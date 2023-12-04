Return-Path: <linux-wireless+bounces-384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4069803AD4
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 17:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006021C20A04
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173828DD2;
	Mon,  4 Dec 2023 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="F4nYbEtN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B3DB4
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 08:50:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNxIoxeqvVNFV2lzp6ynssp9/6soIOtZEIqR9VqWuC/9ovG4HlBXIph/AbnP+jrAOit4ybibSmRfnQyddKZeZnhDSPf0OLC+eUYQ561mw4yWt7KC/3Y0p7p7h1ARu/wFnqkSxPVxxv3JAyqyLcxOiHxZ5WwOrBKT4hFvwTASLnygYNa8upPvCaESdXfIfsMQSsZLTyYefCoVqlqiLFXSdwSxQ2eDVpY+O2dG8lS5UhOXrQ0Dts4A4dtMmI6SXhjlZT0KceHWVIs5Dhpz8FeCqLzaoX6GyWjLZlxAdNp13lmhOpMbMtG43FrorsGIybfEsMCaAquKnRa3XNz1lQ1h7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTotYt7EyktFaPq52h5/3zQXgmdXiU4E6HVwmwXrZeE=;
 b=L922N8rmZ34sI5rkeb7fqlsYoSjwPktG5PYiOutr3rgxH1RfcQXmL7Yxa4IDhpW4JkkiW7MdlzcfUL/wunP/P5AZ68uDfXiYcq9vEzAjA8TcN73CXZQUwRgOv2OzUkrEI0fmR0TJEc+hLEPp6nsw9RTSMZeExiL0+0t02s6b5JVY0h7Ta0l68OWijPR7RpFhluOd+KZpWqJ/IzxH2EKKXERSdk0EswlV19JTIm9IHgxxwfIcPVOZE3E2GxVOO7t9wu/Mi4hY0Hrar40jAq9/U8L6lTOoDbZqsx1PzZ7w55cST4hIohf1pFtCs6RX82IT6pQ4ND7Ss/7ioAL9vcMysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTotYt7EyktFaPq52h5/3zQXgmdXiU4E6HVwmwXrZeE=;
 b=F4nYbEtN2R6mcCIRHx9IntfIWRP29wkulQBeZncDlFhRfyTrXRRuDcc1w6h/boMPW8wbC3B1maY359w+wDoCDQrNS30Faywa7rYAYi0E/nEJ2Vl5LvJEmno++QWAtbWgVSrs9ddRDaQ7SraTUkB6fv9s5m+s6vIaHrrGhdm6EGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 16:50:54 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::b06d:166f:f5cb:c650]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::b06d:166f:f5cb:c650%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 16:50:54 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 Dmitry Antipov <dmantipov@yandex.ru>
Subject:
 Re: [PATCH] wifi: wfx: fix possible NULL pointer dereference in
 wfx_set_mfp_ap()
Date: Mon, 04 Dec 2023 17:50:50 +0100
Message-ID: <4726634.8F6SAcFxjW@pc-42>
Organization: Silicon Labs
In-Reply-To: <20231204155558.133839-1-dmantipov@yandex.ru>
References: <20231204155558.133839-1-dmantipov@yandex.ru>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR1P264CA0112.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::16) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bb4061-1795-49f1-9bde-08dbf4e92e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	klKHks2n6xiFIwIO4QWkOwK18lZlbpiQeBgXr2LdaLgKpXaichgbVlFhzjivcx+GjFMVDy+XJQUnQaHK+5god+5zVhFzgEenFKmXX/0hCj5PWgxdz+Ru3j8Uh51rsHDmgi9VNLdTtugcBS+m80Hmed7Fsw60eP+ky9v6MBr8cl1mIlfBk0mo9EkGD2CYSceJyq10egbLWQq/hrK7oOfE/Kixq4FfWIlXWVw7W73b3cJoNoBD/ckQnHW+R2pRVs4jQRxpixIuRd7vBfQ92PHx1qowv3bSp5dAaoEKNJzV8nTnTxtddGEiyA0aBoe77Tw48xXCx99okyOCBOJxdBsYsgCy7M5S+ZcAx65bCdU5uEJUzICHxK7IiJZEFpUDH8Pc+XUlWVNP4Rw1ousJBb6fOlA8qcWxeVALaGXMLlcb2piXqEuOauMqN/Wx3ZP4AJiJXhLYvFmgLJSfEbLWc3V1bObbLWzsBAaS3YphDO0rR+OM+YkuLkEWo1veEB11bmCvH3vLnJ7Jm7eprtQ2+Cq6NPYfdufsebn5EbNJmLZNzwZuzd0uG9buvT3vMLI4XozW2dmpbvcuUVtu8N88+acH2QhHK7uCjdIDM10f295mAHI6eHf0kq7fXkMNjqWNGtvu3wyRSLzFnkGcLUxpvVw9dQlewqaM3YvdQACow1Nipq1PPh8rHPAqoZWOI2ju11gY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(376002)(39850400004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6666004)(52116002)(36916002)(6506007)(9686003)(6512007)(478600001)(26005)(83380400001)(66574015)(6486002)(6916009)(66476007)(66946007)(66556008)(316002)(54906003)(86362001)(5660300002)(41300700001)(33716001)(8676002)(8936002)(4326008)(38100700002)(2906002)(38350700005)(39026012)(23180200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?jsoMwswRy9fqBIdG5qV4BOlpdjLq79x+kZAzoH2OqLZyNG6Ao3HF0q8zcL?=
 =?iso-8859-1?Q?3aQcqRT8w1Hb41vysv1Q8WyuGE+YIEuOxfVR40G1o2XL7NxTmlgUkULvg4?=
 =?iso-8859-1?Q?ieP7IVmZl3Wi6jpQrgG57h0jirQ0h6xBGMJKNH8SQyaBS50eEU5NnV6CFk?=
 =?iso-8859-1?Q?GLZxq3N7dIaZ0bWud9WwBphv+CAlqcmW7abuUoYu8SSQu8rWI73WUUnZPc?=
 =?iso-8859-1?Q?QdGCrhDUU9zu35vWcc4k1hvQ8XKquhD+p/luc+pHTL2CwLM0f4Q3WPftGi?=
 =?iso-8859-1?Q?Qq/FiyGBoDeQ8zlJITwcohcoBnusbTkN5umqebG1pHYjUcKnORnLEjZr9C?=
 =?iso-8859-1?Q?YswenvLW+oe+rdarqD+c1n4Erw5xhJ30FoHBrHt8QUosPLb3NYpzwJNlbf?=
 =?iso-8859-1?Q?8a9P8gd7TrXjFsntnxeZxP6hp9sMFrmfxlSDvANTywWexMv6PrOrysepQu?=
 =?iso-8859-1?Q?GcSm/3fGEwf4FNI42pF3WZjsJVFr1GmcUZ/RqvKryUYWulpeG9ftfJjTC2?=
 =?iso-8859-1?Q?2Th/7kZir+YfxCZNvIwOts8UCSzd9IG1ZryTnn0P0b1pVYcRRV0dNff09S?=
 =?iso-8859-1?Q?xLPkF5y0lAcCS7kCLyMpmygG6PHdPLn2TRAK6ILQQzmIbwJW7Yzd/SeW3q?=
 =?iso-8859-1?Q?Y7soPA6ggnPz0t8ETBOncCT92ZnAb6zc3V73gSm80fg8Z6B/jTt6+SFiOi?=
 =?iso-8859-1?Q?mMQaaExWXoeypHzudrDoEnXRxH/syiLIpaJgrc7MqH80Upa3ckNX8MWvxq?=
 =?iso-8859-1?Q?II6ebu+fsGLEsAbz86/mkaUSJjlaBqNqviMNcq/Z74GlzzbgY73pkCUEcG?=
 =?iso-8859-1?Q?z9tAtFtFpwP8YDzqVBYsOj8mqPNxt05KxpqHEE+aOeFRwcc+7DrYmdKNxn?=
 =?iso-8859-1?Q?Ikv0mXMjgOe6R/XdkWJNsPsQJIVVcuz9xEWMaPq6sJ7BSAtqLwAjlVdC3C?=
 =?iso-8859-1?Q?YSZ4TtbUND4MVZRfPK7jtKEgg3g+EzmPkJroJrG55vEgw1f5z4XuBQJBH4?=
 =?iso-8859-1?Q?bghmliuQtWfHtX/CQvRaBENi36liY5AT+l+meU7GJBxIV2eorfNwx1ERLx?=
 =?iso-8859-1?Q?tpjLM07yotgvDt35D3vxAKFCXwLIi/h9zIDLJeLTLxKwpIdKt6+MFmZAU4?=
 =?iso-8859-1?Q?o/145T5qdjZXvD30SctFobPDOKsHCDla6x5Iwa4A0qUgqXHo5tdjLYkJRP?=
 =?iso-8859-1?Q?tKlCjHMQvafj0/H17kwjkTLklLeMdjlkgb6jNmhD+lgbub4lOWdFyDmCpK?=
 =?iso-8859-1?Q?j5xl/k5hbWkHD7cCPKHsfijW8vC4AKUULqxF7r3cx/qr5ll4829C1J6yqp?=
 =?iso-8859-1?Q?/mdgPg7qtRF15GgoWAeQmPEo+zw5sLRorOk7PP5SD0hD3jJdR31RNmDyXD?=
 =?iso-8859-1?Q?4DcmOjOKWSdQiQxWhsOK44dOKnUAZ/+l8qLAR2os9ti/9nWSTQQBP9g1JE?=
 =?iso-8859-1?Q?PeXMMmIH5CjGQwFuprtgk9xsnleHrU0tGYO+SuncH5FmcFS/NyiG+1o8W+?=
 =?iso-8859-1?Q?buBpBC6eXMU7cd2grht4dAwNj770eRnsSgkAaraCueA7DFLO+t21oaXcFB?=
 =?iso-8859-1?Q?PZztNJAl2Z/ydiX7PgVi/zm7ZaZZtVIkJvOT+TcXsYb9NHkiFTaTVm8Vjy?=
 =?iso-8859-1?Q?EWAl5ecAoEpCy2eQTQC+d06mhaHILjqPCD?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bb4061-1795-49f1-9bde-08dbf4e92e2b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:50:54.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x2OOApXsLOGf4S4KvWv8fHrQka6cga1K+q92WO2GB85qglifkYPe5ZqIkid/9bLxtI1XdaIQNAUeJ8Ffmr1PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454

Hello Dmitry,

On Monday 4 December 2023 16:55:37 CET Dmitry Antipov wrote:
>=20
> Since 'ieee80211_beacon_get()' can return NULL, 'wfx_set_mfp_ap()'
> should check the return value before examining skb data. So convert
> the latter to return an appropriate error code and propagate it to
> return from 'wfx_start_ap()' as well. Compile tested only.
>=20
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/silabs/wfx/sta.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless=
/silabs/wfx/sta.c
> index 1b6c158457b4..df100d8513ad 100644
> --- a/drivers/net/wireless/silabs/wfx/sta.c
> +++ b/drivers/net/wireless/silabs/wfx/sta.c
> @@ -336,29 +336,35 @@ static int wfx_upload_ap_templates(struct wfx_vif *=
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
> +       if (unlikely(!skb))
> +               return -ENOMEM;
> +
> +       ptr =3D (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffse=
t,
> +                                     skb->len - ieoffset);
>         if (ptr) {

The code would be slightly better if we would invert this condition:

    if (!ptr)
            return -EINVAL;
=20
>                 ptr +=3D pairwise_cipher_suite_count_offset;
>                 if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
> -                       return;
> +                       return -EINVAL;
>                 ptr +=3D 1 + pairwise_cipher_suite_size * *ptr;
>                 if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
> -                       return;
> +                       return -EINVAL;
>                 ptr +=3D 1 + akm_suite_size * *ptr;
>                 if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
> -                       return;
> +                       return -EINVAL;
>                 wfx_hif_set_mfp(wvif, *ptr & BIT(7), *ptr & BIT(6));
> +               return 0;
>         }
> +       return -EINVAL;
>  }
>=20
>  int wfx_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> @@ -374,10 +380,7 @@ int wfx_start_ap(struct ieee80211_hw *hw, struct iee=
e80211_vif *vif,
>         wvif =3D (struct wfx_vif *)vif->drv_priv;
>         wfx_upload_ap_templates(wvif);
>         ret =3D wfx_hif_start(wvif, &vif->bss_conf, wvif->channel);
> -       if (ret > 0)
> -               return -EIO;
> -       wfx_set_mfp_ap(wvif);
> -       return ret;
> +       return ret > 0 ? -EIO : wfx_set_mfp_ap(wvif);

I would prefer to not abuse of the trinary operator. I would prefer:

       if (ret > 0)
               return -EIO;
       return wfx_set_mfp_ap(wvif);

>  }
>=20
>  void wfx_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> --
> 2.43.0
>=20
>=20

I agree with the patch. Could you fix the cosmetics issues? I will take car=
e
of testing it on real hardware.



--=20
J=E9r=F4me Pouiller



