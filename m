Return-Path: <linux-wireless+bounces-29512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBECCA649A
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 07:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F2B7318352C
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 06:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645072D12ED;
	Fri,  5 Dec 2025 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="elqHXX4d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449682F39B0;
	Fri,  5 Dec 2025 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917843; cv=fail; b=IZ9z7rsgdvBpD15ApNQzahwHubIhh6vI88hfqsyjhJmjzUPJUWg1V57sLdzqx2lWuWPeqSDfUzgQg2SNIY2csoMyCQZTMiDnUnEHYivkTALap1o6iUh9KrxDxkUgFrWurKviTM/NBwlMcRiRQgSUP1+v0Rt3oqgZzoDAK54+eko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917843; c=relaxed/simple;
	bh=IoOzzgUCGfkI134jUxJ+IYy1D5ScCdD0et+Jm344mG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QmCsczyhjURHzYapNqs+VxVu7v86C+jAa6McpzvRrYYb+eUEo1pApbmfYdiK0eZoZeRISYG1krG0MP5QTvjXgsosy60AgDrrwRpy+xsxY+ntCycHbe5QQzuhKqnvCzyXQJCMwp63DnX2NWQi4tdmsvd2V6shkihbuJ0BR7ttEJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=elqHXX4d; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfQfe6r62DuQDgZX78W085qIlRF4JvkujFTD6eWWkYKFuU9fKclJhgGBlia/wVFzePpEXfpg4axAn8fk09Jy2FfUPInMvbEBzOiC52FYbGJzXika1/bZnnXKbyVL7q6JgEgFqbPNVDFq/YDGRYoh/WgLkPJ57U0yac79N941iApmuRgfRbrnMbpLQ/Vb+xzaIx2Tp2GoTsZn69tTfYlmfiyyMLdfkUY6wBItgQMD7bQNnbHwMiSWlv81xRAEi5OETOklPgD175epuWEJZRVJJS0oWSW8wJThQwB92dBZsIW8l6Q6HtAv7zoWGL8T7+QbfiDI0E6ranNzid72dATNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHgz5l0bURlc7FzJLW9ps0TQyohyVyC9hcqZ3V8uXrk=;
 b=m5QZbyS/viC47cIXM+QYea/4Hgfqk36F7uNb9Z1MnajBYKBqhKplWNNrcpGUCXMZY9ArJPbcE/CMqXpEm8nRNuWs5F2a2mWCFaaQfUHVsE2WKZ9ax1t6xxSuMXG1XxuXfDO3t/tIGAdt3hsvkfQ6S9n7p6nJYPSjJkENLpcVm5Usdox+LuippjOSY1hCP/yZufqyY8gOBw0sQJbL8AzRf7+YIU+Z7+P8hGsEN088yYDwjY/9imRJ7EicJTwgWOAl+tYvfhbwOub331q7eWefzbCKJiAr/64tabb9Tp3HISDL61/+vGxLGD852AnPTGA+jhCK6nDzLdMowTeJ8f+gRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHgz5l0bURlc7FzJLW9ps0TQyohyVyC9hcqZ3V8uXrk=;
 b=elqHXX4dXPyWHzA4G/mAWwTuce/2q4oJdysfDpP2l2PnbKM3iOcXc/nFFbmBUu8NjXrs3WO58JXE98OTiauOOJrUnz/fYzXiwR6VlkTWfq/Lc5ijtI88e3nDsSws0gpuS4Rd9P5YzvVcLYk+gBtyYaDQImNEFnrFd5DH6ithePXhqZXjD/zuXTBnvKxZcXVGpyTgs4+nU3RTtCRfz8qcKl8jxNIKTf1RB66rmr9tlvxbaF01+jCL3iemsMIPg61JsP66bs6P4gE10DXTyI2F9Hc3hkyBA+t1NPByf1/pilit75Vxo71Pl1Xig5nYAqvXYCEUsCQKvntGYcAk9puzBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PA4PR04MB9245.eurprd04.prod.outlook.com (2603:10a6:102:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 06:57:13 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 06:57:13 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v8 04/22] wifi: nxpwifi: add support for 802.11h (DFS and TPC)
Date: Fri,  5 Dec 2025 14:55:27 +0800
Message-Id: <20251205065545.3325032-5-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
References: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PA4PR04MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: d45ece54-f4b2-43c8-49e3-08de33cb849d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFCnWYN34pfODYI7XJJnVfCLg55pdqMn7CUIUVW5N5ScqzkIh+oJ5pNNJ7is?=
 =?us-ascii?Q?hojyT7rNlBG0LOfVJKO+NToOWiihSphnrzxnsiSdUqP6Vmz+iMlcJh6cLpp+?=
 =?us-ascii?Q?VlIboiLqPRpmU05evRbEgxwNPwdV1r/V7Kr3m7IpkUtu8fHrkxj5PhP/Ev41?=
 =?us-ascii?Q?E6nDmKqwaU6A2QEROoIC1RkUQwGuhMPppD4J6991jAYOveDbWYdT7fMfU9Jm?=
 =?us-ascii?Q?lE5Lbbl9J7ZxRBUTDKH/T8KYR/jj9Z+N/9YQc1xZ2g2CcqmVBn0jfL4NX/+n?=
 =?us-ascii?Q?c8MG5771Mxk/02vHFM3MFY84q6x7eTVZoIA3ajWb+pLCUtuFxdbdwGOXGMwF?=
 =?us-ascii?Q?kT7ybSaIRD6A8hnavLGhOKxOEkJvuV1bEiS2gJjecLt7NeMAxsMVFEQwmOrV?=
 =?us-ascii?Q?tFtF5Q64eVBjsGwN96M+2x8Jzl4l4w2HnPfQsgEnRXdJpC+qrqWCiYrM0RXb?=
 =?us-ascii?Q?MkB1WutF7LSOuCmCdmQigq1h6qgfj9jSzGCksqG/Btq7NmOOtzMak1W8lZgF?=
 =?us-ascii?Q?EMGl6EHHqNfT5rwwlfflX1RiCfCMeJKtpck50pBp4byLekdiwyadvLyYWXPL?=
 =?us-ascii?Q?BGGa1A1JtlQypYYc7S0ycs3rE+uGL4SS05TzT6LiNGArwtbfds/o944p9k7P?=
 =?us-ascii?Q?8FqZi9DSlUjUOVFubvf7gw8hr5j7NYtHKR7rObrPbHB/L7uD9qDJfIXhRxRU?=
 =?us-ascii?Q?ZM3Ej7WoVeyYCSxHD+lMyj+c3eR5BJVNnUwn9zn8OhlbWQrAjO5gcoeYJWhd?=
 =?us-ascii?Q?6A7NWV6lxOauxHZVk+jy2ijfCImlWLEerssFRzgKxMdh2rzbSxzkYhk1e7nw?=
 =?us-ascii?Q?9xo/uPn+NqrZvtC28p1d77l3/pQj28flhCEEOAfwmLMUzf0QAEYvl4fS8O4r?=
 =?us-ascii?Q?2UO664XZ0WznnxRbGmm7JLFMfp7rTiLv0gvm1YCwNrF72ite3ysSAJskIGEI?=
 =?us-ascii?Q?GaJQHjKFVXhnJmbc7hQi3pYSu7RfqcgNSQu43qi0YenorkuhTvJ9ftY00XpU?=
 =?us-ascii?Q?4sIYco4pEUReWikqHMs5LfptH0AwwANfUTaitmxR8/EJT4I/TBaatkIIQnOp?=
 =?us-ascii?Q?rwBmFr2DhAkCZT6DvM4vkKpCc7w6JWpheEFyxa2j5aCj+hI28yHJ5407WBwB?=
 =?us-ascii?Q?kGaoWyXp5ceaD88pNP6ZikB5CUUmZ8dlUv60RSnmw4yMrLNuVnuN59sBZFLw?=
 =?us-ascii?Q?ow9fCMYoxRPNygTrMX+TZfmuAXdQCE1uxMYM6oKOpxjc7M2ZzEotvw4knPFO?=
 =?us-ascii?Q?lxy9oSDElDnI5PLuf8BtCu0u+o9KEKuKqzxn7Y2LsMiAryKUStVMT0VopneL?=
 =?us-ascii?Q?GLaNv7NaeVt+hyePa76L83hiLZ7i+BKp4KthAVndPsF4xxjm2f6drUwOJZUF?=
 =?us-ascii?Q?lQh+qdT3AnOJmIGOV7ji/TYFHqDh5W+03dlWy1Ofi4IVhAYSFWNdsi2cBYfT?=
 =?us-ascii?Q?Fljl6mYUcIyi9LrCe6rMGA4P9zzeyl/rTE/YyWy6lFIz9FVtW3Bm2Qeych+l?=
 =?us-ascii?Q?m+avZkOgQb5ZIbOC4+nYSqS9BQdVmBXSsw43?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kdsno4eSllCBLA3hMBtRzI3QKvBAfz8Z/7fgWhzRVP5Rr8GmNmDbgU6UAq1h?=
 =?us-ascii?Q?ITYYiuO1R36sbTBxcwYT6brn1foepGPGH1fnqfTe2mHYaJx0+OdLKxLCRR0c?=
 =?us-ascii?Q?Fsn+BZ+zsxk7jpzIn79wRtswDUNlNRIGv2Hj2UDxwMurG3lkhVQXLClBuGe1?=
 =?us-ascii?Q?15MX0cTEjNELIZBmTX0SFd0gfPeyUnyWqFC9YIKwA1pgDvzatpTCPClz1EDv?=
 =?us-ascii?Q?1iRLp/BIw36M8q+oay10DTnpSLhJYOsLru74ckL8CIcgtIFA+hc9Ey/Nejei?=
 =?us-ascii?Q?UaJPe5kn+vhRfdIGSDDXiPPANqpXiCnBo9wA/cn4jwf7LPFidny6KQQJVgNH?=
 =?us-ascii?Q?7Wcj65NE1VjvZf4yYtOvQTAnIO7+PmcZVUvG1FMAQ8qVyYfV7xvo18VoN4NS?=
 =?us-ascii?Q?hOBiz/Mtz4LfQ3MfQAvDEc520LTmDt3jHyqz7hAaRPKIGYXH4vAB91W0EnND?=
 =?us-ascii?Q?BzXyzfAsqhiNvO3yEXpNKBcQ33L73A04+c7rXdBGYoSjLlV5ZVlTPGhuMyv9?=
 =?us-ascii?Q?G57AuSQ/0lKDjF7o/G1KT0ZK0atC8TQKLTmrSrKpJhcewdSzwh/9hrlG+msw?=
 =?us-ascii?Q?0zvLN6MXD/ZdEdavg0PRo+6z41fpCxQNi8A75Bz+X8teakeOVoiYQETeLlv1?=
 =?us-ascii?Q?ZlaDFdm4B5PggkK9uAln/Mvt6fBYZu7nWSJgjTevv0ftf5CaM4F9CdltAbwi?=
 =?us-ascii?Q?JbIwt5gKAh5m9j5t23ZdHTnZhEWZwflDTXoW21DOpIdK/vOE07FoS2ozt926?=
 =?us-ascii?Q?2NuCsV55f6Lb5wAh0a/uwazUGFsk/JmGHGtyHDhpJS+13/EeLiff5kSt0cCY?=
 =?us-ascii?Q?tQquUwrtomP8eEmBz9bky/OzhwrL19OIyS3Mtl3h4tLP0BqYgXBESD1fpnJC?=
 =?us-ascii?Q?RKswKJlfE0/teWv6WxheTOkSLN3VmakLWVa42aTLZRGvdP0cKU+B9wk38nPH?=
 =?us-ascii?Q?wefHp9ki2/ff28JG0C0pwmfi/KjvNzuvhDNYMaUDQ+RflQPhowa8XWQ6odw1?=
 =?us-ascii?Q?ZYRz2Y54s88txLhDXfyTboagJv24Iuq5PIKj9SmqA+EkTuxJvY1JCX8s60ik?=
 =?us-ascii?Q?Poe6L07t9YtYzF0i6YdBXEPBQlmxotdDNNWozv8TjpiaVKIpkFIReeQbhFvr?=
 =?us-ascii?Q?LzNdHeQjJ9MwulBOCNbq4S1Nn7Wo8KJ6dlRS4P4DWORaXcJ2aoquOlWmEAn3?=
 =?us-ascii?Q?o5uwm7fq75jrbRzRTWCruBEG1m0T5IDhjlzvn7DKhZlm4IcEwprEu/neeqiD?=
 =?us-ascii?Q?frHBBwMgTVO4Q/GJgXoIJMcwefN9LnwLt8XeSja+F1q5FQoz3yFwjcS6r3u8?=
 =?us-ascii?Q?qDA67no6w5MyVSlO9n3OgqEdxVCOgXzdPPbCGYgvhzd+l1GGTQjF+BYAdS8p?=
 =?us-ascii?Q?gMVuRUSHtdh7TgdV9Cec+fkxY56sFrGmzZDCiUiqhevt00Zeyv8+e4xvUUZR?=
 =?us-ascii?Q?11IEldrKSObhSEQkyvpiuHXlUKEteC0ObZBgH+O7tNXFbQjzyXB8pZBbcqbv?=
 =?us-ascii?Q?AJml+cZ7hceSLbVfPgpbY6KCD2+HFl45J7xDrQIwcmvbVJLoXxMgEMSC/s+s?=
 =?us-ascii?Q?T76lJJ0WptaT+tQORHdqIVTDdYGZywSuRkup/H4x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45ece54-f4b2-43c8-49e3-08de33cb849d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:57:13.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/TvgKFmXTLhd0J7hWtfx7kfJ/P6ym/5ZlwgvhFRvocnuoq18WKEH6cTPJibrpMXZ/dIA/JdP/HXRsviyhfeFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9245

Introduce 802.11h functionality to the nxpwifi driver, enabling
Dynamic Frequency Selection (DFS) and Transmit Power Control (TPC)
features required for regulatory compliance in 5GHz bands.

- Adds logic to handle DFS CAC (Channel Availability Check) procedures,
  including radar detection, CAC timeout, and abort handling.
- Implements firmware interaction via HOST_CMD_CHAN_REPORT_REQUEST
  and radar event handling.
- Supports TPC through power capability and local power constraint IEs
  during association.
- Enables channel switch operations with AP restart and beacon updates.

Firmware is responsible for radar detection and reporting, while the
driver manages TLV construction, event handling, and cfg80211 integration.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 354 +++++++++++++++++++++++++
 1 file changed, 354 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..50fe9430bfd9
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,354 @@
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
+/*
+ * This function appends 11h info to a buffer while joining an
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
+/*
+ * This functions processes TLV buffer for a pending BSS Join command.
+ *
+ * Activate 11h functionality in the firmware if the spectrum management
+ * capability bit is found in the network we are joining. Also, necessary
+ * TLVs are set based on requested network's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/*
+		 * Activate 11h functions in firmware, turns on capability
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
+/*
+ * This is DFS CAC work function.
+ * This delayed work emits CAC finished event for cfg80211 if
+ * CAC was started earlier.
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
+/*
+ * This function prepares channel report request command to FW for
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
+/*
+ * This function is to abort ongoing CAC upon stopping AP operations
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
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+}
+
+/*
+ * This function handles channel report event from FW during CAC period.
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
+ * This is work function for channel switch handling.
+ * This function takes care of updating new channel definitin to
+ * bss config structure, restart AP and indicate channel switch success
+ * to cfg80211.
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


