Return-Path: <linux-wireless+bounces-32525-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNnWKAiaqWlJAwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32525-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:58:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C954E21401B
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46CE730B164E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441823A8FF7;
	Thu,  5 Mar 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gpXCw4p2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506353A8FEA;
	Thu,  5 Mar 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721723; cv=fail; b=ZRCTwuYj8hptNu+CgZ6q4VqizlwRcFhf7rdGp32IyHxnJakeWgCAoIZzGELsj2/mroztbrP0f2ki04DupnRTijaLMI9Xzob8Km9EAYS03gk5lGaJcjpgzMe12RdTpz+EsTJrVO2mOa7inBvdxwWBFUrxBnTAu0XV6VEr46zmH3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721723; c=relaxed/simple;
	bh=Y/MNg7Yjz3xKxbvnTPYKjnv3jaWHZJedhoXssr/bZew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ik7sZo4xU6qqLH+nJ8FNTw2KQBiPNnF+ufvfNOyg9YL0J/M+nA0znaxA4HjZ6uP4VDC9YApqBuSiKUZSjOceGgS9ZShQrXOmKiuFfsL1OdIiKnTd+3SWV+ktkT3YeUvqlAHrlm+136xafk7/kpMq+l36KiamsHWCeTZqtokggGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gpXCw4p2; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOddlBYD41TLpk/RuayeqmV/teT7yCMR4yEzrnhjb63IHuuKg+gScxDQihGeZArx13x6xDYFbc2fktVgrUmFTirIXhbh82j3v/1QcKCy1zRLNy/yas9BE72itgu2DcPJ2LCt2Wa9qHXS38dj9NiPVSgkTB7y+0o230WEK1O5SpW3/ICRf/zqY5f2c9a+WsC7Yod1vH8MZF2uJddxE6l6LB//9WyNRPji4swAXeBcFMn7GROEAZyluHYEuirmn2orvmLlwglajJsmqaKWDy/wl8Sf3De/4Au+LbotRas0CM+bqRfKrW+V2ubIpx61l58bZRqOjalLarbHrH+Np/waWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG72JfwtGl8povHEDzW1pvZ5u9S8zriZdF9dG9oel6Y=;
 b=Dw7RruUdHDqMQ2t0py1yIeZrcw9PiisazADXMP5wrEK5t5wbl9cIF62MY+C63uSGgIgHGFqZT3nbcPOJJkUOU9YSjALDFRZx9cJ/j1gbXohKUpxDl1iTmzdH4BfxHctUg2m1MHrXJidAP9iv8jE+XNY6DT/q8ZhGjsN09IkkhDS1QGWiT8TCMfeWc7FqRQmooLo5dLgynbACNlp+tPFM59VChyBZYcAvEk+86mSwQUayih0B99+VDT2I4wlmgLuz+JfR48WE/cs2srxsSEFqk/ZtFUP8n2u2d0ua3wn0gNov5bS/yGeLaq5ZFnQ5r7eZB1mRxNddA7mUXYf07YjXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG72JfwtGl8povHEDzW1pvZ5u9S8zriZdF9dG9oel6Y=;
 b=gpXCw4p2T8kYV/kpsIqpCCjgnF0rYqWvTHup5e62kVBy0tftDtYMd5GR4bLifqAdy0SDIWLAEjhAdOwquN1eLKWol5fXdaqn3IJkLRc2k3IC44gS+JqdSia++1d/NMdWpbS2XQPuyqRuIurSll7Ldzonu+zIn+inQYDWErY9jkGpXwvzxNu6aSDOA/tYAYuvdLn0Ib0e0N7ExZrMR+Hjy6t8PcnfcUvjqZd7sv3ifguKorGiqQWBlKGnbUxPlEqitDS5hteGC7BLBPVaMBKDrsu0pJmrpFPmuJKUmdUM34IGhn7ctg0SQlIJsXj/sGi3DoLm93rkjlMMv86FNqUDhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS4PR04MB9313.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:41:58 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:41:58 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 04/21] wifi: nxpwifi: add 802.11h DFS/TPC support for 5 GHz operation
Date: Thu,  5 Mar 2026 22:39:22 +0800
Message-Id: <20260305143939.3724868-5-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS4PR04MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f27a0bd-691c-4bc6-2a0d-08de7ac55acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	8uqwfMB9dZOvauaILCUFD8ffeAi6YmVWu5IdDXOFkTVGbOy+o63RLA4pIY9Ay2MviA5S08V2zXjz0ijuar0Z13EdoMTkCR0saietISTnJS4jsNvQJkYSDQfvTN8UAI1fasvo5m1AcjZJxNldw+zJtjQlJF6Daq2YkA9TkrTlvmAAI8oyQWEI7q+Up1fTlhYFqcu+2db2pqNhphs3cJsL7gTwA5fx134busuIfl+xaXMBpE4rugwmvZjqlHP6SoWQDIcPrlvsJoJfHrbxWs4QrNMF+tHAWviRC6azkCQMvAZYQUu8Krwt06cuk+c1T0Ht7Pl9xRpzORDTxmDpchnJ36ZjJsPDCTRoP1UdaCmV8LA3NbDlEt/ikuRq+5wknZQDf0KOL0F5O6W8GfDQ/IA2x9Z5eJ3iOw2Q4AsO+VJ5Hy9EcoOp1FEMzv5aBXzhPHvNfAI1x0TMfrTICvUdNVIzxQCKit2cakYAMsGxG3HoLJdbRjXjBBNrPoRPa8ceXIOJmX6X5c1qOcJ2awfjTwrQ6nSXbG447szrNw6fxViHMy823bQcyCoVgVTQzb8CRDjZnGExX/rJAfgEERU9wsyRdQ0FDqvVOJNw6NFZvjXSH36CsxsBY5eJsQ9jtkAkDEWE7VXGpau516uK52k38waUcH9mifHPzH6izKwC7y8UrcQRs5v4x9peGHKH3CCaFKOkTS7othi2Emo4QHm4g9ORTw2BXVwIfdz57HwFl4U6s15cK+yhluTUlntjLXSL3W1VzzaKnpPGY1pFTBTjY73gVLwL4owO9GhR9+Gm/LmPo88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GFb2uEzX3S8pd9XHOe3D2pwRy82j1zMBVKNO1+m/HVql3ke6kKhltXFnsW7F?=
 =?us-ascii?Q?wslu6uwjjh7s0/DrMGuyWseFbfNMFNSHu9TwIhlY6WeVfjGTDjXcVU5lMyu1?=
 =?us-ascii?Q?8tvERSfIuJDvUOV0F1m34n4VCtaIwmOqLMYDOA6Rnd+q8Er4YzcpyPN0g/gt?=
 =?us-ascii?Q?MhfhYG48P6e0tVOoBKw0qymKQ3xz4oSkJ2Z+NC4Hhr/jXa3YnCnE46IAZ4Nx?=
 =?us-ascii?Q?i6qxilS2L8Ay2JnlBKg5iHgkvFesYw0PahxSCTacVGBfULeopaIo9gy7H7hF?=
 =?us-ascii?Q?3sbADqyR5ycFbRJvE4hpP0+V4tT81of07Afs8P6zxaUtXTlvVZ4njcb5fGyr?=
 =?us-ascii?Q?N52tSjAN63+KJqNQEngvFtu1xtp5sbmRrTqWjIMsxZFreNcuOcw+5P3S51WL?=
 =?us-ascii?Q?nplJChUWr2D0UZPsDMiiNtkU/TXPGFQQCOF6uQqy1V1lmdCyUICF5mUiPG6Q?=
 =?us-ascii?Q?rvzRhyJoOmlywGpWlZ2OGdjIZ8bVEQL0xuF2wsAI57itRMDKBip2dVZ7oTBR?=
 =?us-ascii?Q?w3pSKfSnKIeMfPss5yIpBD88XjB0rpj6keuXrqXD+MNtbCwuQzhGvzJxaZTT?=
 =?us-ascii?Q?rAzh6PGDQQv5oSfPe8SSKCKmChf5btGNLcvnOo6+N3vKjHq798Tfjo8chA+1?=
 =?us-ascii?Q?G1Rqz1LgqBbSl+wrEJS1pffn2iJluTYv96DnbFLIoGbsA6HW6uKroFJIbm/S?=
 =?us-ascii?Q?a+kbN4aSbMyFatUSpiu65gi12Pb3iUK+9D2CUysXAr4ImD3EbKKAyPybVeA8?=
 =?us-ascii?Q?2gKNbU798oHnpUUGv1NdUa/IHLXGEpz1BmFdO73zaMHte6yok/Lc3Qxy5ssr?=
 =?us-ascii?Q?tcRLRbi9IpYYjVBlorWj8sJEJaZ3g9Pi30SVNs5mE6Gw25LntB2kbPo4BHiu?=
 =?us-ascii?Q?lw5Maq/AZu+A24SbgfnB5E61Oi7gJXNlgxT/hT9rxL9jGJbA6Cib4K93STeu?=
 =?us-ascii?Q?klDMZATLnX+EBn0Fu4E2sQOnViELeEyF2ZxpbKdcXs1/pWBCPt4RcmQsIrPo?=
 =?us-ascii?Q?wY8P5fVy21eXfNXVm9T0B+E6Dui07ceoQxCEwcVE6sMRx2Ez+Us9X/UERJYw?=
 =?us-ascii?Q?d88bpF0AUQ5/MqgUjZRYc1HJomH3I08A3Gb84V7yXPJiyJEZ/AkfIp85Vite?=
 =?us-ascii?Q?tsQ1Hm/Bm7rlc1TLNayDwRFiHGk8FcdRUFC2cro6/NlnMPijkLyJ17RoUoQX?=
 =?us-ascii?Q?7vKgD72ENHpi4YAMph1TQsbZiixidDHYkZpuphQrMx73geKgCmmM6QaXR0xk?=
 =?us-ascii?Q?uyALNqaf9joARmOnJr0v2tjlCYY4++MrRuVIpZmSTQRQNJB3nM0t+Vz5D/EZ?=
 =?us-ascii?Q?0+Nk9C1HD7UwtVqGVhmWKds58puTmEtUqVRRoGTdmlGR2Yb1zfjAxMG9ZK2p?=
 =?us-ascii?Q?VQQqZfpmP+4PdLrch1fi7bRcHUqk38FkbitccWbZh/3/BSgp6KLNO9DiiPnw?=
 =?us-ascii?Q?ShP1pNKSGKYO/obY7xCk5jqXrK28hxUFXkpq7mT6gXAScTEnvOFAqmQNprC4?=
 =?us-ascii?Q?xMgHwW0vAOvsWzq5XNjDOhV2vuHSBhJnhzKRtXMo0XgFFiV/ckq2A/4kw9JT?=
 =?us-ascii?Q?bbkXZ2LMv8dU78KlNRB+uCuLDW4J4Sz443m6N4DcYkpZQhdFXfZE75slgNiX?=
 =?us-ascii?Q?iqiMuLcywiJYiAbwT+JvDMOQ0/9RdFqA3IYtN5QTU1ad1rm9Y4vCdF3Xza58?=
 =?us-ascii?Q?bGS/a63mqrp1HpYW6Ujshycij5qW0740VnQnJCh7s8q44CUSEbO/SowNUwob?=
 =?us-ascii?Q?wbageJsvAw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f27a0bd-691c-4bc6-2a0d-08de7ac55acc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:41:58.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mc2/OKeOIgbL4HCcY/8ebFcD+KKAla3cdv6gvVTgAloxmPQUQY13re3J5h6wVHhhuiMBupWoYwcuWZ1p+GQK7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9313
X-Rspamd-Queue-Id: C954E21401B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32525-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

Introduce 802.11h functionality to enable DFS and Transmit Power Control
(TPC) handling required for 5 GHz regulatory compliance.

Handle DFS Channel Availability Check (CAC), including start, timeout,
and abort flows, and process firmware radar reports via
HOST_CMD_CHAN_REPORT_REQUEST and corresponding events. Support channel
switch operations with AP restart and beacon updates through cfg80211.

Implement TPC handling during association using the power capability and
local power constraint elements. Delegate radar detection to firmware,
while the driver constructs TLVs, processes events, and integrates with
cfg80211 for state updates and notifications.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 339 +++++++++++++++++++++++++
 1 file changed, 339 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..44af3a40a45c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: 802.11h helpers
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
+/* appends 11h info to a buffer while joining an infrastructure BSS */
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
+/*
+ * Process TLV buffer for a pending BSS join. Enable 11h in firmware when the
+ * network advertises spectrum management, and add required TLVs based on the
+ * BSS's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/* Activate 11h functions in firmware, turns on capability bit */
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
+/*
+ * DFS CAC work function. This delayed work emits CAC finished event for cfg80211
+ * if CAC was started earlier
+ */
+void nxpwifi_dfs_cac_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_chan_def chandef;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
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
+/* prepares channel report request command to FW for starting radar detection */
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
+	nxpwifi_convert_chan_to_band_cfg(priv,
+					 &cr_req->chan_desc.band_cfg,
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
+/* Abort ongoing CAC when stopping AP operations or during unload */
+void nxpwifi_abort_cac(struct nxpwifi_private *priv)
+{
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to stop CAC in FW\n");
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "Aborting delayed work for CAC.\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+}
+
+/*
+ * handles channel report event from FW during CAC period. If radar is detected
+ * during CAC, driver indicates the same to cfg80211 and also cancels ongoing
+ * delayed work
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
+
+				wiphy_delayed_work_cancel(priv->adapter->wiphy,
+							  &priv->dfs_cac_work);
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
+/* Handler for radar detected event from FW */
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb)
+{
+	struct nxpwifi_radar_det_event *rdr_event;
+
+	rdr_event = (void *)(skb->data + sizeof(u32));
+
+	nxpwifi_dbg(priv->adapter, MSG,
+		    "radar detected; indicating kernel\n");
+
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
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
+/*
+ * work function for channel switch handling. takes care of updating new channel
+ * definitin to bss config structure, restart AP and indicate channel switch
+ * success to cfg80211
+ */
+void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct nxpwifi_uap_bss_param *bss_cfg;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
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
+	if (nxpwifi_cfg80211_change_beacon(adapter->wiphy, priv->netdev,
+					   &priv->ap_update_info)) {
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
+
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
+
+	if (priv->uap_stop_tx) {
+		netif_carrier_on(priv->netdev);
+		nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+		priv->uap_stop_tx = false;
+	}
+}
-- 
2.34.1


