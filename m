Return-Path: <linux-wireless+bounces-25732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C7B0BCAA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A51A3A793F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD9D288536;
	Mon, 21 Jul 2025 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vu2vbEAa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2760286417;
	Mon, 21 Jul 2025 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079529; cv=fail; b=kOfn2up3inOItEREKABMx1cIn1xLFW8mBHtgEbaVqZkJtexaJFrBOc4e1hP5v4+6swZ8zgR0u7be/m2RUsS61d/nBhKlnPJ+wVgLt2zxzyDnSirPxZ9kmLz/mCeWv3yIQ8jkRhxkp8ilLRXiY9D1rywr5+o3nJ6bneqhDPb4PGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079529; c=relaxed/simple;
	bh=lnhlvO04ec+tGPF0AvT2tv2BCOtF/pUfJdXwuvkzjUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ha10FHbf2L8aTLrmuQ7uD0ZhP6tjZ1ZDhmjvcaLd1wEjpvf4f1DZBQNEmtJ+H4eTM9D6+rhJCNMsQI6rjTEWFXWXSFlLSMsfdjSuxLKJXUmH1XbBm21R2LU4tZ0YmIq4bZ+N/lsvoS2D87KHKAsj+WpFVzJDfO77lTMtBxxdT5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vu2vbEAa; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAiDucHSI449lsf3S3aYq4MM10IFRRGLn10hEy+EZgOR3umu0w9ZEe8eTjDX7KW3qbiA+UcqoE75OP9N28plWpXrotAvSXAZGNVxVzqVXoUMlh/55+teCT6ffwlt/V4pOxaxQ8jGK+s/4wxYED631zl8NmOQyJ/6yfJzei34syFXJRFqRe1GkXwjdJO5SCSbb40Mxt1l3rhPG0WZi3B11xhv54WjN2Y5xjMoSjijsMYDoQ3mpV7QtEp31ZNqNbBCT745IfYwZqe1QmEej4nGXKN/QjFNT7k8Cg144p8muhn5djrENh1t/cDOZc2ENLtM19+cZl6ioo2mha3XlSXugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYCst5iuCanLzboH4+qfL14RIaAXAdyUr9/kM/ubmzQ=;
 b=syBehZQvi5q2gl4hMN5MIpmAzX8OdomE3c2APgcgKBRc5y/lw7vKU9TL22jNbR+clrdJEsGFIwkSEqpe0/4W5CC0fKS+Vqq0hlE0yLFVuTrpVT51T0+LZ1VE5PVo0xKaFA4sgCV0OULBndRscy6mRKJcMDx4XzhANiGyV8pXSV0pPzoRuEhUUSv4DHx+GLxq3E+uzRycrsJV+JsspGoSLssECqdZvgNz+M432U5AXREuN3H6b05PMU6MRLLG7JGACO9fVPP8FtihuKTFrJBNfDD5/CZd9CQvhD+VVfNf42JswrPJkXflymMvGn104tbc6hewJqLF28rznRjgbPPDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYCst5iuCanLzboH4+qfL14RIaAXAdyUr9/kM/ubmzQ=;
 b=Vu2vbEAaX+4dEJylSMXWKRl69YitQWrg20cVksGBCkVoIvXOSTSQkPOw8mXa9XXBXiOBBYvEDTqNRIzFDq6JDh2bgNHYuNiVIb6s7jpDwzJAKZxtcF7NTjFLMDWzDhtKT5UraoyOgABYUMoWLz/lIqFm9fTBFm1E219BVkypKoqexzkidlOox6aJSaHnz/o6tP7L792Vz+UyNEwKRJ9UqgsMXSFlQDYZLyVjliEVydx5pO2wFklT0DXzxL/3tI6+pwyrzCQTXrtdtrbZP3RDG9kf07vL0UrDBs7mzP9r+RITh1jI8pka+7A4iqF0+K1YgigdlkmWhOnFNfZe43oqag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DU2PR04MB8967.eurprd04.prod.outlook.com (2603:10a6:10:2e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:31:43 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:31:43 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	tsung-hsien.hsieh@nxp.com,
	jeff.chen_1@nxp.com,
	brian.hsu@nxp.com
Subject: [PATCH v4 12/22] wifi: nxpwifi: add command and event files
Date: Mon, 21 Jul 2025 14:26:31 +0800
Message-Id: <20250721062641.2001796-13-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
References: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|DU2PR04MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: e11a42f8-ec91-421b-9999-08ddc8204239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/RkbNdqWnXs3ec/isi+8vjXPe0xMKP4EYQ+aDc93Xj7nNm5J+NFnvCzOI+RL?=
 =?us-ascii?Q?XpKA6a6W9Wp6kv4R5q37Jj4irxAW/3HeUxWHoEGG/XtenyejUjzCsChHcZ8L?=
 =?us-ascii?Q?5RmHKSHfLvcm4JdynWorQkT+982JbtgvKISI75+G2LLxO0S73aHkK8bKXrRq?=
 =?us-ascii?Q?K2A75zl2IGvnB0Scv8qsojrldbjitZm++v+HxUiR3epFyjKzJHLnTaBhKkSb?=
 =?us-ascii?Q?MrbdQstrjAHRCtN3VNq3eyxTzTiLXNID7Ul8kFZW0EOuW7gvD3apaQkKmdN6?=
 =?us-ascii?Q?VJ2dskyFWo8eGa3i8NTh6A7A/zReJMC2aHGIqaGCGuROgxSYgxYBlCctZHAx?=
 =?us-ascii?Q?aD5VKtWn3+mUvE0jCCw375Ot5CG4NvwS5RJ9VTylLTm3VXLvD0Cle6E1JqSR?=
 =?us-ascii?Q?7JdLvMrLZkYSTDM1PKXktlfk8HWEH09D6jA29HDegQdND2ksA4U8ek8POfo1?=
 =?us-ascii?Q?7ExCjtoBuTVDbaWmGElzstmA6wnCE/QfC4PgmAc3e3j6y/F6p446Mh1xJf37?=
 =?us-ascii?Q?EGAXwnTDNsdF0qKhJqVwbQI947yMnJrQLuvhguClaNPbsFN1Zs9aBLvtgGI6?=
 =?us-ascii?Q?1NxLchrrpt0xzDfnPeMg+siG4GRLRPnC0JvAxqptgVsiCDrLhZ8wGVfoTbAj?=
 =?us-ascii?Q?8iX2vrsGljz0cz75G0uqlVfgrEbJ3zakMTpNvPozvIAGLoPp4y9xw8oxtRH8?=
 =?us-ascii?Q?eDFOpi/BaFHpqTbKiftudLoiAcIvLshJeiHO+Uw2vt3r5hSyrnEsA5szT/rB?=
 =?us-ascii?Q?Q2oxtMbN4UPbIItQFXR1DDvfD7ZpnTQWvmdDgE1ZOMm9rKlSB7vUFECwcx7I?=
 =?us-ascii?Q?UO53PgAf5wIwCQhFu9jP2nFgPqqduhOjC+NOeBWDiQyDNT1CTSiD0dXFKJbI?=
 =?us-ascii?Q?KXiw+lrFaQ2wk2CEwvO+/DVCMot20mEcuHiiLReioUJd/QPM0T6WfXpPZzX1?=
 =?us-ascii?Q?LA3/Zt0waJeissvtmrXRd/0ILGFUBcbZWw1qeMnhkXaV8z2Fty0qHdZSw7Ss?=
 =?us-ascii?Q?H7LO+ZmW1O0c3cBjASjqmmPKS5NMjZ8kBnc6I3cGjzf7LFVUy8pIcK+6Hm7l?=
 =?us-ascii?Q?a6VcC+RzS5cb+uV7vk7MKAh6inZOwBQPu44OnTI/m28gBIOI1gcsekHEtDm4?=
 =?us-ascii?Q?N/oLKOscjTUU799q/ONUUTp2pEQ2iZsjuvSwHhAE3SpG6KbPrlU79DgIsi85?=
 =?us-ascii?Q?QvaMxBpcsx1kgqyXKP4TDiJ1vxxV9wQBOKRSM5k/4CynHfAZJZVm9GXmcXCP?=
 =?us-ascii?Q?vfA9+ga1XgZvyf4EeMX+ylo0v+clyk3i9pn+ImMQgOtf9XbgC+QLBuQtAsvX?=
 =?us-ascii?Q?HHyJvXia3hCipb6QgBDc8yRr8u29sYKIBIpRwvuTjyPxBUmSKTcej1TIuIhR?=
 =?us-ascii?Q?YvPS98rxrybnF084Sfs0c+gAPM6CiMgnLFk13yoL7Ln4aErFgiD0ZiN43KdK?=
 =?us-ascii?Q?RNNtWEVXPz78tgUAVkGxPQoK4UG2r3iNxiZPtpOTZKnVzQA2m1eUhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?paCbWkTcQOeeu6uLhKJLJcwMdmAjxcdStpmI5KXruprDF2htrEgNwBQwCH/V?=
 =?us-ascii?Q?IAwUIu7lakwpjMw+NjSE2FMCaYcmNoGdIL+P+H4rxaGG13Rv9r0fDmRtQHXa?=
 =?us-ascii?Q?MXsdsaBNGMz9NZ3jNq4OIkS5S8VnInsFykkF571a8qTgqUbc/iLLDYRIv8wK?=
 =?us-ascii?Q?7P+IGgu1Ej8jr7XmSCLhwiKvckX1IiNQHj7J9WqXVeF4hMGA6hQPNgxhGD4o?=
 =?us-ascii?Q?5p+q+IkUIhSHO1oTRasEMkDeeLM1Wsw1qL5IYl36p2Y3Jz/WSvdw9fCmlCeX?=
 =?us-ascii?Q?D1C5nd/rD8vBOEIViu1eZboDHWm3zLfjewADVoocCz2nkiFTJj66bF/th6vd?=
 =?us-ascii?Q?9OWRGrQmgejhDxWZwAP2t3FRqGaWOJ9UuzAliY5BfJgmjj+9k9aMRcWzLqtQ?=
 =?us-ascii?Q?4f6cVOXDmPnS2aknEeV++FsY/8FgRGAShCHN8jKIC5WtyRgryYYSU+UVvr6x?=
 =?us-ascii?Q?B25XiA8TLLVO74R+niDlDN2IKUEBl9wbuXG6BGg5x2Tb1UQbcsLBSZpa4Nr2?=
 =?us-ascii?Q?suaGaLFCRiESuhgwGtBGV8od1+1plZgjTfzM1z9+VAGq3+W6vHmQRREO7XKR?=
 =?us-ascii?Q?PuKGi9XQVtJRReXjxOPcknxiJvBz/ZQkXsXvaMxLE+PQHHkY9UFxb3LAXMze?=
 =?us-ascii?Q?egkAuYw1YrMi/KjTnji0FWYV5hcQn/ItPBrwnAbKwF8kaaRdB2eq9uwt+r50?=
 =?us-ascii?Q?W3rcm5ZL9eAchqju3BrB2NmBhRNYXIN0lVwmw640Vq34+T3Sar+VCgzpRNdg?=
 =?us-ascii?Q?do4Jhsj1lQiqKKNmpqKTBflTZtg0MY78oeC6RN+Jprq4Lu+Ob8qe80gHUBmC?=
 =?us-ascii?Q?u1WQXNM0XHD+PLw89SKoEjTrbT2CqWW8MHUeGUMf1I2T/X7/hxasSvD8xmo8?=
 =?us-ascii?Q?c4W0Oy79bdHgiHvu7q/PgjKjOrf7mMg3atbvOnG4c+wWSKqKApUqFFQkin3H?=
 =?us-ascii?Q?SrVLJUnbm7IeqcZViai/MHkT4n67l3mQGUqkHEjWVbK5JvBr3Pi4vT+f3B2w?=
 =?us-ascii?Q?ff9MvlplMVJ2ynNp2VNN8DTjOQo4DFQWY07NUJ/SDX/sDx3ou5PFTHlW4ptu?=
 =?us-ascii?Q?ICNG40kPUMEMWgTbjPCsELVrqcDdEuPmTkNsFWFyIzzYxMU6/nSmB4+aqqnd?=
 =?us-ascii?Q?UYSmnJFPUsac7f5GyuOjlAmLRY6RSsezPaSeODzPYWuFlQ7ZTJNd/s+ehgjD?=
 =?us-ascii?Q?GKCmOy7X9AJZP13dlLNZ1nUJFV6vPfnhFKLdyfIi1HDNlSvSGE+sRds2o7Y+?=
 =?us-ascii?Q?r1WzgR6/t0fTZVQlpipShcWPeNWUPTz1sNCBMknSCmW/7LYfk5UJaDcCrRGi?=
 =?us-ascii?Q?WhP0v0qqaCHc64KG6k98h6eIwvMt7P1nacWL8rUd5AZm2+c9Ai6rLP+9m51V?=
 =?us-ascii?Q?tTsMuINHYz2FC4900sGEGWqV3EeQgiJbY0xAR6ItZ93rnvKYuo17J3i3/+aY?=
 =?us-ascii?Q?tDAhXDi08sOcJVUmnNgB9bUoF0ARr66Hej5NVwBRrbeH71MxjNtF5IZnQgtq?=
 =?us-ascii?Q?FUUywvWgixfgXIu6W8yBYDDopqtbCA1h9wqWKLqq0HGWL8RE5DhpdEwzZLyv?=
 =?us-ascii?Q?Z5mUVRFrCFE4GaPfDxRa96VxpP1ZQKmxAKIybKnW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11a42f8-ec91-421b-9999-08ddc8204239
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:31:43.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gm35k3bMuE66wFdJd1pO/7ugZYbOMAW4jMy4mQqwzjwGbnPdRjI2imoTkHrQ8S7CZnIm8pxRmIR6iWEgLRVTjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8967

Implement command and event to communicate with NXP FW.
Function table is used for the search of command and event.
Handler for command response will be hooked to command node
for the first search of corresponding command.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c    | 1284 +++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h    |   98 +
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c   | 3449 ++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c |  868 +++++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c   | 1234 +++++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c |  490 +++
 6 files changed, 7423 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cmdevt.c b/drivers/net/wireless/nxp/nxpwifi/cmdevt.c
new file mode 100644
index 000000000000..09549406509a
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cmdevt.c
@@ -0,0 +1,1284 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: commands and events
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include <asm/unaligned.h>
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+
+static void nxpwifi_cancel_pending_ioctl(struct nxpwifi_adapter *adapter);
+
+/* This function initializes a command node.
+ *
+ * The actual allocation of the node is not done by this function. It only
+ * initiates a node by filling it with default parameters. Similarly,
+ * allocation of the different buffers used (IOCTL buffer, data buffer) are
+ * not done by this function either.
+ */
+static void
+nxpwifi_init_cmd_node(struct nxpwifi_private *priv,
+		      struct cmd_ctrl_node *cmd_node,
+		      u32 cmd_no, void *data_buf, bool sync)
+{
+	cmd_node->priv = priv;
+	cmd_node->cmd_no = cmd_no;
+
+	if (sync) {
+		cmd_node->wait_q_enabled = true;
+		cmd_node->cmd_wait_q_woken = false;
+		cmd_node->condition = &cmd_node->cmd_wait_q_woken;
+	}
+	cmd_node->data_buf = data_buf;
+	cmd_node->cmd_skb = cmd_node->skb;
+	cmd_node->cmd_resp = NULL;
+}
+
+/* This function returns a command node from the free queue depending upon
+ * availability.
+ */
+static struct cmd_ctrl_node *
+nxpwifi_get_cmd_node(struct nxpwifi_adapter *adapter)
+{
+	struct cmd_ctrl_node *cmd_node;
+
+	spin_lock_bh(&adapter->cmd_free_q_lock);
+	if (list_empty(&adapter->cmd_free_q)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "GET_CMD_NODE: cmd node not available\n");
+		spin_unlock_bh(&adapter->cmd_free_q_lock);
+		return NULL;
+	}
+	cmd_node = list_first_entry(&adapter->cmd_free_q,
+				    struct cmd_ctrl_node, list);
+	list_del(&cmd_node->list);
+	spin_unlock_bh(&adapter->cmd_free_q_lock);
+
+	return cmd_node;
+}
+
+/* This function cleans up a command node.
+ *
+ * The function resets the fields including the buffer pointers.
+ * This function does not try to free the buffers. They must be
+ * freed before calling this function.
+ *
+ * This function will however call the receive completion callback
+ * in case a response buffer is still available before resetting
+ * the pointer.
+ */
+static void
+nxpwifi_clean_cmd_node(struct nxpwifi_adapter *adapter,
+		       struct cmd_ctrl_node *cmd_node)
+{
+	cmd_node->cmd_no = 0;
+	cmd_node->cmd_flag = 0;
+	cmd_node->data_buf = NULL;
+	cmd_node->wait_q_enabled = false;
+
+	if (cmd_node->cmd_skb)
+		skb_trim(cmd_node->cmd_skb, 0);
+
+	if (cmd_node->resp_skb) {
+		adapter->if_ops.cmdrsp_complete(adapter, cmd_node->resp_skb);
+		cmd_node->resp_skb = NULL;
+	}
+}
+
+/* This function returns a command to the command free queue.
+ *
+ * The function also calls the completion callback if required, before
+ * cleaning the command node and re-inserting it into the free queue.
+ */
+static void
+nxpwifi_insert_cmd_to_free_q(struct nxpwifi_adapter *adapter,
+			     struct cmd_ctrl_node *cmd_node)
+{
+	if (!cmd_node)
+		return;
+
+	if (cmd_node->wait_q_enabled)
+		nxpwifi_complete_cmd(adapter, cmd_node);
+	/* Clean the node */
+	nxpwifi_clean_cmd_node(adapter, cmd_node);
+
+	/* Insert node into cmd_free_q */
+	spin_lock_bh(&adapter->cmd_free_q_lock);
+	list_add_tail(&cmd_node->list, &adapter->cmd_free_q);
+	spin_unlock_bh(&adapter->cmd_free_q_lock);
+}
+
+/* This function reuses a command node. */
+void nxpwifi_recycle_cmd_node(struct nxpwifi_adapter *adapter,
+			      struct cmd_ctrl_node *cmd_node)
+{
+	struct host_cmd_ds_command *host_cmd = (void *)cmd_node->cmd_skb->data;
+
+	nxpwifi_insert_cmd_to_free_q(adapter, cmd_node);
+
+	atomic_dec(&adapter->cmd_pending);
+	nxpwifi_dbg(adapter, CMD,
+		    "cmd: FREE_CMD: cmd=%#x, cmd_pending=%d\n",
+		le16_to_cpu(host_cmd->command),
+		atomic_read(&adapter->cmd_pending));
+}
+
+/* This function sends a host command to the firmware.
+ *
+ * The function copies the host command into the driver command
+ * buffer, which will be transferred to the firmware later by the
+ * main thread.
+ */
+static int nxpwifi_cmd_host_cmd(struct nxpwifi_private *priv,
+				struct cmd_ctrl_node *cmd_node)
+{
+	struct host_cmd_ds_command *cmd;
+	struct nxpwifi_ds_misc_cmd *pcmd_ptr;
+
+	cmd = (struct host_cmd_ds_command *)cmd_node->skb->data;
+	pcmd_ptr = (struct nxpwifi_ds_misc_cmd *)cmd_node->data_buf;
+
+	/* Copy the HOST command to command buffer */
+	memcpy(cmd, pcmd_ptr->cmd, pcmd_ptr->len);
+	nxpwifi_dbg(priv->adapter, CMD,
+		    "cmd: host cmd size = %d\n", pcmd_ptr->len);
+	return 0;
+}
+
+/* This function downloads a command to the firmware.
+ *
+ * The function performs sanity tests, sets the command sequence
+ * number and size, converts the header fields to CPU format before
+ * sending. Afterwards, it logs the command ID and action for debugging
+ * and sets up the command timeout timer.
+ */
+static int nxpwifi_dnld_cmd_to_fw(struct nxpwifi_private *priv,
+				  struct cmd_ctrl_node *cmd_node)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+	struct host_cmd_ds_command *host_cmd;
+	u16 cmd_code;
+	u16 cmd_size;
+
+	if (!adapter || !cmd_node)
+		return -EINVAL;
+
+	host_cmd = (struct host_cmd_ds_command *)(cmd_node->cmd_skb->data);
+
+	/* Sanity test */
+	if (host_cmd->size == 0) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "DNLD_CMD: host_cmd is null\t"
+			    "or cmd size is 0, not sending\n");
+		if (cmd_node->wait_q_enabled)
+			adapter->cmd_wait_q.status = -1;
+		nxpwifi_recycle_cmd_node(adapter, cmd_node);
+		return -EINVAL;
+	}
+
+	cmd_code = le16_to_cpu(host_cmd->command);
+	cmd_node->cmd_no = cmd_code;
+	cmd_size = le16_to_cpu(host_cmd->size);
+
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_RESET &&
+	    cmd_code != HOST_CMD_FUNC_SHUTDOWN &&
+	    cmd_code != HOST_CMD_FUNC_INIT) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "DNLD_CMD: FW in reset state, ignore cmd %#x\n",
+			cmd_code);
+		nxpwifi_recycle_cmd_node(adapter, cmd_node);
+		nxpwifi_queue_work(adapter, &adapter->main_work);
+		return -EPERM;
+	}
+
+	/* Set command sequence number */
+	adapter->seq_num++;
+	host_cmd->seq_num = cpu_to_le16(HOST_SET_SEQ_NO_BSS_INFO
+					(adapter->seq_num,
+					 cmd_node->priv->bss_num,
+					 cmd_node->priv->bss_type));
+
+	spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+	adapter->curr_cmd = cmd_node;
+	spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+
+	/* Adjust skb length */
+	if (cmd_node->cmd_skb->len > cmd_size)
+		/* cmd_size is less than sizeof(struct host_cmd_ds_command).
+		 * Trim off the unused portion.
+		 */
+		skb_trim(cmd_node->cmd_skb, cmd_size);
+	else if (cmd_node->cmd_skb->len < cmd_size)
+		/* cmd_size is larger than sizeof(struct host_cmd_ds_command)
+		 * because we have appended custom IE TLV. Increase skb length
+		 * accordingly.
+		 */
+		skb_put(cmd_node->cmd_skb, cmd_size - cmd_node->cmd_skb->len);
+
+	nxpwifi_dbg(adapter, CMD,
+		    "cmd: DNLD_CMD: %#x, act %#x, len %d, seqno %#x\n",
+		    cmd_code,
+		    get_unaligned_le16((u8 *)host_cmd + S_DS_GEN),
+		    cmd_size, le16_to_cpu(host_cmd->seq_num));
+	nxpwifi_dbg_dump(adapter, CMD_D, "cmd buffer:", host_cmd, cmd_size);
+
+	skb_push(cmd_node->cmd_skb, adapter->intf_hdr_len);
+	ret = adapter->if_ops.host_to_card(adapter, NXPWIFI_TYPE_CMD,
+					   cmd_node->cmd_skb, NULL);
+	skb_pull(cmd_node->cmd_skb, adapter->intf_hdr_len);
+
+	if (ret) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "DNLD_CMD: host to card failed\n");
+		if (cmd_node->wait_q_enabled)
+			adapter->cmd_wait_q.status = -1;
+		nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
+
+		spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+		adapter->curr_cmd = NULL;
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+
+		adapter->dbg.num_cmd_host_to_card_failure++;
+		return ret;
+	}
+
+	/* Save the last command id and action to debug log */
+	adapter->dbg.last_cmd_index =
+			(adapter->dbg.last_cmd_index + 1) % DBG_CMD_NUM;
+	adapter->dbg.last_cmd_id[adapter->dbg.last_cmd_index] = cmd_code;
+	adapter->dbg.last_cmd_act[adapter->dbg.last_cmd_index] =
+			get_unaligned_le16((u8 *)host_cmd + S_DS_GEN);
+
+	/* Setup the timer after transmit command, except that specific
+	 * command might not have command response.
+	 */
+	if (cmd_code != HOST_CMD_FW_DUMP_EVENT)
+		mod_timer(&adapter->cmd_timer,
+			  jiffies + msecs_to_jiffies(NXPWIFI_TIMER_10S));
+
+	/* Clear BSS_NO_BITS from HOST */
+	cmd_code &= HOST_CMD_ID_MASK;
+
+	return 0;
+}
+
+/* This function downloads a sleep confirm command to the firmware.
+ *
+ * The function performs sanity tests, sets the command sequence
+ * number and size, converts the header fields to CPU format before
+ * sending.
+ *
+ * No responses are needed for sleep confirm command.
+ */
+static int nxpwifi_dnld_sleep_confirm_cmd(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+	struct nxpwifi_private *priv;
+	struct nxpwifi_opt_sleep_confirm *sleep_cfm_buf =
+				(struct nxpwifi_opt_sleep_confirm *)
+						adapter->sleep_cfm->data;
+
+	priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+
+	adapter->seq_num++;
+	sleep_cfm_buf->seq_num =
+		cpu_to_le16(HOST_SET_SEQ_NO_BSS_INFO
+					(adapter->seq_num, priv->bss_num,
+					 priv->bss_type));
+
+	nxpwifi_dbg(adapter, CMD,
+		    "cmd: DNLD_CMD: %#x, act %#x, len %d, seqno %#x\n",
+		le16_to_cpu(sleep_cfm_buf->command),
+		le16_to_cpu(sleep_cfm_buf->action),
+		le16_to_cpu(sleep_cfm_buf->size),
+		le16_to_cpu(sleep_cfm_buf->seq_num));
+	nxpwifi_dbg_dump(adapter, CMD_D, "SLEEP_CFM buffer: ", sleep_cfm_buf,
+			 le16_to_cpu(sleep_cfm_buf->size));
+
+	skb_push(adapter->sleep_cfm, adapter->intf_hdr_len);
+	ret = adapter->if_ops.host_to_card(adapter, NXPWIFI_TYPE_CMD,
+					   adapter->sleep_cfm, NULL);
+	skb_pull(adapter->sleep_cfm, adapter->intf_hdr_len);
+
+	if (ret) {
+		nxpwifi_dbg(adapter, ERROR, "SLEEP_CFM: failed\n");
+		adapter->dbg.num_cmd_sleep_cfm_host_to_card_failure++;
+		return ret;
+	}
+
+	if (!le16_to_cpu(sleep_cfm_buf->resp_ctrl))
+		/* Response is not needed for sleep confirm command */
+		adapter->ps_state = PS_STATE_SLEEP;
+	else
+		adapter->ps_state = PS_STATE_SLEEP_CFM;
+
+	if (!le16_to_cpu(sleep_cfm_buf->resp_ctrl) &&
+	    (test_bit(NXPWIFI_IS_HS_CONFIGURED, &adapter->work_flags) &&
+	     !adapter->sleep_period.period)) {
+		adapter->pm_wakeup_card_req = true;
+		nxpwifi_hs_activated_event(nxpwifi_get_priv
+				(adapter, NXPWIFI_BSS_ROLE_ANY), true);
+	}
+
+	return ret;
+}
+
+/* This function allocates the command buffers and links them to
+ * the command free queue.
+ *
+ * The driver uses a pre allocated number of command buffers, which
+ * are created at driver initializations and freed at driver cleanup.
+ * Every command needs to obtain a command buffer from this pool before
+ * it can be issued. The command free queue lists the command buffers
+ * currently free to use, while the command pending queue lists the
+ * command buffers already in use and awaiting handling. Command buffers
+ * are returned to the free queue after use.
+ */
+int nxpwifi_alloc_cmd_buffer(struct nxpwifi_adapter *adapter)
+{
+	struct cmd_ctrl_node *cmd_array;
+	u32 i;
+
+	/* Allocate and initialize struct cmd_ctrl_node */
+	cmd_array = kcalloc(NXPWIFI_NUM_OF_CMD_BUFFER,
+			    sizeof(struct cmd_ctrl_node), GFP_KERNEL);
+	if (!cmd_array)
+		return -ENOMEM;
+
+	adapter->cmd_pool = cmd_array;
+
+	/* Allocate and initialize command buffers */
+	for (i = 0; i < NXPWIFI_NUM_OF_CMD_BUFFER; i++) {
+		cmd_array[i].skb = dev_alloc_skb(NXPWIFI_SIZE_OF_CMD_BUFFER);
+		if (!cmd_array[i].skb)
+			return -ENOMEM;
+	}
+
+	for (i = 0; i < NXPWIFI_NUM_OF_CMD_BUFFER; i++)
+		nxpwifi_insert_cmd_to_free_q(adapter, &cmd_array[i]);
+
+	return 0;
+}
+
+/* This function frees the command buffers.
+ *
+ * The function calls the completion callback for all the command
+ * buffers that still have response buffers associated with them.
+ */
+void nxpwifi_free_cmd_buffer(struct nxpwifi_adapter *adapter)
+{
+	struct cmd_ctrl_node *cmd_array;
+	u32 i;
+
+	/* Need to check if cmd pool is allocated or not */
+	if (!adapter->cmd_pool) {
+		nxpwifi_dbg(adapter, FATAL,
+			    "info: FREE_CMD_BUF: cmd_pool is null\n");
+		return;
+	}
+
+	cmd_array = adapter->cmd_pool;
+
+	/* Release shared memory buffers */
+	for (i = 0; i < NXPWIFI_NUM_OF_CMD_BUFFER; i++) {
+		if (cmd_array[i].skb) {
+			nxpwifi_dbg(adapter, CMD,
+				    "cmd: free cmd buffer %d\n", i);
+			dev_kfree_skb_any(cmd_array[i].skb);
+		}
+		if (!cmd_array[i].resp_skb)
+			continue;
+
+		dev_kfree_skb_any(cmd_array[i].resp_skb);
+	}
+	/* Release struct cmd_ctrl_node */
+	if (adapter->cmd_pool) {
+		nxpwifi_dbg(adapter, CMD,
+			    "cmd: free cmd pool\n");
+		kfree(adapter->cmd_pool);
+		adapter->cmd_pool = NULL;
+	}
+}
+
+/* This function handles events generated by firmware.
+ *
+ * Event body of events received from firmware are not used (though they are
+ * saved), only the event ID is used. Some events are re-invoked by
+ * the driver, with a new event body.
+ *
+ * After processing, the function calls the completion callback
+ * for cleanup.
+ */
+int nxpwifi_process_event(struct nxpwifi_adapter *adapter)
+{
+	int ret, i;
+	struct nxpwifi_private *priv =
+		nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+	struct sk_buff *skb = adapter->event_skb;
+	u32 eventcause;
+	struct nxpwifi_rxinfo *rx_info;
+
+	if ((adapter->event_cause & EVENT_ID_MASK) == EVENT_RADAR_DETECTED) {
+		for (i = 0; i < adapter->priv_num; i++) {
+			priv = adapter->priv[i];
+			if (nxpwifi_is_11h_active(priv)) {
+				adapter->event_cause |=
+					((priv->bss_num & 0xff) << 16) |
+					((priv->bss_type & 0xff) << 24);
+				break;
+			}
+		}
+	}
+
+	eventcause = adapter->event_cause;
+
+	/* Save the last event to debug log */
+	adapter->dbg.last_event_index =
+		(adapter->dbg.last_event_index + 1) % DBG_CMD_NUM;
+	adapter->dbg.last_event[adapter->dbg.last_event_index] =
+		(u16)eventcause;
+
+	/* Get BSS number and corresponding priv */
+	priv = nxpwifi_get_priv_by_id(adapter, EVENT_GET_BSS_NUM(eventcause),
+				      EVENT_GET_BSS_TYPE(eventcause));
+	if (!priv)
+		priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+
+	/* Clear BSS_NO_BITS from event */
+	eventcause &= EVENT_ID_MASK;
+	adapter->event_cause = eventcause;
+
+	if (skb) {
+		rx_info = NXPWIFI_SKB_RXCB(skb);
+		memset(rx_info, 0, sizeof(*rx_info));
+		rx_info->bss_num = priv->bss_num;
+		rx_info->bss_type = priv->bss_type;
+		nxpwifi_dbg_dump(adapter, EVT_D, "Event Buf:",
+				 skb->data, skb->len);
+	}
+
+	nxpwifi_dbg(adapter, EVENT, "EVENT: cause: %#x\n", eventcause);
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
+		ret = nxpwifi_process_uap_event(priv);
+	else
+		ret = nxpwifi_process_sta_event(priv);
+
+	adapter->event_cause = 0;
+	adapter->event_skb = NULL;
+	adapter->if_ops.event_complete(adapter, skb);
+
+	return ret;
+}
+
+/* This function prepares a command and send it to the firmware.
+ *
+ * Preparation includes -
+ *      - Sanity tests to make sure the card is still present or the FW
+ *        is not reset
+ *      - Getting a new command node from the command free queue
+ *      - Initializing the command node for default parameters
+ *      - Fill up the non-default parameters and buffer pointers
+ *      - Add the command to pending queue
+ */
+int nxpwifi_send_cmd(struct nxpwifi_private *priv, u16 cmd_no,
+		     u16 cmd_action, u32 cmd_oid, void *data_buf, bool sync)
+{
+	int ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct cmd_ctrl_node *cmd_node;
+
+	if (!adapter) {
+		pr_err("PREP_CMD: adapter is NULL\n");
+		return -EINVAL;
+	}
+
+	if (test_bit(NXPWIFI_IS_SUSPENDED, &adapter->work_flags)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "PREP_CMD: device in suspended state\n");
+		return -EPERM;
+	}
+
+	if (test_bit(NXPWIFI_IS_HS_ENABLING, &adapter->work_flags) &&
+	    cmd_no != HOST_CMD_802_11_HS_CFG_ENH) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "PREP_CMD: host entering sleep state\n");
+		return -EPERM;
+	}
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "PREP_CMD: card is removed\n");
+		return -EPERM;
+	}
+
+	if (test_bit(NXPWIFI_IS_CMD_TIMEDOUT, &adapter->work_flags)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "PREP_CMD: FW is in bad state\n");
+		return -EPERM;
+	}
+
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_RESET) {
+		if (cmd_no != HOST_CMD_FUNC_INIT) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "PREP_CMD: FW in reset state\n");
+			return -EPERM;
+		}
+	}
+
+	if (priv->adapter->hs_activated_manually &&
+	    cmd_no != HOST_CMD_802_11_HS_CFG_ENH) {
+		nxpwifi_cancel_hs(priv, NXPWIFI_ASYNC_CMD);
+		priv->adapter->hs_activated_manually = false;
+	}
+
+	/* Get a new command node */
+	cmd_node = nxpwifi_get_cmd_node(adapter);
+
+	if (!cmd_node) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "PREP_CMD: no free cmd node\n");
+		return -ENOMEM;
+	}
+
+	/* Initialize the command node */
+	nxpwifi_init_cmd_node(priv, cmd_node, cmd_no, data_buf, sync);
+
+	if (!cmd_node->cmd_skb) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "PREP_CMD: no free cmd buf\n");
+		return -ENOMEM;
+	}
+
+	skb_put_zero(cmd_node->cmd_skb, sizeof(struct host_cmd_ds_command));
+
+	/* Prepare command */
+	if (cmd_no) {
+		switch (cmd_no) {
+		case HOST_CMD_UAP_SYS_CONFIG:
+		case HOST_CMD_UAP_BSS_START:
+		case HOST_CMD_UAP_BSS_STOP:
+		case HOST_CMD_UAP_STA_DEAUTH:
+		case HOST_CMD_APCMD_SYS_RESET:
+		case HOST_CMD_APCMD_STA_LIST:
+		case HOST_CMD_CHAN_REPORT_REQUEST:
+		case HOST_CMD_ADD_NEW_STATION:
+			ret = nxpwifi_uap_prepare_cmd(priv, cmd_node,
+						      cmd_action, cmd_oid);
+			break;
+		default:
+			ret = nxpwifi_sta_prepare_cmd(priv, cmd_node,
+						      cmd_action, cmd_oid);
+			break;
+		}
+	} else {
+		ret = nxpwifi_cmd_host_cmd(priv, cmd_node);
+		cmd_node->cmd_flag |= CMD_F_HOSTCMD;
+	}
+
+	/* Return error, since the command preparation failed */
+	if (ret) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "PREP_CMD: cmd %#x preparation failed\n",
+			    cmd_no);
+		nxpwifi_insert_cmd_to_free_q(adapter, cmd_node);
+		return ret;
+	}
+
+	/* Send command */
+	if (cmd_no == HOST_CMD_802_11_SCAN ||
+	    cmd_no == HOST_CMD_802_11_SCAN_EXT) {
+		nxpwifi_queue_scan_cmd(priv, cmd_node);
+	} else {
+		nxpwifi_insert_cmd_to_pending_q(adapter, cmd_node);
+		nxpwifi_queue_work(adapter, &adapter->main_work);
+		if (cmd_node->wait_q_enabled)
+			ret = nxpwifi_wait_queue_complete(adapter, cmd_node);
+	}
+
+	return ret;
+}
+
+/* This function queues a command to the command pending queue.
+ *
+ * This in effect adds the command to the command list to be executed.
+ * Exit PS command is handled specially, by placing it always to the
+ * front of the command queue.
+ */
+void
+nxpwifi_insert_cmd_to_pending_q(struct nxpwifi_adapter *adapter,
+				struct cmd_ctrl_node *cmd_node)
+{
+	struct host_cmd_ds_command *host_cmd = NULL;
+	u16 command;
+	bool add_tail = true;
+
+	host_cmd = (struct host_cmd_ds_command *)(cmd_node->cmd_skb->data);
+	if (!host_cmd) {
+		nxpwifi_dbg(adapter, ERROR, "QUEUE_CMD: host_cmd is NULL\n");
+		return;
+	}
+
+	command = le16_to_cpu(host_cmd->command);
+
+	/* Exit_PS command needs to be queued in the header always. */
+	if (command == HOST_CMD_802_11_PS_MODE_ENH) {
+		struct host_cmd_ds_802_11_ps_mode_enh *pm =
+						&host_cmd->params.psmode_enh;
+		if ((le16_to_cpu(pm->action) == DIS_PS) ||
+		    (le16_to_cpu(pm->action) == DIS_AUTO_PS)) {
+			if (adapter->ps_state != PS_STATE_AWAKE)
+				add_tail = false;
+		}
+	}
+
+	/* Same with exit host sleep cmd, luckily that can't happen at the same time as EXIT_PS */
+	if (command == HOST_CMD_802_11_HS_CFG_ENH) {
+		struct host_cmd_ds_802_11_hs_cfg_enh *hs_cfg =
+			&host_cmd->params.opt_hs_cfg;
+
+		if (le16_to_cpu(hs_cfg->action) == HS_ACTIVATE)
+			add_tail = false;
+	}
+
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	if (add_tail)
+		list_add_tail(&cmd_node->list, &adapter->cmd_pending_q);
+	else
+		list_add(&cmd_node->list, &adapter->cmd_pending_q);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+
+	atomic_inc(&adapter->cmd_pending);
+	nxpwifi_dbg(adapter, CMD,
+		    "cmd: QUEUE_CMD: cmd=%#x, cmd_pending=%d\n",
+		    command, atomic_read(&adapter->cmd_pending));
+}
+
+/* This function executes the next command in command pending queue.
+ *
+ * This function will fail if a command is already in processing stage,
+ * otherwise it will dequeue the first command from the command pending
+ * queue and send to the firmware.
+ *
+ * If the device is currently in host sleep mode, any commands, except the
+ * host sleep configuration command will de-activate the host sleep. For PS
+ * mode, the function will put the firmware back to sleep if applicable.
+ */
+int nxpwifi_exec_next_cmd(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	struct cmd_ctrl_node *cmd_node;
+	int ret = 0;
+	struct host_cmd_ds_command *host_cmd;
+
+	/* Check if already in processing */
+	if (adapter->curr_cmd) {
+		nxpwifi_dbg(adapter, FATAL,
+			    "EXEC_NEXT_CMD: cmd in processing\n");
+		return -EBUSY;
+	}
+
+	spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+	/* Check if any command is pending */
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	if (list_empty(&adapter->cmd_pending_q)) {
+		spin_unlock_bh(&adapter->cmd_pending_q_lock);
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+		return 0;
+	}
+	cmd_node = list_first_entry(&adapter->cmd_pending_q,
+				    struct cmd_ctrl_node, list);
+
+	host_cmd = (struct host_cmd_ds_command *)(cmd_node->cmd_skb->data);
+	priv = cmd_node->priv;
+
+	if (adapter->ps_state != PS_STATE_AWAKE) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: cannot send cmd in sleep state,\t"
+			    "this should not happen\n", __func__);
+		spin_unlock_bh(&adapter->cmd_pending_q_lock);
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+		return ret;
+	}
+
+	list_del(&cmd_node->list);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+
+	spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+	ret = nxpwifi_dnld_cmd_to_fw(priv, cmd_node);
+	priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+	/* Any command sent to the firmware when host is in sleep
+	 * mode should de-configure host sleep. We should skip the
+	 * host sleep configuration command itself though
+	 */
+	if (priv && host_cmd->command !=
+	     cpu_to_le16(HOST_CMD_802_11_HS_CFG_ENH)) {
+		if (adapter->hs_activated) {
+			clear_bit(NXPWIFI_IS_HS_CONFIGURED,
+				  &adapter->work_flags);
+			nxpwifi_hs_activated_event(priv, false);
+		}
+	}
+
+	return ret;
+}
+
+static void
+nxpwifi_process_cmdresp_error(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_802_11_ps_mode_enh *pm;
+
+	nxpwifi_dbg(adapter, ERROR,
+		    "CMD_RESP: cmd %#x error, result=%#x\n",
+		    resp->command, resp->result);
+
+	if (adapter->curr_cmd->wait_q_enabled)
+		adapter->cmd_wait_q.status = -1;
+
+	switch (le16_to_cpu(resp->command)) {
+	case HOST_CMD_802_11_PS_MODE_ENH:
+		pm = &resp->params.psmode_enh;
+		nxpwifi_dbg(adapter, ERROR,
+			    "PS_MODE_ENH cmd failed: result=0x%x action=0x%X\n",
+			    resp->result, le16_to_cpu(pm->action));
+		break;
+	case HOST_CMD_802_11_SCAN:
+	case HOST_CMD_802_11_SCAN_EXT:
+		nxpwifi_cancel_scan(adapter);
+		break;
+
+	case HOST_CMD_MAC_CONTROL:
+		break;
+
+	case HOST_CMD_SDIO_SP_RX_AGGR_CFG:
+		nxpwifi_dbg(adapter, MSG,
+			    "SDIO RX single-port aggregation Not support\n");
+		break;
+
+	default:
+		break;
+	}
+	/* Handling errors here */
+	nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
+
+	spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+	adapter->curr_cmd = NULL;
+	spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+}
+
+/* This function handles the command response.
+ *
+ * After processing, the function cleans the command node and puts
+ * it back to the command free queue.
+ */
+int nxpwifi_process_cmdresp(struct nxpwifi_adapter *adapter)
+{
+	struct host_cmd_ds_command *resp;
+	struct nxpwifi_private *priv =
+		nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+	int ret = 0;
+	u16 orig_cmdresp_no;
+	u16 cmdresp_no;
+	u16 cmdresp_result;
+
+	if (!adapter->curr_cmd || !adapter->curr_cmd->resp_skb) {
+		resp = (struct host_cmd_ds_command *)adapter->upld_buf;
+		nxpwifi_dbg(adapter, ERROR,
+			    "CMD_RESP: NULL curr_cmd, %#x\n",
+			    le16_to_cpu(resp->command));
+		return -EINVAL;
+	}
+
+	resp = (struct host_cmd_ds_command *)adapter->curr_cmd->resp_skb->data;
+	orig_cmdresp_no = le16_to_cpu(resp->command);
+	cmdresp_no = (orig_cmdresp_no & HOST_CMD_ID_MASK);
+
+	if (adapter->curr_cmd->cmd_no != cmdresp_no) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "cmdresp error: cmd=0x%x cmd_resp=0x%x\n",
+			    adapter->curr_cmd->cmd_no, cmdresp_no);
+		return -EINVAL;
+	}
+	/* Now we got response from FW, cancel the command timer */
+	del_timer_sync(&adapter->cmd_timer);
+	clear_bit(NXPWIFI_IS_CMD_TIMEDOUT, &adapter->work_flags);
+
+	if (adapter->curr_cmd->cmd_flag & CMD_F_HOSTCMD) {
+		/* Copy original response back to response buffer */
+		struct nxpwifi_ds_misc_cmd *hostcmd;
+		u16 size = le16_to_cpu(resp->size);
+
+		nxpwifi_dbg(adapter, INFO,
+			    "info: host cmd resp size = %d\n", size);
+		size = min_t(u16, size, NXPWIFI_SIZE_OF_CMD_BUFFER);
+		if (adapter->curr_cmd->data_buf) {
+			hostcmd = adapter->curr_cmd->data_buf;
+			hostcmd->len = size;
+			memcpy(hostcmd->cmd, resp, size);
+		}
+	}
+
+	/* Get BSS number and corresponding priv */
+	priv = nxpwifi_get_priv_by_id
+	       (adapter, HOST_GET_BSS_NO(le16_to_cpu(resp->seq_num)),
+		HOST_GET_BSS_TYPE(le16_to_cpu(resp->seq_num)));
+	if (!priv)
+		priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+	/* Clear RET_BIT from HOST */
+	resp->command = cpu_to_le16(orig_cmdresp_no & HOST_CMD_ID_MASK);
+
+	cmdresp_no = le16_to_cpu(resp->command);
+	cmdresp_result = le16_to_cpu(resp->result);
+
+	/* Save the last command response to debug log */
+	adapter->dbg.last_cmd_resp_index =
+			(adapter->dbg.last_cmd_resp_index + 1) % DBG_CMD_NUM;
+	adapter->dbg.last_cmd_resp_id[adapter->dbg.last_cmd_resp_index] =
+								orig_cmdresp_no;
+
+	nxpwifi_dbg(adapter, CMD,
+		    "cmd: CMD_RESP: 0x%x, result %d, len %d, seqno 0x%x\n",
+		    orig_cmdresp_no, cmdresp_result,
+		    le16_to_cpu(resp->size), le16_to_cpu(resp->seq_num));
+	nxpwifi_dbg_dump(adapter, CMD_D, "CMD_RESP buffer:", resp,
+			 le16_to_cpu(resp->size));
+
+	if (!(orig_cmdresp_no & HOST_RET_BIT)) {
+		nxpwifi_dbg(adapter, ERROR, "CMD_RESP: invalid cmd resp\n");
+		if (adapter->curr_cmd->wait_q_enabled)
+			adapter->cmd_wait_q.status = -1;
+
+		nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
+		spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+		adapter->curr_cmd = NULL;
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+		return -EINVAL;
+	}
+
+	if (adapter->curr_cmd->cmd_flag & CMD_F_HOSTCMD) {
+		adapter->curr_cmd->cmd_flag &= ~CMD_F_HOSTCMD;
+		if (cmdresp_result == HOST_RESULT_OK &&
+		    cmdresp_no == HOST_CMD_802_11_HS_CFG_ENH)
+			ret = nxpwifi_ret_802_11_hs_cfg(priv, resp);
+	} else {
+		if (resp->result != HOST_RESULT_OK) {
+			nxpwifi_process_cmdresp_error(priv, resp);
+			return -EFAULT;
+		}
+		if (adapter->curr_cmd->cmd_resp) {
+			void *data_buf = adapter->curr_cmd->data_buf;
+
+			ret = adapter->curr_cmd->cmd_resp(priv, resp,
+							  cmdresp_no,
+							  data_buf);
+		}
+	}
+
+	/* Check init command response */
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_INITIALIZING) {
+		if (ret) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "%s: cmd %#x failed during\t"
+				    "initialization\n", __func__, cmdresp_no);
+			nxpwifi_init_fw_complete(adapter);
+			return ret;
+		} else if (adapter->last_init_cmd == cmdresp_no) {
+			adapter->hw_status = NXPWIFI_HW_STATUS_INIT_DONE;
+		}
+	}
+
+	if (adapter->curr_cmd) {
+		if (adapter->curr_cmd->wait_q_enabled)
+			adapter->cmd_wait_q.status = ret;
+
+		nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
+
+		spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+		adapter->curr_cmd = NULL;
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+	}
+
+	return ret;
+}
+
+void nxpwifi_process_assoc_resp(struct nxpwifi_adapter *adapter)
+{
+	struct cfg80211_rx_assoc_resp assoc_resp = {
+		.uapsd_queues = -1,
+	};
+	struct nxpwifi_private *priv =
+		nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_STA);
+
+	if (priv->assoc_rsp_size) {
+		assoc_resp.links[0].bss = priv->req_bss;
+		assoc_resp.buf = priv->assoc_rsp_buf;
+		assoc_resp.len = priv->assoc_rsp_size;
+		cfg80211_rx_assoc_resp(priv->netdev,
+				       &assoc_resp);
+		priv->assoc_rsp_size = 0;
+	}
+}
+
+/* This function handles the timeout of command sending.
+ *
+ * It will re-send the same command again.
+ */
+void
+nxpwifi_cmd_timeout_func(struct timer_list *t)
+{
+	struct nxpwifi_adapter *adapter = from_timer(adapter, t, cmd_timer);
+	struct cmd_ctrl_node *cmd_node;
+
+	set_bit(NXPWIFI_IS_CMD_TIMEDOUT, &adapter->work_flags);
+	if (!adapter->curr_cmd) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "cmd: empty curr_cmd\n");
+		return;
+	}
+	cmd_node = adapter->curr_cmd;
+	if (cmd_node) {
+		adapter->dbg.timeout_cmd_id =
+			adapter->dbg.last_cmd_id[adapter->dbg.last_cmd_index];
+		adapter->dbg.timeout_cmd_act =
+			adapter->dbg.last_cmd_act[adapter->dbg.last_cmd_index];
+		nxpwifi_dbg(adapter, MSG,
+			    "%s: Timeout cmd id = %#x, act = %#x\n", __func__,
+			    adapter->dbg.timeout_cmd_id,
+			    adapter->dbg.timeout_cmd_act);
+
+		nxpwifi_dbg(adapter, MSG,
+			    "num_data_h2c_failure = %d\n",
+			    adapter->dbg.num_tx_host_to_card_failure);
+		nxpwifi_dbg(adapter, MSG,
+			    "num_cmd_h2c_failure = %d\n",
+			    adapter->dbg.num_cmd_host_to_card_failure);
+
+		nxpwifi_dbg(adapter, MSG,
+			    "is_cmd_timedout = %d\n",
+			    test_bit(NXPWIFI_IS_CMD_TIMEDOUT,
+				     &adapter->work_flags));
+		nxpwifi_dbg(adapter, MSG,
+			    "num_tx_timeout = %d\n",
+			    adapter->dbg.num_tx_timeout);
+
+		nxpwifi_dbg(adapter, MSG,
+			    "last_cmd_index = %d\n",
+			    adapter->dbg.last_cmd_index);
+		nxpwifi_dbg(adapter, MSG,
+			    "last_cmd_id: %*ph\n",
+			    (int)sizeof(adapter->dbg.last_cmd_id),
+			    adapter->dbg.last_cmd_id);
+		nxpwifi_dbg(adapter, MSG,
+			    "last_cmd_act: %*ph\n",
+			    (int)sizeof(adapter->dbg.last_cmd_act),
+			    adapter->dbg.last_cmd_act);
+
+		nxpwifi_dbg(adapter, MSG,
+			    "last_cmd_resp_index = %d\n",
+			    adapter->dbg.last_cmd_resp_index);
+		nxpwifi_dbg(adapter, MSG,
+			    "last_cmd_resp_id: %*ph\n",
+			    (int)sizeof(adapter->dbg.last_cmd_resp_id),
+			    adapter->dbg.last_cmd_resp_id);
+
+		nxpwifi_dbg(adapter, MSG,
+			    "last_event_index = %d\n",
+			    adapter->dbg.last_event_index);
+		nxpwifi_dbg(adapter, MSG,
+			    "last_event: %*ph\n",
+			    (int)sizeof(adapter->dbg.last_event),
+			    adapter->dbg.last_event);
+
+		nxpwifi_dbg(adapter, MSG,
+			    "data_sent=%d cmd_sent=%d\n",
+			    adapter->data_sent, adapter->cmd_sent);
+
+		nxpwifi_dbg(adapter, MSG,
+			    "ps_mode=%d ps_state=%d\n",
+			    adapter->ps_mode, adapter->ps_state);
+
+		if (cmd_node->wait_q_enabled) {
+			adapter->cmd_wait_q.status = -ETIMEDOUT;
+			nxpwifi_cancel_pending_ioctl(adapter);
+		}
+	}
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_INITIALIZING) {
+		nxpwifi_init_fw_complete(adapter);
+		return;
+	}
+
+	if (adapter->if_ops.device_dump)
+		adapter->if_ops.device_dump(adapter);
+
+	if (adapter->if_ops.card_reset)
+		adapter->if_ops.card_reset(adapter);
+}
+
+void
+nxpwifi_cancel_pending_scan_cmd(struct nxpwifi_adapter *adapter)
+{
+	struct cmd_ctrl_node *cmd_node = NULL, *tmp_node;
+
+	/* Cancel all pending scan command */
+	spin_lock_bh(&adapter->scan_pending_q_lock);
+	list_for_each_entry_safe(cmd_node, tmp_node,
+				 &adapter->scan_pending_q, list) {
+		list_del(&cmd_node->list);
+		cmd_node->wait_q_enabled = false;
+		nxpwifi_insert_cmd_to_free_q(adapter, cmd_node);
+	}
+	spin_unlock_bh(&adapter->scan_pending_q_lock);
+}
+
+/* This function cancels all the pending commands.
+ *
+ * The current command, all commands in command pending queue and all scan
+ * commands in scan pending queue are cancelled. All the completion callbacks
+ * are called with failure status to ensure cleanup.
+ */
+void
+nxpwifi_cancel_all_pending_cmd(struct nxpwifi_adapter *adapter)
+{
+	struct cmd_ctrl_node *cmd_node = NULL, *tmp_node;
+
+	spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+	/* Cancel current cmd */
+	if (adapter->curr_cmd && adapter->curr_cmd->wait_q_enabled) {
+		adapter->cmd_wait_q.status = -1;
+		nxpwifi_complete_cmd(adapter, adapter->curr_cmd);
+		adapter->curr_cmd->wait_q_enabled = false;
+		/* no recycle probably wait for response */
+	}
+	/* Cancel all pending command */
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	list_for_each_entry_safe(cmd_node, tmp_node,
+				 &adapter->cmd_pending_q, list) {
+		list_del(&cmd_node->list);
+
+		if (cmd_node->wait_q_enabled)
+			adapter->cmd_wait_q.status = -1;
+		nxpwifi_recycle_cmd_node(adapter, cmd_node);
+	}
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+	spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+
+	nxpwifi_cancel_scan(adapter);
+}
+
+/* This function cancels all pending commands that matches with
+ * the given IOCTL request.
+ *
+ * Both the current command buffer and the pending command queue are
+ * searched for matching IOCTL request. The completion callback of
+ * the matched command is called with failure status to ensure cleanup.
+ * In case of scan commands, all pending commands in scan pending queue
+ * are cancelled.
+ */
+static void
+nxpwifi_cancel_pending_ioctl(struct nxpwifi_adapter *adapter)
+{
+	struct cmd_ctrl_node *cmd_node = NULL;
+
+	if (adapter->curr_cmd &&
+	    adapter->curr_cmd->wait_q_enabled) {
+		spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+		cmd_node = adapter->curr_cmd;
+		/* setting curr_cmd to NULL is quite dangerous, because
+		 * nxpwifi_process_cmdresp checks curr_cmd to be != NULL
+		 * at the beginning then relies on it and dereferences
+		 * it at will
+		 * this probably works since nxpwifi_cmd_timeout_func
+		 * is the only caller of this function and responses
+		 * at that point
+		 */
+		adapter->curr_cmd = NULL;
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+
+		nxpwifi_recycle_cmd_node(adapter, cmd_node);
+	}
+
+	nxpwifi_cancel_scan(adapter);
+}
+
+/* This function sends the sleep confirm command to firmware, if
+ * possible.
+ *
+ * The sleep confirm command cannot be issued if command response,
+ * data response or event response is awaiting handling, or if we
+ * are in the middle of sending a command, or expecting a command
+ * response.
+ */
+void
+nxpwifi_check_ps_cond(struct nxpwifi_adapter *adapter)
+{
+	if (!adapter->cmd_sent && !atomic_read(&adapter->tx_hw_pending) &&
+	    !adapter->curr_cmd && !IS_CARD_RX_RCVD(adapter))
+		nxpwifi_dnld_sleep_confirm_cmd(adapter);
+	else
+		nxpwifi_dbg(adapter, CMD,
+			    "cmd: Delay Sleep Confirm (%s%s%s%s)\n",
+			    (adapter->cmd_sent) ? "D" : "",
+			    atomic_read(&adapter->tx_hw_pending) ? "T" : "",
+			    (adapter->curr_cmd) ? "C" : "",
+			    (IS_CARD_RX_RCVD(adapter)) ? "R" : "");
+}
+
+/* This function sends a Host Sleep activated event to applications.
+ *
+ * This event is generated by the driver, with a blank event body.
+ */
+void
+nxpwifi_hs_activated_event(struct nxpwifi_private *priv, u8 activated)
+{
+	if (activated) {
+		if (test_bit(NXPWIFI_IS_HS_CONFIGURED,
+			     &priv->adapter->work_flags)) {
+			priv->adapter->hs_activated = true;
+			nxpwifi_update_rxreor_flags(priv->adapter,
+						    RXREOR_FORCE_NO_DROP);
+			nxpwifi_dbg(priv->adapter, EVENT,
+				    "event: hs_activated\n");
+			priv->adapter->hs_activate_wait_q_woken = true;
+			wake_up_interruptible(&priv->adapter->hs_activate_wait_q);
+		} else {
+			nxpwifi_dbg(priv->adapter, EVENT,
+				    "event: HS not configured\n");
+		}
+	} else {
+		nxpwifi_dbg(priv->adapter, EVENT,
+			    "event: hs_deactivated\n");
+		priv->adapter->hs_activated = false;
+	}
+}
+
+/* This function handles the command response of a Host Sleep configuration
+ * command.
+ *
+ * Handling includes changing the header fields into CPU format
+ * and setting the current host sleep activation status in driver.
+ *
+ * In case host sleep status change, the function generates an event to
+ * notify the applications.
+ */
+int nxpwifi_ret_802_11_hs_cfg(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_802_11_hs_cfg_enh *phs_cfg =
+		&resp->params.opt_hs_cfg;
+	u32 conditions = le32_to_cpu(phs_cfg->params.hs_config.conditions);
+
+	if (phs_cfg->action == cpu_to_le16(HS_ACTIVATE)) {
+		nxpwifi_hs_activated_event(priv, true);
+		goto done;
+	} else {
+		nxpwifi_dbg(adapter, CMD,
+			    "cmd: CMD_RESP: HS_CFG cmd reply\t"
+			    " result=%#x, conditions=0x%x gpio=0x%x gap=0x%x\n",
+			    resp->result, conditions,
+			    phs_cfg->params.hs_config.gpio,
+			    phs_cfg->params.hs_config.gap);
+	}
+	if (conditions != HS_CFG_CANCEL) {
+		set_bit(NXPWIFI_IS_HS_CONFIGURED, &adapter->work_flags);
+	} else {
+		clear_bit(NXPWIFI_IS_HS_CONFIGURED, &adapter->work_flags);
+		if (adapter->hs_activated)
+			nxpwifi_hs_activated_event(priv, false);
+	}
+
+done:
+	return 0;
+}
+
+/* This function wakes up the adapter and generates a Host Sleep
+ * cancel event on receiving the power up interrupt.
+ */
+void
+nxpwifi_process_hs_config(struct nxpwifi_adapter *adapter)
+{
+	nxpwifi_dbg(adapter, INFO,
+		    "info: %s: auto cancelling host sleep\t"
+		    "since there is interrupt from the firmware\n",
+		    __func__);
+
+	adapter->if_ops.wakeup(adapter);
+
+	if (adapter->hs_activated_manually) {
+		nxpwifi_cancel_hs(nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY),
+				  NXPWIFI_ASYNC_CMD);
+		adapter->hs_activated_manually = false;
+	}
+
+	adapter->hs_activated = false;
+	clear_bit(NXPWIFI_IS_HS_CONFIGURED, &adapter->work_flags);
+	clear_bit(NXPWIFI_IS_SUSPENDED, &adapter->work_flags);
+	nxpwifi_hs_activated_event(nxpwifi_get_priv(adapter,
+						    NXPWIFI_BSS_ROLE_ANY),
+				   false);
+}
+EXPORT_SYMBOL_GPL(nxpwifi_process_hs_config);
+
+/* This function handles the command response of a sleep confirm command.
+ *
+ * The function sets the card state to SLEEP if the response indicates success.
+ */
+void
+nxpwifi_process_sleep_confirm_resp(struct nxpwifi_adapter *adapter,
+				   u8 *pbuf, u32 upld_len)
+{
+	struct host_cmd_ds_command *cmd = (struct host_cmd_ds_command *)pbuf;
+	u16 result = le16_to_cpu(cmd->result);
+	u16 command = le16_to_cpu(cmd->command);
+	u16 seq_num = le16_to_cpu(cmd->seq_num);
+
+	if (!upld_len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: cmd size is 0\n", __func__);
+		return;
+	}
+
+	nxpwifi_dbg(adapter, CMD,
+		    "cmd: CMD_RESP: 0x%x, result %d, len %d, seqno 0x%x\n",
+		    command, result, le16_to_cpu(cmd->size), seq_num);
+
+	/* Update sequence number */
+	seq_num = HOST_GET_SEQ_NO(seq_num);
+	/* Clear RET_BIT from HOST */
+	command &= HOST_CMD_ID_MASK;
+
+	if (command != HOST_CMD_802_11_PS_MODE_ENH) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: rcvd unexpected resp for cmd %#x, result = %x\n",
+			    __func__, command, result);
+		return;
+	}
+
+	if (result) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: sleep confirm cmd failed\n",
+			    __func__);
+		adapter->pm_wakeup_card_req = false;
+		adapter->ps_state = PS_STATE_AWAKE;
+		return;
+	}
+	adapter->pm_wakeup_card_req = true;
+	if (test_bit(NXPWIFI_IS_HS_CONFIGURED, &adapter->work_flags))
+		nxpwifi_hs_activated_event(nxpwifi_get_priv
+						(adapter, NXPWIFI_BSS_ROLE_ANY),
+					   true);
+	adapter->ps_state = PS_STATE_SLEEP;
+	cmd->command = cpu_to_le16(command);
+	cmd->seq_num = cpu_to_le16(seq_num);
+}
+EXPORT_SYMBOL_GPL(nxpwifi_process_sleep_confirm_resp);
diff --git a/drivers/net/wireless/nxp/nxpwifi/cmdevt.h b/drivers/net/wireless/nxp/nxpwifi/cmdevt.h
new file mode 100644
index 000000000000..ccd4f23c39f2
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cmdevt.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: commands and events
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_CMD_EVT_H_
+#define _NXPWIFI_CMD_EVT_H_
+
+struct nxpwifi_cmd_entry {
+	u16 cmd_no;
+	int (*prepare_cmd)(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *cmd,
+			   u16 cmd_no, void *data_buf,
+			   u16 cmd_action, u32 cmd_type);
+	int (*cmd_resp)(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			u16 cmdresp_no,
+			void *data_buf);
+};
+
+struct nxpwifi_evt_entry {
+	u32 event_cause;
+	int (*event_handler)(struct nxpwifi_private *priv);
+};
+
+static inline int
+nxpwifi_cmd_fill_head_only(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *cmd,
+			   u16 cmd_no, void *data_buf,
+			   u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(cmd_no);
+	cmd->size = cpu_to_le16(S_DS_GEN);
+
+	return 0;
+}
+
+int nxpwifi_send_cmd(struct nxpwifi_private *priv, u16 cmd_no,
+		     u16 cmd_action, u32 cmd_oid, void *data_buf, bool sync);
+int nxpwifi_sta_prepare_cmd(struct nxpwifi_private *priv,
+			    struct cmd_ctrl_node *cmd_node,
+			    u16 cmd_action, u32 cmd_oid);
+int nxpwifi_dnld_dt_cfgdata(struct nxpwifi_private *priv,
+			    struct device_node *node, const char *prefix);
+int nxpwifi_sta_init_cmd(struct nxpwifi_private *priv, u8 first_sta, bool init);
+int nxpwifi_uap_prepare_cmd(struct nxpwifi_private *priv,
+			    struct cmd_ctrl_node *cmd_node,
+			    u16 cmd_action, u32 type);
+int nxpwifi_set_secure_params(struct nxpwifi_private *priv,
+			      struct nxpwifi_uap_bss_param *bss_config,
+			      struct cfg80211_ap_settings *params);
+void nxpwifi_set_ht_params(struct nxpwifi_private *priv,
+			   struct nxpwifi_uap_bss_param *bss_cfg,
+			   struct cfg80211_ap_settings *params);
+void nxpwifi_set_vht_params(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params);
+void nxpwifi_set_tpc_params(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params);
+void nxpwifi_set_uap_rates(struct nxpwifi_uap_bss_param *bss_cfg,
+			   struct cfg80211_ap_settings *params);
+void nxpwifi_set_vht_width(struct nxpwifi_private *priv,
+			   enum nl80211_chan_width width,
+			   bool ap_11ac_disable);
+bool nxpwifi_check_11ax_capability(struct nxpwifi_private *priv,
+				   struct nxpwifi_uap_bss_param *bss_cfg,
+				   struct cfg80211_ap_settings *params);
+int nxpwifi_set_11ax_status(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params);
+void nxpwifi_set_sys_config_invalid_data(struct nxpwifi_uap_bss_param *config);
+void nxpwifi_set_wmm_params(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params);
+void nxpwifi_config_uap_11d(struct nxpwifi_private *priv,
+			    struct cfg80211_beacon_data *beacon_data);
+void nxpwifi_uap_set_channel(struct nxpwifi_private *priv,
+			     struct nxpwifi_uap_bss_param *bss_cfg,
+			     struct cfg80211_chan_def chandef);
+int nxpwifi_config_start_uap(struct nxpwifi_private *priv,
+			     struct nxpwifi_uap_bss_param *bss_cfg);
+
+int nxpwifi_process_event(struct nxpwifi_adapter *adapter);
+int nxpwifi_process_sta_event(struct nxpwifi_private *priv);
+int nxpwifi_process_uap_event(struct nxpwifi_private *priv);
+void nxpwifi_reset_connect_state(struct nxpwifi_private *priv, u16 reason,
+				 bool from_ap);
+void nxpwifi_process_multi_chan_event(struct nxpwifi_private *priv,
+				      struct sk_buff *event_skb);
+void nxpwifi_process_tx_pause_event(struct nxpwifi_private *priv,
+				    struct sk_buff *event);
+void nxpwifi_bt_coex_wlan_param_update_event(struct nxpwifi_private *priv,
+					     struct sk_buff *event_skb);
+
+#endif /* !_NXPWIFI_CMD_EVT_H_ */
diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_cmd.c b/drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
new file mode 100644
index 000000000000..deed4537ec36
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
@@ -0,0 +1,3449 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station command handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+#include "11ac.h"
+#include "11ax.h"
+
+static bool disable_auto_ds;
+
+static int
+nxpwifi_cmd_sta_get_hw_spec(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *cmd,
+			    u16 cmd_no, void *data_buf,
+			    u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_get_hw_spec *hw_spec = &cmd->params.hw_spec;
+
+	cmd->command = cpu_to_le16(HOST_CMD_GET_HW_SPEC);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_get_hw_spec) +
+				S_DS_GEN);
+	memcpy(hw_spec->permanent_addr, priv->curr_addr, ETH_ALEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_get_hw_spec(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *resp,
+			    u16 cmdresp_no,
+			    void *data_buf)
+{
+	struct host_cmd_ds_get_hw_spec *hw_spec = &resp->params.hw_spec;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_header *tlv;
+	struct hw_spec_api_rev *api_rev;
+	struct hw_spec_max_conn *max_conn;
+	struct hw_spec_extension *hw_he_cap;
+	struct hw_spec_fw_cap_info *fw_cap;
+	struct hw_spec_secure_boot_uuid *sb_uuid;
+	u16 resp_size, api_id;
+	int i, left_len, parsed_len = 0;
+
+	adapter->fw_cap_info = le32_to_cpu(hw_spec->fw_cap_info);
+
+	if (IS_SUPPORT_MULTI_BANDS(adapter))
+		adapter->fw_bands = GET_FW_DEFAULT_BANDS(adapter);
+	else
+		adapter->fw_bands = BAND_B;
+
+	if ((adapter->fw_bands & BAND_A) && (adapter->fw_bands & BAND_GN))
+		adapter->fw_bands |= BAND_AN;
+	if (!(adapter->fw_bands & BAND_G) && (adapter->fw_bands & BAND_GN))
+		adapter->fw_bands &= ~BAND_GN;
+
+	adapter->fw_release_number = le32_to_cpu(hw_spec->fw_release_number);
+	adapter->fw_api_ver = (adapter->fw_release_number >> 16) & 0xff;
+	adapter->number_of_antenna =
+		le16_to_cpu(hw_spec->number_of_antenna) & 0xf;
+
+	if (le32_to_cpu(hw_spec->dot_11ac_dev_cap)) {
+		adapter->is_hw_11ac_capable = true;
+
+		/* Copy 11AC cap */
+		adapter->hw_dot_11ac_dev_cap =
+			le32_to_cpu(hw_spec->dot_11ac_dev_cap);
+		adapter->usr_dot_11ac_dev_cap_bg = adapter->hw_dot_11ac_dev_cap
+			& ~NXPWIFI_DEF_11AC_CAP_BF_RESET_MASK;
+		adapter->usr_dot_11ac_dev_cap_a = adapter->hw_dot_11ac_dev_cap
+			& ~NXPWIFI_DEF_11AC_CAP_BF_RESET_MASK;
+
+		/* Copy 11AC mcs */
+		adapter->hw_dot_11ac_mcs_support =
+			le32_to_cpu(hw_spec->dot_11ac_mcs_support);
+		adapter->usr_dot_11ac_mcs_support =
+			adapter->hw_dot_11ac_mcs_support;
+	} else {
+		adapter->is_hw_11ac_capable = false;
+	}
+
+	resp_size = le16_to_cpu(resp->size) - S_DS_GEN;
+	if (resp_size > sizeof(struct host_cmd_ds_get_hw_spec)) {
+		/* we have variable HW SPEC information */
+		left_len = resp_size - sizeof(struct host_cmd_ds_get_hw_spec);
+		while (left_len > sizeof(struct nxpwifi_ie_types_header)) {
+			tlv = (void *)&hw_spec->tlv + parsed_len;
+			switch (le16_to_cpu(tlv->type)) {
+			case TLV_TYPE_API_REV:
+				api_rev = (struct hw_spec_api_rev *)tlv;
+				api_id = le16_to_cpu(api_rev->api_id);
+				switch (api_id) {
+				case KEY_API_VER_ID:
+					adapter->key_api_major_ver =
+						api_rev->major_ver;
+					adapter->key_api_minor_ver =
+						api_rev->minor_ver;
+					nxpwifi_dbg(adapter, INFO,
+						    "key_api v%d.%d\n",
+						    adapter->key_api_major_ver,
+						    adapter->key_api_minor_ver);
+					break;
+				case FW_API_VER_ID:
+					adapter->fw_api_ver =
+						api_rev->major_ver;
+					nxpwifi_dbg(adapter, MSG,
+						    "Firmware api version %d.%d\n",
+						    adapter->fw_api_ver,
+						    api_rev->minor_ver);
+					break;
+				case UAP_FW_API_VER_ID:
+					nxpwifi_dbg(adapter, INFO,
+						    "uAP api version %d.%d\n",
+						    api_rev->major_ver,
+						    api_rev->minor_ver);
+					break;
+				case CHANRPT_API_VER_ID:
+					nxpwifi_dbg(adapter, INFO,
+						    "channel report api version %d.%d\n",
+						    api_rev->major_ver,
+						    api_rev->minor_ver);
+					break;
+				case FW_HOTFIX_VER_ID:
+					adapter->fw_hotfix_ver =
+						api_rev->major_ver;
+					nxpwifi_dbg(adapter, INFO,
+						    "Firmware hotfix version %d\n",
+						    api_rev->major_ver);
+					break;
+				default:
+					nxpwifi_dbg(adapter, FATAL,
+						    "Unknown api_id: %d\n",
+						    api_id);
+					break;
+				}
+				break;
+			case TLV_TYPE_MAX_CONN:
+				max_conn = (struct hw_spec_max_conn *)tlv;
+				adapter->max_sta_conn = max_conn->max_sta_conn;
+				nxpwifi_dbg(adapter, INFO,
+					    "max sta connections: %u\n",
+					    adapter->max_sta_conn);
+				break;
+			case TLV_TYPE_EXTENSION_ID:
+				hw_he_cap = (struct hw_spec_extension *)tlv;
+				if (hw_he_cap->ext_id ==
+				    WLAN_EID_EXT_HE_CAPABILITY)
+					nxpwifi_update_11ax_cap(adapter, hw_he_cap);
+				break;
+			case TLV_TYPE_FW_CAP_INFO:
+				fw_cap = (struct hw_spec_fw_cap_info *)tlv;
+				adapter->fw_cap_info =
+					le32_to_cpu(fw_cap->fw_cap_info);
+				adapter->fw_cap_ext =
+					le32_to_cpu(fw_cap->fw_cap_ext);
+				nxpwifi_dbg(adapter, INFO,
+					    "fw_cap_info:%#x fw_cap_ext:%#x\n",
+					    adapter->fw_cap_info,
+					    adapter->fw_cap_ext);
+				break;
+			case TLV_TYPE_SECURE_BOOT_UUID:
+				sb_uuid = (struct hw_spec_secure_boot_uuid *)tlv;
+				adapter->uuid_lo =
+					le64_to_cpu(sb_uuid->uuid_lo);
+				adapter->uuid_hi =
+					le64_to_cpu(sb_uuid->uuid_hi);
+				nxpwifi_dbg(adapter, INFO,
+					    "uuid: %#llx%#llx\n",
+					    adapter->uuid_lo, adapter->uuid_hi);
+				break;
+			default:
+				nxpwifi_dbg(adapter, FATAL,
+					    "Unknown GET_HW_SPEC TLV type: %#x\n",
+					    le16_to_cpu(tlv->type));
+				break;
+			}
+			parsed_len += le16_to_cpu(tlv->len) +
+				      sizeof(struct nxpwifi_ie_types_header);
+			left_len -= le16_to_cpu(tlv->len) +
+				      sizeof(struct nxpwifi_ie_types_header);
+		}
+	}
+
+	if (adapter->key_api_major_ver < KEY_API_VER_MAJOR_V2)
+		return -EOPNOTSUPP;
+
+	nxpwifi_dbg(adapter, INFO,
+		    "info: GET_HW_SPEC: fw_release_number- %#x\n",
+		    adapter->fw_release_number);
+	nxpwifi_dbg(adapter, INFO,
+		    "info: GET_HW_SPEC: permanent addr: %pM\n",
+		    hw_spec->permanent_addr);
+	nxpwifi_dbg(adapter, INFO,
+		    "info: GET_HW_SPEC: hw_if_version=%#x version=%#x\n",
+		    le16_to_cpu(hw_spec->hw_if_version),
+		    le16_to_cpu(hw_spec->version));
+
+	ether_addr_copy(priv->adapter->perm_addr, hw_spec->permanent_addr);
+	adapter->region_code = le16_to_cpu(hw_spec->region_code);
+
+	for (i = 0; i < NXPWIFI_MAX_REGION_CODE; i++)
+		/* Use the region code to search for the index */
+		if (adapter->region_code == region_code_index[i])
+			break;
+
+	/* If it's unidentified region code, use the default (world) */
+	if (i >= NXPWIFI_MAX_REGION_CODE) {
+		adapter->region_code = 0x00;
+		nxpwifi_dbg(adapter, WARN,
+			    "cmd: unknown region code, use default (USA)\n");
+	}
+
+	adapter->hw_dot_11n_dev_cap = le32_to_cpu(hw_spec->dot_11n_dev_cap);
+	adapter->hw_dev_mcs_support = hw_spec->dev_mcs_support;
+	adapter->hw_mpdu_density = GET_MPDU_DENSITY(hw_spec->hw_dev_cap);
+	adapter->user_dev_mcs_support = adapter->hw_dev_mcs_support;
+	adapter->user_htstream = adapter->hw_dev_mcs_support;
+	if (adapter->fw_bands & BAND_A)
+		adapter->user_htstream |= (adapter->user_htstream << 8);
+
+	if (adapter->if_ops.update_mp_end_port) {
+		u16 mp_end_port;
+
+		mp_end_port = le16_to_cpu(hw_spec->mp_end_port);
+		adapter->if_ops.update_mp_end_port(adapter, mp_end_port);
+	}
+
+	if (adapter->fw_api_ver == NXPWIFI_FW_V15)
+		adapter->scan_chan_gap_enabled = true;
+
+	for (i = 0; i < adapter->priv_num; i++)
+		adapter->priv[i]->config_bands = adapter->fw_bands;
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_scan(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *cmd,
+			    u16 cmd_no, void *data_buf,
+			    u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_802_11_scan(cmd, data_buf);
+}
+
+static int
+nxpwifi_ret_sta_802_11_scan(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *resp,
+			    u16 cmdresp_no,
+			    void *data_buf)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+
+	ret = nxpwifi_ret_802_11_scan(priv, resp);
+	adapter->curr_cmd->wait_q_enabled = false;
+
+	return ret;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_get_log(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *cmd,
+			       u16 cmd_no, void *data_buf,
+			       u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_GET_LOG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_802_11_get_log) +
+				S_DS_GEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_802_11_get_log(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *resp,
+			       u16 cmdresp_no,
+			       void *data_buf)
+{
+	struct host_cmd_ds_802_11_get_log *get_log =
+		&resp->params.get_log;
+	struct nxpwifi_ds_get_stats *stats =
+		(struct nxpwifi_ds_get_stats *)data_buf;
+
+	if (stats) {
+		stats->mcast_tx_frame = le32_to_cpu(get_log->mcast_tx_frame);
+		stats->failed = le32_to_cpu(get_log->failed);
+		stats->retry = le32_to_cpu(get_log->retry);
+		stats->multi_retry = le32_to_cpu(get_log->multi_retry);
+		stats->frame_dup = le32_to_cpu(get_log->frame_dup);
+		stats->rts_success = le32_to_cpu(get_log->rts_success);
+		stats->rts_failure = le32_to_cpu(get_log->rts_failure);
+		stats->ack_failure = le32_to_cpu(get_log->ack_failure);
+		stats->rx_frag = le32_to_cpu(get_log->rx_frag);
+		stats->mcast_rx_frame = le32_to_cpu(get_log->mcast_rx_frame);
+		stats->fcs_error = le32_to_cpu(get_log->fcs_error);
+		stats->tx_frame = le32_to_cpu(get_log->tx_frame);
+		stats->wep_icv_error[0] =
+			le32_to_cpu(get_log->wep_icv_err_cnt[0]);
+		stats->wep_icv_error[1] =
+			le32_to_cpu(get_log->wep_icv_err_cnt[1]);
+		stats->wep_icv_error[2] =
+			le32_to_cpu(get_log->wep_icv_err_cnt[2]);
+		stats->wep_icv_error[3] =
+			le32_to_cpu(get_log->wep_icv_err_cnt[3]);
+		stats->bcn_rcv_cnt = le32_to_cpu(get_log->bcn_rcv_cnt);
+		stats->bcn_miss_cnt = le32_to_cpu(get_log->bcn_miss_cnt);
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_mac_multicast_adr(struct nxpwifi_private *priv,
+				  struct host_cmd_ds_command *cmd,
+				  u16 cmd_no, void *data_buf,
+				  u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_mac_multicast_adr *mcast_addr = &cmd->params.mc_addr;
+	struct nxpwifi_multicast_list *mcast_list =
+		(struct nxpwifi_multicast_list *)data_buf;
+
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_mac_multicast_adr) +
+				S_DS_GEN);
+	cmd->command = cpu_to_le16(HOST_CMD_MAC_MULTICAST_ADR);
+
+	mcast_addr->action = cpu_to_le16(cmd_action);
+	mcast_addr->num_of_adrs =
+		cpu_to_le16((u16)mcast_list->num_multicast_addr);
+	memcpy(mcast_addr->mac_list, mcast_list->mac_list,
+	       mcast_list->num_multicast_addr * ETH_ALEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_associate(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *cmd,
+				 u16 cmd_no, void *data_buf,
+				 u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_802_11_associate(priv, cmd, data_buf);
+}
+
+static int
+nxpwifi_ret_sta_802_11_associate(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *resp,
+				 u16 cmdresp_no,
+				 void *data_buf)
+{
+	return nxpwifi_ret_802_11_associate(priv, resp);
+}
+
+static int
+nxpwifi_cmd_sta_802_11_snmp_mib(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *cmd,
+				u16 cmd_no, void *data_buf,
+				u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_802_11_snmp_mib *snmp_mib = &cmd->params.smib;
+	u16 *ul_temp = (u16 *)data_buf;
+
+	nxpwifi_dbg(priv->adapter, CMD,
+		    "cmd: SNMP_CMD: cmd_oid = 0x%x\n", cmd_type);
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_SNMP_MIB);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_802_11_snmp_mib)
+				+ S_DS_GEN);
+
+	snmp_mib->oid = cpu_to_le16((u16)cmd_type);
+	if (cmd_action == HOST_ACT_GEN_GET) {
+		snmp_mib->query_type = cpu_to_le16(HOST_ACT_GEN_GET);
+		snmp_mib->buf_size = cpu_to_le16(MAX_SNMP_BUF_SIZE);
+		le16_unaligned_add_cpu(&cmd->size, MAX_SNMP_BUF_SIZE);
+	} else if (cmd_action == HOST_ACT_GEN_SET) {
+		snmp_mib->query_type = cpu_to_le16(HOST_ACT_GEN_SET);
+		snmp_mib->buf_size = cpu_to_le16(sizeof(u16));
+		put_unaligned_le16(*ul_temp, snmp_mib->value);
+		le16_unaligned_add_cpu(&cmd->size, sizeof(u16));
+	}
+
+	nxpwifi_dbg(priv->adapter, CMD,
+		    "cmd: SNMP_CMD: Action=0x%x, OID=0x%x,\t"
+		    "OIDSize=0x%x, Value=0x%x\n",
+		    cmd_action, cmd_type, le16_to_cpu(snmp_mib->buf_size),
+		    get_unaligned_le16(snmp_mib->value));
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_802_11_snmp_mib(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *resp,
+				u16 cmdresp_no,
+				void *data_buf)
+{
+	struct host_cmd_ds_802_11_snmp_mib *smib = &resp->params.smib;
+	u16 oid = le16_to_cpu(smib->oid);
+	u16 query_type = le16_to_cpu(smib->query_type);
+	u32 ul_temp;
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: SNMP_RESP: oid value = %#x,\t"
+		    "query_type = %#x, buf size = %#x\n",
+		    oid, query_type, le16_to_cpu(smib->buf_size));
+	if (query_type == HOST_ACT_GEN_GET) {
+		ul_temp = get_unaligned_le16(smib->value);
+		if (data_buf)
+			*(u32 *)data_buf = ul_temp;
+		switch (oid) {
+		case FRAG_THRESH_I:
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: SNMP_RESP: FragThsd =%u\n",
+				    ul_temp);
+			break;
+		case RTS_THRESH_I:
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: SNMP_RESP: RTSThsd =%u\n",
+				    ul_temp);
+			break;
+		case SHORT_RETRY_LIM_I:
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: SNMP_RESP: TxRetryCount=%u\n",
+				    ul_temp);
+			break;
+		case DTIM_PERIOD_I:
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: SNMP_RESP: DTIM period=%u\n",
+				    ul_temp);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int nxpwifi_cmd_sta_reg_access(struct nxpwifi_private *priv,
+				      struct host_cmd_ds_command *cmd,
+				      u16 cmd_no, void *data_buf,
+				      u16 cmd_action, u32 cmd_type)
+{
+	struct nxpwifi_ds_reg_rw *reg_rw = data_buf;
+
+	cmd->command = cpu_to_le16(cmd_no);
+
+	switch (cmd_no) {
+	case HOST_CMD_MAC_REG_ACCESS:
+	{
+		struct host_cmd_ds_mac_reg_access *mac_reg;
+
+		cmd->size = cpu_to_le16(sizeof(*mac_reg) + S_DS_GEN);
+		mac_reg = &cmd->params.mac_reg;
+		mac_reg->action = cpu_to_le16(cmd_action);
+		mac_reg->offset = cpu_to_le16((u16)reg_rw->offset);
+		mac_reg->value = cpu_to_le32(reg_rw->value);
+		break;
+	}
+	case HOST_CMD_BBP_REG_ACCESS:
+	{
+		struct host_cmd_ds_bbp_reg_access *bbp_reg;
+
+		cmd->size = cpu_to_le16(sizeof(*bbp_reg) + S_DS_GEN);
+		bbp_reg = &cmd->params.bbp_reg;
+		bbp_reg->action = cpu_to_le16(cmd_action);
+		bbp_reg->offset = cpu_to_le16((u16)reg_rw->offset);
+		bbp_reg->value = (u8)reg_rw->value;
+		break;
+	}
+	case HOST_CMD_RF_REG_ACCESS:
+	{
+		struct host_cmd_ds_rf_reg_access *rf_reg;
+
+		cmd->size = cpu_to_le16(sizeof(*rf_reg) + S_DS_GEN);
+		rf_reg = &cmd->params.rf_reg;
+		rf_reg->action = cpu_to_le16(cmd_action);
+		rf_reg->offset = cpu_to_le16((u16)reg_rw->offset);
+		rf_reg->value = (u8)reg_rw->value;
+		break;
+	}
+	case HOST_CMD_PMIC_REG_ACCESS:
+	{
+		struct host_cmd_ds_pmic_reg_access *pmic_reg;
+
+		cmd->size = cpu_to_le16(sizeof(*pmic_reg) + S_DS_GEN);
+		pmic_reg = &cmd->params.pmic_reg;
+		pmic_reg->action = cpu_to_le16(cmd_action);
+		pmic_reg->offset = cpu_to_le16((u16)reg_rw->offset);
+		pmic_reg->value = (u8)reg_rw->value;
+		break;
+	}
+	case HOST_CMD_CAU_REG_ACCESS:
+	{
+		struct host_cmd_ds_rf_reg_access *cau_reg;
+
+		cmd->size = cpu_to_le16(sizeof(*cau_reg) + S_DS_GEN);
+		cau_reg = &cmd->params.rf_reg;
+		cau_reg->action = cpu_to_le16(cmd_action);
+		cau_reg->offset = cpu_to_le16((u16)reg_rw->offset);
+		cau_reg->value = (u8)reg_rw->value;
+		break;
+	}
+	case HOST_CMD_802_11_EEPROM_ACCESS:
+	{
+		struct nxpwifi_ds_read_eeprom *rd_eeprom = data_buf;
+		struct host_cmd_ds_802_11_eeprom_access *cmd_eeprom =
+			&cmd->params.eeprom;
+
+		cmd->size = cpu_to_le16(sizeof(*cmd_eeprom) + S_DS_GEN);
+		cmd_eeprom->action = cpu_to_le16(cmd_action);
+		cmd_eeprom->offset = cpu_to_le16(rd_eeprom->offset);
+		cmd_eeprom->byte_count = cpu_to_le16(rd_eeprom->byte_count);
+		cmd_eeprom->value = 0;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_reg_access(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *resp,
+			   u16 cmdresp_no,
+			   void *data_buf)
+{
+	struct nxpwifi_ds_reg_rw *reg_rw;
+	struct nxpwifi_ds_read_eeprom *eeprom;
+	union reg {
+		struct host_cmd_ds_mac_reg_access *mac;
+		struct host_cmd_ds_bbp_reg_access *bbp;
+		struct host_cmd_ds_rf_reg_access *rf;
+		struct host_cmd_ds_pmic_reg_access *pmic;
+		struct host_cmd_ds_802_11_eeprom_access *eeprom;
+	} r;
+
+	if (!data_buf)
+		return 0;
+
+	reg_rw = data_buf;
+	eeprom = data_buf;
+	switch (cmdresp_no) {
+	case HOST_CMD_MAC_REG_ACCESS:
+		r.mac = &resp->params.mac_reg;
+		reg_rw->offset = (u32)le16_to_cpu(r.mac->offset);
+		reg_rw->value = le32_to_cpu(r.mac->value);
+		break;
+	case HOST_CMD_BBP_REG_ACCESS:
+		r.bbp = &resp->params.bbp_reg;
+		reg_rw->offset = (u32)le16_to_cpu(r.bbp->offset);
+		reg_rw->value = (u32)r.bbp->value;
+		break;
+
+	case HOST_CMD_RF_REG_ACCESS:
+		r.rf = &resp->params.rf_reg;
+		reg_rw->offset = (u32)le16_to_cpu(r.rf->offset);
+		reg_rw->value = (u32)r.bbp->value;
+		break;
+	case HOST_CMD_PMIC_REG_ACCESS:
+		r.pmic = &resp->params.pmic_reg;
+		reg_rw->offset = (u32)le16_to_cpu(r.pmic->offset);
+		reg_rw->value = (u32)r.pmic->value;
+		break;
+	case HOST_CMD_CAU_REG_ACCESS:
+		r.rf = &resp->params.rf_reg;
+		reg_rw->offset = (u32)le16_to_cpu(r.rf->offset);
+		reg_rw->value = (u32)r.rf->value;
+		break;
+	case HOST_CMD_802_11_EEPROM_ACCESS:
+		r.eeprom = &resp->params.eeprom;
+		pr_debug("info: EEPROM read len=%x\n",
+			 le16_to_cpu(r.eeprom->byte_count));
+		if (eeprom->byte_count < le16_to_cpu(r.eeprom->byte_count)) {
+			eeprom->byte_count = 0;
+			pr_debug("info: EEPROM read length is too big\n");
+			return -ENOMEM;
+		}
+		eeprom->offset = le16_to_cpu(r.eeprom->offset);
+		eeprom->byte_count = le16_to_cpu(r.eeprom->byte_count);
+		if (eeprom->byte_count > 0)
+			memcpy(&eeprom->value, &r.eeprom->value,
+			       min((u16)MAX_EEPROM_DATA, eeprom->byte_count));
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_rf_tx_pwr(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *cmd,
+			  u16 cmd_no, void *data_buf,
+			  u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_rf_tx_pwr *txp = &cmd->params.txp;
+
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_rf_tx_pwr)
+				+ S_DS_GEN);
+	cmd->command = cpu_to_le16(HOST_CMD_RF_TX_PWR);
+	txp->action = cpu_to_le16(cmd_action);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_rf_tx_pwr(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp,
+			  u16 cmdresp_no,
+			  void *data_buf)
+{
+	struct host_cmd_ds_rf_tx_pwr *txp = &resp->params.txp;
+	u16 action = le16_to_cpu(txp->action);
+
+	priv->tx_power_level = le16_to_cpu(txp->cur_level);
+
+	if (action == HOST_ACT_GEN_GET) {
+		priv->max_tx_power_level = txp->max_power;
+		priv->min_tx_power_level = txp->min_power;
+	}
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "Current TxPower Level=%d, Max Power=%d, Min Power=%d\n",
+		    priv->tx_power_level, priv->max_tx_power_level,
+		    priv->min_tx_power_level);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_rf_antenna(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *cmd,
+			   u16 cmd_no, void *data_buf,
+			   u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_rf_ant_mimo *ant_mimo = &cmd->params.ant_mimo;
+	struct host_cmd_ds_rf_ant_siso *ant_siso = &cmd->params.ant_siso;
+	struct nxpwifi_ds_ant_cfg *ant_cfg =
+		(struct nxpwifi_ds_ant_cfg *)data_buf;
+
+	cmd->command = cpu_to_le16(HOST_CMD_RF_ANTENNA);
+
+	switch (cmd_action) {
+	case HOST_ACT_GEN_SET:
+		if (priv->adapter->hw_dev_mcs_support == HT_STREAM_2X2) {
+			cmd->size = cpu_to_le16(sizeof(struct
+						host_cmd_ds_rf_ant_mimo)
+						+ S_DS_GEN);
+			ant_mimo->action_tx = cpu_to_le16(HOST_ACT_SET_TX);
+			ant_mimo->tx_ant_mode =
+				cpu_to_le16((u16)ant_cfg->tx_ant);
+			ant_mimo->action_rx = cpu_to_le16(HOST_ACT_SET_RX);
+			ant_mimo->rx_ant_mode =
+				cpu_to_le16((u16)ant_cfg->rx_ant);
+		} else {
+			cmd->size = cpu_to_le16(sizeof(struct
+						host_cmd_ds_rf_ant_siso) +
+						S_DS_GEN);
+			ant_siso->action = cpu_to_le16(HOST_ACT_SET_BOTH);
+			ant_siso->ant_mode = cpu_to_le16((u16)ant_cfg->tx_ant);
+		}
+		break;
+	case HOST_ACT_GEN_GET:
+		if (priv->adapter->hw_dev_mcs_support == HT_STREAM_2X2) {
+			cmd->size = cpu_to_le16(sizeof(struct
+						host_cmd_ds_rf_ant_mimo) +
+						S_DS_GEN);
+			ant_mimo->action_tx = cpu_to_le16(HOST_ACT_GET_TX);
+			ant_mimo->action_rx = cpu_to_le16(HOST_ACT_GET_RX);
+		} else {
+			cmd->size = cpu_to_le16(sizeof(struct
+						host_cmd_ds_rf_ant_siso) +
+						S_DS_GEN);
+			ant_siso->action = cpu_to_le16(HOST_ACT_GET_BOTH);
+		}
+		break;
+	}
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_rf_antenna(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *resp,
+			   u16 cmdresp_no,
+			   void *data_buf)
+{
+	struct host_cmd_ds_rf_ant_mimo *ant_mimo = &resp->params.ant_mimo;
+	struct host_cmd_ds_rf_ant_siso *ant_siso = &resp->params.ant_siso;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (adapter->hw_dev_mcs_support == HT_STREAM_2X2) {
+		priv->tx_ant = le16_to_cpu(ant_mimo->tx_ant_mode);
+		priv->rx_ant = le16_to_cpu(ant_mimo->rx_ant_mode);
+		nxpwifi_dbg(adapter, INFO,
+			    "RF_ANT_RESP: Tx action = 0x%x, Tx Mode = 0x%04x\t"
+			    "Rx action = 0x%x, Rx Mode = 0x%04x\n",
+			    le16_to_cpu(ant_mimo->action_tx),
+			    le16_to_cpu(ant_mimo->tx_ant_mode),
+			    le16_to_cpu(ant_mimo->action_rx),
+			    le16_to_cpu(ant_mimo->rx_ant_mode));
+	} else {
+		priv->tx_ant = le16_to_cpu(ant_siso->ant_mode);
+		priv->rx_ant = le16_to_cpu(ant_siso->ant_mode);
+		nxpwifi_dbg(adapter, INFO,
+			    "RF_ANT_RESP: action = 0x%x, Mode = 0x%04x\n",
+			    le16_to_cpu(ant_siso->action),
+			    le16_to_cpu(ant_siso->ant_mode));
+	}
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_deauthenticate(struct nxpwifi_private *priv,
+				      struct host_cmd_ds_command *cmd,
+				      u16 cmd_no, void *data_buf,
+				      u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_802_11_deauthenticate *deauth = &cmd->params.deauth;
+	u8 *mac = (u8 *)data_buf;
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_DEAUTHENTICATE);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_802_11_deauthenticate)
+				+ S_DS_GEN);
+
+	/* Set AP MAC address */
+	memcpy(deauth->mac_addr, mac, ETH_ALEN);
+
+	nxpwifi_dbg(priv->adapter, CMD, "cmd: Deauth: %pM\n", deauth->mac_addr);
+
+	deauth->reason_code = cpu_to_le16(WLAN_REASON_DEAUTH_LEAVING);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_802_11_deauthenticate(struct nxpwifi_private *priv,
+				      struct host_cmd_ds_command *resp,
+				      u16 cmdresp_no,
+				      void *data_buf)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	adapter->dbg.num_cmd_deauth++;
+	if (!memcmp(resp->params.deauth.mac_addr,
+		    &priv->curr_bss_params.bss_descriptor.mac_address,
+		    sizeof(resp->params.deauth.mac_addr)))
+		nxpwifi_reset_connect_state(priv, WLAN_REASON_DEAUTH_LEAVING,
+					    false);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_mac_control(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *cmd,
+			    u16 cmd_no, void *data_buf,
+			    u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_mac_control *mac_ctrl = &cmd->params.mac_ctrl;
+	u32 *action = (u32 *)data_buf;
+
+	if (cmd_action != HOST_ACT_GEN_SET) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "mac_control: only support set cmd\n");
+		return -EINVAL;
+	}
+
+	cmd->command = cpu_to_le16(HOST_CMD_MAC_CONTROL);
+	cmd->size =
+		cpu_to_le16(sizeof(struct host_cmd_ds_mac_control) + S_DS_GEN);
+	mac_ctrl->action = cpu_to_le32(*action);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_mac_address(struct nxpwifi_private *priv,
+				   struct host_cmd_ds_command *cmd,
+				   u16 cmd_no, void *data_buf,
+				   u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_MAC_ADDRESS);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_802_11_mac_address) +
+				S_DS_GEN);
+	cmd->result = 0;
+
+	cmd->params.mac_addr.action = cpu_to_le16(cmd_action);
+
+	if (cmd_action == HOST_ACT_GEN_SET)
+		memcpy(cmd->params.mac_addr.mac_addr, priv->curr_addr,
+		       ETH_ALEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_802_11_mac_address(struct nxpwifi_private *priv,
+				   struct host_cmd_ds_command *resp,
+				   u16 cmdresp_no,
+				   void *data_buf)
+{
+	struct host_cmd_ds_802_11_mac_address *cmd_mac_addr;
+
+	cmd_mac_addr = &resp->params.mac_addr;
+
+	memcpy(priv->curr_addr, cmd_mac_addr->mac_addr, ETH_ALEN);
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: set mac address: %pM\n", priv->curr_addr);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11d_domain_info(struct nxpwifi_private *priv,
+				    struct host_cmd_ds_command *cmd,
+				    u16 cmd_no, void *data_buf,
+				    u16 cmd_action, u32 cmd_type)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_802_11d_domain_info *domain_info =
+		&cmd->params.domain_info;
+	struct nxpwifi_ietypes_domain_param_set *domain =
+		&domain_info->domain;
+	struct nxpwifi_ietypes_domain_code *domain_code;
+	u8 no_of_triplet = adapter->domain_reg.no_of_triplet;
+	int triplet_size;
+
+	nxpwifi_dbg(adapter, INFO,
+		    "info: 11D: no_of_triplet=0x%x\n", no_of_triplet);
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11D_DOMAIN_INFO);
+	cmd->size = cpu_to_le16(S_DS_GEN);
+	domain_info->action = cpu_to_le16(cmd_action);
+	le16_unaligned_add_cpu(&cmd->size, sizeof(domain_info->action));
+
+	if (cmd_action == HOST_ACT_GEN_GET)
+		return 0;
+
+	triplet_size = no_of_triplet *
+		sizeof(struct ieee80211_country_ie_triplet);
+
+	domain->header.type = cpu_to_le16(WLAN_EID_COUNTRY);
+	domain->header.len =
+		cpu_to_le16(sizeof(domain->country_code) + triplet_size);
+	memcpy(domain->country_code, adapter->domain_reg.country_code,
+	       sizeof(domain->country_code));
+	if (no_of_triplet)
+		memcpy(domain->triplet, adapter->domain_reg.triplet,
+		       triplet_size);
+	le16_unaligned_add_cpu(&cmd->size, sizeof(*domain) + triplet_size);
+
+	domain_code = (struct nxpwifi_ietypes_domain_code *)((u8 *)cmd +
+		le16_to_cpu(cmd->size));
+	domain_code->header.type = cpu_to_le16(TLV_TYPE_REGION_DOMAIN_CODE);
+	domain_code->header.len =
+		cpu_to_le16(sizeof(*domain_code) -
+		sizeof(struct nxpwifi_ie_types_header));
+	le16_unaligned_add_cpu(&cmd->size, sizeof(*domain_code));
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_802_11d_domain_info(struct nxpwifi_private *priv,
+				    struct host_cmd_ds_command *resp,
+				    u16 cmdresp_no,
+				    void *data_buf)
+{
+	struct host_cmd_ds_802_11d_domain_info_rsp *domain_info =
+		&resp->params.domain_info_resp;
+	struct nxpwifi_ietypes_domain_param_set *domain = &domain_info->domain;
+	u16 action = le16_to_cpu(domain_info->action);
+	u8 no_of_triplet;
+
+	no_of_triplet = (u8)((le16_to_cpu(domain->header.len)
+			     - IEEE80211_COUNTRY_STRING_LEN)
+			     / sizeof(struct ieee80211_country_ie_triplet));
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: 11D Domain Info Resp: no_of_triplet=%d\n",
+		    no_of_triplet);
+
+	if (no_of_triplet > NXPWIFI_MAX_TRIPLET_802_11D) {
+		nxpwifi_dbg(priv->adapter, FATAL,
+			    "11D: invalid number of triplets %d returned\n",
+			    no_of_triplet);
+		return -EINVAL;
+	}
+
+	switch (action) {
+	case HOST_ACT_GEN_SET:  /* Proc Set Action */
+		break;
+	case HOST_ACT_GEN_GET:
+		break;
+	default:
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "11D: invalid action:%d\n", domain_info->action);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nxpwifi_set_aes_key(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *cmd,
+			       struct nxpwifi_ds_encrypt_key *enc_key,
+			       struct host_cmd_ds_802_11_key_material *km)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 size, len = KEY_PARAMS_FIXED_LEN;
+	u8 key_type, key_type_igtk;
+
+	if (enc_key->key_len == WLAN_KEY_LEN_CCMP) {
+		key_type = KEY_TYPE_ID_AES;
+		key_type_igtk = KEY_TYPE_ID_AES_CMAC;
+	} else {
+		key_type = KEY_TYPE_ID_GCMP_256;
+		key_type_igtk = KEY_TYPE_ID_BIP_GMAC_256;
+	}
+
+	if (enc_key->is_igtk_key) {
+		km->key_param_set.key_info &= cpu_to_le16(~KEY_MCAST);
+		km->key_param_set.key_info |= cpu_to_le16(KEY_IGTK);
+		km->key_param_set.key_type = key_type_igtk;
+		if (enc_key->key_len == WLAN_KEY_LEN_CCMP) {
+			nxpwifi_dbg(adapter, INFO,
+				    "%s: Set CMAC AES Key\n", __func__);
+			if (enc_key->is_rx_seq_valid)
+				memcpy(km->key_param_set.key_params.cmac_aes.ipn,
+				       enc_key->pn, enc_key->pn_len);
+			km->key_param_set.key_params.cmac_aes.key_len =
+				cpu_to_le16(enc_key->key_len);
+			memcpy(km->key_param_set.key_params.cmac_aes.key,
+			       enc_key->key_material, enc_key->key_len);
+			len += sizeof(struct nxpwifi_cmac_aes_param);
+		} else {
+			nxpwifi_dbg(adapter, INFO,
+				    "%s: Set GMAC AES Key\n", __func__);
+			if (enc_key->is_rx_seq_valid)
+				memcpy(km->key_param_set.key_params.gmac_aes.ipn,
+				       enc_key->pn, enc_key->pn_len);
+			km->key_param_set.key_params.gmac_aes.key_len =
+				cpu_to_le16(enc_key->key_len);
+			memcpy(km->key_param_set.key_params.gmac_aes.key,
+			       enc_key->key_material, enc_key->key_len);
+			len += sizeof(struct nxpwifi_gmac_aes_param);
+		}
+	} else if (enc_key->is_igtk_def_key) {
+		nxpwifi_dbg(adapter, INFO,
+			    "%s: Set CMAC default Key index\n", __func__);
+		km->key_param_set.key_type = key_type_igtk;
+		km->key_param_set.key_idx = enc_key->key_index & KEY_INDEX_MASK;
+	} else {
+		nxpwifi_dbg(adapter, INFO,
+			    "%s: Set AES Key\n", __func__);
+		if (enc_key->is_rx_seq_valid)
+			memcpy(km->key_param_set.key_params.aes.pn,
+			       enc_key->pn, enc_key->pn_len);
+		km->key_param_set.key_type = key_type;
+		km->key_param_set.key_params.aes.key_len =
+					  cpu_to_le16(enc_key->key_len);
+		memcpy(km->key_param_set.key_params.aes.key,
+		       enc_key->key_material, enc_key->key_len);
+		len += sizeof(struct nxpwifi_aes_param);
+	}
+
+	km->key_param_set.len = cpu_to_le16(len);
+	size = len + sizeof(struct nxpwifi_ie_types_header) +
+	       sizeof(km->action) + S_DS_GEN;
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_key_material(struct nxpwifi_private *priv,
+				    struct host_cmd_ds_command *cmd,
+				    u16 cmd_no, void *data_buf,
+				    u16 cmd_action, u32 cmd_type)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ds_encrypt_key *enc_key =
+		(struct nxpwifi_ds_encrypt_key *)data_buf;
+	u8 *mac = enc_key->mac_addr;
+	u16 key_info, len = KEY_PARAMS_FIXED_LEN;
+	struct host_cmd_ds_802_11_key_material *km =
+		&cmd->params.key_material;
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_KEY_MATERIAL);
+	km->action = cpu_to_le16(cmd_action);
+
+	if (cmd_action == HOST_ACT_GEN_GET) {
+		nxpwifi_dbg(adapter, INFO, "%s: Get key\n", __func__);
+		km->key_param_set.key_idx =
+			enc_key->key_index & KEY_INDEX_MASK;
+		km->key_param_set.type = cpu_to_le16(TLV_TYPE_KEY_PARAM_V2);
+		km->key_param_set.len = cpu_to_le16(KEY_PARAMS_FIXED_LEN);
+		ether_addr_copy(km->key_param_set.mac_addr, mac);
+
+		if (enc_key->key_index & NXPWIFI_KEY_INDEX_UNICAST)
+			key_info = KEY_UNICAST;
+		else
+			key_info = KEY_MCAST;
+
+		if (enc_key->is_igtk_key)
+			key_info |= KEY_IGTK;
+
+		km->key_param_set.key_info = cpu_to_le16(key_info);
+
+		cmd->size = cpu_to_le16(sizeof(struct nxpwifi_ie_types_header) +
+					S_DS_GEN + KEY_PARAMS_FIXED_LEN +
+					sizeof(km->action));
+		return 0;
+	}
+
+	memset(&km->key_param_set, 0,
+	       sizeof(struct nxpwifi_ie_type_key_param_set));
+
+	if (enc_key->key_disable) {
+		nxpwifi_dbg(adapter, INFO, "%s: Remove key\n", __func__);
+		km->action = cpu_to_le16(HOST_ACT_GEN_REMOVE);
+		km->key_param_set.type = cpu_to_le16(TLV_TYPE_KEY_PARAM_V2);
+		km->key_param_set.len = cpu_to_le16(KEY_PARAMS_FIXED_LEN);
+		km->key_param_set.key_idx = enc_key->key_index & KEY_INDEX_MASK;
+		key_info = KEY_MCAST | KEY_UNICAST;
+		km->key_param_set.key_info = cpu_to_le16(key_info);
+		ether_addr_copy(km->key_param_set.mac_addr, mac);
+		cmd->size = cpu_to_le16(sizeof(struct nxpwifi_ie_types_header) +
+					S_DS_GEN + KEY_PARAMS_FIXED_LEN +
+					sizeof(km->action));
+		return 0;
+	}
+
+	km->action = cpu_to_le16(HOST_ACT_GEN_SET);
+	km->key_param_set.key_idx = enc_key->key_index & KEY_INDEX_MASK;
+	km->key_param_set.type = cpu_to_le16(TLV_TYPE_KEY_PARAM_V2);
+	key_info = KEY_ENABLED;
+	ether_addr_copy(km->key_param_set.mac_addr, mac);
+
+	if (enc_key->key_len <= WLAN_KEY_LEN_WEP104) {
+		nxpwifi_dbg(adapter, INFO, "%s: Set WEP Key\n", __func__);
+		len += sizeof(struct nxpwifi_wep_param);
+		km->key_param_set.len = cpu_to_le16(len);
+		km->key_param_set.key_type = KEY_TYPE_ID_WEP;
+
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+			key_info |= KEY_MCAST | KEY_UNICAST;
+		} else {
+			if (enc_key->is_current_wep_key) {
+				key_info |= KEY_MCAST | KEY_UNICAST;
+				if (km->key_param_set.key_idx ==
+				    (priv->wep_key_curr_index & KEY_INDEX_MASK))
+					key_info |= KEY_DEFAULT;
+			} else {
+				if (is_broadcast_ether_addr(mac))
+					key_info |= KEY_MCAST;
+				else
+					key_info |= KEY_UNICAST | KEY_DEFAULT;
+			}
+		}
+		km->key_param_set.key_info = cpu_to_le16(key_info);
+
+		km->key_param_set.key_params.wep.key_len =
+						  cpu_to_le16(enc_key->key_len);
+		memcpy(km->key_param_set.key_params.wep.key,
+		       enc_key->key_material, enc_key->key_len);
+
+		cmd->size = cpu_to_le16(sizeof(struct nxpwifi_ie_types_header) +
+					len + sizeof(km->action) + S_DS_GEN);
+		return 0;
+	}
+
+	if (is_broadcast_ether_addr(mac))
+		key_info |= KEY_MCAST | KEY_RX_KEY;
+	else
+		key_info |= KEY_UNICAST | KEY_TX_KEY | KEY_RX_KEY;
+
+	/* Enable default key for WPA/WPA2 */
+	if (!priv->wpa_is_gtk_set)
+		key_info |= KEY_DEFAULT;
+
+	km->key_param_set.key_info = cpu_to_le16(key_info);
+
+	if (enc_key->key_cipher != WLAN_CIPHER_SUITE_TKIP &&
+	    enc_key->key_len >= WLAN_KEY_LEN_CCMP)
+		return nxpwifi_set_aes_key(priv, cmd, enc_key, km);
+
+	if (enc_key->key_len == WLAN_KEY_LEN_TKIP) {
+		nxpwifi_dbg(adapter, INFO,
+			    "%s: Set TKIP Key\n", __func__);
+		if (enc_key->is_rx_seq_valid)
+			memcpy(km->key_param_set.key_params.tkip.pn,
+			       enc_key->pn, enc_key->pn_len);
+		km->key_param_set.key_type = KEY_TYPE_ID_TKIP;
+		km->key_param_set.key_params.tkip.key_len =
+						cpu_to_le16(enc_key->key_len);
+		memcpy(km->key_param_set.key_params.tkip.key,
+		       enc_key->key_material, enc_key->key_len);
+
+		len += sizeof(struct nxpwifi_tkip_param);
+		km->key_param_set.len = cpu_to_le16(len);
+		cmd->size = cpu_to_le16(sizeof(struct nxpwifi_ie_types_header) +
+					len + sizeof(km->action) + S_DS_GEN);
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_802_11_key_material(struct nxpwifi_private *priv,
+				    struct host_cmd_ds_command *resp,
+				    u16 cmdresp_no,
+				    void *data_buf)
+{
+	struct host_cmd_ds_802_11_key_material *key;
+	int len;
+
+	key = &resp->params.key_material;
+
+	len = le16_to_cpu(key->key_param_set.key_params.aes.key_len);
+	if (len > sizeof(key->key_param_set.key_params.aes.key))
+		return -EINVAL;
+
+	if (le16_to_cpu(key->action) == HOST_ACT_GEN_SET) {
+		if ((le16_to_cpu(key->key_param_set.key_info) & KEY_MCAST)) {
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: key: GTK is set\n");
+			priv->wpa_is_gtk_set = true;
+			priv->scan_block = false;
+			priv->port_open = true;
+		}
+	}
+
+	if (key->key_param_set.key_type != KEY_TYPE_ID_AES &&
+	    key->key_param_set.key_type != KEY_TYPE_ID_GCMP_256)
+		return 0;
+
+	memset(priv->aes_key.key_param_set.key_params.aes.key, 0,
+	       sizeof(key->key_param_set.key_params.aes.key));
+	priv->aes_key.key_param_set.key_params.aes.key_len = cpu_to_le16(len);
+	memcpy(priv->aes_key.key_param_set.key_params.aes.key,
+	       key->key_param_set.key_params.aes.key, len);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_bg_scan_config(struct nxpwifi_private *priv,
+				      struct host_cmd_ds_command *cmd,
+				      u16 cmd_no, void *data_buf,
+				      u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_802_11_bg_scan_config(priv, cmd, data_buf);
+}
+
+static int
+nxpwifi_cmd_sta_802_11_bg_scan_query(struct nxpwifi_private *priv,
+				     struct host_cmd_ds_command *cmd,
+				     u16 cmd_no, void *data_buf,
+				     u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_802_11_bg_scan_query(cmd);
+}
+
+static int
+nxpwifi_ret_sta_802_11_bg_scan_query(struct nxpwifi_private *priv,
+				     struct host_cmd_ds_command *resp,
+				     u16 cmdresp_no,
+				     void *data_buf)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+
+	ret = nxpwifi_ret_802_11_scan(priv, resp);
+	cfg80211_sched_scan_results(priv->wdev.wiphy, 0);
+	nxpwifi_dbg(adapter, CMD,
+		    "info: CMD_RESP: BG_SCAN result is ready!\n");
+
+	return ret;
+}
+
+static int
+nxpwifi_cmd_sta_wmm_get_status(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *cmd,
+			       u16 cmd_no, void *data_buf,
+			       u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(HOST_CMD_WMM_GET_STATUS);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_wmm_get_status) +
+				S_DS_GEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_wmm_get_status(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *resp,
+			       u16 cmdresp_no,
+			       void *data_buf)
+{
+	return nxpwifi_ret_wmm_get_status(priv, resp);
+}
+
+static int
+nxpwifi_cmd_sta_802_11_subsc_evt(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *cmd,
+				 u16 cmd_no, void *data_buf,
+				 u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_802_11_subsc_evt *subsc_evt = &cmd->params.subsc_evt;
+	struct nxpwifi_ds_misc_subsc_evt *subsc_evt_cfg =
+		(struct nxpwifi_ds_misc_subsc_evt *)data_buf;
+	struct nxpwifi_ie_types_rssi_threshold *rssi_tlv;
+	u16 event_bitmap;
+	u8 *pos;
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_SUBSCRIBE_EVENT);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_802_11_subsc_evt) +
+				S_DS_GEN);
+
+	subsc_evt->action = cpu_to_le16(subsc_evt_cfg->action);
+	nxpwifi_dbg(priv->adapter, CMD,
+		    "cmd: action: %d\n", subsc_evt_cfg->action);
+
+	/*For query requests, no configuration TLV structures are to be added.*/
+	if (subsc_evt_cfg->action == HOST_ACT_GEN_GET)
+		return 0;
+
+	subsc_evt->events = cpu_to_le16(subsc_evt_cfg->events);
+
+	event_bitmap = subsc_evt_cfg->events;
+	nxpwifi_dbg(priv->adapter, CMD, "cmd: event bitmap : %16x\n",
+		    event_bitmap);
+
+	if ((subsc_evt_cfg->action == HOST_ACT_BITWISE_CLR ||
+	     subsc_evt_cfg->action == HOST_ACT_BITWISE_SET) &&
+	    event_bitmap == 0) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Error: No event specified\t"
+			    "for bitwise action type\n");
+		return -EINVAL;
+	}
+
+	/* Append TLV structures for each of the specified events for
+	 * subscribing or re-configuring. This is not required for
+	 * bitwise unsubscribing request.
+	 */
+	if (subsc_evt_cfg->action == HOST_ACT_BITWISE_CLR)
+		return 0;
+
+	pos = ((u8 *)subsc_evt) +
+			sizeof(struct host_cmd_ds_802_11_subsc_evt);
+
+	if (event_bitmap & BITMASK_BCN_RSSI_LOW) {
+		rssi_tlv = (struct nxpwifi_ie_types_rssi_threshold *)pos;
+
+		rssi_tlv->header.type = cpu_to_le16(TLV_TYPE_RSSI_LOW);
+		rssi_tlv->header.len =
+		    cpu_to_le16(sizeof(struct nxpwifi_ie_types_rssi_threshold) -
+				sizeof(struct nxpwifi_ie_types_header));
+		rssi_tlv->abs_value = subsc_evt_cfg->bcn_l_rssi_cfg.abs_value;
+		rssi_tlv->evt_freq = subsc_evt_cfg->bcn_l_rssi_cfg.evt_freq;
+
+		nxpwifi_dbg(priv->adapter, EVENT,
+			    "Cfg Beacon Low Rssi event,\t"
+			    "RSSI:-%d dBm, Freq:%d\n",
+			    subsc_evt_cfg->bcn_l_rssi_cfg.abs_value,
+			    subsc_evt_cfg->bcn_l_rssi_cfg.evt_freq);
+
+		pos += sizeof(struct nxpwifi_ie_types_rssi_threshold);
+		le16_unaligned_add_cpu
+		(&cmd->size,
+		 sizeof(struct nxpwifi_ie_types_rssi_threshold));
+	}
+
+	if (event_bitmap & BITMASK_BCN_RSSI_HIGH) {
+		rssi_tlv = (struct nxpwifi_ie_types_rssi_threshold *)pos;
+
+		rssi_tlv->header.type = cpu_to_le16(TLV_TYPE_RSSI_HIGH);
+		rssi_tlv->header.len =
+		    cpu_to_le16(sizeof(struct nxpwifi_ie_types_rssi_threshold) -
+				sizeof(struct nxpwifi_ie_types_header));
+		rssi_tlv->abs_value = subsc_evt_cfg->bcn_h_rssi_cfg.abs_value;
+		rssi_tlv->evt_freq = subsc_evt_cfg->bcn_h_rssi_cfg.evt_freq;
+
+		nxpwifi_dbg(priv->adapter, EVENT,
+			    "Cfg Beacon High Rssi event,\t"
+			    "RSSI:-%d dBm, Freq:%d\n",
+			    subsc_evt_cfg->bcn_h_rssi_cfg.abs_value,
+			    subsc_evt_cfg->bcn_h_rssi_cfg.evt_freq);
+
+		pos += sizeof(struct nxpwifi_ie_types_rssi_threshold);
+		le16_unaligned_add_cpu
+		(&cmd->size,
+		 sizeof(struct nxpwifi_ie_types_rssi_threshold));
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_subsc_evt(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp,
+			  u16 cmdresp_no,
+			  void *data_buf)
+{
+	struct host_cmd_ds_802_11_subsc_evt *cmd_sub_event =
+		&resp->params.subsc_evt;
+
+	/* For every subscribe event command (Get/Set/Clear), FW reports the
+	 * current set of subscribed events
+	 */
+	nxpwifi_dbg(priv->adapter, EVENT,
+		    "Bitmap of currently subscribed events: %16x\n",
+		    le16_to_cpu(cmd_sub_event->events));
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_tx_rate_query(struct nxpwifi_private *priv,
+				     struct host_cmd_ds_command *cmd,
+				     u16 cmd_no, void *data_buf,
+				     u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_TX_RATE_QUERY);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_tx_rate_query) +
+				S_DS_GEN);
+	priv->tx_rate = 0;
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_802_11_tx_rate_query(struct nxpwifi_private *priv,
+				     struct host_cmd_ds_command *resp,
+				     u16 cmdresp_no,
+				     void *data_buf)
+{
+	priv->tx_rate = resp->params.tx_rate.tx_rate;
+	priv->tx_htinfo = resp->params.tx_rate.ht_info;
+	if (!priv->is_data_rate_auto)
+		priv->data_rate =
+			nxpwifi_index_to_data_rate(priv, priv->tx_rate,
+						   priv->tx_htinfo);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_mem_access(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *cmd,
+			   u16 cmd_no, void *data_buf,
+			   u16 cmd_action, u32 cmd_type)
+{
+	struct nxpwifi_ds_mem_rw *mem_rw =
+		(struct nxpwifi_ds_mem_rw *)data_buf;
+	struct host_cmd_ds_mem_access *mem_access = (void *)&cmd->params.mem;
+
+	cmd->command = cpu_to_le16(HOST_CMD_MEM_ACCESS);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_mem_access) +
+				S_DS_GEN);
+
+	mem_access->action = cpu_to_le16(cmd_action);
+	mem_access->addr = cpu_to_le32(mem_rw->addr);
+	mem_access->value = cpu_to_le32(mem_rw->value);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_mem_access(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *resp,
+			   u16 cmdresp_no,
+			   void *data_buf)
+{
+	struct host_cmd_ds_mem_access *mem = (void *)&resp->params.mem;
+
+	priv->mem_rw.addr = le32_to_cpu(mem->addr);
+	priv->mem_rw.value = le32_to_cpu(mem->value);
+
+	return 0;
+}
+
+static u32 nxpwifi_parse_cal_cfg(u8 *src, size_t len, u8 *dst)
+{
+	u8 *s = src, *d = dst;
+
+	while (s - src < len) {
+		if (*s && (isspace(*s) || *s == '\t')) {
+			s++;
+			continue;
+		}
+		if (isxdigit(*s)) {
+			if (kstrtou8(s, 16, d))
+				return 0;
+			d++;
+			s += 2;
+		} else {
+			s++;
+		}
+	}
+
+	return d - dst;
+}
+
+static int
+nxpwifi_cmd_sta_cfg_data(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd,
+			 u16 cmd_no, void *data_buf,
+			 u16 cmd_action, u32 cmd_type)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct property *prop = data_buf;
+	u32 len;
+	u8 *data = (u8 *)cmd + S_DS_GEN;
+	int ret;
+
+	if (prop) {
+		len = prop->length;
+		ret = of_property_read_u8_array(adapter->dt_node, prop->name,
+						data, len);
+		if (ret)
+			return ret;
+		nxpwifi_dbg(adapter, INFO,
+			    "download cfg_data from device tree: %s\n",
+			    prop->name);
+	} else if (adapter->cal_data->data && adapter->cal_data->size > 0) {
+		len = nxpwifi_parse_cal_cfg((u8 *)adapter->cal_data->data,
+					    adapter->cal_data->size, data);
+		nxpwifi_dbg(adapter, INFO,
+			    "download cfg_data from config file\n");
+	} else {
+		return -EINVAL;
+	}
+
+	cmd->command = cpu_to_le16(HOST_CMD_CFG_DATA);
+	cmd->size = cpu_to_le16(S_DS_GEN + len);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_cfg_data(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 u16 cmdresp_no,
+			 void *data_buf)
+{
+	if (resp->result != HOST_RESULT_OK) {
+		nxpwifi_dbg(priv->adapter, ERROR, "Cal data cmd resp failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_ver_ext(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd,
+			u16 cmd_no, void *data_buf,
+			u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(cmd_no);
+	cmd->params.verext.version_str_sel =
+		(u8)(get_unaligned((u32 *)data_buf));
+	memcpy(&cmd->params, data_buf, sizeof(struct host_cmd_ds_version_ext));
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_version_ext) +
+				S_DS_GEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_ver_ext(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			u16 cmdresp_no,
+			void *data_buf)
+{
+	struct host_cmd_ds_version_ext *ver_ext = &resp->params.verext;
+	struct host_cmd_ds_version_ext *version_ext =
+		(struct host_cmd_ds_version_ext *)data_buf;
+
+	if (test_and_clear_bit(NXPWIFI_IS_REQUESTING_FW_VEREXT, &priv->adapter->work_flags)) {
+		if (strncmp(ver_ext->version_str, "ChipRev:20, BB:9b(10.00), RF:40(21)",
+			    NXPWIFI_VERSION_STR_LENGTH) == 0) {
+			struct nxpwifi_ds_auto_ds auto_ds = {
+				.auto_ds = DEEP_SLEEP_OFF,
+			};
+
+			nxpwifi_dbg(priv->adapter, MSG,
+				    "Bad HW revision detected, disabling deep sleep\n");
+
+			if (nxpwifi_send_cmd(priv, HOST_CMD_802_11_PS_MODE_ENH,
+					     DIS_AUTO_PS, BITMAP_AUTO_DS, &auto_ds, false)) {
+				nxpwifi_dbg(priv->adapter, MSG,
+					    "Disabling deep sleep failed.\n");
+			}
+		}
+
+		return 0;
+	}
+
+	if (version_ext) {
+		version_ext->version_str_sel = ver_ext->version_str_sel;
+		memcpy(version_ext->version_str, ver_ext->version_str,
+		       NXPWIFI_VERSION_STR_LENGTH);
+		memcpy(priv->version_str, ver_ext->version_str,
+		       NXPWIFI_VERSION_STR_LENGTH);
+
+		/* Ensure the version string from the firmware is 0-terminated */
+		priv->version_str[NXPWIFI_VERSION_STR_LENGTH - 1] = '\0';
+	}
+	return 0;
+}
+
+static int
+nxpwifi_cmd_append_rpn_expression(struct nxpwifi_private *priv,
+				  struct nxpwifi_mef_entry *mef_entry,
+				  u8 **buffer)
+{
+	struct nxpwifi_mef_filter *filter = mef_entry->filter;
+	int i, byte_len;
+	u8 *stack_ptr = *buffer;
+
+	for (i = 0; i < NXPWIFI_MEF_MAX_FILTERS; i++) {
+		filter = &mef_entry->filter[i];
+		if (!filter->filt_type)
+			break;
+		put_unaligned_le32((u32)filter->repeat, stack_ptr);
+		stack_ptr += 4;
+		*stack_ptr = TYPE_DNUM;
+		stack_ptr += 1;
+
+		byte_len = filter->byte_seq[NXPWIFI_MEF_MAX_BYTESEQ];
+		memcpy(stack_ptr, filter->byte_seq, byte_len);
+		stack_ptr += byte_len;
+		*stack_ptr = byte_len;
+		stack_ptr += 1;
+		*stack_ptr = TYPE_BYTESEQ;
+		stack_ptr += 1;
+		put_unaligned_le32((u32)filter->offset, stack_ptr);
+		stack_ptr += 4;
+		*stack_ptr = TYPE_DNUM;
+		stack_ptr += 1;
+
+		*stack_ptr = filter->filt_type;
+		stack_ptr += 1;
+
+		if (filter->filt_action) {
+			*stack_ptr = filter->filt_action;
+			stack_ptr += 1;
+		}
+
+		if (stack_ptr - *buffer > STACK_NBYTES)
+			return -ENOMEM;
+	}
+
+	*buffer = stack_ptr;
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_mef_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd,
+			u16 cmd_no, void *data_buf,
+			u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_mef_cfg *mef_cfg = &cmd->params.mef_cfg;
+	struct nxpwifi_ds_mef_cfg *mef =
+		(struct nxpwifi_ds_mef_cfg *)data_buf;
+	struct nxpwifi_fw_mef_entry *mef_entry = NULL;
+	u8 *pos = (u8 *)mef_cfg;
+	u16 i;
+	int ret = 0;
+
+	cmd->command = cpu_to_le16(HOST_CMD_MEF_CFG);
+
+	mef_cfg->criteria = cpu_to_le32(mef->criteria);
+	mef_cfg->num_entries = cpu_to_le16(mef->num_entries);
+	pos += sizeof(*mef_cfg);
+
+	for (i = 0; i < mef->num_entries; i++) {
+		mef_entry = (struct nxpwifi_fw_mef_entry *)pos;
+		mef_entry->mode = mef->mef_entry[i].mode;
+		mef_entry->action = mef->mef_entry[i].action;
+		pos += sizeof(*mef_entry);
+
+		ret = nxpwifi_cmd_append_rpn_expression(priv,
+							&mef->mef_entry[i],
+							&pos);
+		if (ret)
+			return ret;
+
+		mef_entry->exprsize =
+			cpu_to_le16(pos - mef_entry->expr);
+	}
+	cmd->size = cpu_to_le16((u16)(pos - (u8 *)mef_cfg) + S_DS_GEN);
+
+	return ret;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_rssi_info(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *cmd,
+				 u16 cmd_no, void *data_buf,
+				 u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(HOST_CMD_RSSI_INFO);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_802_11_rssi_info) +
+				S_DS_GEN);
+	cmd->params.rssi_info.action = cpu_to_le16(cmd_action);
+	cmd->params.rssi_info.ndata = cpu_to_le16(priv->data_avg_factor);
+	cmd->params.rssi_info.nbcn = cpu_to_le16(priv->bcn_avg_factor);
+
+	/* Reset SNR/NF/RSSI values in private structure */
+	priv->data_rssi_last = 0;
+	priv->data_nf_last = 0;
+	priv->data_rssi_avg = 0;
+	priv->data_nf_avg = 0;
+	priv->bcn_rssi_last = 0;
+	priv->bcn_nf_last = 0;
+	priv->bcn_rssi_avg = 0;
+	priv->bcn_nf_avg = 0;
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_802_11_rssi_info(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *resp,
+				 u16 cmdresp_no,
+				 void *data_buf)
+{
+	struct host_cmd_ds_802_11_rssi_info_rsp *rssi_info_rsp =
+		&resp->params.rssi_info_rsp;
+	struct nxpwifi_ds_misc_subsc_evt *subsc_evt =
+		&priv->async_subsc_evt_storage;
+
+	priv->data_rssi_last = le16_to_cpu(rssi_info_rsp->data_rssi_last);
+	priv->data_nf_last = le16_to_cpu(rssi_info_rsp->data_nf_last);
+
+	priv->data_rssi_avg = le16_to_cpu(rssi_info_rsp->data_rssi_avg);
+	priv->data_nf_avg = le16_to_cpu(rssi_info_rsp->data_nf_avg);
+
+	priv->bcn_rssi_last = le16_to_cpu(rssi_info_rsp->bcn_rssi_last);
+	priv->bcn_nf_last = le16_to_cpu(rssi_info_rsp->bcn_nf_last);
+
+	priv->bcn_rssi_avg = le16_to_cpu(rssi_info_rsp->bcn_rssi_avg);
+	priv->bcn_nf_avg = le16_to_cpu(rssi_info_rsp->bcn_nf_avg);
+
+	if (priv->subsc_evt_rssi_state == EVENT_HANDLED)
+		return 0;
+
+	memset(subsc_evt, 0x00, sizeof(struct nxpwifi_ds_misc_subsc_evt));
+
+	/* Resubscribe low and high rssi events with new thresholds */
+	subsc_evt->events = BITMASK_BCN_RSSI_LOW | BITMASK_BCN_RSSI_HIGH;
+	subsc_evt->action = HOST_ACT_BITWISE_SET;
+	if (priv->subsc_evt_rssi_state == RSSI_LOW_RECVD) {
+		subsc_evt->bcn_l_rssi_cfg.abs_value = abs(priv->bcn_rssi_avg -
+				priv->cqm_rssi_hyst);
+		subsc_evt->bcn_h_rssi_cfg.abs_value = abs(priv->cqm_rssi_thold);
+	} else if (priv->subsc_evt_rssi_state == RSSI_HIGH_RECVD) {
+		subsc_evt->bcn_l_rssi_cfg.abs_value = abs(priv->cqm_rssi_thold);
+		subsc_evt->bcn_h_rssi_cfg.abs_value = abs(priv->bcn_rssi_avg +
+				priv->cqm_rssi_hyst);
+	}
+	subsc_evt->bcn_l_rssi_cfg.evt_freq = 1;
+	subsc_evt->bcn_h_rssi_cfg.evt_freq = 1;
+
+	priv->subsc_evt_rssi_state = EVENT_HANDLED;
+
+	nxpwifi_send_cmd(priv, HOST_CMD_802_11_SUBSCRIBE_EVENT,
+			 0, 0, subsc_evt, false);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_func_init(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *cmd,
+			  u16 cmd_no, void *data_buf,
+			  u16 cmd_action, u32 cmd_type)
+{
+	if (priv->adapter->hw_status == NXPWIFI_HW_STATUS_RESET)
+		priv->adapter->hw_status = NXPWIFI_HW_STATUS_READY;
+	cmd->command = cpu_to_le16(cmd_no);
+	cmd->size = cpu_to_le16(S_DS_GEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_func_shutdown(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *cmd,
+			      u16 cmd_no, void *data_buf,
+			      u16 cmd_action, u32 cmd_type)
+{
+	priv->adapter->hw_status = NXPWIFI_HW_STATUS_RESET;
+	cmd->command = cpu_to_le16(cmd_no);
+	cmd->size = cpu_to_le16(S_DS_GEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_11n_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd,
+			u16 cmd_no, void *data_buf,
+			u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_11n_cfg(priv, cmd, cmd_action, data_buf);
+}
+
+static int
+nxpwifi_cmd_sta_11n_addba_req(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *cmd,
+			      u16 cmd_no, void *data_buf,
+			      u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_11n_addba_req(cmd, data_buf);
+}
+
+static int
+nxpwifi_ret_sta_11n_addba_req(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp,
+			      u16 cmdresp_no,
+			      void *data_buf)
+{
+	return nxpwifi_ret_11n_addba_req(priv, resp);
+}
+
+static int
+nxpwifi_cmd_sta_11n_addba_rsp(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *cmd,
+			      u16 cmd_no, void *data_buf,
+			      u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_11n_addba_rsp_gen(priv, cmd, data_buf);
+}
+
+static int
+nxpwifi_ret_sta_11n_addba_rsp(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp,
+			      u16 cmdresp_no,
+			      void *data_buf)
+{
+	return nxpwifi_ret_11n_addba_resp(priv, resp);
+}
+
+static int
+nxpwifi_cmd_sta_11n_delba(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *cmd,
+			  u16 cmd_no, void *data_buf,
+			  u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_11n_delba(cmd, data_buf);
+}
+
+static int
+nxpwifi_ret_sta_11n_delba(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp,
+			  u16 cmdresp_no,
+			  void *data_buf)
+{
+	return nxpwifi_ret_11n_delba(priv, resp);
+}
+
+static int
+nxpwifi_cmd_sta_tx_power_cfg(struct nxpwifi_private *priv,
+			     struct host_cmd_ds_command *cmd,
+			     u16 cmd_no, void *data_buf,
+			     u16 cmd_action, u32 cmd_type)
+{
+	struct nxpwifi_types_power_group *pg_tlv;
+	struct host_cmd_ds_txpwr_cfg *cmd_txp_cfg = &cmd->params.txp_cfg;
+	struct host_cmd_ds_txpwr_cfg *txp =
+		(struct host_cmd_ds_txpwr_cfg *)data_buf;
+
+	cmd->command = cpu_to_le16(HOST_CMD_TXPWR_CFG);
+	cmd->size =
+		cpu_to_le16(S_DS_GEN + sizeof(struct host_cmd_ds_txpwr_cfg));
+	switch (cmd_action) {
+	case HOST_ACT_GEN_SET:
+		if (txp->mode) {
+			pg_tlv = (struct nxpwifi_types_power_group
+				  *)((unsigned long)txp +
+				     sizeof(struct host_cmd_ds_txpwr_cfg));
+			memmove(cmd_txp_cfg, txp,
+				sizeof(struct host_cmd_ds_txpwr_cfg) +
+				sizeof(struct nxpwifi_types_power_group) +
+				le16_to_cpu(pg_tlv->length));
+
+			pg_tlv = (struct nxpwifi_types_power_group *)((u8 *)
+				  cmd_txp_cfg +
+				  sizeof(struct host_cmd_ds_txpwr_cfg));
+			cmd->size = cpu_to_le16(le16_to_cpu(cmd->size) +
+				  sizeof(struct nxpwifi_types_power_group) +
+				  le16_to_cpu(pg_tlv->length));
+		} else {
+			memmove(cmd_txp_cfg, txp, sizeof(*txp));
+		}
+		cmd_txp_cfg->action = cpu_to_le16(cmd_action);
+		break;
+	case HOST_ACT_GEN_GET:
+		cmd_txp_cfg->action = cpu_to_le16(cmd_action);
+		break;
+	}
+
+	return 0;
+}
+
+static int nxpwifi_get_power_level(struct nxpwifi_private *priv, void *data_buf)
+{
+	int length, max_power = -1, min_power = -1;
+	struct nxpwifi_types_power_group *pg_tlv_hdr;
+	struct nxpwifi_power_group *pg;
+
+	if (!data_buf)
+		return -ENOMEM;
+
+	pg_tlv_hdr = (struct nxpwifi_types_power_group *)((u8 *)data_buf);
+	pg = (struct nxpwifi_power_group *)
+		((u8 *)pg_tlv_hdr + sizeof(struct nxpwifi_types_power_group));
+	length = le16_to_cpu(pg_tlv_hdr->length);
+
+	/* At least one structure required to update power */
+	if (length < sizeof(struct nxpwifi_power_group))
+		return 0;
+
+	max_power = pg->power_max;
+	min_power = pg->power_min;
+	length -= sizeof(struct nxpwifi_power_group);
+
+	while (length >= sizeof(struct nxpwifi_power_group)) {
+		pg++;
+		if (max_power < pg->power_max)
+			max_power = pg->power_max;
+
+		if (min_power > pg->power_min)
+			min_power = pg->power_min;
+
+		length -= sizeof(struct nxpwifi_power_group);
+	}
+	priv->min_tx_power_level = (u8)min_power;
+	priv->max_tx_power_level = (u8)max_power;
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_tx_power_cfg(struct nxpwifi_private *priv,
+			     struct host_cmd_ds_command *resp,
+			     u16 cmdresp_no,
+			     void *data_buf)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_txpwr_cfg *txp_cfg = &resp->params.txp_cfg;
+	struct nxpwifi_types_power_group *pg_tlv_hdr;
+	struct nxpwifi_power_group *pg;
+	u16 action = le16_to_cpu(txp_cfg->action);
+	u16 tlv_buf_left;
+
+	pg_tlv_hdr = (struct nxpwifi_types_power_group *)
+		((u8 *)txp_cfg +
+		 sizeof(struct host_cmd_ds_txpwr_cfg));
+
+	pg = (struct nxpwifi_power_group *)
+		((u8 *)pg_tlv_hdr +
+		 sizeof(struct nxpwifi_types_power_group));
+
+	tlv_buf_left = le16_to_cpu(resp->size) - S_DS_GEN - sizeof(*txp_cfg);
+	if (tlv_buf_left <
+			le16_to_cpu(pg_tlv_hdr->length) + sizeof(*pg_tlv_hdr))
+		return 0;
+
+	switch (action) {
+	case HOST_ACT_GEN_GET:
+		if (adapter->hw_status == NXPWIFI_HW_STATUS_INITIALIZING)
+			nxpwifi_get_power_level(priv, pg_tlv_hdr);
+
+		priv->tx_power_level = (u16)pg->power_min;
+		break;
+
+	case HOST_ACT_GEN_SET:
+		if (!le32_to_cpu(txp_cfg->mode))
+			break;
+
+		if (pg->power_max == pg->power_min)
+			priv->tx_power_level = (u16)pg->power_min;
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "CMD_RESP: unknown cmd action %d\n",
+			    action);
+		return 0;
+	}
+	nxpwifi_dbg(adapter, INFO,
+		    "info: Current TxPower Level = %d, Max Power=%d, Min Power=%d\n",
+		    priv->tx_power_level, priv->max_tx_power_level,
+		    priv->min_tx_power_level);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_tx_rate_cfg(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *cmd,
+			    u16 cmd_no, void *data_buf,
+			    u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_tx_rate_cfg *rate_cfg = &cmd->params.tx_rate_cfg;
+	u16 *pbitmap_rates = (u16 *)data_buf;
+	struct nxpwifi_rate_scope *rate_scope;
+	struct nxpwifi_rate_drop_pattern *rate_drop;
+	u32 i;
+
+	cmd->command = cpu_to_le16(HOST_CMD_TX_RATE_CFG);
+
+	rate_cfg->action = cpu_to_le16(cmd_action);
+	rate_cfg->cfg_index = 0;
+
+	rate_scope = (struct nxpwifi_rate_scope *)((u8 *)rate_cfg +
+		      sizeof(struct host_cmd_ds_tx_rate_cfg));
+	rate_scope->type = cpu_to_le16(TLV_TYPE_RATE_SCOPE);
+	rate_scope->length = cpu_to_le16
+		(sizeof(*rate_scope) - sizeof(struct nxpwifi_ie_types_header));
+	if (pbitmap_rates) {
+		rate_scope->hr_dsss_rate_bitmap = cpu_to_le16(pbitmap_rates[0]);
+		rate_scope->ofdm_rate_bitmap = cpu_to_le16(pbitmap_rates[1]);
+		for (i = 0; i < ARRAY_SIZE(rate_scope->ht_mcs_rate_bitmap); i++)
+			rate_scope->ht_mcs_rate_bitmap[i] =
+				cpu_to_le16(pbitmap_rates[2 + i]);
+		if (priv->adapter->fw_api_ver == NXPWIFI_FW_V15) {
+			for (i = 0;
+			     i < ARRAY_SIZE(rate_scope->vht_mcs_rate_bitmap);
+			     i++)
+				rate_scope->vht_mcs_rate_bitmap[i] =
+					cpu_to_le16(pbitmap_rates[10 + i]);
+		}
+	} else {
+		rate_scope->hr_dsss_rate_bitmap =
+			cpu_to_le16(priv->bitmap_rates[0]);
+		rate_scope->ofdm_rate_bitmap =
+			cpu_to_le16(priv->bitmap_rates[1]);
+		for (i = 0; i < ARRAY_SIZE(rate_scope->ht_mcs_rate_bitmap); i++)
+			rate_scope->ht_mcs_rate_bitmap[i] =
+				cpu_to_le16(priv->bitmap_rates[2 + i]);
+		if (priv->adapter->fw_api_ver == NXPWIFI_FW_V15) {
+			for (i = 0;
+			     i < ARRAY_SIZE(rate_scope->vht_mcs_rate_bitmap);
+			     i++)
+				rate_scope->vht_mcs_rate_bitmap[i] =
+					cpu_to_le16(priv->bitmap_rates[10 + i]);
+		}
+	}
+
+	rate_drop = (struct nxpwifi_rate_drop_pattern *)((u8 *)rate_scope +
+					     sizeof(struct nxpwifi_rate_scope));
+	rate_drop->type = cpu_to_le16(TLV_TYPE_RATE_DROP_CONTROL);
+	rate_drop->length = cpu_to_le16(sizeof(rate_drop->rate_drop_mode));
+	rate_drop->rate_drop_mode = 0;
+
+	cmd->size =
+		cpu_to_le16(S_DS_GEN + sizeof(struct host_cmd_ds_tx_rate_cfg) +
+			    sizeof(struct nxpwifi_rate_scope) +
+			    sizeof(struct nxpwifi_rate_drop_pattern));
+
+	return 0;
+}
+
+static void nxpwifi_ret_rate_scope(struct nxpwifi_private *priv, u8 *tlv_buf)
+{
+	struct nxpwifi_rate_scope *rate_scope;
+	int i;
+
+	rate_scope = (struct nxpwifi_rate_scope *)tlv_buf;
+	priv->bitmap_rates[0] =
+		le16_to_cpu(rate_scope->hr_dsss_rate_bitmap);
+	priv->bitmap_rates[1] =
+		le16_to_cpu(rate_scope->ofdm_rate_bitmap);
+	for (i = 0; i < ARRAY_SIZE(rate_scope->ht_mcs_rate_bitmap); i++)
+		priv->bitmap_rates[2 + i] =
+			le16_to_cpu(rate_scope->ht_mcs_rate_bitmap[i]);
+
+	if (priv->adapter->fw_api_ver == NXPWIFI_FW_V15) {
+		for (i = 0; i < ARRAY_SIZE(rate_scope->vht_mcs_rate_bitmap);
+		     i++)
+			priv->bitmap_rates[10 + i] =
+				le16_to_cpu(rate_scope->vht_mcs_rate_bitmap[i]);
+	}
+}
+
+static int
+nxpwifi_ret_sta_tx_rate_cfg(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *resp,
+			    u16 cmdresp_no,
+			    void *data_buf)
+{
+	struct host_cmd_ds_tx_rate_cfg *rate_cfg = &resp->params.tx_rate_cfg;
+	struct nxpwifi_ie_types_header *head;
+	u16 tlv, tlv_buf_len, tlv_buf_left;
+	u8 *tlv_buf;
+
+	tlv_buf = ((u8 *)rate_cfg) + sizeof(struct host_cmd_ds_tx_rate_cfg);
+	tlv_buf_left = le16_to_cpu(resp->size) - S_DS_GEN - sizeof(*rate_cfg);
+
+	while (tlv_buf_left >= sizeof(*head)) {
+		head = (struct nxpwifi_ie_types_header *)tlv_buf;
+		tlv = le16_to_cpu(head->type);
+		tlv_buf_len = le16_to_cpu(head->len);
+
+		if (tlv_buf_left < (sizeof(*head) + tlv_buf_len))
+			break;
+
+		switch (tlv) {
+		case TLV_TYPE_RATE_SCOPE:
+			nxpwifi_ret_rate_scope(priv, tlv_buf);
+			break;
+			/* Add RATE_DROP tlv here */
+		}
+
+		tlv_buf += (sizeof(*head) + tlv_buf_len);
+		tlv_buf_left -= (sizeof(*head) + tlv_buf_len);
+	}
+
+	priv->is_data_rate_auto = nxpwifi_is_rate_auto(priv);
+
+	if (priv->is_data_rate_auto)
+		priv->data_rate = 0;
+	else
+		return nxpwifi_send_cmd(priv, HOST_CMD_802_11_TX_RATE_QUERY,
+					HOST_ACT_GEN_GET, 0, NULL, false);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_reconfigure_rx_buff(struct nxpwifi_private *priv,
+				    struct host_cmd_ds_command *cmd,
+				    u16 cmd_no, void *data_buf,
+				    u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_recfg_tx_buf(priv, cmd, cmd_action, data_buf);
+}
+
+static int
+nxpwifi_ret_sta_reconfigure_rx_buff(struct nxpwifi_private *priv,
+				    struct host_cmd_ds_command *resp,
+				    u16 cmdresp_no,
+				    void *data_buf)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (0xffff != (u16)le16_to_cpu(resp->params.tx_buf.buff_size)) {
+		adapter->tx_buf_size =
+			(u16)le16_to_cpu(resp->params.tx_buf.buff_size);
+		adapter->tx_buf_size =
+			(adapter->tx_buf_size / NXPWIFI_SDIO_BLOCK_SIZE) *
+			NXPWIFI_SDIO_BLOCK_SIZE;
+		adapter->curr_tx_buf_size = adapter->tx_buf_size;
+		nxpwifi_dbg(adapter, CMD, "cmd: curr_tx_buf_size=%d\n",
+			    adapter->curr_tx_buf_size);
+
+		if (adapter->if_ops.update_mp_end_port) {
+			u16 mp_end_port;
+
+			mp_end_port =
+				le16_to_cpu(resp->params.tx_buf.mp_end_port);
+			adapter->if_ops.update_mp_end_port(adapter,
+							   mp_end_port);
+		}
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_chan_report_request(struct nxpwifi_private *priv,
+				    struct host_cmd_ds_command *cmd,
+				    u16 cmd_no, void *data_buf,
+				    u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_issue_chan_report_request(priv, cmd, data_buf);
+}
+
+static int
+nxpwifi_cmd_sta_amsdu_aggr_ctrl(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *cmd,
+				u16 cmd_no, void *data_buf,
+				u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_amsdu_aggr_ctrl(cmd, cmd_action, data_buf);
+}
+
+static int
+nxpwifi_cmd_sta_robust_coex(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *cmd,
+			    u16 cmd_no, void *data_buf,
+			    u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_robust_coex *coex = &cmd->params.coex;
+	bool *is_timeshare = (bool *)data_buf;
+	struct nxpwifi_ie_types_robust_coex *coex_tlv;
+
+	cmd->command = cpu_to_le16(HOST_CMD_ROBUST_COEX);
+	cmd->size = cpu_to_le16(sizeof(*coex) + sizeof(*coex_tlv) + S_DS_GEN);
+
+	coex->action = cpu_to_le16(cmd_action);
+	coex_tlv = (struct nxpwifi_ie_types_robust_coex *)
+				((u8 *)coex + sizeof(*coex));
+	coex_tlv->header.type = cpu_to_le16(TLV_TYPE_ROBUST_COEX);
+	coex_tlv->header.len = cpu_to_le16(sizeof(coex_tlv->mode));
+
+	if (coex->action == HOST_ACT_GEN_GET)
+		return 0;
+
+	if (*is_timeshare)
+		coex_tlv->mode = cpu_to_le32(NXPWIFI_COEX_MODE_TIMESHARE);
+	else
+		coex_tlv->mode = cpu_to_le32(NXPWIFI_COEX_MODE_SPATIAL);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_robust_coex(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *resp,
+			    u16 cmdresp_no,
+			    void *data_buf)
+{
+	struct host_cmd_ds_robust_coex *coex = &resp->params.coex;
+	bool *is_timeshare = (bool *)data_buf;
+	struct nxpwifi_ie_types_robust_coex *coex_tlv;
+	u16 action = le16_to_cpu(coex->action);
+	u32 mode;
+
+	coex_tlv = (struct nxpwifi_ie_types_robust_coex
+		    *)((u8 *)coex + sizeof(struct host_cmd_ds_robust_coex));
+	if (action == HOST_ACT_GEN_GET) {
+		mode = le32_to_cpu(coex_tlv->mode);
+		if (mode == NXPWIFI_COEX_MODE_TIMESHARE)
+			*is_timeshare = true;
+		else
+			*is_timeshare = false;
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_enh_power_mode(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *cmd,
+			       u16 cmd_no, void *data_buf,
+			       u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_802_11_ps_mode_enh *psmode_enh =
+		&cmd->params.psmode_enh;
+	u16 ps_bitmap = (u16)cmd_type;
+	struct nxpwifi_ds_auto_ds *auto_ds =
+		(struct nxpwifi_ds_auto_ds *)data_buf;
+	u8 *tlv;
+	u16 cmd_size = 0;
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_PS_MODE_ENH);
+	if (cmd_action == DIS_AUTO_PS) {
+		psmode_enh->action = cpu_to_le16(DIS_AUTO_PS);
+		psmode_enh->params.ps_bitmap = cpu_to_le16(ps_bitmap);
+		cmd->size = cpu_to_le16(S_DS_GEN + sizeof(psmode_enh->action) +
+					sizeof(psmode_enh->params.ps_bitmap));
+	} else if (cmd_action == GET_PS) {
+		psmode_enh->action = cpu_to_le16(GET_PS);
+		psmode_enh->params.ps_bitmap = cpu_to_le16(ps_bitmap);
+		cmd->size = cpu_to_le16(S_DS_GEN + sizeof(psmode_enh->action) +
+					sizeof(psmode_enh->params.ps_bitmap));
+	} else if (cmd_action == EN_AUTO_PS) {
+		psmode_enh->action = cpu_to_le16(EN_AUTO_PS);
+		psmode_enh->params.ps_bitmap = cpu_to_le16(ps_bitmap);
+		cmd_size = S_DS_GEN + sizeof(psmode_enh->action) +
+					sizeof(psmode_enh->params.ps_bitmap);
+		tlv = (u8 *)cmd + cmd_size;
+		if (ps_bitmap & BITMAP_STA_PS) {
+			struct nxpwifi_adapter *adapter = priv->adapter;
+			struct nxpwifi_ie_types_ps_param *ps_tlv =
+				(struct nxpwifi_ie_types_ps_param *)tlv;
+			struct nxpwifi_ps_param *ps_mode = &ps_tlv->param;
+
+			ps_tlv->header.type = cpu_to_le16(TLV_TYPE_PS_PARAM);
+			ps_tlv->header.len = cpu_to_le16(sizeof(*ps_tlv) -
+					sizeof(struct nxpwifi_ie_types_header));
+			cmd_size += sizeof(*ps_tlv);
+			tlv += sizeof(*ps_tlv);
+			nxpwifi_dbg(priv->adapter, CMD,
+				    "cmd: PS Command: Enter PS\n");
+			ps_mode->null_pkt_interval =
+					cpu_to_le16(adapter->null_pkt_interval);
+			ps_mode->multiple_dtims =
+					cpu_to_le16(adapter->multiple_dtim);
+			ps_mode->bcn_miss_timeout =
+					cpu_to_le16(adapter->bcn_miss_time_out);
+			ps_mode->local_listen_interval =
+				cpu_to_le16(adapter->local_listen_interval);
+			ps_mode->delay_to_ps =
+					cpu_to_le16(adapter->delay_to_ps);
+			ps_mode->mode = cpu_to_le16(adapter->enhanced_ps_mode);
+		}
+		if (ps_bitmap & BITMAP_AUTO_DS) {
+			struct nxpwifi_ie_types_auto_ds_param *auto_ds_tlv =
+				(struct nxpwifi_ie_types_auto_ds_param *)tlv;
+			u16 idletime = 0;
+
+			auto_ds_tlv->header.type =
+				cpu_to_le16(TLV_TYPE_AUTO_DS_PARAM);
+			auto_ds_tlv->header.len =
+				cpu_to_le16(sizeof(*auto_ds_tlv) -
+					sizeof(struct nxpwifi_ie_types_header));
+			cmd_size += sizeof(*auto_ds_tlv);
+			tlv += sizeof(*auto_ds_tlv);
+			if (auto_ds)
+				idletime = auto_ds->idle_time;
+			nxpwifi_dbg(priv->adapter, CMD,
+				    "cmd: PS Command: Enter Auto Deep Sleep\n");
+			auto_ds_tlv->deep_sleep_timeout = cpu_to_le16(idletime);
+		}
+		cmd->size = cpu_to_le16(cmd_size);
+	}
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_enh_power_mode(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *resp,
+			       u16 cmdresp_no,
+			       void *data_buf)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_802_11_ps_mode_enh *ps_mode =
+		&resp->params.psmode_enh;
+	struct nxpwifi_ds_pm_cfg *pm_cfg =
+		(struct nxpwifi_ds_pm_cfg *)data_buf;
+	u16 action = le16_to_cpu(ps_mode->action);
+	u16 ps_bitmap = le16_to_cpu(ps_mode->params.ps_bitmap);
+	u16 auto_ps_bitmap =
+		le16_to_cpu(ps_mode->params.ps_bitmap);
+
+	nxpwifi_dbg(adapter, INFO,
+		    "info: %s: PS_MODE cmd reply result=%#x action=%#X\n",
+		    __func__, resp->result, action);
+	if (action == EN_AUTO_PS) {
+		if (auto_ps_bitmap & BITMAP_AUTO_DS) {
+			nxpwifi_dbg(adapter, CMD,
+				    "cmd: Enabled auto deep sleep\n");
+			priv->adapter->is_deep_sleep = true;
+		}
+		if (auto_ps_bitmap & BITMAP_STA_PS) {
+			nxpwifi_dbg(adapter, CMD,
+				    "cmd: Enabled STA power save\n");
+			if (adapter->sleep_period.period)
+				nxpwifi_dbg(adapter, CMD,
+					    "cmd: set to uapsd/pps mode\n");
+		}
+	} else if (action == DIS_AUTO_PS) {
+		if (ps_bitmap & BITMAP_AUTO_DS) {
+			priv->adapter->is_deep_sleep = false;
+			nxpwifi_dbg(adapter, CMD,
+				    "cmd: Disabled auto deep sleep\n");
+		}
+		if (ps_bitmap & BITMAP_STA_PS) {
+			nxpwifi_dbg(adapter, CMD,
+				    "cmd: Disabled STA power save\n");
+			if (adapter->sleep_period.period) {
+				adapter->delay_null_pkt = false;
+				adapter->tx_lock_flag = false;
+				adapter->pps_uapsd_mode = false;
+			}
+		}
+	} else if (action == GET_PS) {
+		if (ps_bitmap & BITMAP_STA_PS)
+			adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_PSP;
+		else
+			adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_CAM;
+
+		nxpwifi_dbg(adapter, CMD,
+			    "cmd: ps_bitmap=%#x\n", ps_bitmap);
+
+		if (pm_cfg) {
+			/* This section is for get power save mode */
+			if (ps_bitmap & BITMAP_STA_PS)
+				pm_cfg->param.ps_mode = 1;
+			else
+				pm_cfg->param.ps_mode = 0;
+		}
+	}
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_hs_cfg(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *cmd,
+			      u16 cmd_no, void *data_buf,
+			      u16 cmd_action, u32 cmd_type)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_802_11_hs_cfg_enh *hs_cfg = &cmd->params.opt_hs_cfg;
+	struct nxpwifi_hs_config_param *hscfg_param =
+		(struct nxpwifi_hs_config_param *)data_buf;
+	u8 *tlv = (u8 *)hs_cfg + sizeof(struct host_cmd_ds_802_11_hs_cfg_enh);
+	struct nxpwifi_ps_param_in_hs *psparam_tlv = NULL;
+	bool hs_activate = false;
+	u16 size;
+
+	if (!hscfg_param)
+		/* New Activate command */
+		hs_activate = true;
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_HS_CFG_ENH);
+
+	if (!hs_activate &&
+	    hscfg_param->conditions != cpu_to_le32(HS_CFG_CANCEL) &&
+	    (adapter->arp_filter_size > 0 &&
+	     adapter->arp_filter_size <= ARP_FILTER_MAX_BUF_SIZE)) {
+		nxpwifi_dbg(adapter, CMD,
+			    "cmd: Attach %d bytes ArpFilter to HSCfg cmd\n",
+			    adapter->arp_filter_size);
+		memcpy(((u8 *)hs_cfg) +
+		       sizeof(struct host_cmd_ds_802_11_hs_cfg_enh),
+		       adapter->arp_filter, adapter->arp_filter_size);
+		size = adapter->arp_filter_size +
+			sizeof(struct host_cmd_ds_802_11_hs_cfg_enh)
+			+ S_DS_GEN;
+		tlv = (u8 *)hs_cfg
+			+ sizeof(struct host_cmd_ds_802_11_hs_cfg_enh)
+			+ adapter->arp_filter_size;
+	} else {
+		size = S_DS_GEN + sizeof(struct host_cmd_ds_802_11_hs_cfg_enh);
+	}
+	if (hs_activate) {
+		hs_cfg->action = cpu_to_le16(HS_ACTIVATE);
+		hs_cfg->params.hs_activate.resp_ctrl = cpu_to_le16(RESP_NEEDED);
+
+		adapter->hs_activated_manually = true;
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: Activating host sleep manually\n");
+	} else {
+		hs_cfg->action = cpu_to_le16(HS_CONFIGURE);
+		hs_cfg->params.hs_config.conditions = hscfg_param->conditions;
+		hs_cfg->params.hs_config.gpio = hscfg_param->gpio;
+		hs_cfg->params.hs_config.gap = hscfg_param->gap;
+
+		size += sizeof(struct nxpwifi_ps_param_in_hs);
+		psparam_tlv = (struct nxpwifi_ps_param_in_hs *)tlv;
+		psparam_tlv->header.type =
+			cpu_to_le16(TLV_TYPE_PS_PARAMS_IN_HS);
+		psparam_tlv->header.len =
+			cpu_to_le16(sizeof(struct nxpwifi_ps_param_in_hs)
+				- sizeof(struct nxpwifi_ie_types_header));
+		psparam_tlv->hs_wake_int = cpu_to_le32(HS_DEF_WAKE_INTERVAL);
+		psparam_tlv->hs_inact_timeout =
+			cpu_to_le32(HS_DEF_INACTIVITY_TIMEOUT);
+
+		nxpwifi_dbg(adapter, CMD,
+			    "cmd: HS_CFG_CMD: condition:0x%x gpio:0x%x gap:0x%x\n",
+			    hs_cfg->params.hs_config.conditions,
+			    hs_cfg->params.hs_config.gpio,
+			    hs_cfg->params.hs_config.gap);
+	}
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_802_11_hs_cfg(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp,
+			      u16 cmdresp_no,
+			      void *data_buf)
+{
+	return nxpwifi_ret_802_11_hs_cfg(priv, resp);
+}
+
+static int
+nxpwifi_cmd_sta_set_bss_mode(struct nxpwifi_private *priv,
+			     struct host_cmd_ds_command *cmd,
+			     u16 cmd_no, void *data_buf,
+			     u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(cmd_no);
+	if (priv->bss_mode == NL80211_IFTYPE_STATION)
+		cmd->params.bss_mode.con_type = CONNECTION_TYPE_INFRA;
+	else if (priv->bss_mode == NL80211_IFTYPE_AP)
+		cmd->params.bss_mode.con_type = CONNECTION_TYPE_AP;
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_set_bss_mode) +
+				S_DS_GEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_net_monitor(struct nxpwifi_private *priv,
+				   struct host_cmd_ds_command *cmd,
+				   u16 cmd_no, void *data_buf,
+				   u16 cmd_action, u32 cmd_type)
+{
+	struct nxpwifi_802_11_net_monitor *net_mon;
+	struct host_cmd_ds_802_11_net_monitor *cmd_net_mon =
+		&cmd->params.net_mon;
+	struct chan_band_param *chan_band = NULL;
+	u8 sec_chan_offset = 0;
+	u32 bw_offset = 0;
+
+	net_mon = (struct nxpwifi_802_11_net_monitor *)data_buf;
+
+	cmd->size = cpu_to_le16(S_DS_GEN +
+				sizeof(struct host_cmd_ds_802_11_net_monitor) +
+				sizeof(struct chan_band_param));
+	cmd->command = cpu_to_le16(cmd_no);
+	cmd_net_mon->action = cpu_to_le16(cmd_action);
+
+	if (cmd_action == HOST_ACT_GEN_SET) {
+		if (net_mon->enable_net_mon) {
+			cmd_net_mon->enable_net_mon = cpu_to_le16(0x1);
+			cmd_net_mon->filter_flag = cpu_to_le16((u16)
+			net_mon->filter_flag);
+		}
+
+		if (net_mon->enable_net_mon && net_mon->channel) {
+			chan_band = &cmd_net_mon->monitor_chan.chan_band_param[0];
+			cmd_net_mon->monitor_chan.header.type =
+				cpu_to_le16(TLV_TYPE_CHANNELBANDLIST);
+			cmd_net_mon->monitor_chan.header.len =
+				cpu_to_le16(sizeof(struct chan_band_param));
+			chan_band->chan_number = (u8)net_mon->channel;
+			chan_band->band_cfg.chan_band =
+				nxpwifi_band_to_radio_type((u16)net_mon->band);
+
+			if (net_mon->band & BAND_GN ||
+			    net_mon->band & BAND_AN ||
+			    net_mon->band & BAND_GAC ||
+			    net_mon->band & BAND_AAC) {
+				bw_offset = net_mon->chan_bandwidth;
+				if (bw_offset == CHANNEL_BW_40MHZ_ABOVE) {
+					chan_band->band_cfg.chan_2O_ffset =
+						NXPWIFI_SEC_CHAN_ABOVE;
+					chan_band->band_cfg.chan_width =
+						CHAN_BW_40MHZ;
+				} else if (bw_offset == CHANNEL_BW_40MHZ_BELOW) {
+					chan_band->band_cfg.chan_2O_ffset =
+						NXPWIFI_SEC_CHAN_BELOW;
+					chan_band->band_cfg.chan_width =
+						CHAN_BW_40MHZ;
+				} else if (bw_offset == CHANNEL_BW_80MHZ) {
+					sec_chan_offset =
+						nxpwifi_get_sec_chan_offset(net_mon->channel);
+					if (sec_chan_offset == NXPWIFI_SEC_CHAN_ABOVE)
+						chan_band->band_cfg.chan_2O_ffset =
+							NXPWIFI_SEC_CHAN_ABOVE;
+					else if (sec_chan_offset == NXPWIFI_SEC_CHAN_BELOW)
+						chan_band->band_cfg.chan_2O_ffset =
+							NXPWIFI_SEC_CHAN_BELOW;
+					chan_band->band_cfg.chan_width = CHAN_BW_80MHZ;
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_802_11_net_monitor(struct nxpwifi_private *priv,
+				   struct host_cmd_ds_command *resp,
+				   u16 cmdresp_no,
+				   void *data_buf)
+{
+	struct host_cmd_ds_802_11_net_monitor *cmd_net_mon = &resp->params.net_mon;
+
+	nxpwifi_dbg(priv->adapter, CMD,
+		    "cmd: NET_MONITOR_CMD: action: %d, enable: %d, flag: %d ch: %d band: %d bw: %d offset: %d\n",
+		    le16_to_cpu(cmd_net_mon->action),
+		    le16_to_cpu(cmd_net_mon->enable_net_mon),
+		    le16_to_cpu(cmd_net_mon->filter_flag),
+		    cmd_net_mon->monitor_chan.chan_band_param[0].chan_number,
+		    cmd_net_mon->monitor_chan.chan_band_param[0].band_cfg.chan_band,
+		    cmd_net_mon->monitor_chan.chan_band_param[0].band_cfg.chan_width,
+		    cmd_net_mon->monitor_chan.chan_band_param[0].band_cfg.chan_2O_ffset);
+	priv->adapter->enable_net_mon = le16_to_cpu(cmd_net_mon->enable_net_mon);
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_802_11_scan_ext(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *cmd,
+				u16 cmd_no, void *data_buf,
+				u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_802_11_scan_ext(priv, cmd, data_buf);
+}
+
+static int
+nxpwifi_ret_sta_802_11_scan_ext(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *resp,
+				u16 cmdresp_no,
+				void *data_buf)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+
+	ret = nxpwifi_ret_802_11_scan_ext(priv, resp);
+	adapter->curr_cmd->wait_q_enabled = false;
+
+	return ret;
+}
+
+static int
+nxpwifi_cmd_sta_coalesce_cfg(struct nxpwifi_private *priv,
+			     struct host_cmd_ds_command *cmd,
+			     u16 cmd_no, void *data_buf,
+			     u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_coalesce_cfg *coalesce_cfg =
+		&cmd->params.coalesce_cfg;
+	struct nxpwifi_ds_coalesce_cfg *cfg =
+		(struct nxpwifi_ds_coalesce_cfg *)data_buf;
+	struct coalesce_filt_field_param *param;
+	u16 cnt, idx, length;
+	struct coalesce_receive_filt_rule *rule;
+
+	cmd->command = cpu_to_le16(HOST_CMD_COALESCE_CFG);
+	cmd->size = cpu_to_le16(S_DS_GEN);
+
+	coalesce_cfg->action = cpu_to_le16(cmd_action);
+	coalesce_cfg->num_of_rules = cpu_to_le16(cfg->num_of_rules);
+	rule = (void *)coalesce_cfg->rule_data;
+
+	for (cnt = 0; cnt < cfg->num_of_rules; cnt++) {
+		rule->header.type = cpu_to_le16(TLV_TYPE_COALESCE_RULE);
+		rule->max_coalescing_delay =
+			cpu_to_le16(cfg->rule[cnt].max_coalescing_delay);
+		rule->pkt_type = cfg->rule[cnt].pkt_type;
+		rule->num_of_fields = cfg->rule[cnt].num_of_fields;
+
+		length = 0;
+
+		param = rule->params;
+		for (idx = 0; idx < cfg->rule[cnt].num_of_fields; idx++) {
+			param->operation = cfg->rule[cnt].params[idx].operation;
+			param->operand_len =
+					cfg->rule[cnt].params[idx].operand_len;
+			param->offset =
+				cpu_to_le16(cfg->rule[cnt].params[idx].offset);
+			memcpy(param->operand_byte_stream,
+			       cfg->rule[cnt].params[idx].operand_byte_stream,
+			       param->operand_len);
+
+			length += sizeof(struct coalesce_filt_field_param);
+
+			param++;
+		}
+
+		/* Total rule length is sizeof max_coalescing_delay(u16),
+		 * num_of_fields(u8), pkt_type(u8) and total length of the all
+		 * params
+		 */
+		rule->header.len = cpu_to_le16(length + sizeof(u16) +
+					       sizeof(u8) + sizeof(u8));
+
+		/* Add the rule length to the command size*/
+		le16_unaligned_add_cpu(&cmd->size,
+				       le16_to_cpu(rule->header.len) +
+				       sizeof(struct nxpwifi_ie_types_header));
+
+		rule = (void *)((u8 *)rule->params + length);
+	}
+
+	/* Add sizeof action, num_of_rules to total command length */
+	le16_unaligned_add_cpu(&cmd->size, sizeof(u16) + sizeof(u16));
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_mgmt_frame_reg(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *cmd,
+			       u16 cmd_no, void *data_buf,
+			       u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(cmd_no);
+	cmd->params.reg_mask.action = cpu_to_le16(cmd_action);
+	cmd->params.reg_mask.mask =
+		cpu_to_le32(get_unaligned((u32 *)data_buf));
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_mgmt_frame_reg) +
+				S_DS_GEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_remain_on_chan(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *cmd,
+			       u16 cmd_no, void *data_buf,
+			       u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(cmd_no);
+	memcpy(&cmd->params, data_buf,
+	       sizeof(struct host_cmd_ds_remain_on_chan));
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_remain_on_chan) +
+				S_DS_GEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_remain_on_chan(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *resp,
+			       u16 cmdresp_no,
+			       void *data_buf)
+{
+	struct host_cmd_ds_remain_on_chan *resp_cfg = &resp->params.roc_cfg;
+	struct host_cmd_ds_remain_on_chan *roc_cfg =
+		(struct host_cmd_ds_remain_on_chan *)data_buf;
+
+	if (roc_cfg)
+		memcpy(roc_cfg, resp_cfg, sizeof(*roc_cfg));
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_gtk_rekey_offload(struct nxpwifi_private *priv,
+				  struct host_cmd_ds_command *cmd,
+				  u16 cmd_no, void *data_buf,
+				  u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_gtk_rekey_params *rekey = &cmd->params.rekey;
+	struct cfg80211_gtk_rekey_data *data =
+		(struct cfg80211_gtk_rekey_data *)data_buf;
+	u64 rekey_ctr;
+
+	cmd->command = cpu_to_le16(HOST_CMD_GTK_REKEY_OFFLOAD_CFG);
+	cmd->size = cpu_to_le16(sizeof(*rekey) + S_DS_GEN);
+
+	rekey->action = cpu_to_le16(cmd_action);
+	if (cmd_action == HOST_ACT_GEN_SET) {
+		memcpy(rekey->kek, data->kek, NL80211_KEK_LEN);
+		memcpy(rekey->kck, data->kck, NL80211_KCK_LEN);
+		rekey_ctr = be64_to_cpup((__be64 *)data->replay_ctr);
+		rekey->replay_ctr_low = cpu_to_le32((u32)rekey_ctr);
+		rekey->replay_ctr_high =
+			cpu_to_le32((u32)((u64)rekey_ctr >> 32));
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd,
+			 u16 cmd_no, void *data_buf,
+			 u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_11ac_cfg(priv, cmd, cmd_action, data_buf);
+}
+
+static int
+nxpwifi_cmd_sta_hs_wakeup_reason(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *cmd,
+				 u16 cmd_no, void *data_buf,
+				 u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(HOST_CMD_HS_WAKEUP_REASON);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_wakeup_reason) +
+				S_DS_GEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_hs_wakeup_reason(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *resp,
+				 u16 cmdresp_no,
+				 void *data_buf)
+{
+	struct host_cmd_ds_wakeup_reason *wakeup_reason =
+		(struct host_cmd_ds_wakeup_reason *)data_buf;
+	wakeup_reason->wakeup_reason =
+		resp->params.hs_wakeup_reason.wakeup_reason;
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_mc_policy(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *cmd,
+			  u16 cmd_no, void *data_buf,
+			  u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_multi_chan_policy *mc_pol = &cmd->params.mc_policy;
+	const u16 *drcs_info = data_buf;
+
+	mc_pol->action = cpu_to_le16(cmd_action);
+	mc_pol->policy = cpu_to_le16(*drcs_info);
+	cmd->command = cpu_to_le16(HOST_CMD_MC_POLICY);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_multi_chan_policy) +
+				S_DS_GEN);
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_sdio_rx_aggr_cfg(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *cmd,
+				 u16 cmd_no, void *data_buf,
+				 u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_sdio_sp_rx_aggr_cfg *cfg =
+					&cmd->params.sdio_rx_aggr_cfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_SDIO_SP_RX_AGGR_CFG);
+	cmd->size =
+		cpu_to_le16(sizeof(struct host_cmd_sdio_sp_rx_aggr_cfg) +
+			    S_DS_GEN);
+	cfg->action = cmd_action;
+	if (cmd_action == HOST_ACT_GEN_SET)
+		cfg->enable = *(u8 *)data_buf;
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_sdio_rx_aggr_cfg(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *resp,
+				 u16 cmdresp_no,
+				 void *data_buf)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_sdio_sp_rx_aggr_cfg *cfg =
+				&resp->params.sdio_rx_aggr_cfg;
+
+	adapter->sdio_rx_aggr_enable = cfg->enable;
+	adapter->sdio_rx_block_size = le16_to_cpu(cfg->block_size);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_get_chan_info(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *cmd,
+			      u16 cmd_no, void *data_buf,
+			      u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_sta_configure *sta_cfg_cmd = &cmd->params.sta_cfg;
+	struct host_cmd_tlv_channel_band *tlv_band_channel =
+	(struct host_cmd_tlv_channel_band *)sta_cfg_cmd->tlv_buffer;
+
+	cmd->command = cpu_to_le16(HOST_CMD_STA_CONFIGURE);
+	cmd->size = cpu_to_le16(sizeof(*sta_cfg_cmd) +
+				sizeof(*tlv_band_channel) + S_DS_GEN);
+	sta_cfg_cmd->action = cpu_to_le16(cmd_action);
+	memset(tlv_band_channel, 0, sizeof(*tlv_band_channel));
+	tlv_band_channel->header.type = cpu_to_le16(TLV_TYPE_CHANNELBANDLIST);
+	tlv_band_channel->header.len  = cpu_to_le16(sizeof(*tlv_band_channel) -
+					sizeof(struct nxpwifi_ie_types_header));
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_get_chan_info(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp,
+			      u16 cmdresp_no,
+			      void *data_buf)
+{
+	struct host_cmd_ds_sta_configure *sta_cfg_cmd = &resp->params.sta_cfg;
+	struct nxpwifi_channel_band *channel_band =
+		(struct nxpwifi_channel_band *)data_buf;
+	struct host_cmd_tlv_channel_band *tlv_band_channel;
+
+	tlv_band_channel =
+	(struct host_cmd_tlv_channel_band *)sta_cfg_cmd->tlv_buffer;
+	memcpy(&channel_band->band_config, &tlv_band_channel->band_config,
+	       sizeof(struct nxpwifi_band_config));
+	channel_band->channel = tlv_band_channel->channel;
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_chan_region_cfg(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *cmd,
+				u16 cmd_no, void *data_buf,
+				u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_chan_region_cfg *reg = &cmd->params.reg_cfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_CHAN_REGION_CFG);
+	cmd->size = cpu_to_le16(sizeof(*reg) + S_DS_GEN);
+
+	if (cmd_action == HOST_ACT_GEN_GET)
+		reg->action = cpu_to_le16(cmd_action);
+
+	return 0;
+}
+
+static struct ieee80211_regdomain *
+nxpwifi_create_custom_regdomain(struct nxpwifi_private *priv,
+				u8 *buf, u16 buf_len)
+{
+	u16 num_chan = buf_len / 2;
+	struct ieee80211_regdomain *regd;
+	struct ieee80211_reg_rule *rule;
+	bool new_rule;
+	int idx, freq, prev_freq = 0;
+	u32 bw, prev_bw = 0;
+	u8 chflags, prev_chflags = 0, valid_rules = 0;
+
+	if (WARN_ON_ONCE(num_chan > NL80211_MAX_SUPP_REG_RULES))
+		return ERR_PTR(-EINVAL);
+
+	regd = kzalloc(struct_size(regd, reg_rules, num_chan), GFP_KERNEL);
+	if (!regd)
+		return ERR_PTR(-ENOMEM);
+
+	for (idx = 0; idx < num_chan; idx++) {
+		u8 chan;
+		enum nl80211_band band;
+
+		chan = *buf++;
+		if (!chan) {
+			kfree(regd);
+			return NULL;
+		}
+		chflags = *buf++;
+		band = (chan <= 14) ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+		freq = ieee80211_channel_to_frequency(chan, band);
+		new_rule = false;
+
+		if (chflags & NXPWIFI_CHANNEL_DISABLED)
+			continue;
+
+		if (band == NL80211_BAND_5GHZ) {
+			if (!(chflags & NXPWIFI_CHANNEL_NOHT80))
+				bw = MHZ_TO_KHZ(80);
+			else if (!(chflags & NXPWIFI_CHANNEL_NOHT40))
+				bw = MHZ_TO_KHZ(40);
+			else
+				bw = MHZ_TO_KHZ(20);
+		} else {
+			if (!(chflags & NXPWIFI_CHANNEL_NOHT40))
+				bw = MHZ_TO_KHZ(40);
+			else
+				bw = MHZ_TO_KHZ(20);
+		}
+
+		if (idx == 0 || prev_chflags != chflags || prev_bw != bw ||
+		    freq - prev_freq > 20) {
+			valid_rules++;
+			new_rule = true;
+		}
+
+		rule = &regd->reg_rules[valid_rules - 1];
+
+		rule->freq_range.end_freq_khz = MHZ_TO_KHZ(freq + 10);
+
+		prev_chflags = chflags;
+		prev_freq = freq;
+		prev_bw = bw;
+
+		if (!new_rule)
+			continue;
+
+		rule->freq_range.start_freq_khz = MHZ_TO_KHZ(freq - 10);
+		rule->power_rule.max_eirp = DBM_TO_MBM(19);
+
+		if (chflags & NXPWIFI_CHANNEL_PASSIVE)
+			rule->flags = NL80211_RRF_NO_IR;
+
+		if (chflags & NXPWIFI_CHANNEL_DFS)
+			rule->flags = NL80211_RRF_DFS;
+
+		rule->freq_range.max_bandwidth_khz = bw;
+	}
+
+	regd->n_reg_rules = valid_rules;
+	regd->alpha2[0] = '9';
+	regd->alpha2[1] = '9';
+
+	return regd;
+}
+
+static int
+nxpwifi_ret_sta_chan_region_cfg(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *resp,
+				u16 cmdresp_no,
+				void *data_buf)
+{
+	struct host_cmd_ds_chan_region_cfg *reg = &resp->params.reg_cfg;
+	u16 action = le16_to_cpu(reg->action);
+	u16 tlv, tlv_buf_len, tlv_buf_left;
+	struct nxpwifi_ie_types_header *head;
+	struct ieee80211_regdomain *regd;
+	u8 *tlv_buf;
+
+	if (action != HOST_ACT_GEN_GET)
+		return 0;
+
+	tlv_buf = (u8 *)reg + sizeof(*reg);
+	tlv_buf_left = le16_to_cpu(resp->size) - S_DS_GEN - sizeof(*reg);
+
+	while (tlv_buf_left >= sizeof(*head)) {
+		head = (struct nxpwifi_ie_types_header *)tlv_buf;
+		tlv = le16_to_cpu(head->type);
+		tlv_buf_len = le16_to_cpu(head->len);
+
+		if (tlv_buf_left < (sizeof(*head) + tlv_buf_len))
+			break;
+
+		switch (tlv) {
+		case TLV_TYPE_CHAN_ATTR_CFG:
+			nxpwifi_dbg_dump(priv->adapter, CMD_D, "CHAN:",
+					 (u8 *)head + sizeof(*head),
+					 tlv_buf_len);
+			regd = nxpwifi_create_custom_regdomain(priv, (u8 *)head
+							       + sizeof(*head),
+							       tlv_buf_len);
+			if (!IS_ERR(regd))
+				priv->adapter->regd = regd;
+			break;
+		}
+
+		tlv_buf += (sizeof(*head) + tlv_buf_len);
+		tlv_buf_left -= (sizeof(*head) + tlv_buf_len);
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_pkt_aggr_ctrl(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *cmd,
+			      u16 cmd_no, void *data_buf,
+			      u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(cmd_no);
+	cmd->params.pkt_aggr_ctrl.action = cpu_to_le16(cmd_action);
+	cmd->params.pkt_aggr_ctrl.enable = cpu_to_le16(*(u16 *)data_buf);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_pkt_aggr_ctrl) +
+				S_DS_GEN);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_sta_pkt_aggr_ctrl(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp,
+			      u16 cmdresp_no,
+			      void *data_buf)
+{
+	struct host_cmd_ds_pkt_aggr_ctrl *pkt_aggr_ctrl =
+					&resp->params.pkt_aggr_ctrl;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	adapter->bus_aggr.enable = le16_to_cpu(pkt_aggr_ctrl->enable);
+	if (adapter->bus_aggr.enable)
+		adapter->intf_hdr_len = INTF_HEADER_LEN;
+	adapter->bus_aggr.mode = NXPWIFI_BUS_AGGR_MODE_LEN_V2;
+	adapter->bus_aggr.tx_aggr_max_size =
+		le16_to_cpu(pkt_aggr_ctrl->tx_aggr_max_size);
+	adapter->bus_aggr.tx_aggr_max_num =
+		le16_to_cpu(pkt_aggr_ctrl->tx_aggr_max_num);
+	adapter->bus_aggr.tx_aggr_align =
+		le16_to_cpu(pkt_aggr_ctrl->tx_aggr_align);
+
+	return 0;
+}
+
+static int
+nxpwifi_cmd_sta_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd,
+			 u16 cmd_no, void *data_buf,
+			 u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_11ax_cfg(priv, cmd, cmd_action, data_buf);
+}
+
+static int
+nxpwifi_ret_sta_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 u16 cmdresp_no,
+			 void *data_buf)
+{
+	return nxpwifi_ret_11ax_cfg(priv, resp, data_buf);
+}
+
+static int
+nxpwifi_cmd_sta_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd,
+			 u16 cmd_no, void *data_buf,
+			 u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_11ax_cmd(priv, cmd, cmd_action, data_buf);
+}
+
+static int
+nxpwifi_ret_sta_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 u16 cmdresp_no,
+			 void *data_buf)
+{
+	return nxpwifi_ret_11ax_cmd(priv, resp, data_buf);
+}
+
+static int
+nxpwifi_cmd_sta_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd,
+			u16 cmd_no, void *data_buf,
+			u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_twt_cfg(priv, cmd, cmd_action, data_buf);
+}
+
+static int
+nxpwifi_ret_sta_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			u16 cmdresp_no,
+			void *data_buf)
+{
+	return nxpwifi_ret_11ax_cfg(priv, resp, data_buf);
+}
+
+static const struct nxpwifi_cmd_entry cmd_table_sta[] = {
+	{.cmd_no = HOST_CMD_GET_HW_SPEC,
+	.prepare_cmd = nxpwifi_cmd_sta_get_hw_spec,
+	.cmd_resp = nxpwifi_ret_sta_get_hw_spec},
+	{.cmd_no = HOST_CMD_802_11_SCAN,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_scan,
+	.cmd_resp = nxpwifi_ret_sta_802_11_scan},
+	{.cmd_no = HOST_CMD_802_11_GET_LOG,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_get_log,
+	.cmd_resp = nxpwifi_ret_sta_802_11_get_log},
+	{.cmd_no = HOST_CMD_MAC_MULTICAST_ADR,
+	.prepare_cmd = nxpwifi_cmd_sta_mac_multicast_adr,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_802_11_ASSOCIATE,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_associate,
+	.cmd_resp = nxpwifi_ret_sta_802_11_associate},
+	{.cmd_no = HOST_CMD_802_11_SNMP_MIB,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_snmp_mib,
+	.cmd_resp = nxpwifi_ret_sta_802_11_snmp_mib},
+	{.cmd_no = HOST_CMD_MAC_REG_ACCESS,
+	.prepare_cmd = nxpwifi_cmd_sta_reg_access,
+	.cmd_resp = nxpwifi_ret_sta_reg_access},
+	{.cmd_no = HOST_CMD_BBP_REG_ACCESS,
+	.prepare_cmd = nxpwifi_cmd_sta_reg_access,
+	.cmd_resp = nxpwifi_ret_sta_reg_access},
+	{.cmd_no = HOST_CMD_RF_REG_ACCESS,
+	.prepare_cmd = nxpwifi_cmd_sta_reg_access,
+	.cmd_resp = nxpwifi_ret_sta_reg_access},
+	{.cmd_no = HOST_CMD_RF_TX_PWR,
+	.prepare_cmd = nxpwifi_cmd_sta_rf_tx_pwr,
+	.cmd_resp = nxpwifi_ret_sta_rf_tx_pwr},
+	{.cmd_no = HOST_CMD_RF_ANTENNA,
+	.prepare_cmd = nxpwifi_cmd_sta_rf_antenna,
+	.cmd_resp = nxpwifi_ret_sta_rf_antenna},
+	{.cmd_no = HOST_CMD_802_11_DEAUTHENTICATE,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_deauthenticate,
+	.cmd_resp = nxpwifi_ret_sta_802_11_deauthenticate},
+	{.cmd_no = HOST_CMD_MAC_CONTROL,
+	.prepare_cmd = nxpwifi_cmd_sta_mac_control,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_802_11_MAC_ADDRESS,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_mac_address,
+	.cmd_resp = nxpwifi_ret_sta_802_11_mac_address},
+	{.cmd_no = HOST_CMD_802_11_EEPROM_ACCESS,
+	.prepare_cmd = nxpwifi_cmd_sta_reg_access,
+	.cmd_resp = nxpwifi_ret_sta_reg_access},
+	{.cmd_no = HOST_CMD_802_11D_DOMAIN_INFO,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11d_domain_info,
+	.cmd_resp = nxpwifi_ret_sta_802_11d_domain_info},
+	{.cmd_no = HOST_CMD_802_11_KEY_MATERIAL,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_key_material,
+	.cmd_resp = nxpwifi_ret_sta_802_11_key_material},
+	{.cmd_no = HOST_CMD_802_11_BG_SCAN_CONFIG,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_bg_scan_config,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_802_11_BG_SCAN_QUERY,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_bg_scan_query,
+	.cmd_resp = nxpwifi_ret_sta_802_11_bg_scan_query},
+	{.cmd_no = HOST_CMD_WMM_GET_STATUS,
+	.prepare_cmd = nxpwifi_cmd_sta_wmm_get_status,
+	.cmd_resp = nxpwifi_ret_sta_wmm_get_status},
+	{.cmd_no = HOST_CMD_802_11_SUBSCRIBE_EVENT,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_subsc_evt,
+	.cmd_resp = nxpwifi_ret_sta_subsc_evt},
+	{.cmd_no = HOST_CMD_802_11_TX_RATE_QUERY,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_tx_rate_query,
+	.cmd_resp = nxpwifi_ret_sta_802_11_tx_rate_query},
+	{.cmd_no = HOST_CMD_MEM_ACCESS,
+	.prepare_cmd = nxpwifi_cmd_sta_mem_access,
+	.cmd_resp = nxpwifi_ret_sta_mem_access},
+	{.cmd_no = HOST_CMD_CFG_DATA,
+	.prepare_cmd = nxpwifi_cmd_sta_cfg_data,
+	.cmd_resp = nxpwifi_ret_sta_cfg_data},
+	{.cmd_no = HOST_CMD_VERSION_EXT,
+	.prepare_cmd = nxpwifi_cmd_sta_ver_ext,
+	.cmd_resp = nxpwifi_ret_sta_ver_ext},
+	{.cmd_no = HOST_CMD_MEF_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_mef_cfg,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_RSSI_INFO,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_rssi_info,
+	.cmd_resp = nxpwifi_ret_sta_802_11_rssi_info},
+	{.cmd_no = HOST_CMD_FUNC_INIT,
+	.prepare_cmd = nxpwifi_cmd_sta_func_init,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_FUNC_SHUTDOWN,
+	.prepare_cmd = nxpwifi_cmd_sta_func_shutdown,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_PMIC_REG_ACCESS,
+	.prepare_cmd = nxpwifi_cmd_sta_reg_access,
+	.cmd_resp = nxpwifi_ret_sta_reg_access},
+	{.cmd_no = HOST_CMD_11N_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_11n_cfg,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_11N_ADDBA_REQ,
+	.prepare_cmd = nxpwifi_cmd_sta_11n_addba_req,
+	.cmd_resp = nxpwifi_ret_sta_11n_addba_req},
+	{.cmd_no = HOST_CMD_11N_ADDBA_RSP,
+	.prepare_cmd = nxpwifi_cmd_sta_11n_addba_rsp,
+	.cmd_resp = nxpwifi_ret_sta_11n_addba_rsp},
+	{.cmd_no = HOST_CMD_11N_DELBA,
+	.prepare_cmd = nxpwifi_cmd_sta_11n_delba,
+	.cmd_resp = nxpwifi_ret_sta_11n_delba},
+	{.cmd_no = HOST_CMD_TXPWR_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_tx_power_cfg,
+	.cmd_resp = nxpwifi_ret_sta_tx_power_cfg},
+	{.cmd_no = HOST_CMD_TX_RATE_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_tx_rate_cfg,
+	.cmd_resp = nxpwifi_ret_sta_tx_rate_cfg},
+	{.cmd_no = HOST_CMD_RECONFIGURE_TX_BUFF,
+	.prepare_cmd = nxpwifi_cmd_sta_reconfigure_rx_buff,
+	.cmd_resp = nxpwifi_ret_sta_reconfigure_rx_buff},
+	{.cmd_no = HOST_CMD_CHAN_REPORT_REQUEST,
+	.prepare_cmd = nxpwifi_cmd_sta_chan_report_request,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_AMSDU_AGGR_CTRL,
+	.prepare_cmd = nxpwifi_cmd_sta_amsdu_aggr_ctrl,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_ROBUST_COEX,
+	.prepare_cmd = nxpwifi_cmd_sta_robust_coex,
+	.cmd_resp = nxpwifi_ret_sta_robust_coex},
+	{.cmd_no = HOST_CMD_802_11_PS_MODE_ENH,
+	.prepare_cmd = nxpwifi_cmd_sta_enh_power_mode,
+	.cmd_resp = nxpwifi_ret_sta_enh_power_mode},
+	{.cmd_no = HOST_CMD_802_11_HS_CFG_ENH,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_hs_cfg,
+	.cmd_resp = nxpwifi_ret_sta_802_11_hs_cfg},
+	{.cmd_no = HOST_CMD_CAU_REG_ACCESS,
+	.prepare_cmd = nxpwifi_cmd_sta_reg_access,
+	.cmd_resp = nxpwifi_ret_sta_reg_access},
+	{.cmd_no = HOST_CMD_SET_BSS_MODE,
+	.prepare_cmd = nxpwifi_cmd_sta_set_bss_mode,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_802_11_NET_MONITOR,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_net_monitor,
+	.cmd_resp = nxpwifi_ret_sta_802_11_net_monitor},
+	{.cmd_no = HOST_CMD_802_11_SCAN_EXT,
+	.prepare_cmd = nxpwifi_cmd_sta_802_11_scan_ext,
+	.cmd_resp = nxpwifi_ret_sta_802_11_scan_ext},
+	{.cmd_no = HOST_CMD_COALESCE_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_coalesce_cfg,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_MGMT_FRAME_REG,
+	.prepare_cmd = nxpwifi_cmd_sta_mgmt_frame_reg,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_REMAIN_ON_CHAN,
+	.prepare_cmd = nxpwifi_cmd_sta_remain_on_chan,
+	.cmd_resp = nxpwifi_ret_sta_remain_on_chan},
+	{.cmd_no = HOST_CMD_GTK_REKEY_OFFLOAD_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_gtk_rekey_offload,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_11AC_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_11ac_cfg,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_HS_WAKEUP_REASON,
+	.prepare_cmd = nxpwifi_cmd_sta_hs_wakeup_reason,
+	.cmd_resp = nxpwifi_ret_sta_hs_wakeup_reason},
+	{.cmd_no = HOST_CMD_MC_POLICY,
+	.prepare_cmd = nxpwifi_cmd_sta_mc_policy,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_FW_DUMP_EVENT,
+	.prepare_cmd = nxpwifi_cmd_fill_head_only,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_SDIO_SP_RX_AGGR_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_sdio_rx_aggr_cfg,
+	.cmd_resp = nxpwifi_ret_sta_sdio_rx_aggr_cfg},
+	{.cmd_no = HOST_CMD_STA_CONFIGURE,
+	.prepare_cmd = nxpwifi_cmd_sta_get_chan_info,
+	.cmd_resp = nxpwifi_ret_sta_get_chan_info},
+	{.cmd_no = HOST_CMD_CHAN_REGION_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_chan_region_cfg,
+	.cmd_resp = nxpwifi_ret_sta_chan_region_cfg},
+	{.cmd_no = HOST_CMD_PACKET_AGGR_CTRL,
+	.prepare_cmd = nxpwifi_cmd_sta_pkt_aggr_ctrl,
+	.cmd_resp = nxpwifi_ret_sta_pkt_aggr_ctrl},
+	{.cmd_no = HOST_CMD_11AX_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_11ax_cfg,
+	.cmd_resp = nxpwifi_ret_sta_11ax_cfg},
+	{.cmd_no = HOST_CMD_11AX_CMD,
+	.prepare_cmd = nxpwifi_cmd_sta_11ax_cmd,
+	.cmd_resp = nxpwifi_ret_sta_11ax_cmd},
+	{.cmd_no = HOST_CMD_TWT_CFG,
+	.prepare_cmd = nxpwifi_cmd_sta_twt_cfg,
+	.cmd_resp = nxpwifi_ret_sta_twt_cfg},
+};
+
+/* This function prepares the commands before sending them to the firmware.
+ *
+ * This is a generic function which calls specific command preparation
+ * routines based upon the command number.
+ */
+int nxpwifi_sta_prepare_cmd(struct nxpwifi_private *priv,
+			    struct cmd_ctrl_node *cmd_node,
+			    u16 cmd_action, u32 cmd_oid)
+
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 cmd_no = cmd_node->cmd_no;
+	struct host_cmd_ds_command *cmd =
+		(struct host_cmd_ds_command *)cmd_node->skb->data;
+	void *data_buf = cmd_node->data_buf;
+	int i, ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(cmd_table_sta); i++) {
+		if (cmd_no == cmd_table_sta[i].cmd_no) {
+			if (cmd_table_sta[i].prepare_cmd)
+				ret = cmd_table_sta[i].prepare_cmd(priv, cmd,
+								   cmd_no,
+								   data_buf,
+								   cmd_action,
+								   cmd_oid);
+			cmd_node->cmd_resp = cmd_table_sta[i].cmd_resp;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(cmd_table_sta))
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: unknown command: %#x\n",
+			    __func__, cmd_no);
+	else
+		nxpwifi_dbg(adapter, CMD,
+			    "%s: command: %#x\n",
+			    __func__, cmd_no);
+
+	return ret;
+}
+
+int nxpwifi_dnld_dt_cfgdata(struct nxpwifi_private *priv,
+			    struct device_node *node, const char *prefix)
+{
+#ifdef CONFIG_OF
+	struct property *prop;
+	size_t len = strlen(prefix);
+	int ret;
+
+	/* look for all matching property names */
+	for_each_property_of_node(node, prop) {
+		if (len > strlen(prop->name) ||
+		    strncmp(prop->name, prefix, len))
+			continue;
+
+		/* property header is 6 bytes, data must fit in cmd buffer */
+		if (prop->value && prop->length > 6 &&
+		    prop->length <= NXPWIFI_SIZE_OF_CMD_BUFFER - S_DS_GEN) {
+			ret = nxpwifi_send_cmd(priv, HOST_CMD_CFG_DATA,
+					       HOST_ACT_GEN_SET, 0,
+					       prop, true);
+			if (ret)
+				return ret;
+		}
+	}
+#endif
+	return 0;
+}
+
+/* This function issues commands to initialize firmware.
+ *
+ * This is called after firmware download to bring the card to
+ * working state.
+ * Function is also called during reinitialization of virtual
+ * interfaces.
+ */
+int nxpwifi_sta_init_cmd(struct nxpwifi_private *priv, u8 first_sta, bool init)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+	struct nxpwifi_ds_11n_amsdu_aggr_ctrl amsdu_aggr_ctrl;
+	struct nxpwifi_ds_auto_ds auto_ds;
+	enum state_11d_t state_11d;
+	struct nxpwifi_ds_11n_tx_cfg tx_cfg;
+	u8 sdio_sp_rx_aggr_enable;
+	int data;
+
+	if (first_sta) {
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_FUNC_INIT,
+				       HOST_ACT_GEN_SET, 0, NULL, true);
+		if (ret)
+			return ret;
+
+		/* Download calibration data to firmware.
+		 * The cal-data can be read from device tree and/or
+		 * a configuration file and downloaded to firmware.
+		 */
+		if (adapter->dt_node) {
+			if (of_property_read_u32(adapter->dt_node,
+						 "nxp,wakeup-pin",
+						 &data) == 0) {
+				pr_debug("Wakeup pin = 0x%x\n", data);
+				adapter->hs_cfg.gpio = data;
+			}
+
+			nxpwifi_dnld_dt_cfgdata(priv, adapter->dt_node,
+						"nxp,caldata");
+		}
+
+		if (adapter->cal_data)
+			nxpwifi_send_cmd(priv, HOST_CMD_CFG_DATA,
+					 HOST_ACT_GEN_SET, 0, NULL, true);
+
+		/* Read MAC address from HW */
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_GET_HW_SPEC,
+				       HOST_ACT_GEN_GET, 0, NULL, true);
+		if (ret)
+			return ret;
+
+		/** Set SDIO Single Port RX Aggr Info */
+		if (priv->adapter->iface_type == NXPWIFI_SDIO &&
+		    ISSUPP_SDIO_SPA_ENABLED(priv->adapter->fw_cap_info) &&
+		    !priv->adapter->host_disable_sdio_rx_aggr) {
+			sdio_sp_rx_aggr_enable = true;
+			ret = nxpwifi_send_cmd(priv,
+					       HOST_CMD_SDIO_SP_RX_AGGR_CFG,
+					       HOST_ACT_GEN_SET, 0,
+					       &sdio_sp_rx_aggr_enable,
+					       true);
+			if (ret) {
+				nxpwifi_dbg(priv->adapter, ERROR,
+					    "error while enabling SP aggregation..disable it");
+				adapter->sdio_rx_aggr_enable = false;
+			}
+		}
+
+		/* Reconfigure tx buf size */
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_RECONFIGURE_TX_BUFF,
+				       HOST_ACT_GEN_SET, 0,
+				       &priv->adapter->tx_buf_size, true);
+		if (ret)
+			return ret;
+
+		if (priv->bss_type != NXPWIFI_BSS_TYPE_UAP) {
+			/* Enable IEEE PS by default */
+			priv->adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_PSP;
+			ret = nxpwifi_send_cmd(priv,
+					       HOST_CMD_802_11_PS_MODE_ENH,
+					       EN_AUTO_PS, BITMAP_STA_PS, NULL,
+					       true);
+			if (ret)
+				return ret;
+		}
+
+		nxpwifi_send_cmd(priv, HOST_CMD_CHAN_REGION_CFG,
+				 HOST_ACT_GEN_GET, 0, NULL, true);
+	}
+
+	/* get tx rate */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TX_RATE_CFG,
+			       HOST_ACT_GEN_GET, 0, NULL, true);
+	if (ret)
+		return ret;
+	priv->data_rate = 0;
+
+	/* get tx power */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_RF_TX_PWR,
+			       HOST_ACT_GEN_GET, 0, NULL, true);
+	if (ret)
+		return ret;
+
+	memset(&amsdu_aggr_ctrl, 0, sizeof(amsdu_aggr_ctrl));
+	amsdu_aggr_ctrl.enable = true;
+	/* Send request to firmware */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_AMSDU_AGGR_CTRL,
+			       HOST_ACT_GEN_SET, 0,
+			       &amsdu_aggr_ctrl, true);
+	if (ret)
+		return ret;
+	/* MAC Control must be the last command in init_fw */
+	/* set MAC Control */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_MAC_CONTROL,
+			       HOST_ACT_GEN_SET, 0,
+			       &priv->curr_pkt_filter, true);
+	if (ret)
+		return ret;
+
+	if (!disable_auto_ds && first_sta &&
+	    priv->bss_type != NXPWIFI_BSS_TYPE_UAP) {
+		/* Enable auto deep sleep */
+		auto_ds.auto_ds = DEEP_SLEEP_ON;
+		auto_ds.idle_time = DEEP_SLEEP_IDLE_TIME;
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_PS_MODE_ENH,
+				       EN_AUTO_PS, BITMAP_AUTO_DS,
+				       &auto_ds, true);
+		if (ret)
+			return ret;
+	}
+
+	if (priv->bss_type != NXPWIFI_BSS_TYPE_UAP) {
+		/* Send cmd to FW to enable/disable 11D function */
+		state_11d = ENABLE_11D;
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_SNMP_MIB,
+				       HOST_ACT_GEN_SET, DOT11D_I,
+				       &state_11d, true);
+		if (ret)
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "11D: failed to enable 11D\n");
+	}
+
+	/* Send cmd to FW to configure 11n specific configuration
+	 * (Short GI, Channel BW, Green field support etc.) for transmit
+	 */
+	tx_cfg.tx_htcap = NXPWIFI_FW_DEF_HTTXCFG;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_11N_CFG,
+			       HOST_ACT_GEN_SET, 0, &tx_cfg, true);
+
+	if (init) {
+		/* set last_init_cmd before sending the command */
+		priv->adapter->last_init_cmd = HOST_CMD_11N_CFG;
+		ret = -EINPROGRESS;
+	}
+
+	return ret;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_event.c b/drivers/net/wireless/nxp/nxpwifi/sta_event.c
new file mode 100644
index 000000000000..a67486b2ae65
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_event.c
@@ -0,0 +1,868 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station event handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+
+static int
+nxpwifi_sta_event_link_lost(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	adapter->dbg.num_event_link_lost++;
+	if (priv->media_connected) {
+		adapter->priv_link_lost = priv;
+		adapter->host_mlme_link_lost = true;
+		nxpwifi_queue_wiphy_work(adapter,
+					 &adapter->host_mlme_work);
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_link_sensed(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	netif_carrier_on(priv->netdev);
+	nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_deauthenticated(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (priv->wps.session_enable) {
+		nxpwifi_dbg(adapter, INFO,
+			    "info: receive deauth event in wps session\n");
+	} else {
+		adapter->dbg.num_event_deauth++;
+		if (priv->media_connected) {
+			priv->last_deauth_reason =
+				get_unaligned_le16(priv->adapter->event_body);
+			nxpwifi_queue_wiphy_work(priv->adapter,
+						 &priv->reset_conn_state_work);
+		}
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_disassociated(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (priv->wps.session_enable) {
+		nxpwifi_dbg(adapter, INFO,
+			    "info: receive disassoc event in wps session\n");
+	} else {
+		adapter->dbg.num_event_disassoc++;
+		if (priv->media_connected) {
+			priv->last_deauth_reason =
+				get_unaligned_le16(priv->adapter->event_body);
+			nxpwifi_queue_wiphy_work(priv->adapter,
+						 &priv->reset_conn_state_work);
+		}
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_ps_awake(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (!adapter->pps_uapsd_mode &&
+	    priv->port_open &&
+	    priv->media_connected && adapter->sleep_period.period) {
+		adapter->pps_uapsd_mode = true;
+		nxpwifi_dbg(adapter, EVENT,
+			    "event: PPS/UAPSD mode activated\n");
+	}
+	adapter->tx_lock_flag = false;
+	if (adapter->pps_uapsd_mode && adapter->gen_null_pkt) {
+		if (nxpwifi_check_last_packet_indication(priv)) {
+			if (adapter->data_sent) {
+				adapter->ps_state = PS_STATE_AWAKE;
+				adapter->pm_wakeup_card_req = false;
+				adapter->pm_wakeup_fw_try = false;
+				del_timer(&adapter->wakeup_timer);
+			} else {
+				if (!nxpwifi_send_null_packet
+				    (priv,
+				     NXPWIFI_TxPD_POWER_MGMT_NULL_PACKET |
+				     NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET))
+					adapter->ps_state = PS_STATE_SLEEP;
+			}
+
+			return 0;
+		}
+	}
+
+	adapter->ps_state = PS_STATE_AWAKE;
+	adapter->pm_wakeup_card_req = false;
+	adapter->pm_wakeup_fw_try = false;
+	del_timer(&adapter->wakeup_timer);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_ps_sleep(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	adapter->ps_state = PS_STATE_PRE_SLEEP;
+	nxpwifi_check_ps_cond(adapter);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_mic_err_multicast(struct nxpwifi_private *priv)
+{
+	cfg80211_michael_mic_failure(priv->netdev, priv->cfg_bssid,
+				     NL80211_KEYTYPE_GROUP,
+				     -1, NULL, GFP_KERNEL);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_mic_err_unicast(struct nxpwifi_private *priv)
+{
+	cfg80211_michael_mic_failure(priv->netdev, priv->cfg_bssid,
+				     NL80211_KEYTYPE_PAIRWISE,
+				     -1, NULL, GFP_KERNEL);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_deep_sleep_awake(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	adapter->if_ops.wakeup_complete(adapter);
+	if (adapter->is_deep_sleep)
+		adapter->is_deep_sleep = false;
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_wmm_status_change(struct nxpwifi_private *priv)
+{
+	return nxpwifi_send_cmd(priv, HOST_CMD_WMM_GET_STATUS,
+				0, 0, NULL, false);
+}
+
+static int
+nxpwifi_sta_event_bs_scan_report(struct nxpwifi_private *priv)
+{
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_BG_SCAN_QUERY,
+				HOST_ACT_GEN_GET, 0, NULL, false);
+}
+
+static int
+nxpwifi_sta_event_rssi_low(struct nxpwifi_private *priv)
+{
+	cfg80211_cqm_rssi_notify(priv->netdev,
+				 NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW,
+				 0, GFP_KERNEL);
+	priv->subsc_evt_rssi_state = RSSI_LOW_RECVD;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_RSSI_INFO,
+				HOST_ACT_GEN_GET, 0, NULL, false);
+}
+
+static int
+nxpwifi_sta_event_rssi_high(struct nxpwifi_private *priv)
+{
+	cfg80211_cqm_rssi_notify(priv->netdev,
+				 NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH,
+				 0, GFP_KERNEL);
+	priv->subsc_evt_rssi_state = RSSI_HIGH_RECVD;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_RSSI_INFO,
+				HOST_ACT_GEN_GET, 0, NULL, false);
+}
+
+static int
+nxpwifi_sta_event_port_release(struct nxpwifi_private *priv)
+{
+	priv->port_open = true;
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_addba(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_11N_ADDBA_RSP,
+				HOST_ACT_GEN_SET, 0,
+				adapter->event_body, false);
+}
+
+static int
+nxpwifi_sta_event_delba(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_11n_delete_ba_stream(priv, adapter->event_body);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_bs_stream_timeout(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_11n_batimeout *event =
+		(struct host_cmd_ds_11n_batimeout *)adapter->event_body;
+
+	nxpwifi_11n_ba_stream_timeout(priv, event);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_amsdu_aggr_ctrl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 ctrl;
+
+	ctrl = get_unaligned_le16(adapter->event_body);
+	adapter->tx_buf_size = min_t(u16, adapter->curr_tx_buf_size, ctrl);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_hs_act_req(struct nxpwifi_private *priv)
+{
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_HS_CFG_ENH,
+				0, 0, NULL, false);
+}
+
+static int
+nxpwifi_sta_event_channel_switch_ann(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_bssdescriptor *bss_desc;
+
+	bss_desc = &priv->curr_bss_params.bss_descriptor;
+	priv->csa_expire_time = jiffies + msecs_to_jiffies(DFS_CHAN_MOVE_TIME);
+	priv->csa_chan = bss_desc->channel;
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_DEAUTHENTICATE,
+				HOST_ACT_GEN_SET, 0,
+				bss_desc->mac_address, false);
+}
+
+static int
+nxpwifi_sta_event_radar_detected(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	return nxpwifi_11h_handle_radar_detected(priv, adapter->event_skb);
+}
+
+static int
+nxpwifi_sta_event_channel_report_rdy(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	return nxpwifi_11h_handle_chanrpt_ready(priv, adapter->event_skb);
+}
+
+static int
+nxpwifi_sta_event_tx_data_pause(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_process_tx_pause_event(priv, adapter->event_skb);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_ext_scan_report(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	void *buf = adapter->event_skb->data;
+	int ret = 0;
+
+	/* We intend to skip this event during suspend, but handle
+	 * it in interface disabled case
+	 */
+	if (adapter->ext_scan && (!priv->scan_aborting ||
+				  !netif_running(priv->netdev)))
+		ret = nxpwifi_handle_event_ext_scan_report(priv, buf);
+
+	return ret;
+}
+
+static int
+nxpwifi_sta_event_rxba_sync(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_11n_rxba_sync_event(priv, adapter->event_body,
+				    adapter->event_skb->len -
+				    sizeof(adapter->event_cause));
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_remain_on_chan_expired(struct nxpwifi_private *priv)
+{
+	if (priv->auth_flag & HOST_MLME_AUTH_PENDING) {
+		priv->auth_flag = 0;
+		priv->auth_alg = WLAN_AUTH_NONE;
+	} else {
+		cfg80211_remain_on_channel_expired(&priv->wdev,
+						   priv->roc_cfg.cookie,
+						   &priv->roc_cfg.chan,
+						   GFP_ATOMIC);
+	}
+
+	memset(&priv->roc_cfg, 0x00, sizeof(struct nxpwifi_roc_cfg));
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_bg_scan_stopped(struct nxpwifi_private *priv)
+{
+	cfg80211_sched_scan_stopped(priv->wdev.wiphy, 0);
+	if (priv->sched_scanning)
+		priv->sched_scanning = false;
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_multi_chan_info(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_process_multi_chan_event(priv, adapter->event_skb);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_tx_status_report(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_parse_tx_status_event(priv, adapter->event_body);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_bt_coex_wlan_para_change(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (!adapter->ignore_btcoex_events)
+		nxpwifi_bt_coex_wlan_param_update_event(priv,
+							adapter->event_skb);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_vdll_ind(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	return nxpwifi_process_vdll_event(priv, adapter->event_skb);
+}
+
+static const struct nxpwifi_evt_entry evt_table_sta[] = {
+	{.event_cause = EVENT_LINK_LOST,
+	.event_handler = nxpwifi_sta_event_link_lost},
+	{.event_cause = EVENT_LINK_SENSED,
+	.event_handler = nxpwifi_sta_event_link_sensed},
+	{.event_cause = EVENT_DEAUTHENTICATED,
+	.event_handler = nxpwifi_sta_event_deauthenticated},
+	{.event_cause = EVENT_DISASSOCIATED,
+	.event_handler = nxpwifi_sta_event_disassociated},
+	{.event_cause = EVENT_PS_AWAKE,
+	.event_handler = nxpwifi_sta_event_ps_awake},
+	{.event_cause = EVENT_PS_SLEEP,
+	.event_handler = nxpwifi_sta_event_ps_sleep},
+	{.event_cause = EVENT_MIC_ERR_MULTICAST,
+	.event_handler = nxpwifi_sta_event_mic_err_multicast},
+	{.event_cause = EVENT_MIC_ERR_UNICAST,
+	.event_handler = nxpwifi_sta_event_mic_err_unicast},
+	{.event_cause = EVENT_DEEP_SLEEP_AWAKE,
+	.event_handler = nxpwifi_sta_event_deep_sleep_awake},
+	{.event_cause = EVENT_WMM_STATUS_CHANGE,
+	.event_handler = nxpwifi_sta_event_wmm_status_change},
+	{.event_cause = EVENT_BG_SCAN_REPORT,
+	.event_handler = nxpwifi_sta_event_bs_scan_report},
+	{.event_cause = EVENT_RSSI_LOW,
+	.event_handler = nxpwifi_sta_event_rssi_low},
+	{.event_cause = EVENT_RSSI_HIGH,
+	.event_handler = nxpwifi_sta_event_rssi_high},
+	{.event_cause = EVENT_PORT_RELEASE,
+	.event_handler = nxpwifi_sta_event_port_release},
+	{.event_cause = EVENT_ADDBA,
+	.event_handler = nxpwifi_sta_event_addba},
+	{.event_cause = EVENT_DELBA,
+	.event_handler = nxpwifi_sta_event_delba},
+	{.event_cause = EVENT_BA_STREAM_TIEMOUT,
+	.event_handler = nxpwifi_sta_event_bs_stream_timeout},
+	{.event_cause = EVENT_AMSDU_AGGR_CTRL,
+	.event_handler = nxpwifi_sta_event_amsdu_aggr_ctrl},
+	{.event_cause = EVENT_HS_ACT_REQ,
+	.event_handler = nxpwifi_sta_event_hs_act_req},
+	{.event_cause = EVENT_CHANNEL_SWITCH_ANN,
+	.event_handler = nxpwifi_sta_event_channel_switch_ann},
+	{.event_cause = EVENT_RADAR_DETECTED,
+	.event_handler = nxpwifi_sta_event_radar_detected},
+	{.event_cause = EVENT_CHANNEL_REPORT_RDY,
+	.event_handler = nxpwifi_sta_event_channel_report_rdy},
+	{.event_cause = EVENT_TX_DATA_PAUSE,
+	.event_handler = nxpwifi_sta_event_tx_data_pause},
+	{.event_cause = EVENT_EXT_SCAN_REPORT,
+	.event_handler = nxpwifi_sta_event_ext_scan_report},
+	{.event_cause = EVENT_RXBA_SYNC,
+	.event_handler = nxpwifi_sta_event_rxba_sync},
+	{.event_cause = EVENT_REMAIN_ON_CHAN_EXPIRED,
+	.event_handler = nxpwifi_sta_event_remain_on_chan_expired},
+	{.event_cause = EVENT_BG_SCAN_STOPPED,
+	.event_handler = nxpwifi_sta_event_bg_scan_stopped},
+	{.event_cause = EVENT_MULTI_CHAN_INFO,
+	.event_handler = nxpwifi_sta_event_multi_chan_info},
+	{.event_cause = EVENT_TX_STATUS_REPORT,
+	.event_handler = nxpwifi_sta_event_tx_status_report},
+	{.event_cause = EVENT_BT_COEX_WLAN_PARA_CHANGE,
+	.event_handler = nxpwifi_sta_event_bt_coex_wlan_para_change},
+	{.event_cause = EVENT_VDLL_IND,
+	.event_handler = nxpwifi_sta_event_vdll_ind},
+	{.event_cause = EVENT_DUMMY_HOST_WAKEUP_SIGNAL,
+	.event_handler = NULL},
+	{.event_cause = EVENT_MIB_CHANGED,
+	.event_handler = NULL},
+	{.event_cause = EVENT_INIT_DONE,
+	.event_handler = NULL},
+	{.event_cause = EVENT_SNR_LOW,
+	.event_handler = NULL},
+	{.event_cause = EVENT_MAX_FAIL,
+	.event_handler = NULL},
+	{.event_cause = EVENT_SNR_HIGH,
+	.event_handler = NULL},
+	{.event_cause = EVENT_DATA_RSSI_LOW,
+	.event_handler = NULL},
+	{.event_cause = EVENT_DATA_SNR_LOW,
+	.event_handler = NULL},
+	{.event_cause = EVENT_DATA_RSSI_HIGH,
+	.event_handler = NULL},
+	{.event_cause = EVENT_DATA_SNR_HIGH,
+	.event_handler = NULL},
+	{.event_cause = EVENT_LINK_QUALITY,
+	.event_handler = NULL},
+	{.event_cause = EVENT_PRE_BEACON_LOST,
+	.event_handler = NULL},
+	{.event_cause = EVENT_WEP_ICV_ERR,
+	.event_handler = NULL},
+	{.event_cause = EVENT_BW_CHANGE,
+	.event_handler = NULL},
+	{.event_cause = EVENT_HOSTWAKE_STAIE,
+	.event_handler = NULL},
+	{.event_cause = EVENT_UNKNOWN_DEBUG,
+	.event_handler = NULL},
+};
+
+static void nxpwifi_process_uap_tx_pause(struct nxpwifi_private *priv,
+					 struct nxpwifi_ie_types_header *tlv)
+{
+	struct nxpwifi_tx_pause_tlv *tp;
+	struct nxpwifi_sta_node *sta_ptr;
+
+	tp = (void *)tlv;
+	nxpwifi_dbg(priv->adapter, EVENT,
+		    "uap tx_pause: %pM pause=%d, pkts=%d\n",
+		    tp->peermac, tp->tx_pause,
+		    tp->pkt_cnt);
+
+	if (ether_addr_equal(tp->peermac, priv->netdev->dev_addr)) {
+		if (tp->tx_pause)
+			priv->port_open = false;
+		else
+			priv->port_open = true;
+	} else if (is_multicast_ether_addr(tp->peermac)) {
+		nxpwifi_update_ralist_tx_pause(priv, tp->peermac, tp->tx_pause);
+	} else {
+		rcu_read_lock();
+		sta_ptr = nxpwifi_get_sta_entry(priv, tp->peermac);
+		if (sta_ptr && sta_ptr->tx_pause != tp->tx_pause) {
+			sta_ptr->tx_pause = tp->tx_pause;
+			nxpwifi_update_ralist_tx_pause(priv, tp->peermac,
+						       tp->tx_pause);
+		}
+		rcu_read_unlock();
+	}
+}
+
+static void nxpwifi_process_sta_tx_pause(struct nxpwifi_private *priv,
+					 struct nxpwifi_ie_types_header *tlv)
+{
+	struct nxpwifi_tx_pause_tlv *tp;
+
+	tp = (void *)tlv;
+	nxpwifi_dbg(priv->adapter, EVENT,
+		    "sta tx_pause: %pM pause=%d, pkts=%d\n",
+		    tp->peermac, tp->tx_pause,
+		    tp->pkt_cnt);
+
+	if (ether_addr_equal(tp->peermac, priv->cfg_bssid)) {
+		if (tp->tx_pause)
+			priv->port_open = false;
+		else
+			priv->port_open = true;
+	}
+}
+
+/* This function resets the connection state.
+ *
+ * The function is invoked after receiving a disconnect event from firmware,
+ * and performs the following actions -
+ *      - Set media status to disconnected
+ *      - Clean up Tx and Rx packets
+ *      - Resets SNR/NF/RSSI value in driver
+ *      - Resets security configurations in driver
+ *      - Enables auto data rate
+ *      - Saves the previous SSID and BSSID so that they can
+ *        be used for re-association, if required
+ *      - Erases current SSID and BSSID information
+ *      - Sends a disconnect event to upper layers/applications.
+ */
+void nxpwifi_reset_connect_state(struct nxpwifi_private *priv, u16 reason_code,
+				 bool from_ap)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (!priv->media_connected)
+		return;
+
+	nxpwifi_dbg(adapter, INFO,
+		    "info: handles disconnect event\n");
+
+	priv->media_connected = false;
+
+	priv->auth_flag = 0;
+	priv->auth_alg = WLAN_AUTH_NONE;
+
+	priv->scan_block = false;
+	priv->port_open = false;
+
+	/* Free Tx and Rx packets, report disconnect to upper layer */
+	nxpwifi_clean_txrx(priv);
+
+	/* Reset SNR/NF/RSSI values */
+	priv->data_rssi_last = 0;
+	priv->data_nf_last = 0;
+	priv->data_rssi_avg = 0;
+	priv->data_nf_avg = 0;
+	priv->bcn_rssi_last = 0;
+	priv->bcn_nf_last = 0;
+	priv->bcn_rssi_avg = 0;
+	priv->bcn_nf_avg = 0;
+	priv->rxpd_rate = 0;
+	priv->rxpd_htinfo = 0;
+	priv->sec_info.wpa_enabled = false;
+	priv->sec_info.wpa2_enabled = false;
+	priv->wpa_ie_len = 0;
+
+	priv->sec_info.encryption_mode = 0;
+
+	/* Enable auto data rate */
+	priv->is_data_rate_auto = true;
+	priv->data_rate = 0;
+
+	priv->assoc_resp_ht_param = 0;
+	priv->ht_param_present = false;
+
+	if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA ||
+	     GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) && priv->hist_data)
+		nxpwifi_hist_data_reset(priv);
+
+	/* Memorize the previous SSID and BSSID so
+	 * it could be used for re-assoc
+	 */
+
+	nxpwifi_dbg(adapter, INFO,
+		    "info: previous SSID=%s, SSID len=%u\n",
+		    priv->prev_ssid.ssid, priv->prev_ssid.ssid_len);
+
+	nxpwifi_dbg(adapter, INFO,
+		    "info: current SSID=%s, SSID len=%u\n",
+		    priv->curr_bss_params.bss_descriptor.ssid.ssid,
+		    priv->curr_bss_params.bss_descriptor.ssid.ssid_len);
+
+	memcpy(&priv->prev_ssid,
+	       &priv->curr_bss_params.bss_descriptor.ssid,
+	       sizeof(struct cfg80211_ssid));
+
+	memcpy(priv->prev_bssid,
+	       priv->curr_bss_params.bss_descriptor.mac_address, ETH_ALEN);
+
+	/* Need to erase the current SSID and BSSID info */
+	memset(&priv->curr_bss_params, 0x00, sizeof(priv->curr_bss_params));
+
+	adapter->tx_lock_flag = false;
+	adapter->pps_uapsd_mode = false;
+
+	if (test_bit(NXPWIFI_IS_CMD_TIMEDOUT, &adapter->work_flags) &&
+	    adapter->curr_cmd)
+		return;
+
+	priv->media_connected = false;
+	nxpwifi_dbg(adapter, MSG,
+		    "info: successfully disconnected from %pM: reason code %d\n",
+		    priv->cfg_bssid, reason_code);
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+		if (adapter->host_mlme_link_lost)
+			nxpwifi_host_mlme_disconnect(adapter->priv_link_lost,
+						     reason_code, NULL);
+		else
+			cfg80211_disconnected(priv->netdev, reason_code, NULL,
+					      0, !from_ap, GFP_KERNEL);
+	}
+	eth_zero_addr(priv->cfg_bssid);
+
+	nxpwifi_stop_net_dev_queue(priv->netdev, adapter);
+	netif_carrier_off(priv->netdev);
+
+	if (!ISSUPP_FIRMWARE_SUPPLICANT(priv->adapter->fw_cap_info))
+		return;
+
+	nxpwifi_send_cmd(priv, HOST_CMD_GTK_REKEY_OFFLOAD_CFG,
+			 HOST_ACT_GEN_REMOVE, 0, NULL, false);
+}
+
+void nxpwifi_reset_conn_state_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct nxpwifi_private *priv = container_of(work,
+						    struct nxpwifi_private,
+						    reset_conn_state_work);
+
+	nxpwifi_reset_connect_state(priv, priv->last_deauth_reason, true);
+}
+
+void nxpwifi_process_multi_chan_event(struct nxpwifi_private *priv,
+				      struct sk_buff *event_skb)
+{
+	struct nxpwifi_ie_types_multi_chan_info *chan_info;
+	struct nxpwifi_ie_types_mc_group_info *grp_info;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_header *tlv;
+	u16 tlv_buf_left, tlv_type, tlv_len;
+	int intf_num, bss_type, bss_num, i;
+	struct nxpwifi_private *intf_priv;
+
+	tlv_buf_left = event_skb->len - sizeof(u32);
+	chan_info = (void *)event_skb->data + sizeof(u32);
+
+	if (le16_to_cpu(chan_info->header.type) != TLV_TYPE_MULTI_CHAN_INFO ||
+	    tlv_buf_left < sizeof(struct nxpwifi_ie_types_multi_chan_info)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "unknown TLV in chan_info event\n");
+		return;
+	}
+
+	adapter->usb_mc_status = le16_to_cpu(chan_info->status);
+	nxpwifi_dbg(adapter, EVENT, "multi chan operation %s\n",
+		    adapter->usb_mc_status ? "started" : "over");
+
+	tlv_buf_left -= sizeof(struct nxpwifi_ie_types_multi_chan_info);
+	tlv = (struct nxpwifi_ie_types_header *)chan_info->tlv_buffer;
+
+	while (tlv_buf_left >= (int)sizeof(struct nxpwifi_ie_types_header)) {
+		tlv_type = le16_to_cpu(tlv->type);
+		tlv_len  = le16_to_cpu(tlv->len);
+		if ((sizeof(struct nxpwifi_ie_types_header) + tlv_len) >
+		    tlv_buf_left) {
+			nxpwifi_dbg(adapter, ERROR, "wrong tlv: tlvLen=%d,\t"
+				    "tlvBufLeft=%d\n", tlv_len, tlv_buf_left);
+			break;
+		}
+		if (tlv_type != TLV_TYPE_MC_GROUP_INFO) {
+			nxpwifi_dbg(adapter, ERROR, "wrong tlv type: 0x%x\n",
+				    tlv_type);
+			break;
+		}
+
+		grp_info = (struct nxpwifi_ie_types_mc_group_info *)tlv;
+		intf_num = grp_info->intf_num;
+		for (i = 0; i < intf_num; i++) {
+			bss_type = grp_info->bss_type_numlist[i] >> 4;
+			bss_num = grp_info->bss_type_numlist[i] & BSS_NUM_MASK;
+			intf_priv = nxpwifi_get_priv_by_id(adapter, bss_num,
+							   bss_type);
+			if (!intf_priv) {
+				nxpwifi_dbg(adapter, ERROR,
+					    "Invalid bss_type bss_num\t"
+					    "in multi channel event\n");
+				continue;
+			}
+		}
+
+		tlv_buf_left -= sizeof(struct nxpwifi_ie_types_header) +
+				tlv_len;
+		tlv = (void *)((u8 *)tlv + tlv_len +
+			       sizeof(struct nxpwifi_ie_types_header));
+	}
+}
+
+void nxpwifi_process_tx_pause_event(struct nxpwifi_private *priv,
+				    struct sk_buff *event_skb)
+{
+	struct nxpwifi_ie_types_header *tlv;
+	u16 tlv_type, tlv_len;
+	int tlv_buf_left;
+
+	if (!priv->media_connected) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "tx_pause event while disconnected; bss_role=%d\n",
+			    priv->bss_role);
+		return;
+	}
+
+	tlv_buf_left = event_skb->len - sizeof(u32);
+	tlv = (void *)event_skb->data + sizeof(u32);
+
+	while (tlv_buf_left >= (int)sizeof(struct nxpwifi_ie_types_header)) {
+		tlv_type = le16_to_cpu(tlv->type);
+		tlv_len  = le16_to_cpu(tlv->len);
+		if ((sizeof(struct nxpwifi_ie_types_header) + tlv_len) >
+		    tlv_buf_left) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "wrong tlv: tlvLen=%d, tlvBufLeft=%d\n",
+				    tlv_len, tlv_buf_left);
+			break;
+		}
+		if (tlv_type == TLV_TYPE_TX_PAUSE) {
+			if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+				nxpwifi_process_sta_tx_pause(priv, tlv);
+			else
+				nxpwifi_process_uap_tx_pause(priv, tlv);
+		}
+
+		tlv_buf_left -= sizeof(struct nxpwifi_ie_types_header) +
+				tlv_len;
+		tlv = (void *)((u8 *)tlv + tlv_len +
+			       sizeof(struct nxpwifi_ie_types_header));
+	}
+}
+
+/* This function handles coex events generated by firmware */
+void nxpwifi_bt_coex_wlan_param_update_event(struct nxpwifi_private *priv,
+					     struct sk_buff *event_skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_header *tlv;
+	struct nxpwifi_ie_types_btcoex_aggr_win_size *winsizetlv;
+	struct nxpwifi_ie_types_btcoex_scan_time *scantlv;
+	s32 len = event_skb->len - sizeof(u32);
+	u8 *cur_ptr = event_skb->data + sizeof(u32);
+	u16 tlv_type, tlv_len;
+
+	while (len >= sizeof(struct nxpwifi_ie_types_header)) {
+		tlv = (struct nxpwifi_ie_types_header *)cur_ptr;
+		tlv_len = le16_to_cpu(tlv->len);
+		tlv_type = le16_to_cpu(tlv->type);
+
+		if ((tlv_len + sizeof(struct nxpwifi_ie_types_header)) > len)
+			break;
+		switch (tlv_type) {
+		case TLV_BTCOEX_WL_AGGR_WINSIZE:
+			winsizetlv =
+			    (struct nxpwifi_ie_types_btcoex_aggr_win_size *)tlv;
+			adapter->coex_win_size = winsizetlv->coex_win_size;
+			adapter->coex_tx_win_size =
+				winsizetlv->tx_win_size;
+			adapter->coex_rx_win_size =
+				winsizetlv->rx_win_size;
+			nxpwifi_coex_ampdu_rxwinsize(adapter);
+			nxpwifi_update_ampdu_txwinsize(adapter);
+			break;
+
+		case TLV_BTCOEX_WL_SCANTIME:
+			scantlv =
+			    (struct nxpwifi_ie_types_btcoex_scan_time *)tlv;
+			adapter->coex_scan = scantlv->coex_scan;
+			adapter->coex_min_scan_time = le16_to_cpu(scantlv->min_scan_time);
+			adapter->coex_max_scan_time = le16_to_cpu(scantlv->max_scan_time);
+			break;
+
+		default:
+			break;
+		}
+
+		len -= tlv_len + sizeof(struct nxpwifi_ie_types_header);
+		cur_ptr += tlv_len +
+			sizeof(struct nxpwifi_ie_types_header);
+	}
+
+	dev_dbg(adapter->dev, "coex_scan=%d min_scan=%d coex_win=%d, tx_win=%d rx_win=%d\n",
+		adapter->coex_scan, adapter->coex_min_scan_time,
+		adapter->coex_win_size, adapter->coex_tx_win_size,
+		adapter->coex_rx_win_size);
+}
+
+/* This function handles events generated by firmware.
+ *
+ * This is a generic function and handles all events.
+ *
+ * Event specific routines are called by this function based
+ * upon the generated event cause.
+ */
+int nxpwifi_process_sta_event(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u32 eventcause = adapter->event_cause;
+	int evt, ret = 0;
+
+	for (evt = 0; evt < ARRAY_SIZE(evt_table_sta); evt++) {
+		if (eventcause == evt_table_sta[evt].event_cause) {
+			if (evt_table_sta[evt].event_handler)
+				ret = evt_table_sta[evt].event_handler(priv);
+			break;
+		}
+	}
+
+	if (evt == ARRAY_SIZE(evt_table_sta))
+		nxpwifi_dbg(adapter, EVENT,
+			    "%s: unknown event id: %#x\n",
+			    __func__, eventcause);
+	else
+		nxpwifi_dbg(adapter, EVENT,
+			    "%s: event id: %#x\n",
+			    __func__, eventcause);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/uap_cmd.c b/drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
new file mode 100644
index 000000000000..0968ba0d4a51
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
@@ -0,0 +1,1234 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: AP specific command handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+#include "11n.h"
+#include "11ac.h"
+#include "11ax.h"
+
+/* This function parses BSS related parameters from structure
+ * and prepares TLVs specific to WPA/WPA2 security.
+ * These TLVs are appended to command buffer.
+ */
+static void
+nxpwifi_uap_bss_wpa(u8 **tlv_buf, void *cmd_buf, u16 *param_size)
+{
+	struct host_cmd_tlv_pwk_cipher *pwk_cipher;
+	struct host_cmd_tlv_gwk_cipher *gwk_cipher;
+	struct host_cmd_tlv_passphrase *passphrase;
+	struct host_cmd_tlv_akmp *tlv_akmp;
+	struct nxpwifi_uap_bss_param *bss_cfg = cmd_buf;
+	u16 cmd_size = *param_size;
+	u8 *tlv = *tlv_buf;
+
+	tlv_akmp = (struct host_cmd_tlv_akmp *)tlv;
+	tlv_akmp->header.type = cpu_to_le16(TLV_TYPE_UAP_AKMP);
+	tlv_akmp->header.len = cpu_to_le16(sizeof(struct host_cmd_tlv_akmp) -
+					sizeof(struct nxpwifi_ie_types_header));
+	tlv_akmp->key_mgmt_operation = cpu_to_le16(bss_cfg->key_mgmt_operation);
+	tlv_akmp->key_mgmt = cpu_to_le16(bss_cfg->key_mgmt);
+	cmd_size += sizeof(struct host_cmd_tlv_akmp);
+	tlv += sizeof(struct host_cmd_tlv_akmp);
+
+	if (bss_cfg->wpa_cfg.pairwise_cipher_wpa & VALID_CIPHER_BITMAP) {
+		pwk_cipher = (struct host_cmd_tlv_pwk_cipher *)tlv;
+		pwk_cipher->header.type = cpu_to_le16(TLV_TYPE_PWK_CIPHER);
+		pwk_cipher->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_pwk_cipher) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		pwk_cipher->proto = cpu_to_le16(PROTOCOL_WPA);
+		pwk_cipher->cipher = bss_cfg->wpa_cfg.pairwise_cipher_wpa;
+		cmd_size += sizeof(struct host_cmd_tlv_pwk_cipher);
+		tlv += sizeof(struct host_cmd_tlv_pwk_cipher);
+	}
+
+	if (bss_cfg->wpa_cfg.pairwise_cipher_wpa2 & VALID_CIPHER_BITMAP) {
+		pwk_cipher = (struct host_cmd_tlv_pwk_cipher *)tlv;
+		pwk_cipher->header.type = cpu_to_le16(TLV_TYPE_PWK_CIPHER);
+		pwk_cipher->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_pwk_cipher) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		pwk_cipher->proto = cpu_to_le16(PROTOCOL_WPA2);
+		pwk_cipher->cipher = bss_cfg->wpa_cfg.pairwise_cipher_wpa2;
+		cmd_size += sizeof(struct host_cmd_tlv_pwk_cipher);
+		tlv += sizeof(struct host_cmd_tlv_pwk_cipher);
+	}
+
+	if (bss_cfg->wpa_cfg.group_cipher & VALID_CIPHER_BITMAP) {
+		gwk_cipher = (struct host_cmd_tlv_gwk_cipher *)tlv;
+		gwk_cipher->header.type = cpu_to_le16(TLV_TYPE_GWK_CIPHER);
+		gwk_cipher->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_gwk_cipher) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		gwk_cipher->cipher = bss_cfg->wpa_cfg.group_cipher;
+		cmd_size += sizeof(struct host_cmd_tlv_gwk_cipher);
+		tlv += sizeof(struct host_cmd_tlv_gwk_cipher);
+	}
+
+	if (bss_cfg->wpa_cfg.length) {
+		passphrase = (struct host_cmd_tlv_passphrase *)tlv;
+		passphrase->header.type =
+				cpu_to_le16(TLV_TYPE_UAP_WPA_PASSPHRASE);
+		passphrase->header.len = cpu_to_le16(bss_cfg->wpa_cfg.length);
+		memcpy(passphrase->passphrase, bss_cfg->wpa_cfg.passphrase,
+		       bss_cfg->wpa_cfg.length);
+		cmd_size += sizeof(struct nxpwifi_ie_types_header) +
+			    bss_cfg->wpa_cfg.length;
+		tlv += sizeof(struct nxpwifi_ie_types_header) +
+				bss_cfg->wpa_cfg.length;
+	}
+
+	*param_size = cmd_size;
+	*tlv_buf = tlv;
+}
+
+/* This function parses BSS related parameters from structure
+ * and prepares TLVs specific to WEP encryption.
+ * These TLVs are appended to command buffer.
+ */
+static void
+nxpwifi_uap_bss_wep(u8 **tlv_buf, void *cmd_buf, u16 *param_size)
+{
+	struct host_cmd_tlv_wep_key *wep_key;
+	u16 cmd_size = *param_size;
+	int i;
+	u8 *tlv = *tlv_buf;
+	struct nxpwifi_uap_bss_param *bss_cfg = cmd_buf;
+
+	for (i = 0; i < NUM_WEP_KEYS; i++) {
+		if (bss_cfg->wep_cfg[i].length &&
+		    (bss_cfg->wep_cfg[i].length == WLAN_KEY_LEN_WEP40 ||
+		     bss_cfg->wep_cfg[i].length == WLAN_KEY_LEN_WEP104)) {
+			wep_key = (struct host_cmd_tlv_wep_key *)tlv;
+			wep_key->header.type =
+				cpu_to_le16(TLV_TYPE_UAP_WEP_KEY);
+			wep_key->header.len =
+				cpu_to_le16(bss_cfg->wep_cfg[i].length + 2);
+			wep_key->key_index = bss_cfg->wep_cfg[i].key_index;
+			wep_key->is_default = bss_cfg->wep_cfg[i].is_default;
+			memcpy(wep_key->key, bss_cfg->wep_cfg[i].key,
+			       bss_cfg->wep_cfg[i].length);
+			cmd_size += sizeof(struct nxpwifi_ie_types_header) + 2 +
+				    bss_cfg->wep_cfg[i].length;
+			tlv += sizeof(struct nxpwifi_ie_types_header) + 2 +
+				    bss_cfg->wep_cfg[i].length;
+		}
+	}
+
+	*param_size = cmd_size;
+	*tlv_buf = tlv;
+}
+
+/* This function parses BSS related parameters from structure
+ * and prepares TLVs. These TLVs are appended to command buffer.
+ */
+static int
+nxpwifi_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
+{
+	struct host_cmd_tlv_mac_addr *mac_tlv;
+	struct host_cmd_tlv_dtim_period *dtim_period;
+	struct host_cmd_tlv_beacon_period *beacon_period;
+	struct host_cmd_tlv_ssid *ssid;
+	struct host_cmd_tlv_bcast_ssid *bcast_ssid;
+	struct host_cmd_tlv_channel_band *chan_band;
+	struct host_cmd_tlv_frag_threshold *frag_threshold;
+	struct host_cmd_tlv_rts_threshold *rts_threshold;
+	struct host_cmd_tlv_retry_limit *retry_limit;
+	struct host_cmd_tlv_encrypt_protocol *encrypt_protocol;
+	struct host_cmd_tlv_auth_type *auth_type;
+	struct host_cmd_tlv_rates *tlv_rates;
+	struct host_cmd_tlv_ageout_timer *ao_timer, *ps_ao_timer;
+	struct host_cmd_tlv_power_constraint *pwr_ct;
+	struct nxpwifi_ie_types_htcap *htcap;
+	struct nxpwifi_ie_types_wmmcap *wmm_cap;
+	struct nxpwifi_uap_bss_param *bss_cfg = cmd_buf;
+	int i;
+	u16 cmd_size = *param_size;
+
+	mac_tlv = (struct host_cmd_tlv_mac_addr *)tlv;
+	mac_tlv->header.type = cpu_to_le16(TLV_TYPE_UAP_MAC_ADDRESS);
+	mac_tlv->header.len = cpu_to_le16(ETH_ALEN);
+	memcpy(mac_tlv->mac_addr, bss_cfg->mac_addr, ETH_ALEN);
+	cmd_size += sizeof(struct host_cmd_tlv_mac_addr);
+	tlv += sizeof(struct host_cmd_tlv_mac_addr);
+
+	if (bss_cfg->ssid.ssid_len) {
+		ssid = (struct host_cmd_tlv_ssid *)tlv;
+		ssid->header.type = cpu_to_le16(TLV_TYPE_UAP_SSID);
+		ssid->header.len = cpu_to_le16((u16)bss_cfg->ssid.ssid_len);
+		memcpy(ssid->ssid, bss_cfg->ssid.ssid, bss_cfg->ssid.ssid_len);
+		cmd_size += sizeof(struct nxpwifi_ie_types_header) +
+			    bss_cfg->ssid.ssid_len;
+		tlv += sizeof(struct nxpwifi_ie_types_header) +
+				bss_cfg->ssid.ssid_len;
+
+		bcast_ssid = (struct host_cmd_tlv_bcast_ssid *)tlv;
+		bcast_ssid->header.type = cpu_to_le16(TLV_TYPE_UAP_BCAST_SSID);
+		bcast_ssid->header.len =
+				cpu_to_le16(sizeof(bcast_ssid->bcast_ctl));
+		bcast_ssid->bcast_ctl = bss_cfg->bcast_ssid_ctl;
+		cmd_size += sizeof(struct host_cmd_tlv_bcast_ssid);
+		tlv += sizeof(struct host_cmd_tlv_bcast_ssid);
+	}
+	if (bss_cfg->rates[0]) {
+		tlv_rates = (struct host_cmd_tlv_rates *)tlv;
+		tlv_rates->header.type = cpu_to_le16(TLV_TYPE_UAP_RATES);
+
+		for (i = 0; i < NXPWIFI_SUPPORTED_RATES && bss_cfg->rates[i];
+		     i++)
+			tlv_rates->rates[i] = bss_cfg->rates[i];
+
+		tlv_rates->header.len = cpu_to_le16(i);
+		cmd_size += sizeof(struct host_cmd_tlv_rates) + i;
+		tlv += sizeof(struct host_cmd_tlv_rates) + i;
+	}
+	if (bss_cfg->channel &&
+	    (((bss_cfg->band_cfg & BIT(0)) == BAND_CONFIG_BG &&
+	      bss_cfg->channel <= MAX_CHANNEL_BAND_BG) ||
+	    ((bss_cfg->band_cfg & BIT(0)) == BAND_CONFIG_A &&
+	     bss_cfg->channel <= MAX_CHANNEL_BAND_A))) {
+		chan_band = (struct host_cmd_tlv_channel_band *)tlv;
+		chan_band->header.type = cpu_to_le16(TLV_TYPE_CHANNELBANDLIST);
+		chan_band->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_channel_band) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		chan_band->band_config = bss_cfg->band_cfg;
+		chan_band->channel = bss_cfg->channel;
+		cmd_size += sizeof(struct host_cmd_tlv_channel_band);
+		tlv += sizeof(struct host_cmd_tlv_channel_band);
+	}
+	if (bss_cfg->beacon_period >= MIN_BEACON_PERIOD &&
+	    bss_cfg->beacon_period <= MAX_BEACON_PERIOD) {
+		beacon_period = (struct host_cmd_tlv_beacon_period *)tlv;
+		beacon_period->header.type =
+					cpu_to_le16(TLV_TYPE_UAP_BEACON_PERIOD);
+		beacon_period->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_beacon_period) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		beacon_period->period = cpu_to_le16(bss_cfg->beacon_period);
+		cmd_size += sizeof(struct host_cmd_tlv_beacon_period);
+		tlv += sizeof(struct host_cmd_tlv_beacon_period);
+	}
+	if (bss_cfg->dtim_period >= MIN_DTIM_PERIOD &&
+	    bss_cfg->dtim_period <= MAX_DTIM_PERIOD) {
+		dtim_period = (struct host_cmd_tlv_dtim_period *)tlv;
+		dtim_period->header.type =
+			cpu_to_le16(TLV_TYPE_UAP_DTIM_PERIOD);
+		dtim_period->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_dtim_period) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		dtim_period->period = bss_cfg->dtim_period;
+		cmd_size += sizeof(struct host_cmd_tlv_dtim_period);
+		tlv += sizeof(struct host_cmd_tlv_dtim_period);
+	}
+	if (bss_cfg->rts_threshold <= NXPWIFI_RTS_MAX_VALUE) {
+		rts_threshold = (struct host_cmd_tlv_rts_threshold *)tlv;
+		rts_threshold->header.type =
+					cpu_to_le16(TLV_TYPE_UAP_RTS_THRESHOLD);
+		rts_threshold->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_rts_threshold) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		rts_threshold->rts_thr = cpu_to_le16(bss_cfg->rts_threshold);
+		cmd_size += sizeof(struct host_cmd_tlv_frag_threshold);
+		tlv += sizeof(struct host_cmd_tlv_frag_threshold);
+	}
+	if (bss_cfg->frag_threshold >= NXPWIFI_FRAG_MIN_VALUE &&
+	    bss_cfg->frag_threshold <= NXPWIFI_FRAG_MAX_VALUE) {
+		frag_threshold = (struct host_cmd_tlv_frag_threshold *)tlv;
+		frag_threshold->header.type =
+				cpu_to_le16(TLV_TYPE_UAP_FRAG_THRESHOLD);
+		frag_threshold->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_frag_threshold) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		frag_threshold->frag_thr = cpu_to_le16(bss_cfg->frag_threshold);
+		cmd_size += sizeof(struct host_cmd_tlv_frag_threshold);
+		tlv += sizeof(struct host_cmd_tlv_frag_threshold);
+	}
+	if (bss_cfg->retry_limit <= NXPWIFI_RETRY_LIMIT) {
+		retry_limit = (struct host_cmd_tlv_retry_limit *)tlv;
+		retry_limit->header.type =
+			cpu_to_le16(TLV_TYPE_UAP_RETRY_LIMIT);
+		retry_limit->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_retry_limit) -
+				    sizeof(struct nxpwifi_ie_types_header));
+		retry_limit->limit = (u8)bss_cfg->retry_limit;
+		cmd_size += sizeof(struct host_cmd_tlv_retry_limit);
+		tlv += sizeof(struct host_cmd_tlv_retry_limit);
+	}
+	if ((bss_cfg->protocol & PROTOCOL_WPA) ||
+	    (bss_cfg->protocol & PROTOCOL_WPA2) ||
+	    (bss_cfg->protocol & PROTOCOL_EAP))
+		nxpwifi_uap_bss_wpa(&tlv, cmd_buf, &cmd_size);
+	else
+		nxpwifi_uap_bss_wep(&tlv, cmd_buf, &cmd_size);
+
+	if (bss_cfg->auth_mode <= WLAN_AUTH_SHARED_KEY ||
+	    bss_cfg->auth_mode == NXPWIFI_AUTH_MODE_AUTO) {
+		auth_type = (struct host_cmd_tlv_auth_type *)tlv;
+		auth_type->header.type = cpu_to_le16(TLV_TYPE_AUTH_TYPE);
+		auth_type->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_auth_type) -
+			sizeof(struct nxpwifi_ie_types_header));
+		auth_type->auth_type = (u8)bss_cfg->auth_mode;
+		auth_type->pwe_derivation = 0;
+		auth_type->transition_disable = 0;
+		cmd_size += sizeof(struct host_cmd_tlv_auth_type);
+		tlv += sizeof(struct host_cmd_tlv_auth_type);
+	}
+	if (bss_cfg->protocol) {
+		encrypt_protocol = (struct host_cmd_tlv_encrypt_protocol *)tlv;
+		encrypt_protocol->header.type =
+			cpu_to_le16(TLV_TYPE_UAP_ENCRY_PROTOCOL);
+		encrypt_protocol->header.len =
+			cpu_to_le16(sizeof(struct host_cmd_tlv_encrypt_protocol)
+			- sizeof(struct nxpwifi_ie_types_header));
+		encrypt_protocol->proto = cpu_to_le16(bss_cfg->protocol);
+		cmd_size += sizeof(struct host_cmd_tlv_encrypt_protocol);
+		tlv += sizeof(struct host_cmd_tlv_encrypt_protocol);
+	}
+
+	if (bss_cfg->ht_cap.cap_info) {
+		htcap = (struct nxpwifi_ie_types_htcap *)tlv;
+		htcap->header.type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		htcap->header.len =
+				cpu_to_le16(sizeof(struct ieee80211_ht_cap));
+		htcap->ht_cap.cap_info = bss_cfg->ht_cap.cap_info;
+		htcap->ht_cap.ampdu_params_info =
+					     bss_cfg->ht_cap.ampdu_params_info;
+		memcpy(&htcap->ht_cap.mcs, &bss_cfg->ht_cap.mcs,
+		       sizeof(struct ieee80211_mcs_info));
+		htcap->ht_cap.extended_ht_cap_info =
+					bss_cfg->ht_cap.extended_ht_cap_info;
+		htcap->ht_cap.tx_BF_cap_info = bss_cfg->ht_cap.tx_BF_cap_info;
+		htcap->ht_cap.antenna_selection_info =
+					bss_cfg->ht_cap.antenna_selection_info;
+		cmd_size += sizeof(struct nxpwifi_ie_types_htcap);
+		tlv += sizeof(struct nxpwifi_ie_types_htcap);
+	}
+
+	if (bss_cfg->wmm_info.qos_info != 0xFF) {
+		wmm_cap = (struct nxpwifi_ie_types_wmmcap *)tlv;
+		wmm_cap->header.type = cpu_to_le16(WLAN_EID_VENDOR_SPECIFIC);
+		wmm_cap->header.len = cpu_to_le16(sizeof(wmm_cap->wmm_info));
+		memcpy(&wmm_cap->wmm_info, &bss_cfg->wmm_info,
+		       sizeof(wmm_cap->wmm_info));
+		cmd_size += sizeof(struct nxpwifi_ie_types_wmmcap);
+		tlv += sizeof(struct nxpwifi_ie_types_wmmcap);
+	}
+
+	if (bss_cfg->sta_ao_timer) {
+		ao_timer = (struct host_cmd_tlv_ageout_timer *)tlv;
+		ao_timer->header.type = cpu_to_le16(TLV_TYPE_UAP_AO_TIMER);
+		ao_timer->header.len = cpu_to_le16(sizeof(*ao_timer) -
+					sizeof(struct nxpwifi_ie_types_header));
+		ao_timer->sta_ao_timer = cpu_to_le32(bss_cfg->sta_ao_timer);
+		cmd_size += sizeof(*ao_timer);
+		tlv += sizeof(*ao_timer);
+	}
+
+	if (bss_cfg->power_constraint) {
+		pwr_ct = (void *)tlv;
+		pwr_ct->header.type = cpu_to_le16(TLV_TYPE_PWR_CONSTRAINT);
+		pwr_ct->header.len = cpu_to_le16(sizeof(u8));
+		pwr_ct->constraint = bss_cfg->power_constraint;
+		cmd_size += sizeof(*pwr_ct);
+		tlv += sizeof(*pwr_ct);
+	}
+
+	if (bss_cfg->ps_sta_ao_timer) {
+		ps_ao_timer = (struct host_cmd_tlv_ageout_timer *)tlv;
+		ps_ao_timer->header.type =
+				cpu_to_le16(TLV_TYPE_UAP_PS_AO_TIMER);
+		ps_ao_timer->header.len = cpu_to_le16(sizeof(*ps_ao_timer) -
+				sizeof(struct nxpwifi_ie_types_header));
+		ps_ao_timer->sta_ao_timer =
+					cpu_to_le32(bss_cfg->ps_sta_ao_timer);
+		cmd_size += sizeof(*ps_ao_timer);
+		tlv += sizeof(*ps_ao_timer);
+	}
+
+	*param_size = cmd_size;
+
+	return 0;
+}
+
+/* This function parses custom IEs from IE list and prepares command buffer */
+static int nxpwifi_uap_custom_ie_prepare(u8 *tlv, void *cmd_buf, u16 *ie_size)
+{
+	struct nxpwifi_ie_list *ap_ie = cmd_buf;
+	struct nxpwifi_ie_types_header *tlv_ie = (void *)tlv;
+
+	if (!ap_ie || !ap_ie->len)
+		return -EINVAL;
+
+	*ie_size += le16_to_cpu(ap_ie->len) +
+		    sizeof(struct nxpwifi_ie_types_header);
+
+	tlv_ie->type = cpu_to_le16(TLV_TYPE_MGMT_IE);
+	tlv_ie->len = ap_ie->len;
+	tlv += sizeof(struct nxpwifi_ie_types_header);
+
+	memcpy(tlv, ap_ie->ie_list, le16_to_cpu(ap_ie->len));
+
+	return 0;
+}
+
+/* Parse AP config structure and prepare TLV based command structure
+ * to be sent to FW for uAP configuration
+ */
+static int
+nxpwifi_cmd_uap_sys_config(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *cmd,
+			   u16 cmd_no, void *data_buf,
+			   u16 cmd_action, u32 cmd_type)
+{
+	u8 *tlv;
+	u16 cmd_size, param_size, ie_size;
+	struct host_cmd_ds_sys_config *sys_cfg;
+	int ret = 0;
+
+	cmd->command = cpu_to_le16(HOST_CMD_UAP_SYS_CONFIG);
+	cmd_size = (u16)(sizeof(struct host_cmd_ds_sys_config) + S_DS_GEN);
+	sys_cfg = &cmd->params.uap_sys_config;
+	sys_cfg->action = cpu_to_le16(cmd_action);
+	tlv = sys_cfg->tlv;
+
+	switch (cmd_type) {
+	case UAP_BSS_PARAMS_I:
+		param_size = cmd_size;
+		ret = nxpwifi_uap_bss_param_prepare(tlv, data_buf, &param_size);
+		if (ret)
+			return ret;
+		cmd->size = cpu_to_le16(param_size);
+		break;
+	case UAP_CUSTOM_IE_I:
+		ie_size = cmd_size;
+		ret = nxpwifi_uap_custom_ie_prepare(tlv, data_buf, &ie_size);
+		if (ret)
+			return ret;
+		cmd->size = cpu_to_le16(ie_size);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int
+nxpwifi_cmd_uap_bss_start(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *cmd,
+			  u16 cmd_no, void *data_buf,
+			  u16 cmd_action, u32 cmd_type)
+{
+	struct nxpwifi_ie_types_host_mlme *tlv;
+	int size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_UAP_BSS_START);
+	size = S_DS_GEN;
+
+	tlv = (struct nxpwifi_ie_types_host_mlme *)((u8 *)cmd + size);
+	tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
+	tlv->header.len = cpu_to_le16(sizeof(tlv->host_mlme));
+	tlv->host_mlme = 1;
+	size += sizeof(struct nxpwifi_ie_types_host_mlme);
+
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_uap_bss_start(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp,
+			  u16 cmdresp_no,
+			  void *data_buf)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	adapter->tx_lock_flag = false;
+	adapter->pps_uapsd_mode = false;
+	adapter->delay_null_pkt = false;
+	priv->bss_started = 1;
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_uap_bss_stop(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 u16 cmdresp_no,
+			 void *data_buf)
+{
+	priv->bss_started = 0;
+
+	return 0;
+}
+
+static int
+nxpwifi_ret_apcmd_sta_list(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *resp,
+			   u16 cmdresp_no,
+			   void *data_buf)
+{
+	struct host_cmd_ds_sta_list *sta_list =
+		&resp->params.sta_list;
+	struct nxpwifi_ie_types_sta_info *sta_info = (void *)&sta_list->tlv;
+	int i;
+	struct nxpwifi_sta_node *sta_node;
+
+	rcu_read_lock();
+	for (i = 0; i < (le16_to_cpu(sta_list->sta_count)); i++) {
+		sta_node = nxpwifi_get_sta_entry(priv, sta_info->mac);
+		if (unlikely(!sta_node))
+			continue;
+
+		sta_node->stats.rssi = sta_info->rssi;
+		sta_info++;
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
+/* This function prepares AP specific deauth command with mac supplied in
+ * function parameter.
+ */
+static int nxpwifi_cmd_uap_sta_deauth(struct nxpwifi_private *priv,
+				      struct host_cmd_ds_command *cmd,
+				      u16 cmd_no, void *data_buf,
+				      u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_sta_deauth *sta_deauth = &cmd->params.sta_deauth;
+	u8 *mac = (u8 *)data_buf;
+
+	cmd->command = cpu_to_le16(HOST_CMD_UAP_STA_DEAUTH);
+	memcpy(sta_deauth->mac, mac, ETH_ALEN);
+	sta_deauth->reason = cpu_to_le16(WLAN_REASON_DEAUTH_LEAVING);
+
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_sta_deauth) +
+				S_DS_GEN);
+	return 0;
+}
+
+static int
+nxpwifi_cmd_uap_chan_report_request(struct nxpwifi_private *priv,
+				    struct host_cmd_ds_command *cmd,
+				    u16 cmd_no, void *data_buf,
+				    u16 cmd_action, u32 cmd_type)
+{
+	return nxpwifi_cmd_issue_chan_report_request(priv, cmd, data_buf);
+}
+
+/* This function prepares AP specific add station command.
+ */
+static int
+nxpwifi_cmd_uap_add_new_station(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *cmd,
+				u16 cmd_no, void *data_buf,
+				u16 cmd_action, u32 cmd_type)
+{
+	struct host_cmd_ds_add_station *new_sta = &cmd->params.sta_info;
+	struct nxpwifi_sta_info *add_sta = (struct nxpwifi_sta_info *)data_buf;
+	struct station_parameters *params = add_sta->params;
+	struct nxpwifi_sta_node *sta_ptr;
+	u16 cmd_size;
+	u8 *pos, *cmd_end;
+	u16 tlv_len;
+	struct nxpwifi_ie_types_sta_flag *sta_flag;
+	int i;
+
+	cmd->command = cpu_to_le16(HOST_CMD_ADD_NEW_STATION);
+	new_sta->action = cpu_to_le16(cmd_action);
+	cmd_size = sizeof(struct host_cmd_ds_add_station) + S_DS_GEN;
+
+	if (cmd_action == HOST_ACT_ADD_STA)
+		sta_ptr = nxpwifi_add_sta_entry(priv, add_sta->peer_mac);
+	else
+		sta_ptr = nxpwifi_get_sta_entry_rcu(priv, add_sta->peer_mac);
+
+	if (!sta_ptr)
+		return -EINVAL;
+
+	memcpy(new_sta->peer_mac, add_sta->peer_mac, ETH_ALEN);
+
+	if (cmd_action == HOST_ACT_REMOVE_STA) {
+		cmd->size = cpu_to_le16(cmd_size);
+		return 0;
+	}
+
+	new_sta->aid = cpu_to_le16(params->aid);
+	new_sta->listen_interval = cpu_to_le32(params->listen_interval);
+	new_sta->cap_info = cpu_to_le16(params->capability);
+
+	pos = new_sta->tlv;
+	cmd_end = (u8 *)cmd;
+	cmd_end += (NXPWIFI_SIZE_OF_CMD_BUFFER - 1);
+
+	if (params->sta_flags_set & NL80211_STA_FLAG_WME)
+		sta_ptr->is_wmm_enabled = 1;
+	sta_flag = (struct nxpwifi_ie_types_sta_flag *)pos;
+	sta_flag->header.type = cpu_to_le16(TLV_TYPE_UAP_STA_FLAGS);
+	sta_flag->header.len = cpu_to_le16(sizeof(__le32));
+	sta_flag->sta_flags = cpu_to_le32(params->sta_flags_set);
+	pos += sizeof(struct nxpwifi_ie_types_sta_flag);
+	cmd_size += sizeof(struct nxpwifi_ie_types_sta_flag);
+
+	if (params->ext_capab_len) {
+		u8 *data = (u8 *)params->ext_capab;
+		u16 len = params->ext_capab_len;
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_EXT_CAPABILITY,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+	}
+
+	if (params->link_sta_params.supported_rates_len) {
+		u8 *data = (u8 *)params->link_sta_params.supported_rates;
+		u16 len = params->link_sta_params.supported_rates_len;
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_SUPP_RATES,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+	}
+
+	if (params->uapsd_queues || params->max_sp) {
+		u8 qos_capability = params->uapsd_queues | (params->max_sp << 5);
+		u8 *data = &qos_capability;
+		u16 len = sizeof(u8);
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_QOS_CAPA,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+		sta_ptr->is_wmm_enabled = 1;
+	}
+
+	if (params->link_sta_params.ht_capa) {
+		u8 *data = (u8 *)params->link_sta_params.ht_capa;
+		u16 len = sizeof(struct ieee80211_ht_cap);
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_HT_CAPABILITY,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+		sta_ptr->is_11n_enabled = 1;
+		sta_ptr->max_amsdu =
+			le16_to_cpu(params->link_sta_params.ht_capa->cap_info) &
+			IEEE80211_HT_CAP_MAX_AMSDU ?
+			NXPWIFI_TX_DATA_BUF_SIZE_8K :
+			NXPWIFI_TX_DATA_BUF_SIZE_4K;
+	}
+
+	if (params->link_sta_params.vht_capa) {
+		u8 *data = (u8 *)params->link_sta_params.vht_capa;
+		u16 len = sizeof(struct ieee80211_vht_cap);
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_VHT_CAPABILITY,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+		sta_ptr->is_11ac_enabled = 1;
+	}
+
+	if (params->link_sta_params.opmode_notif_used) {
+		u8 *data = &params->link_sta_params.opmode_notif;
+		u16 len = sizeof(u8);
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_OPMODE_NOTIF,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+	}
+
+	if (params->link_sta_params.he_capa_len) {
+		u8 *data = (u8 *)params->link_sta_params.he_capa;
+		u16 len = params->link_sta_params.he_capa_len;
+
+		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_EXT_HE_CAPABILITY,
+						  data, len, pos, cmd_end);
+		if (!tlv_len)
+			return -EINVAL;
+		pos += tlv_len;
+		cmd_size += tlv_len;
+		sta_ptr->is_11ax_enabled = 1;
+	}
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		if (sta_ptr->is_11n_enabled || sta_ptr->is_11ax_enabled)
+			sta_ptr->ampdu_sta[i] =
+				      priv->aggr_prio_tbl[i].ampdu_user;
+		else
+			sta_ptr->ampdu_sta[i] = BA_STREAM_NOT_ALLOWED;
+	}
+
+	memset(sta_ptr->rx_seq, 0xff, sizeof(sta_ptr->rx_seq));
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+static const struct nxpwifi_cmd_entry cmd_table_uap[] = {
+	{.cmd_no = HOST_CMD_APCMD_SYS_RESET,
+	.prepare_cmd = nxpwifi_cmd_fill_head_only,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_UAP_SYS_CONFIG,
+	.prepare_cmd = nxpwifi_cmd_uap_sys_config,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_UAP_BSS_START,
+	.prepare_cmd = nxpwifi_cmd_uap_bss_start,
+	.cmd_resp = nxpwifi_ret_uap_bss_start},
+	{.cmd_no = HOST_CMD_UAP_BSS_STOP,
+	.prepare_cmd = nxpwifi_cmd_fill_head_only,
+	.cmd_resp = nxpwifi_ret_uap_bss_stop},
+	{.cmd_no = HOST_CMD_APCMD_STA_LIST,
+	.prepare_cmd = nxpwifi_cmd_fill_head_only,
+	.cmd_resp = nxpwifi_ret_apcmd_sta_list},
+	{.cmd_no = HOST_CMD_UAP_STA_DEAUTH,
+	.prepare_cmd = nxpwifi_cmd_uap_sta_deauth,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_CHAN_REPORT_REQUEST,
+	.prepare_cmd = nxpwifi_cmd_uap_chan_report_request,
+	.cmd_resp = NULL},
+	{.cmd_no = HOST_CMD_ADD_NEW_STATION,
+	.prepare_cmd = nxpwifi_cmd_uap_add_new_station,
+	.cmd_resp = NULL},
+};
+
+/* This function prepares the AP specific commands before sending them
+ * to the firmware.
+ * This is a generic function which calls specific command preparation
+ * routines based upon the command number.
+ */
+int nxpwifi_uap_prepare_cmd(struct nxpwifi_private *priv,
+			    struct cmd_ctrl_node *cmd_node,
+			    u16 cmd_action, u32 type)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 cmd_no = cmd_node->cmd_no;
+	struct host_cmd_ds_command *cmd =
+		(struct host_cmd_ds_command *)cmd_node->skb->data;
+	void *data_buf = cmd_node->data_buf;
+	int i, ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(cmd_table_uap); i++) {
+		if (cmd_no == cmd_table_uap[i].cmd_no) {
+			if (cmd_table_uap[i].prepare_cmd)
+				ret = cmd_table_uap[i].prepare_cmd(priv, cmd,
+								   cmd_no,
+								   data_buf,
+								   cmd_action,
+								   type);
+			cmd_node->cmd_resp = cmd_table_uap[i].cmd_resp;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(cmd_table_uap))
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: unknown command: %#x\n",
+			    __func__, cmd_no);
+	else
+		nxpwifi_dbg(adapter, CMD,
+			    "%s: command: %#x\n",
+			    __func__, cmd_no);
+
+	return ret;
+}
+
+/* This function parses security related parameters from cfg80211_ap_settings
+ * and sets into FW understandable bss_config structure.
+ */
+int nxpwifi_set_secure_params(struct nxpwifi_private *priv,
+			      struct nxpwifi_uap_bss_param *bss_config,
+			      struct cfg80211_ap_settings *params)
+{
+	int i;
+	struct nxpwifi_wep_key wep_key;
+
+	if (!params->privacy) {
+		bss_config->protocol = PROTOCOL_NO_SECURITY;
+		bss_config->key_mgmt = KEY_MGMT_NONE;
+		bss_config->wpa_cfg.length = 0;
+		priv->sec_info.wep_enabled = 0;
+		priv->sec_info.wpa_enabled = 0;
+		priv->sec_info.wpa2_enabled = 0;
+
+		return 0;
+	}
+
+	switch (params->auth_type) {
+	case NL80211_AUTHTYPE_OPEN_SYSTEM:
+		bss_config->auth_mode = WLAN_AUTH_OPEN;
+		break;
+	case NL80211_AUTHTYPE_SHARED_KEY:
+		bss_config->auth_mode = WLAN_AUTH_SHARED_KEY;
+		break;
+	case NL80211_AUTHTYPE_NETWORK_EAP:
+		bss_config->auth_mode = WLAN_AUTH_LEAP;
+		break;
+	default:
+		bss_config->auth_mode = NXPWIFI_AUTH_MODE_AUTO;
+		break;
+	}
+
+	bss_config->key_mgmt_operation |= KEY_MGMT_ON_HOST;
+
+	bss_config->protocol = 0;
+	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
+		bss_config->protocol |= PROTOCOL_WPA;
+	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
+		bss_config->protocol |= PROTOCOL_WPA2;
+
+	bss_config->key_mgmt = 0;
+	for (i = 0; i < params->crypto.n_akm_suites; i++) {
+		switch (params->crypto.akm_suites[i]) {
+		case WLAN_AKM_SUITE_8021X:
+			bss_config->key_mgmt |= KEY_MGMT_EAP;
+			break;
+		case WLAN_AKM_SUITE_PSK:
+			bss_config->key_mgmt |= KEY_MGMT_PSK;
+			break;
+		case WLAN_AKM_SUITE_PSK_SHA256:
+			bss_config->key_mgmt |= KEY_MGMT_PSK_SHA256;
+			break;
+		case WLAN_AKM_SUITE_OWE:
+			bss_config->key_mgmt |= KEY_MGMT_OWE;
+			break;
+		case WLAN_AKM_SUITE_SAE:
+			bss_config->key_mgmt |= KEY_MGMT_SAE;
+			break;
+		default:
+			break;
+		}
+	}
+
+	for (i = 0; i < params->crypto.n_ciphers_pairwise; i++) {
+		switch (params->crypto.ciphers_pairwise[i]) {
+		case WLAN_CIPHER_SUITE_WEP40:
+		case WLAN_CIPHER_SUITE_WEP104:
+			break;
+		case WLAN_CIPHER_SUITE_TKIP:
+			if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
+				bss_config->wpa_cfg.pairwise_cipher_wpa |=
+								CIPHER_TKIP;
+			if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
+				bss_config->wpa_cfg.pairwise_cipher_wpa2 |=
+								CIPHER_TKIP;
+			break;
+		case WLAN_CIPHER_SUITE_CCMP:
+			if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
+				bss_config->wpa_cfg.pairwise_cipher_wpa |=
+								CIPHER_AES_CCMP;
+			if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
+				bss_config->wpa_cfg.pairwise_cipher_wpa2 |=
+								CIPHER_AES_CCMP;
+			break;
+		default:
+			break;
+		}
+	}
+
+	switch (params->crypto.cipher_group) {
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+		if (priv->sec_info.wep_enabled) {
+			bss_config->protocol = PROTOCOL_STATIC_WEP;
+			bss_config->key_mgmt = KEY_MGMT_NONE;
+			bss_config->wpa_cfg.length = 0;
+
+			for (i = 0; i < NUM_WEP_KEYS; i++) {
+				wep_key = priv->wep_key[i];
+				bss_config->wep_cfg[i].key_index = i;
+
+				if (priv->wep_key_curr_index == i)
+					bss_config->wep_cfg[i].is_default = 1;
+				else
+					bss_config->wep_cfg[i].is_default = 0;
+
+				bss_config->wep_cfg[i].length =
+							     wep_key.key_length;
+				memcpy(&bss_config->wep_cfg[i].key,
+				       &wep_key.key_material,
+				       wep_key.key_length);
+			}
+		}
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		bss_config->wpa_cfg.group_cipher = CIPHER_TKIP;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+		bss_config->wpa_cfg.group_cipher = CIPHER_AES_CCMP;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/* This function updates 11n related parameters from IE and sets them into
+ * bss_config structure.
+ */
+void
+nxpwifi_set_ht_params(struct nxpwifi_private *priv,
+		      struct nxpwifi_uap_bss_param *bss_cfg,
+		      struct cfg80211_ap_settings *params)
+{
+	const u8 *ht_ie;
+
+	if (!ISSUPP_11NENABLED(priv->adapter->fw_cap_info))
+		return;
+
+	ht_ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, params->beacon.tail,
+				 params->beacon.tail_len);
+	if (ht_ie) {
+		memcpy(&bss_cfg->ht_cap, ht_ie + 2,
+		       sizeof(struct ieee80211_ht_cap));
+		if (ISSUPP_BEAMFORMING(priv->adapter->hw_dot_11n_dev_cap))
+			bss_cfg->ht_cap.tx_BF_cap_info =
+				cpu_to_le32(NXPWIFI_DEF_11N_TX_BF_CAP);
+		priv->ap_11n_enabled = 1;
+	} else {
+		memset(&bss_cfg->ht_cap, 0, sizeof(struct ieee80211_ht_cap));
+		bss_cfg->ht_cap.cap_info = cpu_to_le16(NXPWIFI_DEF_HT_CAP);
+		bss_cfg->ht_cap.ampdu_params_info = NXPWIFI_DEF_AMPDU;
+	}
+}
+
+/* This function updates 11ac related parameters from IE
+ * and sets them into bss_config structure.
+ */
+void nxpwifi_set_vht_params(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params)
+{
+	const u8 *vht_ie;
+
+	vht_ie = cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, params->beacon.tail,
+				  params->beacon.tail_len);
+	if (vht_ie) {
+		memcpy(&bss_cfg->vht_cap, vht_ie + 2,
+		       sizeof(struct ieee80211_vht_cap));
+		priv->ap_11ac_enabled = 1;
+	} else {
+		priv->ap_11ac_enabled = 0;
+	}
+}
+
+/* This function updates 11ac related parameters from IE
+ * and sets them into bss_config structure.
+ */
+void nxpwifi_set_tpc_params(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params)
+{
+	const u8 *tpc_ie;
+
+	tpc_ie = cfg80211_find_ie(WLAN_EID_TPC_REQUEST, params->beacon.tail,
+				  params->beacon.tail_len);
+	if (tpc_ie)
+		bss_cfg->power_constraint = *(tpc_ie + 2);
+	else
+		bss_cfg->power_constraint = 0;
+}
+
+/* Enable VHT only when cfg80211_ap_settings has VHT IE.
+ * Otherwise disable VHT.
+ */
+void nxpwifi_set_vht_width(struct nxpwifi_private *priv,
+			   enum nl80211_chan_width width,
+			   bool ap_11ac_enable)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_11ac_vht_cfg vht_cfg;
+
+	vht_cfg.band_config = VHT_CFG_5GHZ;
+	vht_cfg.cap_info = adapter->hw_dot_11ac_dev_cap;
+
+	if (!ap_11ac_enable) {
+		vht_cfg.mcs_tx_set = DISABLE_VHT_MCS_SET;
+		vht_cfg.mcs_rx_set = DISABLE_VHT_MCS_SET;
+	} else {
+		vht_cfg.mcs_tx_set = DEFAULT_VHT_MCS_SET;
+		vht_cfg.mcs_rx_set = DEFAULT_VHT_MCS_SET;
+	}
+
+	vht_cfg.misc_config  = VHT_CAP_UAP_ONLY;
+
+	if (ap_11ac_enable && width >= NL80211_CHAN_WIDTH_80)
+		vht_cfg.misc_config |= VHT_BW_80_160_80P80;
+
+	nxpwifi_send_cmd(priv, HOST_CMD_11AC_CFG,
+			 HOST_ACT_GEN_SET, 0, &vht_cfg, true);
+}
+
+bool nxpwifi_check_11ax_capability(struct nxpwifi_private *priv,
+				   struct nxpwifi_uap_bss_param *bss_cfg,
+				   struct cfg80211_ap_settings *params)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 band = bss_cfg->band_cfg & BAND_CFG_CHAN_BAND_MASK;
+
+	if (band == BAND_2GHZ &&
+	    !(adapter->fw_bands & BAND_GAX))
+		return false;
+
+	if (band == BAND_5GHZ &&
+	    !(adapter->fw_bands & BAND_AAX))
+		return false;
+
+	if (params->he_cap)
+		return true;
+	else
+		return false;
+}
+
+int nxpwifi_set_11ax_status(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params)
+{
+	struct nxpwifi_11ax_he_cfg ax_cfg;
+	u8 band = bss_cfg->band_cfg & BAND_CFG_CHAN_BAND_MASK;
+	const struct element *he_cap;
+	int ret;
+
+	if (band == BAND_2GHZ)
+		ax_cfg.band = BIT(0);
+	else if (band == BAND_5GHZ)
+		ax_cfg.band = BIT(1);
+	else
+		return -EINVAL;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_11AX_CFG,
+			       HOST_ACT_GEN_GET, 0, &ax_cfg, true);
+	if (ret)
+		return ret;
+
+	he_cap = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
+					params->beacon.tail,
+					params->beacon.tail_len);
+
+	if (he_cap) {
+		ax_cfg.he_cap_cfg.id = he_cap->id;
+		ax_cfg.he_cap_cfg.len = he_cap->datalen;
+		if (params->twt_responder == 0) {
+			struct nxpwifi_11ax_he_cap_cfg *he_cap_cfg =
+			(struct nxpwifi_11ax_he_cap_cfg *)he_cap;
+
+			he_cap_cfg->cap_elem.mac_cap_info[0] &=
+				~HE_MAC_CAP_TWT_RESP_SUPPORT;
+		}
+		memcpy(ax_cfg.data + 4,
+		       he_cap->data,
+		       he_cap->datalen);
+	} else {
+		/* disable */
+		if (ax_cfg.he_cap_cfg.len &&
+		    ax_cfg.he_cap_cfg.ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+			memset(ax_cfg.he_cap_cfg.he_txrx_mcs_support, 0xff,
+			       sizeof(ax_cfg.he_cap_cfg.he_txrx_mcs_support));
+		}
+	}
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_11AX_CFG,
+				HOST_ACT_GEN_SET, 0, &ax_cfg, true);
+}
+
+/* This function finds supported rates IE from beacon parameter and sets
+ * these rates into bss_config structure.
+ */
+void
+nxpwifi_set_uap_rates(struct nxpwifi_uap_bss_param *bss_cfg,
+		      struct cfg80211_ap_settings *params)
+{
+	struct element *rate_ie;
+	int var_offset = offsetof(struct ieee80211_mgmt, u.beacon.variable);
+	const u8 *var_pos = params->beacon.head + var_offset;
+	int len = params->beacon.head_len - var_offset;
+	u8 rate_len = 0;
+
+	rate_ie = (void *)cfg80211_find_ie(WLAN_EID_SUPP_RATES, var_pos, len);
+	if (rate_ie) {
+		if (rate_ie->datalen > NXPWIFI_SUPPORTED_RATES)
+			return;
+		memcpy(bss_cfg->rates, rate_ie + 1, rate_ie->datalen);
+		rate_len = rate_ie->datalen;
+	}
+
+	rate_ie = (void *)cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES,
+					   params->beacon.tail,
+					   params->beacon.tail_len);
+	if (rate_ie) {
+		if (rate_ie->datalen > NXPWIFI_SUPPORTED_RATES - rate_len)
+			return;
+		memcpy(bss_cfg->rates + rate_len,
+		       rate_ie + 1, rate_ie->datalen);
+	}
+}
+
+/* This function initializes some of nxpwifi_uap_bss_param variables.
+ * This helps FW in ignoring invalid values. These values may or may not
+ * be get updated to valid ones at later stage.
+ */
+void nxpwifi_set_sys_config_invalid_data(struct nxpwifi_uap_bss_param *config)
+{
+	config->bcast_ssid_ctl = 0x7F;
+	config->radio_ctl = 0x7F;
+	config->dtim_period = 0x7F;
+	config->beacon_period = 0x7FFF;
+	config->auth_mode = 0x7F;
+	config->rts_threshold = 0x7FFF;
+	config->frag_threshold = 0x7FFF;
+	config->retry_limit = 0x7F;
+	config->qos_info = 0xFF;
+}
+
+/* This function parses WMM related parameters from cfg80211_ap_settings
+ * structure and updates bss_config structure.
+ */
+void
+nxpwifi_set_wmm_params(struct nxpwifi_private *priv,
+		       struct nxpwifi_uap_bss_param *bss_cfg,
+		       struct cfg80211_ap_settings *params)
+{
+	const u8 *vendor_ie;
+	const u8 *wmm_ie;
+	static const u8 wmm_oui[] = {0x00, 0x50, 0xf2, 0x02};
+
+	vendor_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+					    WLAN_OUI_TYPE_MICROSOFT_WMM,
+					    params->beacon.tail,
+					    params->beacon.tail_len);
+	if (vendor_ie) {
+		wmm_ie = vendor_ie;
+		if (*(wmm_ie + 1) > sizeof(struct nxpwifi_types_wmm_info))
+			return;
+		memcpy(&bss_cfg->wmm_info, wmm_ie +
+		       sizeof(struct element), *(wmm_ie + 1));
+		priv->wmm_enabled = 1;
+	} else {
+		memset(&bss_cfg->wmm_info, 0, sizeof(bss_cfg->wmm_info));
+		memcpy(&bss_cfg->wmm_info.oui, wmm_oui, sizeof(wmm_oui));
+		bss_cfg->wmm_info.subtype = NXPWIFI_WMM_SUBTYPE;
+		bss_cfg->wmm_info.version = NXPWIFI_WMM_VERSION;
+		priv->wmm_enabled = 0;
+	}
+
+	bss_cfg->qos_info = 0x00;
+}
+
+/* This function enable 11D if userspace set the country IE.
+ */
+void nxpwifi_config_uap_11d(struct nxpwifi_private *priv,
+			    struct cfg80211_beacon_data *beacon_data)
+{
+	enum state_11d_t state_11d;
+	const u8 *country_ie;
+
+	country_ie = cfg80211_find_ie(WLAN_EID_COUNTRY, beacon_data->tail,
+				      beacon_data->tail_len);
+	if (country_ie) {
+		/* Send cmd to FW to enable 11D function */
+		state_11d = ENABLE_11D;
+		if (nxpwifi_send_cmd(priv, HOST_CMD_802_11_SNMP_MIB,
+				     HOST_ACT_GEN_SET, DOT11D_I,
+				     &state_11d, true)) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "11D: failed to enable 11D\n");
+		}
+	}
+}
+
+void nxpwifi_uap_set_channel(struct nxpwifi_private *priv,
+			     struct nxpwifi_uap_bss_param *bss_cfg,
+			     struct cfg80211_chan_def chandef)
+{
+	u8 config_bands = 0, old_bands = priv->config_bands;
+
+	priv->bss_chandef = chandef;
+
+	bss_cfg->channel =
+		ieee80211_frequency_to_channel(chandef.chan->center_freq);
+
+	nxpwifi_convert_chan_to_band_cfg(priv, &bss_cfg->band_cfg, &chandef);
+
+	/* Set appropriate bands */
+	if (chandef.chan->band == NL80211_BAND_2GHZ) {
+		config_bands = BAND_B | BAND_G;
+		if (chandef.width > NL80211_CHAN_WIDTH_20_NOHT)
+			config_bands |= BAND_GN | BAND_GAX;
+	} else {
+		config_bands = BAND_A;
+		if (chandef.width > NL80211_CHAN_WIDTH_20_NOHT)
+			config_bands |= BAND_AN;
+		if (chandef.width > NL80211_CHAN_WIDTH_40)
+			config_bands |= BAND_AAC | BAND_AAX;
+	}
+
+	priv->config_bands = config_bands;
+
+	if (old_bands != config_bands) {
+		if (nxpwifi_band_to_radio_type(priv->config_bands) ==
+		    HOST_SCAN_RADIO_TYPE_BG)
+			nxpwifi_send_domain_info_cmd_fw(priv->adapter->wiphy,
+							NL80211_BAND_2GHZ);
+		else
+			nxpwifi_send_domain_info_cmd_fw(priv->adapter->wiphy,
+							NL80211_BAND_5GHZ);
+		nxpwifi_dnld_txpwr_table(priv);
+	}
+}
+
+int nxpwifi_config_start_uap(struct nxpwifi_private *priv,
+			     struct nxpwifi_uap_bss_param *bss_cfg)
+{
+	int ret;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_UAP_SYS_CONFIG,
+			       HOST_ACT_GEN_SET,
+			       UAP_BSS_PARAMS_I, bss_cfg, true);
+	if (ret) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to set AP configuration\n");
+		return ret;
+	}
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_START,
+			       HOST_ACT_GEN_SET, 0, NULL, true);
+	if (ret) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to start the BSS\n");
+		return ret;
+	}
+
+	if (priv->sec_info.wep_enabled)
+		priv->curr_pkt_filter |= HOST_ACT_MAC_WEP_ENABLE;
+	else
+		priv->curr_pkt_filter &= ~HOST_ACT_MAC_WEP_ENABLE;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_MAC_CONTROL,
+			       HOST_ACT_GEN_SET, 0,
+			       &priv->curr_pkt_filter, true);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/uap_event.c b/drivers/net/wireless/nxp/nxpwifi/uap_event.c
new file mode 100644
index 000000000000..d3b567472c68
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/uap_event.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: AP event handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "11n.h"
+
+#define NXPWIFI_BSS_START_EVT_FIX_SIZE    12
+
+static int
+nxpwifi_uap_event_ps_awake(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (!adapter->pps_uapsd_mode &&
+	    priv->media_connected && adapter->sleep_period.period) {
+		adapter->pps_uapsd_mode = true;
+		nxpwifi_dbg(adapter, EVENT,
+			    "event: PPS/UAPSD mode activated\n");
+	}
+	adapter->tx_lock_flag = false;
+	if (adapter->pps_uapsd_mode && adapter->gen_null_pkt) {
+		if (nxpwifi_check_last_packet_indication(priv)) {
+			if (adapter->data_sent) {
+				adapter->ps_state = PS_STATE_AWAKE;
+				adapter->pm_wakeup_card_req = false;
+				adapter->pm_wakeup_fw_try = false;
+			} else {
+				if (!nxpwifi_send_null_packet
+				    (priv,
+				     NXPWIFI_TxPD_POWER_MGMT_NULL_PACKET |
+				     NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET))
+					adapter->ps_state = PS_STATE_SLEEP;
+			}
+
+			return 0;
+		}
+	}
+
+	adapter->ps_state = PS_STATE_AWAKE;
+	adapter->pm_wakeup_card_req = false;
+	adapter->pm_wakeup_fw_try = false;
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_ps_sleep(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	adapter->ps_state = PS_STATE_PRE_SLEEP;
+	nxpwifi_check_ps_cond(adapter);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_sta_deauth(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 *deauth_mac;
+
+	deauth_mac = adapter->event_body +
+		     NXPWIFI_UAP_EVENT_EXTRA_HEADER;
+	cfg80211_del_sta(priv->netdev, deauth_mac, GFP_KERNEL);
+
+	if (priv->ap_11n_enabled) {
+		nxpwifi_11n_del_rx_reorder_tbl_by_ta(priv, deauth_mac);
+		nxpwifi_del_tx_ba_stream_tbl_by_ra(priv, deauth_mac);
+	}
+	nxpwifi_wmm_del_peer_ra_list(priv, deauth_mac);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_sta_assoc(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct station_info *sinfo;
+	struct nxpwifi_assoc_event *event;
+	struct nxpwifi_sta_node *node;
+	int len, i;
+
+	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+	if (!sinfo)
+		return -ENOMEM;
+
+	event = (struct nxpwifi_assoc_event *)
+		(adapter->event_body + NXPWIFI_UAP_EVENT_EXTRA_HEADER);
+	if (le16_to_cpu(event->type) == TLV_TYPE_UAP_MGMT_FRAME) {
+		len = -1;
+
+		if (ieee80211_is_assoc_req(event->frame_control))
+			len = 0;
+		else if (ieee80211_is_reassoc_req(event->frame_control))
+			/* There will be ETH_ALEN bytes of
+			 * current_ap_addr before the re-assoc ies.
+			 */
+			len = ETH_ALEN;
+
+		if (len != -1) {
+			sinfo->assoc_req_ies = &event->data[len];
+			len = (u8 *)sinfo->assoc_req_ies -
+			      (u8 *)&event->frame_control;
+			sinfo->assoc_req_ies_len =
+				le16_to_cpu(event->len) - (u16)len;
+		}
+	}
+	cfg80211_new_sta(priv->netdev, event->sta_addr, sinfo,
+			 GFP_KERNEL);
+
+	node = nxpwifi_add_sta_entry(priv, event->sta_addr);
+	if (!node) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "could not create station entry!\n");
+		kfree(sinfo);
+		return -ENOENT;
+	}
+
+	if (!priv->ap_11n_enabled) {
+		kfree(sinfo);
+		return 0;
+	}
+
+	nxpwifi_set_sta_ht_cap(priv, sinfo->assoc_req_ies,
+			       sinfo->assoc_req_ies_len, node);
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		if (node->is_11n_enabled || node->is_11ax_enabled)
+			node->ampdu_sta[i] =
+				      priv->aggr_prio_tbl[i].ampdu_user;
+		else
+			node->ampdu_sta[i] = BA_STREAM_NOT_ALLOWED;
+	}
+	memset(node->rx_seq, 0xff, sizeof(node->rx_seq));
+	kfree(sinfo);
+
+	return 0;
+}
+
+static int
+nxpwifi_check_uap_capabilities(struct nxpwifi_private *priv,
+			       struct sk_buff *event)
+{
+	int evt_len;
+	u8 *curr;
+	u16 tlv_len;
+	struct nxpwifi_ie_types_data *tlv_hdr;
+	struct ieee80211_wmm_param_ie *wmm_param_ie = NULL;
+	int mask = IEEE80211_WMM_IE_AP_QOSINFO_PARAM_SET_CNT_MASK;
+
+	priv->wmm_enabled = false;
+	skb_pull(event, NXPWIFI_BSS_START_EVT_FIX_SIZE);
+	evt_len = event->len;
+	curr = event->data;
+
+	nxpwifi_dbg_dump(priv->adapter, EVT_D, "uap capabilities:",
+			 event->data, event->len);
+
+	skb_push(event, NXPWIFI_BSS_START_EVT_FIX_SIZE);
+
+	while ((evt_len >= sizeof(tlv_hdr->header))) {
+		tlv_hdr = (struct nxpwifi_ie_types_data *)curr;
+		tlv_len = le16_to_cpu(tlv_hdr->header.len);
+
+		if (evt_len < tlv_len + sizeof(tlv_hdr->header))
+			break;
+
+		switch (le16_to_cpu(tlv_hdr->header.type)) {
+		case WLAN_EID_HT_CAPABILITY:
+			priv->ap_11n_enabled = true;
+			break;
+
+		case WLAN_EID_VHT_CAPABILITY:
+			priv->ap_11ac_enabled = true;
+			break;
+
+		case WLAN_EID_VENDOR_SPECIFIC:
+			/* Point the regular IEEE IE 2 bytes into the NXP IE
+			 * and setup the IEEE IE type and length byte fields
+			 */
+			wmm_param_ie = (void *)(curr + 2);
+			wmm_param_ie->len = (u8)tlv_len;
+			wmm_param_ie->element_id =
+						WLAN_EID_VENDOR_SPECIFIC;
+			nxpwifi_dbg(priv->adapter, EVENT,
+				    "info: check uap capabilities:\t"
+				    "wmm parameter set count: %d\n",
+				    wmm_param_ie->qos_info & mask);
+
+			nxpwifi_wmm_setup_ac_downgrade(priv);
+			priv->wmm_enabled = true;
+			nxpwifi_wmm_setup_queue_priorities(priv, wmm_param_ie);
+			break;
+
+		default:
+			break;
+		}
+
+		curr += (tlv_len + sizeof(tlv_hdr->header));
+		evt_len -= (tlv_len + sizeof(tlv_hdr->header));
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_bss_start(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	priv->port_open = false;
+	eth_hw_addr_set(priv->netdev, adapter->event_body + 2);
+	if (priv->hist_data)
+		nxpwifi_hist_data_reset(priv);
+	return nxpwifi_check_uap_capabilities(priv, adapter->event_skb);
+}
+
+static int
+nxpwifi_uap_event_addba(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (priv->media_connected)
+		nxpwifi_send_cmd(priv, HOST_CMD_11N_ADDBA_RSP,
+				 HOST_ACT_GEN_SET, 0,
+				 adapter->event_body, false);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_delba(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (priv->media_connected)
+		nxpwifi_11n_delete_ba_stream(priv, adapter->event_body);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_ba_stream_timeout(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_11n_batimeout *ba_timeout;
+
+	if (priv->media_connected) {
+		ba_timeout = (void *)adapter->event_body;
+		nxpwifi_11n_ba_stream_timeout(priv, ba_timeout);
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_amsdu_aggr_ctrl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 ctrl;
+
+	ctrl = get_unaligned_le16(adapter->event_body);
+	nxpwifi_dbg(adapter, EVENT,
+		    "event: AMSDU_AGGR_CTRL %d\n", ctrl);
+
+	if (priv->media_connected) {
+		adapter->tx_buf_size =
+			min_t(u16, adapter->curr_tx_buf_size, ctrl);
+		nxpwifi_dbg(adapter, EVENT,
+			    "event: tx_buf_size %d\n",
+			    adapter->tx_buf_size);
+	}
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_bss_idle(struct nxpwifi_private *priv)
+{
+	priv->media_connected = false;
+	priv->port_open = false;
+	nxpwifi_clean_txrx(priv);
+	nxpwifi_del_all_sta_list(priv);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_bss_active(struct nxpwifi_private *priv)
+{
+	priv->media_connected = true;
+	priv->port_open = true;
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_mic_countermeasures(struct nxpwifi_private *priv)
+{
+	/* For future development */
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_radar_detected(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	return nxpwifi_11h_handle_radar_detected(priv, adapter->event_skb);
+}
+
+static int
+nxpwifi_uap_event_channel_report_rdy(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	return nxpwifi_11h_handle_chanrpt_ready(priv, adapter->event_skb);
+}
+
+static int
+nxpwifi_uap_event_tx_data_pause(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_process_tx_pause_event(priv, adapter->event_skb);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_ext_scan_report(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	void *buf = adapter->event_skb->data;
+	int ret = 0;
+
+	if (adapter->ext_scan)
+		ret = nxpwifi_handle_event_ext_scan_report(priv, buf);
+
+	return ret;
+}
+
+static int
+nxpwifi_uap_event_rxba_sync(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_11n_rxba_sync_event(priv, adapter->event_body,
+				    adapter->event_skb->len -
+				    sizeof(adapter->event_cause));
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_remain_on_chan_expired(struct nxpwifi_private *priv)
+{
+	cfg80211_remain_on_channel_expired(&priv->wdev,
+					   priv->roc_cfg.cookie,
+					   &priv->roc_cfg.chan,
+					   GFP_ATOMIC);
+	memset(&priv->roc_cfg, 0x00, sizeof(struct nxpwifi_roc_cfg));
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_multi_chan_info(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_process_multi_chan_event(priv, adapter->event_skb);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_tx_status_report(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_parse_tx_status_event(priv, adapter->event_body);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_bt_coex_wlan_para_change(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	nxpwifi_bt_coex_wlan_param_update_event(priv, adapter->event_skb);
+
+	return 0;
+}
+
+static int
+nxpwifi_uap_event_vdll_ind(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	return nxpwifi_process_vdll_event(priv, adapter->event_skb);
+}
+
+static const struct nxpwifi_evt_entry evt_table_uap[] = {
+	{.event_cause = EVENT_PS_AWAKE,
+	 .event_handler = nxpwifi_uap_event_ps_awake},
+	{.event_cause = EVENT_PS_SLEEP,
+	 .event_handler = nxpwifi_uap_event_ps_sleep},
+	{.event_cause = EVENT_UAP_STA_DEAUTH,
+	 .event_handler = nxpwifi_uap_event_sta_deauth},
+	{.event_cause = EVENT_UAP_STA_ASSOC,
+	 .event_handler = nxpwifi_uap_event_sta_assoc},
+	{.event_cause = EVENT_UAP_BSS_START,
+	 .event_handler = nxpwifi_uap_event_bss_start},
+	{.event_cause = EVENT_ADDBA,
+	 .event_handler = nxpwifi_uap_event_addba},
+	{.event_cause = EVENT_DELBA,
+	 .event_handler = nxpwifi_uap_event_delba},
+	{.event_cause = EVENT_BA_STREAM_TIEMOUT,
+	 .event_handler = nxpwifi_uap_event_ba_stream_timeout},
+	{.event_cause = EVENT_AMSDU_AGGR_CTRL,
+	 .event_handler = nxpwifi_uap_event_amsdu_aggr_ctrl},
+	{.event_cause = EVENT_UAP_BSS_IDLE,
+	 .event_handler = nxpwifi_uap_event_bss_idle},
+	{.event_cause = EVENT_UAP_BSS_ACTIVE,
+	 .event_handler = nxpwifi_uap_event_bss_active},
+	{.event_cause = EVENT_UAP_MIC_COUNTERMEASURES,
+	 .event_handler = nxpwifi_uap_event_mic_countermeasures},
+	{.event_cause = EVENT_RADAR_DETECTED,
+	 .event_handler = nxpwifi_uap_event_radar_detected},
+	{.event_cause = EVENT_CHANNEL_REPORT_RDY,
+	 .event_handler = nxpwifi_uap_event_channel_report_rdy},
+	{.event_cause = EVENT_TX_DATA_PAUSE,
+	 .event_handler = nxpwifi_uap_event_tx_data_pause},
+	{.event_cause = EVENT_EXT_SCAN_REPORT,
+	 .event_handler = nxpwifi_uap_event_ext_scan_report},
+	{.event_cause = EVENT_RXBA_SYNC,
+	 .event_handler = nxpwifi_uap_event_rxba_sync},
+	{.event_cause = EVENT_REMAIN_ON_CHAN_EXPIRED,
+	 .event_handler = nxpwifi_uap_event_remain_on_chan_expired},
+	{.event_cause = EVENT_MULTI_CHAN_INFO,
+	 .event_handler = nxpwifi_uap_event_multi_chan_info},
+	{.event_cause = EVENT_TX_STATUS_REPORT,
+	 .event_handler = nxpwifi_uap_event_tx_status_report},
+	{.event_cause = EVENT_BT_COEX_WLAN_PARA_CHANGE,
+	 .event_handler = nxpwifi_uap_event_bt_coex_wlan_para_change},
+	{.event_cause = EVENT_VDLL_IND,
+	 .event_handler = nxpwifi_uap_event_vdll_ind},
+};
+
+/* This function handles AP interface specific events generated by firmware.
+ *
+ * Event specific routines are called by this function based
+ * upon the generated event cause.
+ */
+int nxpwifi_process_uap_event(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u32 eventcause = adapter->event_cause;
+	int evt, ret = 0;
+
+	for (evt = 0; evt < ARRAY_SIZE(evt_table_uap); evt++) {
+		if (eventcause == evt_table_uap[evt].event_cause) {
+			if (evt_table_uap[evt].event_handler)
+				ret = evt_table_uap[evt].event_handler(priv);
+			break;
+		}
+	}
+
+	if (evt == ARRAY_SIZE(evt_table_uap))
+		nxpwifi_dbg(adapter, EVENT,
+			    "%s: unknown event id: %#x\n",
+			    __func__, eventcause);
+	else
+		nxpwifi_dbg(adapter, EVENT,
+			    "%s: event id: %#x\n",
+			    __func__, eventcause);
+
+	return ret;
+}
-- 
2.34.1


