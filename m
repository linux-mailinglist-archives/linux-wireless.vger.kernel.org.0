Return-Path: <linux-wireless+bounces-11194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A994CDA5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43ACC281234
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F325197A97;
	Fri,  9 Aug 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JV8E0KLJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A427192B87;
	Fri,  9 Aug 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196818; cv=fail; b=lJ/4R1b2tNpdgd5XHSbD7d9n8xznvwZkEOw8dyLJXzbPdixEFmbu4ScBMR6f8/sW4z+N7Nx4kOxjTwbYLQOabEBEh28zpKfIbbOoPusSs4qQab4jB1ZVAERM4wedQcpk7C8eas34fHEoL/3WLqstRQVmvEufMaKb5zlhgtxVoNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196818; c=relaxed/simple;
	bh=4jneY9QPHv+/KYl3GvjaaIAsVBkH1CncQL74fk8/1a4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pTS/zpBrx9CPddVmJw/WQcM0PQJcivX4zVQveygPpq5wDo65q75xwdoyIrxKslRjjFTBzU2pli3tBYxn6uNzkro3zS94hl2BR/TfWrlF8akUOqvjSCzkIqn3nqrHt9NKsPketCAJeg2fzG+uVIcWh0DVbevE17pgSXb4ShnNt/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JV8E0KLJ; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClYYBGGKwo2f3FePuv41N1mwVjZNfk2assR6zoiKZONtNkm3HMhVQjDo2lzgbx8liaBIkSDKFeEhDPdZ3bhDG+LLF+AgMT7p9Dbua4VK4Wf4CgMGEbgzwYbExNRyROGpK6255y/G/7/uwZejAmOHnxmEi7PXu5elLlg9ZD4gVlTwztFuJCQ8mQnggDGp56V6nSQh8vRuOC0Q7N9HeX076NwoyTEXBQGXYJVYHhWty984T8BWjQ9ZWXjA1NZuU0UdSqdgZlmXvI34vhuen0W3os550Hv+G4ZW0fMYGAQtqWjIEnOR3ZIFLpKwzRTHFQhcD07b8was3Vj3O4rN4p8/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+9PUGqbaRn9zMe5jATArZOPJPjoi0ukRVI0tRimJfM=;
 b=y9LKuNZON1uO6odCHQUCSFQClTsthEAQg5pcX0I6CWr8zBz28XPrbEGihz/DOH+lzOvzKbBPsDRrT5uf4HnHthPaDe2P3m6Qiz5YWgiT0aNfbx8trgMzDKifpwZ3HPU6Rn0a8d4Uew191zKTdBDJHnF/u/kTlMSdDgaB5Dtr83LEyV5pvxsJiiNop0oM/vspfiKjGTk7jQGeWZgxXlEPplO3ZjbDVtumNrVzHYKoKcgI9F4GgII5j59Ez1qDXsRqZWNpYV3UyIAt/wddxSxq/PsQDY6aJK7YKpcBf8oftveQB/q0LMIGf37XIklUc/ekSRG/7RB0LOaB1rWAFLCewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+9PUGqbaRn9zMe5jATArZOPJPjoi0ukRVI0tRimJfM=;
 b=JV8E0KLJC2cSVG+p3BV2Ku5YrSH4n58ZUjNOpbHJME2ngl5m2etEYItEzYwf9G3FsZG38pFH+gf1xTqiCDlFFqPkfF9QDHo6VcxzQWi8Xgnao5OfwnuK0bQKxtvhqOlmNPh5OGFx0h6P7Wo9pGKg2M+fEfp53/YrPf2V60TOLjhfGNnW5M4tEdiIcNA64BsuWLfqBgTtRkmu6p1vT7FNR/jIkI610jSBrl5iw9x6KUYVziDqFVUeQfNR2nEPqquYk+Ym3/3m3RhCOyBi9Ica0yX5E0Hj/Y9IIvDEDFVjmTdw+k5j697axXnsEAOYQyBg+IY6RK6P+fqH7AP8YB3RhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:46:47 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:47 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 17/43] wifi: nxpwifi: add decl.h
Date: Fri,  9 Aug 2024 17:45:07 +0800
Message-Id: <20240809094533.1660-18-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c37f16b2-f20a-49eb-0c5c-08dcb8582f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BjWGqmRi3nheJPT1L5LRzgYpDgSqsjOtYygViRzPTENVxElMkwHlQyTVqDqZ?=
 =?us-ascii?Q?JhbZ6cSZm738sSRmU62dBc4zJCnwaNeV52/ISz8vDVBa5SjNV4/Z6V5aEnrV?=
 =?us-ascii?Q?aLCoCTUqzUTBML9CixFujV9zSt2shQMd7MGUH7vRIUVk8sMWagHSwuulKTQW?=
 =?us-ascii?Q?lDOqVcRVx0b8RHF6joEZBJayrHJHSgBsn8b3OrcXZnHPOf8iL+c+S8169tU2?=
 =?us-ascii?Q?g63c4CvUFnonr1CliUCv+aOgdrQZEjFZPD9icZayU3OBYbuSrmH3tFZXLXEA?=
 =?us-ascii?Q?OwsN6jn3oHUylgspe8sZNND7yzG1hEd/rbWpDw797REun67fPY3Pstq3rIuf?=
 =?us-ascii?Q?Gz5FT65gd9h+6Jnd5savGpah3d9/ykeiwNZ384cdRJyyT91eSaFgPshRYo8T?=
 =?us-ascii?Q?A1YBf1c/t2FncGVyuq4LKiN+qKdxTK+dZcyabUDnGzbqd0T47iCB0d4iQNa4?=
 =?us-ascii?Q?bJrnS+OYjYwwGktWAeg3UVCbyDAqeXMs7TGBIl5Sw55AqLqUf5i4eRo+Ov5v?=
 =?us-ascii?Q?TK/vRZFCY13T/cbDemL9PwqWxtjmIygr9qOwCc5uRaV/NJxnmy9im2BEjzHb?=
 =?us-ascii?Q?/6PdMeGvwRyD40+opw51kt8w5l0QGtKQPQSsl4kFv83z5ZBrrABk1zliVIyp?=
 =?us-ascii?Q?f467cQqhJf5vJ3ySJhUCn/Gunm8zdcBPzR3bPnL9ra4lRUENt1d6YNi/o/27?=
 =?us-ascii?Q?dr3Vl9uVkpBI0PP4IvxsiuqN3yDsGlal53o7n+gRO8KgYpIzqx40Cwi+cREW?=
 =?us-ascii?Q?VOUgRLbFcZz1i0bjqmA/Be7luTMLg9b4jR37nqumddBYFx4bMixuHgVmUrS6?=
 =?us-ascii?Q?tQQSQajjewCAwEHibk5O5pgbssEMQSX9z9tkrG97aD5xlHVhD9hK3QEV44MH?=
 =?us-ascii?Q?gsRlwHmjTnoT3Mw4cUNbPhe9WOp2dORkwp5izrN5gUbziy/4bHq4x2WGTKAV?=
 =?us-ascii?Q?Vn3xqMwiw6t9pYWyHO6zhevADD8XyeWWVn8qjY2SQbMrVKF1kazNcBR5VGaZ?=
 =?us-ascii?Q?D/yjwhBx7LAl1z//8Q7Cl0OkkmT2JcRnCYk2vrbGJO4boVdGFD6yrueWKnYl?=
 =?us-ascii?Q?eKnT9btrjkrVpWDZEpZpu5LQINDrHL1TP/HqR541iiTM71ccS+ZwdMnzMCXs?=
 =?us-ascii?Q?OdFWeiVJS/WvO3wtLX4n/qeRLUFQUTZ2BHF3OwDbnGieARL6JmUCmqVqgRJv?=
 =?us-ascii?Q?ZNCLRLP87/ZU8YngeHOoZEKMSCeSN6ht+UqAz3UlMj0uLIZvVSjhT0e1L1lR?=
 =?us-ascii?Q?HJ6vjFMUyjj+a/6DRbKLI728Bripj7zMvIom68Xo3aCIR4UH5WG6qbvun6id?=
 =?us-ascii?Q?ZMaknBUFWwoMBdYTqoyZCOrczaejqnlxkS+2TZHUnICjVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z2UmRLwNd/7P4/qvFkiDzUFmXo6cNmWCzglgKhUKqGqtv1V1RcMF6vEcIzEm?=
 =?us-ascii?Q?P70aS2tZ9grYWzAdTh2y9uf0gryi8ZjI2OHAK+sbwADaxVxlpbZkQAHDCkC8?=
 =?us-ascii?Q?QS1jRMFSxgimTAnVWLGmzB6gkDIzIvZL15ysrK0kbzq5SgYWfFTgpp7dbpej?=
 =?us-ascii?Q?8RvxfKDovF+bsYvULsaudD6cBIHFf8J3QStU8YRFqvQFho1l8VH5pASFcBIJ?=
 =?us-ascii?Q?DzLL4cxjyMQUG3IYDlihhrtC6UYu0/2Ifn4SMH0AYe1GjMn37+09XqPG3KrT?=
 =?us-ascii?Q?IZO2eGRkbQcW6/ehq32FYSzv7pUKThz49ydgOKezqzjeUOuLAxuD+SqqOvpT?=
 =?us-ascii?Q?4eg5xNDTeLPotMZOCqOoMxI8TAEZP3chcPUYObGkk3X20zoCO4NlxdwA5FYi?=
 =?us-ascii?Q?uD27NBcznr6UYbaGUDzcM2mWlZ/qRzXRp/2RDBV0CsdtdfWo+fITgwid6yvT?=
 =?us-ascii?Q?OSLaF4DIzk1fViN2Zrp0TAmy/RYuk83xfd8mCWR/yVBzsrIFw+tsaIReNFyj?=
 =?us-ascii?Q?pml9o6lAWG9DnAbZkks0RpTu0Fqnw+0N20S/K9r/f1WlzGv5I99yfbEK0+L9?=
 =?us-ascii?Q?q09SyX2CzRhoGFplWZDmc9LMvw4CZgmTEmeJ4HKqI09ZhEiaEQQx1bptyBLQ?=
 =?us-ascii?Q?ZfCoE5eG1DcIWS/AZ+9Qm5XUGZETNoPW/hyCiavqXqkWiqsHx3vgJUDcEKnk?=
 =?us-ascii?Q?Uw70pG5xzmF8KLxxneGu0drh7oYGTi/I404AeHg7E6E99aeqqTZZ5/U7aY8e?=
 =?us-ascii?Q?j1Nf9Nb3ypuGhYbSqshsZTyAIrtTVuaP7NvrEdaCdvsO9kawVyX6vsUPgkxn?=
 =?us-ascii?Q?zNpJgKhhBd0NBvk+7Ab/D5ilYkLXZTkuo6b2qdFvFPhMhgba3PulVfc44oQ7?=
 =?us-ascii?Q?IGg9ru2Q+XATKFD9BvcvIEQPCBdR3gLi0FBxTalFPp01ZaSAI2AQJu+bbJFW?=
 =?us-ascii?Q?Cs+KAcnx3JeVjGSF3Klc4ZQz4G1t7qudnU3ypdPdfGMTqrmokFcjNNos9+gW?=
 =?us-ascii?Q?O1lmV7L5Y4GNQIv5LRcQj6hy11za8X5nCtXpGcVZPmNhwtBImM7LCMVVkvTl?=
 =?us-ascii?Q?euQookQBSgcO9StmU9Faa7gumkPgq9ZHB0QM4t7PX0PqEoJBs4q5wtyXAOEx?=
 =?us-ascii?Q?ko/c0BaDOzVg4AcGXncM4APOdj2iXFEVGhiggULykxzbe6AyJvhBF67m/zIy?=
 =?us-ascii?Q?L8ud+NX/hPXZJjbxWATLuizJD+B856SgEgbRK42cPnoxCoKn+saCV3epxLQa?=
 =?us-ascii?Q?y4rkCNFV4gOOIigbgV3zPcQ1hW0JSa0AOoEbUQqhNjzEXoVGGXDiHQYgMXB0?=
 =?us-ascii?Q?9OxWyYLwUsk0jCsuxN/Q8FZKKdFSYPZcKeKUCVrv9aEgiHWjdqjAw72kn1EK?=
 =?us-ascii?Q?6aRl91L/YK5d6ncopZ5JY2P0ukH8usBVxp+ZkQzzd1b93NK/HYDdONUD97Y7?=
 =?us-ascii?Q?olV4GgOIBeKDJ/GcLuktqsNI/ZWuqgb4+Wm1CGqDHHNeEox+3INYdCKpyrD4?=
 =?us-ascii?Q?2x/TcFqcL+W5SPLNGK1CPST5qLYP9tU+9sgquMg8/B48JxE/MxfrYRkak8me?=
 =?us-ascii?Q?/4LkelwcyLpAd18Ms5+Eyc9XIt+E67ZZMTCA5u2O2ZsjUcEcfjPg6QX+Ie6X?=
 =?us-ascii?Q?6kiWKgVB0ckHRVoqT76I8ygpLUxJDz48EDhVo1LbfrT4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37f16b2-f20a-49eb-0c5c-08dcb8582f45
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:47.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmQI055HW92zTc1nxgN4H95ey6zQ7tSOxU89iRLv+Mfk3lezhWXp465lxGxpHKQpda9s1kNKhH8pP+tH2zm+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

---
 drivers/net/wireless/nxp/nxpwifi/decl.h | 294 ++++++++++++++++++++++++
 1 file changed, 294 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/decl.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/decl.h b/drivers/net/wireless/nxp/nxpwifi/decl.h
new file mode 100644
index 000000000000..930f777f064f
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/decl.h
@@ -0,0 +1,294 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: generic data structures and APIs
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_DECL_H_
+#define _NXPWIFI_DECL_H_
+
+#undef pr_fmt
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/wait.h>
+#include <linux/timer.h>
+#include <linux/ieee80211.h>
+#include <uapi/linux/if_arp.h>
+#include <net/cfg80211.h>
+
+#define NXPWIFI_BSS_COEX_COUNT	     2
+#define NXPWIFI_MAX_BSS_NUM         (2)
+
+#define NXPWIFI_MAX_CSA_COUNTERS     5
+
+#define NXPWIFI_DMA_ALIGN_SZ	    64
+#define NXPWIFI_RX_HEADROOM	    64
+#define MAX_TXPD_SZ		    32
+#define INTF_HDR_ALIGN		     4
+/* special FW 4 address management header */
+#define NXPWIFI_MIN_DATA_HEADER_LEN (NXPWIFI_DMA_ALIGN_SZ + INTF_HDR_ALIGN + \
+				     MAX_TXPD_SZ)
+
+#define NXPWIFI_MGMT_FRAME_HEADER_SIZE	8	/* sizeof(pkt_type)
+						 *   + sizeof(tx_control)
+						 */
+
+#define FRMCTL_LEN                2
+#define DURATION_LEN              2
+#define SEQCTL_LEN                2
+#define NXPWIFI_MGMT_HEADER_LEN   (FRMCTL_LEN + FRMCTL_LEN + ETH_ALEN + \
+				   ETH_ALEN + ETH_ALEN + SEQCTL_LEN + ETH_ALEN)
+
+#define AUTH_ALG_LEN              2
+#define AUTH_TRANSACTION_LEN      2
+#define AUTH_STATUS_LEN           2
+#define NXPWIFI_AUTH_BODY_LEN     (AUTH_ALG_LEN + AUTH_TRANSACTION_LEN + \
+				   AUTH_STATUS_LEN)
+
+#define HOST_MLME_AUTH_PENDING    BIT(0)
+#define HOST_MLME_AUTH_DONE       BIT(1)
+
+#define HOST_MLME_MGMT_MASK       (BIT(IEEE80211_STYPE_AUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DEAUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DISASSOC >> 4))
+
+#define AUTH_TX_DEFAULT_WAIT_TIME 2400
+
+#define WLAN_AUTH_NONE            0xFFFF
+
+#define NXPWIFI_MAX_TX_BASTREAM_SUPPORTED	2
+#define NXPWIFI_MAX_RX_BASTREAM_SUPPORTED	16
+
+#define NXPWIFI_STA_AMPDU_DEF_TXWINSIZE        64
+#define NXPWIFI_STA_AMPDU_DEF_RXWINSIZE        64
+#define NXPWIFI_STA_COEX_AMPDU_DEF_RXWINSIZE   16
+
+#define NXPWIFI_UAP_AMPDU_DEF_TXWINSIZE        32
+
+#define NXPWIFI_UAP_COEX_AMPDU_DEF_RXWINSIZE   16
+
+#define NXPWIFI_UAP_AMPDU_DEF_RXWINSIZE        16
+#define NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE   64
+#define NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE   64
+#define NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE   64
+#define NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE   64
+
+#define NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT  0xffff
+
+#define NXPWIFI_RATE_BITMAP_MCS0   32
+
+#define NXPWIFI_RX_DATA_BUF_SIZE     (4 * 1024)
+#define NXPWIFI_RX_CMD_BUF_SIZE	     (2 * 1024)
+
+#define MAX_BEACON_PERIOD                  (4000)
+#define MIN_BEACON_PERIOD                  (50)
+#define MAX_DTIM_PERIOD                    (100)
+#define MIN_DTIM_PERIOD                    (1)
+
+#define NXPWIFI_RTS_MIN_VALUE              (0)
+#define NXPWIFI_RTS_MAX_VALUE              (2347)
+#define NXPWIFI_FRAG_MIN_VALUE             (256)
+#define NXPWIFI_FRAG_MAX_VALUE             (2346)
+#define NXPWIFI_WMM_VERSION                0x01
+#define NXPWIFI_WMM_SUBTYPE                0x01
+
+#define NXPWIFI_RETRY_LIMIT                14
+#define NXPWIFI_SDIO_BLOCK_SIZE            256
+
+#define NXPWIFI_BUF_FLAG_REQUEUED_PKT      BIT(0)
+#define NXPWIFI_BUF_FLAG_BRIDGED_PKT	   BIT(1)
+#define NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS   BIT(3)
+#define NXPWIFI_BUF_FLAG_ACTION_TX_STATUS  BIT(4)
+#define NXPWIFI_BUF_FLAG_AGGR_PKT          BIT(5)
+
+#define NXPWIFI_BRIDGED_PKTS_THR_HIGH      1024
+#define NXPWIFI_BRIDGED_PKTS_THR_LOW        128
+
+/* 54M rates, index from 0 to 11 */
+#define NXPWIFI_RATE_INDEX_MCS0 12
+/* 12-27=MCS0-15(BW20) */
+#define NXPWIFI_BW20_MCS_NUM 15
+
+/* Rate index for OFDM 0 */
+#define NXPWIFI_RATE_INDEX_OFDM0   4
+
+#define NXPWIFI_MAX_STA_NUM		3
+#define NXPWIFI_MAX_UAP_NUM		3
+
+#define NXPWIFI_A_BAND_START_FREQ	5000
+
+/* SDIO Aggr data packet special info */
+#define SDIO_MAX_AGGR_BUF_SIZE		(256 * 255)
+#define BLOCK_NUMBER_OFFSET		15
+#define SDIO_HEADER_OFFSET		28
+
+#define NXPWIFI_SIZE_4K 0x4000
+
+enum nxpwifi_bss_type {
+	NXPWIFI_BSS_TYPE_STA = 0,
+	NXPWIFI_BSS_TYPE_UAP = 1,
+	NXPWIFI_BSS_TYPE_ANY = 0xff,
+};
+
+enum nxpwifi_bss_role {
+	NXPWIFI_BSS_ROLE_STA = 0,
+	NXPWIFI_BSS_ROLE_UAP = 1,
+	NXPWIFI_BSS_ROLE_ANY = 0xff,
+};
+
+#define BSS_ROLE_BIT_MASK    BIT(0)
+
+#define GET_BSS_ROLE(priv)   ((priv)->bss_role & BSS_ROLE_BIT_MASK)
+
+enum nxpwifi_data_frame_type {
+	NXPWIFI_DATA_FRAME_TYPE_ETH_II = 0,
+	NXPWIFI_DATA_FRAME_TYPE_802_11,
+};
+
+struct nxpwifi_fw_image {
+	u8 *helper_buf;
+	u32 helper_len;
+	u8 *fw_buf;
+	u32 fw_len;
+};
+
+struct nxpwifi_802_11_ssid {
+	u32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+};
+
+struct nxpwifi_wait_queue {
+	wait_queue_head_t wait;
+	int status;
+};
+
+struct nxpwifi_rxinfo {
+	struct sk_buff *parent;
+	u8 bss_num;
+	u8 bss_type;
+	u8 use_count;
+	u8 buf_type;
+	u16 pkt_len;
+};
+
+struct nxpwifi_txinfo {
+	u8 flags;
+	u8 bss_num;
+	u8 bss_type;
+	u8 aggr_num;
+	u32 pkt_len;
+	u8 ack_frame_id;
+	u64 cookie;
+};
+
+enum nxpwifi_wmm_ac_e {
+	WMM_AC_BK,
+	WMM_AC_BE,
+	WMM_AC_VI,
+	WMM_AC_VO
+} __packed;
+
+struct nxpwifi_types_wmm_info {
+	u8 oui[4];
+	u8 subtype;
+	u8 version;
+	u8 qos_info;
+	u8 reserved;
+	struct ieee80211_wmm_ac_param ac[IEEE80211_NUM_ACS];
+} __packed;
+
+struct nxpwifi_arp_eth_header {
+	struct arphdr hdr;
+	u8 ar_sha[ETH_ALEN];
+	u8 ar_sip[4];
+	u8 ar_tha[ETH_ALEN];
+	u8 ar_tip[4];
+} __packed;
+
+struct nxpwifi_chan_stats {
+	u8 chan_num;
+	u8 bandcfg;
+	u8 flags;
+	s8 noise;
+	u16 total_bss;
+	u16 cca_scan_dur;
+	u16 cca_busy_dur;
+} __packed;
+
+#define NXPWIFI_HIST_MAX_SAMPLES	1048576
+#define NXPWIFI_MAX_RX_RATES		     44
+#define NXPWIFI_MAX_AC_RX_RATES		     74
+#define NXPWIFI_MAX_SNR			    256
+#define NXPWIFI_MAX_NOISE_FLR		    256
+#define NXPWIFI_MAX_SIG_STRENGTH	    256
+
+struct nxpwifi_histogram_data {
+	atomic_t rx_rate[NXPWIFI_MAX_AC_RX_RATES];
+	atomic_t snr[NXPWIFI_MAX_SNR];
+	atomic_t noise_flr[NXPWIFI_MAX_NOISE_FLR];
+	atomic_t sig_str[NXPWIFI_MAX_SIG_STRENGTH];
+	atomic_t num_samples;
+};
+
+struct nxpwifi_iface_comb {
+	u8 sta_intf;
+	u8 uap_intf;
+};
+
+struct nxpwifi_radar_params {
+	struct cfg80211_chan_def *chandef;
+	u32 cac_time_ms;
+} __packed;
+
+struct nxpwifi_11h_intf_state {
+	bool is_11h_enabled;
+	bool is_11h_active;
+} __packed;
+
+#define NXPWIFI_FW_DUMP_IDX		0xff
+#define NXPWIFI_FW_DUMP_MAX_MEMSIZE     0x160000
+#define NXPWIFI_DRV_INFO_IDX		20
+#define FW_DUMP_MAX_NAME_LEN		8
+#define FW_DUMP_HOST_READY      0xEE
+#define FW_DUMP_DONE			0xFF
+#define FW_DUMP_READ_DONE		0xFE
+
+struct memory_type_mapping {
+	u8 mem_name[FW_DUMP_MAX_NAME_LEN];
+	u8 *mem_ptr;
+	u32 mem_size;
+	u8 done_flag;
+};
+
+enum rdwr_status {
+	RDWR_STATUS_SUCCESS = 0,
+	RDWR_STATUS_FAILURE = 1,
+	RDWR_STATUS_DONE = 2
+};
+
+enum nxpwifi_chan_band {
+	BAND_2GHZ = 0,
+	BAND_5GHZ,
+	BAND_6GHZ,
+	BAND_4GHZ,
+};
+
+enum nxpwifi_chan_width {
+	CHAN_BW_20MHZ = 0,
+	CHAN_BW_10MHZ,
+	CHAN_BW_40MHZ,
+	CHAN_BW_80MHZ,
+	CHAN_BW_8080MHZ,
+	CHAN_BW_160MHZ,
+	CHAN_BW_5MHZ,
+};
+
+enum nxpwifi_chan_offset {
+	SEC_CHAN_NONE = 0,
+	SEC_CHAN_ABOVE = 1,
+	SEC_CHAN_5MHZ = 2,
+	SEC_CHAN_BELOW = 3
+};
+
+#endif /* !_NXPWIFI_DECL_H_ */
-- 
2.34.1


