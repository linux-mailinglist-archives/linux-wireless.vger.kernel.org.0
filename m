Return-Path: <linux-wireless+bounces-11190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968DF94CD9E
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A11C21DF2
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36B194C96;
	Fri,  9 Aug 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hFroGAFq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79531957E2;
	Fri,  9 Aug 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196804; cv=fail; b=GO6Q+YWuLAwnZVLjbKAgbgXNebpUtueSA3dR+h5N8MU27ndc1pXnpDsrLVTLb4m47VN/ytH5fGDfCiiM4Mt0evgpZ9ugRbKvZ5zVLNtR0KR5Oov0hxUuQ7Ujpz56jhZOcN4QXs534ftZPfblgyKrpKQE8mIWUhm6mvSLjQ7hokA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196804; c=relaxed/simple;
	bh=00hCiK7/BwzQH7lN+WBpRr1iRn+cvYeOJz/CFU9NVnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nUQKS8EvTnbkKJbQd8XQdh58MDO7E7i9hf2SjA17dKJQ4F0JAOoydVz5hUwVz3UZJBLHfQSGxbt2c6iYEOXVg96rvLb0RvV+8aqw9I95XLq4DkhpDNBteaDdUp4xFeqBHxauUTE25CwGvkC8LPnUW2W6Ts0VaKmO/Oi5EGZC+cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hFroGAFq; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWN6S+Ny5Cav10kbqqrEjbe0uabZu7HueraaPvl7x+UxpUja3z4oiGD1HQzNOfW3rOpK7cWx7jjEn+HJFUhItrAbb7T9iVPZg5n0QlQs39HHgrPEf9MtWz5wNAf1gsKSVFPNN/enAkqylziMZ5PNIbJeOcH1+Bq3JVk/QK6d1frEaALwucmsdQ3MK5TqvER788QHBeAfh7jEzlwAPf+uUTSRDw02aHiYBVIgzS8p+N+ucpMJ6RoiFi4F/Zc7tcga2p5BBWx591OnGnHgOR+2PhHeT0micSjFD9ymS5HBl2Bn34Z1OuiKaIClaSDGD+yGQD3qwMIEoxOsTaeM7IbqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoBZLoCW4gBLbF736lnajcCz9D8aqYRFhv/UaE1f27c=;
 b=lWmblhIp52SRI6p/tfFouZKlW2oO7HG+iykakcF2pQbOVkVDyVs0jY8GLLUcEHpWiGUZwZW6ycH5veNJmasQKR7SXo5OdDyP8XN9bLZF8NgJN6QxL+iqxC49y8CGyDqVTmzmIPgsNFJqH91/U6ew1L7+dS+Y54F/WKreSghjPUiCF1zaNQMuk5ui1jtmYD8zdyeJRt1kUh++z4cm05Ym+e0N2T8IWtz2RKRwFP5pydjPDThWnRvIjkNVUbMY+969iqiUlauuixOR+DIq0A/k13JCZxtjDHFA0JKGIWaUL80J4EsdtZZZX+iItQXeYNTlC4ii+ne70VbUow+eaMBZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoBZLoCW4gBLbF736lnajcCz9D8aqYRFhv/UaE1f27c=;
 b=hFroGAFqCox6JmPpkPZ0iiWye3jwHOW0YwSifvK60/HQIuOb3u1NL8FSq/2awpsFqxfh5CZN8n/5y8w7Re+Zkvv8yIpFtlSaERjuHmjDaNVyd5WgPXWkMAByaylOryb+LLaQOj5ZYnZGRn8wKE3gsfm20OB7f+ruwlaNMCbQfm73PYNpxbvG+wIQvIzVuo9QT+Qb7NVZLcoeKYWQ/AtMO7DDXhSO36XTxxzMM3oxuE8mFR+4P/0AQrHVQ11fvnOAeSsbC3f2cJ5MGmZ6pk64R1zrfYGVAVHYO17VXa0FCTTtWuJpsEv1wfX0yLcVY9poKAXDQI4ragoQjxFh34dMBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:46:34 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:34 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 13/43] wifi: nxpwifi: add cfp.c
Date: Fri,  9 Aug 2024 17:45:03 +0800
Message-Id: <20240809094533.1660-14-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2b5dde3-d03f-4329-baeb-08dcb858279f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y9rTmQ5HFrh1/8G/A/sVhvYgI/LC38Qpur0fEfTP4nFBmP7tgzTKZh4ST0Sc?=
 =?us-ascii?Q?vSF8HK8x4m5g5XX/c4YnYrMHn18AWD5nfs8aMLac65PwTE7HZvUowIIfMFDS?=
 =?us-ascii?Q?Z25DO9o5nEE/uiiSgJZ6wEbKaUlVDiW+lBL8wujU5kaUnrWGia3YBsgwuaqR?=
 =?us-ascii?Q?5+wAo7eiQWUpbhXHYBul95C5wTnwibXVfKsDktyTFFRQX07JqUFFucp6f2nq?=
 =?us-ascii?Q?iAYsX0O6L8n6juOBZ9CeY3aaCJtyiaqQ3TRB6cGHbRgG8Cs3xeiqwQKLUWIN?=
 =?us-ascii?Q?wl7TErCNvPcMoqQJ0YNeRrJ6et+Lt7nj47Dra83YNaSYiCt9bbE7fvURSEw3?=
 =?us-ascii?Q?8a2bJFF5wUZLBUVe9ViC+zIq5OAjwN6lh0iphXaBS/0PWO82SCeDFy2iUQd8?=
 =?us-ascii?Q?3auzTEkMveeKD8Ku1zEd4gXr+DwJmougJHo0cnhYbwDRRYs1xVEl9OWmQqw7?=
 =?us-ascii?Q?b8Sp88Da1fqqIrV5ny+964EEcxBJHHyZj2FVMaa9vakrdYLk+61b2Mkfxvwv?=
 =?us-ascii?Q?Qm7UtiqBMDFKwkiPw6in0n5oS6WCmrYY1fpIn7bC1j9iJH5HzLdwDMDn7XBs?=
 =?us-ascii?Q?9pvIg+3FRAbRE2OqBB48YeYm1yJudQaGgDtlmeE/GyGPhkf5k1NxW7CDdruw?=
 =?us-ascii?Q?lKkhyrVvM056MYnU6KcL70gZOD03iKUvTD+g0P1CMiLmR4Z4P6A7/tawY+yI?=
 =?us-ascii?Q?Q7vSLC63qQfbjiovJ66WmffDvgdtnNDiZSkCCLFAFm4UMJKIKJqr8AgDVcEV?=
 =?us-ascii?Q?cc66JDu1OAbDeQbP02wgpgSljGJSCdjGkGW7EtOuoSFVzbcuwsKQWl4/x8G9?=
 =?us-ascii?Q?myCOOb6Vu/x1rDyQOG+N+JlrO4Ob7PSEjw29xFKcsrW2oqDtQ7bTh/ZOryFz?=
 =?us-ascii?Q?mO0uBsN+36XZZs5KmCADnLp71cQIBf4/GwaFgJ9x3LOJnLPJqWL88gEBpw1U?=
 =?us-ascii?Q?VtrNJ/IdqosiJ3+/LkbmRLFKhORFZ6N58lpLFUZd+ZXX5hbuGej7csSB5JGW?=
 =?us-ascii?Q?7f/L3ZxDV1BEfPvudycJzO4wuUeMFjgZmcCGDpNTM7IS17eLNEb4/4qZ4n1z?=
 =?us-ascii?Q?CN7J5bblGiwfPl5kl2NEIla8glA7yGqAP+N2gAsM3sEf1HGGCzULNeOHBM2X?=
 =?us-ascii?Q?NEpc07UTgS2U0Amsr1Fvce2thTt9TApnZ+J7oZUfQKgkwb3MvqRGsXtjSK/D?=
 =?us-ascii?Q?Cn43y5m3jtX91H9tUIFkgWfUyKjZyzGS79tb2WW4alWIXST9Q9q6fZWbt3nB?=
 =?us-ascii?Q?EwHHCO4J8deYt6k/bTIF4vPt/tmZgYDlHOmH0+mU4WQe4/cSwpyAUP4+492Y?=
 =?us-ascii?Q?L52rQlQPNy8xbo07ykG51gHLcHawqIaLcgf+UOUx2RJVkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2gxsdBAjUhU5Z30XW2Gy89QmtpaQuzmLy14+dLwrsIpP7QzprbtvxXUGVZ5N?=
 =?us-ascii?Q?RtQ6sO7fDTtXtDMRGtqhNS6hwdc9t30s+agjdjgKurJzkpNE0TDE6K1HfRkr?=
 =?us-ascii?Q?CT1yPJKL4YjxDFK5vzNgi7eGO8HiR0Pp56tDbL5BV63HQJjrDk6fy2lc4vhS?=
 =?us-ascii?Q?Z+Px+7JWVGURLDLPKgHrzn6SILoI2T3Asm7ZhJRnEvPwLT0YmQkPYhojjqQg?=
 =?us-ascii?Q?Fk0FpEsjoN4m37D816oPggzh+nI169rPvaxbK/BvK3YaJ/DvJJp9V7nibHxH?=
 =?us-ascii?Q?ceBL8ixrd7bOh/uEoA2nlSaqwctspnPObhXopFsyGOPHsUtQI6PPxPvlv3uB?=
 =?us-ascii?Q?HOrwZlCrWUOA36+gGT8pncFH+4FGo8O+XPh36lLOqHocVrf8D220jikr4ggV?=
 =?us-ascii?Q?wK0ztys48AMiNIBCW5DmXywwlNQpjNG1VGfQS5Ahi1qWMRdp3GMDiFfyiY4h?=
 =?us-ascii?Q?SqEGHTzRSpOh4u+PqlO196+4gdzfo1/vuj8WGsqQTWkx0HVHj5f+HlZMEvS6?=
 =?us-ascii?Q?RZfub9CzPvz4SsFl7mLnN7I49cdQnRytMEiBYrbI0Ei57Ux6LKnyk7v4dzQm?=
 =?us-ascii?Q?R+5f69h4Vho0XCTbcUReGuEtw2tpuRYJVYwUR1+1PSpVhfJCA5ceCqveb+HZ?=
 =?us-ascii?Q?DlxpoBJoYdakj4diZzcZPq6lP//WI74xWDjviC5wy7QKuHLp+qC8+u7hkG6S?=
 =?us-ascii?Q?Ac0xFcTlCeD+frWAFNi5u50RE+l/wKkAedetkLbASprYYxng1+IbagfLihu7?=
 =?us-ascii?Q?FOoe7Q8wWSEcCb2fvH/phznPTY8exytn+gsKL+4d4ddtPtyyaMuMWWOtLnk8?=
 =?us-ascii?Q?urtVdM5MedbGTq0QE76w8iF8i7vrDT7Yzo99FXeZSsnkqCyXm7DeoIePyH1a?=
 =?us-ascii?Q?m1RuUDxe8J/oD5Z1D08ikoZtrMj4WXpiHcGTY+6Oj7qCQQWbVJZdoUfWKaYr?=
 =?us-ascii?Q?E7L++hPppSuz1xbNOKx0FqAZG6DAGVSV407HVR2wQcleemmNRmt4ebTlXE6X?=
 =?us-ascii?Q?u47/YR9Wv4V+kD1gINBuRrbgpwvGFie6ypKU+Anl4FVveEvW3r2sxYkiofLg?=
 =?us-ascii?Q?053NAUO+0uaSZOhpR7T60zh+nSROiN23yxfcRaWgyoJhYnOJznLHRLK+lVZT?=
 =?us-ascii?Q?4FWChIExNuQUqHdXsZBjJatxdOwS63yGPaq5ZXpm1FLNQdPxIKkIqfMK+b4p?=
 =?us-ascii?Q?FcvV8h83VZEOn22BE0zzpS78WOdKcNiiMqCC/+wig//DFYYCs1ph5lHhKaIH?=
 =?us-ascii?Q?QZMjJ4OfRNWrskG4Emfi8aYHtjwBet6Zd1BrT76Y5V6/AFkvCSwhnMY6pqiu?=
 =?us-ascii?Q?VsA7z5hIUgKXiJFc2h5kbmcm0KZAWYdKnWZk2vsg0tEq7ln/1etYEwjGP9B2?=
 =?us-ascii?Q?/h9uGCNy9jTt+5d2tSdxIISyCwe+qtIguZuSGEYzqY8+8y8i+KU59tYPMYNF?=
 =?us-ascii?Q?T0ordVcx2Vj/drxQZ25N/slXoeoWaHWd9e9qYSwuZ9WLf8tDnCt2kAp5gpfp?=
 =?us-ascii?Q?rL3smb6z8s/CAzjhd2ZiPfnkWWCedrcFyNNwmgS4g2ehoo0dFZ1uhh1Z1YMo?=
 =?us-ascii?Q?Wh5/vwi6jzdIK8pm+X7tB5FFhiB44kvs7N1ChvC4TkWtgEP265Lkm3bFBeL8?=
 =?us-ascii?Q?iceMv9jtje5kQ2FKWX95fwF991IZW1+gYPNgWQGUDJs3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b5dde3-d03f-4329-baeb-08dcb858279f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:34.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JdXg4B7bJO2rR72Z4HP9qP2o9L8J9aLIQs/m+XiiDEYHOvnOBV1NgpwdTwchewjfoecuspaCOK8liXHVDEHrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

---
 drivers/net/wireless/nxp/nxpwifi/cfp.c | 484 +++++++++++++++++++++++++
 1 file changed, 484 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfp.c b/drivers/net/wireless/nxp/nxpwifi/cfp.c
new file mode 100644
index 000000000000..249aa31c2d4c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfp.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: Channel, Frequency and Power
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cfg80211.h"
+
+/* 100mW */
+#define NXPWIFI_TX_PWR_DEFAULT         20
+/* 100mW */
+#define NXPWIFI_TX_PWR_US_DEFAULT      20
+/* 50mW */
+#define NXPWIFI_TX_PWR_JP_DEFAULT      16
+/* 100mW */
+#define NXPWIFI_TX_PWR_FR_100MW        20
+/* 10mW */
+#define NXPWIFI_TX_PWR_FR_10MW         10
+/* 100mW */
+#define NXPWIFI_TX_PWR_EMEA_DEFAULT    20
+
+static u8 supported_rates_a[A_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0xb0, 0x48, 0x60, 0x6c, 0 };
+static u16 nxpwifi_data_rates[NXPWIFI_SUPPORTED_RATES_EXT] = { 0x02, 0x04,
+					0x0B, 0x16, 0x00, 0x0C, 0x12, 0x18,
+					0x24, 0x30, 0x48, 0x60, 0x6C, 0x90,
+					0x0D, 0x1A, 0x27, 0x34, 0x4E, 0x68,
+					0x75, 0x82, 0x0C, 0x1B, 0x36, 0x51,
+					0x6C, 0xA2, 0xD8, 0xF3, 0x10E, 0x00 };
+
+static u8 supported_rates_b[B_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x16, 0 };
+
+static u8 supported_rates_g[G_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0x30, 0x48, 0x60, 0x6c, 0 };
+
+static u8 supported_rates_bg[BG_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x0c,
+					0x12, 0x16, 0x18, 0x24, 0x30, 0x48,
+					0x60, 0x6c, 0 };
+
+u16 region_code_index[NXPWIFI_MAX_REGION_CODE] = { 0x00, 0x10, 0x20, 0x30,
+						0x31, 0x32, 0x40, 0x41, 0x50 };
+
+static u8 supported_rates_n[N_SUPPORTED_RATES] = { 0x02, 0x04, 0 };
+
+/* For every mcs_rate line, the first 8 bytes are for stream 1x1,
+ * and all 16 bytes are for stream 2x2.
+ */
+static const u16 mcs_rate[4][16] = {
+	/* LGI 40M */
+	{ 0x1b, 0x36, 0x51, 0x6c, 0xa2, 0xd8, 0xf3, 0x10e,
+	  0x36, 0x6c, 0xa2, 0xd8, 0x144, 0x1b0, 0x1e6, 0x21c },
+
+	/* SGI 40M */
+	{ 0x1e, 0x3c, 0x5a, 0x78, 0xb4, 0xf0, 0x10e, 0x12c,
+	  0x3c, 0x78, 0xb4, 0xf0, 0x168, 0x1e0, 0x21c, 0x258 },
+
+	/* LGI 20M */
+	{ 0x0d, 0x1a, 0x27, 0x34, 0x4e, 0x68, 0x75, 0x82,
+	  0x1a, 0x34, 0x4e, 0x68, 0x9c, 0xd0, 0xea, 0x104 },
+
+	/* SGI 20M */
+	{ 0x0e, 0x1c, 0x2b, 0x39, 0x56, 0x73, 0x82, 0x90,
+	  0x1c, 0x39, 0x56, 0x73, 0xad, 0xe7, 0x104, 0x120 }
+};
+
+/* AC rates */
+static const u16 ac_mcs_rate_nss1[8][10] = {
+	/* LG 160M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 160M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 80M */
+	{ 0x3B, 0x75, 0xB0, 0xEA, 0x15F, 0x1D4, 0x20F,
+	  0x249, 0x2BE, 0x30C },
+
+	/* SG 80M */
+	{ 0x41, 0x82, 0xC3, 0x104, 0x186, 0x208, 0x249,
+	  0x28A, 0x30C, 0x363 },
+
+	/* LG 40M */
+	{ 0x1B, 0x36, 0x51, 0x6C, 0xA2, 0xD8, 0xF3,
+	  0x10E, 0x144, 0x168 },
+
+	/* SG 40M */
+	{ 0x1E, 0x3C, 0x5A, 0x78, 0xB4, 0xF0, 0x10E,
+	  0x12C, 0x168, 0x190 },
+
+	/* LG 20M */
+	{ 0xD, 0x1A, 0x27, 0x34, 0x4E, 0x68, 0x75, 0x82, 0x9C, 0x00 },
+
+	/* SG 20M */
+	{ 0xF, 0x1D, 0x2C, 0x3A, 0x57, 0x74, 0x82, 0x91, 0xAE, 0x00 },
+};
+
+/* NSS2 note: the value in the table is 2 multiplier of the actual rate */
+static const u16 ac_mcs_rate_nss2[8][10] = {
+	/* LG 160M */
+	{ 0xEA, 0x1D4, 0x2BE, 0x3A8, 0x57C, 0x750, 0x83A,
+	  0x924, 0xAF8, 0xC30 },
+
+	/* SG 160M */
+	{ 0x104, 0x208, 0x30C, 0x410, 0x618, 0x820, 0x924,
+	  0xA28, 0xC30, 0xD8B },
+
+	/* LG 80M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 80M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 40M */
+	{ 0x36, 0x6C, 0xA2, 0xD8, 0x144, 0x1B0, 0x1E6,
+	  0x21C, 0x288, 0x2D0 },
+
+	/* SG 40M */
+	{ 0x3C, 0x78, 0xB4, 0xF0, 0x168, 0x1E0, 0x21C,
+	  0x258, 0x2D0, 0x320 },
+
+	/* LG 20M */
+	{ 0x1A, 0x34, 0x4A, 0x68, 0x9C, 0xD0, 0xEA, 0x104,
+	  0x138, 0x00 },
+
+	/* SG 20M */
+	{ 0x1D, 0x3A, 0x57, 0x74, 0xAE, 0xE6, 0x104, 0x121,
+	  0x15B, 0x00 },
+};
+
+struct region_code_mapping {
+	u8 code;
+	u8 region[IEEE80211_COUNTRY_STRING_LEN];
+};
+
+static struct region_code_mapping region_code_mapping_t[] = {
+	{ 0x10, "US " }, /* US FCC */
+	{ 0x20, "CA " }, /* IC Canada */
+	{ 0x30, "FR " }, /* France */
+	{ 0x31, "ES " }, /* Spain */
+	{ 0x32, "FR " }, /* France */
+	{ 0x40, "JP " }, /* Japan */
+	{ 0x41, "JP " }, /* Japan */
+	{ 0x50, "CN " }, /* China */
+};
+
+/* This function converts integer code to region string */
+u8 *nxpwifi_11d_code_2_region(u8 code)
+{
+	u8 i;
+
+	/* Look for code in mapping table */
+	for (i = 0; i < ARRAY_SIZE(region_code_mapping_t); i++)
+		if (region_code_mapping_t[i].code == code)
+			return region_code_mapping_t[i].region;
+
+	return NULL;
+}
+
+/* This function maps an index in supported rates table into
+ * the corresponding data rate.
+ */
+u32 nxpwifi_index_to_acs_data_rate(struct nxpwifi_private *priv,
+				   u8 index, u8 ht_info)
+{
+	u32 rate = 0;
+	u8 mcs_index = 0;
+	u8 bw = 0;
+	u8 gi = 0;
+
+	if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_VHT) {
+		mcs_index = min(index & 0xF, 9);
+
+		/* 20M: bw=0, 40M: bw=1, 80M: bw=2, 160M: bw=3 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if ((index >> 4) == 1)	/* NSS = 2 */
+			rate = ac_mcs_rate_nss2[2 * (3 - bw) + gi][mcs_index];
+		else			/* NSS = 1 */
+			rate = ac_mcs_rate_nss1[2 * (3 - bw) + gi][mcs_index];
+	} else if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_HT) {
+		/* 20M: bw=0, 40M: bw=1 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (gi == 1)
+				rate = 0x0D;    /* MCS 32 SGI rate */
+			else
+				rate = 0x0C;    /* MCS 32 LGI rate */
+		} else if (index < 16) {
+			if (bw == 1 || bw == 0)
+				rate = mcs_rate[2 * (1 - bw) + gi][index];
+			else
+				rate = nxpwifi_data_rates[0];
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		/* 11n non-HT rates */
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+
+	return rate;
+}
+
+/* This function maps an index in supported rates table into
+ * the corresponding data rate.
+ */
+u32 nxpwifi_index_to_data_rate(struct nxpwifi_private *priv,
+			       u8 index, u8 ht_info)
+{
+	u32 mcs_num_supp =
+		(priv->adapter->user_dev_mcs_support == HT_STREAM_2X2) ? 16 : 8;
+	u32 rate;
+
+	if (priv->adapter->is_hw_11ac_capable)
+		return nxpwifi_index_to_acs_data_rate(priv, index, ht_info);
+
+	if (ht_info & BIT(0)) {
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (ht_info & BIT(2))
+				rate = 0x0D;	/* MCS 32 SGI rate */
+			else
+				rate = 0x0C;	/* MCS 32 LGI rate */
+		} else if (index < mcs_num_supp) {
+			if (ht_info & BIT(1)) {
+				if (ht_info & BIT(2))
+					/* SGI, 40M */
+					rate = mcs_rate[1][index];
+				else
+					/* LGI, 40M */
+					rate = mcs_rate[0][index];
+			} else {
+				if (ht_info & BIT(2))
+					/* SGI, 20M */
+					rate = mcs_rate[3][index];
+				else
+					/* LGI, 20M */
+					rate = mcs_rate[2][index];
+			}
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+	return rate;
+}
+
+/* This function returns the current active data rates.
+ *
+ * The result may vary depending upon connection status.
+ */
+u32 nxpwifi_get_active_data_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	if (!priv->media_connected)
+		return nxpwifi_get_supported_rates(priv, rates);
+	else
+		return nxpwifi_copy_rates(rates, 0,
+					  priv->curr_bss_params.data_rates,
+					  priv->curr_bss_params.num_of_rates);
+}
+
+/* This function locates the Channel-Frequency-Power triplet based upon
+ * band and channel/frequency parameters.
+ */
+struct nxpwifi_chan_freq_power *
+nxpwifi_get_cfp(struct nxpwifi_private *priv, u8 band, u16 channel, u32 freq)
+{
+	struct nxpwifi_chan_freq_power *cfp = NULL;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *ch = NULL;
+	int i;
+
+	if (!channel && !freq)
+		return cfp;
+
+	if (nxpwifi_band_to_radio_type(band) == HOST_SCAN_RADIO_TYPE_BG)
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_2GHZ];
+	else
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_5GHZ];
+
+	if (!sband) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: cannot find cfp by band %d\n",
+			    __func__, band);
+		return cfp;
+	}
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		if (ch->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		if (freq) {
+			if (ch->center_freq == freq)
+				break;
+		} else {
+			/* find by valid channel*/
+			if (ch->hw_value == channel ||
+			    channel == FIRST_VALID_CHANNEL)
+				break;
+		}
+	}
+	if (i == sband->n_channels) {
+		nxpwifi_dbg(priv->adapter, WARN,
+			    "%s: cannot find cfp by band %d\t"
+			    "& channel=%d freq=%d\n",
+			    __func__, band, channel, freq);
+	} else {
+		if (!ch)
+			return cfp;
+
+		priv->cfp.channel = ch->hw_value;
+		priv->cfp.freq = ch->center_freq;
+		priv->cfp.max_tx_power = ch->max_power;
+		cfp = &priv->cfp;
+	}
+
+	return cfp;
+}
+
+/* This function checks if the data rate is set to auto.
+ */
+u8
+nxpwifi_is_rate_auto(struct nxpwifi_private *priv)
+{
+	u32 i;
+	int rate_num = 0;
+
+	for (i = 0; i < ARRAY_SIZE(priv->bitmap_rates); i++)
+		if (priv->bitmap_rates[i])
+			rate_num++;
+
+	if (rate_num > 1)
+		return true;
+	else
+		return false;
+}
+
+/* This function gets the supported data rates from bitmask inside
+ * cfg80211_scan_request.
+ */
+u32 nxpwifi_get_rates_from_cfg80211(struct nxpwifi_private *priv,
+				    u8 *rates, u8 radio_type)
+{
+	struct wiphy *wiphy = priv->adapter->wiphy;
+	struct cfg80211_scan_request *request = priv->scan_request;
+	u32 num_rates, rate_mask;
+	struct ieee80211_supported_band *sband;
+	int i;
+
+	if (radio_type) {
+		sband = wiphy->bands[NL80211_BAND_5GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_5GHZ];
+	} else {
+		sband = wiphy->bands[NL80211_BAND_2GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_2GHZ];
+	}
+
+	num_rates = 0;
+	for (i = 0; i < sband->n_bitrates; i++) {
+		if ((BIT(i) & rate_mask) == 0)
+			continue; /* skip rate */
+		rates[num_rates++] = (u8)(sband->bitrates[i].bitrate / 5);
+	}
+
+	return num_rates;
+}
+
+/* This function gets the supported data rates. The function works in
+ * both Ad-Hoc and infra mode by printing the band and returning the
+ * data rates.
+ */
+u32 nxpwifi_get_supported_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	u32 k = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+		switch (adapter->config_bands) {
+		case BAND_B:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_b\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_b,
+					       sizeof(supported_rates_b));
+			break;
+		case BAND_G:
+		case BAND_G | BAND_GN:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_g\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_g,
+					       sizeof(supported_rates_g));
+			break;
+		case BAND_B | BAND_G:
+		case BAND_A | BAND_B | BAND_G:
+		case BAND_A | BAND_B:
+		case BAND_A | BAND_B | BAND_G | BAND_GN | BAND_AN:
+		case BAND_A | BAND_B | BAND_G | BAND_GN | BAND_AN | BAND_AAC:
+		case BAND_B | BAND_G | BAND_GN:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_bg\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_bg,
+					       sizeof(supported_rates_bg));
+			break;
+		case BAND_A:
+		case BAND_A | BAND_G:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_a\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_a,
+					       sizeof(supported_rates_a));
+			break;
+		case BAND_AN:
+		case BAND_A | BAND_AN:
+		case BAND_A | BAND_AN | BAND_AAC:
+		case BAND_A | BAND_G | BAND_AN | BAND_GN:
+		case BAND_A | BAND_G | BAND_AN | BAND_GN | BAND_AAC:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_a\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_a,
+					       sizeof(supported_rates_a));
+			break;
+		case BAND_GN:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_n\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_n,
+					       sizeof(supported_rates_n));
+			break;
+		}
+	}
+
+	return k;
+}
+
+u8 nxpwifi_adjust_data_rate(struct nxpwifi_private *priv,
+			    u8 rx_rate, u8 rate_info)
+{
+	u8 rate_index = 0;
+
+	/* HT40 */
+	if ((rate_info & BIT(0)) && (rate_info & BIT(1)))
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 +
+			     NXPWIFI_BW20_MCS_NUM + rx_rate;
+	else if (rate_info & BIT(0)) /* HT20 */
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 + rx_rate;
+	else
+		rate_index = (rx_rate > NXPWIFI_RATE_INDEX_OFDM0) ?
+			      rx_rate - 1 : rx_rate;
+
+	if (rate_index >= NXPWIFI_MAX_AC_RX_RATES)
+		rate_index = NXPWIFI_MAX_AC_RX_RATES - 1;
+
+	return rate_index;
+}
-- 
2.34.1


