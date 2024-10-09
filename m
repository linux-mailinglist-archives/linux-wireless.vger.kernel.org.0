Return-Path: <linux-wireless+bounces-13755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A14995FE8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0EFBB21750
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 06:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8317839C;
	Wed,  9 Oct 2024 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YfEqwpcO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698A17B41F;
	Wed,  9 Oct 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455825; cv=fail; b=PIU18fkC3UnGD/yRBLER607vvHDHKyi4t3IVO20TNjxh173jFVWcN5g43DALQ54o3bgFI3AcRMAGRXwunQ4sJ9yysYWkz5jIk+NyPLA+/CyDoaIpxu7L57yZmjhAmkEqzVlWSf70UmM6whwRFJAkq9USODiAWkeiCbM/1uMVw0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455825; c=relaxed/simple;
	bh=faLvdIoR2soD9fbx0WvTnf9133zgE6Dd+XP/ODaLHYA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D4xfLv7OU22uxLiWR1ZwaN6/CqZz7kzbV5C0+LS250Pnod0ccrpdLApZ0IYS+NrKg/aXWwlqtPY7Xn/pwTQr2BBB7AyHCK4WwJZaB6VlQ4rUEXY9Oc9AqWWQXDH2PSeh0IMqYbesNI1UQ4YS5wqSG8uEu2bzEf18C5+yiC+PniU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YfEqwpcO; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qU8le8cWvemG3jvEokhfq5JmjwmvALnH5lPeEAlCuKPd2x+djbCSBv6Mw8pQkrnqcO6zipb6Y4G7bCgikAA4A+CJjBX17szqtMAwylsGdF6ltRrLg1xSqEB4IhLIwAwvH2iHuSw9Evzy1AESMRGBTQdP/oTIzQf6K1Tf/mbC5fU36f//7mAmQ3hRLsj2K0bkGgOrRr1PULWx/AvVD4vxhWCqulE7PlnGMdpd4Lsgs47QvEwb8dBiIhwUfvPiRdWr4fZBNucCU04lF9KXp5OeNeVlQlObMvBrNfu7d+hQ9zpl7s8pcgAssgygEFly8XQzQG1c0U4nHW7QTC1dzxn3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpZrs/qVlxuAqVawTB3Bd4sKyVVFyoNz5gpQYQ0mSRQ=;
 b=PY6A6qfPbVHNqfHijtxbos28H8ZC83lmJ4W5CyAhtPqQlgHrTQZ3QGhKBIzhlvyQlBx1EimMnHs7GjRZAxK3GSgTfHkw6E6ClX9HENmcsz+KDgRvk6CjElleJuOFfp4QIOfwfGnSCh4gBdtJTdiL8FLSWvh2HYAtn+O/S76BQ8CbHHbpuWRMppECNtQR44NOvCS2Txc9utBb9twz6qAPX8XRUm8mR5jaE6COU+DFj1RgYqH05Bkxd4Yg7B+4Z8a9THY8kIc3LZP3OCUcc7LktnzJ/64R6MSPXI2kU62xaVNWcw99AlvvtT/X+aOzZr5KR940KczDs3j302tYX9nNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpZrs/qVlxuAqVawTB3Bd4sKyVVFyoNz5gpQYQ0mSRQ=;
 b=YfEqwpcOr2vyO73RU+ikp6KfRMpmwm2EPVy9aTynl4lNbFyfeOpv4cviaFQgUHNYCNRazTQeq65KHno6b3o+nSV7l+YREV8U2fmHFM4Ldpj5wp50zdlg+r3BMq8QSvF5EAXnEFKot7fgD67nTBVDUQJxfdYMZz3ssqgZPmRXTNRSllJ9NzA+86VehONK3SbNMKbp/RTR3GWAyzDqKhIqiAaXtQD9j/Gq1LMvJttONSydW1U07at2mVnZChcegw5aIY63vxh7OQ4biRiLTCLhHQ3qvYYWXuilHAyIHqvgFjWdlhdoPKOmJJz8tHTCAJi0Bca00NmGRSoJQeOxUvPqhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB9414.eurprd04.prod.outlook.com (2603:10a6:102:2a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 06:37:00 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:37:00 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2] wifi: mwifiex: fix firmware crash for AP DFS mode
Date: Wed,  9 Oct 2024 14:36:47 +0800
Message-Id: <20241009063647.9265-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PA4PR04MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fe837a-6539-43ab-8e5b-08dce82cc72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DA3YI/ttZEKyXAyHn7xZa6tE7QxpYvL1OQnrF54TuaEAUHUzxx5ry8oUuiHZ?=
 =?us-ascii?Q?zgKRbPDpmUqfG7GdpdUhUkIHLF6OeyDZSpPFPPEfFAasQkBOocOtBeP5Prbz?=
 =?us-ascii?Q?kf6aTaeV3eF2g66RwyjDpdyelhk/b1VQxq1TkKX4Qbgh9Hq6IAVsvY7LSzjh?=
 =?us-ascii?Q?Qmi7QE6EaZKZYCu1BWNvWK+iwgMIWMSVDsWOGMCepPtMhakVV3MU1qwoRHKF?=
 =?us-ascii?Q?uxSDx45qiOgnH/yh9No+SfhT+uNk/dszJIzIujd+38o8loeCOeZUOuD2H3Oa?=
 =?us-ascii?Q?4k+qgbYZnBtzoGQwUOCNoyGlulxvULijhIddotQ38C9DfgQjWHsK2kQc6qDZ?=
 =?us-ascii?Q?J7k9Kh7Fw1NZ9iDV+XNg8psXFjOByK3WVLJSjQEVC/19Wklwgz7mTlCgDYnq?=
 =?us-ascii?Q?CbT6Jh1riTcYIo2UIH7wVzI60IlrEfJYNmkJ51x4r4ADIP2qnLVe5gySBYBa?=
 =?us-ascii?Q?zUOGOzK0FcCgAm7K/ERKAGfJYM9k9m0fE9FsQAV5v4o1cEZTq4FsX6dBbqQ2?=
 =?us-ascii?Q?ppS+nIr7IM+gqjs623jWaV8MKJcU+e1nPOeC6cED1v0u4njPyJbShdpgM662?=
 =?us-ascii?Q?1GTzIAWrnhsv0xy4VXqVJiHbo7eFhaEpv2frSpns9tTccppYRK5MwIkNdDfa?=
 =?us-ascii?Q?Y51mD1pCyEazo5+qrhI+LOASCjODX4tvowM+myty/J6acLYNcjU+hZIzGpqG?=
 =?us-ascii?Q?bO8xPqliuKuanfiHYIoQ3PILOlxKkeRoa7N2sl40+7KwFcbXXIyQ9pFdFX4N?=
 =?us-ascii?Q?YOBaE0OVaMJkaXKdoyneF1uMyj4XkqtIzOoHEBX65LC7bzT5rYQUwNfvrPYb?=
 =?us-ascii?Q?AyaI1FzElSvnmbOdSzp1oQVZTt/KuQRI5qybP7L6De3FibJY2xAb3ef9uZCs?=
 =?us-ascii?Q?I9JSthB7CvRPLkQwFhmpKczBnk7/dwc5mHxhFcvhxiexgANQZ1LGfmwrlOOX?=
 =?us-ascii?Q?vS9BQcUVs8SPzED/DVoswP+hCDhi1Aul6EvlKwfl7mY9Gdjx8UeV3oVafgQh?=
 =?us-ascii?Q?NEUcZBC5OvjIS26S7V6JBa0Tj13k7tlTATfGAapTUdHpdGH2WKXIu7efErJa?=
 =?us-ascii?Q?JuztQwJqi6W8G1rrQgQwP0Ux3A1cWPoonnS75d6eSGbfMl33eoPGLIi6cbt9?=
 =?us-ascii?Q?JTlfwlMikqMtXDZKyTw5fD06hlhW5VO9YFkb6AqcfXM8D2akAqKAL+YS/+hu?=
 =?us-ascii?Q?LyTduSUWF1GOHmO6H1JYMvKDOpTcl4OlPwnxUFKrSS4/vz69IH8gyABkcHxP?=
 =?us-ascii?Q?aCwktVh6dcMIJ6+rLOlgMbqCbHIl+4JPzcSFevF+9sw9wCqQtXwloRPBamR8?=
 =?us-ascii?Q?88ZkeS93+u3W0giW97MZDSRqFbfwIEBkpl3VFrLL+WDKdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z+uOaQ4QkDpJMlTvoCdAOOYc6nf89x4mNBzqHovUVXlsAHhMSOx04HWzROSj?=
 =?us-ascii?Q?MgfnRA4X2jU+5y2kA47Li1h3TT0tgGgVpAFL2doEyO+lS1fm9oolpuXXrFGy?=
 =?us-ascii?Q?6kM1nFVaFdRPr/5Mrp6Z7asOzXMZw5uJnR/K2ZViQu8DGlO/vxl8CArfELA3?=
 =?us-ascii?Q?c60snoEmYYqmRHqtUcD0rM4NrMoW24q07Jn+lGM5cOtoJsdzaVhCk/KIdsi5?=
 =?us-ascii?Q?Ri1ClBvHYlUS2pAUHXf3D8VwHpEqoaljwlQBauGyyjMR53AcMbhw7yjFEsFG?=
 =?us-ascii?Q?eS8IDbHXpEZPB/cUPlfh4g85De7Fmuqc2xlyUEdQ1Jb2jU6YWn/9fFCSMe3B?=
 =?us-ascii?Q?ZyIg+/ncThKq5qXN5cSTystsY54nU3Ca3wk2qenhLckBIFDWJjBL0dagnlVi?=
 =?us-ascii?Q?s8xtBi3jHmZJgw3AQcvdvUEUlsSMlPv7s1ZoDfw3KcghNAQ8ttPAUpsBkEbm?=
 =?us-ascii?Q?lsyMWLycxVoCJwB2/8lP2/PDJqaQGhTG2URQgWAgwH4LsYFvNOpDquagGRA7?=
 =?us-ascii?Q?eUK0aVBVzcAJom+jU26Cc7Uj5MVZSNaVpnxtccGVPgaS7+bKRVexxSU1aFr3?=
 =?us-ascii?Q?sUutFIxPaBAqkXBQTqtiLzgrT4/pHtyUFNBwj72y7ETNSXPGNZsLlHBmx1M8?=
 =?us-ascii?Q?xmg/z8/084Igkn3mePWbRptIm71q0Uvmxa0VcGmhsKob8g+DYVvY9A5ppUDZ?=
 =?us-ascii?Q?7+CroRHDcNOG6HgsGMeKYy3mpCziAkJP7oGDvdirL6QXaGiZV9AcqhWri9gT?=
 =?us-ascii?Q?Nk+jMdKELwC3TjegaXD8KyN0ETc8zuMduay6aLjBNkxt9z7/fDp6XSx6RHto?=
 =?us-ascii?Q?gn+Xk7eD+9kAPjdVP/OZrEMlFCMRq0c8nJOmbwGoqPltvj5k8WrV4i1FvJMO?=
 =?us-ascii?Q?aEiPYjrg5YhzNHymSUNmxiCx1FzVZl0O/2jprolPuIV5v7dVQ6z5qm2Wue7g?=
 =?us-ascii?Q?HQpEHiXhZYQPzRT6l2hQvYATNRFCgxbQpyz9YyZ49YUDYv8WvTAGI5qIuV0D?=
 =?us-ascii?Q?9+3Pykz4Dnb7IBnsmnpWQGRqFIgb2HCg2dK4jyLXwoyEMA9NOB1w3MdqX4FQ?=
 =?us-ascii?Q?3Zwak269RMo4D2gvzxlKBLmHFFT8Z4DtCCr4JUW5mU93VqTyzDtf2T5hayWx?=
 =?us-ascii?Q?FVbqtESw2hi/D0FFuMQGzGF15VH7d7z7QJEHXhjkrpVP7CPTocVC8RcqYWza?=
 =?us-ascii?Q?5Sm3r+3CN4nun99BSO4yuFKWrWQSd/DiSqJwYKvOOI3/EMiZuhPffZqh2krH?=
 =?us-ascii?Q?ddBc5v4lxMD36VAuw/l67VoYlU9adu1wQ3cpiGGASLR/rVgwdrZA+sF3YA+E?=
 =?us-ascii?Q?j0bFui5NMCLPS/v4KMdN477Yw0hdyhinE/EhEzb98MMAENUm9IeR6l26pdKw?=
 =?us-ascii?Q?wEEBrsVYqotH4xAMzktc4DsUK9a/SEapi1UYS8QlQla1SRDTBHe8sH7lVtIq?=
 =?us-ascii?Q?V5kWUQjcA27eHi62gkaKC4GIe70maxCO/vui5qRagCYh9iuoDLZefZl509Xh?=
 =?us-ascii?Q?4FruUcGOSJqzjb3+RS94bImN9f9prEpPO5IiwkfCOZeryVx1E7Yqke6dRAL3?=
 =?us-ascii?Q?ehyRgLUhQT7h+J6ik8bo49OXCNvH18k2Y2H/3Iv4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fe837a-6539-43ab-8e5b-08dce82cc72d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:37:00.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJwQ3kk18Wrl+Ax1tkjtxuFAQDsv15+nzUYzaeep2cDb7fwq9uKaAOppUFMZZ93rOe8G9m/9U/Lc+LUaQta2Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9414

When AP mode is running on DFS channel and radar detection happened
during or after CAC, firmware will crash due to the code of mwifiex
is too old to handle DFS process. This patch fixes above issue and
had been tested with IW416.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---

v2:
   - remove clean up for adapter (from priv->adapter to adapter).
   - remove useless check of netif_carrier_ok().
   - just return directly for mwifiex_cfg80211_change_beacon().
   - remove debugfs file "fake_radar_detect".

---
 drivers/net/wireless/marvell/mwifiex/11h.c    | 49 ++++++++++++++++---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 49 +++++++------------
 .../net/wireless/marvell/mwifiex/cfg80211.h   |  4 +-
 drivers/net/wireless/marvell/mwifiex/decl.h   |  1 +
 drivers/net/wireless/marvell/mwifiex/main.h   |  1 +
 5 files changed, 66 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index 032b93a41d99..3d8f6c610bca 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -7,7 +7,7 @@
 
 #include "main.h"
 #include "fw.h"
-
+#include "cfg80211.h"
 
 void mwifiex_init_11h_params(struct mwifiex_private *priv)
 {
@@ -221,8 +221,11 @@ int mwifiex_11h_handle_chanrpt_ready(struct mwifiex_private *priv,
 				cancel_delayed_work_sync(&priv->dfs_cac_work);
 				cfg80211_cac_event(priv->netdev,
 						   &priv->dfs_chandef,
-						   NL80211_RADAR_DETECTED,
+						   NL80211_RADAR_CAC_ABORTED,
 						   GFP_KERNEL, 0);
+				cfg80211_radar_event(priv->adapter->wiphy,
+						     &priv->dfs_chandef,
+						     GFP_KERNEL);
 			}
 			break;
 		default:
@@ -245,9 +248,16 @@ int mwifiex_11h_handle_radar_detected(struct mwifiex_private *priv,
 
 	mwifiex_dbg(priv->adapter, MSG,
 		    "radar detected; indicating kernel\n");
-	if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
-		mwifiex_dbg(priv->adapter, ERROR,
-			    "Failed to stop CAC in FW\n");
+
+	if (priv->wdev.links[0].cac_started) {
+		if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
+			mwifiex_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+
 	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
 			     GFP_KERNEL);
 	mwifiex_dbg(priv->adapter, MSG, "regdomain: %d\n",
@@ -268,8 +278,12 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 	struct mwifiex_uap_bss_param *bss_cfg;
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct mwifiex_private *priv =
-			container_of(delayed_work, struct mwifiex_private,
-				     dfs_chan_sw_work);
+		container_of(delayed_work, struct mwifiex_private,
+			     dfs_chan_sw_work);
+
+	if (mwifiex_del_mgmt_ies(priv))
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "Failed to delete mgmt IEs!\n");
 
 	bss_cfg = &priv->bss_cfg;
 	if (!bss_cfg->beacon_period) {
@@ -278,6 +292,21 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 		return;
 	}
 
+	if (mwifiex_send_cmd(priv, HostCmd_CMD_UAP_BSS_STOP,
+			     HostCmd_ACT_GEN_SET, 0, NULL, true)) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "channel switch: Failed to stop the BSS\n");
+		return;
+	}
+
+	if (mwifiex_cfg80211_change_beacon_data(priv->adapter->wiphy,
+						priv->netdev,
+						&priv->beacon_after)) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "channel switch: Failed to set beacon\n");
+		return;
+	}
+
 	mwifiex_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
 
 	if (mwifiex_config_start_uap(priv, bss_cfg)) {
@@ -291,4 +320,10 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 	wiphy_lock(priv->wdev.wiphy);
 	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
 	wiphy_unlock(priv->wdev.wiphy);
+
+	if (priv->uap_stop_tx) {
+		netif_carrier_on(priv->netdev);
+		mwifiex_wake_up_net_dev_queue(priv->netdev, priv->adapter);
+		priv->uap_stop_tx = false;
+	}
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index fca3eea7ee84..40f51e62b2e7 100644
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
@@ -1892,6 +1882,16 @@ static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
 	return 0;
 }
 
+/* cfg80211 operation handler for change_beacon.
+ * Function retrieves and sets modified management IEs to FW.
+ */
+static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
+					  struct net_device *dev,
+					  struct cfg80211_ap_update *params)
+{
+	return mwifiex_cfg80211_change_beacon_data(wiphy, dev, &params->beacon);
+}
+
 /* cfg80211 operation handler for del_station.
  * Function deauthenticates station which value is provided in mac parameter.
  * If mac is NULL/broadcast, all stations in associated station list are
@@ -4027,10 +4027,8 @@ static int
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
@@ -4045,20 +4043,10 @@ mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
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
-		if (netif_carrier_ok(priv->netdev))
-			netif_carrier_off(priv->netdev);
+	if (params->block_tx) {
+		netif_carrier_off(priv->netdev);
 		mwifiex_stop_net_dev_queue(priv->netdev, priv->adapter);
+		priv->uap_stop_tx = true;
 	}
 
 	if (mwifiex_del_mgmt_ies(priv))
@@ -4075,7 +4063,7 @@ mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(&priv->beacon_after, &params->beacon_after,
 	       sizeof(priv->beacon_after));
 
-	chsw_msec = max(channel_sw->count * priv->bss_cfg.beacon_period, 100);
+	chsw_msec = max(params->count * priv->bss_cfg.beacon_period, 100);
 	queue_delayed_work(priv->dfs_chan_sw_workqueue, &priv->dfs_chan_sw_work,
 			   msecs_to_jiffies(chsw_msec));
 	return 0;
@@ -4814,6 +4802,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
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
index 566adce3413c..58e8a3daba4a 100644
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

base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
2.34.1


