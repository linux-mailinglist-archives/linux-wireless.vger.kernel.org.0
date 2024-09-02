Return-Path: <linux-wireless+bounces-12306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F0967DC9
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 04:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4489E1C21887
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FE4282F7;
	Mon,  2 Sep 2024 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c/d172AK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48F224EF;
	Mon,  2 Sep 2024 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725243898; cv=fail; b=rgiHJalvYhgG6EUQ0OZDnfJyU3tp2I9GYKl9sEfcL5zr77V9prVeIDKnRLUVFGM3C4eF0UNkfAOgzIRb0Wa5n080+6V3XoDTGMTwcHa4Xt+r80BINcOPyMK0Jwx8TlRkWCJ1DMSFKR6rD6hrAGbw1tNlHJgrSA/CjMF0sw1/L7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725243898; c=relaxed/simple;
	bh=X74DX1kBdoY3GTFd4UjkXCTiz+NkIx1ltr1/IFY/YKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GEzmCA1pK3VIUpgXagi+RuzVbhYE0mq+Brrx6kmon8gr/463BKB1EQsez/X83wxw5CVovOmz7CjlcN58M3JpbkvOQAvGitQDcF4zUG5JKvMiVZ6PnZsg1BlpcxIZGMNu/uHp8PuEzVC7ObS50XKOHTPnV+Qw5bD0fiNvO2+Aq3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c/d172AK; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dc4teilddrc5LUFnuqEbmwxIo9J9fANMnudi1V0EIV1RqdaR7rK1w8HZ360e7aES60+64VlidwVHHFTRSm+d1ac0BHQXUc5fGC5O8jHvT93E6L2FyxDxdDpCGp7iRweIrwrzenSMdrjuXHaaqCDItxspZoMTq3tIM0++Hun1Tvk/SZmSCRA7PGycdWpQOhm8l6sqY3jERe1vRu5Cga/Zs0U5RrNKbFFuqts2asLCqyANyO+8yXnRHufEiWe1LZehuNdnfougy/Mxm2roekunMkpO3ZIyXXSL9ha71U3zxr+Oqry8qgXQvF2/4SmQvFtG5+73sCyOKSLCLr/7INO3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XZQL9InZl1g5UORXrhLVa+UONWprhSAGxmLdOuxOKM=;
 b=k4j3vpK6XUvp5+L1uEurIdIz/BPu0smZJEhlBwTYRNvuucYshM3999JotWo/uFrE7S7QnFA+OCPNeujn2uJpGsrye0249Lijz1c6QiWJlPV/cchyKq2UBxTyg3VxK/2+tyVSmdhCiKFZ013XjYif2r6PGtTY1HPDxagLqtpjOwe+HLIWakzHeJ5VWmSBFhrixXOCciFOyzCPJ6Ds+q5u/AYdgfDZBTrE/ss6OMf3jHkdmn7/LmX2PZzXKQSxnVnJYTzrJCmceBp65KfQA/CCUXmZc7nGsGESJaAa5TgLjPc3gNLi0uhVqrqPU/5ALAHf2LRCSEHAVpNkzU1HogzOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XZQL9InZl1g5UORXrhLVa+UONWprhSAGxmLdOuxOKM=;
 b=c/d172AK5UIKZFc8qXcxgr5IQhdujdF8Hnhh1sWeqG7m8Spvf4F4LwSEGQ7I5FyUm5dtPNRakef32vI0hhF8K0B5ZV8++F3FpQhw473oV/CpJqHTS2h7jY0ymMQN0zV3myLMDizpyemxksr9/awAwgYHOi2P/x68D+yVkGOmvf5C8whyFz0N+LGCNhF/Wn+pnvIDeKCBnMxSaEyz05QPnIrorkF0+GTMHKsVZXKnsOf/BsNAyfbfs7itFFtIbWowVqCVEt5NXjFH1V16yKQKkcm2O0VwusYaoCEzXuo3lpiFxgPff9YDSE3t77mxHL3DeCwrK3bNib6ftYgOK8ZpmA==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 02:24:53 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 02:24:53 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, Francesco Dolcini
	<francesco@dolcini.it>
CC: Calvin Owens <calvin@wbinvd.org>, Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Thread-Topic: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
Thread-Index: AQHa94lYwasmKIL7I0OVdvDE0AaRyrJDyhdA
Date: Mon, 2 Sep 2024 02:24:53 +0000
Message-ID:
 <PA4PR04MB9638016F363BFF87D62B70D1D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
In-Reply-To: <20240826072648.167004-1-s.hauer@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB7966:EE_
x-ms-office365-filtering-correlation-id: 8aa9679b-0b31-4490-4d1a-08dccaf66dbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IQADIUkLr9J7P3T5l8pWhX7Pu60yPQDL0m29JoRvAucEw6K8gQNXr0MSorm8?=
 =?us-ascii?Q?eOw/16bGWOhwgK/4LqlE2t1PvqSOFPWE+wu8aH+T2N0gB8PxpibjM/nrfD3t?=
 =?us-ascii?Q?EcktdMR90kaaVNzWnI806gUyggum1z4NN8aQFnODLyvbNMThai6QyoB/z0HG?=
 =?us-ascii?Q?nfS4FejPFMGQm34PveIDerysv7GekDnEtbcUgOW5Yb/H+oHc27QatSyqdEQ9?=
 =?us-ascii?Q?Y87OALvTO5HRQvGvTqfAx4Q5TCswxjByRg0mtMsczrzcGzmJM9Z8NQGxMBGC?=
 =?us-ascii?Q?MFSexQLsaobSynzwIEAkee1DHJVB3O2cA91+RgMNxYBiRWKnYHmHTYsC8Fba?=
 =?us-ascii?Q?lM9uWhnOj271VWNCAczX1YjYJe+bKgOhkCOehDgtXzEDPDOfZ+6A5Eyip+NO?=
 =?us-ascii?Q?RU+lkYEa85Duq8/0x8Hp5DG+tgGB9SnOnhahHETdnMtSTGMiFwhiBdxRWrkM?=
 =?us-ascii?Q?CIDEzQZY+u2RxGn0Wt7XN2m8hte5fCjNL3x35lM5zAy6IOpdrfucHd6XaW4j?=
 =?us-ascii?Q?aoPaD4jqY7AqEAvo6GQjxziOua9xQn6b6hNIkYhTF+CMlVIn7w62P6cU4Dad?=
 =?us-ascii?Q?INI5p+Ph36uFYT2eQW4iPi3BbfLE2WFDn1sX8KsVhWLi61o5tWMEqbeG4ZCb?=
 =?us-ascii?Q?3ywZAtWbtbycoTbDUw/hTk7UFIuhs0hgMW3YI7TeP+VAjv90k4xo7sR3Ums0?=
 =?us-ascii?Q?IyZKX0jxiQM7du7XvwK8Dk8mH8A1K6luC3D58GiqpFTzzxXWVIpWJy2H9iBu?=
 =?us-ascii?Q?ZWGtW/K9XmpUopZoux8MU+va2wivcKDCggoJKq3pzUifiBtMFEbGokqeUp4d?=
 =?us-ascii?Q?87e6CV21nLUpRpISW52c/27JGpgrO4rgjh2kpaerzrKdeJ/4BafkV+C7koGd?=
 =?us-ascii?Q?N7K3Di+ZmNjMwbMnK5boJkHiV5wTUL9hIwLhzNwm8XodRoExaYSIOk6AblWT?=
 =?us-ascii?Q?ishrmd2tqk+yj6UKAaJhm2rJNrMPK8pYUz0tFULxCpMntWc6SGo5IY2kF3mw?=
 =?us-ascii?Q?uqAEv41p5WSbY8ieTzPUbNJP0NYghOu5pBojD2bWvjEUxa9gAZOtKp12fFBK?=
 =?us-ascii?Q?6pazQcB0fY9xayrOmdO4F3fvIuUI9EDW70VUvQ/eNonsJ/RCeI0da04whiWa?=
 =?us-ascii?Q?AFRRcCRk6ZVi6/D9qOhjh3b5vFtDTKwd7WgbKAYbAB1OpdBNA5iw+ZnNKP2o?=
 =?us-ascii?Q?Na2i3JW2KBh7MS1ohlZn8cMIMJPCbH0RQ8VAkErrngx8Dra03WYymK49zINf?=
 =?us-ascii?Q?bPO3SL8J77N+6ciVM6aEI3zqz0vJhE33QHP6L/0QyhGZvGJ8Nn2oB5ceA1NC?=
 =?us-ascii?Q?ZOnWbGlT1AZ2neKUbLNq6aVgZfn3hvTtD3+J8MCDPgUX8w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g29R6NSPoQfPJY4Alcm7dyTfMV0vKmz4+uubN148jTnkfag+fdBO/cMAou1E?=
 =?us-ascii?Q?skL7t+N3fo5uxQN1aantbT5OIalLONuTUq3AZ0fUjNwko8WA/Sw7jOHanRkt?=
 =?us-ascii?Q?DeeYu/7QVpT3ZgPr7vZWgw59roisYdlQnmUy2ScmOuI6Yv47QogSC1TC2EWe?=
 =?us-ascii?Q?F1BOxUZZbcQvcJwqaWrYz+jqOiYjKIi4VdAijzSl0H2FVpTSvvpi+DEr79U2?=
 =?us-ascii?Q?528qWzTzWsjMSxIgWHV3IBd/x4hZWIA1I93L9XpABshl/feInoeISaYwnNVV?=
 =?us-ascii?Q?AFhkwQp2iMsl2R0Bzn/sMvoWXbrvRGqef6rKJFagpgncThRnt8hbd51sB2xZ?=
 =?us-ascii?Q?cBrdqS+WJ4P9LHzBNY5/L9esqKKmpMpyFhuBqqvS28adamfUliR8lKCs4lJf?=
 =?us-ascii?Q?eObxb+XL+nY9S79J/O5WjXgNBtOlEdQ+HZDji8QjEUCfrobU9Rc8Z5SKas/Q?=
 =?us-ascii?Q?XVXdI6tpZKwrrrPQeW9LMeambrhjdMzr6fetJfHSVb+HGbvt1dzojWmUPa5u?=
 =?us-ascii?Q?/byG+0olBCEVofXFg7dVnN4pLXsveEuVgcVN4pYGDDKCrDvcLwqi7kshhGMn?=
 =?us-ascii?Q?Xbx3RVP/rv7miYcB+bzQy/DXRg8z622zZJ/oe3weUClv+eDlQyUy0WStzaJL?=
 =?us-ascii?Q?I5vPGDoqPzAgrFozTzfVDqq/dLV79sYTd5uFnM8edFzJJy9vOpStZ+yUqqno?=
 =?us-ascii?Q?RWLtJMhW76yXGJtx09qef8WNDmPaSrh7RZeWc61NqfeI08Kraeqy7ZWZptMx?=
 =?us-ascii?Q?RETdqgmVmxNmTHr8wBxFNoW8h3IyGkuHcsWpGy/RpTq9p2b3Hiu2p0a6Dz9q?=
 =?us-ascii?Q?pdWVXVhrnWS86quwfoYOcTRtAp5oYeC9DgfHoJrNhUzcBWrZ/rWv+SkCsg/2?=
 =?us-ascii?Q?15mnG03H8I2ekQ7LPEyT+E5HvMnYyoIyFhsAMNQJqxFSLbTwJLTuADNoo6L3?=
 =?us-ascii?Q?19k5zBJdO4uAts5JCM7heJatsmIP4DwNnbY4JSUguIfVoEzJT9rkdV+qw/5q?=
 =?us-ascii?Q?ID+IBy1cB+tRknKkXWi8ufoLHdgUy3y2f2IbjEXdW9zACrECROheELtZgdvs?=
 =?us-ascii?Q?8C5fBk4dRnyOFAOMYloYxaTar/vU5WHyriOfBFY91oWlkKAOWmmCeTfGVZK8?=
 =?us-ascii?Q?RkbKdsWPG+e0UJSLF0vcggjb9PdlRwboRXJOkqHbTPE63JczmPFLzeH93Wh3?=
 =?us-ascii?Q?Vv5ysQC5NC27wJSz5laiELg2mN7YGuY1PY3350ch7CER9tTMjnGub0tPglEO?=
 =?us-ascii?Q?JqfqF4G5SPkORGN+okXLHtBtnYck5Z5XeSqqCNQeTVu8N4o0bWigviLOtKvo?=
 =?us-ascii?Q?ZUIZ5Y4LC6uXWrV6ruvMoIWuCoYzhEl+ubCYPawt3V3khThlvZPy2gRUTsU3?=
 =?us-ascii?Q?Pkd0lM/qZqSR0vh9OtI7UNDBnRVUAnjECGXNbLsBLfE2JzSQ6wzA1kz1YoJU?=
 =?us-ascii?Q?ahobhBIZ+HsYCW/2L6V286Hth37aN0QW14/kYp3Ou5WlGMSFF8ip+Ca2I7k2?=
 =?us-ascii?Q?Sjbyjl0taO8qMtjGeaYwwcTiSAFyKSRk5wF8Zx7oCGm7bLf4D3+tOlptvKBX?=
 =?us-ascii?Q?82Oobxdb+wvkpeLF8ssfd3W3nswgVT7znDpxdCdX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa9679b-0b31-4490-4d1a-08dccaf66dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 02:24:53.1617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4C2lwdsJsg5dT2kEoi5IopdQhuYG9TVMbzOHZkotz5YX0vrq9T4/c5/klE5O+QLYRnerBikvy1aXtrNzKReGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, August 26, 2024 3:27 PM
> To: Francesco Dolcini <francesco@dolcini.it>
> Cc: Calvin Owens <calvin@wbinvd.org>; Brian Norris
> <briannorris@chromium.org>; Kalle Valo <kvalo@kernel.org>; David Lin
> <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de; Sascha Hauer
> <s.hauer@pengutronix.de>
> Subject: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> This series adds support for the iw61x chips to the mwifiex driver.
> There are a few things to address, hence the RFC status. See the commit
> messages for details. The series is based on wireless-next/main.
>
> I am sending this now since people requested it here [1], but as it's out=
 now
> feel free to leave your comments to the issues mentioned (or others I hav=
en't
> mentioned ;)
>
> [1]
> https://lore.kern/
> el.org%2Fall%2F20240809094533.1660-1-yu-hao.lin%40nxp.com%2F&data=3D05
> %7C02%7Cyu-hao.lin%40nxp.com%7C184ab4fed58647150f8508dcc5a0789a%7
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638602540229716119%
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DcACBHxaQvcOqu6ri
> BoAlZDONRlGQ4j5DcglEV9T%2BpYU%3D&reserved=3D0
>
> Sascha
>
>
> Sascha Hauer (4):
>   wifi: mwifiex: release firmware at remove time
>   wifi: mwifiex: handle VDLL
>   wifi: mwifiex: wait longer for SDIO card status
>   mwifiex: add iw61x support
>
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c | 86 +++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/fw.h     | 16 ++++
>  drivers/net/wireless/marvell/mwifiex/main.c   |  9 +-
>  drivers/net/wireless/marvell/mwifiex/main.h   |  4 +
>  drivers/net/wireless/marvell/mwifiex/sdio.c   | 81 ++++++++++++++++-
>  drivers/net/wireless/marvell/mwifiex/sdio.h   |  3 +
>  .../net/wireless/marvell/mwifiex/sta_event.c  |  4
> +  .../net/wireless/marvell/mwifiex/uap_event.c  |  4 +
>  include/linux/mmc/sdio_ids.h                  |  3 +
>  9 files changed, 205 insertions(+), 5 deletions(-)
>
> --
> 2.39.2

I think you ported VDLL related code from nxpwifi and you also traced our p=
rivate/downstream MXM driver.
If this is the case, I think you should know nxpwifi already cleaned up the=
 porting VDLL code from MXM driver.
I check your patch quickly. You ported the new SDIO data type (MWIFIEX_TYPE=
_VDLL) from nxpwifi, but you
did not port the code to support this new data type from nxpwifi. In other =
word, you did not test your
patch before submission (same as some of your patches).

Another thing is that this new SDIO data type should be handled carefully w=
ith other existed SDIO data type.

Nxpwifi only supports new SDIO mode, so the modification to support NXPWIFI=
_TYPE_VDLL can be clean and
simple. If you want to port the code to Mwifiex, there is no one-to-one mod=
ification of the code.

Another important thing is that you should consider if your modifications w=
ill affect existed devices or not.
You need to check if you should check firmware version or chip type before =
adding some code.

BTW, no matter if you add the code with or without checking of firmware ver=
sion or chip type, you should test
your modifications for IW61x and at least one legacy device if the code is =
added to Mwifiex.

David

