Return-Path: <linux-wireless+bounces-11207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC8B94CDC0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF881F226D3
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFF719AA53;
	Fri,  9 Aug 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GHo/JfPS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09DE19A281;
	Fri,  9 Aug 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196862; cv=fail; b=UERalqAX3iePVfJhsg1yD79x0ZXXsIbuAW7xEB+gn1VGbif6xfu3oIYUeFAB5UKKghH14XuhFF6e3nvDj1wm1XTuOWMxmjFXt+k4QBAEElWBqDozQQAWn4uncpDsmOG6roOBTx6rEB26+FKuZmGvbgRMJx+QxHGCqcIbmHfKnFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196862; c=relaxed/simple;
	bh=7Oafm1/MBy1j9Ld3SJToc8AKiZ2k9RgvoY4xcriuiJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q0GlmjHv+EeEKzW1kOjDfRkwZOZdIrGAuequfCaLqJJ0I1BBXroY1E1noDgr+76E+BGWl6TMtOmdvxaw1wyJs/DlbLGAH+UMm5NwKkgqEPnfhNC3ZaEwsFTxA2qigcXPb91gGdl8+0rkTQO0GTdHHGcovuPCxYujSEPb8b08dYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GHo/JfPS; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJicGw8upUTc8MAwS+0Wn92Vv1nvcy+FS5EyXRgK8o89mszc+0s0fK8uRlRCsR1a/Gb4H7sYqzrlX2r6Xs3E5bZRaoqLOyuN9HgNM1kreGmplW3q91vRFsHDFrxdWL2hepDcAJSMdFPcsA/jE9yCilB7/DSq6E+G8adj7Ri8vOKZsK78Iho+2ow+h/iOULScE5bzPRtEtdRYtmmjmyEbiZkQD/pICbB6m0i9HyjHyIOCGoiWT7d+fSmB42uPDTOTm6/M9JXYMg5LsrdONs/bu5/32CH05oMgtck28YEWSfvZjJHEucsabxiYcQ7xfWqRQD9QI2/TJ0DmcZjE3A55/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdE9qNROvq51dOan1/lsUiVmQnJIgEmfg2mnL1hTZLo=;
 b=vmIzOQQiMmaAs7RBCKdlD4X40yFD7TVldhowgtx7A1vNVoOz4myw353Pk9DihbyXsj62yw3qbHD/gWf2Nyu1Cy5vDeBRy4IJn/d17XoPRZrk40LouMgueMXjvSetmintpUawDIIPJPc1uTjBOAnlXNMqSjtfgObVj9EV7B/NVOzBOcemgzE3jLD0FOnmB5K/lyR9r8HfsSOj8+wuzPwzwCqe/6TPnuzNDmGgOXtsYWnqskfxv3e3wgdENnH0DW0Vkks+CP+BqQ6Ny3Oq8Ar1nYi4ecg0N6ztxj10n8l8ZeREgsEc7I0HEWB9xdfSQQtyXP+K7Uv2MbZxUf687IueAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdE9qNROvq51dOan1/lsUiVmQnJIgEmfg2mnL1hTZLo=;
 b=GHo/JfPSr8uTXCeVy8h/OKdJN7/PAlJf60Ux7Dlyc/bT1SLfuzP4e71pYkIrs9MHLY/R4kKdDcFqpYZNqW3Z3scP1U6hA5WkUz3EZEu2sGzsOd/FG02nE4iGrt6xitjPh5dFDyA+mD08K5x6Hevzc+UcOxv0Z8Iuh6CcogApvKU6u78lk7+9Wee90s9oDfMvT8S1day3V6u89Luzk36RcHd6IdzhkJTtJvJq3HgTPPx9Xgi/XqdUlw2eZWqhFLu1U/tqSTBvNvcTZv84L4Dfnng90V2CJmoFH+6SWzKlV44LCzLjobxaif3AFXKtnqd9YS8Bg39giKTerpLIlhyyyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:47:30 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:47:30 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 30/43] wifi: nxpwifi: add sta_event.c
Date: Fri,  9 Aug 2024 17:45:20 +0800
Message-Id: <20240809094533.1660-31-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|GV1PR04MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ccc03bc-4b9f-4295-068c-08dcb85848e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uBRTg7mGT+9aTk21FTfzxVfSwX9pt4AyOX6OH1dDAoVj63nCl0Kvk3xxpNZD?=
 =?us-ascii?Q?aJNdEgia5EbFFq5qwJvQxj1TfkA6EqBsM1DN0W3+4csANA9GAibgofLBbmMK?=
 =?us-ascii?Q?8/wk4HSRChDRH9bpGwzJ05jEM4cTkNZ5mNg9Z86DFzhhqPB/fn0XjDTPEHn3?=
 =?us-ascii?Q?nA3PeGCWnf27J7VjNAvFSQzBYwXpGxCea2hJab7mzGkmLa7uEGfWXjHQ6yCI?=
 =?us-ascii?Q?aiU8j/7ywhaLcsOQG8kpRm/R1LL1212aqbayw68PjyQhlc09PdzVUYgTEW6+?=
 =?us-ascii?Q?LNZu8b/2odUm5U98eHg2oqzYadpqwovRHGxYzfyTsJIQEFjuGv1XOrhcOhEM?=
 =?us-ascii?Q?0rUjbaJ7Q33g+6aLVkybmtz1SE8wDrt9QWNGaJ0K3DmRNZ9xB9r11S0u3eyA?=
 =?us-ascii?Q?meuhL+OK6fpfbeC8yrFuyT2RMEYFtIFm/F4WexJAhEM1uFfj2Q+Rpdw6TFlW?=
 =?us-ascii?Q?diPk0fS8qVC+tu+a1QHBndG1RYpf/f60RkR1CN7QalWT1gDmldjooUBF3yoR?=
 =?us-ascii?Q?v75e/VvlbDsZVO5e7N3iW+knVI7aVRP9aIwXaxzW5D14yPcS4mORkaCApfrG?=
 =?us-ascii?Q?X/XK7zSI3fCQYk5aghecyEq6b2Ww8Go0gvR9/y9tebimAQamGKGiGMDMgvQd?=
 =?us-ascii?Q?j5hceTjeiW0T3mf63o0nryUPKpJAZu2eew6eHMK2XalXMzOZeV95Pq8dQCT4?=
 =?us-ascii?Q?bHnBdqYD/5pvRIYunwUek+iyfIFF8EO5BL/KXIlLqoBtvxBEmE8BFc8pWFkc?=
 =?us-ascii?Q?4l5P7NPVfqcuCNiSV5qp9dgYcvK3GAl+x4/izf2P5CojEEvmmw5Q0Bt/n+6y?=
 =?us-ascii?Q?PuP27RGHhIFx11VtElc0UjbMe0YLVqMrpMsxgpKlvs6PuT5F35CR8Mf2Uf8n?=
 =?us-ascii?Q?j6AU8pSgTaBkzeBbFgmT7hmYbs5tZkX/JJeVZVax0fbOSXV7fnjn/DPgCcR3?=
 =?us-ascii?Q?XQZFtUXcQFSYk/xwpwRupc+YeQ0FPmjStTl2Oozy2+yK9h8oe30m5JhbXDI/?=
 =?us-ascii?Q?nCKUPINyAaMM2YnAydzYlmI78oIcJsd5OQrbdmA8dEn0jnpz7YO4tan7o4Zw?=
 =?us-ascii?Q?eMP5kQcM19rLxFIG6a4knnXjSEbgRaXVlY7iJlG8LrvNZwvAgHrWsFRxL03o?=
 =?us-ascii?Q?SryJBs4lpyjqAobMOoO7vpFwiJYP9F2ilz4vzAWalTcPqKI7eX057/r9UOX1?=
 =?us-ascii?Q?SQk4LgiX9J5WgY8ar+QvtaM/+vD5X2rK+gNOIKkbYFaY14bJTNiI6N7UJ3m6?=
 =?us-ascii?Q?Ox65a1yv+PakbMlpHTm73n1+sRZHhyaGZ8hS079YibUY2KSpfm5P3EARiMAd?=
 =?us-ascii?Q?WEpxMshopEVidK/i072qXLciYyP7L7rzOqD0Cnao8y7E3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIPH0+DDzhJ259pLxV73Q2/mmtYdWHB2qTBb4y0KmTupOPjCFkLLk40ZF6eW?=
 =?us-ascii?Q?YTjwetD62XbkEi2io8Whk/5TKJXIV9cgSKpPz96wJUIgIrRCcw7lG73nAh1P?=
 =?us-ascii?Q?d1V3Vs8pyqStvyWozY8sUfGDhijJ9eW8uB8SorfrXKo/Te4Zs1D1IN/NqRlF?=
 =?us-ascii?Q?vrfYkq7Tie5BRitpUwErQBIhMjT754UlTFHh4jKqaV3KE8lQMH9pEBZboMVJ?=
 =?us-ascii?Q?oU8Fd43WfPjsO/bHu8uMpuhv/lUci1l4f/mUHFwIzwWZ4hZ79GXdKqNeGtO5?=
 =?us-ascii?Q?TqIJ6+SVdC72LDkAPtQEcj5I3thuYRYanwtTDFuyOQQry0aYVyuDg7uGduqJ?=
 =?us-ascii?Q?0J+p+qpfG3+vYwAWlm4ZiyOmE+5AOZ/XIQS/f6C1FbRePaI7YxmxM7wl0wGO?=
 =?us-ascii?Q?fXKPoHhFEykpDvwi677cPn19G+4QfgWmBCR0/QNy5Gh3Lev7uepmyPT8lYdY?=
 =?us-ascii?Q?n75R1lf6tHEmujH54eoo8zyAlXrHx7YZJiyJN8icC1jkFM8IRJ/KSvrZDEea?=
 =?us-ascii?Q?z3l076bDWrEtWdwj3yjN53LPrTje5soxkJpoS3yGA2yBGthpxm2DA0lDz3zT?=
 =?us-ascii?Q?XXy+aKRa+XJvBZiwNanaydhYybaPGok5znw85tN/X1F17BfSGWG8o+H+SYRM?=
 =?us-ascii?Q?Bv7Lueos2SrWUs1G5rBMEAfd7hGP2UtU2xo/Qpmnvv+8jrnAcefnkBMGaBs0?=
 =?us-ascii?Q?shZDwdeRS3ztA++TNsuvXrF5yGh/Bx9VT933Ilb0lWhvRor0qtkfO4k+92vW?=
 =?us-ascii?Q?Ol4FWGkU3DOXPhwP3V9qqHbmuYYVPkAAF9/hRpTuDJNTCn3M/PjmdCl1T6wa?=
 =?us-ascii?Q?Jk/QhGLhfPbomnI3NWWSYiagTTzLonlI1GAMWAsmubf1FXG6Yj8hAhNDheQo?=
 =?us-ascii?Q?CJN6WBS+AQ7GrEMItuha/EbhzL9F7acW/cfy5NCdbvlEXDh5vUOwCrJr5FDq?=
 =?us-ascii?Q?FnxdkmXdKYtPqHe1U0zlNdmrRXnGcpMP9/FsSQE+hhyIVNRi41FoXZUkWWF3?=
 =?us-ascii?Q?TJtPam3FxqGtyVbTIIyogiigP/MY2uBJAQuqO/zvcG6fC3XGYT2xG5EiQI2h?=
 =?us-ascii?Q?qNxit9cyAJ1ANmvXgHluc9cQHYlQ/wXiXl1LaSNY7ATSZZntVh0zKYmBvOAC?=
 =?us-ascii?Q?E6cqXyS1RT1CziX2zfFI52DqcXsIyURo9eJa4NPydmqHl0kaTkVqGBvVMeEK?=
 =?us-ascii?Q?ApwRwIIdEYhRzFvCEhdSNXhcpg96cKcGg8cuacX73/3swr1NQmqQmLxoy4yD?=
 =?us-ascii?Q?h9FfcFvpDva23SizJl4biSca6MeC0V2AwoM4onB3qFpA7Ux6McJiQFmqnSgI?=
 =?us-ascii?Q?3OyiM85ivDDpual/qz03X9SSlmAP2ldeV+PXYNP/t0rtYF1JnlsqYa7rqjbD?=
 =?us-ascii?Q?WUwGRpb/fz4iN+VOsMf64T2hN4K5Q16vcNOwZHL6mVFWvBkJ+dYDjk8IpgDJ?=
 =?us-ascii?Q?6n+djNDiYGvMVrttU1NjtwxcmN/rsi0Vs1gR2BIzN77Owh0PCXzB2rb5yWJm?=
 =?us-ascii?Q?txMRFzH5ur4RQFSaN3PQxJy1CJwbPB52WZUAuaecjpK2Kqygvtpy8bRtKSND?=
 =?us-ascii?Q?9D8fZX07ZmcXhaqHiBGrm5KFk4zh7RG1MaJ6yMgqdvIKt/zOYGMw0iisy4bP?=
 =?us-ascii?Q?wegdxyqdEFB4I2qGccvDOv1SmLrdVnGiDV25CkUIFLsL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccc03bc-4b9f-4295-068c-08dcb85848e0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:47:30.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0vMZTFvzw6PSg1lBTfiWQvNS0ehC7cyqy10jFP68zJ9lRJx4YAv2gLN7yo42f8TkH9t7Ruok9HvWiyoWbW9Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120

---
 drivers/net/wireless/nxp/nxpwifi/sta_event.c | 864 +++++++++++++++++++
 1 file changed, 864 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_event.c b/drivers/net/wireless/nxp/nxpwifi/sta_event.c
new file mode 100644
index 000000000000..58852a63df44
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_event.c
@@ -0,0 +1,864 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station event handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
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
+		nxpwifi_queue_work(adapter,
+				   &adapter->host_mlme_work);
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
+	if (!netif_carrier_ok(priv->netdev))
+		netif_carrier_on(priv->netdev);
+	nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+
+	return 0;
+}
+
+static int
+nxpwifi_sta_event_deauthenticated(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 reason_code;
+
+	if (priv->wps.session_enable) {
+		nxpwifi_dbg(adapter, INFO,
+			    "info: receive deauth event in wps session\n");
+	} else {
+		adapter->dbg.num_event_deauth++;
+		if (priv->media_connected) {
+			reason_code =
+				get_unaligned_le16(adapter->event_body);
+			nxpwifi_reset_connect_state(priv, reason_code, true);
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
+	u16 reason_code;
+
+	if (priv->wps.session_enable) {
+		nxpwifi_dbg(adapter, INFO,
+			    "info: receive disassoc event in wps session\n");
+	} else {
+		adapter->dbg.num_event_disassoc++;
+		if (priv->media_connected) {
+			reason_code =
+				get_unaligned_le16(adapter->event_body);
+			nxpwifi_reset_connect_state(priv, reason_code, true);
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
+		spin_lock_bh(&priv->sta_list_spinlock);
+		sta_ptr = nxpwifi_get_sta_entry(priv, tp->peermac);
+		if (sta_ptr && sta_ptr->tx_pause != tp->tx_pause) {
+			sta_ptr->tx_pause = tp->tx_pause;
+			spin_unlock_bh(&priv->sta_list_spinlock);
+			nxpwifi_update_ralist_tx_pause(priv, tp->peermac,
+						       tp->tx_pause);
+		} else {
+			spin_unlock_bh(&priv->sta_list_spinlock);
+		}
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
+	if (netif_carrier_ok(priv->netdev))
+		netif_carrier_off(priv->netdev);
+
+	if (!ISSUPP_FIRMWARE_SUPPLICANT(priv->adapter->fw_cap_info))
+		return;
+
+	nxpwifi_send_cmd(priv, HOST_CMD_GTK_REKEY_OFFLOAD_CFG,
+			 HOST_ACT_GEN_REMOVE, 0, NULL, false);
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
-- 
2.34.1


