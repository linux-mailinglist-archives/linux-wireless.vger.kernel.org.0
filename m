Return-Path: <linux-wireless+bounces-12716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1389726BA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 03:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C7F1F2435C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 01:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83FB7E575;
	Tue, 10 Sep 2024 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZALJEuBl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8311B42AA4;
	Tue, 10 Sep 2024 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725933129; cv=fail; b=Uv7wsSSVMBSAf9J543PeMH4hnvHucyKHJDLVnPKeZpqR84AeDNpVH8hmCNnj6RkVxlY0A/0OyauDcoy1YbqRr0pszwqEphloheom1DZooTIbhM9tgmLPq11ybt1o4+ZpjaU49xyz6nYKRt2vDX0MmtgDVmajkrJl5m16rUQGo5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725933129; c=relaxed/simple;
	bh=5zRH/1eEBKfvhLXrGKbzBXHW4gLnn5fCHE1zWdRrQEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FT/aKhHRbLEOyMwBYj9AQkKJdwGPvl0Hs1ED37M6fMEezQJouvT1vmM2jXuaG0HByHgCJWH/2cB/qAYSr0BHNqkiqIBbwkLnvMmjzpmJJLW/OYzNqQ2OkkVq9+Kn5eq4gCkH2rCrOFjLfBVFOS8OMSC6ruT8ZhmjT2fEAvLEX9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZALJEuBl; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdmWhgxoUsl5vijQD3gZde1BYJYgWgOZbdDZQCUwEF7jtGe2Z/d2RqVo7IMDG1WmC2IZFWcaa7RdMkfh6usIMmB5YrjhAJWwr6atMccS4CI515nRIZJAgAaGRv2A18AY5J1lCd4XKK1LE0YW56CLA4pXi1ERAHS0bWC/EehoNdkeFuBOIOzi1zYozSFVayPjqQtgnPPLCd3o1LB8aZBH4naY17FTxfwYGtjRQKIEuk89FLtxp5caBqsmJoFtEdKdJp0yK4rFbI1Z1qkKnzmPYVS2CL4d2MP0JctiC+o4PBVD7XDaqWfgcOz8uibZ3UBUcphoHGB5VvWu21CN1R+49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBxjOxeYTvpo40QGXxKGdU8ZqVNL2EI1+UR57CVNYuw=;
 b=I9BWaP14vE3lqLWAuwSOsyKtBewM+qEDMOV8r5tc9CK6jbQZK+ryKri8vzOS6d3dItTpyOC8AAjtK2bEIQ+Ze0HMZvsGVF95Cz4P56t0Ag8DPrNK0isYoKozhWVPcJfK6MdJ8v4wWFXViO9b0AaEjkAxCh9PIlKFSVInh7azoeQgDXHooQ/yS1DD95piO3oWTVyT0paEl9VH0Q3NCZig/GS+GWxmvjFWXZJxMFYVT3Pf2ryHvdGddeyGP5lGJ3PGHDVT06cScUZ0jEFO9qCKbOhSm4cir0/nJkRB4lK4If2rVld2XVQ8rdnfXQBcs/RwhdxTb2EG+GuHbP1s2zvhwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBxjOxeYTvpo40QGXxKGdU8ZqVNL2EI1+UR57CVNYuw=;
 b=ZALJEuBlmQRbFRgpTIpVtMsTYq9HQkS0J+sOie3xPtYmAEftvUo6JMhrWmT1+Q4ABk+Q2RLEQGifnP8DTJ1knVbMmCzkxwFC1aFZdi1OoopLlde9UsOF4UQohkyb13DLP35BtYJdLeDitof/cVxM4DHqr1wLzng/yrEnyhww32xZ4jd9OANtc1hkHKcZPxXIgjiPo9w8MWYY7gJASYCsBUEInEBxiuyOrq2AWtO8xqcyxP+U5Qu2Zt+WUCyXI6h9hwAPB8jZ6xSdpTpAWkfD6+voIijcBbBmeHuhL5sxP6zm4AwPqix0QfjVX6CqGyj4lcKo5CFGbmTrlZCB1mKLuw==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB8PR04MB7034.eurprd04.prod.outlook.com (2603:10a6:10:128::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 01:52:03 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 01:52:02 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Topic: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Index: AQHa/RQwZkxE7S8BN0ebi7x6fu8g/rJP/dMAgABP2xA=
Date: Tue, 10 Sep 2024 01:52:02 +0000
Message-ID:
 <PA4PR04MB9638EA984DB5F2FDAEA3B873D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <Zt9jFpyptX_ftH-p@pengutronix.de>
In-Reply-To: <Zt9jFpyptX_ftH-p@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DB8PR04MB7034:EE_
x-ms-office365-filtering-correlation-id: add141e5-9b92-4c55-558e-08dcd13b2aa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yvZay8bFk3yRve0XhW5DALAS+Ha6axj262ayDAg2ICreipe2P5dFOocKbm7m?=
 =?us-ascii?Q?EVegASXfyCBdmLrxcq1cz3BY6u1hn41m4bohjkDoDhk5hmBL9W1WSgnHJcNS?=
 =?us-ascii?Q?PGOgnnTCUvyKC2HtWtolQFTWT6+mdozPR47VZ8EF9Bi6L/04ZKfdrFRAb9oO?=
 =?us-ascii?Q?GMe5XQEn+ohAhKuz720J4XjCSIFWOckk375HPRx4PqD0pcuik6aodDTDhs8x?=
 =?us-ascii?Q?pxOee+9s0fV6uU7qqZqP1dkAWEvQvUlEfSeOvDVjtpCnfy2bZcEto9/NFukR?=
 =?us-ascii?Q?jrfnYfJeL/bnroTzfBwNFefTvhzuGRs66onKPHD+ZHYDOiN2yk8qmoZ0HUNR?=
 =?us-ascii?Q?ZqInEOqz7rzt+dhFhv863BZXX3h6qQu0xNqKmIeeviALwGTjCJMN7Eja029q?=
 =?us-ascii?Q?bk/novObxP836FVUYBYk6I3QUHUBqd/4dtInndmz5a61gNAfdH0+d13+mJzx?=
 =?us-ascii?Q?pe3AgDjzjqJuduiiscXStQIR799aK6vNOmSNHhcs1/hG28t6Kd2/R3XvF94C?=
 =?us-ascii?Q?BQpbSZ4Ym5H0fNP7IcDxhWpsr8ThW7FKtjyorXbirKpDRucXkqcrO9+g8rM2?=
 =?us-ascii?Q?URENMnRkWRQ/lARlcQZT4hLn4omk6PeECQS3E4AL5u0wxJ6bVRfM/bCnMztw?=
 =?us-ascii?Q?RisXuUUKUHdCkL6AvDCZs3/IZlTk8HErWf13caJY9nPoksNONBt7F0Wra5nw?=
 =?us-ascii?Q?uTkQMkh499S5xvoMp8vTEOQhCfYoCeUnn8jx18w23qsVUxWsrG3+er3iSxAi?=
 =?us-ascii?Q?6hVwXrHZ6Yek7k+yBS4nttq/eIUEy1hU9qLf5LRqggrnMoepyqD4Eu0Yugtf?=
 =?us-ascii?Q?r2S1MxbjehBwXrILlwOlAS4h+8lNz6GvVVXihzhm1lbq1V5u0h2YvHfV6r64?=
 =?us-ascii?Q?Y+SXMazkq7KH5pPAwbgx3FHqX81cwQEVXyANY7OQHGMValAJz3tlR8sv4CQR?=
 =?us-ascii?Q?HzGp6kCaMYgsmjoGK62/xxY3IWPjzhfhCBvHiyIq8AnYkAQ1nDTUWFQ9Jd5X?=
 =?us-ascii?Q?+GW6GfO2ATTIosjPR84CUhWX88aQFYuqIGfNlgtITL3XW4LWp079B4tP3eEB?=
 =?us-ascii?Q?gtMQ4dobvGiakg6j9mQnjhaFiafFeg0uLGiwNul7avwcrU6OV3jUFfwNbJ3P?=
 =?us-ascii?Q?hJpVc8Z4Y+hBFugIvdPYPT40gp+ERePpKTKzlB/izsI8OuEtUMqA9zck3vtc?=
 =?us-ascii?Q?D050EtiSMUDlaLJJ3/EqkyplHR3+5a7cjBNC+hV+K1DCie8u+tUiwHn7u+Ir?=
 =?us-ascii?Q?PGYccO5zYq8v+g3e4XbrRKK5p2+i7R5WtmuQ846cLFDJURuWQmy9pzxnFAPu?=
 =?us-ascii?Q?WYcDYw1ZDqc/gpGpk4pStBIKM92LxYEN7xYTikxKKFGAZgKvUVmYabcIg4+W?=
 =?us-ascii?Q?Hu14yraGt3EA/pGUgbWIwxCNp1gVArAM9xViRmcjWETMwCubdw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NPAQrXtHOzMXrsY9HEQ2qb1npzuOlLMviaFJy/PA7Aq+jOfbxtE0bvqKdbma?=
 =?us-ascii?Q?kX+sAYFZ35q3l+BtfV34FdfMN2j48fu3vXD4QVMNjwzFyTut6CW58ZUTvEpu?=
 =?us-ascii?Q?mZrkXvSKvrdBg7Gi4IsUlftnD0k2EICN5Pp/kwDdipuJCE8TdoTojzT0H68L?=
 =?us-ascii?Q?LW+hHoh/K6AHnolOCwjM8cFMKKQQ9Hl9xdhAsn8RvrHL4szb0q+vjfFLrKl2?=
 =?us-ascii?Q?6wZfhKGf+bUsb94VXRHVy+KNebM2WWCo6oUzsvfX/x0Z3UiZXCoEbVTLTEoa?=
 =?us-ascii?Q?2C8ooxwKm4n1Vlwo6frkU7jwoUk+vvT+YF/cpiqoM82dnKaFrtugZrVZokuh?=
 =?us-ascii?Q?vRXNWfoXwMNxcbnT4Wt9wqCbcpAjZEqZNk+0YtuwL2LMDpJq1tK/nkNwP5DF?=
 =?us-ascii?Q?zyBygGHcZfb6PNAGLZQQkPanC/B0rT0nRFoT8X//cVEobW03ADVO/Ain5Xfz?=
 =?us-ascii?Q?fZubcGeBbNtjrj2REettkfLj/0I5XvU48Wm+vQ7ligK8C3zsfcRqJE01Q4jT?=
 =?us-ascii?Q?uLcsZYo2QZEPdiuJvW8scyGHuqwZVb3M1P4wyFPtOfX4KZRdrVcHZD5yQIfG?=
 =?us-ascii?Q?TROouukaH0yc2hoo2IYDHuE+ovXOpSZdA6zUb1NFKx/jRLwRwOB6RuPgqTMa?=
 =?us-ascii?Q?qq6a4wanDv+ajokqLivgcJdSUucVxxaZ3LO/I3SWFTXza863wTWPIYoqGLJF?=
 =?us-ascii?Q?t0MGH8h0okYaszZR+eOgNG+/26tFu5yh/OvgFGV+iHP7uOlvhc1ffOShsAGa?=
 =?us-ascii?Q?R6EJHIw65pTty9+pjzZuamdyQjxw5t9dZ8f5l6mHyzJMCaGiX2n1lluq9XhU?=
 =?us-ascii?Q?zIg26Qkmv20qBHTp6x/qtcZHr69GLozmSlo/Nh5WwRyCTHpPbZofLT8aeDwl?=
 =?us-ascii?Q?dSMjuVrbXX0KT4tf/q6BS2mdsfmfk9GZvYzCKAwGd+NTJWLmtoH6YcalAS9P?=
 =?us-ascii?Q?3Tq/VfhUzPdXg5fPGIfw7RswQW9MRw+xDMuy/aKUpuD5NQWAmKvoqlg2gdYk?=
 =?us-ascii?Q?R3xXm8F8L6xY0lYCvm500IyyOD1FP5tNR02rwlerEZFxn8YoexpU58hlk6Rt?=
 =?us-ascii?Q?Hvrgg6I/mPsOb9/wKMQ6lNpQEumQR5hJur9mNN1vSk3Nm2yPUduEp87/ohzR?=
 =?us-ascii?Q?DYKUlt7hBDXT9TaXQ+k14uksjIe+u4/m1lwcJyaBeCRpnidGF82h5pjGWJx5?=
 =?us-ascii?Q?F0prtxR+w+ZgX8lIXMBq7Bmruimef93WFnybhoiXQ5YmPEfgbI/5cqrkpMYP?=
 =?us-ascii?Q?sYRX+SJ07Yps2v+W/NGJngzv+c/XRwXoVOq6MtTT0Q2mv5MPYtsPR68iErtI?=
 =?us-ascii?Q?hKqnyEvHdLzkHqs5s/js9XgWxFOdDeStYpQ//QPt9VCpmr6NpopEc/fd9rqu?=
 =?us-ascii?Q?CUyXI0czHPz5jzcvVqg55Efcw2610Eoe7zOMaj1tAE0i4mAwvPIBpEp25idX?=
 =?us-ascii?Q?uZjJY8/LyEvTgkvaGqANC7NUry/uRvBtN0EgY5blLwT7lxaHVjDC57PlnY+0?=
 =?us-ascii?Q?vimq5NJy4n+1jc63u2yBAInIXU+BUbsx9Nl8x/RaLztWtCPqs4gQjIbtuPTp?=
 =?us-ascii?Q?c/FamwfhHLc9SS+TsTbCqwZUQHxxDH2Tt9TTYeF/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: add141e5-9b92-4c55-558e-08dcd13b2aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 01:52:02.8143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFDkajcAjYb+83MboG3qp2ngnLat4o8XtGkbaheVdw0qO4TK+oI/pEG5wUA/QYK1XGMDzfmzXEd6ya9JY4SSHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7034

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 10, 2024 5:05 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on
> different channel
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > Current firmware doesn't support AP and STA running on different
> > channels simultaneously.
> > FW crash would occur in such case.
> > This patch avoids the issue by disabling AP and STA to run on
> > different channels.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > ---
> >
> > v2:
> >    - clean up code.
> >
> > ---
> >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 17 ++++---
> >  drivers/net/wireless/marvell/mwifiex/util.c   | 44 +++++++++++++++++++
> >  drivers/net/wireless/marvell/mwifiex/util.h   | 13 ++++++
> >  3 files changed, 69 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > index 722ead51e912..3dbcab463445 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > @@ -781,11 +781,9 @@ mwifiex_cfg80211_set_wiphy_params(struct wiphy
> *wiphy, u32 changed)
> >               break;
> >
> >       case MWIFIEX_BSS_ROLE_STA:
> > -             if (priv->media_connected) {
> > -                     mwifiex_dbg(adapter, ERROR,
> > -                                 "cannot change wiphy params
> when connected");
> > -                     return -EINVAL;
> > -             }
> > +             if (priv->media_connected)
> > +                     break;
>=20
> This hunk seems unrelated to this patch. If this is needed then it deserv=
es an
> extra patch along with an explanation why this is necessary.
>=20
> Sascha
>=20

Without this hunk, AP and STA can't run on the same channel if some wiphy p=
arameters are setting.

David

