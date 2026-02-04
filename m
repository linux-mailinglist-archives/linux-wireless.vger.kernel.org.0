Return-Path: <linux-wireless+bounces-31566-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCE0MR+Lg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31566-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:08:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78991EB6B7
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE4BE30041C0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7142E01F;
	Wed,  4 Feb 2026 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NgGwkD+f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53B42E016;
	Wed,  4 Feb 2026 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228355; cv=fail; b=SCtN/tAD8bws3GCsnsy4mpjRddqjndOyAeSd9LyEa2KcCMEYgNGUa6pJdOB/249ATMnBBgVXPhZeuLFcCYK7WJJtbJmvR/+qY8sttcGlPbQyGlYHqE48PrH1erDS5G9jSa8l5lWC2hmsz1yxdr0Z4657+INRMTYN8hM0TWnLEz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228355; c=relaxed/simple;
	bh=7wQRYFWZAR5rkvbbJaiRIxmeNP9OshPOEfK9wx/otOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MzVRFXvtDgMU8796lY1rBwtYAS69ziHxYiLNF5linhpqpIlAOonbyWBEYlvv1eBTb8lk2SUP4ub4/pYnoW7CiEab1m+xqmocCSZVTIoIKMmAsjMGvqcpOLeoWeLERAADTVKdyZMg6dlWNIe2lT6qoua8t9HwMesGZRaqEzlFFaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NgGwkD+f; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXueZWpqhm43OpnTc4GGkk4veKJ2cv6orBUErqlv1xsK2HnANPtdla3m+yz+dWprkKSz1aF1/+Y5C1LQ8xMMnMVmGMT03Lk2DTcOpn4nbdCjF0OaQM0JgLeHvAv/M68HEdefoPVhisq0a30OW8SkoMyCqvW5BfG1FQSYUF3OGedgNnWy9lcG+EofytHttjdUFsEyK94l5Z62OEQYOaIhuJT7KQriBm3GycFCPj99F1Ql34dESCn7Ab32F73s2jA1bPpziz/AzJbpX8GX7nr4XY0Z8/qJgeeA8aZdwNWW7keCLS3JvFFvN1/0A+0hn883VggWgrInLaQZZVEFlkZdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp6AW69/tFsD6huikmfSpEe162rEFCGjP2gKlgOxcj0=;
 b=zDKZfKDlmDFO3HnfTK5kqbfiuX6T29pvbE+BaKRf6xpXgx87tz4ZgoSJjWQ35QL4t5eJnacI2uss93TxA1hgZIeGScwCZRFiQi172+gqmhlJdKG6gCwHIVpK7cJA/LIGf//m8/fvSFBIl9F/UByUv50Mg2WIiyZbYNzC2kZztASFRVHF+BE6nZkUzd+JNvPeq6gxegqTBusRNxjdDwY2+trNx+a5xOUbuMF0a5m6buZC2B3tt/L5EfR3hmZ+z7XJnxiP1VW8/TSWq8hgZ/IT8RVCPBACFfiX6DagtlQS4hLxCL3itQvIplY7OUERhpS38N9iDNp3gX3ZF9eW1VnU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp6AW69/tFsD6huikmfSpEe162rEFCGjP2gKlgOxcj0=;
 b=NgGwkD+fwbibVyijgxD9tZ2liuoRfp2gzFAoDrxkCI3GWOos7hm2kfpBZUHSdzfs8BgKAE4bbc29zoBF3OoWB24V4xGMz92FcD0dINAU/l1OjxL6L9JKD7WydMdFri9n9UPivsF3/jIXnbuscZFb19c6dbVX0Qw5cMwU5dwBZN2/r9k41BiJbZQ/CqC6RZ58wrwy6WKu579ucsB5HXHZNEeMOy/zC9sxEHVvn5IrszhymOiYrFtToZkaqtJEiDHLciEMwyusiLjM7SmxwHWv9pEskZb0g6Wz41UTpwQysA8ZWcSeiaCpBeSDQMEPJSo4ZExsfnsWaDY5U7Kb6nCLqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GV2PR04MB11980.eurprd04.prod.outlook.com (2603:10a6:150:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 18:05:54 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:05:54 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 17/21] wifi: nxpwifi: add driver initialization and shutdown support
Date: Thu,  5 Feb 2026 02:03:54 +0800
Message-Id: <20260204180358.632281-18-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 68a83459-2a2f-47fc-1b62-08de641809bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C4+3B46ly5rwPjDH8A55CHYoT9UJFwW2fPddFXKS3lC8OgEV5bh23l2arhO+?=
 =?us-ascii?Q?qWdS36JYRnFIfsg157dIOaVIrauqReIdeQDiSLJEUJEj4GYdJoQGWlTdy69L?=
 =?us-ascii?Q?5KgP1lfH3J7QiK5Nn9CtDtdwOhtCqv9zu1x9z8Nruv3lds21Cz3tDRA7h2Qy?=
 =?us-ascii?Q?zNh8SmBdRC9FBWMgmrQvu4s1L0Joz/vET02ReyYMy2SP8g9GHyOiIrUDv+dp?=
 =?us-ascii?Q?+WbJyW8oHr3+CL+G0JMdbiwLorQlFJqfRB0clVxeoLCbrWZX16sq+q+zyL7S?=
 =?us-ascii?Q?DSGzUiHYLKvUUwQ6bJ8GhQE1BupWa9I5b1ZqEOFWVtJonhd+NtsmIw0Av6Nw?=
 =?us-ascii?Q?xacX1AYkw9SKZYtdUO1NlEkGcPagNeZhJ7T7vXA7NSwplvqJtdiiHFUrNGdD?=
 =?us-ascii?Q?UpsoqSnqavlGHN2YE1HHJAAsreVJQVflvR6HAiuQWZKQmmXGuETw7emOrSPI?=
 =?us-ascii?Q?yD57EyUR55qcQ6heiY94rLn4GZVnnv2jRtkaB7B/e/GpOkafpcNxJArTwvpE?=
 =?us-ascii?Q?b8jvmc2+OQDyu3A6wVR0hT6dNn5fD3Kc8ooEOFkcca34w2xCK7Hmg4ObOaAZ?=
 =?us-ascii?Q?/91nFyrkI46M9HjEWFGcTWmLAb82Oi5e2G7lHrtRiGasdOPDnioAEAtQpnXj?=
 =?us-ascii?Q?C9+Ia1Cd5xGc9BnEqWqSZzC42V0xqtWkvRhIe6SMHuMrfwicDeE2vR5rEUOD?=
 =?us-ascii?Q?nlWL/jeBxLhP3zOxGcW1FYhR4EuSixWA2GD/Hl/n2aauI4f7We9/hRCZ7XOP?=
 =?us-ascii?Q?ajeMLE2N5QJpwYyUqX/xveS5D+IZIKOPKvRv9d89N6jjMcNx0O1DnLofj18o?=
 =?us-ascii?Q?74zaBeFEMlmTox3EWc9DwfrDKPnJuRhpHCFHHgDy6Q8Td1O1/pKsHWhhzSlj?=
 =?us-ascii?Q?82WqnycRe6Rv6TN9bZW438GT7ju1UR6KA4sg0LpkqgEyweXh1CSiuxWWqL6I?=
 =?us-ascii?Q?SgkY1oTWX59BNJl9ydy33NUEn1AuDd0P5P9c6PIaBzxvn2VAdG+OrX62tean?=
 =?us-ascii?Q?iaP8ALcvgQK+iSRXQE/adSIH+j5Qqqs2sX35B93TCqG5Wp94m8zhrrfDjuHx?=
 =?us-ascii?Q?8uM3DuQ6BF61RLUQOJ0fuqccpqJj8AIEtZMUa9DkYwm0dRBWkzpleO8xVbRO?=
 =?us-ascii?Q?hP6Si/AOhGtnajxdlUH+Wqhrp5jJPHwfNz6+aYkKyCJdeI3jse6D9T9DsDLV?=
 =?us-ascii?Q?Ap7WeICPVKr4eB39TBKKOr83DZUiacvNCkb0WhTRMew5PXGCIK63xWLTPjMY?=
 =?us-ascii?Q?bdeNTBOtis1qmp8KuUTFpxRTMt3c5zf6Huj+qgFdK5bF2PoQUeEbPXLw8C6v?=
 =?us-ascii?Q?bn335ebWfko09QN5x5jy/kIr2yDW4dmeUiF82L3Av+qh9RfyP0HhgVhVNCK1?=
 =?us-ascii?Q?g4cYbT8ulgJo48YfwlN7eTqNP7M11IoxJou9jMdPiNSXOXx1X3IJajqHyFHI?=
 =?us-ascii?Q?bv1csoRS/jbHnk46axsthfyEISfN/+Ypbyig1TJcHz/lMNTzB1y1yaaltkGf?=
 =?us-ascii?Q?do1zv/LWMGR4sWsxybx8bA+aa6c9Lu01hsl262y9PlQEAsNs2asQUX2XvZ/Z?=
 =?us-ascii?Q?WE08X4sedka3F9/so6Ye91KvHveCNvKcgeoNq3Ftc4WL+9xUqVh5TD0/rA3r?=
 =?us-ascii?Q?B85FQ8uqeSi5/l4lOX5YO2M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/i3RhhZMt+jTp1quUMiYUaMGI2JdXytjlyNr/P9kr3SZFZHCFotLjp8DNaF?=
 =?us-ascii?Q?mBX14GT7kJpdkZBQNM2w20O4ogYJQuNFnlAxbEmCFW1qYIp8QFAWmqwJKY32?=
 =?us-ascii?Q?lhJjWPumnCTQ7ytPFRj78r25PLOh3LQWDT7B/VW7CciOCoxppi1FGbqcA/c6?=
 =?us-ascii?Q?NoC7oDzKXa9HQiMCAPMNKWRA6z8uYoPXIDFS2chtebwgLaGT3F7lSnh7FD9s?=
 =?us-ascii?Q?IKOGZEC1QDATuf1jogJsD66eqP+MTwQHYfomHHNJFYEyEOLM/lq77KA270M1?=
 =?us-ascii?Q?vpFCZTm9AuI64rFtmZtbN1FDwT//z5TcJG5KNxValPDMCkWFzFI5N2iguOjk?=
 =?us-ascii?Q?5ask2H0Fvvw5lZV1GcT44ph+znBDkSJ2c13LaD9Qx03QHsStQ7Z9HExdWUt3?=
 =?us-ascii?Q?RDAqUyWSzCZKFGZ4sTYydQHfqYsZ2MVfTpnzu6g88kmwJ3GCI7Muk108dZp8?=
 =?us-ascii?Q?FTJakLDOi/swpGV5p0A9XSjHOPska/yR6+Wb6yt8zLKRkRgFwD6iWsUStsRk?=
 =?us-ascii?Q?pi8cZ5VCn984LwBqQlDQyAIJW2euFTM37t5PVBcl47xmJCrARWiFTxJFmRFf?=
 =?us-ascii?Q?ztbB3UhmyKFcbLNkBuM2uqM19E+48lR4rpq1uymoivfAYf1MYGuTAuw6u28T?=
 =?us-ascii?Q?hiLok54SCXYv3gN6jUaTvn2PwPG2MhOwjXb2jIzlw1+4/biiNzuPTdHHE9Af?=
 =?us-ascii?Q?mIUVN0Wvmxi6ycN3/TcV05sD030CVotyYaAGAWtZMeFTQ8kVadvgfOQuFQ57?=
 =?us-ascii?Q?M5/yBll0g3sMEig1l5mDJQdmrO2oX9KWlZjsnClt9ba1afi/YvjVxp3aYI4D?=
 =?us-ascii?Q?545C3DwvcXeBKybL5eZp/3xNYq7AIQqpHCC5O5cCO7h/8uT2bUDJn0Uxr5GM?=
 =?us-ascii?Q?ycr+liC9xzovlm67wlYxLi32sVuM6FvUwnhOFJufuG6NbX/UBBkjmCajULvU?=
 =?us-ascii?Q?f+5vXw0aX52g9cw2S4fZxChKSm5bqKQikuoasyxcajUrxRUv4ZAUN3pxEhNr?=
 =?us-ascii?Q?9cC+ptXkdomgdiotK6Kr7vEMhE8xKYcpWHNIjJTV/o9nRIHw8LjM4AIDE4ly?=
 =?us-ascii?Q?NkrAM598PhMHAI2lilL4yieFKCM/RGULiP/MFwer+ppK5syeNgTzAu7EAy2z?=
 =?us-ascii?Q?Zsp+I2+hIQ0DU3ugc6C2KVgx5LyCHDv2MRC0qwksOLN7wTlT0/TM8dNaN5Jf?=
 =?us-ascii?Q?2RNAVvedDTbW2nwO1DmbLejAKoXwvfrT5p/PEEqsp8FDBULFfhTt470qudgM?=
 =?us-ascii?Q?+dC10qvMo7EdOcpOjOd43pRA9pt47Q5D5AHVt5tvbfJN4hzMHy9LL8rWu0tI?=
 =?us-ascii?Q?TPaechPYfT5/32+f9oTi1EFPtsiTPNV3Kws3yi1DjG40ecbpT1bSBQ51KNOU?=
 =?us-ascii?Q?VXZtmKI+8Jj6vGqE4lG5A9q1iKxov0OfbQCuGvLGte6X+9Bo5wbzz5LbUL1o?=
 =?us-ascii?Q?na0F9nczKsOrotnt70OxgU0WkBorPpVZ445t64rhfY3NuBZ3TfsuVyZMwl7D?=
 =?us-ascii?Q?AdsHo9nAdtzB+94UeyAE5xt+ldDmqOOywZ17aAxX0htIE57j4mLSxsTSdrmn?=
 =?us-ascii?Q?2rRVAwSDkkAopSCte0sefbN5AMPna8sIJF1+vVsh6jEyogmHE7P94/rGRvoX?=
 =?us-ascii?Q?Fz8COD3URUXM40BxC51yPJfuqSEoNJQEpFRlFZ+CtsSD4fO8TeFw3E8B+sB7?=
 =?us-ascii?Q?8wYmG4vNhyIJjirINYTrW0CBf6sLeA5ZlQJfWx8HG6fGJxX61GrBHQ59JeUw?=
 =?us-ascii?Q?lnKvqc7vMw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a83459-2a2f-47fc-1b62-08de641809bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:05:54.0112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XShx4/WXEpbXL6FyuLzxke9drpk86iBBe7TDFkDzhL03KUgzkpjZGV98y4kWLBCqZ9uxYbefYDl13VqVJXy6lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11980
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31566-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 78991EB6B7
X-Rspamd-Action: no action

This patch introduces the initialization and shutdown logic for the nxpwifi
driver, including setup of adapter and private structures, firmware
download,and resource cleanup.

Key features:
- Initializes adapter and private structures with default values
- Allocates and initializes command buffers, queues, and timers
- Sets up BSS priority tables for multi-interface coordination
- Implements firmware download and initialization sequence
- Provides shutdown and cleanup routines for safe driver removal
- Adds helpers for managing netdev queues and synchronization primitives

These foundational components are essential for bringing up the driver and
ensuring proper resource management across its lifecycle.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/init.c | 607 ++++++++++++++++++++++++
 1 file changed, 607 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/init.c b/drivers/net/wireless/nxp/nxpwifi/init.c
new file mode 100644
index 000000000000..7e472dd194a1
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/init.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: HW/FW initialization
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+
+/* Add a BSS priority node to the adapter list. */
+static int nxpwifi_add_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bss_prio;
+	struct nxpwifi_bss_prio_tbl *tbl = adapter->bss_prio_tbl;
+
+	bss_prio = kzalloc(sizeof(*bss_prio), GFP_KERNEL);
+	if (!bss_prio)
+		return -ENOMEM;
+
+	bss_prio->priv = priv;
+	INIT_LIST_HEAD(&bss_prio->list);
+
+	spin_lock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+	list_add_tail(&bss_prio->list, &tbl[priv->bss_priority].bss_prio_head);
+	spin_unlock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+
+	return 0;
+}
+
+static void wakeup_timer_fn(struct timer_list *t)
+{
+	struct nxpwifi_adapter *adapter = timer_container_of(adapter, t, wakeup_timer);
+
+	nxpwifi_dbg(adapter, ERROR, "Firmware wakeup failed\n");
+	adapter->hw_status = NXPWIFI_HW_STATUS_RESET;
+	nxpwifi_cancel_all_pending_cmd(adapter);
+
+	if (adapter->if_ops.card_reset)
+		adapter->if_ops.card_reset(adapter);
+}
+
+/* Initialize priv defaults and lists. */
+int nxpwifi_init_priv(struct nxpwifi_private *priv)
+{
+	u32 i;
+
+	priv->media_connected = false;
+	eth_broadcast_addr(priv->curr_addr);
+	priv->port_open = false;
+	priv->usb_port = NXPWIFI_USB_EP_DATA;
+	priv->pkt_tx_ctrl = 0;
+	priv->bss_mode = NL80211_IFTYPE_UNSPECIFIED;
+	priv->data_rate = 0;	/* Initially indicate the rate as auto */
+	priv->is_data_rate_auto = true;
+	priv->bcn_avg_factor = DEFAULT_BCN_AVG_FACTOR;
+	priv->data_avg_factor = DEFAULT_DATA_AVG_FACTOR;
+
+	priv->auth_flag = 0;
+	priv->auth_alg = WLAN_AUTH_NONE;
+
+	priv->sec_info.wep_enabled = 0;
+	priv->sec_info.authentication_mode = NL80211_AUTHTYPE_OPEN_SYSTEM;
+	priv->sec_info.encryption_mode = 0;
+	for (i = 0; i < ARRAY_SIZE(priv->wep_key); i++)
+		memset(&priv->wep_key[i], 0, sizeof(struct nxpwifi_wep_key));
+	priv->wep_key_curr_index = 0;
+	priv->curr_pkt_filter = HOST_ACT_MAC_DYNAMIC_BW_ENABLE |
+				HOST_ACT_MAC_RX_ON | HOST_ACT_MAC_TX_ON |
+				HOST_ACT_MAC_ETHERNETII_ENABLE;
+
+	priv->beacon_period = 100; /* beacon interval */
+	priv->attempted_bss_desc = NULL;
+	memset(&priv->curr_bss_params, 0, sizeof(priv->curr_bss_params));
+	priv->listen_interval = NXPWIFI_DEFAULT_LISTEN_INTERVAL;
+
+	memset(&priv->prev_ssid, 0, sizeof(priv->prev_ssid));
+	memset(&priv->prev_bssid, 0, sizeof(priv->prev_bssid));
+	memset(&priv->assoc_rsp_buf, 0, sizeof(priv->assoc_rsp_buf));
+	priv->assoc_rsp_size = 0;
+	priv->atim_window = 0;
+	priv->tx_power_level = 0;
+	priv->max_tx_power_level = 0;
+	priv->min_tx_power_level = 0;
+	priv->tx_ant = 0;
+	priv->rx_ant = 0;
+	priv->tx_rate = 0;
+	priv->rxpd_htinfo = 0;
+	priv->rxpd_rate = 0;
+	priv->rate_bitmap = 0;
+	priv->data_rssi_last = 0;
+	priv->data_rssi_avg = 0;
+	priv->data_nf_avg = 0;
+	priv->data_nf_last = 0;
+	priv->bcn_rssi_last = 0;
+	priv->bcn_rssi_avg = 0;
+	priv->bcn_nf_avg = 0;
+	priv->bcn_nf_last = 0;
+	memset(&priv->wpa_ie, 0, sizeof(priv->wpa_ie));
+	memset(&priv->aes_key, 0, sizeof(priv->aes_key));
+	priv->wpa_ie_len = 0;
+	priv->wpa_is_gtk_set = false;
+
+	memset(&priv->assoc_tlv_buf, 0, sizeof(priv->assoc_tlv_buf));
+	priv->assoc_tlv_buf_len = 0;
+	memset(&priv->wps, 0, sizeof(priv->wps));
+	memset(&priv->gen_ie_buf, 0, sizeof(priv->gen_ie_buf));
+	priv->gen_ie_buf_len = 0;
+	memset(priv->vs_ie, 0, sizeof(priv->vs_ie));
+
+	priv->wmm_required = true;
+	priv->wmm_enabled = false;
+	priv->wmm_qosinfo = 0;
+	priv->curr_bcn_buf = NULL;
+	priv->curr_bcn_size = 0;
+	priv->wps_ie = NULL;
+	priv->wps_ie_len = 0;
+	priv->ap_11n_enabled = 0;
+	memset(&priv->roc_cfg, 0, sizeof(priv->roc_cfg));
+
+	priv->scan_block = false;
+
+	priv->csa_chan = 0;
+	priv->csa_expire_time = 0;
+	priv->del_list_idx = 0;
+	priv->hs2_enabled = false;
+	memcpy(priv->tos_to_tid_inv, tos_to_tid_inv, MAX_NUM_TID);
+
+	nxpwifi_init_11h_params(priv);
+
+	return nxpwifi_add_bss_prio_tbl(priv);
+}
+
+/* Allocate command buffer and sleep-confirm skb. */
+static int nxpwifi_allocate_adapter(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+
+	/* Allocate command buffer */
+	ret = nxpwifi_alloc_cmd_buffer(adapter);
+	if (ret) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed to alloc cmd buffer\n",
+			    __func__);
+		return ret;
+	}
+
+	adapter->sleep_cfm =
+		dev_alloc_skb(sizeof(struct nxpwifi_opt_sleep_confirm)
+			      + INTF_HEADER_LEN);
+
+	if (!adapter->sleep_cfm) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed to alloc sleep cfm\t"
+			    " cmd buffer\n", __func__);
+		return -ENOMEM;
+	}
+	skb_reserve(adapter->sleep_cfm, INTF_HEADER_LEN);
+
+	return 0;
+}
+
+/* Initialize adapter defaults and WMM parameters. */
+static void nxpwifi_init_adapter(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_opt_sleep_confirm *sleep_cfm_buf = NULL;
+
+	skb_put(adapter->sleep_cfm, sizeof(struct nxpwifi_opt_sleep_confirm));
+
+	adapter->cmd_sent = false;
+	adapter->data_sent = true;
+
+	adapter->intf_hdr_len = INTF_HEADER_LEN;
+
+	adapter->cmd_resp_received = false;
+	adapter->event_received = false;
+	adapter->data_received = false;
+	adapter->assoc_resp_received = false;
+	adapter->priv_link_lost = NULL;
+	adapter->host_mlme_link_lost = false;
+
+	clear_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+
+	adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_CAM;
+	adapter->ps_state = PS_STATE_AWAKE;
+	adapter->need_to_wakeup = false;
+
+	adapter->scan_mode = HOST_BSS_MODE_ANY;
+	adapter->specific_scan_time = NXPWIFI_SPECIFIC_SCAN_CHAN_TIME;
+	adapter->active_scan_time = NXPWIFI_ACTIVE_SCAN_CHAN_TIME;
+	adapter->passive_scan_time = NXPWIFI_PASSIVE_SCAN_CHAN_TIME;
+	adapter->scan_chan_gap_time = NXPWIFI_DEF_SCAN_CHAN_GAP_TIME;
+
+	adapter->scan_probes = 1;
+
+	adapter->multiple_dtim = 1;
+
+	/* default value in firmware will be used */
+	adapter->local_listen_interval = 0;
+
+	adapter->is_deep_sleep = false;
+
+	adapter->delay_null_pkt = false;
+	adapter->delay_to_ps = 1000;
+	adapter->enhanced_ps_mode = PS_MODE_AUTO;
+
+	/* Disable NULL Pkg generation by default */
+	adapter->gen_null_pkt = false;
+	/* Disable pps/uapsd mode by default */
+	adapter->pps_uapsd_mode = false;
+	adapter->pm_wakeup_card_req = false;
+
+	adapter->pm_wakeup_fw_try = false;
+
+	adapter->curr_tx_buf_size = NXPWIFI_TX_DATA_BUF_SIZE_2K;
+
+	clear_bit(NXPWIFI_IS_HS_CONFIGURED, &adapter->work_flags);
+	adapter->hs_cfg.conditions = cpu_to_le32(HS_CFG_COND_DEF);
+	adapter->hs_cfg.gpio = HS_CFG_GPIO_DEF;
+	adapter->hs_cfg.gap = HS_CFG_GAP_DEF;
+	adapter->hs_activated = false;
+
+	memset(adapter->event_body, 0, sizeof(adapter->event_body));
+	adapter->hw_dot_11n_dev_cap = 0;
+	adapter->hw_dev_mcs_support = 0;
+	adapter->sec_chan_offset = 0;
+
+	nxpwifi_wmm_init(adapter);
+	atomic_set(&adapter->tx_hw_pending, 0);
+
+	sleep_cfm_buf = (struct nxpwifi_opt_sleep_confirm *)
+					adapter->sleep_cfm->data;
+	memset(sleep_cfm_buf, 0, adapter->sleep_cfm->len);
+	sleep_cfm_buf->command = cpu_to_le16(HOST_CMD_802_11_PS_MODE_ENH);
+	sleep_cfm_buf->size = cpu_to_le16(adapter->sleep_cfm->len);
+	sleep_cfm_buf->result = 0;
+	sleep_cfm_buf->action = cpu_to_le16(SLEEP_CONFIRM);
+	sleep_cfm_buf->resp_ctrl = cpu_to_le16(RESP_NEEDED);
+
+	memset(&adapter->sleep_period, 0, sizeof(adapter->sleep_period));
+	adapter->tx_lock_flag = false;
+	adapter->null_pkt_interval = 0;
+	adapter->fw_bands = 0;
+	adapter->fw_release_number = 0;
+	adapter->fw_cap_info = 0;
+	memset(&adapter->upld_buf, 0, sizeof(adapter->upld_buf));
+	adapter->event_cause = 0;
+	adapter->region_code = 0;
+	adapter->bcn_miss_time_out = DEFAULT_BCN_MISS_TIMEOUT;
+	memset(&adapter->arp_filter, 0, sizeof(adapter->arp_filter));
+	adapter->arp_filter_size = 0;
+	adapter->max_mgmt_ie_index = MAX_MGMT_IE_INDEX;
+	adapter->key_api_major_ver = 0;
+	adapter->key_api_minor_ver = 0;
+	eth_broadcast_addr(adapter->perm_addr);
+	adapter->iface_limit.sta_intf = NXPWIFI_MAX_STA_NUM;
+	adapter->iface_limit.uap_intf = NXPWIFI_MAX_UAP_NUM;
+	adapter->active_scan_triggered = false;
+	timer_setup(&adapter->wakeup_timer, wakeup_timer_fn, 0);
+	adapter->devdump_len = 0;
+	memset(&adapter->vdll_ctrl, 0, sizeof(adapter->vdll_ctrl));
+	adapter->vdll_ctrl.skb = dev_alloc_skb(NXPWIFI_SIZE_OF_CMD_BUFFER);
+	atomic_set(&adapter->iface_changing, 0);
+}
+
+/* Update trans_start for each Tx queue. */
+void nxpwifi_set_trans_start(struct net_device *dev)
+{
+	int i;
+
+	for (i = 0; i < dev->num_tx_queues; i++)
+		txq_trans_cond_update(netdev_get_tx_queue(dev, i));
+
+	netif_trans_update(dev);
+}
+
+/* Wake all netdev Tx queues. */
+void nxpwifi_wake_up_net_dev_queue(struct net_device *netdev,
+				   struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_wake_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* Stop all netdev Tx queues. */
+void nxpwifi_stop_net_dev_queue(struct net_device *netdev,
+				struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_stop_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* Invalidate list heads. */
+static void nxpwifi_invalidate_lists(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	list_del(&adapter->cmd_free_q);
+	list_del(&adapter->cmd_pending_q);
+	list_del(&adapter->scan_pending_q);
+
+	for (i = 0; i < adapter->priv_num; i++)
+		list_del(&adapter->bss_prio_tbl[i].bss_prio_head);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		for (j = 0; j < MAX_NUM_TID; ++j) {
+			list_del(&priv->wmm.tid_tbl_ptr[j].ra_list);
+			list_del(&priv->tx_ba_stream_tbl_ptr[j]);
+			list_del(&priv->rx_reorder_tbl_ptr[j]);
+		}
+		list_del(&priv->sta_list);
+	}
+}
+
+/* Cancel pending work, stop timers, and free adapter buffers. */
+static void
+nxpwifi_adapter_cleanup(struct nxpwifi_adapter *adapter)
+{
+	timer_delete(&adapter->wakeup_timer);
+	nxpwifi_cancel_all_pending_cmd(adapter);
+	wake_up_interruptible(&adapter->cmd_wait_q.wait);
+	wake_up_interruptible(&adapter->hs_activate_wait_q);
+	if (adapter->vdll_ctrl.vdll_mem) {
+		vfree(adapter->vdll_ctrl.vdll_mem);
+		adapter->vdll_ctrl.vdll_mem = NULL;
+		adapter->vdll_ctrl.vdll_len = 0;
+	}
+	if (adapter->vdll_ctrl.skb) {
+		dev_kfree_skb_any(adapter->vdll_ctrl.skb);
+		adapter->vdll_ctrl.skb = NULL;
+	}
+}
+
+void nxpwifi_free_cmd_buffers(struct nxpwifi_adapter *adapter)
+{
+	nxpwifi_invalidate_lists(adapter);
+
+	/* Free command buffer */
+	nxpwifi_dbg(adapter, INFO, "info: free cmd buffer\n");
+	nxpwifi_free_cmd_buffer(adapter);
+
+	if (adapter->sleep_cfm)
+		dev_kfree_skb_any(adapter->sleep_cfm);
+}
+
+/* Initialize locks and list heads. */
+void nxpwifi_init_lock_list(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	spin_lock_init(&adapter->int_lock);
+	spin_lock_init(&adapter->nxpwifi_cmd_lock);
+	spin_lock_init(&adapter->queue_lock);
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		spin_lock_init(&priv->wmm.ra_list_spinlock);
+		spin_lock_init(&priv->curr_bcn_buf_lock);
+		spin_lock_init(&priv->sta_list_spinlock);
+	}
+
+	/* Initialize cmd_free_q */
+	INIT_LIST_HEAD(&adapter->cmd_free_q);
+	/* Initialize cmd_pending_q */
+	INIT_LIST_HEAD(&adapter->cmd_pending_q);
+	/* Initialize scan_pending_q */
+	INIT_LIST_HEAD(&adapter->scan_pending_q);
+
+	spin_lock_init(&adapter->cmd_free_q_lock);
+	spin_lock_init(&adapter->cmd_pending_q_lock);
+	spin_lock_init(&adapter->scan_pending_q_lock);
+
+	skb_queue_head_init(&adapter->rx_mlme_q);
+	skb_queue_head_init(&adapter->rx_data_q);
+	skb_queue_head_init(&adapter->tx_data_q);
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		INIT_LIST_HEAD(&adapter->bss_prio_tbl[i].bss_prio_head);
+		spin_lock_init(&adapter->bss_prio_tbl[i].bss_prio_lock);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		for (j = 0; j < MAX_NUM_TID; ++j) {
+			INIT_LIST_HEAD(&priv->wmm.tid_tbl_ptr[j].ra_list);
+			INIT_LIST_HEAD(&priv->tx_ba_stream_tbl_ptr[j]);
+			INIT_LIST_HEAD(&priv->rx_reorder_tbl_ptr[j]);
+			spin_lock_init(&priv->tx_ba_stream_tbl_lock[j]);
+			spin_lock_init(&priv->rx_reorder_tbl_lock[j]);
+		}
+		INIT_LIST_HEAD(&priv->sta_list);
+		skb_queue_head_init(&priv->bypass_txq);
+
+		spin_lock_init(&priv->ack_status_lock);
+		xa_init(&priv->ack_status_frames);
+	}
+}
+
+/* Init firmware: alloc resources, init adapter/privs, send STA init. */
+int nxpwifi_init_fw(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+	struct nxpwifi_private *priv;
+	u8 i;
+	bool first_sta = true;
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+
+	/* Allocate memory for member of adapter structure */
+	ret = nxpwifi_allocate_adapter(adapter);
+	if (ret)
+		return ret;
+
+	/* Initialize adapter structure */
+	nxpwifi_init_adapter(adapter);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		/* Initialize private structure */
+		ret = nxpwifi_init_priv(priv);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		ret = nxpwifi_sta_init_cmd(adapter->priv[i],
+					   first_sta, true);
+		if (ret)
+			return ret;
+
+		first_sta = false;
+	}
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	WARN_ON(!list_empty(&adapter->cmd_pending_q));
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+	adapter->hw_status = NXPWIFI_HW_STATUS_READY;
+
+	return 0;
+}
+
+/* Remove all BSS priority nodes for this priv. */
+static void nxpwifi_delete_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	int i;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bssprio_node, *tmp_node;
+	struct list_head *head;
+	spinlock_t *lock; /* bss priority lock */
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		head = &adapter->bss_prio_tbl[i].bss_prio_head;
+		lock = &adapter->bss_prio_tbl[i].bss_prio_lock;
+		nxpwifi_dbg(adapter, INFO,
+			    "info: delete BSS priority table,\t"
+			    "bss_type = %d, bss_num = %d, i = %d,\t"
+			    "head = %p\n",
+			    priv->bss_type, priv->bss_num, i, head);
+
+		{
+			spin_lock_bh(lock);
+			list_for_each_entry_safe(bssprio_node, tmp_node, head,
+						 list) {
+				if (bssprio_node->priv == priv) {
+					nxpwifi_dbg(adapter, INFO,
+						    "info: Delete\t"
+						    "node %p, next = %p\n",
+						    bssprio_node, tmp_node);
+					list_del(&bssprio_node->list);
+					kfree(bssprio_node);
+				}
+			}
+			spin_unlock_bh(lock);
+		}
+	}
+}
+
+/* Free per-priv resources and BSS priority entries. */
+void nxpwifi_free_priv(struct nxpwifi_private *priv)
+{
+	nxpwifi_clean_txrx(priv);
+	nxpwifi_delete_bss_prio_tbl(priv);
+	nxpwifi_free_curr_bcn(priv);
+}
+
+/* Shutdown driver: stop work, drain queues, free resources. */
+void
+nxpwifi_shutdown_drv(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i;
+	struct sk_buff *skb;
+
+	/* nxpwifi already shutdown */
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_NOT_READY)
+		return;
+
+	/* cancel current command */
+	if (adapter->curr_cmd) {
+		nxpwifi_dbg(adapter, WARN,
+			    "curr_cmd is still in processing\n");
+		timer_delete_sync(&adapter->cmd_timer);
+		nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
+		adapter->curr_cmd = NULL;
+	}
+
+	/* shut down nxpwifi */
+	nxpwifi_dbg(adapter, MSG,
+		    "info: shutdown nxpwifi...\n");
+
+	/* Clean up Tx/Rx queues and delete BSS priority table */
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		nxpwifi_abort_cac(priv);
+		nxpwifi_free_priv(priv);
+	}
+
+	atomic_set(&adapter->tx_queued, 0);
+	while ((skb = skb_dequeue(&adapter->tx_data_q)))
+		nxpwifi_write_data_complete(adapter, skb, 0, 0);
+
+	while ((skb = skb_dequeue(&adapter->rx_mlme_q)))
+		dev_kfree_skb_any(skb);
+
+	while ((skb = skb_dequeue(&adapter->rx_data_q))) {
+		struct nxpwifi_rxinfo *rx_info = NXPWIFI_SKB_RXCB(skb);
+
+		atomic_dec(&adapter->rx_pending);
+		priv = adapter->priv[rx_info->bss_num];
+		if (priv)
+			priv->stats.rx_dropped++;
+
+		dev_kfree_skb_any(skb);
+	}
+
+	nxpwifi_adapter_cleanup(adapter);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_NOT_READY;
+}
+
+/* Download FW if needed; check winner and wait until ready. */
+int nxpwifi_dnld_fw(struct nxpwifi_adapter *adapter,
+		    struct nxpwifi_fw_image *pmfw)
+{
+	int ret;
+	u32 poll_num = 1;
+
+	/* check if firmware is already running */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (!ret) {
+		nxpwifi_dbg(adapter, MSG,
+			    "WLAN FW already running! Skip FW dnld\n");
+		return 0;
+	}
+
+	/* check if we are the winner for downloading FW */
+	if (adapter->if_ops.check_winner_status) {
+		adapter->winner = 0;
+		ret = adapter->if_ops.check_winner_status(adapter);
+
+		poll_num = MAX_FIRMWARE_POLL_TRIES;
+		if (ret) {
+			nxpwifi_dbg(adapter, MSG,
+				    "WLAN read winner status failed!\n");
+			return ret;
+		}
+
+		if (!adapter->winner) {
+			nxpwifi_dbg(adapter, MSG,
+				    "WLAN is not the winner! Skip FW dnld\n");
+			goto poll_fw;
+		}
+	}
+
+	if (pmfw) {
+		/* Download firmware with helper */
+		ret = adapter->if_ops.prog_fw(adapter, pmfw);
+		if (ret) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "prog_fw failed ret=%#x\n", ret);
+			return ret;
+		}
+	}
+
+poll_fw:
+	/* Check if the firmware is downloaded successfully or not */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (ret)
+		nxpwifi_dbg(adapter, ERROR,
+			    "FW failed to be active in time\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_dnld_fw);
-- 
2.34.1


