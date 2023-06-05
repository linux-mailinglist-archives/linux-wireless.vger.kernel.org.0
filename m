Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA0722AE6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjFEPWa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjFEPWO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 11:22:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7011A
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 08:22:01 -0700 (PDT)
X-UUID: b257cfec03b411eeb20a276fd37b9834-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=htiNUyN73toaDqRZQJwOlsGxEqfRsc+nZ6iDrsW0iKI=;
        b=gM/J44+rk46HT85bLJlAU9D8UbE/1Aauv5zogPYz/BbcBoy3YwO1OKMgobUvJyIM9jD8INYCUw0ZenIwtLWD1zJTzYJ7cajb92rHTeiipchUijivXXiY/ckWKsdK4vfPUKWDHiHoTdw9pHYUQqS0qK1h67r9BqrkPCt23jD7VB4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:a375e960-1f2c-4221-9d86-6e7ff8616788,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.25,REQID:a375e960-1f2c-4221-9d86-6e7ff8616788,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:d5b0ae3,CLOUDID:cd21166e-2f20-4998-991c-3b78627e4938,B
        ulkID:230605232153EABK8CV5,BulkQuantity:0,Recheck:0,SF:28|17|19|48|29,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b257cfec03b411eeb20a276fd37b9834-20230605
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1972126626; Mon, 05 Jun 2023 23:21:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 23:21:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 23:21:50 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v3 06/10] wifi: mt76: connac: add support to set ifs time by mcu command
Date:   Mon, 5 Jun 2023 23:21:37 +0800
Message-ID: <20230605152141.17434-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230605152141.17434-1-shayne.chen@mediatek.com>
References: <20230605152141.17434-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

There's a race between driver and fw on some tx/rx control registers
when setting ifs, which will cause accidental hw queue pause problems.
Avoid this by setting ifs time with bss_info mcu command.

Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
v2:
  - merge two commits
    - wifi: mt76: connac: add a new bss_info tag for setting ifs time
    - wifi: mt76: mt7996: set ifs time by mcu command
  - change bool a_band to use is_2ghz
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 27 +----------
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 46 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 17 +++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  3 +-
 6 files changed, 70 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4a21c237ea6e..3790d68525e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1288,6 +1288,7 @@ enum {
 	UNI_BSS_INFO_UAPSD = 19,
 	UNI_BSS_INFO_PS = 21,
 	UNI_BSS_INFO_BCNFT = 22,
+	UNI_BSS_INFO_IFS_TIME = 23,
 	UNI_BSS_INFO_OFFLOAD = 25,
 	UNI_BSS_INFO_MLD = 26,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 130eb7b4fd91..78d9127e63ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1604,20 +1604,19 @@ void mt7996_mac_reset_counters(struct mt7996_phy *phy)
 	mt7996_mcu_get_chan_mib_info(phy, true);
 }
 
-void mt7996_mac_set_timing(struct mt7996_phy *phy)
+void mt7996_mac_set_coverage_class(struct mt7996_phy *phy)
 {
 	s16 coverage_class = phy->coverage_class;
 	struct mt7996_dev *dev = phy->dev;
 	struct mt7996_phy *phy2 = mt7996_phy2(dev);
 	struct mt7996_phy *phy3 = mt7996_phy3(dev);
-	u32 val, reg_offset;
+	u32 reg_offset;
 	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
 		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
 	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
 		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
 	u8 band_idx = phy->mt76->band_idx;
 	int offset;
-	bool a_band = !(phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ);
 
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
@@ -1630,34 +1629,12 @@ void mt7996_mac_set_timing(struct mt7996_phy *phy)
 		coverage_class = max_t(s16, coverage_class,
 				       phy3->coverage_class);
 
-	mt76_set(dev, MT_ARB_SCR(band_idx),
-		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
-	udelay(1);
-
 	offset = 3 * coverage_class;
 	reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
 		     FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
 
 	mt76_wr(dev, MT_TMAC_CDTR(band_idx), cck + reg_offset);
 	mt76_wr(dev, MT_TMAC_ODTR(band_idx), ofdm + reg_offset);
-	mt76_wr(dev, MT_TMAC_ICR0(band_idx),
-		FIELD_PREP(MT_IFS_EIFS_OFDM, a_band ? 84 : 78) |
-		FIELD_PREP(MT_IFS_RIFS, 2) |
-		FIELD_PREP(MT_IFS_SIFS, 10) |
-		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
-
-	if (!a_band)
-		mt76_wr(dev, MT_TMAC_ICR1(band_idx),
-			FIELD_PREP(MT_IFS_EIFS_CCK, 314));
-
-	if (phy->slottime < 20 || a_band)
-		val = MT7996_CFEND_RATE_DEFAULT;
-	else
-		val = MT7996_CFEND_RATE_11B;
-
-	mt76_rmw_field(dev, MT_RATE_HRCR0(band_idx), MT_RATE_HRCR0_CFEND_RATE, val);
-	mt76_clear(dev, MT_ARB_SCR(band_idx),
-		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
 }
 
 void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 8a1edc5c1288..6001b534b657 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -287,7 +287,6 @@ int mt7996_set_channel(struct mt7996_phy *phy)
 	if (ret)
 		goto out;
 
-	mt7996_mac_set_timing(phy);
 	ret = mt7996_dfs_init_radar_detector(phy);
 	mt7996_mac_cca_stats_reset(phy);
 
@@ -565,7 +564,7 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 
 		if (slottime != phy->slottime) {
 			phy->slottime = slottime;
-			mt7996_mac_set_timing(phy);
+			mt7996_mcu_set_timing(phy, vif);
 		}
 	}
 
@@ -905,7 +904,7 @@ mt7996_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 
 	mutex_lock(&dev->mt76.mutex);
 	phy->coverage_class = max_t(s16, coverage_class, 0);
-	mt7996_mac_set_timing(phy);
+	mt7996_mac_set_coverage_class(phy);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 6706d38cf4cf..0ede9769a8e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -701,6 +701,34 @@ mt7996_mcu_muar_config(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 				 sizeof(req), true);
 }
 
+static void
+mt7996_mcu_bss_ifs_timing_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_phy *phy = mvif->phy;
+	struct bss_ifs_time_tlv *ifs_time;
+	struct tlv *tlv;
+	bool is_2ghz = phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_IFS_TIME, sizeof(*ifs_time));
+
+	ifs_time = (struct bss_ifs_time_tlv *)tlv;
+	ifs_time->slot_valid = true;
+	ifs_time->sifs_valid = true;
+	ifs_time->rifs_valid = true;
+	ifs_time->eifs_valid = true;
+
+	ifs_time->slot_time = cpu_to_le16(phy->slottime);
+	ifs_time->sifs_time = cpu_to_le16(10);
+	ifs_time->rifs_time = cpu_to_le16(2);
+	ifs_time->eifs_time = cpu_to_le16(is_2ghz ? 78 : 84);
+
+	if (is_2ghz) {
+		ifs_time->eifs_cck_valid = true;
+		ifs_time->eifs_cck_time = cpu_to_le16(314);
+	}
+}
+
 static int
 mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 			 struct ieee80211_vif *vif,
@@ -826,6 +854,7 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
 		mt7996_mcu_bss_bmc_tlv(skb, vif, phy);
 		mt7996_mcu_bss_ra_tlv(skb, vif, phy);
 		mt7996_mcu_bss_txcmd_tlv(skb, true);
+		mt7996_mcu_bss_ifs_timing_tlv(skb, vif);
 
 		if (vif->bss_conf.he_support)
 			mt7996_mcu_bss_he_tlv(skb, vif, phy);
@@ -838,6 +867,23 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
 				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
+int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = phy->dev;
+	struct sk_buff *skb;
+
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+					 MT7996_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7996_mcu_bss_ifs_timing_tlv(skb, vif);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
 static int
 mt7996_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 		  struct ieee80211_ampdu_params *params,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index d7075a4d0667..078f82858621 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -317,6 +317,22 @@ struct bss_sec_tlv {
 	u8 __rsv2[1];
 } __packed;
 
+struct bss_ifs_time_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 slot_valid;
+	u8 sifs_valid;
+	u8 rifs_valid;
+	u8 eifs_valid;
+	__le16 slot_time;
+	__le16 sifs_time;
+	__le16 rifs_time;
+	__le16 eifs_time;
+	u8 eifs_cck_valid;
+	u8 rsv;
+	__le16 eifs_cck_time;
+} __packed;
+
 struct bss_power_save {
 	__le16 tag;
 	__le16 len;
@@ -552,6 +568,7 @@ enum {
 					 sizeof(struct bss_txcmd_tlv) +		\
 					 sizeof(struct bss_power_save) +	\
 					 sizeof(struct bss_sec_tlv) +		\
+					 sizeof(struct bss_ifs_time_tlv) +	\
 					 sizeof(struct bss_mld_tlv))
 
 #define MT7996_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +		\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 7dfdc7384056..42892f06faa7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -463,6 +463,7 @@ int mt7996_mcu_set_radar_th(struct mt7996_dev *dev, int index,
 			    const struct mt7996_dfs_pattern *pattern);
 int mt7996_mcu_set_radio_en(struct mt7996_phy *phy, bool enable);
 int mt7996_mcu_set_rts_thresh(struct mt7996_phy *phy, u32 val);
+int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif);
 int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch);
 int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 index,
 		       u8 rx_sel, u8 val);
@@ -526,7 +527,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, int pid,
 			   enum mt76_txq_id qid, u32 changed);
-void mt7996_mac_set_timing(struct mt7996_phy *phy);
+void mt7996_mac_set_coverage_class(struct mt7996_phy *phy);
 int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-- 
2.39.2

