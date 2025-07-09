Return-Path: <linux-wireless+bounces-25011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3194EAFDD6A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2FF1C27A6F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A09213224;
	Wed,  9 Jul 2025 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eR6xr421"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013025.outbound.protection.outlook.com [52.101.127.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB72080C8;
	Wed,  9 Jul 2025 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027822; cv=fail; b=ors+9J/P8Tetf15u1lAQ8d1TB9WTOZsZFPMe6SzuNI5RCsgl1bUqtrQ9K2O8uA1qkC/p6SS7oVyjxk3z2c9tLF2rQT33CPDMH72zCHsMHNHERpsMel5KEkwnAWRUM26M8H8re7dXmrqSF2CZ1V1TN9zLbYfQx+br+a/24fdZY14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027822; c=relaxed/simple;
	bh=0tL7CwnBoCVU+7464oVQ5q6AYRdbHetE4vFeZgMU+KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QMHVKn+oHfmA1ZEz+//A2zIqv/qRlmk4sKxm2QQ4AnpEsirWfm6HYz15FY+bWiW5pY1LJ6hXX1PXEjxdhmfDItFwxmv6m9CopvJp/nKO/0VIcL33gDwTEqG/LH3EOPcynpCuwDxtxBDuuUCc9aa21cSf44vjbDbLcXgEvBnMwus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eR6xr421; arc=fail smtp.client-ip=52.101.127.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/kBDbrOhRCd3TOEYaqUbKj0ysyuON9ASO01djy0YucJ88N3WzbT0b0GTPCi+MczpB68refDmuklNUPmhP09gdJzp61+ppaP25+3VmteFCdlKCdndlzWQv3RFTfRknkjpCq6eSvVbiGAjoQgDrSxTvx+vaNykhGqFdJ8xie8fNHT/FbS2OZaz0IfSdWYddamJap5ZASm3DZUbqjCWCNqZzCRsx0nv/bQEGbQYbnoqzj9wX0P4FRgY+p44fbTt71LjHxAnCWxNyu17odTNxqpmjASoSQo74jO6JTuL0c/swmJ9c8nKF2bJ5PFvs9iGE160sBZPhpenyyuQdRmJuRlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXPTVUYjR3F3aOhIywWlT2woittUXY5OWpjbgXLAWiA=;
 b=T4cB/tu0jXnITFBuZ0GKk3USXb/1+qZ+HN25ltB5k3C1JEMK7QOEN6i9fdH/zsOHv03ljPNHop2OuxWRBNowTtReLcnZfa3S0wR2fujKWUCDL+aAWMPgvLmwRWH4tgfzP0BB+XGQBfvddImolQpNUX9sfNCGVLZxYw4RpqK1nnYYsR6LX/4Lrl3zwo1/SalfiXqqc/7zl4lx1atSgEJg7RyX8Z2CWs24St0gFaqT4/Os5iAmL7SRc7BeCWNb+qRkAyBZ5g8AWC7QUSJcU0Wc0Dn6ig1qFn2vUlsp3MHtWxTgLJNfFHmt6LMN2cWXF5phlqj5X4kqTHNWr4Y8PfcERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXPTVUYjR3F3aOhIywWlT2woittUXY5OWpjbgXLAWiA=;
 b=eR6xr421HaXGEskFHvPUrWc6Xj+02Acy6HCgU6ChOhuy52KtCVPxZlcJizxj/II29EHv0rJPGqhXEQmVPlRfBEIW3n41OeqZxuL1qqYqAWjrutXjykjUHOpzqmomRPSbZ47uyTzushbfgIFE+/69s7rfKfoPkGq2oq2As8OlWADO8ASQeVVxBnZDmOFwpg9Qn6hI8upYMRKjyYAKB75jVnAsmarKclql+01VLtHjWM5Ht5yX0twZOsVIH8fyEa1+FB/4euINqHr3IXRKgOcVgVVW8T4j9NRaApxpWPH2a5aBOLlGJJpW0JOlNb3U5oEiPavoo4JeQ4xMbKULkpmjaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY2PPF4597475D5.apcprd06.prod.outlook.com (2603:1096:408::78b) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Wed, 9 Jul 2025 02:23:36 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:23:36 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org (open list:QUALCOMM ATHEROS ATH9K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 08/12] wifi: ath9k: Use max() to improve code
Date: Wed,  9 Jul 2025 10:21:36 +0800
Message-Id: <20250709022210.304030-9-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709022210.304030-1-rongqianfeng@vivo.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY2PPF4597475D5:EE_
X-MS-Office365-Filtering-Correlation-Id: 75eb940f-6be3-488a-3394-08ddbe8f9bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?liTVVSlf5iCHFl4Oh4n3OeNHL5NmlO8RSOspu3q8fAMPOe7kM/A/sJ1Xjj0k?=
 =?us-ascii?Q?EslyE2Ts8lDzNoBLXSYN/KSJ/qF7dZnMOwygwmZg7RHt4XCbWspNVrSewWDr?=
 =?us-ascii?Q?RB2oYfs+20krlBl+wPoJm8/e1YqiAqqCxuHiteU2c9BFj6Z3mF1muGvDoXrg?=
 =?us-ascii?Q?05u2YBrGYT2fM9xK7q1uCSq0/4I5hwdk5BmQfHF5uIc7rjJERAS3I4Az2N+5?=
 =?us-ascii?Q?JM8KC08aF6QV+lGMIrNPB/jsY6Hi8b4nSvCb4SAjroZgqMW3iapFw3NXEiHB?=
 =?us-ascii?Q?xBtR3ng+fZWrrnSY1bfe9FA1tXno+GjUy8dW/7weDaYYTrExEOaaDDZfS0SX?=
 =?us-ascii?Q?WBqhMFYLhFxZxRDiS2FrZsCHBFRBvome12L8wf+q4jv7Oha89XSxXonRUXIm?=
 =?us-ascii?Q?v0kB3sPSAXWzw51XRxtU96Mm04ObSIpxju66MMD+jybkdhpky9iE+zXlkDLD?=
 =?us-ascii?Q?4cesabIFT+4HGVPUyv9W1EJJooE8qpJFfxfRgfJS5LgU28Tz5qQzz/v9fO3j?=
 =?us-ascii?Q?R3byhAQLmATnNnLpqA2andnkkmYulxiHwc8Fhh1JFtEukpZOXGMHMzypmtF3?=
 =?us-ascii?Q?sBlULzk+pA/UUWktb7O/zp0PPlDlY6FNmQ7iXzEJNCXlEIobaZDFWd8YwCIb?=
 =?us-ascii?Q?yN3bMcWPX7l8ZXkgKrvJg+px24Q5ra63+ya638hucwTJXXKo5Ybbdntc1I+H?=
 =?us-ascii?Q?BopN+GqnMObLyWMIESoQ+91MfWqSgK7YbBEcp5KclXLkVzEIJSIdEkRsUg9x?=
 =?us-ascii?Q?/tNL6QPBDAIsDPlV6GZHHTqMUJgL+PbNW6CTGu1pqZJGCo8PmVHLYW2j4G48?=
 =?us-ascii?Q?sJfKkB119cEgYWT8D44wIylTSg8vJ8dj29+8aWByCXa9sYVBcE81YpHkVf5Y?=
 =?us-ascii?Q?ahRP9JPB5i2+0XGqwctrrUAvSL2uXnFYACOFriFbdJcsgvIfiLmqsUAZgccq?=
 =?us-ascii?Q?SdycQCG6bcRYcdzgtolV9VBkhwWR1Tx6yjGOAfYhTxJbafOj0XJiztUrVWgS?=
 =?us-ascii?Q?bFoTc/+7pAu7qZs7dRIBkvbgY3JP0VOvfsg0RWiszJT8sR1u/WsL/d5O/+QI?=
 =?us-ascii?Q?JUzAdpRQwF0o//PI+7bGDO5ptE3/DxKUGSvSFO5Cpc+iOiEmHth6R34dktJG?=
 =?us-ascii?Q?+RlBXorReCzgM6/7ZGuMjHl/SpW4CUQN7Z3L6taVQHwb8+qvA1L38+/ra0AD?=
 =?us-ascii?Q?Otagamdm0+sJO7Kmjap9l0rk/i6Z2BgdrsgJ8HnuMiXAoJA/PJPML0g2GFVB?=
 =?us-ascii?Q?cEJlfkTWE6Cp4Iyhsg/OJcG0xeEQPoYhnW6Q6pBclVcNhrJpFk4bBisZsOLC?=
 =?us-ascii?Q?Gd6lXfzK/Bo2Zwyizd0lH5pkcrEn38I5qpbovaqBUTM4i6eqAMjQGKaCXhgI?=
 =?us-ascii?Q?6SM4rC71yoPFIagxiL+mC2fnCdXN0/XIdleGcuY8z5kefIOx4FUJ8iITWXHX?=
 =?us-ascii?Q?wKjkGfm1DB/+RL1up80PtvFW3zYOzWjGOYBtGvqRHrGJOwwadZYIqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h4yaEB58runjBV7oKFtBk6/hn7ZLeZKXXmgoJRGisrlzMYjn3AERCV80ycp8?=
 =?us-ascii?Q?z1X6ZImsjaBlz9j4csN99xX+PnkZZkqNSWq5qM4MypaNP0Hq8up3MiwmrhLC?=
 =?us-ascii?Q?aIhOf79YNkHUKUU0OvdfhBYyze6h2NBtbd+1M5zP73AXlRQ5oReB3CBx2iVG?=
 =?us-ascii?Q?25+2NZE6sQ0OMKB2Goo09Fml5FgUn6dxZ4Huj1meULJ9V/dBIGD9jrPA51YK?=
 =?us-ascii?Q?oKPHnWP+AZ/g2eiBsuGDJzk7ROBqPoWVLD4Pc3nKxNyLOTVwzTcxPrsl3+Bk?=
 =?us-ascii?Q?lOrAtlOhiYpezcQPZFtDCHILheNEc3bFimMhrpquYUWQ0QAdlrUANiSLvFlP?=
 =?us-ascii?Q?GphpKwAbJqgTUzPOQkLKImMD7h9mFstdr3AgoVhVep/Tx5xZYPPhHyfaBkQW?=
 =?us-ascii?Q?A7xPynwmVSHBy8lF6rEMOlqvzBEB7VN4z070+aGmxC5GZGEP2vK4acJDcuu5?=
 =?us-ascii?Q?8bmk1rte+tZojAOGT/503wJl+4JrkUzo82j+ym3J0vCuq67yF9dMeUgyTw6I?=
 =?us-ascii?Q?YDGeiTgvzEBpuxR5QUyU6oX53h0Y/LPgGzhrcuCN3ZR+OKAJm2d5LTHGzgM9?=
 =?us-ascii?Q?OlxwOtOo3ZHR4+vnL9YYWwqApiXjZ+CD0VXKl37U73Ujhbi3Zdm1vlmfWBwi?=
 =?us-ascii?Q?XtcG+AVjw16LMyCBspPgYAuDGWeoYs0SWVa7gfcil1um/cba0P9HZEbgTeiu?=
 =?us-ascii?Q?lh/cB0kKkDr5/Je05N3EbDkvIfncl5oQhYrvX6ukv2B2U9l/tvvRenF/m6RB?=
 =?us-ascii?Q?Ho5jaFgmb0Wx+uEyczAbAE3c4PnvFg1d/iE0sJ3QlLfKZxWEdqDR37Q0V6ci?=
 =?us-ascii?Q?4ydRvzHc4bVOCzZJfjmcT25AQ0eNFG5woKaKdza71nDbxKhhEVgAIxu6WN2H?=
 =?us-ascii?Q?zWuGJTpQVPQ/vGDB9v3Gxy+AZKdNEQAzvUNTLA8bEafd6NcRzVy4od2MgxDH?=
 =?us-ascii?Q?ffrYpR/9iopZvwdiWNY7NZFHzqnw2qN5KP6vnsnJYJxt4EP2w2lwBtI7VwfI?=
 =?us-ascii?Q?H4NV0u6GRgFwDTZc3DevuEvpN7NOFTjCndAbpAKpSPWDPS7kjjjhF7J3dPvT?=
 =?us-ascii?Q?ws35EI0m6Lpt2ugneh6+3ufsXWsrBhSmdMDSV/P2eoXpyUJUSKhcZ83TVDAw?=
 =?us-ascii?Q?3FOBzFqBZXD2ygODYU3SzoEahCxYUL4ZKvz0aqPIYVEbhzS0kYsyv/6KzVto?=
 =?us-ascii?Q?l4t4kNr/trgJyfPxGVK7hbE1Ny3yMwDBQEi5aAaV72iTew/0I/zuzESas9L8?=
 =?us-ascii?Q?RYQZ6WWd83qhcTGrV8DFtlnZASVPeBSE9Nj9PyFriysJgqLwnBMYCNyRB0oP?=
 =?us-ascii?Q?5/g9LEyLAkA/z9peH0/bcWIktRHP3ZlT97P0XhsCi22plQBnBaHyHK/SwYW9?=
 =?us-ascii?Q?lF+cHkWLSzHWfv9GGU5wV6gRpPlfOM8K7us9Bg6QFegf0bTuK3uYsmE2w4bh?=
 =?us-ascii?Q?p0wkJvhvqWA2/ltFnDF/7kuVMXWZuj56zl3V07i60i9UGsRQh4dztlP9K6eF?=
 =?us-ascii?Q?mLWLaPFdQfc/wfDxFPLp+KQzmZJ3d1T4nKaHFLvu0vuFB9GLov7Q0kE6D6pA?=
 =?us-ascii?Q?gWRrnSdwyfRdgqm6aaBGMnVDyTi0rQuqoBU0X9ti?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75eb940f-6be3-488a-3394-08ddbe8f9bf4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:23:36.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oV1jJLB58XDJcjQa9H+9sBfNjX8Pc2v+vHvuaL7ZeiZCuG/fUxxO7DyXKfuIBX7cgMYCnzNIm8PyfZr/9S1wOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4597475D5

Use max() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/ath/ath9k/dfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index 2fb73a5e1d51..370346450675 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -239,10 +239,7 @@ ath9k_postprocess_radar_event(struct ath_softc *sc,
 		 * Radiated testing, when pulse is on DC, different pri and
 		 * ext durations are reported, so take the larger of the two
 		 */
-		if (ard->pulse_length_ext >= ard->pulse_length_pri)
-			dur = ard->pulse_length_ext;
-		else
-			dur = ard->pulse_length_pri;
+		dur = max(ard->pulse_length_ext, ard->pulse_length_pri);
 		DFS_STAT_INC(sc, dc_phy_errors);
 
 		/* when both are present use stronger one */
-- 
2.34.1


