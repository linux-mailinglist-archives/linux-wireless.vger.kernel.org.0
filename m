Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1B9516C6C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 10:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383854AbiEBIvu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 04:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383983AbiEBIvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 04:51:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDAE5931E
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 01:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxRSvmwQ4Gk3xDzTRsfFhceIgrYlMNaa5apwDp74h7InkAbgVbVhwN0PzHp0MKDt2YE1ZILIaRbn6/DDdd4yn97OcbV3GBhxS3cwBjYqGByGUXKyYzI9/mL220lASYJzGssbiRdupVRjfN9RCV0Cm4cd9JtrMjNAhnCkmuHXPhLZi8FyeNa4bK5/FYbxYL8UL2wGTgMRY0MrgAu5Fo6tAKtZn2dApj0/qf5ShTvP3Hj8x7C+XfmybD/saH5mLOEUbuKOWrkz/T6YMLVvYC5Mti5mdPzUuJQWYiKD0+DxsY9Js07lAI0oc2RL/4H58PXLuxw9zH6WxW0P7VE92HeVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utlN1iq/l7OgfLbeotGQfG5/LwkbCfZIkoTlNP0piqA=;
 b=B2Mde2E8nNwhOSUHJQn6YXLP2atc4KV2rQ/cuSDK/uGK7lhM2X6ZpbzGhrirot+OPVnhJOig2o0ySsTNhSZZZYp4sbSXKblETDKQSLAJIu52J82+6NMpgPBFMF8ZucLctXswPlwyaJIDbFFVwCqh6Nt/UCMskxVHgnupKmcmoOSsVrhN1XzGABGyit9DAxi33KIKlXgQkBVsmQMerzKfCeu+vjK444GMZ9Rs+O68S7DxEWJ32fbQaVIm5x2HqZ8lIBbDwYF+zYcqzKC646WCtNhEvTeVDRSMKT1jewRTT5bzsWPGoswGlXJ30W4DnJEnP4+7z+ZvAk9QnNvPvCtvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utlN1iq/l7OgfLbeotGQfG5/LwkbCfZIkoTlNP0piqA=;
 b=JbJPD2OVznH9LZOvBH1fflmCzqDC7XQOBRTO9H5ci0QoVC0eHjtq9pH/NjoyAtHkOQAYrN8IsnIfK8rTC9Ty/jKuhmqnagt1wmDA4a4xLqSnpgW+YSTF8WU/8fCafD6TNLf8yehcX83Yx62YgkaiWCOjlemQY5ZjoM0Ps7nVT/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by DM6PR11MB4331.namprd11.prod.outlook.com (2603:10b6:5:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 08:48:07 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::89b8:2d6e:d075:527]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::89b8:2d6e:d075:527%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 08:48:07 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wfx: avoid flush_workqueue(system_highpri_wq) usage
Date:   Mon, 02 May 2022 10:48:01 +0200
Message-ID: <110321547.nniJfEyVGO@pc-42>
Organization: Silicon Labs
In-Reply-To: <87fsltd462.fsf@kernel.org>
References: <20220225112405.355599-1-Jerome.Pouiller@silabs.com> <e25078f4-96f4-482c-b5da-a4a22d88b072@I-love.SAKURA.ne.jp> <87fsltd462.fsf@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR1P264CA0051.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::12) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a6bcc16-1551-4499-8798-08da2c187a6b
X-MS-TrafficTypeDiagnostic: DM6PR11MB4331:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB4331346DECC493F982C6E27093C19@DM6PR11MB4331.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s72niHBMwrYxIO3xMkCqjONVB1lyeKZToCGD9IF2EuzlkRd8rso/TGQa8px9vn3QAqqqfgF+51PSvs0pp6E3v6gh5LpXjdBNDdkWOKzm5z9cPoFij0pRP74xu7rxzLlmYgXLmJhDVqhcWJBubY3TkQ8DyLmcqZ3VhAfs9zymaaA1iTL9V4R9+903KlFgug/6BRFj4NKumRB0olKi2TfCZ5FbW2Bx5DWLbz9tQpB5F38WH2MbnNZqC++LXrDDmV+JgfahOhfDcPA1JTP6t/6mJAwqDkjMmtCPLPEeMHrdfMbgC98BCFNeoYESMyYBEGsmSqMw5uhFzJ0305X4wvlYeEZ6+b5grPiPIVFh5FfmCiLQYIEACj4GUuu2aFtP79roPLc04NwD1MgzpSmtP6bnxK2RotYgD+xzcoEmVP64KsClgIQ2/jIETpXD/QttYsOn0g/nNPQwKH9MDDLvgpRZ284nq1mn81MN5g16l1C61pHQUsWYUHtoT1HShkBRPMXScxFL3DSn5Ez2WVCSaR+4sVpsXaN2Kkgs4PwPw4KCxdUJQ5xbsdqn1QMpbvBIRDkQbUEbLqhy710aI1jc7LsWaVMAmCgZHCmzW0hdbznCa4GmjBauFf0XSxF8n4bqlU/6VXExVZZZ4RHKmtqsSl8FIgeKlXtxuGOkalt1VP0XESEfVnFVsfGzCmSOR6aliD9RlRQ4UT8iqpA0uRfXcEBt8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(26005)(6506007)(6512007)(9686003)(2906002)(38100700002)(86362001)(38350700002)(508600001)(33716001)(52116002)(36916002)(6486002)(5660300002)(8936002)(316002)(110136005)(4326008)(8676002)(66476007)(66556008)(66946007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yjXBlsIp+mdOIJlNotvsPyjavlg5hPzK1ksbO9tnrQTm8yPTGl2OOvRG9X?=
 =?iso-8859-1?Q?+Rj5EXV75dU5ABlhDYC2Ag8wjOD+sN4wyODE2fcOzMcbsy3SKA7cZRP5Hy?=
 =?iso-8859-1?Q?zEnwS7pTaemcDFk9I3SsXeTtCww03N4+sBmHL0R933a9u/r7M2+a+BzlCo?=
 =?iso-8859-1?Q?9W8/aNeA4vc7UV5MddrGmOusjcFiJt3ewrhA6RIrpdh4DL1MescVpotNvd?=
 =?iso-8859-1?Q?P5SNipq6JbnKeqXtOMWyxsIB/b1pJxFA1n8SNbBe177WSde59PqrTg6IkS?=
 =?iso-8859-1?Q?M2YcKDeqNYbAOCigR9aM2OPf7zazsY6hMKwU80sKqiqz4PzWloS3daCUQM?=
 =?iso-8859-1?Q?PdYOcO3N+jz5oT6ULdLJTiQZ84HBx9j0D0K94zQ0Ei5Cnqxz9uqE4OgkFt?=
 =?iso-8859-1?Q?4ndurDTS6WyIbGEZ1rMJRaH3UysbK6mDaI4zSVhrf2a7Fu5fVKlC9iTu5Z?=
 =?iso-8859-1?Q?/2/I2EO13fSikW2zwmDJ2CM6tsTmjLlQnzlceKhYiq0R/diD2Vf5XKT7st?=
 =?iso-8859-1?Q?wUIbhPFnlEhzKUcDeFbjecEWTXElqwtPQgNr5+KpiLbrw5OqIEDD1nXV0Q?=
 =?iso-8859-1?Q?pmzg2gPkBb2NGrw8v+1YIELmmOS2zhaSd6RD5C7ADKci4/IoSfak+OZV6q?=
 =?iso-8859-1?Q?flmHOJuvKv/yFYzaWZeqBr19rruu+OMxPcyFwN5SsQ6S52/R/z8AsNpxv6?=
 =?iso-8859-1?Q?1woPFh3q+KV7DnwktYrPQ85lJEISxtr1ilRZgMG2UAYDceyCnw31nSND3N?=
 =?iso-8859-1?Q?w2JBZ3ghjav7raCmkRV7B+MGFiGy1tnlWYpezSqbGa16MNW5hQLwKN2s2P?=
 =?iso-8859-1?Q?1IsyBHQ4ydXci/ZyhnsN8dZitoXeDhR8nM8zzsg7qJLU8qgALq1tW0TjxA?=
 =?iso-8859-1?Q?ZZJuVSN00nwEqoJl25X28fBOy428z7ojyx90+WQFYk9dBYpZznKi8VG6hW?=
 =?iso-8859-1?Q?fd7SBc0RBV7oiPAdF6N3m+RDHOhDN+dDuaUGlYmRo7r1h0pCAzdxDxHTMy?=
 =?iso-8859-1?Q?N6T+Q4yt89J1QyuxYsAWwjKN5HHvpoIhNtMdxrPxhlBY1nvS0c6cxXBhfq?=
 =?iso-8859-1?Q?/EGn5fojD28C2T7YG2NlA8EScUuQdfzUVATsdAykxTzcXPpuGTRVLT40wA?=
 =?iso-8859-1?Q?u4cTy1TdWczJVHZqvG11J5umKJsM+dRU35aBGKqxcX5gWlGB4XRapTwkUN?=
 =?iso-8859-1?Q?p33hdvlqREb9YnrujFh80S0B4birv4T+Vkzn375cy05B8Fk2IzmTXSssBp?=
 =?iso-8859-1?Q?aMvahiZqs1FUdk8vsNKwHVp1SctDgIqzbxnhdpJiqrayxGyRoEBhR7zrKa?=
 =?iso-8859-1?Q?ehSVCHlORYd2E18zqNMAAnJT/+MPV79HbQgS4WSWjMudzyKnoIiV+BI/Fa?=
 =?iso-8859-1?Q?r58GwEvuDMIiPSK1a7YFw2hliZLETkDrLEA7RCgJlBSaRzclHumM6YqI2R?=
 =?iso-8859-1?Q?YFC+/O9pI5WVGCa/DMqKkcTrkLVi4T/CrZuMdP+LYxozIJWrWkhxPciieo?=
 =?iso-8859-1?Q?iIhiAGF7RBUAmzhO4DOY9zcXPFg8mFqC6sMN0YEfxvzY+TcB4c6N3jQ0bq?=
 =?iso-8859-1?Q?61nhnKPFS5P+fyyEnXGoprRz+acZSWT4iwkXodYClWSClh+XiV9qiOOyxH?=
 =?iso-8859-1?Q?rUrb1tjRi7+6iXLtUMlaJpjWeTxNHeBUSk6ohODfobHQsj48ax0m45w+pU?=
 =?iso-8859-1?Q?7R7mYFJcFosBIO4Y36eySzj5iEFQDW9SJXe4C272Oz6mGPK7cxISguScTX?=
 =?iso-8859-1?Q?QzTgBaTO8+bqD/pKXA6Ikk6iZS3DCfu6RrgSZBDyt0+wvBpahNRxIjpWoX?=
 =?iso-8859-1?Q?wsMOmdDutg=3D=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6bcc16-1551-4499-8798-08da2c187a6b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 08:48:07.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ucl8I6gwSPzwagd+kTfxfb1FSlWWqjsInCLEsV7bIlI/r/MJVQ0/NWMP9/dGzh7eyhcDtPPFyCqwgAOVK8M1vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4331
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sunday 1 May 2022 10:53:57 CEST Kalle Valo wrote:
> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:
>=20
> > Flushing system-wide workqueues is dangerous and will be forbidden.
> > Replace system_highpri_wq with local wfx_wq.
> >
> > While we are at it, add missing spi_unregister_driver() call when
> > sdio_register_driver() failed.
> >
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>=20
> [...]
>=20
> > @@ -473,10 +475,18 @@ static int __init wfx_core_init(void)
> >  {
> >       int ret =3D 0;
> >
> > +     wfx_wq =3D alloc_workqueue("wfx_wq", WQ_HIGHPRI, 0);
> > +     if (!wfx_wq)
> > +             return -ENOMEM;
> >       if (IS_ENABLED(CONFIG_SPI))
> >               ret =3D spi_register_driver(&wfx_spi_driver);
> >       if (IS_ENABLED(CONFIG_MMC) && !ret)
> >               ret =3D sdio_register_driver(&wfx_sdio_driver);
> > +     if (ret) {
> > +             if (IS_ENABLED(CONFIG_SPI))
> > +                     spi_unregister_driver(&wfx_spi_driver);
> > +             destroy_workqueue(wfx_wq);
> > +     }
> >       return ret;
> >  }
> >  module_init(wfx_core_init);
>=20
> So now the thread is created every time the module loaded, even if
> there's no device available. Also I'm not really a fan of global
> variables (wfx_wq). I would rather create a workqueue per device in
> wfx_probe() or use the workqueue provided by mac80211.
>=20
> /**
>  * ieee80211_queue_work - add work onto the mac80211 workqueue
>  *
>  * Drivers and mac80211 use this to add work onto the mac80211 workqueue.
>  * This helper ensures drivers are not queueing work when they should not=
 be.
>  *
>  * @hw: the hardware struct for the interface we are adding work for
>  * @work: the work we want to add onto the mac80211 workqueue
>  */
> void ieee80211_queue_work(struct ieee80211_hw *hw, struct work_struct *wo=
rk);
>=20

The last time I have checked if I could use this workqueue, I remember
it was not well suited for wfx (I don't remember why exactly). So I
believe we have to allocate a new workqueue.


--=20
J=E9r=F4me Pouiller


