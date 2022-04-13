defmodule TecSolfacilCepApi.Entities.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias TecSolfacilCepApi.Entities.Accounts.User
  @fields ~w(email password)a

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs, options \\ []) do
    user
    |> cast(attrs, @fields)
    |> validate_email()
    |> validate_password(options)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 120)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset, options) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 4, max: 72)
    |> try_hash_password(options)
  end

  defp try_hash_password(changeset, options) do
    hash_password? = Keyword.get(options, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      |> validate_length(:password, max: 72, count: :bytes)
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end

  @doc """
  Verifies the password.

  If there is no user or the user doesn't have a password, we call
  `Bcrypt.no_user_verify/0` to avoid timing attacks.
  """
  def valid_password?(%User{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

  @doc """
  Validates the current password otherwise adds an error to the changeset.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end
end
