Return-Path: <linux-wireless+bounces-12358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2DE969117
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 03:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2321D2841CB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 01:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE6C1CCECE;
	Tue,  3 Sep 2024 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uwch0Ibb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD931A4E6B;
	Tue,  3 Sep 2024 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725328312; cv=fail; b=N7777Fpx7+DKzR3oixUCsX0zrPcmynGHKuWxbpXwbLP+/Vc498OMX+9WyGvCaRSjO0walRvoOQ7RF3GCy0cvo8u4MVrL9kH1+KVz7pCPbOo7+Jizn0P0od96RixN4cU7DprxYvnnFULDg3+fK5RpwQ2dsgjzXXlKzL0aJ4QKQf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725328312; c=relaxed/simple;
	bh=84RZoTTepUQUOHdN/NW1JSpCU/ZwonIhp3cfzJ+vjnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gN/8G50MbB2SQEMOe0YFBhYs6LfbL6RsVVOuBbMK0FYS54mmKwgSbMt3uT+bGkTdgaMq//dWxrRj0/wrJgzEaEnTIfoynNju3bUHIkB+w2grdq+ZyNTw9SZIv2XqBHfa14C09QCydXEEpQrVCEAD7UBmNi0oJSc5ulKMwDfQJls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uwch0Ibb; arc=fail smtp.client-ip=40.107.105.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yowxFmkldYwg00Aw75OhlUBjeoILJEOp81ucWcAA5YxiT3S+TeL3hDtncQ9wrJ0SvhKibPXzgECVuXcszZKKK5+Q6jecncOVYZBZ7MYTXEfB45Ery7j+KSMemQgHYX3EfAn4tCuwe27673CkizMR4iNh+ba0Dqb0chNl8DyYV8CNDvIcUi4T8XUmuvLKdDcsw0besGo4YCBrcA8GcLUzx/3ely0mFm++wmBRNHO76HiZW09iHFJGEiEg0o8XbmKfN5uMTx8Dcd8UMqtAHo+vpBcTkVbq3o//aOHqqpaLa11w727oThEVXDnyjeKpUAQaDv4h8OsQDmWIZ8Son+ploA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+64IIb4kA90FRggb4LkkVjKhxvz9toCP1j0gQjcHtc=;
 b=wkPOGfZIz8rv9fvyB0Dk35+dxU57Nfj7mFgtbZOIcmA3hVV1gx0plgGKKWdnroKdBHtq+7arcDTjlB0oR1ZXsETqPULwcxxIhJhMmRQLBbZHPIK9ro+XsrSM9SSHCQbx+SZZcNV09QVNJpGB8f7KCcJXwMkpgUd2Qmshb0xUeajqW8fYGsSw0ENznO0OnTylaAa7SC/iYkigHZ+TeKSSeYPis2G+js2rjfVRxkx/1C9YhqGCNDoAXgFqK+67xyC0uKouDCGPuXDX6p2V4yvPygDi1R2uU70osiHHegQ36lRh65QXnmlSrSMF2DqShgu3HOSrOZSVL1cw8XgKBf5D7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+64IIb4kA90FRggb4LkkVjKhxvz9toCP1j0gQjcHtc=;
 b=Uwch0IbbOUqZujccEegukEwvcYzeX/m+Vqc/wmFil4wTSL8OBgc99SpfU18iSxJjY+8Emq+UhGr//vfr5o346xN4ZYjUnEcCPR60N4Z1HOmvSnVqtIaeq4tsZEIsaE3AubktBcfVR0yDomNirDzy40V5T82fw4JLVzY40CyZ3q0CFRXUWkyLc2LVYX3jF1rKjnWso9LyOj+3S5bXyCVFLZwiQEMrPf5qImOUZMFAusPYC9xFLoT/n+NkeqRyhGgsp191AbzXnKSHrYZFZWk1mlF+8gIWINC96RcEMWJUQQDoNU4dsGFfkNMrGzTwFnRQk4Tz8ykqHcn72BS0eOK8Zw==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS4PR04MB9292.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 01:51:46 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 01:51:46 +0000
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
Thread-Index:
 AQHa94lYwasmKIL7I0OVdvDE0AaRyrJDyhdAgABM2ICAAAJRsIAAEAAAgAACqQCAAFg9AIAA03Ag
Date: Tue, 3 Sep 2024 01:51:46 +0000
Message-ID:
 <PA4PR04MB963814F85BBA6DD39F516469D1932@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
 <PA4PR04MB9638016F363BFF87D62B70D1D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVd3__wfm6EOOgH@pengutronix.de>
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVtPJSsIr9eIFWv@pengutronix.de>
 <PA4PR04MB9638ED8FA48E352F7246127AD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtW5fFocfr9_WgGD@pengutronix.de>
In-Reply-To: <ZtW5fFocfr9_WgGD@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS4PR04MB9292:EE_
x-ms-office365-filtering-correlation-id: 27515ab2-392e-4649-0305-08dccbbaf822
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nkeiMBvLYlIelicAWkQtbDsWD8YLnLkoQ+M6vNVQTZmmMH2jpnql6RQMWZl3?=
 =?us-ascii?Q?Tv2XbBof3WrZ3t3NaJ905WBHKgr6KNaOt5Hyk9JjwgeXfn9au6cymxRU+LPs?=
 =?us-ascii?Q?ElFkymS9Yc4YOyd4W8TpFb4wHIgLHwM/bgh0na9TfJJ+TMtvC5ntKUBQl4ZT?=
 =?us-ascii?Q?bfjygxdxBhDSDefaVAQRU0jrPFm8kNaq512p4RBOz7KpT20WZ/FwiGGgdSEO?=
 =?us-ascii?Q?gtUsMkTC5/+x0Zq8MS7XOfwY8lNBiZFI5cZwpwvQC2JAoXHZgktM/kBKPsiM?=
 =?us-ascii?Q?gcM7z99Lxw+MDECWKKIkmvdrymLbzRMIPED/wIxGnieWG8HmPhDTQtbAM2Ea?=
 =?us-ascii?Q?+p1k7FCmfpm4zz/gKEIJeyx6peX55XAj++++zFrDhNbZlqDvYYPWf6tHQ9J0?=
 =?us-ascii?Q?4t3urdBoBcPiUjcbv+mqA7l19OVUXKmCsvQRUsmfFZSQkcSsnNkJac+9GF4n?=
 =?us-ascii?Q?YbOtTJs09DrZ2eNk8k6kqDFrhZQ2dRcHNZQzccLz9WtmDckwgDLHPMKfUC8M?=
 =?us-ascii?Q?Hgvf92Su35btSDevuOklo9i60tIixvat+H/yytm54u86xUYdGRbNjV0XlsCU?=
 =?us-ascii?Q?cE0MmWdNLYOb7RVXMZR1YFk+S9y608xubgDKCHc47JXoWJTszS6/y1/afKY+?=
 =?us-ascii?Q?rxmOrNCMZ+Iz5XiVoMFd+Cbi9ClyeU0e3Bg8uvU0etMTWX/N7257g5HxgqY/?=
 =?us-ascii?Q?zdSy21Idi8HMLV8cS4TmmYRBKrX2SlkmhWE8+MjVVOCtm7wAMGIJqcqjKN2s?=
 =?us-ascii?Q?tE68N5953Vw4mNqxm5vqF3uDMxx7aQ0uP63fvglkdQ2Hq7FlwIl0hMHeQTdg?=
 =?us-ascii?Q?f5zIPZHGhj3V+CELgkmvvdYyT6xn5p26PuYyDjTXTvc5S3vAvJm/kwlADrhB?=
 =?us-ascii?Q?/qGbHoyVyj9s8djBKptbNdZv8OPRJoVtvDn8pU3aFVBdb0ayjdxFbx1a07Nn?=
 =?us-ascii?Q?WdemJXF4lahgv0HyhONw9YkQKHmh27mnO1ELJDrd2TO58MK+61UR/6cMWB4G?=
 =?us-ascii?Q?UbRndiOeaWJqCxS1tCyZ3cn9xYUoXf0EG3U02LtCgXhzqMHP2RnjfH/rQFsq?=
 =?us-ascii?Q?EXaYmFWqiqvR0DvQtIk1HJuk2YA12D+i2QDXJE4cAQXTxhKxvk0/4qIq8a9q?=
 =?us-ascii?Q?DWoxGCEfaym0pwdot8FA71PDRyio87ho3OVTcP7dDItICORTLlLl+jiNBxIC?=
 =?us-ascii?Q?M4RtnZn6EInG3RU7eHohXv7oZ2HQCnIaZcveUDpD1LrqyvuNih2cjjVwCrXd?=
 =?us-ascii?Q?z2dEmOqlxE4jTir/5HlKz6AxeklKBZ05IY6HV005N6XsZF/C6QNN7zUdQnwr?=
 =?us-ascii?Q?7JLrRMekvoeq5Y5vuqVB4QHBl/HfC/dYEBUXVPefYPjJ6p9X9ldXobB1xYO5?=
 =?us-ascii?Q?RggRhLXt9JTrDbUI6okO4AhXA+WDIswdH03/c7vFayIc/fUnng=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EV4iiuNbgBl02EsgZx5YE2NqLcXUfVjpnBukVFEpRDmhgJD46ezkEMq5gl90?=
 =?us-ascii?Q?zD1uSj1/nMVkzsXn/n/3yfqBeWCKJQSP+TB5jl326YVQjPmnhnPFva4n2q94?=
 =?us-ascii?Q?VDCm6iz8OJf5Z0jdYmZo2goiVlHpQUOq3QGmP3dA88FVWT0Ube+BrAYnWsjF?=
 =?us-ascii?Q?UA0oCqQD6nSOVEbiQdjLRwmJA2eZBCe3cg3ezuweYpUG31UfABagdY5bnK2g?=
 =?us-ascii?Q?UNMxAHxzzZcHqsDpNulnsxaPOBt4DTGQWg9jh+wBlsdNVJFsVUjKRqNl8JhU?=
 =?us-ascii?Q?qbYD1DHIHzK4KwYcIX3DFnLKiT9BAYdPVkLVpBGrXblDofLLka19YKVVFM+B?=
 =?us-ascii?Q?MQYhw2ooLpeLGi3mAdKSfv7OuEjpFmxGX7su0HJ8bossC1/Jsz10m/phLwuh?=
 =?us-ascii?Q?7UW9qzEx0lo3uEM2hqbHumSTD1vpLJJtt3RrUOc9SPp/kwwNczNskg7a3u3W?=
 =?us-ascii?Q?MVJRogPVFr1FHRT2VGljEsDpaO1yrEXRxDqE0nXc9TKQbA3IYSuGTq9bPvAD?=
 =?us-ascii?Q?TSADHvnbeSEU66BNCgLvRtOwlW9H26GNQHjuQsyF9wubQpL7byIZ4sVDXtYV?=
 =?us-ascii?Q?dcTqCy8jawJIj2GpStJuNx3ukSD7Mf8sepoQJ9CAG4XI1g1Rnv2hcqDSTqc+?=
 =?us-ascii?Q?HaP/in03HMHkdOA20BD4Zbo9CvsTXnhd7lOUVfHmZaVPoDVJZ86/bPVy7vqK?=
 =?us-ascii?Q?w9FN4WbExG1HhFDv20XlIzf4YEp/dzCLRbnPQY23FNrJpqTNs4kBZ7url+db?=
 =?us-ascii?Q?myk9xZmHmPY2I81iEj7dFndTd69uTjtGtkZVLIufv+ftYM7J+rvqtzY6RNfe?=
 =?us-ascii?Q?7WlOhO775dfiTx+w0u9PsD2HO464B9iDF7HVwOtrS783yaaA1cyLjZc4gxw4?=
 =?us-ascii?Q?CPi8nRK5MxOog9jbIXdsSUOXhz2/wA4PkkrzT5uwC2Qmk0C6BX0p1k2P7hEs?=
 =?us-ascii?Q?gUUj/ulb409fBBoNPvnQEVz0JjRStK9GLPUKsXFTVErdR4JOLG8WBnSosqeN?=
 =?us-ascii?Q?/nIc3TR0nAvXfxVYaLXbZ5yFx1RqUTjoLSVv7GvFg62jAlNQfnQXqY+z9ajA?=
 =?us-ascii?Q?5iXXWQJQ68QknCYHTQsaGyZeQMJbcj54A0Y2ucU8Y2i8pFPJ+3aChiO3s0Fw?=
 =?us-ascii?Q?CnPBNGiq2MMNyENB+yEWndjKDet2TB2f5eZIar3OEEG7BG3XrrceuteI/teM?=
 =?us-ascii?Q?5QASR12oVN6UoDkTo/8y6nKv1fFGn6/2I8fBcrqTmWkWFNk0Ee7X1eG2MowE?=
 =?us-ascii?Q?wyWMdCwLxn8pDuyMk/q/7f0Pv6w5oB5tMqKPZfqgcBtIkRX+q5D1NFhuDUFd?=
 =?us-ascii?Q?YJM4VaBaLTJtlzyFcU3WKO1ay5dAaOMuEfcQaA/cvFiNWJ+TzKusuU0mdipQ?=
 =?us-ascii?Q?9K1DdpTr0CWu86eijSfz+OA+l1/py4BB0tI7PBll0cjVggEteLJqmtwwTGtr?=
 =?us-ascii?Q?iEICcfZIAjlsG7GxJl8AmcU20inHS4b5VOOrCr3z6WwpUli9L0596zFwvF6Z?=
 =?us-ascii?Q?+XXG/celB4R9U8WrUdembdzAx3x6TdP/rHJKPEpNznU9CxPQF3r4YDvdAVib?=
 =?us-ascii?Q?r5gYv8FL4wuty72qg8+UH3HROjqtJRGGp6wAwHwi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27515ab2-392e-4649-0305-08dccbbaf822
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 01:51:46.6526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vm3FH6w6F/zKLv4je6hDYmJQ6N2A/u21APnaqe70aOMQyv8MchrHEgrftL/6NY17oSLSBL224QgsmVeDxvbcAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9292

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, September 2, 2024 9:11 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle Valo
> <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
>=20
> > > > > > >
> > > > > > > Sascha
> > > > > > >
> > > > > > >
> > > > > > > Sascha Hauer (4):
> > > > > > >   wifi: mwifiex: release firmware at remove time
> > > > > > >   wifi: mwifiex: handle VDLL
> > > > > > >   wifi: mwifiex: wait longer for SDIO card status
> > > > > > >   mwifiex: add iw61x support
> > > > > > >
> > > > > > >  drivers/net/wireless/marvell/mwifiex/cmdevt.c | 86
> > > > > +++++++++++++++++++
> > > > > > >  drivers/net/wireless/marvell/mwifiex/fw.h     | 16 ++++
> > > > > > >  drivers/net/wireless/marvell/mwifiex/main.c   |  9 +-
> > > > > > >  drivers/net/wireless/marvell/mwifiex/main.h   |  4 +
> > > > > > >  drivers/net/wireless/marvell/mwifiex/sdio.c   | 81
> > > ++++++++++++++++-
> > > > > > >  drivers/net/wireless/marvell/mwifiex/sdio.h   |  3 +
> > > > > > >  .../net/wireless/marvell/mwifiex/sta_event.c  |  4
> > > > > > > +  .../net/wireless/marvell/mwifiex/uap_event.c  |  4 +
> > > > > > >  include/linux/mmc/sdio_ids.h                  |  3 +
> > > > > > >  9 files changed, 205 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > --
> > > The VDLL support in the downstream driver supports a case when a
> > > VDLL event comes in while a command is being sent. I catched this
> > > with this
> > > test:
> > >
> > >         if (adapter->cmd_sent) {
> > >                 mwifiex_dbg(adapter, MSG, "%s: adapter is busy\n",
> > > __func__);
> > >                 return -EBUSY;
> > >         }
> > >
> > > The downstream driver defers handling of the VDLL event to the main
> > > process in this case. I haven't implemented this case in my patch
> > > because I wasn't able to trigger it, but is this the case you are ref=
erring to?
> > >
> >
> > Not only this code segment. In fact, you did not add VDLL data patch su=
pport
> to sdio.c.
> > If you try to add the code and do test, you will know what is missing i=
n your
> code.
>=20
> Could you point me to the code you mean?
>=20
> Sascha
>=20

I only know the porting VDLL code in nxpwifi.

David

