import type { NextPage, GetServerSideProps } from "next";
import Head from "next/head";
import styles from "../styles/Home.module.css";

interface PageProp {
  fact: {
    fact: string;
  };
}

const Home: NextPage<PageProp> = ({ fact }) => {
  return (
    <div className={styles.container}>
      <Head>
        <title>Next App example. Server Side Rendered</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>This is a Server Side redered page Calling Httpd Inside VNET !</h1>

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
  console.log("Invoking apache on VM inside VNET")
  const response = await fetch("http://10.1.3.4");
  const fact = await response.text();
  console.log("apache response - ",fact);

  return {
    props: {
      fact: fact
    },
  };
};

export default Home;
