Return-Path: <linux-wireless+bounces-641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1C880C571
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 11:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E328173D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16161D6AE;
	Mon, 11 Dec 2023 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="Qa0skMQa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2DF2
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 02:01:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBPtxO33c0w3g/I298c8sgQEQcbpT+FAZ0VwlP5u2pXLudFCDojARbM9IFVwM9erC9ObtPUYm0gea6B6ZLjz9o713PqTDCaVcxDmcKoyoMiKeSBx975u4p13jXXiTm8dOQ1IwrR6upIN/XhxCiXdxsT5tNIPtM0Z+j8Rm+OUuw56L1xnJISSLQo7hmPQeRuPdRE5vHa9WQ6ZxFwHMID/Bd1i4Hi9dcn9/qH07BTqAhwwZ8MJsv6vFNl0P8tpc3JJWElgIwdbFQf6vdqG1D1VfwNcOWkT9SQBhV/9WTtmjTh+cLNzCVfqMUjDT302OkNQJ7jFyKzroCXXnZOQL3rZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4T1wt9WhUQTUkyh2806K6M1ma5ETnbGkBve5pAUOI0=;
 b=F5p1DeDlo8L/Tp7Rt5gp7spLFttKFbpGE0iLG7zuJVrcVF1xGyQxtGnCgGI7q/sLEwsDzbkTdDE0Q/mWFcxZMNJGwpMrhOl/laFiEazA5h2BsCBvcopj4yLtv60Izs4GSsJhv4KPGCtZmbyvQ48oIQ+osMJ0b+dGPUzjDL6pA7Boda1jcYptLh+IX6fqBNluUlfSNoZlan3KfJ0ItuL2p9nUZx4Lzlh8KSFmlsUQJlObf+yOuxjNBEKVeWZBlM14c1yksryxTZMsX/U+pCqF3AZl3uZxaFYd8hwJn15S5l/7tPfkccGMGPFi7i2XlddWSUTQGTJ1xvJa0JjS8EFp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4T1wt9WhUQTUkyh2806K6M1ma5ETnbGkBve5pAUOI0=;
 b=Qa0skMQa6EipyrRcpqxPt6M4+pdQ4+8Pw/fVni3EI9VquuikHttqs+aaGB/bsvV8k4fHvWFI7JsyOYWWx5ADq9G4MIJGe71OkNJrZw7SBKvt59R+jvF+qiJheMoo95WRTRs8Ccj65oSoIJ1AD3Eesl7NakftUjRMtIApTHLl1Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by MW4PR11MB7080.namprd11.prod.outlook.com (2603:10b6:303:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:01:12 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::b06d:166f:f5cb:c650]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::b06d:166f:f5cb:c650%7]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 10:01:11 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject:
 Re: [PATCH] [v2] wifi: wfx: fix possible NULL pointer dereference in
 wfx_set_mfp_ap()
Date: Mon, 11 Dec 2023 11:01:08 +0100
Message-ID: <2306444.ElGaqSPkdT@pc-42>
Organization: Silicon Labs
In-Reply-To: <20231204171130.141394-1-dmantipov@yandex.ru>
References:
 <4726634.8F6SAcFxjW@pc-42> <20231204171130.141394-1-dmantipov@yandex.ru>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: LO4P123CA0496.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::15) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|MW4PR11MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: dae98b75-e8e2-4fcd-9c27-08dbfa301a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oATr7RmlgxLA1eEgNLS1UjIwBl7sezLKfZ1nq+2voYuag9sW3L89K80eQv1/os8+nKOfdyJWEELA4WmqqEcdeEj/QaU8IjNYOdQu2pPtZrj9v1NWwpUIaS+IpTHtmPMBdCoQzGamnr4dWnA2eXnIW7yQXmYYpMKh45by7OX+5G2NAg4nAXAFMbjZm6Sg3Jy7iUjnolVea7NowQXy/PNvoLEExIIpIpfaGkGekcnPQvIPfzceEss06j5a2+kQhs3NgkcrdQsWcadRTiB6z1ti9+g4APkyAZR4wMqf4hGcdVpZ7VY4snWetybHx9rDFkofEt+sFh6/WrdkUSITlb6bbucYCWgoxLpeTGsAC3fvkx3qoBxL81NTNKuAzp6Wg7izbd+rHVHxqBGtjhvDvwlxxgtTXfxASRJvaT0iB+RWfw+eDZ0oJx+Tn0mlUORgItMbWf0MMeMVo5TJYMopzCBVJcSpb0Nv5BA+VSlKU3jEkb3lMrlBGy5ZgWIO1SDPUxY9oh2oHUBYVvP60T50365A+xzjWfuJ61USLJ9DlQLgG3h8ck9kdf1SWimSLlP2ymzcWUi6lFH8kH34OZ/SN6NXVt/grXY9qhZxUdhe/YBh9xWyCDI/uChe/WLsnUogJD20fBYzmu5U2epTumaPh3YajA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(136003)(39850400004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(33716001)(41300700001)(66574015)(26005)(83380400001)(86362001)(38350700005)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(6666004)(6512007)(6506007)(9686003)(52116002)(36916002)(66946007)(66556008)(66476007)(6916009)(478600001)(6486002)(23180200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?9nlq9arUkYIezQjADgQYWKMxx8iMS2nqnC3JnPG3cmwm/T3E0ZHHomykdy?=
 =?iso-8859-1?Q?LPda56aTfreeqea/tUkIUdx9av4pWmS6o7/Sx4gfENdYwEqUCqSQoD3IoF?=
 =?iso-8859-1?Q?nvG/ydYf0vA99vmIYp6ShK9bkrQrxYpfVnHMofTxXK9Gch+Uf5Itqe2o5C?=
 =?iso-8859-1?Q?PVhstRQc1C4o/OY0yZUY2eIxIuuN7iddWyHKTY8lXbsxZdm92Dma+BmteC?=
 =?iso-8859-1?Q?DIG9C2eGCNT/A7fg+0fqQEP729BW5gdj1Yy/ASkvJdnfyfMYasXovvYHtA?=
 =?iso-8859-1?Q?Aqd7vyjO2WBhmMcjNcsXSnsA5SI8liSTUMyqLD0JqdTpmKq6p4yixEQKo9?=
 =?iso-8859-1?Q?81LmXeaCgwYQo0KpnJ1OKgnq1VcWFT/yzpYqNEhYsxGcug2UWOQZ0s6bDf?=
 =?iso-8859-1?Q?1o9wJ+tw+cuTuL9pKkHOP8Y0QCjV8lGZ1YM0hk9PAcyNGhjO5Xr3GQ71qp?=
 =?iso-8859-1?Q?nL7o6AfY/f/VGCtBDeV/bBXtGydlRJKt4p34K5MFpk7NcompIDX1E9MB9U?=
 =?iso-8859-1?Q?f9Rt9SMqxAnKVZy4rDfvQaox1lFT7QFBf4bUJRTUpn0AmzRvZmUgklwXHn?=
 =?iso-8859-1?Q?fT5wJkr1dyjVTyNYwlJi+tt+SB3QbXWrNyXDoO3/Aj+qvepJWicX454ha1?=
 =?iso-8859-1?Q?P86BsgWGVmoP4Sx9kdKuixtLjrIee+jUXSpLWBFdlRWHkpz0UfMi331WL6?=
 =?iso-8859-1?Q?yBFmQH4YTfe/OkDqGJ2aUfCm1l38pvpKC6LCmNeBONEitAGgT8j5D6xr+D?=
 =?iso-8859-1?Q?7onm2GMkTDcY1kTHqrhItjAwi9ryYrTdSGhFsHYl9uKtGH5YzbRNui/t7v?=
 =?iso-8859-1?Q?XXVFBq9eVFXYV/pGW/UpcBdYms9v/q9Wn1ouHTgkOFBb/yVCWkLjr3BVka?=
 =?iso-8859-1?Q?kDT5GpbQBkeR/8TMXWPLrnFvQ8Ul0SbUrkLv2ZgYZi4NbOTZ25gxC4ff8A?=
 =?iso-8859-1?Q?douAfwWV6E/0FoZ9uA0jpyK3eDSwzryA5ua9MpLWHzND43xjqBqUey94kE?=
 =?iso-8859-1?Q?5Mjua6Mmp/HuC5H5I2CbxKKT8ar0ocDK305a3O0pw350/WMgY+ViMmbZE9?=
 =?iso-8859-1?Q?9Foco7oUCXy+mAW6PDbMTg4/BCrWY20r41GQHdBRlitRgItn7XY9IfqEue?=
 =?iso-8859-1?Q?bGYBlSqcLixAmj9tksOsxv5HHiEPbRvAkjUQHUZBmCqlescnRVPPnBKUfu?=
 =?iso-8859-1?Q?TRBmb6v/PXLVM171HiUcFpumOT8dd5H6w5Sx3wPkRKKuJPtrAmnDYcqLsm?=
 =?iso-8859-1?Q?se1nRXK9zmGc91/65FDVYUqe1CCNn/Ftyii5oQpCN29r2jQXGoSeBdMYUw?=
 =?iso-8859-1?Q?dhil21/38bRpvnxKJz8PgnpBcqU86AaFZBodludpluzkDj/+oluD3tyuwZ?=
 =?iso-8859-1?Q?7QKg1kAi2rzU1A3oI3MnQGgf5+SpcZkDrV89voGtTk0P3E37XJzFvWQXKL?=
 =?iso-8859-1?Q?x5W0+Gsipynn1YY14us+/X2gaz4VrjR3K82bbZIHuzZyN3eTPTGvMCScJU?=
 =?iso-8859-1?Q?3fsrdWQstVXQE2uL0N6i4OCX1uCF7p/DnxQEES7LaiYMNrXfrYR/+WwZ48?=
 =?iso-8859-1?Q?DVW+SBs3bWGb3F6E8MW3ygKokdqDglGc7LfVlKVqlw2ddh+YRnDN8jXM1A?=
 =?iso-8859-1?Q?qfMmHhKyWTMMCQyuTPEjFnZnXC+y7Sqvp4?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae98b75-e8e2-4fcd-9c27-08dbfa301a4d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:01:11.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QlsvmKYOtcCkdTsa/vB0M2DMxmAlQGrSK7q+bYHvfZ4XdhUd00PhHm2lGXWv1UpEu81USuEtZQPPy4X5tt5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7080

On Monday 4 December 2023 18:11:28 CET Dmitry Antipov wrote:
> Since 'ieee80211_beacon_get()' can return NULL, 'wfx_set_mfp_ap()'
> should check the return value before examining skb data. So convert
> the latter to return an appropriate error code and propagate it to
> return from 'wfx_start_ap()' as well. Compile tested only.
>=20
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: adjust branches according to maintainer's suggestions
> ---
>  drivers/net/wireless/silabs/wfx/sta.c | 42 ++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless=
/silabs/wfx/sta.c
> index 1b6c158457b4..537caf9d914a 100644
> --- a/drivers/net/wireless/silabs/wfx/sta.c
> +++ b/drivers/net/wireless/silabs/wfx/sta.c
> @@ -336,29 +336,38 @@ static int wfx_upload_ap_templates(struct wfx_vif *=
wvif)
>         return 0;
>  }
>=20
> -static void wfx_set_mfp_ap(struct wfx_vif *wvif)
> +static int wfx_set_mfp_ap(struct wfx_vif *wvif)
>  {
>         struct ieee80211_vif *vif =3D wvif_to_vif(wvif);
>         struct sk_buff *skb =3D ieee80211_beacon_get(wvif->wdev->hw, vif,=
 0);
>         const int ieoffset =3D offsetof(struct ieee80211_mgmt, u.beacon.v=
ariable);
> -       const u16 *ptr =3D (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->dat=
a + ieoffset,
> -                                                skb->len - ieoffset);
>         const int pairwise_cipher_suite_count_offset =3D 8 / sizeof(u16);
>         const int pairwise_cipher_suite_size =3D 4 / sizeof(u16);
>         const int akm_suite_size =3D 4 / sizeof(u16);
> +       const u16 *ptr;
>=20
> -       if (ptr) {
> -               ptr +=3D pairwise_cipher_suite_count_offset;
> -               if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
> -                       return;
> -               ptr +=3D 1 + pairwise_cipher_suite_size * *ptr;
> -               if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
> -                       return;
> -               ptr +=3D 1 + akm_suite_size * *ptr;
> -               if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
> -                       return;
> -               wfx_hif_set_mfp(wvif, *ptr & BIT(7), *ptr & BIT(6));
> -       }
> +       if (unlikely(!skb))
> +               return -ENOMEM;
> +
> +       ptr =3D (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffse=
t,
> +                                     skb->len - ieoffset);
> +       if (unlikely(!ptr))
> +               return -EINVAL;
> +
> +       ptr +=3D pairwise_cipher_suite_count_offset;
> +       if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
> +               return -EINVAL;
> +
> +       ptr +=3D 1 + pairwise_cipher_suite_size * *ptr;
> +       if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
> +               return -EINVAL;
> +
> +       ptr +=3D 1 + akm_suite_size * *ptr;
> +       if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
> +               return -EINVAL;
> +
> +       wfx_hif_set_mfp(wvif, *ptr & BIT(7), *ptr & BIT(6));
> +       return 0;
>  }
>=20
>  int wfx_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> @@ -376,8 +385,7 @@ int wfx_start_ap(struct ieee80211_hw *hw, struct ieee=
80211_vif *vif,
>         ret =3D wfx_hif_start(wvif, &vif->bss_conf, wvif->channel);
>         if (ret > 0)
>                 return -EIO;
> -       wfx_set_mfp_ap(wvif);
> -       return ret;
> +       return wfx_set_mfp_ap(wvif);
>  }
>=20
>  void wfx_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> --
> 2.43.0
>=20
>=20

Tested-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
Acked-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
=20

For the record, I tested with hostapd and this configuration:

    channel=3D1
    ctrl_interface=3D/var/run/hostapd
    driver=3Dnl80211
    ht_capab=3D[SHORT-GI-20]
    hw_mode=3Dg
    ieee80211n=3D1
    ieee80211w=3D2
    interface=3Dwlan0
    rsn_pairwise=3DCCMP
    ssid=3Drpi-jpo-slv1
    wpa=3D2
    wpa_key_mgmt=3DWPA-PSK
    wpa_passphrase=3Dpassword


--=20
J=E9r=F4me Pouiller



