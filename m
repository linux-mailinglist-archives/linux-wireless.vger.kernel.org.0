Return-Path: <linux-wireless+bounces-9400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0323911DB8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7940F1F24306
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A6E17B4F9;
	Fri, 21 Jun 2024 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZW2xmgR8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5817B43A;
	Fri, 21 Jun 2024 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956481; cv=fail; b=u8nnEo8+D2NMUsE6R+PiUHzVd89iFZ4OkuCyVgSb3fyrAOQxZwnsfgX9xzvOyTlvm1VErb1Usg5ujZlzPKj1LtDp6NUoDYEzgKXF+mnrsN4N+QE8A9UmojD3O2AT7vB+PtYNjdUNbsVhsBnPOd4fK4wp2kX/vOSBGR2xTJtyd6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956481; c=relaxed/simple;
	bh=3LGnFwNTz6B6JbUwqdVOpd6H/T6IXTEBSr4nWWQO5RU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ei/FQpgC9EM+qk+48CC/3Uvo9eJtFUgqhDlOrThLau3ArfcAOZzBJZ+M7X16R4QGW2pYNYgecBziGK4lDNt6fTHWBc9bKgJI5swGgLWPFS/lldLP6KEhRtdYh4L43ywgZ2Sfb0CfHSwIpHC2K+qF+R/9UPQbXymjwDBn6cOa6PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZW2xmgR8; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO2Z04mXNH+mkxdInkWCY3t5/EQz0j5vfrSCGv/s+2W+SbuqoF4xLuiClkALlajkcy3YgSZ5eLjv2Ho+Af3flMbAEm/pq0JIXkHRTGr+3AOoB/Ub63/zYonNqGStiLVAerBMUAN3edCrRgKrIN3LQLbosoJb9RaHQR0lmoz48VaR03S4lIRrNw96Y2F3PdaxrH6OVXYW4MRe+nCDPvBuaUQJay7Qx3W0jWtXNShwhQKB9cne5BnKdytzB4l6xdUYNescItBUQKcmtpqyRAF4BuqUoe2h8fpqH+m9DXE2YdOpM8d0ReGICXKz/riFl4k2b9UuW7NzQ5CZWW52uCeRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvQpSlbULY4Zcc3iELEuL0i00AQ5LgeF9Sccc0po37A=;
 b=M8nla2FzHHXoiYikDY1AgZG7oHpgI/YzgKw6ENKm6LyVu1CkByyaMtWWwVr9BHACc7vZbaMz161SNB+5xqRAP9nxgfqavTWiHXOkEkLtf7JBFsiRvmu7A1hezIgXaCU1dlg5DWE5OnB6ajb20r/v3irraYpMDVvHnJdTgRoKf/QbCPrOAe3AuwiTlorA0mQUDuLJ/kzrRA6crptGL9bJsYVgunPl4MZDCsBIaQqhaIiqpE4hK74C7NrcnFesOQ4n+i57gmzJT2thtn8y7j26ND4X60EJ4pa5B97olIZO/+JXGoxn9AeNvr5ZBMZN3cxDqnhE4vFXE5MYJGanl0pX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvQpSlbULY4Zcc3iELEuL0i00AQ5LgeF9Sccc0po37A=;
 b=ZW2xmgR8WKj3kBNk6TCxXaALK//Y5j3qot6JCGncRwslmZh+edyJZ43L3RfwOmikzdnCm+s3k77Ociy/eXgHIDE5BTHunVlay3KQgU+AUyi+zdy2q+awU3XNh01YiXH6zXQdhL2VkAmsN2sXLjF7ujKIMEfQzyrI9AbIYscPJdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:33 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:33 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 36/43] wifi: nxpwifi: add uap_txrx.c
Date: Fri, 21 Jun 2024 15:52:01 +0800
Message-Id: <20240621075208.513497-37-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4d53bb-7e65-4afd-5d40-08dc91c76363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/+RreziID+45MBsvfk+t0nAuejFFkHpfhn7IMWalWC4deMrs9ZVoi0Mx+iMm?=
 =?us-ascii?Q?T93N+SIdOMzMvy262ILNtG690/a/cwOrUYAXwnDRvWIwlvUtquBuMF3O8JIJ?=
 =?us-ascii?Q?mR4iU2uwHltfVy2zjd3k69xdXDdWER6WiarhUdgEvvte6GoyRto7AjdxZjRD?=
 =?us-ascii?Q?gi18shuxXaqOxpZ6eznrJmgv1/ugcQdcOf6HIMmm8nkomhYERCIoNYQZZErp?=
 =?us-ascii?Q?MKQxieGq/Nl5M9XhbN8uceFnZagKelnkjw55NtOUI1gGBuMv757mmDJTUUKQ?=
 =?us-ascii?Q?kWqJYrNVCfBRMia9fkVXA36QNK4/iy7ww2Fl5IFdXaBOtkgP+Bzw7NbOCKJm?=
 =?us-ascii?Q?gds/rHwvenGgxWI5YTE/aHpEaN1kH8EmRFtv96AO5Z2CLiBXvW17wYQdkxYl?=
 =?us-ascii?Q?GBEA5YPRkOsV1ORqWLqcE5I8lDzXy/9GiGBvwer1d706DlmrZFNTnW2KwfPU?=
 =?us-ascii?Q?fcL79Ui+/ybeGtIdnrHV0MmK3Z5WQYbkdW4825bao5mWedvu1Rah7ElJw+hD?=
 =?us-ascii?Q?h7z7LnUn92qLUMmmrc6Po7eKJH2GeGwoKn0bm5Qyiz+nPHUHMWnTLKZ5Bgw2?=
 =?us-ascii?Q?e+JZsh5JC3nfNAIn7uFR29AkCte5m1OHDX6dxHWqEm61KH5Dcg/WZXb82ltl?=
 =?us-ascii?Q?0QnxTyknQCrj80H6lWfsa/W2l0tiPdUnzNL6du2VhjhBhICurX5c5eMI7D2L?=
 =?us-ascii?Q?BWSqjYQCjiHdKfOUPC6MnIpTeVwtsojU+Avd7+FCSLwcceBHuROX+t4fcpSp?=
 =?us-ascii?Q?TH16XpPSdS6ZHzHdaKJlPz291E/ut1hCJUe1rOcKAEHPbDOZNoO+YW/aRRwZ?=
 =?us-ascii?Q?uu7GSnBYYEshpttfOr2ej2ToYD7TuSjQf5fm+FDZchgxfnxCnNb+vtTi0qW+?=
 =?us-ascii?Q?GPWLllIz/XDQfFoaiY9QJmPnt3M3+TY4zSyyP+2ZhSDadCxLHRN1MuIPpZjG?=
 =?us-ascii?Q?RuRUt2ZGxElyMXqjbgJLK+q+Jiz6FZXYyJpkke0BmmHRMUAjfE/UYhcPmDsk?=
 =?us-ascii?Q?YHdfPdjyYqcc4vls/rcmcY4sjYAS3s2AUc/KDAo9oqGwhEt3TbXvw06hGKg7?=
 =?us-ascii?Q?7lm0JVNBTaIG6PZ2sjET9r09Vas3KMXHYKi0M1sCqKvLO6QQ/AlQebvkqUyl?=
 =?us-ascii?Q?O717uAxKG3eHs7uFquoA221yj7iXC4O88eH8x0mnV4+15ksPDU/+O89AyJnt?=
 =?us-ascii?Q?KSWcK7BGO+eZVuegPnSZTn0y/B9y6kWOdw2FqRdRpaxeVaWEnIDFtluTiOEX?=
 =?us-ascii?Q?nqrQ0NP4SMkJnMpgeTIyVvjH9brDV7xzUdo1wUcX3qgWblj9qL1rNOFqG5Nr?=
 =?us-ascii?Q?EMY1OLfIrlOOD96DhM3IAWBM3/9lZoUbuDb+QgeoC0g3KSAtcwBcJ7UyqXWe?=
 =?us-ascii?Q?FqQqsnw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7O6Uvv/TjHzdrjK7adxEU2yEC6ltXQuhc5ckoLXVylOCuTIClCUjQ1IPej3z?=
 =?us-ascii?Q?b1XQp3zmESidfxD0nNjulzwYxHLBw/M+n8RnZmWCIq/C+rZI6Ib8U/WTFyLv?=
 =?us-ascii?Q?ML9sYeoScwdcCAbbEazjyMGQl4lMtzy3kmc6s6kT5ekoyUoVIIUuQdKyd0Mg?=
 =?us-ascii?Q?0CDQXMskJh1YFGpfGtQtkCvSeb96PYlrhfm6F6+L52HDk6evgjCCkeanlZGR?=
 =?us-ascii?Q?D2OjTieLtp/n/O8UUK7cHwfENvaBiaLbXEchnx2B5bWPgjE4bqIC43yIjv0J?=
 =?us-ascii?Q?CP0FDUs1kHpmogoc4FlrFrMh+H2zdpDCn7keg33C6CWlawVmV2zD4z7q1aiJ?=
 =?us-ascii?Q?66gUN5ilWSDn6OxPbZE4UZlSRJQdYN1MZb/yng6YY9ULXs0pT5WsTk1QKKeb?=
 =?us-ascii?Q?YM1tPcJ6CWhHj4kNKe1WKrXHgQqRAW/IrA4jSjWtgHZx3ZlIFd5gZnKiErcB?=
 =?us-ascii?Q?ze4KqumbUBOnFBysrETqFKkRZISmieRMb0pdDt2sgj+4Fz434Ycydx6XsqIm?=
 =?us-ascii?Q?PpUmMQAKM2FO4zeYbfgak+TBzu8aLzUp56Pgv7ecVu0DeuJpRS9Rr7ORgJ2E?=
 =?us-ascii?Q?HGSUuGf3uqBwztGTTFS/94rGSAjAuAtf82JwR8xxLfKwcG0bmFWFtiaGohw3?=
 =?us-ascii?Q?u5FAq0YWCUiO9qxTejwOin4WCMDzHLXaKHUxsO16F73U9531aOAPQWfEqS3A?=
 =?us-ascii?Q?YZP6wcuQIwnRIBVHqOW+Wt+Oo2uELpS+IZgedQR1geEwhHcjwuPIQ7eq6hIa?=
 =?us-ascii?Q?eXu437vYPr/W4s12xoukd5/SBn/PzE+torwgmPpfv304ZO/nlKGPVKUNYCbH?=
 =?us-ascii?Q?SUGg0TXh/a/jSqPXq2AhH+Q1/Dl6NvfvlcIxtFf3IFevP1Rt/m+jK4bCLzcI?=
 =?us-ascii?Q?RZLTkxriRA2OWztiMC62nKhiH6poVEAoLOSDJZ0CA66Lq8gcuaS23jY3YWKx?=
 =?us-ascii?Q?6UgRXvvJFEs0G3tMp34yIyMNNU0eqEPeQvYbSNwj/2j+hHQ45bWn/sl5uWgh?=
 =?us-ascii?Q?nWv5gpu9wf7sIjPm1yCdEyQvMYc6x1KkY0xvn980jKXIPXXJKa3QtpakABOC?=
 =?us-ascii?Q?6zamPMEIYARY66Kv6SQrS6XqBPJ9b8r7nokU/Lxz4Nmsnx/qKwwAdQIuyNxD?=
 =?us-ascii?Q?SRN7mJCZ+sdqeRAkNiFA2dOIm41t/aC8jOGYKXyJMjPYed/memOrLL5YnIMm?=
 =?us-ascii?Q?oDySQQQrhWi7+jJI6K417Hb+WpfkDq968eUQlYekSfoBABufm91Co8PtbN/X?=
 =?us-ascii?Q?b5A6ha6rSQCrHuSQQzfEtB7VEGBXm1J9nFxCwOb+m64FlXOxfhL7expIu02V?=
 =?us-ascii?Q?mSBbL9b8bfux8pKmK+LtT6M8+hbciGILI9gMBQNyQ28dkVKUFC2V1pgl71VC?=
 =?us-ascii?Q?bsB5cfQm8NtxavljOTaYo7PDG9gX+43tKn+BMoUwgMfrZZQZV49C8mD9v6T9?=
 =?us-ascii?Q?LOGBzaaGBSAZ75Uq3jThk4HuFTfhc/y0Lc8UV1YmLnW3RTSOzHWVEPKfMVbd?=
 =?us-ascii?Q?YzH2tuOZVpWu1d0zWZRWRt1WCtnPxCW8gw0EcM0xyZRIATeC3gJ9okL9a4g4?=
 =?us-ascii?Q?3bETLTB/HkQSBwJPqpfFeGoaOdMWqu+e2WLd7w3Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4d53bb-7e65-4afd-5d40-08dc91c76363
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:33.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9rVG7tXuSU4nKyAUFxM4yA1eXV79Px4dDv+COtiihbEVCgNr794KOyFFyVIr6PKufeLbx6UCNeXoyftuhBe8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c | 498 ++++++++++++++++++++
 1 file changed, 498 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c b/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
new file mode 100644
index 000000000000..055d59cb942f
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
@@ -0,0 +1,498 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: AP TX and RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "ioctl.h"
+#include "main.h"
+#include "wmm.h"
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+
+/* This function checks if particular RA list has packets more than low bridge
+ * packet threshold and then deletes packet from this RA list.
+ * Function deletes packets from such RA list and returns true. If no such list
+ * is found, false is returned.
+ */
+static bool
+nxpwifi_uap_del_tx_pkts_in_ralist(struct nxpwifi_private *priv,
+				  struct list_head *ra_list_head,
+				  int tid)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+	struct sk_buff *skb, *tmp;
+	bool pkt_deleted = false;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	list_for_each_entry(ra_list, ra_list_head, list) {
+		if (skb_queue_empty(&ra_list->skb_head))
+			continue;
+
+		skb_queue_walk_safe(&ra_list->skb_head, skb, tmp) {
+			tx_info = NXPWIFI_SKB_TXCB(skb);
+			if (tx_info->flags & NXPWIFI_BUF_FLAG_BRIDGED_PKT) {
+				__skb_unlink(skb, &ra_list->skb_head);
+				nxpwifi_write_data_complete(adapter, skb, 0,
+							    -1);
+				if (ra_list->tx_paused)
+					priv->wmm.pkts_paused[tid]--;
+				else
+					atomic_dec(&priv->wmm.tx_pkts_queued);
+				pkt_deleted = true;
+			}
+			if ((atomic_read(&adapter->pending_bridged_pkts) <=
+					     NXPWIFI_BRIDGED_PKTS_THR_LOW))
+				break;
+		}
+	}
+
+	return pkt_deleted;
+}
+
+/* This function deletes packets from particular RA List. RA list index
+ * from which packets are deleted is preserved so that packets from next RA
+ * list are deleted upon subsequent call thus maintaining fairness.
+ */
+static void nxpwifi_uap_cleanup_tx_queues(struct nxpwifi_private *priv)
+{
+	struct list_head *ra_list;
+	int i;
+
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+	for (i = 0; i < MAX_NUM_TID; i++, priv->del_list_idx++) {
+		if (priv->del_list_idx == MAX_NUM_TID)
+			priv->del_list_idx = 0;
+		ra_list = &priv->wmm.tid_tbl_ptr[priv->del_list_idx].ra_list;
+		if (nxpwifi_uap_del_tx_pkts_in_ralist(priv, ra_list, i)) {
+			priv->del_list_idx++;
+			break;
+		}
+	}
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+}
+
+static void
+nxpwifi_uap_queue_bridged_pkt(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	struct sk_buff *new_skb;
+	struct nxpwifi_txinfo *tx_info;
+	int hdr_chop;
+	struct ethhdr *p_ethhdr;
+	struct nxpwifi_sta_node *src_node;
+	int index;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	if ((atomic_read(&adapter->pending_bridged_pkts) >=
+					     NXPWIFI_BRIDGED_PKTS_THR_HIGH)) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Tx: Bridge packet limit reached. Drop packet!\n");
+		kfree_skb(skb);
+		nxpwifi_uap_cleanup_tx_queues(priv);
+		return;
+	}
+
+	if (sizeof(*rx_pkt_hdr) +
+	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		     sizeof(bridge_tunnel_header))) ||
+	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		     sizeof(rfc1042_header)) &&
+	     rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_AARP) &&
+	     rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_IPX))) {
+		/* Replace the 803 header and rfc1042 header (llc/snap) with
+		 * an Ethernet II header, keep the src/dst and snap_type
+		 * (ethertype).
+		 *
+		 * The firmware only passes up SNAP frames converting all RX
+		 * data from 802.11 to 802.2/LLC/SNAP frames.
+		 *
+		 * To create the Ethernet II, just move the src, dst address
+		 * right before the snap_type.
+		 */
+		p_ethhdr = (struct ethhdr *)
+			((u8 *)(&rx_pkt_hdr->eth803_hdr)
+			 + sizeof(rx_pkt_hdr->eth803_hdr)
+			 + sizeof(rx_pkt_hdr->rfc1042_hdr)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_dest)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_source)
+			 - sizeof(rx_pkt_hdr->rfc1042_hdr.snap_type));
+		memcpy(p_ethhdr->h_source, rx_pkt_hdr->eth803_hdr.h_source,
+		       sizeof(p_ethhdr->h_source));
+		memcpy(p_ethhdr->h_dest, rx_pkt_hdr->eth803_hdr.h_dest,
+		       sizeof(p_ethhdr->h_dest));
+		/* Chop off the rxpd + the excess memory from
+		 * 802.2/llc/snap header that was removed.
+		 */
+		hdr_chop = (u8 *)p_ethhdr - (u8 *)uap_rx_pd;
+	} else {
+		/* Chop off the rxpd */
+		hdr_chop = (u8 *)&rx_pkt_hdr->eth803_hdr - (u8 *)uap_rx_pd;
+	}
+
+	/* Chop off the leading header bytes so that it points
+	 * to the start of either the reconstructed EthII frame
+	 * or the 802.2/llc/snap frame.
+	 */
+	skb_pull(skb, hdr_chop);
+
+	if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "data: Tx: insufficient skb headroom %d\n",
+			    skb_headroom(skb));
+		/* Insufficient skb headroom - allocate a new skb */
+		new_skb =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		if (unlikely(!new_skb)) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Tx: cannot allocate new_skb\n");
+			kfree_skb(skb);
+			priv->stats.tx_dropped++;
+			return;
+		}
+
+		kfree_skb(skb);
+		skb = new_skb;
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: new skb headroom %d\n",
+			    skb_headroom(skb));
+	}
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->flags |= NXPWIFI_BUF_FLAG_BRIDGED_PKT;
+
+	src_node = nxpwifi_get_sta_entry(priv, rx_pkt_hdr->eth803_hdr.h_source);
+	if (src_node) {
+		src_node->stats.last_rx = jiffies;
+		src_node->stats.rx_bytes += skb->len;
+		src_node->stats.rx_packets++;
+		src_node->stats.last_tx_rate = uap_rx_pd->rx_rate;
+		src_node->stats.last_tx_htinfo = uap_rx_pd->ht_info;
+	}
+
+	if (is_unicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest)) {
+		/* Update bridge packet statistics as the
+		 * packet is not going to kernel/upper layer.
+		 */
+		priv->stats.rx_bytes += skb->len;
+		priv->stats.rx_packets++;
+
+		/* Sending bridge packet to TX queue, so save the packet
+		 * length in TXCB to update statistics in TX complete.
+		 */
+		tx_info->pkt_len = skb->len;
+	}
+
+	__net_timestamp(skb);
+
+	index = nxpwifi_1d_to_wmm_queue[skb->priority];
+	atomic_inc(&priv->wmm_tx_pending[index]);
+	nxpwifi_wmm_add_buf_txqueue(priv, skb);
+	atomic_inc(&adapter->tx_pending);
+	atomic_inc(&adapter->pending_bridged_pkts);
+
+	nxpwifi_queue_main_work(priv->adapter);
+}
+
+/* This function contains logic for AP packet forwarding.
+ *
+ * If a packet is multicast/broadcast, it is sent to kernel/upper layer
+ * as well as queued back to AP TX queue so that it can be sent to other
+ * associated stations.
+ * If a packet is unicast and RA is present in associated station list,
+ * it is again requeued into AP TX queue.
+ * If a packet is unicast and RA is not in associated station list,
+ * packet is forwarded to kernel to handle routing logic.
+ */
+int nxpwifi_handle_uap_rx_forward(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u8 ra[ETH_ALEN];
+	struct sk_buff *skb_uap;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	/* don't do packet forwarding in disconnected state */
+	if (!priv->media_connected) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "drop packet in disconnected state.\n");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	memcpy(ra, rx_pkt_hdr->eth803_hdr.h_dest, ETH_ALEN);
+
+	if (is_multicast_ether_addr(ra)) {
+		skb_uap = skb_copy(skb, GFP_ATOMIC);
+		if (likely(skb_uap)) {
+			nxpwifi_uap_queue_bridged_pkt(priv, skb_uap);
+		} else {
+			nxpwifi_dbg(adapter, ERROR,
+				    "failed to copy skb for uAP\n");
+				    priv->stats.rx_dropped++;
+				    dev_kfree_skb_any(skb);
+			return -1;
+		}
+	} else {
+		if (nxpwifi_get_sta_entry(priv, ra)) {
+			/* Requeue Intra-BSS packet */
+			nxpwifi_uap_queue_bridged_pkt(priv, skb);
+			return 0;
+		}
+	}
+
+	/* Forward unicat/Inter-BSS packets to kernel. */
+	return nxpwifi_process_rx_packet(priv, skb);
+}
+
+int nxpwifi_uap_recv_packet(struct nxpwifi_private *priv,
+			    struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_sta_node *src_node;
+	struct ethhdr *p_ethhdr;
+	struct sk_buff *skb_uap;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (!skb)
+		return -1;
+
+	p_ethhdr = (void *)skb->data;
+	src_node = nxpwifi_get_sta_entry(priv, p_ethhdr->h_source);
+	if (src_node) {
+		src_node->stats.last_rx = jiffies;
+		src_node->stats.rx_bytes += skb->len;
+		src_node->stats.rx_packets++;
+	}
+
+	if (is_multicast_ether_addr(p_ethhdr->h_dest) ||
+	    nxpwifi_get_sta_entry(priv, p_ethhdr->h_dest)) {
+		if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN)
+			skb_uap =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		else
+			skb_uap = skb_copy(skb, GFP_ATOMIC);
+
+		if (likely(skb_uap)) {
+			tx_info = NXPWIFI_SKB_TXCB(skb_uap);
+			memset(tx_info, 0, sizeof(*tx_info));
+			tx_info->bss_num = priv->bss_num;
+			tx_info->bss_type = priv->bss_type;
+			tx_info->flags |= NXPWIFI_BUF_FLAG_BRIDGED_PKT;
+			__net_timestamp(skb_uap);
+			nxpwifi_wmm_add_buf_txqueue(priv, skb_uap);
+			atomic_inc(&adapter->tx_pending);
+			atomic_inc(&adapter->pending_bridged_pkts);
+			if ((atomic_read(&adapter->pending_bridged_pkts) >=
+					NXPWIFI_BRIDGED_PKTS_THR_HIGH)) {
+				nxpwifi_dbg(adapter, ERROR,
+					    "Tx: Bridge packet limit reached. Drop packet!\n");
+				nxpwifi_uap_cleanup_tx_queues(priv);
+			}
+
+		} else {
+			nxpwifi_dbg(adapter, ERROR, "failed to allocate skb_uap");
+		}
+
+		nxpwifi_queue_main_work(adapter);
+		/* Don't forward Intra-BSS unicast packet to upper layer*/
+		if (nxpwifi_get_sta_entry(priv, p_ethhdr->h_dest))
+			return 0;
+	}
+
+	skb->dev = priv->netdev;
+	skb->protocol = eth_type_trans(skb, priv->netdev);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* Forward multicast/broadcast packet to upper layer*/
+	netif_rx(skb);
+	return 0;
+}
+
+/* This function processes the packet received on AP interface.
+ *
+ * The function looks into the RxPD and performs sanity tests on the
+ * received buffer to ensure its a valid packet before processing it
+ * further. If the packet is determined to be aggregated, it is
+ * de-aggregated accordingly. Then skb is passed to AP packet forwarding logic.
+ *
+ * The completion callback is called after processing is complete.
+ */
+int nxpwifi_process_uap_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u16 rx_pkt_type;
+	u8 ta[ETH_ALEN], pkt_type;
+	struct nxpwifi_sta_node *node;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	    sizeof(rx_pkt_hdr->eth803_hdr) > skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet for struct ethhdr: len=%d, offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
+
+	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	     le16_to_cpu(uap_rx_pd->rx_pkt_length)) > (u16)skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet: len=%d, offset=%d, length=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset),
+			    le16_to_cpu(uap_rx_pd->rx_pkt_length));
+		priv->stats.rx_dropped++;
+
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			node->stats.tx_failed++;
+
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	if (rx_pkt_type == PKT_TYPE_MGMT) {
+		ret = nxpwifi_process_mgmt_packet(priv, skb);
+		if (ret)
+			nxpwifi_dbg(adapter, DATA, "Rx of mgmt packet failed");
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (rx_pkt_type != PKT_TYPE_BAR && uap_rx_pd->priority < MAX_NUM_TID) {
+		spin_lock_bh(&priv->sta_list_spinlock);
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			node->rx_seq[uap_rx_pd->priority] =
+						le16_to_cpu(uap_rx_pd->seq_num);
+		spin_unlock_bh(&priv->sta_list_spinlock);
+	}
+
+	if (!priv->ap_11n_enabled ||
+	    (!nxpwifi_11n_get_rx_reorder_tbl(priv, uap_rx_pd->priority, ta) &&
+	    (le16_to_cpu(uap_rx_pd->rx_pkt_type) != PKT_TYPE_AMSDU))) {
+		ret = nxpwifi_handle_uap_rx_forward(priv, skb);
+		return ret;
+	}
+
+	/* Reorder and send to kernel */
+	pkt_type = (u8)le16_to_cpu(uap_rx_pd->rx_pkt_type);
+	ret = nxpwifi_11n_rx_reorder_pkt(priv, le16_to_cpu(uap_rx_pd->seq_num),
+					 uap_rx_pd->priority, ta, pkt_type,
+					 skb);
+
+	if (ret || rx_pkt_type == PKT_TYPE_BAR)
+		dev_kfree_skb_any(skb);
+
+	if (ret)
+		priv->stats.rx_dropped++;
+
+	return ret;
+}
+
+/* This function fills the TxPD for AP tx packets.
+ *
+ * The Tx buffer received by this function should already have the
+ * header space allocated for TxPD.
+ *
+ * This function inserts the TxPD in between interface header and actual
+ * data and adjusts the buffer pointers accordingly.
+ *
+ * The following TxPD fields are set by this function, as required -
+ *      - BSS number
+ *      - Tx packet length and offset
+ *      - Priority
+ *      - Packet delay
+ *      - Priority specific Tx control
+ *      - Flags
+ */
+void nxpwifi_process_uap_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_txpd *txpd;
+	struct nxpwifi_txinfo *tx_info = NXPWIFI_SKB_TXCB(skb);
+	int pad;
+	u16 pkt_type, pkt_offset;
+	int hroom = adapter->intf_hdr_len;
+
+	pkt_type = nxpwifi_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
+
+	pad = ((uintptr_t)skb->data - (sizeof(*txpd) + hroom)) &
+	       (NXPWIFI_DMA_ALIGN_SZ - 1);
+
+	skb_push(skb, sizeof(*txpd) + pad);
+
+	txpd = (struct uap_txpd *)skb->data;
+	memset(txpd, 0, sizeof(*txpd));
+	txpd->bss_num = priv->bss_num;
+	txpd->bss_type = priv->bss_type;
+	txpd->tx_pkt_length = cpu_to_le16((u16)(skb->len - (sizeof(*txpd) +
+						pad)));
+	txpd->priority = (u8)skb->priority;
+
+	txpd->pkt_delay_2ms = nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS ||
+	    tx_info->flags & NXPWIFI_BUF_FLAG_ACTION_TX_STATUS) {
+		txpd->tx_token_id = tx_info->ack_frame_id;
+		txpd->flags |= NXPWIFI_TXPD_FLAGS_REQ_TX_STATUS;
+	}
+
+	if (txpd->priority < ARRAY_SIZE(priv->wmm.user_pri_pkt_tx_ctrl))
+		/* Set the priority specific tx_control field, setting of 0 will
+		 * cause the default value to be used later in this function.
+		 */
+		txpd->tx_control =
+		    cpu_to_le32(priv->wmm.user_pri_pkt_tx_ctrl[txpd->priority]);
+
+	/* Offset of actual data */
+	pkt_offset = sizeof(*txpd) + pad;
+	if (pkt_type == PKT_TYPE_MGMT) {
+		/* Set the packet type and add header for management frame */
+		txpd->tx_pkt_type = cpu_to_le16(pkt_type);
+		pkt_offset += NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	}
+
+	txpd->tx_pkt_offset = cpu_to_le16(pkt_offset);
+
+	/* make space for adapter->intf_hdr_len */
+	skb_push(skb, hroom);
+
+	if (!txpd->tx_control)
+		/* TxCtrl set by user or default */
+		txpd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+}
-- 
2.34.1


