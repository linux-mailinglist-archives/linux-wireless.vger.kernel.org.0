Return-Path: <linux-wireless+bounces-12319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE3967FC0
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE79F284725
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6554B154BEA;
	Mon,  2 Sep 2024 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F9jKe/IV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13320F4FA;
	Mon,  2 Sep 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260053; cv=fail; b=iSQ/cj3Comx9eqLQD1ocm8RTyydsxF2NA8ia1reIwMAmQtmAI4WzORqX6iUzRvOHj/o8/kM3Z5ExMlKga09c+VxxiC6rjoRJddkPj49RVRKJLLdCWw2V2kz5VTyNU+DgVUjgSVA7TV40A1DDn92zHO5bgVxSz0HRoj23L7lWfwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260053; c=relaxed/simple;
	bh=JA5ziYjgyiH8w5G4DuT7k3iXC2rT4aZPg1+pIkH8s5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uKBKdcwTTAt5+Ow1crfQngwJGO4smDSRo7x0w2C6X0Wyu/pr8/r/vgwuB/1Apeks5dZV8fXg5zNxNQ3Oog0vnBqPYx52cssSCqioBMLAHIvpaPYdJK8kJsYcuvKzDdEO8Rqqm140hV5A2vTl+ws87kKFFrF5kjeKElL7xLrqBNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F9jKe/IV; arc=fail smtp.client-ip=40.107.104.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEPeUE+N3fKPW4l4pBpWRrZDN60suAGFE3DgZ4xScBJp/cFFhSXJEMBq5bBOgH5/+9QVHRUomf+Kgv3/BzcWSQFX4RZwZmM7IKNKc1GgnnUlYix2bFat5a/hgYg8MdXSc0IRZg8jZWR5RAo6hJGvcv0XW5knY7AYhyHwSt/k8ozbXlQ+/m/9zU2V534DtWFnXFDO5jAbbgHjGCxA5kohdZbzFbPljG+Z2kaaE6BzUIiwhMeE1EQxRiryVKIIZuFVPJGpa88QN2QBCf/AApJQmplJ3SSUiZTKpNA9nPn25VMiZJJGDC8bLGMpkMX68RXyIfj7sigvY/pKcSNo3Nkgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecmo6KDkCa1E5rQBdlgSazJj+tqQrHBDHM1Jwd+16r4=;
 b=I0eWkMnUhxKBgC1eD6P1k3AM4aS7ryFSDUswfuWmu3Q1nxtncx6I7DMwJVNjCZcyvBfXnq/GY2fmPeYOfUbtNYWvt9KaTzmuTYvw+y/Cu00XWwWK3w4eZo3x0mdy3waCQo1NkqN6qcvG+qx73wKA7xn4M4cjQCWA/pFrVJD5VZhMFi783M1q0JsfqPR0pjgtBrHKQCKtnPH6ctD8CU7JTTIhGPXYMjh/RdZo9slrgkKy5DA7b76s7n+hBSjNEdXD9LArE7AnHYCvPUZ0LYAxkX21Um05tjMUgpck1F6HeYcHQMzawjvfG3Q4EsnP4bwEmcviIaEVZb4kACai/uVrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecmo6KDkCa1E5rQBdlgSazJj+tqQrHBDHM1Jwd+16r4=;
 b=F9jKe/IVjhpN0Vt9OtD5wc8KOe49wUriwrg3ZbvYgOv6cZPqcegqiXiHXotUM84X1Gu+LQNtvtn+SceOIHcHgT7khKE54mpJXmC90N9qn3Ls10qbU4jQF4RaeznldK0/KkP+NKpPtB4dbZTdJM6UGbN84kPag3zFr1MN81g0ipiI48p1D/YL+kdjvWRPjha4rwooS2RzAG/Zg3rlDWW2i64Tk9P4bmYyPTjsnffA5k14672mZRYNNHxy9yl+93ZTz/Ls5IoKXjpjRkQhUMh7X3t7yhq66HRx5v3/bMkp2TkIpbYh79QMclWQWRQXiyZMWz7c5eVje9dQWBggvu0fPg==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PR3PR04MB7371.eurprd04.prod.outlook.com (2603:10a6:102:87::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:54:08 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 06:54:08 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Francesco Dolcini <francesco@dolcini.it>, Calvin Owens
	<calvin@wbinvd.org>, Brian Norris <briannorris@chromium.org>, Kalle Valo
	<kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Thread-Topic: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Thread-Index: AQHa94lYwasmKIL7I0OVdvDE0AaRyrJDyhdAgABM2ICAAAJRsA==
Date: Mon, 2 Sep 2024 06:54:07 +0000
Message-ID:
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
 <PA4PR04MB9638016F363BFF87D62B70D1D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVd3__wfm6EOOgH@pengutronix.de>
In-Reply-To: <ZtVd3__wfm6EOOgH@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PR3PR04MB7371:EE_
x-ms-office365-filtering-correlation-id: db8d8f85-209d-4500-497f-08dccb1c0ad2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ql80dIJ6TPSjjaEX1+qVdFP5TiF1clZPsITSLwkUMNzHj+bi+seONv9AmOwG?=
 =?us-ascii?Q?bqHZG9diIvqvl1s0QiM1STZk8KagxoDJgf4wXLlCQZvTN67+ZhdCExEWF3pw?=
 =?us-ascii?Q?IkYku4DUcyqsjjOU+aoScVRk7Yf6LBJNJ+XiV91AqMJgNZkrsKKv1/jaHVyb?=
 =?us-ascii?Q?Bem2aXaOXKOSLQ9Twqwi1M47tZI/0Ixpt6aMKBCRQ0qPuJxt0jVyRwag0XGd?=
 =?us-ascii?Q?Ui/fDSlz07p+MTjIFmN1Hd6qW/aXtacFeWkdqYXJp/rDWux8teC1lPLFFbeA?=
 =?us-ascii?Q?Tjp8ts+7/Qua3D5LB8lS/uxZvklCgU1ZaC/5booGmhaqdsovehP8Pg/f5wgx?=
 =?us-ascii?Q?CAAnCH0gmjQWPgHbcIl0bz2q9CSsj+1xzqVbBbjr93ktdLSh6Seco7+iyGIV?=
 =?us-ascii?Q?9ChQUD/RoMKgpWnRiFCYCyzi6X5K1CXUN1OZU60KaEDk3naNSLrC1Wzncbcs?=
 =?us-ascii?Q?uxjVkj/Mff/ntsK2Sj/28VAwDADa/0wJp+Dg1CH2Vi5QtuLvjYsvgOciTYD9?=
 =?us-ascii?Q?DaWu+6S8c+0m7jQovp78OcYw2qYLmkquIXAhGSDhDYabYw4RJN9WjIDtBKbC?=
 =?us-ascii?Q?1+XQZEIGfghqNYrfWwU8Zb+nChwGkdlxjFepvG4m49TXxuJNnGVxV3uR7Cwj?=
 =?us-ascii?Q?lNO5LaJ8TnPflptqT24WByYr1ZKfIv0AGj5kwObTF8x6y0qkVhzCPDgo8CLF?=
 =?us-ascii?Q?qzb/OCz4cJ5YBbnNQVdZCcLs6RA/nlyy6WriRJkD2fyCEJamvODQgaCvGzJ7?=
 =?us-ascii?Q?AZCvejITbgnL65Uh80eCpKaju+UXgqQwp1a/wHHuqFwPvpK3YQAtzlSOpINf?=
 =?us-ascii?Q?wgiCoSleXq9hldFnJ2L23U/ANQNXXN+c6Phk5vXmvWoq/aD2CAj5zk5xXpnu?=
 =?us-ascii?Q?x1uofpxp3iU8bxbko/Kaj8Evut+F6GuDqobVP3LOXrRCiRq/wJy72EvgIGgT?=
 =?us-ascii?Q?NQhB7I/8fltRAXD9K622sBXlbKg4Ze4b0PiWa/lBwAakqOM/6GJBt9Fb7RqC?=
 =?us-ascii?Q?gAf+dDHPqg3F594s7nEwJGuXjr8CGawlEStP26Y/bwdr3glbxBkmebxXKnw9?=
 =?us-ascii?Q?Z9U13FK1rf5yLRvmuF8b7LUuOp6PHKXOUhH9sryccNNU3f0pbpmt0Ik53754?=
 =?us-ascii?Q?zC2zNXbNkmoaxP45gE6qmAU9rysZGm6wL/VqctpusAr8QpAu2DUEiAK2craT?=
 =?us-ascii?Q?7TJw6dlLeAne3sB2ZpkQxj2h/KOzmbTKZTJltOXxT3wgBpAPzvf82sC/EfAa?=
 =?us-ascii?Q?SQ6S8JKvpUL2rG9ejPEnnufjfboGT5cskJvrjOwNqWXSl/BcHRSB8slwOipx?=
 =?us-ascii?Q?vkzmeoGw+AK4TpwzFLqeaQe9aYaKHWPIE06/GYQnRZvm/4ukhcdYEf+NvbbT?=
 =?us-ascii?Q?s56FlCM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ETAbDRGcoXNSZHWwQX51NfLd3/0WvOerwZ8AIR9MUzyPWA34RWygb5vPchoD?=
 =?us-ascii?Q?j3aMO277RuvBfIIxxuernIH7fVseO9YuHDJqSp9CJij8XvAgfPilnvp4iBV+?=
 =?us-ascii?Q?cPmIrM3W4fpi5DbowZlumf4FUR/tmdtcGZRUFkHNvtpQ5A9JG0Q/nsupuKzp?=
 =?us-ascii?Q?r2IJ/V7+106gN5yVlAaHE/cpBjlRivALzVE1bBD+OnJj8rHcCregUgArWwp5?=
 =?us-ascii?Q?DqKBiwMRZttZWQtglvD55KOFzCI11EwEEgfYSSMVLu6srdP2vXzrz1dRaaF2?=
 =?us-ascii?Q?7houZEmsJ8T/UXnD1HegNTHSFGq9hM+JdqjlgccZp2bOBkWxuygtg2mVjo45?=
 =?us-ascii?Q?aOX512Fx8Nm7KdF9sqCtHDw4azB9a/Ci4C/SDRNsBuWmEsjPGJy26q/Bg2sS?=
 =?us-ascii?Q?0A1IWUBWVCcaOdgDaGGGMqwBLqWI7npuBjDLM7nmC1r+QCSG5F0CTDYSVbe4?=
 =?us-ascii?Q?UbFMuEINzrzNi+61POINvlY2kJDM4x8MgPj/HQZiqaupYIAFY7gNweN0vEHA?=
 =?us-ascii?Q?NKDzhfpktq+nZk7xYaoGfTIiyeOmuGCC9lBjh4Bh/Gd93dilz894oS7mFhav?=
 =?us-ascii?Q?iGlmiEvv1iuu+nimdzm/xWC9Va3wP2r/2iPboDR1h6ShNMYmCrVLZ/5A/VuQ?=
 =?us-ascii?Q?hvhZOaevM9ERZkYLtBd/lS+EMsxW5hbWW1j2xfP6EjxalonFKy73lNBFvB3A?=
 =?us-ascii?Q?4Z4+ulqR7nydG4QuW5HknGVoEJ6DNupiws1mLKRIW7aA8/NLH++K0hcSOL6e?=
 =?us-ascii?Q?5q3BNyQ3FqizYPEwgSSLGciaUA3DgEmkso6PPlRDNIn76cSL9+ab0uHpqNzo?=
 =?us-ascii?Q?aPDepdrGuFYuGFwwWU9SjO39MYrb6yp7kvYwZC0L9pnwRJYOuyGC6M/c2rPJ?=
 =?us-ascii?Q?0kBh2Ftis0mJrkjQUXF+4824JN5YrkWnlGxNQEx+Pl/PqBNp18dMoUpXrxNQ?=
 =?us-ascii?Q?hSM9CiGuuB8HCG6c3DrJmi18/w4pU8uOzRfBI1Zozmn9K1u6QOYff5GgfRVp?=
 =?us-ascii?Q?D8oO2e8NAdioA8H47Zb4I3uHsnEqhFvTPIkOOZRs2LBOXUtlfZPqntIF9Zjd?=
 =?us-ascii?Q?GBPaAqItR3Ox1Dgglpva5xJHq7KnssmOfEBNiwnodExQe1JI3PhXUOGirFRh?=
 =?us-ascii?Q?AInKjaCkEXdAClkXl/vaI5xT1bGCvR8pNUaZjA0H8nAS6xEJMlKo5igis52A?=
 =?us-ascii?Q?ngPOVj4gIXfBIdjYp9CjoR7leeJyCqosztr1QNftq4SgU1kWZbQstA821Ume?=
 =?us-ascii?Q?NP2jlKWDry6IzTk9fsW18EvZUXMpVwNNgp1+jb877VMXlYypqHfR4qqhXHvF?=
 =?us-ascii?Q?9Qy6L0rwHLlnsOORWmzg7alu1dGP9OG2PyAO/oygRJymRt84UOxrZW69/rMC?=
 =?us-ascii?Q?RgMolNRbdJRfsPziw+HO8CI+M5MTfcXvtCO2vXDJGeMU0tQQ7+j/LSxhQXX3?=
 =?us-ascii?Q?29yvRM+IFnwKOs0FSIChro0TSaSP0mlcNABI4gaFNIKm1eoPLnnEwAPF7mCP?=
 =?us-ascii?Q?GTNdC1eplPZeqHziTgOQ6QuClKFlatjnMovTI1uOzhTnB/WkFosgdCeKqmjK?=
 =?us-ascii?Q?I4UjswOrk2VuvULeRsCtuWPEatoz5z6raDDJRr7M?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db8d8f85-209d-4500-497f-08dccb1c0ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 06:54:08.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ne6q6MErzJbPMtCv4LFIN5P/xH2yT9SWn/qNTfLex/rgFTwy40+xTvnxrT0sWqXQSxzm9TzIuc+kUjW2srs4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7371

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, September 2, 2024 2:41 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle Valo
> <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Mon, Sep 02, 2024 at 02:24:53AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Monday, August 26, 2024 3:27 PM
> > > To: Francesco Dolcini <francesco@dolcini.it>
> > > Cc: Calvin Owens <calvin@wbinvd.org>; Brian Norris
> > > <briannorris@chromium.org>; Kalle Valo <kvalo@kernel.org>; David Lin
> > > <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; kernel@pengutronix.de; Sascha Hauer
> > > <s.hauer@pengutronix.de>
> > > Subject: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > This series adds support for the iw61x chips to the mwifiex driver.
> > > There are a few things to address, hence the RFC status. See the
> > > commit messages for details. The series is based on wireless-next/mai=
n.
> > >
> > > I am sending this now since people requested it here [1], but as
> > > it's out now feel free to leave your comments to the issues
> > > mentioned (or others I haven't mentioned ;)
> > >
> > > [1]
> > > https://lo/
> > >
> re.kern%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C6125c51da3704fe10
> a5
> > >
> a08dccb1a24ef%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> 08560
> > >
> 383160951%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> 2luMz
> > >
> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DjfQ6FQimPpwr
> nwUo
> > > OCEhmpSadtrb15ymGiif%2B1UCdG0%3D&reserved=3D0
> > >
> el.org%2Fall%2F20240809094533.1660-1-yu-hao.lin%40nxp.com%2F&data=3D05
> > >
> %7C02%7Cyu-hao.lin%40nxp.com%7C184ab4fed58647150f8508dcc5a0789a%7
> > >
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638602540229716119%
> > >
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> > >
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DcACBHxaQvcOqu6ri
> > > BoAlZDONRlGQ4j5DcglEV9T%2BpYU%3D&reserved=3D0
> > >
> > > Sascha
> > >
> > >
> > > Sascha Hauer (4):
> > >   wifi: mwifiex: release firmware at remove time
> > >   wifi: mwifiex: handle VDLL
> > >   wifi: mwifiex: wait longer for SDIO card status
> > >   mwifiex: add iw61x support
> > >
> > >  drivers/net/wireless/marvell/mwifiex/cmdevt.c | 86
> +++++++++++++++++++
> > >  drivers/net/wireless/marvell/mwifiex/fw.h     | 16 ++++
> > >  drivers/net/wireless/marvell/mwifiex/main.c   |  9 +-
> > >  drivers/net/wireless/marvell/mwifiex/main.h   |  4 +
> > >  drivers/net/wireless/marvell/mwifiex/sdio.c   | 81 ++++++++++++++++-
> > >  drivers/net/wireless/marvell/mwifiex/sdio.h   |  3 +
> > >  .../net/wireless/marvell/mwifiex/sta_event.c  |  4
> > > +  .../net/wireless/marvell/mwifiex/uap_event.c  |  4 +
> > >  include/linux/mmc/sdio_ids.h                  |  3 +
> > >  9 files changed, 205 insertions(+), 5 deletions(-)
> > >
> > > --
> > > 2.39.2
> >
> > I think you ported VDLL related code from nxpwifi and you also traced
> > our private/downstream MXM driver.
>
> I ported it from this repository:
>
> https://github.co/
> m%2Fnxp-imx%2Fmwifiex-iw612.git&data=3D05%7C02%7Cyu-hao.lin%40nxp.co
> m%7C6125c51da3704fe10a5a08dccb1a24ef%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C638608560383172495%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C0%7C%7C%7C&sdata=3D5TgI0r4u2I9Pi1FATJx32Ubn7ufmbYsBR1XkpQLAIyQ
> %3D&reserved=3D0
>
> Is that the one you are referring to as MXM driver?
>

Yes.

> > If this is the case, I think you should know nxpwifi already cleaned
> > up the porting VDLL code from MXM driver.
> > I check your patch quickly. You ported the new SDIO data type
> > (MWIFIEX_TYPE_VDLL) from nxpwifi, but you did not port the code to
> > support this new data type from nxpwifi. In other word, you did not
> > test your patch before submission (same as some of your patches).
>
> I did test it. It works with the iw61x as well as older chips. There are =
likely
> details I haven't tested, but it generally works. If there are details I =
should test
> additionally please let me know.
>
> >
> > Another thing is that this new SDIO data type should be handled
> > carefully with other existed SDIO data type.
> >
> > Nxpwifi only supports new SDIO mode, so the modification to support
> > NXPWIFI_TYPE_VDLL can be clean and simple. If you want to port the
> > code to Mwifiex, there is no one-to-one modification of the code.
> >
> > Another important thing is that you should consider if your
> > modifications will affect existed devices or not.
> > You need to check if you should check firmware version or chip type
> > before adding some code.
>
> The VDLL code I added for the iw61x only reacts to the EVENT_VDLL_IND
> event. So as long as a firmware doesn't send such an event nothing is cha=
nged
> with this patch, and I haven't seen an older chip sending a VDLL event.
>

How about IW61x? As I mentioned before, if you test IW61x on DFS channel, c=
ommand timeout will happen.
Without correct VDLL porting, you will encounter command timeout in some ot=
her test cases. But testing
on DFS channel will be easier to reproduce the issue.

BTW, it is not a trivial job to port the support of VDLL data path from MXM=
 driver to Mwifiex.

David

