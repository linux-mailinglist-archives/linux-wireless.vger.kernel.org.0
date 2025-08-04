Return-Path: <linux-wireless+bounces-26134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640DEB1A660
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEB43A1CC7
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0002737EB;
	Mon,  4 Aug 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aZwwCwoJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A353272813;
	Mon,  4 Aug 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322357; cv=fail; b=Bhq/fnTdxFOMU+6KctL+0AGV4J1+lzVTjYTCO1TIyPqjev5OmpkIGBVYikX47jpCEAnUjEUu/g/sEbrXcVIAvKK19JeAFGMO98xSI/RWsVqabyLpKBn5VUpmqGihaZp2eXWbK8zx2vm9c//X4Sch3/S+GkwllDYqS0vLt4Q9PfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322357; c=relaxed/simple;
	bh=DpXpEuXwTypxFHphnaL+5+MOkp+FKbs6aUsa0vGQunE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qYANJagj9alHx8QAI+zFnDGkr1jZHA01i+N11pjRBl+oxNY4L//7mC8yJsObWeckE4fzkZgoZ28L6f7SBMWxwoiuktCH3FG+2v/jKQZkZbnqIIVX1JCrWkhjgwtUSS+NkOPFECMJGgAhTF4IfkX39iea8KGaEiyVswB00gXvEFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aZwwCwoJ; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2mlxAQfJG/ow+IKcms23SPWSl4F3YVxBfv63ftn6+jSVsLkximOWnVMmxpU4X4B/lsHqJ+s0tH8FUDA89yk5rM/AbWtGqswAsRjOHmdL0duK7jb6Aq6cSc1NuAmGx5pDEpXdh6kTQLmjwW8+fa5BvM9LsNo7edU7vUs1cuwa5oDPkRd90Dc90T7j8SdvYnmlQePPM0Xnr6Stg8/rgrFw9/0iGYwgMZoYfuFN6SVQT4DDdB/86Hgj6qgN3STWMVmcTX9ddjNkZAh+Y7WjTfmIh7XFCuIivFYeISgbBO5FowD8t6hH9mx4f7CYorX6j8VW6ao4Z1PLO/3SkTgWeecfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62dxwVV2aYWl76zejSmTTPrBbDsNo05ergbOZ7HWAP4=;
 b=NYzuCqdMrzTX4EHDt/H3PaNV53KJwNvCEWwqhPiSeOcJaw38D/zH84Jy0dAwi4knUmFRztHyftg+CMAhnzFbIgMdAKHIp2gPmtnz56RuuxdT7alujTceTOvd4+rBLw1b1VHCEEqZrrhjoRJ1LtupqTCKWrtb1/chT3HeEv6+PTisibDpqRMNVKMmru/VTCU/+fh05DuGI/jdsW6UjMqlO1te/J2Qoqu1p4s6DuIgm81/3jwaxL+gZR9N/emXvJhda8dnWjbkSiYinWzmhv7Y2qXyqUbCNor4enpe1lKmyj23PzgZKu3p6iaNIJd05cpz/MG5mtETxH/YzNvOtdgyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62dxwVV2aYWl76zejSmTTPrBbDsNo05ergbOZ7HWAP4=;
 b=aZwwCwoJT12j9I+GGGWfsQLf7G/UPJVkapQT+GBSSfE88oM5IQGUnVA5I2LArHx5eXICWh/oQ9edw7KQMhsDmEnjdkR2tmpLbKXHmaDPsNsOn2+aPQP+AMK3OOQ7WrdB7i8QyTsjrgsLzNw/eePzLJ//YCkX9Ac9wTrnXIPVofx+1VttwngOEYyXBu4K3qftimHBfLTlLpdGSiaOZ23goYOSFPe9SMMLsecy8Dh1n3Q28GaOTZvEPNtAp4gDnECgAp0qlrm23CtIhIaWb3x2E8CSxoHkpP46sE6kbccLaWrYjI2cU+YUblJdbt1JSQ+d1qmORdkIzvBJIQPxCXfcRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:45:52 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:45:52 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	brian.hsu@nxp.com,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v5 04/22] wifi: nxpwifi: add 802.11h file
Date: Mon,  4 Aug 2025 23:40:00 +0800
Message-Id: <20250804154018.3563834-5-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PAXPR04MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc5d49d-17ed-417e-5e64-08ddd36dfe33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MeupYjY5hYjpgeHOGeOfe9mKQh/DNplfimBScmQdor47o0F3jo1s8mTeTv42?=
 =?us-ascii?Q?4cfI5UrkehA8TW9saI3R5QIeIIUAk5G0hdsfl86AzRC+77DCxZDBFozD2iBc?=
 =?us-ascii?Q?ezt12JU5rjrN6RRvip5zosnOSX9m5PQ9W+Z91ndQceC/FLYeN3XnBUX4b9Cw?=
 =?us-ascii?Q?x+2JSUaypQfuVW5lTD0YnVvPt7/Egh5/DysEnvKGVgaBV2ND8hC7oFO83DmO?=
 =?us-ascii?Q?LamZ49ZudWbfoNOSTSstQI3otwmBIFtlU0cCexU6pEBIuXie12xF/L+iXo88?=
 =?us-ascii?Q?rENeh0/p0z6BfWKRdq6ACWtWNYmgQeOja+R/Nqxb6CWk3u0vVYJidEPKK6qf?=
 =?us-ascii?Q?qQFB6q212cYVCmwD5DSPQpUK23Phirqf3CYSZ4NG1StdrwfAqeOanb/0jMh6?=
 =?us-ascii?Q?S7B/w3XYWjR8BtSV8IwqXgLWdZrleOtPhDolqbWlrXJvL41U/5UooK9XS94Z?=
 =?us-ascii?Q?n+gEZfygs3XHvDeUes+4xs3pRRCkeahW7KMsqSKhob8tT/9MSIT8tGCiuLmq?=
 =?us-ascii?Q?KVRh802ShaKJS3qHmRGj1tT++UdsnX+2rfNg17NRrS/NP/g+6aJcVIRx87MG?=
 =?us-ascii?Q?Bs3fFon5uz2ov4DuA9KQ//iwXmsdwPQlk3CZLTR3a1BVlqKIFLOI+XlPtyMw?=
 =?us-ascii?Q?Mpz4gWTGkBJ+1VEhMc84OB0ur+aiBicB2DTIe1GQugtswSGCuCEQ+SJPFApN?=
 =?us-ascii?Q?nBBpsq6hAAIcqoqP3tZ4vYnhbvriauLcK3nLVl3sFmRrRb9KEBlNR3C64tAB?=
 =?us-ascii?Q?YUbnWMQ1hl+ZPHW/Mwpq+bo9soDh/cljM61t4eZpA/4KxEiZjfgVLLwQnQWC?=
 =?us-ascii?Q?xREok7fXCM/lLF3nVWGC3X+U8d5yhG1cxG35jy0OwzII0ZNlUy6k9X0aVtJO?=
 =?us-ascii?Q?r1aLoazkvptptR7A9YGu8t0hrCO5s20+8te0Qk0GWwTBcctnirhyMd1PIDSG?=
 =?us-ascii?Q?UaP6ECmQH2GThP6OUwssIofYk99mE0lbYsBjKtLKFCiu1Y3ayfxwWq2bHPe9?=
 =?us-ascii?Q?/RgD096Mn8Jxvur/9WG/gEd3JRumsX6qGxdCp8pOOgfVAXl4U0vgiEsDxcUY?=
 =?us-ascii?Q?MNLfgkMTyBW186C3pm8YaVKZFGrEdvMbRYFq9mNGmKd/4wzzms27UeNRAPY1?=
 =?us-ascii?Q?E1FO0DC1kQLY4ZqotYg5KWiGIJvN6VELdRzb5BQQ3/Vasc39hNbyJC7rb5NA?=
 =?us-ascii?Q?a8CZIk78eAQx6N9U+twabNh9iFLr/26znvq9ugRuIScb26cdMgrPrdMVhMzj?=
 =?us-ascii?Q?dIAflrESEPQPx0kyGJcemu6MYTwLvb1zSDRz/UljKh7ndTbXnGMi2eOPFCTr?=
 =?us-ascii?Q?5+2Ba62GU9b5nmiZFkI7anWsjZjoYrx35qKN4wN+cE+duwOh/Z5fOhLJT+o/?=
 =?us-ascii?Q?CfXsP7hY7xh3Q45ueWAaQEPUrqMz7D/zYzSY7c/5My9tGFiQBcGL1NMJn/pJ?=
 =?us-ascii?Q?UuNvGoQ+O2VkPKZqx1neEZ5lrRVCC4LtCt93IJFGMdv5U1mmNra0vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?54CnnbU+rVOdmsImOYXoll3yp/igfpcFZl0gIIvoAa/OFoGXhaKN26bfGeop?=
 =?us-ascii?Q?GguXS/tNFvyqCQB+U5kZhLEPjtoZu6sqx1Du6od5oL9vAiDm22XiCGHi7zWb?=
 =?us-ascii?Q?sqDfG0tOLi9MdWr6S5nwP24+Z7cXhXCJtscXQ0J76HUN5/uqkwwVeRyiNc4P?=
 =?us-ascii?Q?D063jsaZiG+IcOM2Hnn1mj1a05hOh9jfWQ8/krjJUJQfN2eXqGc4YWoOgS4R?=
 =?us-ascii?Q?2qeHBGoiCJvDdG6pDunlZUXvqZm9SZ8UyDeJR4wFj+6dwqfB1J8OPgUdYVWW?=
 =?us-ascii?Q?5Blv7vYdLUAwBC6UOix/k9sZxUDIL7PnFMwfF3Fth8yT1fAluDFb9cjHAT/G?=
 =?us-ascii?Q?uk2qipnz9sQDd8ptyejvDvxk4p3ucF9Kz38lpqqSXJOT+vTRIjIfayIVSrEg?=
 =?us-ascii?Q?nfimFckZyhhUmMQAr+gnHllVmiJaOWioxh3iDJEtvxCkLnvYOKQZyAHQMDjL?=
 =?us-ascii?Q?0xjsZRcKMadYmonZVCgKMydjB2COAgjaPZoH0yOrIGr5J8VyhhfDpX/BBtKq?=
 =?us-ascii?Q?1xAKQECDs6Zr3Uga7k9Z9noYZx3RzC9GyYgSB9RfmSuyypiQrovBV7e3ermh?=
 =?us-ascii?Q?mB2tpJIY94zm0EvA70Mt3FnlZoc0AJchA1aZyD3r1OlmRjhWcsv7hGjqnOe6?=
 =?us-ascii?Q?/pKfxbItq2xe/cHX74+NZFHUUbHx2Bb/GpD7zwd2QOFLzrHw1EerYI9eDWh6?=
 =?us-ascii?Q?YcL9AdACQr5aRnG1Cq5AxJCZWX6zpBVwnoNOKMqpQ2UsLgsyucBHUG4fEb8W?=
 =?us-ascii?Q?54W6q9ypra3DSZXZWK9R/xWGlfwVPoVnsa5Tl7KAJEs+pC2aZYfTnAAc3Rzd?=
 =?us-ascii?Q?i02lpExfGzVRWZoUozax3ItB0p4S8AVra7NI7OzzFFBqzRaURavPkcxS9MEW?=
 =?us-ascii?Q?Mc7wpSyM2jc9WjBMnxXLNU5wtsjzs+DwoPFrmSevSfvqwMs9O/UmTjqa7osv?=
 =?us-ascii?Q?OZ2g33/ZSbLPU2BLkVNmw5S5ZXAiZr5DX823pLMqJ765Qc533UKJ/Iqg3098?=
 =?us-ascii?Q?maL1Rr+VILvRtVr+N2DT7D8KQ0FdnXxGDWOoDXdjVZMjrwMgw1oG3/UPr6bk?=
 =?us-ascii?Q?ZV5BBJSH+qXqf/JS0cCG8I8KM2IbsTdm/ecBmjhrpMlQ9ENHuPQywprcO5Tg?=
 =?us-ascii?Q?9LuCus0YnXgbNOAtjYD9aX3qPtnRigVi9zFtIIYJX7/UBNCk6kdvtzC/7bxc?=
 =?us-ascii?Q?363sr78Shsy3Avg+eYqAuo9Grn6GAdPHKeNX/aN35Y7DqtFZuJchdTe9/Fq7?=
 =?us-ascii?Q?ztZNIZuTNfE3M3+DSh5VajJixxldiJci5Cd9MOQBuk1pkuygggkZZliwFILo?=
 =?us-ascii?Q?+Hp4eGx0Vt0C80f6ivHIpyLJljeUkNYWuuwKZ3UWRzuLY3hBICBS2iN6qBWM?=
 =?us-ascii?Q?cODcU+O76dxLks+TxtDsJQb3iDc8BmpRzMT6a2qKIa9WRq7Rduml31OsvEQv?=
 =?us-ascii?Q?u5TI2IbDHGO3lBpd4RZov/jW1/Xw74bAodVBgIh71R6xCtinwVadyn6EQ64a?=
 =?us-ascii?Q?TQi+fYdS0Q/CXC5x+3i/O/a2tGXwXV9zp2KcA3z4ouFeNRTzjjW0DktwCk3j?=
 =?us-ascii?Q?wVYMRFUgQtzRy0MVBxstF/3Ms+ha9kE9RvleG/BT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc5d49d-17ed-417e-5e64-08ddd36dfe33
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:45:52.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmGXRjlpjbGcJIfOA0+r9vL+2SAvKi2DTSAjQGyDKFSN78S4UmB1eFvgkVTvWAVji2WLsoHV6g9B0epmbI1JzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

File 802.11h is used to support 802.11h features (DFS and TPC).

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 346 +++++++++++++++++++++++++
 1 file changed, 346 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..035aaa1a9a7e
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11h
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+#include "fw.h"
+#include "cfg80211.h"
+
+void nxpwifi_init_11h_params(struct nxpwifi_private *priv)
+{
+	priv->state_11h.is_11h_enabled = true;
+	priv->state_11h.is_11h_active = false;
+}
+
+inline int nxpwifi_is_11h_active(struct nxpwifi_private *priv)
+{
+	return priv->state_11h.is_11h_active;
+}
+
+/* This function appends 11h info to a buffer while joining an
+ * infrastructure BSS
+ */
+static void
+nxpwifi_11h_process_infra_join(struct nxpwifi_private *priv, u8 **buffer,
+			       struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_header *ie_header;
+	struct nxpwifi_ie_types_pwr_capability *cap;
+	struct nxpwifi_ie_types_local_pwr_constraint *constraint;
+	struct ieee80211_supported_band *sband;
+	u8 radio_type;
+	int i;
+
+	if (!buffer || !(*buffer))
+		return;
+
+	radio_type = nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+	sband = priv->wdev.wiphy->bands[radio_type];
+
+	cap = (struct nxpwifi_ie_types_pwr_capability *)*buffer;
+	cap->header.type = cpu_to_le16(WLAN_EID_PWR_CAPABILITY);
+	cap->header.len = cpu_to_le16(2);
+	cap->min_pwr = 0;
+	cap->max_pwr = 0;
+	*buffer += sizeof(*cap);
+
+	constraint = (struct nxpwifi_ie_types_local_pwr_constraint *)*buffer;
+	constraint->header.type = cpu_to_le16(WLAN_EID_PWR_CONSTRAINT);
+	constraint->header.len = cpu_to_le16(2);
+	constraint->chan = bss_desc->channel;
+	constraint->constraint = bss_desc->local_constraint;
+	*buffer += sizeof(*constraint);
+
+	ie_header = (struct nxpwifi_ie_types_header *)*buffer;
+	ie_header->type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+	ie_header->len  = cpu_to_le16(2 * sband->n_channels + 2);
+	*buffer += sizeof(*ie_header);
+	*(*buffer)++ = WLAN_EID_SUPPORTED_CHANNELS;
+	*(*buffer)++ = 2 * sband->n_channels;
+	for (i = 0; i < sband->n_channels; i++) {
+		u32 center_freq;
+
+		center_freq = sband->channels[i].center_freq;
+		*(*buffer)++ = ieee80211_frequency_to_channel(center_freq);
+		*(*buffer)++ = 1; /* one channel in the subband */
+	}
+}
+
+/* Enable or disable the 11h extensions in the firmware */
+int nxpwifi_11h_activate(struct nxpwifi_private *priv, bool flag)
+{
+	u32 enable = flag;
+
+	/* enable master mode radar detection on AP interface */
+	if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) && enable)
+		enable |= NXPWIFI_MASTER_RADAR_DET_MASK;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_SNMP_MIB,
+				HOST_ACT_GEN_SET, DOT11H_I, &enable, true);
+}
+
+/* This functions processes TLV buffer for a pending BSS Join command.
+ *
+ * Activate 11h functionality in the firmware if the spectrum management
+ * capability bit is found in the network we are joining. Also, necessary
+ * TLVs are set based on requested network's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/* Activate 11h functions in firmware, turns on capability
+		 * bit
+		 */
+		nxpwifi_11h_activate(priv, true);
+		priv->state_11h.is_11h_active = true;
+		bss_desc->cap_info_bitmap |= WLAN_CAPABILITY_SPECTRUM_MGMT;
+		nxpwifi_11h_process_infra_join(priv, buffer, bss_desc);
+	} else {
+		/* Deactivate 11h functions in the firmware */
+		nxpwifi_11h_activate(priv, false);
+		priv->state_11h.is_11h_active = false;
+		bss_desc->cap_info_bitmap &= ~WLAN_CAPABILITY_SPECTRUM_MGMT;
+	}
+}
+
+/* This is DFS CAC work function.
+ * This delayed work emits CAC finished event for cfg80211 if
+ * CAC was started earlier.
+ */
+void nxpwifi_dfs_cac_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_chan_def chandef;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_cac_work);
+
+	chandef = priv->dfs_chandef;
+	if (priv->wdev.links[0].cac_started) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "CAC timer finished; No radar detected\n");
+		cfg80211_cac_event(priv->netdev, &chandef,
+				   NL80211_RADAR_CAC_FINISHED,
+				   GFP_KERNEL, 0);
+	}
+}
+
+/* This function prepares channel report request command to FW for
+ * starting radar detection.
+ */
+int nxpwifi_cmd_issue_chan_report_request(struct nxpwifi_private *priv,
+					  struct host_cmd_ds_command *cmd,
+					  void *data_buf)
+{
+	struct host_cmd_ds_chan_rpt_req *cr_req = &cmd->params.chan_rpt_req;
+	struct nxpwifi_radar_params *radar_params = (void *)data_buf;
+	u16 size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_CHAN_REPORT_REQUEST);
+	size = S_DS_GEN;
+
+	cr_req->chan_desc.start_freq = cpu_to_le16(NXPWIFI_A_BAND_START_FREQ);
+	nxpwifi_convert_chan_to_band_cfg(priv,
+					 &cr_req->chan_desc.band_cfg,
+					 radar_params->chandef);
+	cr_req->chan_desc.chan_num = radar_params->chandef->chan->hw_value;
+	cr_req->msec_dwell_time = cpu_to_le32(radar_params->cac_time_ms);
+	size += sizeof(*cr_req);
+
+	if (radar_params->cac_time_ms) {
+		struct nxpwifi_ie_types_chan_rpt_data *rpt;
+
+		rpt = (struct nxpwifi_ie_types_chan_rpt_data *)((u8 *)cmd + size);
+		rpt->header.type = cpu_to_le16(TLV_TYPE_CHANRPT_11H_BASIC);
+		rpt->header.len = cpu_to_le16(sizeof(u8));
+		rpt->meas_rpt_map = 1 << MEAS_RPT_MAP_RADAR_SHIFT_BIT;
+		size += sizeof(*rpt);
+
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "11h: issuing DFS Radar check for channel=%d\n",
+			    radar_params->chandef->chan->hw_value);
+	} else {
+		nxpwifi_dbg(priv->adapter, MSG, "cancelling CAC\n");
+	}
+
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+int nxpwifi_stop_radar_detection(struct nxpwifi_private *priv,
+				 struct cfg80211_chan_def *chandef)
+{
+	struct nxpwifi_radar_params radar_params;
+
+	memset(&radar_params, 0, sizeof(struct nxpwifi_radar_params));
+	radar_params.chandef = chandef;
+	radar_params.cac_time_ms = 0;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_CHAN_REPORT_REQUEST,
+				HOST_ACT_GEN_SET, 0, &radar_params, true);
+}
+
+/* This function is to abort ongoing CAC upon stopping AP operations
+ * or during unload.
+ */
+void nxpwifi_abort_cac(struct nxpwifi_private *priv)
+{
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to stop CAC in FW\n");
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "Aborting delayed work for CAC.\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+}
+
+/* This function handles channel report event from FW during CAC period.
+ * If radar is detected during CAC, driver indicates the same to cfg80211
+ * and also cancels ongoing delayed work.
+ */
+int nxpwifi_11h_handle_chanrpt_ready(struct nxpwifi_private *priv,
+				     struct sk_buff *skb)
+{
+	struct host_cmd_ds_chan_rpt_event *rpt_event;
+	struct nxpwifi_ie_types_chan_rpt_data *rpt;
+	u16 event_len, tlv_len;
+
+	rpt_event = (void *)(skb->data + sizeof(u32));
+	event_len = skb->len - (sizeof(struct host_cmd_ds_chan_rpt_event) +
+				sizeof(u32));
+
+	if (le32_to_cpu(rpt_event->result) != HOST_RESULT_OK) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Error in channel report event\n");
+		return -EINVAL;
+	}
+
+	while (event_len >= sizeof(struct nxpwifi_ie_types_header)) {
+		rpt = (void *)&rpt_event->tlvbuf;
+		tlv_len = le16_to_cpu(rpt->header.len);
+
+		switch (le16_to_cpu(rpt->header.type)) {
+		case TLV_TYPE_CHANRPT_11H_BASIC:
+			if (rpt->meas_rpt_map & MEAS_RPT_MAP_RADAR_MASK) {
+				nxpwifi_dbg(priv->adapter, MSG,
+					    "RADAR Detected on channel %d!\n",
+					    priv->dfs_chandef.chan->hw_value);
+
+				wiphy_delayed_work_cancel(priv->adapter->wiphy,
+							  &priv->dfs_cac_work);
+				cfg80211_cac_event(priv->netdev,
+						   &priv->dfs_chandef,
+						   NL80211_RADAR_CAC_ABORTED,
+						   GFP_KERNEL, 0);
+				cfg80211_radar_event(priv->adapter->wiphy,
+						     &priv->dfs_chandef,
+						     GFP_KERNEL);
+			}
+			break;
+		default:
+			break;
+		}
+
+		event_len -= (tlv_len + sizeof(rpt->header));
+	}
+
+	return 0;
+}
+
+/* Handler for radar detected event from FW.*/
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb)
+{
+	struct nxpwifi_radar_det_event *rdr_event;
+
+	rdr_event = (void *)(skb->data + sizeof(u32));
+
+	nxpwifi_dbg(priv->adapter, MSG,
+		    "radar detected; indicating kernel\n");
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
+			     GFP_KERNEL);
+	nxpwifi_dbg(priv->adapter, MSG, "regdomain: %d\n",
+		    rdr_event->reg_domain);
+	nxpwifi_dbg(priv->adapter, MSG, "radar detection type: %d\n",
+		    rdr_event->det_type);
+
+	return 0;
+}
+
+/* This is work function for channel switch handling.
+ * This function takes care of updating new channel definitin to
+ * bss config structure, restart AP and indicate channel switch success
+ * to cfg80211.
+ */
+void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct nxpwifi_uap_bss_param *bss_cfg;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_chan_sw_work);
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (nxpwifi_del_mgmt_ies(priv))
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to delete mgmt IEs!\n");
+
+	bss_cfg = &priv->bss_cfg;
+	if (!bss_cfg->beacon_period) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: AP already stopped\n");
+		return;
+	}
+
+	if (nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
+			     HOST_ACT_GEN_SET, 0, NULL, true)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to stop the BSS\n");
+		return;
+	}
+
+	if (nxpwifi_cfg80211_change_beacon(adapter->wiphy, priv->netdev,
+					   &priv->ap_update_info)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to set beacon\n");
+		return;
+	}
+
+	nxpwifi_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
+
+	if (nxpwifi_config_start_uap(priv, bss_cfg)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Failed to start AP after channel switch\n");
+		return;
+	}
+
+	nxpwifi_dbg(adapter, MSG,
+		    "indicating channel switch completion to kernel\n");
+
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
+
+	if (priv->uap_stop_tx) {
+		netif_carrier_on(priv->netdev);
+		nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+		priv->uap_stop_tx = false;
+	}
+}
-- 
2.34.1


