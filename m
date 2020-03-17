Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84E188AC8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgCQQme (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgCQQme (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:42:34 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3150D2073E;
        Tue, 17 Mar 2020 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584463353;
        bh=E+FausOTa04jhInPcaWth1o5g+avAXa5NKjHpTPhpVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkSDtNo6jm9pMRXSDw2WJPNi0aP5nMEmiDtaU2RMO7uIaMgRivdJ4qSdLhFVWdocH
         7anOdCjBmLFj1qUrvDN1lQ+AU59mv7EjHiyxt6tfUT42EGuMWgsB+fp1aNYECvNd1d
         gKBsNGyA0eaTsF7sClsx8WoWVvdUyCbLJQec2sXE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 22/25] mt76: mt7615: add more uni mcu commands
Date:   Tue, 17 Mar 2020 17:41:29 +0100
Message-Id: <9c06586b7beeaa1436039f419f5a93bd5f9827d7.1584463004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584463004.git.lorenzo@kernel.org>
References: <cover.1584463004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce mt7615_mcu_uni_set_bss, mt7615_mcu_uni_set_dev and
mt7615_mcu_uni_set_beacon_offload uni mcu commands. This is a
preliminary patch to add mt7663e support

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 205 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   7 +
 2 files changed, 212 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index a72b65ebdffc..7dd5826be305 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1113,6 +1113,207 @@ static const struct mt7615_mcu_ops sta_update_ops = {
 	.sta_add = mt7615_mcu_add_sta,
 };
 
+static int
+mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
+		       struct ieee80211_vif *vif, bool enable)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct {
+		struct req_hdr {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 pad;
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} data = {
+		.hdr = {
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = enable,
+		},
+	};
+
+	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_DEV_INFO_UPDATE,
+				   &data, sizeof(data), true);
+}
+
+static int
+mt7615_mcu_uni_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
+{
+	return 0;
+}
+
+static int
+mt7615_mcu_uni_add_bss(struct mt7615_dev *dev,
+		       struct ieee80211_vif *vif, bool enable)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct {
+		struct req_hdr {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct basic_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 omac_idx;
+			u8 hw_bss_idx;
+			u8 band_idx;
+			__le32 conn_type;
+			u8 conn_state;
+			u8 wmm_idx;
+			u8 bssid[ETH_ALEN];
+			__le16 bmc_tx_wlan_idx;
+			__le16 bcn_interval;
+			u8 dtim_period;
+			u8 phymode;
+			__le16 sta_idx;
+			u8 nonht_basic_phy;
+			u8 pad[3];
+		} __packed basic;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct basic_tlv)),
+			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = vif->bss_conf.dtim_period,
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = enable,
+		},
+	};
+	u8 idx, tx_wlan_idx = 0;
+
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	req.basic.hw_bss_idx = idx;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		tx_wlan_idx = mvif->sta.wcid.idx;
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (enable) {
+			struct ieee80211_sta *sta;
+			struct mt7615_sta *msta;
+
+			rcu_read_lock();
+			sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
+			if (!sta) {
+				rcu_read_unlock();
+				return -EINVAL;
+			}
+
+			msta = (struct mt7615_sta *)sta->drv_priv;
+			tx_wlan_idx = msta->wcid.idx;
+			rcu_read_unlock();
+		}
+		req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	memcpy(req.basic.bssid, vif->bss_conf.bssid, ETH_ALEN);
+	req.basic.bmc_tx_wlan_idx = cpu_to_le16(tx_wlan_idx);
+	req.basic.sta_idx = cpu_to_le16(tx_wlan_idx);
+	req.basic.conn_state = !enable;
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				   &req, sizeof(req), true);
+}
+
+static int
+mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
+				  struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  bool enable)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	struct ieee80211_mutable_offsets offs;
+	struct {
+		struct req_hdr {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bcn_content_tlv {
+			__le16 tag;
+			__le16 len;
+			__le16 tim_ie_pos;
+			__le16 csa_ie_pos;
+			__le16 bcc_ie_pos;
+			/* 0: enable beacon offload
+			 * 1: disable beacon offload
+			 * 2: update probe respond offload
+			 */
+			u8 enable;
+			/* 0: legacy format (TXD + payload)
+			 * 1: only cap field IE
+			 */
+			u8 type;
+			__le16 pkt_len;
+			u8 pkt[512];
+		} __packed beacon_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.beacon_tlv = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BCN_CONTENT),
+			.len = cpu_to_le16(sizeof(struct bcn_content_tlv)),
+			.enable = enable,
+		},
+	};
+	struct sk_buff *skb;
+
+	skb = ieee80211_beacon_get_template(mt76_hw(dev), vif, &offs);
+	if (!skb)
+		return -EINVAL;
+
+	if (skb->len > 512 - MT_TXD_SIZE) {
+		dev_err(dev->mt76.dev, "beacon size limit exceed\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	mt7615_mac_write_txwi(dev, (__le32 *)(req.beacon_tlv.pkt), skb,
+			      wcid, NULL, 0, NULL, true);
+	memcpy(req.beacon_tlv.pkt + MT_TXD_SIZE, skb->data, skb->len);
+	req.beacon_tlv.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
+	req.beacon_tlv.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
+
+	if (offs.csa_counter_offs[0]) {
+		u16 csa_offs;
+
+		csa_offs = MT_TXD_SIZE + offs.csa_counter_offs[0] - 4;
+		req.beacon_tlv.csa_ie_pos = cpu_to_le16(csa_offs);
+	}
+	dev_kfree_skb(skb);
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				   &req, sizeof(req), true);
+}
+
 static int
 mt7615_mcu_uni_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta, bool enable)
@@ -1122,6 +1323,10 @@ mt7615_mcu_uni_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 }
 
 static const struct mt7615_mcu_ops uni_update_ops = {
+	.add_beacon_offload = mt7615_mcu_uni_add_beacon_offload,
+	.set_pm_state = mt7615_mcu_uni_ctrl_pm_state,
+	.add_dev_info = mt7615_mcu_uni_add_dev,
+	.add_bss_info = mt7615_mcu_uni_add_bss,
 	.sta_add = mt7615_mcu_uni_add_sta,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index bc87cf0419d8..62a7b86f2a3b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -270,6 +270,8 @@ enum {
 };
 
 enum {
+	MCU_UNI_CMD_DEV_INFO_UPDATE = MCU_UNI_PREFIX | 0x01,
+	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
 	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
 };
 
@@ -279,6 +281,11 @@ enum {
 
 #define MCU_CMD_UNI_EXT_ACK	(MCU_CMD_ACK | MCU_CMD_UNI | MCU_CMD_QUERY)
 
+enum {
+	UNI_BSS_INFO_BASIC = 0,
+	UNI_BSS_INFO_BCN_CONTENT = 7,
+};
+
 enum {
 	PATCH_SEM_RELEASE = 0x0,
 	PATCH_SEM_GET	  = 0x1
-- 
2.25.1

