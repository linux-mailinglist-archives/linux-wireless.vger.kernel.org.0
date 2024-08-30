Return-Path: <linux-wireless+bounces-12245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4C8965984
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 10:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A165E2824B4
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029413665B;
	Fri, 30 Aug 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XVE5pIHN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5A158A37;
	Fri, 30 Aug 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005268; cv=fail; b=JMSNg0s59G1cVaOxShpm9EnFg/KyMPV2NrpuH5gHaFYc14fgu55xJk9XnNU2+znBCwbOuKbfv/9hoiJaGVRQJ1Wu4UA6vhLcTi9Lm2hLbc5Dbwe/QOf+DlroBZ73vawjhCA99ZzKVpe2TB5h2THt0zdy/Kw31zG9chBWvdEz9Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005268; c=relaxed/simple;
	bh=b7sXcbDOvbG67XX8bwgCs/qG6lIv0EhvU47sxgZFIpw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S4WyTs4JZZV8YWhD6ohiz6StWxuu963FFupiPYu/hSFuF168y/JPNPL9pQ6AnTcIR4OvF+yf7YAioSo3nWgfZBNAG3cEslFaQB0cSiDUnP9GNGBrn524A5CstfLHER+9zllJ3h87e/SgGk9tEBCfUu0YAQw+p0OwLIhdj33CYj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XVE5pIHN; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjvWn8fKC4zoNmRvln4sPh7P4fMJfSOu97d/GpdbOmWzMK8ZXDFJje8z3SFv8zJOM33Z3nsVuxOnMMR/3DqfMI7kn1RwGLGSRCgTXPUalax26GAlFboqSHSg/Gxd93rFqDVOLit/xeoydJxm+w7Ma0eNLFnvYzy2jjaX3WaXN4FTok/6cl4Sj/DzvyzoGdS06SHr0xmhKIr3Kv080NdLZhyxQvyegFJfG0ppkMmOz8m1wOhRFVVKGcNUTThm5Q+my2i8u+ICWA/PQ+3LZWZcGOjjxa6jiZsDT8geOiuvr/sIv+XSd+KruhzP+IXZCrXwd7Bvt5fQURxQOrPtqlxVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF34WzbgJQsbPHMRcZum5vNchdLTpU2RoOFRZpAE5rs=;
 b=dMDo22a2+RzOo+0zdHHowcDYqWenub4vmIT0mLw1dkzK3iSADfHVjQMQ/ix/G3izE6MGcMNOE+U55uUhBV5vhfmCbMDP0fichshCvtWhn2sAr9ng8uT54FVRTARegBzcJTweSiGwGDx4RiW1uwViwMtznDqVlAgj5X67KIyr++gpCn5XOAnvKYTNLSnF+qz4sMWLT8Bopv/cmD2iit+Q9bNJDCgS8IRKaYA1cuETbvWDcGVLW96RNib9mQqlInJ7wRM1iFwll9aIXCDGXyNRcOmGYAJIrT6+fNq1aXQg8MYTRV6VW50mzyTLlQMuybMXIeidRI0ZFwqPP2epUHcA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF34WzbgJQsbPHMRcZum5vNchdLTpU2RoOFRZpAE5rs=;
 b=XVE5pIHN/HWqm7heYO2c9xDOr7wrmJPzHU3haAcr7OHQ+m4Owd/vijPSph7oBuq9niNmKa9btTWtkaTfYuh9ArII1+9Doir61oySQ2hZPbE/g41CsuMQa7iFdFBP0GmSDAggAeJ/MfUE3hDwFZ5yYKT80K2dOvLOkRz85J/CJv/wjSO2LVHiLl0EtvkK6u67TaZRnbLeQL7gkSrIasRCkNkPW48MnmEuoumDlgnAy+XDSo03CKaCTSg1FzSQwHYYLgom34hItJn2xh44HcbjINV5si4KgX9v4K64A06CYVgMgnoy9irO2T0FHwK7De2B9pQo7gJb/IuJM7cgyVVmAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI2PR04MB10932.eurprd04.prod.outlook.com (2603:10a6:800:279::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 08:07:41 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 08:07:41 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS mode
Date: Fri, 30 Aug 2024 16:07:19 +0800
Message-Id: <20240830080719.826142-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0052.eurprd04.prod.outlook.com
 (2603:10a6:208:1::29) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI2PR04MB10932:EE_
X-MS-Office365-Filtering-Correlation-Id: 844d1f08-612a-4150-0d9b-08dcc8cad1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?svsZL1X9HkhkgF1mjboKbtt+RLPDN+8L33wlHx4Yxbj4tzAhhJXAd2s14Qjp?=
 =?us-ascii?Q?4Qu5EWVaHyJdrai40npCK5l0tvCLw05kOLCxtpJNYj6p7bcG8BE1PEJnad8u?=
 =?us-ascii?Q?sb+WcxX1AstG7Az7yDfGq9C95cxvbRpfzk1TnJk01bRS7gqb71ELdGK3kVZQ?=
 =?us-ascii?Q?wcMl53hQU0cfx92MIGoQsTjR19MUtviEhWDxRXr1fQ1nYHxlhZ151X41/bY+?=
 =?us-ascii?Q?in0b2r4LtGxiKy4Z6CJpaxm+emkTRYkfMOdljcpp+Ee4A0RSDpMcYDxTrsdr?=
 =?us-ascii?Q?nR0qxKZSa40mLm988GEa20juAW0dzLzi8izc7YrEXcNVneIRj1ntBHvntkW6?=
 =?us-ascii?Q?6W8U32r25VkY8vtrvgWDocqO5K4Fx/02YnsNYbVNJqSsDmGvYA9Mg3iGtYhV?=
 =?us-ascii?Q?fHT3Qc3OSH5EIXX/oEX5ZAks0tiH1R9Qa8iCs1E8GLYcZUKjV7fV73eaB0Su?=
 =?us-ascii?Q?tKjVmE/rAv0q/Oi6dfVhXvpQ0qzXtUo6AMHNqgAagavI1ivezF4tdAU4UJHf?=
 =?us-ascii?Q?skxnoNPu4WVG7wAd416EobhML0KutAy7UhWJuy5YOF3tXFL+wT6cBmskqZzO?=
 =?us-ascii?Q?xspoSLYI03Bi0953OPUWoSSLYIwsJdeiZ6XLbV3XFsLYxbyDk6qq6LSBb/W9?=
 =?us-ascii?Q?mzmb70dyOuGqtM7agDwnrWjzc+0xHhwCQTNhf3vVO+xe3CiMZQVwDZNr748S?=
 =?us-ascii?Q?BL+6uCkH9JOStHQYMWu5ePomld6lDKaTlPY86BIveW3CJ8QeJOsDXaYvvkVq?=
 =?us-ascii?Q?rVCOohaMSWWryDA5+o3Xx/DsUb7fJzx89rLEM0GirZR29OZfD8PhGw9B40jT?=
 =?us-ascii?Q?/wX6aubhafNpXQn0S/UEm2S+sAvk8N6kuRrf7F+6uFSdpDWupgkj5lkkGzu8?=
 =?us-ascii?Q?jt22KbklhlEzV3PbCITR3dKCswATEdpMG8Xjsmvkim+9mqdi773R012x4TRD?=
 =?us-ascii?Q?jjZvObIgepW2nbOJwJn6iYkwt+VCwqY+yEsYQ5wOOlccEk01Nxg5dVK+DukO?=
 =?us-ascii?Q?5srD7iRGtjLJEpZ32kCG3EWYkDqMhTz6y+zoprhiGQAw7NcD1y5wj6tWlyoM?=
 =?us-ascii?Q?D3SBp1oi7ojwKOyhHKIscQ0WxaIdgkFqZRZhV5D3DslqT6OlhSqSJAycojxV?=
 =?us-ascii?Q?1/YGhu1TeGX5X94Gcng9rZELLDUdFX4xUa0vzqGmjvRZNzIWSDm5ThrkznGH?=
 =?us-ascii?Q?3xqT1KzL5YcGN+UDKSdBEX1qSK44uYzACKio/2yxo1Oz7A7obt3depokbP8b?=
 =?us-ascii?Q?VlBpR6wdAryVcKC1K31pEdQRifuN1GJG1xRNGkV1f7xfnrjElv58PefvqAwM?=
 =?us-ascii?Q?qhBJMcKKPzVOV2YMnOqtn6reLULRlWsb5Qs+rA9hsRe0Pt74/KcJP4kCHtp5?=
 =?us-ascii?Q?q1miB1kEB3IzDOH0OQQ0UpeUbi7DWGprr4MGCblpb0beqU+8Qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G6oZGps1Nd/mrrth9KacoALcT8bPQzSDGeJ4YxWqCNl1ZWGoXdbHSjj8XKGt?=
 =?us-ascii?Q?uzbpBf7SQBdaQj7PGLpLkdcyBUqKe00xZ6Y8XCzIG4Yk7eQFbYMA3wxBAUml?=
 =?us-ascii?Q?sG/R/dIVT3TRbFqMIXkuQIEZL9gL+ETbHnNr4SOT1gxQ/xqE7ozZrPWW/k5j?=
 =?us-ascii?Q?Sn2gzVBYjgYDMnsKGVA31E+QhMaOynqMX2/IOVUunVW0d5uR/cMC0b810hIp?=
 =?us-ascii?Q?taEOiBI94PN0DMSP9wK4JHlI6G9qfTB7DcxC53hiF8tJjUu2ypE80BLuAOaq?=
 =?us-ascii?Q?8wZyGzgByK9GF5J7F0YVZzg9h7bUHonm6cEBtFFWNoF6BoDkAfj1jU2zJfbF?=
 =?us-ascii?Q?94cRSIaU9HgpMPDpJlP0zOsyhje2N1HI8hGT3ySCfAW2pjXr/9dFvttIvQpk?=
 =?us-ascii?Q?6B/pVS1B3VEh9eEgPU1MrZb4BCRSTroa5Ib7Fbzw1LkNqO2RZcoMzJ7wdLu8?=
 =?us-ascii?Q?05Lcw55Fdbg/oMahtcW2gm441MdriBW/YDMUQ/FzMnzBZr0yfNpMT+x4i0dk?=
 =?us-ascii?Q?mFfYPaRTdKY9x3UZInl2oK17L2MvcEzRKWBp5cenWFZ3OSrPFtpym5Ocin7F?=
 =?us-ascii?Q?YKakt4Z4cS3uwwltExmKyURmSh+K+OVr+HRkSihb4rw5yzvBxGPPJ2n69OeU?=
 =?us-ascii?Q?OVdfcm7QyzEO786DjtwCJHvWQwfDhzr2GXNMCIogSh4/qmf3j6YBra8OVvku?=
 =?us-ascii?Q?7El5ldiMHjQrlz2N+rXFob3lvi7KGYgJq9QtobOaHV5wNV5EH7lCab1r5gKD?=
 =?us-ascii?Q?6DyzYKA67DNQHd2/MmM+FNvmKpm8DBD/CuZUFDSEmkPfSqSe0tXPGW1yvqND?=
 =?us-ascii?Q?V/fPKdDmDx3+SCb8EyUFXSeew6/V4ci8MuualkjYlbiwmtVcrVyo2uNaCR/+?=
 =?us-ascii?Q?PcaYmALbRreqZtrj5IrsRDRJ1tAWU556x8Wm2+jV/qPsHF4aZXGRUPvk4RPX?=
 =?us-ascii?Q?x0AHvtRMtRtIOICD4a7pjYSAD9rHzQfP8uLA9V12dfKkZhvY4YifuR2uujB6?=
 =?us-ascii?Q?ktpmp5PPKs8VmompMaDKSaC+MD2tbBDXUBUNSxKJZEwKQl2b9Yuw46AXtvxJ?=
 =?us-ascii?Q?7dNzbEkd5QisWZO2ZK7yKf5oxEHWW93HQOV6d1fpeuMs9mTjiCHypRNfU7I4?=
 =?us-ascii?Q?Qy8yJbAEjySL4LQl7dk8JpkLQQFZ16G18tO3gYKjpvkH21doGXGZnCyTHfT5?=
 =?us-ascii?Q?Mk180So4H0oMThTS3FQWBvBhgI12yvOixRRvO9niK+lgCdiCjSntWN6/uyZ6?=
 =?us-ascii?Q?68iYKHbA7veXXKyFMFk5IXPTvznwM/2uuwDg8V1nnQir9DWWIwxSz6xeCGkJ?=
 =?us-ascii?Q?oHX7mSfZjSpGoO3CBDGxjZOJrwBkFRV2RMQh5di3wjFZkD6KJ59i8UJemjL+?=
 =?us-ascii?Q?UOJYtmQWCzHQTb72aYb4RQJeZue1EvDHgKoSE80UQrEh8L98mULja032kw3P?=
 =?us-ascii?Q?LgSUII7qQs5hAN/rdwocuX1v9pDpU8RKdHS4KU17O9BBEKDn0Bk3yhz2YzCd?=
 =?us-ascii?Q?YuaLqmyj4RfmKZfyCKLOgqWV2KXJ3gGUTsRcALpWTy55XPqoILKJTL+J9JeM?=
 =?us-ascii?Q?dZCjlVzvzTqDkHp7GQliCznOCmwIAzOrCpLYEF9X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844d1f08-612a-4150-0d9b-08dcc8cad1a6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:07:41.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ygyd3pspcGzu46AASysG5RBBS09DMa9M0Bjgl15GIoNi80RQLZ3E9CaiXKz1qDSNCTJ2P/6+QB+RKOD4Uokdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10932

Firmware crashes when AP works on a DFS channel and radar detection occurs.
This patch fixes the issue, also add "fake_radar_detect" entry to mimic
radar detection for testing purpose.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/11h.c    | 56 +++++++++++++++----
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 50 ++++++++---------
 .../net/wireless/marvell/mwifiex/cfg80211.h   |  4 +-
 .../net/wireless/marvell/mwifiex/debugfs.c    | 42 ++++++++++++++
 drivers/net/wireless/marvell/mwifiex/decl.h   |  1 +
 drivers/net/wireless/marvell/mwifiex/main.h   |  1 +
 6 files changed, 115 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index b90f922f1cdc..e7e7a154831f 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -7,7 +7,7 @@
 
 #include "main.h"
 #include "fw.h"
-
+#include "cfg80211.h"
 
 void mwifiex_init_11h_params(struct mwifiex_private *priv)
 {
@@ -220,8 +220,11 @@ int mwifiex_11h_handle_chanrpt_ready(struct mwifiex_private *priv,
 				cancel_delayed_work_sync(&priv->dfs_cac_work);
 				cfg80211_cac_event(priv->netdev,
 						   &priv->dfs_chandef,
-						   NL80211_RADAR_DETECTED,
+						   NL80211_RADAR_CAC_ABORTED,
 						   GFP_KERNEL);
+				cfg80211_radar_event(priv->adapter->wiphy,
+						     &priv->dfs_chandef,
+						     GFP_KERNEL);
 			}
 			break;
 		default:
@@ -244,9 +247,16 @@ int mwifiex_11h_handle_radar_detected(struct mwifiex_private *priv,
 
 	mwifiex_dbg(priv->adapter, MSG,
 		    "radar detected; indicating kernel\n");
-	if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
-		mwifiex_dbg(priv->adapter, ERROR,
-			    "Failed to stop CAC in FW\n");
+
+	if (priv->wdev.cac_started) {
+		if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
+			mwifiex_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+	}
+
 	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
 			     GFP_KERNEL);
 	mwifiex_dbg(priv->adapter, MSG, "regdomain: %d\n",
@@ -267,27 +277,53 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 	struct mwifiex_uap_bss_param *bss_cfg;
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct mwifiex_private *priv =
-			container_of(delayed_work, struct mwifiex_private,
-				     dfs_chan_sw_work);
+		container_of(delayed_work, struct mwifiex_private,
+			     dfs_chan_sw_work);
+	struct mwifiex_adapter *adapter = priv->adapter;
+
+	if (mwifiex_del_mgmt_ies(priv))
+		mwifiex_dbg(adapter, ERROR,
+			    "Failed to delete mgmt IEs!\n");
 
 	bss_cfg = &priv->bss_cfg;
 	if (!bss_cfg->beacon_period) {
-		mwifiex_dbg(priv->adapter, ERROR,
+		mwifiex_dbg(adapter, ERROR,
 			    "channel switch: AP already stopped\n");
 		return;
 	}
 
+	if (mwifiex_send_cmd(priv, HostCmd_CMD_UAP_BSS_STOP,
+			     HostCmd_ACT_GEN_SET, 0, NULL, true)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "channel switch: Failed to stop the BSS\n");
+		return;
+	}
+
+	if (mwifiex_cfg80211_change_beacon_data(adapter->wiphy, priv->netdev,
+						&priv->beacon_after)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "channel switch: Failed to set beacon\n");
+		return;
+	}
+
 	mwifiex_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
 
 	if (mwifiex_config_start_uap(priv, bss_cfg)) {
-		mwifiex_dbg(priv->adapter, ERROR,
+		mwifiex_dbg(adapter, ERROR,
 			    "Failed to start AP after channel switch\n");
 		return;
 	}
 
-	mwifiex_dbg(priv->adapter, MSG,
+	mwifiex_dbg(adapter, MSG,
 		    "indicating channel switch completion to kernel\n");
 	wiphy_lock(priv->wdev.wiphy);
 	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
 	wiphy_unlock(priv->wdev.wiphy);
+
+	if (priv->uap_stop_tx) {
+		if (!netif_carrier_ok(priv->netdev))
+			netif_carrier_on(priv->netdev);
+		mwifiex_wake_up_net_dev_queue(priv->netdev, adapter);
+		priv->uap_stop_tx = false;
+	}
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 722ead51e912..c5e8f12da0ae 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1858,16 +1858,12 @@ static int mwifiex_cfg80211_set_cqm_rssi_config(struct wiphy *wiphy,
 	return 0;
 }
 
-/* cfg80211 operation handler for change_beacon.
- * Function retrieves and sets modified management IEs to FW.
- */
-static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
-					  struct net_device *dev,
-					  struct cfg80211_ap_update *params)
+int mwifiex_cfg80211_change_beacon_data(struct wiphy *wiphy,
+					struct net_device *dev,
+					struct cfg80211_beacon_data *data)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	struct mwifiex_adapter *adapter = priv->adapter;
-	struct cfg80211_beacon_data *data = &params->beacon;
 
 	mwifiex_cancel_scan(adapter);
 
@@ -1877,12 +1873,6 @@ static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
-	if (!priv->bss_started) {
-		mwifiex_dbg(priv->adapter, ERROR,
-			    "%s: bss not started\n", __func__);
-		return -EINVAL;
-	}
-
 	if (mwifiex_set_mgmt_ies(priv, data)) {
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "%s: setting mgmt ies failed\n", __func__);
@@ -1892,6 +1882,20 @@ static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
 	return 0;
 }
 
+/* cfg80211 operation handler for change_beacon.
+ * Function retrieves and sets modified management IEs to FW.
+ */
+static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
+					  struct net_device *dev,
+					  struct cfg80211_ap_update *params)
+{
+	int ret;
+
+	ret = mwifiex_cfg80211_change_beacon_data(wiphy, dev, &params->beacon);
+
+	return ret;
+}
+
 /* cfg80211 operation handler for del_station.
  * Function deauthenticates station which value is provided in mac parameter.
  * If mac is NULL/broadcast, all stations in associated station list are
@@ -4027,10 +4031,8 @@ static int
 mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				struct cfg80211_csa_settings *params)
 {
-	struct ieee_types_header *chsw_ie;
-	struct ieee80211_channel_sw_ie *channel_sw;
-	int chsw_msec;
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	int chsw_msec;
 
 	if (priv->adapter->scan_processing) {
 		mwifiex_dbg(priv->adapter, ERROR,
@@ -4045,20 +4047,11 @@ mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 				       &priv->dfs_chandef))
 		return -EINVAL;
 
-	chsw_ie = (void *)cfg80211_find_ie(WLAN_EID_CHANNEL_SWITCH,
-					   params->beacon_csa.tail,
-					   params->beacon_csa.tail_len);
-	if (!chsw_ie) {
-		mwifiex_dbg(priv->adapter, ERROR,
-			    "Could not parse channel switch announcement IE\n");
-		return -EINVAL;
-	}
-
-	channel_sw = (void *)(chsw_ie + 1);
-	if (channel_sw->mode) {
+	if (params->block_tx) {
 		if (netif_carrier_ok(priv->netdev))
 			netif_carrier_off(priv->netdev);
 		mwifiex_stop_net_dev_queue(priv->netdev, priv->adapter);
+		priv->uap_stop_tx = true;
 	}
 
 	if (mwifiex_del_mgmt_ies(priv))
@@ -4075,7 +4068,7 @@ mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(&priv->beacon_after, &params->beacon_after,
 	       sizeof(priv->beacon_after));
 
-	chsw_msec = max(channel_sw->count * priv->bss_cfg.beacon_period, 100);
+	chsw_msec = max(params->count * priv->bss_cfg.beacon_period, 100);
 	queue_delayed_work(priv->dfs_chan_sw_workqueue, &priv->dfs_chan_sw_work,
 			   msecs_to_jiffies(chsw_msec));
 	return 0;
@@ -4794,6 +4787,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 			WIPHY_FLAG_HAS_CHANNEL_SWITCH |
 			WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT;
+	wiphy->max_num_csa_counters = MWIFIEX_MAX_CSA_COUNTERS;
 
 	if (adapter->host_mlme_enabled)
 		wiphy->flags |= WIPHY_FLAG_REPORTS_OBSS;
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.h b/drivers/net/wireless/marvell/mwifiex/cfg80211.h
index 50f7001f5ef0..0a12437f89f2 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.h
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.h
@@ -13,5 +13,7 @@
 #include "main.h"
 
 int mwifiex_register_cfg80211(struct mwifiex_adapter *);
-
+int mwifiex_cfg80211_change_beacon_data(struct wiphy *wiphy,
+					struct net_device *dev,
+					struct cfg80211_beacon_data *data);
 #endif
diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 9deaf59dcb62..5d575d2918fe 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -909,6 +909,46 @@ mwifiex_reset_write(struct file *file,
 	return count;
 }
 
+static ssize_t
+mwifiex_fake_radar_detect_write(struct file *file,
+				const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	struct mwifiex_private *priv = file->private_data;
+	struct mwifiex_adapter *adapter = priv->adapter;
+	bool result;
+	int rc;
+
+	rc = kstrtobool_from_user(ubuf, count, &result);
+	if (rc)
+		return rc;
+
+	if (!result)
+		return -EINVAL;
+
+	if (priv->wdev.cac_started) {
+		mwifiex_dbg(adapter, MSG,
+			    "Generate fake radar detected during CAC\n");
+		if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
+			mwifiex_dbg(adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+		cfg80211_radar_event(adapter->wiphy, &priv->dfs_chandef,
+				     GFP_KERNEL);
+	} else {
+		if (priv->bss_chandef.chan->dfs_cac_ms) {
+			mwifiex_dbg(adapter, MSG,
+				    "Generate fake radar detected\n");
+			cfg80211_radar_event(adapter->wiphy,
+					     &priv->dfs_chandef,
+					     GFP_KERNEL);
+		}
+	}
+
+	return count;
+}
 #define MWIFIEX_DFS_ADD_FILE(name) do {                                 \
 	debugfs_create_file(#name, 0644, priv->dfs_dev_dir, priv,       \
 			    &mwifiex_dfs_##name##_fops);                \
@@ -945,6 +985,7 @@ MWIFIEX_DFS_FILE_OPS(histogram);
 MWIFIEX_DFS_FILE_OPS(debug_mask);
 MWIFIEX_DFS_FILE_OPS(timeshare_coex);
 MWIFIEX_DFS_FILE_WRITE_OPS(reset);
+MWIFIEX_DFS_FILE_WRITE_OPS(fake_radar_detect);
 MWIFIEX_DFS_FILE_OPS(verext);
 
 /*
@@ -971,6 +1012,7 @@ mwifiex_dev_debugfs_init(struct mwifiex_private *priv)
 	MWIFIEX_DFS_ADD_FILE(debug_mask);
 	MWIFIEX_DFS_ADD_FILE(timeshare_coex);
 	MWIFIEX_DFS_ADD_FILE(reset);
+	MWIFIEX_DFS_ADD_FILE(fake_radar_detect);
 	MWIFIEX_DFS_ADD_FILE(verext);
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wireless/marvell/mwifiex/decl.h
index 84603f1e7f6e..9ece61743b9c 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -19,6 +19,7 @@
 
 #define MWIFIEX_BSS_COEX_COUNT	     2
 #define MWIFIEX_MAX_BSS_NUM         (3)
+#define MWIFIEX_MAX_CSA_COUNTERS     5
 
 #define MWIFIEX_DMA_ALIGN_SZ	    64
 #define MWIFIEX_RX_HEADROOM	    64
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 9024bb944e6a..92bc25bf550f 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -678,6 +678,7 @@ struct mwifiex_private {
 	struct delayed_work dfs_cac_work;
 	struct workqueue_struct *dfs_chan_sw_workqueue;
 	struct delayed_work dfs_chan_sw_work;
+	bool uap_stop_tx;
 	struct cfg80211_beacon_data beacon_after;
 	struct mwifiex_11h_intf_state state_11h;
 	struct mwifiex_ds_mem_rw mem_rw;

base-commit: ae98f5c9fd8ba84cd408b41faa77e65bf1b4cdfa
-- 
2.34.1


