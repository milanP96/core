from django.test import TestCase
from django.contrib.auth import get_user_model


class ModelTests(TestCase):

    def setUp(self):
        self.payload = {
            "email": "milan9oaasdsd@gmail.com", "password": "12345qwerty", "first_name": "Milan",
            "last_name": "Petkovic", "phone": "123234283",
        }

    def test_create_user_with_email_successful(self):
        """Test creating a new user with an email is successful"""

        user = get_user_model().objects.create_user(**self.payload)

        self.assertEqual(user.email, self.payload["email"])
        self.assertTrue(user.check_password(self.payload["password"]))

    def test_new_superuser(self):
        """Test creating a new superuser"""

        user = get_user_model().objects.create_superuser(**self.payload)

        self.assertTrue(user.is_superuser)
        self.assertTrue(user.is_staff)
