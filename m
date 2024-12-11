Return-Path: <linux-wireless+bounces-16234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB649EC3C0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 04:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B91880649
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 03:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0671369A8;
	Wed, 11 Dec 2024 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kIrVirHO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013031.outbound.protection.outlook.com [52.101.67.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EBE29A1;
	Wed, 11 Dec 2024 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889169; cv=fail; b=PbJD0UV5DjswzPA1u+4RcZ7csJU4WQloSc9jcsiREUB8r45C1/pYA+RJQ9hsgBLfefyYLb2Kv8JXftc7jSqUAw6IOiwtFiPWDQYR2mZxLSw/Pni1Uon/s9rj/NOEy4EXl86TNBtrYxNStUOL47Ci9yKXa9ecoRn35l3FTZpVRZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889169; c=relaxed/simple;
	bh=wpW+q7ck7M6B1fogo7qA9aIUeAJ0Yi33MzUHE1eAytE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kL2a45weAp8OC4/oisfbWTurld9k5FBTnhBBpXaJGJ8G+l/fM2W+0gbrQvc1FermLas41Yg7bTRad/iCQpunqCrLmqJCYR67QSc3L3WtaFbBoHMwxgFiQKHABO7+xsd1saKuLHJc/usIKEzrWu3SKTn4qPNgLvYWH0y187v19g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kIrVirHO; arc=fail smtp.client-ip=52.101.67.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnJXQ0FYMlCDljqCxxQ41P8z1uYGQ8y30XQRh5IgnWXFL9IJfv6l2UoKGQg3EO5PFM8I8ugPVcSbKxHsIHD3cXZxtOxvaFtMY1QVGYkQEt80OkB2OyDbrP/y7nFQBsMbwn627kcILnxG5G/nQ0rq7dCwvkNczl4vZmxp+/m0QlKR67wFih9QyqFijHcaoaqMeMVjskT2aJ4JDYuwj0o3WVIgM7ohVZiILoKQu3EdOz2wXEhn2W66MPjKG9PVI6L2YfLrKP5u2meCmrUbkKo3C/w0LF/5RC4gwYhjeWKBT2lvl1V80ABbn7JEYyKRNcofYlo2RFyLmWbVGcX19CUdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EGd6BFCg6OexH6Xt1fEQCq7dk5ea+nC81oXAbVXxwc=;
 b=FSUWJ/6gO2WePn/VdaXOqdWhhsRvoU+Kbz93gfkxo4RzawHUFeJv3o83LnLRUPlpnXcacPt5R2f60TYwnQH4jtuwzSGC+iq6GEfNUfHib6oZH6hTNCjwGCreN/qrP0pdzJTicAIEU5Z8Nnaly7jJk363iTcAOKC3p1Kxh8Kmo68NKMBphx8ccvIjArZG8tUDWWHXyCayJ9VyJ+lXts449lrMRmMrur+9AqVheSz8OIWd8C/kOGxwJshN/sAbi9KrENt1yRIv5J34SYseBSqbRnaobyFB0pNlUHwfEz4WDClU5glZeX7PjmcMk5bg6AYsLY6p+uP1G3qpLa60FNJamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EGd6BFCg6OexH6Xt1fEQCq7dk5ea+nC81oXAbVXxwc=;
 b=kIrVirHODuHh1BgizjTO6+l3BfpBBIpYy0FvI4stM1HaVrQpwUFPWC626690xBD+BZqeZFeNNhYuZc7XsQDH7w/NXSyXaDjBZJqE0CKpexfR82lMvlwbADcJhHyDNxIWDxXsiRFBYrLnDiEsjvBu2GZBUSoKgkvhIDgp7nMDtg4nqnR8MDFkOpQMP719BpHYvvx+j96UJLtYXCCrBN7dHkGhF+M8QScTIbCFm43gvJqTs9EiT8mBJV95100aIjvKp4rlXVIRVPNLgEWuJaJB3dr7AC4eAful10FjRg0UQLLjQFEIucGKcGW2C27cAKU3//482PRqe4zRJ0njvpOH4A==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU0PR04MB9494.eurprd04.prod.outlook.com (2603:10a6:10:32e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 11 Dec
 2024 03:52:43 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 03:52:43 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Kalle Valo <kvalo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Chor Teck Law
	<chorteck.law@nxp.com>, Jeff Chen <jeff.chen_1@nxp.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: AQHa6kDq7zFfRJGOz0Wel62W8Sr8T7IzUOKAgFesnAuAViyYYA==
Date: Wed, 11 Dec 2024 03:52:43 +0000
Message-ID:
 <PA4PR04MB96384D3EAFABA0D4D6BD6A3DD13E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
	<Zsc1efkBHDXdZtfJ@pengutronix.de> <87a5f341bb.fsf@kernel.org>
In-Reply-To: <87a5f341bb.fsf@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DU0PR04MB9494:EE_
x-ms-office365-filtering-correlation-id: cd04cf80-226e-42c8-ef22-08dd19974495
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JkmkewKUtIkKJYg/PiEmtOV0Wgb4nuecYWbbWNqs4xf0/OXIttvNTrN2fLmK?=
 =?us-ascii?Q?ovfGPSNVsw2OH/QKP60fx0zfiI7Oz2KCf+V9oMwJUX4uwgda/HWjuz/vF7k4?=
 =?us-ascii?Q?hTPdn+e9YFLk5nkn7zbR0b8WB8+otjSTIayJr9M6pfc9lksC0731kC875Wi/?=
 =?us-ascii?Q?bSad2MYZapgDnvejMhpKzuKbDXPPMKvpBEPUKi07Ek9pQAIKfbBVKFH6LAb5?=
 =?us-ascii?Q?txewfpdHZxvT9lkKyuGAOCDBn70v4zW1hXJhnaLP5p83QrIoDsZe5Y5Idh0D?=
 =?us-ascii?Q?X16hYMeiz90xlcJwxH0+IvAyB+SJ3NwCMY/wRaseajE506/o2Z6UmcI6XI/o?=
 =?us-ascii?Q?Xj/JrnUeEyLuz9tTNihnmor+hJwTA9I5999yS2ZQL/for0qTt2Esnhk7fsGw?=
 =?us-ascii?Q?jFqDItwE8h3qCqXJvVUxSCNL0OSMzjSE5jiIOBHVdh6vUQ47HLfTfKvJaZ7F?=
 =?us-ascii?Q?s0dOUiKK6gRv/1KQhA+7V6ZoZJ/sebvkfnHTBpOJOSgZUdBNFwHYXUFxG0/o?=
 =?us-ascii?Q?QcNc+aZ9LecAoTmgogYR4zDa3/v9ztrNKI8D9z1mJH/cqM+C1GlMvYqMGUUI?=
 =?us-ascii?Q?jD6qlpdp2ilsPe3Ey6d7HEv1wirC2ZdvUBZbNkXTOYmhOSNdGVUStiQ39ZEy?=
 =?us-ascii?Q?ypjIBHkve4j3+ZPa5BdfpI0AHBo7pjZVL+IChWYkxZP1fjnCm0cLBvDwGcTu?=
 =?us-ascii?Q?ummFXFr1vb+3yJvWf5xa4wEWj8cEm/NprrN0+3+6GU8b2sVF7Lgb2G2cxxho?=
 =?us-ascii?Q?PZr+AGNYrUJKa0mcBcL8jRgkvEKInzrCAO3b+YPL9vYAGIrMcCOFxFepS4DN?=
 =?us-ascii?Q?x4THO6/kLtlnuoZnzPFQ0t4EduC0gwHFW98QgOUJmBmOjY0RX8RXVpmlZGSV?=
 =?us-ascii?Q?vvMLbc5Q/xLFtI96sqWeZ1AqTiqa8O2jskdSl3jrd6wudmQEy3E+kkT48eLh?=
 =?us-ascii?Q?YytuadHMzFr+IWFrODJpqIfEpAhBs4zRNmdfF3cFdOqMV6IUsSps9CJrfzQT?=
 =?us-ascii?Q?LSpmBuz7ypDmk3mkoVmSfkK8loLbh76mLU1Wz+znNb5hA5zn8TPSiZah27v4?=
 =?us-ascii?Q?xIR05CEUDTP4YUhDIOg+VzqV6di96oaPkrU/v/syxeVZ/lEJlY/7D8k0mgKh?=
 =?us-ascii?Q?9uZpkKGoaiqSzwg8aFnpNPvl+gs9O4TqX2OORhMXVZj4FtvlqiTa5f5i1id5?=
 =?us-ascii?Q?Epy/7XdfWq9cvgisR5GwIq0fQvMwbeRgZNMyGrS3Qo2wavCOgj1nR2b2He9k?=
 =?us-ascii?Q?L2HHlTpSAClKepMjGkK5K46so0TzvMda15CirJ32v1LU1PApyKtvX+2Y6t19?=
 =?us-ascii?Q?pxYbChWJT6Aq/PfAFzQSEsIHk6oOXyhRGmZw1jcxTDcbbwrEf1IB54vhyGhj?=
 =?us-ascii?Q?YWzkK2Z5IDOImaUQbJ+jTHsirFRA+B9ITrZbBprpf8WZ/fRY/g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GrYKEPoMcsGYVZUNs1qw25/5Eg8RaUF7jjxol8Dl7KYdd4MboFvNtyKCQd3a?=
 =?us-ascii?Q?Acy0HCxbHUb44UdDoDBWPgxnL6dIUManYMmQajm69zgWYqoQ9vs0CBdMmn/e?=
 =?us-ascii?Q?CPTCXXErZ5NdjuI7cFQCztG1JUJlbtfXsOx0PJsJ8qUQiW1qY3ter3ad/3ja?=
 =?us-ascii?Q?Qb24YT9z6hKAW1/VW24a6u1l08g8jyNMgMBAxUqsiKN6tLLZ1ZDrPYyBsXle?=
 =?us-ascii?Q?XsVMfUMf9iLufRS+DpqP5u9oTASQ1gB4g3VuDslPWFotuGc2TVNbO+8xMxrB?=
 =?us-ascii?Q?5PTaLYlCVRWL0c6uBzuL4r2ZshEH1uu3wlibWm/a/OCnJjjyIMLlgSdaeo8q?=
 =?us-ascii?Q?n0XpaItnOilMAwHiJd15ofYjQWtMfoE+tQq4zrUq32VI1wfnTgmxfjiPIJF5?=
 =?us-ascii?Q?B16BirTXP2Cf8bEh1LIFt3XYLMrjcCQrSPIm501x2+U+BKkYBGyKppv5VhI4?=
 =?us-ascii?Q?fnvzAKTz52/KcUPRsJ+y3bJ62Sdy4Nr8uV8gji8Is5qzIYVWhCwViYxCdICa?=
 =?us-ascii?Q?2hpmPWbMsml/TibRjypwOPL6DAB70aQrV1n0uoPpmDdNr6HYyA7gwb20OTJr?=
 =?us-ascii?Q?6KglFUnNppnEG+2e3zu+HiK4xcmvJLdSamIPorP2U5Wu4CEb9E5ZV+cJH8L9?=
 =?us-ascii?Q?cPdh4PTztPHxD+kcuqRnsoYmNh05ggJ97n3mJDSKDT1yIjGrSlLwjwJTPBqK?=
 =?us-ascii?Q?MVJCIEhjZSB4iMkcgDuh9z1+x+Bs3/iupQbSWL0IGSkYOoB+4ax7MJpsrO63?=
 =?us-ascii?Q?StbjBnX91zuZRH/SsirCt1kShcjpKQ3AT17UgQlbWWktQ0FW2PNgmX6UHl1I?=
 =?us-ascii?Q?4xPq1lGOuIBr3m1IYJicb7ltG0HfmXtGR2XZaqw2Na/ppmHeSdVWJCluNpCJ?=
 =?us-ascii?Q?cPYIs1ChlwljyhQD71xqA9dxHMTYdIs3+qLa84xKnOJeFpLRfc1gDvMO+Ote?=
 =?us-ascii?Q?2igQLtZ+F1j0wLfQt6SHhX90qyGkSAhRv2HUWiqdsb4dVXyGHjmHHo3b73A8?=
 =?us-ascii?Q?VdcmwD0RC/2YmeaxRk+Ok+nGWXrIx54BnCLBQTyP+92MJxS5M7NMnbzIzoVm?=
 =?us-ascii?Q?YjbaUqU6A90jte2s1u20umkswEKPOhrVPkogyyBJ83mRrDwVpx03YTOtEOIp?=
 =?us-ascii?Q?m75h487Q8AwSI8GkA0Q+qSkedBCT9u1LI3W/k7XJdJQZNXS/gmQdqq0yPK02?=
 =?us-ascii?Q?cluf08Dcy4NJfafPkfOFBQTd/wkQ3UWaLcbLiX5bJJNyxrEacbzHOHF2G2BB?=
 =?us-ascii?Q?43p2Qx9kuT4g39jfE24lNW1jX5g0DfrNHWpwHScB/j1e3DokeNsAvogeCHaJ?=
 =?us-ascii?Q?WVz+q3MB157GPWzQXyDzEYpPVE46cU0zSv/LliocVG751IKF2ljRAlMEr6En?=
 =?us-ascii?Q?f0je6r1l7Zo2PnpywzhYMqljSe2/hRuqlHoHAFU37C9FJ0/HssyMbOfJq1Nm?=
 =?us-ascii?Q?VV/w58PGfSJAwV6EspunLOv62QU75X20h9hgJGZPjVNHhRLkqCM9hLXo3qO9?=
 =?us-ascii?Q?TMueqXVNjsdJZtl3nWJnQh5ZlLi9LcWCVF99g0bW6V7Vapj6AulD5MYE0io0?=
 =?us-ascii?Q?3R1VAPuGXMtPZJWVbuReVLUcyNIA2jFQKS8iAz5w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd04cf80-226e-42c8-ef22-08dd19974495
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 03:52:43.7788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8krVCNPBtCUOkfNt4i1YiozmY+/doi22V3/Wm0U1IK4KF3vA9qYWhbWwc6XttX/D3lTr0q19blphTnN8RQ00w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9494

> From: Kalle Valo <kvalo@kernel.org>
> Sent: Thursday, October 17, 2024 3:49 PM
> To: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; johannes@sipsolutions.net;
> briannorris@chromium.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; kernel@pengutronix.de
> Subject: [EXT] Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to supp=
ort
> iw61x
>=20
> >
> > Honestly I don't think adding a new driver is a good ideai, given how
> > big wifi drivers are and how limited the review bandwidth is.
> >
> > What we'll end up with is that we'll receive the same patches for both
> > drivers, or worse, only for one driver while the other stays unpatched.
> >
> > I even found some of the bugs and deficiencies I am just fixing for
> > the mwifiex driver in the nxpwifi driver as well. So please direct
> > your effort to improving the existing driver rather than putting more
> > burden to the maintainers by adding a new driver. I am sure this is
> > the faster path to get the necessary changes upstream, plus users of
> > the mwifiex driver will profit from these changes as well.
> >
> > Of course I don't have to decide this. The wifi maintainer(s) will
> > have the final word, but these are my 2 cents on this topic.
>=20
> Replying to an old mail but I'm with Sascha here and I'm also skeptic abo=
ut
> adding a new driver. Especially my worry is that after the driver is acce=
pted we
> will not hear from NXP anymore and the community has two almost identical
> drivers to maintain. There have been cases that after taking the driver t=
he
> company disappears and we (the community) are left maintaining the
> abandoned driver.
>=20
> Also I have not seen any convincing reasons why a new driver is needed.
> For me much better approach would be to extend mwifiex like Sascha
> recommends.
>=20

We understand NXP had left mwifiex unattended for some time, which has caus=
ed a lot of concern and trouble for the community.=20
We hope to address the concerns by clarifying that the NXP driver strategy =
is to contribute and maintain both mwifiex and nxpwifi
drivers until such time only a single nxpwifi driver is required.
Our approach:

*	Maintain existing (up to IW416) chips in mwifiex
*	NXP will actively participate in mwifiex driver to address bug fixes and =
review patch contributions
*	Support new chipset introduction with nxpwifi
*	Starting from IW61x, new chips will be supported in nxpwifi only
*	NXP is committed to be the maintainer of nxpwifi, and we have long term m=
aintenance plan in place including regular QA,
    bug fixes and feature enhancement
*	We are open to have discussions of any weaknesses in driver architecture =
for purpose of enhancing the driver=20
*	Keep mwifiex driver in "Odd fixes" state without impact by new devices=20

The above is an effort to address the community's concerns about NXP's comm=
itment to nxpwifi and stakeholder collaboration.=20

We look forward to your feedback so we can move forward.

> --
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
wor
> k.kernel.org%2Fproject%2Flinux-wireless%2Flist%2F&data=3D05%7C02%7Cyu-hao
> .lin%40nxp.com%7C7b455d23b995424b128c08dcee80210c%7C686ea1d3bc2b
> 4c6fa92cd99c5c301635%7C0%7C0%7C638647481285440847%7CUnknown%7C
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
> XVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D6KvGnRnlTJJJ%2F%2Faqc7AAA0BeTXI
> VzH7JdzheVpwIVQ4%3D&reserved=3D0
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwirel=
ess.
> wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fsubmittingpatches
> &data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C7b455d23b995424b128c08dce
> e80210c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386474812
> 85471640%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DAzZqyhe4
> KfQlX4GNUKY37OI4IP8EJsJFtNeAK8U8M8Q%3D&reserved=3D0

