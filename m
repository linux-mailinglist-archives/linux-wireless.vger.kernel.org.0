Return-Path: <linux-wireless+bounces-31553-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O0fHouLg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31553-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:10:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16196EB70F
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673CD30CA06D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F342316D;
	Wed,  4 Feb 2026 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YlYLF+L/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438202D978A;
	Wed,  4 Feb 2026 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228323; cv=fail; b=JR5jk1eZS2a+meDn9a+04oHKPdJitXpazQW3VeFn37L/OON6RyoPiJnh54JdxcpHagW6TRLUolGbkBs4ZD6IirRt8Y8zR+2cxcGtIOteL2GJmA2r4DyLFvWwPvNa8KATOmYK4IonV5krdd/+/9phn3Qec6LSshm9YBF5VVaL2aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228323; c=relaxed/simple;
	bh=rmmyynuVxgw+u7YgPUYnQrliaMWNQ3gGnmDMj06eZas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=devV2JfJ5sfoG33kCEdt8AeKAdpYGbpdOSJz5iGruYJpi7x12UDaHQyzx1+096zn3hScM0SiDkTnjni5qywAQbKAl11ZVin/Phu8OzP6SGuGwO+5LCpThU7a1lmfzd3kP3TwYl2rGhrKHwW+fWGPbaM7r0u18cEgzkwmsAxN/Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YlYLF+L/; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHxxtxv3uUFevrXSUV7PSfEEmib7fRWIEWGtevC14D8sVm61nSS0+HxyUG6RFK0zBR1thmSC2k2YrtBK4are+66W5ZbqNqu/OJwgfN7oQfVYKuyPx7fFyj3vOaQhObPS1jkNoNgCdl4zuUIJvINKaEFJ/k1caK5Sem+SV/I6vDFbUMW/DxuyRnAkyoDz6RKAuTNX+1HiSpNX1HwHfsZAL3FzQguROGgpGCaarS7HhsS1+AXDvtdTC20iUjbp0w/olB0iNCAWpoCbLPiB7dA/BzqdsM8fzjt2w1bV4D6jidfBhRXafF9IMc1GXlx84C3u1GL+Fcm0TdGgk34ePjWgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XzHrle+3IjyH2AS1V25QqZZEOcU9FOUH2EwDV9YSHQ=;
 b=cVz/MgIe+r/K583SlO6pA3Szox8zY8+mw4vs9thC58pmaU2Lxu18qjA0WKWL2LceOHphc8h5AnnErYu5ppAyzpSMp+cnOdmAL2okyu4n3lE6PUm7+4eHaLSsH6ASp33FkuCYHn/8z1XOCwHj3c0vnW+sTY3liI2MaxiG3xVcEB5ERAFuUbqPCwVCir7TzmIf1l5nizNd3wcRK3hOgFYDAWpjrdU/GhH1yH0nANuoqkcQM2hMj343KA1t3RBf8xIsjXtlgpDkjH7RqIHE+WkJKKbBSAZc7phgh5OEIje9KGeFOm6klvR9YzkLRPTMJMkaRLkv3pKaIHzhqaffT88HsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XzHrle+3IjyH2AS1V25QqZZEOcU9FOUH2EwDV9YSHQ=;
 b=YlYLF+L/srxKtXftvZraxyUQZbE98DNIFFqGRtfD+4CCEQkFDq0oPBrKa07jJ/bwteJjgEeZ5h2K1E6ivB/cp7eqEoaARZxCQxSge2vesV9MoijZUol5mPE5sdiPgPyJ07G540YugPtkzhbNMH8pp22DwlJSzIifv5Q6eOg3xLSkrZbtRweADvwJXeqGnTn6/Q6tX3sTvXWzeTyPqx0X9n87uD6gDh7N63zHLJo5C7MfT3/NU8IKFKvhkRe+YywtW3tYVhFv/ALBLVwUIDEeKo731wUBq9U5xQZmALCGZ6qc34ISAIulkwT0x7wKf/78++oMiU5zLFZkwayhuz4Khg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GVXPR04MB12314.eurprd04.prod.outlook.com (2603:10a6:150:30f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 4 Feb
 2026 18:05:20 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:05:20 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 04/21] wifi: nxpwifi: add support for 802.11h (DFS and TPC)
Date: Thu,  5 Feb 2026 02:03:41 +0800
Message-Id: <20260204180358.632281-5-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GVXPR04MB12314:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9c1317-8491-4f50-05a7-08de6417f5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQ8EXixbxA9gSef3kw1+bltBXiHI8XcZJKboHsFInLUIG8UDkK5SDlBKQ71t?=
 =?us-ascii?Q?xokwzPzVDFTxoE3zuH18MPaVLfVBwuu+BD2SWGnBguHBJlqj225j56qex6p0?=
 =?us-ascii?Q?+0G9uVS3inbIlCWOUADW0gkhjQFSpsRyHV0iCox1lazprli9eYD7vATvRR6H?=
 =?us-ascii?Q?Nx8RzG2eOBt13686JwTmfF5miQYeTlNOFcjWymPL7mrGaO8FsuYwqhmUv+KD?=
 =?us-ascii?Q?MSDPjAmIFSgkxO/Uuas15eM66msaAbTLNQIzG7ysa6SaWXbIz0j7E2YAeAZ5?=
 =?us-ascii?Q?06vGzOoXHCKaMbK43rRRot/Oy2AuoncLLoCZ31A3o31q2DsaVqNTYrhp9OeJ?=
 =?us-ascii?Q?y1yT9D1p/CnA/a60/ji+M5KNfpUBxl1gIzfrqlmUCMEHrWOPdTpMsO36ZjXW?=
 =?us-ascii?Q?SzV6g9zHnLwNq99nHWaL2eSIZUQ79Inma7Ewo+bxXG9N/TcgiA9F+pgui7Zz?=
 =?us-ascii?Q?w4caV+h9XtnG9O14dsxV271pM1YrF6XH5d7h00nOB2Cdm+oS0OJY7abmZkL3?=
 =?us-ascii?Q?GpxjkOw62tGyF7SCIxZbhs7ljVBlLQHweXY+/LU9hstUZxWo102Xn55sk3S5?=
 =?us-ascii?Q?diH/f//hzjpMX50oPXjq1jUK7+Wh7F983qOFHeqEFO2y5Hclx3E5OcWQAZaO?=
 =?us-ascii?Q?LfQs393yate9ZK07LcJ9mVZejs49ubOUGDlq1G2azGqInrA6B6J3PNCsLOt/?=
 =?us-ascii?Q?Qw4VAaSVIoHpK8ev9UWAqk7cFQ3+D85hvEFWz+lDYTyZn86pkoZr6kLuJk29?=
 =?us-ascii?Q?F/bDZOxt2Gmk5n9egWbJ2wUVVTdi+9bu4x9EHdOdwOJi0Y0dlfgASGUsFW7R?=
 =?us-ascii?Q?KUODPdujzmnjAryPhqn1MpYMjhPja8z1HmaOljhjyXxsrF1110//6Rb7BOSG?=
 =?us-ascii?Q?EVgTiL7HlNi6I547m1IWgTT53WAMHWOIch0Rblhm37NLUoXebdGPG1saoSSD?=
 =?us-ascii?Q?SdoPYUsQlT5Fp85Q4eShckQtDTRpqMPxasPWMr+KLSN+MMEiFj2Ru72Qtu4b?=
 =?us-ascii?Q?doubuxRZqpZaD+Iju96iu9lMO51NmNtkzM9nGXCkVmlJqjHqVAKVDVFwURoq?=
 =?us-ascii?Q?W8TZGpMuTNnFLHjdoz68/32ZPnmtuyGz0W6E6o3oarZnedGw7lp4PCzCVlOX?=
 =?us-ascii?Q?F+60UUIO4R9g+uuYJISAgLxv10oaHpxgTgz76ogCt137jVPqrG2O83pIBjqQ?=
 =?us-ascii?Q?ifEGo5px54O9sB5kAi9A5SG17BDzasdhvd2uUfegn0hqBIr8mcVHmeaWG6zg?=
 =?us-ascii?Q?niq7Oa8fZyMxgUzUbtDT5FLbZKfP3xOnwe4YuYjlyMJ+Ov5TxldXjiyZQ0cB?=
 =?us-ascii?Q?uB1qXo0pqGXAl5FuQP0KTqMccBHmtuZnLhmPgDMm8r5e5gp8Ix32vvYOxoRv?=
 =?us-ascii?Q?LrzhC/Pn8n//3IXsR4RnImI6BdNzcpEEJYRpx+qaAONBK3VSUQBNq6kCSpmY?=
 =?us-ascii?Q?CJVI5yStIuLWRC3rGukEF+hpgyzK4E/MC1GkkQ6rQXhDtOkbDiTXPl9GVAr7?=
 =?us-ascii?Q?iiBZeviK4OaMn39AM82yZI4Ubpe0/ecJ2h1+5HmJWyZA6afnv8udXoKibqLE?=
 =?us-ascii?Q?3tzv7n0LAhTyVNRE65KNR55g9IfqVdNeCMdvpsxJ9i6k5KAAsBbOmqTIK2nj?=
 =?us-ascii?Q?L9XnDfcUVRVXsPNnfcz/L2k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fpvHmASPnacKyAE2F7XZpCETNAfne5JedqaE980+BhDMpbXfB/qodX/IfJby?=
 =?us-ascii?Q?8GLGIOkfeP6qrUbYlYDDvJCNj8GbCoVZU6xsAps0SyK4swVfoavhQwmGdn2Z?=
 =?us-ascii?Q?kcb4RIUXccCpw5RU213hG62Wg5j33YH86LV7QlRK3kqhilHPGg2M7a4V/L0m?=
 =?us-ascii?Q?aWP+WCPV9lWyYhPRU9Y5M/x1Al7Pul5k/zBuIXT2a1MbNKfIXAxjBmxuwWNi?=
 =?us-ascii?Q?QnJLoZZVlvVEDPBp1XWTRiS3wxLNzJTCbUg0CYlAN7sXZEzSMlG7o7lcfKYJ?=
 =?us-ascii?Q?yHpfLP1kJxgg0Ef4FfQkg2cu1QDnlBhD0DEyiOQKvQAqjlO6Id5n/4dRQa9X?=
 =?us-ascii?Q?a3QHqgZ/tUJuR/y8XndVPX9VNVLzeURjd6GXTtQgv1aRiGrSzK+apgwo3Pw/?=
 =?us-ascii?Q?efzbNwYrEMoCMcBKmZkkxUK5cErEVMCxlmGX9CDHaSHenlZlK3Fk0frDMFVZ?=
 =?us-ascii?Q?5dwjYoRuDyoY3mnqlb9N1Aam1b/8PQCZjjuY6Nz/0tQtT6/+U0qlgtweiqmV?=
 =?us-ascii?Q?1MMi67zSl2KtMOuKMo82PAZru36vwySqPKglQDejeVjspvk0yosvaidrKUd7?=
 =?us-ascii?Q?gby7n5Izbi2OLDfgObNrbYyT9wpjtNuzy1QhaimaFFSD7bTiYvlw+IB10aEd?=
 =?us-ascii?Q?A+k48f0jcLpsTXy7ZXK09SucT0OgIi4uIoFFP2CJpNbESv2GPZ0FpxYj9cQz?=
 =?us-ascii?Q?Q86l971u/TSnZsE3ZpcWq0R7fzjGIGQ5cQkvavFj2ce852uKw1796x3oGP1S?=
 =?us-ascii?Q?o4AM940vioDzxTXTkV2ou57HJJHEzmU6vyaFZUGjIOOjyjhbTD84I97G/aTq?=
 =?us-ascii?Q?10UJTwqC3qM/TRg5uFld2YZQkAUxjArmUHCzXPH5CeO8XyOqaccKoBNk3hMO?=
 =?us-ascii?Q?YdYh5cY8ulsCMwBy7OTbcqmXoAizcRM1tn7ngms9d5Px6FwEn3CiexGmtw41?=
 =?us-ascii?Q?uuRGkbejbw031jZlhH5H+OcNN4ZxjxnSdNjUv5lpLgE51yTKj7M9C2bcEFlc?=
 =?us-ascii?Q?2Wg87r7riYX7ualLQwhznvCmXvu+gq+Wyuu5qlrAWMo0mWmnkXq4efxFjbAp?=
 =?us-ascii?Q?SbbCxZ57vAe7qnHqLF382iU1lKyLd+Zgi5qdea+azmfbnQ7x2gBkmLwO16pI?=
 =?us-ascii?Q?PGF22CQGGldOwll2FxXUeafrhFm1/67Osm9QEFpezFs2GMdosJjX32MbRk7n?=
 =?us-ascii?Q?G1ws4CC4GEpUmCOqIu0DjbJ2NykB//K3deTzDahl2EbG/vGYIttzNMIHL6Ez?=
 =?us-ascii?Q?79YhOUQ3sjHWKBOYDBOtAuxNEr2d/2A4rHcaL0V0gaCTTnR7Q97u7UWhWa48?=
 =?us-ascii?Q?0TLpa0VqunFm3QlYJnqOIkuv+incqu8qDHhDP9qQSrSTQwEACvfv0Wtq+HT1?=
 =?us-ascii?Q?tP7+JAFCLn3QqOf3YnVFlvda43DfrZgIYEHEErZoL9fobFNIR3uWAtIKtCyJ?=
 =?us-ascii?Q?TrmfJ/Yrz6Dgs7OoK6LzQQ9pEUpOcB3R1sDU4bpoN3hol+wHeUpio+tteZCB?=
 =?us-ascii?Q?0TqNBiPwDF8KAo0TcE0geKR6xn924lplKkIJ9zavEgRZ+k45BD9GKW+BsLjs?=
 =?us-ascii?Q?OoUapLjlCsD18RNWD/ab3mAR5Cl+8HxM6OMvIlbsIhsQ00haosNr6bUs7hp1?=
 =?us-ascii?Q?kmMsQ3z6+jWYzNv2c652NMy4GQ9r1HrYi37gfPBDTIlZLlGiGY5GgSZd/4xB?=
 =?us-ascii?Q?T+i5ZCnc37p8oxO8nef5M8Hphhgj2aCYj+Y0hZerW+m4iirmxANuU1w1oXeM?=
 =?us-ascii?Q?jyh3QlUTvA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9c1317-8491-4f50-05a7-08de6417f5bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:05:20.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTYoiGpNG+M6lLExizszfrST45/6Wu6rAdY78eU/0aZB6k7/996lm/7OznbPKI03ofPeiD2l0EGvDCZ/q1hobg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12314
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31553-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 16196EB70F
X-Rspamd-Action: no action

Introduce 802.11h functionality to the nxpwifi driver, enabling
Dynamic Frequency Selection (DFS) and Transmit Power Control (TPC)
features required for regulatory compliance in 5GHz bands.

- Adds logic to handle DFS CAC (Channel Availability Check) procedures,
  including radar detection, CAC timeout, and abort handling.
- Implements firmware interaction via HOST_CMD_CHAN_REPORT_REQUEST
  and radar event handling.
- Supports TPC through power capability and local power constraint IEs
  during association.
- Enables channel switch operations with AP restart and beacon updates.

Firmware is responsible for radar detection and reporting, while the
driver manages TLV construction, event handling, and cfg80211 integration.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 338 +++++++++++++++++++++++++
 1 file changed, 338 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..2189b5242fc9
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: 802.11h helpers
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+#include "fw.h"
+#include "cfg80211.h"
+
+void nxpwifi_init_11h_params(struct nxpwifi_private *priv)
+{
+	priv->state_11h.is_11h_enabled = true;
+	priv->state_11h.is_11h_active = false;
+}
+
+inline int nxpwifi_is_11h_active(struct nxpwifi_private *priv)
+{
+	return priv->state_11h.is_11h_active;
+}
+
+/* appends 11h info to a buffer while joining an infrastructure BSS */
+static void
+nxpwifi_11h_process_infra_join(struct nxpwifi_private *priv, u8 **buffer,
+			       struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_header *ie_header;
+	struct nxpwifi_ie_types_pwr_capability *cap;
+	struct nxpwifi_ie_types_local_pwr_constraint *constraint;
+	struct ieee80211_supported_band *sband;
+	u8 radio_type;
+	int i;
+
+	if (!buffer || !(*buffer))
+		return;
+
+	radio_type = nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+	sband = priv->wdev.wiphy->bands[radio_type];
+
+	cap = (struct nxpwifi_ie_types_pwr_capability *)*buffer;
+	cap->header.type = cpu_to_le16(WLAN_EID_PWR_CAPABILITY);
+	cap->header.len = cpu_to_le16(2);
+	cap->min_pwr = 0;
+	cap->max_pwr = 0;
+	*buffer += sizeof(*cap);
+
+	constraint = (struct nxpwifi_ie_types_local_pwr_constraint *)*buffer;
+	constraint->header.type = cpu_to_le16(WLAN_EID_PWR_CONSTRAINT);
+	constraint->header.len = cpu_to_le16(2);
+	constraint->chan = bss_desc->channel;
+	constraint->constraint = bss_desc->local_constraint;
+	*buffer += sizeof(*constraint);
+
+	ie_header = (struct nxpwifi_ie_types_header *)*buffer;
+	ie_header->type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+	ie_header->len  = cpu_to_le16(2 * sband->n_channels + 2);
+	*buffer += sizeof(*ie_header);
+	*(*buffer)++ = WLAN_EID_SUPPORTED_CHANNELS;
+	*(*buffer)++ = 2 * sband->n_channels;
+	for (i = 0; i < sband->n_channels; i++) {
+		u32 center_freq;
+
+		center_freq = sband->channels[i].center_freq;
+		*(*buffer)++ = ieee80211_frequency_to_channel(center_freq);
+		*(*buffer)++ = 1; /* one channel in the subband */
+	}
+}
+
+/* Enable or disable the 11h extensions in the firmware */
+int nxpwifi_11h_activate(struct nxpwifi_private *priv, bool flag)
+{
+	u32 enable = flag;
+
+	/* enable master mode radar detection on AP interface */
+	if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) && enable)
+		enable |= NXPWIFI_MASTER_RADAR_DET_MASK;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_SNMP_MIB,
+				HOST_ACT_GEN_SET, DOT11H_I, &enable, true);
+}
+
+/*
+ * Process TLV buffer for a pending BSS join. Enable 11h in firmware when the
+ * network advertises spectrum management, and add required TLVs based on the
+ * BSS's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/* Activate 11h functions in firmware, turns on capability bit */
+		nxpwifi_11h_activate(priv, true);
+		priv->state_11h.is_11h_active = true;
+		bss_desc->cap_info_bitmap |= WLAN_CAPABILITY_SPECTRUM_MGMT;
+		nxpwifi_11h_process_infra_join(priv, buffer, bss_desc);
+	} else {
+		/* Deactivate 11h functions in the firmware */
+		nxpwifi_11h_activate(priv, false);
+		priv->state_11h.is_11h_active = false;
+		bss_desc->cap_info_bitmap &= ~WLAN_CAPABILITY_SPECTRUM_MGMT;
+	}
+}
+
+/*
+ * DFS CAC work function. This delayed work emits CAC finished event for cfg80211
+ * if CAC was started earlier
+ */
+void nxpwifi_dfs_cac_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_chan_def chandef;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_cac_work);
+
+	chandef = priv->dfs_chandef;
+	if (priv->wdev.links[0].cac_started) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "CAC timer finished; No radar detected\n");
+		cfg80211_cac_event(priv->netdev, &chandef,
+				   NL80211_RADAR_CAC_FINISHED,
+				   GFP_KERNEL, 0);
+	}
+}
+
+/* prepares channel report request command to FW for starting radar detection */
+int nxpwifi_cmd_issue_chan_report_request(struct nxpwifi_private *priv,
+					  struct host_cmd_ds_command *cmd,
+					  void *data_buf)
+{
+	struct host_cmd_ds_chan_rpt_req *cr_req = &cmd->params.chan_rpt_req;
+	struct nxpwifi_radar_params *radar_params = (void *)data_buf;
+	u16 size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_CHAN_REPORT_REQUEST);
+	size = S_DS_GEN;
+
+	cr_req->chan_desc.start_freq = cpu_to_le16(NXPWIFI_A_BAND_START_FREQ);
+	nxpwifi_convert_chan_to_band_cfg(priv,
+					 &cr_req->chan_desc.band_cfg,
+					 radar_params->chandef);
+	cr_req->chan_desc.chan_num = radar_params->chandef->chan->hw_value;
+	cr_req->msec_dwell_time = cpu_to_le32(radar_params->cac_time_ms);
+	size += sizeof(*cr_req);
+
+	if (radar_params->cac_time_ms) {
+		struct nxpwifi_ie_types_chan_rpt_data *rpt;
+
+		rpt = (struct nxpwifi_ie_types_chan_rpt_data *)((u8 *)cmd + size);
+		rpt->header.type = cpu_to_le16(TLV_TYPE_CHANRPT_11H_BASIC);
+		rpt->header.len = cpu_to_le16(sizeof(u8));
+		rpt->meas_rpt_map = 1 << MEAS_RPT_MAP_RADAR_SHIFT_BIT;
+		size += sizeof(*rpt);
+
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "11h: issuing DFS Radar check for channel=%d\n",
+			    radar_params->chandef->chan->hw_value);
+	} else {
+		nxpwifi_dbg(priv->adapter, MSG, "cancelling CAC\n");
+	}
+
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+int nxpwifi_stop_radar_detection(struct nxpwifi_private *priv,
+				 struct cfg80211_chan_def *chandef)
+{
+	struct nxpwifi_radar_params radar_params;
+
+	memset(&radar_params, 0, sizeof(struct nxpwifi_radar_params));
+	radar_params.chandef = chandef;
+	radar_params.cac_time_ms = 0;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_CHAN_REPORT_REQUEST,
+				HOST_ACT_GEN_SET, 0, &radar_params, true);
+}
+
+/* Abort ongoing CAC when stopping AP operations or during unload */
+void nxpwifi_abort_cac(struct nxpwifi_private *priv)
+{
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to stop CAC in FW\n");
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "Aborting delayed work for CAC.\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+}
+
+/*
+ * handles channel report event from FW during CAC period. If radar is detected
+ * during CAC, driver indicates the same to cfg80211 and also cancels ongoing
+ * delayed work
+ */
+int nxpwifi_11h_handle_chanrpt_ready(struct nxpwifi_private *priv,
+				     struct sk_buff *skb)
+{
+	struct host_cmd_ds_chan_rpt_event *rpt_event;
+	struct nxpwifi_ie_types_chan_rpt_data *rpt;
+	u16 event_len, tlv_len;
+
+	rpt_event = (void *)(skb->data + sizeof(u32));
+	event_len = skb->len - (sizeof(struct host_cmd_ds_chan_rpt_event) +
+				sizeof(u32));
+
+	if (le32_to_cpu(rpt_event->result) != HOST_RESULT_OK) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Error in channel report event\n");
+		return -EINVAL;
+	}
+
+	while (event_len >= sizeof(struct nxpwifi_ie_types_header)) {
+		rpt = (void *)&rpt_event->tlvbuf;
+		tlv_len = le16_to_cpu(rpt->header.len);
+
+		switch (le16_to_cpu(rpt->header.type)) {
+		case TLV_TYPE_CHANRPT_11H_BASIC:
+			if (rpt->meas_rpt_map & MEAS_RPT_MAP_RADAR_MASK) {
+				nxpwifi_dbg(priv->adapter, MSG,
+					    "RADAR Detected on channel %d!\n",
+					    priv->dfs_chandef.chan->hw_value);
+
+				wiphy_delayed_work_cancel(priv->adapter->wiphy,
+							  &priv->dfs_cac_work);
+				cfg80211_cac_event(priv->netdev,
+						   &priv->dfs_chandef,
+						   NL80211_RADAR_CAC_ABORTED,
+						   GFP_KERNEL, 0);
+				cfg80211_radar_event(priv->adapter->wiphy,
+						     &priv->dfs_chandef,
+						     GFP_KERNEL);
+			}
+			break;
+		default:
+			break;
+		}
+
+		event_len -= (tlv_len + sizeof(rpt->header));
+	}
+
+	return 0;
+}
+
+/* Handler for radar detected event from FW */
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb)
+{
+	struct nxpwifi_radar_det_event *rdr_event;
+
+	rdr_event = (void *)(skb->data + sizeof(u32));
+
+	nxpwifi_dbg(priv->adapter, MSG,
+		    "radar detected; indicating kernel\n");
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
+			     GFP_KERNEL);
+	nxpwifi_dbg(priv->adapter, MSG, "regdomain: %d\n",
+		    rdr_event->reg_domain);
+	nxpwifi_dbg(priv->adapter, MSG, "radar detection type: %d\n",
+		    rdr_event->det_type);
+
+	return 0;
+}
+
+/*
+ * work function for channel switch handling. takes care of updating new channel
+ * definitin to bss config structure, restart AP and indicate channel switch
+ * success to cfg80211
+ */
+void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct nxpwifi_uap_bss_param *bss_cfg;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_chan_sw_work);
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (nxpwifi_del_mgmt_ies(priv))
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to delete mgmt IEs!\n");
+
+	bss_cfg = &priv->bss_cfg;
+	if (!bss_cfg->beacon_period) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: AP already stopped\n");
+		return;
+	}
+
+	if (nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
+			     HOST_ACT_GEN_SET, 0, NULL, true)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to stop the BSS\n");
+		return;
+	}
+
+	if (nxpwifi_cfg80211_change_beacon(adapter->wiphy, priv->netdev,
+					   &priv->ap_update_info)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to set beacon\n");
+		return;
+	}
+
+	nxpwifi_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
+
+	if (nxpwifi_config_start_uap(priv, bss_cfg)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Failed to start AP after channel switch\n");
+		return;
+	}
+
+	nxpwifi_dbg(adapter, MSG,
+		    "indicating channel switch completion to kernel\n");
+
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
+
+	if (priv->uap_stop_tx) {
+		netif_carrier_on(priv->netdev);
+		nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+		priv->uap_stop_tx = false;
+	}
+}
-- 
2.34.1


