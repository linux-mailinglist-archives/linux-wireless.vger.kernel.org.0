Return-Path: <linux-wireless+bounces-13293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B714989AA0
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7551F21D2F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89815573F;
	Mon, 30 Sep 2024 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bZC0F00H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080E1714AC;
	Mon, 30 Sep 2024 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678286; cv=fail; b=kvm/DaD8OLDPurKG/WP/pMQEKeFh2DOW5dJxhIJkUN4v+fRFkkFFUue0aYrzSWJPvZs5SBsylEFJR7mxnz255CG7b3JmgewhR0kUcHjfxaGEcdcTnOckVuWx2o4jqCvQcX5+cr2OzBs7xAJPc4TJDtHVbULjrg3DAksyKb4YhiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678286; c=relaxed/simple;
	bh=gBHNpfomL5C8aByMeM5Ue32AskzufHPucinPsSA/JS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nprqc0hcjT+CUgvOwjTnBBfLzNF6pEMbdqsO5LzmdqeTlR5m6dL/uVSVk79+uOkgZM7PHvWhzgFzleD+6Iztw3s93KA8ZxsVoDkAjniQjI0it0shmOGRsoll/VXkWWEB/AGLioOehsm+t307xrCcaiDYLQVkVbRrvJ3WfFOiiNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bZC0F00H; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWdlLEvtMOo+WLw1CwWGQRpC7Kra2Afx9noqW29vGvFv/v1bIjD+VIXwRYtVlDFdQneWtWD+CHHXy7++crM6BrLg1AfLKgHEBrgh90ehauVr2Dm0xNFWLYsQau6dSlhwRL6+vlt5UgkbMUiw2f0Sx7X6AlBKvaNhWoMWRRRxh/EfuFkxA6czmaeZA1XZSjd8ArXy+tPKdWon9BgKg/W8YkN+UOd7ubK3Cu9gtAfFJw9m6k29DLiuREQ4g6fXrO9LgyxUjIwDN51EPNawyadBaF6MjFLXkJfQ2+KLDJzZR25ITwTW8rqYM64+V3NWsgX2SCKUbCUsxeWEfsu8ZVqiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=By5U3BFeUvqrtkv8vqZIMAo49PlwXH5yvtLg3RIGris=;
 b=cr2Fs0aiuXYsfj2MrL7/5ngIhgYYaOMeAtHTHEznQKM+lcdwwOyWDVESvtwzixmt16ach/ldRq9yVuidP5lyYqmA6rUl4QdLo8kItQflY7bh7c5JxV0IJSB4ZpxYfXafW93xyna2lPrAocdW/4UsIgj61eqigw28FkLzINyDa169jL099QInAfhNYLKhN4ZTdJkde9wWpILnWHHDChX8glBdUyTDtuaTxKdb3BMM57UGRw90csLM2do6inRqjM9Qdr1qZATprpyAhLk+0mnps7dLS7b5QGQ3E8cI1atJT5x61gq3TGAFstF51NjurNFG0XEvARg3VKksqyscB+W6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=By5U3BFeUvqrtkv8vqZIMAo49PlwXH5yvtLg3RIGris=;
 b=bZC0F00H5KGeaEC9Qj5mNAMdemHzTHrQYPdP41U5UB0eLAJ1spTxMmujG/GCEi8Z4BrdJLfKdS3XbNvHI8ra4vjI27Ht/e6i/kFd45TsS7vjvoJwgyCMMGmzRToj26TNR2A4Tc9+/4CjpM8AusR6t4a+IFykBFDqVLLtz+UDNn7KcXqfF8Z5RQwtUBg5Ou9kzpSgTT17RkoVtsbnbBGZxPWuBormZKJv/eOglEHxqUROWVvUcjnsJUNvICKa3sLtkcs67okWAr/ElO30huXSgovSbe/ets+maDlvxLgBtNbK9W9AUFOb3qDpPAASVTISkXAEM3tYdv2zM7u233ig+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 30 Sep
 2024 06:37:52 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:37:52 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 08/22] wifi: nxpwifi: add cfp.c
Date: Mon, 30 Sep 2024 14:36:47 +0800
Message-Id: <20240930063701.2566520-9-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: f4394a42-491b-4ad5-c89d-08dce11a68d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?taUKaOAKA5bKLofPftSAYvEyfubfCadKbVSiI4A7uWRqlEoQpJN6F+x5SY37?=
 =?us-ascii?Q?caehbJUbBKYNYpce91Nmq5GCnlayDd+mdftHq0Sd/dKIbD11ox5uvIsw9WwK?=
 =?us-ascii?Q?cLN4JtokAMdp2dgkapLTZZ8Eicn5le839iR6dAfwkcLVR1h6XeAdXpakFK2X?=
 =?us-ascii?Q?g/9w10kaWv8iJPpLeW//Kiis0mQTfnG0nfuAUa/qxLBacU0LPOlU4Ttk3O0B?=
 =?us-ascii?Q?NXiPepHII+u2TaTdUu3D1fdUFNN558xpUAo82oAVxtq9ZqVynyQKxMy+YC6Q?=
 =?us-ascii?Q?XnnuSNp5FhI7YoQU0HNGKEpTfoPJrHzZirshkUEaNJxSeIHd7RvERlgGnhpw?=
 =?us-ascii?Q?M1A2l5OTk/8dC8E4g7xOmMI310r+/YEqkdvbfGHmORKHuuItLaO8YPUVLVmo?=
 =?us-ascii?Q?76UimAjeMBLwsbrRshdPWRZemP1EpLGnShlRnLTcyv5LDfNKHqBH0BywE5bC?=
 =?us-ascii?Q?PM3jn2p0Lfktcjb8OY3NGNccGpoI5fMPIzcVH0/1eNGygOrG+kZ5vAppAVlM?=
 =?us-ascii?Q?fXf06jT6ilpyLOxYNrnZV0sorvI6DCaUHBHnv2iW2vy314tgUpSCtDJs9s6H?=
 =?us-ascii?Q?J4Ngyxf/tpqDbkkwj69N9KmdcUeZgj/QgEglIxEzaL7TgX8Geqvn8hXtfZWn?=
 =?us-ascii?Q?nu1shP+/lWYjAKviciAOtrxaHJ5Hce06wFFQDa+0ALm3OELIWlNbIBuM/vze?=
 =?us-ascii?Q?pdz9nETGjDDtcug87Hk02Ur9aUZzjOO5IzRndqlyPOl5gL8cvT8ifugdbLhP?=
 =?us-ascii?Q?hr4PYz9aANUH/u6KeUt9pFSguWgIg7eNVKUiNQHh3oVldk12eTXG9BNHGJ4b?=
 =?us-ascii?Q?whp3fGFtU8sOZUTI4LtUKb7tqO9UYpixwQO8CpQv9/TzZsutDnll448/u7qt?=
 =?us-ascii?Q?6xWxkeE0UM/uB9CUU/1z6j+m59lVxL0/6Q8AoQcNGP7rCWMXIdo9SHmqO7xj?=
 =?us-ascii?Q?ATR5uy9Md61h09bxxvwfkuIT1ueeluOFXvtu+Q565DDGgueEPq4HCgGLDQWi?=
 =?us-ascii?Q?XAJ+Lf2KW5grTjASAASNakNh48OCrrOXt/cK7Mbcbe7l0upa3jwapRmrTgKt?=
 =?us-ascii?Q?bfwqa7mxyPrt7oezfEVs6/xkdi1bBq7YtYysGZefsBfubuWGtREsVFPiNMi1?=
 =?us-ascii?Q?fumFKojh3XiVg4AyieEZmQMVu74T9S/j/kayoB00AjYCaeo/2aG/GMHwew0O?=
 =?us-ascii?Q?PaL/VHwQJDiuHeM5GMG+20zpp+SWBHxVQk5LGY3b4vSxYiQxT5W1jAWf1mTf?=
 =?us-ascii?Q?EfC3DKQDIICFIyxgkJAHXhA12kXyLCONLvTPeHcHqY+2fFD2yawPlOl67quW?=
 =?us-ascii?Q?afzU6GmiqVTufUVwgwzhRmkEyuZ+okkKJhnSh45nT7HjR+Cs1rLPSK6setr7?=
 =?us-ascii?Q?0BfZ2EFnntu/c92JTysfpxSmLCRafQUtaiC1uxBuEvq25CdwfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BL6Sg8DgqaXVgjbZKBryaLZ3R10xFXqca8ls4Y2ddD4VoosuTnHRj0OmVkmH?=
 =?us-ascii?Q?q2zE45WV0643Us8rTvNaX3vL8r37/56PR1FaKMOppKtrBON64eKrHcQaLkU6?=
 =?us-ascii?Q?ezMTmk9+uvUk8gasMltwHKOIgyCQI5VJi3sIvTlEJGSh18Z5jSWPSdt9Mwtd?=
 =?us-ascii?Q?m0Vq8ZloAZPGi0XJGApE+cDnaRF52OuRd7KOtelbxRKnBE4LST/mMb3oVHg8?=
 =?us-ascii?Q?EKU0r8vT6UKGWi2Sr9xRZe4OQqzitgF+u2gKkK6tDKt94JfxcQa0V2iAsXEU?=
 =?us-ascii?Q?ilvR2TjnEXRKdcUVsaQRQ45gmjZev1tUFtXnbRpqATVfdopfJFXxxveG9WR8?=
 =?us-ascii?Q?MrdcgayD+pv/TEGGjPWWpfrQoEn+VSfsY0P+9qaFwrKkhaw/ANy8hoGas1ci?=
 =?us-ascii?Q?07E3MRMehBhcXEfcyeWh0zTLXCC/gM4agP6kpCc9X1mdINxN00arjK0ppiD6?=
 =?us-ascii?Q?nG2UUx8/kjmRzErzD1uFTo2xeE/mQCBdoh4IeR0IQ9VA1YAma+qjg8X/2mQw?=
 =?us-ascii?Q?nnByOZk+psIL+3wS+PsRbHDJWHK4H8CmbBjt5DEVFZkIGLMpXAq2LvhY1fBq?=
 =?us-ascii?Q?qVt9+01pxw3N2jVWLsGjgb7bNFFGxorhofkI6eQmlQHVSp4537UYeCnVd+Pm?=
 =?us-ascii?Q?z5OB70eM2E0YSKgicGv1wySz0aStw3d7BjoR4gm6ozfUjbd94zSHJhKRqsSJ?=
 =?us-ascii?Q?1WGbFb3l8BOZJ8wKzj6bOJhs9Gr/0ijPRfBEKAl4GSs9cluSXUeNAyNGY9Gg?=
 =?us-ascii?Q?+BbBXr9+OXbsVrrDmC32oywfXWVMD5ove7iM02uBn6Eed3biUUrbOF0q1g9x?=
 =?us-ascii?Q?5zrWWvn5Q0nM6vpJnPpwkCFikKt/rPtreeYvwKDKBKuNF/Wug4hrT9rckhzT?=
 =?us-ascii?Q?K5lAwLmD1Km2u1B5kSONvHNS+3i6MoF/bYrj7SKSMc9I9J9s8Un9ctb+5Gth?=
 =?us-ascii?Q?xVk3UiZlV81jmfdkDmzTXw49qKkCybgOL5jf0AxuinDLgmRnfe7joWcxfedw?=
 =?us-ascii?Q?LvDGxTTYsSY025cUugnP3HRi6rnVWraub8CTglJDATJ4rMl79jV2G8eJqvOP?=
 =?us-ascii?Q?F92XRzvj9qAnLqEhIqC+ta1wm3luzBqrRq9jmiVqlHLaJIC/evs8v5/aDkns?=
 =?us-ascii?Q?69O5Tir+srJedrScxfFXrrDswiwt94ra4KCV1eppxV345vplMZ+N9kEAy+kD?=
 =?us-ascii?Q?fGvDFzjdl74uKulzBRqOSdpxQVf+/sA3LSZEdzdBIc/fR5fyhHWxoeFUS9ZZ?=
 =?us-ascii?Q?LuTci5XDcH0q/JHDMu2IgdEofaV6hMU1L9SbTkePJbKqh8s9TtPKF5MzJsWa?=
 =?us-ascii?Q?J0ha3kBItxXkDlID4AFpHWoj6gB+1H0mW5Oa6um+LAJB6xZV1HH8xTEiy3yD?=
 =?us-ascii?Q?ojC/u7hJHaLRL/+awCUmuK4SZ9+Jc5vvBJJQUWuvj5kiDJgsIiiPYsNg2Pk9?=
 =?us-ascii?Q?WTRaiUkZXKEQFkPeOetZfovnrmjYuFkY2mI6y9CFgVxhbyrnPKqTEvHdrkg0?=
 =?us-ascii?Q?rvmRzX5KzpJOz2235rxW2fbNRLQph3tDQk5UWdxvIDBwzlV3HS+GWl6cTuoC?=
 =?us-ascii?Q?5PyZ5dBTFai85K4vdCjDepInRfpEhRa6hk/+Dh9S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4394a42-491b-4ad5-c89d-08dce11a68d8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:37:52.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7GNyE2pJ7ZiTI5OvQbHBKI2wOyvBidMH1JB4ywTxCrYo+mJ4B5xS7Qn6uImt+v1YXN1pP02y4rIkH91z9xRgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

Files cfp.c supports functions related to channel/frequency/power.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
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


