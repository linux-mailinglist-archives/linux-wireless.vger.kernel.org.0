Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7871CFEDC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgELUDI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 16:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731048AbgELUDH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 16:03:07 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB5F20731;
        Tue, 12 May 2020 20:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589313786;
        bh=Fz7WTW9zSmBWQvn6SKCgJqKAnF3fPQ9gZ+wJurCnphQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFfQ5iCyu7AsHb/CR3QZGcJh+JPmPZYyFWUJ4ZiTrlkOvoZTMLf5yfliOUTYAXx6f
         dtEHZVpgy1ZLDEhbjwdu168je1f7T3wcCH5GjLaWU782m6t5TpYXumwkR7LpaUPp/n
         p/7vAmrmiGJrrbHfgmBqCh2ZUtizh6Y0sA6UtODw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 4/4] mt76: mt7615: configure bss info adding the interface
Date:   Tue, 12 May 2020 22:02:50 +0200
Message-Id: <dba96d7584bc78bb436b2f9d7f81c7d3c44e0f46.1589313659.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589313659.git.lorenzo@kernel.org>
References: <cover.1589313659.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce essential bss information for multiple vifs hw_scan in
mt7615_mcu_uni_add_dev adding the interface

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 97 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 26 +++++
 3 files changed, 89 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index e87a5843c718..2e9e9d3519d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -156,10 +156,6 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	else
 		mvif->wmm_idx = mvif->idx % MT7615_MAX_WMM_SETS;
 
-	ret = mt7615_mcu_add_dev_info(dev, vif, true);
-	if (ret)
-		goto out;
-
 	dev->vif_mask |= BIT(mvif->idx);
 	dev->omac_mask |= BIT(mvif->omac_idx);
 	phy->omac_mask |= BIT(mvif->omac_idx);
@@ -182,6 +178,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 		mt76_txq_init(&dev->mt76, vif->txq);
 	}
 
+	ret = mt7615_mcu_add_dev_info(dev, vif, true);
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 92ea9dc3c1c6..b944f372738a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1294,7 +1294,7 @@ mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct {
-		struct req_hdr {
+		struct {
 			u8 omac_idx;
 			u8 band_idx;
 			__le16 pad;
@@ -1306,7 +1306,7 @@ mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
 			u8 pad;
 			u8 omac_addr[ETH_ALEN];
 		} __packed tlv;
-	} data = {
+	} dev_req = {
 		.hdr = {
 			.omac_idx = mvif->omac_idx,
 			.band_idx = mvif->band_idx,
@@ -1317,11 +1317,65 @@ mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
 			.active = enable,
 		},
 	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt7615_bss_basic_tlv basic;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt7615_bss_basic_tlv)),
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = enable,
+			.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx),
+			.sta_idx = cpu_to_le16(mvif->sta.wcid.idx),
+			.conn_state = 1,
+		},
+	};
+	int err, idx, cmd, len;
+	void *data;
 
-	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		break;
+	case NL80211_IFTYPE_STATION:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_DEV_INFO_UPDATE,
-				   &data, sizeof(data), true);
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	basic_req.basic.hw_bss_idx = idx;
+
+	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+
+	cmd = enable ? MCU_UNI_CMD_DEV_INFO_UPDATE : MCU_UNI_CMD_BSS_INFO_UPDATE;
+	data = enable ? (void *)&dev_req : (void *)&basic_req;
+	len = enable ? sizeof(dev_req) : sizeof(basic_req);
+
+	err = __mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
+	if (err < 0)
+		return err;
+
+	cmd = enable ? MCU_UNI_CMD_BSS_INFO_UPDATE : MCU_UNI_CMD_DEV_INFO_UPDATE;
+	data = enable ? (void *)&basic_req : (void *)&dev_req;
+	len = enable ? sizeof(basic_req) : sizeof(dev_req);
+
+	return __mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
 }
 
 static int
@@ -1343,44 +1397,20 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			u8 bss_idx;
 			u8 pad[3];
 		} __packed hdr;
-		struct basic_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 active;
-			u8 omac_idx;
-			u8 hw_bss_idx;
-			u8 band_idx;
-			__le32 conn_type;
-			u8 conn_state;
-			u8 wmm_idx;
-			u8 bssid[ETH_ALEN];
-			__le16 bmc_tx_wlan_idx;
-			__le16 bcn_interval;
-			u8 dtim_period;
-			u8 phymode; /* bit(0): A
-				     * bit(1): B
-				     * bit(2): G
-				     * bit(3): GN
-				     * bit(4): AN
-				     * bit(5): AC
-				     */
-			__le16 sta_idx;
-			u8 nonht_basic_phy;
-			u8 pad[3];
-		} __packed basic;
+		struct mt7615_bss_basic_tlv basic;
 	} basic_req = {
 		.hdr = {
 			.bss_idx = mvif->idx,
 		},
 		.basic = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
-			.len = cpu_to_le16(sizeof(struct basic_tlv)),
+			.len = cpu_to_le16(sizeof(struct mt7615_bss_basic_tlv)),
 			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
 			.dtim_period = vif->bss_conf.dtim_period,
 			.omac_idx = mvif->omac_idx,
 			.band_idx = mvif->band_idx,
 			.wmm_idx = mvif->wmm_idx,
-			.active = enable,
+			.active = true, /* keep bss deactivated */
 			.phymode = 0x38,
 		},
 	};
@@ -1458,9 +1488,6 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (err < 0)
 		return err;
 
-	if (!mt7615_firmware_offload(dev))
-		return 0;
-
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_40:
 		rlm_req.rlm.bw = CMD_CBW_40MHZ;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 338fd077f575..348521b0d44c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -425,6 +425,32 @@ struct mt7615_mcu_bss_event {
 	u8 pad;
 } __packed;
 
+struct mt7615_bss_basic_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 active;
+	u8 omac_idx;
+	u8 hw_bss_idx;
+	u8 band_idx;
+	__le32 conn_type;
+	u8 conn_state;
+	u8 wmm_idx;
+	u8 bssid[ETH_ALEN];
+	__le16 bmc_tx_wlan_idx;
+	__le16 bcn_interval;
+	u8 dtim_period;
+	u8 phymode; /* bit(0): A
+		     * bit(1): B
+		     * bit(2): G
+		     * bit(3): GN
+		     * bit(4): AN
+		     * bit(5): AC
+		     */
+	__le16 sta_idx;
+	u8 nonht_basic_phy;
+	u8 pad[3];
+} __packed;
+
 struct mt7615_wow_ctrl_tlv {
 	__le16 tag;
 	__le16 len;
-- 
2.26.2

