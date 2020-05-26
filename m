Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60DAE19C1AF
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbgDBNHw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbgDBNHv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:07:51 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45ED12078C;
        Thu,  2 Apr 2020 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832870;
        bh=cnI3Kg/a0oHMxhqHmpBnTSiQLrhR+l7f5r1yCv1/7HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIgdbEU77MWcJ+3DM1STcUM+n0RFTOf/ksA1j8sZ9uORJ9Bib17ItrbIC/o+hXPZI
         OBLA07Vkf96VfzJn20igAY1WL9f+uMvoME89jQ2UF1CyAptpXUHK3zsX98BBKQK/iG
         W7HhmWGds6JTFnllT8w+tR2er4r+s8h9ItmU2BLI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 06/12] mt76: mt7615: introduce mt7615_mcu_set_channel_domain mcu command
Date:   Thu,  2 Apr 2020 15:06:36 +0200
Message-Id: <904338962304250b456ec9aa09a5e7197cd98344.1585832458.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585832458.git.lorenzo@kernel.org>
References: <cover.1585832458.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_mcu_set_channel_domain routines in order to instruct
the mcu about supported band/channels. This is a preliminary patch to
add hw scan support to mt7663e driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 72 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  9 ++-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 ++
 4 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 6586176c29af..20f6e31a017d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -50,6 +50,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 		mt7615_mac_enable_nf(dev, 1);
 	}
 
+	mt7615_mcu_set_channel_domain(phy);
 	mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 32e3e4219076..9ce08be2f7c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -135,14 +135,21 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	mcu_txd->pkt_type = MCU_PKT_ID;
 	mcu_txd->seq = seq;
 
-	if (cmd & MCU_FW_PREFIX) {
+	switch (cmd & ~MCU_CMD_MASK) {
+	case MCU_FW_PREFIX:
 		mcu_txd->set_query = MCU_Q_NA;
 		mcu_txd->cid = mcu_cmd;
-	} else {
+		break;
+	case MCU_CE_PREFIX:
+		mcu_txd->set_query = MCU_Q_SET;
+		mcu_txd->cid = mcu_cmd;
+		break;
+	default:
 		mcu_txd->cid = MCU_CMD_EXT_CID;
 		mcu_txd->set_query = MCU_Q_SET;
 		mcu_txd->ext_cid = cmd;
 		mcu_txd->ext_cid_ack = 1;
+		break;
 	}
 }
 
@@ -2421,3 +2428,64 @@ int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable)
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
 				   sizeof(req), true);
 }
+
+int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	struct mt7615_dev *dev = phy->dev;
+	struct mt7615_mcu_channel_domain {
+		__le32 country_code; /* regulatory_request.alpha2 */
+		u8 bw_2g; /* BW_20_40M		0
+			   * BW_20M		1
+			   * BW_20_40_80M	2
+			   * BW_20_40_80_160M	3
+			   * BW_20_40_80_8080M	4
+			   */
+		u8 bw_5g;
+		__le16 pad;
+		u8 n_2ch;
+		u8 n_5ch;
+		__le16 pad2;
+	} __packed hdr = {
+		.bw_2g = 0,
+		.bw_5g = 3,
+		.n_2ch = mphy->sband_2g.sband.n_channels,
+		.n_5ch = mphy->sband_5g.sband.n_channels,
+	};
+	struct mt7615_mcu_chan {
+		__le16 hw_value;
+		__le16 pad;
+		__le32 flags;
+	} __packed;
+	int i, n_channels = hdr.n_2ch + hdr.n_5ch;
+	int len = sizeof(hdr) + n_channels * sizeof(struct mt7615_mcu_chan);
+	struct sk_buff *skb;
+
+	if (!mt7615_firmware_offload(dev))
+		return 0;
+
+	skb = mt7615_mcu_msg_alloc(NULL, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	for (i = 0; i < n_channels; i++) {
+		struct ieee80211_channel *chan;
+		struct mt7615_mcu_chan channel;
+
+		if (i < hdr.n_2ch)
+			chan = &mphy->sband_2g.sband.channels[i];
+		else
+			chan = &mphy->sband_5g.sband.channels[i - hdr.n_2ch];
+
+		channel.hw_value = cpu_to_le16(chan->hw_value);
+		channel.flags = cpu_to_le32(chan->flags);
+		channel.pad = 0;
+
+		skb_put_data(skb, &channel, sizeof(channel));
+	}
+
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_CMD_SET_CHAN_DOMAIN, false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index d1f7391472fc..c03541328ad7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -232,7 +232,9 @@ enum {
 
 #define MCU_FW_PREFIX		BIT(31)
 #define MCU_UNI_PREFIX		BIT(30)
-#define MCU_CMD_MASK		~(MCU_FW_PREFIX | MCU_UNI_PREFIX)
+#define MCU_CE_PREFIX		BIT(29)
+#define MCU_CMD_MASK		~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
+				  MCU_CE_PREFIX)
 
 enum {
 	MCU_CMD_TARGET_ADDRESS_LEN_REQ = MCU_FW_PREFIX | 0x01,
@@ -275,6 +277,11 @@ enum {
 	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
 };
 
+/* offload mcu commands */
+enum {
+	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
+};
+
 #define MCU_CMD_ACK		BIT(0)
 #define MCU_CMD_UNI		BIT(1)
 #define MCU_CMD_QUERY		BIT(2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index dfc60d3ff836..c4aff5f4c89b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -364,6 +364,11 @@ static inline void mt7615_irq_disable(struct mt7615_dev *dev, u32 mask)
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+static inline bool mt7615_firmware_offload(struct mt7615_dev *dev)
+{
+	return dev->fw_ver > MT7615_FIRMWARE_V2;
+}
+
 void mt7615_update_channel(struct mt76_dev *mdev);
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask);
 void mt7615_mac_reset_counters(struct mt7615_dev *dev);
@@ -393,6 +398,7 @@ int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 			 int cmd, int *wait_seq);
+int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy);
 
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
-- 
2.25.1

