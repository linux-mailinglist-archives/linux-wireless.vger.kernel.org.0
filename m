Return-Path: <linux-wireless+bounces-11949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FD795EB43
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 10:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C932E1F2314B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D41E1422C8;
	Mon, 26 Aug 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W75EbHQl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05413AD1D;
	Mon, 26 Aug 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659064; cv=fail; b=Y4T1OrbrZlKLlo/4gC8SAxJ58NGLLcLFjDiKFYpXM5mDzndLHt/jBAqRKn6SOdLwdZTFWo92Nprgt3f+2/PjTSY7q0smEYIjOkYxF1258oVXmQgcG4IoJQX2eDEaSkPmjvhPQLP89B6yzNpWt3vT3c696HIKaxDZmvVNy/sbnqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659064; c=relaxed/simple;
	bh=cYwhvr/nfBylZrIdOY7teW+2ry5c5sf3UXwEIc+OxXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rdnFyYX1WeEqd/jYc5rV0y5KoYtpcIMC5pM9JsS1wC78lNSMtS4doLbLpz5J7pzi5cGl3BN6maV2weBGJ8EhttYDGoIWI9uSvrpqp6eHW1Dn5vzrjWcuvFw1B/Z0pt17LbxXuwhox9v0569UIF6B0pXFVFQHRDaIRPZq6jc6ydo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W75EbHQl; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkZNEuAKe8fIXqOMptNVQlnevj9m8vuGu5kttulQ1vL5/VI8G4kyv4KE0XgxD9wZjuFlV9B/3C6hHWvNmDJdRDSfOEXym2OfxH/6QIZiUZm7UnlJSNSJvRy+g5HKcEQl07feZudH1IzZ1wF2yWy0UPsM4QSIaRs+9yKbk98hFnSKmy3UUenemj+2nh1vCwPilEUjgUwvBtRHFrPVVRbLa0eWNkrJIdHpaVxpEED+em1mVljAxlxK0HzMA1D4J+6+ZQoKJDaOzeLlBkayLKG3oRyZVBxTX8+9mLv03MLG53ENz1n5wtIZ5IAEc8p3KDHf4vpJzRTjpZESpiU/e/cHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMBRBLm4SC24SDdJKENClL/zSB8626vV2h1ZgRc8IXY=;
 b=IzIlxl/dxiKDC5yx4yIVyHLnuFEaxC8Lr2hFwa3+LE4ucopNB1WWvIPrUvhClI5em2DIMkcJ/M6aM/JPEP2CahjWBUBqp21w1Nnnpe0y4PI01V/f85b3knxU9tzmffFlTsWEkBIYyb5ocylCpu/3WfIlp7J2TAk3HzXAKlQmQ6ifFOXbsUAmpRnXoIGkS1XkWGiR+0hY1OqzquHCdbUbNTX/seBtW0u9i30EtxmZHO09xXLQuo+ibHr2SrX4yHiMgHr0dB8jsCR34S19k02AsefKCmNKI/YePVQzq58ozGAySEerzh5OCUIc6oSe6z9eFRbJPXSCuumyb45a8AEW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMBRBLm4SC24SDdJKENClL/zSB8626vV2h1ZgRc8IXY=;
 b=W75EbHQl7PR/EF2PyystiBR+vhxbgSH+7zV47ZAD4V6TuoUePHsvPXILCyxaTns0somb1p5r3D6aJEcmWQfzqkRWVZx0WYEcQpIIKNhy/Otv9C3aG2fogmH1z7sU9Pp9FyFRXtopMs+dx9B10kBrrkazZA+qjpxnVm0BrwxvmhjLtt2a3iVoW+Aq+zVhBfmQsL+H0+r/UzN9YpJ5O0npL/Mztk9QVTDq7riFHdl3CdSjv3VJyLtiZffY6X70W7ELnwF4AOPhFDJ96UD7jBr2zNRr2AQ89N7lPkDf/Aac1d0J/sIpaVoFAuaxlCOoGgFyAPIDXWjihma4HW2bTAvPEQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8825.eurprd04.prod.outlook.com (2603:10a6:20b:408::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 07:57:39 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 07:57:39 +0000
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
Thread-Index: AQHa94lYwasmKIL7I0OVdvDE0AaRyrI5K4CA
Date: Mon, 26 Aug 2024 07:57:39 +0000
Message-ID:
 <PA4PR04MB96381DEE1E9DC0A8F05C7695D18B2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
In-Reply-To: <20240826072648.167004-1-s.hauer@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8825:EE_
x-ms-office365-filtering-correlation-id: b1df2d79-5b06-4775-c560-08dcc5a4c1a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P/evmt4U9EGIJGtALzXPl0uCxWSqqBRHOJ/Cza9GMsSsLMk0KqjBIe+INMpX?=
 =?us-ascii?Q?co6B8oujopENxpCaKzIOBeGg9g/nKFf04xXGOV3YQi8Jje3ZG3YI7SvWnMZa?=
 =?us-ascii?Q?GExChUZqeSwN88M62R0mi/9uwkKVwYGmICWHynP4RRP2cdIIVWWkHFM3QbUn?=
 =?us-ascii?Q?9Y/ytGnSElJdU8Rl2vnwcLtjp8cI2NAen8O3BGA7ZSIjl//SPuSRg4kceYl7?=
 =?us-ascii?Q?hm8iVZ35bB9vzEsYoJrj2dVq9Ginotb9r5wOkajc8voFVrsExTPvnT6Jw5H1?=
 =?us-ascii?Q?voe67urqpvEj78FH0/6cZd79DOzw+5Ojuk2tk1+SFL3C0r/hbh0hnIYfVnH1?=
 =?us-ascii?Q?GSm5dB2pocz4Dp81FN5JDoB/UFdai3yg3tQh3Z8P82KZrq5rguAPjBtFOGA8?=
 =?us-ascii?Q?pLFOmJ9lhYr79xhQRfMC0+ml13TDN/CPx8NU4jmvW8HJeBVoIDUxMCoxhl0K?=
 =?us-ascii?Q?p2oSZo8Ppo+mjOt+rtP+q/wd/OSJJuIvXOHBSelJtXQcpkvaPWYE/51oslFs?=
 =?us-ascii?Q?Hs4zhV9z/y0h3ALzCtOnk+E7qJ6N5KIBMvY+j8FljqG6U28OvTfZCaoT0H6Z?=
 =?us-ascii?Q?hyeZ3vvuN7oNe+gEEz2pLK4Xj6pURMH7K6Rjzdi7DoDQLwYn4O2Dkz3kr/38?=
 =?us-ascii?Q?k8hrqE258G5KDxZ5jaHR8pw5fX7LeWRREolmNmIJZm/t21FqVOA6uryYMi8K?=
 =?us-ascii?Q?ATeiHXb9Tq8PuAT0eveJCMauDKqZ3bemaLm5RsK604UcK9HB2Yq56f8S8T08?=
 =?us-ascii?Q?oRy2Jh1/RBs8x0aI3Fg6itpE4RTaT5Nl8WDRZKHp06KoFcKCyqMcMzpKRk1B?=
 =?us-ascii?Q?FwHfG0N0BMvqlLK5MNuhKaJtKnqRjzKYxOmOZiCsHfExieuhXxYq4OKGM4ZU?=
 =?us-ascii?Q?CV0Jk/a64RaYqmZJ6HjRM/euK0NGTdP8C6D9jA8gDl5Cn1lMqxfPzZ/HyZfa?=
 =?us-ascii?Q?TsnWnh6zXH6/6Z7fcwWdzz+8xEmFQY5He5HhGu2uDVL/blayTHgoLBlKSWiZ?=
 =?us-ascii?Q?UIyTa91+8guFo4o84wawryhg83XWgnkk7ulkTjQGVmsTHAvXHgwRxadVXcp/?=
 =?us-ascii?Q?DiDYUg/siKv5MpoLEzYYbw8UqaGJb+fsjOHgQ0RByA+3TQhmtY7g//fY5MID?=
 =?us-ascii?Q?NlcXgoQGJKy1/bUzH6eBUlgu0TJ4o+uLj6A6C8DubjFA/3H/VZViSZfGjxZz?=
 =?us-ascii?Q?DEL+RWHV7LKraGuXWP8FT16ULT0aBFakd9etIMlm00TBjde0rhO8GL+Yd7/v?=
 =?us-ascii?Q?v6vm1pEianj+jYnMK2pE81LByRmCx7jGwd4USv5+LbGilnubZZ1gn4+9WHBS?=
 =?us-ascii?Q?bJJWLQxT4USveIewXzJZhtuzlMm6eBXN19hISItUzyqDRw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Oh99UFsVYd6yJ4hJvPkrUrMmn+j6FGWUFF894Qknrq1QPzEqc1ruy6rQTrIw?=
 =?us-ascii?Q?Y8qIyHimITyWXWRlfK7eIfOgsg+4qyw0v/piZdShy1926fCa4u7ElRdkW3JJ?=
 =?us-ascii?Q?G6J09hL8kIjQf0yCJ91nDna/waJaj7Iey9Esfj+WAVt9oFJjBuIbNFhL+4pG?=
 =?us-ascii?Q?EDZj5+2dG+2bB75fj/UJxyxH0KN0U+4KYZP0ug6VaqrEzxAVegqhC8g68M/d?=
 =?us-ascii?Q?TnLZ5+5mtLvrtCBwIRqfAxbau2KQIfx0vXhJVUcl5ENv9fFvd4AkSZ7gJZ7V?=
 =?us-ascii?Q?wXIiojxJe8b7SUuNeGd5Lj0lSB9SJW+P9JTCfWzRJb2I5FqG0R2qOzq9vxiH?=
 =?us-ascii?Q?q8dUYYltHLoWbL1Fy5oFJmWqiOpA9FaQk9pB7wNdzbgFghnYwP8kLRRWbIuu?=
 =?us-ascii?Q?GawVs1Q/fnufcTak01qPI3FPJK/F0MKaJLrSCCEuI6hO7NjLi9uUwMNNLHhV?=
 =?us-ascii?Q?JalaigNUtyt2fIFWiT9SO+FSY+GLalHICJNeJ5wMQLOij9yBT607mG7ARhsd?=
 =?us-ascii?Q?C/zm2ykF7Wb1VCHnejB1mgB23yq81OJ+r8wjQbHjOV3YYgkHYb4rczfahOk8?=
 =?us-ascii?Q?uO04oMTocQnTT9hVNailHEPjGY0ZMXDgovmwjITs761Zng2Sgm0GG22tEyWu?=
 =?us-ascii?Q?z7EIQlPKSneV1aVra840q2mhxSnHPf9azrt1IIZpuV+I6bqoUcgxZpyykXAE?=
 =?us-ascii?Q?tdLHoUXOkLKspAMS+mSDDoz7EL/hfSp/799YfX5al2CBkOQEIC7zGvGeQer3?=
 =?us-ascii?Q?Cgsee+gyMDiJ/a8kAIsSSVVXa0Q2MaJ9llIDkxqUcoTklpAFlgTrQuPtGyF5?=
 =?us-ascii?Q?sL7ME5t/xqQb0ZaFFzinUCYIqQv2lBG7V9zOT5t8mHP1jK4OrxZQzlMBHEvL?=
 =?us-ascii?Q?RU4FFX+6kN21/Xo+LWNgNNbXEqxx/b1LGZqehiYONbKg5unUoR8u4IUEAhfx?=
 =?us-ascii?Q?OLLfe6/EBLPgYrJ6e+KL8EgRU219RLZJkHB3bwelOOpVF9xicuJKADXTjcBB?=
 =?us-ascii?Q?bcjZfehZy4KUD01hIhBLwrO0wdyJVdNhyDOD4TzBmkMRrvmtnfCOdNWW75OV?=
 =?us-ascii?Q?SxPYcuN1xy2+gYL2WVyH+jm7pLbEGdhUfO4r74j4BQTApSTVR1nRCqpt9br0?=
 =?us-ascii?Q?CS0PGA4Yzv0y6sTnQ+lHLaCyB3Jg96hCnQKpSzuhssobP3yxIAK+Opvghb28?=
 =?us-ascii?Q?8cEli7tpRaz1cfQaVT55yZA+VMdXLno2NMvetOXJLSfVZHgOwu61+tYl6JHV?=
 =?us-ascii?Q?fn6/FznCc8zFkeuYx/EBuz8/6uzOCPUZlSYzZo+HqL2FAFElTnalCtbv/1te?=
 =?us-ascii?Q?I75eZ0UPzjyGccHeBT+5G3hAkKv/zIATHU6Axyx6IaCsh9SmVrpb7g67oqUN?=
 =?us-ascii?Q?+uDvkruwU1SA5KU1R/n7ZC8nbLkF0P4os5FyXjXJFie42OSrxWtZw6D0lZ9H?=
 =?us-ascii?Q?xaNCuRyqVOtOtYUfy5vyK5Dz2saCtU5JnjLsehgEQD+FtsZVn4r6dYNgaZe6?=
 =?us-ascii?Q?BNRLUy6yRICssbnONQfy9jCIT7xJEVFQbWl/hJCudNJbfcs3ZWQngP6IVfb0?=
 =?us-ascii?Q?dVfhB3gRzd/fzVMDmxh4h3z6wmGah702jKLOtpA1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1df2d79-5b06-4775-c560-08dcc5a4c1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 07:57:39.3521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyGOOW6awpzjJAUO/WhWyWHhNNaNTwupVdgHz3xHquicLtGjHjbV5RJQMC8qpN4dhhj35wNUwpO90Z7egmIGVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8825

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

Did you test STA or AP mode on DFS channel?

David

