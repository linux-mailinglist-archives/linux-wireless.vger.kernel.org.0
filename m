Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41547778C2
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 14:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjHJMoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 08:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjHJMo3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 08:44:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1632CC5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 05:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJoCPDAJBI2QlxnnikiR/UkRURpQDqMFNAL5fSOjLThwvCPJiHJbLQf8O0bk+3t91jo63Lx3uf0F1b6s13oF6a1/HxLosAQb1GJvwUWXNgwYQtkj6jkCnTSUSMx3xw57g3Iv5hQWWKVZFwBxcGyjzz5kP15QJA7ETJABDhGsW9JP6fgbcs58Pp/CrktOvrxtmgiRz19+HxkwafkKMH0EDxDv+UzP6jYKi5Aj9MITmlBlMZAD7nXwDspd1D+pW3mr6U2Dgb1KNZ39uZEm926krxnroVZVmNigDTS7javPzwpd6hkmucgM98kbMCV5g6/eQN6Ik+54uk9OKrB8HcFmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhqUyZnz4rVmyFEav3ZkzoJJ++7+xCiGh1qekyd8tPg=;
 b=N7B/kuUfBxtsEkEMXm06g5K+THeFRW1WqzoXHG71+txmtZIHkZvnN8iKKXPt8xFaq00LJ3HP1Kp9Gg/Jx7hcpgEdMxgeQwlose6w2BUWAwdsd+MazHSu4L/fQ7663DuODLkBFESAkvPnaMI6w6HsJ+t2GQPuqinXNaedhIy44vnUBnbjCrkHivTweL5QJCPZ3X0T1GDadZbTZWltwWNWbA/B85TczVDkGTVMb8rpygLS/EcS3eykWl+bssg8DhVcjvem3zXiteTM7fsJ/o9v7swMR+7TZfoHT39QiSY4h3uwucOjx6fX5vTu/5RDdDc6Vfn8G2Kvlexi0o1zRc/eGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhqUyZnz4rVmyFEav3ZkzoJJ++7+xCiGh1qekyd8tPg=;
 b=DQxo37WJX0A8WAQ5zWWze0Mzp911kEvHbF62WNTth4xLvXeHFQFh1YOhy9cRD9BhpfRgWz427SiLjaAMg7WzHRfjT+jfAFFENxftY0GMFP6/oaoDvZ1ApsRgTiqw1ObBmBNrcZq9NZqhJeqcS4eEZNF23ycMqpPKotYsMswN4qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH0PR11MB4983.namprd11.prod.outlook.com (2603:10b6:510:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:44:25 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:44:24 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     kvalo@kernel.org, Li Zetao <lizetao1@huawei.com>
Cc:     lizetao1@huawei.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH -next] wifi: wfx: Use devm_kmemdup to replace devm_kmalloc +
 memcpy
Date:   Thu, 10 Aug 2023 14:44:19 +0200
Message-ID: <2435182.NgBsaNRSFp@pc-42>
Organization: Silicon Labs
In-Reply-To: <20230810114939.2104013-1-lizetao1@huawei.com>
References: <20230810114939.2104013-1-lizetao1@huawei.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PA7P264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::15) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH0PR11MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ab89d5-680f-45c2-3603-08db999f86b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaHdmd0jyoeJVgBrxOnwKjrvFO6LhQETa4AG1K/U/k6WBQVWyED5xhtnbNTSOszvkL1mLUL+jculnek8PMc+EhkTokC/en1cDsf8v+elLTjNdi2rhmttB2SehNiUu1AJEbSQrxeuHD5pseCYLqoE3y2484ZxM32Jtgmp1HaWEw1/6S8Yuk+gnsTaww9sOY6bf0fgtvpQP4XFC3YOHwowzqvDiGKwjgjGAnIjeAIeyrZ65KnqoP/b4VJXZhDtQlmxF8NQi2UBFNYj3TTP9tI6bDi8BMZ7isyI6dndCwSmMOhxLM/df0F0tCl5aQrqblnZvKhsm2PmwKAggstRl6QYPo8ByU3DWA8pvSR4X82FN8/LhUc8TZVPtSALMNQd3bHiSnK4E4W5di2cGY4PYV4ChjBNIuPjbkcGd4g9F06Fr+YzQOSDgxdWS441i29XwAnzQibucAz0uCaFeqoj20QqwK7tJLyJMFeogCCdyiKTp6cuvotByc7aa2qYlNCo2FxyHsXwTwEeWUlg2RcNPURXSToyZcornnIUqCTk6zrhcPgE4dKoqd/we6n3iunnYRGWRJ3dUVKSy6vV7CGV8oMDsEiNMQJwg/mqr1ddhxHs5hFBL/1GmmbIN6O7dglSYbzV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39850400004)(396003)(136003)(346002)(376002)(366004)(451199021)(186006)(1800799006)(83380400001)(2906002)(9686003)(6512007)(52116002)(6506007)(26005)(6666004)(6486002)(86362001)(478600001)(36916002)(66946007)(6916009)(316002)(4326008)(66556008)(8676002)(66476007)(8936002)(5660300002)(41300700001)(38100700002)(33716001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1tBGS7fhT50zxCgSYz6Uh/AYvDqQf/LUwKJDEkiUuRPHQgvXNCJE0gYndp?=
 =?iso-8859-1?Q?EGArua7Y6SATe9LtS2djFscO2tt7Gi7A5bwSWj8ILyLht+cHFKPDciaUmD?=
 =?iso-8859-1?Q?z58oWeauSMm+MQzjceXFcjtgk2Amghc5f0b3801dgSI/Qt2axTBbgX/ZLT?=
 =?iso-8859-1?Q?57dwD97MygvrSqyasGeBLtQKefpxhfz73bTdTSCtxVdui/R8/lSrbTM3v3?=
 =?iso-8859-1?Q?a550IFibcRgZoeA1/O42Df3fzOwK1VmKCen40kw4RtWSS+JNi20cfibpHi?=
 =?iso-8859-1?Q?4YXldagGdBj2PWVzATCfLaHuh85uR8QeTMWJ/0AmAK6Vm/m6eQQPU6L6rI?=
 =?iso-8859-1?Q?OCUGm9uBcrdLwavUcEEGWEV+Jq+NEliIT8k8Q8NBn02mFmp7YKtn0utElm?=
 =?iso-8859-1?Q?mJ+Es7yedZBx67+O61baFCSFilIoNw8vM1a7sVzzQSXy8PY/81C0gk3GIa?=
 =?iso-8859-1?Q?q0weDNXAxZ632jAw8WUJdegWedl1zSA6LWwQkxHh44bHS5k5HGUTd4vOrZ?=
 =?iso-8859-1?Q?xuErdyNLshO0dRJqj05ROWeArYRI/Bi2CQZoyJ9aRoSDYt5992MyrDEwlK?=
 =?iso-8859-1?Q?qZpiBvDeCkHkm8VvSW06u9h44naLIqblCeklhx0tvz7LECm//Aqil1qT+8?=
 =?iso-8859-1?Q?kElm89zrcMkIa4SL/fVortXQAKxp9t1K+JL4oN0kbyFe/XRUtQj7g4tk4v?=
 =?iso-8859-1?Q?EfWKoisX+nQYUIgrh1mg0SUKCwgSuwBV+5IOnyZQqe6pJWuf6XE5KD+8MF?=
 =?iso-8859-1?Q?Hn3jFo++yDxFdhWHJZfF461/sBTacNNg/YpHFamOrMhMrE2YvUnyDhKamb?=
 =?iso-8859-1?Q?DNNeilXh6lhdjC9YEnRh9DL6HkUJQQ3eBn9XQ04o+wYfqJQPTRU+ChfmuP?=
 =?iso-8859-1?Q?I5i6eWxE4/wkromiackALTJCi67iZMYKMZFDOaQO32+ZAu+nOmBf168O+C?=
 =?iso-8859-1?Q?PrZI2ZOxg+k6rB4zsKkAy5dTe0u2WqcTB+lytucZ3bZsjp+XhVbjJHzj1g?=
 =?iso-8859-1?Q?/7CuFMCsidmP7Tom/PSL4qGQw6d5FRrdvNzYynkNiPCGSL9wLZbS1z0r+c?=
 =?iso-8859-1?Q?RlJv5HftYboMBoL60KrE8S8Fub3Ul2unuW0/mApQoiQIUOo7wPVpG/ELmr?=
 =?iso-8859-1?Q?oEOKbt1Qa42B2fS/qwpt5WE+4Dlkb+8PiwMr5lSP1I+FxzWJedhEDHC1iX?=
 =?iso-8859-1?Q?vtFCGnz9yjm3DE6uOhzA1dJ8i46nykxUTzzWMTMNsKQLkLZYTy2sisZEtv?=
 =?iso-8859-1?Q?mxQ3Qzs/SMzOpvxjAqNsqaHpb1ih1JXF3oZGZdGT5fNfEecsdj+8qU4gfC?=
 =?iso-8859-1?Q?sjyHoI+ySMxr3HjCUujpmb324azeiSMNiGEyUcmuoBPMK2Ro8O09fYdjbT?=
 =?iso-8859-1?Q?t3cvflR0RKmidrZgu14abVNKwrMK3ox6d3Kmig5LVxML4v/Kg80y22ROTq?=
 =?iso-8859-1?Q?PW7CFTEAE+9Jta+VMTUJtXjAW1feOrrl9uI9vxtEEIEy8zscPtb6+W9aeT?=
 =?iso-8859-1?Q?h4gAujEUvP4QvJADOIInN18AzKpmF/8G9I9nwjNWIp0m7zWF7ezh3lIIC8?=
 =?iso-8859-1?Q?7lUWgc1aJX8v4pt1BNS1gUxQj0RGxGQS7jFba8cB8/JpklBgbesjAVUCYJ?=
 =?iso-8859-1?Q?WEEDjzWNCzluwZKgjdOTu6TlZeKqX/jUTk?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ab89d5-680f-45c2-3603-08db999f86b3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:44:24.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NfxVxRT6P47eem2Zkkr296WWzLXSPdoB8WjJMJU2ENKhdiR9CS6+Gt5Ck1EfS7Wl0htn4rKuK2TalR936PdMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4983
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thursday 10 August 2023 13:49:39 CEST Li Zetao wrote:
> Use the helper function devm_kmemdup() rather than duplicating its
> implementation, which helps to enhance code readability.
>=20
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/wireless/silabs/wfx/main.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireles=
s/silabs/wfx/main.c
> index 0b50f7058bbb..ede822d771aa 100644
> --- a/drivers/net/wireless/silabs/wfx/main.c
> +++ b/drivers/net/wireless/silabs/wfx/main.c
> @@ -293,13 +293,12 @@ struct wfx_dev *wfx_init_common(struct device *dev,=
 const struct wfx_platform_da
>         hw->wiphy->max_scan_ie_len =3D IEEE80211_MAX_DATA_LEN;
>         hw->wiphy->n_iface_combinations =3D ARRAY_SIZE(wfx_iface_combinat=
ions);
>         hw->wiphy->iface_combinations =3D wfx_iface_combinations;
> -       hw->wiphy->bands[NL80211_BAND_2GHZ] =3D devm_kmalloc(dev, sizeof(=
wfx_band_2ghz), GFP_KERNEL);
> +       /* FIXME: also copy wfx_rates and wfx_2ghz_chantable */
> +       hw->wiphy->bands[NL80211_BAND_2GHZ] =3D devm_kmemdup(dev, &wfx_ba=
nd_2ghz,
> +                                                          sizeof(wfx_ban=
d_2ghz), GFP_KERNEL);
>         if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
>                 goto err;
>=20
> -       /* FIXME: also copy wfx_rates and wfx_2ghz_chantable */
> -       memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz, sizeo=
f(wfx_band_2ghz));
> -
>         wdev =3D hw->priv;
>         wdev->hw =3D hw;
>         wdev->dev =3D dev;
> --
> 2.34.1
>=20
>=20

Make sense.

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

--=20
J=E9r=F4me Pouiller


