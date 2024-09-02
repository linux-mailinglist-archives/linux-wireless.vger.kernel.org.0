Return-Path: <linux-wireless+bounces-12322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A46968137
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 10:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2C21F21D36
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9DA17C9A3;
	Mon,  2 Sep 2024 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aA2xNgcG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F014B97E;
	Mon,  2 Sep 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264064; cv=fail; b=jBHaFSx67gbmpPXa+D5XUgCUXHVh+odwr6u9bh9JDYU58AY7WWrkG2t2fgB4QgNLQ/GmIat5N4/qWzOqHnynwzCIIX0WSlD6erccij6M95vX1uGQmL8pJ5b6G63xsEwYZO4wZvk5z0213FELi3wQf9Uj4IS/v5w5IVXHObsqBC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264064; c=relaxed/simple;
	bh=76hHxjUuTgf9b6Lkj38PmylDS5EnzWF2r+PbUGeEmDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gKoiGD3PLeQdYtGSRaWYIlY4HzSsieOzKAVWEu2BojaS+57X9NMfOvM+eUQsol6Nnvrr9549eaNmaXLBGLfhKVYaiVrLMda3zBr8fAfemBe8YUwFiNRWAHrgBbAVIa1CaFyczXgDtvXTjpb++GDnU1ersB+Ptb/C/r50P4tDsrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aA2xNgcG; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg9pS3Xz2Ds6W9up77WOWNyHHu9tb0p5bJt++C4dovbIWm9Dbg7N4W1hUEJ7f1XHoXBARcUL2kv2Z27/8zXvYPuql5fQ7j+ZO9xQ6iUME8kdt7P+MWlC7Nn1mW5FVTGW7IAKcvbsyK/a6lrwgV9tzSYO0L9rDJxOC22bshNspnWOYoemsAxbUCIQlEnu9qfA/ycuIFrPAb4PHbDxaFfAvijos5dQHCfm+iOXfoceZOMVV4QYwdJZYvlKpUB8fV6bZ0aMicLHnjnF7EcLHveSARXYmW8xkXcmr+4foh024vWcmTjCgrhXEvris1yGdrc/oitXwihlLg+sN3HCd9lTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRnTeTUV7tCohs21ax1s2T5GHRokV+CI3b4DblPL55w=;
 b=yC7gCCmcdIcklu2hsXpCfhuPeerAsdtqB4fnEscYOPur8eigXVpwqHdjg4b2Ne8iX7AfsI4ST3kQJbpssZfxo1ZMuAZtM/BCaAbzN23c9PJWZn5pefv/ApS5aLyl7cwR+iC70zadMtJ3RS4S6onzI3yJUS6DYbvHyKS0qK+0roS2//jfOJjdV3ByP7V+p1GEmcXV39z5HkxBF6ekOemhwfbQyd8ZzcS5YkVZnYa57vMqvhJzDJuEv9bCVvXZq3EoC3Ss1DTH0m4mefAhPogcB4AIbICg2aNZRJJXt2XnoKh19UkMN/b8Fo7w/gDS/LS5y5JfRgv1SMO1k5DmYiQw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRnTeTUV7tCohs21ax1s2T5GHRokV+CI3b4DblPL55w=;
 b=aA2xNgcGRm/ZD6Pp26+MmktzMVlyEaMp1hh6YSM3FC7DwibagpJ8b7cYV2DjHM3FO2gdJFSz4MhYDgX8l57LUE3YQhlQPgFNAsdr5NeEFKqzFj4flKJvA5iravAC0a690FiTHgnUL8m8X4aNzSEMhMr1o5yVHifSrJy1XoKftfAZAoIc/Zfxo9pV1Ou2eVdd0Dl44OiBBYgwQPJo8mRtl8TTov0yARw3gQjQqp0op4DNrHbfcBH3AjYhbao6oIQ7frTBhbaVdXUEVW7uJ/zceEK/6oQhJZ8SpJZoMiYFOuMJ37+zgJYrfwdceX/ZCwQAV9IrYTbni5XCmze+xLrytw==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 08:00:58 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 08:00:58 +0000
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
Thread-Index: AQHa94lYwasmKIL7I0OVdvDE0AaRyrJDyhdAgABM2ICAAAJRsIAAEAAAgAACqQA=
Date: Mon, 2 Sep 2024 08:00:58 +0000
Message-ID:
 <PA4PR04MB9638ED8FA48E352F7246127AD1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
 <PA4PR04MB9638016F363BFF87D62B70D1D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVd3__wfm6EOOgH@pengutronix.de>
 <PA4PR04MB9638CF45263E713203A53EF7D1922@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZtVtPJSsIr9eIFWv@pengutronix.de>
In-Reply-To: <ZtVtPJSsIr9eIFWv@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB9231:EE_
x-ms-office365-filtering-correlation-id: ce023edd-0045-45c1-8fd3-08dccb256142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ih3KWkSDk27MQU8QIUnvWQl/PuZI0GL1PV1fkrwTqBy4cH2o4cGz5b1EQCtE?=
 =?us-ascii?Q?ZJCzkafyGYsodD7Gq1C0aQuSFqGwPCdweuvzneE2mHNE1bC2EV3vWLzWjTfD?=
 =?us-ascii?Q?vEq6oL9xm2UypPr+0zt9nvGY8ZpEMrbRJCffWVWafr39uNOu3lnN3sNksara?=
 =?us-ascii?Q?XMMN3SoBx/waleD2LLcr6lDfMWDN4RZRE6S6gEOzXPuCpzcMCI1fhsmfnzc4?=
 =?us-ascii?Q?L6DyNritspDWkMSe5kBa2xD0mMyZzwlbPl+xTPuvY/bqQp07UarEDOw8L4Mj?=
 =?us-ascii?Q?jAcppZ1Wk3ybcbEKFl8727FgA2dzqHPxKfQfa+ftrNxAn6snIJYqdYDbokAB?=
 =?us-ascii?Q?ll7IdIp28a4y463rvMEkp2P/H/bH/Rv7THFPl56QkkXj5Qhku33XZFH4XYfA?=
 =?us-ascii?Q?66bDdRqgd8y3Pwz0WeXzja0gE3EAL1e+WtPDv179c99gR/+rRssI+E5XCRtU?=
 =?us-ascii?Q?gLa1a4mELLh4IRBWA2XjTlVuVjRwZX9oUMNgAzeX57XK3CBzDN4FJ/sYRzu+?=
 =?us-ascii?Q?5HyN1Lm+L0UTiDbYeYxKKZM6whhI7q5ojYsLow+WtlOeiUg1LoABb1vdW87A?=
 =?us-ascii?Q?2Sb5Aqq1BzG7R4NA7rSvpqliY8y64Km0jUrU6el7L8bL34FFeXrEOhoykptJ?=
 =?us-ascii?Q?JFxc0fcO6KkilFaFhWhvdPBnNiDv3nWwxO6Mu3HUCrm2HVmVBXLty4qX+mFz?=
 =?us-ascii?Q?iqZd/Zx6QOv9Y5y81HiW4BoOb8bNsOISU0k78aiXLsX1Mek6ZWPCdAVHe+Oc?=
 =?us-ascii?Q?00QuUMiCPh8pKc+HzODJQ7hPkSeM4J9AiL4XBs1MbxpExS2wdFNSPWe5RPH8?=
 =?us-ascii?Q?ZdbexnzmQSE9hs5ONbkb12Sd2bOUf5BphZaMAFATxsU76zwqlvE0wi6NNYdT?=
 =?us-ascii?Q?iHz5JM1xfTwNAX2wNxZyuKKrBZeImGE9viCWyx8ZPUvBtgAIHGafNRm5Pdzt?=
 =?us-ascii?Q?8JkVg0nSsWUAqJprf1BmUZwXBIa8MbXk62azP/ZIPn3K/48URALx4ysMKypE?=
 =?us-ascii?Q?ClMB4payaIKhUAXyOMbC+At4itf2lq4DqnXgq3nW5c02HA2b/YPcm6SSF86Z?=
 =?us-ascii?Q?wzypKJg6a6PPd96xtCi+Q0PXqDXZIyO2nKsZUVY5ogV9nXelO/V4Uv1m2P1h?=
 =?us-ascii?Q?ezhP8MI/Cir0RDL9vQAH6SfGh7SjEmjS0IQwciRGEAn7wPTmBXkl1c/L7IMO?=
 =?us-ascii?Q?O+/KzOBIGOCMiD2qqrANLvbnu0gCG1Cs/YtJI2pdflc2oU7FcX7Rav5FBK3P?=
 =?us-ascii?Q?1h5FHYIa/LFJkG7hKDiVMs4ZEBct6XWRXpTHk+9NKd7vMK8xlpQ4B+OHMuU3?=
 =?us-ascii?Q?DAmmg2HSapQi2OWrY3L9PR3X5HqtMJNiH7Y43/zQq+diDvXWWzaKmlWDCUh9?=
 =?us-ascii?Q?fdoHYfJQcUKjZF+fNyrH4kOghr3SXm0PPTuu3VPTMTlO6G5JSw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iYLdJTbmuh+lWSl0qbyHGVnrJVWW74AcNVAGJeKR8MEi5o2bsTLiVFJpFPta?=
 =?us-ascii?Q?2/qN+W7IqdFpXFdoViYJX1kBdQsW51Gb4kpuojd+Ffgkyv9zmoxGSvfT4wfa?=
 =?us-ascii?Q?mZyfcZtJVQsf0zGWGehf/ZNDjfBg3450gI7vsbwO3Fqws7mMPljD+KDsNPHl?=
 =?us-ascii?Q?ugTOq7fvruARcmxmLGNZYyW4CIF3cW3fU0Cc6R+/niaEG4+ojsKVhIf6naKk?=
 =?us-ascii?Q?EiTD58gfvrNMMHJOZizuZig6U/AZbpqdjt0qtzeNNGUE3D29EaOIPcoJ4OJ6?=
 =?us-ascii?Q?s3rwcs9eZhgXaQz3RO4ttxjhQNxQF6b7FfBojtMOO8owcgb9j9gI3eY6l/hj?=
 =?us-ascii?Q?bPE5eTOoV7GibAeHuaKa7TNwj4dQCnRvfoeY5dg2ysKy5643j7kxoNd8+NlP?=
 =?us-ascii?Q?TtbPN1leTNRftqlQlH934uw1CH/iy1CtUvhy00K8K4U52MMVd8hkFiVCDrOQ?=
 =?us-ascii?Q?QmL/ZgL5iZpdeKR2lrAe74OMPCJM7f1uAJWP91XqLUBeoQpKajs+z0rgTxnE?=
 =?us-ascii?Q?nnSgQ7b9pmrnA689v39zxpA8xqC+nxTIksKpzHqr0AhYR0LxARQG46LT3Jpu?=
 =?us-ascii?Q?euvc5E1OKLYr/8oamTb0/wHtp+yMAOOI6VrCRsxJl279a8hl1rdj7BBb9xDJ?=
 =?us-ascii?Q?i/k0WiZxzuyzyvREVg7IThWOjpk6/3WDkNxMx6JOb1mCuzE8URrpx6ky5++J?=
 =?us-ascii?Q?8Gu5uEbsBpy8XaSj8NoT9/fS0kXvFDQShafFo/gJtS5hjYgjsyC4q0d/vjCC?=
 =?us-ascii?Q?AoHr5FKk+uEoJoC53zBaq2z2icqx+Z6NBmhtz82TjVM8ST6UyjCfhjrKQwCQ?=
 =?us-ascii?Q?wtnTqQ6P6PNtcb4MvPonl2nTQVe7z0dE2OhRUE9hewgU0hM7glzmMi4Itoyl?=
 =?us-ascii?Q?JN++wEo/oEvmWgmTeUy7f4v0pkhXYyKFPtXGP9gATZsuoDXtApKtBPN7PeMf?=
 =?us-ascii?Q?NQBQheCdXZZsY7Mm3Nph/HrDZk9SQ//Rc7a0Lk9HHWRlKQ8z7KpXWmHAvlif?=
 =?us-ascii?Q?GF602/FWkQmKLtSzX1XEy5plVclARCOup0k3grgPZb6wqi3BlA+cPr+W3GCh?=
 =?us-ascii?Q?pjl0YQONXZK9PHvWd/umleNd6l3WWrza/la2NsPtoFA5bEcfslxgXn/CkIxg?=
 =?us-ascii?Q?DeupS7qTymaX/Anek+RWn+aUoLYoyxz3YoGZ7F81jvfJknQ8bcdBOX548HaH?=
 =?us-ascii?Q?LpAj/qDf85VObsH3x61MEFGjy12Gj26BxMhE8i2mGC0Bu0KTvv2HMCIYfjlJ?=
 =?us-ascii?Q?dFCERcxFAN29QxNqm8Ny493/rUctZQxBr0PU0GkU7IoPBTbKUQJOKjb1H01o?=
 =?us-ascii?Q?Veca8KIaRakaYDiO7dQ0k/py/T0Tq4pyQhlUrRjF2nxqziPvNCRKuA+91CuO?=
 =?us-ascii?Q?HYmrmHYpoxFnkaAe2Xl9XACrxUJBFFVqs5LPJB5uHVrkG0PlQVg9K2baY2ZH?=
 =?us-ascii?Q?NV7z/TTbci0Nm3hssraFEuM0RRWf1Z2S9vZRBT/HPSiEWlclVRCezoYvgsYp?=
 =?us-ascii?Q?iuxY2cW4oJjwCSkwcIGJSfE8fJOylurGlinhuZphUbi6hgaenB1VGGCfestZ?=
 =?us-ascii?Q?K9m5Smo/favpRrUJvxZ7dmW2qkQoyRiCWZPpgKac?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce023edd-0045-45c1-8fd3-08dccb256142
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 08:00:58.5722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIM4KKo9MNa+yEPABu9OG72j+dNC0+SD3jP2GF81oA5lqTYutV7NuHp6fw21l0akvWgLjUZKIncd8XsTsXsDEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9231

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, September 2, 2024 3:46 PM
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
> On Mon, Sep 02, 2024 at 06:54:07AM +0000, David Lin wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Monday, September 2, 2024 2:41 PM
> > > To: David Lin <yu-hao.lin@nxp.com>
> > > Cc: Francesco Dolcini <francesco@dolcini.it>; Calvin Owens
> > > <calvin@wbinvd.org>; Brian Norris <briannorris@chromium.org>; Kalle
> > > Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; kernel@pengutronix.de
> > > Subject: Re: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Mon, Sep 02, 2024 at 02:24:53AM +0000, David Lin wrote:
> > > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > Sent: Monday, August 26, 2024 3:27 PM
> > > > > To: Francesco Dolcini <francesco@dolcini.it>
> > > > > Cc: Calvin Owens <calvin@wbinvd.org>; Brian Norris
> > > > > <briannorris@chromium.org>; Kalle Valo <kvalo@kernel.org>; David
> > > > > Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> > > > > linux-kernel@vger.kernel.org; kernel@pengutronix.de; Sascha
> > > > > Hauer <s.hauer@pengutronix.de>
> > > > > Subject: [EXT] [RFC PATCH 0/4] mwifiex: add support for iw61x
> > > > >
> > > > > Caution: This is an external email. Please take care when
> > > > > clicking links or opening attachments. When in doubt, report the
> > > > > message using the 'Report this email' button
> > > > >
> > > > >
> > > > > This series adds support for the iw61x chips to the mwifiex drive=
r.
> > > > > There are a few things to address, hence the RFC status. See the
> > > > > commit messages for details. The series is based on
> wireless-next/main.
> > > > >
> > > > > I am sending this now since people requested it here [1], but as
> > > > > it's out now feel free to leave your comments to the issues
> > > > > mentioned (or others I haven't mentioned ;)
> > > > >
> > > > > [1]
> > > > > https://lo/
> > > > >
> > >
> re.kern%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C6125c51da3704fe10
> > > a5
> > > > >
> > >
> a08dccb1a24ef%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> > > 08560
> > > > >
> > >
> 383160951%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> > > 2luMz
> > > > >
> > >
> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DjfQ6FQimPpwr
> > > nwUo
> > > > > OCEhmpSadtrb15ymGiif%2B1UCdG0%3D&reserved=3D0
> > > > >
> > >
> el.org%2Fall%2F20240809094533.1660-1-yu-hao.lin%40nxp.com%2F&data=3D05
> > > > >
> > >
> %7C02%7Cyu-hao.lin%40nxp.com%7C184ab4fed58647150f8508dcc5a0789a%7
> > > > >
> > >
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638602540229716119%
> > > > >
> > >
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> > > > >
> > >
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DcACBHxaQvcOqu6ri
> > > > > BoAlZDONRlGQ4j5DcglEV9T%2BpYU%3D&reserved=3D0
> > > > >
> > > > > Sascha
> > > > >
> > > > >
> > > > > Sascha Hauer (4):
> > > > >   wifi: mwifiex: release firmware at remove time
> > > > >   wifi: mwifiex: handle VDLL
> > > > >   wifi: mwifiex: wait longer for SDIO card status
> > > > >   mwifiex: add iw61x support
> > > > >
> > > > >  drivers/net/wireless/marvell/mwifiex/cmdevt.c | 86
> > > +++++++++++++++++++
> > > > >  drivers/net/wireless/marvell/mwifiex/fw.h     | 16 ++++
> > > > >  drivers/net/wireless/marvell/mwifiex/main.c   |  9 +-
> > > > >  drivers/net/wireless/marvell/mwifiex/main.h   |  4 +
> > > > >  drivers/net/wireless/marvell/mwifiex/sdio.c   | 81
> ++++++++++++++++-
> > > > >  drivers/net/wireless/marvell/mwifiex/sdio.h   |  3 +
> > > > >  .../net/wireless/marvell/mwifiex/sta_event.c  |  4
> > > > > +  .../net/wireless/marvell/mwifiex/uap_event.c  |  4 +
> > > > >  include/linux/mmc/sdio_ids.h                  |  3 +
> > > > >  9 files changed, 205 insertions(+), 5 deletions(-)
> > > > >
> > > > > --
> > > > > 2.39.2
> > > >
> > > > I think you ported VDLL related code from nxpwifi and you also
> > > > traced our private/downstream MXM driver.
> > >
> > > I ported it from this repository:
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > >
> thub.co%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7C9f55bf357ece47645
> 0b
> > >
> 708dccb234dae%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6386
> 08599
> > >
> 700151625%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> 2luMz
> > >
> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DOLf3OfFX7R%
> 2BT3V
> > > gWtcsqlls%2FI3ceY8r3bewwYy8bAes%3D&reserved=3D0
> > >
> m%2Fnxp-imx%2Fmwifiex-iw612.git&data=3D05%7C02%7Cyu-hao.lin%40nxp.co
> > >
> m%7C6125c51da3704fe10a5a08dccb1a24ef%7C686ea1d3bc2b4c6fa92cd99c5
> > >
> c301635%7C0%7C0%7C638608560383172495%7CUnknown%7CTWFpbGZsb3d
> > >
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > >
> D%7C0%7C%7C%7C&sdata=3D5TgI0r4u2I9Pi1FATJx32Ubn7ufmbYsBR1XkpQLAIyQ
> > > %3D&reserved=3D0
> > >
> > > Is that the one you are referring to as MXM driver?
> > >
> >
> > Yes.
> >
> > > > If this is the case, I think you should know nxpwifi already
> > > > cleaned up the porting VDLL code from MXM driver.
> > > > I check your patch quickly. You ported the new SDIO data type
> > > > (MWIFIEX_TYPE_VDLL) from nxpwifi, but you did not port the code to
> > > > support this new data type from nxpwifi. In other word, you did
> > > > not test your patch before submission (same as some of your patches=
).
> > >
> > > I did test it. It works with the iw61x as well as older chips. There
> > > are likely details I haven't tested, but it generally works. If
> > > there are details I should test additionally please let me know.
> > >
> > > >
> > > > Another thing is that this new SDIO data type should be handled
> > > > carefully with other existed SDIO data type.
> > > >
> > > > Nxpwifi only supports new SDIO mode, so the modification to
> > > > support NXPWIFI_TYPE_VDLL can be clean and simple. If you want to
> > > > port the code to Mwifiex, there is no one-to-one modification of th=
e
> code.
> > > >
> > > > Another important thing is that you should consider if your
> > > > modifications will affect existed devices or not.
> > > > You need to check if you should check firmware version or chip
> > > > type before adding some code.
> > >
> > > The VDLL code I added for the iw61x only reacts to the
> > > EVENT_VDLL_IND event. So as long as a firmware doesn't send such an
> > > event nothing is changed with this patch, and I haven't seen an older=
 chip
> sending a VDLL event.
> > >
> >
> > How about IW61x? As I mentioned before, if you test IW61x on DFS
> > channel, command timeout will happen.  Without correct VDLL porting,
> > you will encounter command timeout in some other test cases. But
> > testing on DFS channel will be easier to reproduce the issue.
>=20
> The VDLL support in the downstream driver supports a case when a VDLL
> event comes in while a command is being sent. I catched this with this
> test:
>=20
>         if (adapter->cmd_sent) {
>                 mwifiex_dbg(adapter, MSG, "%s: adapter is busy\n",
> __func__);
>                 return -EBUSY;
>         }
>=20
> The downstream driver defers handling of the VDLL event to the main proce=
ss
> in this case. I haven't implemented this case in my patch because I wasn'=
t able
> to trigger it, but is this the case you are referring to?
>=20

Not only this code segment. In fact, you did not add VDLL data patch suppor=
t to sdio.c.
If you try to add the code and do test, you will know what is missing in yo=
ur code.

> >
> > BTW, it is not a trivial job to port the support of VDLL data path
> > from MXM driver to Mwifiex.
>=20
> Nothing is trivial with WiFi, these drivers are complex beasts. Be carefu=
l with
> such arguments though, because duplicating the code into two drivers make=
s
> the situation even more complex.
>=20
> Sascha

We will only support IW61x in nxpwifi. VDLL related code and future code fo=
r 11ax
won't be added to Mwifiex. Other difficult things are NEW API which are onl=
y for new version
of firmware. I think you did not aware of that now.

David=20


