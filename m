Return-Path: <linux-wireless+bounces-13304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9A5989AB8
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C6F1C21031
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF616F0E8;
	Mon, 30 Sep 2024 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JJ/Cg27p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F7185B68;
	Mon, 30 Sep 2024 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678330; cv=fail; b=VMuJjGvuf2g/2WeNIqwas4Dn5GpzRRQE17cfhDzOPJ37S2UZ37ruo9uo+D8FhNCr5FftrciyitgcxwYkH9Gl8e6ZymrvZJMt3f8hachqShoYtB+ZOLPhWOJwtqnpfPUPbcN5+cUCpYukt2lbOa5tydG/qDODL4nn/vk87shkJP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678330; c=relaxed/simple;
	bh=A3qr9mVfXPCTBCZAGlHzSxQNgJgTlmapZCTTaMoWEJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vm3oVfimk8s1Hvzn5S2QaWLNBBzSkEBTX+HQoOUJ1bfCkA5ShI0FeVj9DuANm50YL7XQCMFCX/3R4u7wDJUWeTzD9G2hpbEb/6tyHcE4rK7YG5yQWMaUBfj60qGexeBnuPp81u0uvDhWLmXlEvGJ7b8qN7OoF2I9i5+mhetWBwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JJ/Cg27p; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqsnBThvEUeFd2nivuIE0cotHzZclXmClN3mRXccprVqWt76c7DY9iPVMlsSEYgQu82Q4xARmN7gAEPd25L8bZCZr9oZDUV5k5xSCyhZajrzKIYrpEzSX+ccMwYvlpjRtlWrGa5p3z3PP8eUrkyrADiB+KMNX+KlhYzG2JXd5rFkR6L4doolkU08qEql78Kddcgjxunk6HoPejt757ekQiazcQKvOt+hArG7jwS0S3A2as6d0i5vac4xnMr2oAG+OfV3Hg5BxYR4igQPZzzEVqe6/giUl53516JH+3xy60O03LswjDHOMBhyVf4FV+JcDkb6hXAUd9wtD69QzQX08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZygSVhNTzduE8v66tIgkt5JbxBJdw0Ggkm6Uo5RNHuo=;
 b=yPqur2XW2TTvOpHgu0hu0HYJ8UIdiEZcuuzS9LYSSk0blAZ1DiBWDsKA2YEtq08buVCy8lRTZedW5D+BXd7HoFpOmj9Y8oSLWpUCaGI9sF7DZy2Et2Q7YJMaLxWzlXt8kajVRIprszJiHn76Q4zH8I4XWSs/SKwV8ubMcgTalQNYTXdlXFKxCMXn20LGAKr4H4MW4p5r8dklj/bAuSqS1qXk0thgKUUSe/0OUJUxbD+v9cRl2hbpzICBFq6GhdkWDJJogy5/WvSFQ4vuG2scva/J7etJAMudV7zFKj//drSK+Yc1RQQyl7cJjIPy0dMqLSlJ8OMeeTsrfj7MABOngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZygSVhNTzduE8v66tIgkt5JbxBJdw0Ggkm6Uo5RNHuo=;
 b=JJ/Cg27pv3JkXFBXTS5Pqxfhes/n1/BjpGpBUJfNTxQnh3LnfEb+4akuAqUlYcKrF4ryM20M/EIZZAUmeNjSF5uMRXwhgfnwj+8aihodC8xtKOWTU9lc1s8wXOfcqAaeDoAuEVfpjzrx169MnkxlEtXv96uM/B3eVdsx/RrZ3+EdN/5G5tFLzfkFv0tTDHsZDDoSLMiK94kbPpeWsuo7/XxS0cB22dsdzRDGxfxBJAd6kNPbpLeURgnD/QcDLTianKeSfCOa09+KbFqTaG2Kz+ll1psJkGrPyOppj+Mk6mQM8NxdGR6/P0MwupbKiJFBTRLTXdQ8wQEK20BKIyB4pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 30 Sep
 2024 06:38:24 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:38:24 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 18/22] wifi: nxpwifi: add core files
Date: Mon, 30 Sep 2024 14:36:57 +0800
Message-Id: <20240930063701.2566520-19-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dce7a76-8d58-4e73-2201-08dce11a7b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AAhEIsKpdvPsDpR5rcf1Ec1YypP19+3p7n5ZzwvXIoaQWRWhHvE5L7Lf7fb8?=
 =?us-ascii?Q?64Ff74roSql/eYtlDPbwv/BsFAuF1sbUCVaKHSjFFjiw7euOmhypOrB0yQpT?=
 =?us-ascii?Q?6W9Pcthes7QXMF+BPuI+9OPEySN7TM5E7AC0wi/apwqfc6AjlZaWDFs7xEEN?=
 =?us-ascii?Q?9vEF49Qu6lnO9qHZVBh/ThJ3sNgJO+J7deFUynZOPZYkS1J36rAKW9g8O7T5?=
 =?us-ascii?Q?++dgLjVIa32K5zxw09gWRTKNFRWvU6GN0n1CsJ97B9pXU03kFU1dLAJz/6Yb?=
 =?us-ascii?Q?w2mwDDraEuugJ+3pP+yp5gTvyK24k1T2Q8Mb4LvXf1ZAM7mRbplriFgd7FwX?=
 =?us-ascii?Q?ZSh+XlOZniwaYD6GwUmBIvdTFRWycTn+e6CS0+HLoP1m78i9JMIApjySteCX?=
 =?us-ascii?Q?rQ0DcBu4HrvyH+g9eL44NU/FyPEL0zAC90uvO08mR17rQ4YcqLHwktFf6VEf?=
 =?us-ascii?Q?KVCMS5De+gXzwIbI7MR5rdfbyJFuiRWHlI/3KJ5ECFwjdOPe1X4C4wjDPAGe?=
 =?us-ascii?Q?sgBZzE4nWFuHs+gfeCKC9W9+SslJ5/jMv96zesgInCYBBTN1K5qWWjrtunDp?=
 =?us-ascii?Q?7VQxLr5fKLnx/395CNtWbF24L8csOd8xpK/p3HWBxBfYBbup/VIEKby7jTrE?=
 =?us-ascii?Q?UD4SgJTtq0bQ/BqwBQ/cOVtnGY/52UI8Cj3kt8/1gOvCm4fYM4cFaggHtApl?=
 =?us-ascii?Q?Ffq8m1avVSfOLtDSvmggQBGz0Nbl+dzi8zdvdC29GArIdobkaK8Tcm9kHu91?=
 =?us-ascii?Q?QZhoKmdqIGTg5WAiq/DOpCw0zMszwq1cmNqjHlLUg2lDDrqBm0Ay4rubwTdC?=
 =?us-ascii?Q?3E5rjz/D3JIBJz34X4iLObzyQC9NjwfoxEQH/nD2HJKYRIe42WQ1Nf4heWst?=
 =?us-ascii?Q?6dYmns1yWEQEbnMOe7NXHFnPbFZrJja4MpOps1h6gLaCZBz8GEWwG/QGfMcW?=
 =?us-ascii?Q?VnRZFwLe4WwJsBNb4MoM+PMhbzSIpJm83jGC/Nk7xNhCTsxlpCmbsLvBzp8P?=
 =?us-ascii?Q?6T/Lob3L1N6DL6u+PVOIrS5c3NusA6hDG/lEz6eqLSyYFhTc+ulI+j0EKjGV?=
 =?us-ascii?Q?bv572wtc/wdH4mg5AevexjbF3ftYPwPZaQVDFuV83mCTaqK0uU6Y5gApioMm?=
 =?us-ascii?Q?Sbv3c0K4mhhZX0u+HD2QXS1u20UsJrBSScmRM+WVX4zNLCUxLKvbhSSH4zYP?=
 =?us-ascii?Q?U09SeibjOmo32KhxTxlGA98YWGsNa3meM4k8GbZkIR4xsr0jBxM8ugEmE5ma?=
 =?us-ascii?Q?FtRmDx/qawqBjmsfj0RvIzPg7scmtH+OQF6SPcVEa7A4HOYpc7bu/YhCP/58?=
 =?us-ascii?Q?uFkaZlKM+6Eccxkd6k8Q7glLiNegRpg1FblX8MzP1ZZ9LcgN9iL6rZ3zwsNv?=
 =?us-ascii?Q?/WnKCADotdq1ssb3wBG4MEv4EYbzmvvT4C9VzNvrQDusdlg0uQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BqkAYSvmCqPVgrssi6L07cVrfL2LJlPdGuLygaswABLafK+usI/AFZxMiHaq?=
 =?us-ascii?Q?9rphPwAvjy1krYjqu0e3WUgGd1zBs/waEiRlICCR3ajRkOkqaMHhBdctAP+C?=
 =?us-ascii?Q?kupiBVaoQ1hvZ6SQIPzP0SmRKhbgVl5Gr5wQnv8DNIAImy9e1liZQPnUwFsN?=
 =?us-ascii?Q?clM7hAXeZthoDVhSO7HwZ6HqRUehE0C5w/FMie5bxuM2LBU4LfQ7BhRUcTnt?=
 =?us-ascii?Q?JRInCDyR9AxMsfbLFIScnFQaxT8sN2PQxTOlFvgNqofit1SZvqnvRdWgRIsh?=
 =?us-ascii?Q?2JUBBm1iwzDycovZ9CRI+AP48j2ohp8JgaJPhorgeTGw30fba/75vsEuLXRw?=
 =?us-ascii?Q?j/dQhsX6kHeiEsZgvvCyMafLh0DNf8uJaMhQQbD0IjVettgpChAXnRTEvawK?=
 =?us-ascii?Q?bZ9KYmV/lh7uy7N1Ewpy6j0LwTjd2X0UtUZCM4e2T+hfv91MmBsQ4D0HlSzH?=
 =?us-ascii?Q?7vWx0M3iWYovWbTyeCDtT3kmnjSvxRVOcvP16hEMdI0bUsQIJMFt1NaLkOmd?=
 =?us-ascii?Q?/UyIyFsU5vzjwnoTx67X+noNqWwpHyrTfIJ++Ta2o1kICzoTdWUPvghLBytO?=
 =?us-ascii?Q?FLjWGCsdV2x+BdYDj3wgKijwb/+si8/t689Z688FYBf7K3WOjKP0SqNE7oTG?=
 =?us-ascii?Q?aa1vIPXkQ//HPzIGA4n2+YaXGUjsvyssvtRDk+Sx2OnNoY5Yx0Dkzl2q8AWk?=
 =?us-ascii?Q?spaUDIxkitLM+g5DCiwSNeexrVMDvaobQUmjgr16hHpIiIuf2D+4P2cSyYrp?=
 =?us-ascii?Q?l6qnCC5kSfG51grgrjmiyAVnD0OGhmo4mQhwu0s3C1KKpZVzpl3Im5CQxAHW?=
 =?us-ascii?Q?AZYQdNnPOF4DRqH5tUzBaxj3yTHPPXiJiP/ABA8LaY/RwEVQcQo/AC3kXFSw?=
 =?us-ascii?Q?3zuRp1SEpJTh9IcA1K0CHWe78Z6h305o9p/1WgHwX+kOyVVQCq+2ZNB5ekV2?=
 =?us-ascii?Q?c5vL1ABCVshgC8BnDp9/AwRdFOyIp5YCkh8lI/bOda342u0clYl8NFpmq+HL?=
 =?us-ascii?Q?gv/rxKaZmq8nmi/BY9nLBgEV2xSHJTASTI0mCQWqg5hngPNmgaLfH6vk8uv6?=
 =?us-ascii?Q?jfWNgX/HwqZcy1CfArJFpHH/bp1cQyETnE/xuVZvLhJKZM0z4cXMFmgEbLuO?=
 =?us-ascii?Q?aA8ouGGGJvQRQT3104ReRFtGxEzqQtWwJCC7g+7K78eoXqTWdmPEru6NJ0Av?=
 =?us-ascii?Q?Zmh+GAaJK52ANcumPfIUln6sJxFD1AjEr+bsAJWcIM5Na4ckQnvU5btU0xBL?=
 =?us-ascii?Q?pqfaVukQ32lNxbzbdOYTyhKRZg+wreaIvmn76sJaRdohRIBi3W3G1/KmC4SE?=
 =?us-ascii?Q?b6IFzu7i73Q8mdHeEuj0ppCJM0SMHu4LY5pvm1U4OTfwDbPGTsYdMbmv5Y5d?=
 =?us-ascii?Q?G4lBZIjZ1dj5J22xgvhHpvGw7AUpGbzhAh+cracgBZynXneVQexKD2WOQW+K?=
 =?us-ascii?Q?OuIHFUQZ7C/E3z7841/qMTeluts+SAPUncIERxBdp5PMHs7ktzq/mcG5DFGH?=
 =?us-ascii?Q?QqXCqmr4eOF2yVhRYwTZaEHdU3VeAixj99S4/eT3WS8EHlnXdYQBmquT/A86?=
 =?us-ascii?Q?OAPbnbTX8yDvFJDJ2SrOGUdcojeTyhz/XLEE73rl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dce7a76-8d58-4e73-2201-08dce11a7b7a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:38:24.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J07u+M0PNmhyD9B/ZpTbD0xOEbTR/lwo3SdIjOgycKWt3VmFPiVqSA9QZVldcT4T66CcPsYdNaI6CqVFjQ1kZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

Nxpwifi is a two modules driver: one for core layer and
another one is for bus driver.

Core layer supports needed functions to allow bus driver
to create an working instance for the bus driver.

Struct nxpwifi_if_ops is defined to allow bus driver to hook
callback functions to core layer for the operations of bus
related functions.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/main.c | 1649 +++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/main.h | 1477 ++++++++++++++++++++
 2 files changed, 3126 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/main.c b/drivers/net/wireless/nxp/nxpwifi/main.c
new file mode 100644
index 000000000000..6a26a5248b3a
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/main.c
@@ -0,0 +1,1649 @@
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
+	del_timer_sync(&adapter->cmd_timer);
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
+static void nxpwifi_process_rx(struct nxpwifi_adapter *adapter)
+{
+	struct sk_buff *skb;
+	struct nxpwifi_rxinfo *rx_info;
+
+	/* Check for Rx data */
+	while ((skb = skb_dequeue(&adapter->rx_data_q))) {
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
+	spin_lock_irqsave(&adapter->main_proc_lock, flags);
+
+	/* Check if already processing */
+	if (adapter->nxpwifi_processing || adapter->main_locked) {
+		adapter->more_task_flag = true;
+		spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
+		return;
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
+		/* Handle pending interrupt if any */
+		if (adapter->int_status) {
+			if (adapter->hs_activated)
+				nxpwifi_process_hs_config(adapter);
+			if (adapter->if_ops.process_int_status)
+				adapter->if_ops.process_int_status(adapter);
+		}
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
+		if (!adapter->cmd_sent &&
+		    adapter->vdll_ctrl.pending_block) {
+			struct vdll_dnld_ctrl *ctrl = &adapter->vdll_ctrl;
+
+			nxpwifi_download_vdll_block(adapter, ctrl->pending_block,
+						    ctrl->pending_block_len);
+			ctrl->pending_block = NULL;
+		}
+
+		if (!adapter->cmd_sent && !adapter->curr_cmd) {
+			if (nxpwifi_exec_next_cmd(adapter))
+				break;
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
+	tasklet_kill(&adapter->rx_task);
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
+/* This is the RX tasklet function.
+ *
+ * It handles the RX operations.
+ */
+static void nxpwifi_rx_recv(unsigned long data)
+{
+	struct nxpwifi_adapter *adapter = (struct nxpwifi_adapter *)data;
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags))
+		return;
+
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
+
+	nxpwifi_main_process(adapter);
+}
+
+/* This is the host mlme work function.
+ * It handles the host mlme operations.
+ */
+static void nxpwifi_host_mlme_work(struct work_struct *work)
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
+		wiphy_lock(priv->wdev.wiphy);
+		cfg80211_rx_mlme_mgmt(priv->netdev,
+				      skb->data,
+				      rx_info->pkt_len);
+		wiphy_unlock(priv->wdev.wiphy);
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
+	tasklet_kill(&adapter->rx_task);
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
+	if (atomic_read(&adapter->tx_pending) ||
+	    atomic_read(&adapter->cmd_pending)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "tx_pending=%d,cmd_pending=%d\n",
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
+	tasklet_init(&adapter->rx_task,
+		     (void *)nxpwifi_rx_recv, (unsigned long)adapter);
+	tasklet_disable(&adapter->rx_task);
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
+	INIT_WORK(&adapter->host_mlme_work, nxpwifi_host_mlme_work);
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
+	tasklet_enable(&adapter->rx_task);
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
+	tasklet_kill(&adapter->rx_task);
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
+			       nxpwifi_irq_wakeup_handler,
+			       IRQF_TRIGGER_LOW | IRQF_NO_AUTOEN,
+			       "wifi_wake", adapter);
+	if (ret) {
+		dev_err(dev, "Failed to request irq_wakeup %d (%d)\n",
+			adapter->irq_wakeup, ret);
+		goto err_exit;
+	}
+
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
+	tasklet_init(&adapter->rx_task,
+		     (void *)nxpwifi_rx_recv, (unsigned long)adapter);
+	tasklet_disable(&adapter->rx_task);
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
+	INIT_WORK(&adapter->host_mlme_work, nxpwifi_host_mlme_work);
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
+	tasklet_enable(&adapter->rx_task);
+
+	return ret;
+
+err_init_fw:
+	pr_debug("info: %s: unregister device\n", __func__);
+	if (adapter->if_ops.unregister_dev)
+		adapter->if_ops.unregister_dev(adapter);
+err_registerdev:
+	set_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+	tasklet_kill(&adapter->rx_task);
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
diff --git a/drivers/net/wireless/nxp/nxpwifi/main.h b/drivers/net/wireless/nxp/nxpwifi/main.h
new file mode 100644
index 000000000000..5b27e2baba26
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/main.h
@@ -0,0 +1,1477 @@
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
+#include <net/lib80211.h>
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
+	struct list_head tx_ba_stream_tbl_ptr;
+	/* spin lock for tx_ba_stream_tbl_ptr queue */
+	spinlock_t tx_ba_stream_tbl_lock;
+	struct nxpwifi_tx_aggr aggr_prio_tbl[MAX_NUM_TID];
+	struct nxpwifi_add_ba_param add_ba_param;
+	u16 rx_seq[MAX_NUM_TID];
+	u8 tos_to_tid_inv[MAX_NUM_TID];
+	struct list_head rx_reorder_tbl_ptr;
+	/* spin lock for rx_reorder_tbl_ptr queue */
+	spinlock_t rx_reorder_tbl_lock;
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
+	struct delayed_work dfs_cac_work;
+	struct delayed_work dfs_chan_sw_work;
+	bool uap_stop_tx;
+	struct cfg80211_beacon_data beacon_after;
+	struct nxpwifi_11h_intf_state state_11h;
+	struct nxpwifi_ds_mem_rw mem_rw;
+	struct sk_buff_head bypass_txq;
+	struct nxpwifi_user_scan_chan hidden_chan[NXPWIFI_USER_SCAN_CHAN_MAX];
+	u8 assoc_resp_ht_param;
+	bool ht_param_present;
+};
+
+struct nxpwifi_tx_ba_stream_tbl {
+	struct list_head list;
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
+	int (*process_int_status)(struct nxpwifi_adapter *adapter);
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
+	atomic_t tx_pending;
+	atomic_t cmd_pending;
+	atomic_t tx_hw_pending;
+	struct workqueue_struct *workqueue;
+	struct work_struct main_work;
+	struct work_struct host_mlme_work;
+	struct tasklet_struct rx_task;
+	/* spin lock for following variables which
+	 * are used to synchronize main process function
+	 */
+	spinlock_t main_proc_lock;
+	/* avoid execution of main process function */
+	bool main_locked;
+	/* indicate if main process function is running */
+	u32 nxpwifi_processing;
+	/* indicate if there are more tasks should be done
+	 * by main process function
+	 */
+	u8 more_task_flag;
+	struct nxpwifi_bss_prio_tbl bss_prio_tbl[NXPWIFI_MAX_BSS_NUM];
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
+	u8 event_received;
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
+};
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
+
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
+void nxpwifi_dfs_cac_work(struct work_struct *work);
+void nxpwifi_dfs_chan_sw_work(struct work_struct *work);
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


