Return-Path: <linux-wireless+bounces-9399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98575911DB5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250411F21166
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF61717B435;
	Fri, 21 Jun 2024 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oWEaoRkK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2D17B410;
	Fri, 21 Jun 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956477; cv=fail; b=oBRV9w/SgiAds9Sq3YcMfnOGqeq4YEzX1QdqeUTaQuzhwQuWJGVWpsPiDerzSCOEfyCZV75xkQjYgiPgKk4Um2/TWaWW39v5ZjBt7kVpYgh187t5mNazxc1hfLYpmEcLVVy1ZEeZG11WhdWx/MPCRBZ2AA36EEwmsz5fdX+dwG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956477; c=relaxed/simple;
	bh=YoSlgN26Bdqe/2KvCNAIsfpJ7Z26bb0vqxd0YI6CVqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbRf5Kgsuy96BF3+s7CPa7jymZt5zWc15uHV7HCFO4ANHxW1h3jyOofQMbA1A/TTF2sBdlSWSjf6k/gru4F/Ue+3U/DJnBCK12xu0v6tpG7dTxPov1ZzAC3bpfyi0tUIhU1HAyz05sLr6xFu/mlagW7wPDnJfH/zpRp3lBlRHc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oWEaoRkK; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guNATDMld1Y2zAAkkeCpw8EszXMksF23xfj4GTUhpjD2pUOk+ruOhl/NTIYDPi93OakeU/Le6GHceujdR7aLgTX/7VZi7uOL5uHiKhmWCK7JRaN8bmeqybQJEa2feeOWSouumpblORQEvZf5JQvAnWXVF0gZBh2Vt7z1r1BdvxM82JbG4pYR/xhoAP42KeyvtbVi3Mnvjk+IjfGIGpOSkQuSHr5/sEtnGGpuAGvlbtSiOMd4aRLqydZgdOVmQKUBwgGbE5kk/1zDVRcaNvz+t4cWrTgu7MYLsNz6V8mRJvqe6sIfcP0CREYlQTGyXcbwDv6OVfDE25C7D+mk0Jt9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbCjsVVT6y3+92l4US55cLejzoVFTytHoQxx10eDZLw=;
 b=Po630c+kPHJ8UXoSIje4F78kw8eriLhWglsZfeXOtEjh24VhD/ChiO1OBMKaTwYODCxjp8DGtx7yoI0lo3kriSEOQaN9qwxhW/XM1fo5F/jKOdhu6ElU5vxDzQc0wN3/E6R1i5M9uUsghMggvIQDwnWHwg9lOoBzy+a+BMKOF0b550oJZaiExjXF2NfiqHRJExHpwppkG3dzSYf1adrc/m2VgOsyIazerxIUJ+SzWaduqcUfYq9E1uHfd4v44Wl4nkl6ArRL2tRjPSPX0YfWFqbS3ep3dj6bv/M3aUDwL6+1daZlwDYXargF+nxdJPQ4OGIuMC3SLUvWyn2bh6en8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbCjsVVT6y3+92l4US55cLejzoVFTytHoQxx10eDZLw=;
 b=oWEaoRkKCMCnrAA2Ed/x4EMKdQAtZlaYDcatrx/McR0Fe4MpYpiCcbQ+rtSX2+24WcAduJ4VSrW5ILJSwxfxoGczO3v/IDNiVuLuSPq0+1chLUUGb38ojFGwV103RfaQ7swrSdwWxa7aSY8FP7JOe3S0blmp+KQvy1ojLFVYH+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:30 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:30 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 35/43] wifi: nxpwifi: add uap_event.c
Date: Fri, 21 Jun 2024 15:52:00 +0800
Message-Id: <20240621075208.513497-36-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d5ff4f6-ce74-4893-0e0d-08dc91c761a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1YKviy65OFGVx0Obik/IId4EeXyFBfsqkuY+63yRygrePRIx00bgZqTBg4f4?=
 =?us-ascii?Q?zUHyhyCGVFIiV3wWMWp2jkLeT2Oe4nNhpNPU1uE6sO96GN/Y2HrJJ5AaCafj?=
 =?us-ascii?Q?VhwUVLU5zJwvjiEKtP/PFfgu2GVtsvV97pdGdwF5H6Y/y6T35RCJuhx62AHT?=
 =?us-ascii?Q?FbtMOkJz0Q+rK/+J1TLXZdt8WxN6nvQVhl1gpoMWs2dYTyLSH+Z2l45V6WrQ?=
 =?us-ascii?Q?/gJ3Q/uKIhCHN1ZmOlG5daHsM34RdF3PZro3GXPxj0mMe4glcbG88jCCeixD?=
 =?us-ascii?Q?4QKOesYr9LI5rTzjcupXY6YDUNBsBnvrY9o+X8hg6k9HRvq7qEPlIaMBbnjO?=
 =?us-ascii?Q?votlrkmUZ+7allJL8JTMtNQ03zTurvpsxhfNRnOIDTBLYir9G5tm2WBfG9jF?=
 =?us-ascii?Q?lIFo10ajyUxMbGDRSK5nCbyAUpf4uNJilDP9aXQuP3/+L1sSD2BeVyh8VgE1?=
 =?us-ascii?Q?0wxbqbRyhHsVWdsGsaJS8Xo/nnt5iVYCf2KgoWtFTQ7csImBtPL+4bqTbOB6?=
 =?us-ascii?Q?X4eah8yjGNhwjuFdsc2SEk6Uu3xmmatpYsPRE4AyGhVnfv9Nu/sXR5U3LeXu?=
 =?us-ascii?Q?ImgQEBslb9dAchWlKSly8/y/M4HOvh47qm+GSnOZ61Is0MYTDah6cOwNRJbE?=
 =?us-ascii?Q?qhWZs4mJwAcIcp9HMyP2dxje+KhggUarNTQ25Z18S2Qo9erxk+bxBVcM47zK?=
 =?us-ascii?Q?pB4EY07NPeMtZgGEPBzDMpIW8ah+Bfw9gFN7CI/YDVnyVZ6iCUGKjtyOy0nq?=
 =?us-ascii?Q?HqyUt8XSZ0BlQv1+fMezz1SwZRTzeOdhlGisbuQLffvkYRdsqgQB/6OOhC3H?=
 =?us-ascii?Q?dc5nqI2pLNQPEPWv6iIEa/E1l7V9pvGJ7mmjMzJLdo6KW25OYEvVL2V2wb/c?=
 =?us-ascii?Q?mqUGYFmG35AWouQXvwqGgqXIGAiZK18YoFkNYGZhtWSmDAl/HYWAy6f/Uhtl?=
 =?us-ascii?Q?JTbmoPhDGTxlyKrqSxJoB43A+3N2U/AbxBXZYpCd4RYT95U07Qt0ij+yhMID?=
 =?us-ascii?Q?glHr/jzxczNWFKBztv0RNek1huBxDfpv8ocb/TTq6oo+WYWqeIisGFtTnElH?=
 =?us-ascii?Q?6vk+AXSaOVJH/m0V0lvZlKwtZClug8p+enpjlHEq1cxB5AWxN10jtcfRMpmZ?=
 =?us-ascii?Q?MKOn/VIs3lbAdJQ0ExRO0GM9ScZUKb/Njw/F51Fs5UaWejFo9+/Q+uvfemQS?=
 =?us-ascii?Q?hOxFTr/HVyErMBayYa+5AO5DE32/0SjBWHNf1iX6b99GGO5bUbG7AI+ZkbwT?=
 =?us-ascii?Q?BG6AnZBfm1fXgMqi3mYRIqO5rYQFmHZRtlM5zyqwkEeuCMQeg4j50RhRWui5?=
 =?us-ascii?Q?gkEoXFujzBHcUg5j0JcdfFL7uGtRhvvqXtekFsWmm7aDwxDw5ytK9OPHgTjE?=
 =?us-ascii?Q?6TDUYHw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ptq9KkUMY+pLdloRmIqpik5tE2LBkPKK6LXdCVD2ZscrkTtHeI1sc2XJHVLN?=
 =?us-ascii?Q?M/FSOcJhYmbfpAX9Jqe9XC55FeiE/hHLgGZmaZvdqMfnRQJ2JfCEcYN2T5b1?=
 =?us-ascii?Q?75UDZoxSzz5/8uVCxYt/WZG3Jez97hCYtB9luNase4PmyYmP6v/vwyHnBv8c?=
 =?us-ascii?Q?fNzc6mi/nSayfvKewIYd0Cg+pad0NTj8Pm1+ffrsl/AUnfLMk1Hq9MfiTagR?=
 =?us-ascii?Q?9BrLcjWiJQrsUNWSEARiY//xpmgrOxY+iGivsdcM4W2zQbOmSr9RAJ8miUCL?=
 =?us-ascii?Q?gE2jgIoh32trvGcKLn14ObXRK4bS+YzkzPubm5+hcmVcyAsjTQKPmF+afzdU?=
 =?us-ascii?Q?WdcGBFv262YNrrItcT9KRR63JFV9K+q56/fHJl0elY0p7sTNNIVOWVBF7tF8?=
 =?us-ascii?Q?SqdrvYZwIzjZLLSlSFnRzlqkRxpE3hw6PfZ0O8y1bAPMcEqKzjl2LsTO9XOH?=
 =?us-ascii?Q?juV/FlxYZSzPDSLiYJZ8kvr86fUcVkEpTgdDTf+nf47a3wzvNQchdWgHplZC?=
 =?us-ascii?Q?vL2bCpGEcXEPtF/sOxtJqNCy1PilpYq98G/37m69snQNtgFCufrYk9/bGOqo?=
 =?us-ascii?Q?WbSmosTmmITVZGKFHTjm/ycAR2A6/RYPs+YmRJHFL/iC6VyFIuvd+gwJvtSk?=
 =?us-ascii?Q?JS1INv2I7S4Ku3FROMspWCzqIcaKdLiG4uWCOsRxmzhLOfMh1Cq+wdR1DMYl?=
 =?us-ascii?Q?R4apqiLVZrzDyi0wsIxm1EJ6A2d0mIBC6SfTY44g7SFT/nlEITnf/0/PxlEz?=
 =?us-ascii?Q?RmpYifR5wtLvEcneP2zxXnV0cKevmGmCvzOQQJZAVqcsyFMBvY54wNhGXWlz?=
 =?us-ascii?Q?LNMxKSBMKuqHBbgyMw1ZahCib9Uv2x03t4gQYOCVregeBhvrZDaJXCRFXGxb?=
 =?us-ascii?Q?uXMRQm/prQD+TfGylXBbgRpU0tyVm5JPxQVD08Ia+JSBKJlOYsa/qw3GJ998?=
 =?us-ascii?Q?lH9soRGbP/bGJ9Z2gkroCZqvUYfpKYiapKyWjlKAl4Fw+GT0xs3htDVMEetB?=
 =?us-ascii?Q?ir9rkaZwaLwwe8FnbXVWbHdMV370ffahzppm+pBGeB6UaXh6pnxesuUJ4e9j?=
 =?us-ascii?Q?ZMhjgm9Wb8jWPaIzM5aUYSS58Jbcgo7P6P1ABfVSb8L2qyYmHxGK6u/TnnQL?=
 =?us-ascii?Q?5xbW5ssSeTPYMWl68jtyjVz4t85Ov0S+0m51l7lGw9XKH8rNY1LQq9m/Y+Qy?=
 =?us-ascii?Q?gZdL0t3VVt8qiuZHRYltNXyFsvl9XEl0NPEAQMP3qcvgwQRkbYWrohlqIpHM?=
 =?us-ascii?Q?cpcWFXm5+gnJCDS0iAWYRdsVP5fPUwT6QxSibODIsTd8RUMF5Xp//JnzuF7G?=
 =?us-ascii?Q?EV1ninHHGJ6WrQ4rtI9D254bmJRxm2VLdWtPdRcaZ/t0F3Zd4u6+f7Zxn6+U?=
 =?us-ascii?Q?UjMNk04AUaJyK3uiOiO562AZHKIVNa0VjhPcv7CE/v8E1xhqWG0HwcfkmL89?=
 =?us-ascii?Q?ToYKS7BdpwJz0sbRUQPw4A8BvoOkmZ81WfAu2OCtQz8SbgT3y6M6EXbsw9Sh?=
 =?us-ascii?Q?C5Vlit+/DtOm66TQgL3sQCzbG7lWGQJFssxwnDGRu+wdvjyWk5rKgdepOahd?=
 =?us-ascii?Q?CxxpnDy7hC8W2j/B/H0Xjdk/U5hVXqNZNgb8FaKk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5ff4f6-ce74-4893-0e0d-08dc91c761a2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:30.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZ5zAHBCCiPIEd1HOJyiQ/OrMav4lo2XiBPnrR47CH9XAMOssi5hwngFR44jE5OMt2hu4FvAKUgaGOu+ziQGnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/uap_event.c | 483 +++++++++++++++++++
 1 file changed, 483 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/uap_event.c b/drivers/net/wireless/nxp/nxpwifi/uap_event.c
new file mode 100644
index 000000000000..2c15b01ec018
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/uap_event.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: AP event handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
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
+			if (adapter->data_sent ||
+			    (adapter->if_ops.is_port_ready &&
+			     !adapter->if_ops.is_port_ready(priv))) {
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
+	nxpwifi_del_sta_entry(priv, deauth_mac);
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
+		return -1;
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
+		if (node->is_11n_enabled)
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
+	struct ieee_types_wmm_parameter *wmm_param_ie = NULL;
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
+			wmm_param_ie->vend_hdr.len = (u8)tlv_len;
+			wmm_param_ie->vend_hdr.element_id =
+						WLAN_EID_VENDOR_SPECIFIC;
+			nxpwifi_dbg(priv->adapter, EVENT,
+				    "info: check uap capabilities:\t"
+				    "wmm parameter set count: %d\n",
+				    wmm_param_ie->qos_info_bitmap & mask);
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


