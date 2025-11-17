Return-Path: <linux-wireless+bounces-29047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E100C63BB1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B1B34E2836
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D368332EBB;
	Mon, 17 Nov 2025 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n3YZo8Bv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B7331A7F;
	Mon, 17 Nov 2025 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377392; cv=fail; b=tVpOc1WluW4KJSp57YOgTGIbeFB4N31VWPEjkwh/Y4TFz0h182DcK85q6UJfOvz1g7+voli+jZRxqKwRp6IXkw12QS9qStkPw0cKF52nTGRB2KgaIFTOIkIcl7WZL3BE/Rl/o86zSu827LRI5bFb/1HRTye4UjN8NV7Ki8LJIu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377392; c=relaxed/simple;
	bh=vywahqrIOaXu3KGMwWbdCGd7g/yGmx+xFy/BgHJFVU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g9D/uBQWJMLaOb666nk/kVw2VSQITBAvjrQLp4DNf7Ul4Pn0oHsh3TSfkTdNLkwHlKrdWlVExoA/NCCsYCfpV/K1CHGEQPfbkGZgAD+ys2uqBUByUc9p+iShfLlvYzjBaR0cVRsjzwHez50jIPBrQUNwSbeltFcc999FxlbmRLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n3YZo8Bv; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUPDeEo1Z4smKvQ9VN7QFEl3rXWMxdHCr227bYRzkZyP4m0PveCRGq/BkBiGHd0x7PC2MMtU6FeZiAprccN3/Zf5RvhkeMquuh8wQ8hJ6D7lZLnEsvLWf9kWKWn7iEDO4FOIS0CwsubvArxHHBEBA/uuD4+LnjjYqOJRSRx1oFekUiL5Q7RphSQvX9DVAcm9yHqpPXxwZx5kMuEwIYHHHtU8GBDnd9gCu6f5TBnuZzqTsaw0qn4tGM2fdzfZCQ2bF4YVChPQE/4qVGImxq4rQzLd2sQcy+TK7WP7Z3/sGzs8uSvWy0v0frtb53aQkkx8vP/Gf/K8rMhUtd0KKqPVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBlzoIJ/HOPfnWy9nNeVBRaej59ULtZ8Ef/Gll344Ok=;
 b=UPCfbHrpqziHCM96/hyVMXoxdVPz+9PH8MDymklaZMA+03xYXl/qCepYoLQSHtHuSObXNxM+3GVFj4P9pwq97Fx4IlHZ5dgK/pTeB2hCu3tzGcSdVzZPUyKGWzLOdO/cfJEwKT2IT9mdH1ST+1Uxs1SNcMuqIlQqsjwlXHwnx8VG5Klu6/naWFLz+4MK++ilaBzFUB0ECLDPYuEy6Kx3//XL+J17M0SshxTkubFHXejql1Pmw5pNdXATGT/vg5FFqVfsWMGWenETUzL7WyEYeXp6Q6XDb7zD+UeWuxwYMKNUSbXBblSG530Ye6RV8TRratCh9rubHxE7CrboK8r5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBlzoIJ/HOPfnWy9nNeVBRaej59ULtZ8Ef/Gll344Ok=;
 b=n3YZo8BvwAw7eBwRMaR+1kiMcpMhwZ8+x5w4EqXZO+k2N4sf/aNmXoaM7l4mrvTxXYvJJ2JyUMcnV1eH5ylLNrg0QpSSz13zMRjOZGzS9ImBZZJEGnXe9Jh4Wcm8HGzEpuhEj3PiybYfjginuFjFBpVLw9Qv0i/7TCEBL59tm5HcuKIeoeaETBGmeq+HqeUhdpIRmQru+MyC1lTlGJSImenPqz2vtXByAWaVXfwyL38idjOexpMpmZ0/k7MGizQlNRfpw+J8OwP/IgX39t0plpTSGEI3pNVlg7g5uQ0ticf5JcjilELzCJroed7vrZ88BNtmPohlkSVswyj3IdmE8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS1PR04MB9309.eurprd04.prod.outlook.com (2603:10a6:20b:4df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:02:48 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:02:47 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 18/22] wifi: nxpwifi: add core driver implementation
Date: Mon, 17 Nov 2025 19:00:42 +0800
Message-Id: <20251117110046.2810811-19-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 946ce007-efa2-4f32-5e8b-08de25c8d771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rNgo1vslGnr4Fjt3sATFDewoybAhwu9GjIDy1SwQh1YQOJFbKSzvW4Iyhl/j?=
 =?us-ascii?Q?Nqsj9hAnOnbeOI2JfNJebiiM+USMgsP0qpuGW71s6DOZ3N3zzHZUePw2mDCd?=
 =?us-ascii?Q?1BhQQ/pzndyiygcZoGjn1VYILdaKutkPtBqrqWWrKQGXCsdQT+SK7u9peT6P?=
 =?us-ascii?Q?O8YjIkPwNJSCXCu0yZCNIhQHDXXfgL16cIcR8YdpPGVFN2ujLcv/LdLtD1m5?=
 =?us-ascii?Q?J/rgjWL05N0KAB+AsGUtJX1zGJ+7ZR3aHHNgC9CpHKVZRGCU24WjmBy5UMCV?=
 =?us-ascii?Q?kuX6YongtyJNrGC1rwh9ud9b32QqA8QQKELO6dzWDTLVBBXiCNfpchi7B0J6?=
 =?us-ascii?Q?3cwvOVTsGotCmcmEoTaXO8HGepBew5noTWAT7ZtKSrn0gwPbUadaKN5kv8FE?=
 =?us-ascii?Q?TwNAi1TvSG13B8DwJr3VFx1ls4NRyl3P3Doc+39PJBIUH6l16njzIaKrGtmN?=
 =?us-ascii?Q?fpHuyz1xqTnXj9wWKp/gxdctdG6s5z3WLRZdewVcmelGP8GTXdZxUB986yv6?=
 =?us-ascii?Q?Hu9QNzsEY+ghTXrCzl7rRSu/1YDUoozDqYcQK4U20jkIGpApbd7rESACvJV0?=
 =?us-ascii?Q?TnnXEk3waGCw6L95oKfNQHCTSFn5T42D7Ty5GMhYKhRqMqz+YDtvkrLcv5Ec?=
 =?us-ascii?Q?KB8IkGiIyzzmDr9/MX4QNF3ZwW8IXd1eEi0JwyVROqvXx9dp2QnFU2X7oZN/?=
 =?us-ascii?Q?YMaBoQpnWXk8GPOaFbL4xlU2ZSBY3rRWrWliMQdHvb2S0MAhw0nJSrKrIy/X?=
 =?us-ascii?Q?QFW/SVR7s7ymDvg3GoRuuxi8oeUuklTdc+nVHlLnUPb4DeUxSkvPbdKeO+jJ?=
 =?us-ascii?Q?gd0eT97b4gXppnufzqkaJk2Md3+8uI7wa982rnkiUHvMBfl0ci4hxCsY2PIW?=
 =?us-ascii?Q?4iWKL3Iok1ulX3Aj1eUI3WgweAF8Mf05THDWR7bAgAUtLTiW6Led+K4FfXdG?=
 =?us-ascii?Q?c5yu6ccpfOufiD2U+L7VoccCGKkLE7kG5JHrlIxPXMQ/dS7yD8XAqQokQfQk?=
 =?us-ascii?Q?ES3qxtHJ1URK8bQeznyXGKMQxoPwEexGt7QX0xOVAERgtr8qx6LFAOUmZtMI?=
 =?us-ascii?Q?zDcijxNIkFJ1p5n4I2w0miqGFfh35SSPKs03O81yQKU4A5BiK/DaubEr/3vD?=
 =?us-ascii?Q?QFpGq+FYtJv814MUMPNmA+D5L1EcSZnpEE//mbA3y+JV5PetrlMGhbdoGrgh?=
 =?us-ascii?Q?weld64A3tTrhWwofV/tXb6UHy4xyI4zVhj8DjCWKA1kKJgGlhyUSmCTU70mQ?=
 =?us-ascii?Q?44e/x8akMYWKykNCZdjeJ9e3S5hNpnM8O4bij4vRl84orDCSo4bB/1xhwtBC?=
 =?us-ascii?Q?bnCWq2QbFV1qMMQpswWSIFo6bKxe1hQOtq+oxvUEGyBdcFh0iFoGUOQvuJsi?=
 =?us-ascii?Q?0ldmkmPoalfCtlA5ck/dc44mkF0Zo8XxJF8uX7NshN0EqdFK9QaQup0x46ZE?=
 =?us-ascii?Q?na1e7bALDlDJJn4Ig5RfFE2RMF6D5S4TQYk5Zgw3ynlxY5HcVc8+D2JR2gM3?=
 =?us-ascii?Q?NMhNk2SOEbvT4bzlDZvYk3IbtN1iKR6wuxVu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zjB1pzRZU1ajWW9lCSfDTacm6yd2Lspxsr5T99LlA1prKmNIjhNVuCnIML5i?=
 =?us-ascii?Q?l9YvJdjfBmok5XHm4b7ISqPeVqDlcyr/9vPbnXpgjwZsuafY74PdJFeAXknF?=
 =?us-ascii?Q?QrIZ2Ko/iRfHBl1e2sw194Ceyr36RPhCXPQiAAMz+gON+g6Xgo4I54YDlCH9?=
 =?us-ascii?Q?6flzhtAtpfe8/XkhPpECpprPC+zTYcp/znCbUj6nY2jiPwRA5jF1qLO/Rbcp?=
 =?us-ascii?Q?KYuAo+CuKUdcA0TqJTx+QQrhWJ2KIqOUtyXZN05+CmfCLeV5abJqleP5dcO/?=
 =?us-ascii?Q?SH+T/hueJx4s9dtJYZWzQUqEr1S9PucCre/D1mah3g6Xfa7V/SBkyw0WiH7E?=
 =?us-ascii?Q?TwtOSVlhNxSBqGQRnIHY7n3vuEz8Inob5eKTVVcd0c912Acx4iYHuS7c4jwC?=
 =?us-ascii?Q?ubnCVufWgJ/8I/uzt3lckDTHDlBc8b+F6L5erOJg2AAHvfS4UlHxRrPvH5G5?=
 =?us-ascii?Q?ZXSwaZhJgRt2BGRagNlnFhHpHIpf137svyZNEZ9b2Ka/dkm8IQyBGfURPese?=
 =?us-ascii?Q?QKKTuQk44WdMd+ewTrBAxMXcIfxac3VI6d5kMlz4+uv+9IbZXDZyCFdElyIb?=
 =?us-ascii?Q?c/WMM1fPkQXkCNxezfj8gKvL6YTFTs6n/vxCnbRlEkFgFq2smHA3UBVTLgua?=
 =?us-ascii?Q?lNwj7TrjjKiYhAZ7xjhTw3Dfo7XvJFZG2mmPB5QM4WkYVC83MT4MZChQm5Su?=
 =?us-ascii?Q?DLd/MqQUAdseevw7ZxY5RwfY1SKTPzsn7xdb0Zb76AsMsC8cnE9+0/z1aykP?=
 =?us-ascii?Q?+ZWudLc/2mONeMgIV682AOrUaIadiCy9eo91K/nZa1+2SoFilyMyna7+ej8I?=
 =?us-ascii?Q?18yfdtWtUeUy/+7g0SwT2UY9QsipFLoRbvFAnbzVCapd/M/3bzU20wpkZeJP?=
 =?us-ascii?Q?NCBYU3jIzmKB5wQ3EzI7L3q7DehlXzr8WFPYQXqZSTCLwdUMPAIuawFkyx4p?=
 =?us-ascii?Q?yQSc/EzdGG1DvXOq98UBPagFT7oTCR3CrKr78xzDAsojwGOZvguzvSCmixwN?=
 =?us-ascii?Q?1md+YFpWfW09I+kCcCPtCA7f/p7TsmceRlKmmhklmZwqi5Sz/9VWb8NAw+kq?=
 =?us-ascii?Q?K4CfOyRpxba2UvW6F9WNaUydytuYZ8RGVV8eEXGPigg76mf7FC1du84qH/YV?=
 =?us-ascii?Q?MParx4i2k7sWIQy2jrzu+4TXYEBrxUk2zUD0dN3PGfe955djA92Q3wDUi12f?=
 =?us-ascii?Q?TZYOnIxvg7df9p91PvpyuFj96/mP78ysHmDyxC04OlMHGCsip5dIuHEJdIct?=
 =?us-ascii?Q?7oNy+09G6WvmOPENAR7yc2lTsd2y7HYNUilMhIgwnXdNk9XOZd3Yzp/mXu7p?=
 =?us-ascii?Q?Sr66QrX/PtIeyk9HoNCmmPHkSAqQ1o4JEhMidrYLFruIPr49lgrDKhG2wu8D?=
 =?us-ascii?Q?A0pz9xOhxYm5N8QjavhL+9HYp8fxjUbHJZ91VZqPAPsdIVzBZhrO9rXmCYFh?=
 =?us-ascii?Q?YvmGGDFcjl3pZd2f5uc3PjLqeFWFs/1Cqqe3DsZ7HBJ3lJlP/+FzsBvCx9Mo?=
 =?us-ascii?Q?RgWn8JtCKRs/XibHUyKGBsOPG784PJvVsc/n/SWqTcxPWHJ2LhQ1aU6RMjXa?=
 =?us-ascii?Q?+Bp3WxBH8ELWfTACya31sZPh4Sq+2fNbyXpYssHr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946ce007-efa2-4f32-5e8b-08de25c8d771
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:02:47.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rmmvZ0W8Z2YlkxBaCcaLfA6iLGNlk2M70perrEk5kAT865GJ86QwksLGAXbDqnOye1q0ptL601iAc3pfqF9TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9309

This patch introduces the core layer of the nxpwifi driver, which provides
the foundational logic and infrastructure for managing the wireless
adapter.

Highlights:
- Implements adapter registration, initialization, and teardown
- Defines the main driver loop for handling TX/RX, command, and event flows
- Adds firmware download and wakeup handling logic
- Introduces power management, workqueue, and interrupt handling
- Provides debug and device dump support for diagnostics
- Defines core data structures and interfaces in main.h
- Establishes the interface abstraction via nxpwifi_if_ops for bus drivers

This core layer enables the bus-specific driver to instantiate and operate
the Wi-Fi device through a well-defined callback interface.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/main.c | 1834 ++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/main.h | 1836 +++++++++++++++++++++++
 2 files changed, 3670 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/main.c b/drivers/net/wireless/nxp/nxpwifi/main.c
new file mode 100644
index 000000000000..b3e9e57a0cba
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/main.c
@@ -0,0 +1,1834 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: major functions
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include <linux/suspend.h>
+
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "cfg80211.h"
+#include "11n.h"
+
+#define VERSION	"1.0"
+
+static unsigned int debug_mask = NXPWIFI_DEFAULT_DEBUG_MASK;
+
+char driver_version[] = "nxpwifi " VERSION " (%s) ";
+
+const u16 nxpwifi_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
+
+/* This function registers the device and performs all the necessary
+ * initializations.
+ *
+ * The following initialization operations are performed -
+ *      - Allocate adapter structure
+ *      - Save interface specific operations table in adapter
+ *      - Call interface specific initialization routine
+ *      - Allocate private structures
+ *      - Set default adapter structure parameters
+ *      - Initialize locks
+ *
+ * In case of any errors during initialization, this function also ensures
+ * proper cleanup before exiting.
+ */
+static struct nxpwifi_adapter *nxpwifi_register(void *card, struct device *dev,
+						struct nxpwifi_if_ops *if_ops)
+{
+	struct nxpwifi_adapter *adapter;
+	int ret = 0;
+	int i;
+
+	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
+	if (!adapter)
+		return ERR_PTR(-ENOMEM);
+
+	adapter->dev = dev;
+	adapter->card = card;
+
+	/* Save interface specific operations in adapter */
+	memmove(&adapter->if_ops, if_ops, sizeof(struct nxpwifi_if_ops));
+	adapter->debug_mask = debug_mask;
+
+	/* card specific initialization has been deferred until now .. */
+	if (adapter->if_ops.init_if) {
+		ret = adapter->if_ops.init_if(adapter);
+		if (ret)
+			goto error;
+	}
+
+	adapter->priv_num = 0;
+
+	for (i = 0; i < NXPWIFI_MAX_BSS_NUM; i++) {
+		/* Allocate memory for private structure */
+		adapter->priv[i] =
+			kzalloc(sizeof(struct nxpwifi_private), GFP_KERNEL);
+		if (!adapter->priv[i]) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		adapter->priv[i]->adapter = adapter;
+		adapter->priv_num++;
+	}
+	nxpwifi_init_lock_list(adapter);
+
+	timer_setup(&adapter->cmd_timer, nxpwifi_cmd_timeout_func, 0);
+
+	if (ret)
+		return ERR_PTR(ret);
+	else
+		return adapter;
+
+error:
+	nxpwifi_dbg(adapter, ERROR,
+		    "info: leave %s with error\n", __func__);
+
+	for (i = 0; i < adapter->priv_num; i++)
+		kfree(adapter->priv[i]);
+
+	kfree(adapter);
+
+	return ERR_PTR(ret);
+}
+
+/* This function unregisters the device and performs all the necessary
+ * cleanups.
+ *
+ * The following cleanup operations are performed -
+ *      - Free the timers
+ *      - Free beacon buffers
+ *      - Free private structures
+ *      - Free adapter structure
+ */
+static void nxpwifi_unregister(struct nxpwifi_adapter *adapter)
+{
+	s32 i;
+
+	if (adapter->if_ops.cleanup_if)
+		adapter->if_ops.cleanup_if(adapter);
+
+	timer_delete_sync(&adapter->cmd_timer);
+
+	/* Free private structures */
+	for (i = 0; i < adapter->priv_num; i++) {
+		nxpwifi_free_curr_bcn(adapter->priv[i]);
+		kfree(adapter->priv[i]);
+	}
+
+	if (adapter->nd_info) {
+		for (i = 0 ; i < adapter->nd_info->n_matches ; i++)
+			kfree(adapter->nd_info->matches[i]);
+		kfree(adapter->nd_info);
+		adapter->nd_info = NULL;
+	}
+
+	kfree(adapter->regd);
+
+	kfree(adapter);
+}
+
+static void nxpwifi_queue_rx_work(struct nxpwifi_adapter *adapter)
+{
+	queue_work(adapter->rx_workqueue, &adapter->rx_work);
+}
+
+static void nxpwifi_process_rx(struct nxpwifi_adapter *adapter)
+{
+	struct sk_buff *skb;
+	struct nxpwifi_rxinfo *rx_info;
+
+	if (atomic_read(&adapter->iface_changing) ||
+	    atomic_read(&adapter->rx_ba_teardown_pending))
+		return;
+
+	/* Check for Rx data */
+	while ((skb = skb_dequeue(&adapter->rx_data_q))) {
+		atomic_dec(&adapter->rx_pending);
+		if (adapter->delay_main_work &&
+		    (atomic_read(&adapter->rx_pending) < LOW_RX_PENDING)) {
+			adapter->delay_main_work = false;
+			nxpwifi_queue_work(adapter, &adapter->main_work);
+		}
+		rx_info = NXPWIFI_SKB_RXCB(skb);
+		if (rx_info->buf_type == NXPWIFI_TYPE_AGGR_DATA) {
+			if (adapter->if_ops.deaggr_pkt)
+				adapter->if_ops.deaggr_pkt(adapter, skb);
+			dev_kfree_skb_any(skb);
+		} else {
+			nxpwifi_handle_rx_packet(adapter, skb);
+		}
+	}
+}
+
+static void maybe_quirk_fw_disable_ds(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_STA);
+	struct nxpwifi_ver_ext ver_ext;
+
+	if (test_and_set_bit(NXPWIFI_IS_REQUESTING_FW_VEREXT, &adapter->work_flags))
+		return;
+
+	memset(&ver_ext, 0, sizeof(ver_ext));
+	ver_ext.version_str_sel = 1;
+	if (nxpwifi_send_cmd(priv, HOST_CMD_VERSION_EXT,
+			     HOST_ACT_GEN_GET, 0, &ver_ext, false)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "Checking hardware revision failed.\n");
+	}
+}
+
+static inline void nxpwifi_handle_irq_status(struct nxpwifi_adapter *adapter, u8 istat)
+{
+	if (adapter->hs_activated)
+		nxpwifi_process_hs_config(adapter);
+	if (adapter->if_ops.process_int_status)
+		adapter->if_ops.process_int_status(adapter, istat);
+}
+
+static inline bool nxpwifi_drain_tx(struct nxpwifi_adapter *adapter)
+{
+	bool ret = false;
+
+	if ((adapter->scan_chan_gap_enabled || !adapter->scan_processing) &&
+	    !adapter->data_sent && !skb_queue_empty(&adapter->tx_data_q)) {
+		if (adapter->hs_activated_manually) {
+			nxpwifi_cancel_hs(nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY),
+					  NXPWIFI_ASYNC_CMD);
+			adapter->hs_activated_manually = false;
+		}
+
+		nxpwifi_process_tx_queue(adapter);
+		if (adapter->hs_activated) {
+			clear_bit(NXPWIFI_IS_HS_CONFIGURED,
+				  &adapter->work_flags);
+			nxpwifi_hs_activated_event
+				(nxpwifi_get_priv
+				(adapter, NXPWIFI_BSS_ROLE_ANY),
+				false);
+		}
+		ret = true;
+	}
+
+	if ((adapter->scan_chan_gap_enabled ||
+	     !adapter->scan_processing) &&
+	    !adapter->data_sent &&
+	    !nxpwifi_bypass_txlist_empty(adapter)) {
+		if (adapter->hs_activated_manually) {
+			nxpwifi_cancel_hs(nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY),
+					  NXPWIFI_ASYNC_CMD);
+			adapter->hs_activated_manually = false;
+		}
+			nxpwifi_process_bypass_tx(adapter);
+		if (adapter->hs_activated) {
+			clear_bit(NXPWIFI_IS_HS_CONFIGURED,
+				  &adapter->work_flags);
+			nxpwifi_hs_activated_event
+				(nxpwifi_get_priv
+				 (adapter, NXPWIFI_BSS_ROLE_ANY),
+				 false);
+		}
+		ret = true;
+	}
+
+	if ((adapter->scan_chan_gap_enabled ||
+	     !adapter->scan_processing) &&
+	    !adapter->data_sent && !nxpwifi_wmm_lists_empty(adapter)) {
+		if (adapter->hs_activated_manually) {
+			nxpwifi_cancel_hs(nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY),
+					  NXPWIFI_ASYNC_CMD);
+			adapter->hs_activated_manually = false;
+		}
+
+		nxpwifi_wmm_process_tx(adapter);
+		if (adapter->hs_activated) {
+			clear_bit(NXPWIFI_IS_HS_CONFIGURED,
+				  &adapter->work_flags);
+			nxpwifi_hs_activated_event
+				(nxpwifi_get_priv
+				 (adapter, NXPWIFI_BSS_ROLE_ANY),
+				 false);
+		}
+		ret = true;
+	}
+
+	return ret;
+}
+
+static inline bool nxpwifi_handle_rx(struct nxpwifi_adapter *adapter)
+{
+	if (adapter->rx_work_enabled && adapter->data_received) {
+		nxpwifi_queue_rx_work(adapter);
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool nxpwifi_handle_cmd_response(struct nxpwifi_adapter *adapter)
+{
+	/* Check for Cmd Resp */
+	if (adapter->cmd_resp_received) {
+		adapter->cmd_resp_received = false;
+		nxpwifi_process_cmdresp(adapter);
+		/* call nxpwifi back when init_fw is done */
+		if (adapter->hw_status == NXPWIFI_HW_STATUS_INIT_DONE) {
+			adapter->hw_status = NXPWIFI_HW_STATUS_READY;
+			nxpwifi_init_fw_complete(adapter);
+			maybe_quirk_fw_disable_ds(adapter);
+		}
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool nxpwifi_handle_events(struct nxpwifi_adapter *adapter)
+{
+	if (adapter->event_received) {
+		adapter->event_received = false;
+		nxpwifi_process_event(adapter);
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool nxpwifi_tx_has_pending(struct nxpwifi_adapter *adapter)
+{
+	return !skb_queue_empty(&adapter->tx_data_q) ||
+		!nxpwifi_bypass_txlist_empty(adapter) ||
+		!nxpwifi_wmm_lists_empty(adapter);
+}
+
+static inline bool nxpwifi_cmd_has_pending(struct nxpwifi_adapter *adapter)
+{
+	return !list_empty(&adapter->cmd_pending_q);
+}
+
+static inline bool nxpwifi_events_has_pending(struct nxpwifi_adapter *adapter)
+{
+	return adapter->event_received;
+}
+
+static inline bool nxpwifi_should_wakeup_card(struct nxpwifi_adapter *adapter)
+{
+	if (adapter->ps_state != PS_STATE_SLEEP)
+		return false;
+
+	if (!adapter->pm_wakeup_card_req || adapter->pm_wakeup_fw_try)
+		return false;
+
+	return is_command_pending(adapter) || nxpwifi_tx_has_pending(adapter);
+}
+
+static inline bool nxpwifi_should_exit_main_loop(struct nxpwifi_adapter *adapter)
+{
+	if (adapter->pm_wakeup_fw_try)
+		return true;
+
+	if (adapter->ps_state == PS_STATE_PRE_SLEEP)
+		nxpwifi_check_ps_cond(adapter);
+
+	if (adapter->ps_state != PS_STATE_AWAKE)
+		return true;
+
+	if (adapter->tx_lock_flag)
+		return true;
+
+	if ((!adapter->scan_chan_gap_enabled && adapter->scan_processing) ||
+	    adapter->data_sent || !nxpwifi_tx_has_pending(adapter)) {
+		if (adapter->cmd_sent || adapter->curr_cmd ||
+		    !is_command_pending(adapter))
+			return true;
+	}
+
+	return false;
+}
+
+static inline void nxpwifi_wakeup_card(struct nxpwifi_adapter *adapter)
+{
+	adapter->pm_wakeup_fw_try = true;
+	mod_timer(&adapter->wakeup_timer, jiffies + (HZ * 3));
+	adapter->if_ops.wakeup(adapter);
+}
+
+static inline void nxpwifi_handle_vdll_download(struct nxpwifi_adapter *adapter)
+{
+	if (!adapter->cmd_sent && adapter->vdll_ctrl.pending_block) {
+		struct vdll_dnld_ctrl *ctrl = &adapter->vdll_ctrl;
+
+		nxpwifi_download_vdll_block(adapter, ctrl->pending_block,
+					    ctrl->pending_block_len);
+		ctrl->pending_block = NULL;
+	}
+}
+
+static inline void nxpwifi_finish_delayed_null_pkt(struct nxpwifi_adapter *adapter)
+{
+	if (!adapter->delay_null_pkt)
+		return;
+
+	if (adapter->cmd_sent || adapter->curr_cmd || is_command_pending(adapter))
+		return;
+
+	if (nxpwifi_tx_has_pending(adapter))
+		return;
+
+	if (!nxpwifi_send_null_packet(nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_STA),
+				      NXPWIFI_TxPD_POWER_MGMT_NULL_PACKET |
+				      NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET)) {
+		adapter->delay_null_pkt = false;
+		adapter->ps_state = PS_STATE_SLEEP;
+	}
+}
+
+static inline bool nxpwifi_pump_command(struct nxpwifi_adapter *adapter)
+{
+	if (!adapter->cmd_sent && !adapter->curr_cmd) {
+		if (!nxpwifi_exec_next_cmd(adapter))
+			return true;
+	}
+
+	return false;
+}
+
+/* The main process.
+ *
+ * This function is the main procedure of the driver and handles various driver
+ * operations. It runs in a loop and provides the core functionalities.
+ *
+ * The main responsibilities of this function are -
+ *      - Ensure concurrency control
+ *      - Handle pending interrupts and call interrupt handlers
+ *      - Wake up the card if required
+ *      - Handle command responses and call response handlers
+ *      - Handle events and call event handlers
+ *      - Execute pending commands
+ *      - Transmit pending data packets
+ */
+void nxpwifi_main_process(struct nxpwifi_adapter *adapter)
+{
+	unsigned long flags;
+
+	/* Check if virtual interface changing */
+	if (atomic_read(&adapter->iface_changing)) {
+		nxpwifi_dbg(adapter,
+			    INFO, "main_process skipped due to iface_changing");
+		return;
+	}
+
+	for (;;) {
+		bool did_work = false;
+		u8 istat = 0;
+
+		if (adapter->hw_status == NXPWIFI_HW_STATUS_NOT_READY)
+			break;
+
+		/* For non-USB interfaces, If we process interrupts first, it
+		 * would increase RX pending even further. Avoid this by
+		 * checking if rx_pending has crossed high threshold and
+		 * schedule rx work queue and then process interrupts.
+		 * For USB interface, there are no interrupts. We already have
+		 * HIGH_RX_PENDING check in usb.c
+		 */
+		if (atomic_read(&adapter->rx_pending) >= HIGH_RX_PENDING) {
+			adapter->delay_main_work = true;
+			nxpwifi_queue_rx_work(adapter);
+			break;
+		}
+
+		/* Snapshot-and-clear the interrupt status.
+		 *
+		 * Take the same lock as the producer (nxpwifi_sdio_interrupt()) uses
+		 * when OR-ing new bits into adapter->int_status. We atomically grab
+		 * what has accumulated and clear it, so this consumer owns this batch.
+		 */
+		spin_lock_irqsave(&adapter->int_lock, flags);
+		istat = adapter->int_status;
+		adapter->int_status = 0;
+		spin_unlock_irqrestore(&adapter->int_lock, flags);
+
+		/* Handle pending interrupt if any */
+		if (istat) {
+			nxpwifi_handle_irq_status(adapter, istat);
+			did_work = true;
+		}
+
+		did_work |= nxpwifi_handle_rx(adapter);
+
+		if (nxpwifi_should_wakeup_card(adapter)) {
+			nxpwifi_wakeup_card(adapter);
+			continue;
+		}
+
+		if (IS_CARD_RX_RCVD(adapter)) {
+			/* Card has responded, clear wakeup state and update power state */
+			adapter->data_received = false;
+			adapter->pm_wakeup_fw_try = false;
+			timer_delete(&adapter->wakeup_timer);
+			if (adapter->ps_state == PS_STATE_SLEEP)
+				adapter->ps_state = PS_STATE_AWAKE;
+		} else {
+			if (nxpwifi_should_exit_main_loop(adapter))
+				break;
+		}
+
+		did_work |= nxpwifi_handle_events(adapter);
+
+		did_work |= nxpwifi_handle_cmd_response(adapter);
+
+		/* Check if we need to confirm Sleep Request
+		 * received previously
+		 */
+		if (adapter->ps_state == PS_STATE_PRE_SLEEP)
+			nxpwifi_check_ps_cond(adapter);
+
+		/* * The ps_state may have been changed during processing of
+		 * Sleep Request event.
+		 */
+		if (adapter->ps_state != PS_STATE_AWAKE)
+			continue;
+
+		if (adapter->tx_lock_flag)
+			continue;
+
+		nxpwifi_handle_vdll_download(adapter);
+
+		did_work |= nxpwifi_pump_command(adapter);
+
+		did_work |= nxpwifi_drain_tx(adapter);
+
+		/*
+		 * Attempt to send delayed null packet.
+		 * If successful, firmware will enter sleep and ps_state will be updated.
+		 * We check ps_state here to determine if main loop can safely exit.
+		 */
+		nxpwifi_finish_delayed_null_pkt(adapter);
+
+		if (adapter->ps_state == PS_STATE_SLEEP)
+			break;
+		/*
+		 * Step 3) Cooperative preemption point.
+		 * cond_resched() yields ONLY if need_resched() is set. Placing it
+		 * BEFORE the final check improves fairness: it lets ksdioirqd (RT/FIFO)
+		 * or other producers run and set new int_status bits. Immediately
+		 * after we return here, we perform the final "net cast" (Step 4) to
+		 * decide if we should continue or return.
+		 */
+
+		cond_resched();
+
+		/*
+		 * Step 4) Exit decision with lost-kick closure.
+		 *
+		 * We consider exiting ONLY when this round did no real work.
+		 * Rationale:
+		 *   - If did_work == true: we will loop anyway; at Step 1 we will
+		 *     re-snapshot int_status, so there's no need to re-check now.
+		 *   - If did_work == false: we appear idle and may return. But during
+		 *     our execution window, a producer may have just set int_status and
+		 *     queue_work(); since this work is still running, queue_work()
+		 *     returns false (no second instance queued). If we return now,
+		 *     we'd leave unprocessed status with no pending work => lost-kick.
+		 *
+		 * Therefore, perform a single final check: if *anything* is pending,
+		 * continue looping; otherwise, break and return.
+		 */
+		if (!did_work) {
+			bool more = false;
+			unsigned long flags;
+			/* 4a) New IRQ bits raced in while we were running? */
+			spin_lock_irqsave(&adapter->int_lock, flags);
+			more |= adapter->int_status != 0;
+			spin_unlock_irqrestore(&adapter->int_lock, flags);
+			/* 4b) Any other sources still pending? (driver-specific) */
+			more |= nxpwifi_tx_has_pending(adapter);
+			more |= nxpwifi_cmd_has_pending(adapter);
+			more |= nxpwifi_events_has_pending(adapter);
+
+			if (!more)
+				break;  /* Truly quiescent now: safe to return. */
+			/* else: loop back to Step 1 to consume what just arrived. */
+		}
+		/* If did_work == true, we loop unconditionally and re-snapshot. */
+	};
+}
+
+/* This function frees the adapter structure.
+ *
+ * Additionally, this closes the netlink socket, frees the timers
+ * and private structures.
+ */
+static void nxpwifi_free_adapter(struct nxpwifi_adapter *adapter)
+{
+	if (!adapter) {
+		pr_err("%s: adapter is NULL\n", __func__);
+		return;
+	}
+
+	nxpwifi_unregister(adapter);
+	pr_debug("info: %s: free adapter\n", __func__);
+}
+
+/* This function cancels all works in the queue and destroys
+ * the main workqueue.
+ */
+static void nxpwifi_terminate_workqueue(struct nxpwifi_adapter *adapter)
+{
+	if (adapter->workqueue) {
+		destroy_workqueue(adapter->workqueue);
+		adapter->workqueue = NULL;
+	}
+
+	if (adapter->rx_workqueue) {
+		destroy_workqueue(adapter->rx_workqueue);
+		adapter->rx_workqueue = NULL;
+	}
+}
+
+/* This function gets firmware and initializes it.
+ *
+ * The main initialization steps followed are -
+ *      - Download the correct firmware to card
+ *      - Issue the init commands to firmware
+ */
+static int _nxpwifi_fw_dpc(const struct firmware *firmware, void *context)
+{
+	int ret = 0;
+	char fmt[64];
+	struct nxpwifi_adapter *adapter = context;
+	struct nxpwifi_fw_image fw;
+	bool init_failed = false;
+	struct wireless_dev *wdev;
+	struct completion *fw_done = adapter->fw_done;
+
+	if (!firmware) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Failed to get firmware %s\n", adapter->fw_name);
+		ret = -EINVAL;
+		goto err_dnld_fw;
+	}
+
+	memset(&fw, 0, sizeof(struct nxpwifi_fw_image));
+	adapter->firmware = firmware;
+	fw.fw_buf = (u8 *)adapter->firmware->data;
+	fw.fw_len = adapter->firmware->size;
+
+	if (adapter->if_ops.dnld_fw)
+		ret = adapter->if_ops.dnld_fw(adapter, &fw);
+	else
+		ret = nxpwifi_dnld_fw(adapter, &fw);
+
+	if (ret)
+		goto err_dnld_fw;
+
+	nxpwifi_dbg(adapter, MSG, "WLAN FW is active\n");
+
+	/* enable host interrupt after fw dnld is successful */
+	if (adapter->if_ops.enable_int) {
+		ret = adapter->if_ops.enable_int(adapter);
+		if (ret)
+			goto err_dnld_fw;
+	}
+
+	adapter->init_wait_q_woken = false;
+	ret = nxpwifi_init_fw(adapter);
+	if (ret != -EINPROGRESS) {
+		goto err_init_fw;
+	} else if (!ret) {
+		adapter->hw_status = NXPWIFI_HW_STATUS_READY;
+		goto done;
+	}
+	/* Wait for nxpwifi_init to complete */
+	wait_event_interruptible(adapter->init_wait_q,
+				 adapter->init_wait_q_woken);
+	if (adapter->hw_status != NXPWIFI_HW_STATUS_READY)
+		goto err_init_fw;
+
+	if (!adapter->wiphy) {
+		if (nxpwifi_register_cfg80211(adapter)) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "cannot register with cfg80211\n");
+			goto err_init_fw;
+		}
+	}
+
+	if (nxpwifi_init_channel_scan_gap(adapter)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "could not init channel stats table\n");
+		goto err_init_chan_scan;
+	}
+
+	rtnl_lock();
+	/* Create station interface by default */
+	wdev = nxpwifi_add_virtual_intf(adapter->wiphy, "mlan%d", NET_NAME_ENUM,
+					NL80211_IFTYPE_STATION, NULL);
+	if (IS_ERR(wdev)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "cannot create default STA interface\n");
+		rtnl_unlock();
+		goto err_add_intf;
+	}
+
+	wdev = nxpwifi_add_virtual_intf(adapter->wiphy, "uap%d", NET_NAME_ENUM,
+					NL80211_IFTYPE_AP, NULL);
+	if (IS_ERR(wdev)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "cannot create AP interface\n");
+		rtnl_unlock();
+		goto err_add_intf;
+	}
+
+	rtnl_unlock();
+
+	nxpwifi_drv_get_driver_version(adapter, fmt, sizeof(fmt) - 1);
+	nxpwifi_dbg(adapter, MSG, "driver_version = %s\n", fmt);
+	adapter->is_up = true;
+	goto done;
+
+err_add_intf:
+	vfree(adapter->chan_stats);
+err_init_chan_scan:
+	wiphy_unregister(adapter->wiphy);
+	wiphy_free(adapter->wiphy);
+err_init_fw:
+	if (adapter->if_ops.disable_int)
+		adapter->if_ops.disable_int(adapter);
+err_dnld_fw:
+	nxpwifi_dbg(adapter, ERROR,
+		    "info: %s: unregister device\n", __func__);
+	if (adapter->if_ops.unregister_dev)
+		adapter->if_ops.unregister_dev(adapter);
+
+	set_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+	nxpwifi_terminate_workqueue(adapter);
+
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_READY) {
+		pr_debug("info: %s: shutdown nxpwifi\n", __func__);
+		nxpwifi_shutdown_drv(adapter);
+		nxpwifi_free_cmd_buffers(adapter);
+	}
+
+	init_failed = true;
+done:
+	if (adapter->cal_data) {
+		release_firmware(adapter->cal_data);
+		adapter->cal_data = NULL;
+	}
+	if (adapter->firmware) {
+		release_firmware(adapter->firmware);
+		adapter->firmware = NULL;
+	}
+	if (init_failed) {
+		if (adapter->irq_wakeup >= 0)
+			device_init_wakeup(adapter->dev, false);
+		nxpwifi_free_adapter(adapter);
+	}
+	/* Tell all current and future waiters we're finished */
+	complete_all(fw_done);
+
+	return ret;
+}
+
+static void nxpwifi_fw_dpc(const struct firmware *firmware, void *context)
+{
+	_nxpwifi_fw_dpc(firmware, context);
+}
+
+/* This function gets the firmware and (if called asynchronously) kicks off the
+ * HW init when done.
+ */
+static int nxpwifi_init_hw_fw(struct nxpwifi_adapter *adapter,
+			      bool req_fw_nowait)
+{
+	int ret;
+
+	if (req_fw_nowait) {
+		ret = request_firmware_nowait(THIS_MODULE, 1, adapter->fw_name,
+					      adapter->dev, GFP_KERNEL, adapter,
+					      nxpwifi_fw_dpc);
+	} else {
+		ret = request_firmware(&adapter->firmware,
+				       adapter->fw_name,
+				       adapter->dev);
+	}
+
+	if (ret < 0)
+		nxpwifi_dbg(adapter, ERROR, "request_firmware%s error %d\n",
+			    req_fw_nowait ? "_nowait" : "", ret);
+	return ret;
+}
+
+/* cfg80211 network device handler for open.
+ *
+ * Starts the data queue.
+ */
+static int
+nxpwifi_open(struct net_device *dev)
+{
+	netif_carrier_off(dev);
+
+	return 0;
+}
+
+/* cfg80211 network device handler for close.
+ */
+static int
+nxpwifi_close(struct net_device *dev)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+
+	if (priv->scan_request) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "aborting scan on ndo_stop\n");
+		cfg80211_scan_done(priv->scan_request, &info);
+		priv->scan_request = NULL;
+		priv->scan_aborting = true;
+	}
+
+	if (priv->sched_scanning) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "aborting bgscan on ndo_stop\n");
+		nxpwifi_stop_bg_scan(priv);
+		cfg80211_sched_scan_stopped(priv->wdev.wiphy, 0);
+	}
+
+	return 0;
+}
+
+static bool
+nxpwifi_bypass_tx_queue(struct nxpwifi_private *priv,
+			struct sk_buff *skb)
+{
+	struct ethhdr *eth_hdr = (struct ethhdr *)skb->data;
+
+	if (eth_hdr->h_proto == htons(ETH_P_PAE) ||
+	    nxpwifi_is_skb_mgmt_frame(skb)) {
+		nxpwifi_dbg(priv->adapter, DATA,
+			    "bypass txqueue; eth type %#x, mgmt %d\n",
+			     ntohs(eth_hdr->h_proto),
+			     nxpwifi_is_skb_mgmt_frame(skb));
+		if (eth_hdr->h_proto == htons(ETH_P_PAE))
+			nxpwifi_dbg(priv->adapter, MSG,
+				    "key: send EAPOL to %pM\n",
+				    eth_hdr->h_dest);
+		return true;
+	}
+
+	return false;
+}
+
+/* Add buffer into wmm tx queue and queue work to transmit it.
+ */
+void nxpwifi_queue_tx_pkt(struct nxpwifi_private *priv, struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct netdev_queue *txq;
+	int index = nxpwifi_1d_to_wmm_queue[skb->priority];
+
+	if (atomic_inc_return(&priv->wmm_tx_pending[index]) >= MAX_TX_PENDING) {
+		txq = netdev_get_tx_queue(priv->netdev, index);
+		if (!netif_tx_queue_stopped(txq)) {
+			netif_tx_stop_queue(txq);
+			nxpwifi_dbg(adapter, DATA,
+				    "stop queue: %d\n", index);
+		}
+	}
+
+	if (nxpwifi_bypass_tx_queue(priv, skb)) {
+		atomic_inc(&adapter->tx_pending);
+		atomic_inc(&adapter->bypass_tx_pending);
+		nxpwifi_wmm_add_buf_bypass_txqueue(priv, skb);
+	} else {
+		atomic_inc(&adapter->tx_pending);
+		nxpwifi_wmm_add_buf_txqueue(priv, skb);
+	}
+
+	nxpwifi_queue_work(adapter, &adapter->main_work);
+}
+
+struct sk_buff *
+nxpwifi_clone_skb_for_tx_status(struct nxpwifi_private *priv,
+				struct sk_buff *skb, u8 flag, u64 *cookie)
+{
+	struct sk_buff *orig_skb = skb;
+	struct nxpwifi_txinfo *tx_info, *orig_tx_info;
+
+	skb = skb_clone(skb, GFP_ATOMIC);
+	if (skb) {
+		int id;
+
+		spin_lock_bh(&priv->ack_status_lock);
+		id = idr_alloc(&priv->ack_status_frames, orig_skb,
+			       1, 0x10, GFP_ATOMIC);
+		spin_unlock_bh(&priv->ack_status_lock);
+
+		if (id >= 0) {
+			tx_info = NXPWIFI_SKB_TXCB(skb);
+			tx_info->ack_frame_id = id;
+			tx_info->flags |= flag;
+			orig_tx_info = NXPWIFI_SKB_TXCB(orig_skb);
+			orig_tx_info->ack_frame_id = id;
+			orig_tx_info->flags |= flag;
+
+			if (flag == NXPWIFI_BUF_FLAG_ACTION_TX_STATUS && cookie)
+				orig_tx_info->cookie = *cookie;
+
+		} else if (skb_shared(skb)) {
+			kfree_skb(orig_skb);
+		} else {
+			kfree_skb(skb);
+			skb = orig_skb;
+		}
+	} else {
+		/* couldn't clone -- lose tx status ... */
+		skb = orig_skb;
+	}
+
+	return skb;
+}
+
+/* cfg80211 network device handler for data transmission.
+ */
+static netdev_tx_t
+nxpwifi_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	struct sk_buff *new_skb;
+	struct nxpwifi_txinfo *tx_info;
+	bool multicast;
+
+	nxpwifi_dbg(priv->adapter, DATA,
+		    "data: %lu BSS(%d-%d): Data <= kernel\n",
+		    jiffies, priv->bss_type, priv->bss_num);
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &priv->adapter->work_flags)) {
+		kfree_skb(skb);
+		priv->stats.tx_dropped++;
+		return 0;
+	}
+	if (!skb->len || skb->len > ETH_FRAME_LEN) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Tx: bad skb len %d\n", skb->len);
+		kfree_skb(skb);
+		priv->stats.tx_dropped++;
+		return 0;
+	}
+	if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN) {
+		nxpwifi_dbg(priv->adapter, DATA,
+			    "data: Tx: insufficient skb headroom %d\n",
+			    skb_headroom(skb));
+		/* Insufficient skb headroom - allocate a new skb */
+		new_skb =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		if (unlikely(!new_skb)) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Tx: cannot alloca new_skb\n");
+			kfree_skb(skb);
+			priv->stats.tx_dropped++;
+			return 0;
+		}
+		kfree_skb(skb);
+		skb = new_skb;
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: new skb headroomd %d\n",
+			    skb_headroom(skb));
+	}
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->pkt_len = skb->len;
+
+	multicast = is_multicast_ether_addr(skb->data);
+
+	if (unlikely(!multicast && sk_requests_wifi_status(skb->sk) &&
+		     priv->adapter->fw_api_ver == NXPWIFI_FW_V15))
+		skb = nxpwifi_clone_skb_for_tx_status(priv,
+						      skb,
+					NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS, NULL);
+
+	/* Record the current time the packet was queued; used to
+	 * determine the amount of time the packet was queued in
+	 * the driver before it was sent to the firmware.
+	 * The delay is then sent along with the packet to the
+	 * firmware for aggregate delay calculation for stats and
+	 * MSDU lifetime expiry.
+	 */
+	__net_timestamp(skb);
+
+	nxpwifi_queue_tx_pkt(priv, skb);
+
+	return 0;
+}
+
+int nxpwifi_set_mac_address(struct nxpwifi_private *priv,
+			    struct net_device *dev, bool external,
+			    u8 *new_mac)
+{
+	int ret;
+	u64 mac_addr, old_mac_addr;
+
+	old_mac_addr = ether_addr_to_u64(priv->curr_addr);
+
+	if (external) {
+		mac_addr = ether_addr_to_u64(new_mac);
+	} else {
+		/* Internal mac address change */
+		if (priv->bss_type == NXPWIFI_BSS_TYPE_ANY)
+			return -EOPNOTSUPP;
+
+		mac_addr = old_mac_addr;
+
+		if (priv->adapter->priv[0] != priv) {
+			/* Set mac address based on bss_type/bss_num */
+			mac_addr ^= BIT_ULL(priv->bss_type + 8);
+			mac_addr += priv->bss_num;
+		}
+	}
+
+	u64_to_ether_addr(mac_addr, priv->curr_addr);
+
+	/* Send request to firmware */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_MAC_ADDRESS,
+			       HOST_ACT_GEN_SET, 0, NULL, true);
+
+	if (ret) {
+		u64_to_ether_addr(old_mac_addr, priv->curr_addr);
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "set mac address failed: ret=%d\n", ret);
+		return ret;
+	}
+
+	eth_hw_addr_set(dev, priv->curr_addr);
+	return 0;
+}
+
+/* cfg80211 network device handler for setting MAC address.
+ */
+static int
+nxpwifi_ndo_set_mac_address(struct net_device *dev, void *addr)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	struct sockaddr *hw_addr = addr;
+
+	return nxpwifi_set_mac_address(priv, dev, true, hw_addr->sa_data);
+}
+
+/* cfg80211 network device handler for setting multicast list.
+ */
+static void nxpwifi_set_multicast_list(struct net_device *dev)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	struct nxpwifi_multicast_list mcast_list;
+
+	if (dev->flags & IFF_PROMISC) {
+		mcast_list.mode = NXPWIFI_PROMISC_MODE;
+	} else if (dev->flags & IFF_ALLMULTI ||
+		   netdev_mc_count(dev) > NXPWIFI_MAX_MULTICAST_LIST_SIZE) {
+		mcast_list.mode = NXPWIFI_ALL_MULTI_MODE;
+	} else {
+		mcast_list.mode = NXPWIFI_MULTICAST_MODE;
+		mcast_list.num_multicast_addr =
+			nxpwifi_copy_mcast_addr(&mcast_list, dev);
+	}
+	nxpwifi_request_set_multicast_list(priv, &mcast_list);
+}
+
+/* cfg80211 network device handler for transmission timeout.
+ */
+static void
+nxpwifi_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+
+	priv->num_tx_timeout++;
+	priv->tx_timeout_cnt++;
+	nxpwifi_dbg(priv->adapter, ERROR,
+		    "%lu : Tx timeout(#%d), bss_type-num = %d-%d\n",
+		    jiffies, priv->tx_timeout_cnt, priv->bss_type,
+		    priv->bss_num);
+	nxpwifi_set_trans_start(dev);
+
+	if (priv->tx_timeout_cnt > TX_TIMEOUT_THRESHOLD &&
+	    priv->adapter->if_ops.card_reset) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "tx_timeout_cnt exceeds threshold.\t"
+			    "Triggering card reset!\n");
+		priv->adapter->if_ops.card_reset(priv->adapter);
+	}
+}
+
+void nxpwifi_upload_device_dump(struct nxpwifi_adapter *adapter)
+{
+	/* Dump all the memory data into single file, a userspace script will
+	 * be used to split all the memory data to multiple files
+	 */
+	nxpwifi_dbg(adapter, MSG,
+		    "== nxpwifi dump information to /sys/class/devcoredump start\n");
+	dev_coredumpv(adapter->dev, adapter->devdump_data, adapter->devdump_len,
+		      GFP_KERNEL);
+	nxpwifi_dbg(adapter, MSG,
+		    "== nxpwifi dump information to /sys/class/devcoredump end\n");
+
+	/* Device dump data will be freed in device coredump release function
+	 * after 5 min. Here reset adapter->devdump_data and ->devdump_len
+	 * to avoid it been accidentally reused.
+	 */
+	adapter->devdump_data = NULL;
+	adapter->devdump_len = 0;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_upload_device_dump);
+
+void nxpwifi_drv_info_dump(struct nxpwifi_adapter *adapter)
+{
+	char *p;
+	char drv_version[64];
+	struct sdio_mmc_card *sdio_card;
+	struct nxpwifi_private *priv;
+	int i, idx;
+	struct netdev_queue *txq;
+	struct nxpwifi_debug_info *debug_info;
+
+	nxpwifi_dbg(adapter, MSG, "===nxpwifi driverinfo dump start===\n");
+
+	p = adapter->devdump_data;
+	strscpy(p, "========Start dump driverinfo========\n", NXPWIFI_FW_DUMP_SIZE);
+	p += strlen("========Start dump driverinfo========\n");
+	p += sprintf(p, "driver_name = ");
+	p += sprintf(p, "\"nxpwifi\"\n");
+
+	nxpwifi_drv_get_driver_version(adapter, drv_version,
+				       sizeof(drv_version) - 1);
+	p += sprintf(p, "driver_version = %s\n", drv_version);
+
+	p += sprintf(p, "tx_pending = %d\n",
+		     atomic_read(&adapter->tx_pending));
+	p += sprintf(p, "rx_pending = %d\n",
+		     atomic_read(&adapter->rx_pending));
+
+	if (adapter->iface_type == NXPWIFI_SDIO) {
+		sdio_card = (struct sdio_mmc_card *)adapter->card;
+		p += sprintf(p, "\nmp_rd_bitmap=0x%x curr_rd_port=0x%x\n",
+			     sdio_card->mp_rd_bitmap, sdio_card->curr_rd_port);
+		p += sprintf(p, "mp_wr_bitmap=0x%x curr_wr_port=0x%x\n",
+			     sdio_card->mp_wr_bitmap, sdio_card->curr_wr_port);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (!adapter->priv[i]->netdev)
+			continue;
+		priv = adapter->priv[i];
+		p += sprintf(p, "\n[interface  : \"%s\"]\n",
+			     priv->netdev->name);
+		p += sprintf(p, "wmm_tx_pending[0] = %d\n",
+			     atomic_read(&priv->wmm_tx_pending[0]));
+		p += sprintf(p, "wmm_tx_pending[1] = %d\n",
+			     atomic_read(&priv->wmm_tx_pending[1]));
+		p += sprintf(p, "wmm_tx_pending[2] = %d\n",
+			     atomic_read(&priv->wmm_tx_pending[2]));
+		p += sprintf(p, "wmm_tx_pending[3] = %d\n",
+			     atomic_read(&priv->wmm_tx_pending[3]));
+		p += sprintf(p, "media_state=\"%s\"\n", !priv->media_connected ?
+			     "Disconnected" : "Connected");
+		p += sprintf(p, "carrier %s\n", (netif_carrier_ok(priv->netdev)
+			     ? "on" : "off"));
+		for (idx = 0; idx < priv->netdev->num_tx_queues; idx++) {
+			txq = netdev_get_tx_queue(priv->netdev, idx);
+			p += sprintf(p, "tx queue %d:%s  ", idx,
+				     netif_tx_queue_stopped(txq) ?
+				     "stopped" : "started");
+		}
+		p += sprintf(p, "\n%s: num_tx_timeout = %d\n",
+			     priv->netdev->name, priv->num_tx_timeout);
+	}
+
+	if (adapter->iface_type == NXPWIFI_SDIO) {
+		p += sprintf(p, "\n=== %s register dump===\n", "SDIO");
+		if (adapter->if_ops.reg_dump)
+			p += adapter->if_ops.reg_dump(adapter, p);
+	}
+	p += sprintf(p, "\n=== more debug information\n");
+	debug_info = kzalloc(sizeof(*debug_info), GFP_KERNEL);
+	if (debug_info) {
+		for (i = 0; i < adapter->priv_num; i++) {
+			if (!adapter->priv[i]->netdev)
+				continue;
+			priv = adapter->priv[i];
+			nxpwifi_get_debug_info(priv, debug_info);
+			p += nxpwifi_debug_info_to_buffer(priv, p, debug_info);
+			break;
+		}
+		kfree(debug_info);
+	}
+
+	p += sprintf(p, "\n========End dump========\n");
+	nxpwifi_dbg(adapter, MSG, "===nxpwifi driverinfo dump end===\n");
+	adapter->devdump_len = p - (char *)adapter->devdump_data;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_drv_info_dump);
+
+void nxpwifi_prepare_fw_dump_info(struct nxpwifi_adapter *adapter)
+{
+	u8 idx;
+	char *fw_dump_ptr;
+	u32 dump_len = 0;
+
+	for (idx = 0; idx < adapter->num_mem_types; idx++) {
+		struct memory_type_mapping *entry =
+				&adapter->mem_type_mapping_tbl[idx];
+
+		if (entry->mem_ptr) {
+			dump_len += (strlen("========Start dump ") +
+					strlen(entry->mem_name) +
+					strlen("========\n") +
+					(entry->mem_size + 1) +
+					strlen("\n========End dump========\n"));
+		}
+	}
+
+	if (dump_len + 1 + adapter->devdump_len > NXPWIFI_FW_DUMP_SIZE) {
+		/* Realloc in case buffer overflow */
+		fw_dump_ptr = vzalloc(dump_len + 1 + adapter->devdump_len);
+		nxpwifi_dbg(adapter, MSG, "Realloc device dump data.\n");
+		if (!fw_dump_ptr) {
+			vfree(adapter->devdump_data);
+			nxpwifi_dbg(adapter, ERROR,
+				    "vzalloc devdump data failure!\n");
+			return;
+		}
+
+		memmove(fw_dump_ptr, adapter->devdump_data,
+			adapter->devdump_len);
+		vfree(adapter->devdump_data);
+		adapter->devdump_data = fw_dump_ptr;
+	}
+
+	fw_dump_ptr = (char *)adapter->devdump_data + adapter->devdump_len;
+
+	for (idx = 0; idx < adapter->num_mem_types; idx++) {
+		struct memory_type_mapping *entry =
+					&adapter->mem_type_mapping_tbl[idx];
+
+		if (entry->mem_ptr) {
+			fw_dump_ptr += sprintf(fw_dump_ptr, "========Start dump ");
+			fw_dump_ptr += sprintf(fw_dump_ptr, "%s", entry->mem_name);
+			fw_dump_ptr += sprintf(fw_dump_ptr, "========\n");
+			memcpy(fw_dump_ptr, entry->mem_ptr, entry->mem_size);
+			fw_dump_ptr += entry->mem_size;
+			fw_dump_ptr += sprintf(fw_dump_ptr, "\n========End dump========\n");
+		}
+	}
+
+	adapter->devdump_len = fw_dump_ptr - (char *)adapter->devdump_data;
+
+	for (idx = 0; idx < adapter->num_mem_types; idx++) {
+		struct memory_type_mapping *entry =
+			&adapter->mem_type_mapping_tbl[idx];
+
+		vfree(entry->mem_ptr);
+		entry->mem_ptr = NULL;
+		entry->mem_size = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(nxpwifi_prepare_fw_dump_info);
+
+/* cfg80211 network device handler for statistics retrieval.
+ */
+static struct net_device_stats *nxpwifi_get_stats(struct net_device *dev)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+
+	return &priv->stats;
+}
+
+static u16
+nxpwifi_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
+				struct net_device *sb_dev)
+{
+	skb->priority = cfg80211_classify8021d(skb, NULL);
+	return nxpwifi_1d_to_wmm_queue[skb->priority];
+}
+
+/* Network device handlers */
+static const struct net_device_ops nxpwifi_netdev_ops = {
+	.ndo_open = nxpwifi_open,
+	.ndo_stop = nxpwifi_close,
+	.ndo_start_xmit = nxpwifi_hard_start_xmit,
+	.ndo_set_mac_address = nxpwifi_ndo_set_mac_address,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_tx_timeout = nxpwifi_tx_timeout,
+	.ndo_get_stats = nxpwifi_get_stats,
+	.ndo_set_rx_mode = nxpwifi_set_multicast_list,
+	.ndo_select_queue = nxpwifi_netdev_select_wmm_queue,
+};
+
+/* This function initializes the private structure parameters.
+ *
+ * The following wait queues are initialized -
+ *      - IOCTL wait queue
+ *      - Command wait queue
+ *      - Statistics wait queue
+ *
+ * ...and the following default parameters are set -
+ *      - Current key index     : Set to 0
+ *      - Rate index            : Set to auto
+ *      - Media connected       : Set to disconnected
+ *      - Nick name             : Set to null
+ *      - Number of Tx timeout  : Set to 0
+ *      - Device address        : Set to current address
+ *      - Rx histogram statistc : Set to 0
+ *
+ * In addition, the CFG80211 work queue is also created.
+ */
+void nxpwifi_init_priv_params(struct nxpwifi_private *priv,
+			      struct net_device *dev)
+{
+	dev->netdev_ops = &nxpwifi_netdev_ops;
+	dev->needs_free_netdev = true;
+	/* Initialize private structure */
+	priv->current_key_index = 0;
+	priv->media_connected = false;
+	memset(priv->mgmt_ie, 0,
+	       sizeof(struct nxpwifi_ie) * MAX_MGMT_IE_INDEX);
+	priv->beacon_idx = NXPWIFI_AUTO_IDX_MASK;
+	priv->proberesp_idx = NXPWIFI_AUTO_IDX_MASK;
+	priv->assocresp_idx = NXPWIFI_AUTO_IDX_MASK;
+	priv->gen_idx = NXPWIFI_AUTO_IDX_MASK;
+	priv->num_tx_timeout = 0;
+	if (is_valid_ether_addr(dev->dev_addr))
+		ether_addr_copy(priv->curr_addr, dev->dev_addr);
+	else
+		ether_addr_copy(priv->curr_addr, priv->adapter->perm_addr);
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA ||
+	    GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->hist_data = kmalloc(sizeof(*priv->hist_data), GFP_KERNEL);
+		if (priv->hist_data)
+			nxpwifi_hist_data_reset(priv);
+	}
+}
+
+/* This function check if command is pending.
+ */
+int is_command_pending(struct nxpwifi_adapter *adapter)
+{
+	int is_cmd_pend_q_empty;
+
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+
+	return !is_cmd_pend_q_empty;
+}
+
+/* This is the host mlme work function.
+ * It handles the host mlme operations.
+ */
+static void nxpwifi_host_mlme_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct nxpwifi_adapter *adapter =
+		container_of(work, struct nxpwifi_adapter, host_mlme_work);
+	struct sk_buff *skb;
+	struct nxpwifi_rxinfo *rx_info;
+	struct nxpwifi_private *priv;
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags))
+		return;
+
+	while ((skb = skb_dequeue(&adapter->rx_mlme_q))) {
+		rx_info = NXPWIFI_SKB_RXCB(skb);
+		priv = adapter->priv[rx_info->bss_num];
+		cfg80211_rx_mlme_mgmt(priv->netdev,
+				      skb->data,
+				      rx_info->pkt_len);
+	}
+
+	/* Check for host mlme disconnection */
+	if (adapter->host_mlme_link_lost) {
+		if (adapter->priv_link_lost) {
+			nxpwifi_reset_connect_state(adapter->priv_link_lost,
+						    WLAN_REASON_DEAUTH_LEAVING,
+						    true);
+			adapter->priv_link_lost = NULL;
+		}
+		adapter->host_mlme_link_lost = false;
+	}
+
+	/* Check for host mlme Assoc Resp */
+	if (adapter->assoc_resp_received) {
+		nxpwifi_process_assoc_resp(adapter);
+		adapter->assoc_resp_received = false;
+	}
+}
+
+/* This is the RX work function.
+ *
+ * It handles the RX operations.
+ */
+static void nxpwifi_rx_work(struct work_struct *work)
+{
+	struct nxpwifi_adapter *adapter =
+		container_of(work, struct nxpwifi_adapter, rx_work);
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags))
+		return;
+	nxpwifi_process_rx(adapter);
+}
+
+/* This is the main work function.
+ *
+ * It handles the main process, which in turn handles the complete
+ * driver operations.
+ */
+static void nxpwifi_main_work(struct work_struct *work)
+{
+	struct nxpwifi_adapter *adapter =
+		container_of(work, struct nxpwifi_adapter, main_work);
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags))
+		return;
+	nxpwifi_main_process(adapter);
+}
+
+/* Common teardown code used for both device removal and reset */
+static void nxpwifi_uninit_sw(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	int i;
+
+	/* We can no longer handle interrupts once we start doing the teardown
+	 * below.
+	 */
+	if (adapter->if_ops.disable_int)
+		adapter->if_ops.disable_int(adapter);
+
+	set_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+	nxpwifi_terminate_workqueue(adapter);
+	adapter->int_status = 0;
+
+	/* Stop data */
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		if (priv->netdev) {
+			nxpwifi_stop_net_dev_queue(priv->netdev, adapter);
+			netif_carrier_off(priv->netdev);
+			netif_device_detach(priv->netdev);
+		}
+	}
+
+	nxpwifi_dbg(adapter, CMD, "cmd: calling nxpwifi_shutdown_drv...\n");
+	nxpwifi_shutdown_drv(adapter);
+	nxpwifi_dbg(adapter, CMD, "cmd: nxpwifi_shutdown_drv done\n");
+
+	if (atomic_read(&adapter->rx_pending) ||
+	    atomic_read(&adapter->tx_pending) ||
+	    atomic_read(&adapter->cmd_pending)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "rx_pending=%d, tx_pending=%d,\t"
+			    "cmd_pending=%d\n",
+			    atomic_read(&adapter->rx_pending),
+			    atomic_read(&adapter->tx_pending),
+			    atomic_read(&adapter->cmd_pending));
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		rtnl_lock();
+		if (priv->netdev &&
+		    priv->wdev.iftype != NL80211_IFTYPE_UNSPECIFIED) {
+			/* Close the netdev now, because if we do it later, the
+			 * netdev notifiers will need to acquire the wiphy lock
+			 * again --> deadlock.
+			 */
+			dev_close(priv->wdev.netdev);
+			wiphy_lock(adapter->wiphy);
+			nxpwifi_del_virtual_intf(adapter->wiphy, &priv->wdev);
+			wiphy_unlock(adapter->wiphy);
+		}
+		rtnl_unlock();
+	}
+
+	wiphy_unregister(adapter->wiphy);
+	wiphy_free(adapter->wiphy);
+	adapter->wiphy = NULL;
+
+	vfree(adapter->chan_stats);
+	nxpwifi_free_cmd_buffers(adapter);
+}
+
+/* This function can be used for shutting down the adapter SW.
+ */
+void nxpwifi_shutdown_sw(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+
+	if (!adapter)
+		return;
+
+	wait_for_completion(adapter->fw_done);
+	/* Caller should ensure we aren't suspending while this happens */
+	reinit_completion(adapter->fw_done);
+
+	priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+	nxpwifi_deauthenticate(priv, NULL);
+
+	nxpwifi_init_shutdown_fw(priv, NXPWIFI_FUNC_SHUTDOWN);
+
+	nxpwifi_uninit_sw(adapter);
+	adapter->is_up = false;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_shutdown_sw);
+
+/* This function can be used for reinitting the adapter SW. Required
+ * code is extracted from nxpwifi_add_card()
+ */
+int
+nxpwifi_reinit_sw(struct nxpwifi_adapter *adapter)
+{
+	int ret = 0;
+
+	nxpwifi_init_lock_list(adapter);
+	if (adapter->if_ops.up_dev)
+		adapter->if_ops.up_dev(adapter);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+	clear_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+	init_waitqueue_head(&adapter->init_wait_q);
+	clear_bit(NXPWIFI_IS_SUSPENDED, &adapter->work_flags);
+	adapter->hs_activated = false;
+	clear_bit(NXPWIFI_IS_CMD_TIMEDOUT, &adapter->work_flags);
+	init_waitqueue_head(&adapter->hs_activate_wait_q);
+	init_waitqueue_head(&adapter->cmd_wait_q.wait);
+	adapter->cmd_wait_q.status = 0;
+	adapter->scan_wait_q_woken = false;
+
+	if (num_possible_cpus() > 1)
+		adapter->rx_work_enabled = true;
+
+	adapter->workqueue =
+		alloc_workqueue("NXPWIFI_WORK_QUEUE",
+				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!adapter->workqueue) {
+		ret = -ENOMEM;
+		goto err_kmalloc;
+	}
+
+	INIT_WORK(&adapter->main_work, nxpwifi_main_work);
+
+	if (adapter->rx_work_enabled) {
+		adapter->rx_workqueue = alloc_workqueue("NXPWIFI_RX_WORK_QUEUE",
+							WQ_HIGHPRI |
+							WQ_MEM_RECLAIM |
+							WQ_UNBOUND, 0);
+		if (!adapter->rx_workqueue) {
+			ret = -ENOMEM;
+			goto err_kmalloc;
+		}
+		INIT_WORK(&adapter->rx_work, nxpwifi_rx_work);
+	}
+
+	wiphy_work_init(&adapter->host_mlme_work, nxpwifi_host_mlme_work);
+
+	/* Register the device. Fill up the private data structure with
+	 * relevant information from the card. Some code extracted from
+	 * nxpwifi_register_dev()
+	 */
+	nxpwifi_dbg(adapter, INFO, "%s, nxpwifi_init_hw_fw()...\n", __func__);
+
+	ret = nxpwifi_init_hw_fw(adapter, false);
+	if (ret) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: firmware init failed\n", __func__);
+		goto err_init_fw;
+	}
+
+	/* _nxpwifi_fw_dpc() does its own cleanup */
+	ret = _nxpwifi_fw_dpc(adapter->firmware, adapter);
+	if (ret) {
+		pr_err("Failed to bring up adapter: %d\n", ret);
+		return ret;
+	}
+	nxpwifi_dbg(adapter, INFO, "%s, successful\n", __func__);
+
+	return ret;
+
+err_init_fw:
+	nxpwifi_dbg(adapter, ERROR, "info: %s: unregister device\n", __func__);
+	if (adapter->if_ops.unregister_dev)
+		adapter->if_ops.unregister_dev(adapter);
+
+err_kmalloc:
+	set_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+	nxpwifi_terminate_workqueue(adapter);
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_READY) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "info: %s: shutdown nxpwifi\n", __func__);
+		nxpwifi_shutdown_drv(adapter);
+		nxpwifi_free_cmd_buffers(adapter);
+	}
+
+	complete_all(adapter->fw_done);
+	nxpwifi_dbg(adapter, INFO, "%s, error\n", __func__);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_reinit_sw);
+
+static irqreturn_t nxpwifi_irq_wakeup_handler(int irq, void *priv)
+{
+	struct nxpwifi_adapter *adapter = priv;
+
+	nxpwifi_dbg(adapter, INFO, "%s: wake by wifi", __func__);
+	adapter->wake_by_wifi = true;
+	disable_irq_nosync(irq);
+
+	/* Notify PM core we are wakeup source */
+	pm_wakeup_event(adapter->dev, 0);
+	pm_system_wakeup();
+
+	return IRQ_HANDLED;
+}
+
+static void nxpwifi_probe_of(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+	struct device *dev = adapter->dev;
+
+	if (!dev->of_node)
+		goto err_exit;
+
+	adapter->dt_node = dev->of_node;
+	adapter->irq_wakeup = irq_of_parse_and_map(adapter->dt_node, 0);
+	if (!adapter->irq_wakeup) {
+		nxpwifi_dbg(adapter, ERROR, "fail to parse irq_wakeup from device tree\n");
+		goto err_exit;
+	}
+
+	ret = devm_request_irq(dev, adapter->irq_wakeup,
+			       nxpwifi_irq_wakeup_handler,
+			       IRQF_TRIGGER_LOW | IRQF_NO_AUTOEN,
+			       "wifi_wake", adapter);
+	if (ret) {
+		nxpwifi_dbg(adapter, ERROR, "Failed to request irq_wakeup %d (%d)\n",
+			    adapter->irq_wakeup, ret);
+		goto err_exit;
+	}
+
+	if (device_init_wakeup(dev, true)) {
+		nxpwifi_dbg(adapter, ERROR, "fail to init wakeup for nxpwifi\n");
+		goto err_exit;
+	}
+	return;
+
+err_exit:
+	adapter->irq_wakeup = -1;
+}
+
+/* This function adds the card.
+ *
+ * This function follows the following major steps to set up the device -
+ *      - Initialize software. This includes probing the card, registering
+ *        the interface operations table, and allocating/initializing the
+ *        adapter structure
+ *      - Set up the netlink socket
+ *      - Create and start the main work queue
+ *      - Register the device
+ *      - Initialize firmware and hardware
+ *      - Add logical interfaces
+ */
+int
+nxpwifi_add_card(void *card, struct completion *fw_done,
+		 struct nxpwifi_if_ops *if_ops, u8 iface_type,
+		 struct device *dev)
+{
+	struct nxpwifi_adapter *adapter;
+	int ret = 0;
+
+	adapter = nxpwifi_register(card, dev, if_ops);
+	if (IS_ERR(adapter)) {
+		ret = PTR_ERR(adapter);
+		pr_err("%s: adapter register failed %d\n", __func__, ret);
+		goto err_init_sw;
+	}
+
+	nxpwifi_probe_of(adapter);
+
+	adapter->iface_type = iface_type;
+	adapter->fw_done = fw_done;
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+	clear_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+	init_waitqueue_head(&adapter->init_wait_q);
+	clear_bit(NXPWIFI_IS_SUSPENDED, &adapter->work_flags);
+	adapter->hs_activated = false;
+	init_waitqueue_head(&adapter->hs_activate_wait_q);
+	init_waitqueue_head(&adapter->cmd_wait_q.wait);
+	adapter->cmd_wait_q.status = 0;
+	adapter->scan_wait_q_woken = false;
+
+	if (num_possible_cpus() > 1)
+		adapter->rx_work_enabled = true;
+
+	adapter->workqueue =
+		alloc_workqueue("NXPWIFI_WORK_QUEUE",
+				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!adapter->workqueue) {
+		ret = -ENOMEM;
+		goto err_kmalloc;
+	}
+
+	INIT_WORK(&adapter->main_work, nxpwifi_main_work);
+
+	if (adapter->rx_work_enabled) {
+		adapter->rx_workqueue = alloc_workqueue("NXPWIFI_RX_WORK_QUEUE",
+							WQ_HIGHPRI |
+							WQ_MEM_RECLAIM |
+							WQ_UNBOUND, 0);
+		if (!adapter->rx_workqueue) {
+			ret = -ENOMEM;
+			goto err_kmalloc;
+		}
+
+		INIT_WORK(&adapter->rx_work, nxpwifi_rx_work);
+	}
+
+	wiphy_work_init(&adapter->host_mlme_work, nxpwifi_host_mlme_work);
+
+	/* Register the device. Fill up the private data structure with relevant
+	 * information from the card.
+	 */
+	ret = adapter->if_ops.register_dev(adapter);
+	if (ret) {
+		pr_err("%s: failed to register nxpwifi device\n", __func__);
+		goto err_registerdev;
+	}
+
+	ret = nxpwifi_init_hw_fw(adapter, true);
+	if (ret) {
+		pr_err("%s: firmware init failed\n", __func__);
+		goto err_init_fw;
+	}
+
+	return ret;
+
+err_init_fw:
+	pr_debug("info: %s: unregister device\n", __func__);
+	if (adapter->if_ops.unregister_dev)
+		adapter->if_ops.unregister_dev(adapter);
+err_registerdev:
+	set_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+	nxpwifi_terminate_workqueue(adapter);
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_READY) {
+		pr_debug("info: %s: shutdown nxpwifi\n", __func__);
+		nxpwifi_shutdown_drv(adapter);
+		nxpwifi_free_cmd_buffers(adapter);
+	}
+err_kmalloc:
+	if (adapter->irq_wakeup >= 0)
+		device_init_wakeup(adapter->dev, false);
+	nxpwifi_free_adapter(adapter);
+
+err_init_sw:
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_add_card);
+
+/* This function removes the card.
+ *
+ * This function follows the following major steps to remove the device -
+ *      - Stop data traffic
+ *      - Shutdown firmware
+ *      - Remove the logical interfaces
+ *      - Terminate the work queue
+ *      - Unregister the device
+ *      - Free the adapter structure
+ */
+void nxpwifi_remove_card(struct nxpwifi_adapter *adapter)
+{
+	if (!adapter)
+		return;
+
+	if (adapter->is_up)
+		nxpwifi_uninit_sw(adapter);
+
+	if (adapter->irq_wakeup >= 0)
+		device_init_wakeup(adapter->dev, false);
+
+	/* Unregister device */
+	nxpwifi_dbg(adapter, INFO,
+		    "info: unregister device\n");
+	if (adapter->if_ops.unregister_dev)
+		adapter->if_ops.unregister_dev(adapter);
+	/* Free adapter structure */
+	nxpwifi_dbg(adapter, INFO,
+		    "info: free adapter\n");
+	nxpwifi_free_adapter(adapter);
+}
+EXPORT_SYMBOL_GPL(nxpwifi_remove_card);
+
+void _nxpwifi_dbg(const struct nxpwifi_adapter *adapter, int mask,
+		  const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (!(adapter->debug_mask & mask))
+		return;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (adapter->dev)
+		nxpwifi_dbg(adapter, INFO, "%pV", &vaf);
+	else
+		pr_info("%pV", &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(_nxpwifi_dbg);
+
+/* This function initializes the module.
+ *
+ * The debug FS is also initialized if configured.
+ */
+static int
+nxpwifi_init_module(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	nxpwifi_debugfs_init();
+#endif
+	return 0;
+}
+
+/* This function cleans up the module.
+ *
+ * The debug FS is removed if available.
+ */
+static void
+nxpwifi_cleanup_module(void)
+{
+#ifdef CONFIG_DEBUG_FS
+	nxpwifi_debugfs_remove();
+#endif
+}
+
+module_init(nxpwifi_init_module);
+module_exit(nxpwifi_cleanup_module);
+
+MODULE_AUTHOR("NXP International Ltd.");
+MODULE_DESCRIPTION("NXP WiFi Driver version " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/wireless/nxp/nxpwifi/main.h b/drivers/net/wireless/nxp/nxpwifi/main.h
new file mode 100644
index 000000000000..07f64794eee5
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/main.h
@@ -0,0 +1,1836 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: major data structures and prototypes
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_MAIN_H_
+#define _NXPWIFI_MAIN_H_
+
+#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/ip.h>
+#include <linux/skbuff.h>
+#include <linux/if_arp.h>
+#include <linux/etherdevice.h>
+#include <net/sock.h>
+#include <linux/vmalloc.h>
+#include <linux/firmware.h>
+#include <linux/ctype.h>
+#include <linux/of.h>
+#include <linux/idr.h>
+#include <linux/inetdevice.h>
+#include <linux/devcoredump.h>
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/of_irq.h>
+#include <linux/workqueue.h>
+#include <net/ieee80211_radiotap.h>
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "sdio.h"
+
+extern char driver_version[];
+
+struct nxpwifi_adapter;
+struct nxpwifi_private;
+
+enum {
+	NXPWIFI_ASYNC_CMD,
+	NXPWIFI_SYNC_CMD
+};
+
+#define NXPWIFI_MAX_AP				64
+
+#define NXPWIFI_MAX_PKTS_TXQ			16
+
+#define NXPWIFI_DEFAULT_WATCHDOG_TIMEOUT	(5 * HZ)
+
+#define NXPWIFI_TIMER_10S			10000
+#define NXPWIFI_TIMER_1S			1000
+
+#define MAX_TX_PENDING      400
+#define LOW_TX_PENDING      380
+
+#define HIGH_RX_PENDING     50
+#define LOW_RX_PENDING      20
+
+#define NXPWIFI_UPLD_SIZE               (2312)
+
+#define MAX_EVENT_SIZE                  2048
+
+#define NXPWIFI_FW_DUMP_SIZE       (2 * 1024 * 1024)
+
+#define ARP_FILTER_MAX_BUF_SIZE         68
+
+#define NXPWIFI_KEY_BUFFER_SIZE			16
+#define NXPWIFI_DEFAULT_LISTEN_INTERVAL 10
+#define NXPWIFI_MAX_REGION_CODE         9
+
+#define DEFAULT_BCN_AVG_FACTOR          8
+#define DEFAULT_DATA_AVG_FACTOR         8
+
+#define FIRST_VALID_CHANNEL				0xff
+
+#define DEFAULT_BCN_MISS_TIMEOUT		5
+
+#define MAX_SCAN_BEACON_BUFFER			8000
+
+#define SCAN_BEACON_ENTRY_PAD			6
+
+#define NXPWIFI_PASSIVE_SCAN_CHAN_TIME	110
+#define NXPWIFI_ACTIVE_SCAN_CHAN_TIME	40
+#define NXPWIFI_SPECIFIC_SCAN_CHAN_TIME	40
+#define NXPWIFI_DEF_SCAN_CHAN_GAP_TIME  50
+
+#define SCAN_RSSI(RSSI)					(0x100 - ((u8)(RSSI)))
+
+#define NXPWIFI_MAX_TOTAL_SCAN_TIME	(NXPWIFI_TIMER_10S - NXPWIFI_TIMER_1S)
+
+#define WPA_GTK_OUI_OFFSET				2
+#define RSN_GTK_OUI_OFFSET				2
+
+#define NXPWIFI_OUI_NOT_PRESENT			0
+#define NXPWIFI_OUI_PRESENT				1
+
+#define PKT_TYPE_MGMT	0xE5
+#define PKT_TYPE_802DOT11 0x05
+
+/* Do not check for data_received for USB, as data_received
+ * is handled in nxpwifi_usb_recv for USB
+ */
+#define IS_CARD_RX_RCVD(adapter) ({ \
+	typeof(adapter) (_adapter) = adapter; \
+	((_adapter)->cmd_resp_received || \
+	 (_adapter)->event_received || \
+	 (_adapter)->data_received); \
+	})
+
+#define NXPWIFI_TYPE_DATA			0
+#define NXPWIFI_TYPE_CMD			1
+#define NXPWIFI_TYPE_EVENT			3
+#define NXPWIFI_TYPE_VDLL			4
+#define NXPWIFI_TYPE_AGGR_DATA			10
+
+#define MAX_BITMAP_RATES_SIZE			18
+
+#define MAX_CHANNEL_BAND_BG     14
+#define MAX_CHANNEL_BAND_A      165
+
+#define MAX_FREQUENCY_BAND_BG   2484
+
+#define NXPWIFI_EVENT_HEADER_LEN           4
+#define NXPWIFI_UAP_EVENT_EXTRA_HEADER	   2
+
+#define NXPWIFI_TYPE_LEN			4
+#define NXPWIFI_USB_TYPE_CMD			0xF00DFACE
+#define NXPWIFI_USB_TYPE_DATA			0xBEADC0DE
+#define NXPWIFI_USB_TYPE_EVENT			0xBEEFFACE
+
+/* Threshold for tx_timeout_cnt before we trigger a card reset */
+#define TX_TIMEOUT_THRESHOLD	6
+
+#define NXPWIFI_DRV_INFO_SIZE_MAX 0x40000
+
+/* Address alignment */
+#define NXPWIFI_ALIGN_ADDR(p, a) ({ \
+	typeof(a) (_a) = a; \
+	(((long)(p) + (_a) - 1) & ~((_a) - 1)); \
+	})
+
+#define NXPWIFI_MAC_LOCAL_ADMIN_BIT		41
+
+/* BIT value */
+#define MBIT(x)    (((u32)1) << (x))
+
+/**
+ *enum nxpwifi_debug_level  -  nxp wifi debug level
+ */
+enum NXPWIFI_DEBUG_LEVEL {
+	NXPWIFI_DBG_MSG		= 0x00000001,
+	NXPWIFI_DBG_FATAL	= 0x00000002,
+	NXPWIFI_DBG_ERROR	= 0x00000004,
+	NXPWIFI_DBG_DATA	= 0x00000008,
+	NXPWIFI_DBG_CMD		= 0x00000010,
+	NXPWIFI_DBG_EVENT	= 0x00000020,
+	NXPWIFI_DBG_INTR	= 0x00000040,
+	NXPWIFI_DBG_IOCTL	= 0x00000080,
+
+	NXPWIFI_DBG_MPA_D	= 0x00008000,
+	NXPWIFI_DBG_DAT_D	= 0x00010000,
+	NXPWIFI_DBG_CMD_D	= 0x00020000,
+	NXPWIFI_DBG_EVT_D	= 0x00040000,
+	NXPWIFI_DBG_FW_D	= 0x00080000,
+	NXPWIFI_DBG_IF_D	= 0x00100000,
+
+	NXPWIFI_DBG_ENTRY	= 0x10000000,
+	NXPWIFI_DBG_WARN	= 0x20000000,
+	NXPWIFI_DBG_INFO	= 0x40000000,
+	NXPWIFI_DBG_DUMP	= 0x80000000,
+
+	NXPWIFI_DBG_ANY		= 0xffffffff
+};
+
+#define NXPWIFI_DEFAULT_DEBUG_MASK	(NXPWIFI_DBG_MSG | \
+					NXPWIFI_DBG_FATAL | \
+					NXPWIFI_DBG_ERROR)
+
+__printf(3, 4)
+void _nxpwifi_dbg(const struct nxpwifi_adapter *adapter, int mask,
+		  const char *fmt, ...);
+#define nxpwifi_dbg(adapter, mask, fmt, ...)				\
+	_nxpwifi_dbg(adapter, NXPWIFI_DBG_##mask, fmt, ##__VA_ARGS__)
+
+#define DEBUG_DUMP_DATA_MAX_LEN		128
+#define nxpwifi_dbg_dump(adapter, dbg_mask, str, buf, len)	\
+do {								\
+	if ((adapter)->debug_mask & NXPWIFI_DBG_##dbg_mask)	\
+		print_hex_dump(KERN_DEBUG, str,			\
+			       DUMP_PREFIX_OFFSET, 16, 1,	\
+			       buf, len, false);		\
+} while (0)
+
+/** Min BGSCAN interval 15 second */
+#define NXPWIFI_BGSCAN_INTERVAL 15000
+/** default repeat count */
+#define NXPWIFI_BGSCAN_REPEAT_COUNT 6
+
+struct nxpwifi_dbg {
+	u32 num_cmd_host_to_card_failure;
+	u32 num_cmd_sleep_cfm_host_to_card_failure;
+	u32 num_tx_host_to_card_failure;
+	u32 num_event_deauth;
+	u32 num_event_disassoc;
+	u32 num_event_link_lost;
+	u32 num_cmd_deauth;
+	u32 num_cmd_assoc_success;
+	u32 num_cmd_assoc_failure;
+	u32 num_tx_timeout;
+	u16 timeout_cmd_id;
+	u16 timeout_cmd_act;
+	u16 last_cmd_id[DBG_CMD_NUM];
+	u16 last_cmd_act[DBG_CMD_NUM];
+	u16 last_cmd_index;
+	u16 last_cmd_resp_id[DBG_CMD_NUM];
+	u16 last_cmd_resp_index;
+	u16 last_event[DBG_CMD_NUM];
+	u16 last_event_index;
+	u32 last_mp_wr_bitmap[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_wr_ports[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_wr_len[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_curr_wr_port[NXPWIFI_DBG_SDIO_MP_NUM];
+	u8 last_sdio_mp_index;
+};
+
+enum NXPWIFI_HARDWARE_STATUS {
+	NXPWIFI_HW_STATUS_READY,
+	NXPWIFI_HW_STATUS_INITIALIZING,
+	NXPWIFI_HW_STATUS_INIT_DONE,
+	NXPWIFI_HW_STATUS_RESET,
+	NXPWIFI_HW_STATUS_NOT_READY
+};
+
+enum NXPWIFI_802_11_POWER_MODE {
+	NXPWIFI_802_11_POWER_MODE_CAM,
+	NXPWIFI_802_11_POWER_MODE_PSP
+};
+
+struct nxpwifi_tx_param {
+	u32 next_pkt_len;
+};
+
+enum NXPWIFI_PS_STATE {
+	PS_STATE_AWAKE,
+	PS_STATE_PRE_SLEEP,
+	PS_STATE_SLEEP_CFM,
+	PS_STATE_SLEEP
+};
+
+enum nxpwifi_iface_type {
+	NXPWIFI_SDIO
+};
+
+struct nxpwifi_add_ba_param {
+	u32 tx_win_size;
+	u32 rx_win_size;
+	u32 timeout;
+	u8 tx_amsdu;
+	u8 rx_amsdu;
+};
+
+struct nxpwifi_tx_aggr {
+	u8 ampdu_user;
+	u8 ampdu_ap;
+	u8 amsdu;
+};
+
+enum nxpwifi_ba_status {
+	BA_SETUP_NONE = 0,
+	BA_SETUP_INPROGRESS,
+	BA_SETUP_COMPLETE
+};
+
+struct nxpwifi_ra_list_tbl {
+	struct list_head list;
+	struct sk_buff_head skb_head;
+	u8 ra[ETH_ALEN];
+	u32 is_11n_enabled;
+	u16 max_amsdu;
+	u16 ba_pkt_count;
+	u8 ba_packet_thr;
+	enum nxpwifi_ba_status ba_status;
+	u8 amsdu_in_ampdu;
+	u16 total_pkt_count;
+	bool tx_paused;
+};
+
+struct nxpwifi_tid_tbl {
+	struct list_head ra_list;
+};
+
+#define WMM_HIGHEST_PRIORITY		7
+#define HIGH_PRIO_TID				7
+#define LOW_PRIO_TID				0
+#define NO_PKT_PRIO_TID				-1
+#define NXPWIFI_WMM_DRV_DELAY_MAX 510
+
+struct nxpwifi_wmm_desc {
+	struct nxpwifi_tid_tbl tid_tbl_ptr[MAX_NUM_TID];
+	u32 packets_out[MAX_NUM_TID];
+	u32 pkts_paused[MAX_NUM_TID];
+	/* spin lock to protect ra_list */
+	spinlock_t ra_list_spinlock;
+	struct nxpwifi_wmm_ac_status ac_status[IEEE80211_NUM_ACS];
+	enum nxpwifi_wmm_ac_e ac_down_graded_vals[IEEE80211_NUM_ACS];
+	u32 drv_pkt_delay_max;
+	u8 queue_priority[IEEE80211_NUM_ACS];
+	u32 user_pri_pkt_tx_ctrl[WMM_HIGHEST_PRIORITY + 1];	/* UP: 0 to 7 */
+	/* Number of transmit packets queued */
+	atomic_t tx_pkts_queued;
+	/* Tracks highest priority with a packet queued */
+	atomic_t highest_queued_prio;
+};
+
+struct nxpwifi_802_11_security {
+	u8 wpa_enabled;
+	u8 wpa2_enabled;
+	u8 wep_enabled;
+	u32 authentication_mode;
+	u8 is_authtype_auto;
+	u32 encryption_mode;
+};
+
+struct ieee_types_vendor_specific {
+	struct ieee80211_vendor_ie vend_hdr;
+	u8 data[IEEE_MAX_IE_SIZE - sizeof(struct ieee80211_vendor_ie)];
+} __packed;
+
+struct nxpwifi_bssdescriptor {
+	u8 mac_address[ETH_ALEN];
+	struct cfg80211_ssid ssid;
+	u32 privacy;
+	s32 rssi;
+	u32 channel;
+	u32 freq;
+	u16 beacon_period;
+	u8 erp_flags;
+	u32 bss_mode;
+	u8 supported_rates[NXPWIFI_SUPPORTED_RATES];
+	u8 data_rates[NXPWIFI_SUPPORTED_RATES];
+	u16 bss_band;
+	u64 fw_tsf;
+	u64 timestamp;
+	union ieee_types_phy_param_set phy_param_set;
+	struct ieee_types_cf_param_set cf_param_set;
+	u16 cap_info_bitmap;
+	struct ieee80211_wmm_param_ie wmm_ie;
+	u8 disable_11n;
+	struct ieee80211_ht_cap *bcn_ht_cap;
+	u16 ht_cap_offset;
+	struct ieee80211_ht_operation *bcn_ht_oper;
+	u16 ht_info_offset;
+	u8 *bcn_bss_co_2040;
+	u16 bss_co_2040_offset;
+	u8 *bcn_ext_cap;
+	u16 ext_cap_offset;
+	struct ieee80211_vht_cap *bcn_vht_cap;
+	u16 vht_cap_offset;
+	struct ieee80211_vht_operation *bcn_vht_oper;
+	u16 vht_info_offset;
+	struct ieee_types_oper_mode_ntf *oper_mode;
+	u16 oper_mode_offset;
+	u8 disable_11ac;
+	struct ieee80211_he_cap_elem *bcn_he_cap;
+	u16 he_cap_offset;
+	struct ieee80211_he_operation *bcn_he_oper;
+	u16 he_info_offset;
+	u8 disable_11ax;
+	struct ieee_types_vendor_specific *bcn_wpa_ie;
+	u16 wpa_offset;
+	struct element *bcn_rsn_ie;
+	u16 rsn_offset;
+	struct element *bcn_rsnx_ie;
+	u16 rsnx_offset;
+	u8 *beacon_buf;
+	u32 beacon_buf_size;
+	u8 sensed_11h;
+	u8 local_constraint;
+	u8 chan_sw_ie_present;
+};
+
+struct nxpwifi_current_bss_params {
+	struct nxpwifi_bssdescriptor bss_descriptor;
+	u8 wmm_enabled;
+	u8 wmm_uapsd_enabled;
+	u8 band;
+	u32 num_of_rates;
+	u8 data_rates[NXPWIFI_SUPPORTED_RATES];
+};
+
+struct nxpwifi_sleep_period {
+	u16 period;
+	u16 reserved;
+};
+
+struct nxpwifi_wep_key {
+	u32 length;
+	u32 key_index;
+	u32 key_length;
+	u8 key_material[NXPWIFI_KEY_BUFFER_SIZE];
+};
+
+#define MAX_REGION_CHANNEL_NUM  2
+
+struct nxpwifi_chan_freq_power {
+	u16 channel;
+	u32 freq;
+	u16 max_tx_power;
+	u8 unsupported;
+};
+
+enum state_11d_t {
+	DISABLE_11D = 0,
+	ENABLE_11D = 1,
+};
+
+#define NXPWIFI_MAX_TRIPLET_802_11D		83
+
+struct nxpwifi_802_11d_domain_reg {
+	u8 dfs_region;
+	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
+	u8 no_of_triplet;
+	struct ieee80211_country_ie_triplet
+		triplet[NXPWIFI_MAX_TRIPLET_802_11D];
+};
+
+struct nxpwifi_vendor_spec_cfg_ie {
+	u16 mask;
+	u16 flag;
+	u8 ie[NXPWIFI_MAX_VSIE_LEN];
+};
+
+struct wps {
+	u8 session_enable;
+};
+
+struct nxpwifi_roc_cfg {
+	u64 cookie;
+	struct ieee80211_channel chan;
+};
+
+enum nxpwifi_iface_work_flags {
+	NXPWIFI_IFACE_WORK_DEVICE_DUMP,
+	NXPWIFI_IFACE_WORK_CARD_RESET,
+};
+
+enum nxpwifi_adapter_work_flags {
+	NXPWIFI_SURPRISE_REMOVED,
+	NXPWIFI_IS_CMD_TIMEDOUT,
+	NXPWIFI_IS_SUSPENDED,
+	NXPWIFI_IS_HS_CONFIGURED,
+	NXPWIFI_IS_HS_ENABLING,
+	NXPWIFI_IS_REQUESTING_FW_VEREXT,
+};
+
+struct nxpwifi_band_config {
+	u8 chan_band:2;
+	u8 chan_width:2;
+	u8 chan2_offset:2;
+	u8 scan_mode:2;
+} __packed;
+
+struct nxpwifi_channel_band {
+	struct nxpwifi_band_config band_config;
+	u8 channel;
+};
+
+struct nxpwifi_private {
+	struct nxpwifi_adapter *adapter;
+	u8 bss_type;
+	u8 bss_role;
+	u8 bss_priority;
+	u8 bss_num;
+	u8 bss_started;
+	u8 auth_flag;
+	u16 auth_alg;
+	u8 frame_type;
+	u8 curr_addr[ETH_ALEN];
+	u8 media_connected;
+	u8 port_open;
+	u8 usb_port;
+	u32 num_tx_timeout;
+	/* track consecutive timeout */
+	u8 tx_timeout_cnt;
+	struct net_device *netdev;
+	struct net_device_stats stats;
+	u32 curr_pkt_filter;
+	u32 bss_mode;
+	u32 pkt_tx_ctrl;
+	u16 tx_power_level;
+	u8 max_tx_power_level;
+	u8 min_tx_power_level;
+	u32 tx_ant;
+	u32 rx_ant;
+	u8 tx_rate;
+	u8 tx_htinfo;
+	u8 rxpd_htinfo;
+	u8 rxpd_rate;
+	u16 rate_bitmap;
+	u16 bitmap_rates[MAX_BITMAP_RATES_SIZE];
+	u32 data_rate;
+	u8 is_data_rate_auto;
+	u16 bcn_avg_factor;
+	u16 data_avg_factor;
+	s16 data_rssi_last;
+	s16 data_nf_last;
+	s16 data_rssi_avg;
+	s16 data_nf_avg;
+	s16 bcn_rssi_last;
+	s16 bcn_nf_last;
+	s16 bcn_rssi_avg;
+	s16 bcn_nf_avg;
+	struct nxpwifi_bssdescriptor *attempted_bss_desc;
+	struct cfg80211_ssid prev_ssid;
+	u8 prev_bssid[ETH_ALEN];
+	struct nxpwifi_current_bss_params curr_bss_params;
+	u16 beacon_period;
+	u8 dtim_period;
+	u16 listen_interval;
+	u16 atim_window;
+	struct nxpwifi_802_11_security sec_info;
+	struct nxpwifi_wep_key wep_key[NUM_WEP_KEYS];
+	u16 wep_key_curr_index;
+	u8 wpa_ie[256];
+	u16 wpa_ie_len;
+	u8 wpa_is_gtk_set;
+	struct host_cmd_ds_802_11_key_material aes_key;
+	u8 *wps_ie;
+	u16 wps_ie_len;
+	u8 wmm_required;
+	u8 wmm_enabled;
+	u8 wmm_qosinfo;
+	struct nxpwifi_wmm_desc wmm;
+	atomic_t wmm_tx_pending[IEEE80211_NUM_ACS];
+	struct list_head sta_list;
+	/* spin lock for associated station list */
+	spinlock_t sta_list_spinlock;
+	struct list_head tx_ba_stream_tbl_ptr[MAX_NUM_TID];
+	/* spin lock for tx_ba_stream_tbl_ptr queue */
+	struct spinlock tx_ba_stream_tbl_lock[MAX_NUM_TID];
+	struct nxpwifi_tx_aggr aggr_prio_tbl[MAX_NUM_TID];
+	struct nxpwifi_add_ba_param add_ba_param;
+	u16 rx_seq[MAX_NUM_TID];
+	u8 tos_to_tid_inv[MAX_NUM_TID];
+	struct list_head rx_reorder_tbl_ptr[MAX_NUM_TID];
+	/* spin lock for rx_reorder_tbl_ptr queue */
+	struct spinlock rx_reorder_tbl_lock[MAX_NUM_TID];
+#define NXPWIFI_ASSOC_RSP_BUF_SIZE  500
+	u8 assoc_rsp_buf[NXPWIFI_ASSOC_RSP_BUF_SIZE];
+	u32 assoc_rsp_size;
+	struct cfg80211_bss *req_bss;
+
+#define NXPWIFI_GENIE_BUF_SIZE      256
+	u8 gen_ie_buf[NXPWIFI_GENIE_BUF_SIZE];
+	u8 gen_ie_buf_len;
+
+	struct nxpwifi_vendor_spec_cfg_ie vs_ie[NXPWIFI_MAX_VSIE_NUM];
+
+#define NXPWIFI_ASSOC_TLV_BUF_SIZE  256
+	u8 assoc_tlv_buf[NXPWIFI_ASSOC_TLV_BUF_SIZE];
+	u8 assoc_tlv_buf_len;
+
+	u8 *curr_bcn_buf;
+	u32 curr_bcn_size;
+	/* spin lock for beacon buffer */
+	spinlock_t curr_bcn_buf_lock;
+	struct wireless_dev wdev;
+	struct nxpwifi_chan_freq_power cfp;
+	u32 versionstrsel;
+	char version_str[NXPWIFI_VERSION_STR_LENGTH];
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dfs_dev_dir;
+#endif
+	u16 current_key_index;
+	struct cfg80211_scan_request *scan_request;
+	u8 cfg_bssid[6];
+	struct wps wps;
+	u8 scan_block;
+	s32 cqm_rssi_thold;
+	u32 cqm_rssi_hyst;
+	u8 subsc_evt_rssi_state;
+	struct nxpwifi_ds_misc_subsc_evt async_subsc_evt_storage;
+	struct nxpwifi_ie mgmt_ie[MAX_MGMT_IE_INDEX];
+	u16 beacon_idx;
+	u16 proberesp_idx;
+	u16 assocresp_idx;
+	u16 gen_idx;
+	u8 ap_11n_enabled;
+	u8 ap_11ac_enabled;
+	u8 ap_11ax_enabled;
+	u16 config_bands;
+	/* 11AX */
+	u8 user_he_cap_len;
+	u8 user_he_cap[HE_CAP_MAX_SIZE];
+	u8 user_2g_he_cap_len;
+	u8 user_2g_he_cap[HE_CAP_MAX_SIZE];
+	bool host_mlme_reg;
+	u32 mgmt_frame_mask;
+	struct nxpwifi_roc_cfg roc_cfg;
+	bool scan_aborting;
+	u8 sched_scanning;
+	u8 csa_chan;
+	unsigned long csa_expire_time;
+	u8 del_list_idx;
+	bool hs2_enabled;
+	struct nxpwifi_uap_bss_param bss_cfg;
+	struct cfg80211_chan_def bss_chandef;
+	struct station_parameters *sta_params;
+	struct idr ack_status_frames;
+	/* spin lock for ack status */
+	spinlock_t ack_status_lock;
+	/** rx histogram data */
+	struct nxpwifi_histogram_data *hist_data;
+	struct cfg80211_chan_def dfs_chandef;
+	struct wiphy_work reset_conn_state_work;
+	struct wiphy_delayed_work dfs_cac_work;
+	struct wiphy_delayed_work dfs_chan_sw_work;
+	bool uap_stop_tx;
+	struct cfg80211_ap_update ap_update_info;
+	struct nxpwifi_11h_intf_state state_11h;
+	struct nxpwifi_ds_mem_rw mem_rw;
+	struct sk_buff_head bypass_txq;
+	struct nxpwifi_user_scan_chan hidden_chan[NXPWIFI_USER_SCAN_CHAN_MAX];
+	u8 assoc_resp_ht_param;
+	bool ht_param_present;
+	u16 last_deauth_reason;
+};
+
+struct nxpwifi_tx_ba_stream_tbl {
+	struct list_head list;
+	struct rcu_head rcu;
+	int tid;
+	u8 ra[ETH_ALEN];
+	enum nxpwifi_ba_status ba_status;
+	u8 amsdu;
+};
+
+struct nxpwifi_rx_reorder_tbl;
+
+struct reorder_tmr_cnxt {
+	struct timer_list timer;
+	struct nxpwifi_rx_reorder_tbl *ptr;
+	struct nxpwifi_private *priv;
+	u8 timer_is_set;
+};
+
+struct nxpwifi_rx_reorder_tbl {
+	struct list_head list;
+	struct list_head tmp_list;
+	struct rcu_head rcu;
+	int tid;
+	u8 ta[ETH_ALEN];
+	int init_win;
+	int start_win;
+	int win_size;
+	void **rx_reorder_ptr;
+	struct reorder_tmr_cnxt timer_context;
+	u8 amsdu;
+	u8 flags;
+};
+
+struct nxpwifi_bss_prio_node {
+	struct list_head list;
+	struct nxpwifi_private *priv;
+};
+
+struct nxpwifi_bss_prio_tbl {
+	struct list_head bss_prio_head;
+	/* spin lock for bss priority  */
+	spinlock_t bss_prio_lock;
+	struct nxpwifi_bss_prio_node *bss_prio_cur;
+};
+
+struct cmd_ctrl_node {
+	struct list_head list;
+	struct nxpwifi_private *priv;
+	u32 cmd_no;
+	u32 cmd_flag;
+	struct sk_buff *cmd_skb;
+	struct sk_buff *resp_skb;
+	void *data_buf;
+	u32 wait_q_enabled;
+	struct sk_buff *skb;
+	u8 *condition;
+	u8 cmd_wait_q_woken;
+	int (*cmd_resp)(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			u16 cmdresp_no,
+			void *data_buf);
+};
+
+struct nxpwifi_bss_priv {
+	u16 band;
+	u64 fw_tsf;
+};
+
+struct nxpwifi_station_stats {
+	u64 last_rx;
+	s8 rssi;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u32 rx_packets;
+	u32 tx_packets;
+	u32 tx_failed;
+	u8 last_tx_rate;
+	u8 last_tx_htinfo;
+};
+
+/* This is AP specific structure which stores information
+ * about associated/peer STA
+ */
+struct nxpwifi_sta_node {
+	struct list_head list;
+	struct rcu_head rcu;
+	u8 mac_addr[ETH_ALEN];
+	u8 is_wmm_enabled;
+	u8 is_11n_enabled;
+	u8 is_11ac_enabled;
+	u8 is_11ax_enabled;
+	u8 ampdu_sta[MAX_NUM_TID];
+	u16 rx_seq[MAX_NUM_TID];
+	u16 max_amsdu;
+	struct nxpwifi_station_stats stats;
+	u8 tx_pause;
+};
+
+#define NXPWIFI_TYPE_AGGR_DATA_V2 11
+#define NXPWIFI_BUS_AGGR_MODE_LEN_V2 (2)
+#define NXPWIFI_BUS_AGGR_MAX_LEN 16000
+#define NXPWIFI_BUS_AGGR_MAX_NUM 10
+struct bus_aggr_params {
+	u16 enable;
+	u16 mode;
+	u16 tx_aggr_max_size;
+	u16 tx_aggr_max_num;
+	u16 tx_aggr_align;
+};
+
+struct vdll_dnld_ctrl {
+	u8 *pending_block;
+	u16 pending_block_len;
+	u8 *vdll_mem;
+	u32 vdll_len;
+	struct sk_buff *skb;
+};
+
+struct nxpwifi_if_ops {
+	int (*init_if)(struct nxpwifi_adapter *adapter);
+	void (*cleanup_if)(struct nxpwifi_adapter *adapter);
+	int (*check_fw_status)(struct nxpwifi_adapter *adapter, u32 poll_num);
+	int (*check_winner_status)(struct nxpwifi_adapter *adapter);
+	int (*prog_fw)(struct nxpwifi_adapter *adapter,
+		       struct nxpwifi_fw_image *fw);
+	int (*register_dev)(struct nxpwifi_adapter *adapter);
+	void (*unregister_dev)(struct nxpwifi_adapter *adapter);
+	int (*enable_int)(struct nxpwifi_adapter *adapter);
+	void (*disable_int)(struct nxpwifi_adapter *adapter);
+	int (*process_int_status)(struct nxpwifi_adapter *adapter, u8 istat);
+	int (*host_to_card)(struct nxpwifi_adapter *adapter, u8 type,
+			    struct sk_buff *skb,
+			    struct nxpwifi_tx_param *tx_param);
+	int (*wakeup)(struct nxpwifi_adapter *adapter);
+	int (*wakeup_complete)(struct nxpwifi_adapter *adapter);
+
+	/* Interface specific functions */
+	void (*update_mp_end_port)(struct nxpwifi_adapter *adapter, u16 port);
+	void (*cleanup_mpa_buf)(struct nxpwifi_adapter *adapter);
+	int (*cmdrsp_complete)(struct nxpwifi_adapter *adapter,
+			       struct sk_buff *skb);
+	int (*event_complete)(struct nxpwifi_adapter *adapter,
+			      struct sk_buff *skb);
+	int (*dnld_fw)(struct nxpwifi_adapter *adapter,
+		       struct nxpwifi_fw_image *fw);
+	void (*card_reset)(struct nxpwifi_adapter *adapter);
+	int (*reg_dump)(struct nxpwifi_adapter *adapter, char *drv_buf);
+	void (*device_dump)(struct nxpwifi_adapter *adapter);
+	void (*deaggr_pkt)(struct nxpwifi_adapter *adapter,
+			   struct sk_buff *skb);
+	void (*up_dev)(struct nxpwifi_adapter *adapter);
+};
+
+struct nxpwifi_adapter {
+	u8 iface_type;
+	unsigned int debug_mask;
+	struct nxpwifi_iface_comb iface_limit;
+	struct nxpwifi_iface_comb curr_iface_comb;
+	struct nxpwifi_private *priv[NXPWIFI_MAX_BSS_NUM];
+	u8 priv_num;
+	const struct firmware *firmware;
+	char fw_name[32];
+	int winner;
+	struct device *dev;
+	struct wiphy *wiphy;
+	u8 perm_addr[ETH_ALEN];
+	unsigned long work_flags;
+	u32 fw_release_number;
+	u8 intf_hdr_len;
+	u16 init_wait_q_woken;
+	wait_queue_head_t init_wait_q;
+	void *card;
+	struct nxpwifi_if_ops if_ops;
+	atomic_t bypass_tx_pending;
+	atomic_t rx_pending;
+	atomic_t tx_pending;
+	atomic_t cmd_pending;
+	atomic_t tx_hw_pending;
+	struct workqueue_struct *workqueue;
+	struct work_struct main_work;
+	struct workqueue_struct *rx_workqueue;
+	struct work_struct rx_work;
+	struct wiphy_work host_mlme_work;
+	bool rx_work_enabled;
+	bool rx_processing;
+	bool delay_main_work;
+	atomic_t rx_ba_teardown_pending;
+	atomic_t iface_changing;
+	struct nxpwifi_bss_prio_tbl bss_prio_tbl[NXPWIFI_MAX_BSS_NUM];
+	u32 nxpwifi_processing;
+	u16 tx_buf_size;
+	u16 curr_tx_buf_size;
+	/* sdio single port rx aggregation capability */
+	bool host_disable_sdio_rx_aggr;
+	bool sdio_rx_aggr_enable;
+	u16 sdio_rx_block_size;
+	u32 ioport;
+	enum NXPWIFI_HARDWARE_STATUS hw_status;
+	u16 number_of_antenna;
+	u32 fw_cap_info;
+	u32 fw_cap_ext;
+	u16 user_htstream;
+	u64 uuid_lo;
+	u64 uuid_hi;
+	/* spin lock for interrupt handling */
+	spinlock_t int_lock;
+	u8 int_status;
+	u32 event_cause;
+	struct sk_buff *event_skb;
+	u8 upld_buf[NXPWIFI_UPLD_SIZE];
+	u8 data_sent;
+	u8 cmd_sent;
+	u8 cmd_resp_received;
+	bool event_received;
+	u8 data_received;
+	u8 assoc_resp_received;
+	struct nxpwifi_private *priv_link_lost;
+	u8 host_mlme_link_lost;
+	u16 seq_num;
+	struct cmd_ctrl_node *cmd_pool;
+	struct cmd_ctrl_node *curr_cmd;
+	/* spin lock for command */
+	spinlock_t nxpwifi_cmd_lock;
+	u16 last_init_cmd;
+	struct timer_list cmd_timer;
+	struct list_head cmd_free_q;
+	/* spin lock for cmd_free_q */
+	spinlock_t cmd_free_q_lock;
+	struct list_head cmd_pending_q;
+	/* spin lock for cmd_pending_q */
+	spinlock_t cmd_pending_q_lock;
+	struct list_head scan_pending_q;
+	/* spin lock for scan_pending_q */
+	spinlock_t scan_pending_q_lock;
+	struct sk_buff_head tx_data_q;
+	atomic_t tx_queued;
+	u32 scan_processing;
+	u16 region_code;
+	struct nxpwifi_802_11d_domain_reg domain_reg;
+	u16 scan_probes;
+	u32 scan_mode;
+	u16 specific_scan_time;
+	u16 active_scan_time;
+	u16 passive_scan_time;
+	u16 scan_chan_gap_time;
+	u16 fw_bands;
+	u8 tx_lock_flag;
+	struct nxpwifi_sleep_period sleep_period;
+	u16 ps_mode;
+	u32 ps_state;
+	u8 need_to_wakeup;
+	u16 multiple_dtim;
+	u16 local_listen_interval;
+	u16 null_pkt_interval;
+	struct sk_buff *sleep_cfm;
+	u16 bcn_miss_time_out;
+	u8 is_deep_sleep;
+	u8 delay_null_pkt;
+	u16 delay_to_ps;
+	u16 enhanced_ps_mode;
+	u8 pm_wakeup_card_req;
+	u16 gen_null_pkt;
+	u16 pps_uapsd_mode;
+	u32 pm_wakeup_fw_try;
+	struct timer_list wakeup_timer;
+	struct nxpwifi_hs_config_param hs_cfg;
+	u8 hs_activated;
+	u8 hs_activated_manually;
+	u16 hs_activate_wait_q_woken;
+	wait_queue_head_t hs_activate_wait_q;
+	u8 event_body[MAX_EVENT_SIZE];
+	u32 hw_dot_11n_dev_cap;
+	u8 hw_dev_mcs_support;
+	u8 hw_mpdu_density;
+	u8 user_dev_mcs_support;
+	u8 sec_chan_offset;
+	struct nxpwifi_dbg dbg;
+	u8 arp_filter[ARP_FILTER_MAX_BUF_SIZE];
+	u32 arp_filter_size;
+	struct nxpwifi_wait_queue cmd_wait_q;
+	u8 scan_wait_q_woken;
+	spinlock_t queue_lock;		/* lock for tx queues */
+	u8 dfs_region;
+	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
+	u16 max_mgmt_ie_index;
+	const struct firmware *cal_data;
+	struct device_node *dt_node;
+	/* 11AC */
+	u32 is_hw_11ac_capable;
+	u32 hw_dot_11ac_dev_cap;
+	u32 hw_dot_11ac_mcs_support;
+	u32 usr_dot_11ac_dev_cap_bg;
+	u32 usr_dot_11ac_dev_cap_a;
+	u32 usr_dot_11ac_mcs_support;
+	/* 11AX */
+	u8 is_hw_11ax_capable;
+	u8 hw_he_cap_len;
+	u8 hw_he_cap[HE_CAP_MAX_SIZE];
+	u8 hw_2g_he_cap_len;
+	u8 hw_2g_he_cap[HE_CAP_MAX_SIZE];
+	atomic_t pending_bridged_pkts;
+	/* For synchronizing FW initialization with device lifecycle. */
+	struct completion *fw_done;
+	bool is_up;
+	bool ext_scan;
+	u8 fw_api_ver;
+	u8 fw_hotfix_ver;
+	u8 key_api_major_ver, key_api_minor_ver;
+	u8 max_sta_conn;
+	struct memory_type_mapping *mem_type_mapping_tbl;
+	u8 num_mem_types;
+	bool scan_chan_gap_enabled;
+	struct sk_buff_head rx_mlme_q;
+	struct sk_buff_head rx_data_q;
+	struct nxpwifi_chan_stats *chan_stats;
+	u32 num_in_chan_stats;
+	int survey_idx;
+	u8 coex_scan;
+	u8 coex_min_scan_time;
+	u8 coex_max_scan_time;
+	u8 coex_win_size;
+	u8 coex_tx_win_size;
+	u8 coex_rx_win_size;
+	u8 active_scan_triggered;
+	bool usb_mc_status;
+	bool usb_mc_setup;
+	struct cfg80211_wowlan_nd_info *nd_info;
+	struct ieee80211_regdomain *regd;
+	/* Wake-on-WLAN (WoWLAN) */
+	int irq_wakeup;
+	bool wake_by_wifi;
+	/* Aggregation parameters*/
+	struct bus_aggr_params bus_aggr;
+	/* Device dump data/length */
+	void *devdump_data;
+	int devdump_len;
+	bool ignore_btcoex_events;
+	struct vdll_dnld_ctrl vdll_ctrl;
+	u64 roc_cookie_counter;
+	u32 enable_net_mon;
+};
+
+struct mix_rate_info {
+	/**  bit0: LGI: gi=0, SGI: gi= 1 */
+	/**  bit1-2: 20M: bw=0, 40M: bw=1, 80M: bw=2, 160M: bw=3  */
+	/**  bit3-4: LG: format=0, HT: format=1, VHT: format=2 */
+	/**  bit5: LDPC: 0-not support,  1-support */
+	/**  bit6-7:reserved */
+	u8 rate_info;
+	/** MCS index */
+	u8 mcs_index;
+	/** bitrate, in 500Kbps */
+	u16 bitrate;
+	/** NSS */
+	u8 nss_index;
+	/** DCM */
+	u8 dcm;
+};
+
+struct rxpd_extra_info {
+	/** flags */
+	u8 flags;
+	/** channel.flags */
+	u16 channel_flags;
+	/** mcs.known */
+	u8 mcs_known;
+	/** mcs.flags */
+	u8 mcs_flags;
+	/** vht/he sig1 */
+	u32 vht_he_sig1;
+	/** vht/he sig2 */
+	u32 vht_he_sig2;
+	/** HE user idx */
+	u32 user_idx;
+};
+
+struct radiotap_info {
+	/** Rate Info */
+	struct mix_rate_info rate_info;
+	/** SNR */
+	s8 snr;
+	/** Noise Floor */
+	s8 nf;
+	/** band config */
+	u8 band_config;
+	/** chan number */
+	u8 chan_num;
+	u8 antenna;
+	/** extra rxpd info from FW */
+	struct rxpd_extra_info extra_info;
+};
+
+/** channel_field.flags */
+#define CHANNEL_FLAGS_TURBO 0x0010
+#define CHANNEL_FLAGS_CCK 0x0020
+#define CHANNEL_FLAGS_OFDM 0x0040
+#define CHANNEL_FLAGS_2GHZ 0x0080
+#define CHANNEL_FLAGS_5GHZ 0x0100
+#define CHANNEL_FLAGS_ONLY_PASSIVSCAN_ALLOW 0x0200
+#define CHANNEL_FLAGS_DYNAMIC_CCK_OFDM 0x0400
+#define CHANNEL_FLAGS_GFSK 0x0800
+struct channel_field {
+	/** frequency */
+	__le16 frequency;
+	/** flags */
+	__le16 flags;
+} __packed;
+
+/** mcs_field.known */
+#define MCS_KNOWN_BANDWIDTH 0x01
+#define MCS_KNOWN_MCS_INDEX_KNOWN 0x02
+#define MCS_KNOWN_GUARD_INTERVAL 0x04
+#define MCS_KNOWN_HT_FORMAT 0x08
+#define MCS_KNOWN_FEC_TYPE 0x10
+#define MCS_KNOWN_STBC_KNOWN 0x20
+#define MCS_KNOWN_NESS_KNOWN 0x40
+#define MCS_KNOWN_NESS_DATA 0x80
+/** bandwidth */
+#define RX_BW_20 0
+#define RX_BW_40 1
+#define RX_BW_20L 2
+#define RX_BW_20U 3
+#define RX_BW_80 4
+#define RX_HE_BW_20 0
+#define RX_HE_BW_40 1
+#define RX_HE_BW_80 2
+#define RX_HE_BW_160 3
+
+/* mcs_field.flags
+ * The flags field is any combination of the following:
+ * 0x03    bandwidth - 0: 20, 1: 40, 2: 20L, 3: 20U
+ * 0x04    guard interval - 0: long GI, 1: short GI
+ * 0x08    HT format - 0: mixed, 1: greenfield
+ * 0x10    FEC type - 0: BCC, 1: LDPC
+ * 0x60    Number of STBC streams
+ * 0x80    Ness - bit 0 (LSB) of Number of extension spatial streams
+ */
+struct mcs_field {
+	/** known */
+	u8 known;
+	/** flags */
+	u8 flags;
+	/** mcs */
+	u8 mcs;
+} __packed;
+
+/** vht_field.known */
+#define VHT_KNOWN_STBC 0x0001
+#define VHT_KNOWN_TXOP_PS_NA 0x0002
+#define VHT_KNOWN_GI 0x0004
+#define VHT_KNOWN_SGI_NSYM_DIS 0x0008
+#define VHT_KNOWN_LDPC_EXTRA_OFDM_SYM 0x0010
+#define VHT_KNOWN_BEAMFORMED 0x0020
+#define VHT_KNOWN_BANDWIDTH 0x0040
+#define VHT_KNOWN_GROUP_ID 0x0080
+#define VHT_KNOWN_PARTIAL_AID 0x0100
+
+/** vht_field.flags */
+#define VHT_FLAG_STBC 0x01
+#define VHT_FLAG_TXOP_PS_NA 0x02
+#define VHT_FLAG_SGI 0x04
+#define VHT_FLAG_SGI_NSYM_M10_9 0x08
+#define VHT_FLAG_LDPC_EXTRA_OFDM_SYM 0x10
+#define VHT_FLAG_BEAMFORMED 0x20
+
+/** vht_field.coding */
+#define VHT_CODING_LDPC_USER0 0x01
+#define VHT_CODING_LDPC_USER1 0x02
+#define VHT_CODING_LDPC_USER2 0x04
+#define VHT_CODING_LDPC_USER3 0x08
+
+/** vht_field */
+struct vht_field {
+	/** pad: for vht field require 2 bytes alignment */
+	u8 pad;
+	/** known */
+	u16 known;
+	/** flags */
+	u8 flags;
+	/** bandwidth */
+	u8 bandwidth;
+	/** mcs_nss for up to 4 users */
+	u8 mcs_nss[4];
+	/** coding for up to 4 users */
+	u8 coding;
+	/** group_id */
+	u8 group_id;
+	/** partial_aid */
+	u16 partial_aid;
+} __packed;
+
+#define HE_BSS_COLOR_KNOWN	0x0002
+#define HE_BEAM_CHANGE_KNOWN	0x0004
+#define HE_UL_DL_KNOWN		0x0008
+#define HE_MCS_KNOWN		0x0020
+#define HE_DCM_KNOWN		0x0040
+#define HE_CODING_KNOWN		0x0080
+#define HE_BW_KNOWN		0x4000
+#define HE_DATA_GI_KNOWN	0x0002
+#define HE_MU_DATA		0x0002
+#define HE_CODING_LDPC_USER0	0x2000
+/** he_field - COCO */
+struct he_field {
+	u8  pad;
+	__le16 data1;
+	__le16 data2;
+	__le16 data3;
+	__le16 data4;
+	__le16 data5;
+	__le16 data6;
+} __packed;
+
+extern u8 ru_signal[16][9];
+extern u8 ru_signal_106[14][9];
+extern u8 ru_signal_52[9];
+
+#define NXPWIFI_20_BIT_CH1P	0xC0000000
+#define NXPWIFI_20_BIT_CH1S	0x0000003F
+#define NXPWIFI_20_BIT_CH2	0x007F8000
+#define NXPWIFI_80_CENTER_RU	0x00004000
+#define NXPWIFI_160_CENTER_RU	0x40000000
+#define NXPWIFI_20_BIT_CH3	0x00003FC0
+#define NXPWIFI_20_BIT_CH4	0x7F800000
+#define NXPWIFI_BIT_160_CH3	0x003FC000
+#define NXPWIFI_BIT_160_CH4	0x03FC0000
+
+#define NXPWIFI_DECODE_RU_SIGNALING_CH1(out, x, y) \
+{ \
+	out = ((((x) << 8) & NXPWIFI_20_BIT_CH1P) >> 30) | \
+	      (((y) & NXPWIFI_20_BIT_CH1S) << 2); \
+}
+
+#define NXPWIFI_DECODE_RU_SIGNALING_CH3(out, y) \
+{ \
+	out = ((y) & NXPWIFI_20_BIT_CH3) >> 6; \
+}
+
+#define NXPWIFI_DECODE_RU_SIGNALING_CH2(out, y) \
+{ \
+	out = ((y) & NXPWIFI_20_BIT_CH2) >> 15; \
+}
+
+#define NXPWIFI_DECODE_RU_SIGNALING_CH4(out, y) \
+{ \
+	out = ((y) & NXPWIFI_20_BIT_CH4) >> 23; \
+}
+
+#define NXPWIFI_DECODING_160_RU_CH3(out, y) \
+{ \
+	out = ((y) & NXPWIFI_BIT_160_CH3) >> 5; \
+}
+
+#define NXPWIFI_DECODING_160_RU_CH4(out, y) \
+{ \
+	out = ((y) & NXPWIFI_BIT_160_CH4) >> 22; \
+}
+
+#define RU_SIGNAL_52_TONE	112
+#define TONE_MAX_USERS_52	4
+#define TONE_MAX_USERS_242	3
+#define RU_SIGNAL_26_TONE	0
+#define TONE_MAX_USERS_26	8
+#define RU_26_TONE_LIMIT	15
+#define RU_TONE_LIMIT		96
+#define RU_80_106_TONE		128
+#define RU_40_242_TONE		192
+#define RU_80_484_TONE		200
+#define RU_160_996_TONE		208
+#define RU_TONE_26		4
+#define RU_TONE_52		5
+#define RU_TONE_106		6
+#define RU_TONE_242		7
+#define RU_TONE_484		8
+#define RU_TONE_996		9
+
+static inline void nxpwifi_decode_ru_tone(u32 *x, u32 *y, u32 *tone)
+{
+	u32 x1, y1, t1;
+
+	x1 = *x;
+	y1 = *y;
+	t1 = *tone;
+
+	if (x1 == RU_SIGNAL_52_TONE) {
+		if ((y1 + 1) <= TONE_MAX_USERS_52)
+			t1 = RU_TONE_52;
+		else
+			y1 = (y1 + 1) - TONE_MAX_USERS_52;
+	} else if (x1 == RU_SIGNAL_26_TONE) {
+		if ((y1 + 1) <= TONE_MAX_USERS_26)
+			t1 = RU_TONE_26;
+		else
+			y1 = (y1 + 1) - TONE_MAX_USERS_26;
+	} else if (x1 <= RU_TONE_LIMIT) {
+		u32 ru_arr_idx;
+
+		ru_arr_idx = x1 > RU_26_TONE_LIMIT ? 1 : 0;
+		if ((y1 + 1) > (ru_arr_idx ?
+			      ru_signal_106[x1 / 8][8] : ru_signal[x1][8])) {
+			y1 = (y1 + 1) - (ru_arr_idx ?
+				       ru_signal_106[x1 / 8][8] : ru_signal[x1][8]);
+		} else {
+			u32 ind = 0;
+			u32 idx = 0;
+			u32 tn;
+
+			while (ind < 8) {
+				tn = ru_arr_idx ?
+				ru_signal_106[x1 / 8][7 - ind] : ru_signal[x1][7 - ind];
+				ind++;
+				if (tn == 0x1 || tn == 0x0 || tn == 0x2) {
+					if (idx == y1) {
+						t1 = tn ? (tn == 2) ?
+						RU_TONE_106 : RU_TONE_52 : RU_TONE_26;
+						break;
+					}
+					idx++;
+				}
+			}
+		}
+	} else if (x1 == RU_80_106_TONE) {
+		if ((y1 + 1) > TONE_MAX_USERS_242)
+			y1 = (y1 + 1) - TONE_MAX_USERS_242;
+		else
+			t1 = (y1 == 2) ? RU_TONE_106 : (y1 == 1) ? 0 : RU_TONE_106;
+	} else if (x1 == RU_40_242_TONE) {
+		if (!y1)
+			t1 = RU_TONE_242;
+		else
+			y1--;
+	} else if (x1 == RU_80_484_TONE) {
+		if (!y1)
+			t1 = RU_TONE_484;
+		else
+			y1--;
+	} else if (x1 == RU_160_996_TONE) {
+		if (!y1)
+			t1 = RU_TONE_996;
+		else
+			y1--;
+	}
+
+	*y = y1;
+	*tone = t1;
+}
+
+/** radiotap_body.flags */
+#define RADIOTAP_FLAGS_DURING_CFG 0x01
+#define RADIOTAP_FLAGS_SHORT_PREAMBLE 0x02
+#define RADIOTAP_FLAGS_WEP_ENCRYPTION 0x04
+#define RADIOTAP_FLAGS_WITH_FRAGMENT 0x08
+#define RADIOTAP_FLAGS_INCLUDE_FCS 0x10
+#define RADIOTAP_FLAGS_PAD_BTW_HEADER_PAYLOAD 0x20
+#define RADIOTAP_FLAGS_FAILED_FCS_CHECK 0x40
+#define RADIOTAP_FLAGS_USE_SGI_HT 0x80
+struct radiotap_body {
+	/** timestamp */
+	__le64 timestamp;
+	/** flags */
+	u8 flags;
+	/** rate for LG pkt, RATE flag will be present, it shows datarate in
+	 * 500Kbps. For HT/VHT pkt, RATE flag will not be present, it is not
+	 * used.
+	 */
+	u8 rate;
+	/** channel */
+	struct channel_field channel;
+	/** antenna_signal */
+	s8 antenna_signal;
+	/** antenna_noise */
+	s8 antenna_noise;
+	/** antenna */
+	u8 antenna;
+	/** union for HT/VHT pkt */
+	union {
+		/** mcs field */
+		struct mcs_field mcs;
+		/** vht field */
+		struct vht_field vht;
+		/** he field */
+		struct he_field he;
+	} u;
+} __packed;
+
+struct radiotap_header {
+	struct ieee80211_radiotap_header hdr;
+	struct radiotap_body body;
+} __packed;
+
+void nxpwifi_process_tx_queue(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_init_lock_list(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_set_trans_start(struct net_device *dev);
+
+void nxpwifi_stop_net_dev_queue(struct net_device *netdev,
+				struct nxpwifi_adapter *adapter);
+
+void nxpwifi_wake_up_net_dev_queue(struct net_device *netdev,
+				   struct nxpwifi_adapter *adapter);
+
+int nxpwifi_init_priv(struct nxpwifi_private *priv);
+void nxpwifi_free_priv(struct nxpwifi_private *priv);
+
+int nxpwifi_init_fw(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_init_fw_complete(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_shutdown_drv(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_dnld_fw(struct nxpwifi_adapter *adapter,
+		    struct nxpwifi_fw_image *fw);
+
+int nxpwifi_recv_packet(struct nxpwifi_private *priv, struct sk_buff *skb);
+int nxpwifi_uap_recv_packet(struct nxpwifi_private *priv,
+			    struct sk_buff *skb);
+
+void nxpwifi_host_mlme_disconnect(struct nxpwifi_private *priv,
+				  u16 reason_code, u8 *sa);
+
+int nxpwifi_process_mgmt_packet(struct nxpwifi_private *priv,
+				struct sk_buff *skb);
+int nxpwifi_recv_packet_to_monif(struct nxpwifi_private *priv,
+				 struct sk_buff *skb);
+int nxpwifi_complete_cmd(struct nxpwifi_adapter *adapter,
+			 struct cmd_ctrl_node *cmd_node);
+
+void nxpwifi_cmd_timeout_func(struct timer_list *t);
+
+int nxpwifi_get_debug_info(struct nxpwifi_private *priv,
+			   struct nxpwifi_debug_info *info);
+
+int nxpwifi_alloc_cmd_buffer(struct nxpwifi_adapter *adapter);
+void nxpwifi_free_cmd_buffer(struct nxpwifi_adapter *adapter);
+void nxpwifi_free_cmd_buffers(struct nxpwifi_adapter *adapter);
+void nxpwifi_cancel_all_pending_cmd(struct nxpwifi_adapter *adapter);
+void nxpwifi_cancel_pending_scan_cmd(struct nxpwifi_adapter *adapter);
+void nxpwifi_cancel_scan(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_recycle_cmd_node(struct nxpwifi_adapter *adapter,
+			      struct cmd_ctrl_node *cmd_node);
+
+void nxpwifi_insert_cmd_to_pending_q(struct nxpwifi_adapter *adapter,
+				     struct cmd_ctrl_node *cmd_node);
+
+int nxpwifi_exec_next_cmd(struct nxpwifi_adapter *adapter);
+int nxpwifi_process_cmdresp(struct nxpwifi_adapter *adapter);
+void nxpwifi_process_assoc_resp(struct nxpwifi_adapter *adapter);
+int nxpwifi_handle_rx_packet(struct nxpwifi_adapter *adapter,
+			     struct sk_buff *skb);
+int nxpwifi_process_tx(struct nxpwifi_private *priv, struct sk_buff *skb,
+		       struct nxpwifi_tx_param *tx_param);
+int nxpwifi_send_null_packet(struct nxpwifi_private *priv, u8 flags);
+int nxpwifi_write_data_complete(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb, int aggr, int status);
+void nxpwifi_clean_txrx(struct nxpwifi_private *priv);
+u8 nxpwifi_check_last_packet_indication(struct nxpwifi_private *priv);
+void nxpwifi_check_ps_cond(struct nxpwifi_adapter *adapter);
+void nxpwifi_process_sleep_confirm_resp(struct nxpwifi_adapter *adapter,
+					u8 *pbuf, u32 upld_len);
+void nxpwifi_process_hs_config(struct nxpwifi_adapter *adapter);
+void nxpwifi_hs_activated_event(struct nxpwifi_private *priv,
+				u8 activated);
+int nxpwifi_set_hs_params(struct nxpwifi_private *priv, u16 action,
+			  int cmd_type, struct nxpwifi_ds_hs_cfg *hs_cfg);
+int nxpwifi_ret_802_11_hs_cfg(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp);
+int nxpwifi_process_rx_packet(struct nxpwifi_private *priv,
+			      struct sk_buff *skb);
+int nxpwifi_process_sta_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb);
+int nxpwifi_process_uap_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb);
+int nxpwifi_handle_uap_rx_forward(struct nxpwifi_private *priv,
+				  struct sk_buff *skb);
+void nxpwifi_delete_all_station_list(struct nxpwifi_private *priv);
+void nxpwifi_wmm_del_peer_ra_list(struct nxpwifi_private *priv,
+				  const u8 *ra_addr);
+void nxpwifi_process_sta_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb);
+void nxpwifi_process_uap_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb);
+int nxpwifi_cmd_802_11_scan(struct host_cmd_ds_command *cmd,
+			    struct nxpwifi_scan_cmd_config *scan_cfg);
+void nxpwifi_queue_scan_cmd(struct nxpwifi_private *priv,
+			    struct cmd_ctrl_node *cmd_node);
+int nxpwifi_ret_802_11_scan(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *resp);
+int nxpwifi_associate(struct nxpwifi_private *priv,
+		      struct nxpwifi_bssdescriptor *bss_desc);
+int nxpwifi_cmd_802_11_associate(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *cmd,
+				 struct nxpwifi_bssdescriptor *bss_desc);
+int nxpwifi_ret_802_11_associate(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *resp);
+u8 nxpwifi_band_to_radio_type(u16 config_bands);
+int nxpwifi_deauthenticate(struct nxpwifi_private *priv, u8 *mac);
+void nxpwifi_deauthenticate_all(struct nxpwifi_adapter *adapter);
+int nxpwifi_cmd_802_11_bg_scan_query(struct host_cmd_ds_command *cmd);
+struct nxpwifi_chan_freq_power *nxpwifi_get_cfp(struct nxpwifi_private *priv,
+						u8 band, u16 channel, u32 freq);
+u32 nxpwifi_index_to_data_rate(struct nxpwifi_private *priv,
+			       u8 index, u8 ht_info);
+u32 nxpwifi_index_to_acs_data_rate(struct nxpwifi_private *priv,
+				   u8 index, u8 ht_info);
+int nxpwifi_cmd_append_vsie_tlv(struct nxpwifi_private *priv, u16 vsie_mask,
+				u8 **buffer);
+u32 nxpwifi_get_active_data_rates(struct nxpwifi_private *priv,
+				  u8 *rates);
+u32 nxpwifi_get_supported_rates(struct nxpwifi_private *priv, u8 *rates);
+u32 nxpwifi_get_rates_from_cfg80211(struct nxpwifi_private *priv,
+				    u8 *rates, u8 radio_type);
+u8 nxpwifi_is_rate_auto(struct nxpwifi_private *priv);
+extern u16 region_code_index[NXPWIFI_MAX_REGION_CODE];
+void nxpwifi_save_curr_bcn(struct nxpwifi_private *priv);
+void nxpwifi_free_curr_bcn(struct nxpwifi_private *priv);
+int is_command_pending(struct nxpwifi_adapter *adapter);
+void nxpwifi_init_priv_params(struct nxpwifi_private *priv,
+			      struct net_device *dev);
+void nxpwifi_set_ba_params(struct nxpwifi_private *priv);
+void nxpwifi_update_ampdu_txwinsize(struct nxpwifi_adapter *pmadapter);
+void nxpwifi_set_11ac_ba_params(struct nxpwifi_private *priv);
+int nxpwifi_cmd_802_11_scan_ext(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *cmd,
+				void *data_buf);
+int nxpwifi_ret_802_11_scan_ext(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *resp);
+int nxpwifi_handle_event_ext_scan_report(struct nxpwifi_private *priv,
+					 void *buf);
+int nxpwifi_cmd_802_11_bg_scan_config(struct nxpwifi_private *priv,
+				      struct host_cmd_ds_command *cmd,
+				      void *data_buf);
+int nxpwifi_stop_bg_scan(struct nxpwifi_private *priv);
+
+/* This function checks if the queuing is RA based or not.
+ */
+static inline u8
+nxpwifi_queuing_ra_based(struct nxpwifi_private *priv)
+{
+	/* Currently we assume if we are in Infra, then DA=RA. This might not be
+	 * true in the future
+	 */
+	if (priv->bss_mode == NL80211_IFTYPE_STATION &&
+	    (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA))
+		return false;
+
+	return true;
+}
+
+/* This function copies rates.
+ */
+static inline u32
+nxpwifi_copy_rates(u8 *dest, u32 pos, u8 *src, int len)
+{
+	int i;
+
+	for (i = 0; i < len && src[i]; i++, pos++) {
+		if (pos >= NXPWIFI_SUPPORTED_RATES)
+			break;
+		dest[pos] = src[i];
+	}
+
+	return pos;
+}
+
+/* This function returns the correct private structure pointer based
+ * upon the BSS type and BSS number.
+ */
+static inline struct nxpwifi_private *
+nxpwifi_get_priv_by_id(struct nxpwifi_adapter *adapter,
+		       u8 bss_num, u8 bss_type)
+{
+	int i;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]->bss_mode ==
+		    NL80211_IFTYPE_UNSPECIFIED)
+			continue;
+		if (adapter->priv[i]->bss_num == bss_num &&
+		    adapter->priv[i]->bss_type == bss_type)
+			break;
+	}
+	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
+}
+
+/* This function returns the first available private structure pointer
+ * based upon the BSS role.
+ */
+static inline struct nxpwifi_private *
+nxpwifi_get_priv(struct nxpwifi_adapter *adapter,
+		 enum nxpwifi_bss_role bss_role)
+{
+	int i;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (bss_role == NXPWIFI_BSS_ROLE_ANY ||
+		    GET_BSS_ROLE(adapter->priv[i]) == bss_role)
+			break;
+	}
+
+	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
+}
+
+/* This function checks available bss_num when adding new interface or
+ * changing interface type.
+ */
+static inline u8
+nxpwifi_get_unused_bss_num(struct nxpwifi_adapter *adapter, u8 bss_type)
+{
+	u8 i, j;
+	int index[NXPWIFI_MAX_BSS_NUM];
+
+	memset(index, 0, sizeof(index));
+	for (i = 0; i < adapter->priv_num; i++)
+		if (adapter->priv[i]->bss_type == bss_type &&
+		    !(adapter->priv[i]->bss_mode ==
+		      NL80211_IFTYPE_UNSPECIFIED)) {
+			index[adapter->priv[i]->bss_num] = 1;
+		}
+	for (j = 0; j < NXPWIFI_MAX_BSS_NUM; j++)
+		if (!index[j])
+			return j;
+	return -ENOENT;
+}
+
+/* This function returns the first available unused private structure pointer.
+ */
+static inline struct nxpwifi_private *
+nxpwifi_get_unused_priv_by_bss_type(struct nxpwifi_adapter *adapter,
+				    u8 bss_type)
+{
+	u8 i;
+
+	for (i = 0; i < adapter->priv_num; i++)
+		if (adapter->priv[i]->bss_mode ==
+		   NL80211_IFTYPE_UNSPECIFIED) {
+			adapter->priv[i]->bss_num =
+				nxpwifi_get_unused_bss_num(adapter, bss_type);
+			break;
+		}
+
+	return ((i < adapter->priv_num) ? adapter->priv[i] : NULL);
+}
+
+/* This function returns the driver private structure of a network device.
+ */
+static inline struct nxpwifi_private *
+nxpwifi_netdev_get_priv(struct net_device *dev)
+{
+	return (struct nxpwifi_private *)(*(unsigned long *)netdev_priv(dev));
+}
+
+/* This function checks if a skb holds a management frame.
+ */
+static inline bool nxpwifi_is_skb_mgmt_frame(struct sk_buff *skb)
+{
+	return (get_unaligned_le32(skb->data) == PKT_TYPE_MGMT);
+}
+
+/* This function retrieves channel closed for operation by Channel
+ * Switch Announcement.
+ */
+static inline u8
+nxpwifi_11h_get_csa_closed_channel(struct nxpwifi_private *priv)
+{
+	if (!priv->csa_chan)
+		return 0;
+
+	/* Clear csa channel, if DFS channel move time has passed */
+	if (time_after(jiffies, priv->csa_expire_time)) {
+		priv->csa_chan = 0;
+		priv->csa_expire_time = 0;
+	}
+
+	return priv->csa_chan;
+}
+
+static inline u8 nxpwifi_is_any_intf_active(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_private *priv_tmp;
+	int i;
+
+	for (i = 0; i < priv->adapter->priv_num; i++) {
+		priv_tmp = priv->adapter->priv[i];
+		if ((GET_BSS_ROLE(priv_tmp) == NXPWIFI_BSS_ROLE_UAP &&
+		     priv_tmp->bss_started) ||
+		    (GET_BSS_ROLE(priv_tmp) == NXPWIFI_BSS_ROLE_STA &&
+		     priv_tmp->media_connected))
+			return 1;
+	}
+
+	return 0;
+}
+
+/* Disable platform specific wakeup interrupt */
+static inline void nxpwifi_disable_wake(struct nxpwifi_adapter *adapter)
+{
+	if (adapter->irq_wakeup >= 0) {
+		disable_irq_wake(adapter->irq_wakeup);
+		disable_irq(adapter->irq_wakeup);
+		if (adapter->wake_by_wifi)
+			/* Undo our disable, since interrupt handler already
+			 * did this.
+			 */
+			enable_irq(adapter->irq_wakeup);
+	}
+}
+
+/* Enable platform specific wakeup interrupt */
+static inline void nxpwifi_enable_wake(struct nxpwifi_adapter *adapter)
+{
+	/* Enable platform specific wakeup interrupt */
+	if (adapter->irq_wakeup >= 0) {
+		adapter->wake_by_wifi = false;
+		enable_irq(adapter->irq_wakeup);
+		enable_irq_wake(adapter->irq_wakeup);
+	}
+}
+
+int nxpwifi_init_shutdown_fw(struct nxpwifi_private *priv,
+			     u32 func_init_shutdown);
+
+int nxpwifi_add_card(void *card, struct completion *fw_done,
+		     struct nxpwifi_if_ops *if_ops, u8 iface_type,
+		     struct device *dev);
+void nxpwifi_remove_card(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_get_version(struct nxpwifi_adapter *adapter, char *version,
+			 int maxlen);
+int
+nxpwifi_request_set_multicast_list(struct nxpwifi_private *priv,
+				   struct nxpwifi_multicast_list *mcast_list);
+int nxpwifi_copy_mcast_addr(struct nxpwifi_multicast_list *mlist,
+			    struct net_device *dev);
+int nxpwifi_wait_queue_complete(struct nxpwifi_adapter *adapter,
+				struct cmd_ctrl_node *cmd_queued);
+int nxpwifi_bss_start(struct nxpwifi_private *priv, struct cfg80211_bss *bss,
+		      struct cfg80211_ssid *req_ssid);
+int nxpwifi_cancel_hs(struct nxpwifi_private *priv, int cmd_type);
+bool nxpwifi_enable_hs(struct nxpwifi_adapter *adapter);
+int nxpwifi_disable_auto_ds(struct nxpwifi_private *priv);
+int nxpwifi_drv_get_data_rate(struct nxpwifi_private *priv, u32 *rate);
+
+int nxpwifi_scan_networks(struct nxpwifi_private *priv,
+			  const struct nxpwifi_user_scan_cfg *user_scan_in);
+int nxpwifi_set_radio(struct nxpwifi_private *priv, u8 option);
+
+int nxpwifi_set_encode(struct nxpwifi_private *priv, struct key_params *kp,
+		       const u8 *key, int key_len, u8 key_index,
+		       const u8 *mac_addr, int disable);
+
+int nxpwifi_set_gen_ie(struct nxpwifi_private *priv, const u8 *ie, int ie_len);
+
+int nxpwifi_get_ver_ext(struct nxpwifi_private *priv, u32 version_str_sel);
+
+int nxpwifi_remain_on_chan_cfg(struct nxpwifi_private *priv, u16 action,
+			       struct ieee80211_channel *chan,
+			       unsigned int duration);
+
+int nxpwifi_get_stats_info(struct nxpwifi_private *priv,
+			   struct nxpwifi_ds_get_stats *log);
+
+int nxpwifi_reg_write(struct nxpwifi_private *priv, u32 reg_type,
+		      u32 reg_offset, u32 reg_value);
+
+int nxpwifi_reg_read(struct nxpwifi_private *priv, u32 reg_type,
+		     u32 reg_offset, u32 *value);
+
+int nxpwifi_eeprom_read(struct nxpwifi_private *priv, u16 offset, u16 bytes,
+			u8 *value);
+
+int nxpwifi_set_11n_httx_cfg(struct nxpwifi_private *priv, int data);
+
+int nxpwifi_get_11n_httx_cfg(struct nxpwifi_private *priv, int *data);
+
+int nxpwifi_set_tx_rate_cfg(struct nxpwifi_private *priv, int tx_rate_index);
+
+int nxpwifi_get_tx_rate_cfg(struct nxpwifi_private *priv, int *tx_rate_index);
+
+int nxpwifi_drv_set_power(struct nxpwifi_private *priv, u32 *ps_mode);
+
+int nxpwifi_drv_get_driver_version(struct nxpwifi_adapter *adapter,
+				   char *version, int max_len);
+
+int nxpwifi_set_tx_power(struct nxpwifi_private *priv,
+			 struct nxpwifi_power_cfg *power_cfg);
+
+void nxpwifi_main_process(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_queue_tx_pkt(struct nxpwifi_private *priv, struct sk_buff *skb);
+
+int nxpwifi_get_bss_info(struct nxpwifi_private *priv,
+			 struct nxpwifi_bss_info *info);
+int nxpwifi_fill_new_bss_desc(struct nxpwifi_private *priv,
+			      struct cfg80211_bss *bss,
+			      struct nxpwifi_bssdescriptor *bss_desc);
+int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
+				    struct nxpwifi_bssdescriptor *bss_entry);
+int nxpwifi_check_network_compatibility(struct nxpwifi_private *priv,
+					struct nxpwifi_bssdescriptor *bss_desc);
+
+u8 nxpwifi_chan_type_to_sec_chan_offset(enum nl80211_channel_type chan_type);
+u8 nxpwifi_get_chan_type(struct nxpwifi_private *priv);
+
+struct wireless_dev *nxpwifi_add_virtual_intf(struct wiphy *wiphy,
+					      const char *name,
+					      unsigned char name_assign_type,
+					      enum nl80211_iftype type,
+					      struct vif_params *params);
+int nxpwifi_del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev);
+
+int nxpwifi_add_wowlan_magic_pkt_filter(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_set_mgmt_ies(struct nxpwifi_private *priv,
+			 struct cfg80211_beacon_data *data);
+int nxpwifi_del_mgmt_ies(struct nxpwifi_private *priv);
+u8 *nxpwifi_11d_code_2_region(u8 code);
+void nxpwifi_init_11h_params(struct nxpwifi_private *priv);
+int nxpwifi_is_11h_active(struct nxpwifi_private *priv);
+int nxpwifi_11h_activate(struct nxpwifi_private *priv, bool flag);
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc);
+int nxpwifi_11h_handle_event_chanswann(struct nxpwifi_private *priv);
+void nxpwifi_dnld_txpwr_table(struct nxpwifi_private *priv);
+
+extern const struct ethtool_ops nxpwifi_ethtool_ops;
+
+void nxpwifi_del_all_sta_list(struct nxpwifi_private *priv);
+void nxpwifi_del_sta_entry(struct nxpwifi_private *priv, const u8 *mac);
+void
+nxpwifi_set_sta_ht_cap(struct nxpwifi_private *priv, const u8 *ies,
+		       int ies_len, struct nxpwifi_sta_node *node);
+struct nxpwifi_sta_node *
+nxpwifi_add_sta_entry(struct nxpwifi_private *priv, const u8 *mac);
+struct nxpwifi_sta_node *
+nxpwifi_get_sta_entry(struct nxpwifi_private *priv, const u8 *mac);
+struct nxpwifi_sta_node *
+nxpwifi_get_sta_entry_rcu(struct nxpwifi_private *priv, const u8 *mac);
+int nxpwifi_init_channel_scan_gap(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_cmd_issue_chan_report_request(struct nxpwifi_private *priv,
+					  struct host_cmd_ds_command *cmd,
+					  void *data_buf);
+int nxpwifi_11h_handle_chanrpt_ready(struct nxpwifi_private *priv,
+				     struct sk_buff *skb);
+
+void nxpwifi_parse_tx_status_event(struct nxpwifi_private *priv,
+				   void *event_body);
+
+struct sk_buff *
+nxpwifi_clone_skb_for_tx_status(struct nxpwifi_private *priv,
+				struct sk_buff *skb, u8 flag, u64 *cookie);
+void nxpwifi_reset_conn_state_work(struct wiphy *wiphy, struct wiphy_work *work);
+void nxpwifi_dfs_cac_work(struct wiphy *wiphy, struct wiphy_work *work);
+void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work);
+void nxpwifi_abort_cac(struct nxpwifi_private *priv);
+int nxpwifi_stop_radar_detection(struct nxpwifi_private *priv,
+				 struct cfg80211_chan_def *chandef);
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb);
+
+void nxpwifi_hist_data_set(struct nxpwifi_private *priv, u8 rx_rate, s8 snr,
+			   s8 nflr);
+void nxpwifi_hist_data_reset(struct nxpwifi_private *priv);
+void nxpwifi_hist_data_add(struct nxpwifi_private *priv,
+			   u8 rx_rate, s8 snr, s8 nflr);
+u8 nxpwifi_adjust_data_rate(struct nxpwifi_private *priv,
+			    u8 rx_rate, u8 ht_info);
+
+void nxpwifi_drv_info_dump(struct nxpwifi_adapter *adapter);
+void nxpwifi_prepare_fw_dump_info(struct nxpwifi_adapter *adapter);
+void nxpwifi_upload_device_dump(struct nxpwifi_adapter *adapter);
+void *nxpwifi_alloc_dma_align_buf(int rx_len, gfp_t flags);
+void nxpwifi_fw_dump_event(struct nxpwifi_private *priv);
+int nxpwifi_get_wakeup_reason(struct nxpwifi_private *priv, u16 action,
+			      int cmd_type,
+			      struct nxpwifi_ds_wakeup_reason *wakeup_reason);
+int nxpwifi_get_chan_info(struct nxpwifi_private *priv,
+			  struct nxpwifi_channel_band *channel_band);
+void nxpwifi_coex_ampdu_rxwinsize(struct nxpwifi_adapter *adapter);
+void nxpwifi_11n_delba(struct nxpwifi_private *priv, int tid);
+int nxpwifi_send_domain_info_cmd_fw(struct wiphy *wiphy, enum nl80211_band band);
+int nxpwifi_set_mac_address(struct nxpwifi_private *priv,
+			    struct net_device *dev,
+			    bool external, u8 *new_mac);
+void nxpwifi_devdump_tmo_func(unsigned long function_context);
+
+#ifdef CONFIG_DEBUG_FS
+void nxpwifi_debugfs_init(void);
+void nxpwifi_debugfs_remove(void);
+
+void nxpwifi_dev_debugfs_init(struct nxpwifi_private *priv);
+void nxpwifi_dev_debugfs_remove(struct nxpwifi_private *priv);
+#endif
+int nxpwifi_reinit_sw(struct nxpwifi_adapter *adapter);
+void nxpwifi_shutdown_sw(struct nxpwifi_adapter *adapter);
+#endif /* !_NXPWIFI_MAIN_H_ */
-- 
2.34.1


