Return-Path: <linux-wireless+bounces-20366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD50A608C3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 07:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618013B61FF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 06:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369573FBA7;
	Fri, 14 Mar 2025 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wy6ETz95"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA72F3B;
	Fri, 14 Mar 2025 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932276; cv=fail; b=WMsWYMk88a6u+95pml1mNse4ezEMO4ACRqUIUJxvYDOvlY8P7F/mrcwNppWGPojPOaWOt+M8gru3b+xcO4U5vJ5iFITy0icx9op+qpeENYBg+tgQmGU0eO3tl4gRM/5SykHlk8xM+911+gIUMTZM1YrcfEQfAj2GRb+zNRG/vOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932276; c=relaxed/simple;
	bh=hbOCptnz8wx2kkyIANw8HsQum2nMl5sZ8jdz1xEnr3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iI1vGxow1sqVW3rOITjMIkqttJECuWKWz0QBQQJNFBRKLPkj6ekNZ1PzsD8575gXQkwu5ZJvuqhKcf1PtZ4ih9OAV7ZhTRVdvt+3Np8YZZ4KthbyplhRRkjsYp0dHiwAA8vjv1fVb3IOFSQq+IoqrTuQLqpMxVrsTKFYUjSU1ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wy6ETz95; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXHzCCxqyRUYrp+d8CtXukOmHBH6wMD6sBnp6J2EEOWSoFzqk1WXab0Ivx9TgQamPgEi1Vdj0S6X5yNHJ8YwkJMNJCiBQFJBtoZRwdgw+SRFHNyR1ZOPE+M3E8sd9ECXsyZkUvjcq9v5+4f4sodmyLIV5tWk07SXahxDVMI8peTQhfUDE9bO3M16r0Oof6pgJo28wLxOHCClh4ORh+0bZflC2ilQPtXWUAU3ZvwbiyJ0Kvydfl0XTAnn7iXEwayYYBkmJFSZ4Pq611fI3rf44gdSy/inU0JlX32sdyA329UPSjDYroBy0VrJfH2UyX1cJHqFJhKMCH8L9MooZtZWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+K+ZI6bqpuM/0op+BwtBVUD+VOeyOybeK70l8zOsSk=;
 b=pw4TkjGqBcb6Y9NjC4mSWNysdiuRxvPkkk/fZEiaOFOXA+CQgEGXKw9gBAiyVtXixPgxLV7UXDP5H9obvE7P+4449aeV7PpcJk/vPpPS6A02em6FY63JgOB/KyCG7rcyXU3irsnc9tpXeqiXQPSdpmojmfcK8ySpCfZ+Mx/W7kVEX/v373RVQWqsKLduIg/gIK0glU9kIsChF0+RyY4CYLGZhD/4v5QudFgOEmUchLLIfEq8MMxR1U5DwszcCktbc/zO6jCrSVIXNnMjP2U+RehbSoLYQJ1QSyYVcBg69ZZ9yl3ntL+JjYA4ls5dBVgUejWXRzPm5VSUqtFqipw15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+K+ZI6bqpuM/0op+BwtBVUD+VOeyOybeK70l8zOsSk=;
 b=Wy6ETz95YW9EAwMJkPAP4ozMbaTMZD+c9oYDTMFNs3hEJBm/Cl00tq/7MwIL2UrJRWIDUTM1FdP/B7G5yo6ziMF3qhof1Z6wzAbCYMgKoMC+hI320K+wYug4x/ZVjq+hqm2TgnbiQdAkv/XJJpvnnb2RqkXcAEQPuuOZCP64OBrKOiB2XhqSI7Zl8fg/glRrzqwoFKq2puqOlL+xYmtgc5xjqQjwpryEMUVsVpjxAhY/OEih8y3/BhKGuybCIAqA9GXbh+MUmBPs+mqUu+FcAqSfZ1XAcAnq7Leqn3EL2gJJJCG8ELexazfFpfdRus3mdYus6Nn1ygxUxAMBej5+Nw==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by DB9PR04MB10065.eurprd04.prod.outlook.com (2603:10a6:10:4c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Fri, 14 Mar
 2025 06:04:30 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8534.025; Fri, 14 Mar 2025
 06:04:30 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH 2/2] wifi: mwifiex: Fix the wrong hardware
 setting for HT40.
Thread-Topic: [EXT] Re: [PATCH 2/2] wifi: mwifiex: Fix the wrong hardware
 setting for HT40.
Thread-Index: AQHbaw6DFeByIlp9d02YfmzX8/uQvLMfgjWAgFLEtqA=
Date: Fri, 14 Mar 2025 06:04:30 +0000
Message-ID:
 <PAWPR04MB99109CC10ECD8EAEDDA56DF79CD22@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20250120074011.720358-1-jeff.chen_1@nxp.com>
 <20250120074011.720358-2-jeff.chen_1@nxp.com>
 <Z44vj59nWIiswq7s@gaggiata.pivistrello.it>
In-Reply-To: <Z44vj59nWIiswq7s@gaggiata.pivistrello.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|DB9PR04MB10065:EE_
x-ms-office365-filtering-correlation-id: b464a046-dda6-49e7-2741-08dd62be15e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GZWyz1tlkrlv2CEBhVOs/tW+BS8Faw6gAdwB3SRmTmvds2QCNIB+RXt4/XOg?=
 =?us-ascii?Q?MtKAoOliFoz/ZvRMVdlcgyMWn+75oFfq4XhSCwGfO3I3TqqoH6g3TFUoWH8x?=
 =?us-ascii?Q?Lp+fbe2F5p0ILvuPVQNyzbxWDbitppLXO4nYqrx2z/mO9U87VGbgY0BN9vXV?=
 =?us-ascii?Q?xaZmxt+qSag+7jAL9tTQYn4nfkpmigVHqpV4Yv/yPZls18g3+9AoY+HnVJzG?=
 =?us-ascii?Q?+D9dcfpNfarwbGN2urnjnpmqPcB69nKeDrtrCwJMIxrjb8g3Jw11kpYM921J?=
 =?us-ascii?Q?fV3EizI7HmzbEMe+Dd6AtAqYzgL38j8o+Fv7wfXwbGP+YxQjDQdIQtXO//DE?=
 =?us-ascii?Q?hZgPNhHen4vlmOFAaigTqrDH01I7kdWZCTKQ9BFxOIjcDwh5GkaBomZXw1D3?=
 =?us-ascii?Q?Zv06SiBdy2yGtgm/rEEUhkthq/mfkio9e7IsJKaI7+Hh9AFeFfL5KPE2FObN?=
 =?us-ascii?Q?P5B2xv8N8FZcXAj89GO3ZTbTT9MtPe+ThwuXMl+ZPfUSF6NaQG5svdABPz2u?=
 =?us-ascii?Q?W31FDmpqxleAWq3/xUyAGuK/R/5vuL/5ipOB3NBcD6DnAR5SNLMHyWYRM0kZ?=
 =?us-ascii?Q?b5ro2gCPZWfhUb4z4J7O9FCH0XaFabS01UtyP5LtYEa85TD2g03bQAE+fgDA?=
 =?us-ascii?Q?4mYOlStG75TDbKxOCbkF7A0aBUn5wP6qHyiEnnpG9mrpc++OcHm1NZGuGDAw?=
 =?us-ascii?Q?6dnY6D6CBRH6edGbBVPhbc69zCTEiKkcZrXGogaAQMJtdaEqFGotkFQ6zSx8?=
 =?us-ascii?Q?v12FuzSutA3TI62rfMLVs0f0sqHK1uG24en7KzJM/i1dUj4HUFPqHAe95bIc?=
 =?us-ascii?Q?aS9lRVO2bIgrYzID9nAUotccvgrYVcrgfsIT/LSiHOQt00gkfxrLCQGQeHGK?=
 =?us-ascii?Q?7EGIq6xrlHFKF5aI4uwuNP6GS6p9yqt2hZzZwQwprT0kiR8Nbh6lMwRN+Uzx?=
 =?us-ascii?Q?t6f3Y1/hBCZDgYO1L/nC66CurUlSJ7lzsVyKc7b4CEYsj38GrzL9ixbUnVm+?=
 =?us-ascii?Q?SkkqIclEYtPl15Gv/oIGU9G2rybc+exzF5SGFErH9WojKlYDb2T8VvteJOse?=
 =?us-ascii?Q?TVHDROaYp2UJTGtgWkXxNNBihLSHkYhSPZr3GoJ1E4JGLh0KQgmXUP0xjxGs?=
 =?us-ascii?Q?xeIhJ7nof34fKYuBvSXCsoK1Mz0zoUd88vrJnwrJNCACcl2+7LlQcO31pLtH?=
 =?us-ascii?Q?uObuwOVIo4aPzT/RqjI7vvk+XKp/ppLL/7JKxfa6uk2ROntQlb3Ji2Cyxa5l?=
 =?us-ascii?Q?q19uTlE1jV3/8LQV4hkcj3NIxqEIjUajfZBKKvkjJm2Ms3yT0QP/XnY5IUSv?=
 =?us-ascii?Q?qt+4nkq90e97JXXNV0t+9WyAVvXme/w/vnZr1WzrjBW8nefva16vklT8ARl1?=
 =?us-ascii?Q?SoGqV66gwhE9Qnw2qC6rucA4z3yG4n7B4GPX4RcbdDOHxixngigSyx+sGt/P?=
 =?us-ascii?Q?qYwMM8avM1NDFs+X0gqWh3pvONNUcAj6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SCQ3guI/6adrdMfpLd3nI0lul/wZMK36DwIZi3D1BeHlU4B/sld8CMS5vkj8?=
 =?us-ascii?Q?WBZCJMdzGskkU5W/+02WXK+HDLkkIGX/fc66MCUk9HUjdQp5T1FrmF+bvug/?=
 =?us-ascii?Q?nLsF3zqNPo5Whx21assNKYx2ktIhfD+QNqnu/yyd0WE2QdZMsSSXvg9bJcOV?=
 =?us-ascii?Q?19Cd0G+/BU/QZPy/64BVsvXioTbIziLUspwIqWNH8u3HPC93KuE1g6NSupWG?=
 =?us-ascii?Q?GYkKJLNNEtbYVVVvSAk0OVmNjYX6da3QjICND6tds6oTiQ7o975BJ7vM6Fxz?=
 =?us-ascii?Q?qeEK6P3rZMCZO7BK/3jqI/6vchHzeSZEg1HsFKjUIAlu9nZF5MnelNSa9sMs?=
 =?us-ascii?Q?NUJadYtPqSS4Dv6H6Gv7FgYMvH3VHT7QVcZ5/HyFZpyuJNMcHj4rYhSWDwEl?=
 =?us-ascii?Q?+ORQsRvcuhiqbHyrz8KIcFFTZc5OmvYzyH49Z2Aia5QuWGlnqzdqE5DmrXG4?=
 =?us-ascii?Q?C+7p3Gu/Pq3dQZMHY8HxvIVnvinU+9c1iRqed4KUekty8yvhTbX0uKJxp0ro?=
 =?us-ascii?Q?FrLN5fz4XpEOlOUr4yCB+23FM8yAEuLCSXF3CQEaq092avvwHVCrHRhd0cNg?=
 =?us-ascii?Q?JCm4TOc0adDLzAAkgNZOEhOazn+ns94J9TYWe6LEmg28eO7Ol4Pbc5bXtvED?=
 =?us-ascii?Q?iqo88r8j82ek5eW2v5Sjc/SEoK8s34qsjRBMR935851sJnL0Z9mhQZfwoaST?=
 =?us-ascii?Q?99REXkm2mRukdBJEsWQ7FjzPt02j1q9XYjR/t6POf5J71sSEG24PccuJKHTS?=
 =?us-ascii?Q?VoUH/oyBr6fHwRlihcb+jKf6AvB9OsALJyP/xipMVSoWO6CGTmmYMsy3eABF?=
 =?us-ascii?Q?mDF2hNoBM3eLwGxcKcXYGFEp/x0tuC8hQh0pd/rcxFkJRUX/xHmPcaIQr59E?=
 =?us-ascii?Q?avxixysEHn/hlVQ1fOlJxA7cNhVDE6mxfdvGL1uGZ9MOwvkAjWxRc5QW3Qmx?=
 =?us-ascii?Q?A4Mtkbj6Q1NPtEZurCuD5MGw2WHAgiYw5L0KGVZdFxiFXeW4DQi8DuPkPxXC?=
 =?us-ascii?Q?jcP96//Vmx4ESsp9hRIsnGoafxIiXYTPgnru2qf4xHXISo+iQFdAmcOYqigk?=
 =?us-ascii?Q?qpgEH63oRcRhJE8/zHeCkPrXT1dUi0ckmLVGQhl2WHCc0jHQb90s3DqXw3jq?=
 =?us-ascii?Q?eumkM1sVB64P0kEGmJ8ujZTsC7hswVhMG7OHpFuKOMvJm1yh6mB2cOenTn11?=
 =?us-ascii?Q?oX1qwrYthWBXsyFU4clUNQfkZJjNgqbM95oaMjdgtJ6mbX5c+XRKdH54TzgX?=
 =?us-ascii?Q?VkS2M9Kgo3UwNOeQ5+H9fHQh58ORV7sCaN2fl2qoCuK9RWTo8e7n88iOh6M4?=
 =?us-ascii?Q?2NF7pyHSvco3h9RlDEi9JIvm0ToxD/wZR107tRwvEcmy0pjAbuAj2S7vf2df?=
 =?us-ascii?Q?7EajkGBSemI9UmPAg6LD0NqAdxWLjVyP3UNaYg0BTBZUPeAYXg81WjEiRfEH?=
 =?us-ascii?Q?QUhDt0naTE1Cs275cdAfTRkWPzZGwXe0plSP6p14JwQ2U/lHaBdYFE5rMzrg?=
 =?us-ascii?Q?8aHdKUW3QfyrSBjsnvAJWll5wHJNkGyxtKqlxGDpEsWWJHEDivc9ffvdEhlh?=
 =?us-ascii?Q?H+twp9/4Y0E9ljIlckjxGyG3dgPB6Qc8PCeyNXOs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b464a046-dda6-49e7-2741-08dd62be15e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 06:04:30.6829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJfRiDEdBdHYJUjtbratmr5H3exynCQAhB4z4j6w6wSr7kf4T0qhhzdAKe+j4SYJqXRRkaq/1zyd1qp0aydujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10065

Hello Francesco,

Thank you for reviewing the patch.

> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, January 20, 2025 7:12 PM
> To: Jeff Chen <jeff.chen_1@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>; s.hauer@pengutronix.de
> Subject: [EXT] Re: [PATCH 2/2] wifi: mwifiex: Fix the wrong hardware sett=
ing for
> HT40.
>=20
>=20
> Can you expand this a little bit?
>=20
> - Is this a regression?

- No, this is not a regression.

> - What is the impact of this missing configuration? It's not working at a=
ll?

Without this configuration, the connection operates at 20MHz even if the=20
access point supports 40MHz bandwidth. This means that while the device can=
=20
connect, it does so with reduced bandwidth, potentially affecting performan=
ce=20
and throughput.

>   It's working in some unexpected way (please explain)?

As mentioned above, the connection operates at 20MHz even if the=20
access point supports 40MHz bandwidth.

> - Should this backported to stable (probably given the answer before it s=
hould
>   be obvious the answer to this question)?

Considering that HT40 mode is not commonly used on the 2.4GHz band due to=20
limited bandwidth and potential interference, backporting this fix may not =
be=20
necessary.

>=20
> Anything else worth mentioning?
>=20

There is nothing additional to mention.

> >
> > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/11n.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c
> > b/drivers/net/wireless/marvell/mwifiex/11n.c
> > index 66f0f5377ac1..4ae0b4aaa09a 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/11n.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/11n.c
> > @@ -308,7 +308,7 @@ mwifiex_cmd_append_11n_tlv(struct
> mwifiex_private *priv,
> >       int ret_len =3D 0;
> >       struct ieee80211_supported_band *sband;
> >       struct ieee_types_header *hdr;
> > -     u8 radio_type;
> > +     u8 radio_type, secch_offset;
> >
> >       if (!buffer || !*buffer)
> >               return ret_len;
> > @@ -401,13 +401,15 @@ mwifiex_cmd_append_11n_tlv(struct
> mwifiex_private *priv,
> >               chan_list->chan_scan_param[0].radio_type =3D
> >                       mwifiex_band_to_radio_type((u8)
> > bss_desc->bss_band);
> >
> > -             if (sband->ht_cap.cap &
> IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
> > -                 bss_desc->bcn_ht_oper->ht_param &
> > -                 IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
> > -
> SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
> > -                                       radio_type,
> > -
> (bss_desc->bcn_ht_oper->ht_param &
> > -
> IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
> > +             if (sband->ht_cap.cap &
> IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
> > +                     if (bss_desc->bcn_ht_oper->ht_param &
> IEEE80211_HT_PARAM_CHAN_WIDTH_ANY) {
> > +
> chan_list->chan_scan_param[0].radio_type
> > + |=3D (CHAN_BW_40MHZ << 2);
>=20
> setting `radio_type |=3D (CHAN_BW_40MHZ << 2)` seems the only real change
> on this patch, correct? Anything else is cosmetic, correct?
>=20
> would doing just this change be equivalent, right?
>=20
>         SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
>                           radio_type | (CHAN_BW_40MHZ << 2),
>                           (bss_desc->bcn_ht_oper->ht_param &
>                           IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
>=20
>=20
> Francesco


