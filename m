Return-Path: <linux-wireless+bounces-13287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37597989A92
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A962F2831FC
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C415380B;
	Mon, 30 Sep 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="azBKDeii"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0147B15098F;
	Mon, 30 Sep 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678262; cv=fail; b=WkiyaHMHGx+9vpCJ5nGgwMQsBliPGXsgigwlhBh3DpjneoimP9OKgJxZx/qOtac7le82OC/iJJ2oQ5RD4DRa6ekkJcyPIDYVOJx2EYoOPi/ZtUSS0MmqNSGQKUw8wiTMB4ZYXsffYuq50OqjGuaSCZZtwkBH8m/d0N54XqE18nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678262; c=relaxed/simple;
	bh=jNep0sI2fAyiX/Wwn7FxlO9lDarKLe034MBc82q+H7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJdPn0upOjL8fG1rGoocM9a5fy6xkOvH5JGbr9zQSt7TXIuyHWEGWcWS3Z+rm1z4HglbopP/wskwM6GydXwijF/YUMTNwenpk18XRbxMmrOj/6Onf3K5096h9Pu4FKDOJHXN98xQn1etamAeiGYjLywuJVpWkbmsRqKh6WmW1PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=azBKDeii; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGU7JNAlDGr8vf7M4L5U3cyQs4HAIAOJitD3zn0mQ6ADpQfylz5H5e7hFkYywhIkxxhJ9PtbTataw3P14mv54y/OO5OLWs236CjwJfK3HYgD4d/NnXwd9ewgX697OMf9p0EfCGV2/qfw9YBKQUCxDzJyY9tQtYdk+P/3+TOzCxMX0oMbZwGjc0IJ0DIPh5lJmJwMPHIdeRMI/d0p7l/AnFwSzo2cWAUdK5JnhSMNvNeR/M091zfZGvUWfWvrjHW/ox2SR5Z5KU8zRk7ECTxzw/etBFEA/pZzpg1cGhGlbLaMdQ7GeBcs+4brE2sMp1thQkoctUrlW0oxGHFIeiK8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUAxdtkboWmu261KiDlKFxQKJXn8Jc2UPPpJzsyOcsY=;
 b=HyyeHZoBfaoowKCzHKpJpe1n9hNJsxwdS57hdNW2GIXpEfLxe+9FqYMrIwrBldLP/KvbKsIXHnntTv+bQJgR/m37I1ZAoa/zve/KL6RHmvmQcNnfH/PJvC5F78sUkt9/0qV1XwotdzxXH0cp/mvhtxJiMWTojXliqb25amhpua+X9Fh7GKdiUDn5MHuPWCWFOzOz0ju9Kp/VtX3s6ObtNwQh1x9yafu0Ty3t1EHG6HwTq2gYaSqkHiXqZ+kLBspdMg1om08OJTkihUXT63L7F88r8NxJimKQRykWiv2sAEsDTlb00Qj4FRAfpX0rQoLMn8ItjVsWzj2DrDf2jb5hDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUAxdtkboWmu261KiDlKFxQKJXn8Jc2UPPpJzsyOcsY=;
 b=azBKDeiicLKrEsDR45mivEkA0ymBii9kmruWqTngrz4AgJz3tUIQbdnNGbIjjdWFNWIXyX4em6fABdKEw9c0CVI2UyWLSh85kNnS34hW2vwDCMLunR8rF7tTPEm4DS0SlQ+no6uyoXd0xlRH7x6z9o2MWhmZQBkoMnxyP/1rCMW7flLmNnodKnMkpNJZYSYaxeOUXZtoouxcPv1/h1ClyCNcRVAM4EXqbV/schPBM7v/P9nFUOELCcmpfqzcP7/vlNoATynul62IY0+m1Mi7nhoD8CagwrRrDU2n4Cppaw/eEt72ZK6ZPN7e0P3o/9JoIGbYqLLmiMVJ5TFW4guqkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB9000.eurprd04.prod.outlook.com (2603:10a6:10:2e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 30 Sep
 2024 06:37:34 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:37:34 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 02/22] wifi: nxpwifi: add 802.11ac files
Date: Mon, 30 Sep 2024 14:36:41 +0800
Message-Id: <20240930063701.2566520-3-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DU2PR04MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c950705-b719-4bf8-3a2a-08dce11a5dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VD6gP3DdF4HW++SZyBnrxlOQhCuJXXoH2WL70edAWCWHxdG5VKecAYMsIwLg?=
 =?us-ascii?Q?zDyFHynLsUvZloMiPgwti9sLSF4LBip0axnPwdnkPkWYAr+oSNoKhONN3bQK?=
 =?us-ascii?Q?sPSDt3h73S/cI1yNri0w3MbwN5buuWz2uNBv1ZWwy55J5yT/U4B2XbWEQxX+?=
 =?us-ascii?Q?IzX/vOoHh80EDcVk/crEFWiHsdA4016ARvg9BVHzeRmeWmpOfZ+lvAJdnvQv?=
 =?us-ascii?Q?B6b/d2kIK47fTiRMtbAYDBrVAA0OyMmd2w48UwQzFZ7fSrW21cDvsZZvC05+?=
 =?us-ascii?Q?lSH1kdN1fHc7I43pLWr2dURYilPjKz14iurG5lRmwiYU9abkAXDbO+XTzf1O?=
 =?us-ascii?Q?GYJxXGYd83foF8eXffzgfmMBP82oZr6aBqcICBecC00V1vnflktSQjmC+Qsj?=
 =?us-ascii?Q?+5fcLMwkfkL3txBzE71ewN2V6Ax2v6xqhCK9jK8LsoLYCnKKbiTcepbJoPfT?=
 =?us-ascii?Q?jgf5Dm7ahB0nBpAgJ1lHwf4tTCB+uzoBUKkFoFa81JBYK1kjU0XlMRhQnnH+?=
 =?us-ascii?Q?GFhy0UWWvglv8O6LGCfRsH/nvUateMHbw1smSitgHUNxwnpLHtkDNYhbuOL3?=
 =?us-ascii?Q?VHRgtgBdWXc54G6iJyYiv2seRn5+VhfJ23jflgmbAnjlHvVxsi7scMAXu+yR?=
 =?us-ascii?Q?zQ/FDBEcgxVKrfoWzIikFYvl+G4lH10BqdvUM7ElAYYErThNv5nyLuvA1dLd?=
 =?us-ascii?Q?2XxPo+/7ORQ+MNa64IW/jiRT1nucBdEYoiil2FztTRtYxWioDiCNd1xXDOAS?=
 =?us-ascii?Q?l9yo4RmqdVIHUeHPmx1vAe7j4MVttlLlKwyW2JO5yPP3wEotYd4Os9FfOT4Z?=
 =?us-ascii?Q?snS1srPqzU+o4hvU+6VHhkE107+NNUZiU6vPEOFm2FaOwUTHlMPj3pjkNzxp?=
 =?us-ascii?Q?bdkQ+AdttY3zgz1epDux0AhS0bQJ4HnTF18J+vuFoWU12142g2KrYnbgdcY0?=
 =?us-ascii?Q?3aRGzCMEdo+oaGySYMAA9nSFhJBjAc0mwaGT0/NEq1Lakq4/RZ7wi6nugufm?=
 =?us-ascii?Q?SZVYgFo0sXKILeGsaBjh2HYha9h/Su7DJWyXDKj79OY4ZA8pFTrkAe51djsB?=
 =?us-ascii?Q?WR0+s4OYrf8WaG4Vcm0NHFIh+egvIZU1qU1aorKJE9iC8WVckxvxgxlSfaO9?=
 =?us-ascii?Q?jItJuqQNzQ5w/EhtBYGZ4nNsU60rfaVLQKo3D60mnSwdkGOfaPLgD9x1K3RT?=
 =?us-ascii?Q?dRl5Oy/u7O8i7W2rTDl6QxWEypT4gt1BX7nMB4bURr0qvLmrCgGOCtNJ/HZB?=
 =?us-ascii?Q?5JTUWn5djzOeiuZMKsFMJm0PZyyJeDyuFF3niiZi914rUK76KhNBbKJMDz8K?=
 =?us-ascii?Q?bm7wC7eZJ9JDkIPJFuf1oKcMutp9KoVZInGZJXg+JZJYAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UsxnBR49/jtKl/VRksn4XMwmMTywPOlYuR4QrHjS7HDhjdr1TsXPWn08TyoH?=
 =?us-ascii?Q?pmICr01i78dXu+akZK3cwXQtyK3Hbq9w1+cA63UjmAcDkHMg7UJEyFwvlJDw?=
 =?us-ascii?Q?fIOtMsgH2Q5bknzDJFfp2Ka1NCApOT8xpbz7cOLKdVnmbOy5bv00c47wj5Iv?=
 =?us-ascii?Q?8oHUG/Exh3F2SenSr82KOK5BodhV7HIVe1M3qflDAbzQpnByYtrjXFWlU9v8?=
 =?us-ascii?Q?hUge9mTsWRKogWuuSJhX64W5V97pgzrFwQtwQ11odM1Of5Izm/lRFrVTgsmZ?=
 =?us-ascii?Q?HMYZs6+L6dq7kekATX+c7kiN+hgbiFh8sqa/UXOpk6nXHw6Lc8lY7+3UC+YA?=
 =?us-ascii?Q?e6mjaqM2LLZ033WMH8ZnCj1I0BPCrezfWgTyvrvkr9XDoTzz5gEQc3tvwmAT?=
 =?us-ascii?Q?Yese9+Zk0iqwl6+KsHpXfDYkucXJox/Dpy72kqUf1B7QnbSS0JwbRso1FIFb?=
 =?us-ascii?Q?bH7aprhlZKYAO6OCBGJNBkdQanO9j51Sc/qrGC7Fg+23UmdDZSkAiEoiP+Rt?=
 =?us-ascii?Q?ac71phfUVV8GBwRwkTt3Cl/q12gIZQGXPB3iYSne3Pxvskj8N0pKdEgSJm3E?=
 =?us-ascii?Q?zgdfhMmFLdD0HU8faSMgwNAhnQckT7qsROaIMuDu+GAOCw0lsr1QjXu2fXZL?=
 =?us-ascii?Q?P+eFDwQhwsXLZTIgSC8cKA+vhfFE9S3oxSHu37mDBY+DhocnFAiGZ2ljqApe?=
 =?us-ascii?Q?b2CRL5P08aVxLNampkEB1TobkEhRj10qCUqLbut4xxKioXpEsfi2zwieETE6?=
 =?us-ascii?Q?1l4eDs55dMJrfnRQOKbkLWkuFQ4DBEwoUC+13ZnuPUNn+cY5rNKSz1napgEN?=
 =?us-ascii?Q?1HaxeHbd3ztbyCsTBGls0R5BgyiA1Zar0LP5cXbG0BWsPslPiSTS6pIGhz3K?=
 =?us-ascii?Q?I4ZDHWAjmExX8dQNrCqvRT4Mk78byPhzEQ99SZRj400ewhzGeYpbdFbT1vmD?=
 =?us-ascii?Q?x1R9VFsUqPu7g4ztFPHUeCs1QgfC7kb33EbcxoqBnyV+bfE5NPq3kpHKEij5?=
 =?us-ascii?Q?LSRfjMseG+jxxGQD2nbrbyIhRIPdosVpOHzPCBs0U2JVx6SFITK23CGN69aL?=
 =?us-ascii?Q?OSH7RbwogGZWw1mOEUC2ATxxMxE3FuSl68jZaG1zZpyRyVsKYf1I2GCXWaVx?=
 =?us-ascii?Q?ciQdEM2yaqnSABCBYkUolP5VbgavGaZhwy5ed21MBe74ejQ8wcO6sAt+5gFc?=
 =?us-ascii?Q?er4NQre2uZ82bJ9RV8LPOMT9mGBq/RZYl8wkA/auPCsMKQBrwBYKprzZiRFU?=
 =?us-ascii?Q?YRexgmZefzxSg8JGJsVdFe+yQa6FE4isVv24odEYZ5EDdtmrJ3DKE0xCRml3?=
 =?us-ascii?Q?Dpzucp1kt6gzvcxS/U2atvfMdMw8zwRjSqvm3VrLm96RuPYbF7LUqpJmbbTn?=
 =?us-ascii?Q?9GhGzwP0MDLx2VfRxoMo2JdMFCaxfYAN2pjl8F+KZC6QErXAv8kukQ+9oEb7?=
 =?us-ascii?Q?RcuMs5BIObIkdE52NLGcr/5uPFExyUomNIYejANdABTnQ80yn0E7c6Gcj9S/?=
 =?us-ascii?Q?0u3jpDvq7X3eSknJBLwSm7fCbhPd6gqc+M2HS4dMK12nS5BbBqGcbCdM8ji0?=
 =?us-ascii?Q?NScLPBThITmrqo+LkuDM/9RdugiJzct4PPKKm+BQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c950705-b719-4bf8-3a2a-08dce11a5dd3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:37:34.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0koEsLoQb8D2ol+n/XTTsUHVmA0SZ4A8LR4nU5vzBF1ajSpvUWzun7l+mvCxnE9bKrZJDC3H8pIHFvxTh4VN3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9000

For client mode, NXP firmware will help association process via
host command HOST_CMD_802_11_ASSOCIATE. IEs for 802.11ac should be
converted from parameters passed from cfg80211 to TLVs appended
to host command HOST_CMD_802_11_ASSOCIATE.

For AP mode, IEs for 802.11ac should be converted from parameters
passed from cfg80211 to host command HOST_CMD_11AC_CFG.

Files in this commit will support 802.11ac features based on above
descriptions.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 288 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ac.h |  32 +++
 2 files changed, 320 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..40079e43c571
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11ac
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ac.h"
+
+/* Tables of the MCS map to the highest data rate (in Mbps) supported
+ * for long GI.
+ */
+static const u16 max_rate_lgi_80MHZ[8][3] = {
+	{0x124, 0x15F, 0x186},	/* NSS = 1 */
+	{0x249, 0x2BE, 0x30C},  /* NSS = 2 */
+	{0x36D, 0x41D, 0x492},  /* NSS = 3 */
+	{0x492, 0x57C, 0x618},  /* NSS = 4 */
+	{0x5B6, 0x6DB, 0x79E},  /* NSS = 5 */
+	{0x6DB, 0x83A, 0x0},    /* NSS = 6 */
+	{0x7FF, 0x999, 0xAAA},  /* NSS = 7 */
+	{0x924, 0xAF8, 0xC30}   /* NSS = 8 */
+};
+
+static const u16 max_rate_lgi_160MHZ[8][3] = {
+	{0x249, 0x2BE, 0x30C},   /* NSS = 1 */
+	{0x492, 0x57C, 0x618},   /* NSS = 2 */
+	{0x6DB, 0x83A, 0x0},     /* NSS = 3 */
+	{0x924, 0xAF8, 0xC30},   /* NSS = 4 */
+	{0xB6D, 0xDB6, 0xF3C},   /* NSS = 5 */
+	{0xDB6, 0x1074, 0x1248}, /* NSS = 6 */
+	{0xFFF, 0x1332, 0x1554}, /* NSS = 7 */
+	{0x1248, 0x15F0, 0x1860} /* NSS = 8 */
+};
+
+/* This function converts the 2-bit MCS map to the highest long GI
+ * VHT data rate.
+ */
+static u16
+nxpwifi_convert_mcsmap_to_maxrate(struct nxpwifi_private *priv,
+				  u16 bands, u16 mcs_map)
+{
+	u8 i, nss, mcs;
+	u16 max_rate = 0;
+	u32 usr_vht_cap_info = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_AAC)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* find the max NSS supported */
+	nss = 1;
+	for (i = 1; i <= 8; i++) {
+		mcs = GET_VHTNSSMCS(mcs_map, i);
+		if (mcs < IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			nss = i;
+	}
+	mcs = GET_VHTNSSMCS(mcs_map, nss);
+
+	/* if mcs is 3, nss must be 1 (NSS = 1). Default mcs to MCS 0~9 */
+	if (mcs == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+		mcs = IEEE80211_VHT_MCS_SUPPORT_0_9;
+
+	if (GET_VHTCAP_CHWDSET(usr_vht_cap_info)) {
+		/* support 160 MHz */
+		max_rate = max_rate_lgi_160MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 is not supported in NSS6 */
+			max_rate = max_rate_lgi_160MHZ[nss - 1][mcs - 1];
+	} else {
+		max_rate = max_rate_lgi_80MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 is not supported in NSS3 */
+			max_rate = max_rate_lgi_80MHZ[nss - 1][mcs - 1];
+	}
+
+	return max_rate;
+}
+
+static void
+nxpwifi_fill_vht_cap_info(struct nxpwifi_private *priv,
+			  struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_A)
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_a);
+	else
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_bg);
+}
+
+static void
+nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			 struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 mcs_map_user, mcs_map_resp, mcs_map_result;
+	u16 mcs_user, mcs_resp, nss, tmp;
+
+	/* Fill VHT cap info */
+	nxpwifi_fill_vht_cap_info(priv, vht_cap, bands);
+
+	/* rx MCS Set: find the minimum of the user rx mcs and ap rx mcs */
+	mcs_map_user = GET_DEVRXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.rx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.rx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.rx_highest = cpu_to_le16(tmp);
+
+	/* tx MCS Set: find the minimum of the user tx mcs and ap tx mcs */
+	mcs_map_user = GET_DEVTXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.tx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.tx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.tx_highest = cpu_to_le16(tmp);
+}
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_vhtcap *vht_cap;
+	struct nxpwifi_ie_types_oper_mode_ntf *oper_ntf;
+	struct ieee_types_oper_mode_ntf *ieee_oper_ntf;
+	struct nxpwifi_ie_types_vht_oper *vht_op;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 supp_chwd_set;
+	u32 usr_vht_cap_info;
+	int ret_len = 0;
+
+	if (bss_desc->bss_band & BAND_A)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* VHT Capabilities IE */
+	if (bss_desc->bcn_vht_cap) {
+		vht_cap = (struct nxpwifi_ie_types_vhtcap *)*buffer;
+		memset(vht_cap, 0, sizeof(*vht_cap));
+		vht_cap->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		vht_cap->header.len  =
+			cpu_to_le16(sizeof(struct ieee80211_vht_cap));
+		memcpy((u8 *)vht_cap + sizeof(struct nxpwifi_ie_types_header),
+		       (u8 *)bss_desc->bcn_vht_cap,
+		       le16_to_cpu(vht_cap->header.len));
+
+		nxpwifi_fill_vht_cap_tlv(priv, &vht_cap->vht_cap,
+					 bss_desc->bss_band);
+		*buffer += sizeof(*vht_cap);
+		ret_len += sizeof(*vht_cap);
+	}
+
+	/* VHT Operation IE */
+	if (bss_desc->bcn_vht_oper) {
+		if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+			vht_op = (struct nxpwifi_ie_types_vht_oper *)*buffer;
+			memset(vht_op, 0, sizeof(*vht_op));
+			vht_op->header.type =
+				cpu_to_le16(WLAN_EID_VHT_OPERATION);
+			vht_op->header.len  = cpu_to_le16(sizeof(*vht_op) -
+				sizeof(struct nxpwifi_ie_types_header));
+			memcpy((u8 *)vht_op +
+				sizeof(struct nxpwifi_ie_types_header),
+			       (u8 *)bss_desc->bcn_vht_oper,
+			       le16_to_cpu(vht_op->header.len));
+
+			/* negotiate the channel width and central freq
+			 * and keep the central freq as the peer suggests
+			 */
+			supp_chwd_set = GET_VHTCAP_CHWDSET(usr_vht_cap_info);
+
+			switch (supp_chwd_set) {
+			case 0:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 1:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_160MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 2:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80P80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			default:
+				vht_op->chan_width =
+				     IEEE80211_VHT_CHANWIDTH_USE_HT;
+				break;
+			}
+
+			*buffer += sizeof(*vht_op);
+			ret_len += sizeof(*vht_op);
+		}
+	}
+
+	/* Operating Mode Notification IE */
+	if (bss_desc->oper_mode) {
+		ieee_oper_ntf = bss_desc->oper_mode;
+		oper_ntf = (void *)*buffer;
+		memset(oper_ntf, 0, sizeof(*oper_ntf));
+		oper_ntf->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		oper_ntf->header.len = cpu_to_le16(sizeof(u8));
+		oper_ntf->oper_mode = ieee_oper_ntf->oper_mode;
+		*buffer += sizeof(*oper_ntf);
+		ret_len += sizeof(*oper_ntf);
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg)
+{
+	struct host_cmd_11ac_vht_cfg *vhtcfg = &cmd->params.vht_cfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AC_CFG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_11ac_vht_cfg) +
+				S_DS_GEN);
+	vhtcfg->action = cpu_to_le16(cmd_action);
+	vhtcfg->band_config = cfg->band_config;
+	vhtcfg->misc_config = cfg->misc_config;
+	vhtcfg->cap_info = cpu_to_le32(cfg->cap_info);
+	vhtcfg->mcs_tx_set = cpu_to_le32(cfg->mcs_tx_set);
+	vhtcfg->mcs_rx_set = cpu_to_le32(cfg->mcs_rx_set);
+
+	return 0;
+}
+
+/* This function initializes the BlockACK setup information for given
+ * nxpwifi_private structure for 11ac enabled networks.
+ */
+void nxpwifi_set_11ac_ba_params(struct nxpwifi_private *priv)
+{
+	priv->add_ba_param.timeout = NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE;
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.h b/drivers/net/wireless/nxp/nxpwifi/11ac.h
new file mode 100644
index 000000000000..c89956f247f4
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11ac
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AC_H_
+#define _NXPWIFI_11AC_H_
+
+#define VHT_CFG_2GHZ BIT(0)
+#define VHT_CFG_5GHZ BIT(1)
+
+enum vht_cfg_misc_config {
+	VHT_CAP_TX_OPERATION = 1,
+	VHT_CAP_ASSOCIATION,
+	VHT_CAP_UAP_ONLY
+};
+
+#define DEFAULT_VHT_MCS_SET 0xfffe
+#define DISABLE_VHT_MCS_SET 0xffff
+
+#define VHT_BW_80_160_80P80 BIT(2)
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg);
+
+#endif /* _NXPWIFI_11AC_H_ */
-- 
2.34.1


