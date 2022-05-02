Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4366516C40
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 10:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiEBImm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 04:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383882AbiEBImU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 04:42:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FF6532D7
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 01:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/B2ZrOfzoc0V9A9x/AfciLWbPyIJWvkwrY2zqkcm4Zmq1LzIxHQ32fEBHQsJjw4NDAXbqGZz66SR7rZ/a8UOCRyqN3zmu3U0MZad999zRNGX/q4iBT5S5J+YLN8s0Oy+OfDlcKXvbdTvTNjXi1cZQF6GvsDrdT1hZpoZL2e7Olr9BftT42m2Oc3gdLSXzS1BaOJcvnUAnyYqoC9zwkwI/iXzLScj9mI4r9jvJNPJkVrlItlKVOfNmLbu8oCnyOZENXAumdrA30MK4br/jd5v6LPRVgMsrSoX9uEXqKUAMvCmbSOs7dDfLulbZbWcK2g4xTw2kHiaXUp8hW1h3XZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qbEE75YvS2+I9gt1fWjbao12aLsa8Bnqz2uRRz9Lj8=;
 b=Xc/ulc6fcp8Q2UgnSE+M9zEx1S76fE60O9uTDfNZQfuIlnSSLEBejrehYJKudHxeg05JJ5GlhIJaUB4nZ4c+GDTcorW1+7xnf+w2X8GNtua2ZLb9Pggb/+OYpX0uleZjDGdcpLbNPIFZfuL8jckizmFFVe2SyOKiYnxXDjyzvY1rtboZLeS3lSsLjR0SSnZOxCx+Ful8dDKWl7m1EKWnV+OaDVI5xUHqxXfNo2OyNl620ol2BCA/HVrbIXUtzLTQA2KBoqoJ5eOMOfurID/4NYSsYYouEYw/4kz/n/2wWOPIuERxhi5IYSEn8qrSVzhd/d3qPNrQYI1cub7yOUAjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qbEE75YvS2+I9gt1fWjbao12aLsa8Bnqz2uRRz9Lj8=;
 b=MLOACWIW545feF8pp7pOBZcmehrM4RiPvZ/XVZJy+MzdCOWmRsKKCnWzpsaYDMY6vHJ0YH0DHi78t2IPLdN3aIwNGBc+vBPE34yQPfNnu9Gi/hPJeOLGTQ9QEFoC8D5pv/rszN4NFpLZWS7cXnCQ7M++fAwhcgAEtHbrA0dA2as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by DM6PR11MB3466.namprd11.prod.outlook.com (2603:10b6:5:e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Mon, 2 May 2022 08:38:50 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::89b8:2d6e:d075:527]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::89b8:2d6e:d075:527%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 08:38:50 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wfx: avoid flush_workqueue(system_highpri_wq) usage
Date:   Mon, 02 May 2022 10:38:43 +0200
Message-ID: <3828648.MHq7AAxBmi@pc-42>
Organization: Silicon Labs
In-Reply-To: <f15574a6-aba4-72bc-73af-26fdcdf9fb63@I-love.SAKURA.ne.jp>
References: <20220225112405.355599-1-Jerome.Pouiller@silabs.com> <87a6c0cuxf.fsf@kernel.org> <f15574a6-aba4-72bc-73af-26fdcdf9fb63@I-love.SAKURA.ne.jp>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR3P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::21) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ae5367e-a594-4101-5fbc-08da2c172e59
X-MS-TrafficTypeDiagnostic: DM6PR11MB3466:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB34663B2F900946C829969C2B93C19@DM6PR11MB3466.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jR5eR3ToMlowLnlc3EABHUv4BzTwBVwLWtobinjI8nPSRR3J+9NfwCaBRrkSbNhyJYCIXbWpeOl9e5NH91QkvsRNnDyNJ2bRNxrENQkxmujBMMpMKEyMapapmFFnPQQdi2c4/38IUjROgTKoR0nN26JKcYGOzf6tTLbzfnwz8FswlacXEOJvhgSWT/uSkPujwCiLgihC4ln3BIMELk4anRs2iBnksBv3i+acnCCnIPtyCPXkcNsiJKdbcoWaSwFjR5PDAUoi1FIsv61DGk3bfZXhiApgPuVycInV1O38Xf4yohw/t7d5OY/usqyRN4sYPKa0/57u/TD2zb6ykSfyGJqaK0N4sA4oL2Du/eDC0PFd1iv0bJRoBOWdSyGeG0DybwV7/aHwigfFfBHBdGoptQ0cypdEqKCrZ/VEN7BXYtewcv6qp/wmkEcPE+x4V6d4jdPrp+Hd7muRniImmLmu9A/raOs4EO5SsssemG+iL/3zuOGrqUBEogHc68KiYW6nBMFZX+7eapGqjiN+0Yxzh6mpuAb52gFgW9rqyGR7u43Q2qnG0YYhrKYedhZI1IYjPowEid9Rtz3iH0EXh/C3CPKX3Drhzlqy/IPFdVTSbTSmY7CTIq+rJoP5H3/by638eNFi/Glb396FUqbfbG0i7K28d2vcAmmYuLFIYBS9xZll4J/caJaKHa5F2MtYdzT8yb7VybPqTEInBpkIGJztf6psKqCMWA9DdsqrHuXYNl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(66574015)(110136005)(52116002)(86362001)(38350700002)(33716001)(316002)(508600001)(8676002)(4326008)(2906002)(6486002)(186003)(26005)(8936002)(5660300002)(6506007)(66476007)(6512007)(9686003)(66946007)(66556008)(83380400001)(6666004)(36916002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XvHcyxAJOirdOIkHFClyqqntrOKX1Wu2/kj75ri1ZxUG8GrzPUIAo7D98b?=
 =?iso-8859-1?Q?BbzoqVr/bd++VzFGQszgez+Un7b2qLAvZBDQiLxjty4GYsNDo1TY22MX1y?=
 =?iso-8859-1?Q?HcCiljA3XmZKxllIaXVVpUVHU5/f/ol2MkWcqVhyamRoIzmmQzgzntnz31?=
 =?iso-8859-1?Q?gOarVTabfVqwJW3vxJ1skRWz5UsTvlmuROklRnQhNLXZOIuayOIw6NYK2d?=
 =?iso-8859-1?Q?yqdGXBzLW89/Ig9Jr7NFzh/zSw5mU/I3Ov42meugTJsOcIYGJK1PDk0Lo8?=
 =?iso-8859-1?Q?hCDlbA9Ap7q+ucFr5FqvKSnitDoNj2nzunYzWyOmxKihwkurLKTvYRlTIH?=
 =?iso-8859-1?Q?ZSz+k4Yqq2321qk9dUiN4D/2soFQGkhtRPzX+F1UA/OZwI/ZZOYEC4uLGE?=
 =?iso-8859-1?Q?w9GggrXJ6GdyFPbC4dPu8CFh3j54qFOqUovXIy24WGT19u5lAqWjNTZ04d?=
 =?iso-8859-1?Q?aFYvSkEbAOjUqNQcszA3RyWfWS9nZZoNKOTg7fsAtZkvuNygyqYwvsei7M?=
 =?iso-8859-1?Q?QVMA9JtSqb4RsY1Z+MkBFSyab9F8T+U4PVBfzws7lDrTfdFG7+hedWxdSs?=
 =?iso-8859-1?Q?pFSMyGZFlXN1TL2CjTfIF27izHOVDTKfFl4Q6tuzL4bT4Q9eMZ2I0sa+np?=
 =?iso-8859-1?Q?RZX1iqTqUke2wZQ07/VoCv0xbYyZbGK1FBDgxnc2ycCdisOU+Q7qQd2iTn?=
 =?iso-8859-1?Q?CXtaZjRoXQaZdty/wYpf7UMjePJzPJ22x8rFC5FBEmuzm0iOhTBK99AQmz?=
 =?iso-8859-1?Q?lZpPZlwzGhB4BSMkK4hmV2/AMPL7LmbfOfysjJQMl1Ty44ZQxUk4q4UoOG?=
 =?iso-8859-1?Q?0KpkXUPzeOV8dWh93BS09GwAYcRu6iJ4jckTe062gfk1BGKnwgHJFlm+ta?=
 =?iso-8859-1?Q?wHoD+7GgpZQ9j3ShINVXQoAnrTXHBLQAB9SYpgs49GkWsM9fVbbFCd8ZkO?=
 =?iso-8859-1?Q?Upq7D/B+oXb0e+oZUFGQ7Rm1g5q9afcS8LF2Oparw4907ndreq7H/oMSc6?=
 =?iso-8859-1?Q?9orqKVfAurkklZFs/rMFObMmhHHMxc0VsClGlOB2ElK8QLQ/QSLS5ZztMX?=
 =?iso-8859-1?Q?MNg7I8YYa6JPiBhfnGMxJ761PnA6nJw209UxiYVLXg/xLNxVdkXBInG+d+?=
 =?iso-8859-1?Q?o8ALrX2EUxiwATuAlx4NgyEMc5JnsCYJCcj40ZIxHf7OjGmiTgzoZ772M/?=
 =?iso-8859-1?Q?deCuG17fgkQQ8vV9Ori7V3h2CN4t8Y+62q3Sdx/X5cNBlDpPT8NBvfpjux?=
 =?iso-8859-1?Q?BnBiGy6pJvRfpwylUP2RIm5qPPKdoJRCLcCEDpk23kAAMe94gZ6kDbqt/K?=
 =?iso-8859-1?Q?ZoNPQyNujXZjUPgmpniL/Rz4JZ3ywRLnE2TRk3cHiL11Opzrzxi0mQZX4y?=
 =?iso-8859-1?Q?QX1taYktvWaKLTlwS9VQ4Wrtf6pAqdNNWQIqHjhzEU/VqNHT7nwyqwMKQs?=
 =?iso-8859-1?Q?7GoDs+ZBEcXx0GvYOKlBIx4E2uCYMgKgLXz6tLLHfKhVbRB6nlCO4bEz5p?=
 =?iso-8859-1?Q?aUT2/SeZ13p3OXcLuiL0SfQ8kCkVOJb8jDgEKVvHth07tqyZTNkb7YuM5n?=
 =?iso-8859-1?Q?N52AivuTCzeswj9Xw0D0AesIXToATu6+NsgXwzYpjixGAm6bf9J3hirxaB?=
 =?iso-8859-1?Q?KtquQsE7COz9Yw91G1rtXMnXtsn1jpMSK+bigjhDsIjaNJ+p/j7rIwLgZj?=
 =?iso-8859-1?Q?efsIDzgZLwkH44GLs+Q3i/drKjGsEeVRlWrPLdHH8Imw4E3aLlpnwh9Gu6?=
 =?iso-8859-1?Q?fEcOGb4rRmVw7J4cncn75E5ppuCWIuChpTcx/xMaYm8DiHbcizmXYBx4JY?=
 =?iso-8859-1?Q?4FBAreKNIw=3D=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae5367e-a594-4101-5fbc-08da2c172e59
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 08:38:50.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZN2vRXT7Qpof2WZogBtAvMn/368XjPjvrbDrxvUDeG9GEQ1OAJ8qPSUJ8JCKCA6JXkYPfb0v6M/dQYOYp7VUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3466
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Monday 2 May 2022 10:16:06 CEST Tetsuo Handa wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.
>=20
>=20
> Flushing system-wide workqueues is dangerous and will be forbidden.
> Replace system_highpri_wq with per "struct wfx_dev" bh_wq.
>=20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Note: This patch is only compile tested.
>=20
> Changes in v2:
>   Use per "struct wfx_dev" workqueue.
>=20
>  drivers/net/wireless/silabs/wfx/bh.c     | 6 +++---
>  drivers/net/wireless/silabs/wfx/hif_tx.c | 2 +-
>  drivers/net/wireless/silabs/wfx/main.c   | 6 ++++++
>  drivers/net/wireless/silabs/wfx/wfx.h    | 1 +
>  4 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/bh.c b/drivers/net/wireless/=
silabs/wfx/bh.c
> index bcea9d5b119c..21dfdcf9cc27 100644
> --- a/drivers/net/wireless/silabs/wfx/bh.c
> +++ b/drivers/net/wireless/silabs/wfx/bh.c
> @@ -267,7 +267,7 @@ void wfx_bh_request_rx(struct wfx_dev *wdev)
>         wfx_control_reg_read(wdev, &cur);
>         prev =3D atomic_xchg(&wdev->hif.ctrl_reg, cur);
>         complete(&wdev->hif.ctrl_ready);
> -       queue_work(system_highpri_wq, &wdev->hif.bh);
> +       queue_work(wdev->bh_wq, &wdev->hif.bh);
>=20
>         if (!(cur & CTRL_NEXT_LEN_MASK))
>                 dev_err(wdev->dev, "unexpected control register value: le=
ngth field is 0: %04x\n",
> @@ -280,7 +280,7 @@ void wfx_bh_request_rx(struct wfx_dev *wdev)
>  /* Driver want to send data */
>  void wfx_bh_request_tx(struct wfx_dev *wdev)
>  {
> -       queue_work(system_highpri_wq, &wdev->hif.bh);
> +       queue_work(wdev->bh_wq, &wdev->hif.bh);
>  }
>=20
>  /* If IRQ is not available, this function allow to manually poll the con=
trol register and simulate
> @@ -295,7 +295,7 @@ void wfx_bh_poll_irq(struct wfx_dev *wdev)
>         u32 reg;
>=20
>         WARN(!wdev->poll_irq, "unexpected IRQ polling can mask IRQ");
> -       flush_workqueue(system_highpri_wq);
> +       flush_workqueue(wdev->bh_wq);
>         start =3D ktime_get();
>         for (;;) {
>                 wfx_control_reg_read(wdev, &reg);
> diff --git a/drivers/net/wireless/silabs/wfx/hif_tx.c b/drivers/net/wirel=
ess/silabs/wfx/hif_tx.c
> index 9c653d0e9034..d35dd940d968 100644
> --- a/drivers/net/wireless/silabs/wfx/hif_tx.c
> +++ b/drivers/net/wireless/silabs/wfx/hif_tx.c
> @@ -73,7 +73,7 @@ int wfx_cmd_send(struct wfx_dev *wdev, struct wfx_hif_m=
sg *request,
>=20
>         if (no_reply) {
>                 /* Chip won't reply. Ensure the wq has send the buffer be=
fore to continue. */
> -               flush_workqueue(system_highpri_wq);
> +               flush_workqueue(wdev->bh_wq);
>                 ret =3D 0;
>                 goto end;
>         }
> diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireles=
s/silabs/wfx/main.c
> index e575a81ca2ca..e015bfb8d221 100644
> --- a/drivers/net/wireless/silabs/wfx/main.c
> +++ b/drivers/net/wireless/silabs/wfx/main.c
> @@ -345,6 +345,10 @@ int wfx_probe(struct wfx_dev *wdev)
>         wdev->pdata.gpio_wakeup =3D NULL;
>         wdev->poll_irq =3D true;
>=20
> +       wdev->bh_wq =3D alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI, 0);
> +       if (!wdev->bh_wq)
> +               return -ENOMEM;
> +
>         wfx_bh_register(wdev);
>=20
>         err =3D wfx_init_device(wdev);
> @@ -458,6 +462,7 @@ int wfx_probe(struct wfx_dev *wdev)
>         wdev->hwbus_ops->irq_unsubscribe(wdev->hwbus_priv);
>  bh_unregister:
>         wfx_bh_unregister(wdev);
> +       destroy_workqueue(wdev->bh_wq);
>         return err;
>  }
>=20
> @@ -467,6 +472,7 @@ void wfx_release(struct wfx_dev *wdev)
>         wfx_hif_shutdown(wdev);
>         wdev->hwbus_ops->irq_unsubscribe(wdev->hwbus_priv);
>         wfx_bh_unregister(wdev);
> +       destroy_workqueue(wdev->bh_wq);
>  }
>=20
>  static int __init wfx_core_init(void)
> diff --git a/drivers/net/wireless/silabs/wfx/wfx.h b/drivers/net/wireless=
/silabs/wfx/wfx.h
> index 6594cc647c2f..6f5e95dae21f 100644
> --- a/drivers/net/wireless/silabs/wfx/wfx.h
> +++ b/drivers/net/wireless/silabs/wfx/wfx.h
> @@ -57,6 +57,7 @@ struct wfx_dev {
>         struct mutex               rx_stats_lock;
>         struct wfx_hif_tx_power_loop_info tx_power_loop_info;
>         struct mutex               tx_power_loop_info_lock;
> +       struct workqueue_struct    *bh_wq;
>  };
>=20
>  struct wfx_vif {
> --
> 2.34.1
>=20
>=20
>=20

It's right for me.

Signed-off-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

--=20
J=E9r=F4me Pouiller


