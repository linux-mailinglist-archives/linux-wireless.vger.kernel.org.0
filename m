Return-Path: <linux-wireless+bounces-12728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A8972965
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 08:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D42E286322
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C664F16B38E;
	Tue, 10 Sep 2024 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rqe2Sm3U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D28167265;
	Tue, 10 Sep 2024 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949143; cv=fail; b=kCtW8Qds0n33xPVZc5G83JzQpTXvUqwo9IUjB5DUGrDtNr6we6k5SqPFPGMBMzmYUFvJHa8yJs3gWb0Naz4KewVKqtAnj4If1119o7gJudjZv4uanlY+bzEXEWiS64FfKKujUbXKg7UH5oXeFXObhNOui+UvbkTx+J3Dq7Vlyqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949143; c=relaxed/simple;
	bh=X7sUjzgek62Vo04HzfWPv3KPLHJonRWVEyO32c6PdjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PudUEAEACxSxGG0J+MBOPpPexDmM66ixmcOxq4XkuVGxOVx3fO831gSZLNO+L6Cf/U65i0cT388RIlzOxjO+K0Y4l95MylXZxDsszbP9iZTSefN4uNLU+jD7i8t1aRwDXY1o4UtgzdCWjgBS/mEhrVVtSjYdhdoH0kOkEOPY46Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rqe2Sm3U; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duJF4UjOd9lKKIpUMA3/fR3xSpQjocOXvreIcmq2HSRcYqrOM8I7MoEZP5Bt/5U35IuFpTfFSN/DmhBC5dtOmrO1fbfkWv0y5IcFX9fT33ifQpcc7w5m/+KN/q+yoAT6Nfmy2HFWLux7eAWZFF2YryDPF2mvg9U/Pk4EptYcNwWQs2tbDc6PbJ503QUxAwfw9gnB2k75EcO0p6GGF+p3MSq5De80qJIhSyC4hagONLeXf5Tqt57uoMAVYMkonXxE4mWLNo1xvPQdrjlPVEadLrLJn+7FH4JRMk5jqCKWBw3YYUxuBcfOzDmxacPwFejzNhJh+zVWJcGOOdGBnsSSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7sUjzgek62Vo04HzfWPv3KPLHJonRWVEyO32c6PdjQ=;
 b=PItrbcDCf1pTY3MAsdQ4M5wHFtJuuia+P53/aBiOSkBC/mZs1utFuauqHKo6NHYhlxoW5Y5+MaxaBGFISldh77+04UjqJc89TdnEM5yIzR1sE7MAYdRIeA55wQJeqLyfX07LktSmlSLwW/YZHEzHJNnq5v/MCRgYYuRCk4sniEYEmmhzugMEqENrNaQk9cHeELx+IRwUuYuXUi3ptWqCAnvU1+K/tWYnZzS34CkW+hULS3Eb0BFPaQmzIbv+Tossh1/xjfmPfVUUZ0ATzbaho7z0jRIo64R8sXjmzQzygep2uqIG2/0PEHhmyrZ5Rmu8IPzG4TLjm7yDtUBt2Q1GDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7sUjzgek62Vo04HzfWPv3KPLHJonRWVEyO32c6PdjQ=;
 b=Rqe2Sm3UZhPhJx7ep/lb7d9dUfymEUQDJddlQZ25KkiGvYIkRKx5mwYyBDBzj/OMU6zQi9VFoACHsQf7QlcNCq10g8bXpMMzqP2TTKBPTd0dNHikjU1uMzTlMrMhqucupSyP1AxvBxh5B0YVZqUSTrzmzOsOMU7VJCEU3VMJsp9AzZ+nNiXseZLLtNuEX1ZrT+moZHaleNeUGZZKHwGDSc5wzvV6midj+vV18c/Ye/g+69EvwOt/hyW+R+4lKxHxJm1B1tdEWAQOSSAFlorPMW+h8+UZuVPGWVidywwVjBPujFW3HK1PeUNMljZS5hJCrdtKt/eUd3stXSd0sFxTwA==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB6846.eurprd04.prod.outlook.com (2603:10a6:803:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 06:18:57 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 06:18:57 +0000
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
Thread-Index:
 AQHa/RQwZkxE7S8BN0ebi7x6fu8g/rJEPYCAgAAPeUCAC6fogIAAWbHQgABDcACAAAAqgIAAAvAAgAAC0XA=
Date: Tue, 10 Sep 2024 06:18:57 +0000
Message-ID:
 <PA4PR04MB96389B2CC16060957878D0D3D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
 <ZtWHhSQlPVMekW1I@pengutronix.de>
 <PA4PR04MB9638EC10C0B656B750D922ADD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt9blTxk88Opujsk@pengutronix.de>
 <PA4PR04MB963813D69B4D87B7147704A5D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_fZEJyiCyanf7X@pengutronix.de>
 <PA4PR04MB9638C8978D9C6360A9B214E4D19A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zt_h_mW4nFWKu2SI@pengutronix.de>
In-Reply-To: <Zt_h_mW4nFWKu2SI@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB6846:EE_
x-ms-office365-filtering-correlation-id: 0396fe86-bc63-4a67-0471-08dcd16073ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N5ZEmFcAcBTnYXrv4+366rN/DQ/AUfTkhioIRG2I89HvbwQyiMuzyNjsPR6m?=
 =?us-ascii?Q?4nveKNlp+0AGcObzePglGsQRJXSZgQGl7ptDt57JFm60TanLAAdQPmAc9SaB?=
 =?us-ascii?Q?sLWSk1TYdw+NxLy48/YTnwkZAYSYTJk2X2CIbhuFdS+wCc230dIPuOgoRJE+?=
 =?us-ascii?Q?nBOLoqoG9cu1xJgDkYOVKNs4PERKRC0xC3kFlhS3Z44kzuRtqy0UJDyQJjEq?=
 =?us-ascii?Q?2j33uoHsZdMp7SnLY47y1VMbamYXeJq9g2Ef47T6n3BHss7vI+TozBC0sENE?=
 =?us-ascii?Q?iG7UTVK17jm8odLuxurnDkc+v32XCu+rGrROoj6H8TkM0e+8MFeo77c3eo85?=
 =?us-ascii?Q?8uwAnWFSOfz83rp7M4AjhcV2QMVTBsYjjhI2fXUjeNq1OEFbKulxCjd65l91?=
 =?us-ascii?Q?rzw1bWiEA/er7q+jE11A4QqFyOYlMW/Ik9OARIvBF9qDU70Ysdmqr4HrpTxZ?=
 =?us-ascii?Q?pe6H8rCE97sQkcVu0eHi/D6NRbtpYuukvAlQEtiLrBMLsONBYK64QkiqDX+p?=
 =?us-ascii?Q?NdLfYd4vhiTeGQ3Vy9QPT5Q9EDPKQJmgMaKU8XNAG165psTPLMdmjS0GPUXf?=
 =?us-ascii?Q?2mdiVrBBok0A0Lg+TBaNIzFMt9ZWzn0lWv3ih3rNxV/TEKpBzLvsX8/HdKd+?=
 =?us-ascii?Q?ogcIvh9f18RzPun0Z6EdlfMLutS3qLUFzZfqFWPVSCrlSDZ5sNa6Mxk2t9BH?=
 =?us-ascii?Q?1KcEiN+3Fo5SIRnEtju/47dObHDdV5gcFKxc3hu7kz/a731J07XwSLJn/E0L?=
 =?us-ascii?Q?tz4qTglGt1LWG2EkqXf7weq0KVgHwc5vzf1xvlXD1totbxr8CeXLEFL4OPHk?=
 =?us-ascii?Q?hpRm6lZCqL9TuXwDV0NpCuRWDoc05Vrn4JbBMAHwC1+5185XUbZQJPnx/xQ+?=
 =?us-ascii?Q?uBZTNFdFr0ycLb8rGpr/+tjZoFZQaJKI1LZfOi3nMVNrrAGGKYG1IFIu5UzV?=
 =?us-ascii?Q?yGcVuD3onMvvU2w/a4YzLh2N39XXSIsYtzjzV4NrOERlTgb4aYNx5aE63pMS?=
 =?us-ascii?Q?IOCT0IPnh/A/WIncwlNOz+fL6ht74WAZjXcC48gnYdxxCpwtFrOH4MxG9AQS?=
 =?us-ascii?Q?ygA94fZesNsxDpVQFUhAI04CyQLY1Dgtzsp0NTMORQxmA/MxmypQqKCsUo2s?=
 =?us-ascii?Q?ulMqJJ3Tw6KEA7QM1GN/asVk8AntbJ6AGy/M+/QJzTwthsEnKgBUqAsaceyv?=
 =?us-ascii?Q?Qt08UwWgkODsLLUvj5bqZRNQqBvmWtUi1CAeF0bBG6tBFj14KpMbGN+id5tf?=
 =?us-ascii?Q?dgxt9wHIuZ5xwxpAWVTxHlRudr+fruivEiqFYzkuWBvifDrpFjZltQ8I6fRf?=
 =?us-ascii?Q?qb0g7EbRdBH/bsrydObdiZ61ZKfSys59kljgjfHJjtrjYpShVwjAVurg1Tu2?=
 =?us-ascii?Q?v3WbW3k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UvGLTsXykCChX2dyu5RD80W0bBapE9vjmDJjSo563/2gBv50kO6JmBbJ3fR9?=
 =?us-ascii?Q?Swurtzva78Sii0u2MD+yUZPrt9FWobykbj9p13F1D/EAquaOI9Jaov9JE7jn?=
 =?us-ascii?Q?JOJ5MqjzF5Q0ZZGk0Emi4IyxvQxe4P3bm4PGWcRlNY+h3EiD1YJPpEu2bYzt?=
 =?us-ascii?Q?Rjc4YjZgZrIXMhRWshh7DJ1E6fHsnsb2vpZPjttK/trmWOoso5TWUGobAGDZ?=
 =?us-ascii?Q?CB0PSsfKloFvS6rVe6hQ+h2WWDt0YaQELuV7lQ7Qlct92JixCNIWM4kePb/s?=
 =?us-ascii?Q?mDESrJ92GAiXHGefYMV3jxiGdx64HV1N1gzbN2zWLVpxgwPQv8ZqvYWJqIrG?=
 =?us-ascii?Q?7XfHUuXdIw77j8Sf2Lbj99vymbca1P/nW719ieSWRr4cQrRRABDtZDBMgUTR?=
 =?us-ascii?Q?cE72D2n143hs71VFh6fholjImTsRZ85pNbFtwRzALWBEr1kiOWERaNsi3uRg?=
 =?us-ascii?Q?wwxX44vy1QSIYQIf21cho1r6yA1t7dYrUwFGNJQ2Gt42vNqIuK1oeEeduCsg?=
 =?us-ascii?Q?bzqyZtFodQey/oIHLVbADBU0SK4xzp03RTgyIiIZtRPfDfpPL633gsBHahA1?=
 =?us-ascii?Q?i/up1IMU7SRuQuca8Ltllah7mZw4/egCFGmOoptjY/PFkqtRISHTqxFIB6we?=
 =?us-ascii?Q?O+n2DRyAIQHAUVlVB2NlYUy8D6LMzYOB3Nghv1LRd222XO/DMNFwUDjuWdes?=
 =?us-ascii?Q?bRU+930BiGyImfk5O+I9RNvpO5zjXgTm6exGxnix+Qo0AHnwcMWOzZ90ZHW6?=
 =?us-ascii?Q?7PYp2NBeqgGZpPdvwxlct+gmuOPA4+6rz874vOjnB9kHFwtb23aQ7ENsfoUY?=
 =?us-ascii?Q?qgU8difuQ38ZiMxgfRZ99julX+7MQkHs26Ma9akN8b0PkECrFyIWiz39EX9Q?=
 =?us-ascii?Q?RmcNnw6sVX//jsQu6ZqXUQgl7429llTuI7v+/jKR1ShqjAGH3Z8+F1TI4EeS?=
 =?us-ascii?Q?+y+3Jzi2Dz9k/utHWmBvhrCa55Y2jaWPii/XPJv4C7U14SZ2Pfay7GiT2zuU?=
 =?us-ascii?Q?2QvPnoAOCzPXn6QV9FXuCql1itcJgh4k0Gl+gfqprd8UcU9UKZWzzsdA8NjI?=
 =?us-ascii?Q?oCb/wbqhtYIAQpHy3pdQjfNhbPP2Eldg/lXyW+R5DkQOTEol+1B3zMVbjFDj?=
 =?us-ascii?Q?6W6nVSiFJv2rDw5tL4FJ29HhCnnDS2qqJNCA13PK+kzgnIJHD+OBsud3lXBd?=
 =?us-ascii?Q?Yt+16kI8dVxNTziCZ9E53HDQwv2nBtEfwuz/OD1rvOO8M3G6Iv9cOEaaGxV9?=
 =?us-ascii?Q?1j43Qx04CJQWGFqYASE4Uoz3SVXdpc60NjBdHuabYcR2jY2B33OCA9zpoDWz?=
 =?us-ascii?Q?j9mb0AyzjRnTdkDeTbaiVds8svOEk3io3wyFrOsJD/NH5tenoqYIx7qVbHnt?=
 =?us-ascii?Q?EtJVDHU1bkaECU3F0vJefZwM2i8LVNGou+zAiEfCm8qPkuh6XrKhFKQzW9DQ?=
 =?us-ascii?Q?zaLuRRZxHWcZ9O2qzYDd0KRtaH9vZIf44WaTSpQl1ck9sKnrRB7/XMzXgPmo?=
 =?us-ascii?Q?nKtaqMdoUyCtXTzB5q2PG6XyER3KhwMQCMupR/+ceHFWchu1lJGlunUSDWJ1?=
 =?us-ascii?Q?AWDVKmwbL60QF4NmQpoMcF2ipe4aMCGKDsH/q+i0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0396fe86-bc63-4a67-0471-08dcd16073ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 06:18:57.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Y6gJr5cXBh/Gy8ljmfwV2D5RQ4kFVRukGvM6JybFDsaCuaDyX0xtm14ohTZPJvwPhAbo5NX0NOANanTWcwoUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6846

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 10, 2024 2:07 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running=
 on
> different channel
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Sep 10, 2024 at 05:56:58AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Tuesday, September 10, 2024 1:56 PM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
> > > Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> > > Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and STA
> > > running on different channel
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Tue, Sep 10, 2024 at 01:55:14AM +0000, David Lin wrote:
> > > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > Sent: Tuesday, September 10, 2024 4:33 AM
> > > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > > Cc: linux-wireless@vger.kernel.org;
> > > > > linux-kernel@vger.kernel.org; briannorris@chromium.org;
> > > > > kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> > > > > <tsung-hsien.hsieh@nxp.com>
> > > > > Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and
> > > > > STA running on different channel
> > > > >
> > > > > Caution: This is an external email. Please take care when
> > > > > clicking links or opening attachments. When in doubt, report the
> > > > > message using the 'Report this email' button
> > > > >
> > > > >
> > > > > On Mon, Sep 02, 2024 at 10:35:01AM +0000, David Lin wrote:
> > > > > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > > > Sent: Monday, September 2, 2024 5:38 PM
> > > > > > > To: David Lin <yu-hao.lin@nxp.com>
> > > > > > > Cc: linux-wireless@vger.kernel.org;
> > > > > > > linux-kernel@vger.kernel.org; briannorris@chromium.org;
> > > > > > > kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> > > > > > > <tsung-hsien.hsieh@nxp.com>
> > > > > > > Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: avoid AP and
> > > > > > > STA running on different channel
> > > > > > >
> > > > > > > On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> > > > > > > > Current firmware doesn't support AP and STA running on
> > > > > > > > different channels simultaneously.
> > > > > > >
> > > > > > > As mentioned here:
> > > > > > >
> > > > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A
> > > > > > > %2F%
> > > > > > >
> > >
> 2Flo%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7Cd0a1e3797a0d4acd7a
> > > > > > >
> > >
> 9c08dcd15d3ddb%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> > > 6
> > > > > > >
> > >
> 15445620612026%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> > > QI
> > > > > > >
> > >
> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D5yC
> > > > > > >
> jjIqxpV%2BJxlPdrCH0gRTQ%2FCQZKr%2FDc0S1cjkaIA8%3D&reserved=3D0
> > > > > > >
> > > > >
> > >
> re.kern%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C7712df39ac37414fd
> > > > > a7
> > > > > > >
> > > > >
> > >
> e08dcd10eac35%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> > > > > 15108
> > > > > > >
> > > > >
> > >
> 157502805%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > > > > 2luMz
> > > > > > >
> > > > >
> > >
> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DURNJPJE17iRY
> > > > > Tu4i
> > > > > > > rx7eQAC97tE5OE6a4kUfjUwuaVU%3D&reserved=3D0
> > > > > > >
> > > > >
> > >
> el.org%2Fall%2FZtGnWC7SPHt7Vbbp%40pengutronix.de%2F&data=3D05%7C02%
> > > > > > >
> > > > >
> > >
> 7Cyu-hao.lin%40nxp.com%7Cce9b7d4e417c41113c7d08dccb32fc49%7C686ea
> > > > > > >
> > > > >
> > >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638608667089710854%7CUnkn
> > > > > > >
> > > > >
> > >
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > > > > > >
> > > > >
> > >
> aWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DnMZO565xCUO%2BwxD4tIfi
> > > > > > > w6cGyYrinaEsi7XLfqyxgXg%3D&reserved=3D0
> > > > > > >
> > > > > > > AP and STA can indeed have different channels when DRCS is
> > > > > > > enabled, so I think you have to check this in your patch.
> > > > > > >
> > > > > > > Maybe the same question here again: Wouldn't it make sense
> > > > > > > to enable DRCS by default?
> > > > > > >
> > > > > > > Sascha
> > > > > > >
> > > > > >
> > > > > > I will look into DRCS support later after current tasks on hand=
.
> > > > > > This patch is a quick fix to avoid firmware crash in the specif=
ic
> scenario.
> > > > >
> > > > > With DRCS support enabled AP and STA actually can run on
> > > > > different channels with the current code. You are breaking this
> > > > > scenario with this
> > > patch.
> > > > >
> > > > > Sascha
> > > > >
> > > >
> > > > DRCS will be checked in the future.
> > >
> > > By future you mean v3 of this patch?
> > >
> > > Sascha
> > >
> >
> > No schedule now.
>=20
> I am getting confused now. You want us to abandon my patch in favour of y=
ours,
> but you have no plans to update your patch to avoid a regression that you
> introduce with your patch?
>=20
> Sascha
>=20

My patch resolves the same issue as your patch. But your patch can't let AP=
 and STA run on the same channel if some wiphy parameters are set.

I wonder did you test your patch?

David

