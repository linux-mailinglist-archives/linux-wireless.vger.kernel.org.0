Return-Path: <linux-wireless+bounces-29028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9495C63B47
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD45D4EC35E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C44432C327;
	Mon, 17 Nov 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fPiQ9r+p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000D32C302;
	Mon, 17 Nov 2025 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377322; cv=fail; b=E2t2vXhnLsZkzEfpq9LMLcQPkVfSqNcN0R3GUhup9W0Th6uKbM+C6jHdoFBozIrSGaiZnP7c+eB5cm8KQzbfDf4qHeUHwFK/o5vMNT1wRDA7DyxvaDjhDhXx+ZFgIbQIZ4ll/7k6SDgCTZjt/GGnbnZRi48fNtBYbc0VJapdPgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377322; c=relaxed/simple;
	bh=KdgkcdUxP6vWmouClIcRvOLQqcd5uao2VEdGAYKM62s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MB52AoL6uFowFrESm3Vr/hnvYxnTyssm8cs0E/KO3pQEuIPQc0/maYY8xP9XD7FETLh7gk2ToZ6qDuuLcD2iXFJZojpRays+wpZJv/j0dFaD0Q0t5uIRFNddj4AD1pcIu9I08Bo34vI6B04O8Nvq1y3RMQaJ0Ffqtol6yGTZg8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fPiQ9r+p; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2aaL7bLpUT7Lq1xPL5bfRgcONKerFrZ3B3qK+bL/dz7lcgZ2HjjA1axDw0jPabIiZ2eg0+TAoAVsniYldQI2UN2YzUw2bt1d94sUFKryvTeKPlnv5DJJCGnqroScR7CAP036pFQnzz1pS+uJdwWfK1aNITXyS/+8gNecq3oIUY5gdX8SgCKvKJjU0vrPgqfIHzcgOzGmnaH6UbWHt61N+594j0XtuvD+0b5Hp26IxpzLMKeAPqTutcJUwftjm42z/Iunjl9czoVBppWR+fPajMlq35mCJwikrRem0T5A1dTAOGwxFLj/kpT4lNx2P02WKC1P6eZxXzX90rrSYWN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THMg+NHJ+U0g3ZtORGjo2bxlp2i73+lkpN2+ibuy6v8=;
 b=qK4WUByLPEeXfLfCNe8bEXmlc/TVqoWIlzyl9L0jEuuemNCtyXJzUYKN7GGqbMqb9o1UFsHKblv2m6Spr30RB+HHNScUnrPDzTh+HDFy+1rPXmXMG03UWyM7oXNwqoGfLAfWwahAGucdS+lfQQTgmodqgGW8N5Y0pW6rb7eW/88XyRJs1OYYKLSIeAUDRJkxLN7jKVE4QOr+Y/O/R596lxnhHlgQg6+UxuWzXvvcLhHB6Qjqd6tLcPsLUqjiK93i9RSxizTiUpoAiNZjRTDItoLTugsV/rRYOdba2XGP821H3KJvBkL8KXrPImtIG1QV7hiWGcsVyHAEAkUDCLGgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THMg+NHJ+U0g3ZtORGjo2bxlp2i73+lkpN2+ibuy6v8=;
 b=fPiQ9r+pgCjI/kMlPJkXe3XkYrxmKWlJHaSLPuVydQUuNiBLaK3Hm0KgQ2z5sP7yXDJ9f6jJc3jbgJVEnXAi1BZOTfIPkvYvweUnCMtZUIMBP/m3G5op1y8978sGf8WrB2BN74mDYrwTSfc+Y351C1n19x6RMI9GJgCggO5G4+XkUVz5wVi0ED0ECVWDGJbduC9sJs5Qy/B2ii5DpBYi649NR4q9hOkEpoXnsaBMxohPZD0F5RTPW81qjyK1DQUI6ksSV3zvWfEqZDCif99sQTfVvc/oZ9m2u2zmn7iCN1x+XEwSvBB6p23CkFNhkmWesCcR0IHor1YPfLDa7JPHlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GVXPR04MB11542.eurprd04.prod.outlook.com (2603:10a6:150:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:01:54 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:01:54 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 02/22] wifi: nxpwifi: add initial support for 802.11ac
Date: Mon, 17 Nov 2025 19:00:26 +0800
Message-Id: <20251117110046.2810811-3-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GVXPR04MB11542:EE_
X-MS-Office365-Filtering-Correlation-Id: 57982b3e-a4e3-4fbe-a810-08de25c8b807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F93n4WrWzMD+xUoSe8KO2yVMpiP4TlDbYtsVoWf8rnLq2vNvWedQ+pGiSMql?=
 =?us-ascii?Q?1e94kZiZQ5VKUyZfIHFn6wenzKfT8LDv/78I4FNvp8FtJ8cnl73kGk3NEVky?=
 =?us-ascii?Q?GldAD0Gl4h4cv+aw5P+vD3flY9AglMpLXgbjA7JgVeJDWTypA3vqkIz76lrg?=
 =?us-ascii?Q?egca69Fjib1n23l9d8LGjK97WbSMR3C3bUVGejCduAnyOnukgVeTVK02VJkS?=
 =?us-ascii?Q?EpWbuIMge21V1mGFJ9hsYlq8hEQsUdKu+8SxMqJ+YhyPr4mS5rit7xy/gJ+S?=
 =?us-ascii?Q?vmNGYalhPClEMJgcTse1jDJLcPPiOAlPnhggADyoKhDmqoDPto1t3tITT5F8?=
 =?us-ascii?Q?RmMnNh6FRkTpJq0/Mcv9VOK5SjAaBsZ8hQMSulZq9cv9CLcIZvB5NozLlCns?=
 =?us-ascii?Q?ywoVhwpqC9te8ue+mPuA/wkmLq6q9VSqGulZe/0bcX8XLBT9BPDrx4QT0T/0?=
 =?us-ascii?Q?tFdPHfs6V6PufawkRALLTeZ2OLU4skI/ZwMbVtsNcCEbUBNp7hzxnpoDng8j?=
 =?us-ascii?Q?/6u7bqnFjaHvlBkgxcDTST7eyMUUNYX4YW567WPdI+14zZgIC8uE0oXWccLM?=
 =?us-ascii?Q?Nr2lgmO/gUC5718NDYfNiRM/ym3mVxIE0GBAsN9fjmcuSKPnvUE7gGrelPFB?=
 =?us-ascii?Q?ay4fNa/AprzyvLXeZF+Kkhc3vGKqoZwlZzTQ8+N4+jgugMeGSTuFrt6DcRAs?=
 =?us-ascii?Q?+ZutZ3eW7Br76M2dNdRQVv4VeQdI4fZ92OMr8yQ9kODbhxWSN+9WFN802WAo?=
 =?us-ascii?Q?SfJeQeGoiavCH22L0tmBjyQFidXphFh5x1HQQoOPCeVJ/KPF+LyIOl8UyJl8?=
 =?us-ascii?Q?lAYVXSCRvEZLy1h/OZ5klHSZSK1jy3SbE0odDBNa0HQvi48QeTapCQnh0buH?=
 =?us-ascii?Q?0ESJjLnS3D6Vv7urknzqQra8H3H4wivCprkQWcFKVyADJdoe02X9puU2dC3s?=
 =?us-ascii?Q?NYvom4J4QoJrGSs/63aK9OOAvyZ2eIDCGXtHAzhm+7Ui5wd2CEjvP0XFj6Px?=
 =?us-ascii?Q?lmCcZdC9Re29bAFY6RJjqH8C5yB1ahtnQvWljmc6A1vEahcEW+JDbXeQogv4?=
 =?us-ascii?Q?ozayyN5zvmwQQUN+bvBYmz6FcTqeUIAYJXvSqeIX040gCQLJQQBorqmfYaq0?=
 =?us-ascii?Q?knKXxSf7HS8OCV+UZEW8Gye9xsBhRUJg+DapC0et315Z0M+DZrYK/v5DgkYo?=
 =?us-ascii?Q?tnWIKK0LyUL72UHt5ynOgSJrEV9pBsaF95Y0gkN15tqlftJZwKrgWcoodbxc?=
 =?us-ascii?Q?QRl5N8TuwQW99FNWiMa8MWEJW7Thu9tPeFDU/C1uLMqYzptoXrs1xZ6KQv2Z?=
 =?us-ascii?Q?cDQ0gsu/XKdNiEXq8p3InSN8Cwf4xFP3zPWVHbO5J4xnYlO3b2NViQ2U9xXv?=
 =?us-ascii?Q?N9oeoq4n5RBN12rky8h7EjTPR20lP5quCB/qnPkyfSS42v/KQg2pRRmH40y9?=
 =?us-ascii?Q?se+EqgvWJiWVwovW6ifxEwj3RCmSq+ES+eaVDAbd8jqxZnPb+Z9degYJ+Q3w?=
 =?us-ascii?Q?4TSKLLvjSaDk7/iSy6eaihhAR20CC4EWnRPY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37Ydhk0BeSK4v0sIDsRqyPEIUWGqT/n+IiRYOdUCs4ZvJ8YTKVMIJbuhsq/S?=
 =?us-ascii?Q?knMkFYn6rxp9/PXNP3QRlsiVN0aemVvE2Za6/41OGop8DwXJ+BzC8QtSHSKU?=
 =?us-ascii?Q?L74Q9bCqFsywMUYzVEDz3Xm06JI+cNJHxn51s3soh34me8XeR2L0hNyVajXs?=
 =?us-ascii?Q?pB4+vRD/iX9c3oyf0JJvmAXHm9EuYpaiGZtOAXKY9qflKL6F8u97IBRK38df?=
 =?us-ascii?Q?t9zDmCyxsmXPFxAywL09uYG5prnKs78XKC2LJuDSyRrPyVi88UUnWVXaStnE?=
 =?us-ascii?Q?TLUex3VM9FXVJuLy4vp2TclwCIOKUKFxAaa64oNFTW0Diq9w+poq13iQk84F?=
 =?us-ascii?Q?Qwsac9uMzMpiQbMyas42MfElEWJKOGvzjgiOmk8Unlf2pmnpK26uoSzbk2jC?=
 =?us-ascii?Q?txrQIwPC/OESYSqmMoiBAgpLTzOEW6PrBDMyuUa4l4KiRScvFVjwZXtB+K5/?=
 =?us-ascii?Q?nm7vU2viyYoRGFad7VOFl2S2e3J+wirMK+pylXRIlYo0KUgtxDgqbSBAW1HS?=
 =?us-ascii?Q?zTkq+8O1tdv/NnxygXWE/GQTHRSqOamyhBltaTKynJ1CSyhasucVbhv8mqX5?=
 =?us-ascii?Q?3UR77wlF5GH0X8VXCzySSxe1dEXesb/kKy0rGa5jraJnOYnfmTVdV/2RWJth?=
 =?us-ascii?Q?Ceig4oWbXH1z5LjXwu6sc7ETpPSB2DoDSEEXGSInnziqVf8HSUtxhnJM/ZtG?=
 =?us-ascii?Q?w8PZra4o9nXkVtZaOO0te6AMQ5jUtJSInh02mcXvXfFZof0V+uleNVTI9bge?=
 =?us-ascii?Q?0wpvDGV2MSQBSM/2vJ6fAQKuhGxbqP1tjQTakog4fVx+wdaJbz2Eq11Z2TyM?=
 =?us-ascii?Q?/o+nuz0AizBoyZDhF6XI4JjXz2q+8G0dCbG+8X8useslR+5wdEIAYDOpkAMB?=
 =?us-ascii?Q?oOoCJbLDKT1PPvzstqg6MN84RmRJ6aQWkHxAGvvVB2fipUAmBBvvsJs4en1T?=
 =?us-ascii?Q?bgf7Wq+DKONMsK7sirb7Oss1SjdAvkRdXhhS87EqVIT7k8YxRNHDx1CBYbFM?=
 =?us-ascii?Q?HQlknbBLK+dGa5UXIyR+gBz1OPTW4ahThuhGHDVZlwwGRtsj+2BsAGt8LV2H?=
 =?us-ascii?Q?k2tIbAnd7u4iyin+g6cgT8/u4KNOg6XieNRDz+5KZk0aD5GO4n+jOPWyX/15?=
 =?us-ascii?Q?Wuozc4kpePyApotr0z+OUn0uHRsOBLW8ZL3fL/qdxhL49SUrrF7x2OeRL+Ct?=
 =?us-ascii?Q?jHouX/wwJ3xaGSE1WRxqNQB/6fpYsjS5HSU3KiPJpgX8sx1sHUlV4LQkNQ+k?=
 =?us-ascii?Q?4XZPr16BE5moPP6FjweyD1gCFS8Ul2qoxzlZvvrVmvFuorvaTUGSlR/4uqBL?=
 =?us-ascii?Q?3HKGqMM6BL4FWwoYVcA/djZ3BCOZ3R4ga8YA4B0B5Ri4YdOTbWys5no3zfF4?=
 =?us-ascii?Q?KvhE8yFVZqEfdKKJjxzCboUDH6AC67q4RTU1dkxJU9jaY4uCDWNdbZ3aqtN7?=
 =?us-ascii?Q?1g02wfEmCIGFYDx9GoHD0+8GD9dTrteiGABPI5uFV030BWu7lium4zdy1Hcj?=
 =?us-ascii?Q?ToiS7LmAFkDgvdMw7QPaGl41TeKcZhVN16giVrT9wa2YpU5S/PLjpjQj0H1c?=
 =?us-ascii?Q?ULhJoGYorlgs2gE4AANGtRul4NCdvGccjZQuU76b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57982b3e-a4e3-4fbe-a810-08de25c8b807
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:01:54.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhjgFhAV+5vZWees+eeWUIgMtZKAfOGcmm0SuSpMRFEPCtiiyCKszoJwqurlR62f9UX4MWzU1OCNREpeStd9HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11542

Introduce 802.11ac feature support for both client and AP modes,
with coordination between host driver and NXP firmware.

- In client mode, the firmware assists the association process via
  HOST_CMD_802_11_ASSOCIATE. The driver converts 802.11ac IEs from
  cfg80211 parameters into TLVs and appends them to the host command.

- In AP mode, the driver converts 802.11ac IEs into parameters for
  HOST_CMD_11AC_CFG, which are then passed to the firmware for
  configuration.

This patch adds logic to handle VHT capabilities, operations, and
operating mode notifications, enabling proper negotiation and setup
of 802.11ac features through firmware interaction.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 289 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ac.h |  33 +++
 2 files changed, 322 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..0c34c0801027
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,289 @@
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
+	if (u32_get_bits(usr_vht_cap_info, IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK)) {
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
+void
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
+	/* VHT Capabilities element */
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
+	/* VHT Operation element */
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
+			supp_chwd_set = u32_get_bits(usr_vht_cap_info,
+						     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK);
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
+	/* Operating Mode Notification element */
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
index 000000000000..6fc72fab251e
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.h
@@ -0,0 +1,33 @@
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
+void nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			      struct ieee80211_vht_cap *vht_cap, u16 bands);
+#endif /* _NXPWIFI_11AC_H_ */
-- 
2.34.1


