Return-Path: <linux-wireless+bounces-13288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22CC989A95
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186A81C21163
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D887E154BEE;
	Mon, 30 Sep 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LREUvFJP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99784D02;
	Mon, 30 Sep 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678264; cv=fail; b=lm8VRxH9P/KZGJjVAdNs0+yBepYa0HthwZAO7+fiLigUnvQl3zkaLvENrSrsG5N2/G0+BGxeuuY7heRxXZJI+j/Hd1z5d2UhxSKpf5AmX8xE+qA3vvOp1IdKgtlkxHvjTsqStD++N4NURXkbj9WcYCtlei5jahV6bvA2wDNMQPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678264; c=relaxed/simple;
	bh=PN8jxJEORBwQwSFHGwCpsH55jYI6jCDcjDsbui3Uzi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CFQvjShKWrGjgcYFLt4TNDAsz7LpXuvY/WVcGQ7S1Tu0su9F13G88cBjel7QF/hzzrYUyGIgmzY1YmUqYMtfa2W9k4WkU1Qq9KLkg65or30dkyn86gUADbuo+wvpqsJPHjuXy2JTUjXuimg3S+ckHfVcztUYFfswBYrUK8vCWkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LREUvFJP; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8AQtFmwS+l38ZGD1UEonYrLaOlnFkYXBHp7LLnyrLEGNDIhdx9Cuw58YA4E6xE4mI6mSUglQf7ENmT5lGOD+Pb0vEGA+m8R1x7hLEmFKp3BiFUiHiuIvaA6lXh0QRbhl33TrSkX4eF7FrqIIULLXWFQkqTp6pY+47jZZ6EvmioviyrSDYkuON2VSTFa2Z4+TjYb7V488ViYJ05aKf1RmW0w90P/uLZHQckF6IJCRFB0BBI0p6i14Ym/Ej7sMS9dmWmQWCX6LUmGzHU1pD8iH8cLNf+Gm+1IZkt6wf+Cv3BwUtDCvaR5p4ormcqCuyOVOEIw8BMXC12+AfYQneI32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b16w7IAgMPYPy0CWdJeYv+KadFDHo8AjpnUJjk7Fe9M=;
 b=n5Rx3tY6DQlP+8BkvZmzGY7SMWq7TQmVctDp9JMh8Ni2ltX2sTAuRIk0n1xKXuPB+5Od99RnpNZY0fCpBX+WQXAPnglMQLlg7C/UuaVPPj0GHquL3aPHdd2MYsw7YOnbLH0aqMfuPwzHmQJMjlr9a402IVSk+rrriJVmMJMXsYIE9ggw8FRpWPg7kcer7eP6ZIOHv6VDMLoDkI4eI5zvumHQcSYaYDHPomBfGiDZRI5Pn9IncACnW/iz2GZuZR2Q1so9Uotm6l8TEFbfislSf3VkA7qb5rXS4sXEwNqjoGFb8e8z6ZBCiI5Gq2LOJoPkXbfCH5DKZ6uWMLpQ1Uybjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b16w7IAgMPYPy0CWdJeYv+KadFDHo8AjpnUJjk7Fe9M=;
 b=LREUvFJP6SYgeUPI2E4sM4f/ypGOYK7PgZc0lWkIpsNQBKCwtvap6DH+dIE9upEMt2DyJWhnc+xKTJ3KE2WIKXq/Gi0sqA2HctvV34od+3AzcEnysxuIc1vR+Ckm7egf0KGGJFlqwuzY2RIzupiL/UXhphS5LdJkAjAc2CIHxM3SquLG3cieZACRwC3zoCr6lZ4TKro9TApc1K9JuxNVAqio8hlCngoCUGrexJZzRPo2k1CGSSw4cLCJlhPUaV8E/3pskDJKEh7nTwTCAIVUC4cnKwtZk3gfBLb/sW16YID0787e4DQvI67EoGzRJ2xeS9lJ1Z8EbGGNGTiZykcOYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB9000.eurprd04.prod.outlook.com (2603:10a6:10:2e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 30 Sep
 2024 06:37:38 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:37:38 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 03/22] wifi: nxpwifi: add 802.11ax files
Date: Mon, 30 Sep 2024 14:36:42 +0800
Message-Id: <20240930063701.2566520-4-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DU2PR04MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 8447f303-1607-49fb-5f9a-08dce11a6005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m8BB6GSLUldt72HN4PF+ejRVixGM1QJV1iqtCyuXHhR92ad/RUGjksYhjhCF?=
 =?us-ascii?Q?x0Ea7MGqDU8WJFfu/GvCSSK/GAF8qCoUETHrQjvNwGc/kfPGxfgqTMoe599k?=
 =?us-ascii?Q?vEDkqHPlC+civx1xoDMrSnWDyw+fEjTzHygd3tj6qMcqN7I9hv5iyce+dpW3?=
 =?us-ascii?Q?LM6hF5QuSpYRkyE+zRCB06/W48PkEaD5t/x7rEh5v9Do2fjmgERp39LoESpN?=
 =?us-ascii?Q?4eqfSoNKCec1pb7kAKCaPQRawE+aEIBaiA9jBdYmhwcdr90Q+LwNPrZdQspd?=
 =?us-ascii?Q?mgHyF7rJlP8O+8TPUVfQj8ztuFJUGlUTVMwwc9amCD8UQ8JRF1GorOZa+kV/?=
 =?us-ascii?Q?YrOrJkUX3dlbIvhn+tlcibyIt+pPBofSmNja1j/5lQhsCmsbKaKwoUpOKtH+?=
 =?us-ascii?Q?DuNHh9CMj5cRqDploULL57XqS8z7+0vQn9Nb2QH3Zsq+urjtZEgDiBEJue/L?=
 =?us-ascii?Q?rt6qTBO6s1zqwY144UUaD0MxJNmqfqYh9kzVEVE3cManAyLuA7aeYFfmjUvB?=
 =?us-ascii?Q?9vDC9Pv6lpoCQRe9zzx8sqB/2PB8ZbuOrvDt/je6JOtzIuVCWprvp+RXLHzx?=
 =?us-ascii?Q?GzUe459EUeEAB5IDfgFh1rC0qwP8Yyi26as/AKtXnzweSO3KBQaGhqvKvjc5?=
 =?us-ascii?Q?2XnAB0rrXJ5jd1Olje/UwYHHuIyLFelLsGaq+5EVUPeHihb8izVyM50r7wpO?=
 =?us-ascii?Q?PodZ2oTx2z+M3gmhYPi3Tln+MxUDipALLyeGP5dpXxJIzKz/UEDYy77OzQBX?=
 =?us-ascii?Q?wvLytgZRs6Wu79PkhGY8SWLMdHYQda+OVexVNByK0OX7BYa3w7A03YzF0L4Z?=
 =?us-ascii?Q?ip1xGSLvg8lNMuOf/+HCOSEmbQGaRFsYYMQCPrXbp2FGIslFAEyxgaBJsBiD?=
 =?us-ascii?Q?PX+0wLRqZXPZBP3W0TmZixdG06MWe6z5cKKSC48CrnM8y5xRnSy0tPJYaRUo?=
 =?us-ascii?Q?+/wafslOMZnYlUL1EeCVYCj3/x23okbluJE47Y2tM9bfWudlJFQujlvWJqlP?=
 =?us-ascii?Q?EwGrHq7LM133SFoHB5KBIxaCDHTGvG6gRczJJLER/aGH35pcxHCFNhdxWXoz?=
 =?us-ascii?Q?fmC89KaV7lFoHm1CYwgzOGPrcrrs4m+SDUnzkJfORukJxq6101k7gudwPysW?=
 =?us-ascii?Q?kcl9v2qE3Lhkta/uBe6ZZoFTIV3uwhH863FWLmdps2y8943GtnnON1ryXY3F?=
 =?us-ascii?Q?KrNwawJT7h/R+AOH5wkVpzMmoH8PQxiSzb9Ft0yVQM5aDTJkOpvxcz0g145D?=
 =?us-ascii?Q?6HCBCegKe4h2vXWwo0ErnLXe9SHQDo0Yaps3+cQ9GwvgB9y8eM8a8yRTMATc?=
 =?us-ascii?Q?FLGwPgW11yPWY68hbgIObckz/Tq7BWFXsgHfz9ARBxaJyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IAAZOPHmAnSX/IiA5UY7NwrdFQBTZ8eWq0F0CdWr3G3VAIbzMNvfoniBpk/A?=
 =?us-ascii?Q?zWqv7QeN5GsGQOWhxNQCiz/TewPI/jykdPF+PQ6VpGV0h+s+33xtnkyBScJ4?=
 =?us-ascii?Q?YgWTTdVZWWqldHWU/N7ww4gywjX/w6iEtugDESjJcxNPjVJ0aWiuRNvRC3gW?=
 =?us-ascii?Q?jPFO2RoZZo7dvE1BFfq02WgR9hP5I8Qojc+WVPs2Aw3YAvtpCuBvhYWYOj8g?=
 =?us-ascii?Q?M/gd+BtGT5Mlu8m1Hk2a4iuHiWZ+ArBvJbULCT4EJL0yi5MCD2MwGzM0c3k9?=
 =?us-ascii?Q?5Lsh+0iREvUROdekk/d8mvN4tK2MLkz/s8I8Pyr2DTLh/eb6GFlu8YPrmjta?=
 =?us-ascii?Q?6cclvjwirmU/IpC+3o70/5L32uu7aQ+iyd03g8T8A4PNnqzVN2kcOFFw0qON?=
 =?us-ascii?Q?G+huduMGVC6i6axJdPpFOsfWJdq1yzVjqz8N4P/kkpKuyZifCmpvnFmM0jWx?=
 =?us-ascii?Q?+I0W7/VaxA9lHq7QvVjwMBiDH+J1y3BysXB2SkFdBzLr7gHxJgCyKxob1JxA?=
 =?us-ascii?Q?VL1jv8hU+OMqONhhA2ESU0Ir7P6SSRQNrAGVRMJistYiX/IdbIBGHyS9seDi?=
 =?us-ascii?Q?n4iRjCj9gG8XyWJbluXbh5U6lsBx1kmDEAOjTdG/vYB/BrscQkyiMnmzxcls?=
 =?us-ascii?Q?wE+6kty7VqUNzoSNJ4PleWII+copkPenZ0PZP+qs0mOG/uVE2vlmRHO7Cm8H?=
 =?us-ascii?Q?9AQVvkq6y2NQyCVcQ0aQV9YGCDf2cF4zn+vt9rzbMij9ons+LZVmMWlDZyra?=
 =?us-ascii?Q?ijZTlSBiVQbmVRLbukyQ6QrodiIDgeGXkIjKrDb0GsvIn4KfiucokwEsSsyQ?=
 =?us-ascii?Q?hqZSRNdy0Z251nkvdAG5OJwj48I39HW0lkhaDclYfbjKJp6jMpR0a/2qzoCC?=
 =?us-ascii?Q?G/xrQ25LDhHVbBHCCEis8ne6FLAzhskZiGCa/7ubAi56kEdRyssGlJkS4+U1?=
 =?us-ascii?Q?2U8g/PeZWs82afsgPSlOIBGqgm9pZ+RRTdTITkfwE/lXmvI1JE4IcTgL+a6q?=
 =?us-ascii?Q?qOnyVhghbxWj5QfLwPXRG3Wsjn7j4Qbtxcre8ghX4wrQogMykqMn2hbgFVwx?=
 =?us-ascii?Q?JF0+26KAEeZaypDYD3a/xgE7WhW9c9ZeJSMpUgtw1cWPtTjC0zD92amJE+vi?=
 =?us-ascii?Q?HKo7FvN7puBqF/c5ivAg+5Ly3sxe+JLHV3DnJxISGTVKvpn9nGk+gkx/32z9?=
 =?us-ascii?Q?n1gk/vf23DhrM+9BCSmwlm/GfBRAcA8Fto48SgV6RCKh3js0lhQrf0G0ixMu?=
 =?us-ascii?Q?hd1KutTuDicCUdG4leVeU2y7Qy4xfot745n3EUTFQTbkBxkZhmbYNt2RJoqQ?=
 =?us-ascii?Q?bhl7yumPzAiypVVuhZJ5OdiwoUnrHfTp8bHF0CdQ9FxLN0r9NpixLujXOzQX?=
 =?us-ascii?Q?YCFW39P32x49I533UJsz6+3jbtbmG+89x5D7VZl+UyAJvPYzdj/omBSm/m3O?=
 =?us-ascii?Q?/E6Le9zx8SQ/MksUaeXpma5Tod/QEapp15V5juvLxvW83h+VAj+iRF5GpsgM?=
 =?us-ascii?Q?UZSK12MqxRQBiwsqLeqOJ3OKCMs0CUktDhfy29JmaxJGaT/fmcUcJf6ANm3T?=
 =?us-ascii?Q?BH0NE+oHLZdgbOKNsyY4wkUGqKGEtQ759lORO+vD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8447f303-1607-49fb-5f9a-08dce11a6005
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:37:38.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYD5b8L/7bqOpDWTz+tIPxSUBhnwFI296F6vGedjs87JqXDOu5ns3mneW6aFKFjrsmd+HhN6P88HncCAfNizMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9000

For client mode, NXP firmware will help association process via
host command HOST_CMD_802_11_ASSOCIATE. IEs for 802.11ax should be
converted from parameters passed from cfg80211 to TLVs appended
to host command HOST_CMD_802_11_ASSOCIATE.

For AP mode, IEs for 802.11ax should be converted from parameters
passed from cfg80211 to host command HOST_CMD_11AX_CFG.

Files in this commit will support 802.11ax features based on above
descriptions.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ax.c | 388 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ax.h |  61 ++++
 2 files changed, 449 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
new file mode 100644
index 000000000000..923f8100b576
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11ax
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ax.h"
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	struct nxpwifi_ie_types_he_cap *user_he_cap = NULL;
+	u8 header_len = sizeof(struct nxpwifi_ie_types_header);
+	u16 data_len = le16_to_cpu(hw_he_cap->header.len);
+	bool he_cap_2g = false;
+	int i;
+
+	if ((data_len + header_len) > sizeof(adapter->hw_he_cap)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "hw_he_cap too big, len=%d\n",
+			    data_len);
+		return;
+	}
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)hw_he_cap;
+
+	if (he_cap->he_phy_cap[0] &
+	    (AX_2G_40MHZ_SUPPORT | AX_2G_20MHZ_SUPPORT)) {
+		adapter->hw_2g_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_2g_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_2g_he_cap_len);
+		adapter->fw_bands |= BAND_GAX;
+		he_cap_2g = true;
+		nxpwifi_dbg_dump(adapter, CMD_D, "2.4G HE capability IE ",
+				 adapter->hw_2g_he_cap,
+				 adapter->hw_2g_he_cap_len);
+	} else {
+		adapter->hw_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_he_cap_len);
+		adapter->fw_bands |= BAND_AAX;
+		nxpwifi_dbg_dump(adapter, CMD_D, "5G HE capability IE ",
+				 adapter->hw_he_cap,
+				 adapter->hw_he_cap_len);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		if (he_cap_2g) {
+			priv->user_2g_he_cap_len = adapter->hw_2g_he_cap_len;
+			memcpy(priv->user_2g_he_cap, adapter->hw_2g_he_cap,
+			       sizeof(adapter->hw_2g_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_2g_he_cap;
+		} else {
+			priv->user_he_cap_len = adapter->hw_he_cap_len;
+			memcpy(priv->user_he_cap, adapter->hw_he_cap,
+			       sizeof(adapter->hw_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_he_cap;
+		}
+
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+			user_he_cap->he_mac_cap[0] &=
+				HE_MAC_CAP_TWT_RESP_SUPPORT;
+		else
+			user_he_cap->he_mac_cap[0] &=
+				HE_MAC_CAP_TWT_REQ_SUPPORT;
+	}
+
+	adapter->is_hw_11ax_capable = true;
+}
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc)
+{
+	u16 bss_band = bss_desc->bss_band;
+
+	if (bss_desc->disable_11n)
+		return false;
+
+	if (bss_band & BAND_G)
+		return (priv->config_bands & BAND_GAX);
+	else if (bss_band & BAND_A)
+		return (priv->config_bands & BAND_AAX);
+
+	return false;
+}
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap = NULL;
+	int ret_len;
+	u16 rx_nss, tx_nss;
+	u8 nss;
+	u16 cfg_value;
+	u16 hw_value;
+
+	if (!bss_desc->bcn_he_cap)
+		return -EOPNOTSUPP;
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)*buffer;
+	if (bss_desc->bss_band & BAND_A) {
+		memcpy(*buffer, priv->user_he_cap, priv->user_he_cap_len);
+		*buffer += priv->user_he_cap_len;
+		ret_len = priv->user_he_cap_len;
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			adapter->hw_he_cap;
+	} else {
+		memcpy(*buffer, priv->user_2g_he_cap, priv->user_2g_he_cap_len);
+		*buffer += priv->user_2g_he_cap_len;
+		ret_len = priv->user_2g_he_cap_len;
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			adapter->hw_2g_he_cap;
+	}
+
+	if (bss_desc->bss_band & BAND_A) {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream >> 8);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream >> 8) & 0x0f;
+	} else {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream) & 0x0f;
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->rx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->rx_mcs_80, nss);
+		if (rx_nss != 0 && nss > rx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT ||
+		    cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->tx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->tx_mcs_80, nss);
+		if (tx_nss != 0 && nss > tx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT ||
+		    cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &cmd->params.ax_cfg;
+	u16 cmd_size;
+	struct nxpwifi_ie_types_header *header;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CFG);
+	cmd_size = sizeof(struct host_cmd_11ax_cfg) + S_DS_GEN;
+
+	he_cfg->action = cpu_to_le16(cmd_action);
+	he_cfg->band_config = ax_cfg->band;
+
+	if (ax_cfg->he_cap_cfg.len &&
+	    ax_cfg->he_cap_cfg.ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+		header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+		header->type = cpu_to_le16(ax_cfg->he_cap_cfg.id);
+		header->len = cpu_to_le16(ax_cfg->he_cap_cfg.len);
+		memcpy(he_cfg->tlv + sizeof(*header),
+		       &ax_cfg->he_cap_cfg.ext_id,
+		       ax_cfg->he_cap_cfg.len);
+		cmd_size += (sizeof(*header) + ax_cfg->he_cap_cfg.len);
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &resp->params.ax_cfg;
+	struct nxpwifi_ie_types_header *header;
+	u16 left_len, tlv_type, tlv_len;
+	u8 ext_id;
+	struct nxpwifi_11ax_he_cap_cfg *he_cap = &ax_cfg->he_cap_cfg;
+
+	left_len = resp->size - sizeof(*he_cfg) - S_DS_GEN;
+	header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+
+	while (left_len > sizeof(*header)) {
+		tlv_type = le16_to_cpu(header->type);
+		tlv_len = le16_to_cpu(header->len);
+
+		if (tlv_type == TLV_TYPE_EXTENSION_ID) {
+			ext_id = *((u8 *)header + sizeof(*header) + 1);
+			if (ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+				he_cap->id = tlv_type;
+				he_cap->len = tlv_len;
+				memcpy((u8 *)&he_cap->ext_id,
+				       (u8 *)header + sizeof(*header) + 1,
+				       tlv_len);
+				if (he_cfg->band_config & BIT(1)) {
+					memcpy(priv->user_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_he_cap_len =
+						sizeof(*header) + tlv_len;
+				} else {
+					memcpy(priv->user_2g_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_2g_he_cap_len =
+						sizeof(*header) + tlv_len;
+				}
+			}
+		}
+
+		left_len -= (sizeof(*header) + tlv_len);
+		header = (struct nxpwifi_ie_types_header *)((u8 *)header +
+							    sizeof(*header) +
+							    tlv_len);
+	}
+
+	return 0;
+}
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &cmd->params.ax_cmd;
+	u16 cmd_size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CMD);
+	cmd_size = sizeof(struct host_cmd_11ax_cmd) + S_DS_GEN;
+
+	he_cmd->action = cpu_to_le16(cmd_action);
+	he_cmd->sub_id = cpu_to_le16(ax_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		struct nxpwifi_11ax_sr_cmd *sr_cmd =
+			(struct nxpwifi_11ax_sr_cmd *)&ax_cmd->param;
+		struct nxpwifi_ie_types_data *tlv;
+
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		tlv->header.type = cpu_to_le16(sr_cmd->type);
+		tlv->header.len = cpu_to_le16(sr_cmd->len);
+		memcpy(tlv->data, sr_cmd->param.obss_pd_offset.offset,
+		       sr_cmd->len);
+		cmd_size += (sizeof(tlv->header) + sr_cmd->len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		struct nxpwifi_11ax_beam_cmd *beam_cmd =
+			(struct nxpwifi_11ax_beam_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = beam_cmd->value;
+		cmd_size += sizeof(*beam_cmd);
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		struct nxpwifi_11ax_htc_cmd *htc_cmd =
+			(struct nxpwifi_11ax_htc_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = htc_cmd->value;
+		cmd_size += sizeof(*htc_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		struct nxpwifi_11ax_txomi_cmd *txmoi_cmd =
+			(struct nxpwifi_11ax_txomi_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txmoi_cmd->omi, sizeof(*txmoi_cmd));
+		cmd_size += sizeof(*txmoi_cmd);
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		struct nxpwifi_11ax_toltime_cmd *toltime_cmd =
+			(struct nxpwifi_11ax_toltime_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &toltime_cmd->tol_time,
+		       sizeof(toltime_cmd->tol_time));
+		cmd_size += sizeof(*toltime_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		struct nxpwifi_11ax_txop_cmd *txop_cmd =
+			(struct nxpwifi_11ax_txop_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txop_cmd->rts_thres,
+		       sizeof(txop_cmd->rts_thres));
+		cmd_size += sizeof(*txop_cmd);
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		struct nxpwifi_11ax_set_bsrp_cmd *set_bsrp_cmd =
+			(struct nxpwifi_11ax_set_bsrp_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = set_bsrp_cmd->value;
+		cmd_size += sizeof(*set_bsrp_cmd);
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		struct nxpwifi_11ax_llde_cmd *llde_cmd =
+			(struct nxpwifi_11ax_llde_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &llde_cmd->llde, sizeof(*llde_cmd));
+		cmd_size += sizeof(*llde_cmd);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &resp->params.ax_cmd;
+
+	ax_cmd->sub_id = le16_to_cpu(he_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		struct nxpwifi_ie_types_data *tlv;
+
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		memcpy(ax_cmd->param.sr_cfg.param.obss_pd_offset.offset,
+		       tlv->data,
+		       ax_cmd->param.sr_cfg.len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		ax_cmd->param.beam_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		ax_cmd->param.htc_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		memcpy(&ax_cmd->param.txomi_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.txomi_cfg));
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		memcpy(&ax_cmd->param.toltime_cfg.tol_time,
+		       he_cmd->val, sizeof(ax_cmd->param.toltime_cfg));
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		memcpy(&ax_cmd->param.txop_cfg.rts_thres,
+		       he_cmd->val, sizeof(ax_cmd->param.txop_cfg));
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		ax_cmd->param.setbsrp_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		memcpy(&ax_cmd->param.llde_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.llde_cfg));
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.h b/drivers/net/wireless/nxp/nxpwifi/11ax.h
new file mode 100644
index 000000000000..41e318b39482
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11ax
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AX_H_
+#define _NXPWIFI_11AX_H_
+
+/* device support 2.4G 40MHZ*/
+#define AX_2G_40MHZ_SUPPORT BIT(1)
+/* device support 2.4G 242 tone RUs */
+#define AX_2G_20MHZ_SUPPORT BIT(5)
+
+/* 0 indicates support for HE-MCS 0-7 for n spatial streams
+ * 1 indicates support for HE-MCS 0-9 for n spatial streams
+ * 2 indicates support for HE-MCS 0-11 for n spatial streams
+ * 3 indicates that n spatial streams is not supported for HE PPDUs
+ */
+static inline u16
+nxpwifi_get_he_nss_mcs(__le16 mcs_map_set, int nss) {
+	return ((le16_to_cpu(mcs_map_set) >> (2 * (nss - 1))) & 0x3);
+}
+
+static inline void
+nxpwifi_set_he_nss_mcs(__le16 *mcs_map_set, int nss, int value) {
+	u16 temp;
+
+	temp = le16_to_cpu(*mcs_map_set);
+	temp |= ((value & 0x3) << (2 * (nss - 1)));
+	*mcs_map_set = cpu_to_le16(temp);
+}
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap);
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc);
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+#endif /* _NXPWIFI_11AX_H_ */
-- 
2.34.1


