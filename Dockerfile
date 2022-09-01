# # Extend from the official Elixir image.
# FROM elixir:1.13.4

# remeber to change your dev ip to a public ip

# RUN apt-get update && apt-get install -y postgresql-client && apt-get install -y inotify-tools && apt-get install -y nodejs && curl -L https://npmjs.org/install.sh | sh && mix local.hex --force && mix archive.install --force hex phx_new 1.6.5 && apt-get update && apt-get install -y apt-utils && apt-get install -y build-essential && mix local.rebar --force

# # Create app directory and copy the Elixir projects into it.
# RUN mkdir /app
# COPY . /app
# WORKDIR /app

# ENV MIX_ENV=prod

# # Install Hex package manager.
# # By using `--force`, we don’t need to type “Y” to confirm the installation.
# RUN mix local.hex --force
# RUN mix local.rebar --force

# # Compile the project.
# RUN mix deps.get --only $MIX_ENV
# RUN mix do compile

# CMD ["/app/entrypoint.sh"]