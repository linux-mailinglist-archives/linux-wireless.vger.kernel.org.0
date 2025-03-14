Return-Path: <linux-wireless+bounces-20363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A5BA607A8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 04:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD00017DF4F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 03:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADC62AF14;
	Fri, 14 Mar 2025 03:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NYbHtGD1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012071.outbound.protection.outlook.com [52.101.71.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5FFF510;
	Fri, 14 Mar 2025 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741921583; cv=fail; b=l0xz+csr/vPVWi0WolpS0UtLrRwDai6031sRkVfyaMDwkE0qWXzwblZ2QumP27W4+sA4ymLb1nfEgPzqfNaNmSQ+T3PnEgIzR1nGU85GT5w5tjHbNGRRjzkMb7eLTgbfwEVa/38jCvhpLcBRRCsHeataB2tZYvbZdBHuruf/680=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741921583; c=relaxed/simple;
	bh=zhItjvjI09U+CIlm/++ZkMk0XjPWH6hoJVJ7AhZ0U+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=anK3mQ5PXquti+q5yWD1hyfp0kl18DarbcmgqQElIMvOtn8J95ZwZDzi5P1eF8dum5qKAGqKgHv3SX87yp5kdDVgv2p4R6zPfQd/OeyiGbY8WujBzbShS2M3uyEcn/5QPtDVPfFkKmTXGgmP6KfsdlQsg1A1HPFNwp7w2f6l2yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NYbHtGD1; arc=fail smtp.client-ip=52.101.71.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a32Fj+q3VBDvSpV8YiMz2d9oWAne/ZnCYxhQhAfNBaaPMw0I53XG6abd1sy7kdADuDMlPUrSEWMpWXjOHGQtiJKfcR+xZjZIj4A0j01RoLCr/PPYzDfJAtX+4eRVGErK71XpMoruOzDZf+SfCeLvs7mPEIL4jGcjxuXVzryTII1ovEufYlEEOg7Qr7IQixl90c0ZFIAdrlfOgiQMAbo4V68HcNNX3NvBm74ATKN5j2AQynd9C6b/m//dZHraNuE8OB2XpPm0biMPy5SGc9bcRi0M+pqaWieiG0GGvBIZnMCg1VuFrpJp4m8HYBi+LlBb0bw1jqrYsxo8Ad7UUdZwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w4TVRSq1wnu4LGREGpWAPHNLdFeb+dVEU2OCHtm3NU=;
 b=yeUnmWeyZ5F0a1kYfr0oF6nlkF1/kIakgGUQ9ciP7kxG+FhvZ3SiCEav1fN0GvW4crhXRRp07v7+AX0q699xDDq0JgHY3pag7U7IOXRMKk/xQfuDmIGONL3oFefnJWnn3JFrAHZ+/8Mrgzr3+cDvJipLx/ChWr7Hw5iSTAeLIiO1W8dBto86ZVD3rzVGPtihOvwldURi6cwhOSuCd+MT4Nkmc20pT3kp2UrXTtKTa7l36l7koZkgoPCM1y9WbHTmVXOJ9u2Wy4/PFNpXnG4gZxakVE6Bi+uen+mWC0p8zWotGAO0vGnn044ht2w2DtF4pup+VPtNK+1OoLokv4RNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w4TVRSq1wnu4LGREGpWAPHNLdFeb+dVEU2OCHtm3NU=;
 b=NYbHtGD1JlggbkRughJH6k8IX4E8v2f4ZlpNsINnX36WYC+AxSKawOFGU6QpsNsWcicA/Wh0MPz/4QQdp7XKAQWITL/rvPIpRO+N9RyB/xR+Rsv2po1ZqNBOeOoM3pLLOS4uXYdwQL2KpXPs2fR0o84yjHOaGuPMe/TPWnS0QCoat9F2P1v4NXQ4A6gzx/AJ6MonYCDcrp9Xle/wyau/jNMkGeUWScuFlJrI1fJA4NTwvVski6f120HzzVaQHvgqzratmlMRq/7NYex+bey5ST63YzbY2Ko+qJXW3qH0vv3H/HVcFIdgoel71e/ohNKmZoRjTJELwAtXvmClN2nFhA==
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by GVXPR04MB9760.eurprd04.prod.outlook.com (2603:10a6:150:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 03:06:16 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8534.025; Fri, 14 Mar 2025
 03:06:16 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 2/2] wifi: mwifiex: Fix HT40 bandwidth issue.
Thread-Topic: [EXT] Re: [PATCH v2 2/2] wifi: mwifiex: Fix HT40 bandwidth
 issue.
Thread-Index: AQHbd21GYtQrCAygjEeiDEJzKvnz9rNmGMcAgAwIfgA=
Date: Fri, 14 Mar 2025 03:06:16 +0000
Message-ID:
 <PAWPR04MB9910DD6135CDBBF46A4030879CD22@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: <20250205012843.758714-1-jeff.chen_1@nxp.com>
 <20250205012843.758714-2-jeff.chen_1@nxp.com>
 <20250306103754.GB19853@francesco-nb>
In-Reply-To: <20250306103754.GB19853@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9910:EE_|GVXPR04MB9760:EE_
x-ms-office365-filtering-correlation-id: 37c14b03-70f9-47a6-03b4-08dd62a52fc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LOw0nxRufD4FLsv09X5LQ+rgU5kSI7IHchwPx5vMrN2KrkMPdhYQJdB1tmn9?=
 =?us-ascii?Q?TUg9Qf++aVuS5rs071x0hkmVoSUMFJj9KKv3Wp/TbKOEE1jOhnUFR61pmPPr?=
 =?us-ascii?Q?HlivaV3vMqlpKOkPBPVF3SzAPwpb9Uh4OyzfzN0JzV+B4Wo9Flz9xRtNPkvb?=
 =?us-ascii?Q?cmAXgOselw+2ubH2SKEKxQYTYY9iXCgP9kN5QredP3yoRmZ4Cbx8nwOzrERg?=
 =?us-ascii?Q?YbJ0JJJkVKD6WJFc48FrDahalHRAGVyKqoH8TdcgE8OkluavW/OsPRk+PYgj?=
 =?us-ascii?Q?Q0X7kNmAYMuPd5KwBmIQO4K8EVswx5nTODWWyD6waFwj1XACTGHi51jvi3qj?=
 =?us-ascii?Q?4/u5PqI+JEvGJbDwSt3ceSGdldWsVEusAtKzbxQ99ARLjPJNEthImWEIv6QQ?=
 =?us-ascii?Q?NUJl90LqIax6NRjDMs0WdrjUTq2s2eCbGXP1ME2MUecrsJV1//XL+qYJkXhS?=
 =?us-ascii?Q?NwLyyaUSWPxIl5IXh2zlRbtZTFTqn9vglD53kzjWMRPvv5GuVyfYXmh5q+ul?=
 =?us-ascii?Q?lBpsgofDcoRaUeZKaYF9W5LcyzJXycnqiYnr4N+jc4eTkKHPrHiJIDOuX17M?=
 =?us-ascii?Q?lH7MzzlOTIZQazF/7iZ6v5C2d30olIsBMmqvnx2hxYNeuYYMvdrcWrUrGsLs?=
 =?us-ascii?Q?DdTScPLjpY0JM+0u+cwbqrBzD8DefTAsWC+BGCvTJKU5oMkg3nrOXyAL9NNI?=
 =?us-ascii?Q?Q8vS/2CzmfZt74JgA4TZbUgfMWSRHNmBy81Hyf1R3d2fROuYgdVoWKudqAyi?=
 =?us-ascii?Q?uqOja1PaSgeql7IGtNnVGlWLFNPpQr5pUdvMkIYEEhL9PsaNPf+Jp9icNHlb?=
 =?us-ascii?Q?KKSf254Txrz/EP74QsJwJm4kN+4atCtXQ+4YxTZ2B/2i7hxiLTsLEhO+MOmH?=
 =?us-ascii?Q?W5R0652Ci+5Yd17d93SdzW3FwMhofzD4FgCsZRnC6rEf9vEojBylx3B7ZnWX?=
 =?us-ascii?Q?07q3uIOPB5alavFV8jBEioR2Ts6abYJU0GjgIlPKnJD9D4mr2b+Z6XY04jUi?=
 =?us-ascii?Q?mnBJQZJT41/vPN2geXS1Jg/Qm8+Rg9p7F89fZl40P67xA4xzlESWJCwO33ru?=
 =?us-ascii?Q?BKn9IMgm4JANhkcfFlYzrKBEXzfuuTaLgQpib9t8BzfkB28XelcuPWyFUesk?=
 =?us-ascii?Q?7P9hyGD6+8x/Y7yoGaVNWMLcsASP76RPSNRbj6cllzkFbyhmH+C50TD7X1XT?=
 =?us-ascii?Q?1bbUeOXIRcqCWAQr46VG31fEtKti6DyFCR5EBVnNdjJdsSJT8eowMdg7dpWh?=
 =?us-ascii?Q?WR+wGo/491ujUOUoeL9s+oUyEOr76QgL9Dnjk50JXlNR8X4PvM0Qj8rUy5bl?=
 =?us-ascii?Q?ERKV8BoU4O5Q+ZdEpH25IxIo+jz3kKF63OkrUDbqnkyG1TfPEdRffJBADGTo?=
 =?us-ascii?Q?1EAbwznjtZG9Fu4wZ71Fu+ZIlahR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Pq+h1Hb88AXOAKL1Kd4Unu5gCZGtwYBynm+iJu40HIZpKTkHvsl/0HPST/BM?=
 =?us-ascii?Q?/IlZ3hN4Feck9cnORaoTS2Pj0WkSrnIfI7RcoEa4UttZO0DzbNZTTnZTT/Wr?=
 =?us-ascii?Q?RSrzASUiTszODXGa7sKWTzde+jJcKJYUeS4uaIpcAgYHpBko35bUFGqQr0xd?=
 =?us-ascii?Q?PPhL9E4hugbVNHuSx35ssAXwk9t9q5DFS/sQfyybZyIpE9YcgjY9MZsrrEWD?=
 =?us-ascii?Q?Sd3xD1VIcVGkpKz6Vtpc4JLb30+1Zm3vCv9b3h9q7/7XXtEVmNGR+tST6fIU?=
 =?us-ascii?Q?80wYJsUGxo5OylkoG703TtUnHRCtvhIxJJgAnqi5IgrUcUJwk/cK1qbdDrLb?=
 =?us-ascii?Q?JN5pDFU7Be4mc49U0FOV2fA8Jgj5Wpy2gtOoFYD8nVF+pjVdBImtoZvctpBL?=
 =?us-ascii?Q?LebAg7fZ88Wwu8BRjJV1d3JMFt49j7MUYr4QCjaZ+ybD8ZOUbsFHube5MCmz?=
 =?us-ascii?Q?59VydzZG7lwZHiCE/aP0XX+qwold6Fd4Trxz8LH/iR8+fLzvCmghJnYux+NV?=
 =?us-ascii?Q?7BLcBlNMKy+9d1aBMNo9CrhO57YagmywSbbUAE6/6rqI4SksZd0Cf9GDlJiq?=
 =?us-ascii?Q?ZtRt9kw8ULGY7QAOAmFKkeW+oiNUd1VnGUd33xBNaVqHVMdxYLk8D0h5aS/s?=
 =?us-ascii?Q?t61U9ATE6Ocg8zndEzJIHSwLEPQuOpOcPwDTxBty3Swf/NdYTOK/r1mdsB6V?=
 =?us-ascii?Q?fHJX5btU0Jou+uxbsUEGRRBfhG2+TnILYNjAC1hldJLvhfd2MrLpk/IrQ2fy?=
 =?us-ascii?Q?H27DMIz8ezA1WnRAqXhq+LcL7Yf+lUEsvroIAiHf/phKs4q8jZA0LqYdrbaA?=
 =?us-ascii?Q?a4vRnxKRucSIcWTNiOuPAWS6qzP8cv6CGtdJFzzMHSM4Ii6rtyFN/BXGdz6r?=
 =?us-ascii?Q?KujaEKzcJNvOK2R5ESwUHwZF2YYghFSPFkpBbWc4dY47DFA0AAb2nORMByRK?=
 =?us-ascii?Q?/EG3ZVpA0DXQ5ozSgM9NuoyweiuuYs2Nf3aW2nE4z5e4TUDHIlTYNHd+MuBA?=
 =?us-ascii?Q?u4zw5z6zTAj8bqlFBDK+NXPgu9rA1yyZ65uVmKMNGUiYmuOUJBMUq33yATx1?=
 =?us-ascii?Q?McWEAxD25DuyfCbM/6CkL9YKS8yO+VMCAxyUk7+L84oMzmW8ofu6kF5gIjaN?=
 =?us-ascii?Q?trgWdTldL6NJBI0G1iWl69kPmGokMDbiEZj/OQv4kaMX6VQtd7C5pryx7lPA?=
 =?us-ascii?Q?tImAgr/MFVBox1wdgaph/99QsMT1ZrKSARpw3tOxTyFfkXa02HmcBLtk5wbW?=
 =?us-ascii?Q?FGYQfUM3FehI33wZPQnFuhVqHCYVOgY4L3MJcA090vFQDKa7/iSYVdJcAk8S?=
 =?us-ascii?Q?f2sr0N70+5ARIWtxHsqoE3wZEYGT/vauFtJGH4OudTwYflIlOCNKQQcHb7Vf?=
 =?us-ascii?Q?hjJFA7udi7CC8lkRgCahA5cx8A3mobNFvtlfCPFw8tipWEj6EWxWECVdL7jG?=
 =?us-ascii?Q?Wx63F14VmLZDsez+vojtgowfuEssMEBTnE8BdFkU4QRpHeGBRUKI/zwNQVW+?=
 =?us-ascii?Q?5OTaSynhIBsGoTPe19Vi+bUgr6KbG/gosIxHGEPDvAtiStzzTkkLdsPRdP64?=
 =?us-ascii?Q?+viG8gJrl0+fmwj1UMQ7IABsRfr3TnOmwgHsilTW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c14b03-70f9-47a6-03b4-08dd62a52fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 03:06:16.6215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxHAua//t/NgcQ/1wG7oDB/b3zI8R6JXuKtwbcoBAIcbft1hfpMY80xZH0F0j1aswdwZ0EF9HTBq+D0VTX2DJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9760

Hello Francesco,

Thank you for reviewing and providing great comments.

> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Thursday, March 6, 2025 6:38 PM
> To: Jeff Chen <jeff.chen_1@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>; s.hauer@pengutronix.de
> Subject: [EXT] Re: [PATCH v2 2/2] wifi: mwifiex: Fix HT40 bandwidth issue=
.
>
>
> As you know this patch came after us (Toradex) reported some issue
> connecting to 2.4GHz network using IW416.
>
> However according to this commit message this actual fix is not related t=
o the
> issue in which it was not possible to connect at all, but it's just an
> improvement. Can you confirm this?
>

You are correct that this patch primarily addresses an improvement rather t=
han
resolving an outright failure to connect. It ensures that when the AP suppo=
rts
40MHz bandwidth, the connection operates at the expected 40MHz instead of
being limited to 20MHz. This fix is not directly related to the reported is=
sue
where the connection to the 2.4GHz network with IW416 was not possible at a=
ll.

> Can you please also answer the last comment I had in the previous version=
 of
> this patch, see
> https://lore.ker/
> nel.org%2Fall%2FZ44vj59nWIiswq7s%40gaggiata.pivistrello.it%2F&data=3D05%7
> C02%7Cjeff.chen_1%40nxp.com%7C608bec5740f046d9409908dd5c9af5e1%7C
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638768542804304282%7
> CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDA
> wMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7
> C&sdata=3DpiD%2BBLUEqdCZgomWsxtKFGS7RAfj0nk0tTsQYu%2BEEwU%3D&res
> erved=3D0
> ?
>
> Reported here again for you convenience:
>
>   setting `radio_type |=3D (CHAN_BW_40MHZ << 2)` seems the only real chan=
ge
> on this
>   patch, correct? Anything else is cosmetic, correct?
>
>   would doing just this change be equivalent, right?
>
>         SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
>                           radio_type | (CHAN_BW_40MHZ << 2),
>                           (bss_desc->bcn_ht_oper->ht_param &
>                           IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
>
>

Yes, the primary functional change in the patch is indeed the addition of
`radio_type |=3D (CHAN_BW_40MHZ << 2)`. The rest of the changes were
made to pass checkpatch and seem unnecessary. I will update to your
version.

