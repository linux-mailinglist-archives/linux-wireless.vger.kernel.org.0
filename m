Return-Path: <linux-wireless+bounces-11927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD695E6B9
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 04:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742FE280F7A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 02:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687DA645;
	Mon, 26 Aug 2024 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FXZjB9Yo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1DD2913;
	Mon, 26 Aug 2024 02:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724639595; cv=fail; b=hO+c5B1iUXSmRA1GLDXAPm//WxEo37wLX7AkPGn2E0C89w9tFuhGrnP6eFyRfLs3UrndwEhckXRDfIGJbzuH/Wg/hzLuaLudAyWWWXm/xZWn6BcjAqw1hgCFJFflkTGMXEJXpmp4Rev7nCT0Rozd8jJhrapSTL3xRd21+7q6gtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724639595; c=relaxed/simple;
	bh=FBEc4qpTXIDu5dt534ymEzuxkUDGV8ICYG0wRQSkVfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kDVBJ3vG6BcEvK7jWKlKnj8LJSjnfAxXbTxlQe2u/xxmY1up1OqmEVXk3T/KX2bc52NeZ5u2eygnJBtelxVzvEwUqgfF7CFm6MbSf4V3doq89+jl/y2GysZztIdOWLEh5mdenp4E4ayo5jMj0NyY7PyNHQA1bD4LFu752WuHfqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FXZjB9Yo; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFA8amfddt9VJOHTiQ0W0kxTMk3RLSiFepIfrjBwY6u0P0BWm90Q0E8h5YhUL+eZkTrvrSwkEZvz0+bqKP3eMd5DGu6C3FNV3NirvJP7uxOocnYGYTYtbUxUBimpg74m3NgRoT1/OBvuyc8NfEeOtpZP9XzCoa5gQZPF4whh5ltMYzsORNRGW/nu0rC9oxH5Vs9+ehtNVPk7VndKMXfpTWQL13bnmOasojtkI30HsNu3CP4PBoa2rjFtsbNkD4SuqPw+RAke2dlXOneEOewmfRwMV2jPJ5bgvsaGDZEA4Cb9Htan5WRpWG/R3RkbMNHpEI89GVobhmKDtHC4n2raqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdNKseiGpvaYBNJHvbswADeAkl3Mhpl+NazmFzXM9kE=;
 b=wlCNxBLjFcWONf6OxZmqYixzLjUp6NEssIIAwK7f8YSbVqGQzyiOjSPBTUuQfWwLQZWztARh8qVtZJJpznk221gSLq++YUkhror7ZKv9Qxste10+U3eyuAL96CM6Kiwryab+n7fSEJhYLDdpiq3870TPJrN2w/QkUxNSm/roZeeXsdVjr3Nmt8xQrZtjCVJkH7tImw/qa5ti4MX5GpPp59VcuyA02pu/WFgaVeC+kFq6x84TFxX21ysHDB1MPsKN7Oesjs0vU2YAEJfA87f8Wi9+i/6djix2zcnrzIuGxTdTUPwSY9PjVyfKdqPLAS2KTkyyMQgAwStuJuFT378cdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdNKseiGpvaYBNJHvbswADeAkl3Mhpl+NazmFzXM9kE=;
 b=FXZjB9Yo0cpNaUqGufTFjrFT6kjXb5bASuwREGxuIm8oTaPN8+oh51eaOvbVvw63du+KkI6+hCP8b7trq1Sy05uEbHka3ccMToTOkvU/iDugfVwNpma0s7bFgW1/TnvA217u4grRwn7IMELFtKb7VhdVM8aCkwdcBhFHRs4IaQfe0LhpwSuYT+HT0QRZy0XY/LTSiL+LSgf5NPjzbSBZguZik8m9W4aLfhJ2GeXMMC3t4pygXB2BPbPL815J5GDFgoVkPP937rq4kH087TiX28cJ/F4sM1g22SIbOy9BiypbICVm29Br5VhiCECZjujDzgBuCzYoGEQXym5LXjb71A==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB7149.eurprd04.prod.outlook.com (2603:10a6:800:12e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 26 Aug
 2024 02:33:10 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 02:33:10 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Calvin Owens <calvin@wbinvd.org>, Sascha Hauer <s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: AQHa6kDq7zFfRJGOz0Wel62W8Sr8T7IzUOKAgAU33ICAAGLVsA==
Date: Mon, 26 Aug 2024 02:33:10 +0000
Message-ID:
 <PA4PR04MB96384BCB4093D621C43B047ED18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <Zsc1efkBHDXdZtfJ@pengutronix.de> <ZsuWExGZyY8Tvu6s@mozart.vkv.me>
In-Reply-To: <ZsuWExGZyY8Tvu6s@mozart.vkv.me>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB7149:EE_
x-ms-office365-filtering-correlation-id: e2ca2325-0ccf-4e10-3dfb-08dcc5776d3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ks0dRA66aVyaPlewnDTFmQLusCG3/0VyPKTpe42t4Yd3Usnp8jPYNx+25YN7?=
 =?us-ascii?Q?DRfLIzThkqnwj1mZVO8Nca5Iz33xPeURVxFqrQk091rgh3jge0Z4kHAFIRJS?=
 =?us-ascii?Q?TVKsG8TWSDVO6r/gtDmfgx95H8KIkN4qPs4QvUnE44t3+ytgtf1g04jIBoI2?=
 =?us-ascii?Q?gwtkLyk5B+DlADsH4MJzKxR+l4aVnKsgHF1My8AjnaCNVAv0uiYqbAlxQdpu?=
 =?us-ascii?Q?9a5fU1tER0NNzuX1jC8IxZlGlrwE36do8B8/co9yWKxK0glSN5NtGOQIawQM?=
 =?us-ascii?Q?yIULeNzubcrim0q3w1WYNTA+HvfVu9ZZ1sfqL+IeXAJPtAFSP7basbV6ty4/?=
 =?us-ascii?Q?i1brfoWpVyFXAQP08C/p7J1qk6eky5MoAQjM2pb1ZiPB2YUHe9n6YxSzjW/C?=
 =?us-ascii?Q?+wyLKW28eM6d4p0nqh3UvSoiqi6jBRfY+4HpfpOUntbdyH0XKeinuhX/YX+g?=
 =?us-ascii?Q?uqVZcqRq9589XRjlYHSSidBwG+QZUBhvjRyNsE9AQnsmi48lOiHLcT2tZGUE?=
 =?us-ascii?Q?JmiWxfLOFfPD7Qg9WmTs/77bRviez7t5SXzEgs1RbrzbQqCsLY0Q8wjMVDPG?=
 =?us-ascii?Q?/r0HXWK0T6IJ3+88russuIhgj3dWUlfnRqCUnEj29tu1dOkBICBn62Hq0Gw1?=
 =?us-ascii?Q?wWtw7DCVZyjjXhf6PHeUqX7nCLd4wVSfUHLQwSfDp3MhBdyjpJ4gKCzdppfQ?=
 =?us-ascii?Q?UV/iONUqH6thW/JrBt9Vd9E2ijtej/On8vWv1KDnYN29XhGvh7xKNEDkRBDd?=
 =?us-ascii?Q?Z4lwBbQxFkQzDsDJN3ZEAU3qhb8mlYpKB1MPKexWkN6xzUP0KjlaChCHzP1m?=
 =?us-ascii?Q?DvKcZh1zS22OTh1X5n0hxc08ilL9o1xgwUvmsItWCuTNXUD01L9YaznjcQ7w?=
 =?us-ascii?Q?pJJ13Er9dSdy+zIsE3RbZPyU8s58czxOeFUjb/CZjtjVwTexWQ0HjpLFG14x?=
 =?us-ascii?Q?T+5VBuyorBqj5ZkjUsaoyDQ/NJmZswVqI5OTgcSBl7wRQOes5txIAPRPtcvz?=
 =?us-ascii?Q?DEVR3JyRrZ8x3HhmWt/whidYpst//gbllVNMLn800qovKc3p1uvYLb5dp14B?=
 =?us-ascii?Q?N7xjOQUVXcAmwr0MhprlekmBGp9ecz237NI0oO8cVvqVX+nHJL7n1TYEHheg?=
 =?us-ascii?Q?vbxCWZse8OpCCrjMOiOx2oDfpm3Z6NHN5Cegt4fy/F5ePhDkBKHHxvGhp/KT?=
 =?us-ascii?Q?d32SqQToz5tt9IPojzkXGzME/A4cGI1ztBuZsEJL4fQZ1FGi8I+WX0PaPuTD?=
 =?us-ascii?Q?r8rgqq78MboJRO85VLLKBbKeKk6SMUa6ZGqM8b+5Suko+fQiG4EcoTpv6lBo?=
 =?us-ascii?Q?aluJ8DlSVMTrPYLFCpJhkf+wLKPFiWjCM1purmqlTTGfNZvjyQeWVOABFwF/?=
 =?us-ascii?Q?9hDFLFs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IcZiuNN8+TW9pzUjjkJe8awPxAwH0qzQXGfZeSxJCDfUhMakF78YtbRoQNs3?=
 =?us-ascii?Q?fhpUFaoLzWbV1cUjLZIXul9w7rKmppM2AqpenpWr2D7gg3nxo1o4NHYFmLle?=
 =?us-ascii?Q?d9LnGJpUVXATkLjVtkygDz6Z5uDCPX9hYu+gC0qjRzrUJGC86nhN6ggGXsTZ?=
 =?us-ascii?Q?swIfZ6s2A4oxK3GHva+ns7qU4okhVZnTCGFOQwTJ4TDmlOj4CF4m53JhvD3e?=
 =?us-ascii?Q?WJf2o4eWvJkI72/8AeMWhNIa2McsM46ayJpBaqsRKJ6DP9s2Ti759YQvSZFA?=
 =?us-ascii?Q?NyqTRlIhh/BxWlMifNwQ0+Npjqy8ldNiLjg+2PrH0/zGzmQNtR0+6ueaVukF?=
 =?us-ascii?Q?G3a3yiCPh4NxBjZVRA3u9BZ06cc4MDuNLzv9jTZy2+jouhFnXT7DDJ6LfCuF?=
 =?us-ascii?Q?o+k6fHMB8qMJqcrP8vLLlJsmgxiz7kzXNxgBkZVcW77cQYHMNvSjDkPhPJ8k?=
 =?us-ascii?Q?G4Jh+ZBsEZTX61FZawQe5JDWlXUCEPz4H75NIpD20zgK24LQdc0mDOTZIKsq?=
 =?us-ascii?Q?NCwwlKyDryrbeRnEyI+UyU/CVTC8vcdo8gVtOYkChM9OgPJfXiuN3HOMzoRe?=
 =?us-ascii?Q?setg0MsvtwDARKoYYG3a04odWWBmrPUYmoegyFwtdzAjX9yyMEZzWLwjwupj?=
 =?us-ascii?Q?8T4YSQzAGhVgx4PlAV/jK5+1Tis0woZrsywOLkjPECzK4sTgV8WoCkJksRqo?=
 =?us-ascii?Q?QnXF66i9GJCvqtiFtFeW01LwVpj+ibyATn0dcCBJ4QBVfV7VJ9uFRtpt53cV?=
 =?us-ascii?Q?PXQc0xLTfK/DCPKi4GX5qLQqJSdaBry5ROOuClrZO25BBED/zx9wP2voV76M?=
 =?us-ascii?Q?D/Lj3Cwpj1iuo48tWbMn1QNLRIhSv1Ei7kIgy6aUIwgSq2lP6DQQYRng8Ggm?=
 =?us-ascii?Q?cMK/A2WwZLk819nyRbxM6nwPrHdShzDS0FO1rgwBEfGVhpMvJyAtljB4u1lj?=
 =?us-ascii?Q?L3SZUTGjP6E7wm65VsKEFkeFWO6i7u9QagZBzsd6+ahvsOSglBwpkttwC7db?=
 =?us-ascii?Q?6V1C6ox+SXk4ImtWTNDzPcbm9eqcUrhDbWbwOv7audfi4krrqxvEwWx7e8fk?=
 =?us-ascii?Q?kBy4nspFdNF4hoEuAg0h6R4XXb1Cdf0AelqvxWK4H16rdkPsQn0gYPpdnXH/?=
 =?us-ascii?Q?Li4AASJ33k2/wy1QGxsTQeyPk0SoMrUpO8PD9bEjFVUYDlti7Yt1oo2baNWX?=
 =?us-ascii?Q?gVXyij3sb2d4V6tns0JkU5xZsZA8A5wiM7u05Ijpz2CJPm1MsTR0KlSt2a4N?=
 =?us-ascii?Q?ljjvKGuzMkJ1VIT0xACjws+d3HyYtTn/iZE0q2Y3Mvmv2Bh4/0MAQpM22GKH?=
 =?us-ascii?Q?Ksn79ertBKaWXcwgC0GaxlV7O4hMgjrllL7dL7ScZXx3V5R4+BJ4x8Jsez9A?=
 =?us-ascii?Q?K2lMKVLbOgVTP7Nphdm6e6xSiio7zhY6SkJNPCDGE6eJc2o4B3i8S7ePwyvs?=
 =?us-ascii?Q?ROJZw/cDIbZ25Q2Z2yey+eKZ+zol1iRetMdmyFHTiWk35NPlzdamuTfNor3R?=
 =?us-ascii?Q?ANioKM2TdDDBVwjz0fZvqiWOsGA6owoYxv+RkuZuvxhPGoE4ZekIs4sWrZTQ?=
 =?us-ascii?Q?n/XLPzGnRj8YgpPUP9hgvVpsfhT8V1rbnaauXklz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ca2325-0ccf-4e10-3dfb-08dcc5776d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 02:33:10.3882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Uwby5mIQWmx5tjvms0HT+HUK0GG0mOg0qvz8JlYnyob1Sj0fH7PHNq6qKvXWhiy6fBOIrVASX4YYbYeMi6myw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7149

> From: Calvin Owens <calvin@wbinvd.org>
> Sent: Monday, August 26, 2024 4:38 AM
> To: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; kvalo@kernel.org; johannes@sipsolutions.net=
;
> briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; kernel@pengutronix.de; calvin@wbinvd.org
> Subject: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to supp=
ort
> iw61x
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Thursday 08/22 at 14:56 +0200, Sascha Hauer wrote:
> > On Fri, Aug 09, 2024 at 05:44:50PM +0800, David Lin wrote:
> > > This series adds support for IW61x which is a new family of 2.4/5
> > > GHz dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and
> > > 15.4 tri-radio single chip by NXP. These devices support 20/40/80MHz
> > > single spatial stream in both STA and AP mode. Communication to the
> > > IW61x is done via SDIO interface
> > >
> > > This driver is a derivative of existing Mwifiex [1] and based on
> > > similar full-MAC architecture [2]. It has been tested with i.MX8M
> > > Mini evaluation kits in both AP and STA mode.
> > >
> > > All code passes sparse and checkpatch
> > >
> > > Data sheet (require registration):
> > > https://ww/
> > > w.nxp.com%2Fproducts%2Fwireless-connectivity%2Fwi-fi-plus-bluetooth-
> > >
> &data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7Cff25728795724a618a5208dcc5
> 45c
> > >
> 5fd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63860215067862
> 3224%
> > >
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6
> > >
> Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DU0Cej8ysBD%2Fg1Sa4Ia
> Ph63Ot
> > > iTcemadiCfMINYM%2BRL4%3D&reserved=3D0
> > > plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetoot
> > > h-5-
> > > 4-plus-802-15-4-tri-radio-solution:IW612
> > >
> > > Known gaps to be addressed in the following patches,
> > >   - Enable 11ax capabilities. This initial patch support up to 11ac.
> > >   - Support DFS channel. This initial patch doesn't support DFS chann=
el in
> > >     both AP/STA mode.
> > >
> > > This patch is presented as a request for comment with the intention
> > > of being made into a patch after initial feedbacks are addressed
> > >
> > > [1] We had considered adding IW61x to mwifiex driver, however due to
> > >     FW architecture, host command interface and supported features ar=
e
> > >     significantly different, we have to create the new nxpwifi driver=
.
> > >     Subsequent NXP chipsets will be added and sustained in this new
> driver.
> >
> > I added IW61x support to the mwifiex driver and besides the VDLL
> > handling which must be added I didn't notice any differences. There
> > might be other differences, but I doubt that these can't be integrated
> > into the mwifiex driver.
>
> Hi Sascha,
>
> I'd also love to see this patchset, if you're able to share it. I can tes=
t on an
> IW612 if that's helpful at all.
>
> > Honestly I don't think adding a new driver is a good ideai, given how
> > big wifi drivers are and how limited the review bandwidth is.
> >
> > What we'll end up with is that we'll receive the same patches for both
> > drivers, or worse, only for one driver while the other stays unpatched.
>
> I have some concrete experience with "in-tree driver forks" like this:
> a pair of SCSI drivers named mpt2sas and mpt3sas.
>
> The latter was created as a near copy of the former:
>
>
> https://git.kernel/
> .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcom
> mit%2F%3Fid%3Df92363d12359&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7
> Cff25728795724a618a5208dcc545c5fd%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C638602150678637352%7CUnknown%7CTWFpbGZsb3d8eyJW
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> %7C%7C%7C&sdata=3DmzrLLqJNee7vIdV47j8xVSU%2FByjh%2FnNKnRsx1nw3yNo
> %3D&reserved=3D0
>
> The result was *exactly* what you forsee happening here: both drivers wer=
e
> constantly missing fixes from the other, and they were just subtly differ=
ent
> enough that it wasn't simple to "port" patches from one to the other. It =
was a
> frustrating experience for everybody involved. I think their git historie=
s prove
> your point, I'd encourage everyone with a horse in this race to take a lo=
ok at
> them.
>
> It took three years to finally unify them:
>
>
> https://git.kernel/
> .org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcom
> mit%2F%3Fid%3Dc84b06a48c4d&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7
> Cff25728795724a618a5208dcc545c5fd%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C638602150678649431%7CUnknown%7CTWFpbGZsb3d8eyJW
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> %7C%7C%7C&sdata=3DUGjDfngO1POWuydIfmOL%2BR%2BqJ1BoDQW6NboQUV
> q2Xh8%3D&reserved=3D0
>
> I doubt anyone would disagree that wifi drivers are much more complex tha=
n
> SCSI drivers. It would be strictly *worse* here, and the path to unifying=
 them
> strictly longer.
>
> Thanks,
> Calvin
>

I think Nxpwifi will support NXP new WiFi chips and Mwifiex will support ex=
isted NXP WiFi chips.

David

