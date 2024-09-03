Return-Path: <linux-wireless+bounces-12362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C459693DC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 08:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AE02881A0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6633D1D27A9;
	Tue,  3 Sep 2024 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4/JswDS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96B1CFEDF;
	Tue,  3 Sep 2024 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345561; cv=fail; b=aaCXPtkxpJ3x8AhNwVgZxeYxDsHl8tyanVfc97jQaxD7hQcUzu2NdP5us97dv5zjOzKvJiRU3RcecYI8EIzeoMhJxrnzbFaeP6/A1ZXvJ3EZB1tIxy2YHVGN36/mgQNJ0EDbZQPazIQ0Kl65j5y54tS3INBq2H6pM2wOpFxo0J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345561; c=relaxed/simple;
	bh=2bkAQVhMpCDVHMswjcVi6n2XyXTlVyOxk9c6aup4kTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qg9W1UvjAVv0ZCDH56Js0LW6Ye11FYHRp67jr5LAEmvFoOivguvbfK/J/RUT6Cb4PiMCselLy/Mxl2QTK1pypUCNMUTAxICIXoYyp2L3d12VGBOPVWIs1i81yVry00KpROuMx1LnDg2qlOHEriG7lI/pgH3Olg24obDeg6cFZFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E4/JswDS; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rehxdVPhFCYhufR2Ji9pWWcfG9GrASPdi/C0aINXsf2vJAr0V+JXeIngd3F4pod4AL8ZFWe36vBZhniHRW2bPuuyizH21KiOTHRG7ZVcubxGsns07kPcw6xBTXGQla4X5pyv8kJq37ScwqugOHcjMqxkUj6D9R5Y4NHSTwLWdH+TQmoS+Det3HjS33nHSEOOf2hKHjXTwJCWaGTh8CIx4Z40g556U8VBvwKgqTSATI1TnHCWwNYZKs3wPu7M7hq3bSIDm+P4BhbnR832QNNYp/MgqtIbASfQXmP+ABE3zLa6AXbv8XRYpVnCXxQUH7xCLf4DA7bFg1g+OR6pdE6w9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B0EwCkhcNPXS0zAYwUYt8IPXkJY8JLyUJm23jJQ0bY=;
 b=Vfyp3fMA/adNLb0nXyYtJGk2AnmCfTla+63fTMPBsV2qk3xcsRP07RBM6EEBsOft+m0gcf/LdOLaf7mPkP8BQ7Qg6xnDdv5X8WRK43vsWzI98a5Oyjq1Rhj3cU20d5+gOy7OnA/O0XVK3AvDlMNUeLPr5beKprf4UACVABPWpKyOy0rgrDWTgmnv2XsqiyVvh+w67el8xHOggAE6Urd65/5g/yiB8U4+dSC8E2YI2/sj95ixWf4IZZFwXNAzU2vK1sQdiG4+DJw6Va+y3/uvOOv38J41C1rnDtmYo0I80CCxMMb9ut9SvApzvRUAu32CKJkRUnEGDCnMwSjQASLaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B0EwCkhcNPXS0zAYwUYt8IPXkJY8JLyUJm23jJQ0bY=;
 b=E4/JswDSuigOPDtOY++58Yr+7nUkHv8o9qcxUZsLa/c2Jj0xG4h3vBg2y9bNdIaxmAfE2a/lBrcSLUXciaHRFRYCePrdPjn4uzdjUfKckoJKJ6EtGztfEgzKPhIFLQcmuK7y5fnxuoflyNvjdjL7gi17pawpJSyCz9H4lvzM+FuEIDHf+mDwlOdudzjqdEvM7XTcPplElr9QWyC+sPL1KXbyu8VqOburUUJhtseVXM1GqHjdmhHMwLzHA8lh410/NBXbWkedcw51+TIMoCDloVZCs6ajrhN18W9ovgMoK5uXSOOu1hmEEt4EfZad1RL8SjH5YQkbKlAxKvQQyICo2g==
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by GVXPR04MB10408.eurprd04.prod.outlook.com (2603:10a6:150:1db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 06:39:15 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%4]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 06:39:15 +0000
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
 AQHa94lYwasmKIL7I0OVdvDE0AaRyrJDyhdAgABM2ICAAAJRsIAAEAAAgAACqQCAAFg9AIAA03AggABPlQCAAAF7EA==
Date: Tue, 3 Sep 2024 06:39:15 +0000
Message-ID:
 <DU0PR04MB9636EF4BC137C95F70594E9DD1932@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
 <PA4PR04MB9638016F363BFF87D62B70D1D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVd3__wfm6EOOgH@pengutronix.de>
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVtPJSsIr9eIFWv@pengutronix.de>
 <PA4PR04MB9638ED8FA48E352F7246127AD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtW5fFocfr9_WgGD@pengutronix.de>
 <PA4PR04MB963814F85BBA6DD39F516469D1932@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtatnHp_7FBSSpko@pengutronix.de>
In-Reply-To: <ZtatnHp_7FBSSpko@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|GVXPR04MB10408:EE_
x-ms-office365-filtering-correlation-id: b0e34ec9-79e9-4489-0dcb-08dccbe3212f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gxXKNHXUj6A6EuLNxbP8gE/cZ5EmE22gWHZnXq0D56aDz1ILvBRYT63DE+bX?=
 =?us-ascii?Q?xYq/QN9vsiwkY1Fl+pVc3gm+OYNIu2Q00hrKFi+W2Cvvet2NQOh12sCfSL6E?=
 =?us-ascii?Q?Ndkju9uqSZ3sWTqdm6v5wE1IsKRfZtV9u5xPBXrWpTol90tD69ZwQ/t41Xpn?=
 =?us-ascii?Q?6JbUunox1cXNoVsk2GaGqMa38e1Y+VPD46BF0i+twHuK4jq2HWuLxnbEx1od?=
 =?us-ascii?Q?sNBATd4MjRGhJK5WzK/qoWRaSu++IyVfZACXS5+5wfgVLuE6hIdQxy9JusPs?=
 =?us-ascii?Q?xz8LTU2IlikS8eKj1xnnRR5BY1DmPo4rUTufE6zZ4Tr03BCGV/+4xjSVPILA?=
 =?us-ascii?Q?Us/a38jjIT22ry6hz12ayAjb89/5rbGntdW3boLM4NPTg3928uT0r4obrNLG?=
 =?us-ascii?Q?7dIW5ctViWCunUigursgU1sVwz9lB+oaYh8d4pLLiqYj9w0llfqgYF3NriKb?=
 =?us-ascii?Q?T4E5r0RixXzJFwMtn4SbM4xNYbApc2NjXBJGaWgtrencsokwHZIzetJ91crc?=
 =?us-ascii?Q?j4+0UNe/Gi6kmjRVaStPMKWQBOPMG4MZCVBYI3qyfE31oJHXc+0Opa87mX3J?=
 =?us-ascii?Q?foGNhgdZJFpIoBBpv02+h1RtcOj2JotAElkDGMly/9c12OY/wMLzY9jw6fNw?=
 =?us-ascii?Q?hLaDjjkVmvGnhV7hHZyIvmz//U1nb8uJEPYYFBHKQZ6dX54mlFE7lyyHCtzc?=
 =?us-ascii?Q?ZR5Gc5cvYeZojDB67pldMNaVTwUzCG+jAqmpT3qeOrh8KyqKfefTlAAoUdZ4?=
 =?us-ascii?Q?bQxRkLC+cJEMDYBv9sXB/IMqCStxFc6t3eBM+gJiPJSiV/2Pb9Kr6Ab11MQR?=
 =?us-ascii?Q?WDcP1pyyXp5iWN3ZXgkwaUyVnSHGVS9vVxX02/pfhUW2RkJWA0+uFYqznOp9?=
 =?us-ascii?Q?CSgUKK4/3EHLS0/4V2oCUtW2pCsDPOCOoftkzwCc5+uYkVsEQdVf1JlCOmBX?=
 =?us-ascii?Q?ehyWdLwc44wnDF1XDVQBw8j5ntH/cfqMzrkw+GFjMfS6km7eTNiLi2LDiq0/?=
 =?us-ascii?Q?lISuZ3Cv3jdZbvlE0RM1domyBmrJv+CdexufcjNSxy9eonclUSdGDoVOH8VZ?=
 =?us-ascii?Q?ANGzvCA6fQuVXYv5OQUIXqgeOD2TrA5jr5j0a+ws9aUwN2soOhRKFOLszObJ?=
 =?us-ascii?Q?EVLr9iSG6GsyuVtfOPxdpklcly+dmGXRBSa6aqtTdjXuwaF9qekZESyZ3irM?=
 =?us-ascii?Q?SnPB3KEzHn34qPq4eeYm/ODgi3+51G692I7riHztBgT5pXlAnzZ4hXHvOf5G?=
 =?us-ascii?Q?mOMQhaMvs29aETxuyzRhpJ2kDhKbmnO/mwaMX6Ik94mQPTn1BIShVbbLK+2y?=
 =?us-ascii?Q?+Cv/vnkL7BnfEaVmOTCJZK1VDnuw9DVYirGStPR/Rbkq4Po13K16zoBfsT8u?=
 =?us-ascii?Q?+pRUETbibpCWsSVQw9EAQjg/IyJGPoJBlCvQaVaS3dB16ir5WA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9636.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f2Kt1SqXx5tEdDF04douSpbUy7EIAvUhJ9EqdBMeD1TDaMtNtkwmqgILqPsm?=
 =?us-ascii?Q?LBUinR2KwnH0WDdN7IZC9gX/+lFBY+EmivIzpMIIFb07/ys53gFPfY3HyLX2?=
 =?us-ascii?Q?jVgRjpr7w+uwkFfH2ODazr4/WtzJhfMPVqZ3dLMX4M6EzIoTnH/dF307liBJ?=
 =?us-ascii?Q?/V7DqJ4UR8+xwlJqw69h3aWtXCdM5U9TMOIs7RS2tbiL89Bld9lqVdBS1h0R?=
 =?us-ascii?Q?YzkmMXd4NObQTyIWDyRnejl3WXW6gPvGHvp96af1WsxM6PO7Y5ypeSRxmyX1?=
 =?us-ascii?Q?nvlsuBmnFp0AxUrUc0epAwXKuIeIFPucNVaEW9ea5voyce7d25wvjsyfDVsO?=
 =?us-ascii?Q?7j0mu4D6eXVSM70J1oX67Umw/5X4nVG03TdKzbXyJazGanrQRsTVFNI+baE/?=
 =?us-ascii?Q?gUHv6DTWPR71tPDV5YgJTiEGdHZ8ZhWDSi4vHR0RSP4G1czarrhFMMWg2Qcy?=
 =?us-ascii?Q?zQ67WSeerh+9jTSpdCZrwRRdoA+DOwrmADjWPENSPhYAPjnC6lIlzeyISBWT?=
 =?us-ascii?Q?iyojwfyPebH2IvposoJEl+uYwo8COOHM8//5npo7s9iXhX5L3cj/SgQTID8J?=
 =?us-ascii?Q?kumjP9T4+Mot/o4bLJ0yMD4ZsPbpn7etduScVK6nnL6VMJndxA/J6LfTcVHA?=
 =?us-ascii?Q?+LEWSWlqiFZVwKLurDyTZd2wpyz7GzQyTBtdH2/ULubjbfl/WZHD74TjzBJy?=
 =?us-ascii?Q?BZDw30NCMk1Rgx64CtXpJFpQpNaO/vzF+xAf8xUcN2fcDlzvJVIEzl5vonZO?=
 =?us-ascii?Q?uVmPM+TfnAUpu9+jznB4en/XLOwOebvbfpUwG/0GgXrpTsB8nBtbmueHzXKv?=
 =?us-ascii?Q?+7Y7Pu3Zs0CT1lwlKqqtUW2xaAsQL65eeLt2yszEOIcSf3Y7cEmmzqbAfx7k?=
 =?us-ascii?Q?blLirS8CTLQqKMhTVAydAScg/aG/+DDVgG2YbBQG9zJTG5HoPWSAkhnvNhNS?=
 =?us-ascii?Q?KcXPN15lsH6fCvXS5G3DDW8V+WldwRUjFe66m/RkKvQ7E8eDQ1IHDF/b9EmD?=
 =?us-ascii?Q?L7Mr5x2pYDR843wwY6kGQLhiiHJhFYIXga4o1/lma2M3Y1hGDKlq2mKRpGjb?=
 =?us-ascii?Q?yyzEAwu/cRM+Ly3XDz0d+uQwJHzeeRdS7rLyjbHcerpWakJ0SjXIfoUa9toj?=
 =?us-ascii?Q?Q+6KwRkoX0HxXpAJuQZB+IGr7HMLKxTCNFjRSuAWx2svV4E7RU+3RLQo3QX1?=
 =?us-ascii?Q?t0yQpU2Lhx+euPRH69GaG/V2tDvdfiPhilCztx7fgMjRfvAAhpRBGlB54rtG?=
 =?us-ascii?Q?JJ0iroTnw+Bw+D/3ns8MeqtRy2AaSFXgnuxDuws2Z15DJUW/z0EKcdt9HoZO?=
 =?us-ascii?Q?iici5KekIs7kcalKbMbw3NiCgaXVveMDV8gX+iAVccufu1W5UjFfG91Obo5k?=
 =?us-ascii?Q?sVpE+x3T/xnIbaWP5yM5aZ73zU0FWaGvz5YeASr6VPi1kJeiEzUPRC7Mm2oa?=
 =?us-ascii?Q?1JaKyf8QwCN1IkQlnvCL3hpAl7wCDwh7T1I/dpeTbPaiyHlIWN3awUxD/3py?=
 =?us-ascii?Q?3ymrXDXgR0BOROyWO5RLbPmM9oq7EtJI1E5IuLBYs58bBnBlaEvssFsfT1e+?=
 =?us-ascii?Q?HNY898edcZek2+/H79l6jjnrYxK0QYD5H9+JoVxj?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e34ec9-79e9-4489-0dcb-08dccbe3212f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 06:39:15.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ejd3c5GTL5Kn4CjE4oi9a/Xj6p9tqmAcdTeZPKmdQLcBfW7tR29yY9TUFxBBrOdNZWX9cutuTYRKx5tmc7n7Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10408

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, September 3, 2024 2:33 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle Valo
> <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Sep 03, 2024 at 01:51:46AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Monday, September 2, 2024 9:11 PM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> > > <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle
> > > Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > > Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > >
> > > > > > > > >
> > > > > > > > > Sascha
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Sascha Hauer (4):
> > > > > > > > >   wifi: mwifiex: release firmware at remove time
> > > > > > > > >   wifi: mwifiex: handle VDLL
> > > > > > > > >   wifi: mwifiex: wait longer for SDIO card status
> > > > > > > > >   mwifiex: add iw61x support
> > > > > > > > >
> > > > > > > > >  drivers/net/wireless/marvell/mwifiex/cmdevt.c | 86
> > > > > > > +++++++++++++++++++
> > > > > > > > >  drivers/net/wireless/marvell/mwifiex/fw.h     | 16 ++++
> > > > > > > > >  drivers/net/wireless/marvell/mwifiex/main.c   |  9 +-
> > > > > > > > >  drivers/net/wireless/marvell/mwifiex/main.h   |  4 +
> > > > > > > > >  drivers/net/wireless/marvell/mwifiex/sdio.c   | 81
> > > > > ++++++++++++++++-
> > > > > > > > >  drivers/net/wireless/marvell/mwifiex/sdio.h   |  3 +
> > > > > > > > >  .../net/wireless/marvell/mwifiex/sta_event.c  |  4
> > > > > > > > > +  .../net/wireless/marvell/mwifiex/uap_event.c  |  4 +
> > > > > > > > >  include/linux/mmc/sdio_ids.h                  |  3 +
> > > > > > > > >  9 files changed, 205 insertions(+), 5 deletions(-)
> > > > > > > > >
> > > > > > > > > --
> > > > > The VDLL support in the downstream driver supports a case when a
> > > > > VDLL event comes in while a command is being sent. I catched
> > > > > this with this
> > > > > test:
> > > > >
> > > > >         if (adapter->cmd_sent) {
> > > > >                 mwifiex_dbg(adapter, MSG, "%s: adapter is
> > > > > busy\n", __func__);
> > > > >                 return -EBUSY;
> > > > >         }
> > > > >
> > > > > The downstream driver defers handling of the VDLL event to the
> > > > > main process in this case. I haven't implemented this case in my
> > > > > patch because I wasn't able to trigger it, but is this the case y=
ou are
> referring to?
> > > > >
> > > >
> > > > Not only this code segment. In fact, you did not add VDLL data
> > > > patch support
> > > to sdio.c.
> > > > If you try to add the code and do test, you will know what is
> > > > missing in your
> > > code.
> > >
> > > Could you point me to the code you mean?
> > >
> > > Sascha
> > >
> >
> > I only know the porting VDLL code in nxpwifi.
>=20
> Yes, and I asked for a pointer to that code, some function name, or file/=
line or
> whatever, because I looked at the nxpwifi driver and don't know what you
> mean with "VDLL data patch support" in sdio.c.
>=20
> Sascha
>=20

It is better for you to check MXM driver. It is the same as Mwifiex which s=
upport all SDIO modes.

