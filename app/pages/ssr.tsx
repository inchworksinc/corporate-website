import type { NextPage, GetServerSideProps } from "next";
import Head from "next/head";
import styles from "../styles/Home.module.css";

interface PageProp {
  fact: {
    fact: string;
    length: number;
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
        <h1 className={styles.title}>This is a Server Side redered page !</h1>

        <p>
          If a page uses Server-side Rendering, the page HTML is generated on
          each request.
        </p>
        <div className={styles.grid}>
          <div className={styles.card}>
            <h2>This data was fetched at runtime on each request</h2>
            <p>Fact: {fact.fact}</p>
            <p>Length: {fact.length}</p>
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
  const response = await fetch("https://catfact.ninja/fact");
  const fact = await response.json();

  return {
    props: {
      fact,
    },
  };
};

export default Home;
