Return-Path: <linux-wireless+bounces-9391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8E911D9F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B5D1F22321
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48817175540;
	Fri, 21 Jun 2024 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ow6G/UHe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2046.outbound.protection.outlook.com [40.107.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB87174EE4;
	Fri, 21 Jun 2024 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956456; cv=fail; b=IHaZbm7oa+oEI1PrJEvKzVGTyNaH39X6TIW/2kaElZLChF2RX6C9FAxL+ZpXQoQO5eAK1wczvb01q/M0epNbJWRcLWpTWanuNs75U+SYuV2Tt3xJym9d3ninaj3Otpmtj1c2Z6nIHeLLd0+KJls16pRpk3fROeiu/b4N4dGQ4aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956456; c=relaxed/simple;
	bh=yCMM0VSY+qxTwI8nHoyn33atrcSTD4iIeI15LJsQUOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQE3ZpLh4dl3lk+uWjUa9vDMC9NMsfUVZ/uL7ZhcISOhVS8ocb25VVzGZ2glBHQ2MpHWGREYLMcPMvlf8xXaYKZxV0sqmJIqf7FjPeHnDmEMmjfZ8OJ0bp5KaVdjDidqn4+iJM05aURmfTVC2l2JSHiXUnm+7F0867WeazvLIA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ow6G/UHe; arc=fail smtp.client-ip=40.107.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQhasRKcTpT1h2VKFMLMuvaI7ozkbExflCvV9BqmdGYmLJWSj9POLWP/0Ygno8JVWoIhqwJ9Ebv59ZWwgIbAIBAVX07mU9zor1l5BNc+OjC6ErM8sacT2xGKTt4SzmB2hPGr4oPqnQH0c0Ay/D/Oyof7hUxXBT0agn9xbp5njY2EbHbaBH6YI8NR3AWCh2YKPjQoov42BR2ZLZdjXEfq/MV7SDCtk+lQmlOU1DrzC/sE57RjVEki7tf24MUryoysT+U0zgiTKOsp2Cc49wsDHBCQczg2gJECl0k5jgAoJ12I6cnUEVidwT1A3WQ/70mh0/50cUvs4xFWNcUXFnfUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kwy7f9r3/pe4RXzAg9uU+I6huax8c3zE+iIqAvtFt7M=;
 b=Y7lLAb9PWpBX+7ZFacpaAw5I2YZ0gAgqHAUokUmaQLW3/vcUBvMf2eOedxZp0U2mQoZMDhl1c3B8XwlwwGekYnQRealIwSWylgtBRU36HRvYys6O+al6w6fN+n7cNjND2uhkmLNSdGpxFm2snnazHIXzAfWhtd5hTUCyrasmvUYMYB3iYQI50wTqUSz8YGgP+UXwB6R2cdOiTdiwgrlowqrLzNrLJIIS6UTYNL7DFFDFHsfOK1FMz543YXcxjQ26b/nYKwDRhcWABb0QJOjXOuER66QPylHoAd2fnYz2Wy5Ka5VlQXE2kg+3P921q/W/Dm9W//TTnvOq41Ux73q54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kwy7f9r3/pe4RXzAg9uU+I6huax8c3zE+iIqAvtFt7M=;
 b=ow6G/UHesKOMoLq3ZrQRlTZlN4ZM4xDbOx2H4sEBv0cLthBAyz5whVQ3XugD5rnzUsCRq4RCfJxe2CIbcthoZXwWjvOyCJrc3zX1fjvwYna31Dr+vD7xftivD2r5aV9C0l+9PF6kyzmEhRmHGiWKU3IETN4txyjr9rrkpgfx+4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 07:54:05 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:05 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 27/43] wifi: nxpwifi: add sdio.h
Date: Fri, 21 Jun 2024 15:51:52 +0800
Message-Id: <20240621075208.513497-28-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: abeac904-8c57-46e4-ad31-08dc91c75246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lsHAW+OIZuKLDkByXdzFM9YB2fR29dF6/hQ5fK3aZQ86AozwN+CFc8wKfeOp?=
 =?us-ascii?Q?+OlpG8sLvBtICcwV6DyDSqTJxka7wiPyxz6Dxv3j2iYUfCpuVAlFMiU+2/6f?=
 =?us-ascii?Q?BucwRGqz2+iJkufKQG/3LOWg+7aaxh/jxyuenYPeXiy/zVhiFVCQitqyQKsO?=
 =?us-ascii?Q?XrSbqJHPbpvO19fXZ+oj67khEn7Wqho4PgHmyhGKd+XioaLoZXjQCJm7fUSj?=
 =?us-ascii?Q?VlKaIWm2xhy91nKOW3GacM9Rwldg6Z+xn11zFsBXOPomeTDJ9CkC6/IXIAVy?=
 =?us-ascii?Q?wFbhB3/j/PRLWwQuFKWc1jasmeWgeR7EPBBLoyN8kkmgXmhYRDNJ4ENycLOP?=
 =?us-ascii?Q?G6zrBn3NA3hycIOOm8YTe/gdrz9rUnZzHi5Zj2aqTuvv1Oesy5prkbe0yEIf?=
 =?us-ascii?Q?tSuDK6+v2jw2V8nhp7TsqEscGnFeys1WsTR+fIE1BIta9zRJ3rA8LMQawHOq?=
 =?us-ascii?Q?edffhM58/Tgm8yLuYrdlaIhHdfcM9jQ0MovBLYR4gYxWD59z2NnMukmpgoGq?=
 =?us-ascii?Q?FEf0xQDG/x5emQ6F8u/0Pi6y5st1vjHI8mmb23HK2Z2VEPiV4wV3wnXwRmUf?=
 =?us-ascii?Q?iEfVnJXAaGZYhuq02JNcB0Ww1VAFwnseTeE85HCzOOk9z7TlrnyuJwMc3OJl?=
 =?us-ascii?Q?nMJwjRFUNvKVFgD4R79NFFQd36UN+4tSWXGaK1BqZ8uSLT1aAyTs3d5QNOMk?=
 =?us-ascii?Q?/vQXoX4pyK+N+c/pnaT4UEN1ssL158HBzMfHngopLLxMCVku3rmOw636Szyd?=
 =?us-ascii?Q?S4NBcy4ygleX/VUKS/A8tKqQ5mkm6EYQCggnxkd92Y0S3Pn7IESoSXzTukME?=
 =?us-ascii?Q?GE91HWZGR3CfhZmOUU1+m9k6CUhcBSFK+d6UVrnuEbGzykw8Kd24DOrthFsC?=
 =?us-ascii?Q?rlG11nnknhWmrWDbeVVx4H25/xzFqSCjB/V+2Hf0Xp1t/zzb9TPAg4KLe1HV?=
 =?us-ascii?Q?yte9Gq3D1kNPqaIobcfGsV/mkd81gItIo7Z+z78tqBZb7OabVxqojKp2+2BB?=
 =?us-ascii?Q?S1ayHROv7+/zn5mtqPfA3yWAto5EUnJrWSh+jHWfVILLLEnaC1JVeHPbDPte?=
 =?us-ascii?Q?8ctDICDyzgXQm1T6y8DfRCV/HVC0NOFw6cNQePpTjxsHiDAMVBLVJvX9JbvJ?=
 =?us-ascii?Q?meh3w0lXF9zWoseQGmdLt7iIOQjyH75Yl7aySvVSlL3hwEZxyVbd60ZbJyDV?=
 =?us-ascii?Q?3H5AsArLj3ofZDKiLHQEbxDj60QYOT50RN689NrC0Z5kD8LViMVxmIIFB6Ox?=
 =?us-ascii?Q?iYcP9HhNBAArgbH02pQHZGKTScAlz86FJqAcorB4TW0AavcgAQIRSU64gb49?=
 =?us-ascii?Q?du5iIenGZLrzNPUgOBvESqKsXnYzylaz7AB8aJPd5ItAPND31U2hAb1+7tD7?=
 =?us-ascii?Q?uQ1cqv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7r/gNiFKlHSXSTICN5o/N2GyjQNWlSjrcF77lE3vDEcKODEW9NKmWLdt5jQe?=
 =?us-ascii?Q?6rAQFDFn114Ki4bgrY+VLVfrhzCZTd53HRg+9CuGnaVhB7Z9MKXax7UvsCe7?=
 =?us-ascii?Q?4X3mqkkaYRc7Wm3jGMdpoa278wibiCp0ox4ClL2brwP7Ej0FiBCRGWNXULlS?=
 =?us-ascii?Q?JcQXcuPb7ZY8ZM88vs5Ls4ZNwZ/lyXylmzMBJ2W5OfMN24mlC6rqkA7TvU/0?=
 =?us-ascii?Q?ICs4qcEnSALCu0Zq+3lXIT0kwth9x2kGA5MaUPQeLsaSgiuWVLKMsWDSwW4Y?=
 =?us-ascii?Q?YvQBQcN2R+ShvXXlhem/+D9/nIAm9jzzoApoyLL2gxEvqOTLxHw5/8hs3Z1g?=
 =?us-ascii?Q?31KZITM3HQTfTgSbTk18HtN3HJ3RY4oQrGlS+2iiQvfEsOgzkKn8bf+uOE3V?=
 =?us-ascii?Q?2XYP04etBMfAP26ThJlBLeTTSW7tAKhGMeuga/ZPwtUfOg1q4G90DqLtENbD?=
 =?us-ascii?Q?EjtdOirMeCtybwFpBXwtFlQZh76JDZo6c3oPMwdbsnphKj4tTdGThG+nGL4Z?=
 =?us-ascii?Q?syKbp+IHySZrLEzpLmUvGU2j1SZWa3aoclBSzJP0jFP4Xay7lOlKUuc4Q7JQ?=
 =?us-ascii?Q?3WLtzpj0ZyM2S0y4fwzH+VKxBvik2QaWiciKxt0qJBMpoKijlrReVkQHIwW1?=
 =?us-ascii?Q?N9H29UgyIVxBCXlhMTRTSTjiPap8HsT3XZYqoWtxJuDvGFFUnJO60Yv+0Y9P?=
 =?us-ascii?Q?2HZu8/CPUwa3PlEFwKjiBLIbmxsASoQvmtMCxune7rWdKaT4YIaDAWpIog1u?=
 =?us-ascii?Q?gGO+b6jPeTQV5bMa0GWbhNv2FrHjQgvC2CJcWiE3esbt4f+WZTVHx5CcmuNR?=
 =?us-ascii?Q?/0DML0/kghbrtNUdKLjtJuzlRgRpO79m3ApLPvizi+o3gOVUuRZnocnj7XXo?=
 =?us-ascii?Q?JTcoQleTvKln0248LysYxkxg4rarJiux0Ha9adAQDmAi2NNxR/A5I1x/kO9C?=
 =?us-ascii?Q?2FqZsdxbMHeC3eRTdf7THWEgB+rgt17fFGq2c8TEWXETFQyh20Cu6wloDX8f?=
 =?us-ascii?Q?yWsD+G17/WEp9WEHtUY6s4W1/vdbmyVoZ5Tj0pEBikPgK5ovWbX+bhUqNY+u?=
 =?us-ascii?Q?3nnb/PN6XSftZUwur/Vppk6kESoSnAiLSZ+b6OgDVTjrEky4QCr98lGMkZ2l?=
 =?us-ascii?Q?qFvX+zPyAz8NisTph+Xl1Ajtk3HpeHYAu6ByIP94/h7evp89MUUcPjFM5x0S?=
 =?us-ascii?Q?kaEn4pjCeOf7ufbZ6b2p0f88EqYLfpzisz+JnNQ0Ki7Nins8S+km8SpmgJTN?=
 =?us-ascii?Q?g+R2Pn5xs9OeGLayjd5eXJvaLcqqK5qVnLvfG6lA71qZQ4eEnERQZfhF0Ff+?=
 =?us-ascii?Q?LqIGL6dGanuvQVTkiV0lj1ann3CCyjUxciveNE+rG4icMoOExybRsvTrBa6v?=
 =?us-ascii?Q?RUI/zL9CqAzP//lidk1pID5wY2MzrK7jlkaKiSqUeLlIGDxK5LbMwBC1PvtI?=
 =?us-ascii?Q?Mxk+PQs31DEP1vpFadNDUvN9MIPMD0zK0psvncx+yi57CsvZU8/E8IWVdwvH?=
 =?us-ascii?Q?oyFdqmuRnAyjqSSfBBPGrGHfKHyVmBJlWqcoSOVmtoEKVzny/xS9Yxpiq0E2?=
 =?us-ascii?Q?gEhYDFKQ1814uc5XKcKpJC7LOXLMfLRFSUsUr62B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abeac904-8c57-46e4-ad31-08dc91c75246
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:05.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tL6vi5msSN7OcgtPn4U10OEgiOpdTGF0mz9REYPnLEMgEmUZjwtrzG3I1xTjN3TvY4VoH+/xaIGSTd+XZf1lKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
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


