Return-Path: <linux-wireless+bounces-11193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB0794CDA4
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EA91F221F0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF1197A67;
	Fri,  9 Aug 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FGinxDfo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25A1974FE;
	Fri,  9 Aug 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196815; cv=fail; b=qfGY2yx6K2qVXIKRjlwi6ZbDcQxs4M3SZrtfipgsWNEDk+lCnXdaH83qcVvnzCuR2GIDNL78d0Ws5npy18bv2GazNP1jOXkxNZQ2j/d78+22nQmEhHPAIJNKJV/vvA5Qjstmm1G5VHIouDN24aLCWPJlNN50YHJ1CeM7+pq/hQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196815; c=relaxed/simple;
	bh=rCuRIgysCkC8jmUYDplCaucoyYkXkw9glgGZxByP5Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJO8kcx9b+OSLCjuaJu0FOiq7NnIRoR/aULHJxWqIRgl0VfC6kuWYB2DA0UJr4n8iCb3NI+bVl//4+Rigz6LMsueDr5Kk9Mv6zZOdDGNWVt5ByU5NIO4WaenLzcnzR7dcWFYuJBfSZ7T7qUI4YsJf+xl/BAAGjAPnzfzdnd3J4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FGinxDfo; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdgobPyAiEZ8UiYekprT2NFkqFIgEfjcJAbnI0nzOfFydsMYQn8FNAJVKBMdDInEvbqMLXu96qt1x91nh3d8vAbLHxoNf4rhUSmf4jgdPfCvKmGCMD1cT/xyBR8QNhOPG+I2nMxUOYttDqNq9OtJR/kM89F83r8LDkvR4W+n1O5x/le3g1DVH3x+Iev9bHUFds6RB02xxGT3V/rX8z0+AU7hw8RcgfhPaWhGidkA6Y872P23e7I8LPOIgwuR9FhHE8PvWpDXqBAH1SlbE0sjfpReF+dIlqcC8rXYKIrwsEtp9EII1OSDbT9zTUQcMD/U9yQTNU0MPbEYa7NdqSGaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPFrIYLL82q+pqGXLwMyp/wE9AFpwXImrMeLmKCD9t4=;
 b=ufnZPuhog7MW8BHZWvB4VGXsZBTXO9xuL8Q7Cw5wI/ktgvQBxP1J9YpnZDAhP+tchysHa8Qv1dOWJTpESbmVmaIfqw4/8Zet7ciasc4MMsbyHIDUIk7OGayOS7IYzKVxyVi80X1NZbRh1m5BwaDEn4KJ4XveQe/t5bkXr3hC68iQ596pQ/4NibI56OWyhfMhnZohzWsfRTE2eZCec7C6ibdmylGtWHfm7HS0eXlEg7eHho1JWJInTx+u5NOyr9TSsznp68H4lf3vz6P2an4VQHc/KjmDZdeRhiutcZdd9wXO/Ca+wYghTt9f0R2cHKVzLinGymzGF6GFXWScLIKKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPFrIYLL82q+pqGXLwMyp/wE9AFpwXImrMeLmKCD9t4=;
 b=FGinxDfogfxsfWjb/qo5RwaDtBLpxZzs/nllTw5F4hE9ByLMXyuCoj3jm2Rk4VGvgluYtMaC3DuJW2L82hary4m3Jeh2OYAqbw2aUn//EvCsiYZInOJIu8C5xb0OObmf0Gh5K142gWcNj0DrIzUh1VPQY9c/cG8W9oSxlj7PxoYTAEFN91snTnzKxrTI0S+K5KAs8zaqiTe2wkYdydC1Vt2qAl8Osh+iUu/6dEvjU+FiCsUWqGKtSHHC+lJLdlbDdM9rX8S70lpKYVwcd9puZPekeXe64LfXZZXsvx4UbxbW7H8acnH9RZltLu1qswAal3V7BR/5gxTxU8PGlruJYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:46:44 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:44 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 16/43] wifi: nxpwifi: add debugfs.c
Date: Fri,  9 Aug 2024 17:45:06 +0800
Message-Id: <20240809094533.1660-17-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: da044a13-78ac-4199-6abb-08dcb8582d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dD84lBPtIPMhU3WFX/Qwlb/5qY4VaRFvpLaPbqqrYctPgX65mgUGC2rk3Q6v?=
 =?us-ascii?Q?/NmFMKUofrTQdHKxsvTHrzd85IJOIcCbQinvCMJT+k6/VAT7qRRe94IKc+fk?=
 =?us-ascii?Q?3hBkooJj4xEqfHiKaDpqfp5cLTeOdjccXvk1UEI1B6UC42TZBVtj1B8dcmTY?=
 =?us-ascii?Q?cLaUNWpwWZdR0/b9OORa3M4+gOri+UXWnjfLs1Jg7bGBWKhGm+VQlYwvuVJg?=
 =?us-ascii?Q?YVFg0DhDESUFXrXi2Js4dGzMNRY3mTzReABBPpd1i9vprd8JVj42EQU8haVO?=
 =?us-ascii?Q?PJ6cxQJczuAo5GR23J9WY9PU71SS1voa8HSDkvEBaokOJLWgxgLmHCECJZel?=
 =?us-ascii?Q?tfZvez76re7VdhNXlNmhTOQ43DTI5qJcGTxSPb7WArxZ7+V4D5z02pX/bTmq?=
 =?us-ascii?Q?vpnuHCuMe8OKjzknGVmpx3sHvyTESnYIyqQtc7ybq5/1SUkXfWSah61ToCuF?=
 =?us-ascii?Q?Mzd5tzZ/3semwcAEDIfNsmW4HGOELtRkvEuiFIW570Pqv2GI53aThfDoxmi+?=
 =?us-ascii?Q?EZS3Y5t1eNbwOA98ItJQjTbnQJDgNFY4TrPPAHSYnlN358FWEKBqQ9qfkaoR?=
 =?us-ascii?Q?nwfZ5STbmyTmVbrN4PtNACR3N83Cyst3p0P2P+X3PzUYZ2N6O3oNIBKmEe7Y?=
 =?us-ascii?Q?6NTYWe9wRHnraOCmmNc1wX5RwBkp2fuwG8L+2yAmnPOVNhNNxAfgcwMfRQNO?=
 =?us-ascii?Q?T9Z2v27qZkjREvoRFs6V93h+f4IGWAbcvyi4rioxr5hW+GPWicFCQmgLuja/?=
 =?us-ascii?Q?bW+iVB0nrXklo92+KAqUvGXq1KVrfBXTubNsjWdB/mUS4p/J/4uVOgk+FZUO?=
 =?us-ascii?Q?YpHEvwhWUoceZsi1elo4GFJYh3vAXEVcrXrMU7yHFwLsGcCC6OM/RQeuuYmt?=
 =?us-ascii?Q?aUX1R+fRmtY1cnwwHnA1GfXmP1u6ujm4Y6AJ+J/WWve+YuOm4Cv8bkN+WtBa?=
 =?us-ascii?Q?7s8YK2dXfHCSjp2GzAMLFhyxkR/HWYjXG63aAtH2XIj9bro51HvgK4kizb0F?=
 =?us-ascii?Q?ButwPAIc3pHc6FcrrMU2I5ynk5sDbbTx+IU6i631NzptXhKyPoIjXVMvUiG0?=
 =?us-ascii?Q?XRCqg1Z+R3uhOY2hFjRi5MjNjxui81Gcb2+cVGpwuy5HPPhfDyvX1fSa2xGG?=
 =?us-ascii?Q?uRIslmQfd6cYFOQBd6wacaGSnGrIhyG5ZTUqyOBYudT8udacO/Vqz7ZCgG0v?=
 =?us-ascii?Q?N6EPZuWwQ02pW0z7dlS/Foy9rENDM+ZHc5xccKjsmX51PXXiuHvq1TNjmDa/?=
 =?us-ascii?Q?+ZpJFv+9Dp2q2jNBlOC4IdLoUfCa1EOF0c/UyPCGTAWn+b3lQ1a8WTNK8gez?=
 =?us-ascii?Q?p45SyjRu5d7vmB6YSP9I3FPA0hiIXWH5NZnjAOgqEM5Lbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L4t7M7EM24DI/OzUlSW3KoRJ+Zxo5cLTvy9F6EhqpF3yHEswv7jns1nJOBEZ?=
 =?us-ascii?Q?uQAN4wGUksttUWba+OV2MgqoXV4rS0N3j6xgQjErVUx2uJsqgBDfP0+Fuedk?=
 =?us-ascii?Q?TxyaamcwyCkWko2pV8q5bhXVbQrqQ4A9miVdxVobbenZdPMyUrE1MaBYfIYf?=
 =?us-ascii?Q?QL4SB9FLSZzKJyBBBruuDVaKzOQozJ1n9elaHiITj6+y9U8lFqYPtoTtzkGQ?=
 =?us-ascii?Q?y/jfT5kCFDpyTXiy8xUGOH8/0kIczwWjULx+spo5IZhJk6WWHK01jbsaFu+2?=
 =?us-ascii?Q?E/F5FLtQ8aoTxY09t6CjEFylB6jr1e4hRAsTSV9sYxNDNTp651xqwgbu0Jnq?=
 =?us-ascii?Q?+Rx4m4eQa1ArIMB1pir2XqJ/FWFvucjsvK3BDNUkHLPAGCJL45I8cmIcxr73?=
 =?us-ascii?Q?Kt+ZQcz3ehq0acMT6uui1wMsV/0/7oFA1Kza+CO7M64Fzy9umhP3W2rZoFPB?=
 =?us-ascii?Q?Mh0nF60px/X8XzF77Jr7j/NgZJpOEe6vCu4oxiO8cH2Xf9Gj29NNDlTgg7vV?=
 =?us-ascii?Q?8m0u7JX/AwI7BDawDEYHgWPr7nZBmADQJkoxxuU8/7Y0EBbXqAe4hDEeh7cY?=
 =?us-ascii?Q?SObqlAMModHX6v7syzfpnkYNw/Pe+3QsXPGasobN91v/kGRiouJx3Jmb80u8?=
 =?us-ascii?Q?DWAdyqqdk2sW6aYoN8K91V8a+LvLbYF8GE4e1EiJknRmLqRBo+hSCnGBPin1?=
 =?us-ascii?Q?Z7LJ0HPl31dh2jAKWGKG91ihJ4fYdhdm6QFoAck8Ceal0kQrMXgCf+//IXkN?=
 =?us-ascii?Q?E6k42h55akPmw+5nSPCSjdrdwMEpuWfUv83i0uk3tOtK/4vV9cFUWQpuMtjD?=
 =?us-ascii?Q?0rzIXFubHADMOZjLagPNu3VX/YB6bLv4n9cuvLd79Eyf7mtwDxcpYMT9SOLO?=
 =?us-ascii?Q?umqwFn3Q79kHWCUcribcj9MSNJCpeIGfAzuuuSta9XKa83EgC5d+2O+nCHhB?=
 =?us-ascii?Q?riANMaAXOUpXQkbPVFpxr1PE6JwOB7jmU6fjEBU1qnnqVnyNxEx87q2+/KC1?=
 =?us-ascii?Q?IRJhMYJRfO/q/rxt08BXU0tW+5Me7srzGx/OrF564mZv2rxoxdXYByu3HeOP?=
 =?us-ascii?Q?ZIr3b84T4E3zQDDgPSRvD2U99fFGX9MuieI0AyrdY2rcx93p3wOF1fPt9l3F?=
 =?us-ascii?Q?Qpa/aiD8w7oJxg9f9cbAHw/Xlva9MQZ52JnAl2s4Rkzwdmd6DsRX08kRNKND?=
 =?us-ascii?Q?bNAM5J6pTUZwA1lANuQ277kiHD37Z9GjvbL9fwJSAL/8BRBEqK9ZCgRttUbo?=
 =?us-ascii?Q?GazfJ3sxtMQdBoDDMryTo+VKV9qt+fOkELjaam0Ex5TeMWQY397jmKDlVfD0?=
 =?us-ascii?Q?RRW83KUXklPexr5sQprijRdO93CQ/zpZauA8545MUwAuzVmapjNlef2AfaZU?=
 =?us-ascii?Q?1ID0RrUNFZp+3E3DEDzPJW9SE0AqgAO4zprcMMGN1EEfdwq1hA60bFbVbgxW?=
 =?us-ascii?Q?VgJl+wq+fOXFvqm93g3ecyOI1FAySOMsVa7dWEwQDEaI6+MrA59CSafTjmxf?=
 =?us-ascii?Q?XvMNPjvlv2Mk3/LrkDEX8nWj/FQEMbWb3Oe+RlwaQm33TdHR/l79Nmg+ES7n?=
 =?us-ascii?Q?AXJ30dbbh8pdg/Qx7ViwJXqdwppf2e80vwaJkKemso3jgFtIspCVY68L1Oft?=
 =?us-ascii?Q?IPjr8wskL0adXW4MsNCOCTZMYh3PYVPvinnjQpDE25kf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da044a13-78ac-4199-6abb-08dcb8582d5e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:43.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuKHy6ApfbTQDQzWJEWFwpwz5KwdwsXQXjDqSphl2B/mQhKvvcVuF72D4/XUq3wnlgUL+wvowuDzH6UpkbagxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

---
 drivers/net/wireless/nxp/nxpwifi/debugfs.c | 1041 ++++++++++++++++++++
 1 file changed, 1041 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/debugfs.c b/drivers/net/wireless/nxp/nxpwifi/debugfs.c
new file mode 100644
index 000000000000..a8a5f815f7fa
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/debugfs.c
@@ -0,0 +1,1041 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: debugfs
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include <linux/debugfs.h>
+
+#include "main.h"
+#include "cmdevt.h"
+#include "11n.h"
+
+static struct dentry *nxpwifi_dfs_dir;
+
+static char *bss_modes[] = {
+	"UNSPECIFIED",
+	"ADHOC",
+	"STATION",
+	"AP",
+	"AP_VLAN",
+	"WDS",
+	"MONITOR",
+	"MESH_POINT",
+	"P2P_CLIENT",
+	"P2P_GO",
+	"P2P_DEVICE",
+};
+
+/* Proc info file read handler.
+ *
+ * This function is called when the 'info' file is opened for reading.
+ * It prints the following driver related information -
+ *      - Driver name
+ *      - Driver version
+ *      - Driver extended version
+ *      - Interface name
+ *      - BSS mode
+ *      - Media state (connected or disconnected)
+ *      - MAC address
+ *      - Total number of Tx bytes
+ *      - Total number of Rx bytes
+ *      - Total number of Tx packets
+ *      - Total number of Rx packets
+ *      - Total number of dropped Tx packets
+ *      - Total number of dropped Rx packets
+ *      - Total number of corrupted Tx packets
+ *      - Total number of corrupted Rx packets
+ *      - Carrier status (on or off)
+ *      - Tx queue status (started or stopped)
+ *
+ * For STA mode drivers, it also prints the following extra -
+ *      - ESSID
+ *      - BSSID
+ *      - Channel
+ *      - Region code
+ *      - Multicast count
+ *      - Multicast addresses
+ */
+static ssize_t
+nxpwifi_info_read(struct file *file, char __user *ubuf,
+		  size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	struct net_device *netdev = priv->netdev;
+	struct netdev_hw_addr *ha;
+	struct netdev_queue *txq;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page, fmt[64];
+	struct nxpwifi_bss_info info;
+	ssize_t ret;
+	int i = 0;
+
+	if (!p)
+		return -ENOMEM;
+
+	memset(&info, 0, sizeof(info));
+	ret = nxpwifi_get_bss_info(priv, &info);
+	if (ret)
+		goto free_and_exit;
+
+	nxpwifi_drv_get_driver_version(priv->adapter, fmt, sizeof(fmt) - 1);
+
+	nxpwifi_get_ver_ext(priv, 0);
+
+	p += sprintf(p, "driver_name = ");
+	p += sprintf(p, "\"nxpwifi\"\n");
+	p += sprintf(p, "driver_version = %s", fmt);
+	p += sprintf(p, "\nverext = %s", priv->version_str);
+	p += sprintf(p, "\ninterface_name=\"%s\"\n", netdev->name);
+
+	if (info.bss_mode >= ARRAY_SIZE(bss_modes))
+		p += sprintf(p, "bss_mode=\"%d\"\n", info.bss_mode);
+	else
+		p += sprintf(p, "bss_mode=\"%s\"\n", bss_modes[info.bss_mode]);
+
+	p += sprintf(p, "media_state=\"%s\"\n",
+		     (!priv->media_connected ? "Disconnected" : "Connected"));
+	p += sprintf(p, "mac_address=\"%pM\"\n", netdev->dev_addr);
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) {
+		p += sprintf(p, "multicast_count=\"%d\"\n",
+			     netdev_mc_count(netdev));
+		p += sprintf(p, "essid=\"%.*s\"\n", info.ssid.ssid_len,
+			     info.ssid.ssid);
+		p += sprintf(p, "bssid=\"%pM\"\n", info.bssid);
+		p += sprintf(p, "channel=\"%d\"\n", (int)info.bss_chan);
+		p += sprintf(p, "country_code = \"%s\"\n", info.country_code);
+		p += sprintf(p, "region_code=\"0x%x\"\n",
+			     priv->adapter->region_code);
+
+		netdev_for_each_mc_addr(ha, netdev)
+			p += sprintf(p, "multicast_address[%d]=\"%pM\"\n",
+					i++, ha->addr);
+	}
+
+	p += sprintf(p, "num_tx_bytes = %lu\n", priv->stats.tx_bytes);
+	p += sprintf(p, "num_rx_bytes = %lu\n", priv->stats.rx_bytes);
+	p += sprintf(p, "num_tx_pkts = %lu\n", priv->stats.tx_packets);
+	p += sprintf(p, "num_rx_pkts = %lu\n", priv->stats.rx_packets);
+	p += sprintf(p, "num_tx_pkts_dropped = %lu\n", priv->stats.tx_dropped);
+	p += sprintf(p, "num_rx_pkts_dropped = %lu\n", priv->stats.rx_dropped);
+	p += sprintf(p, "num_tx_pkts_err = %lu\n", priv->stats.tx_errors);
+	p += sprintf(p, "num_rx_pkts_err = %lu\n", priv->stats.rx_errors);
+	p += sprintf(p, "carrier %s\n", ((netif_carrier_ok(priv->netdev))
+					 ? "on" : "off"));
+	p += sprintf(p, "tx queue");
+	for (i = 0; i < netdev->num_tx_queues; i++) {
+		txq = netdev_get_tx_queue(netdev, i);
+		p += sprintf(p, " %d:%s", i, netif_tx_queue_stopped(txq) ?
+			     "stopped" : "started");
+	}
+	p += sprintf(p, "\n");
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+/* Proc getlog file read handler.
+ *
+ * This function is called when the 'getlog' file is opened for reading
+ * It prints the following log information -
+ *      - Number of multicast Tx frames
+ *      - Number of failed packets
+ *      - Number of Tx retries
+ *      - Number of multicast Tx retries
+ *      - Number of duplicate frames
+ *      - Number of RTS successes
+ *      - Number of RTS failures
+ *      - Number of ACK failures
+ *      - Number of fragmented Rx frames
+ *      - Number of multicast Rx frames
+ *      - Number of FCS errors
+ *      - Number of Tx frames
+ *      - WEP ICV error counts
+ *      - Number of received beacons
+ *      - Number of missed beacons
+ */
+static ssize_t
+nxpwifi_getlog_read(struct file *file, char __user *ubuf,
+		    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+	ssize_t ret;
+	struct nxpwifi_ds_get_stats stats;
+
+	if (!p)
+		return -ENOMEM;
+
+	memset(&stats, 0, sizeof(stats));
+	ret = nxpwifi_get_stats_info(priv, &stats);
+	if (ret)
+		goto free_and_exit;
+
+	p += sprintf(p, "\n"
+		     "mcasttxframe     %u\n"
+		     "failed           %u\n"
+		     "retry            %u\n"
+		     "multiretry       %u\n"
+		     "framedup         %u\n"
+		     "rtssuccess       %u\n"
+		     "rtsfailure       %u\n"
+		     "ackfailure       %u\n"
+		     "rxfrag           %u\n"
+		     "mcastrxframe     %u\n"
+		     "fcserror         %u\n"
+		     "txframe          %u\n"
+		     "wepicverrcnt-1   %u\n"
+		     "wepicverrcnt-2   %u\n"
+		     "wepicverrcnt-3   %u\n"
+		     "wepicverrcnt-4   %u\n"
+		     "bcn_rcv_cnt   %u\n"
+		     "bcn_miss_cnt   %u\n",
+		     stats.mcast_tx_frame,
+		     stats.failed,
+		     stats.retry,
+		     stats.multi_retry,
+		     stats.frame_dup,
+		     stats.rts_success,
+		     stats.rts_failure,
+		     stats.ack_failure,
+		     stats.rx_frag,
+		     stats.mcast_rx_frame,
+		     stats.fcs_error,
+		     stats.tx_frame,
+		     stats.wep_icv_error[0],
+		     stats.wep_icv_error[1],
+		     stats.wep_icv_error[2],
+		     stats.wep_icv_error[3],
+		     stats.bcn_rcv_cnt,
+		     stats.bcn_miss_cnt);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+/* Sysfs histogram file read handler.
+ *
+ * This function is called when the 'histogram' file is opened for reading
+ * It prints the following histogram information -
+ *      - Number of histogram samples
+ *      - Receive packet number of each rx_rate
+ *      - Receive packet number of each snr
+ *      - Receive packet number of each nosie_flr
+ *      - Receive packet number of each signal streath
+ */
+static ssize_t
+nxpwifi_histogram_read(struct file *file, char __user *ubuf,
+		       size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	ssize_t ret;
+	struct nxpwifi_histogram_data *phist_data;
+	int i, value;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+
+	if (!p)
+		return -ENOMEM;
+
+	if (!priv || !priv->hist_data) {
+		ret = -EFAULT;
+		goto free_and_exit;
+	}
+
+	phist_data = priv->hist_data;
+
+	p += sprintf(p, "\n"
+		     "total samples = %d\n",
+		     atomic_read(&phist_data->num_samples));
+
+	p += sprintf(p,
+		     "rx rates (in Mbps): 0=1M   1=2M 2=5.5M  3=11M   4=6M   5=9M  6=12M\n"
+		     "7=18M  8=24M  9=36M  10=48M  11=54M 12-27=MCS0-15(BW20) 28-43=MCS0-15(BW40)\n");
+
+	if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info)) {
+		p += sprintf(p,
+			     "44-53=MCS0-9(VHT:BW20) 54-63=MCS0-9(VHT:BW40) 64-73=MCS0-9(VHT:BW80)\n\n");
+	} else {
+		p += sprintf(p, "\n");
+	}
+
+	for (i = 0; i < NXPWIFI_MAX_RX_RATES; i++) {
+		value = atomic_read(&phist_data->rx_rate[i]);
+		if (value)
+			p += sprintf(p, "rx_rate[%02d] = %d\n", i, value);
+	}
+
+	if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info)) {
+		for (i = NXPWIFI_MAX_RX_RATES; i < NXPWIFI_MAX_AC_RX_RATES;
+		     i++) {
+			value = atomic_read(&phist_data->rx_rate[i]);
+			if (value)
+				p += sprintf(p, "rx_rate[%02d] = %d\n",
+					   i, value);
+		}
+	}
+
+	for (i = 0; i < NXPWIFI_MAX_SNR; i++) {
+		value =  atomic_read(&phist_data->snr[i]);
+		if (value)
+			p += sprintf(p, "snr[%02ddB] = %d\n", i, value);
+	}
+	for (i = 0; i < NXPWIFI_MAX_NOISE_FLR; i++) {
+		value = atomic_read(&phist_data->noise_flr[i]);
+		if (value)
+			p += sprintf(p, "noise_flr[%02ddBm] = %d\n",
+				     (int)(i - 128), value);
+	}
+	for (i = 0; i < NXPWIFI_MAX_SIG_STRENGTH; i++) {
+		value = atomic_read(&phist_data->sig_str[i]);
+		if (value)
+			p += sprintf(p, "sig_strength[-%02ddBm] = %d\n",
+				i, value);
+	}
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_histogram_write(struct file *file, const char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+
+	if (priv && priv->hist_data)
+		nxpwifi_hist_data_reset(priv);
+	return 0;
+}
+
+static struct nxpwifi_debug_info info;
+
+/* Proc debug file read handler.
+ *
+ * This function is called when the 'debug' file is opened for reading
+ * It prints the following log information -
+ *      - Interrupt count
+ *      - WMM AC VO packets count
+ *      - WMM AC VI packets count
+ *      - WMM AC BE packets count
+ *      - WMM AC BK packets count
+ *      - Maximum Tx buffer size
+ *      - Tx buffer size
+ *      - Current Tx buffer size
+ *      - Power Save mode
+ *      - Power Save state
+ *      - Deep Sleep status
+ *      - Device wakeup required status
+ *      - Number of wakeup tries
+ *      - Host Sleep configured status
+ *      - Host Sleep activated status
+ *      - Number of Tx timeouts
+ *      - Number of command timeouts
+ *      - Last timed out command ID
+ *      - Last timed out command action
+ *      - Last command ID
+ *      - Last command action
+ *      - Last command index
+ *      - Last command response ID
+ *      - Last command response index
+ *      - Last event
+ *      - Last event index
+ *      - Number of host to card command failures
+ *      - Number of sleep confirm command failures
+ *      - Number of host to card data failure
+ *      - Number of deauthentication events
+ *      - Number of disassociation events
+ *      - Number of link lost events
+ *      - Number of deauthentication commands
+ *      - Number of association success commands
+ *      - Number of association failure commands
+ *      - Number of commands sent
+ *      - Number of data packets sent
+ *      - Number of command responses received
+ *      - Number of events received
+ *      - Tx BA stream table (TID, RA)
+ *      - Rx reorder table (TID, TA, Start window, Window size, Buffer)
+ */
+static ssize_t
+nxpwifi_debug_read(struct file *file, char __user *ubuf,
+		   size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+	ssize_t ret;
+
+	if (!p)
+		return -ENOMEM;
+
+	ret = nxpwifi_get_debug_info(priv, &info);
+	if (ret)
+		goto free_and_exit;
+
+	p += nxpwifi_debug_info_to_buffer(priv, p, &info);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+static u32 saved_reg_type, saved_reg_offset, saved_reg_value;
+
+/* Proc regrdwr file write handler.
+ *
+ * This function is called when the 'regrdwr' file is opened for writing
+ *
+ * This function can be used to write to a register.
+ */
+static ssize_t
+nxpwifi_regrdwr_write(struct file *file,
+		      const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	char *buf;
+	int ret;
+	u32 reg_type = 0, reg_offset = 0, reg_value = UINT_MAX;
+	int rv;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	rv = sscanf(buf, "%u %x %x", &reg_type, &reg_offset, &reg_value);
+
+	if (rv != 3) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (reg_type == 0 || reg_offset == 0) {
+		ret = -EINVAL;
+		goto done;
+	} else {
+		saved_reg_type = reg_type;
+		saved_reg_offset = reg_offset;
+		saved_reg_value = reg_value;
+		ret = count;
+	}
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* Proc regrdwr file read handler.
+ *
+ * This function is called when the 'regrdwr' file is opened for reading
+ *
+ * This function can be used to read from a register.
+ */
+static ssize_t
+nxpwifi_regrdwr_read(struct file *file, char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int pos = 0, ret = 0;
+	u32 reg_value;
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (!saved_reg_type) {
+		/* No command has been given */
+		pos += snprintf(buf, PAGE_SIZE, "0");
+		goto done;
+	}
+	/* Set command has been given */
+	if (saved_reg_value != UINT_MAX) {
+		ret = nxpwifi_reg_write(priv, saved_reg_type, saved_reg_offset,
+					saved_reg_value);
+
+		pos += snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n",
+				saved_reg_type, saved_reg_offset,
+				saved_reg_value);
+
+		ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+		goto done;
+	}
+	/* Get command has been given */
+	ret = nxpwifi_reg_read(priv, saved_reg_type,
+			       saved_reg_offset, &reg_value);
+	if (ret) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	pos += snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n", saved_reg_type,
+			saved_reg_offset, reg_value);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+done:
+	free_page(addr);
+	return ret;
+}
+
+/* Proc debug_mask file read handler.
+ * This function is called when the 'debug_mask' file is opened for reading
+ * This function can be used read driver debugging mask value.
+ */
+static ssize_t
+nxpwifi_debug_mask_read(struct file *file, char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)page;
+	size_t ret = 0;
+	int pos = 0;
+
+	if (!buf)
+		return -ENOMEM;
+
+	pos += snprintf(buf, PAGE_SIZE, "debug mask=0x%08x\n",
+			priv->adapter->debug_mask);
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+	free_page(page);
+	return ret;
+}
+
+/* Proc debug_mask file read handler.
+ * This function is called when the 'debug_mask' file is opened for reading
+ * This function can be used read driver debugging mask value.
+ */
+static ssize_t
+nxpwifi_debug_mask_write(struct file *file, const char __user *ubuf,
+			 size_t count, loff_t *ppos)
+{
+	int ret;
+	unsigned long debug_mask;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (kstrtoul(buf, 0, &debug_mask)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	priv->adapter->debug_mask = debug_mask;
+	ret = count;
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* debugfs verext file write handler.
+ * This function is called when the 'verext' file is opened for write
+ */
+static ssize_t
+nxpwifi_verext_write(struct file *file, const char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	int ret;
+	u32 versionstrsel;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+
+	ret = kstrtou32_from_user(ubuf, count, 10, &versionstrsel);
+	if (ret)
+		return ret;
+
+	priv->versionstrsel = versionstrsel;
+
+	return count;
+}
+
+/* Proc verext file read handler.
+ * This function is called when the 'verext' file is opened for reading
+ * This function can be used read driver exteneed verion string.
+ */
+static ssize_t
+nxpwifi_verext_read(struct file *file, char __user *ubuf,
+		    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	char buf[256];
+	int ret;
+
+	nxpwifi_get_ver_ext(priv, priv->versionstrsel);
+	ret = snprintf(buf, sizeof(buf), "version string: %s\n",
+		       priv->version_str);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, ret);
+}
+
+/* Proc memrw file write handler.
+ * This function is called when the 'memrw' file is opened for writing
+ * This function can be used to write to a memory location.
+ */
+static ssize_t
+nxpwifi_memrw_write(struct file *file, const char __user *ubuf, size_t count,
+		    loff_t *ppos)
+{
+	int ret;
+	char cmd;
+	struct nxpwifi_ds_mem_rw mem_rw;
+	u16 cmd_action;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%c %x %x", &cmd, &mem_rw.addr, &mem_rw.value);
+	if (ret != 3) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if ((cmd == 'r') || (cmd == 'R')) {
+		cmd_action = HOST_ACT_GEN_GET;
+		mem_rw.value = 0;
+	} else if ((cmd == 'w') || (cmd == 'W')) {
+		cmd_action = HOST_ACT_GEN_SET;
+	} else {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	memcpy(&priv->mem_rw, &mem_rw, sizeof(mem_rw));
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_MEM_ACCESS, cmd_action, 0,
+			       &mem_rw, true);
+	if (!ret)
+		ret = count;
+
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* Proc memrw file read handler.
+ * This function is called when the 'memrw' file is opened for reading
+ * This function can be used to read from a memory location.
+ */
+static ssize_t
+nxpwifi_memrw_read(struct file *file, char __user *ubuf,
+		   size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int ret, pos = 0;
+
+	if (!buf)
+		return -ENOMEM;
+
+	pos += snprintf(buf, PAGE_SIZE, "0x%x 0x%x\n", priv->mem_rw.addr,
+			priv->mem_rw.value);
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+	free_page(addr);
+	return ret;
+}
+
+static u32 saved_offset = -1, saved_bytes = -1;
+
+/* Proc rdeeprom file write handler.
+ *
+ * This function is called when the 'rdeeprom' file is opened for writing
+ *
+ * This function can be used to write to a RDEEPROM location.
+ */
+static ssize_t
+nxpwifi_rdeeprom_write(struct file *file,
+		       const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	char *buf;
+	int ret = 0;
+	int offset = -1, bytes = -1;
+	int rv;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	rv = sscanf(buf, "%d %d", &offset, &bytes);
+
+	if (rv != 2) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (offset == -1 || bytes == -1) {
+		ret = -EINVAL;
+		goto done;
+	} else {
+		saved_offset = offset;
+		saved_bytes = bytes;
+		ret = count;
+	}
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* Proc rdeeprom read write handler.
+ *
+ * This function is called when the 'rdeeprom' file is opened for reading
+ *
+ * This function can be used to read from a RDEEPROM location.
+ */
+static ssize_t
+nxpwifi_rdeeprom_read(struct file *file, char __user *ubuf,
+		      size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int pos, ret, i;
+	u8 value[MAX_EEPROM_DATA];
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (saved_offset == -1) {
+		/* No command has been given */
+		pos = snprintf(buf, PAGE_SIZE, "0");
+		goto done;
+	}
+
+	/* Get command has been given */
+	ret = nxpwifi_eeprom_read(priv, (u16)saved_offset,
+				  (u16)saved_bytes, value);
+	if (ret) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	pos = snprintf(buf, PAGE_SIZE, "%d %d ", saved_offset, saved_bytes);
+
+	for (i = 0; i < saved_bytes; i++)
+		pos += scnprintf(buf + pos, PAGE_SIZE - pos, "%d ", value[i]);
+
+done:
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+out_free:
+	free_page(addr);
+	return ret;
+}
+
+/* Proc hscfg file write handler
+ * This function can be used to configure the host sleep parameters.
+ */
+static ssize_t
+nxpwifi_hscfg_write(struct file *file, const char __user *ubuf,
+		    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+	int ret, arg_num;
+	struct nxpwifi_ds_hs_cfg hscfg;
+	int conditions = HS_CFG_COND_DEF;
+	u32 gpio = HS_CFG_GPIO_DEF, gap = HS_CFG_GAP_DEF;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	arg_num = sscanf(buf, "%d %x %x", &conditions, &gpio, &gap);
+
+	memset(&hscfg, 0, sizeof(struct nxpwifi_ds_hs_cfg));
+
+	if (arg_num > 3) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Too many arguments\n");
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (arg_num >= 1 && arg_num < 3)
+		nxpwifi_set_hs_params(priv, HOST_ACT_GEN_GET,
+				      NXPWIFI_SYNC_CMD, &hscfg);
+
+	if (arg_num) {
+		if (conditions == HS_CFG_CANCEL) {
+			nxpwifi_cancel_hs(priv, NXPWIFI_ASYNC_CMD);
+			ret = count;
+			goto done;
+		}
+		hscfg.conditions = conditions;
+	}
+	if (arg_num >= 2)
+		hscfg.gpio = gpio;
+	if (arg_num == 3)
+		hscfg.gap = gap;
+
+	hscfg.is_invoke_hostcmd = false;
+	nxpwifi_set_hs_params(priv, HOST_ACT_GEN_SET,
+			      NXPWIFI_SYNC_CMD, &hscfg);
+
+	nxpwifi_enable_hs(priv->adapter);
+	clear_bit(NXPWIFI_IS_HS_ENABLING, &priv->adapter->work_flags);
+	ret = count;
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* Proc hscfg file read handler
+ * This function can be used to read host sleep configuration
+ * parameters from driver.
+ */
+static ssize_t
+nxpwifi_hscfg_read(struct file *file, char __user *ubuf,
+		   size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int pos, ret;
+	struct nxpwifi_ds_hs_cfg hscfg;
+
+	if (!buf)
+		return -ENOMEM;
+
+	nxpwifi_set_hs_params(priv, HOST_ACT_GEN_GET,
+			      NXPWIFI_SYNC_CMD, &hscfg);
+
+	pos = snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n", hscfg.conditions,
+		       hscfg.gpio, hscfg.gap);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+	free_page(addr);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_timeshare_coex_read(struct file *file, char __user *ubuf,
+			    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = file->private_data;
+	char buf[3];
+	bool timeshare_coex;
+	int ret;
+	unsigned int len;
+
+	if (priv->adapter->fw_api_ver != NXPWIFI_FW_V15)
+		return -EOPNOTSUPP;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_ROBUST_COEX,
+			       HOST_ACT_GEN_GET, 0, &timeshare_coex, true);
+	if (ret)
+		return ret;
+
+	len = sprintf(buf, "%d\n", timeshare_coex);
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static ssize_t
+nxpwifi_timeshare_coex_write(struct file *file, const char __user *ubuf,
+			     size_t count, loff_t *ppos)
+{
+	bool timeshare_coex;
+	struct nxpwifi_private *priv = file->private_data;
+	int ret;
+
+	if (priv->adapter->fw_api_ver != NXPWIFI_FW_V15)
+		return -EOPNOTSUPP;
+
+	ret = kstrtobool_from_user(ubuf, count, &timeshare_coex);
+	if (ret)
+		return ret;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_ROBUST_COEX,
+			       HOST_ACT_GEN_SET, 0, &timeshare_coex, true);
+	if (ret)
+		return ret;
+	else
+		return count;
+}
+
+static ssize_t
+nxpwifi_reset_write(struct file *file,
+		    const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = file->private_data;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	bool result;
+	int rc;
+
+	rc = kstrtobool_from_user(ubuf, count, &result);
+	if (rc)
+		return rc;
+
+	if (!result)
+		return -EINVAL;
+
+	if (adapter->if_ops.card_reset) {
+		dev_info(adapter->dev, "Resetting per request\n");
+		adapter->if_ops.card_reset(adapter);
+	}
+
+	return count;
+}
+
+static ssize_t
+nxpwifi_fake_radar_detect_write(struct file *file,
+				const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = file->private_data;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	bool result;
+	int rc;
+
+	rc = kstrtobool_from_user(ubuf, count, &result);
+	if (rc)
+		return rc;
+
+	if (!result)
+		return -EINVAL;
+
+	if (priv->wdev.cac_started) {
+		nxpwifi_dbg(adapter, MSG,
+			    "Generate fake radar detected during CAC\n");
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+		cfg80211_radar_event(adapter->wiphy, &priv->dfs_chandef,
+				     GFP_KERNEL);
+	} else {
+		if (priv->bss_chandef.chan->dfs_cac_ms) {
+			nxpwifi_dbg(adapter, MSG,
+				    "Generate fake radar detected\n");
+			cfg80211_radar_event(adapter->wiphy,
+					     &priv->dfs_chandef,
+					     GFP_KERNEL);
+		}
+	}
+
+	return count;
+}
+
+#define NXPWIFI_DFS_ADD_FILE(name) debugfs_create_file(#name, 0644,     \
+				   priv->dfs_dev_dir, priv,             \
+				   &nxpwifi_dfs_##name##_fops)
+
+#define NXPWIFI_DFS_FILE_OPS(name)                                      \
+static const struct file_operations nxpwifi_dfs_##name##_fops = {       \
+	.read = nxpwifi_##name##_read,                                  \
+	.write = nxpwifi_##name##_write,                                \
+	.open = simple_open,                                            \
+}
+
+#define NXPWIFI_DFS_FILE_READ_OPS(name)                                 \
+static const struct file_operations nxpwifi_dfs_##name##_fops = {       \
+	.read = nxpwifi_##name##_read,                                  \
+	.open = simple_open,                                            \
+}
+
+#define NXPWIFI_DFS_FILE_WRITE_OPS(name)                                \
+static const struct file_operations nxpwifi_dfs_##name##_fops = {       \
+	.write = nxpwifi_##name##_write,                                \
+	.open = simple_open,                                            \
+}
+
+NXPWIFI_DFS_FILE_READ_OPS(info);
+NXPWIFI_DFS_FILE_READ_OPS(debug);
+NXPWIFI_DFS_FILE_READ_OPS(getlog);
+NXPWIFI_DFS_FILE_OPS(regrdwr);
+NXPWIFI_DFS_FILE_OPS(rdeeprom);
+NXPWIFI_DFS_FILE_OPS(memrw);
+NXPWIFI_DFS_FILE_OPS(hscfg);
+NXPWIFI_DFS_FILE_OPS(histogram);
+NXPWIFI_DFS_FILE_OPS(debug_mask);
+NXPWIFI_DFS_FILE_OPS(timeshare_coex);
+NXPWIFI_DFS_FILE_WRITE_OPS(reset);
+NXPWIFI_DFS_FILE_WRITE_OPS(fake_radar_detect);
+NXPWIFI_DFS_FILE_OPS(verext);
+
+/* This function creates the debug FS directory structure and the files.
+ */
+void
+nxpwifi_dev_debugfs_init(struct nxpwifi_private *priv)
+{
+	if (!nxpwifi_dfs_dir || !priv)
+		return;
+
+	priv->dfs_dev_dir = debugfs_create_dir(priv->netdev->name,
+					       nxpwifi_dfs_dir);
+
+	NXPWIFI_DFS_ADD_FILE(info);
+	NXPWIFI_DFS_ADD_FILE(debug);
+	NXPWIFI_DFS_ADD_FILE(getlog);
+	NXPWIFI_DFS_ADD_FILE(regrdwr);
+	NXPWIFI_DFS_ADD_FILE(rdeeprom);
+
+	NXPWIFI_DFS_ADD_FILE(memrw);
+	NXPWIFI_DFS_ADD_FILE(hscfg);
+	NXPWIFI_DFS_ADD_FILE(histogram);
+	NXPWIFI_DFS_ADD_FILE(debug_mask);
+	NXPWIFI_DFS_ADD_FILE(timeshare_coex);
+	NXPWIFI_DFS_ADD_FILE(reset);
+	NXPWIFI_DFS_ADD_FILE(fake_radar_detect);
+	NXPWIFI_DFS_ADD_FILE(verext);
+}
+
+/* This function removes the debug FS directory structure and the files.
+ */
+void
+nxpwifi_dev_debugfs_remove(struct nxpwifi_private *priv)
+{
+	if (!priv)
+		return;
+
+	debugfs_remove_recursive(priv->dfs_dev_dir);
+}
+
+/* This function creates the top level proc directory.
+ */
+void
+nxpwifi_debugfs_init(void)
+{
+	if (!nxpwifi_dfs_dir)
+		nxpwifi_dfs_dir = debugfs_create_dir("nxpwifi", NULL);
+}
+
+/* This function removes the top level proc directory.
+ */
+void
+nxpwifi_debugfs_remove(void)
+{
+	debugfs_remove(nxpwifi_dfs_dir);
+}
-- 
2.34.1


