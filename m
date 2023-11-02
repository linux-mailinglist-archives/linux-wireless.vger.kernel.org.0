Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D887DEF71
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 11:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346134AbjKBKD5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Nov 2023 06:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346069AbjKBKDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Nov 2023 06:03:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4D1181
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 03:03:44 -0700 (PDT)
X-UUID: 15fd0d78796711ee8051498923ad61e6-20231102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UNvh0VXbgAqVoyRMm94PG4IB+UUQaRSiIIfSgsWnx0A=;
        b=ZUbVAqiPZKnJKhDg/Z7MJBw2R8FIPEs+jlM9Heqj56X/XbCTYCz4dzm+DulsURvqNv25itqDF4wWeLhCgASW5HsRa438NDK/C/hiahb4gfI0oYxCzy2TFCszWIe87DTtXoobgRnWdweqXCa6TCD9qQYIjr48DfuRq4BKBOmptOY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:2d07c187-6934-4799-8b75-59baf71b7601,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:5657ef94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 15fd0d78796711ee8051498923ad61e6-20231102
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1950305325; Thu, 02 Nov 2023 18:03:35 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 Nov 2023 18:03:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 Nov 2023 18:03:33 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Allen Ye <allen.ye@mediatek.com>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: [PATCH 2/8] wifi: mt76: mt7996: add txpower setting support
Date:   Thu, 2 Nov 2023 18:02:56 +0800
Message-ID: <20231102100302.22160-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231102100302.22160-1-shayne.chen@mediatek.com>
References: <20231102100302.22160-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.972900-8.000000
X-TMASE-MatchedRID: tpf4JaSfocooMmKpHm2CtRn0UD4GU5IqrXeN27EOXQLfUZT83lbkEOOA
        Q6TuIiqMdg66vheo1qK9cOdjc/43leHxFb2pjr4bR/j040fRFpKxIYWToTws97lmMfLNiukavYJ
        m+b+NbBQ/R6pk1J76xCO6eMWU6NXnOVzKEd+ERcp1e7Xbb6Im2uU28KlVaRfjFLXUWU5hGiEqF7
        M65VRIS7kKMS2U/j0b1JjReh+rYBijbvGIi5SCUOE9BBUXDccUi+Y+Qw3Txz/xSV7YBeBhS3uer
        PMb7lIQLrbcyKMEIWNSm/bsjKT6beOwSINwNY6ongIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIXzYx
        eQR1DvsnqYbWRpemWfvFaj2DWl0XYjuBP5po/6v6jwR+aTFxF0VRK1CexylI
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.972900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8CC7C83060962BEC7206BF0736D81032746DBB79E7B96C2D88B45687FF608F762000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for setting txpower from upper layer and configuring per-rate
txpower limit table.

Co-developed-by: Allen Ye <allen.ye@mediatek.com>
Signed-off-by: Allen Ye <allen.ye@mediatek.com>
Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  8 +++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 58 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 16 +++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  3 +
 4 files changed, 85 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 9f12b47eb2bf..7336eaa7b9ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -396,6 +396,13 @@ static int mt7996_config(struct ieee80211_hw *hw, u32 changed)
 		ieee80211_wake_queues(hw);
 	}
 
+	if (changed & (IEEE80211_CONF_CHANGE_POWER |
+		       IEEE80211_CONF_CHANGE_CHANNEL)) {
+		ret = mt7996_mcu_set_txpower_sku(phy);
+		if (ret)
+			return ret;
+	}
+
 	mutex_lock(&dev->mt76.mutex);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
@@ -965,6 +972,7 @@ mt7996_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7996_set_stream_vht_txbf_caps(phy);
 	mt7996_set_stream_he_eht_caps(phy);
+	mt7996_mcu_set_txpower_sku(phy);
 
 	mutex_unlock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8097924d460b..8141c24ade50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4353,3 +4353,61 @@ int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id)
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(RRO), &req,
 				 sizeof(req), true);
 }
+
+int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
+{
+#define TX_POWER_LIMIT_TABLE_RATE	0
+	struct mt7996_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
+	struct ieee80211_hw *hw = mphy->hw;
+	struct tx_power_limit_table_ctrl {
+		u8 __rsv1[4];
+
+		__le16 tag;
+		__le16 len;
+		u8 power_ctrl_id;
+		u8 power_limit_type;
+		u8 band_idx;
+	} __packed req = {
+		.tag = cpu_to_le16(UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL),
+		.len = cpu_to_le16(sizeof(req) + MT7996_SKU_RATE_NUM - 4),
+		.power_ctrl_id = UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL,
+		.power_limit_type = TX_POWER_LIMIT_TABLE_RATE,
+		.band_idx = phy->mt76->band_idx,
+	};
+	struct mt76_power_limits la = {};
+	struct sk_buff *skb;
+	int i, tx_power;
+
+	tx_power = mt7996_get_power_bound(phy, hw->conf.power_level);
+	tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
+					      &la, tx_power);
+	mphy->txpower_cur = tx_power;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+				 sizeof(req) + MT7996_SKU_RATE_NUM);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &req, sizeof(req));
+	/* cck and ofdm */
+	skb_put_data(skb, &la.cck, sizeof(la.cck) + sizeof(la.ofdm));
+	/* ht20 */
+	skb_put_data(skb, &la.mcs[0], 8);
+	/* ht40 */
+	skb_put_data(skb, &la.mcs[1], 9);
+
+	/* vht */
+	for (i = 0; i < 4; i++) {
+		skb_put_data(skb, &la.mcs[i], sizeof(la.mcs[i]));
+		skb_put_zero(skb, 2);  /* padding */
+	}
+
+	/* he */
+	skb_put_data(skb, &la.ru[0], sizeof(la.ru));
+	/* eht */
+	skb_put_data(skb, &la.eht[0], sizeof(la.eht));
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WM_UNI_CMD(TXPOWER), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index a3eae32c8f10..1562c8a6a821 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -762,6 +762,18 @@ enum {
 #define MT7996_MAX_BSS_OFFLOAD_SIZE	(MT7996_MAX_BEACON_SIZE +		\
 					 MT7996_BEACON_UPDATE_SIZE)
 
+static inline s8
+mt7996_get_power_bound(struct mt7996_phy *phy, s8 txpower)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	int n_chains = hweight16(mphy->chainmask);
+
+	txpower = mt76_get_sar_power(mphy, mphy->chandef.chan, txpower * 2);
+	txpower -= mt76_tx_power_nss_delta(n_chains);
+
+	return txpower;
+}
+
 enum {
 	UNI_BAND_CONFIG_RADIO_ENABLE,
 	UNI_BAND_CONFIG_RTS_THRESHOLD = 0x08,
@@ -830,6 +842,10 @@ enum {
 	UNI_CMD_THERMAL_PROTECT_DUTY_CONFIG,
 };
 
+enum {
+	UNI_TXPOWER_POWER_LIMIT_TABLE_CTRL = 4,
+};
+
 enum {
 	UNI_CMD_ACCESS_REG_BASIC = 0x0,
 	UNI_CMD_ACCESS_RF_REG_BASIC,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index d3eb564623ae..c62a42512bd6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -42,6 +42,8 @@
 #define MT7996_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7996_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
 
+#define MT7996_SKU_RATE_NUM		417
+
 #define MT7996_MAX_TWT_AGRT		16
 #define MT7996_MAX_STA_TWT_AGRT		8
 #define MT7996_MAX_QUEUE		(__MT_RXQ_MAX +	__MT_MCUQ_MAX + 3)
@@ -471,6 +473,7 @@ int mt7996_mcu_get_chan_mib_info(struct mt7996_phy *phy, bool chan_switch);
 int mt7996_mcu_get_temperature(struct mt7996_phy *phy);
 int mt7996_mcu_set_thermal_throttling(struct mt7996_phy *phy, u8 state);
 int mt7996_mcu_set_thermal_protect(struct mt7996_phy *phy, bool enable);
+int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy);
 int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 index,
 		       u8 rx_sel, u8 val);
 int mt7996_mcu_rdd_background_enable(struct mt7996_phy *phy,
-- 
2.39.2

