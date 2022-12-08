import type { NextPage } from "next";
import Head from "next/head";
import Link from "next/link";
import styles from "../styles/Home.module.css";

const Home: NextPage = () => {
  return (
    <div className={styles.container}>
      <Head>
        <title>Next App example. SSG and SSR examples</title>
        <meta name="description" content="Generated by create next app" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>SSG and SSR examples</h1>

        <div className={styles.grid}>
          <Link href="/ssg">
            <a className={styles.card}>
              <h2>Static Site Generation</h2>
            </a>
          </Link>

          <Link href="/ssr">
            <a className={styles.card}>
              <h2>Server Side Rendering</h2>
            </a>
          </Link>

          <Link href="/ssr-vnet">
            <a className={styles.card}>
              <h2>Server Side Rendering (Vnet API Call)</h2>
            </a>
          </Link>
        </div>
      </main>

      <footer className={styles.footer}>
        Environment : {process.env.environment}
      </footer>
    </div>
  );
};

export default Home;
