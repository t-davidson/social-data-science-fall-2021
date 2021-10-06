# This script is used to deploy the RShiny app

# Loading package to deploy app
library(rsconnect)

# Use credentials for deployment, run to authenticate (you should only need to do this once)
rsconnect::setAccountInfo(name='', # Add shinyapps username
                          token='', # Add shinyapps token
                          secret='') # Add shinyapps secret
# Warning: Do not publish these credentials publicly (e.g. on Github)

# Run to deploy app to the web
rsconnect::deployApp(appDir="path/to/app", # Replace with path to app folder
                     appName = "test") # Replace with app name
