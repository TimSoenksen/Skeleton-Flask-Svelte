# Skeleton-Flask-Svelte

This is a skeleton project made to make a quick docker container after copying and creating another repo.

To run you can do a docker-compose up --build

Most of the stuff needed is in the Dockerfile for Azure Container Apps

Change the Port in the Docker file and in app.py to something that makes sense. I like to just think of a 4 to 5 letter word and make that the port based off a phone.

Backend runs flask, frontend runs svelte.

Both because they are simple to look at and understand.

I use a component library for the frontend called shadcn-svelte.
It has a lot of premade components on their site, you can do an npx install with the console and import components like buttons and components and cards without having to worry about accessibility and other odd frontend shenanigans.

I run this skeleton build with all the requirements so dependabot can tell me what needs to be updated on github, as private repose do not have this feature without enterprise. I also have some examples for python and such for how to have different compoenents in different py programs for the backend. I do intend on putting all the backend stuff in a backend folder, but this is just how I built things at the time.

At the current time of me writing this, I used sqlite as a backend database to store stuff. But with azure container apps I realized that I had to use azure sql server if multiple containers needed to write to it. So I have a good example in the PPF project on how I handled that.