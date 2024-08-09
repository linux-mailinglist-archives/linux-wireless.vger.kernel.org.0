Return-Path: <linux-wireless+bounces-11205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E8B94CDBB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81971284A54
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A987199E92;
	Fri,  9 Aug 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RALnBJII"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013017.outbound.protection.outlook.com [52.101.67.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6141993B8;
	Fri,  9 Aug 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196856; cv=fail; b=ELGHwiERkqO/kKXo948f+oqpmPYrlsOXRJMSDrXBME8k3/ToMSrKdrmA0orM5ztkPneDntT7z1nFNMkGcirt70oneLxyzrL6zEYP+iidJ/Nt4IW/n9Y8FvynFknjF4yRBWAFyB47CCqx5gk4zXfXKT4DD4y5i9AMLlaPbVDM32A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196856; c=relaxed/simple;
	bh=DCwTnVB3QlB/eS0QSPmcBDEI3KgoxehEPKS7GWgAOuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n1y6IFquh7m9GnuD2IBOzOV7/D4ko1vOPgSghDHOpiaA+GNktD2yf+bOxvvB9T+c1h+G7WxthjK9iYqZkHPWP09jPvYzg7kONt8aEwjdSrctDsjM/zizTf3khcMfUbW8OiwiVwjTR9ihk+y1g/zF3yb8Osnx3QbciyuFW5YnF78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RALnBJII; arc=fail smtp.client-ip=52.101.67.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYrBsRRbz3J02lbrCJtKxPMphED6gK/yOFmp1e1+bU+yL3ZsbgcXqggj1SnboV8MxihdxGEjR0Qb6othv4s4jwYYtf9t0bRVkAqrVk/ij/2W2WaIO61DYwJT8DImZGx0kGrKwpvPWCRuY22oieR6KI8liRkHhLJxA/mBh2D6jV/4is26usJD/h7qvzQVsLW8gEmGXHSBVDsFCdYbr3gtMSIIDJYf1aogOYVqgQh0pkqWZsp6a8Azqw/irpjlvSlyZ1jJr/WbaAkL3G8j52l1zaAatuHqGnjB2bUITDZrqk5/eM+jZwfJnvY8ERj0eeQDqUECXOX3Yur+BexrofYOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mazPM+XPfTLPhbUwAP6PEzMSUhyWb3BuoHixzO33xNI=;
 b=jzR6gJiCrHJYD6DuJe3UQag53AMo1Rv/ETA3PpoQw9LMt6xGnaYxlNiZmrUKjOw+6Wt27NSbuPJ6b/nL9tAbzqJgLw6wr9aD6nQrUIC2dD1pUVxZUJizDd2tIaRa1HzZAtsgH+9n2a8cJOCDAbgNjab12KN8aZke6c9vo3DAfAVIs8XtPT/1rHZyr5EjudBPj+UJt7sGwAgFGEE8aVazp2eGp0nzh2zfEv6ONDbFmYutF62kxuSrIKFhSTlJdkmsWonZEjHHl4qKVNhEzfOt33gcAEnz/MrUCIXynjygtsly+G+ziy4RyEL8Nd+HjkoJF/56fEqx7FzOUpPWDcHZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mazPM+XPfTLPhbUwAP6PEzMSUhyWb3BuoHixzO33xNI=;
 b=RALnBJIIOCHgreMFuMOxHEpg+RP6G8mD8fQRTwTofodTz5CORT1Q6mWpWh9Zrr6dV2S0McSY9JJa+5073FY+eseY0v8fzt5YAlpC3TRciPfufaLFX59Y1gOaycGSyO03H1WIxfcfaZ5dzj12dpgf3jHLuk2maM6eFu2/7FDc+EhaVbEHwDcwjLNzpDWTHTlm4dSw/J8VYJcUZv6c5jrcZiru3brjMp6GKTJj1odhHM1c3hSHjUMyJn1/6kGnvGSU9uU/f9+MQA/xnoxgXw7KCMr9Y5B+0MbB+dU/LB9x1QKkLuFDiJ3utu00ewplSAkyb1DPoY6b9JNsF+/TJ23yZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:47:20 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:47:20 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 27/43] wifi: nxpwifi: add sdio.h
Date: Fri,  9 Aug 2024 17:45:17 +0800
Message-Id: <20240809094533.1660-28-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|GVXPR04MB9949:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e7692b-fc04-499f-e8bf-08dcb85842eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QTWoNaKQnHL2hI4GxUIQ5yVI1CcO/e84SeUgAZv9syxR3I95snrjvFVxomoF?=
 =?us-ascii?Q?VArYMrxvGkKEl7cWA90mL/fY5ok1seolJGYpUtoPTYjLpSqjJFL6gU9qSlzd?=
 =?us-ascii?Q?VET7cRv6+7ghI+L8K3xM0NEq4BdJcN5M9HRbHpOtCuzxFcj3Bu5JZoMEsztK?=
 =?us-ascii?Q?Abn6YoxyNhHuYIEyeypjKzdJaelJBjkEgw++YN434f8PPVK0PaEznxGkFM9X?=
 =?us-ascii?Q?zCVpUiGc3m5YqRzxhAIrRMH8+jJGFwfocdRDHVGVKkvQDPbx/BGwdhAk0u38?=
 =?us-ascii?Q?+RAEsqmMKPWBvo9dEM3rJFUgBRPp7dFA2F+EzBranIaYTUVdqQDh2QZKFhDh?=
 =?us-ascii?Q?rKM05ss3jkzOX25jQMszO9szSp/5C+BwmGBh9O7hWST8k+/owtjf0YsDxq/a?=
 =?us-ascii?Q?7Rb5Q0gBtPkXiwVeNmQDrJr0Fw3HpgGTvSTEu8WsyOTPsKrVt/YVb+qmy+QZ?=
 =?us-ascii?Q?NMqBidHXkjsTnvalb3nCJE7+FwScr4pNkFPcXRE9h5sC80DNrKg1zPPCU9jX?=
 =?us-ascii?Q?L5yI/QpbBgM83dtHlVMZMymazMMaiuRySAuHFpLmSzDjO6bPeQyOpNiHMVd+?=
 =?us-ascii?Q?vlPhQddAhb2xFyM5xCJsMp3PksIPCLVIQCmfHx58YGmqCSGT4FT872Sz9t6w?=
 =?us-ascii?Q?uTj9i39ZZ5TT0fUwCvFfTjUBvvnd3pRb+VrzH2PEVyb8S9vN4t1CD9xeDF8c?=
 =?us-ascii?Q?6pogV1eTiRe0uvR4G6LFUAnVl9LcicTexQFnkWTbyW05RKN+p6JFiF1GnPxt?=
 =?us-ascii?Q?btUsB1i3gKkexoF/dJjfoNw5jYWKPkEwQAzOzluBI89TKDgd0vB0HRmm02xf?=
 =?us-ascii?Q?spvrr1nQu61Defb1aca4aLCXGxG84zUTv5fKG//WLwNwI8KpsZKOqllOxC/q?=
 =?us-ascii?Q?QgWmO8AfzBGWFnY4F3WaaOhZp4aBHERW6ZxzGcFWkPU0K/fta5eW6w/GQW3Z?=
 =?us-ascii?Q?q6qF6NcQNEpgLBkB9n0UpKZvI2a64KJqT/7YgrZgozf44XKqRkApo+b+SpNf?=
 =?us-ascii?Q?Vd/vqB84iYw3Vxem++2QYf1LOubGzQwFnxyUCCLZOWL9/2nFDRiTD4kcL/5h?=
 =?us-ascii?Q?KvvpCcoJR2RerfOskafGmiQuXg2PUtr0E+uUTjJ6ZCLNwMOQr+M4pqAM/Jcu?=
 =?us-ascii?Q?c30d5GNnwtlQAWVgsbGqtzNQzEMvh55mGH15yt5073vn71tvi8Km76sQOdVH?=
 =?us-ascii?Q?qi/hW/QXGxre6YdZ2QhuK3+ghG8fXSY4gjGaE2IeV83s279CtgJMpHGMZymp?=
 =?us-ascii?Q?OMUEQLD+KcSSn3I/l/beAVO3k8C0DFDru0tM64Ug+45gMfL10DiomwhT+aRV?=
 =?us-ascii?Q?eOeQjpDQ7BVshfrRv7IYTw0Z/1O1wvfQ3s9iW/CPGzt+RA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DIdBi7b/uKINwYBjCeeZFPqq9FCnhVZU9Nt+1ZEWFzcPciZHT2Qcj4ohQTQS?=
 =?us-ascii?Q?x+pYYfBOAI41L6j7iuoO4cCaWapqbgGSNXsjU5hbItDdMREnt2Tbc75tXoEQ?=
 =?us-ascii?Q?0SfFpY5Gd6DokXQgfcNoHSzmAzSC7r6XKOA3jQPBP6piqGWu5mltR8f05L1I?=
 =?us-ascii?Q?XDTm1HkdkFc/AzhQVDQkM4QNqPrHtLY4V5lC93DaHYa6exDIs41hN6bwTAV+?=
 =?us-ascii?Q?IjH2gtXQo0cwUXjMospfrJpGhZU57e2/DnPeeG7TtzgPEG4tl2byIRH4MkP2?=
 =?us-ascii?Q?wlwILCqBejDsxFekbldS9tyyqZt/yS1+2cLhdbun79eiG0f7Ffa3wnEvE+QR?=
 =?us-ascii?Q?S+YOeFwsXz6OBrvIdq8Dtjw5WRX1UL1X3TBo4c1NikwK2AyJoVGhmp3A6p9J?=
 =?us-ascii?Q?uhi2ENeNYW2xXgCH7obZzcidlFjCIbWJ2G8an3Gn9nphFHy2Las2ZDMotGOi?=
 =?us-ascii?Q?He2F2qKg3eAUHpLIhG47vjr4IojCZ601f14wwdszfwBydT7M6XmLHd1jduFw?=
 =?us-ascii?Q?avBFGa26lChmGq0njsnq9jhjvWKmvYcQrhF4O5Lr4wlcwNn2lq2ke295MOw/?=
 =?us-ascii?Q?dgM+MGI7tONrbLpm0t9OpsKzZ8e5m/QvCtanzg6xUNiCdIsmtisqayfYAUGh?=
 =?us-ascii?Q?vKuzDAa7wUxI+DgKEcq8XcYkRK85kHZ+LN6hdqGtXdBQL1ubpw4De0RZCmw+?=
 =?us-ascii?Q?eJeVkweW/IXuViqrHZCMVwsbWbztOAfZkY4nEtDZ/61aPn/ftyDqTBcZvVts?=
 =?us-ascii?Q?YeM0rvr7WrpNtuy9gQ4kwY4Gky7tBXrKxCi4fXFbNwfQp5T4KNHwusALe8S8?=
 =?us-ascii?Q?YQAP73VKh9i+C0fLBKQdpcOTddW5XAHe1RmapRxQWdpaDmoZQJwj+BCHhDs/?=
 =?us-ascii?Q?hEpc1gM5snFw/AYj76SHu32JMro74Ax8VSGxUd78oE/yHWfN3urrJjO/pfDC?=
 =?us-ascii?Q?ZxBNdwz6i3l66SaMj3d6gX47IrgriED+aU+Ec45YBqh/d3auoWFhW9YCqX2F?=
 =?us-ascii?Q?nu687YKLQoNlFrGgjgM+7rwuvv2Y7Xpr4MExYwUYrcaFb14tZo/y1p5un/Yt?=
 =?us-ascii?Q?w7X49+yHvjuJd65KXozfngir+NGiy+Y39qEMdRen6C8Lg8gVFLOdvKgF/yqD?=
 =?us-ascii?Q?dGQIRRP4/UxySt5J/WdWVDQDyrCCJNaXoBkUmjQun0g4L4ZYwCMwOVhVWESK?=
 =?us-ascii?Q?s56Y6cwk9FIX2bjOY0KGfsOswVah5eHUDDDi+xmagcM2yb65Io0ZDnsJ2zWE?=
 =?us-ascii?Q?wqB2Tef3Z+RiqYhhVUHHH3jC0qU8Q4nLhvsWhR3y+0VK5RHnMZggo5tBNpK1?=
 =?us-ascii?Q?Zm92GkIXX7KsPzEi5iURjyUg7z0IhQCBW/dvGGb2bxQOkQitCP8ridDz0wDY?=
 =?us-ascii?Q?246h/MiChlt9WLz8v7ZWjijvTxcSsYQyYHwm8duydtNmsSVGSwu8Ggg1wPAK?=
 =?us-ascii?Q?QYj1zTlEHEAaN+M2DI5kXrT8tAaBJYgLa1idbLzx/MpvW+cIc97UGba1BmOZ?=
 =?us-ascii?Q?NmfCT0SkCknthNAohvQPr8KE6LQ8iW4EUL1ZK7DLUMI4I0J+KjMI+OUN5yGq?=
 =?us-ascii?Q?DNzeKYyhpLI/g00KGurJSFDqlp3SQvxa04oxWgdrDHJ7BqWh4wwuNkpJH9iG?=
 =?us-ascii?Q?JQOP2xgwTYf+SGRsnnz2tq6OQ7ZAr4kAAz/5dTVR3f6g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e7692b-fc04-499f-e8bf-08dcb85842eb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:47:20.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pdb3IS9uvLevAoZBCT1rNU2ysAi/MtBWETQ9XbnCHOw8Qgurvpwfa9p5ueJI0NH+dahjFC4VjN4aLmzyGnE/Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

---
 drivers/net/wireless/nxp/nxpwifi/sdio.h | 340 ++++++++++++++++++++++++
 1 file changed, 340 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/sdio.h b/drivers/net/wireless/nxp/nxpwifi/sdio.h
new file mode 100644
index 000000000000..de5c884a5b14
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sdio.h
@@ -0,0 +1,340 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: SDIO specific definitions
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef	_NXPWIFI_SDIO_H
+#define	_NXPWIFI_SDIO_H
+
+#include "main.h"
+
+#define IW61X_SDIO_FW_NAME     "nxp/sd_w61x_v1.bin.se"
+
+#define BLOCK_MODE	1
+#define BYTE_MODE	0
+
+#define NXPWIFI_SDIO_IO_PORT_MASK	0xfffff
+
+#define NXPWIFI_SDIO_BYTE_MODE_MASK	0x80000000
+
+#define NXPWIFI_MAX_FUNC2_REG_NUM	13
+#define NXPWIFI_SDIO_SCRATCH_SIZE	10
+
+#define SDIO_MPA_ADDR_BASE		0x1000
+
+#define CMD_PORT_UPLD_INT_MASK		(0x1U << 6)
+#define CMD_PORT_DNLD_INT_MASK		(0x1U << 7)
+#define HOST_TERM_CMD53			(0x1U << 2)
+#define REG_PORT			0
+#define MEM_PORT			0x10000
+
+#define CMD53_NEW_MODE			(0x1U << 0)
+#define CMD_PORT_RD_LEN_EN		(0x1U << 2)
+#define CMD_PORT_AUTO_EN		(0x1U << 0)
+#define CMD_PORT_SLCT			0x8000
+#define UP_LD_CMD_PORT_HOST_INT_STATUS	(0x40U)
+#define DN_LD_CMD_PORT_HOST_INT_STATUS	(0x80U)
+
+#define NXPWIFI_MP_AGGR_BSIZE_32K	(32768)
+/* we leave one block of 256 bytes for DMA alignment*/
+#define NXPWIFI_MP_AGGR_BSIZE_MAX	(65280)
+
+/* Misc. Config Register : Auto Re-enable interrupts */
+#define AUTO_RE_ENABLE_INT		BIT(4)
+
+/* Host Control Registers : Configuration */
+#define CONFIGURATION_REG		0x00
+/* Host Control Registers : Host power up */
+#define HOST_POWER_UP			(0x1U << 1)
+
+/* Host Control Registers : Upload host interrupt mask */
+#define UP_LD_HOST_INT_MASK		(0x1U)
+/* Host Control Registers : Download host interrupt mask */
+#define DN_LD_HOST_INT_MASK		(0x2U)
+
+/* Host Control Registers : Upload host interrupt status */
+#define UP_LD_HOST_INT_STATUS		(0x1U)
+/* Host Control Registers : Download host interrupt status */
+#define DN_LD_HOST_INT_STATUS		(0x2U)
+
+/* Host Control Registers : Host interrupt status */
+#define CARD_INT_STATUS_REG		0x28
+
+/* Card Control Registers : Card I/O ready */
+#define CARD_IO_READY                   (0x1U << 3)
+/* Card Control Registers : Download card ready */
+#define DN_LD_CARD_RDY                  (0x1U << 0)
+
+/* Max retry number of CMD53 write */
+#define MAX_WRITE_IOMEM_RETRY		2
+
+/* SDIO Tx aggregation in progress ? */
+#define MP_TX_AGGR_IN_PROGRESS(a) ((a)->mpa_tx.pkt_cnt > 0)
+
+/* SDIO Tx aggregation buffer room for next packet ? */
+#define MP_TX_AGGR_BUF_HAS_ROOM(a, len) ({ \
+	typeof(a) (_a) = a; \
+	(((_a)->mpa_tx.buf_len + (len))	<= (_a)->mpa_tx.buf_size); \
+	})
+
+/* Copy current packet (SDIO Tx aggregation buffer) to SDIO buffer */
+#define MP_TX_AGGR_BUF_PUT(a, payload, pkt_len, port) do {		\
+	typeof(a) (_a) = (a);						\
+	typeof(pkt_len) (_pkt_len) = pkt_len;				\
+	typeof(port) (_port) = port;					\
+	memmove(&(_a)->mpa_tx.buf[(_a)->mpa_tx.buf_len],		\
+		payload, (_pkt_len));					\
+	(_a)->mpa_tx.buf_len += (_pkt_len);				\
+	if (!(_a)->mpa_tx.pkt_cnt)					\
+		(_a)->mpa_tx.start_port = (_port);			\
+	if ((_a)->mpa_tx.start_port <= (_port))				\
+		(_a)->mpa_tx.ports |= (1 << ((_a)->mpa_tx.pkt_cnt));	\
+	else								\
+		(_a)->mpa_tx.ports |= (1 << ((_a)->mpa_tx.pkt_cnt + 1 +	\
+					     ((_a)->max_ports -		\
+					      (_a)->mp_end_port)));	\
+	(_a)->mpa_tx.pkt_cnt++;						\
+} while (0)
+
+/* SDIO Tx aggregation limit ? */
+#define MP_TX_AGGR_PKT_LIMIT_REACHED(a) ({				\
+	typeof(a) (_a) = a;						\
+	((_a)->mpa_tx.pkt_cnt == (_a)->mpa_tx.pkt_aggr_limit);		\
+	})
+
+/* Reset SDIO Tx aggregation buffer parameters */
+#define MP_TX_AGGR_BUF_RESET(a) do {					\
+	typeof(a) (_a) = (a);						\
+	(_a)->mpa_tx.pkt_cnt = 0;					\
+	(_a)->mpa_tx.buf_len = 0;					\
+	(_a)->mpa_tx.ports = 0;						\
+	(_a)->mpa_tx.start_port = 0;					\
+} while (0)
+
+/* SDIO Rx aggregation limit ? */
+#define MP_RX_AGGR_PKT_LIMIT_REACHED(a)	({				\
+	typeof(a) (_a) = a;						\
+	((_a)->mpa_rx.pkt_cnt == (_a)->mpa_rx.pkt_aggr_limit);		\
+	})
+
+/* SDIO Rx aggregation in progress ? */
+#define MP_RX_AGGR_IN_PROGRESS(a) ((a)->mpa_rx.pkt_cnt > 0)
+
+/* SDIO Rx aggregation buffer room for next packet ? */
+#define MP_RX_AGGR_BUF_HAS_ROOM(a, rx_len) ({				\
+	typeof(a) (_a) = a;						\
+	((((_a)->mpa_rx.buf_len + (rx_len))) <= (_a)->mpa_rx.buf_size);	\
+	})
+
+/* Reset SDIO Rx aggregation buffer parameters */
+#define MP_RX_AGGR_BUF_RESET(a) do {					\
+	typeof(a) (_a) = (a);						\
+	(_a)->mpa_rx.pkt_cnt = 0;					\
+	(_a)->mpa_rx.buf_len = 0;					\
+	(_a)->mpa_rx.ports = 0;						\
+	(_a)->mpa_rx.start_port = 0;					\
+} while (0)
+
+/* data structure for SDIO MPA TX */
+struct nxpwifi_sdio_mpa_tx {
+	/* multiport tx aggregation buffer pointer */
+	u8 *buf;
+	u32 buf_len;
+	u32 pkt_cnt;
+	u32 ports;
+	u16 start_port;
+	u8 enabled;
+	u32 buf_size;
+	u32 pkt_aggr_limit;
+};
+
+struct nxpwifi_sdio_mpa_rx {
+	u8 *buf;
+	u32 buf_len;
+	u32 pkt_cnt;
+	u32 ports;
+	u16 start_port;
+	u32 *len_arr;
+	u8 enabled;
+	u32 buf_size;
+	u32 pkt_aggr_limit;
+};
+
+int nxpwifi_bus_register(void);
+void nxpwifi_bus_unregister(void);
+
+struct nxpwifi_sdio_card_reg {
+	u8 start_rd_port;
+	u8 start_wr_port;
+	u8 base_0_reg;
+	u8 base_1_reg;
+	u8 poll_reg;
+	u8 host_int_enable;
+	u8 host_int_rsr_reg;
+	u8 host_int_status_reg;
+	u8 host_int_mask_reg;
+	u8 host_strap_reg;
+	u8 host_strap_mask;
+	u8 host_strap_value;
+	u8 status_reg_0;
+	u8 status_reg_1;
+	u8 sdio_int_mask;
+	u32 data_port_mask;
+	u8 io_port_0_reg;
+	u8 io_port_1_reg;
+	u8 io_port_2_reg;
+	u8 max_mp_regs;
+	u8 rd_bitmap_l;
+	u8 rd_bitmap_u;
+	u8 rd_bitmap_1l;
+	u8 rd_bitmap_1u;
+	u8 wr_bitmap_l;
+	u8 wr_bitmap_u;
+	u8 wr_bitmap_1l;
+	u8 wr_bitmap_1u;
+	u8 rd_len_p0_l;
+	u8 rd_len_p0_u;
+	u8 card_misc_cfg_reg;
+	u8 card_cfg_2_1_reg;
+	u8 cmd_rd_len_0;
+	u8 cmd_rd_len_1;
+	u8 cmd_rd_len_2;
+	u8 cmd_rd_len_3;
+	u8 cmd_cfg_0;
+	u8 cmd_cfg_1;
+	u8 cmd_cfg_2;
+	u8 cmd_cfg_3;
+	u8 fw_dump_host_ready;
+	u8 fw_dump_ctrl;
+	u8 fw_dump_start;
+	u8 fw_dump_end;
+	u8 func1_dump_reg_start;
+	u8 func1_dump_reg_end;
+	u8 func1_scratch_reg;
+	u8 func1_spec_reg_num;
+	u8 func1_spec_reg_table[NXPWIFI_MAX_FUNC2_REG_NUM];
+};
+
+struct sdio_mmc_card {
+	struct sdio_func *func;
+	struct nxpwifi_adapter *adapter;
+
+	struct completion fw_done;
+	const char *firmware;
+	const char *firmware_sdiouart;
+	const struct nxpwifi_sdio_card_reg *reg;
+	u8 max_ports;
+	u8 mp_agg_pkt_limit;
+	u16 tx_buf_size;
+	u32 mp_tx_agg_buf_size;
+	u32 mp_rx_agg_buf_size;
+
+	u32 mp_rd_bitmap;
+	u32 mp_wr_bitmap;
+
+	u16 mp_end_port;
+	u32 mp_data_port_mask;
+
+	u8 curr_rd_port;
+	u8 curr_wr_port;
+
+	u8 *mp_regs;
+	bool can_dump_fw;
+	bool fw_dump_enh;
+	bool can_ext_scan;
+
+	struct nxpwifi_sdio_mpa_tx mpa_tx;
+	struct nxpwifi_sdio_mpa_rx mpa_rx;
+
+	struct work_struct work;
+	unsigned long work_flags;
+};
+
+struct nxpwifi_sdio_device {
+	const char *firmware;
+	const char *firmware_sdiouart;
+	const struct nxpwifi_sdio_card_reg *reg;
+	u8 max_ports;
+	u8 mp_agg_pkt_limit;
+	u16 tx_buf_size;
+	u32 mp_tx_agg_buf_size;
+	u32 mp_rx_agg_buf_size;
+	bool can_dump_fw;
+	bool fw_dump_enh;
+	bool can_ext_scan;
+};
+
+/* .cmdrsp_complete handler
+ */
+static inline int nxpwifi_sdio_cmdrsp_complete(struct nxpwifi_adapter *adapter,
+					       struct sk_buff *skb)
+{
+	dev_kfree_skb_any(skb);
+	return 0;
+}
+
+/* .event_complete handler
+ */
+static inline int nxpwifi_sdio_event_complete(struct nxpwifi_adapter *adapter,
+					      struct sk_buff *skb)
+{
+	dev_kfree_skb_any(skb);
+	return 0;
+}
+
+static inline bool
+mp_rx_aggr_port_limit_reached(struct sdio_mmc_card *card)
+{
+	u8 tmp;
+
+	if (card->curr_rd_port < card->mpa_rx.start_port) {
+		tmp = card->mp_end_port >> 1;
+
+		if (((card->max_ports - card->mpa_rx.start_port) +
+		    card->curr_rd_port) >= tmp)
+			return true;
+	}
+
+	if ((card->curr_rd_port - card->mpa_rx.start_port) >=
+	    (card->mp_end_port >> 1))
+		return true;
+
+	return false;
+}
+
+static inline bool
+mp_tx_aggr_port_limit_reached(struct sdio_mmc_card *card)
+{
+	u16 tmp;
+
+	if (card->curr_wr_port < card->mpa_tx.start_port) {
+		tmp = card->mp_end_port >> 1;
+
+		if (((card->max_ports - card->mpa_tx.start_port) +
+		    card->curr_wr_port) >= tmp)
+			return true;
+	}
+
+	if ((card->curr_wr_port - card->mpa_tx.start_port) >=
+	    (card->mp_end_port >> 1))
+		return true;
+
+	return false;
+}
+
+/* Prepare to copy current packet from card to SDIO Rx aggregation buffer */
+static inline void mp_rx_aggr_setup(struct sdio_mmc_card *card,
+				    u16 rx_len, u8 port)
+{
+	card->mpa_rx.buf_len += rx_len;
+
+	if (!card->mpa_rx.pkt_cnt)
+		card->mpa_rx.start_port = port;
+
+	card->mpa_rx.ports |= (1 << port);
+	card->mpa_rx.len_arr[card->mpa_rx.pkt_cnt] = rx_len;
+	card->mpa_rx.pkt_cnt++;
+}
+#endif /* _NXPWIFI_SDIO_H */
-- 
2.34.1


