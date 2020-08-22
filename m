Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA624E953
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Aug 2020 21:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgHVTOM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Aug 2020 15:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgHVTOM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Aug 2020 15:14:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9923C061573
        for <linux-wireless@vger.kernel.org>; Sat, 22 Aug 2020 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oQ/PEBQzdnVmA1ixsHxGPRDAgE5VqAsVSwiOLgRHgyM=; b=I+rzxPt+y/5+TVkfup3jeiV2KO
        AkyXTHuiA4qIYcbuVctPGI1fsAgJhOGRkmwzfMJXVr8nJ1hrT2uymEBETavRCo1P27siDLBQeubbP
        Y1Emcam3kETk9UmPEqXsArva3FZbYVAh+cDS7qz1OwJTh8etBhdPcoEj47hZe1quKICY=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k9Yxr-0005AN-RM; Sat, 22 Aug 2020 21:14:07 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>
Subject: [PATCH v3] mt76: mt7915: add Tx A-MSDU offloading support
Date:   Sat, 22 Aug 2020 21:14:06 +0200
Message-Id: <20200822191406.46793-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813075511.5875-1-nbd@nbd.name>
References: <20200813075511.5875-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

This disables the software A-MSDU aggregation in mac80211 and enables hardware
offloading

Suggested-by: Yiwei Chung <yiwei.chung@mediatek.com>
Suggested-by: YF Luo <yf.luo@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v3: limit to AP and client mode
v2: fix maximum mpdu length MCU message field

 drivers/net/wireless/mediatek/mt76/mac80211.c | 11 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  2 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 55 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 21 +++++++
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  3 +-
 6 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3d4bf72700a5..8b41558c7855 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -304,11 +304,14 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
-	ieee80211_hw_set(hw, TX_AMSDU);
 
-	/* TODO: avoid linearization for SDIO */
-	if (!mt76_is_sdio(dev))
-		ieee80211_hw_set(hw, TX_FRAG_LIST);
+	if (!(dev->drv->drv_flags & MT_DRV_AMSDU_OFFLOAD)) {
+		ieee80211_hw_set(hw, TX_AMSDU);
+
+		/* TODO: avoid linearization for SDIO */
+		if (!mt76_is_sdio(dev))
+			ieee80211_hw_set(hw, TX_FRAG_LIST);
+	}
 
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, AP_LINK_PS);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f11978f2bd8f..3d5037afd5ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -216,6 +216,7 @@ struct mt76_wcid {
 
 	u8 sta:1;
 	u8 ext_phy:1;
+	u8 amsdu:1;
 
 	u8 rx_check_pn;
 	u8 rx_key_pn[IEEE80211_NUM_TIDS][6];
@@ -311,6 +312,7 @@ struct mt76_hw_cap {
 #define MT_DRV_SW_RX_AIRTIME		BIT(2)
 #define MT_DRV_RX_DMA_HDR		BIT(3)
 #define MT_DRV_HW_MGMT_TXQ		BIT(4)
+#define MT_DRV_AMSDU_OFFLOAD		BIT(5)
 
 struct mt76_driver_ops {
 	u32 drv_flags;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index df9131d7af3d..9e17be5005e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -680,6 +680,8 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 
 	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
 	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	if (wcid->amsdu)
+		val |= MT_TXD7_HW_AMSDU;
 	txwi[7] = cpu_to_le32(val);
 
 	val = FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 86eb24e90775..9fdfe51e2f79 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -949,6 +949,23 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
 }
 
+static void
+mt7915_mcu_bss_hw_amsdu_tlv(struct sk_buff *skb)
+{
+#define TXD_CMP_MAP1		GENMASK(15, 0)
+#define TXD_CMP_MAP2		(GENMASK(31, 0) & ~BIT(23))
+	struct bss_info_hw_amsdu *amsdu;
+	struct tlv *tlv;
+
+	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_HW_AMSDU, sizeof(*amsdu));
+
+	amsdu = (struct bss_info_hw_amsdu *)tlv;
+	amsdu->cmp_bitmap_0 = cpu_to_le32(TXD_CMP_MAP1);
+	amsdu->cmp_bitmap_1 = cpu_to_le32(TXD_CMP_MAP2);
+	amsdu->trig_thres = cpu_to_le16(2);
+	amsdu->enable = true;
+}
+
 static void
 mt7915_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt7915_vif *mvif)
 {
@@ -1023,6 +1040,7 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 		mt7915_mcu_bss_rfch_tlv(skb, vif, phy);
 		mt7915_mcu_bss_bmc_tlv(skb, phy);
 		mt7915_mcu_bss_ra_tlv(skb, vif, phy);
+		mt7915_mcu_bss_hw_amsdu_tlv(skb);
 
 		if (vif->bss_conf.he_support)
 			mt7915_mcu_bss_he_tlv(skb, vif, phy);
@@ -1181,6 +1199,9 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 	struct sk_buff *skb;
 	int ret;
 
+	if (enable && tx && !params->amsdu)
+		msta->wcid.amsdu = false;
+
 	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
 				       MT7915_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
@@ -1546,6 +1567,37 @@ mt7915_mcu_add_mu(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				       MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
+static void
+mt7915_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct sta_rec_amsdu *amsdu;
+	struct tlv *tlv;
+
+	if (!sta->max_amsdu_len)
+	    return;
+
+	tlv = mt7915_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
+	amsdu = (struct sta_rec_amsdu *)tlv;
+	amsdu->max_amsdu_num = 8;
+	amsdu->amsdu_en = true;
+	amsdu->max_mpdu_size = sta->max_amsdu_len >=
+			       IEEE80211_MAX_MPDU_LEN_VHT_7991;
+	msta->wcid.amsdu = true;
+}
+
+static bool
+mt7915_hw_amsdu_supported(struct ieee80211_vif *vif)
+{
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_STATION:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void
 mt7915_mcu_sta_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 		   struct ieee80211_sta *sta, struct ieee80211_vif *vif)
@@ -1559,6 +1611,9 @@ mt7915_mcu_sta_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 		tlv = mt7915_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
 		ht = (struct sta_rec_ht *)tlv;
 		ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
+
+		if (mt7915_hw_amsdu_supported(vif))
+			mt7915_mcu_sta_amsdu_tlv(skb, sta);
 	}
 
 	/* starec vht */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index a4600860fbf7..c656d66385c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -402,6 +402,16 @@ struct bss_info_ra {
 	__le32 fast_interval;
 } __packed;
 
+struct bss_info_hw_amsdu {
+	__le16 tag;
+	__le16 len;
+	__le32 cmp_bitmap_0;
+	__le32 cmp_bitmap_1;
+	__le16 trig_thres;
+	u8 enable;
+	u8 rsv;
+} __packed;
+
 struct bss_info_he {
 	__le16 tag;
 	__le16 len;
@@ -736,6 +746,15 @@ struct sta_rec_ba {
 	__le16 winsize;
 } __packed;
 
+struct sta_rec_amsdu {
+	__le16 tag;
+	__le16 len;
+	u8 max_amsdu_num;
+	u8 max_mpdu_size;
+	u8 amsdu_en;
+	u8 rsv;
+} __packed;
+
 struct sec_key {
 	u8 cipher_id;
 	u8 cipher_len;
@@ -963,6 +982,7 @@ enum {
 					 sizeof(struct sta_rec_ba) +	\
 					 sizeof(struct sta_rec_vht) +	\
 					 sizeof(struct sta_rec_uapsd) + \
+					 sizeof(struct sta_rec_amsdu) +	\
 					 sizeof(struct tlv) +		\
 					 MT7915_WTBL_UPDATE_MAX_SIZE)
 
@@ -974,6 +994,7 @@ enum {
 					 sizeof(struct bss_info_basic) +\
 					 sizeof(struct bss_info_rf_ch) +\
 					 sizeof(struct bss_info_ra) +	\
+					 sizeof(struct bss_info_hw_amsdu) +\
 					 sizeof(struct bss_info_he) +	\
 					 sizeof(struct bss_info_bmc_rate) +\
 					 sizeof(struct bss_info_ext_bss) +\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 520dea15c449..e0d853bca52a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -78,7 +78,8 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7915_txp),
-		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
+			     MT_DRV_AMSDU_OFFLOAD,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
-- 
2.28.0

