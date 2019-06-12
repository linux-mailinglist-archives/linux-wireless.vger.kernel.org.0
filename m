Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D958741C76
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 08:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfFLGpd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 02:45:33 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51296 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731216AbfFLGpc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 02:45:32 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5C6jSdb004352, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5C6jSdb004352
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Jun 2019 14:45:29 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 14:45:28 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 03/11] rtw88: add beacon function setting
Date:   Wed, 12 Jun 2019 14:45:09 +0800
Message-ID: <1560321917-17751-4-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
References: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Add beacon function setting routines for each hardware port.
If beacon function is not enabled, the hardware is not able
to synchronize with AP's beacon and can miss the beacons
under some scenarios such as PS mode.

For AP and Adhoc modes that require to send beacons, do not
update the TSF, otherwise the beacon interval may be affected.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 13 +++++++++++++
 drivers/net/wireless/realtek/rtw88/main.c     |  5 +++++
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 61436bb..abe6a14 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -85,30 +85,35 @@ static const struct rtw_vif_port rtw_vif_port[] = {
 		.bssid		= {.addr = 0x0618},
 		.net_type	= {.addr = 0x0100, .mask = 0x30000},
 		.aid		= {.addr = 0x06a8, .mask = 0x7ff},
+		.bcn_ctrl	= {.addr = 0x0550, .mask = 0xff},
 	},
 	[1] = {
 		.mac_addr	= {.addr = 0x0700},
 		.bssid		= {.addr = 0x0708},
 		.net_type	= {.addr = 0x0100, .mask = 0xc0000},
 		.aid		= {.addr = 0x0710, .mask = 0x7ff},
+		.bcn_ctrl	= {.addr = 0x0551, .mask = 0xff},
 	},
 	[2] = {
 		.mac_addr	= {.addr = 0x1620},
 		.bssid		= {.addr = 0x1628},
 		.net_type	= {.addr = 0x1100, .mask = 0x3},
 		.aid		= {.addr = 0x1600, .mask = 0x7ff},
+		.bcn_ctrl	= {.addr = 0x0578, .mask = 0xff},
 	},
 	[3] = {
 		.mac_addr	= {.addr = 0x1630},
 		.bssid		= {.addr = 0x1638},
 		.net_type	= {.addr = 0x1100, .mask = 0xc},
 		.aid		= {.addr = 0x1604, .mask = 0x7ff},
+		.bcn_ctrl	= {.addr = 0x0579, .mask = 0xff},
 	},
 	[4] = {
 		.mac_addr	= {.addr = 0x1640},
 		.bssid		= {.addr = 0x1648},
 		.net_type	= {.addr = 0x1100, .mask = 0x30},
 		.aid		= {.addr = 0x1608, .mask = 0x7ff},
+		.bcn_ctrl	= {.addr = 0x057a, .mask = 0xff},
 	},
 };
 
@@ -120,6 +125,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	enum rtw_net_type net_type;
 	u32 config = 0;
 	u8 port = 0;
+	u8 bcn_ctrl = 0;
 
 	rtwvif->port = port;
 	rtwvif->vif = vif;
@@ -136,13 +142,16 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
 		net_type = RTW_NET_AP_MODE;
+		bcn_ctrl = BIT_EN_BCN_FUNCTION | BIT_DIS_TSF_UDT;
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		net_type = RTW_NET_AD_HOC;
+		bcn_ctrl = BIT_EN_BCN_FUNCTION | BIT_DIS_TSF_UDT;
 		break;
 	case NL80211_IFTYPE_STATION:
 	default:
 		net_type = RTW_NET_NO_LINK;
+		bcn_ctrl = BIT_EN_BCN_FUNCTION;
 		break;
 	}
 
@@ -150,6 +159,8 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	config |= PORT_SET_MAC_ADDR;
 	rtwvif->net_type = net_type;
 	config |= PORT_SET_NET_TYPE;
+	rtwvif->bcn_ctrl = bcn_ctrl;
+	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
 	mutex_unlock(&rtwdev->mutex);
@@ -173,6 +184,8 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 	config |= PORT_SET_MAC_ADDR;
 	rtwvif->net_type = RTW_NET_NO_LINK;
 	config |= PORT_SET_NET_TYPE;
+	rtwvif->bcn_ctrl = 0;
+	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 306d799..b8e0519 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -308,6 +308,11 @@ void rtw_vif_port_config(struct rtw_dev *rtwdev,
 		mask = rtwvif->conf->aid.mask;
 		rtw_write32_mask(rtwdev, addr, mask, rtwvif->aid);
 	}
+	if (config & PORT_SET_BCN_CTRL) {
+		addr = rtwvif->conf->bcn_ctrl.addr;
+		mask = rtwvif->conf->bcn_ctrl.mask;
+		rtw_write8_mask(rtwdev, addr, mask, rtwvif->bcn_ctrl);
+	}
 }
 
 static u8 hw_bw_cap_to_bitamp(u8 bw_cap)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 00fc77f..414d21f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -431,6 +431,7 @@ enum rtw_vif_port_set {
 	PORT_SET_BSSID		= BIT(1),
 	PORT_SET_NET_TYPE	= BIT(2),
 	PORT_SET_AID		= BIT(3),
+	PORT_SET_BCN_CTRL	= BIT(4),
 };
 
 struct rtw_vif_port {
@@ -438,6 +439,7 @@ struct rtw_vif_port {
 	struct rtw_hw_reg bssid;
 	struct rtw_hw_reg net_type;
 	struct rtw_hw_reg aid;
+	struct rtw_hw_reg bcn_ctrl;
 };
 
 struct rtw_tx_pkt_info {
@@ -591,6 +593,7 @@ struct rtw_vif {
 	u8 mac_addr[ETH_ALEN];
 	u8 bssid[ETH_ALEN];
 	u8 port;
+	u8 bcn_ctrl;
 	const struct rtw_vif_port *conf;
 
 	struct rtw_traffic_stats stats;
-- 
2.7.4

