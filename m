Return-Path: <linux-wireless+bounces-25070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C54BAAFDF7B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949DD1C2624D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1973B433A4;
	Wed,  9 Jul 2025 05:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KOnd2LCN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011006.outbound.protection.outlook.com [52.101.65.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9B1AAC9;
	Wed,  9 Jul 2025 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039992; cv=fail; b=Iimdd0GxpXi28xhV0p6mR/0y/74rZwy8B0OCW/9NTj+eJii/p6/Vr0hJA/uSCcui2KTyGuT9D71/a3llOZLyUJi82YibWx6VSc2mZFjG+cokTB+4QFmeASUI0y4wJ7+spNLXOUxLWccjLw0hq2K+0BERBzte31cAef300bmZPVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039992; c=relaxed/simple;
	bh=RcXpefcf0UC4u8e03JyknNixbPO0NIgPDej+HpDIu4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PkhtILUzdIdPVI0NDwCbzv5U3Ycj/iqANwVMpF1fwG43SO5eM0tV1LgZjTUKpw67vy9fAuD+dyJcSwd01iZHe9A2VuHTlMswZLiknLqY32w2icvYh1S5hiDiRngPaw7toUAFo2FlTiE91imLlTovIXLpY49K/e3KMcphj3p8eRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KOnd2LCN reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnAmtRaCCqknM/SW7z2x9sY4KKHgrZXZi064iOKt0THv2GBq/u5p8jECGQwFdh/XLtUZoRPIFT7esRwqMtejKg0OgZR49Ze3UMRYsjD0mLoB+/fEWysmd3VSpz80aX4PzFTFVJCscVx3FI+JsBY+vq5tSZeFiI883DJQFJwUDMrU4fwvVr6+CX+nQeqE4ED7KhQlsMT2r0TIgYZnVAFE8upAh4CsjJ4HAvT3qfH7BK1zU1Lq11x5EwASzr9IcRycqe2E1vOc8eIPxQtTnituo9w4JqOM1rNCBJNoE0Jl7vMrsaU4s7y49ZHjXl9uVwAUsHaBit15ygiNEtUNHEMgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCYakYXetOOexM+rnwiJp5fOUY4w9Vruw7wB6lw8m1k=;
 b=h6APnUkksYWYgY/j6/3sOndjw4eZAr9SXkw8qopAlhNEC9iJsHfOmbOtmKIOUyMVPIdO+MGQQzeA1JgwDb4CFsfhgZenvgkvELmPLs3zy+j8LJeJeJu3aNyMCp/PB3gffh+mW6oFQvk9SYAimQI631zciBd6iot/lTBtZ34X5A3uC9vW+USb4w0K0O/4wZtDaXONuvDRTzURlIkpJZWYqj06ZA6Egis9IjkzIa4Ff33xMNxjLci4FUb3bqr8dzRt7zug8ACSl4lCBCYrYjNmBXBneZ1u09iPABHqnDz9elJs3Y+B3ic1ZxOMmMHmbKleUmZpF2YNQbIPi6GgaOyVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCYakYXetOOexM+rnwiJp5fOUY4w9Vruw7wB6lw8m1k=;
 b=KOnd2LCNfw5lbx6ev1tjfa9tecrybBlzpKIv4EWBaNoDRvO17OJSbdSPYJeZkDBppyKwYwvN2QGZ8emL8E5zTcd26J9HXPHoaEr86aGagJ5q5+LT7jUtLBRZF+Zo+g58PyAOUWN4RX2FZWSEcx4juZ0HQ+5yEn/IdFMGYoCKyclO1MfcncZVMkoUuKRYeKQi4VwNUa0khthvBAkuVYJ63An17275CtNT4ytGhOtJamtDqtLZE38jZId7lxQwFB31setPu9JqagMffaPScN2dkdaBHf+oXTHNm4KaI+GIs79aDgNGZPVUrvTtKiXpNp/GK8V5MeJjxuyq1mJp7od3qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5497.eurprd04.prod.outlook.com (2603:10a6:10:8a::17)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Wed, 9 Jul
 2025 05:46:26 +0000
Received: from DB7PR04MB5497.eurprd04.prod.outlook.com
 ([fe80::a12e:514d:8f94:e391]) by DB7PR04MB5497.eurprd04.prod.outlook.com
 ([fe80::a12e:514d:8f94:e391%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:46:26 +0000
Date: Wed, 9 Jul 2025 13:42:41 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"open list:MARVELL MWIFIEX WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/12] wifi: mwifiex: Use max() to improve code
Message-ID: <aG4BUWM8o8S7bR9p@nxpwireless-Inspiron-14-Plus-7440>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
 <20250709022210.304030-11-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709022210.304030-11-rongqianfeng@vivo.com>
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To DB7PR04MB5497.eurprd04.prod.outlook.com
 (2603:10a6:10:8a::17)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5497:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 13811ec6-b762-4622-ac7b-08ddbeabf1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|52116014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?YTu0xB67+ojT1a8lZ0CCl/QwL3N+ah+GEWj9uQ1fBYzKdarqm784R6f8OX?=
 =?iso-8859-1?Q?gDzdt7z9/xB8Y6M+p759Syi6X3LsyjcqS8o8o8OCWQq1qBAHAaUcFHt+0L?=
 =?iso-8859-1?Q?/096CIDuZtJdY3TmMjMInsxjGrsTnLUSSAxAJc0Pr8PNaUuft6v3wmSTeP?=
 =?iso-8859-1?Q?HZMUOoZfes646QXPwsCC3TZmfuvMShysKfrjii1ENDeMShEosi76WOCw4B?=
 =?iso-8859-1?Q?yMZJf1KH1ukth5zrFpmJ1sDfezwJU3+zQelWNu7Yh2a1HEueWuGEvpYNDj?=
 =?iso-8859-1?Q?21+0h+ZqgO3KbmbieUlBdK4cYrJF06kHjtfJjD/l+WQ/MtLlWt7tnNkIPy?=
 =?iso-8859-1?Q?YXihonxtayVfGUo9V7VebtjcNVcmFaM/dG4Lcn9oKWCAE+NOtQztdiF+3E?=
 =?iso-8859-1?Q?BCt3B8aCQHi4wC8RgtrigAbWwem2DYDsr3pcPIa1pCCKfRyk6pya1JeDGl?=
 =?iso-8859-1?Q?CwUjqOjS2N88QrClL3KCw+AdWvNndNh3dNCzhlFfWwA/U+3EpclZSxAoLJ?=
 =?iso-8859-1?Q?HnQcQ5mZFiPXjzu4H2QiGVJht5uV3o6Mj9MKoifBp//KenvZs6ncJpHkbh?=
 =?iso-8859-1?Q?gVe6+iNzMu06rJSMd8YrxFLrmskkp2w3A+5MFufUsOuapEd7b5A9tRMKjH?=
 =?iso-8859-1?Q?nfkaMeYN3lWoL0MCGgG5NHrVvl4U1G20pLwTU3sDUuDBrVtquaO4Hn3Oed?=
 =?iso-8859-1?Q?qpOGEe/Tes68l5kwO1mwH+Bik8cjIoZyV8mxesDA+o/kfQOoy6bfLfdPOq?=
 =?iso-8859-1?Q?BtfnVoSbSPpjs0Ohh/xLBTWExZ4Z0xO+LY5mHi9lCPH+OcAyRyDoqJWQoe?=
 =?iso-8859-1?Q?kUuEOSHHm4jtkMfkUL3YPP3fSwrehhbJRRSrN7LqAX5l1/5DW/r/Phuh+a?=
 =?iso-8859-1?Q?8FC0Hpp9DkeGE3Dd4q5csOxTgk4T0qvlCVMOmz0pjKVC/rMtPbzLHCkYaX?=
 =?iso-8859-1?Q?Y118+d0xx5+FcdvTuj1W/PB3o1qT7FT6fgLmFV30LOH99HDCEVKmMoadyS?=
 =?iso-8859-1?Q?20yUMZaKGb4EH/7E02cU/nVbuaCGvl4mV6VpzIZRp/wkcS6Dc4DKXvDBb4?=
 =?iso-8859-1?Q?BAqSGm9+Hk0vry5uDWuaBwhedykMSoSpRs/4rooloyqap4pRG5BsJuWRjq?=
 =?iso-8859-1?Q?MBEJMzu45SvPKrapJVv+IyOg/Cf6MgZrGIn6GqKFyr2gMGyP2dqHkPv5F6?=
 =?iso-8859-1?Q?6cm/xXN+kdbGCkWNH5Bk8YMz4sXEYZW2P60Cte71MpSOae5O3pDxutwV77?=
 =?iso-8859-1?Q?PnIbtQ6cHoyXhZr424gv7RuONzTNV4g3+5sl230zLa23kOEMkRZpziZax0?=
 =?iso-8859-1?Q?2lXLSsSkrgTVeGWwZ378fmFcK7avHCid4MAQGYuDTE1oAU1sir3kV6l2Lx?=
 =?iso-8859-1?Q?w3XMol7tRHFpaLaFhnccsiR+pIi+k//YQfB2PeiBSTCPC6vkIY7qUi/Iwh?=
 =?iso-8859-1?Q?wX8UUmYK05t6qH9rjn66Fo6RbEDg/VIIFfC2boYubdQWU97/Vb99iiW6A4?=
 =?iso-8859-1?Q?kXMadXRxaiOnm/7pPFAg8FOUoPqcqIotn3vvY/7TodHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(52116014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?7rRD14JfkNmPfU563U9PkP8Fhz6ck9hdWGkRt9lV78jD7brOpyXGW0ELhd?=
 =?iso-8859-1?Q?ZqE/nMYjswKkukB9VRdqMNvKNLV5Ug3Br/7qJ7DICg+0KIdAkKfbsgQ0tl?=
 =?iso-8859-1?Q?VncZNloi8srpOLWMICVWRX0YSTh1X40ms9jNZbWFnhrn7clDIHaGxt+G4o?=
 =?iso-8859-1?Q?PBIJN+J5QaEeBbbY23OliLW8+mEZ4r0Rlj1lTmzqYBn/s1pw7o1KZbdjbJ?=
 =?iso-8859-1?Q?yUfw+mCizcT3HDF0DpJZGzdzV4RayT+Mq/4Ovo7FbJScimpAVd69Z7Wipw?=
 =?iso-8859-1?Q?0JF6JUYyXd3Xlb0KP/Qn3g+tbA7vXoiCwnIIbuyxAkmFaAEZLPItTnuMrW?=
 =?iso-8859-1?Q?QElBxIqpBjfq2br7qa5ETqqk4zipywonrFmDtH0K/K6p04oaKO/Iya136+?=
 =?iso-8859-1?Q?+I4Q/T/4BOQlMN+ZKiJWzNpmkSTEveqt6pKLZJ8aQm+0d8cIpj0tiCo+uD?=
 =?iso-8859-1?Q?BazuSgqAzqxllqAM/I+UwG10Pu7eihog8mZik+CTXQqTZQbec/jWdk2o6Y?=
 =?iso-8859-1?Q?pAjezCm694pmR1/Aza1zJBhjuZaev/SMA4gHaGjA/U1KgNQhzdaE7+WhDS?=
 =?iso-8859-1?Q?eSC75zWNgxJnsL+WfZBMszxAlAD+8SKudA6ewdo2tRPshl4p142Ti9Ddhx?=
 =?iso-8859-1?Q?PywNu9rSSHpr8FDNpeViQUBYoq+vYUX/P1xN0Rn64G3UwWCPyv46qNvPFK?=
 =?iso-8859-1?Q?WsGAK5VYAyLtNVmKFbmQ0Anlq666GkH6wMF/ADph1siW29T4AONaw4Upkf?=
 =?iso-8859-1?Q?drIEhb1qkD5FacZkYNk6dIy63ydOBKw7xTf48eNsfiiHTSfYhChoBenZ5R?=
 =?iso-8859-1?Q?odQbemKfJPd3c5xRAxkO7pfuxVVtUWZiSY/SHdT89aGwD8dqWqJ1BnWwDw?=
 =?iso-8859-1?Q?0NFsrs5s+L22FDk7cGYj5IaXfaOvH5k2l8mhDd2cM7f/2H59oSzpIZDTOk?=
 =?iso-8859-1?Q?D7rUYAw8J/+HyUSdOR9gLe10mtCQCxme5jTpC0yg5RTzmdG9q/xiuRGbl/?=
 =?iso-8859-1?Q?csltzzef9Ah8vxg+aO7zI73h4vm0oVB7tEMTK7k3I+fxgguzHszUWyOK6r?=
 =?iso-8859-1?Q?t6tiKpQj60DaDUOIO5ubu7GmLzEJAUc6nmTzfAi+EENelaU/dZt2OKzsKk?=
 =?iso-8859-1?Q?f9Pm/WcO+V4CSrmK5PoPh6H4l5lsAgJMQFKBgjY8jyr0qJPvsPTy8sWVA7?=
 =?iso-8859-1?Q?LVW8r6wmssnYa5tJELo7WctMrUDszgmaISq/WVztTS2EPd8emJRkvdyJuZ?=
 =?iso-8859-1?Q?noHnwffp3DWdlw93lAd5IKNzA8Uv8mG8zD2KXHzq+SRYdLRI66ul7576nP?=
 =?iso-8859-1?Q?5aNTC6A46BvOncZ5syr3cauTHt/xdb+ZwaUD1eLBiT/M7bYvyH3w9AFLEr?=
 =?iso-8859-1?Q?hFBqIYrjoAtX1RDJbW1bojPgGkKIIcDINJbsWlpPSt3ksftGDBsaAqijgg?=
 =?iso-8859-1?Q?T4/HNPRyjWL2gYweTjHNu20aDjKb+y0UB3XmOajcPk0FQzsF0EI9AgIvdU?=
 =?iso-8859-1?Q?bb1JWty54sNVrm4KLVAwMb7J70XOLqmjNGSaqPLDuGELngu4sTvlQ4Yuhj?=
 =?iso-8859-1?Q?s7hST4PrjNfS3Q7QVuq3QGUcBaPZ3B9gld2LiwFpda200zCO1IeF3ajlk8?=
 =?iso-8859-1?Q?+WPIt4pfWrXtYZxL5dlpUYPIexIGqt5/1X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13811ec6-b762-4622-ac7b-08ddbeabf1b0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 05:46:26.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7obY23DfSgK4+gaPJ2UeVqMOizjLqG9na+ndQElpx1WHRqfMSatia7wCAVbFqFQHPis7/jinrAP62QkwU8KrOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Hi Qianfeng,
Thanks for the cleanup.

On Wed, Jul 09, 2025 at 10:21:38 AM +0800, Qianfeng Rong wrote:
> Use max() to reduce the code and improve its readability.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 286378770e9e..d81db73ac77f 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -4783,10 +4783,8 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
>  		wiphy->iface_combinations = &mwifiex_iface_comb_ap_sta;
>  	wiphy->n_iface_combinations = 1;
>  
> -	if (adapter->max_sta_conn > adapter->max_p2p_conn)
> -		wiphy->max_ap_assoc_sta = adapter->max_sta_conn;
> -	else
> -		wiphy->max_ap_assoc_sta = adapter->max_p2p_conn;
> +	wiphy->max_ap_assoc_sta = max(adapter->max_sta_conn,
> +				      adapter->max_p2p_conn);

adapter->max_sta_conn and adapter->max_p2p_conn are u8, and wiphy->max_ap_assoc_sta is u16.
To ensure type safety and maintainability, I recommend using max_t() with typeof():
wiphy->max_ap_assoc_sta = max_t(typeof(wiphy->max_ap_assoc_sta),
                                adapter->max_sta_conn,
                                adapter->max_p2p_conn);

>  
>  	/* Initialize cipher suits */
>  	wiphy->cipher_suites = mwifiex_cipher_suites;
> -- 
> 2.34.1
> 

