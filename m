Return-Path: <linux-wireless+bounces-13289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DED989A97
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70F22831BD
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D47156242;
	Mon, 30 Sep 2024 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R8pqDarU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036814EC7E;
	Mon, 30 Sep 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678267; cv=fail; b=L9F4TNxkORjnqwZcIWLBw1Tp4Tl8RO8U+3/7g96S1745Kvo7+9uQbHvB/LkDwxcatDpXwXnjvl7WjAasa6PfneewPArYB+4I73MvfzD2LOBkwUfFL7IMRhDIjQI1qs94FCQoF4B4xYUXmbhD0+WrAWT/4/dh4N7xAa//VVEi1Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678267; c=relaxed/simple;
	bh=QcUxkzRP7Sgc/N/v9OJLSLyqKTfqjDvXC/IJONJq0+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RD2bRd4YyV6v65KEfvxsLYYSqaAAVYSgJiGKEtc4MpjaO6l0LV9TJl4zC4xQpkYij+8uhTZIynxFEfTVPb5VKyCiQMnxj9xdA6EDkXvr+vkFE1mBNJRO3dTiW4R3EsoVFpwYKHv2spEpo9X47DT96HSMaI+l1BJ8crtq4cCdXVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R8pqDarU; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNtiZJiqSoCuJwaP0FPiUhkhz/wbVxVQAmrv6Wm0dnoD4QL0OqdOYaRSfNWTkCaXqIQvxs7NHMAoY4na0M3IDqPTEZPuQQ9RxxcxlQs5sGDY70239mM4jwmy6hwdTUObAbmKdsawAAxDp30vTHxdX41hn9aiG2P9eZ18IPjbiVLzEY3OqSQIDMjbrHTJgQalWFjiI8x405DagAuNZPoWaQahpRWftLCW4lDIwto+YYkgAxKQxnvIjR8WJaT5JiHBcJs0HUAxj8Wf8qxqGXtYtkasZuJ8qtDzGBJoPoa9qNQKggM4pLDR5M9v44Wy9eP7RbIvgRZyrrQ+AxuyQ9BE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FULkcCzR6T559FRIRY0guR7B4psEiUwfA4Ly2P/z0O0=;
 b=XV1ZUevgtcf0EOw139XnkqyZPW8cXfTB/vUzn47sTanXH2CYDoKRIPVC7UPkblhOO+7ZXaqDpJg0hx5CjBlQDpFiZkwrmymZerbTUQ3G/BCc5T2/oT4acy2WGbHKC77LK673JeWvysexyXMhXmPmLNTyEMrHG/4Wlhuv/LUJuA3fxn3MlxwGggtxVh9b/xrH09aDLDhJrirNn+pKGO5FcJsCGGcGppSRHdprySiO9etXLcG6eRqt/GQYnuqSxC17OfgC5q4AXfXX92iqRYgGhIQ1Mf1IVknt2z8JfYjf+m7Yum/PflyDrEVQkCLJSLJDCeQ1xGItbUvGRYbX5eUhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FULkcCzR6T559FRIRY0guR7B4psEiUwfA4Ly2P/z0O0=;
 b=R8pqDarU5UJ3O6pxApDgG7YZmPMg6qlGnT2Z4bCMW8THQ2/mcJTCT2mXxb5D2FyTZx1YicyFLxL9UU6noghMtmXsIYx6VBd3EX6mzftGjajLw3od9zQGw6OxmoF7y3/O7a7OyC80AL6NfZ4L8We7DDHyBfChA2bTwh6cTAjHwnzUk2VnQSQ/OTGFl/gaHPwuUVNJwBLxwprZdtdjaESCPlx+aIX5oMuo3O6LNU9iWuUWg/6zI5xD3ueHXlTsHKM4ZpHyqALQCB84BeTM7c1uUkXLmw/jCoGf471JnuLD1ipjYDz4MRXvjXr5CmhrUCD67TzRE9M9WpL+R5NwEWc17Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB9000.eurprd04.prod.outlook.com (2603:10a6:10:2e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 30 Sep
 2024 06:37:41 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:37:41 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 04/22] wifi: nxpwifi: add 802.11h file
Date: Mon, 30 Sep 2024 14:36:43 +0800
Message-Id: <20240930063701.2566520-5-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9af8729f-3cc3-4f19-e438-08dce11a61db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EgEvy1WSvV1+lkEkNNfah9+axoWTaHc4Mk2ypkiIVkNIlb1S1REQfVHlaEZz?=
 =?us-ascii?Q?3YtN/Q/gOTdt5CZsVPuu8gi8bqq3IhSt5OpCkru+CIU/oHYeYd5euCp3qsug?=
 =?us-ascii?Q?9WIOWktsaHDfT8O8BHh4GIUhL9gQf4qEXlLFxCs+S3bX8gs6YkUhYwAAMCHc?=
 =?us-ascii?Q?TYfgll/SP3nZ0bcgp0rYcTXrg9qbYEuJ30JIn/eEiZYUnlJ6TLK6HF3198/p?=
 =?us-ascii?Q?v1LLG4BFOrltqdzyfbRGd89rQTTFyFiZgBYJ8uXh9Mjfmk5fFbs20Y1U9wok?=
 =?us-ascii?Q?8clUKg9YatcrT6xLQo5gyfaPZ3vKoWD6syYWa4qmzEfZvkpOPyJeL0SiiBpn?=
 =?us-ascii?Q?RV2egSJkX51HJWCSeTE3CLpEkEt7KyMuSZ/fu5+qvh5cfPicCAEwtn/inewT?=
 =?us-ascii?Q?nUdMfS+GQ7QZNUjzapkoTDCdoWkfG/MXVFD/ob8xIl6LnAtLa7qJ1OzDkEVM?=
 =?us-ascii?Q?7YzxaOE8qiJGDFO0NXxNBNzXA84tANExgX8+0CBTrHtY60Djr1YOdl3ZOF8j?=
 =?us-ascii?Q?qnrHfEbiIM4D/jrKFux+NG4tYTdakPbZZKn0ucFl5J3ImaJnwFdRKI8ytBRm?=
 =?us-ascii?Q?vqSNruII0V74K1JH9F0Xrb5efZGI7IW130Ze6PQ1mekn/6+VaWAiq1GNYOy9?=
 =?us-ascii?Q?ZwWBxi8PPgjSbWJ0EtqgyZBqkN8+A3u66g52mOndbsSkPQHqPdOp2sC03D4u?=
 =?us-ascii?Q?fMVTKiJs5QKygwFPhaEFG8auBFpIq4/Rb1tDTLCAuiSZP77i0y5gXIuKxKuD?=
 =?us-ascii?Q?7tWFV2r3pBnvNgdoTpoIHcuy8UD7SS4w1XWVxfj5Te3by8zJ5PfRJupmK6+l?=
 =?us-ascii?Q?JXaS9w4XRFdpIc+27AxPZNbT7y3XGNSJBTvUfepQEI4cKrX2nuuVJN7nB5r2?=
 =?us-ascii?Q?hgeGjuyagvna8IHVHk2bGSn/leYbinxUAkXBtW8qnjLNjr7qiGdQ/tYr5c1B?=
 =?us-ascii?Q?kE3r0Z45hD9OhtVztApUVQNM4ePuxOClLcV2u6PStmMdAjR/vZhWD0WtMHvP?=
 =?us-ascii?Q?pMomtVqFitCBBp96eRdiZuWA8CDGA0cMqlXeb6dowRjj71RyGCtGh6wCW+r5?=
 =?us-ascii?Q?Ciml7koxTKzB4j5UC1i46hdVb1SSb3o8H663fhs4Nto458Zfs4SnfT8WKX7H?=
 =?us-ascii?Q?0k7MaswFcUlIyApO5m+HqH5cs/iedFGI7ZeYnLqlVCP7DkjYCh41xNZVj880?=
 =?us-ascii?Q?GmzY9+hFv3YgN73Gom4kSIGg1gGaXzlZ4v6FJKPR3VmSa8bDXyh2FaW6OsR/?=
 =?us-ascii?Q?9myzOzf6HpaJijV1mEEldUOhwEFulyRNyu/SIoW9COElsoV9ihmEN8urFyxM?=
 =?us-ascii?Q?Tn7zSSeDe0dMnXamX9j0pCF7NkwtBYqGY6h5SqNbULgM/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hejt2UrWY33GEB6UVC7n91T5Vd4+Ep61ddBuqRdFwrJxFtaXlsYjsMevyyJq?=
 =?us-ascii?Q?K56HdOlxvJax8b8T4lxnWX1O0HZD5YLigHbYfwNlKbZtUA2jd7CpRd8P/nGH?=
 =?us-ascii?Q?seplrQ+yj7CJzI+MJcCoyvvJRnjkTo4e/DMK1v908zxIDm2FFbdPrjCsJ135?=
 =?us-ascii?Q?E3Rf6xuzkY0L4xpyJnqLO4T4T9wLDvO9quqR7CuT+J1TvZrYonHdMpZG2eFW?=
 =?us-ascii?Q?40d+PJSpuobELnENQH7zsEKY/67ujvttUiMn8G4FjaK8e73PfZdA10l736mI?=
 =?us-ascii?Q?iPSOzwX4vSV8qaxdARkY4MrdtW21EWwmvwM57GgucblqJUaXUPK13pnWPUs/?=
 =?us-ascii?Q?eWt+NPyDMcm0CT7SBY29KRCEKdFHrgtMdlS8i8I8I5ef7w3Mf0/3sjpWq0M/?=
 =?us-ascii?Q?TCEki+C7d8j635b3FLUyxxP5CiQHwoqwdwF35zEnrOUglF/UR8PVTQYlF0Fg?=
 =?us-ascii?Q?+DMDD7G8TMoFfzyC/P69k6y2eoWrd57hl3kYnQB8HdfmxCxqOj2AksHlQ+IL?=
 =?us-ascii?Q?O0NjRv//QV0EgV7UZV3of+n+tmoDElkuV1nR4rp0QupYxxBN/rHDUx9oBFeI?=
 =?us-ascii?Q?8VakP3XgVSzmVFURfxNHcFNvHUuNpZ+DvAUt5u6yQOJ3rpdSWfksyu8cfELC?=
 =?us-ascii?Q?tONsiLUzQNQPGFOmKuW7yStGGP8aVTLwogLyzRZVlg/FDFM0TTmZ74CAlCQC?=
 =?us-ascii?Q?XKHsaYSkO6inoKSvj3AYl40xFy61xOR5IidDCOvrUo+KLSC/SErJud1Giiub?=
 =?us-ascii?Q?kBq6jYZv0dh7ibSamKuPgUlKX1J71tmRwW4bw1jKgvXixFTi+ThbdJT6MQPv?=
 =?us-ascii?Q?pNj2HrWb0jElvhaf8y7n6+lrEAQyRxoax/Xnat7t7ucdmE0OhsaiUgzN8DA+?=
 =?us-ascii?Q?yJ1YWvS3sksHCalJ1uNbKOjTfN84mllOL1bu9T+GT0kulnQ94UZobdMZvauv?=
 =?us-ascii?Q?ZGayCz1+SLMV29MjmjjDC6p6Bzv4ALewjbPu3HPgZKXwCjarYyHgVPMCYwPB?=
 =?us-ascii?Q?O1DWXAnp7twugdXvIBhBkq1TvBZvgJjlErgI52rg5U9Eec7KLqXIuQMNz/Ma?=
 =?us-ascii?Q?vBavyUcS5A4QcHlFXywEPFvL+kCtNB7w8rJl7avF3AVPIUHuHMyUgkjlzZ3Q?=
 =?us-ascii?Q?C0RuB9WMR8KR8vvxPMadtjay8nO0S4g9TrMN3WU+WoK1K4xqBd7IRqVcBKsX?=
 =?us-ascii?Q?NToCwVnGJ3DaZV41OPn+IQP4iI13tcl58QTlRSUNELzioCOmLDXY6HPRLwu0?=
 =?us-ascii?Q?FWkRg1VQqsAr5SWFPMwV64nRKbyiNvlJJApTWgrzi3wWpeHFBEAaOsmR9Utu?=
 =?us-ascii?Q?ZkvKJvGl4Eu+FrUStijFXda7h/esYTdQ5/PfuCHU6ISRKAhIA+37FqDirjAB?=
 =?us-ascii?Q?KZiRmqSDy9ojAbRiAR1h6c7crvU128pa+PsDJcAU4hpS0KHDJR44NB0g2byd?=
 =?us-ascii?Q?/+uvGpqv0FkHvqhMNvDPbS3atuVgbUB1ayhE7WH8OAAbBW1nju/yTfuS51NX?=
 =?us-ascii?Q?WKtC/1GlQP3ZW6x/H/XtB5q4z+ZFpDVNbSq4XWGH9bU4qyOanUeWY3XnxulJ?=
 =?us-ascii?Q?YNmidkIi9Za2x7hPo1xOMVzNs7LzEE+wW2HICYeF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af8729f-3cc3-4f19-e438-08dce11a61db
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:37:41.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IMebKBKNfOsJnLbpcjWerdVCfsYcxkBbN5mtYtPA8raMXDPIHytNuyYY2t14WUFExv/on5DzL/mQaTsY94eHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9000

File 802.11h is used to support 802.11h features (DFS and TPC).

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 432 +++++++++++++++++++++++++
 1 file changed, 432 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..f2830d136941
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11h
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
+/* This function appends 11h info to a buffer while joining an
+ * infrastructure BSS
+ */
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
+/* This functions processes TLV buffer for a pending BSS Join command.
+ *
+ * Activate 11h functionality in the firmware if the spectrum management
+ * capability bit is found in the network we are joining. Also, necessary
+ * TLVs are set based on requested network's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/* Activate 11h functions in firmware, turns on capability
+		 * bit
+		 */
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
+/* This is DFS CAC work function.
+ * This delayed work emits CAC finished event for cfg80211 if
+ * CAC was started earlier.
+ */
+void nxpwifi_dfs_cac_work(struct work_struct *work)
+{
+	struct cfg80211_chan_def chandef;
+	struct delayed_work *delayed_work = to_delayed_work(work);
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
+static u8 nxpwifi_get_channel_2_offset(int chan)
+{
+	u8 chan2_offset = SEC_CHAN_NONE;
+
+	switch (chan) {
+	case 36:
+	case 44:
+	case 52:
+	case 60:
+	case 100:
+	case 108:
+	case 116:
+	case 124:
+	case 132:
+	case 140:
+	case 149:
+	case 157:
+	case 165:
+	case 173:
+		chan2_offset = SEC_CHAN_ABOVE;
+		break;
+	case 40:
+	case 48:
+	case 56:
+	case 64:
+	case 104:
+	case 112:
+	case 120:
+	case 128:
+	case 136:
+	case 144:
+	case 153:
+	case 161:
+	case 169:
+	case 177:
+		chan2_offset = SEC_CHAN_BELOW;
+		break;
+	}
+
+	return chan2_offset;
+}
+
+static void nxpwifi_convert_chan_to_band_cfg(u8 *band_cfg,
+					     struct cfg80211_chan_def *chan_def)
+{
+	u8 chan_band = 0, chan_width = 0, chan2_offset = 0;
+
+	switch (chan_def->chan->band) {
+	case NL80211_BAND_2GHZ:
+		chan_band = BAND_2GHZ;
+		break;
+	case NL80211_BAND_5GHZ:
+		chan_band = BAND_5GHZ;
+		break;
+	default:
+		break;
+	}
+
+	switch (chan_def->width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		chan_width = CHAN_BW_20MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		chan_width = CHAN_BW_40MHZ;
+		if (chan_def->center_freq1 > chan_def->chan->center_freq)
+			chan2_offset = SEC_CHAN_ABOVE;
+		else
+			chan2_offset = SEC_CHAN_BELOW;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		chan2_offset =
+			nxpwifi_get_channel_2_offset(chan_def->chan->hw_value);
+		chan_width = CHAN_BW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+	default:
+		break;
+	}
+
+	*band_cfg = ((chan2_offset << BAND_CFG_CHAN2_SHIFT_BIT) &
+		     BAND_CFG_CHAN2_OFFSET_MASK) |
+		    ((chan_width << BAND_CFG_CHAN_WIDTH_SHIFT_BIT) &
+		     BAND_CFG_CHAN_WIDTH_MASK) |
+		    ((chan_band << BAND_CFG_CHAN_BAND_SHIFT_BIT) &
+		     BAND_CFG_CHAN_BAND_MASK);
+}
+
+/* This function prepares channel report request command to FW for
+ * starting radar detection.
+ */
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
+	nxpwifi_convert_chan_to_band_cfg(&cr_req->chan_desc.band_cfg,
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
+/* This function is to abort ongoing CAC upon stopping AP operations
+ * or during unload.
+ */
+void nxpwifi_abort_cac(struct nxpwifi_private *priv)
+{
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to stop CAC in FW\n");
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "Aborting delayed work for CAC.\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+}
+
+/* This function handles channel report event from FW during CAC period.
+ * If radar is detected during CAC, driver indicates the same to cfg80211
+ * and also cancels ongoing delayed work.
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
+				cancel_delayed_work_sync(&priv->dfs_cac_work);
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
+/* Handler for radar detected event from FW.*/
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
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
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
+/* This is work function for channel switch handling.
+ * This function takes care of updating new channel definitin to
+ * bss config structure, restart AP and indicate channel switch success
+ * to cfg80211.
+ */
+void nxpwifi_dfs_chan_sw_work(struct work_struct *work)
+{
+	struct nxpwifi_uap_bss_param *bss_cfg;
+	struct delayed_work *delayed_work = to_delayed_work(work);
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
+	if (nxpwifi_cfg80211_change_beacon_data(adapter->wiphy,
+						priv->netdev,
+						&priv->beacon_after)) {
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
+	wiphy_lock(priv->wdev.wiphy);
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
+	wiphy_unlock(priv->wdev.wiphy);
+
+	if (priv->uap_stop_tx) {
+		netif_carrier_on(priv->netdev);
+		nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+		priv->uap_stop_tx = false;
+	}
+}
-- 
2.34.1


