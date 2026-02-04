Return-Path: <linux-wireless+bounces-31564-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKtCJPeLg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31564-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:12:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE261EB772
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EB4B303A0EE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD642B746;
	Wed,  4 Feb 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LCM0S1fM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8BF42B73E;
	Wed,  4 Feb 2026 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228351; cv=fail; b=KH7YsBffv8SBb4ppWL2FJVscI302xRGspcKl2PtodOZqPamNv1cUHyv8IPprxK33XLEp7eLo7cGZw8OuFaPqxQtamYsHKivOUYiTdBZvye1qMEd7CEQncaEeLTOoPl4A3bOYnP/go/7WvA0XKD+yT6qPt6/fza72iW4q4L+j4fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228351; c=relaxed/simple;
	bh=mEjjwfnsePPETZ0HPiK0LC/yx8nIj3Y7Pdh0w5PaL9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0tx9uhNXDLwskE6ui8my0rTn7CfQ5Ouf8gSAgN/QDFIuM+Zfu9YJd3fhT28ZTeA9HHmsgqBLo68Sfymt3/dyvpGzedRuK6YNDPu5WGL+o9LyrG9YtrhR8e6nnIESL1X1Eq/7H2ueKzPFWeQUZT6KrrMGjXkxH2+Fgqw7uznlP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LCM0S1fM; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE0cOEol1KLFWr7mOI6oe/V8FsQ9O5RIfCy95EMVgUIo7YWYY4+/2EmgWpE8N+A63YvBzg3vLclpBt5IaEwnh00zf3cI/YemtX9KKhaqDOvPb7LIojB/YmjVZ54daySjrffYvcPZ0IeFvSTzopKYYmq3beF9oOL7qnc39UvHYd8Ei1ur2Lnq2DEiGC/vfJ803j+QGcv8xcAh4eU5z9bmtskM1zD1joW2dHW3DFbsovoo1OuPDwoQWbfuRjcdrinLU8/Htois1e5Qb8Fzv2gJYmBQgog8NJtXMTfZpqbFrqbekgaAidrP7MYV0pHriREzvoM49fIuYBWJvnmffBEvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Swm7kH7INptV7rSBelGkREbbhZ1uNtigAXbjkRdbl4w=;
 b=tjXJ6LIUNCEG12tRdDf9AIWHkuQznv2h/myxQgS8KPc8mK7hCDE5GAQ8VqxUFKEn6oc/46hnGcvdXm53TDQo8vn4vwp0wQPEqDRP3O1uCBcSJjeLjmjsdPEcH6LeeIVGJ0pun2fzSK5OJZccVGnMlHj20AqhrwbD7RHGMHbMtgrrpFWQqtxkSWmZ/2ne94prH3tXzGllrUC8roI0w0G50no5nSqpLy4QULWeyZxwYX2eCAaWY+Ygd3Sb5HoqeLeCT4U47qDhE0UL8NHDyGPB5YKWhGEPE5AwcuhfEdsz0MMJX+XNjPPviXAW4xRYPP0uTV2sO9xiE73EbecQ5RUbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Swm7kH7INptV7rSBelGkREbbhZ1uNtigAXbjkRdbl4w=;
 b=LCM0S1fM6vWJhVjrQ6VyMTDOKB++wNpAckU3AH07fvkWM82yn/5LdlyAjxWgu589nKKeAL5C+PiWj1N8GXadwe1CeuIwN8xQBKa3XDeXdEo5IiPp2ZwV9NriOjUxnVa05lSnl+1v7xo0VqddXQlZ4etCHxF8OQ6d9a8Ub6Jf8hdrZhldBcr92UVRK3jNWI2Vm8eO+JmSoMZ+xd5//aVRl9yhAduLEBSdBNFPAK4NNcYpGSrsZLNyoEHFulWAMvOhwaUUoHo2hzu9LCMJDPuwCzN/0YtjTfJ5XG/OfTsCYxUeI0dCOe2pdU3Ma4PDTTrmVtMJQ8i7i7DIK8wotey7Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GV2PR04MB11980.eurprd04.prod.outlook.com (2603:10a6:150:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 18:05:49 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:05:49 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 15/21] wifi: nxpwifi: add ethtool support for Wake-on-LAN
Date: Thu,  5 Feb 2026 02:03:52 +0800
Message-Id: <20260204180358.632281-16-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204180358.632281-1-jeff.chen_1@nxp.com>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GV2PR04MB11980:EE_
X-MS-Office365-Filtering-Correlation-Id: ce78a47f-aba8-47ed-73d9-08de641806e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?orfPyqGAj/5NNzBU8KH+3RYToMUVHN0ockgLZJxPrc+7rb1hwWWhuhcY1MzO?=
 =?us-ascii?Q?sPb5RVjmiCI7MrAA3+fIAakJo0HxKIUr+iAfgxqDSrUzgLfRJ7/VS2dHix03?=
 =?us-ascii?Q?aMd4qfssAz10Llupl0xZHlVQQW5ZHCzy2PYj6Lct/xkBSyo3u1gafm7ewOaw?=
 =?us-ascii?Q?eQTfFubde4ZV7YCZH3C3Kii+7NOyAbga4oeuDPRAco8d8iGQVjTSrt9hxc3Z?=
 =?us-ascii?Q?JQtwOxYNpit+aadhLNILAbA4mdIEVDMPmPBpfK1Id5fk2OVyT+VuROyo/25C?=
 =?us-ascii?Q?CK22LTJIcjw90m75butp9Ha5rVbxSENCRgzXWS1+p1v+cvyOG0WbhXaLlvng?=
 =?us-ascii?Q?nqHcGcQuOIPWS4fEagvRu+JQgD6Ewx5F+e8I7ec+zrUQMBLe453+U2a91WyW?=
 =?us-ascii?Q?veCgSItjLyY+3GEso7Z3BRx65QKQxhIFWYmTbjlKiqWsaATqT8fQ/HRVjO27?=
 =?us-ascii?Q?l2JSqHGABrdIz0VoYvAKSuCcNltpuRdxQCT2lAhDqSBmDqOOCX+9QpNGFDJs?=
 =?us-ascii?Q?J5PaBeM2ad/ErxCLAVm6BLMAjqZzbzo/rFypZbP+2jNjbsBAW+y+r9WnbOZw?=
 =?us-ascii?Q?NcfFYGDKZtSome3k44d13kMOCr465DUCsVDoZH2jZHRZLuG9ozBofgj7hUj1?=
 =?us-ascii?Q?87ssGYDAnac3fUo37fVogjMZWj107/sa1I6UKUdFZ6pMCaQsi/3496R2V+tO?=
 =?us-ascii?Q?tyvkATgBIAH77ndPV2NbXYk3tAYW2Lrm/qp0/+hAmS7kqc3OLpxBNYx8szwh?=
 =?us-ascii?Q?GMCkFDzzMSL9R4oZI8O5LDZMZbMz8pQuSpH/1JuOL1Nl3CdTfjjU5HsnFZre?=
 =?us-ascii?Q?DRT7Sii+awfRd1ldn5LRzpNmRVpBY/T9f8GpOZz273kEzvYN868WH4IeQ6ro?=
 =?us-ascii?Q?EQOV7HsncDTXpIXYgU2qXK46mmGqFX6/rkOQU51Gpz2eMA/FwB+TWkk+T7tk?=
 =?us-ascii?Q?1WWsMxoYzUUQyuzLNuZ4agjsml56icjht5ZkCAq85ZuzQ5k9wnyNlh6HdpqO?=
 =?us-ascii?Q?JjjQDvjLXFzmYboSktD6DPCywtY0NZImq9KsG4aPKWiAw8Co1R/NYL8cl9oh?=
 =?us-ascii?Q?e1R3Xoi88cezK1XM/DNH/f2brC6UTtCm8gG0jYHxJQltOW56A7QfL9v6c2Ix?=
 =?us-ascii?Q?j0MyaTYKE21lELbB956VTv3BHywrbpeFhZVNXIEghHNGDXuAiGimY1kPsIV7?=
 =?us-ascii?Q?uNRGe4C1xkM33hOEhjAdAIO2uD1TlqWsfiS4bW+z0STsUpldiUFVD2uimz2h?=
 =?us-ascii?Q?uJKRW7Y094yVSbsHtlnXao5q+S10DUaPMOt4vngPMYSK4+D1F9cbSl/RTpf1?=
 =?us-ascii?Q?adh11NoIayirv3RM71D6CncpQndbsaIFVn+ISpQpwkwhkQ2nSnGbePK1uB2a?=
 =?us-ascii?Q?yhXPm3omplVRW8Z5O8yDguMjkVkPr8iUjM85DrHDYoZwhj4hWNNnJWIslzNZ?=
 =?us-ascii?Q?hE/1Wyqr4RdMwQvZ/9LEz7oxadeQLh+5GpJdou7Rf5Ri323wJsw+Fu5+uyr7?=
 =?us-ascii?Q?8LZWcj5zAGiqGSBJbdoFR12HjwNFDF2TbucS5l4TSY9k3e1NcV3a1fk7tgHF?=
 =?us-ascii?Q?6wLM3023PXfMplifR7FdOrklIFT98eJ7t8beD3fQJ8Kpkd8lxspCkwS9tSRF?=
 =?us-ascii?Q?TDdOQntIEIGCMF+qmuZpeJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/odYTl4y7g+A1s4jTo77ZT5RK6zb1ipZWv3VH9trzE5ds1ji7rNPzpzCBPfb?=
 =?us-ascii?Q?L7ox/rnuoCPns6zoCOt0rKlXnJls8Sxm3t5ILOfKXTjR8Y1TGl2iKJjavHyf?=
 =?us-ascii?Q?U6dVUhKBBEJw0CscLE8jQRXKf4h7VJOJ8PmFQVjxIJ31hUbQ5fufFy2H/gpT?=
 =?us-ascii?Q?41UxVf6lzLQHwSrZ7VWKiDiNBMD8uW6NucJn+A11JimC9fMM5vmmJcQUbV8w?=
 =?us-ascii?Q?6qXhePdi52HLY08SmAt5e7ffeTo5MpW5wcEsd/GOP/PwMcK5n2Ml0eco5+bY?=
 =?us-ascii?Q?kglkOhBBXA8c5ajfEbxfhj7o8L7E4J3KtAsDPb/ldMBaFpvqBI1qQMmxEur9?=
 =?us-ascii?Q?KonUbCtFHxcsjc20K6xogcDuJGvptPJe/Jk/Gq/9vCVOXiGff66rx03Lhno+?=
 =?us-ascii?Q?NcHAa0nst7c7ltsEHzGHdEF65tFTQl2DuYTcz2T9hk6b+hjpxPv6gJZkQvrk?=
 =?us-ascii?Q?/lTCMCnnHKAySkOTQ1Sp+fiLK0adL5jcl6JyCkvUrOVW0e0iSaiiWx4/W0Zx?=
 =?us-ascii?Q?LdzAQrdXHt1+/qDis81Di2EXn6ZBzSx5WTzej76fl+J+Qp8y/fdM/q5aQUKz?=
 =?us-ascii?Q?fjeZ/VEzjIkYoGCx9fGci8Ej5c9PLzZcWs5JXm50cJFBXgF6GanzfzP2W/By?=
 =?us-ascii?Q?sWWcwfXzAPnnQHhB/7tB+vmp6BXlfxg0BPYP6XrocEZAO08csR6lG3qQOjjt?=
 =?us-ascii?Q?RdFOd6iLbIT/ZUbVFZuURA+ey+/vBfso2bKRPeN56ATNq+lfJqkw9YL+wplI?=
 =?us-ascii?Q?3XnKAOLB2MMbpRM0AbQJDu0A9t9MY5uv8oaJHVxAu/jWTAJIhdSKPttTDRrA?=
 =?us-ascii?Q?k9JwjwxUvckBWW2nuLP8vRmA0SF4djCtWkiXm++tYDmLcQsrd6rd5Z9/A3kI?=
 =?us-ascii?Q?XbcAjUOVk89b2EJIz6gOSR6Ugrc7I+Z1dScP6oXv8az9l8tmFAWHAhOsxxeg?=
 =?us-ascii?Q?XPcDr4Ec746myLOxWmE8zW5BRuKO0R4ZNc+Gi81eOW1QTD3cdTPvROitScdi?=
 =?us-ascii?Q?sEbUo9uLNGDvFh+Qz+FsaCecLG96+S0wiWvUrb5rWaJ8wJ6LTCzXgxkItvjE?=
 =?us-ascii?Q?tI1CYrl0xULQdnyU3YmqikfcuZwN2n1Muhj8tOci6X83V8FtNeN2/pFkhGd9?=
 =?us-ascii?Q?RJvR/mvHy/irlWQTa+Sqtlkp1SdLNJjAE3P696OiQ+eXzIjB7aqWwaWf0ij2?=
 =?us-ascii?Q?P5GpBmA54BsFC3nSiZ2NjGMsHb9wex15xNUT6oQ8pTg+gvqWmEiTPTEdN++r?=
 =?us-ascii?Q?jzdH7sxfC/60S//9kswhClbqtxI/Yii6jvBP5qgGPkI46Z9bvE+r+JTExSlI?=
 =?us-ascii?Q?EavcC27VQ5GrqJGUV6awfRV+MuHaQ566LXftug5/6r1SQJP72//r+J4WEJnY?=
 =?us-ascii?Q?ZW6TfowDdfvt8szjrmPcjfSEL/DbWeKAuiI6sDyd6n/w4wDbmlqPgLNGpkYR?=
 =?us-ascii?Q?Pgo2ISsF1kM1O+zjYa9so9zmSovEAFKYGO4klyWFiMBcxJkWb/+5LgXx4eqg?=
 =?us-ascii?Q?pVtjeYU4OGBYfKrd3dCp/wa8/HgUwbZWi5lio9O8JG2ZiuzwpvPZ/eFbCn1/?=
 =?us-ascii?Q?/r7HFBs16u8gebiAYnvdBlG3Mpf5DTSgqSlYXkzKVHNx/SzEe4t6YqMyLkBF?=
 =?us-ascii?Q?eMrMReTBp73O8xuOubLpQ+YPTc153Rn3RVOGrPRP/ueousGJoEwO21XznGbt?=
 =?us-ascii?Q?oKrKBx1nd/bA7SZskWayA2bqBhmnKikSJZIJrIvPMthmpehEBhQ9j49J5PE2?=
 =?us-ascii?Q?mcOE4TTB9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce78a47f-aba8-47ed-73d9-08de641806e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:05:49.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJR3787gsarBBNkNUgKrMDQA0zqcXVpwwSwVFscpxn4zyuPXyZWCt25Z6zh62Mf+5aGKUialaTDKm8i5uQJHPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11980
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31564-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AE261EB772
X-Rspamd-Action: no action

This patch adds basic ethtool support to the nxpwifi driver, specifically
implementing Wake-on-LAN (WoL) configuration via ethtool.

Supported WoL options:
- WAKE_UCAST
- WAKE_MCAST
- WAKE_BCAST
- WAKE_PHY

The ethtool ops `get_wol` and `set_wol` are implemented to map ethtool
WoL flags to the driver's internal host sleep configuration.

This enables users to query and configure WoL behavior using standard
ethtool commands.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/ethtool.c | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/ethtool.c b/drivers/net/wireless/nxp/nxpwifi/ethtool.c
new file mode 100644
index 000000000000..aabb635afcf5
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/ethtool.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: ethtool
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+
+static void nxpwifi_ethtool_get_wol(struct net_device *dev,
+				    struct ethtool_wolinfo *wol)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	u32 conditions = le32_to_cpu(priv->adapter->hs_cfg.conditions);
+
+	wol->supported = WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_PHY;
+
+	if (conditions == HS_CFG_COND_DEF)
+		return;
+
+	if (conditions & HS_CFG_COND_UNICAST_DATA)
+		wol->wolopts |= WAKE_UCAST;
+	if (conditions & HS_CFG_COND_MULTICAST_DATA)
+		wol->wolopts |= WAKE_MCAST;
+	if (conditions & HS_CFG_COND_BROADCAST_DATA)
+		wol->wolopts |= WAKE_BCAST;
+	if (conditions & HS_CFG_COND_MAC_EVENT)
+		wol->wolopts |= WAKE_PHY;
+}
+
+static int nxpwifi_ethtool_set_wol(struct net_device *dev,
+				   struct ethtool_wolinfo *wol)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	u32 conditions = 0;
+
+	if (wol->wolopts & ~(WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_PHY))
+		return -EOPNOTSUPP;
+
+	if (wol->wolopts & WAKE_UCAST)
+		conditions |= HS_CFG_COND_UNICAST_DATA;
+	if (wol->wolopts & WAKE_MCAST)
+		conditions |= HS_CFG_COND_MULTICAST_DATA;
+	if (wol->wolopts & WAKE_BCAST)
+		conditions |= HS_CFG_COND_BROADCAST_DATA;
+	if (wol->wolopts & WAKE_PHY)
+		conditions |= HS_CFG_COND_MAC_EVENT;
+	if (wol->wolopts == 0)
+		conditions |= HS_CFG_COND_DEF;
+	priv->adapter->hs_cfg.conditions = cpu_to_le32(conditions);
+
+	return 0;
+}
+
+const struct ethtool_ops nxpwifi_ethtool_ops = {
+	.get_wol = nxpwifi_ethtool_get_wol,
+	.set_wol = nxpwifi_ethtool_set_wol,
+};
-- 
2.34.1


