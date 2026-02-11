Return-Path: <linux-wireless+bounces-31737-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DedI9mBjGkYqAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31737-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 14:19:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11337124B28
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 14:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 084883013EDA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 13:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9F22127E;
	Wed, 11 Feb 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i4pHMpxb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF2146588;
	Wed, 11 Feb 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815959; cv=fail; b=rKX+lbmrZ/QBSFIZg4izNLrhP6xezfbah40qyByFhs4NETX7w0oO0whAq2bs8KUMpkmPeYibBwC+cUMTdjMHthNPisxadPlmqloAg0c9bAvavB9KIZSXMYIN6wqgF4tp51a/SrZDGci2KjizZ75jy9keOWcqQ53NmHPi1yoI4H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815959; c=relaxed/simple;
	bh=Fh5r5T1exYnMqHDEK1GX9sivRNdTsMVZUgsi/HbWOEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lgggd5xdJEGeQZhgQQXAVzA2WvF84L1Z9RgXYgB5w7M0k+JJi021TszvtFGOmV/+sX/OUlEBxl2f9eZ4FuLUwIrojGMsPres15wU8JNbtcmq+Hl/AJA/f5BLhnyeovF/w/cRqLjPJTTA0+/1Huq6PMvvw1v26v8rUbOBv7eMpEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i4pHMpxb; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uA4moc+Y4FutkwDtdmSHdLIPEn9hXfSDsAW/s2foLUUMzye66gxMY857D5BrraY58W7Dzk3mkc3ckVJOKwlkLVWxkQYKL9+poHsn2axo/JPY5zfEzQqVl27mT8lhrzr4P044bSsl/mw091AD/RagDxz4LXfOBXS8R6xi2gdK4If8SWn/SkJmihBN9FlFHzdkoEYuMZVzAVa6hgJiV4ykl8T915Z66FzWyVq5ZeT6uQ6PsfzV23HqIHeSHksO6dQj38b4uBMi4tweDsFcAHvPBTS98f7W1L6PtehmqLItUy1//wDZHCKZgzZUY1NrhxT6QI23oprZ8ZzhV37ZKcAdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyAbzpMyW3fu45C2DXT9tKeynVzsjzBb2Ktttx8j7BU=;
 b=anZHXF/kKX3XRVYlHjnp6ycE4Gj3NJcpmltAr9fKeBJAf1+GPJv5S7yyLiTnlcoPebjY9i6JA/wvE+UzC7SUJpcak34vhnkNR/GoQc0AHtzsee0h1KnXyBT6L1AXcCBmKvydR83rcEo3bp+enBSf+s62dVm0ED37EiVBWAIe6GmV3S5Eixfk7DwoOE7uvI3jN/zoA9Um8eB574Z43rre5VVXM7q8C15A4gu8KehH1j3L+NSPNzLqXNYp63dNyZ8OyRVNA6Ckt4ZEzTnr1NGKpKrAr0q9kjPkgaSAOzou51HyZiv/SZgXeXTLEDMLTFs/aogh+FfOCDFjGZGeGEEO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyAbzpMyW3fu45C2DXT9tKeynVzsjzBb2Ktttx8j7BU=;
 b=i4pHMpxbCM3q0c8X/MquPBnXuKvuSI6TEY2qagi3/ZVvgrDo9HzF1dyhm0amKNysckUaL1tK7/XzgpGQqw2zH6hBAZ+nob1dDeV4smOWh4pD3AH6VwLotbChOKCurVYyaWgqr8ZkSIVE3psjLaglZ2Kv+qRLGdidMQXDHRIFVE2wcziIhR6mWqiwAK7kJg5lK66j9PQ9fS1LeHgfKBK0KtArgESscB9k9mmH1aEkSQ7qLgh632Ku011AXTFATQMVA/fO2iXKSfHBfmrEjVDaCm91PydQotEeGN2kL4XAMOxn5hfHxTJBxK82HihcexWPCP+dCQOsdiynNqAN79LZ0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AMBPR04MB12335.eurprd04.prod.outlook.com (2603:10a6:20b:732::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 13:19:14 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 13:19:14 +0000
Date: Wed, 11 Feb 2026 21:18:01 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, s.hauer@pengutronix.de
Subject: Re: [PATCH v9 18/21] wifi: nxpwifi: add core driver implementation
Message-ID: <aYyBiYr6Zkv+Fzyi@nxpwireless-Inspiron-14-Plus-7440>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
 <20260204180358.632281-19-jeff.chen_1@nxp.com>
 <57439b2a-f606-4ee5-9287-72c40bd726e8@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57439b2a-f606-4ee5-9287-72c40bd726e8@kernel.org>
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AMBPR04MB12335:EE_
X-MS-Office365-Filtering-Correlation-Id: e86d1bac-6644-4b3c-e4bb-08de697026c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AcLJwx/CHpXmVuikN/gcKHzhiT+CiWlaxQVArkp5apIUhv64Ll/O5NC2UU1a?=
 =?us-ascii?Q?/Fn6iJ7kN16S4Xsg5vK8U8TIfmtMBzt8LTmVgGac4muMKsxnT1fMlSr2m/1h?=
 =?us-ascii?Q?xT1BpjXrcWR054L+xR3D9pngqhfY5BKj+oDeVaLNpO9p9MOROCxdLbEoHrlE?=
 =?us-ascii?Q?MvSEuiEl0hNsppLdaOFsWZHWinOnKvB4ju2RLm0GyJJM6vh+9IF4JWG84L14?=
 =?us-ascii?Q?/5QjrrCaceudG+TpuHFhSkm9OPiNJB/oL5gJYeBs7K9tM80kxEBH0o4PbP+p?=
 =?us-ascii?Q?k6xv9j0rrc9ZdvDHdyKShMhpyI3qs4seSuSCoc21kLXiC04SlOpqrHWVekwU?=
 =?us-ascii?Q?VnowKQv/vGcod6RthgnI27cVyP0Ny866Nb+xSD7/ZFlg7WGYRULDrgWETcX1?=
 =?us-ascii?Q?z1R5S0hmB2BJKRQXrXOoPlfNE0RIjrATAVmv8/tpgEZBgVJHiFky9hSQlMXv?=
 =?us-ascii?Q?X92g3B0lNgGa00UAAdfW/JpC3SUrjfbCFKuFL8fqTgztXUPKJCxnprxe8Hrw?=
 =?us-ascii?Q?7GUnvXNajQLjmlRCXm9Un0yIvJ/RyJWqkySUXR6ux9o1QhwFELgoPF5Ng5Zd?=
 =?us-ascii?Q?NJTn/+0FxYvFfdm7rpURCqIo3mFWYOh1mxZ1JcvanYUnzR0fPBseygcVnBBT?=
 =?us-ascii?Q?rNVGukhRP/34BzPr4wBEb8K95ptY6VsMMdS3U+GFVLo2Nh+STU3OZHskhMgT?=
 =?us-ascii?Q?i29sMRG2XpZanUMoQpcZzP9FtKke1DCxfCngb/yJzOtjJSxiQcypJyrHsG17?=
 =?us-ascii?Q?Uo2EZFNFG1wtM6xlhD3CNH/btco+P0zOcLLypjTfrzdkfcz0eIiNX0eoF+MQ?=
 =?us-ascii?Q?gtf+vuN53KU6WJOQ1bzkGvWa34IY4gP3HyMiazY+GUWACOVN6R9trbAIq/Yp?=
 =?us-ascii?Q?nXN4o8OxypqYQ/3A6iPT/c/ou/Ku3WNw56Bf0EWXsQ4WZKaSBLiJYR6Cd3ib?=
 =?us-ascii?Q?YCtEkbgFyNewPgTdzbmfeHovXb35vmpXTguJ6JLzVUqDynwB49Ba9Q5inGbb?=
 =?us-ascii?Q?InJ0qHqAvaI/EoVpjCZ+vSOGtmBsqJk/7wmUDnEJgaem3a4uPnkLLeVL/NzS?=
 =?us-ascii?Q?AM29wJedvhHQ1RxU8JUkzPlE4X68wyPRyjpUaHHEc81dhXgJxRN9qbZrFng+?=
 =?us-ascii?Q?YMGkOlnnRUL+QkurinUrRSSbRedJJzrR2yB1cL21hxo7f2O4QC6vw+gS5FaF?=
 =?us-ascii?Q?ZDlqexcyaOVxSeAPUrXU9ClFrc8g6yyznqE/B7Op5TlI3nMhKx6c9CfRIAoq?=
 =?us-ascii?Q?42aMi+gv3cI+p88hm7rHuSf0PfRuxRzFz3NghzX6ainkR8+4j1fH1tBaCP1R?=
 =?us-ascii?Q?+j+bVq+wlXCGLoO3WWF5zoE3dLmPbOnxzr/26kmk41LftW2+m/0Vldb/ReJI?=
 =?us-ascii?Q?udArd6Acn3TamOsvgAiOOFKJWXqrNRSfNnE4YyJ2JEhY1gNSRXMblkhCDl0F?=
 =?us-ascii?Q?ZdYt7C0D1eV3ECe9UBM/UG5jd7nLpzxCJeRjjWUGJs3TtQ2eGiHXaOvlakX/?=
 =?us-ascii?Q?AKh0M3YtU7bvS0yP3W+fJHMLzErq9pfjTu5jlPhpKvK7XRHbqcevQPx0pzat?=
 =?us-ascii?Q?Xx5/+3iypzbfgbNBLnw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLolW4ei8vEejYKQ0LD7Obgisg1ydXDesDMEE6JrzH4hyIwiC7/L1zbj4yKM?=
 =?us-ascii?Q?cl1/Qcvi8We7y1cO0ThmLvoL79L1h2YtSeP5dmn1fC21oHSjzrbbcTbm7cXm?=
 =?us-ascii?Q?748xvzFLc1tTJbKOIcLlJBgWuU6VX/pFMN9J31vZWc8QBxFK4wmWtvloJp65?=
 =?us-ascii?Q?v1X1ZOfN+QGzitsJTbm6LeBAYVYyR0p/ribMf2atcCI54KbMWSecrDxXBctE?=
 =?us-ascii?Q?6adr+DfZM/dmT1KhMYf3k7i1vgFw740L5qDqfBKmYVjDkcF1zj0RnQJFf7cn?=
 =?us-ascii?Q?JHYQtghVU3tfj850CxeyTE5FAg+GoWVW2gUdFaJkuC6LLP1St4XpV/HZxGHz?=
 =?us-ascii?Q?YXS7vTU7OgrHbJWPLmPzXN4inhMDECITaL2oWRo4fVWH+wymkbJF6d3ToSKg?=
 =?us-ascii?Q?8Cnz0mtgvslMordF5qypM/PQYsHBo95UJcTu1CrnrAANRjXemrqF1rrRt6ma?=
 =?us-ascii?Q?jYYLJldPpkVYpghwIU9HVec9NUrh87PcOn+eWoLRlpOHisbdnrM95lyBdy3g?=
 =?us-ascii?Q?Leo0w1nvoYcq7qQ6VcUCleEvaQwwfG4uH75UIThkXEiS0M25BSvnkOMDpo9P?=
 =?us-ascii?Q?jWl2b8FsFPEDvlzeNhLANZUh4g9kGXDmLRUTLoPQANslK6x2l57FzdhDUUVI?=
 =?us-ascii?Q?NpSed0SQLMt6DdujZ3K9FZUBatp0UQliBxABiwd+5hvLZhI7hUkDn4n4NtGp?=
 =?us-ascii?Q?nyWNx/js32Lm80G16VQf8tJuY9OkgJQvjGroMySPc63kalwbdbptQorKVG3h?=
 =?us-ascii?Q?LouIoiFr/M4iS56NuRYfZTtFlTMYtQjmauYbQQ7JIcujDI+aulveZsQfA6xA?=
 =?us-ascii?Q?Ig97YhQ06a+E2GKsSJdxZoNm0w6q/XlExB1zU5nB5FCZNqUxpgByD3zaoMki?=
 =?us-ascii?Q?3dTbFRIRWCnoNX/4d/MWzv8j3B/6+HpIu5wHGBCfyJ73OlMnNDt3irDCgihl?=
 =?us-ascii?Q?5uIb0lZshgvO7IuicOuXQsX8D7pbeZqDu8hJQT/fR4+nS2hQmxjQjvaM5/k9?=
 =?us-ascii?Q?f7qB1ptjUBW76Eo1rkRZNOfKz2b1hKftVM4mQSEmT9IJcthejfDlG9GtNLMp?=
 =?us-ascii?Q?kz0FNxP91HKNvK3f52OC/1Yesm83OMGV16x82rBrdYAlbZvS952SBn5MDuuy?=
 =?us-ascii?Q?XjKW485XX0r4D/T4jk7bfZmchZLi3X2FYA0dTvJzSVVHIDDa6KfwWEoBPf3R?=
 =?us-ascii?Q?wm6Le5d8ZgS6pTy741RaGKQgv/9eOZhEhITedGLFL6x2D+/1nnTJwa1L4QGk?=
 =?us-ascii?Q?zmxN+Bw8yahz0egwPvH5LyFuEcZDriPr9T+RHYwtZXlqS/edhzoTXY7jpL7A?=
 =?us-ascii?Q?nv936mkuNEugrY8Pv/tbCE/MUPv+s5bWwqZgMY5t1oW/mnqBTLiEzvt+cEYL?=
 =?us-ascii?Q?Di0jEg6J4vsGerPd3pPuqM7I/9kvUCJSF5S1ZVcTdt03dPPHU/j8foSulVC9?=
 =?us-ascii?Q?glK3WD+VV5zaMvzA3l1Hsl7pk10HpTdAfXexFJJzE7opbBxjmYI6F5J5qIDh?=
 =?us-ascii?Q?bIcEeZFamjd99kDRUQ2mSjT1EJd9O0gRXk6wBLVsCBgyd92cUuvq8KMx/Kqr?=
 =?us-ascii?Q?ylmRAmHXXCIpBonf5RBcfDkDNwiwbYIt8sKU3xcRj+VTasEKXvAnVCG5WSbW?=
 =?us-ascii?Q?CspRN02Yu6bxK76rV6k1hA3fj2EFBEOJ10oqD0rkKv/AIzUvKqyxGurjdG+H?=
 =?us-ascii?Q?UoWgujHu69q1nzNR3EQR3OgPGfe0IIS6VhptZnlkJn6y5ySVOhW6y9ssY/ne?=
 =?us-ascii?Q?e3XYJZyPRw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86d1bac-6644-4b3c-e4bb-08de697026c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:19:14.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNnB7cTxZRmJWpidOld5DaBxlNPuTEm/vhjIuu2eNcMLFjh2H0W4zbcLIDjohIJqDTVgzLp8feDR1VsGWwV69w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12335
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31737-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url,nxp.com:dkim]
X-Rspamd-Queue-Id: 11337124B28
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:36:22 AM +0100, Krzysztof Kozlowski wrote:

Hi Krzysztof,
Thanks for the review.

> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94
>

I will update the commit message to use imperative mood as recommended in
the documentation.
 
> > +
> > +	/* Notify PM core we are wakeup source */
> > +	pm_wakeup_event(adapter->dev, 0);
> > +	pm_system_wakeup();
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void nxpwifi_probe_of(struct nxpwifi_adapter *adapter)
> 
> NAK, you removed DT support thus cannot keep undocumented ABI.

Understood, and thanks for pointing this out.

> 
> 
> > +{
> > +	int ret;
> > +	struct device *dev = adapter->dev;
> > +
> > +	if (!dev->of_node)
> > +		goto err_exit;
> > +
> > +	adapter->dt_node = dev->of_node;
> 
> NAK
> 

regards,
jeff


