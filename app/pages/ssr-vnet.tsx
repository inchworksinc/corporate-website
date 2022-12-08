import type { NextPage, GetServerSideProps } from "next";
import Head from "next/head";
import styles from "../styles/Home.module.css";
const axios = require("axios").default;

interface PageProp {
  fact: {
    fact: string;
  };
}

const Home: NextPage<PageProp> = ({ fact }) => {
  console.log(`fact - ${fact}`);
  console.log(`fact - ${fact.fact}`);
  return (
    <div className={styles.container}>
      <Head>
        <title>Next App example. Server Side Rendered</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          This is a Server Side redered page calling an API inside VNet !
        </h1>

        <p>
          If a page uses Server-side Rendering, the page HTML is generated on
          each request.
        </p>
        <div className={styles.grid}>
          <div className={styles.card}>
            <h2>This data was fetched at runtime on each request</h2>
            <p>Fact: {fact.fact}</p>
          </div>
        </div>
      </main>

      <footer className={styles.footer}>
        Environment : {process.env.environment}
      </footer>
    </div>
  );
};

export const getServerSideProps: GetServerSideProps = async (context) => {
  console.log("Invoking API Management Instance using internal endpoint");
  const response = await axios.get(
    "https://apim-api-management-dev-eastus2-01.azure-api.net/dev01/echoapi/resources"
  );
  console.info("headers:", response.headers);
  const responseCode = response.status;

  const fact = {
    fact: responseCode,
  };

  return {
    props: {
      fact,
    },
  };
};

export default Home;
