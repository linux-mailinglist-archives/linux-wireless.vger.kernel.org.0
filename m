Return-Path: <linux-wireless+bounces-9366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADAF911D5C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D80284053
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5EA16D4EA;
	Fri, 21 Jun 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="im9gqVh6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FAE16D335;
	Fri, 21 Jun 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956363; cv=fail; b=QtorzSFsGLmZ/FlaOSUuM9bcxWGkqvehLAQKmzquc9RZD9g5xyaxFLwecbT2sa1vgoS13ofJmPpdnfi1Ik6tW418osbSp5n9NsRt21ar5lbeB85oxXaLZDlYm/bM5VdSwi147sNabo0zUUxzLfpN8oX7f7gW23pO9mVrkXx39iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956363; c=relaxed/simple;
	bh=29/7PCObOYigLkRDRhX7GqvssKztbaGrAiheJJycaiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GmGY7ofcqR29CreERBqQA/nixcnQnmxCFMnrVqS9dS+iTD68TNPRTIf0HAE5DC8rg2r60Xyu7en7yowCr3M2latpjHwWhU3PVL2r6u8X5aqW7ccz8vLgKVuInnNvjgAMWqQIe5A/KSQ/WIxOZXq27CrOxgMMWw/e1AtCAXz3nHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=im9gqVh6; arc=fail smtp.client-ip=40.107.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrKW96uW8q6iBpqWMFCTabeII9sJ002vg390YnSuYIaBL95antDguMWbR5nXP59ioBRZqj6FqipYblqwf5vCi5n99tW42xuVzn8VARfERzdQ+8fURA1dtS7clVTmhQox+iYZfaceZ1xUzGAKrTrKP50SI3f6vk0qGdl1RtDBuC+zDAJPlieqeGxBj9DvUE2GhV7tz965frFQupe6Q+pBaEW5i44/gQ/4kl3IFAG93vgAMyLgl30xwuPHgJWr3ZUgVE99Yycq5F6HBRputn+wHuBNQ6aYtZmTCNrvtOraLDYZfZT+iOWI5GGJPP9LmzTh1QsRZN4fk5wt2kqgqU0IZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi5r2ML+Cj4fQ/fCi0gFAN5/9NwlsrP2l0VP/bNbYlo=;
 b=AFnfvjeOynOLIGsUhM55FYU2FAPaI9iL2Uj+VmrcvbG4NiELrgNOzKAkMKhKKJHz2pmxOaUpBQxZXgyrjoV8Txw0KsjPYz7ZQBJKhtihMg3H3h05+ifB8zt5aDWE4itrenlHEmFiyQfPVS/rGwbT4jV/qB+1+gLh3elZ9yEnDOdXMV7fd9EO2oJ+YMM14zbsHWzFzhZbeGkQTSCxw7NuaBHQ7gPg//RY5XHIPT9JuVWBZhP+HcT2iwT15aohw/04CJJRQugKMk6L1b7e8QFR3uwI+s52fp2XSmQYHotGfvI0VmpMBxIDRjfC6zkHGEOPZHMYntpszklGqR0Z2k8fxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi5r2ML+Cj4fQ/fCi0gFAN5/9NwlsrP2l0VP/bNbYlo=;
 b=im9gqVh6rKAtvikOLn22/N+Ro5GPgQUz79UJYoMuspbpxMNxSKCvLNTWLBo8gdOHImG+dbV5k1Q/pmqYNJS3+XArJ3vChVNx+6DYXJ8eh0dfkWHIpWsHZMpzZaXo8l3X5zWI8B3XFoELSsBz131S6e4w8nUR+gZCTggiJ8Pg/+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:52:37 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:52:37 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 02/43] wifi: nxpwifi: add 11ac.h
Date: Fri, 21 Jun 2024 15:51:27 +0800
Message-Id: <20240621075208.513497-3-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: e421670b-9532-4e09-b4d8-08dc91c71e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kuwqiN6+/ET38/GUrWQZWynmfwww5+D2I+VJOxnnYUURmElaM1vt8QiaXVxW?=
 =?us-ascii?Q?N4Uw0bhZ6P7dyyzt8KP1HD7OrrNlXVm2IfSzojnoLGs7URoCNzrepgCju81g?=
 =?us-ascii?Q?roncha+HX7wyVKh/q1lkgGEtDDuhADBNaezyZ7qTGG3W/bJ/jtPG+i9oOQUG?=
 =?us-ascii?Q?ZpHfoopGSmt3aJBv9zfXd4ckMBooq3GHSM09aGwygaCyspzBp9+Eoyl4Wcd1?=
 =?us-ascii?Q?tZVkOaaAiP5RjoZ3fsxvA74K316KfNyRKHvBclcf+koFNa3GJR2zaIOYtPkk?=
 =?us-ascii?Q?rLiE/JQBhIUEjWxyj0LlQb6KjUPc98lVnc2iWts+M8UA81w5PVbnA2mvqzDg?=
 =?us-ascii?Q?whzxer3P5dIGjjSem01+JEumWQpowlOdsIo6ljHCLCFTWnEh77SfF2DhhPQe?=
 =?us-ascii?Q?9r3gGznDDun7vexMPsOqYBlka9LV8BGgHu1C6aBrbrKukHJrjJlQyXI4JZDC?=
 =?us-ascii?Q?XZ34ndh7ar558JtmgdfE7ebjskAJij7Kxc2E1mIKZgpT/yOOVAW+IiRSELQh?=
 =?us-ascii?Q?9diJqEVjloL+/3hu4moBJvXN0B8S5VmqJZz1kXZUSxzyI5dvhBsQGp85ztCN?=
 =?us-ascii?Q?tW3lNkuTYfgd0JfoOugCDfLQV7LG371xG8mxy+eCZfc079dcpbA0r5EVUsY9?=
 =?us-ascii?Q?7FR787Q6KdckTYVkDDo6GNNBfCnuK2JrYifMIkBxJ/vhukfIsDJBM+YniuVf?=
 =?us-ascii?Q?7MUdGfCh0T0cwCZnLSfis6ao771WcW19ZekAuFmvy4oxDVzUezdW+0XiFEAi?=
 =?us-ascii?Q?ox/lTnied8RSckth6inB+ldhHJYCT48KZ966qZiJp7qjarCk8Lgj0QVkT2Kb?=
 =?us-ascii?Q?m4vFAq51ulEh0HU82kt79ESyywwL8/5NiXJJFm0hIc3XTFzRhGjWr9majc6g?=
 =?us-ascii?Q?OHTaM65jpR1GAU578vcz68kKGHrXWeanxroJcdFTPetm5wGZXMkoH0rU5qJE?=
 =?us-ascii?Q?ESN5PT2u6ZX3RZzaIfqzK0dpfF3OGxM3t9LJ3ESP+RZoB1E2GP8elsPLboBa?=
 =?us-ascii?Q?lua5W93qBrx3JwWACyQaZ7mbKJIDiGnmsu2RhdAa98UhBohA1FQCQXWlRibW?=
 =?us-ascii?Q?1xyelBUvHaCJtYtf6Zq0mxzps1xTCVdAq6f0PD7ONBjfLFT3mZeZ9fvv/HjU?=
 =?us-ascii?Q?f98fdawIcmmSp1TsH/r0ur1yVMaTcqFQvmG3CLdAexOK2uvfC0JIsLQ8GqdB?=
 =?us-ascii?Q?SiMSNDZKJTdySBc6NBKRe/mVBNACmv0W6kh2nvRfnaJetird+uptXK19m5f+?=
 =?us-ascii?Q?Av9WYSkNkj3LP+JdsXObQAp6/vtaB26LkYZ4J5oSdL4gnwW7RzsC41JP1LgO?=
 =?us-ascii?Q?pe0rqufompIZ4fjUw7GpYuIdRghk21JRVc7hJDnHzTuqM5dHdithWcNtgAop?=
 =?us-ascii?Q?C3FHuDo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zN//NQPhVLVPiSw0opgt/ewYIDkn7dpCzbXao4tk656lrwJatt6/BPqQnt3R?=
 =?us-ascii?Q?dfk47MUKXjZuHW9CrVkGpI6sRJkLN8kL8IKh1DGUnDnuFHuFq4PUErdmeumd?=
 =?us-ascii?Q?3dnw8ZqK1RmtM2AUM5Fzalz8Je1/zXa7FQCAkF7Oq+cV9u9lQvzEfdB79bR0?=
 =?us-ascii?Q?CjNE1o0S0z4QA00IM4BsTuLuIVbel2RFSPJvMLB6A0EhtGguBqjPkKM4TVzL?=
 =?us-ascii?Q?KzHMM0NypmGO01SRAnFY0Iu5F0wN2ziZxFYNTtPQX3WT2jvaMxioXbJqCoH9?=
 =?us-ascii?Q?v1Sxc/32eBjIDP6/cV6sB3f+eL9cZ5fB8kw8BH0o3dUao6HaQbjptvqL9Buk?=
 =?us-ascii?Q?mXnXsummKDsQUt+Wnl4rJ6OBhSmJnCaqkShdJLw54wfH1/zzTqYucsp8egAM?=
 =?us-ascii?Q?gpinPJ8fM8KCTQ21KBwI5xpZZp64AnaW5+OgW5RkYA5yKtaLwcBBQFFiEFP1?=
 =?us-ascii?Q?Lqs3wzXQiA3SWWJOFWZ3qXg8qk0zXukUCqz7lLr3Q40nTl9EArOvl+gbU8zH?=
 =?us-ascii?Q?z8TExcVzAw/qJwIyhmw3/SJW0TjPfx5Lxjj7re1BJlIzT/T2eq4ayefT+4/w?=
 =?us-ascii?Q?eXH9yM003uUafJ11STrzaIs3MPNKqhJlJz5etZYnyU/cTNO6MI6D/Rw/wXoV?=
 =?us-ascii?Q?rqdFLJO1NelLr+sU+85eju3CJjgFBF+J4IECzPDNakXNbeStpJEdv/NDepwI?=
 =?us-ascii?Q?vEuu2Wj0bgKIJWUJB6qRip0JBkSbs2RBK5fDuDch/hT9xWtzynneBFBEW0j4?=
 =?us-ascii?Q?GQgxs6gmh2WFBRrxnyix15I97i7fiBWFjtNQigok9rlkLlW4H5PcdyIHw+R7?=
 =?us-ascii?Q?hkbj+2GJplOlyHKRM/AxPOnDcdvL38TDOGjR1YMPLwTQAa2ujbmr9Oq8RxQK?=
 =?us-ascii?Q?cxfweaUy4vFEGpHgYAbegcdU6xF25ITLQRD43L1jyydid07QsdNPDhXqe/bq?=
 =?us-ascii?Q?8toiP1JpmMxV/ZE9laBzeAiNyIN5M2sPf806zkDT10wUBMzvlWUKh8RBOgHQ?=
 =?us-ascii?Q?6PPEuVvnWZrpOqX+LBI3MKfC+TlLar3f2eJTQuDF8ZkewFkWE8Zyw0anWaWj?=
 =?us-ascii?Q?fdxpkndg+12uwj7pyalq58xzeXImwjpQ0n52sv0yC1Y3w5CjOzf5NWm2KDZl?=
 =?us-ascii?Q?jdhWPjW2u0aaYc80kPyBsNwEtEyQJIB9MfqPt8oOyC4Q8KDm8Zw2OfLrcGWG?=
 =?us-ascii?Q?649suseabxA0/f+8d1Raf5kCI5eLROU/kTeDiLyuFfPN/tcrvpk5MBu/IYa5?=
 =?us-ascii?Q?QHIMlUjWc+gRykEEkDlDiEXlODqp76YPkFBiA9X9EYqWbOo84nJR73xEd7cW?=
 =?us-ascii?Q?m1NuqEunjcZ7fMkDUDUrGa3vi9P7lDRu+3g950hRFNOf9IeDiDd/eMISjh7M?=
 =?us-ascii?Q?O2XfLIiwCYG3XmfYV1wGBPUIokmvYxOiRvB6Z6+1tnnRJH4kPk7zv2KprpnG?=
 =?us-ascii?Q?y1KayIvbmgSYOVnzWPl63DHJDlJ2Ad9h8/F+Y9+j4TmKX/lz2aq4tOs3zSvI?=
 =?us-ascii?Q?pQOtYUMGMS58rVvgqS1NudUc6m76+G9ntn3v9NkfEbNVtBLJz6WE49hDStWD?=
 =?us-ascii?Q?JC9bRK6STE3upiMfJk7Wsok+pkzzPU+8Q0rtr5Jc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e421670b-9532-4e09-b4d8-08dc91c71e6b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:52:37.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXzOCehMKs8QFzTfFlpEFgq+aoNTO+HY3B1mWa54u2bLTj+MqLuISmK1b+DaoPSBO7rydmQ+UIUE5B9LzuXMvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.h | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.h b/drivers/net/wireless/nxp/nxpwifi/11ac.h
new file mode 100644
index 000000000000..b060de17a18e
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
+			      struct ieee80211_vht_cap *vht_cap, u8 bands);
+#endif /* _NXPWIFI_11AC_H_ */
-- 
2.34.1


