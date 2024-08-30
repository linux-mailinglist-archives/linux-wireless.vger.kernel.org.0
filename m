Return-Path: <linux-wireless+bounces-12257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36A1965FBF
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 12:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E281C23560
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A0165F05;
	Fri, 30 Aug 2024 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WtvW5VOd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C57173C;
	Fri, 30 Aug 2024 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015537; cv=fail; b=WK6hPHsZrxcYU3t8+ivUhGbjTzH0dgCr/48qkBw7oC7XqZx/iAS2Ksfgdtdhjpk7nnZ2xmt0sVGtiRUtebpD+9lI934yutB5WzAvAJXijwDBd/yQ+eIbM+eNnwwRvG4MMfjziDR9kYve6Xx+1RyPvXitPuAtRO+xPxbKyT2RdRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015537; c=relaxed/simple;
	bh=wLGGHSCXgn1MYW5Q8AKGz8LhjmvJjInINvd9akYpFqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VByKBjda61TRDhBr0JHn5dqnCJpUlsvRsZNPNjD9i3yyPSIXhIpiW1OUs5We+d3mmDSnA/aU1iy0O5CvmGLFGBJchY8K8khJJLa/T4ozxQHGQAObyf5zZ61HqwvApW63qJAZELAMryDBUWpZryg++SWXB2wizJs+Nzy+u1ukAMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WtvW5VOd; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEdHWJ/gLb2ZaX3qCXCpeQMsKoPAnH1sROlmTtHw59AxU2NZ/sP+6xHmJuDv8bHccdJzJCN0A8RH036o1GTBBdIzEucQjf6KVeorRp7rk2nW1U0GbqYFDOui3TYixna7uo3zxZkF9PULUYffIbGXvQWIBkWm7NBJFgbOw0oqbmme5CrnO4c4RHGYonHL2J26f9yxP6z0CjmFh5PzzP9ofh98VvUVtg4kqmYQhsw7yo3XZtmnhWtN2vJ6WHKqlqmMMSiI4FC+HI1d0oVWPkzhP4l9WFUo/F6ALC8k0vr3kKJ1go006v4Z+1gbiBmtiYSRmK5aux6UAgOzJ8kczsIVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLGGHSCXgn1MYW5Q8AKGz8LhjmvJjInINvd9akYpFqw=;
 b=G2u1ViPADIRc+SSxwOsZgrMWP98j9BrOE7CQ9qdRB7beFDnEtpGOc0H1fiwx9bAoSBHB/ubQ7wLsgXQ2ndcSumu+l6PGBmKUA/cIilmAOdz7O7+L5oVyP2HE86s0AstIjbhr0vA9EhHojFJfwF+ADU/IwwVappk8CVRE6qIIJv5iiRuM4pINYAzxiZgO6fN9n6tzIZ0XOOe1Cf6fOdsMu3U6m6jhvIIYpsiEPSlQ5SJGEGV5C16Al6FRriKYxeReI/6RvkzukR6A9m9MzFfb0HBLtdHsWnO+4pUlwQfLuZOPvTIDCf9N7ISsbuCLAaQ+pANjMiwyIMpoc49l7HnkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLGGHSCXgn1MYW5Q8AKGz8LhjmvJjInINvd9akYpFqw=;
 b=WtvW5VOdt3Le2I8mU/8/AObMBQ1rgf6Fm+GyOyjVy9B9B74Tv/bslN2xGBhKo1FR8Qqp4myeeJxbQ5W9lJwtHjctgYl7WbNGT3egKpijWkUn9lCQSkOUnIonTlVQp3hi3o1RHZiDcZEy+7hlJS8UZsN+2S+HokR96fk6sKJLmAWkkyymwRePPmu3RfISE03qi9Q1f+UYYauQbCtgUfHHUhlmLPh0TIBy1Fhet2ewPrihvRsKkqBsUmTVxF2xC6W8dYz6AjTdnBGKGPjbdhzxuJro04iEsM3te+amvh1xIxxESWJTUYpi3HBk9arP3jYVBg7YGgtJR+9v8judhFAxOQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB9141.eurprd04.prod.outlook.com (2603:10a6:20b:448::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 10:58:50 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 10:58:50 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, Francesco Dolcini
	<francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Topic: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on
 different channel
Thread-Index: AQHa+omwahEWj+NlxUWyYlP8eaJEgLI/cxQAgAATBICAABtEUA==
Date: Fri, 30 Aug 2024 10:58:50 +0000
Message-ID:
 <PA4PR04MB963862022F22E473CD559310D1972@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240830030630.825818-1-yu-hao.lin@nxp.com>
 <ZtF-dgrx28yZKG2O@gaggiata.pivistrello.it> <ZtGOaTAEpLgD_z0W@pengutronix.de>
In-Reply-To: <ZtGOaTAEpLgD_z0W@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS8PR04MB9141:EE_
x-ms-office365-filtering-correlation-id: a4a6fc68-736b-4327-9ccf-08dcc8e2bb18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UhkUJGSbEzcvYSc/vw/yECK8XnyMrViErdQzoaxkB41KnNQw3M2a0xkCZmoy?=
 =?us-ascii?Q?S1r/f1NO/n1I8mA60iyQIaCAPlaRkHSsJKZc5XksOvsAh+BNTb+PP8/bX7u9?=
 =?us-ascii?Q?eV5I3vIfiiG6JxbFi75x6gMQP2qVYumNaunoOQka292ucLlX75iEXY723n98?=
 =?us-ascii?Q?69p4K2L2SEx+ZRtc46MyKF/VWu/WDP9EFjAeio4XBTPA4/l19WbvWBcLaFr4?=
 =?us-ascii?Q?omWhHXdta9P0A8OZBMfNyATPPYeCypaXh7cE6HYk5cvODrL7toaphKaivMep?=
 =?us-ascii?Q?NFF+qeruiWG0J3heHcBvLWW8GczGpZEzrgoUyZ2ftY1XBXbIPF48eYOW2Cgu?=
 =?us-ascii?Q?EyhQwFe5xoJ3+ESotb8amPgmPTbUQxQHAPEb6Q89EsDguxSmm2LgBZOO4F+R?=
 =?us-ascii?Q?kuuk4IMwTOkZ8PFwHZIf3ZGP+FhR2mY0yNUS7bhzhKaXBzWx5DsNfqkAxlt/?=
 =?us-ascii?Q?AaoChnZzo2nUovS6O2N/QgYtIOMr7fp6ssqsEmK0hq+QRTYc0EklRs8ZW4wv?=
 =?us-ascii?Q?DlyqQAQKsJIYcNNfmrfem29JlqspAhemy3Oji+NivvxoPice+jgXdRRRWyMS?=
 =?us-ascii?Q?xlFTKO9o6U8WPtYS0FYXcjyx4EV8Zu/Iqxw117l55WGbyFdt8/g2IsRWy5lW?=
 =?us-ascii?Q?5/Qxyfw+bFBziOtNPWefM8GmF7Z7Wz8s2HPqGlCh2XeekraLJJY/6rH0D+p3?=
 =?us-ascii?Q?igChZaxrPqxA+zuguTSXX6xZJ6xMCpv52aw/VUhmHFCyDq4K1BUzaSwxE8rx?=
 =?us-ascii?Q?/CUsXD2QEreXcrJOJfDeJbmLqA1+VLSBRXWany9kND/Emo7b+uhz3XAS9Xvn?=
 =?us-ascii?Q?BbJwGG7YqoRUwp1olUtIuCKJ8BffR2XX0aMym+LRSmKG73h6tNUgyenbPo2J?=
 =?us-ascii?Q?8cAlp0+OLyYewVsmL7lI5PTBrndAm8EtXhlZgVLi6Cux5xuL2PLd8WbBXnTd?=
 =?us-ascii?Q?KPYy8/oIv47kogpW4xaC7xhKy95Z5OujIycmI2lPgYrdwsEXxToAFQNviMV5?=
 =?us-ascii?Q?0rDfANO7i5O8/4bxXKA18K9rg/5tVPhNJNF70t0x3qeQAGHRKjG52HfO7UAZ?=
 =?us-ascii?Q?cRWJobrLH3n4HMPRv/QDIvR4c74JDEjZmtCe4oBh6PIntmB3GelftY0t5Dkj?=
 =?us-ascii?Q?G7AoKrtLn3ZY3rzrOt3lqakKAqYrsK+YKd/pi4LnAdjhx2bQSSxztffcA90X?=
 =?us-ascii?Q?q3UreC+6lxptVwjucNN7035NYvBgIkubFi5tmhuxmvPcKv8nlYd+X3PQjr4C?=
 =?us-ascii?Q?CcQ4N0KvixoBLwxl2OilDBJQBky3PSb7ugFLYqrj7e2ZoAOA75QEsJVBBfFD?=
 =?us-ascii?Q?IxJaEGzOPDG7CzmXgzEAP4pNH+M9Wu1oaKo4skaoQVCHPvUmXY4ZfvTmAqcB?=
 =?us-ascii?Q?2d4tgyPsFoQ/5RSJyf9cwBZfkGS4sWnDSKPAhFpDkCWSrflshg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TjCwQIjqCg5z+MOCUVXdfbKnAoXOvh+XmmOA3OYRGjGuXcvE1UQy9j9jux1x?=
 =?us-ascii?Q?G7ON8/K1R+x+/WxGQwT6zqCJS/l2Z6SG2fb1AoxFROTNkkO1GCBrW/3IrK+T?=
 =?us-ascii?Q?6yeFr6r+0ONThniIrvUr1FIN1oLKpocKb0NcPhftHnu9N3ls2QHrZyxKbLX8?=
 =?us-ascii?Q?1tM2j50tVjyktwCFObFmNfbgexncaDL8+xQ6ml8BPxTBKiPGGhyT+OF3jPrL?=
 =?us-ascii?Q?7OG7BH1cJO3tXblX7XhQNGTaiXi1cLL1YZxvltWWnvCgAm8egMW25a4SorZV?=
 =?us-ascii?Q?fqF7Kk4W8yQbqARm7TuUfqKJBTqMU5BKt1G4qGvJvbvXHxSTuvL95y+hf88/?=
 =?us-ascii?Q?YhIhnpt+GKH+baKDPVaomVmGHf4k4qvM5JE0k+USpMKpu9I8qqP4Pp4A57FS?=
 =?us-ascii?Q?FW77xwz/X+JiK03U5M9I82eLoaZSrMRiWqG+L+JbHjgBgdJioi4sxkpzHrBi?=
 =?us-ascii?Q?ijrQ0XD5WxN3uQaaqQGWlC7hH/sKz0ArGnSQmn/JAt4Mj1E2ZhJW/FVfnG55?=
 =?us-ascii?Q?1UL5/ACCH89yNhRzhuOQevf87ZLdD+tqUhdAbVyQqz7YrbvKY/g1xwwRiqgD?=
 =?us-ascii?Q?QCYiJE8ygx6m+C8S+UnRo/p8JiCqQB8cGcHoxRIT/UuWxusjW4lo/ceELJz+?=
 =?us-ascii?Q?QNk1OOzr3+KHYbtY1OwmhUHS62fDTxOL17xWB0Fq1OCSz+yGYnRegnxlj+yt?=
 =?us-ascii?Q?id4IgsPQjM1LtLgTJbhkmRkKzOb/JQ81IT7VwL9CUCi4b6zVBMizmqVeihQK?=
 =?us-ascii?Q?+tsvWcW6m1Ccn60Q4rbp2j9YHdnwC1Q+MQSH3qdmf+TWRByNaD2WUH64Ov9T?=
 =?us-ascii?Q?BehJr3vHTkaJSlaFAZZ7uU17v/P4DaUEALMu0thkFg4K0bbqIK8ts1wCGkDc?=
 =?us-ascii?Q?xSZtsfXu8ikbWD0RQ80bC573j8rgF0akYydtWCv78TT1baTiMuhWzzN+v6bv?=
 =?us-ascii?Q?y1Be4fAbHiEjja7Z/OYe5/UJ2YGXvae8UkeupXBIpfE0zCW4wFL+jjlL9LGM?=
 =?us-ascii?Q?j1Y0K1afB5e/2TLa7TzwC1ETf9kIn1cuKzN94+Ww8weHjvC/nAeVilMonlHd?=
 =?us-ascii?Q?j6vIOIMmCzAIcJYSgMW+00UKpXaQ01GVmMNWn2Y2aj8xBl1zI39BEkkVFP0p?=
 =?us-ascii?Q?XJ/xbEgwlXbaobXW9IJ/0/2JYFZI2yeCymcc2e+JQq11VsqIVs3xrOr09iHY?=
 =?us-ascii?Q?bLCqsEdAJqpF4Z8i6yvyC4P7xCzJXXBYsZKHHweL1gVKK46uzevrunGSCtTq?=
 =?us-ascii?Q?IkFA1VjMeZStRSeCfwNUwOCiwT+Erdv41gh91tUM4wzQxfoEJQXrJNMiGnhg?=
 =?us-ascii?Q?QUvYP7uaSrrUu41FQL7zH1VTy6hCTD8rSP/LItwRau/OhQxSoeh2X+PfFNVn?=
 =?us-ascii?Q?B8LfcYZPAojsgA7Iv+xN3a0YKUtW6lo2sQQ9YaJZsToUwHQJF4fPKdDihhaV?=
 =?us-ascii?Q?lIioZI4Ai05xV59DgGA29yRVQGLMMDEWA2eK++RJQ8kU48zB2te7LSY9YdGe?=
 =?us-ascii?Q?p7indRgb+ELaSHYWljJhXLU3epfVA+fgozuptE43Qw1jRcKsx4QkgrCsNp9L?=
 =?us-ascii?Q?zFqvGqu5PUVDdO9w/+9tImqp/EWzK/V1jlvLQNHB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a6fc68-736b-4327-9ccf-08dcc8e2bb18
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 10:58:50.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AKFe/VG3kh8DERfIyb7+F7JbXe8ELUNwquxOAP71VfS6t94vWkJfofbpr1gLOp+lYG+cqenz47vFs7IJUf2BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9141

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Friday, August 30, 2024 5:19 PM
> To: Francesco Dolcini <francesco@dolcini.it>
> Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; briannorris@chromium.org; kvalo@kernel.org;
> Pete Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH] wifi: mwifiex: avoid AP and STA running on
> different channel
>=20
> On Fri, Aug 30, 2024 at 10:10:30AM +0200, Francesco Dolcini wrote:
> > +Sascha, that just sent a patch to handle the same issue.
> >
> > On Fri, Aug 30, 2024 at 11:06:30AM +0800, David Lin wrote:
> > > Current firmware doesn't support AP and STA running on different
> > > channels simultaneously.
> > > FW crash would occur in such case.
> > > This patch avoids the issue by disabling AP and STA to run on
> > > different channels.
> >
> > Is this a generic issue of specific of some firmware version? Asking
> > since the driver as you know is supporting multiple Wi-Fi device.
>=20
> The driver does, unfortunately the hardware does not.
>=20
> I learned this the hard way. When an accesspoint is running on uap0 and
> you want to connect to an accesspoint on mlan0 then it won't work when
> that accesspoint is on a different channel.
>=20
> Likewise, when you are creating an accesspoint on uap0 using channel A an=
d
> another one on channel B then you'll notice that both accesspoints will e=
nd
> up using channel A.
>=20
> It took me a while to find that out. In the end I found the same channel
> check in the nxpwifi driver.
>=20
> Sascha
>=20

Yes, this patch is backported from nxpwifi (same as another patch for AP DF=
S mode).
Because Mwifiex supports connect/disconnect and separate auth/assoc, I thin=
k I will
clean up the code and create patch v2 later.

David

