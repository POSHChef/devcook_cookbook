
# This file holds default attributes for the cookbook
# Any of these can be overridden using a Role or an Environment

@{

	# Default attributes
	default = @{

        DevCook = @{

            # Set an animal to be overriden in Roles and Environments
            animal = "fox"

            # Determine the number of text files to created
            files = 10

            # Define the path to use when creating directories in the remotefile recipe
            path = "C:\temp\remotefile"

            # Define the path to be used when copying the files that have been created
            target = "C:\temp\remotefile_copy"
        }

        Tests = @{
            enabled = $true
        }

	}
}
