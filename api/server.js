const Koa = require('koa');
const Router = require('koa-router');
const validate = require('koa-joi-validate');
const cors = require('@koa/cors');
const joi = require('joi');

const search = require('./search');

const app = new Koa();
const router = new Router();

app.use(cors());

// Log each request to the console
app.use(async (ctx, next) => {
  const start = Date.now();
  await next();
  const ms = Date.now() - start;
  console.log(`${ctx.method} ${ctx.url} - ${ms}`);
});

// Log percolated errors to the console
app.on('error', err => {
  console.error('Server Error', err);
});

/**
 * GET /search
 * Search for a term in the library
 * Query Params -
 * term: string under 60 characters
 * offset: positive integer
 */
router.get(
  '/search',
  validate({
    query: {
      term: joi
        .string()
        .max(60)
        .required(),
      offset: joi
        .number()
        .integer()
        .min(0)
        .default(0),
    },
  }),
  async (ctx, next) => {
    const { term, offset } = ctx.request.query;
    ctx.body = await search.queryTerm(term, offset);
  }
);

const port = process.env.PORT || 3000;

app
  .use(router.routes())
  .use(router.allowedMethods())
  .listen(port, err => {
    if (err) console.error(err);
    console.log(`App Listening on Port ${port}`);
  });
