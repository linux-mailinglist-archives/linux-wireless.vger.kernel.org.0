Return-Path: <linux-wireless+bounces-11179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4972494CD87
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966BBB21EF0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75281922EA;
	Fri,  9 Aug 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="di2PvT7g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D0191F9E;
	Fri,  9 Aug 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196762; cv=fail; b=CIAmyfr4sIkmnJtjFkmx9fXPiJ+lCM90yZLrJ7GhE165NG5PGzfUuwsERycHXUc3VoG9ClaZBz2wI/oVWD1SgnlUcDZ1QeQ5LYBk6Kb6CMP1iXomcyvIYDeiD6LnDkHSP0VvXiWSg+ZmVDzdTPMOsb+Mdn32kXKPdAD+deBiA9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196762; c=relaxed/simple;
	bh=E0s9X8Wne6kBEfKe+YOuimdOpYWMPmKTD97YtRAWrPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H2SXg/6AqNqidxM01Wd5UtibPzs6CA5/FJrzJduqGrycsJwbplHNDgTL0RIKFCRwxEkdUJk9BAA4yTrAQSqy8tMqO9Aqmmxm02XZAM+LGY4Z6wzP38Lw+xR+gbyL94oApa0qMqu7qAX8v2P1bjhMbSlkEWpWIiRhFiEbLLc85zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=di2PvT7g; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMwP/Hgqf2ea0+/8NlWZ7o/1FsnVdQr4eISldNDBG9tAhZEM7sMMuC9SXdsuk/3tsKu93WVwp9RCzR+6l85rr/XpLwXtSqo/jZ3OTo6nCXzG8S8Ro9fJhTVn83XKZ4xBsw9EScluV4FlOrRXj8PSJgL1f+jptySfLgY6BkwfNHiyh04KJzyBv5p9dD2qgN4BugKq9PcJlLP05zjxyGiRWKCQ34bd805iSpS8zp6Gcwc6C/4twYmsJkwUWwk8S7zttt+OI4NoqWU0WX2tC12ztXa1NoVQsVbuEN+hBCHHs9kMhc0dGfyXXexHLmhWRrHReLOGF6RI0CiLlRg4EOFSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkabV74wYLnFDDb0iIkfEcSeLsp3BNYusGNRq5Q+q4Y=;
 b=dmGx783JyIesGxnEcehaC7GY97vlxdHYbQ/ipH9gIz04+3jfEPmqCeQJYC98s3H1IPQGWRcRFoRbxiPKYJ0Moil1btudjjxK/ZotJEYeWRnZsa+QaY9nsLpf7Ks8O4PalyQkQUc0A+Xr21R2YXSSnMZsjOJjzNmLPe59UOsmpSzfSwUWHOt+8fxVLJJJkrKHPkFSU3MQDqJCXgjeE9Z6U6V05uip2qK8uWvYOovsE/GNxFoD/pA0mcQm0TkkL3nXLMvEwYlQaB/4dCs1AKvd2gEZvGpWgxbuew6cNagTm5tynowwQot9RKbv0g8mqO3ZWOmy7VZAYaIS80JbFqSTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkabV74wYLnFDDb0iIkfEcSeLsp3BNYusGNRq5Q+q4Y=;
 b=di2PvT7gZugnX5lyaTTXQgZHU99mkRgCkDNIlwSkGiSn+pBEy/y2YKOXfkmU0Bljs/P12hb9RK733abyUhhJItNpk802S5fwGPX76PhTA3bMUlE4dDKlU1BbXdmcgMR6ltYYYRH7tg4lWEU7ZQs7JZwQ6k522rJOjEzl8jH4+woSuZdH3zM8gR9AA4JtWlS1+m5WIO+XZ/aggiq47fmf+LLQbPIWLgO0QEvwLaDno/c10INI6RBxmEkrEpFlUiCbxG7SwYyTr4dX2rWG0hl0Olie9q9uO1mWySh/+ItJ1ORGYkRN2hqy3t5St9OQYKYFdr8+qnqx5oTOhRRmjVyTLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:45:57 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:45:56 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 02/43] wifi: nxpwifi: add 11ac.h
Date: Fri,  9 Aug 2024 17:44:52 +0800
Message-Id: <20240809094533.1660-3-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbc0fae-b2c0-44dc-5941-08dcb8581142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cLac36fooA30zzQXK4YedOm1xPuqKnOSJmBYWBKF/gVcBi6hD5Sl3KsuEZiD?=
 =?us-ascii?Q?3TSpvHQVz6XdnagCvJLkCtlZgb/NJWTkwLr+Lm1TMVJx0Rgo5Ub2ZXWFEULt?=
 =?us-ascii?Q?O8xQRRV70CFpEbh9moTJOcPtj3KixrOtnVsqYP2aWbv5ypBURYif/NSa16F9?=
 =?us-ascii?Q?uzoS/1f+ZmUVTB6g9I69XIbjpTVNvdxKAV8A0Z1IBEB7vizmw0usSi3NfEv0?=
 =?us-ascii?Q?khL/IRvfaH9IsKR/Z0R4hP4lGyP+H+9p+Vzl+Cbn9j8zeRKl5JQN2RhD2UCQ?=
 =?us-ascii?Q?3AQ7VnLPOZUexUMw86lEd+jIOXjW4oOwiiT5ZJNk1CUUEsM8svLH3CpFep7t?=
 =?us-ascii?Q?zMctyGwZbf9j0TLTzpRunIKcaEVGisMYK5zU6zgHwS+g8wIaYImF2BTxuw/w?=
 =?us-ascii?Q?XCf/aKyqSbtKj3RRE4qnNYDlT4d2WfhgqTQKnBKKhL0XWSLmtGX28tIxcUF3?=
 =?us-ascii?Q?pjktCeQNroA3S9ZjKU4jKly9dWvymYCf4f8J8k4gFesT4Y32w3SE4xvRbdYI?=
 =?us-ascii?Q?N9vLxaaie/hdsf9JsiaaQMqzkFjlXfPwrr8F8BqwecIVvjPj2F5uYqoAUWuv?=
 =?us-ascii?Q?2Y6YnDcVH2MmHCwiw12RfreZkU0DfF/Y8TEho5Y/LIqWLPen5HArDdENHcMl?=
 =?us-ascii?Q?11VUBvyW+N1uNzM7+5qWG1oVxdh+UpUUoMbP4z5xVILJ4so0Mbk/uUHCoNWQ?=
 =?us-ascii?Q?LDlDzDV23/9qzQ9ux0jSLsc2XwR+HS3fQE9EN3VIHFKEOZf6iqP5ponoD74t?=
 =?us-ascii?Q?0A2rG5AkqqQXoP2tNw0L12PcJBilg6HjMN7FhjsD73YBLmlsn6h9OJ1XstZw?=
 =?us-ascii?Q?hwSH5+qnyOqCRSsAi6b5GFcTn4tjZRo+OTVJMfZzEA6G6dR6gRQRZZwXU8sL?=
 =?us-ascii?Q?est3qxiUu3/4Tdc4DnaTqWQZn2cUl1EfvTHBbAvt7NX60J1ay9PjlRbIE1wY?=
 =?us-ascii?Q?uOi+isaUHRuJbjy6PzW4gJbwDE9WLaKF1NBs3ZRPGmUXMtWXFl6WZQ53IUo7?=
 =?us-ascii?Q?mzEhx1Kksex3lJwm3ZfELYz0R/L8ImIBC1ScV3Ld1x7CtDGoC/RGHbZQMRwB?=
 =?us-ascii?Q?R60/MdffPX6XpDJRivRXOli0G+xC0NUYnbIR1MSjPzW4hiYT5S0qpVVNFf4v?=
 =?us-ascii?Q?7U/fhVs6x0F29rlg7t0UL6vKyNSkcIdkdNCtf0Q/R96YjnmGWZ3NEOeSx1XA?=
 =?us-ascii?Q?W6TEwKyQv8AC7pmKb87UyUWURljQvc3XdiZZBtgB5/71EgqOdht6MzEKsbnC?=
 =?us-ascii?Q?HfcPRqfa9749oAELyCEOk8HiHUPDM36DHmsJ9h61U99hno9p9F2qmJIbfCT1?=
 =?us-ascii?Q?AsbUSQpnLC6HCmXcOY7ac+FwFfB4uge7EJ5kpnU+flZRNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTOWEVgDKdgfJkC8iY+s3HrsOQcwLT7GoozJTlQPt5aaWWsWa8xZACB5Sr2T?=
 =?us-ascii?Q?8DAfe8N3RfveGCy3/mDLDRIngwGPtQKTQ4NN11S6n92QOFq9Dlzc2Re306UE?=
 =?us-ascii?Q?IdLLIU+h3ayhrVrnv6MupZFOho2/u72YFSzufLQ0W1piO342RE9LCBFa2pLw?=
 =?us-ascii?Q?VJxZb2M0lR7RZot/GVNl0G0xo7CPgvOSHjJo7n8BwpX5eCL6veXbeOugntUp?=
 =?us-ascii?Q?Qs6BjJkixBdPb6E2QdMpgv6firIafl88JMYO5LVjWrFrz3rCcN2spMkQTEm4?=
 =?us-ascii?Q?q5B4rh4v450aEe3MvPwx2cPrl0gQUH/Yt0EnQHrmz5slgR81UhOXqKoqve8g?=
 =?us-ascii?Q?HmlkG65vUHz4aMcdO8h5yBjyjeX8xjCaXjPVr5qhDpB4quYxKWtRfQmtD0ko?=
 =?us-ascii?Q?ytgkBSC5oMjeign3v5oeEmgtBHzxaUDX9w0Gjyh76PpVl35quPcJbAi4TFDM?=
 =?us-ascii?Q?+MYyb/amkM3bOxAz+Ts/W9jurzJrU5HAPeBruCMPLKS2zZc0jx0arauZ+OaF?=
 =?us-ascii?Q?lUYo/BF2/efvze8t4ZJ5+B0NFyg4dJXLRb83P6cdYvo4N3J7sCORgCYPU/DP?=
 =?us-ascii?Q?SZJrWuRL9MBIeZhYnbiB8I+Rs6rBmC9tXjsxoPl3CCHHKb6K2CWr46uQ4HqO?=
 =?us-ascii?Q?RVZUK1cuk2xfcTtiIrnB5OMZYj1uH6yVGoXVu9Gq4yjNtTlSWHjGGT+K25V4?=
 =?us-ascii?Q?M1OBG/UeVdxPEQzk3qbTHtahNdiWGX4qSrj6JgpGoUaMO25BUQjzdjM/J5nh?=
 =?us-ascii?Q?qlTQYGocCtzeQpw8op/YCp9FkzxzWhlEEk5nQeoyYGJvE5ci2d7f1sFgDhgC?=
 =?us-ascii?Q?sqLHVbw1piRFw3eX1r2rqvsuZ1X8/L8IY33aCqY9Sw12uz5CC1XOmCHV9Aos?=
 =?us-ascii?Q?Y1P1Rq1P5EdTYFF2/hGK5OpVDeEj9pPIBHu888OpF/fmUqh0GFDgkhyAVwWK?=
 =?us-ascii?Q?k/sM6I/Xs0LAkx5HpgIZ0PoCKJUh4t8D9pGb44GsuzrV6aNz/xpYoe2ldMBD?=
 =?us-ascii?Q?btdfcNmeECLvewNJaq+A+Bcuh0cUM0oS3hQUSZmFDjUQk5KBdvZUpQj79oE8?=
 =?us-ascii?Q?WfRFm+ePvqDdX8esDpFW7Td7PBTMms6BqjMNLxI08P8u+ZoEeyk9QWWkFmKJ?=
 =?us-ascii?Q?6io2iBxQjvg+AEnvDpoSpjQ72woUfBbbYC/lKj1ashX+O5htnYZCxqCkXjD2?=
 =?us-ascii?Q?8Wi/p9pzLHTzp4GGaxkMFTob5YMJp8cDkS6sFGXmF8G7un+uL19kJcbegL0w?=
 =?us-ascii?Q?Gs1JUXaB/kuoen2yQRwFJYe0RFAN8G5+AVYF2ynVdMFSwxHc5rX2/iARxi1X?=
 =?us-ascii?Q?qQpXTumQQkKxNIV0qUdwN1oXOAWHB5aoLTdWmFi22PECmYCeaVVgQPsuJ2MZ?=
 =?us-ascii?Q?BtzFhBdYeSFmWtReD7NM91p5GvpPrkNbQ8Ryzdhs6t+j0gTnDes9Z8aVMiYl?=
 =?us-ascii?Q?i25IxPZA2wK5RsJLfbF3fM0A+S8KpVwuTJiChqHc+KuciZGnVSzn8jwwg5WC?=
 =?us-ascii?Q?UaHkDNsZE8Rs4NAzlBUax2Clf2l6j4t/zIROtqsk8m5hwXuAt2+lYOil/agX?=
 =?us-ascii?Q?u/TzvKoH7jN3Eiof4xsS1EgEyCRrVgy5Uzxh+lstuTnGk9tnUZo6NdyuNKVo?=
 =?us-ascii?Q?ZjAcTPZUnz1wWui88QJPd8euGPJI/X7h9IDfLxET5ex8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbc0fae-b2c0-44dc-5941-08dcb8581142
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:45:56.9388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mvj+tq5MaNa7b53TiYutDH9z8FFvkSfktwI7cE28ACAgJ+wzvAJekrPKFIWGpS4pSf+e2IOUWiezx/Xg+LBUEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

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


