Return-Path: <linux-wireless+bounces-32533-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IDkDTGYqWm7AgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32533-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:50:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF38213D90
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4017309E3E3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077283B4EB2;
	Thu,  5 Mar 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GdbMuYxl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1FA3B4E80;
	Thu,  5 Mar 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721752; cv=fail; b=GLQGurjM/O2W9OEtvz1K7YLgV1SavwQGa3U54ryGxH96qbEamNBhy1mXsRMOxYVrFIPKlCULCmUKxZybfRAWJSYh8AVcIXkH8kluh4QNc4Fm0rglEP37eNdTuczMNLVQLOU9W5Wp5v2IhND3H2Rne6+AIq07RDcUMfesJjE2kuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721752; c=relaxed/simple;
	bh=07RN3/Mj/SHKIAvbLZXzs4BZNxocDkkpvecjSnVk5Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOsDkeHnrDO2lbdrwIwJE3P23IOGbaz2j2gOsVb4iRklvCsb00CJsJV2A10AFdpjzIkt0LJVvZcYg87LAy++iIwtGG7pXkUu4qsaZgTYvpLjVnemHnZ0ATH4gyzwBCtuNQ2QcaaTG04986R+1sg6jsz+f9aTDwqrZJs0ViPV5TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GdbMuYxl; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIsGT+BlPxk4FWouGRz11tqBcAekJcBjyLRC5ByJuqeKbeAMsyklgmQ39RA1N0HE2idCDmnGdoOyUuUrPoimUAnGbFVWrLEMKlyu2rSHXgPBePcKcc/ajM3pt8OGQmqvqIftO7n12PcZAXncaNMJNfh5d0oUQ2KRgRU8mr6wpv3wea18yxyL5WA/17DsiOt7NVaS0nYRAm9sJFa2owHQgofkWScUQTxxKQnRtu3Huxzct6qyGB5leNCi5TXb/eo8+KgjjBDIR8JqRu9hfxpvbhR/egcrdvQwn3vyYtNDIQ83BMKDxD/wJh/HUuNCLOLF52cJxnaeAKEPEaimPoXlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSJ2YXUkPkY3ny8iegz79t9rUndaumJ0OTPwPmATLtM=;
 b=H6AC00aW4p10Zo7xmRHCr5TABfm8Q2lVxbQZ92fNz53ZQQarzV8LqiORR6wl1Qi7sU70Bfc4zkMuuDVax46T/bCcE6p2f3nf/V0kAMySO5+J1qfEx4oQtSA/4SZfdNiQ9mPLRcM8QINNd0cMYkKRVVcM0XlAeWxH4oMT7SFMAdWL4xH3hH239nra9bAzev07sh0wsYB5QOUvApbvMi1qjOmb58/b+hhmymhkhHfjdMTzaZQKMrEE5YYAvUpHKFDNVlx0pljSOMqxlS3/PW5Iv0aaPryGtix2/j2YOsuqgeb6FDs3tAP6hii8izDAeUz5kCfDJipL7RjCjtsuc2jA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSJ2YXUkPkY3ny8iegz79t9rUndaumJ0OTPwPmATLtM=;
 b=GdbMuYxlYN55EIk35fLap2e45gzygKvJON39ZHL57swtei11pfJpOMWxAnQHSAuoRORJ4zwDZAJx1fTTIaoXTo4UMuG6mJYu07ihaiIZC6COaVVSFBFlFG8Tpr/bxvIL2Hq5+A2zWvyvjArb5U4dzbx0JGn3dX5vZjRh8YWwKYUYHazoTG/1Fxy/KqeMiANauQX1HsyICM71lr+aKKcNnVlF3ItymrdGTwlECv1PRwue/Pd5oejtbv0mEtwVww2ZZzJ1ax+US2HwHAE6BlGvfIC47VGo5aU5owPIsC+s8wpD6YckwNP9K9CrF8Dimi2NJPAuMbG38gFO+eJna74f0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by VI2PR04MB10145.eurprd04.prod.outlook.com (2603:10a6:800:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 14:42:25 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:42:25 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 14/21] wifi: nxpwifi: add debugfs support
Date: Thu,  5 Mar 2026 22:39:32 +0800
Message-Id: <20260305143939.3724868-15-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|VI2PR04MB10145:EE_
X-MS-Office365-Filtering-Correlation-Id: e302630d-a7b1-452f-c725-08de7ac56ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	zSQrBOhh2ifNZbwBActtQXlQ3fZCmS1E22i6zrGkqc1Fm1FWQRqOkr0ceDesjUMcPtL6Xn/mALh7RlAGlXp93volRn8cbJ6IxhdPilzm+GRuTYX4vYP1wo+CD8VbUIkCJL7vxyebx++Bb0DCefVNEbI7/KKYyHLtEr2bZZwYupfer2L9jdulNgyaQe4nH7zMtsZxFCDmzLgj6PdscQrXTzALWNJGl9n1mPzaX8UZcQCfQV3OECPNomgxeyDIp7OKWxyM6J1izLAtHkxWEE7KBKqHoL+F5klSqWgaRDfhCHexH7znLBg+0xiIvMVGkczE3s0f0TjSYT+DxnAEI5aMaldPXQdOjfq/ezFlGttoFQD3GdO2Ulrm8hGQ7+1uA3iMoET+1t3jo/XxevlBQCVsd/wIqmfmvjGUYy1mxCqBXD+NdrrgAKuo1Fquyqp1um+pRovmL88jRn97G4HhABJ/STbyUcowg92xeutY0oGXb9spZmlTQpcCr158Qb1XgpkbQBDba2HRlLBZR8P5+ex3JmZN9Pi+tAHQQYYceqzybY6WYrS0Nx6eznMWXryncObGtimHzhANBTfFLuurnlgCzEYq1L5PqbgdwitOdwJF4XFBMBvatISgmeYIJWFzfKEPyAjgthKY6T5UI/if7D2jbbwyXNza2bOTq4YDDyHyXIQD3B4LVb9ea/wdR/FjFIPrVeqCtE9GF0+CBe7Ket5AsApaX4W/hFUijpK0hyKhiD0eJeQphFH6YUlhUFiofnFDg1MHcRVMv7tULwQnZDjXkshlWbH3kyNU9HGEN7+EHuk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eQeHiJNAJQ0IGS4JxgCEa5V3UB8efX/mNaFnGx2nTnmWXm/Eev7Jh5/Y2omB?=
 =?us-ascii?Q?etveDP7d6TFs1zwxtsMF7FdW9V1w5SxXEL43kVs6+HZjW94s+6wR2GLTWtQU?=
 =?us-ascii?Q?hJJ+cciydvVv6qbZjMdv5EjOsoyF4wpnYXbl9PhixlDiwqKPVqMcbCPUVu6f?=
 =?us-ascii?Q?dMown9QlRVyFY5Qe886F4ipGpRMaCeU7a1Uh/VprPupajMCcGmVJXnCsd7Yx?=
 =?us-ascii?Q?bOK/vWx+TiIGpi49fwTgxel/fzsO6rQ0TAZJUssfjsw9y4sE7zNP8zrK33Tn?=
 =?us-ascii?Q?TTmIbQ3vCyiDzBpcmej1TxAnHRsoxT0SuKyOXaODWRNpSVXAn0C02Qtgbs3u?=
 =?us-ascii?Q?VR/8Ty5wupAyxDI+BevPa1b2Uaqc4LFedrwdbQEtktiMUDhesie8xEVDmiy9?=
 =?us-ascii?Q?L92PfFix6Yech7MDL0YGX+IpJIv8CY16oM0aihDl4rmpn2P3dTlu8cgyatIu?=
 =?us-ascii?Q?HP6VmQxDkvISJlFgP26nkGa4R3wXS7wrCj8e3xUguXyhc1dfM/59Bk56htRl?=
 =?us-ascii?Q?MdF2mPYyFAnCmXOgNNYqHN7RmCtoV+z2tAi5ThSHO4GA0kmqhLqrDKxyIcMA?=
 =?us-ascii?Q?QQ2Z3OBT273faX3fD6rwcqv/fAX/DIKo/0BIOdsgen7xkmMR3jeiSjEh+pHa?=
 =?us-ascii?Q?Gi9+xtC9bS97GGDZKj4YeDBo6SlLaup87HvzoEpoWsu8tlTP3PMdsQ+izK7t?=
 =?us-ascii?Q?gSmIZXlKILhkEcy5Xu13e23arglZ7nBxQjDIzobMiWTpg7CDlY2aRRtvQJET?=
 =?us-ascii?Q?epdguW5U3SzyL8iHb2RuRqPXG6nHs2tQpzPA07jrEAGXJmGDsuWAuJDHUYB4?=
 =?us-ascii?Q?G17jIAuS6LxVdTkvUL5XhemMzJ+FzrrF23uF4Apo7J2mNVItesmB+q+usN0g?=
 =?us-ascii?Q?ZUF7NDKbCSI6ZigLjoFaaCekIKhDnsG0YF4D7PGV1Ay+cEiFVDsDN7oEp2Gg?=
 =?us-ascii?Q?DAzLEZWWfUKTGxivNGRB5zQLiF0cENzUD60re7hMEFiM0VSuHH/JzWXVrRpj?=
 =?us-ascii?Q?wRU6Cn3quCrMMvG7enLG1v+OZMAJF5ie/78DqaQOMnC1CKkS1IGHj3KOoSwT?=
 =?us-ascii?Q?2CZvtBKsJPnqn4QTx/Cd2WviNWPwNhVL3JiLBvPX8Ur7irZ7QdGNQaQx48gp?=
 =?us-ascii?Q?gUarvgiCAe81CR0lYeCrExQFDHqZETSi5nBjtaej/xL3lDjs04WDm2umzZFM?=
 =?us-ascii?Q?OlGHtiKYYfLFylVtlxdblpU1fwOV7kjSQ8Fkw34X1SS4mTW1V730XevQd7QM?=
 =?us-ascii?Q?gpK9dmd6THe6rPb2dOCM1PaQB2RHQ/qfQX2c264ntB3QW/AtizYB4BWxLuLd?=
 =?us-ascii?Q?bXTk1p4J5yuQEDwS5k6cda/+KLcKs2JNbCqoqbTnnBq5K1bwTZuY5BYRvc6o?=
 =?us-ascii?Q?jcRammY6LpmjtXIpcZClW2uWNyj3eoUf/atUPGSD1Cu/RL9t38g/OXe6q9pM?=
 =?us-ascii?Q?lRgkn9931+uDMd3ZqgV9ptTWGMkr7zZwzFyapYLuLVG7gcZtJSMOzjo5J38r?=
 =?us-ascii?Q?l1KgXDdu0ATTMu9BikZlBo7zxFZbgmeVejQc6ISe2fddKH4gWFNkfVTq3MKr?=
 =?us-ascii?Q?Ip0PYgD/GpNd9rCu3qnnDofnOkfen/KaxD/sxzIVUdk1FY6SwFzj1q9/JS/6?=
 =?us-ascii?Q?rVw7n9e75be0VpPpkM+UjTUtd2NEOh5jsOjltBL4pDME/PSYD00AwYg0vuTR?=
 =?us-ascii?Q?8aZ8k1h7g6UAdFDl9JtV2Fjuwg0Nci947X90Hk2bEMESaOVwyJpumT5TFdrr?=
 =?us-ascii?Q?5WrDtBkyAA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e302630d-a7b1-452f-c725-08de7ac56ada
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:42:25.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbzRdurRjrgUOW8PN7WhlJo9dU8N8GVNM3/k/ZPhTkFZvCvi18QONoUaaNE/tWtliFUp7kljw0N8tqz7C0tumA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10145
X-Rspamd-Queue-Id: AAF38213D90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32533-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

Add a debugfs interface for the nxpwifi driver to support diagnostics,
runtime inspection, and testing. Provide entries for examining firmware
state, driver statistics, power-management information, and radar/DFS
behavior, helping with both development and field debugging.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/debugfs.c | 1094 ++++++++++++++++++++
 1 file changed, 1094 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/debugfs.c b/drivers/net/wireless/nxp/nxpwifi/debugfs.c
new file mode 100644
index 000000000000..ccaf0eae37e3
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/debugfs.c
@@ -0,0 +1,1094 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: debugfs
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
+/*
+ * debugfs "info" read handler: dump driver name/version, interface, BSS mode,
+ * link state, MAC, counters; STA adds SSID/BSSID/channel/country/region and
+ * multicast list.
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
+/*
+ * debugfs "getlog" read handler: dump firmware/802.11 counters (retry, RTS/ACK, dup,
+ * frag, mcast, FCS, beacon stats).
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
+/*
+ * debugfs "histogram" read handler: report sample count and per-rate/SNR/noise
+ * floor/signal strength histograms.
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
+/* debugfs "debug" read handler: dump adapter debug info and BA/reorder tables. */
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
+/*
+ * debugfs "regrdwr" write handler: parse <type offset value> and store for
+ * readback/IO.
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
+/*
+ * debugfs "regrdwr" read handler: perform pending register read/write and return
+ * <type offset value>.
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
+/* debugfs "debug_mask" read handler: show driver debug mask. */
+
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
+/* debugfs "debug_mask" write handler: set driver debug mask. */
+
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
+/* debugfs "verext" write handler: select extended version string. */
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
+/* debugfs "verext" read handler: show extended version string. */
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
+/* debugfs "memrw" write handler: read/write firmware memory (addr, value). */
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
+/* debugfs "memrw" read handler: show last memory access result. */
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
+/* debugfs "rdeeprom" write handler: set EEPROM offset/length to read. */
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
+/* debugfs "rdeeprom" read handler: dump EEPROM bytes from saved offset/length. */
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
+/*
+ * debugfs "hscfg" write handler: configure host-sleep (conditions/gpio/gap) or
+ * cancel.
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
+/* debugfs "hscfg" read handler: show current host-sleep configuration. */
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
+		nxpwifi_dbg(adapter, INFO, "Resetting per request\n");
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
+	if (priv->wdev.links[0].cac_started) {
+		nxpwifi_dbg(adapter, MSG,
+			    "Generate fake radar detected during CAC\n");
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
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
+static ssize_t
+nxpwifi_netmon_write(struct file *file, const char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_802_11_net_monitor netmon_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+	memset(&netmon_cfg, 0, sizeof(struct nxpwifi_802_11_net_monitor));
+	ret = sscanf(buf, "%u %u %u %u %u",
+		     &netmon_cfg.enable_net_mon,
+		     &netmon_cfg.filter_flag,
+		     &netmon_cfg.band,
+		     &netmon_cfg.channel,
+		     &netmon_cfg.chan_bandwidth);
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_NET_MONITOR,
+			       HOST_ACT_GEN_SET, 0, &netmon_cfg, true);
+
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_setup_write(struct file *file, const char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+	u16 twt_mantissa, bcn_miss_threshold;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hu %hhu %hu",
+		     &twt_cfg.param.twt_setup.implicit,
+		     &twt_cfg.param.twt_setup.announced,
+		     &twt_cfg.param.twt_setup.trigger_enabled,
+		     &twt_cfg.param.twt_setup.twt_info_disabled,
+		     &twt_cfg.param.twt_setup.negotiation_type,
+		     &twt_cfg.param.twt_setup.twt_wakeup_duration,
+		     &twt_cfg.param.twt_setup.flow_identifier,
+		     &twt_cfg.param.twt_setup.hard_constraint,
+		     &twt_cfg.param.twt_setup.twt_exponent,
+		     &twt_mantissa,
+		     &twt_cfg.param.twt_setup.twt_request,
+		     &bcn_miss_threshold);
+
+	twt_cfg.param.twt_setup.twt_mantissa = cpu_to_le16(twt_mantissa);
+	twt_cfg.param.twt_setup.bcn_miss_threshold = cpu_to_le16(bcn_miss_threshold);
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_SETUP_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_SET, 0,
+			       &twt_cfg, true);
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_teardown_write(struct file *file, const char __user *ubuf,
+			   size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%hhu %hhu %hhu",
+		     &twt_cfg.param.twt_teardown.flow_identifier,
+		     &twt_cfg.param.twt_teardown.negotiation_type,
+		     &twt_cfg.param.twt_teardown.teardown_all_twt);
+
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_TEARDOWN_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_SET, 0,
+			       &twt_cfg, true);
+
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_report_read(struct file *file, char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+	ssize_t ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	u8 num, i, j;
+
+	if (!p)
+		return -ENOMEM;
+
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_REPORT_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_GET, 0,
+			       &twt_cfg, true);
+	if (ret)
+		goto done;
+	num = twt_cfg.param.twt_report.length / NXPWIFI_BTWT_REPORT_LEN;
+	num = num <= NXPWIFI_BTWT_REPORT_MAX_NUM ? num : NXPWIFI_BTWT_REPORT_MAX_NUM;
+	p += sprintf(p, "\ntwt_report len %hhu, num %hhu, twt_report_info:\n",
+		twt_cfg.param.twt_report.length, num);
+	for (i = 0; i < num; i++) {
+		p += sprintf(p, "id[%hu]:\r\n", i);
+		for (j = 0; j < NXPWIFI_BTWT_REPORT_LEN; j++) {
+			p += sprintf(p,
+				" 0x%02x",
+				twt_cfg.param.twt_report.data[i * NXPWIFI_BTWT_REPORT_LEN + j]);
+		}
+		p += sprintf(p, "\r\n");
+	}
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+done:
+	free_page(page);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_information_write(struct file *file, const char __user *ubuf,
+			      size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+	u32 suspend_duration;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%hhu %u",
+		     &twt_cfg.param.twt_information.flow_identifier, &suspend_duration);
+	twt_cfg.param.twt_information.suspend_duration = cpu_to_le32(suspend_duration);
+
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_INFORMATION_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_SET, 0,
+			       &twt_cfg, true);
+
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
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
+NXPWIFI_DFS_FILE_WRITE_OPS(netmon);
+NXPWIFI_DFS_FILE_WRITE_OPS(twt_setup);
+NXPWIFI_DFS_FILE_WRITE_OPS(twt_teardown);
+NXPWIFI_DFS_FILE_READ_OPS(twt_report);
+NXPWIFI_DFS_FILE_WRITE_OPS(twt_information);
+
+/* Create per-netdev debugfs directory and files. */
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
+	NXPWIFI_DFS_ADD_FILE(netmon);
+	NXPWIFI_DFS_ADD_FILE(twt_setup);
+	NXPWIFI_DFS_ADD_FILE(twt_teardown);
+	NXPWIFI_DFS_ADD_FILE(twt_report);
+	NXPWIFI_DFS_ADD_FILE(twt_information);
+}
+
+/* Remove per-netdev debugfs directory and files. */
+void
+nxpwifi_dev_debugfs_remove(struct nxpwifi_private *priv)
+{
+	if (!priv)
+		return;
+
+	debugfs_remove_recursive(priv->dfs_dev_dir);
+}
+
+/* Create top-level debugfs directory. */
+void
+nxpwifi_debugfs_init(void)
+{
+	if (!nxpwifi_dfs_dir)
+		nxpwifi_dfs_dir = debugfs_create_dir("nxpwifi", NULL);
+}
+
+/* Remove top-level debugfs directory. */
+void
+nxpwifi_debugfs_remove(void)
+{
+	debugfs_remove(nxpwifi_dfs_dir);
+}
-- 
2.34.1


