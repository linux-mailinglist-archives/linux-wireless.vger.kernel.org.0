Return-Path: <linux-wireless+bounces-28586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 056FBC3539B
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF9054F9FA5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155530C37C;
	Wed,  5 Nov 2025 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OUoGl382"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A0309EE8;
	Wed,  5 Nov 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339773; cv=fail; b=RbKdgYQpXp9eRoIgC1hmX6Lz6V0D+jIpZgj2lNeoCTKB8nZbmcpi6ppOwv83wzqxvSE2AbQYXbnOzpFGAVGaCQZkd0ZYso1sz71JIk0DDtu91CJIKXUUvBpLydbv5yXLr50bts3HxkP/1lTbW2uIS4twab45MNBFSk3oPTTxQ04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339773; c=relaxed/simple;
	bh=DtAuTVoGwUB0HYk4BOf/fGNpAMGjlRGpLTENqT8el34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c6a17SiQgtfTXVcBcce3l5UXG//KrPuYoAk/+3qErtsHWRevrIHwgz5343Lul0C1EWnzm0BaVV6UUikgau4K8y0tVdudA5zpYNUd6gn5Ha0ZDXVsBHWvjCFpKHwAX3+k39lphz+4oVw3lN0dvdTk7RUlp7j1tKfIbu4wGS+fmXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OUoGl382; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2kywb9xfMGwj+05M6w8I8VQ+oQO6cQnUeY7bxrryfRi0cEs4tTRGRNqyGmitU1+9Tm6ZJUsoNQOW0/upTJEt6UJJEGKaUyC1VaosPVJEnaGmKdnFVt/38TlOGxKL8L9O0J+nr2NZ00Xa2HLT7AAdXG6nSQqOZnj544UHqFDUSL7kp0+jwwAA0/iYvG0zTeMlcj3jZ8U9zxu3+0C/nlB2FzWfMyDAf8W6YbmiXlqXVoTVuTY4J9rEXXG3kg4RrePDZq70YI5z5oOCMtx03xZ/kR2ng7j/Xq0f7+EqYAVYhG2PSOlHqLv0xUO9RHnKygocwfB8F/mPRhEYhiQoUxizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTFS6CFhD2q9npMRlYokC9sxA/ENLd+kLMLymYu6TXU=;
 b=aj06D0WTaiPzfVRx9DC+aFPveI5R9o+Q0W33L0Pf7ubgs58Zg8YakdNRiODz912vBkthsaDs9xHlPgO4KRzao26eXXCLzdw+q39kzCb4kvjSqClbjJgGGSwASm4W0w3PK7LMtlKzqyCMyIBvImGBCg4wJ+j0jXClrJyN4bZPTHZ2KR8F9RQHyQknjRF4+qh3LhVd9WmTlh1MoukhiTVzs9yc68eIugO77j6LvAFa7vv+lr1vUUW57SMa+RjzhpF0+OQ6SdqTgCDp7V3Qzor/J+MpPqmMGify0YCm+bnz1Dr5DLBkJ9u112rA6t+3nJ8/PhgWlFilf7fQLnzRcqSHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTFS6CFhD2q9npMRlYokC9sxA/ENLd+kLMLymYu6TXU=;
 b=OUoGl382L/T+Bv4QiqD7ZaCpt5yeoBlOkYNPVlUFkTf8iDMSeItw2F5y9hcjbI1i+q5LTwRQ9rBtOIE4dKVomeUoXVHG0uLIJc/taj7KtaXR5Cvvbm3fC18esV3+PGvXBqxjenVjF3AfFbUwGBGJIr86tMPa3WCAgq3rq8gjv4ZrogrOhaPMF3OAoLblUmmDvKf+jwzA30WZV0NGifSJnLoM10LN9ApgUQgmj659YUJWvxFozJcFraJ/U+GNjktzLdk4FqhFpouRDPcqxtaw36VLoQ+/HUrB4mX8GurayDpu3gpk62de5i5ST0W7Y3ZnmGhu9JBFxYgJDcNSTmBZ2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DBAPR04MB7429.eurprd04.prod.outlook.com (2603:10a6:10:1a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 5 Nov
 2025 10:49:21 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:49:21 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 08/22] wifi: nxpwifi: add channel/frequency/power (cfp) support
Date: Wed,  5 Nov 2025 18:47:30 +0800
Message-Id: <20251105104744.2401992-9-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
References: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|DBAPR04MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a4ce79-b563-4954-466c-08de1c58f9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4lzDSrEdHrLL+QXFVptwFPGkCDCSPZ1zuqkhsMr8/TQ4mVyIkLOceo1tYhjI?=
 =?us-ascii?Q?s45tF5fYa1zuUgAYLuItF9lH0snfUqYraMrlM08zDZjC9cXvt9tcPIrWqmxT?=
 =?us-ascii?Q?E9UGwVG8IIfA+0uM0k21psQRZtYS44kuJjgR9ljxu0ql/vX/gx0CyLGhXA79?=
 =?us-ascii?Q?awYRgrS5Kvcr80ldc/WG7b53bAbvwOINE6kuvnfsJ1aQP7xAnwgbJY9Ig/WA?=
 =?us-ascii?Q?98mHnHEhiSskFshcYbAxLWVsVU6Jag9MnhZ/5lCwM8hlVgiY2bFcvs7tnM6M?=
 =?us-ascii?Q?9KfE6JvJwk7Ml8DDEUAJSSFXhrZLOIUSqFN1DnnHz2E8zt3ZvoZF6p+UOu5i?=
 =?us-ascii?Q?Lrlazp8vTdb0rXfNAUgG567/OY3HSVISvc2HppayCFoiZtlrTlWplmGdM2Sd?=
 =?us-ascii?Q?TKJ/VL1kIwsfQmGyE6LQyLIuQcw6DgmRt0X+9EOW48iT0lZ21RwNvrTYnIex?=
 =?us-ascii?Q?CSAd5+j8Dtjo8WgNu41+meRN3b8wCLBgBWqv6dSgTwNnSS6TPxf0egp78USz?=
 =?us-ascii?Q?uTpD+J8x+88bl8+KR9tmIEv2ti4zGAbfwixTM9xSa1K5sq0/dty/8v08aNrq?=
 =?us-ascii?Q?oEvSfUOmdPEZ8H0uFsbmvHMwKx9WyMLMpQ4N/HnzV4hemujqPI2uIv5XL3/l?=
 =?us-ascii?Q?pfC0TauyhNzaP62V/faMXIKBJs3kcBfghi+u0b1sSX/x3aMrfcLWTUmMkDVG?=
 =?us-ascii?Q?qF0n64ABHSVOYxNA+ecpNplfMFi0HyEEFdkNiRf31CPZ6/NNMxzlUQFPJ0G/?=
 =?us-ascii?Q?tdlFIAEHdyofwX4P08ZdmPK4oGyxsBmAlAjYlfp5+ae9eqZevf38XFhAqNbf?=
 =?us-ascii?Q?wBzuxRs7yfu25u49hd6kXIz/z3gR+/CjiKHSm/9yHDFr5oDlzTj7euRfiwiC?=
 =?us-ascii?Q?kBjGR/d1zOC60B+16zoz6WTzwRaaoDV0tWx/DetIySje7Q2wlK/YTBJtiS2S?=
 =?us-ascii?Q?vbprb8s6aWELqJnSka5GBQucWUvECiDgcFYeEoAzohTonegLx25OFKWyOZgU?=
 =?us-ascii?Q?pQjmAmsY1KPX3edI6rsqXAx3HE4ab1MizKj38+lgHCoXeB1IePXUkq+1I61i?=
 =?us-ascii?Q?/xYqf9holK+RG/XEVaG79KYXGv3ZLsjL51B8NkEWz0S/q0qhyeotjGfyuxKu?=
 =?us-ascii?Q?d4Hlm5gSf8dmGprPOERM8zrhM7vYMNx05EfzA8kBFU/mDnJK34UmRPDYY84y?=
 =?us-ascii?Q?zlfLlAT3/8AwhYleUEoXcfpzxQLrh0SDsHJl6xudqVDIibtD3b/NI/jFwgOa?=
 =?us-ascii?Q?1FRP7/p09eb4SZt/GDcHVkqsWIOGmvfGfVgN4+jgfbGwXRPesYNBdd4tdu77?=
 =?us-ascii?Q?Get6/iLjc65i3vciFpOvTK0j4Ptfe/0CHs3NfoXLU8co6z1p9L438ajo4q2B?=
 =?us-ascii?Q?vlQicLAWfqe0fSCC2uOWHyT5/UbvOdv1RxwOuxEhSMlb6NtIsOxhj5YLmhy2?=
 =?us-ascii?Q?fOwHkjb/EEzUJdJM/UfnmLTFsraG3lL3045pYXb1Gn0lSgUoKGaBbf26CnmY?=
 =?us-ascii?Q?I2jAZEEBr4ES+JArMYXcTmZnvASRiuyPIDAv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vY7K/ARALz4yQNmCwJXvctjXy1IIeV4CMyRzWZD3uF5kcvQ/dzocA6qnzZv8?=
 =?us-ascii?Q?TOJ1koAcNMNsXtXBiMtSkvfIJpIHAkc/hdSxJ23xg7Cx6xSuAJoZ0y9WJxky?=
 =?us-ascii?Q?3OanEtrI1mBWRBLAozmv4JqEGIkd3mAQZZjyqPd4t/2W8sQS28MozGTjmdhK?=
 =?us-ascii?Q?pPbNFfh5TBGJ14rQxdUu1HRqXXBNeba7GzHsDWyeEkAN3c1smHntQiRKCGt6?=
 =?us-ascii?Q?ix9sQqonRZez1AZYxfB/28jID4ZMrtDp+OIp/R7KHN6pWvANs0lEpcGqxvTS?=
 =?us-ascii?Q?61QgC2fK/+l+EohVMbc8Xesfo5ZFVY7fguxSAxofspSlfSGyqqHeP1q7XkUj?=
 =?us-ascii?Q?SC+XyFVIkMDGnnE2Jolx/991h6QS5wd32s8i76/YE8Yz6KXCvbG0sCV638dF?=
 =?us-ascii?Q?BrtC23t/1yBD4hBg9RzNX6UT54NX4o3+f/8KAqp7/WPtsRGCHGKZGC/vUiY9?=
 =?us-ascii?Q?8ffGHKFjjh35wlXWr/Icmav5m6hXME2/CUpbwB2mxE6xCOVzlAwZ+YTO7dZN?=
 =?us-ascii?Q?Zh5/PFWJcqHGkr3c6jEzwNlrwmUvES2rs47Bl8Mu6/4H89SgwTuAHzSdgj9P?=
 =?us-ascii?Q?Y1yBtq5AkpnzIbs6e1zJZym6pgqqd6AhMxVrML9GT+0LibYv/lLG0Ci9qHX4?=
 =?us-ascii?Q?AYGaTD5eqWYQw0bOEgZHILHZ9mVDskmjkLute7Pb/Of39k1W5o/mvHzaErEP?=
 =?us-ascii?Q?j4BuYXGuvhU5RCz3/04Zy0mSKe1s9pbmpJzQSz6tL8qc00shPuRlbS/SjGQ8?=
 =?us-ascii?Q?LZUj5RErDUSxwhe7gx/agx8jiZPFzdRWnFOyCS7FxavgnkkNgeE8UEfyfEqV?=
 =?us-ascii?Q?f9gIpXG1Y4E8MIYGNfOvBMVS6ErrhaxR4Pc3wJo8S6QdbmGwr2565CGVlr+U?=
 =?us-ascii?Q?PFLVnmcxIcKeSgQWAmHo/5Vto7XgYbcYi6ByD0PHiEHkDqFq8w/AMG+jpELv?=
 =?us-ascii?Q?k8b4sbCH3di1R0B8VEceX1YLjOVLVvStAJ2EVRAxQd3Ok0yARcW5EW1TzZVo?=
 =?us-ascii?Q?MzxOqMHLveIpyIJYKTUz2MAMMbB5viMP9Dv9cXeQVgc2icl72m6VXXO4bte5?=
 =?us-ascii?Q?XSVsMtxu1bfFgKDZ/BbLHAAFLI6Id9nUrOGB15RH+9OlRr+3ou7KZyp/JGIg?=
 =?us-ascii?Q?IFQIeYEWCTfZIMIEgvABsw4hu7Rh2P/3dT03oCbJWi+GR9Og3EYMmeu4CFE+?=
 =?us-ascii?Q?+ClkrICw2+VEr01Ro4fsonL1n1gSiOt52i3I2YbWXi3Cs7ZIoqyhjwl4TLuZ?=
 =?us-ascii?Q?nOoU5cz13VvNnmcbUx0Supq/R5gyoyrfBm1+BwiHKEEnyYG/qmo6zefyvDjE?=
 =?us-ascii?Q?oZ/EZ7Lv94Lq4JA1kjHzEdAQvZqLKfnjkoq8JF4w2/c5Jt75oH6IC5VdMwOB?=
 =?us-ascii?Q?5b6gdxm9J3lDGFAjNZUiTl9TUmepMvo5v+P5FbUoY5R0ecF4kHkvnCCJRWGB?=
 =?us-ascii?Q?O/hH13e0BS8MJAclDLo9aFH72Gq5Es0ffjRYBtNy+ANzY1v9EAADGepr2/yl?=
 =?us-ascii?Q?BNs0gqHPiVCg11/1VwA2Ht1QOCKLJ5bAF3987JY2SHOI1at/bQ2JLnVbGuSq?=
 =?us-ascii?Q?O/+Hna8dduNtNLvvJ2LNvjAdsPcXc/ENX8+FcDLn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a4ce79-b563-4954-466c-08de1c58f9dd
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:49:21.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97Tf8aRH2OC8sYbYPzamf3wU1Y2LxA3c5AqmNV3vPO1SlGUvijd+apo/6vdm4Rz/mFis5ABX5+NC5nUU8qmwww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7429

Introduce cfp.c to provide channel, frequency, and power-related utilities
for the nxpwifi driver.

- Defines supported data rates for 802.11a/b/g/n/ac
- Implements rate-to-index and index-to-rate mapping for HT/VHT formats
- Provides region code to country mapping for 802.11d support
- Adds helpers for:
  - Determining active/supported data rates
  - Mapping channel/frequency/power (CFP) triplets
  - Adjusting RX data rate index
  - Extracting rates from cfg80211 scan requests

This module serves as a foundational component for rate control,
regulatory compliance, and scan/join operations.

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


