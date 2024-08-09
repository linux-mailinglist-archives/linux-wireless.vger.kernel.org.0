Return-Path: <linux-wireless+bounces-11188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D994CD99
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A50A1F21872
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476CC194C79;
	Fri,  9 Aug 2024 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gvJrmTit"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013064.outbound.protection.outlook.com [52.101.67.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45020194C69;
	Fri,  9 Aug 2024 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196796; cv=fail; b=XZldeSxVIwTy0ETVvwt3RAEmCwlUn1HWZAXSgrA29WKBE6yx+BjP8osINYg/CrrsQeNx1Rk22/gre1zo4ASvMph7HRijl/q6BcCa1KUoshYJFP8Zob4gP+lTQuyKqY1hZK6avLWg/bkEi1sOd/2hLR8fkOIqPmO+oxNaO0mUefY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196796; c=relaxed/simple;
	bh=QWKbkaSaNbaVtbJQGMeEXDCm8ELfLEM6Au7R9BuXTdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DJi5yAjQIrUWAmMEgOVGqKzHy626iwNgNnB72UTEYTbi1+WwTO8owkAxXd1Z57YyTVDCdXW5TnNQFlA3JyfcbOtPM2M78L2RxGBjRb80NZNbh/+8jgI9ESj8iBJt2Ng/7PFzzm53dI/4hR+1Ufamihv4SxQo9Bockc3g8Wzl3HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gvJrmTit; arc=fail smtp.client-ip=52.101.67.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0Zu7GewcLK0qn8KdcGQg1FTts0e4c4Mi2hr48E6ZrXntgkncgjYTRaRBzxKkPrIwrvmOL/y07Wqxu1PZXr7swCApRCwPsFBx0RZuTEYcJcWdoUDUY6OyWTicOKVg5e8HuUUTyn1L2oTB6ooYBfXjj7ai2Wj/P/+d0ToTg7DY5nYC0uOi8hMqNNVWH+1IZtrQzZp7qzBntfy+QFF4N7rLErho+1tXwiszMqkPmD6COMSGoVTYrduzQ/+6/8utt6q2PbfMA06ILNr1Ach/FFMOyI7JZdrmQOsO0lv++au2mJJ0zWaJvkn6mAMvwH4MprfoLYPIH7KAH8wLTxxtLOFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBHjJCVxDsSzN5UzZKlN8f1WBHZH5bXsLg2QpNX+dRo=;
 b=CEz2O4EAlOehXj2xdTzNiBTSiUWxnVtVLkMCNcllJZejfsBan2NZWpyAmTxIvSmp8gox8WddrRLZJHKkqwYsM2+BiF13Cb/Rux0h4Z8BIqbRh679PuvfzwJ+omA+BXeCI7Z/c0gn1uOe5H2doVuy4r3qtp4HC6MyzF5yRlc+vQBdE7sb8jCtlzqYFjdhP4TXmaVUHofvGgkxfrAsShmwqLCAI24xla8SIewekLc0tgiVJvnYzItRcEIpodBCr/yuz7eM5ZnWKZutCn58Vlhwv1tb92nFgVAkMDMkTYSaW/wPjdDVpJCa5kr9AMTV5BhN/6kgncDt7V3W9+GxWmk5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBHjJCVxDsSzN5UzZKlN8f1WBHZH5bXsLg2QpNX+dRo=;
 b=gvJrmTitx31z4YrF/UbFytPixVJFaak2Krg1L5c+s1rS9+pDxm0VGBnZfQheoUcROB7nSEz/X9TLu3qowoz8bVmqASPfGqPYB6eVoayx/M9dmvtAqY7otjedhoVH5Ic4DPd32lt90k7dAyRK4bz+Cre2QHVbnUQOBx0uxh+bHKI9uSm/MK7T43+yGxfKmhR3sNVY852/iHY36ljcm3PK2m+NS5MR0v277hAQYx7q/YGirihLjQ4s7IrkbcyqtXrbHxOAPAQgGbObrIaF7XNPbvfwmK5s4PTcvPtq6BkapZJGPHs4Fzuc2PQ8wLvuG2T3RaF5hXiP4HdSNXEIllpeEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:46:28 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:28 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 11/43] wifi: nxpwifi: add cfg80211.h
Date: Fri,  9 Aug 2024 17:45:01 +0800
Message-Id: <20240809094533.1660-12-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: dfc2d294-ed02-4b39-9448-08dcb85823d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XJcsIJO2tqCFBc1VFaE4Q/aT6C15VES6pZXyK9yXYdVD9su9UvqlBSnaOGmL?=
 =?us-ascii?Q?trhtwOpvX4nNf/2fpj4q9QCZFlThg8ZBhOgYHmQFOIPr/fOYjK9neuY8Mm7c?=
 =?us-ascii?Q?lWw7VKp/uyBmaUX0TFPLhsS1umc3jvrG5lAf/rfCq6XcVPhyZVna2BXErvDm?=
 =?us-ascii?Q?iocXmqCWaeXRg8TGxZze/Tta79/A2Wx28qCzxdKHp29P97xLHfCm2UVI/YPj?=
 =?us-ascii?Q?Fb6t1mP4idxKKoYck2k2fuu5cKQeQUw9pbM4shm3y2Mgxz/VZb+2dng1LbbJ?=
 =?us-ascii?Q?WDubEQ4W1O5wP5n70PKq6/Qr7e2gSJ/0/h2MI98RRa17mrpyJqIlu7TuZ5U8?=
 =?us-ascii?Q?dKVvQJ9Z8ms2mUTwbvzcSoxVWzBokxb9L3xHznZyXS9wLoutz1ewQi0aI6BY?=
 =?us-ascii?Q?AvYvoQRvrqkXdYUbgx+6ERsaUgb03fqpwIXtRN/Jq2w+y6IAEJyMaRqMFAxo?=
 =?us-ascii?Q?Yz4Wd5gIOAM8ZBeUzEcV4Old/xzB+wJqUu56f6HJ0BmlPvCLz/Uv430K+eUq?=
 =?us-ascii?Q?eV81ETfF5tGaHcjKtINMcOiREmfALF8gE3CYuY/p8Uuz1psWV1xNXNqN6t0s?=
 =?us-ascii?Q?Sv3SzCjMqEkO+NmY4PcdbT8OTIMMQfYczt+emsrG5ekzUSJqjTyF/yfFdjx2?=
 =?us-ascii?Q?xbOI+I0PDDNIAKgnFHcXI0s6HDA9awLQ63ulJAKsutgGXNflMDUEQqi+kew6?=
 =?us-ascii?Q?VyZVpJC4AfCAjtVhKbzI/U2U+jeWagRE3hzuaOk4FWZPojblG1VlZVdzZGFr?=
 =?us-ascii?Q?bQlMcOeA1OF97rZHsmnA72eOC/s2JsyXbzfawXTrH3q7rgvpfuYysx5XfamT?=
 =?us-ascii?Q?7mVqF/7OC5Imh6tY+eCT3OtAaLXDO2bQbw38V+e92Xl6LjxbWs/gg4sXS7rP?=
 =?us-ascii?Q?v/QbDBtzcDVnokzG4iEtz2xEw0vvEyPBLifMueKxfCJEZLH/xBUWePBNJ6s5?=
 =?us-ascii?Q?z451Kj9u65UiraGD5JwpbEvIFdU9neofIvRVG8JcBqo34BEHLLssFxFWiImG?=
 =?us-ascii?Q?MFQJYU7w09YqMai3J313XYwjpIp3I2niLgg05yhHM2+qhnfAvM9eBGye0VpC?=
 =?us-ascii?Q?pqsOpUXkNicHdh+HAfSFDAJXYs7uRrefysG17+1n5cDgHuoxgJv7q4iG1ETI?=
 =?us-ascii?Q?ryfexdnIWMtY6E3gIBn1YPkK6VeViB9LLzj0fz4rOtsKcGaG/E9sa1OboLGi?=
 =?us-ascii?Q?PwxNww34fkwbJMEJ/hM+9I0xwMaXM+ygiSBXeeQOzCVQYO5nU8wgriIQl/kF?=
 =?us-ascii?Q?o0ZvjIPz9UvgamQFf0La19ur/f/AGwpPD0FQPloS83Opt95ttm8m+/nQL4yK?=
 =?us-ascii?Q?g/0XL1alQ4fT0hFjagDLwM5HYI846lfCjgyS64Sb7UcVEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Clk2AgKDDJHpuYMiAeUJEiJ2REPBql8N7uMKWg3gpi15LcVu9ADyJIRTduwJ?=
 =?us-ascii?Q?WfeOmtoN7rHqk9S305VvAChLIPJSgp5BxiRze8mqwHIYh9DV//u3ZtL1jtuj?=
 =?us-ascii?Q?79cSyQMYgJgEX1UwzDQlGX9cyn0tgRrb2V4Xrrj3/LW1C53V7AutrZ25PtQ4?=
 =?us-ascii?Q?Zq0Ni/Y+GjsvzY2thabOSRF0gD8Z5ejeUC2vRE9hxtcXOeFRbtzwN47gB6Yh?=
 =?us-ascii?Q?e6ML9o1hzp3BXketu24Rkb0wkLrHuONYnjzhcMaZSGtaDFbcebgwzsD4nf8S?=
 =?us-ascii?Q?Zu1+RSMIo7ypMHSRq5rRvbdjLtGIfzC9UJOvr5wcvQT0nXRp7bUvpfBRX5MG?=
 =?us-ascii?Q?GVYQKiLUlo4t8kuhMjJGUeGpPSThHkF0ScwZO1mt6ygQ6OsB1sNd1TgiK9+C?=
 =?us-ascii?Q?M6v3Aso/a4IaAFdxBFgyioo8u5wXizCFBTDrgmSqbk6WmrG2kYnlkiFxByiJ?=
 =?us-ascii?Q?1bRa5/v01yBRB6Poa8immEdharFkKua/NnF9e2xbnxH7nkKAS3g/u0CPxPoe?=
 =?us-ascii?Q?imNLyV5IAy6ObzFh2aJOKbM1hT9F248GaE4xgxeRZnhd16ug5P8CrJUugUPo?=
 =?us-ascii?Q?BULpE60tpY4XRvngKX0adaq58Wsl4rqXRQmai5vjZv6QWkqOAYNV1epglrOJ?=
 =?us-ascii?Q?UUI0Ppi4BTEknxqMpK1RX+ENlarOy4t4qlW/ewss+D2Sg8iEShRtSYxpbVEP?=
 =?us-ascii?Q?iqTOYRGi5y2jvA3nQBfHqyDHmGyYbeJwFM5PmXEyL5M7sC4murVOEIu9JJDH?=
 =?us-ascii?Q?kRMaZo+VR7cp/MI+I2iQ44t2B1rAkMxcTUgNNLsy2slz/rqIucMrE6FgNM0d?=
 =?us-ascii?Q?aRyGneVZ60kthYwRBrdYXl2ihHwHQb3GEKBUDmjRRpOnmJoWfOJ39bQztzMQ?=
 =?us-ascii?Q?ORoiCmspN4r7abxJXjJIrMxUO6iUtiC9Ur1KFciO/eNtMOdcdh/r0nDq6XNn?=
 =?us-ascii?Q?aFe3sex5RImLaxDt4xGi0vSKYGtKXJebEm5DaUH5yvrCiF1Dpu+sZZ+uWqms?=
 =?us-ascii?Q?nvILYbA2okPpwf6HQicgJhlVSXMaTDFPO5H4X8gtOJVUipy6pC5sXVmDUxbN?=
 =?us-ascii?Q?hAVBSe+T7wnw1heVEsNMUY5nV1coIn/PgKUnL80kHSTAXj9EbT0uiB9Z5Dh7?=
 =?us-ascii?Q?NwjgtI+6HCA6qOPPA0JJFEeIlTa5Ev70g3fOkXn9O2C+zu2xhOulvvbmQKlB?=
 =?us-ascii?Q?u0blhFqm8HjAuWJe7kc2qdKCr7qF3vIXQnJeTlgLjScWslklSy7lfvyRk31V?=
 =?us-ascii?Q?JZCh3YkwXYlWIZLNNbaju6yM1cSvz7E0Ac7Di5+g9VXOM5enjoaTNZzqow2X?=
 =?us-ascii?Q?gF1m0WMHdOG5IkI0UNEvvtnpIMgVzczMAcwXuK6BUcZs3IcpHZDCKD5/ki+n?=
 =?us-ascii?Q?0GwaIJfTShyN5JA3M7IoAvSAm2eAQLGI1pSEVxFjXACDJ2B6HoMzUIb+Rkt+?=
 =?us-ascii?Q?t7+cJAvUPFqX1ErInjOIRrbbLG38vgmO1/0KuY0QEX69dUTeCIUykkzw/Ued?=
 =?us-ascii?Q?k1iKKjdRxRab8W21AUox/32F4miWVTC8LfoE8CAKPZGlWO2+7TqSk9Rhgp66?=
 =?us-ascii?Q?LHe3cm7/yZnki3OfTjZ7u9uEr0KIKtYvnml0El94N6NyaJCjH2A9Q8NQgGFl?=
 =?us-ascii?Q?k/2c9zjQ6GvfApoTyBHvj17TDEDm2ixQ7fGI2rltiuJH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc2d294-ed02-4b39-9448-08dcb85823d6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:28.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOi3Y8rvhfS7Sftrbqnck3M54iVtuuKb0aYipPr9Q4qq7LW9u0LhESZUu4lvEwsjCj6mDi4T/9UAQw8P5hIc6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

---
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfg80211.h b/drivers/net/wireless/nxp/nxpwifi/cfg80211.h
new file mode 100644
index 000000000000..086ec9ca4cc9
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfg80211.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: CFG80211
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef __NXPWIFI_CFG80211__
+#define __NXPWIFI_CFG80211__
+
+#include "main.h"
+
+int nxpwifi_register_cfg80211(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_cfg80211_change_beacon_data(struct wiphy *wiphy,
+					struct net_device *dev,
+					struct cfg80211_beacon_data *data);
+
+#endif
-- 
2.34.1


