Return-Path: <linux-wireless+bounces-28580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B83C353F3
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E033462ED8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C35230DED9;
	Wed,  5 Nov 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aMK7wy0M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1C30DEC9;
	Wed,  5 Nov 2025 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339749; cv=fail; b=l83D53XODA7ZEXg4R5n3w6o9vZRtgKV8237x4YbUp2DD8f76qdsK9HOyiVa0RNU75uKrgk768MzOxeXvJkUuzB/dCjbv3QaLLvd1YRyW71iS0dmEz7bCj+xC/RWH9mGYjTvdnBfdCc8avILENlAH2OqhmN6rpMnHAVcI7I9JkkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339749; c=relaxed/simple;
	bh=GFWBeAYhl2eW3XcGfQ22WBIsxV9B0Qiw5aHFBWQ2/Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LJ9G0nEze5r5NqXcLtQR55SERYIKx4E5avAgJIu0WKwmuRfBFR4BWVwTr/6UPsaFX7YKHokXuydQutUz0K1TH174O0yAicfl7GB+JQLhZ9cRfTii5b+bxScO63kzOyb0sFhNT7ivjbqPgyxKtBbgSTRjDPXm7mwsgCnOptySqrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aMK7wy0M; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3CHfvSYlVBXAcLlOTLLZHeLZq23YjPHgq/yWN6FAHSkeyrOcg/V0tz2SCSdMpIt55KV+w8R4F5KJftjAXmMGhORoIARUfWcCMrqegqMmt8bcJBoLgNa3enlz0wGvHd43a+ipL5klTDj8hkm7wneRbdx7py21fEnmwiUWg0ady3PrNB9u6ZS2vnwbYAp2Pwc0qS1I/HCo9LAPO6QZOLIYePX0E4UtVzqA0mRzJpPJkwaFBKs4bOUUTaBWdykq96YibMyv0erxwAgYLk5QuStdXYf+H6lvwg9PY8NA8J9aM/uqNxyr8Xi9803Dz1jG4A0GOsYztwO2x8Ulqv7DdmeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pk075EoOqfeLqpSetN++IozOfDjQ2T9anPATpu36MSQ=;
 b=dUvQN7bn3qjUsR3gAZOpV+BqIuAYBImsMxHiiH7KlClPJVF20X6FyKYFnmJHVDhIUZpD0V/tuXLnd9xQnnhpyuNiZYI2Q7XaTn9C3wSyrbNHZtnqfCxn0mPKcvoIv3jyGP561rbGvcAr0FPJRLIo3e4EVJUZVVBNPfALNp1Og3JIXeGvQKoJgRqYaO7ErPPVpEfcWJXK28ZFtqkilQad+BvvN0gtiX7ULhbG1sOchrhhyXiZvRDv1bIvi8lw8e1eJf2hkJh0U8GFBTYGbIcBIJgHI3Pd6r+JbzEdTsRXf+f2i5k9N0dThzFRAijJx2EvcV6T6KCjvuR9Sx3iaVxDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk075EoOqfeLqpSetN++IozOfDjQ2T9anPATpu36MSQ=;
 b=aMK7wy0MeYgyg1QL3DSripZ7bgi6yP3/e9Vo0993kbkhy4BaP13kqDhrRH5H0lRNFDi6lNSt6Kr+ng5g2G3OiUgJVn8klio0l4X0ie3Vlhnlvti7LPFwz9sHRkuGCx170FfcTj0oA3y0e9yzHSZIxZS7nk0wIO+yVaEHbVED0UCWSabehKdRPWrcPaZS69BEA+HIhNpPjGONHnxD488LNgIQe58kUolN8rAWYEiH1xU8J48//Ht9MLKFP9nSnRJLfD9Ad19PF1jZHQiTjxkPW6iJtwJ+iZWo16MMGpBrzJLxaFKIWliKDgyZnbnA1gH8cs8vQ9cTqWI/1/Df1XEqFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA4PR04MB9293.eurprd04.prod.outlook.com (2603:10a6:102:2a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 10:49:01 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:49:01 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 02/22] wifi: nxpwifi: add initial support for 802.11ac
Date: Wed,  5 Nov 2025 18:47:24 +0800
Message-Id: <20251105104744.2401992-3-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
References: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA4PR04MB9293:EE_
X-MS-Office365-Filtering-Correlation-Id: 77423b04-d898-4a3b-83c9-08de1c58edcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C9c817O1UajB8PVsFVQiPoAL4bvtDdrKO2Vr1IPNZ90RjZSt2QH9jvJKLgSF?=
 =?us-ascii?Q?wbvFPkI8v+j2wQyZvqnwNp1Lg0BvvUfRjlTeC8g0BnvvCeBgb53Xpe9GyIWC?=
 =?us-ascii?Q?n3uKGhr3RN5odBKZJoY+kKB27GY8Tz7NNP17ZcaaVAO64OeLIAS5sDmL2aEI?=
 =?us-ascii?Q?Y5MHcpMIAXQGnzFk5pbople95pU8Ncm5LEAXvge51sg+6Y+wr2qY7BiSdSwS?=
 =?us-ascii?Q?zSyIyBC0vERZ7fMf8pR0FXAb4auhLHCaNGMHGtH8kS4HeXiKbrqlpywMGPzv?=
 =?us-ascii?Q?kv9EeKu7C1KTe3JDWZv6ppOVHtaHldTaEXDO1BDR2hVSsyRddtziMOHMlzR2?=
 =?us-ascii?Q?M4mFvX7g7NkC/qtfvR+qo7rgPDvi3ZhRDnJAKJxU7hTpMXtrWHGMx6d+x7MJ?=
 =?us-ascii?Q?9dMDnLTTWqhVmcieeBQT4Kslhhznbx1geIHuUahj6VJH5L06UIX+3lIqwkvu?=
 =?us-ascii?Q?/6YCfXLemuUdNL9UL6IlSpnJvS2zQQFD8U+c6nOak9oWHuxvdQAOKOHl8O8i?=
 =?us-ascii?Q?de+l8/E0afnC3e/iJlKG40Dymx+Z2wb3MJT/s27rA3CXq4AS84p5qjldWfOS?=
 =?us-ascii?Q?R33SY0eTQlp5+3Tydqx8gKcNiLDTRbA2PLvbjBT3wiqefS6cMAIL9e7st+lC?=
 =?us-ascii?Q?LdHWfGnQphtRP2Sxy6rWetAtiYvDVDLth1O9e7iK9rKaVi/oJZnvCBw7zB2V?=
 =?us-ascii?Q?k8ahkbHlETHv8GCHT6djqv4+q92U3p3/VHTbN/9c8/XQAmqKeg3Pq/fpS+G9?=
 =?us-ascii?Q?5eECwaZgpMRe7WgpI+7HUDOO76aJjimn4lI9I9L5xnouCl2RZy1fP3beffd0?=
 =?us-ascii?Q?bARUi8gYmNgFPaerfVpzgAEKLyWQidXvp1X9t/N5LosvK9fMYFEwQ7AWvYtx?=
 =?us-ascii?Q?KRuS1x/dM+7IZgAR/QUwFNPJJqOy2yjy9Q26zz4r+aZSzfHH5cdtdsgc4x9m?=
 =?us-ascii?Q?aeCNaGBHSH3L3KxqXtDGoNgIU6WhiwplE+B/4/hhDh79vH48Lb6lZBQABpDj?=
 =?us-ascii?Q?MrZPzeee4jubQQu3UsunuSS11Y2pTbdBUAM/Aq2RygvOtEQOGZv3J02pJlTQ?=
 =?us-ascii?Q?QAH6N3c1RQ1np+8DNPPhx7chBiVfcgH4MbU8uufzkMUTmE9vdXqlO8EiXNEi?=
 =?us-ascii?Q?QfOQf/ARV7quIe3ZsSmbd9v5F9boSmGWlDvsexGXtfszM19k8FRwQ7c1bOfx?=
 =?us-ascii?Q?AuFjgIECJO+jNOSEzuwpkZIY+UBXIL4PL8Bwx+0qrJ6VorhUscwbemTioXZl?=
 =?us-ascii?Q?KvIMqRI5aIAoBK1C1J8ND8M4Pklg/5OeU+OOQi54M754/02YRqA3X4iCTWKJ?=
 =?us-ascii?Q?lVrJerFasrJk/RlT207FoRp8hkTccmnvIhYFSs2a5pRevi8mzSd7xOFuEtG2?=
 =?us-ascii?Q?RCBPWc9u2z1eS7A+LE04cG0VpcXq2tFmT36OnC7lMJYc5YgSP6UShVlNQJkq?=
 =?us-ascii?Q?ZCjPjHg+BRZwl18Ub32fUKcLpWQFLJOwUKaci0NQKPeFmJXza5Tcb0V+4DQb?=
 =?us-ascii?Q?WxwiwdjSinN/3Q3dpZCaS9Y7hIjTcD4mFh/6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vCMDbnTKU6dK7Bk6r8naQKyzmmZNYTVq8tQJokWxcw7We5yYicIUNbyxWyf9?=
 =?us-ascii?Q?wK8QOXO2aIfS6LjjBh1itDikCXdUDnLwmRxKwzzdsQBfBquF591xRbV2v6/J?=
 =?us-ascii?Q?qMpal85sTgyiPpngVdZU8rdUjZOXSNxmagLQMK3P43hRLe7rTC68zq/sUtEk?=
 =?us-ascii?Q?NCoI3axBtTN8d2E5BOoUsQnCUBnoynxZi20dJ6wUfBqjfHdMjSXzCz/eEaSK?=
 =?us-ascii?Q?6mBETkbK0kgoRjMabMbsJ15mrTFIPs+ngWLJtz9KQSWCfLKlEHdB0hArv6O1?=
 =?us-ascii?Q?mNWjxgmIHug0pERtrooQ0F4DFkorPGIVPV24IY/KGZRpauTrFKj5Eg+fNqgw?=
 =?us-ascii?Q?CFO0JCniWAMClzk7hiRxTGRoOpwKOj7FYwFuBw41NpJ4XBOjN8Hm2tiymvG0?=
 =?us-ascii?Q?fyOkcTkPrycUnaiTjawX53kW6t2cssn44Rf4h4tBJBMBAHpmuZB6/yz1u+ez?=
 =?us-ascii?Q?YF610fDpLUrIoD3Lgm6orC6bfkO+HzK4+tCkqiQo199wOyhY8jL89b+6BN+a?=
 =?us-ascii?Q?l8QnZ5KSP9MtcN5HUV3cLEGxlYxInRwNQNCh+faBL+R2cxzf+VV/6lV/YG5m?=
 =?us-ascii?Q?fLjjTEjsbJuWImHKZh9nGCEeBhvYAAVXj0xCfeOLQPS1gJJ36BfyKuiBlord?=
 =?us-ascii?Q?DiiY8XgGdrQIyBxgxxTw79GdTG4aPuDSEYm/7bfdA6HPvmDAK/xN4TdVZlkO?=
 =?us-ascii?Q?NlLu/j818rgbR2UfXTKk3FOSb0b0R+AfGOhXVTvuW48e3BbWjg/0fKf+mezM?=
 =?us-ascii?Q?pOaBPICA/bt2j/QdI9fmRIfl46iZgJwwqv8Dsf3Pf9TOQ2UgeuXSklzAdYSs?=
 =?us-ascii?Q?/XytJlXuqWZBfFMRcj7l52t5kXXldOQl5QonbmcC5CaVMaeHpbzu419Ibd0V?=
 =?us-ascii?Q?c4uMQnmoYLEjJ8dBhKok65KGAkqsjj9gvc8ILN3glJFOCq6h/sylG+66X5Hm?=
 =?us-ascii?Q?8VK9gbxKB9zD+0G84eqFn1YUUxIVIUq8Y3sMF5Uhx3fWXDzbCma/lRzIzFXv?=
 =?us-ascii?Q?sGHyrQBr7kjvmkjwg32yKOpWkUjfMC6BQIe1jiRAmxezSa0JoUygCG4audfe?=
 =?us-ascii?Q?S7GR9M4EVKDROvVRdtp7CUUYkR9qUd7OgwJckdUuxp6QqmOep6h5C49ZyjzH?=
 =?us-ascii?Q?Vk2fFhdlYRJgpTxtA/iolQHEceIBlN5Nz54TPZSNzGyRIAB4W9IDcnjxNmy0?=
 =?us-ascii?Q?jJMqdVo68MAdIIXdiKuA03E2r5SH3iDHGRp+97b7CcCbAqqz0rflN/Siz1Q2?=
 =?us-ascii?Q?aAdPvVGLq8L6tby+VmACnbLam68Dh9rlzyFc/KqJURhASm3Kcqafo8ZUJepg?=
 =?us-ascii?Q?AEngWPd1cidRvhKHI65f4J4gAQmOwDV+/bzvBYM8lXAVZsx5EFWJvUxHaFyj?=
 =?us-ascii?Q?dwYitkoeKdVv0cn6xYil0HN1PhuiZX8pn+kuEl7HauTq1l7yt10DEk9Ops7S?=
 =?us-ascii?Q?H2lOnt4Ea1pR23L4rKW4WgIjVuIGTSyALR5HJqO/6u1QnXzR/5sKQXd9TRlE?=
 =?us-ascii?Q?2d+8fzRMXu1diXORn6T/IvchzBFFtpmv4GGOwkcO7E03AnvzxMWaJJYiI4US?=
 =?us-ascii?Q?39Fc09fsYeii0VR9kkdP+ZIVk6DSa84ERIW6Z2nM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77423b04-d898-4a3b-83c9-08de1c58edcd
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:49:01.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eH4KbDcK/SUb/0iP2jPt0venE6+G5xu4bIOYqEHtipjzZAoHRAUcAc0JiS164+GA/lVbiGDHsk7/gn647Pz3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9293

Introduce 802.11ac feature support for both client and AP modes,
with coordination between host driver and NXP firmware.

- In client mode, the firmware assists the association process via
  HOST_CMD_802_11_ASSOCIATE. The driver converts 802.11ac IEs from
  cfg80211 parameters into TLVs and appends them to the host command.

- In AP mode, the driver converts 802.11ac IEs into parameters for
  HOST_CMD_11AC_CFG, which are then passed to the firmware for
  configuration.

This patch adds logic to handle VHT capabilities, operations, and
operating mode notifications, enabling proper negotiation and setup
of 802.11ac features through firmware interaction.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 289 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ac.h |  33 +++
 2 files changed, 322 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..93ecd34180b7
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11ac
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ac.h"
+
+/* Tables of the MCS map to the highest data rate (in Mbps) supported
+ * for long GI.
+ */
+static const u16 max_rate_lgi_80MHZ[8][3] = {
+	{0x124, 0x15F, 0x186},	/* NSS = 1 */
+	{0x249, 0x2BE, 0x30C},  /* NSS = 2 */
+	{0x36D, 0x41D, 0x492},  /* NSS = 3 */
+	{0x492, 0x57C, 0x618},  /* NSS = 4 */
+	{0x5B6, 0x6DB, 0x79E},  /* NSS = 5 */
+	{0x6DB, 0x83A, 0x0},    /* NSS = 6 */
+	{0x7FF, 0x999, 0xAAA},  /* NSS = 7 */
+	{0x924, 0xAF8, 0xC30}   /* NSS = 8 */
+};
+
+static const u16 max_rate_lgi_160MHZ[8][3] = {
+	{0x249, 0x2BE, 0x30C},   /* NSS = 1 */
+	{0x492, 0x57C, 0x618},   /* NSS = 2 */
+	{0x6DB, 0x83A, 0x0},     /* NSS = 3 */
+	{0x924, 0xAF8, 0xC30},   /* NSS = 4 */
+	{0xB6D, 0xDB6, 0xF3C},   /* NSS = 5 */
+	{0xDB6, 0x1074, 0x1248}, /* NSS = 6 */
+	{0xFFF, 0x1332, 0x1554}, /* NSS = 7 */
+	{0x1248, 0x15F0, 0x1860} /* NSS = 8 */
+};
+
+/* This function converts the 2-bit MCS map to the highest long GI
+ * VHT data rate.
+ */
+static u16
+nxpwifi_convert_mcsmap_to_maxrate(struct nxpwifi_private *priv,
+				  u16 bands, u16 mcs_map)
+{
+	u8 i, nss, mcs;
+	u16 max_rate = 0;
+	u32 usr_vht_cap_info = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_AAC)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* find the max NSS supported */
+	nss = 1;
+	for (i = 1; i <= 8; i++) {
+		mcs = GET_VHTNSSMCS(mcs_map, i);
+		if (mcs < IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			nss = i;
+	}
+	mcs = GET_VHTNSSMCS(mcs_map, nss);
+
+	/* if mcs is 3, nss must be 1 (NSS = 1). Default mcs to MCS 0~9 */
+	if (mcs == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+		mcs = IEEE80211_VHT_MCS_SUPPORT_0_9;
+
+	if (u32_get_bits(usr_vht_cap_info, IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK)) {
+		/* support 160 MHz */
+		max_rate = max_rate_lgi_160MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 is not supported in NSS6 */
+			max_rate = max_rate_lgi_160MHZ[nss - 1][mcs - 1];
+	} else {
+		max_rate = max_rate_lgi_80MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 is not supported in NSS3 */
+			max_rate = max_rate_lgi_80MHZ[nss - 1][mcs - 1];
+	}
+
+	return max_rate;
+}
+
+static void
+nxpwifi_fill_vht_cap_info(struct nxpwifi_private *priv,
+			  struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_A)
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_a);
+	else
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_bg);
+}
+
+void
+nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			 struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 mcs_map_user, mcs_map_resp, mcs_map_result;
+	u16 mcs_user, mcs_resp, nss, tmp;
+
+	/* Fill VHT cap info */
+	nxpwifi_fill_vht_cap_info(priv, vht_cap, bands);
+
+	/* rx MCS Set: find the minimum of the user rx mcs and ap rx mcs */
+	mcs_map_user = GET_DEVRXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.rx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.rx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.rx_highest = cpu_to_le16(tmp);
+
+	/* tx MCS Set: find the minimum of the user tx mcs and ap tx mcs */
+	mcs_map_user = GET_DEVTXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.tx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.tx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.tx_highest = cpu_to_le16(tmp);
+}
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_vhtcap *vht_cap;
+	struct nxpwifi_ie_types_oper_mode_ntf *oper_ntf;
+	struct ieee_types_oper_mode_ntf *ieee_oper_ntf;
+	struct nxpwifi_ie_types_vht_oper *vht_op;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 supp_chwd_set;
+	u32 usr_vht_cap_info;
+	int ret_len = 0;
+
+	if (bss_desc->bss_band & BAND_A)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* VHT Capabilities IE */
+	if (bss_desc->bcn_vht_cap) {
+		vht_cap = (struct nxpwifi_ie_types_vhtcap *)*buffer;
+		memset(vht_cap, 0, sizeof(*vht_cap));
+		vht_cap->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		vht_cap->header.len  =
+			cpu_to_le16(sizeof(struct ieee80211_vht_cap));
+		memcpy((u8 *)vht_cap + sizeof(struct nxpwifi_ie_types_header),
+		       (u8 *)bss_desc->bcn_vht_cap,
+		       le16_to_cpu(vht_cap->header.len));
+
+		nxpwifi_fill_vht_cap_tlv(priv, &vht_cap->vht_cap,
+					 bss_desc->bss_band);
+		*buffer += sizeof(*vht_cap);
+		ret_len += sizeof(*vht_cap);
+	}
+
+	/* VHT Operation IE */
+	if (bss_desc->bcn_vht_oper) {
+		if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+			vht_op = (struct nxpwifi_ie_types_vht_oper *)*buffer;
+			memset(vht_op, 0, sizeof(*vht_op));
+			vht_op->header.type =
+				cpu_to_le16(WLAN_EID_VHT_OPERATION);
+			vht_op->header.len  = cpu_to_le16(sizeof(*vht_op) -
+				sizeof(struct nxpwifi_ie_types_header));
+			memcpy((u8 *)vht_op +
+				sizeof(struct nxpwifi_ie_types_header),
+			       (u8 *)bss_desc->bcn_vht_oper,
+			       le16_to_cpu(vht_op->header.len));
+
+			/* negotiate the channel width and central freq
+			 * and keep the central freq as the peer suggests
+			 */
+			supp_chwd_set = u32_get_bits(usr_vht_cap_info,
+						     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK);
+
+			switch (supp_chwd_set) {
+			case 0:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 1:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_160MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 2:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80P80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			default:
+				vht_op->chan_width =
+				     IEEE80211_VHT_CHANWIDTH_USE_HT;
+				break;
+			}
+
+			*buffer += sizeof(*vht_op);
+			ret_len += sizeof(*vht_op);
+		}
+	}
+
+	/* Operating Mode Notification IE */
+	if (bss_desc->oper_mode) {
+		ieee_oper_ntf = bss_desc->oper_mode;
+		oper_ntf = (void *)*buffer;
+		memset(oper_ntf, 0, sizeof(*oper_ntf));
+		oper_ntf->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		oper_ntf->header.len = cpu_to_le16(sizeof(u8));
+		oper_ntf->oper_mode = ieee_oper_ntf->oper_mode;
+		*buffer += sizeof(*oper_ntf);
+		ret_len += sizeof(*oper_ntf);
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg)
+{
+	struct host_cmd_11ac_vht_cfg *vhtcfg = &cmd->params.vht_cfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AC_CFG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_11ac_vht_cfg) +
+				S_DS_GEN);
+	vhtcfg->action = cpu_to_le16(cmd_action);
+	vhtcfg->band_config = cfg->band_config;
+	vhtcfg->misc_config = cfg->misc_config;
+	vhtcfg->cap_info = cpu_to_le32(cfg->cap_info);
+	vhtcfg->mcs_tx_set = cpu_to_le32(cfg->mcs_tx_set);
+	vhtcfg->mcs_rx_set = cpu_to_le32(cfg->mcs_rx_set);
+
+	return 0;
+}
+
+/* This function initializes the BlockACK setup information for given
+ * nxpwifi_private structure for 11ac enabled networks.
+ */
+void nxpwifi_set_11ac_ba_params(struct nxpwifi_private *priv)
+{
+	priv->add_ba_param.timeout = NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE;
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.h b/drivers/net/wireless/nxp/nxpwifi/11ac.h
new file mode 100644
index 000000000000..6fc72fab251e
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11ac
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AC_H_
+#define _NXPWIFI_11AC_H_
+
+#define VHT_CFG_2GHZ BIT(0)
+#define VHT_CFG_5GHZ BIT(1)
+
+enum vht_cfg_misc_config {
+	VHT_CAP_TX_OPERATION = 1,
+	VHT_CAP_ASSOCIATION,
+	VHT_CAP_UAP_ONLY
+};
+
+#define DEFAULT_VHT_MCS_SET 0xfffe
+#define DISABLE_VHT_MCS_SET 0xffff
+
+#define VHT_BW_80_160_80P80 BIT(2)
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg);
+void nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			      struct ieee80211_vht_cap *vht_cap, u16 bands);
+#endif /* _NXPWIFI_11AC_H_ */
-- 
2.34.1


