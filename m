Return-Path: <linux-wireless+bounces-13752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDAB995F74
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE781F247DB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 06:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715AD13B59B;
	Wed,  9 Oct 2024 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mK8HeZ3o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6C36D;
	Wed,  9 Oct 2024 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454199; cv=fail; b=ZxTHgQ/VBvM8Mlp5d7DcAwx03DzmoyCmV6If+JpBdZr/n5G5OM879wWVZFfmdYCWILG2Uduh9B0rL2bVTOSazFj+wPQ8v6R67ndC30nc2VUv9N+fzKM7IedgQ6qZegRzFZyeeUf5rYBg9O6doOO9w1m7rUszctvIUCGWqRLF5AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454199; c=relaxed/simple;
	bh=p16XK7VIUtWNNCzh/++RXgJoCtnFp9nDsY3xuUT1/Is=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S2QoGLKEoQ+NWC2WkhcjWZMRP7OXBMcVRLrE87nQfhBm4lAFnrwBxLDRR2chW60Wm3RcBnZm++XKZd9wEEJO//Z95J408OXBMRgAXEncejhUBj3mAqf7KE6MhFUQPgD76W1hxBDtzm6lRzPtNC66eifl3i7/Lc0eVo+vZRgwdiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mK8HeZ3o; arc=fail smtp.client-ip=40.107.105.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4Q/DrpsaQcEovQKQMFoUtuP5VzEG+XttjMhH9U9lXII+o+bakTGRVTaGPaVQZEmAVCNCdbU2ytXGduXVNz0D2eRDNHCbMM12Sd0D8FolcVEEo/Vo0BljQ3DSEz1Cx7WTUlAZf1/SbruJsFYCwVnHGMWNAoLJhglZ189d2b8Fa2+XK6Zc70Y4hGAAuTvd8E5TNoFKZjuNrrmXChdof/fEljgLI4fbphM1rndSIknqsLFbZiDFEcpsUzjIxgHPC5ozkiCcyxe6t51U4NVGvoic+vowNBfl7Gi1OVxavUq0raIsnaDzN00Joar/R9rEMHYjku3lv3Gjoq/q89owkpb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cjLvOa84vkSko/yDpQQb0zjFmoz4CoBukj+zxMjmno=;
 b=R/eJHaHg2ikfxQrIiYpOy/V7kUuAwl9LPxhnWjc+gCjR/uU9SO7cy7LB3Wm+wEn5UcWS5g6lh9Rg/3fR3JCeIC2tU082WzNoQn6VGShrwwGOPNIfwisYfYlWA8KyPpSEmVa5jkNRX8TSpRYm7EFGYex5lLhRxTX7sG1mt0qek0cuAlnMa/iCXdhZpsZoErhf7DE4Rx8mMEeBepLXZTXICC3n0ZLqQAK9bRD0faYFKjV+mfcMHCySkQeoNSv/+i98AmkQtAPnnTMfsTvTzyLwxY0LhycglVfXfh1oCH4yEPkWndVHFmEvdpLE833iTDhnMcHaq5g2XLnEDyE+vA9RNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cjLvOa84vkSko/yDpQQb0zjFmoz4CoBukj+zxMjmno=;
 b=mK8HeZ3oEwyX09m0+5y+/7Kq8VolaqwMQMXquI13iSBHFOnQnuzf2c5Z+RYKHF3qEeZiee1XrOpVV7QRbsdDCebPS027lFqT+p5qPCgb9uZesoBMGgm4hs+OpW5Vj2T6yMF3KA62Dvis1xexAw7fqbisgyol5bBgRiuSQe3gcc9tl/mVgI5JZpFwd+HIITg/JXHWK+QDjWgQnuSSbIsr0rzSHBw7Ys6OmSms+6fdwch1rLSpPu2JjIt5UJ99T1GuX4aYX+FuLy/Px3lisHgPjhZyHSQOk0zkMjyBHKNGpW7xZrWyCqifkzn85ah3Es49JSfDDfnVb7Mk+5ZnDmFdAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 06:09:54 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:09:54 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH] wifi: nxpwifi: add debugfs file to mimic radar detection
Date: Wed,  9 Oct 2024 14:09:35 +0800
Message-Id: <20241009060935.9074-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI1PR04MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: ed47b2d4-330b-4587-39b6-08dce828fe3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GtQLtkjWq8SzB00+Y6MbfoCq7wwVRev8PBgTKRh0DLosjTcJH2Doc9iZu6s3?=
 =?us-ascii?Q?lOYwuOgpwE4Ir9ZDaY9u08OSzPI0pqZHnKZ3U84E0NHM7V7AVVpbS6/1Xmuw?=
 =?us-ascii?Q?rnGflPnwaDz3z0o4FyRJiQz0Dd3EfxiwpREbN7nch6uH4IV6Jvaxecu/QWQw?=
 =?us-ascii?Q?LP7uAlOXAPFNWGlYJDOeYmhrYoVmqJ+8oBF+nVCDcP7H3zh6hUVOJux2J7Jf?=
 =?us-ascii?Q?X0CbD02j78xrxwUy8GZnqLy8UeIOlwTpGNAovFyD9Wf/uURuZQAFj8vuV325?=
 =?us-ascii?Q?gFbhnnxx/Us5Jt/oBh+wb1ApCIAo8slTw39w9YJgCy+/RktmEyZtcLHkhS2L?=
 =?us-ascii?Q?5VwE8ESsOZeggdqj32l0xRHRYfzmJ2SJHnHCfqWtGyldXhvt7CevDx80La9y?=
 =?us-ascii?Q?sOdFOC/cAZcQ1zkO6IbJfBofEa9qe2+YKCZONgOEGDpoHWXXElpVypMPjeZC?=
 =?us-ascii?Q?uj/5wVbW7wLOx9y8TXXDanhqf/YR1oEuPBnjPAdHieGRerWkeUxl8AdAAYGZ?=
 =?us-ascii?Q?N+xvyHQxnJ4cBQyWVywiqREgKi7wV85BrTAiSNrYIZk+TquCafs1zs0dDmfM?=
 =?us-ascii?Q?AH2JWk10kdtPd5gRvlLyf5jcOI9gLF0dQzLOyruBhpBr5shB/7tlM9RDr/mJ?=
 =?us-ascii?Q?pB6jEhsQa3IrYmxyHnlIsgMIepjrj1oNZAm4P6jjhm5SbKUtmIPaaBLkpTJE?=
 =?us-ascii?Q?1853oSskstuqil6y/hx9UdU8GdB267ixRMTE9Gx3epYTynWS6pv6275Ej/RB?=
 =?us-ascii?Q?VxvBtzDJK1lJpuLSxsJBvjhH287/W71v0P6jEwwejf+MaZpwgjopMDfVoeso?=
 =?us-ascii?Q?Fjk4ZZLZsYovE5ljAvY8Qs+smMfAYhivSF/tThAqik6d0u7NeNFCW25E49Mu?=
 =?us-ascii?Q?4gs0+/yHZgohp3FNPeh2CVtovCbVh1QjaEDKQQJiz7SfjneAh+EoUOQhPn94?=
 =?us-ascii?Q?raOISKoMFFmlLdij2bCBy1aMwsgX7BWS8VfTPtoyTXvc1KrKVGIxDc//io5z?=
 =?us-ascii?Q?iCDUZkkpH6G9Nlg6Fo6Kn8+NYvJC4Oll38HrDzsu6CUkxz1g8WpOA0UGz2rA?=
 =?us-ascii?Q?GBGBznltiE9GVdaYNlmQQ2TX8Mj5Pl7kNHsKQOEGw+FXTbjk77Wour8iKpKh?=
 =?us-ascii?Q?Des1h8te3P3Wngqvn8uw4eHA4VWlQc0X/m7t6X7Mo4myUkJwggWLc4axrqaH?=
 =?us-ascii?Q?AEHWT4dDLd8ZVc1ef8+s6+8nXH3MN04os6OIP4OzQiNCB2dY7Nq1qRIW0wfN?=
 =?us-ascii?Q?T4gSvT5aRMdvmhTtYpFuKSW0ae6HE9O2pZGhPaLlQJHG3macW9d+4I7qQ8mc?=
 =?us-ascii?Q?Ogaze5r0XQS6QkTJcStFWoUwNe4rd41lCTKfMojwoU4aJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hEgaMthd943lyGUstzlc0jse8gFRs3gG16C9Tki7+QQikaZ05vMm4AX1MxuF?=
 =?us-ascii?Q?51KUm0ctwpFnHDds7KiWogC03GeQBAJTueezoElqlWnKGCbgqQApAjildbhE?=
 =?us-ascii?Q?7zBC41qQ8XFEN5y+i/5sSKktNkGAU283vzlRqKED84Ww+MkPMpDBnMe6baNI?=
 =?us-ascii?Q?yxvWLnfBRiDzwLghfvuKaelUphnJ12V+K/F33k5B+IrbOBjV10k5MDfwcr6R?=
 =?us-ascii?Q?5k8w0Psv4d1JMfm8G61P/bWVNF6a4P5c9vEXVKA2KOECMIkz5HqafiNKfgKB?=
 =?us-ascii?Q?34tP4LlywMaj+OJd4D8QMzEgTsDFq5d90Em4CbxoYNTF/HlFh6ME+DCygY/+?=
 =?us-ascii?Q?Q+GA6mMc7IxbBMhFoNCjlSAk/GMOkSdUcC5uXozGwnKR4GZu96LguMfbNEEL?=
 =?us-ascii?Q?9Z0UFYKq9VWGpqFJbl5lsjQqV9ZAgdbHi6z7FQsDq9ENehOG/NxWpY7qHKvL?=
 =?us-ascii?Q?ZEPKdtU1GGyW0cwY5PwYZdH6diWoLS+s7N4tgCp7IGMpCYW3JWv119mu9h6D?=
 =?us-ascii?Q?W8oHv+OpAw2OsEkInsR/SEj8UsVivtgVxkxpdp8sDZEpznp9TW7ut9BoT5Ar?=
 =?us-ascii?Q?eCLLLkbSFgqJY7NUoif2VMv6XghkolTzBY5Y0mLDiN2/SBmzUWAIG6aRfLI3?=
 =?us-ascii?Q?ltN33lefGnDjn11zUQLXFOZsPww5qplobANwinVADgQmh34P9KPf8TZTYxfa?=
 =?us-ascii?Q?woSAUPH1MivyI4zxBE3RKJXHynCTvyIH4j0aGia26rO5XZbZK0+15dGugZNX?=
 =?us-ascii?Q?IVKzWKopkadOMLFIUycd2rVDeZ9UDxpAgdfgd3EgHjSEXQbiSXl/vzOA+LpR?=
 =?us-ascii?Q?kqIsPc3YMucLQ35nE2HokarPzGDvc2gpfnBx0waTvg+DaTRCJMgRu8m9G819?=
 =?us-ascii?Q?pcn1CikluHFzICWaB9Cz+Vo78r4zws6rBQO+mzeATcer9e2Xczyjz9QWg2Lp?=
 =?us-ascii?Q?e9RamUgrZRYszSBbiDVeXq4s5/JRcyD1AnQi2iAU5pB77edO/iYTQGE+4suW?=
 =?us-ascii?Q?MjRRRFlgOVFmRhPDdfw5ZtlGn/JQ+jreKkXt21+QvB5jfohQntJhBFAVRKme?=
 =?us-ascii?Q?e/SuJpz51pdPTATgu4OL5yRCQPjJFJ12zqVRDKxtZdvccFi35pxvhUjZmw4F?=
 =?us-ascii?Q?e1HJAyEgvuoE3pg3fdhqWMC4Jdnf37KD5lRypVkMpRwmxx17+/OGV21ja/zn?=
 =?us-ascii?Q?AjveB2u/eL50Gsu9X5+L/RfCAhiuu+z0rzHlQ08BLU0ELpyFk3W+xamMay9U?=
 =?us-ascii?Q?R+P6Q1ynbQg5FRGwb5LySCgbvs0tWTYA/QVDsls48Y5cTXnkyaZ4q9Jm0gV8?=
 =?us-ascii?Q?9mzSBYWvzT2Clz9duPuAUXfmANjhgzlVyMJLoM3BsrCd12Tbdht76y2HZ6Jy?=
 =?us-ascii?Q?3DVjsm/827hZqVxB6WTy/RcvkVD/rIj0ZK2yl142YyM+RAb/2fogBgnvj2a7?=
 =?us-ascii?Q?Q/Xz3wo7+mEoWHoUT++h+ppjMLZcBTjAgbNN4GDyOHgvbLy3+ijHWDvgzoqj?=
 =?us-ascii?Q?3aQhrYVjltRM6GKwYEfhJWD5fChKEoepqf7Zcjl10Lwn1H85B5u++RNhETh8?=
 =?us-ascii?Q?MOjtHN3UauxeeJmcPnJ1n4t03r4zMK1x5FTbDY4G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed47b2d4-330b-4587-39b6-08dce828fe3f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:09:54.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNUb+WGgT5qHDoV6UhG9CKmMdyrhzjlv9tZ+wWIjy1SD87qPkYg2FmR5qwsxYSXo2iU9KoMeVdcv8bYB5wvfqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813

Debugfs file "fake_radar_detect" is created to mimic radar
detection. Echo 1 to this file will generate radar event
to cfg80211, which can be used to test AP DFS mode without
real radar detection from firmware.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/marvell/mwifiex/debugfs.c    | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 9deaf59dcb62..cf9604661aed 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -909,6 +909,47 @@ mwifiex_reset_write(struct file *file,
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
+	if (priv->wdev.links[0].cac_started) {
+		mwifiex_dbg(adapter, MSG,
+			    "Generate fake radar detected during CAC\n");
+		if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
+			mwifiex_dbg(adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
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
+
 #define MWIFIEX_DFS_ADD_FILE(name) do {                                 \
 	debugfs_create_file(#name, 0644, priv->dfs_dev_dir, priv,       \
 			    &mwifiex_dfs_##name##_fops);                \
@@ -945,6 +986,7 @@ MWIFIEX_DFS_FILE_OPS(histogram);
 MWIFIEX_DFS_FILE_OPS(debug_mask);
 MWIFIEX_DFS_FILE_OPS(timeshare_coex);
 MWIFIEX_DFS_FILE_WRITE_OPS(reset);
+MWIFIEX_DFS_FILE_WRITE_OPS(fake_radar_detect);
 MWIFIEX_DFS_FILE_OPS(verext);
 
 /*
@@ -971,6 +1013,7 @@ mwifiex_dev_debugfs_init(struct mwifiex_private *priv)
 	MWIFIEX_DFS_ADD_FILE(debug_mask);
 	MWIFIEX_DFS_ADD_FILE(timeshare_coex);
 	MWIFIEX_DFS_ADD_FILE(reset);
+	MWIFIEX_DFS_ADD_FILE(fake_radar_detect);
 	MWIFIEX_DFS_ADD_FILE(verext);
 }
 

base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
prerequisite-patch-id: ababe4f5cc6f52d23552f4ada6efb26655f247e3
-- 
2.34.1


