defmodule TecSolfacilCepApi.AccountsTest do
  use TecSolfacilCepApi.DataCase

  import TecSolfacilCepApi.AccountsFixtures

  alias TecSolfacilCepApi.Accounts
  alias TecSolfacilCepApi.Entities.Accounts.User

  describe "create_user/1" do
    test "fail to create invalid user when email is short" do
      invalid_user_map = %{email: "foo", password: "baar"}

      assert {:error, changeset} = Accounts.create_user(invalid_user_map)
      assert Keyword.keys(changeset.errors) == [:email]
      refute changeset.valid?
    end

    test "fail to create invalid user when password is short" do
      invalid_user_map = %{email: "foo@bar.com", password: "bar"}

      assert {:error, changeset} = Accounts.create_user(invalid_user_map)
      assert Keyword.keys(changeset.errors) == [:password]
      refute changeset.valid?
    end

    test "creates user when is valid" do
      user_map = %{email: "email@example.com", password: "password"}

      Accounts.create_user(user_map)

      assert [user] = Repo.all(User)
      assert user.email == "email@example.com"
    end
  end

  describe "get_user/1" do
    test "return a user if exists" do
      user = user_fixture()

      %User{id: id} = Accounts.get_user!(user.id)

      assert id == user.id
    end
  end

  describe "get_user_by_email_and_password/2" do
    test "does not return the user if the email does not exist" do
      refute Accounts.get_user_by_email_and_password("unknown@example.com", "hello world!")
    end

    test "does not return the user if the password is not valid" do
      user = user_fixture()
      refute Accounts.get_user_by_email_and_password(user.email, "invalid")
    end

    test "returns the user if the email and password are valid" do
      %{id: id} = user = user_fixture()

      assert %User{id: ^id} =
               Accounts.get_user_by_email_and_password(user.email, valid_user_password())
    end
  end
end
