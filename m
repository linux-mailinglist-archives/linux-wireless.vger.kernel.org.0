Return-Path: <linux-wireless+bounces-20806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6144AA70740
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C1316C485
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A89325DCFF;
	Tue, 25 Mar 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hq8toATw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2F25EFBC;
	Tue, 25 Mar 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921019; cv=fail; b=Ip7XV4rGy4oNP6j23oP4i7TXGkywCG5P0Pl4A+PtiEjptl6BNvFl6+aTeWMOfRlWPT3QMbdvUqd5R+K/YUHPNWB8f/2TSkv8Cdj5anATBXtY6BT7KOF0ND1toy5Sk1ItbEyxkTEGRrQid3vjAHzzZ3sQROCOyXEZk/SwHDOb6Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921019; c=relaxed/simple;
	bh=gEIqIvjFMAa5a/ikbFdC4yhLqKQBRc2jSfBeUSC3+rA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sjt5RGLViFCUoUOIwCAStafvQrSyQ9lnJ30j6s3hohGocnoXU8RwWpEfNmaJWuEHP1/ucT9eEGAcXhySK8rdJ8jqjQjhZyRZRsbAyM2pIwkJy8v0yQ9jQr0CSBzMZRgu2hXmL15ki1P9+uuPVUJymn/dScjKeGb+CeQd3gFMdsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hq8toATw; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbBFXNuERlrZCAISGp5SaeMyBCgvVX3ujaKWY4F5Wz4Me3qs3S0QMZXD8QyR0TDffyCfzEPwjtK0Wh7NMpVpyBay4+et0KSHWN7EKe8GJZABQ0ZRaT7Mdsckb5314Q0N9Moq89pHase57/ovUI8KkDa04YNrdhnnUNCYtyon2jzU2f/sMddXtgkt00sG+KZOs1qT9QMOg+F2xjdNZhvCiFxaRLERObqJgdOAEZS5b9MhmXr5UMwdKr/45MvHuQYKCoLUICYfrOXFzGyUwz2an2nG2ouyjoqQHFQ5Tqi7t1waRCQKqmD2vLGKnRPACX8e6M+oETzz1k+c/uWrX/8FXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEIqIvjFMAa5a/ikbFdC4yhLqKQBRc2jSfBeUSC3+rA=;
 b=OgHWlX25/DdaPmsR9ChRXGsFWLjlNq4d3SxyeNzvJKge+3ef6T7jwRbzTfIrzoKpSQ7jJzbDcLRVnsCtWdV/+B1H7AsI4tcLOrFXIs41lNGZT9OtPH/288jBRMLM1d+sgOJEBBuVUBQalICzQodyOWCfkaUH4mrb8j3gPQzkus1CQyXlHfZX9a7+CazTojTH2metgrmFVbDulBcUEobhRfM5WjxPF22X4q2KhvBMc8ZYxRV+h6+X+bpBbpEja21iqNmxoL7rg72UOOudRxzx6B3PJyJOrbnABM9g91vEVZRhqC4sMPRZr9HLoR/vOK7sk/jsVHMfl6ySG+Vl22HoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEIqIvjFMAa5a/ikbFdC4yhLqKQBRc2jSfBeUSC3+rA=;
 b=hq8toATwBO5VWjG4N6jw7wwgtBnKR4XPLyM/K2vkV01yGFexbu0Hi0rWAH7w03LWmbIAwTXp0FL2ZbYSkhuNrtH2CuNFVxK0Euf1EaNkq6ZHWvJVeFg1qao93X4Kh9rvMpKSsetdAcWk0d4ymnHOLTamz4w7jHsGPV0I/fCEH9RKzpzC31VuEbbLKFdVAYIDQLyj+yyghY81s5yg8QqyLbUPnIWcHy+tZOdNf7/+dEL4X4BTV1E2Lkf5jXARNG5U7OCxLM/OdAE4sH4K6kemQjb8nZrtDqvsrXqJvqAXvf4F47UsCjJ0o+u03iMvN78sN5WSVbBpdWcUmPZ4Gv9VJA==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by DU4PR04MB10695.eurprd04.prod.outlook.com (2603:10a6:10:580::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 16:43:34 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 16:43:33 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v4 1/2] wifi: mwifiex: Fix premature release of
 RF calibration data.
Thread-Topic: [EXT] Re: [PATCH v4 1/2] wifi: mwifiex: Fix premature release of
 RF calibration data.
Thread-Index: AQHbl8PMECehi6j1KEedBcEe9Ioz87N6qGwAgAlvj2A=
Date: Tue, 25 Mar 2025 16:43:33 +0000
Message-ID:
 <PAWPR04MB9910FE139C88507DE5904ABD9CA72@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250318050739.2239376-2-jeff.chen_1@nxp.com>
 <20250319162842.GA46894@francesco-nb>
In-Reply-To: <20250319162842.GA46894@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|DU4PR04MB10695:EE_
x-ms-office365-filtering-correlation-id: 7d50959e-ab21-416a-858f-08dd6bbc2e8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Qb7EfW0NUl3FVZU0740G4gi0bQExgTTTAZvWyyxqIhzHwSFAE0j5UKaSjrNJ?=
 =?us-ascii?Q?ItjDueZ0KBf2YHOXo8EeYXVNMptMtokHCwPA1gzs6UCHldmXoRE5WfLBUo5O?=
 =?us-ascii?Q?b8KoyBPG8d8vhb6A+ngoTqCDgfJsE5Hgd5Zi023+EsRQyp4wW5sjCkE6fI20?=
 =?us-ascii?Q?faKEolM85uG0Z7zahWubsq8kv5oAwlyOfoo/RNIPP+EPicAtuL3OtrxvuRKg?=
 =?us-ascii?Q?KOk32sXFNeqw/CqPk1t5mFSC9fNWnzF0Hnpw3DBG1cXZe6MJk++JYIm1MigF?=
 =?us-ascii?Q?JlScPA5p7T7aelAddzw/P0JMfl/pkIdnXGWz0PmA12qpIq/cKX/W/WSuvNHh?=
 =?us-ascii?Q?3/FL4QvC4z40WZ6QgYKyjMDHuiklrgDn1tAqI1g7mM8BFuW/5hrbuxt3k7g3?=
 =?us-ascii?Q?QK7xLReRviXLl0yO7lnhyyfaA+pM6rd8ECns5qeBMc06r7Qx5CEEjWY0Q5r3?=
 =?us-ascii?Q?FN8LZxX3hsZ//V65L5ecRvGp+tyouo4gRLlZ9HMTo9dTBEpsJSIfcLthddqP?=
 =?us-ascii?Q?AlJfJ+vNnRMaUjCaYDxKjdwtTM5jePnpaq1n/R1nLs8zQyVH3xXQRPnPbQH5?=
 =?us-ascii?Q?upGP64emXUT4yzTS9NOG811wwJK6Sf8ANnYU77/pIPTxNBxR+yquKUrag5hu?=
 =?us-ascii?Q?PaBeqC5N7H0xK6VltfptJqwBp9FjZ2asWD3kLIT8GIndWqgKNm2tNpA2fMKh?=
 =?us-ascii?Q?znT+Ks/Q/T7LJUb+8iNj3vLnyo9SPLf9BETjG7XFhpw8n5qRV6aRIlRkqO7x?=
 =?us-ascii?Q?lrYliTLlMHsLUJnk6zr4Se9fxhKgbG1hFmuVIc8dx2NLhQ+5XDm/yw/fiNZ8?=
 =?us-ascii?Q?KIfrknU+xnN77hO/AYi7PpXm1FYq9vlJO+cJi8/eEGHx3SuqBUwgAhwcLUv1?=
 =?us-ascii?Q?T8nafovVnf6ETtyWeM0RihAVeGMqP9sqhk2zZeRxcfgYNrseA00Egam/uKYF?=
 =?us-ascii?Q?0DkBPsOu7uXDa4BXTNsEml48VjuvCcmCukAizO7psK9JMLOsqjG1gO2XC5WO?=
 =?us-ascii?Q?dLhatLasTHJUNw4L9Mpe9y7REb/tp/RMSJsQdN5Ew+UsDLdrF2YEc4YX+NIK?=
 =?us-ascii?Q?2j6cCwx+0KAYV4bpN9wp6wlJApwtEFctu2P2hcvUwF6z9eWB0HqgHd4gzOvG?=
 =?us-ascii?Q?hXBa4k13Hl4HBqVUOsSganJlOrNqA9GqatJG4wmnMGlWsceB+Jz2hg9ofcnU?=
 =?us-ascii?Q?WJZkVlmnG4y+cKnZsbuv/OrMKbhTSqJLaiK1DQuxG9Gt563YojXNMtx95nrZ?=
 =?us-ascii?Q?KGNMu/aDsSh/c/AdJ5eXAAGnhcVFq2xxfHvknS2bpNUdlR3l6/Cm4DJQM2k3?=
 =?us-ascii?Q?+l+mW1O1mErhdQsnVIajTefBogFsXq4Q+I2Hdii/xBoQnMHh5IZBuaReyKvY?=
 =?us-ascii?Q?f6xerjIl7L/ABrqjRB84h5XixTCCLo3Fw0OFMMatyu4eQ+XefL+QL7OhstI4?=
 =?us-ascii?Q?HgK27iD+8mN6OEhlsk4dRzIDVHvrmz3r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fyLdukQ/N63XcUswxOkrrEcgkJg3nMlVjWVhRvh+dIERWVhCJd3rV9Sagwlv?=
 =?us-ascii?Q?vUicwObSgDcPT/53Xbi1fyqNppgSME9VoViffHMrvZxtH09qfas7S+3s/x4v?=
 =?us-ascii?Q?Kon+5HlprGgNqGZ1bx83SwGuBwA3oak9o7Xx3ttEV8ij5JIJB2Xjdewy4Eul?=
 =?us-ascii?Q?km8m9H48ic02qdJf7hMOr1/0re7IguQIf95yMw1kqGPMRF3nGs2y66nYLdpO?=
 =?us-ascii?Q?hfvM5VBJBzEPdXBK+GEGSmjuuxC0bhsrqGcB8I6E9B5drzEJRj+B65EQZVYf?=
 =?us-ascii?Q?m3Lqg6j2Dj3OT0m6hC4xp2twNIKmdZHZiJfsEaRhL9E5/tpdASn7j3HP1zrx?=
 =?us-ascii?Q?h1GyW/AYauunFawhjEDppj0Gw8wSyxhcPjVidBUfAVRFb8GpvJtjIN2o5X5x?=
 =?us-ascii?Q?Raaa8wxUbql7vsQ+7DZ50LyM7SR9tmFpCCmoy+UvY78lNNnL4EaRiTLk3TgE?=
 =?us-ascii?Q?1g0ilaH0sxm34P1T0AvL0mauiOD63l2s/SDNghrh1XwoTUiX9CehbdjLvN5B?=
 =?us-ascii?Q?Fppd+AhNIHQ+VL3wRHQplrH04IjA1iL3vHlpuxK6dA26cwjOFE+imkvAb1Q8?=
 =?us-ascii?Q?oDe6U0YiJN03N3JFrUzsjUfVLr9WMICYJ5HEE6wd/WY5IfBl/MhMh1lp5Eku?=
 =?us-ascii?Q?v2JF0XCezQ3/fDJrwbw1WKXtBciK8hq2TLKspecTtx8iHnuStI5uXrrySDN3?=
 =?us-ascii?Q?0nKGNUctqMqX2zrvu7CNM3tnMEIfi2Wjt1UXDkq7ywE5ve4KE8RJC+ZWZ6kC?=
 =?us-ascii?Q?XECVagKsw9E6vXAqENoH8SNlkWszHbbCqvuycqaph2JdGBbYsxKOdotxLe+p?=
 =?us-ascii?Q?wI7c1PsStt4EJSMwQc8zH/wvm+f5Ji2o6gV2aSnJRutmfteztcTcu+r6DywG?=
 =?us-ascii?Q?7vwh2odd2Nidq8posXELBAeWApIt9r36v+NzB0e0yzYtTEkrQ4GNJekcnGIn?=
 =?us-ascii?Q?baX11yP/jRn/zOr2cvA3az3olPIOSAjg0PN6MeyTDlFR1eu7R1ElpSnmDXyw?=
 =?us-ascii?Q?szh9ILX5E2WahrSvOy5oFQ7nVaMJw2RRrxSbz8E1yjlLxPdgV3A+7o8WGYc/?=
 =?us-ascii?Q?zR74CnbhN17UVHA+fgQs6RHH//QRNYIg7ZkDKwWBaafLxKjjyO+m6jvswPJv?=
 =?us-ascii?Q?yD7SyU6hJCWoSClLYt1rGbW1aWRsWJoYagmUbdtJFSoBe1/tuyg1sl8a8XeL?=
 =?us-ascii?Q?n1L0AdPHobcA9h5e9vChrxfD/Gm5nnldWuMGD0cu1UoHFFEcned10x5Rwn4V?=
 =?us-ascii?Q?HOxzURZu6D4LAMG1lpmfONbkdbTNdpKWSIKCwL/01QwMg34fPW1FwDpP/2+c?=
 =?us-ascii?Q?WbaptW+gJ4wd7g0f9Q+KsC2nvhQXpjKT61rsGm3eutegY5iH2oEs3qPcmO5v?=
 =?us-ascii?Q?Q0PVAvKqz+MzJEpdAlHoYqTzc38Bo8E0oI4mLQvPU4YYj7eUoO4fnhk91Yp4?=
 =?us-ascii?Q?Ene9wz2Oet8bFOMQ9JmFMe+UNrMBjvrYFc+wmzfNWlvcBXWsiTEoCwuGA56e?=
 =?us-ascii?Q?IOw1ROw+fOGGIaahkfsBvg7TcOUk07Ikbgv+5TfBmL1Xc1CcvIKBzz6FnccC?=
 =?us-ascii?Q?ikAXsP2p0ApsYOIWuKO2xYaAyIj8UBUBLbnKz7Rk?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d50959e-ab21-416a-858f-08dd6bbc2e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 16:43:33.5206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+iU8wlfDKRAO+VXGr8znuu3Mzivzs86KSlpHbkt/eHTRHd6EEUBLGIXQdpU7FW4vonRkLK1os7ZaBHQX1+DTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10695

> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, March 20, 2025 12:29 AM
> To: Jeff Chen <jeff.chen_1@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; johannes@sipsolutions.net; francesco@dolcini.it=
;
> Pete Hsieh <tsung-hsien.hsieh@nxp.com>; s.hauer@pengutronix.de
> Subject: [EXT] Re: [PATCH v4 1/2] wifi: mwifiex: Fix premature release of=
 RF
> calibration data.
>=20
>=20
> Hello Jeff,
>=20
> On Tue, Mar 18, 2025 at 01:07:38PM +0800, Jeff Chen wrote:
> > This patch resolves an issue where RF calibration data was being
> > released before the download process. Without this fix, the external
> > calibration data file would not be downloaded at all.
> >
> > Fixes: d39fbc88956e ("mwifiex: remove cfg_data construction")
> > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
>=20
> The code looks ok to me, however I do not understand the commit you
> selected as fixes tag.
>=20
> From what I understand releasing the data before using it was done since =
the
> initial commit 388ec385d5ce ("mwifiex: add calibration data download
> feature"). What am I missing?
>=20
> Francesco

Hello Francesco, =20

Thank you for reviewing the patch. You are correct-the Fixes tag I included=
 was incorrect.
After re-examining the issue, I found that the premature release of RF cali=
bration data=20
cannot be reproduced, which invalidates the problem statement for this patc=
h. =20

I have decided to withdraw the patch. I appreciate your feedback and attent=
ion to detail,=20
which helped identify this oversight. =20

Best regards, =20
Jeff

