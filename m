Return-Path: <linux-wireless+bounces-9387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFFB911D97
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E351C21903
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCE816DECF;
	Fri, 21 Jun 2024 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TkDWB8Sf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2046.outbound.protection.outlook.com [40.107.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92716DEC8;
	Fri, 21 Jun 2024 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956439; cv=fail; b=Z2EfmhMjNlB+pe7lWJQEe+/ltK8g1ziIGFXo8Xq6j1CZz8tXxuFmzJ2fIUB//9qr2ui6Z+RwEiuEJ9IVJM91HE4pwrcCF4Br7B7ByTivOd7kLs6iyO6LzyDRCBf5dKXFcxLVXhcRrrN/k2dJfEJQbHoyQazG+xc8Rkqok9oVIOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956439; c=relaxed/simple;
	bh=BWZHUmJjxBDkgmuqSNRLRyDE/QBbdQsFQ91mlEyA1Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiqXxhOUhhTDM2Qra3IL18OsAToqc7Fwh2+W2WaT3XI8WFMegg6B/f81BykZvv+uOfUORYjfCoOfUVsAEPWXZjIeMHl9zfQotSSiEzWVrVIkEvJgeFEvZ0a1f8vqhhvvAjlP2NGbUZl3WqeT1lDd+gbX8FLKu7rWC66GDej/7uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TkDWB8Sf; arc=fail smtp.client-ip=40.107.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLHRR6s5fvoXNrpoIvZmP5s7dsSZLib5csicCZEFmuS4kwok7pt2OJjQTnPVWG/Tl563mmVKKhALvTCVSEqkKTkImUm9rAsvZgUlb/RBsgqoCx4c1dPRjyGu7jzrAY8oXmZSEzpFimj6ijk52qe2R/kxDFREB3sZGoj2zkqTaTo/L9fiwtTyMq1xwqG3pLAjvAul6nW3en+VloqH6Lzr5XxQoVzyVQqhip+OCBhIlF8JSIk4yR4RRh5SsUj4FyGEimVDCcqbUKj5MvqLUjbtrfn9QGw4XW0d7xWidJhxnovcTb2ovKQF/tkNmajK6R4XXo7+bfs/4W/TqmQPP1Kwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw46EMk1sSeIc8xa6ACtpOqBf9G1hTWRhHgKDoQunwg=;
 b=IG5emUdFi1eLkXi0OXeenmS1Q7GCqYRQKY4tIVBUOIWUVBb8ppNUjJfQWbqRx7Vw53XOA+pvK/H0huLCxbVleMaDY6aG6KiV/VhusN3iqSB7juiUO4mpqNWkBNERNJ7CPzG+gXukmy+MH4Bz6qsEOTrOjn91v9CgnUgmKuDqTR3uN4cMqEEsRw5jUa3B6UQFzI8THy4keogrBzjeOAUJtafgHA9tTi8Z9ThU8DXCOLSJF91E5a5tqkv9AYGZzHZ2nAapHDc4GxSmZNBpRAt3hrKgX5lJOAVZ54yfDu8qOFVpFTRJPczP73i/xL8KQZ9IcMGYuFLC5/lsOK7di/feeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw46EMk1sSeIc8xa6ACtpOqBf9G1hTWRhHgKDoQunwg=;
 b=TkDWB8SfCKbmqecVyL6ANHtMi9IwFF19hB1K43+2kjd0VRctgPq/sIkJ1XGkjxFqrAs83+U0nYyRO79MhoI7lwsyHbGyQxdkU7IlogQfMObKM6KcTd4Y4tSOtEmMHhwM9sDW89y8dODC2vBrztxXasPsoa/2+tBQ1A0UI69PJWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 07:53:51 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:51 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 23/43] wifi: nxpwifi: add main.c
Date: Fri, 21 Jun 2024 15:51:48 +0800
Message-Id: <20240621075208.513497-24-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32a563ac-22ea-434d-c52e-08dc91c749de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z4mqo3xGSPSYW+LywEPiuQvS7tgprR2rvD8mN9GjliC1HFOwotQPCN3ntyuI?=
 =?us-ascii?Q?57D6oEhkSBWHC1lRQTBk5IPPEkvvplKRM8a+RTIl1NG+QXdcyVaiSaIAR7Q/?=
 =?us-ascii?Q?EEcFQXiqQlNABEx1JMciMaa/bV5iVGqjUCdwcmGMvQFMXXKf6l7C2l8kKFtc?=
 =?us-ascii?Q?L/aKeThmO8SLRDJ+qUK2nXA1RNBsBeVWdbXAZw5YGhvRYfpzp+HK6Tm4SNnc?=
 =?us-ascii?Q?zNb7IKfisIdQ29VemW0Kb00SilJmzShSBV+lWyNp3HUgt4c335yuaL//iIKz?=
 =?us-ascii?Q?1gLqLC8X/b72POzv/v8yuelYJi88scznncjwSeqFau+UH2uQPVYnm2zvSkox?=
 =?us-ascii?Q?72Nk45hXH0cZgP3AaKAmZqU/dY7FSh632f1O9mQXnIbFUuSHUzkDkSqQVIHc?=
 =?us-ascii?Q?SOrccEyZqAHQakqdOo0SwidSiCZmtbcmTQmV3viX92ilptJHjtKYxg++axNS?=
 =?us-ascii?Q?jWB10GfESkaAjrI123ILa8uCd67Uwt0YWPVmTSEqOmmxJ84xuCYpki7ITsxW?=
 =?us-ascii?Q?s96eeYOsvCCChuxljfzhuYbJC/pyPvF3YbOP0We3LjE15eZYg40WxkEelCaD?=
 =?us-ascii?Q?YwneL/sviEsa40th9L7SfkjPhJ0CDqXQlzJzA59WFKl9XAWXc7S++pMREOH7?=
 =?us-ascii?Q?Kj1ZyQFq1chf3RIJUOvXVwojoKt1XH7u830d3bG5+LPwUtKSJUfL9ucTITNi?=
 =?us-ascii?Q?9P1QnHG9hfgYGeR47K2G7lJthBTCN7QWH9+fpeQcRszz5li+w266BuvWrryf?=
 =?us-ascii?Q?vdRgqMBrU2DI+oLFCR8HP8vfzYk3r82mIo7BHmb6y9CJwBwS86MXYK2yhKMP?=
 =?us-ascii?Q?UAJ1SFBeq5LKwMEJsHQm89BFFA8gJ9YRGstJee0JQDnfcPWO0vSVJ+iAcCiJ?=
 =?us-ascii?Q?XgOYrFQrBTaStBySFYGD8xeHAek1r0Lod1GZKL8huRb01qxYNv76EkARan3e?=
 =?us-ascii?Q?iV1p9r0H2EztOA2jtOpJfDggZgrB/8TKWE665Tk/WKpm4bDA9Tq0acZsjR+u?=
 =?us-ascii?Q?/QMkkCZnnzEerWYnHOfEkxfaNq66QNbQCm0HeDa62kOU+yNqDlW0kfxXWYYF?=
 =?us-ascii?Q?mKXoSI+bY9FP1EE32N+MiCCpJk7DVkRzAsEJDlztdCFaBgmxZiWE2QGLWoVk?=
 =?us-ascii?Q?bLUFDq0jGpiSwiLDITAysy1nIzwGz1nj+2I3JS84mcNY3I4/TiODWh8IZjue?=
 =?us-ascii?Q?9Bmu9t0yxqSFUAe2+AYSsLEl6TPpNzViel4cUKjjTI++DTAEeb6FBPd+evA6?=
 =?us-ascii?Q?Il2nJ5htPvVaSKHTvZptBAH19GNa2XZShYyxbqh4De9ma83rjgIlBeBC1lpr?=
 =?us-ascii?Q?IpNDFyvZUnc0KpfTu/FdyaAcYXiX7Q75HOWN3ya5/z4ZgsIhlC1v9ITrVtbk?=
 =?us-ascii?Q?ppuTgRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?usCBpxNlWRtyB6omc7vyx9aCb52KMXwhorE+6MszI/wZD9C/HjCbI/ZR2fg4?=
 =?us-ascii?Q?DWpOLW1iWRsmQb2c1JdRfkMNujKXlZLzJuj73TprFPldaJ8wUY0s8zBioUMZ?=
 =?us-ascii?Q?PlYgZqcvJ4wgpnliLpjf1l36RcCOdEKavBZsucEaMUUyWWGqNwAfHuqa7y+r?=
 =?us-ascii?Q?CMHYfjMArFHWgYk8UGpbPtWFnUBaxXPX0590nQuEMxCxTai9AwXO8VHsR3BV?=
 =?us-ascii?Q?4N59fFFuyJwNP2xud2/H3o9EpAnsyaoci0hUaXuJvNDkwd4IqH8LSq1qpX12?=
 =?us-ascii?Q?G5UH20MJuIk4sP4gVLQX1kKwe5UbFo03hfBVRBBcrNVGWmCn2jpGVDB4BBS0?=
 =?us-ascii?Q?hk3RaQAUX4P8hG+DqRqYsTk+sMTNtoxRdLWuezthK2hS08AvQhprITz0yEbZ?=
 =?us-ascii?Q?t6gvMv3to/sQrRbgyslRgpCeIFK10cXU6USpUth8F6sjMKnHf9YFnrsWtGcs?=
 =?us-ascii?Q?QYvK4lRWYuOlx/M/GaKUiLdgThiY0pigTrn/yjz7EUGS6RK159NBMZqMcMF3?=
 =?us-ascii?Q?gjnhX/eXShTIIyEX4vP7T7NsT1+5CYR6dJn/vPqmEzp/aa8TlZceGepMNljq?=
 =?us-ascii?Q?TyvqTf8iExLA9ZxZbIpSYO3Sl+tCllv87xqUsCxO4djZu0B2WhP1fRs3ucEw?=
 =?us-ascii?Q?Qi9J/m+aGsfOdw7pdrPt+GqQtX3uhQsmWiEZtvYy9uqderSpGI+726qCtKk9?=
 =?us-ascii?Q?3P0ObY+obXFUjVsVojC+Xp6senRydXy0qFBWNDowsvQE8tVtj+1g6tD8CTow?=
 =?us-ascii?Q?/SOBwS6raoiHud07hlPjgIgZlWVnOYZ6Qe/g7mNcbM5R08DS+QukdKLjRDZp?=
 =?us-ascii?Q?RIvP1xvTGNLcg+4OlZMhasNgrnYfVKRX0uAmMW/mPu2gsgItlvyNNltP/kJ0?=
 =?us-ascii?Q?1TK8fzWr1tgtJ/CY661uC1tCstpWKJ5/zarkBSIjRYheLGAAn/tWfh897uQ1?=
 =?us-ascii?Q?/Lrg1y7rAu1d371gvwoZjhdBpzZkizIw73adl4EnkS/j+PqgLC6C/15VKHy+?=
 =?us-ascii?Q?MZB0LfnF4aUqjVQh7+AtkUxi1sGjvErDMIGwxHY9VIz2m1iKe43ghZ+KqGaB?=
 =?us-ascii?Q?+8QKBp2db4Ti2eAeNfDkfKdV2gqpcr3jRNMU9IQB5gnpOFSTti7bdorKwXfd?=
 =?us-ascii?Q?z5lcmFBxjAW61E+FwZGsQfvK3Aam7LrUSmW1bgWJSZZ2yiYTt8EPSN87sf1i?=
 =?us-ascii?Q?iX3/N5k8vUsFz0Xb6rKGANrgSFIYfESCVquHs5CL3PhSUIMGyEJhj2NV3POQ?=
 =?us-ascii?Q?XGKFRwM0XKoMX+PLSz0FKGB43pZTAhOqfUk6G6k6u0SyDySeREpBSTxQ8AgH?=
 =?us-ascii?Q?/UeLQ+e9rvrJw9k0Y4QA7qs3Ds0vlKEnVmFVWQWPkHoPqYohFhkQbuTtO1ka?=
 =?us-ascii?Q?AFuCh+w4LxhGcSZlHys8awHWzBYVMigASq+uefASX8GZtCCk4UfOW+O0+f0q?=
 =?us-ascii?Q?WGkZvYGaZtZ8kFnj3FfZdyhkgmCyj8LyPUzqnbd8Ae7Z5zrLrjjNu/yuVbVK?=
 =?us-ascii?Q?ftENZ01LhqkbQtvgfGzgkyEjzY2QIdz3/YXhm0BhqZ3dms82AA7LfELmyF4W?=
 =?us-ascii?Q?3EIuAk1LNrqjAXxyf41krzZf6NmnHMpmUMUcV7H/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a563ac-22ea-434d-c52e-08dc91c749de
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:51.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pK0zS+yc5rTjVzbmS48O5otXMxJrenoD2bJyoa43IbA2TBX8sMEiOPi7aCtnSVr620J8E9a3mRIQlEZwO206/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/main.c | 1726 +++++++++++++++++++++++
 1 file changed, 1726 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/main.c b/drivers/net/wireless/nxp/nxpwifi/main.c
new file mode 100644
index 000000000000..54d224bdb315
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/main.c
@@ -0,0 +1,1726 @@
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
+ * In case of any errors during inittialization, this function also ensures
+ * proper cleanup before exiting.
+ */
+static int nxpwifi_register(void *card, struct device *dev,
+			    struct nxpwifi_if_ops *if_ops, void **padapter)
+{
+	struct nxpwifi_adapter *adapter;
+	int i;
+
+	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
+	if (!adapter)
+		return -ENOMEM;
+
+	*padapter = adapter;
+	adapter->dev = dev;
+	adapter->card = card;
+
+	/* Save interface specific operations in adapter */
+	memmove(&adapter->if_ops, if_ops, sizeof(struct nxpwifi_if_ops));
+	adapter->debug_mask = debug_mask;
+
+	/* card specific initialization has been deferred until now .. */
+	if (adapter->if_ops.init_if)
+		if (adapter->if_ops.init_if(adapter))
+			goto error;
+
+	adapter->priv_num = 0;
+
+	for (i = 0; i < NXPWIFI_MAX_BSS_NUM; i++) {
+		/* Allocate memory for private structure */
+		adapter->priv[i] =
+			kzalloc(sizeof(struct nxpwifi_private), GFP_KERNEL);
+		if (!adapter->priv[i])
+			goto error;
+
+		adapter->priv[i]->adapter = adapter;
+		adapter->priv_num++;
+	}
+	nxpwifi_init_lock_list(adapter);
+
+	timer_setup(&adapter->cmd_timer, nxpwifi_cmd_timeout_func, 0);
+
+	return 0;
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
+	return -1;
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
+static int nxpwifi_unregister(struct nxpwifi_adapter *adapter)
+{
+	s32 i;
+
+	if (adapter->if_ops.cleanup_if)
+		adapter->if_ops.cleanup_if(adapter);
+
+	del_timer_sync(&adapter->cmd_timer);
+
+	/* Free private structures */
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			nxpwifi_free_curr_bcn(adapter->priv[i]);
+			kfree(adapter->priv[i]);
+		}
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
+	return 0;
+}
+
+void nxpwifi_queue_main_work(struct nxpwifi_adapter *adapter)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->main_proc_lock, flags);
+	if (adapter->nxpwifi_processing) {
+		adapter->more_task_flag = true;
+		spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
+	} else {
+		spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
+		queue_work(adapter->workqueue, &adapter->main_work);
+	}
+}
+EXPORT_SYMBOL_GPL(nxpwifi_queue_main_work);
+
+static void nxpwifi_queue_rx_work(struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->rx_proc_lock);
+	if (adapter->rx_processing) {
+		spin_unlock_bh(&adapter->rx_proc_lock);
+	} else {
+		spin_unlock_bh(&adapter->rx_proc_lock);
+		queue_work(adapter->rx_workqueue, &adapter->rx_work);
+	}
+}
+
+static int nxpwifi_process_rx(struct nxpwifi_adapter *adapter)
+{
+	struct sk_buff *skb;
+	struct nxpwifi_rxinfo *rx_info;
+
+	spin_lock_bh(&adapter->rx_proc_lock);
+	if (adapter->rx_processing || adapter->rx_locked) {
+		spin_unlock_bh(&adapter->rx_proc_lock);
+		goto exit_rx_proc;
+	} else {
+		adapter->rx_processing = true;
+		spin_unlock_bh(&adapter->rx_proc_lock);
+	}
+
+	/* Check for Rx data */
+	while ((skb = skb_dequeue(&adapter->rx_data_q))) {
+		atomic_dec(&adapter->rx_pending);
+		if (adapter->delay_main_work &&
+		    (atomic_read(&adapter->rx_pending) < LOW_RX_PENDING)) {
+			adapter->delay_main_work = false;
+			nxpwifi_queue_main_work(adapter);
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
+	spin_lock_bh(&adapter->rx_proc_lock);
+	adapter->rx_processing = false;
+	spin_unlock_bh(&adapter->rx_proc_lock);
+
+exit_rx_proc:
+	return 0;
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
+int nxpwifi_main_process(struct nxpwifi_adapter *adapter)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->main_proc_lock, flags);
+
+	/* Check if already processing */
+	if (adapter->nxpwifi_processing || adapter->main_locked) {
+		adapter->more_task_flag = true;
+		spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
+		return 0;
+	}
+
+	adapter->nxpwifi_processing = true;
+	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
+
+process_start:
+	do {
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
+		/* Handle pending interrupt if any */
+		if (adapter->int_status) {
+			if (adapter->hs_activated)
+				nxpwifi_process_hs_config(adapter);
+			if (adapter->if_ops.process_int_status)
+				adapter->if_ops.process_int_status(adapter);
+		}
+
+		if (adapter->rx_work_enabled && adapter->data_received)
+			nxpwifi_queue_rx_work(adapter);
+
+		/* Need to wake up the card ? */
+		if (adapter->ps_state == PS_STATE_SLEEP &&
+		    (adapter->pm_wakeup_card_req &&
+		     !adapter->pm_wakeup_fw_try) &&
+		    (is_command_pending(adapter) ||
+		     !skb_queue_empty(&adapter->tx_data_q) ||
+		     !nxpwifi_bypass_txlist_empty(adapter) ||
+		     !nxpwifi_wmm_lists_empty(adapter))) {
+			adapter->pm_wakeup_fw_try = true;
+			mod_timer(&adapter->wakeup_timer, jiffies + (HZ * 3));
+			adapter->if_ops.wakeup(adapter);
+			continue;
+		}
+
+		if (IS_CARD_RX_RCVD(adapter)) {
+			adapter->data_received = false;
+			adapter->pm_wakeup_fw_try = false;
+			del_timer(&adapter->wakeup_timer);
+			if (adapter->ps_state == PS_STATE_SLEEP)
+				adapter->ps_state = PS_STATE_AWAKE;
+		} else {
+			/* We have tried to wakeup the card already */
+			if (adapter->pm_wakeup_fw_try)
+				break;
+			if (adapter->ps_state == PS_STATE_PRE_SLEEP)
+				nxpwifi_check_ps_cond(adapter);
+
+			if (adapter->ps_state != PS_STATE_AWAKE)
+				break;
+			if (adapter->tx_lock_flag)
+				break;
+
+			if ((!adapter->scan_chan_gap_enabled &&
+			     adapter->scan_processing) || adapter->data_sent ||
+			    (nxpwifi_wmm_lists_empty(adapter) &&
+			     nxpwifi_bypass_txlist_empty(adapter) &&
+			     skb_queue_empty(&adapter->tx_data_q))) {
+				if (adapter->cmd_sent || adapter->curr_cmd ||
+				    (!is_command_pending(adapter)))
+					break;
+			}
+		}
+
+		/* Check for event */
+		if (adapter->event_received) {
+			adapter->event_received = false;
+			nxpwifi_process_event(adapter);
+		}
+
+		/* Check for Cmd Resp */
+		if (adapter->cmd_resp_received) {
+			adapter->cmd_resp_received = false;
+			nxpwifi_process_cmdresp(adapter);
+
+			/* call nxpwifi back when init_fw is done */
+			if (adapter->hw_status == NXPWIFI_HW_STATUS_INIT_DONE) {
+				adapter->hw_status = NXPWIFI_HW_STATUS_READY;
+				nxpwifi_init_fw_complete(adapter);
+				maybe_quirk_fw_disable_ds(adapter);
+			}
+		}
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
+		if (adapter->ps_state == PS_STATE_SLEEP ||
+		    adapter->ps_state == PS_STATE_PRE_SLEEP ||
+		    adapter->ps_state == PS_STATE_SLEEP_CFM) {
+			continue;
+		}
+
+		if (adapter->tx_lock_flag)
+			continue;
+
+		if (!adapter->cmd_sent && !adapter->curr_cmd) {
+			if (nxpwifi_exec_next_cmd(adapter) == -1) {
+				ret = -1;
+				break;
+			}
+		}
+
+		if ((adapter->scan_chan_gap_enabled ||
+		     !adapter->scan_processing) &&
+		    !adapter->data_sent &&
+		    !skb_queue_empty(&adapter->tx_data_q)) {
+			if (adapter->hs_activated_manually) {
+				nxpwifi_cancel_hs(nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY),
+						  NXPWIFI_ASYNC_CMD);
+				adapter->hs_activated_manually = false;
+			}
+
+			nxpwifi_process_tx_queue(adapter);
+			if (adapter->hs_activated) {
+				clear_bit(NXPWIFI_IS_HS_CONFIGURED,
+					  &adapter->work_flags);
+				nxpwifi_hs_activated_event
+					(nxpwifi_get_priv
+					(adapter, NXPWIFI_BSS_ROLE_ANY),
+					false);
+			}
+		}
+
+		if ((adapter->scan_chan_gap_enabled ||
+		     !adapter->scan_processing) &&
+		    !adapter->data_sent &&
+		    !nxpwifi_bypass_txlist_empty(adapter)) {
+			if (adapter->hs_activated_manually) {
+				nxpwifi_cancel_hs(nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY),
+						  NXPWIFI_ASYNC_CMD);
+				adapter->hs_activated_manually = false;
+			}
+
+			nxpwifi_process_bypass_tx(adapter);
+			if (adapter->hs_activated) {
+				clear_bit(NXPWIFI_IS_HS_CONFIGURED,
+					  &adapter->work_flags);
+				nxpwifi_hs_activated_event
+					(nxpwifi_get_priv
+					 (adapter, NXPWIFI_BSS_ROLE_ANY),
+					 false);
+			}
+		}
+
+		if ((adapter->scan_chan_gap_enabled ||
+		     !adapter->scan_processing) &&
+		    !adapter->data_sent && !nxpwifi_wmm_lists_empty(adapter)) {
+			if (adapter->hs_activated_manually) {
+				nxpwifi_cancel_hs(nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY),
+						  NXPWIFI_ASYNC_CMD);
+				adapter->hs_activated_manually = false;
+			}
+
+			nxpwifi_wmm_process_tx(adapter);
+			if (adapter->hs_activated) {
+				clear_bit(NXPWIFI_IS_HS_CONFIGURED,
+					  &adapter->work_flags);
+				nxpwifi_hs_activated_event
+					(nxpwifi_get_priv
+					 (adapter, NXPWIFI_BSS_ROLE_ANY),
+					 false);
+			}
+		}
+
+		if (adapter->delay_null_pkt && !adapter->cmd_sent &&
+		    !adapter->curr_cmd && !is_command_pending(adapter) &&
+		    (nxpwifi_wmm_lists_empty(adapter) &&
+		     nxpwifi_bypass_txlist_empty(adapter) &&
+		     skb_queue_empty(&adapter->tx_data_q))) {
+			if (!nxpwifi_send_null_packet
+			    (nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_STA),
+			     NXPWIFI_TxPD_POWER_MGMT_NULL_PACKET |
+			     NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET)) {
+				adapter->delay_null_pkt = false;
+				adapter->ps_state = PS_STATE_SLEEP;
+			}
+			break;
+		}
+	} while (true);
+
+	spin_lock_irqsave(&adapter->main_proc_lock, flags);
+	if (adapter->more_task_flag) {
+		adapter->more_task_flag = false;
+		spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
+		goto process_start;
+	}
+	adapter->nxpwifi_processing = false;
+	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_main_process);
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
+
+	if (adapter->host_mlme_workqueue) {
+		destroy_workqueue(adapter->host_mlme_workqueue);
+		adapter->host_mlme_workqueue = NULL;
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
+	int ret;
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
+	if (ret == -1)
+		goto err_dnld_fw;
+
+	nxpwifi_dbg(adapter, MSG, "WLAN FW is active\n");
+
+	/* enable host interrupt after fw dnld is successful */
+	if (adapter->if_ops.enable_int) {
+		if (adapter->if_ops.enable_int(adapter))
+			goto err_dnld_fw;
+	}
+
+	adapter->init_wait_q_woken = false;
+	ret = nxpwifi_init_fw(adapter);
+	if (ret == -1) {
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
+	wiphy_lock(adapter->wiphy);
+	/* Create station interface by default */
+	wdev = nxpwifi_add_virtual_intf(adapter->wiphy, "mlan%d", NET_NAME_ENUM,
+					NL80211_IFTYPE_STATION, NULL);
+	if (IS_ERR(wdev)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "cannot create default STA interface\n");
+		wiphy_unlock(adapter->wiphy);
+		rtnl_unlock();
+		goto err_add_intf;
+	}
+
+	wdev = nxpwifi_add_virtual_intf(adapter->wiphy, "uap%d", NET_NAME_ENUM,
+					NL80211_IFTYPE_AP, NULL);
+	if (IS_ERR(wdev)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "cannot create AP interface\n");
+		wiphy_unlock(adapter->wiphy);
+		rtnl_unlock();
+		goto err_add_intf;
+	}
+
+	wiphy_unlock(adapter->wiphy);
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
+	return init_failed ? -EIO : 0;
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
+/* CFG802.11 network device handler for open.
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
+/* CFG802.11 network device handler for close.
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
+int nxpwifi_queue_tx_pkt(struct nxpwifi_private *priv, struct sk_buff *skb)
+{
+	struct netdev_queue *txq;
+	int index = nxpwifi_1d_to_wmm_queue[skb->priority];
+
+	if (atomic_inc_return(&priv->wmm_tx_pending[index]) >= MAX_TX_PENDING) {
+		txq = netdev_get_tx_queue(priv->netdev, index);
+		if (!netif_tx_queue_stopped(txq)) {
+			netif_tx_stop_queue(txq);
+			nxpwifi_dbg(priv->adapter, DATA,
+				    "stop queue: %d\n", index);
+		}
+	}
+
+	if (nxpwifi_bypass_tx_queue(priv, skb)) {
+		atomic_inc(&priv->adapter->tx_pending);
+		atomic_inc(&priv->adapter->bypass_tx_pending);
+		nxpwifi_wmm_add_buf_bypass_txqueue(priv, skb);
+	} else {
+		atomic_inc(&priv->adapter->tx_pending);
+		nxpwifi_wmm_add_buf_txqueue(priv, skb);
+	}
+
+	nxpwifi_queue_main_work(priv->adapter);
+
+	return 0;
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
+/* CFG802.11 network device handler for data transmission.
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
+	if (unlikely(!multicast && skb->sk &&
+		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS &&
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
+/* CFG802.11 network device handler for setting MAC address.
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
+/* CFG802.11 network device handler for setting multicast list.
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
+/* CFG802.11 network device handler for transmission timeout.
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
+		if (!adapter->priv[i] || !adapter->priv[i]->netdev)
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
+			if (!adapter->priv[i] || !adapter->priv[i]->netdev)
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
+/* CFG802.11 network device handler for statistics retrieval.
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
+/* This is the host mlme work queue function.
+ * It handles the host mlme operations.
+ */
+static void nxpwifi_host_mlme_work_queue(struct work_struct *work)
+{
+	struct nxpwifi_adapter *adapter =
+		container_of(work, struct nxpwifi_adapter, host_mlme_work);
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags))
+		return;
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
+/* This is the RX work queue function.
+ *
+ * It handles the RX operations.
+ */
+static void nxpwifi_rx_work_queue(struct work_struct *work)
+{
+	struct nxpwifi_adapter *adapter =
+		container_of(work, struct nxpwifi_adapter, rx_work);
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags))
+		return;
+	nxpwifi_process_rx(adapter);
+}
+
+/* This is the main work queue function.
+ *
+ * It handles the main process, which in turn handles the complete
+ * driver operations.
+ */
+static void nxpwifi_main_work_queue(struct work_struct *work)
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
+		if (priv && priv->netdev) {
+			nxpwifi_stop_net_dev_queue(priv->netdev, adapter);
+			if (netif_carrier_ok(priv->netdev))
+				netif_carrier_off(priv->netdev);
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
+		if (!priv)
+			continue;
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
+int nxpwifi_shutdown_sw(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+
+	if (!adapter)
+		return 0;
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
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_shutdown_sw);
+
+/* This function can be used for reinitting the adapter SW. Required
+ * code is extracted from nxpwifi_add_card()
+ */
+int
+nxpwifi_reinit_sw(struct nxpwifi_adapter *adapter)
+{
+	int ret;
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
+	if (!adapter->workqueue)
+		goto err_kmalloc;
+
+	INIT_WORK(&adapter->main_work, nxpwifi_main_work_queue);
+
+	if (adapter->rx_work_enabled) {
+		adapter->rx_workqueue = alloc_workqueue("NXPWIFI_RX_WORK_QUEUE",
+							WQ_HIGHPRI |
+							WQ_MEM_RECLAIM |
+							WQ_UNBOUND, 0);
+		if (!adapter->rx_workqueue)
+			goto err_kmalloc;
+		INIT_WORK(&adapter->rx_work, nxpwifi_rx_work_queue);
+	}
+
+	adapter->host_mlme_workqueue =
+		alloc_workqueue("NXPWIFI_HOST_MLME_WORK_QUEUE",
+				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!adapter->host_mlme_workqueue)
+		goto err_kmalloc;
+
+	INIT_WORK(&adapter->host_mlme_work, nxpwifi_host_mlme_work_queue);
+
+	/* Register the device. Fill up the private data structure with
+	 * relevant information from the card. Some code extracted from
+	 * nxpwifi_register_dev()
+	 */
+	nxpwifi_dbg(adapter, INFO, "%s, nxpwifi_init_hw_fw()...\n", __func__);
+
+	if (nxpwifi_init_hw_fw(adapter, false)) {
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
+	return 0;
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
+	return -1;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_reinit_sw);
+
+static irqreturn_t nxpwifi_irq_wakeup_handler(int irq, void *priv)
+{
+	struct nxpwifi_adapter *adapter = priv;
+
+	dev_dbg(adapter->dev, "%s: wake by wifi", __func__);
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
+		dev_dbg(dev, "fail to parse irq_wakeup from device tree\n");
+		goto err_exit;
+	}
+
+	ret = devm_request_irq(dev, adapter->irq_wakeup,
+			       nxpwifi_irq_wakeup_handler, IRQF_TRIGGER_LOW,
+			       "wifi_wake", adapter);
+	if (ret) {
+		dev_err(dev, "Failed to request irq_wakeup %d (%d)\n",
+			adapter->irq_wakeup, ret);
+		goto err_exit;
+	}
+
+	disable_irq(adapter->irq_wakeup);
+	if (device_init_wakeup(dev, true)) {
+		dev_err(dev, "fail to init wakeup for nxpwifi\n");
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
+
+	if (nxpwifi_register(card, dev, if_ops, (void **)&adapter)) {
+		pr_err("%s: software init failed\n", __func__);
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
+	if (!adapter->workqueue)
+		goto err_kmalloc;
+
+	INIT_WORK(&adapter->main_work, nxpwifi_main_work_queue);
+
+	if (adapter->rx_work_enabled) {
+		adapter->rx_workqueue = alloc_workqueue("NXPWIFI_RX_WORK_QUEUE",
+							WQ_HIGHPRI |
+							WQ_MEM_RECLAIM |
+							WQ_UNBOUND, 0);
+		if (!adapter->rx_workqueue)
+			goto err_kmalloc;
+
+		INIT_WORK(&adapter->rx_work, nxpwifi_rx_work_queue);
+	}
+
+	adapter->host_mlme_workqueue =
+		alloc_workqueue("NXPWIFI_HOST_MLME_WORK_QUEUE",
+				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!adapter->host_mlme_workqueue)
+		goto err_kmalloc;
+
+	INIT_WORK(&adapter->host_mlme_work, nxpwifi_host_mlme_work_queue);
+
+	/* Register the device. Fill up the private data structure with relevant
+	 * information from the card.
+	 */
+	if (adapter->if_ops.register_dev(adapter)) {
+		pr_err("%s: failed to register nxpwifi device\n", __func__);
+		goto err_registerdev;
+	}
+
+	if (nxpwifi_init_hw_fw(adapter, true)) {
+		pr_err("%s: firmware init failed\n", __func__);
+		goto err_init_fw;
+	}
+
+	return 0;
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
+	return -1;
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
+int nxpwifi_remove_card(struct nxpwifi_adapter *adapter)
+{
+	if (!adapter)
+		return 0;
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
+
+	return 0;
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
+		dev_info(adapter->dev, "%pV", &vaf);
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
-- 
2.34.1


