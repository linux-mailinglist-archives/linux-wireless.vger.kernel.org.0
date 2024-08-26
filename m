Return-Path: <linux-wireless+bounces-11960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E31295EDA6
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BFB1C21186
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4396145FE8;
	Mon, 26 Aug 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fr5NSJyM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D529A2;
	Mon, 26 Aug 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665724; cv=fail; b=tT2dvmRHK7pQsvxmuRsP2BpR5i/RpIZBEyUzKtUl6hg/EZfsB7gc02OKHOMaERHOV5DNAIs0zvmgsHQNLhI5rKjptFDpVANMZQylCwX0Y2pgF4oDAs2ez35zmyBG2JBGmnjJvIxDwPhZvTOekA3gcQ2YyhrhyhoZ5ILhlg3Xbrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665724; c=relaxed/simple;
	bh=QAmc/5fi61fHJZuuTD1uNEHeJIbqqufJREdBzd7gf8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hxtyFBxvKKQvhyS+sKajDhpevjafAQwAFZZhsSeCdMNu/NuLXmzWYhuHlJlYhc9pqSzExqge+ODlCbYyNeHVFJAlSHVdlpMcczBajLhM+sJK9ies4ruqPRMs+o8pzVJNoT91xFbQ6lgJiRCCH7TgV8JLGu98nYfgbFnleqvbdrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fr5NSJyM; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sclEHpkghsyeRE07n8mz0DRa0qyrU54i2/0vvuPGgL3+Z1qzGTjCN1pm/DgVZurWm1tk5D5wB/QJ6ilzcGGV0+5Z9XvZORfPbICrsstRJNLjXx4FF2vS8pHFsPdWBVOMnzlDvQedk4fbyrESCwyEreiQOp7A0Z16rSXXF/M8GLVVS4Sn1R4HciMXLT3dEJwh0z0K+oto4l5lyI36tg1VveDJnJAW5+Sq5vOcPn7m+K6wuHeyd/eRROt6Y5IyNwPcgxHNpaaNxkEEjbikquhRDA03SdGiEvg0qsmxUf75kkXT6FPUhqlVv3hQsuPJtrxBKWVmr6DK49yvPKoa2NNGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyWzAPSfeLl0UTtU73HOitb2+AkEoa7JCRNBu71Pupc=;
 b=TPDe9NhBuIQNhYAlGFKVk8ZauWOJJVJwdZv4YB/4qN5Bv/mkaM4w6hIVAxvOzsXJeAltDBNHALRJkmyqIwk6bps9+OIJ/d9SHx/qvDDjWDHNOMsaZQiCQ/Dj07w6aDEzs8lCzIz7rXxNhqfAJyKDqtNpRVOMqc8RDGqmoozwOeh4GsC1uc/eNXBlC7ifa8IdcM0jWaEMQp7FCEQNjMHfinD+sp+uyBDgSBIkaPZJCOGVljWUwk4WF7ED6PdfV3rNhS79qNmBBT+5WYm4yxbV9RrBjQDS9RDgXOalgOlyJh0+uQiN/Wr5lMBETa2j1m5QQk9unoVDkD1ptQ3TQhJ9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyWzAPSfeLl0UTtU73HOitb2+AkEoa7JCRNBu71Pupc=;
 b=fr5NSJyMs0xYdN7Rc0814jGbqBhsYWXVGecaJLvt8DeICD1peC7zj03B1oAUltIt09pYy6XjWTZI/2ngmv7GvVMF2jftoT3/0e6BLfALTTdZvuhE8KX8d9dbBjZcvJe0ctIeN021KD20zhJGSb+qarxpaRdU/biPbisByLxzobKfuh42tAOKnKbjQcM9j8XUzyD6opgn9syCssaBOt865/U4ymWf+HfRh7N4/pS+XmO1FZj4R4jv8AmR+Se0qGaLHM+7vz9MK6SVdviwzplQAk21pP/vkSSoOSlaOVARq+xNngBotCV77evM7akSToppqipfi56/SnfJDpT79/IwAw==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8697.eurprd04.prod.outlook.com (2603:10a6:20b:43c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 09:48:38 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 09:48:38 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Brian Norris <briannorris@chromium.org>, Francesco Dolcini
	<francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Thread-Topic: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Thread-Index: AQHa8vjaVhal52qkKUSAi5YxIXRvnLIzBf+wgAZLL4CAAACt8A==
Date: Mon, 26 Aug 2024 09:48:38 +0000
Message-ID:
 <PA4PR04MB96386A441739C4D35683512FD18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
 <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZsxM198_t04j6OMo@pengutronix.de>
In-Reply-To: <ZsxM198_t04j6OMo@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8697:EE_
x-ms-office365-filtering-correlation-id: 4668810d-1c6c-45fd-588e-08dcc5b442b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1a4frMKH/b/Z/myvVBxRzWi8mB+SdNQJsBpJNR0V85wjidt63EmdKHvJ9PSc?=
 =?us-ascii?Q?BXcnpZUFgDj2JoHMKmIHOidfJsVP8O9z68hfD6TZr6kk84CX6MblwO91CoZM?=
 =?us-ascii?Q?vlr3zy7GyxG5BZ4OMgaZRmKYg0Jar0VnAc5A0BulAB+93d/iG1Mcr9p5anOS?=
 =?us-ascii?Q?TSE64x/Y8+Ntzrln2JWK2LHX3p25Tx+R+s+NYAEYf7TfAsFoW5QdUJs/GenY?=
 =?us-ascii?Q?9i+CtUfU2li5K9nWOnm5KbATWfcOrdwGlLTQW4hKuYW41Ns32tgWZD5FQyZT?=
 =?us-ascii?Q?or27W8dhwL0UHN6X1BNPr/6IjmW4NeyaK+tcDCU5LiTwl93Gs5W1RgyTvvPW?=
 =?us-ascii?Q?IBXHfrxUQPR/bE5RD0LyYKo2CImrkVFvD7I9Ayz2kVgDSTDu1QreCqSfLita?=
 =?us-ascii?Q?ppxoTrAoku62LTB6oAMSG5fLWLdIXhbPO0eDWV9xmq8ZAvAGq/aaLJkpIyj9?=
 =?us-ascii?Q?S+kpE09NeXvUZKgLRxiAlXWjL2dvmd4Fi7x2K5R5jIw0M6I5GVD7r/daCNqj?=
 =?us-ascii?Q?4cg/HjXcq4n6qErybk+lRwE+bIr1qZWo2sNT6wbKrfST+ftkKBoqSU3ymTcE?=
 =?us-ascii?Q?CmzxaKkWw65o4Y/xkftM8d9egRoQOfS53My5gYXvDCGVY9nuzyGIf2r8zbOK?=
 =?us-ascii?Q?FDKsF715mtw4b1xsNeBp4dkgczXq9jo3SNKcdT3SPP8vg4HNoW7csDEwGdDP?=
 =?us-ascii?Q?+6dqENW4YnD8fexNOQ8CdsaO3YHLnkt5o4i5vVpFlIEAQVsTNnO+xWejl63c?=
 =?us-ascii?Q?zshko/155zO1C+FqFa4AQfcsAkmmcaUpL+2SjSLV5rivY/z9naJvp6BO1ir+?=
 =?us-ascii?Q?zNaGMRIERWXgc5ENyDbMcaU36hq9GO83420fMaIZeQVBq6fjIt9g72IjEpjv?=
 =?us-ascii?Q?aOTW2sDMjZBGHXWR2LwljdlcaxMO6j6OyxaoWRldmIeft8gc64xHD6d0o00k?=
 =?us-ascii?Q?GvxHRyXf9oxa48vdLL3NQmkaBpfaqd7xVljP4nvLp2YbPLXq45BY3I87VTk2?=
 =?us-ascii?Q?z2ZvcvIG9AnaCSr5dxD98ObCcVUXUL1wjhNpE9W2k/tNhdMafYPBnRN1Zotv?=
 =?us-ascii?Q?4VjFZlqY7l88xfvIUpwhOTj0Ha7RwZaXNljFtp6e+PzXe1FNnZvKSpx0sGS9?=
 =?us-ascii?Q?33Oo7NnbCrV4RMqhRYg0fU4q4EXh/pXqAty61YsIp6k8FEYFPRfOgyHtoONc?=
 =?us-ascii?Q?wpANEWuHqbDl4PGpib4UbwPkNEkgi8uaeQ7aGW+K7+HOSc80Ku7GrbqDmntm?=
 =?us-ascii?Q?wIGCCXFvtshm0MehJ72q2qDdWEklft1j4wHZVHESgJJraoWQxOfmEJy/7j79?=
 =?us-ascii?Q?u0byXnNT/3/ftjP1m0CH3Xi3T5muY52rF7WSXdK4s64xRwfyDe9VXUPCNXLo?=
 =?us-ascii?Q?XfgtU8UuEgZJn4klhDfuNEoHNwqTXK5un8maJSznyoE3IKZS2w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BLvQegQMXVhEpuAhw8K7cSZeojL6WTCEcE/yM+1SZnCYmBdLWgWt+4EOdIu6?=
 =?us-ascii?Q?rAEHfhhvy1HAG7ouRGIUkW5/J08WbnUejwyxUxE/sTW8ROz7jrp1S4QhKKkj?=
 =?us-ascii?Q?SEslKXupgfFhcFVRCpZHqBsYLUXas8yAc++u2wKaP4dW2PK1TtvVlj2QOVav?=
 =?us-ascii?Q?Phq6amgR5a0tp7b3mY0O1kkVi7aB/gU/1xeUdpB6/3HV1LJlZQ8KUnuRNrFG?=
 =?us-ascii?Q?ZYmJHvArIo3dc1brYslb/H2RLQkijJNiko7zuLxqiLV7MphpfFzBjtwQAL9W?=
 =?us-ascii?Q?0hO2xyrPlrO9v3exn2uqHbjjJxcw/IGAm9yy5pKQECGwsWYEEk1S8MpAE+gv?=
 =?us-ascii?Q?jVspqK/e2UIlxW9kU4ejmPGySUIiFLQkSeH7Pf3SfQJYIuncR/Mxb5AajO8v?=
 =?us-ascii?Q?f/WSV4hMlgKzDgRf96ZYb9AY2BFGhdsMeXMeTLxiY+NyENCtdZgmNq34gs8o?=
 =?us-ascii?Q?85Pxb4ho+Tu+LHsDsICuTNKi3a6ZpO9SovMQb9WZO1NUWvfI9WCydFv7N4Sp?=
 =?us-ascii?Q?+oQxv6YJxQMyynAcArt7VgTViy3h+Aj08Z/fEVLLRcuNaxEK23wVQCQTbG7r?=
 =?us-ascii?Q?oj8hlmZxuwtiaAGD4PeYu7dzfcfTeFwUJqHaYN0fDWPRlvhS7V2RvcRdueFT?=
 =?us-ascii?Q?2dIU/2mscbQvgaXAHkUMuFuelRtuiNHEmFf+GLKFbOwwcQUpBMEbwKbeJm0G?=
 =?us-ascii?Q?ysf7LIruzcE40IppvyfHya52WddbiOZ9QAX64T8Akdd5CDsbMyNBxZriVvvQ?=
 =?us-ascii?Q?YLh4qqcGv7yZ4UnIeA1/LGnchGqJcMg/qzfj2cAbsrVgXUOIbVFacWEjWiHr?=
 =?us-ascii?Q?3iC1V7YSrKm0Dvly07LF/mIfg92/gFw6c94SEY6vfEBZHjntRkS3tlI7Xy5X?=
 =?us-ascii?Q?eX5AbJD+ciHTchlBNt+ELullLyl3eaxd4j94NR3SdRdxxaHJ9coK0wEW70X4?=
 =?us-ascii?Q?8WaiwswjP1deNDdolzwsm/MGVNQ+EOZdzOkDnUrb/7Cvus1S/PiwB/xCHhXW?=
 =?us-ascii?Q?nd5inKT77Y7cKjD6wO/7Da4qfwh5vFm/ZVxOAfrEofRU1oruAriGlsmqfXNJ?=
 =?us-ascii?Q?5L35xOdG/h6/VqukOyTzPvBP8R/BNRY93c5EGSKjCgHL8AU59sQg3VO9elmh?=
 =?us-ascii?Q?3e1/8akJNqEWBO45VPOcR4g6jI8kDoDkYSyI9+Z2YbP4nsbPBqhyz7z/E2zh?=
 =?us-ascii?Q?pmBw+lbWSHmfjp/XKFiZVWNS3kkZd7wqBSCV4zlWtpfW8R8jJ7lh1rjOHEHU?=
 =?us-ascii?Q?LhQWHrxHbaRZTzNH1xWVK/CM8zafDfL6MZ682Lf/tlDh05Po/fTUkzM26c2m?=
 =?us-ascii?Q?jyhaPdRh5quJzijRvyO+4nf0BLxqE8QIoEdME5EcABVYYZUF//I3YY4WuJ78?=
 =?us-ascii?Q?xWDZbbLyFRTE6o68Qn216YsKCnzIvEKxvcLFh3SyCMG4noUZ+9veLCCOyjb8?=
 =?us-ascii?Q?qxwyusIYCrBVcNqMzofaoJtVmxd4VfTXG+X18aL6M2qL4ssKHTNG1NuFalln?=
 =?us-ascii?Q?f2X+UJbD743QyyoOcp1HMGV8mWSzoNay14aAWoFs7IaUQDmKTaa/eAqGlmnK?=
 =?us-ascii?Q?ATJD+7Tv4xNd8mZf1ckSPxMmTQILR0ahtQKRnVwr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4668810d-1c6c-45fd-588e-08dcc5b442b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 09:48:38.3642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUkIMugn5wK/Qyk3mNfBu2i51Uy5sph1GdslEN3US4E2NRZx7ps1lHkO3H+BjtmKZIu6TqYqvHR6C1ML9NiI6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8697

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, August 26, 2024 5:37 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Brian Norris <briannorris@chromium.org>; Francesco Dolcini
> <francesco@dolcini.it>; Kalle Valo <kvalo@kernel.org>;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de
> Subject: Re: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Thu, Aug 22, 2024 at 09:36:29AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Tuesday, August 20, 2024 7:56 PM
> > > To: Brian Norris <briannorris@chromium.org>; Francesco Dolcini
> > > <francesco@dolcini.it>; Kalle Valo <kvalo@kernel.org>
> > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > kernel@pengutronix.de; Sascha Hauer <s.hauer@pengutronix.de>
> > > Subject: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
> > >
> > > Align multiline if() under the opening brace.
> > >
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/net/wireless/marvell/mwifiex/wmm.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c
> > > b/drivers/net/wireless/marvell/mwifiex/wmm.c
> > > index bcb61dab7dc86..1b1222c73728f 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/wmm.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
> > > @@ -1428,13 +1428,13 @@ mwifiex_dequeue_tx_packet(struct
> > > mwifiex_adapter *adapter)
> > >         }
> > >
> > >         if (!ptr->is_11n_enabled ||
> > > -               ptr->ba_status ||
> > > -               priv->wps.session_enable) {
> > > +           ptr->ba_status ||
> > > +           priv->wps.session_enable) {
> > >                 if (ptr->is_11n_enabled &&
> > > -                       ptr->ba_status &&
> > > -                       ptr->amsdu_in_ampdu &&
> > > -                       mwifiex_is_amsdu_allowed(priv, tid) &&
> > > -                       mwifiex_is_11n_aggragation_possible(priv,
> ptr,
> > > +                   ptr->ba_status &&
> > > +                   ptr->amsdu_in_ampdu &&
> > > +                   mwifiex_is_amsdu_allowed(priv, tid) &&
> > > +                   mwifiex_is_11n_aggragation_possible(priv, ptr,
> > >
> > > adapter->tx_buf_size))
> > >                         mwifiex_11n_aggregate_pkt(priv, ptr,
> ptr_index);
> > >                         /* ra_list_spinlock has been freed in
> > >
> > > --
> > > 2.39.2
> > >
> >
> > I wonder we still need patch for indent issue here? If so I am sure we
> > will need a bunch of similar patches which I don't think really help
> > improve mwifiex quality
> >
> > Actually in its successor Nxpwifi (currently under review), we have
> > cleaned up all indent, and checkpatch errors/warnings/checks.
>=20
> BTW you advertised nxpwifi not as a successor to mwifiex, but as the driv=
er to
> be used for new chips. This means we still have to deal with the mwifiex =
driver
> in the future to support the old chips, so even if nxpwifi is merged it s=
till makes
> sense to clean up mwifiex.
>=20
> Sascha
>=20

Just like what I listed for the errors/warning/checks of Mwifiex running wi=
th checkpatch.
Mwifiex has so many issues. As the driver will only support legacy devices =
and the state of
it is "Odd fixes", It is better to fix really bugs of Mwifiex instead of cl=
eanup it.

David

