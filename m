Return-Path: <linux-wireless+bounces-9392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639D1911DA1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CBE286709
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780CE17556C;
	Fri, 21 Jun 2024 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E1vsBQ5a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C916D9A5;
	Fri, 21 Jun 2024 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956458; cv=fail; b=FiBKJpiBo4PuNvGY9IGWzb3B6KLsGx4OxZIbe44ebVXmlvp6pwgYSeINqRevmFwm1T5fo4hURYQ6YUwFYHufL/3hFK+75fbD6JL0IWOz2OSo5cLGHgaY1V97OKXmbM5mOIi92DJdkZHB6urw+TFE5fopyVUspa99neaJpLKooI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956458; c=relaxed/simple;
	bh=JGAlbiRm2yZv6EajNJ1AqCHbb0fI7brbgoFhI5HlOi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IuQnyPwnfFqIFbnJUKD2eRugBVj9LPEpFKgB55tFVD8yD6Qdyt9+S1/VvUhxnzMgvHPRgn+lGOWZbc9aMpJwf101RE15XznuRXfD/Jl4Z+LTEqJL8AIL+J4FnCWPlZ7SW6ua3moCZnToq4m99YWVQHD+11VAU1QuyThWgAFFvGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E1vsBQ5a; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSWnQZKd2CedEI+2yg5T10gcyBVV/krbRPaOmCUeY5APwj8aW0sO616jOir0M6uO11uk9G4TAZ4P2coiYm/FdfYcIOzjTCXU2+AJQYd/9ClxjVF8iT/582tMTuvSGwvm3VQcp64J4FEEMDs/pMFcb0OshdvSXwGEYS4iaYpfbBYUDichhNl9+tEUBuwwQ8CjIlI8Dw6IVaidGSXYq1aDM9fim6D1OSFZtDjo1+1DCr/AW+k8X1MzevHurqXBf5WUlQ2rvwkiNn4boSa1/OdPjNz0/nRyxvAzwiGbBJ9T8dGDToBnghOuB0FCQJ+ori6QqqO1hsSHD4pumo19CbrEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g/7W8XVdfpqs5LDcvH+tMJU10S4PfowQSYUHGzgaWc=;
 b=Cy36RBKEj5jH8P6HLJB1QKOhjHmRlHfQXKwxB5EkXwdGhHSHTTvCVdArHU2isQeSXhTF10dzrcVlo59s28uETjJUV/H3VwyWj5BynxtAOEh/ha67jQ429fM66OQUyDRURs7bv7ybdFGNOUpAgrVqHDiv6CdiAcOM+VlI6bbBSITBGIi8hAOYm+BZ5d3oBdwvU9Cbx3PWJJoTzFLjBy2qTBuEwQ6Okh1+hjFethIq8kQLubzBn0GPsPc/WeK/PT+zG8ShRzoW0Udi6y70zZkPm0DJnHo5ZRtfwvSgtKbS4RZhfNlucDKBe1hnBnl4AA4l5yOBzA0qYqVdVbxzlQ9veA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g/7W8XVdfpqs5LDcvH+tMJU10S4PfowQSYUHGzgaWc=;
 b=E1vsBQ5acmPa3WyYTFsBC8f5lFgGpZVx5Xdgx7+mW7uIFyI6yuJXZp50hlX9/eR8SFAzPu7J2zU5gHjylXpMFkcW8m3mnlZjQqcGub89O1KERVcob4flXwIwhdgHrZMGKmctJKLGbyFdCx4V3n/nYj/KaR5naR32OvKxS56ipxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:12 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:12 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 29/43] wifi: nxpwifi: add sta_event.c
Date: Fri, 21 Jun 2024 15:51:54 +0800
Message-Id: <20240621075208.513497-30-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: b3390469-2b02-416c-ab00-08dc91c75681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tNlu1Jd74UOkcqx1643U0og0c8+97opdTRVetin7E9BgQ/1rqOuqD9j5orUo?=
 =?us-ascii?Q?F4wu/Nszt7uj9/+ZNsttJePeW9BMUg+WnQu22XlpFHOWsKm8Z+DbCC/JGwNZ?=
 =?us-ascii?Q?ltMa9upyBIwCyREfnGWa+HCLNG2q4+EhY/B0IJGYV8MCAh8o/OjjCJmuv/9f?=
 =?us-ascii?Q?IFzKGw21iXQQipE34tPZpM780ODFhw8SYJTAGTAiA4HmwterSIK/h9haBxZX?=
 =?us-ascii?Q?jjO4mklmTlc/b0KBAL8ZmyM6/hT3bmEJIiwz384gkl4WZXpz+3pn72cEzPXE?=
 =?us-ascii?Q?Tw8TYYRKtKrAH+N8k+e6Dq8VZ7Z3MkTNBOkzsOsP+GcrjHIvNoofr7/hsmJO?=
 =?us-ascii?Q?/JZ5WQM1j/bUsYXOGtLBjHUmrRFdVZlVCgSdwe+3WB18jK/29OnoJYYHvnuL?=
 =?us-ascii?Q?a+9dre8uvsMLAAgHHNEtNEPk5pQrKWNoxftcGqEsRDBhN0AOe+1sd7w7l37J?=
 =?us-ascii?Q?cyjMNZXC3rKgKuRBVz7kxT4Ou9ilh/UIdvk5CTgpkhYgfHJh8kKu0ujjIDXa?=
 =?us-ascii?Q?lcY3kgpWBBwAqECTU77nXeR3ACWWb2TOgT8e+FIbNmMcsY39KxkYWvApO6Ov?=
 =?us-ascii?Q?OLVAepdy9pYzmHeulNmu1A9hK6bIdNGtFTchgVn/ozjEupObflt33yj4o5KK?=
 =?us-ascii?Q?j/hCGlvNh6oZQaVHMiQGxNi3eE4GCdo7NmdN5DufGOo+Du3CuaIEQF3ypcB5?=
 =?us-ascii?Q?f4tYh5u7qLM/0CoNgdxzCb8Ou87/4RMVzII7VDWCmvhOEe6jImRVwEDpTHv5?=
 =?us-ascii?Q?6fGQr4N9iRPyxMDUxN0BU8gKMcw76gEU+5giXxrvBxoHEJLvFx1KfnZLmbY1?=
 =?us-ascii?Q?1yPYM0gCgsaDurF/X6fi6aap78b/oXPXk9jvNdKWhWXT+heA9oxZ3aMy9mLS?=
 =?us-ascii?Q?l7JJNKciCzVe14WaHsKxi1iJEsUXpQt8ORTtI0XslmnQM4A0PM+NOr7dUrYo?=
 =?us-ascii?Q?OSfXK9n0fo8lk7fqN5wFFECiVVsydrE3W2xLVWljpBOj0uvd1ePU9O4X8mwU?=
 =?us-ascii?Q?ph/X1dgCYKPR4V97V3k6n9WVxxA3MLjAjxODQOfOvZlCLCHFa7Pr8+1GXPCg?=
 =?us-ascii?Q?rxaROySN/qED/fdLS81mE/Hn7XkU4sIqx8dmW6Tc/sbT99IEQ8mvnGo8OcKU?=
 =?us-ascii?Q?VSijt3nnHQ9hPov5l5ltg8hPEpBti0atGaKbFKGIFJb6iiwUaUEJZAy3lOq1?=
 =?us-ascii?Q?dEVU+0vFEKphI54SzRMIsRsO7G1YnlY+FXu24ejSVbRMzaPmtS296gKn7KQL?=
 =?us-ascii?Q?iUToLPsm7VBn2t5opv5BjWMlJt/AZESKqY/YkdhTZOSxHmMb1VavW/uY+/cW?=
 =?us-ascii?Q?ZubGzEYKSdkFzGuNNF/qpBC8DbY/hnF8hyqRsG1eo9hHmOXWHSfTcRDXaw7+?=
 =?us-ascii?Q?o3X10f0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ZaKouJOdN7mrgwkBPSXjXU+Hvl89pGGY9a1ww/9Hf9nlRaI5vlpLWqvrDOw?=
 =?us-ascii?Q?6wYo7pwOGIA+5m0FRW/CvCv76LDLmSfNlLC7fT5NJIIcQB8dqLEsgqqo0N+d?=
 =?us-ascii?Q?o97bMRinSmJ+Vhmnw4+BpkAt0QQaGBnhL5Nnth+h+O27XJs08OooffvoG7+4?=
 =?us-ascii?Q?PbDEOtGyq/ZLm8VSw1MaXFzX2nrU0VPhGuZiYonm6Zc5HUl/YzsOjFEgf+Fq?=
 =?us-ascii?Q?uBF8ENMG8f17UN/ulihf25GBtmM6Id/WL0tdALLKSHt/Cbklrs2qt3/p8tqY?=
 =?us-ascii?Q?XNqPNOe55XeGUDIWmDGaq2iZvVWSZ4dbhMTo09y0ShC/6F5Mg4c8Ra0c1r0j?=
 =?us-ascii?Q?K/SiIYUFU/SzRr9LJ6fT7DVTdpviIL55kXzzJcq4oINoKQ6Hu5mIsuGI9sB/?=
 =?us-ascii?Q?Lyi5o8fg19gFEkfRx+OlXsdhTRze0yufTf16WB7yqWPPv3g6s18YXEvm++Lp?=
 =?us-ascii?Q?r30XxHL6wgbjB2Vipb6uV7b2VRPvprMvYRlhffYZoo1Qq7i86mGxpM0y6gmP?=
 =?us-ascii?Q?vxG9zFmUOkef2UjHYdD5GLrPFnu+SY5W+v5xiwubcRK60Q8+Q7Pu7fKnxBHO?=
 =?us-ascii?Q?sjYXID1nEPlukctfBsBBtWKt0FfpQH6KhMxl0rSAKIU9AFFLhm0asdgwsxGX?=
 =?us-ascii?Q?iOzFY/2SPEPLmifiDEr85iiTZIm9A6bmS/hT5emw/IiuW3CLRlGnShZ2/b/U?=
 =?us-ascii?Q?eo22NOD4Up9JE3VV1juyUqBYaa4oLVnXRvpkz4G2/H/vkZXc+eEPq93h5YB9?=
 =?us-ascii?Q?y0sG3C6EGl1qlZdreUMX7rU6m3uJELlML2pu7mtlLPoCjhaHXqZ5ys+2aeIZ?=
 =?us-ascii?Q?kImmJw9b5OTe9dkjTge1IHE0PPE0b1jbvnMMthMocsctpuAlDAc8JSmc1WTN?=
 =?us-ascii?Q?/esUQsGhoX1B1pUVlYUEjKmJD8IDF02zR+uhHLeLmS1dCN2Li+uOvJuTDIXG?=
 =?us-ascii?Q?Gk3SNp7LK9DPqFq/dSfjrFaj0imk4paBCB64kWVSbJf/czyNTBTgmweFVoFY?=
 =?us-ascii?Q?1i/F4Fp++yP+RSZamn2d+I89olUL7ZFMuPJOecghh9E6UU5aJl84+l7IHp+y?=
 =?us-ascii?Q?KEIpLi8YdrtTlfpxDidTQXzCmJfy7KVeY+GJCVyB/P9TmWFvEZX5wJfl4YIY?=
 =?us-ascii?Q?Xhjogp+WNUK6Ur5K3XPMesjBRrSdob6qtxsSLk/W2lq96a7+yZnUpYahePph?=
 =?us-ascii?Q?yYHuJdTkqW7zyR1enBIlirVc9IpGQkYOVmm82j8Ej6+FWRFXwS3zWGdg90zX?=
 =?us-ascii?Q?0vCrOE1Hea/gjvks3QfIvWNvXT/rw1hKCCuiYnfVfdp+aZ0okAyslBdCcU9p?=
 =?us-ascii?Q?hpsbQCXrgS6v6qc0oU6Z3zFe+tf8r+QhT6lx0lcH8TPG/kTCX2010cXAWAni?=
 =?us-ascii?Q?lsBPxtesDdh7X2lItSpWbOo0EsykphKVm8xtJdNW9HXdVKzyTFLltRd4MOQ2?=
 =?us-ascii?Q?XvCABcvbm0BDfM9PKP44vEFgEM97AK+FBp8KAUQzXW3mNkh0B4PODCqqO8rF?=
 =?us-ascii?Q?xmRldq8I5Rd7MIfI808xIhqSXGx+BCsgO4kxg0dgD1CPFhSuwW0UBWKFYV6b?=
 =?us-ascii?Q?uhdvD/jK3+Sy/vUyUzwTyNl2HCod7VmkzjbrZIBH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3390469-2b02-416c-ab00-08dc91c75681
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:11.9488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQXxlWUGQbYeY6gOfWOVnfgEAhH4By9XvDc2I8bBUDd1kK6aear+hGcU1/FRAoi9J+CvRvQATjZHDSWKqDvPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/sta_event.c | 858 +++++++++++++++++++
 1 file changed, 858 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_event.c b/drivers/net/wireless/nxp/nxpwifi/sta_event.c
new file mode 100644
index 000000000000..61daec04665b
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_event.c
@@ -0,0 +1,858 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station event handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "ioctl.h"
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
+	u16 reason_code;
+
+	adapter->dbg.num_event_link_lost++;
+	if (priv->media_connected) {
+		reason_code = get_unaligned_le16(adapter->event_body);
+		adapter->priv_link_lost = priv;
+		adapter->host_mlme_link_lost = true;
+		queue_work(adapter->host_mlme_workqueue,
+			   &adapter->host_mlme_work);
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
+			if (adapter->data_sent ||
+			    (adapter->if_ops.is_port_ready &&
+			     !adapter->if_ops.is_port_ready(priv))) {
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


