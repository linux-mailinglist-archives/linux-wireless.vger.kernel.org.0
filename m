Return-Path: <linux-wireless+bounces-13756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BF8995FEA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1249A1F2488D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DB8176AB5;
	Wed,  9 Oct 2024 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ikzJSROV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998351CFA9;
	Wed,  9 Oct 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455845; cv=fail; b=j1nrlSxh33rE0ghllUM09ghjigLnS8uwkxt29PBZoifpDzKzIeU4NP3ZrYPMbZXYRDuM83US/zvLmn53b9yiuOGvUn5ruE8NOlcLH7Ec8Rbuw8OtkzVnEtXVk2MjwAaAL0S2NZF0J0QZUxZ92Ha7wHMDHKOWTcXycphzJXF0DZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455845; c=relaxed/simple;
	bh=p16XK7VIUtWNNCzh/++RXgJoCtnFp9nDsY3xuUT1/Is=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LDmz652kzMvZqjcwY2E2lD26K8p5BWh3Izy58nRyh5bgOBNxCINmklpqR4XXd1B1yZp0CBt+JesWmyBWjT/hM4fAhkoVanTfSMMsR0lCW3ZM57HagjH7ABQLf/wu5osejp2oa3LYrwYpxaM8cnSGdMLk1WRSA8mZwjnJUSGgRvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ikzJSROV; arc=fail smtp.client-ip=52.101.69.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLNFfrdn/qzPSyevQfZnpKMZOvvsb9MS7jHGqKUjlPDnZmxQ8np9dTBwoWNv4YP/zDzQcZM6Yg16tXs0OzwuTvu+aXVyvQDO9VDhiXWSyy9YOG/YwS++ptxVlv0cZJS1Nwbj5Gyv2aQjC2gzq/k8lYjdo54CTouKmgM3QaT64VF2La2F6d8peZPDo+xLwwMD5GktiVnFMWXkWudbrUOd7Mti7+F0r4/joaMeNNfLeGLRV41X8e3V1FnvEI1+dQVK48WyKftYRSki2cM+76Kf3Vq2snNSH02XwTDxbfGcLWn3sw5cjK0XJjDbqj5GMJtRhlxqs+HnokjLXQpZmlC81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cjLvOa84vkSko/yDpQQb0zjFmoz4CoBukj+zxMjmno=;
 b=y8KAHyjJyJOPFyyZ5BsZszZSH13MHKPO4ZilPA9uazC6R5NyTvYxqZ4L4vyDQEDrJjwBpMvnaOKt8IRuqs/a0ReldX4irORXyzu4MDw7KtaiEepSzy8ly5SI+G4/OVybYxe9tlNIuhkvpwZuG/lrJuLlQWCXme9Hew7yLs5DY5WA5PKod+8898ATFlSkiNMMgHpc+6lil5Kdrgcc22LAw2X8aNmDLihMCKGAsEQ3knqXcJzPhH1xiwWf9pKvKhozNeNDUJfosmwPuThhPb2s+nTou4BWrQdfcns9Ag86E50XC4z0kLsCH2Di23LtnkdWZmDNDRNPIi7K7UkmZeYBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cjLvOa84vkSko/yDpQQb0zjFmoz4CoBukj+zxMjmno=;
 b=ikzJSROV76MVxb4GJNpK8KOrWmKVDe934DrCqoz79qgqWrCflzYZ2DlP/p0oWl/bgjU3EgdHVs8lnGM2oJCn02cak/63Y4l3ibW5lmCVgMTmGdNYGPG/YrsIgHFaYiL9DgHMCyURZ8jz5FZITyPDwmXGZ9tv5+NlXvYmYqIeNhAVDNZcOeDarBgQmbxHlYYJDktT4EmKYKqkAHaN1MkpuN/HTzr3yJLhdEQg/KvUkBbTvRyIX3YgSeYdvaGx5FMGZVZCNlGM5huoc183DVrY/sGr7gA6zOyF3iHaj4C80ds3KodeU1nULIJ4+bKVzB3xPh4t5aur380h8pOlDQ2qaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB9414.eurprd04.prod.outlook.com (2603:10a6:102:2a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 06:37:20 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:37:20 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH] wifi: mwifiex: add debugfs file to mimic radar detection
Date: Wed,  9 Oct 2024 14:37:07 +0800
Message-Id: <20241009063707.9316-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PA4PR04MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4c9f14-fa06-4edd-1ff0-08dce82cd359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1tTSzgh7uayjwG1uIOfVoHaiY81xqclv6y++CscQ/i9CZDuijijgvUoj2GTM?=
 =?us-ascii?Q?W4d55PSTd3fBYbSXwpiRahRvr5l2bdXGgnjKQMpzRQbTwBhTuczcUwygQUVD?=
 =?us-ascii?Q?rvBzUtTalyzYPdRfy4qC2V65lD14hSJTd8VGSymHfp3f5fdsNJFufM1a21YS?=
 =?us-ascii?Q?lF8FTXi3eg+PH0XE5aZ20+dZ0ggq1DjGoFdlReJjDlXje/HB+tGX9Jp2RG4q?=
 =?us-ascii?Q?1nIQXwgbFHVb4BRi1MPiRpdbgxhZ07neDiocVkkzrplOJ40yH/be8G/+CJLU?=
 =?us-ascii?Q?8WB1vZ4NGvBLJQcaFKeSR9d9FYFfaSlerxqZHVK7i8ExJ25VU0h+05JSETD2?=
 =?us-ascii?Q?L9CONP1LDP+c8IJs2t5pr+tniYFjLXY3racB7RdZ0rKRFXUATHPBTxJzVYQT?=
 =?us-ascii?Q?55dT44bu4rlvQ4JZSQhWMy2tOJJtOw27tGw7waIc+P6x7el0PbtMuWXxAKC0?=
 =?us-ascii?Q?cVfSsm4CcXQ0bDNWyfByoDlxnQ5nM8NLr0Klw0udLsxjK/A468sQEjsJFzCw?=
 =?us-ascii?Q?1YewxTDbPJuIXpdZTyZwVqZfA3f8bpLpHZUQavr2xWVGzEog0ffP7ciJ06S1?=
 =?us-ascii?Q?rTLZy8G3GbEcDmEg6b2RZfmBfxKSz0XTJuWM5c534q5Er8yhEfwfkzAAGs1n?=
 =?us-ascii?Q?oUy9YG78SN7+Mq6Xw0NzXmBuX1/4sbuPFgLHxWfmo2JhgJWs2ifa5dGW0h2C?=
 =?us-ascii?Q?dzU4pp7cIKrZajJ6sKMv0/H3kHNDnwyakubgDMtGoIb8GEJcvhsln1awnIpQ?=
 =?us-ascii?Q?/9yvZJ97LporqGHxJ2kawj1gMi3y7CRMIw1D/2ATuO0+4VSulXHDLVGdDdM9?=
 =?us-ascii?Q?/Rlxyg0GON2AoOfRG9nt7xxnBpc1LC0UJH4BSUsSGQTRfBCK4QjGRa7u0MJ9?=
 =?us-ascii?Q?QAgpuYX6o/l/uX5PsosueSDTfctCzT9NLBGLJCCumcW3DHaulTCs9CTWzbUn?=
 =?us-ascii?Q?UtpKYz+kSPpTvDzWMMrYSylQLbfmbD56MD7OSEJ6Ncd+5qx09MnuLTm9YU9j?=
 =?us-ascii?Q?+8TUFSkH7rHZCON1TF0XMX4h1/L+jwNjpA0geOZBd882zxoies6EDC3oVDd5?=
 =?us-ascii?Q?m7Z7PVkIale8IdC/2gj0SLospzaROdlFkjbDavXiWT2y3Y9Dvb2Cy1SBSu2x?=
 =?us-ascii?Q?pJM7DTEdyDDVVKT+Ys3xpm9Z9V+1hNCAwngQ50SDfEZnEWxSeULq4adfRzA7?=
 =?us-ascii?Q?kAf1ZwbhtKS+m10ySdI0SUHhAjBUtVvbUKhrIrFC67murgEoz7tnw9Pi3t4/?=
 =?us-ascii?Q?p90UUFcvDf0hLXyYV0TLNnmlXvgJPDRLAUtf98sWCwcEqLdFV/q9Y5cx+j0T?=
 =?us-ascii?Q?J+iQpYZIuBkEXi3C4AKXrXVXiYOM1zFFDtw23ngmk2ydxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mBUqStdmRmGgn6chbqgG8mhRSW4wtLgZgD8irGlZ6OGY+NpjQ9WMrfllWez+?=
 =?us-ascii?Q?Jedspzn7qI4Z+EUazk57vqUzr7JAIFtZOPMHpD+oTkvBzTV/KCC+D7PWJFVQ?=
 =?us-ascii?Q?AMPQqf77e/OgeV67RUvrBIYnNn458CW9czmmYTJ4YEPEnZwoOrOFVBGpehK5?=
 =?us-ascii?Q?4g8olBhawzULzy9cXxemh2T65mrFFET3qVzFbgujjU10NviCP3aUngWALjVe?=
 =?us-ascii?Q?v3O1kIbT/EJM5bmcl5dIRvdpWceuY0HkezJ+kR+CqwoH/mWH+ihONrgQ0M5x?=
 =?us-ascii?Q?WseJVFl4tVpYMjc19BGe9jrz8kmjJb+Q5trQJvDhv2sVSJIMXS/PZ/81qS9Q?=
 =?us-ascii?Q?U118SFWNYMrbjbXacfABtXPSFJbuvKv7GHNB2gxX2OZKvUq7yU6ifpl6t5JN?=
 =?us-ascii?Q?ogtrCmvLgfu2gWiOlbJKdhkqA7ML8oOYUV/HtDEL9exKyhtS8OBsBc87fmWD?=
 =?us-ascii?Q?mYGJ5SUrBYESwlU5o33vWNkAI5JfN8p7mEM6FpqmVfxu7MBiQrmdeYRkFszn?=
 =?us-ascii?Q?u44Y4qurLzGbUjkMa8HBspbhia9qMLo//bD+hwrJKqVkyBUx32ICiRJ0RtG+?=
 =?us-ascii?Q?xc4Oorg54VLBO10Xjp9eGeW8wfzM2a7YzwF3t80OkiDgjHHbhtwfxzfEnPI8?=
 =?us-ascii?Q?9iq17RzQqCpJ6NA6o98sIMVufdzDjlcPMLpK9hOn4kFb97i6KUQ9L+CQNglp?=
 =?us-ascii?Q?gD7xJMP7WQYVP2kIFRfT8aooVX9kyIUVlrSQi6JXtAbpf6fRe4JevNC7wFT/?=
 =?us-ascii?Q?8te/9Litt/hDaTNhaF4JsUpje3UGrinavm/iQzrtjl44OZIRmEcSOvDiUF0k?=
 =?us-ascii?Q?oCa0zTtpdD1ff5Q8m/98nAJyMVLeQbY3Xq2jJKL8+jDscaV6DOSP5JttBlze?=
 =?us-ascii?Q?GZciVXkM63V4USLCBA6j3EE+jZw3aBSB74NzJb0MIJ2kCV+0IChs3blpOOwH?=
 =?us-ascii?Q?zAasggfNqQsrrpTFpYFA2k728oLhVSAyoAGhRbqWTuMj4iGGl9y3Vne/i3uu?=
 =?us-ascii?Q?4Oj2TCg/Ao7lx/CYsrJnvGifsxCJbbv3CxF8xSl9O9/upfsvpO9tPjYdkwPu?=
 =?us-ascii?Q?ogKfiYk7nY5CEPjpZQ9BCN/Ke4b9WYjuVR8IYH5j7ZDaX3nTUuC9DSU0HhTX?=
 =?us-ascii?Q?PjXp1xkePwlgJCcHfvIvM+YxzGvgCr6cdcGpD1BytBdoGLYH2gZ68v3VJoYI?=
 =?us-ascii?Q?cyMdKOb1Wz/5k8PGpnqEvw+5usDFFCMnb9qTEHLi70XVJsZQVRkPNa6yz926?=
 =?us-ascii?Q?BQK18MBN8p/i/MDXlskHqOUWMe4wkr7xhhx1P/nTCqeWjuzqHDcDV/+/JyQb?=
 =?us-ascii?Q?eYgaFMDX1BADtTdFUP9grjGfm8L37TYoR5tw0vG2B7CT32N5CWcWf9yN+Qxp?=
 =?us-ascii?Q?6Wr11wgGrMOVo7gVo0d5U19CTzbhXBfUP9mfeKwRsmVTqvC8/jHn48HB4EF1?=
 =?us-ascii?Q?pyLde+yYX7bk5151IBy0PY7TtkLXhZI49co8GI1af1/MeYeNlJ5XYm4638O5?=
 =?us-ascii?Q?rxjR4w6Tyu0DqiM4YauONL43Qz4nSQskaRHSVjANafvyD59cpjiESRBaf00l?=
 =?us-ascii?Q?eAD62gb9fktbA2eoxRoxtJSVvmhFo9nrJ8xG3MxL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4c9f14-fa06-4edd-1ff0-08dce82cd359
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:37:20.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAAvdnJoywSvqCCKqioFcU8CRlP7Imyj1Q1WMB2W6/C0krmFQ2r8q4Fvc4HTZjY/Fn4RntkhuoFFKLRDjUNIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9414

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


