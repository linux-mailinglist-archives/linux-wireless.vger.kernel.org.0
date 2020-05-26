Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00191CFEDD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgELUDJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 16:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731077AbgELUDF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 16:03:05 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A2B20753;
        Tue, 12 May 2020 20:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589313784;
        bh=kXKyWrl0IYZIsY/wy0LBJH7I5PyxDo46065KM5XDZ+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13o8paQdknW2dDsvzMhcwunHDqCftOs9EQ1NemBCfryxt8ElNEXMiQz8EusjEyJjC
         sxsWcBMCQCCZCq/LhPEfKYUFnh8FGF5kSdmgLrr63I0NkUk9+GA5HEarc/3ENGLIdW
         o2asgpQ69veGa1ubidBroQvD5GN1wZ5IHTdDIrgw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 3/4] mt76: enable p2p support
Date:   Tue, 12 May 2020 22:02:49 +0200
Message-Id: <33ea6a979805728f1f713f387627832fb1399aae.1589313659.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589313659.git.lorenzo@kernel.org>
References: <cover.1589313659.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce p2p-go/p2p-client suppor to mt76 driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  2 +
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  6 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 61 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  4 ++
 8 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 21407704f1b3..907098101898 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -313,6 +313,8 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 #ifdef CONFIG_MAC80211_MESH
 		BIT(NL80211_IFTYPE_MESH_POINT) |
 #endif
+		BIT(NL80211_IFTYPE_P2P_CLIENT) |
+		BIT(NL80211_IFTYPE_P2P_GO) |
 		BIT(NL80211_IFTYPE_ADHOC);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index f641a8b56b39..94196599797e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -342,6 +342,8 @@ static const struct ieee80211_iface_limit if_limits[] = {
 #ifdef CONFIG_MAC80211_MESH
 			 BIT(NL80211_IFTYPE_MESH_POINT) |
 #endif
+			 BIT(NL80211_IFTYPE_P2P_CLIENT) |
+			 BIT(NL80211_IFTYPE_P2P_GO) |
 			 BIT(NL80211_IFTYPE_AP)
 	 },
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 6e1a17f08f5e..b5bbe9f5f7dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -140,7 +140,9 @@ void mt7615_check_offload_capability(struct mt7615_dev *dev)
 		ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 
 		wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
-				   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
+				   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR |
+				   NL80211_FEATURE_P2P_GO_CTWIN |
+				   NL80211_FEATURE_P2P_GO_OPPPS;
 	} else {
 		dev->ops->hw_scan = NULL;
 		dev->ops->cancel_hw_scan = NULL;
@@ -205,6 +207,8 @@ static const struct ieee80211_iface_limit if_limits[] = {
 #ifdef CONFIG_MAC80211_MESH
 			 BIT(NL80211_IFTYPE_MESH_POINT) |
 #endif
+			 BIT(NL80211_IFTYPE_P2P_CLIENT) |
+			 BIT(NL80211_IFTYPE_P2P_GO) |
 			 BIT(NL80211_IFTYPE_STATION)
 	}
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index c8705f91bafc..e87a5843c718 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -503,6 +503,9 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
 		mt7615_mcu_add_bss_info(phy, vif, NULL, info->enable_beacon);
 		mt7615_mcu_sta_add(dev, vif, NULL, info->enable_beacon);
+
+		if (vif->p2p && info->enable_beacon)
+			mt7615_mcu_set_p2p_oppps(hw, vif);
 	}
 
 	if (changed & (BSS_CHANGED_BEACON |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e9ae7e94d8fd..92ea9dc3c1c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -695,9 +695,9 @@ mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 			 struct ieee80211_sta *sta, bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	u32 type = vif->p2p ? NETWORK_P2P : NETWORK_INFRA;
 	struct bss_info_basic *bss;
 	u8 wlan_idx = mvif->sta.wcid.idx;
-	u32 type = NETWORK_INFRA;
 	struct tlv *tlv;
 
 	tlv = mt7615_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
@@ -749,10 +749,16 @@ mt7615_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
-		type = CONNECTION_INFRA_AP;
+		if (vif->p2p)
+			type = CONNECTION_P2P_GO;
+		else
+			type = CONNECTION_INFRA_AP;
 		break;
 	case NL80211_IFTYPE_STATION:
-		type = CONNECTION_INFRA_STA;
+		if (vif->p2p)
+			type = CONNECTION_P2P_GC;
+		else
+			type = CONNECTION_INFRA_STA;
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		type = CONNECTION_IBSS_ADHOC;
@@ -815,6 +821,7 @@ mt7615_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 {
 	struct sta_rec_basic *basic;
 	struct tlv *tlv;
+	int conn_type;
 
 	tlv = mt7615_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
 
@@ -837,11 +844,19 @@ mt7615_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
-		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic->conn_type = cpu_to_le32(conn_type);
 		basic->aid = cpu_to_le16(sta->aid);
 		break;
 	case NL80211_IFTYPE_STATION:
-		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic->conn_type = cpu_to_le32(conn_type);
 		basic->aid = cpu_to_le16(vif->bss_conf.aid);
 		break;
 	case NL80211_IFTYPE_ADHOC:
@@ -1403,7 +1418,7 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			.short_st = true,
 		},
 	};
-	int err;
+	int err, conn_type;
 	u8 idx;
 
 	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
@@ -1412,10 +1427,18 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
-		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GO;
+		else
+			conn_type = CONNECTION_INFRA_AP;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
 		break;
 	case NL80211_IFTYPE_STATION:
-		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		if (vif->p2p)
+			conn_type = CONNECTION_P2P_GC;
+		else
+			conn_type = CONNECTION_INFRA_STA;
+		basic_req.basic.conn_type = cpu_to_le32(conn_type);
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
@@ -3550,3 +3573,25 @@ int mt7615_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 				       MCU_UNI_CMD_OFFLOAD, true);
 }
 #endif /* CONFIG_PM */
+
+int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	int ct_window = vif->bss_conf.p2p_noa_attr.oppps_ctwindow;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct {
+		__le32 ct_win;
+		u8 bss_idx;
+		u8 rsv[3];
+	} __packed req = {
+		.ct_win = cpu_to_le32(ct_window),
+		.bss_idx = mvif->idx,
+	};
+
+	if (!mt7615_firmware_offload(dev))
+		return -ENOTSUPP;
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_P2P_OPPPS,
+				   &req, sizeof(req), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 0f12e6da89af..338fd077f575 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -507,6 +507,7 @@ enum {
 	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
 	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
 	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
+	MCU_CMD_SET_P2P_OPPPS = MCU_CE_PREFIX | 0x33,
 	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
 	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index dc60abb0a130..ebdfca64b079 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -530,6 +530,8 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy);
 void m7615_mcu_set_ps_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
+int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif);
 int mt7615_firmware_own(struct mt7615_dev *dev);
 int mt7615_driver_own(struct mt7615_dev *dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index b7a120b0856d..9a2c9afa2fb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -46,6 +46,8 @@ static const struct ieee80211_iface_limit mt76x02_if_limits[] = {
 #ifdef CONFIG_MAC80211_MESH
 			 BIT(NL80211_IFTYPE_MESH_POINT) |
 #endif
+			 BIT(NL80211_IFTYPE_P2P_CLIENT) |
+			 BIT(NL80211_IFTYPE_P2P_GO) |
 			 BIT(NL80211_IFTYPE_AP)
 	 },
 };
@@ -60,6 +62,8 @@ static const struct ieee80211_iface_limit mt76x02u_if_limits[] = {
 #ifdef CONFIG_MAC80211_MESH
 			 BIT(NL80211_IFTYPE_MESH_POINT) |
 #endif
+			 BIT(NL80211_IFTYPE_P2P_CLIENT) |
+			 BIT(NL80211_IFTYPE_P2P_GO) |
 			 BIT(NL80211_IFTYPE_AP)
 	},
 };
-- 
2.26.2

