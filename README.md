![](https://img.shields.io/badge/Microverse-blueviolet)

# Short Let API

This project is the backend service provider for the Short Let application, which helps the frontend to register, and login using JWT. It also provides many API endpoints to read, write, update, and delete data from all parts of the project. We built a simple and useful documentation for this project so the community can have an idea how to use with this.

This application was built as a group project in less then 3 weeks.


## Built With

- Ruby on Rails
- PostgresSQL
- Rspec
- And some other open source ruby gems

## Live Demo (if available)

[Live Demo Link](https://livedemo.com)


## Getting Started
Make sure you installed Ruby and PostgresSQL in your machine. Please follow the setup steps in order.

To get a local copy and up and running follow these simple example steps.

1. Open your favorite command line tool, and run the bellow commands.
2. Run `git clone git@github.com:ichala/short-let-api.git`
3. Run `cd short-let-api`
4. Run `cp .env.example .env`
5. Update the `.env` file with proper database credentials
6. Run `openssl rand -base64 32`
7. Now copy the generated key from you terminal and use it in your .env file for `JWT_KEY`
8. Run `rails db:create`
9. Run `rails db:migrate`


### Usage

### Run tests

The tests are built with `Rspec` so you can run the `rspec .` command to run all of the tests.


## Authors

👤 **Aimal Amiri**

- GitHub: [@aimalamiri](https://github.com/aimalamiri)
- Twitter: [@meaimal](https://twitter.com/meaimal)
- LinkedIn: [aimalamiri](https://linkedin.com/in/aimalamiri)

👤 **Eid Hachem**

- GitHub: [@EidHachem](https://github.com/EidHachem)
- Twitter: [@eidHachem1](https://twitter.com/eidHachem1)
- LinkedIn: [Eid Hachem](https://linkedin.com/in/eid-hachem)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

## 📝 License

This project is [MIT](./LICENSE) licensed.

_NOTE: we recommend using the [MIT license](https://choosealicense.com/licenses/mit/) - you can set it up quickly by [using templates available on GitHub](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/adding-a-license-to-a-repository). You can also use [any other license](https://choosealicense.com/licenses/) if you wish._
