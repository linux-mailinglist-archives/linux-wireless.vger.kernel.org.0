Return-Path: <linux-wireless+bounces-26138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1BFB1A66C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B2F1893663
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AF7274FE3;
	Mon,  4 Aug 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="buoTu1Ok"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B7274B2B;
	Mon,  4 Aug 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322372; cv=fail; b=rmZ1wpolrgsE1z9FrMI0ANu6aGnLVfeupO49Y5IZWh0Zesd8EYyLLJh9mF5JIBlYRsA4FcvTw9z6eJ24qUPCQaZKhb1C6HOXpwydqDWXaXdCleqhzUPrgPldhjQoto2r+vDkTpjYjGt8Ma4QsEdi/dAwWFbA05CdJyiytRbxab8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322372; c=relaxed/simple;
	bh=ods0zNX2YgjEyEjSlEoBnvRmij94TNjhUmbfK5y5xYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=juogpQ3eQGaLSHiubMbxlLyL0rNVh79d0iya3CwAWR/FeNx+sPS/lGKC+iYIJ6YFDc4I8DLjJvyrzGJ4YyF2YqV9HMt6Kwlm8eqHUpv7i52PXwwYThC0L4pEIJZluktyINl/+s8yvTAybPNCiKtZEmi5nmXl0rG0NkRYA9GXF/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=buoTu1Ok; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Odrm6iWTr4H6ulaLQwKYtGzUFz0IjnMg2KHMMPLXNRyUhu9MQ3mvaa9no0aLaoMKGWiT0Ze6w7DWUp/l+cdjaGNX3R1KezGD2T/49Qu6YI0aH0xPgUsmqvcAR57XqRR6DgWyCHyfKsDoHzR/cyGCvz5VFMXlkFJXDvBlqDIEs3inqkosHwgPM/FgWaf3ArT7B0C2xfXwfDR+lroXTfPOHH2wkAxA49xV9xi5vJxgI8hlWe6XKYAwkK8/FqpL36fY/5KYi5vkw6hVIsA590XQN/90nms1iXN8RlQ/xPhXOKvL+Xi3td2MHGg44rQt7PAXqFNVF749uKN3lKSq8ac+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDSDSOoi4+B0iCnDms9yNKaC31zModLrb7EIF8saVbA=;
 b=InJRJLJVK2y8XJvLcCd05MhRTPMXLOxEPMmJz9NOfewU3FKaZ0W4vrn79j0JyOytVn0ZZ8Rn3MCOnkmFb9Mr+Vdd+c2x3zXUMDk0SEFnXXFIyl/dPGcaElikYzchW1zX3y5uI13mh+h8pYRKj7HXVbDDqNCf3qQqiMUZnjr8BkMh1rg4cpiYR1uj2HoxYuzz+OjaAy3f43cUZ8DMPZq5ra3rUcWw1N5aoIuewPEsxnVDomLivlCScvBm5YHTcIo3p5YOYyc/3eDP62LV/ozDQ/q84BrAFBEQzkV6j8iraQxIveekWyTbTZ2hO3KxvvYirya8tHQeN3tT2ilbwP07nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDSDSOoi4+B0iCnDms9yNKaC31zModLrb7EIF8saVbA=;
 b=buoTu1OkAdnINVQB/5w8ObnAlWpQKSbzEwgcI7RN2e+D+oBTzxRolkAHV8fNiW1bDGeEjdIDJkKQ0Wim8aBpgHo9z9IGDZM2eT9Mdh9gka3zlv4RwZydFDe3zwmr+5qPgxrT5vOI8hxaiJLHXv7joC+8CIHjM7vRaQ+ZNmwU8P3Lv+Rt+MzFuTP3pU/6UbD9eUvtky7Ug3Mmy+Xydd2eJNjdRjbjTqTzaWXZwURSPjiKccGXXvKqKyQ+GdaQBcY8NBvg74W1LEvOPmha+csMUOgAFrWTkaXI+V64tsewQEHB8fStdhecwN+ZvDgFpn+BjFjxFzKfapoOSHNqAsm60A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:46:05 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:46:05 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	brian.hsu@nxp.com,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v5 08/22] wifi: nxpwifi: add cfp.c
Date: Mon,  4 Aug 2025 23:40:04 +0800
Message-Id: <20250804154018.3563834-9-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PAXPR04MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a60951f-8ea5-4c0e-209d-08ddd36e05b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DYxOox0CbezDlBWxJqL8Ddx0WHqWWkDLCof1T9mS8AaIft/EV0o7etXe0cxP?=
 =?us-ascii?Q?XYrswUeM6vYGFY5X1788iBBYsi3XZdIL6gvDC0TdGMWYTet61khRTxXgzWFQ?=
 =?us-ascii?Q?cfoLy0I0tOup4LH2OwxiYl9np2JSmsooFBfQWRlz1dB26b7qnD8eHmYO+Phu?=
 =?us-ascii?Q?11wXE7nIzcS1fkTxv2OumsXsPGYLs1vSBndPyuT4QYVX4RhSneDGglB9a+PL?=
 =?us-ascii?Q?9RzNQWNcP9IfGTpObY2yhFe+s6w/HVX9k5GIBL+9oVo02VWrlewdF4x8PGO7?=
 =?us-ascii?Q?zPCv3Ln+trbL80IHtZQCnkW1zaMsHuLjU3PK8WMdok5mzro8jf5/XGvSIxiG?=
 =?us-ascii?Q?zCYosRJNwg9DsJTu6/fn1A13nwP1EWJWcsPOwdswl/XYrzqyOLQ+c8i3mESf?=
 =?us-ascii?Q?N8YoQrcFmfAG7gBYXfevOBw6c9vrvrNytgsU81tc9UGUeIseoYd5Pzu/3UJx?=
 =?us-ascii?Q?iAS5ZFiFkkZuazBSvR5pd4yAJtr2hXwdDEGIEArZxn0AE4ZwSmXHdmrDzcpA?=
 =?us-ascii?Q?AqK0s3257F7Y3ViFLqvPkH6NLdpvSiKPQ7F5MDwjUboBUDe55brSWxZ5ptEJ?=
 =?us-ascii?Q?uzufPFyORW7RRv13VyeWbIIAXJUKz3uO8j1S6I4diS90gq0wF1JwODVq8Hlu?=
 =?us-ascii?Q?GBuU8UcmXIUWzRtj8VUnsOwaDm98gOU3F5jGlGPDR0STO6ZAWlgrHivNErNL?=
 =?us-ascii?Q?zZdOOaLH1stoOXZRUE/1GUM49KcUc53/r63OIyBQika2ssjdrE2Ug3A7lyGl?=
 =?us-ascii?Q?DK1o34+g3h+r1oDpvLOgJE8AWASOVJSyfo1TbJ+8gSaWBzUEGQn7EQhlPDu3?=
 =?us-ascii?Q?kZVDYMiVRnq5hieCxtc5IwQ639OQcLxqd0OFo9PBYVTv1shXSwHBHpDtEJ60?=
 =?us-ascii?Q?fWYTRjJ2bx9Ot8yo/wHpLBxUeN3vkRS3G56AOOCIR8IJnr6F9SeRsFh5eH00?=
 =?us-ascii?Q?izEPuJLHHHvpDnX7KivFrYyk4Gk6xHGphhtfNDtU8r3YpmrCWj6EGWnW4/of?=
 =?us-ascii?Q?6DvKWQflM35QA7btqzziNLHM1T99SoyeKJ3ha31CJx+aMbm3N0G2LL1RpfZ1?=
 =?us-ascii?Q?X8Lmo3MD6dElpGXksU5xSeyy39CoUcJEW9D6lTWSV98Jv1KLUDPFidbR/HVl?=
 =?us-ascii?Q?Gtfff5RFKaRnF+TwT+h45JcbHPaUAoKlG9L0YMR187uTXs0BgNsDhmrdxi/F?=
 =?us-ascii?Q?2hWMIwOAT1rdVbwyyTwNPq5x8K4cXr2HNXRBePKDnVNKchi7PZThw43pl/k9?=
 =?us-ascii?Q?rVmLN9s0Ug2M4iBdirQyUJV6+7ERnCtUeqqD/aTDDkEX3qMqO9q5msr5dtqz?=
 =?us-ascii?Q?6rTS6cjGm80Bun24Ym35YM14D2T6eW7akIzWAI/CCFuSVmcVDTcVStNASPZI?=
 =?us-ascii?Q?BHDtfS+iKIof7QhekA5SVF0SHua/as/m1u/i3Ox9SkBSAnUKK32FkjFRkb9f?=
 =?us-ascii?Q?sOmmET3Rkm4OYyOaiS8V2tcE8kaNT0eMGxXw326ffST/WtTnNAs/9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m3dlmS3MA+Z9wYFxYQwHcg3Ip6oIyuDITkRZwbo8rztxkXiCqeTSVeXQGR3p?=
 =?us-ascii?Q?TCc5/WP4jWjTCcqumJrKpyfa/fdl8+Aw+PpFoALcuwxAeNOxryVeRHxhYV2O?=
 =?us-ascii?Q?tPGNb6PkUjqFhFC5AK/u0VSyBYsOcSKibAetmASVs1j3r/h/pfat6+QrQRuF?=
 =?us-ascii?Q?k70w/13PcCY2A7yZz2mE7F3T+58GIoMH2Cis6pEaM+OemC4mmPsH0Vz8XU5W?=
 =?us-ascii?Q?A92MZGJk4JpJzuBWMgYPu4NCE0Q30ZkQ53MGU+DkbfpZFU4wpFTxL0MoqSym?=
 =?us-ascii?Q?5kLioXYtHmku9OJHxPwxYk7CUVxSxkAXcThEpSEAlJBMKgM6+fG1T2XCNudF?=
 =?us-ascii?Q?fAMUxf0kZ21hJ5UrDNU2tQhco9EV2VyEGD9dpKA2mkgW5yfciIZ9V/ZNSkcP?=
 =?us-ascii?Q?dtqp/UYBU11rSjF1TF71e+B8hOAwUYO6LWu61Kj+0euANNhfMUvegjxOdP5k?=
 =?us-ascii?Q?QAfSs/ijzJ3mUxlZcwCI/N84cwtizNiAPtS+sLBBV/MkyY1MBXhAW/uOVvwm?=
 =?us-ascii?Q?32ZnDIXUgIQIKStbhw1nZ13ehGBILo5nY/Gup+X8Xsg/BzsFcRlYK934pcBA?=
 =?us-ascii?Q?h1TwGUlaGCbjcIf9fNzV4OvZxM/rfpmpVlWqCqxZE2xGgGkwx9cy4GYPPF/o?=
 =?us-ascii?Q?08OcngRMQiLRldXExqO0RZoo4uGXJ7hZe0t0GFKfjW4/ExRdYQpY7TPIszjw?=
 =?us-ascii?Q?7IdJHcjkPepPWO5Vwg/JNH8pDcqKyoqNj/9CyRyzwDAc6txNg8b2gBrarMS4?=
 =?us-ascii?Q?zS6zelaZw5CSBk200DTx63ujJCxORUcf1FXm5KmSJlioOFY3pKhebq1kTTmt?=
 =?us-ascii?Q?QBguaItJ9bO3gsCK7SR75doVqpSA2Y521jOKMXC2/DyHBtbeSwJK4ZRI84gR?=
 =?us-ascii?Q?JFdITIM2zdW3+SI7e9MF6n8bwNk8dsFo/WIknQhfW8/EIakMmAu/Olyaa1Kj?=
 =?us-ascii?Q?5iAaZpANHG5kzq8g9gZLMKWEcXoYxrDzySk3kBgKHOIzvgf1fFKC21MEQiTr?=
 =?us-ascii?Q?ozVm4ebo2QXvyIoj7eT6tLIBPBxCgHLnSe1QqaFoVS9Xe/XHhW3O4NYfugSN?=
 =?us-ascii?Q?C7iM7+yzKtA8bCECRnBsaE4o9YTMVIyc/uczwlzcjidc0IxTWxv8fHIea/Q7?=
 =?us-ascii?Q?15JCk8QDCCAmEm80jlRHIDugL/V/MWMV21RlpGC7iYOGEBmf5S71SQmd0z7h?=
 =?us-ascii?Q?p+1JLAtzH4VnBGJMQEVniP4XfU5zAgfJ0BOU985NxpKE8jczFd0ZCajWptQ/?=
 =?us-ascii?Q?I3cmLqFJjjRUiQbpO5gIcAvdJLiAhvoERSM64e16X9yfifBRFEyB3K03q/6H?=
 =?us-ascii?Q?2A8nd/IkRofB/2x1M+YjIqngHRuOxI9FqaUvBFpjSdkp462tIJGYCnoLgBYq?=
 =?us-ascii?Q?rOy3YqU10HByTUnXhNJ+RXDrJSpucmrGjcC4XAORVPIuC7O+ePno1jWqS0vg?=
 =?us-ascii?Q?PQHemYD/f6hgbCKFsFlh5t2XXcLBMx3zTNCK5WozGiPa7y6jN66eK1GxI3v9?=
 =?us-ascii?Q?FoIZP5tGCIE+3GdQZPjPyYfjhGCeC2hogUOXuNSFe2ErUFJzseCQ9dAIGHK6?=
 =?us-ascii?Q?nDPGcNG4uypJwi1D3wvSZPeIOxgFu1IX473AER+Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a60951f-8ea5-4c0e-209d-08ddd36e05b8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:46:05.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TX/bQs7Ychfj5sI/VcxfmN6Jx7Kp9NliGDW/t7a4B40yB39A6URHceUEG/Hr+cNlJmcA80UBnftDyM13bEnIVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

Files cfp.c supports functions related to channel/frequency/power.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cfp.c | 475 +++++++++++++++++++++++++
 1 file changed, 475 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfp.c b/drivers/net/wireless/nxp/nxpwifi/cfp.c
new file mode 100644
index 000000000000..cd0dd4a25d2a
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfp.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: Channel, Frequency and Power
+ *
+ * Copyright 2011-2024 NXP
+ */
+
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
+/* Convert config_bands to B/G/A band
+ */
+static u16 nxpwifi_convert_config_bands(u16 config_bands)
+{
+	u16 bands = 0;
+
+	if (config_bands & BAND_B)
+		bands |= BAND_B;
+	if (config_bands & BAND_G || config_bands & BAND_GN ||
+	    config_bands & BAND_GAC || config_bands & BAND_GAX)
+		bands |= BAND_G;
+	if (config_bands & BAND_A || config_bands & BAND_AN ||
+	    config_bands & BAND_AAC || config_bands & BAND_AAX)
+		bands |= BAND_A;
+
+	return bands;
+}
+
+/* This function gets the supported data rates. The function works in
+ * infra mode by printing the band and returning the data rates.
+ */
+u32 nxpwifi_get_supported_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u32 k = 0;
+	u16 bands = 0;
+
+	bands = nxpwifi_convert_config_bands(adapter->fw_bands);
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+		if (bands == BAND_B) {
+			/* B only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_b\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_b,
+					       sizeof(supported_rates_b));
+		} else if (bands == BAND_G) {
+			/* G only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_g\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_g,
+					       sizeof(supported_rates_g));
+		} else if (bands & (BAND_B | BAND_G)) {
+			/* BG only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_bg\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_bg,
+					       sizeof(supported_rates_bg));
+		} else if (bands & BAND_A) {
+			/* support A */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_a\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_a,
+					       sizeof(supported_rates_a));
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


