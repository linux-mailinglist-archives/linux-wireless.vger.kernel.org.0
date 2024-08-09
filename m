Return-Path: <linux-wireless+bounces-11178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7244594CD85
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF33DB21F08
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA29191F97;
	Fri,  9 Aug 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h6ztb8Om"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF54190686;
	Fri,  9 Aug 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196760; cv=fail; b=FK3mip7XHB2/fSD32Hjf7EWws+DoMWqKTW1KfxanWrKhwuLW+bys5ogYPJlxuo9sCrT+LcigqtFhelW5Np5AGIOGeGVgc+WchaJuvEzPgMz8bJFYA7SpMFpad9XeBkZczns16nsfOoOYDDR/+m/kjDNWwWIPn2p/w5vvyri6vYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196760; c=relaxed/simple;
	bh=9E2BYEfAdC67ORWe04zygWegf4t9949M8HjL+v3qQQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WjrDvrorSbbgz9jjJeIgIlNVja2EJxk05b+P6t3RNlfuFXby/Q3ntqEO709/tdmUuohi/X18J860Zt9QrEYEuzviBaoQGoeKCryiMCGgxd56r0amDQrE+nlo3rVfbDzH0eNcibodrtikwg1PRODWfaSqCgB9ZsvvzZnFd3AjrJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h6ztb8Om; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLJDIrISAl+IoN0D/n3ppgYZpWrpI/8VvychYJDzM0DazpWVFSf5xVtpbSAZeAiV7DDEwPfxbcvmckgkEoBmzBSlceBP8/K7+5TXRkF8Gu2v4tEG+T3H6gIr7bjgTmMXPLaOKABLcwSuJ0ZRsN86VjB883d1Lak3/YP4+iHTl06xB0XILpn9TOfAYjLuFRkbatYLnoDc4PFeh4qNn6TWKqOUxgI/7y9Spi+3vbubS/tpqUnu+hfhnZaBU840Iicp0BSd/YRYamL7JLzhmbr5oFYn6bp3b6HsL+sT0bmd6UIk+rzrWC2NbUdS3Ca/U7TlEOJvQ+YSmIBEyse92poevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+uZVJH/d2Oae4ido2ZVWKaRgeVGcwCwV3uhdGhhGKA=;
 b=HqqwvmIIUtiBnmkvvWkWVNo8PnMKP53UTgY61A1bgV+JBqR8jVoenwl/1tiOlXtREijtvI/WRkonq35KwHGra/Zit42ySL0VfCSoKtwYqZ8SBQH66nMj2Ktv3CD2U7Ht5t0jKedzaR/KHas28MWV+jhOm1HbCcPfBcE2Lrn+ANAlNnjqlT0ubSE8nbfL69LgL6zSSsV9wR7G5V801ExBIk9U42tXme9Rtujk9TbVX9/Rs1Sn5OdR/9xa0m4enc+uqdY2b+cLHMRTqR/76Cuk/Hpcb62DQKB3/X503POvd7Q0xYRCTgVAibBmrZE/9Zx+Q5Tsz/8TornqAObtdeAKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+uZVJH/d2Oae4ido2ZVWKaRgeVGcwCwV3uhdGhhGKA=;
 b=h6ztb8Om0zbofPsBPStiDw9J5xgDoxvZiG6MwxrRq+wwMzRs93apDXwavda0OtXY/Nda6b2Er02u+xtszePQxrZBzFJyi19Q3RZqrfh4izhcM+4vI9HMZiNVnhncP59W58WKQ5+GB73MpZMX3iXLlTCOeGmdd7G7fdh0FBCY+98nq21cibKhxgMD4817b5bazn9DmbdJ1hk84tTfzYz4/NYrNYsn1UP+c+R61QrX5eCSVPY7zwl6uvaBrdR2Q/y6MXzvw3TZbIglNllDQF0PdretHxXTeIFLdWLpa2BijBpSzbyWCrNx0kZpUbfWBWBDX5OyM0VzcB1loE5vm05+GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:45:53 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:45:53 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 01/43] wifi: nxpwifi: add 11ac.c
Date: Fri,  9 Aug 2024 17:44:51 +0800
Message-Id: <20240809094533.1660-2-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 01753177-e374-4cf0-2a00-08dcb8580f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xWW0ShU3mmPEkM4NFSnLH/2Vmt432U8UagqUeaARQeWEq1hnmvfNDlTUDzyk?=
 =?us-ascii?Q?kK++RAsyDqtiKk34AjgZ5JeROOhirUBivxE62Zw97CKnGa80ZV1myz7H90e5?=
 =?us-ascii?Q?gsTNXhQS/VEYvdT+WI0zTTIZC68bLpNgSlxKbYh0Khvcms+q10IkT+/ZiX30?=
 =?us-ascii?Q?bBQxtyxDfqgeMQhS1QOsfAURlSQVqKgyFH2S8i2wfobsUpECR8CBQqxrqJD0?=
 =?us-ascii?Q?28UoC+KAkPazD9+XYccN7oE89H2gRFMDhv+rEEj88kEbh9g4Yxt2ZvgXS3si?=
 =?us-ascii?Q?EJVLthTvgkdd3IaAuIaJQQoOGMUCX/s645A6RHzJrJKKeKsmrOUo8WmaB3Lr?=
 =?us-ascii?Q?kMbtQVRjRkSNKH2Fcc7iaAQ3tQoxxToA5aKgfO4y/WPzTBHMJzAp1900g0xW?=
 =?us-ascii?Q?/EHKj4JlUI1+FHLWrwapmIqN/6vvhbSVuIRABoo/tDXjc0Qb/LwXVmZWD+7S?=
 =?us-ascii?Q?SOEFsizzyHhIgOqwDIzU4K7Q5wl2u0ubwl6+q9E30H3N5dURu6mlQfiQxRwF?=
 =?us-ascii?Q?on2v7q0mHY/L86PqqojD/KwHi17g2JONErIQonrElNBbd/ukT0JYYDfw5SLl?=
 =?us-ascii?Q?Xp2tX2TTydb4ZMp9s5xOlB2KnshkHTIL0ahb6kj40KZxMU2lkg9XZv8wFwrH?=
 =?us-ascii?Q?8VIoA3NemaNV9o/sZ3WFmHinty4BIypFiQ/72wWFGtGky6Fg98zStniv4qg7?=
 =?us-ascii?Q?YIfjp/97lQOtr7L3GME3EjS8hp/18Tq3yZgEmXzpoTnXz77hDj7yse9lrR4p?=
 =?us-ascii?Q?ICk0mb2nUo7w8xy8RuX/UZqLW+yg6VFpqcW/T83jhmHX8pxR6RfipH5YJCSR?=
 =?us-ascii?Q?2BXuaYoKYna+3pjMloXPpgsnngXWi9lAxodX573eTFdQM0JPNGi8MqWpMMZn?=
 =?us-ascii?Q?oWBlOlOElbCW+OVfV/xVOIzKWgd/WY199/UM9AZ49XUh9/2r1Pk8ep4GUnm/?=
 =?us-ascii?Q?Pne4CRkOtWpFkKC5lYlTVMroqGhmdQ0ri7Lz37aQp2/k9Ua+evzExiigCFHw?=
 =?us-ascii?Q?PLJSBW6BoNRkDP+s6ClFGigb+C5tJa+uG95qoJ7PuxDWhoWrgDnTVwEfDtQf?=
 =?us-ascii?Q?XZcLiXz6IhPaPth0okLFz5Zz0Ifo3f/mkGVrKGGHrB6iJAJFc54i1r+g/D6C?=
 =?us-ascii?Q?IItoV6SBXxmkFGDpiA9cV4eVXTSwnpDpdKmYgdFYwPar1inWlTGjjuzz1aI8?=
 =?us-ascii?Q?wIXdfmr1qfv8zSSkQfU1yGcL7g8fIfuA4krqOvgO9XWWo8Uu5JXbfEKT6/dt?=
 =?us-ascii?Q?jXjrkIYcDU7NEhHrgtJh6oHB6wv7He70tZ7zIVy7+ufQoKOyuR/CJVfZfPvx?=
 =?us-ascii?Q?rvmaMYb0h57fyGTZL63L1PR76dVlhDvdNOKM8dOTaFRcMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ETFzIwb3k12bpzWFaRV/zkP5864rXe2yjhSW1GfG07xlagEuBb5U3t7Rex5o?=
 =?us-ascii?Q?IuvfmSGoV3iR+W2JqKgD8UvunRQlkSfvbwcL7szp68LjEzVQ7hmXBdATUZ9O?=
 =?us-ascii?Q?dV5ezb0PNlbqoKHG4dcA67Ksv+cWFTwsQ40Iy+BBuvQrlROI35OhhjvqblX5?=
 =?us-ascii?Q?U1OwLEUzz2rIUlUTVb2u8gsttQD0CMBjsUcbfGHbYgB3LKWaHQS+gVQjvlri?=
 =?us-ascii?Q?7DZSrW6aV7HaqPlI/SfBU3403i7BRBecxFzrEHj85iZw8TBzTr7VwndEzMYO?=
 =?us-ascii?Q?PX4N4046PZjTbDq0PTWqcqhd56uQJMfxJWhSY4KaP8cvJ3ge74Mo3T5ZlA83?=
 =?us-ascii?Q?1LKVVAa+aOMdmrFMQlAXq3tf+G4RD4dKru1c8sCRnibcVndTeT+2UMyQixVd?=
 =?us-ascii?Q?EDBEdYTZDkOFtPeW1CQz0O/0129Aafmp+xhvsyLpQsz2iFh9nk4Jlbp8cvhv?=
 =?us-ascii?Q?EOClmfSOvWlgcjacj/kuNsTHwSSbv7aN8gVZ/AH74JvGwgXm/CsWijgTZUsM?=
 =?us-ascii?Q?kgbRp5LZVZWd0EdqM1CiLxUsNfbcJspD5vqRllB5L1s992MOOQoj6sRVIHAY?=
 =?us-ascii?Q?D9wHiCFrCcFEwFASGTYUvxtOiKAa6u0spvsIH7lWCbmhJC030U6XpvYOStwc?=
 =?us-ascii?Q?LYjcr6lmiPeEcgAzqHVldAEx4bvyH/DuGUqQTxgBkmlHBptdZdsQoFQzY1wq?=
 =?us-ascii?Q?ujRmuF0Atda/XxZsHOSLa+s08Y8zVzf8ctb10vteBZpafBd5Yg2vjZs2V9vF?=
 =?us-ascii?Q?pZDMNLiCOKl81iK/UNPH05dPNwLd4Le9ikSH/rXjHc/M9CbsIv8nF4C9Mdtz?=
 =?us-ascii?Q?2QFhR3GuTXLGly0MJ4WyPl3szYR5bXJIdGC4Ux9g9cACnJSwksnYOwwKeQy5?=
 =?us-ascii?Q?NKlp8odPh6UIZAPPHfuZqgixgTH3BFVniOTHbhUUMuS69eX7bXO8fete41qT?=
 =?us-ascii?Q?x2ACLlOZJjwZA8cCUjJoDT4am5LVg4SJIFvlO4aenWvoQ35Yy6WgtdthvwF9?=
 =?us-ascii?Q?hLyVh08lRim17GjNzztfWQQSs8aLsSkHBfFbmegUZB4+W/7UXf08/No03lRa?=
 =?us-ascii?Q?LW2Aw0bjR15SxtSs97jUBTk2uW/leFzSU0ptKzqiSklXCVsOGROtegisUss4?=
 =?us-ascii?Q?kB7skfqs4W6vsYc1Hzo+Bl4aYnnH94RJX8BVHjTMTq8apr8ZCVo0px/14u8q?=
 =?us-ascii?Q?y85DAHxVZq2GMueUWfEqNz/b0/n0AFVO7pHLB8euOPHyN2UHPNXBMGbQaqEu?=
 =?us-ascii?Q?UwN9AZGibAzOA0ZtmEe2vguJEZqUVsGSD6Udut63yybSyv0ZSWqbPedP5Jq7?=
 =?us-ascii?Q?7x5YBLP6SnI72IzwYDLTRi85eTz1cDzS3x5o/iQMvQuMgInqGuyhgsjJbTfQ?=
 =?us-ascii?Q?1qI2O90ow+dHIneiodwewPOfDFGYXTn8Zr8gazZ223qRxwRtvsSgQkTIM7Fh?=
 =?us-ascii?Q?f6L/o4czV0LLMGj2kXRk9Ek+UGfWe44neQnSYefZwPgi0QWQ6yIJR8lsmLo/?=
 =?us-ascii?Q?QFaVvAwNJuV9GaYqx/amxd6EAaelkjgB1cyz0kRBDHp4EwJlf981QO7bj5Ff?=
 =?us-ascii?Q?4Y50HzcnwfiwFdF99BZiG6ep2zhZhJrVAQKYc7b/+dcT0kG7ZBu9eyWS5LrC?=
 =?us-ascii?Q?f1HgcnWy3s00JfwuyKFT2mKwIgTvyiGavpJwTgO8Qlzh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01753177-e374-4cf0-2a00-08dcb8580f39
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:45:53.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyzzIMIE6MWjg34lkuij/ovDu4OwUZGxKuRst94zXcCnPBvtufFE3rIGEmCusYnicQjV9+DB+nJ4E5jWvyI4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 366 ++++++++++++++++++++++++
 1 file changed, 366 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..514af3b92dd4
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11ac
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
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
+				  u8 bands, u16 mcs_map)
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
+	if (GET_VHTCAP_CHWDSET(usr_vht_cap_info)) {
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
+			  struct ieee80211_vht_cap *vht_cap, u8 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_A)
+		vht_cap->vht_cap_info =
+				cpu_to_le32(adapter->usr_dot_11ac_dev_cap_a);
+	else
+		vht_cap->vht_cap_info =
+				cpu_to_le32(adapter->usr_dot_11ac_dev_cap_bg);
+}
+
+void nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			      struct ieee80211_vht_cap *vht_cap, u8 bands)
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
+				cpu_to_le16(sizeof(struct ieee80211_vht_cap));
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
+					cpu_to_le16(WLAN_EID_VHT_OPERATION);
+			vht_op->header.len  = cpu_to_le16(sizeof(*vht_op) -
+				      sizeof(struct nxpwifi_ie_types_header));
+			memcpy((u8 *)vht_op +
+				sizeof(struct nxpwifi_ie_types_header),
+			       (u8 *)bss_desc->bcn_vht_oper,
+			       le16_to_cpu(vht_op->header.len));
+
+			/* negotiate the channel width and central freq
+			 * and keep the central freq as the peer suggests
+			 */
+			supp_chwd_set = GET_VHTCAP_CHWDSET(usr_vht_cap_info);
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
+					   NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+					   NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+					   NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+					   NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE;
+	}
+}
+
+bool nxpwifi_is_bss_in_11ac_mode(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_bssdescriptor *bss_desc;
+	struct ieee80211_vht_operation *vht_oper;
+
+	bss_desc = &priv->curr_bss_params.bss_descriptor;
+	vht_oper = bss_desc->bcn_vht_oper;
+
+	if (!bss_desc->bcn_vht_cap || !vht_oper)
+		return false;
+
+	if (vht_oper->chan_width == IEEE80211_VHT_CHANWIDTH_USE_HT)
+		return false;
+
+	return true;
+}
+
+u8 nxpwifi_get_center_freq_index(struct nxpwifi_private *priv, u8 band,
+				 u32 pri_chan, u8 chan_bw)
+{
+	u8 center_freq_idx = 0;
+
+	if (band & BAND_AAC) {
+		switch (pri_chan) {
+		case 36:
+		case 40:
+		case 44:
+		case 48:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 42;
+			break;
+		case 52:
+		case 56:
+		case 60:
+		case 64:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 58;
+			else if (chan_bw == IEEE80211_VHT_CHANWIDTH_160MHZ)
+				center_freq_idx = 50;
+			break;
+		case 100:
+		case 104:
+		case 108:
+		case 112:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 106;
+			break;
+		case 116:
+		case 120:
+		case 124:
+		case 128:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 122;
+			else if (chan_bw == IEEE80211_VHT_CHANWIDTH_160MHZ)
+				center_freq_idx = 114;
+			break;
+		case 132:
+		case 136:
+		case 140:
+		case 144:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 138;
+			break;
+		case 149:
+		case 153:
+		case 157:
+		case 161:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 155;
+			break;
+		default:
+			center_freq_idx = 42;
+		}
+	}
+
+	return center_freq_idx;
+}
-- 
2.34.1


