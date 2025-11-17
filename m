Return-Path: <linux-wireless+bounces-29034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E737C63B5F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D99654EAA82
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C7732E153;
	Mon, 17 Nov 2025 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WRkSJikr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA11432E132;
	Mon, 17 Nov 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377347; cv=fail; b=kbKC/lWHSGbgOIjBwzuSwVgANNZZ9XxY+qVdDTVGtFXCdDclqTSlfloHLEWbeptDl63NyFtiYiQAI3kauZfQHco1aRPd4JNjIJVG/wjqQ4TxEzslMVoeMHvG4Rel4avZ4SAo+SiF1CrBqJ2HFZiR62K5ai0Vj+YqdHfkHuY/rQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377347; c=relaxed/simple;
	bh=DtAuTVoGwUB0HYk4BOf/fGNpAMGjlRGpLTENqT8el34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mSwZIYSO6j1GZD7pIdd/1nr+kWrK9UPAurPXUWD3Q1LEXF3O54kQl6N/3EYDTXQqzOp3LbnAH/xDGLysZ10RFezvwIocaoB6xCac0TJqWhMOQehcwGkm9s7jb87wDsSwZVuv+84/wRDYvvxTit859nSplOLXfPCKpiQsjiIh1iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WRkSJikr; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qdp9OGcyCBP0xq1OZ7YvufgUvlNmbvzpeU9qPN5QrB1JfrXy50P3+oxtlyY7DZswdoo4Zzuz8i3LKGZmih6m5AAxdb9CfEjN9JkoBF+y9rea4UfMMeQs7B4+14zRnfJ3QJ/yL5peE2loCfonZXoxUEXLDd9frnlyQ7jLxoLi/Flv/O/WyOg0fBL98uzvXs+ptLvWrTnDKpAzrv2mM4TpcA8sTpvfPEbWkEgXUlqxdqDTW1tOjtwbyNlY6jesV5iQfx9BrDHojegDcMN99A2qozP54OyHnGnAw+vT8FmgPLZwgvCq1g8sqLnjHl0ORSkKqP0KvoVHVPvCLc/ll1PbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTFS6CFhD2q9npMRlYokC9sxA/ENLd+kLMLymYu6TXU=;
 b=AJG5dqmLdvAbFi+CUEn99OATGIjjycJr8J8K1ivY4lfIhQGWLF+qq0Fsg4Sox+v4k7/uMEB9+5kI4IwffKlicWCh0k4X45VdTampX8MfYlFtbHFvusSuNeize89IThDeE5rapmP7TxnmhWAizNoJcPGQY4cC93yWv4QQDAfwaIp7WRZhUm+KeCy7/DEoPJNb3fJQQtIg92JBrBsIPLFbk1/qx/DtKd4tgH0k/ZAzi/wqTiI3odmMjGUYAIx0qByHxqNoo5r4JaMjqn8nMCQGM7pM/fkDFySWmcc6N+GkMzamy1nieMyMfp2y849ff4yXo1E5lxFBuzLhqIQ1E19VTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTFS6CFhD2q9npMRlYokC9sxA/ENLd+kLMLymYu6TXU=;
 b=WRkSJikr5LSNIFVECUO3UtHJqDO9QuQyekv2Lzp70W9O2/OT6ZKl0Fga3RIxGSZBA+A4Ohf9T0ahp8VzwOGwgKQ1fv/s7tyrrkKxVYiHr5NfvKapsbFJCuiIcsZO8aTTZieEUFoms5JSjCPsdd8iuEprh3gczhOOd5nS8xQfw2VnS8SqDxTKxxuditm9ASkWEG235CtGa6IGVlXVJ376elM60Rb9iigfslaLD4DBTADA9eYYRCeViaJiChBK+tf+wRs8jG5ssV4Qc3CFbhUA7FLwtaauQwqoiihoaYCloC/QjTsSL2/2qHVQ8SUTPFFbCw+vSGT6O9GIrA5+fYj36w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS1PR04MB9309.eurprd04.prod.outlook.com (2603:10a6:20b:4df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:02:16 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:02:16 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 08/22] wifi: nxpwifi: add channel/frequency/power (cfp) support
Date: Mon, 17 Nov 2025 19:00:32 +0800
Message-Id: <20251117110046.2810811-9-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS1PR04MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: d98de299-6610-45c4-ab5b-08de25c8c3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s5eBjMGl5RDXKlSArvSWNNANDEzn9cjBdRsXwVzN+ozq5m9hbPQbkFzMQXdj?=
 =?us-ascii?Q?iKnFDfm2AAbUXPXILoF8C/Wf9PUfbBKQ58WTmn9gvJQSkco52CTMPqFtwdOH?=
 =?us-ascii?Q?CPwMrcDGlyMM5rDZzff3IG5QXZeENY3rfJMoy2+xE8YqVyGli9OWA+tvevma?=
 =?us-ascii?Q?DDdcM+755bXgd4BeavKTEZ1mElN/Xwb/vhgP/hF4zxqtOkRGmbirYJ9dNmIW?=
 =?us-ascii?Q?Q1ic7/sKltq+4lS4+/RA3K0WbIp16ms3G9Y7V0MDLWAXq62u25ga+dVIS3tT?=
 =?us-ascii?Q?LPwuQcJ9/QMxWPM8U/ORYZ4VBXfLvkgIJq/kVCh60Um0v+9/U1hFAyBxcuk4?=
 =?us-ascii?Q?LwdILuPyZTWrHBu49sviXDedITSFKhqTv/huhfn3CCCyME2bYNn3mNKSZD/+?=
 =?us-ascii?Q?rLyQo9mX/2nANEHzY0W02UfLjvX+iU11wXLXti0lMbe/7EahqqzDSu6VCvfy?=
 =?us-ascii?Q?oDlnKBNgbN3Gmxgg1gSoxtmTDTLt3/t9hrrL6dd6L7qCyO0bR/GMt0KC43+k?=
 =?us-ascii?Q?kIfvkwMdsb8Eb43i/6va8xcOfLACXrrITvDnaJ5+M0GDvzxoKTyNUxFCSgU8?=
 =?us-ascii?Q?5oRawOyel6kOZR1QIOciP5kGNCkzEqw7/Ea67MQoSepcy4MICGBIO6lriH1z?=
 =?us-ascii?Q?kbJ5rpkaJ4xRIMimu5aiL0pEzUsz/xOnProqt2PrTrnnLyq5L4lTX+3qa2yN?=
 =?us-ascii?Q?X8hPTtnVe26MMx5DBdhcI5gOune7XtMmwudW4wY0B569YHCyl3pP4NxmPVEq?=
 =?us-ascii?Q?+8IgtJalNb+MQzgxkt29hNRhhBGKmlb4epJ57ONBYXnzBOyBzaWD0xPfsohk?=
 =?us-ascii?Q?OrcznIgobknZCWtYecOW5A5uetPG6HOK0xQEDwENSiOv+05j33WSMjGuosk1?=
 =?us-ascii?Q?ETfOwyYrVE/YT4WYshhym4f/IoA0N+ZxLGt9zv+tdizvds/31ROYQhQGPjja?=
 =?us-ascii?Q?+dH/ftfCHwgoKjtUhpoT3aoQnqat2RBxkvwhZxXbnMJ/n2k0wljfkHghurHd?=
 =?us-ascii?Q?lXwOrRmic4evZ6J53+rfvhSbr40+rr50bl+Z6VdBeAtMWZ8rW3n8AN9Lak3W?=
 =?us-ascii?Q?f679yjxyiKk45eT7JMKjofXIfXwS3mvAc/feGXJAyhg5YmOwFRcsNXD2FB+/?=
 =?us-ascii?Q?V9lcThjpp05ErD4TTE0PPa0wBJY2DMxhLfaJvLFioOa2c5cE3rKPo0byBuVQ?=
 =?us-ascii?Q?x1e+e52LXUxGI/+50tVH51Zh4kT6B7/2s+seAuiaKlGW1maOR+m9EjAtzP1z?=
 =?us-ascii?Q?Q5yY2DR5aRrARd410822kwzYtApmT3heHcjDnrxXtaajaBm6rTsCMgIED8Xx?=
 =?us-ascii?Q?o8jcHaaPq+6yCAmdNB94qxswNgUrmSiPyAn7so+W3GJESw1zbiITPfiirwLH?=
 =?us-ascii?Q?s78EaDjmzXB83kYiRAzaxJNOKjkZ2cDtNUSxdym2eNMx+SCRzjrKm68Ml7b6?=
 =?us-ascii?Q?MTUEKuViLVkWgJ3nWbLCheRaPfecVSWGLUw9A4y2IDxKCFtR6MRKmIhsFBbw?=
 =?us-ascii?Q?96WU7fKCI3RsjUXUilusZLCVbvCw9v4fr26I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wF+Te3lZMdVPG3TP1ugg0HRUjc4R/MM6Pv4hqRb9IP/fVPMUvK/CKWaSMvZ9?=
 =?us-ascii?Q?ktD/Cy4WXJ7AyV9gS0wOp2LJiOCijfo3IGSP6sD8Tw2LrSw3M2f7mPE04L6y?=
 =?us-ascii?Q?zCFyQqjwFYrmBkfnOpvOS39cyNYM72/jaRR6tKPc5ZNp+z7KwjwF6EHKldhd?=
 =?us-ascii?Q?Wb3PXvo8YvDEz2m4yXWe11yaZB/aP6+j4nC1LZNEX70Kvfk3Y1D7joDOXHfM?=
 =?us-ascii?Q?8VgJDIe892uHTaW6G5Sd04VrEnQioJbk4cg9fOIikx7tE3i+kJWjAxL7tG29?=
 =?us-ascii?Q?GIMVTC93Mv8eeLkJfPrJVBFrGnFcp+X4BdbvJv86esTfsSaggMU2swePw+QA?=
 =?us-ascii?Q?1KbVUPx/7jAw7M2lN0FDn3X5gTYoP0xq/bU0aYY9D6EetAHQNtrrXYc3IOhf?=
 =?us-ascii?Q?9eITlSLg47vz9PKMjJuTjeFgRGJYt/ICCCLPt+Wc9m/47kXlPkZ949QwE635?=
 =?us-ascii?Q?BXOAIAiMovANblV2NnazyB4C4j3xBHdbr3PCudwbGNx1shAr3jJwVEuq1wPO?=
 =?us-ascii?Q?RCARUTQceWEKjT0Hn6UAc5SdsQrqPmyvRLmoAeWJP8sMzgDMGMtdTQ5S20N1?=
 =?us-ascii?Q?nfsFm9igN2J5pfqbKap30KKLXq8t168ajfwqSANwKm/Rus5fYV97pFttUtfW?=
 =?us-ascii?Q?/AG8Az/4CMVj+3iEkgrOHXV1JK054WCi24Dxdb+S6mqlberP10nEb/P137mm?=
 =?us-ascii?Q?MJ2sHedSH/wOIFXm9IKXf4n4JyU7a+hygb0rbgziELg1aSIloFwgN5MoqeZA?=
 =?us-ascii?Q?aSJ1NlFpxW4R3HguHTmTHZcacJmRBd+F8J2Ky49Krz9I3npy4dHpTKOe3wrX?=
 =?us-ascii?Q?49o99gcrKztV2te/8kN2MuhgVjwEl4g9fgulNUMx6YtX2zEFB9z3PWvigGe9?=
 =?us-ascii?Q?ssQ/bbgyKvrNLZ2UD85MyNLZG+pk1SQAwCloHJzioKz5eqTiw0Y3p69f9ETY?=
 =?us-ascii?Q?yHqVFP53AARPaPceF+ZB/X4eWwtAsIpmZCh326gbIuC2WhkH+lW+oPBtS80o?=
 =?us-ascii?Q?81I7OfQ12z2BS3fqinCUte9S6i568L3r7XKaGJbt/KUHkoz89R/aHpvBEZ+T?=
 =?us-ascii?Q?kiregfBpD4ID20bn8Tws1M5cIzCYqDvcnqIoTNGtY7en3JVZ8Xi0KyC5Cb5k?=
 =?us-ascii?Q?l5uNpsdJoH31yINBsX4q70Nprjug4UEdI2FAJYTaOmB26jz7tC28wFCKr7Wg?=
 =?us-ascii?Q?YjR3Cyda406WRqVaZ+i0e6/bTSguJUNk8ppbs/D2y5wltzSNfniT1MaFZFII?=
 =?us-ascii?Q?PEjoHmhdgcISIBAIV1JCN8t8dsKcTZF7e0QRzOdPIxkZPcJ1P8kdxTO3WKSD?=
 =?us-ascii?Q?7zk0RcERoh+KsAsfCclQ57j5ZDhRIPcm9henbPSmXHy4hunp6YdXwivWJbMK?=
 =?us-ascii?Q?zXThIfC50Mq/3G4Ahfa50T3c5jqo2sbuOmfikxttRLbxcK/WE/evH/S+R95S?=
 =?us-ascii?Q?LVE7Mc4C3sh5yWsVlZOCNBjv+WlSLBFGahXTgo2EI5LsSUE6aTGIaYPA5zok?=
 =?us-ascii?Q?FIazRbIpjrzN3X6/faDS+2JRvJ0Fz9ABz6XkrxB87SM7IE9hcOJQEg6MnLFp?=
 =?us-ascii?Q?uPCaRhN2gLhJY/urLVToaClrxzWAQz1T57KB7HoL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98de299-6610-45c4-ab5b-08de25c8c3d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:02:14.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECah+thjWWYiUSzHKzfVrIR1RH2m2R6Z7pi8JscT3PG9bXrKfPMHQT6wxTpn/8kFr6jeZMhUPGfWa8vCF7IikA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9309

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


