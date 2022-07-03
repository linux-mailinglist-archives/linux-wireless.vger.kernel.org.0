Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5303056491C
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jul 2022 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGCS3K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Jul 2022 14:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiGCS3J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Jul 2022 14:29:09 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF1525E2
        for <linux-wireless@vger.kernel.org>; Sun,  3 Jul 2022 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2NgamkaXPoCKyJqksV/1omr3e3MoMPrsRdhI6BAQe3o=; b=PLMeF7FOLF7haGE+zdZ3LXnXY0
        Lq3pWKAoc6Znv7RidF214fNzO56r5j7s4sHsu5jaHGWE8nPiaThQYcJvXOBBwqSNunDbB3J1ayOqf
        54wvUBTOQ5XoIFjb+8HpJaoMXYwU2XRLb9bk/KHaubzRCwxwzzxlpMnKxOJCIWRjYE1k=;
Received: from p200300daa726cc00a936c3912bbcbc03.dip0.t-ipconnect.de ([2003:da:a726:cc00:a936:c391:2bbc:bc03] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o84LC-0000v9-83
        for linux-wireless@vger.kernel.org; Sun, 03 Jul 2022 20:29:06 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: do not use skb_set_queue_mapping for internal purposes
Date:   Sun,  3 Jul 2022 20:29:05 +0200
Message-Id: <20220703182905.51694-2-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220703182905.51694-1-nbd@nbd.name>
References: <20220703182905.51694-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Previously the code used skb_set_queue_mapping for management or non-bufferable
powersave frames that need to be sent to a different hardware queue.
This can confuse AQL, which expects the value to remain the same until the tx
status report.
The only place that currently uses the altered skb queue mapping is the txwi
write function. Change the code to pass the hardware queue id as a function
parameter instead.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c      | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h   | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/tx.c              | 1 -
 14 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 038774b3ced0..372862768bb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -717,7 +717,8 @@ mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta, int pid,
-			  struct ieee80211_key_conf *key, bool beacon)
+			  struct ieee80211_key_conf *key,
+			  enum mt76_txq_id qid, bool beacon)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
@@ -755,7 +756,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	if (beacon) {
 		p_fmt = MT_TX_TYPE_FW;
 		q_idx = ext_phy ? MT_LMAC_BCN1 : MT_LMAC_BCN0;
-	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
+	} else if (qid >= MT_TXQ_PSD) {
 		p_fmt = is_mmio ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
 		q_idx = ext_phy ? MT_LMAC_ALTX1 : MT_LMAC_ALTX0;
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 3d35381013f1..e8b1be818c30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -714,7 +714,7 @@ mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
 	}
 
 	mt7615_mac_write_txwi(dev, (__le32 *)(req.pkt), skb, wcid, NULL,
-			      0, NULL, true);
+			      0, NULL, 0, true);
 	memcpy(req.pkt + MT_TXD_SIZE, skb->data, skb->len);
 	req.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	req.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
@@ -1086,7 +1086,7 @@ mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 	}
 
 	mt7615_mac_write_txwi(dev, (__le32 *)(req.beacon_tlv.pkt), skb,
-			      wcid, NULL, 0, NULL, true);
+			      wcid, NULL, 0, NULL, 0, true);
 	memcpy(req.beacon_tlv.pkt + MT_TXD_SIZE, skb->data, skb->len);
 	req.beacon_tlv.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	req.beacon_tlv.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 93a9e8f46193..25880d1a50da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -477,7 +477,8 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta, int pid,
-			  struct ieee80211_key_conf *key, bool beacon);
+			  struct ieee80211_key_conf *key,
+			  enum mt76_txq_id qid, bool beacon);
 void mt7615_mac_set_timing(struct mt7615_phy *phy);
 int __mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 			      struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 05b6669466ba..26211c63dac4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -96,7 +96,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 	mt7615_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, sta,
-			      pid, key, false);
+			      pid, key, qid, false);
 
 	txp = txwi + MT_TXD_SIZE;
 	memset(txp, 0, sizeof(struct mt76_connac_txp_common));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 5a6d7829c6e0..0052d103e276 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -49,7 +49,7 @@ mt7663_usb_sdio_write_txwi(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 	__le32 *txwi = (__le32 *)(skb->data - MT_USB_TXD_SIZE);
 
 	memset(txwi, 0, MT_USB_TXD_SIZE);
-	mt7615_mac_write_txwi(dev, txwi, skb, wcid, sta, pid, key, false);
+	mt7615_mac_write_txwi(dev, txwi, skb, wcid, sta, pid, key, qid, false);
 	skb_push(skb, MT_USB_TXD_SIZE);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 1d32d55ba587..9070162c6869 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -339,7 +339,7 @@ void mt76_connac_pm_dequeue_skbs(struct mt76_phy *phy,
 void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				 struct sk_buff *skb, struct mt76_wcid *wcid,
 				 struct ieee80211_key_conf *key, int pid,
-				 u32 changed);
+				 enum mt76_txq_id qid, u32 changed);
 bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 				  int pid, __le32 *txs_data,
 				  struct mt76_sta_stats *stats);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index af2b33d738ca..3ab0dcde7351 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -436,7 +436,7 @@ mt76_connac2_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
 void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				 struct sk_buff *skb, struct mt76_wcid *wcid,
 				 struct ieee80211_key_conf *key, int pid,
-				 u32 changed)
+				 enum mt76_txq_id qid, u32 changed)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
@@ -467,7 +467,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	} else if (beacon) {
 		p_fmt = MT_TX_TYPE_FW;
 		q_idx = MT_LMAC_BCN0;
-	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
+	} else if (qid >= MT_TXQ_PSD) {
 		p_fmt = mt76_is_mmio(dev) ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
 		q_idx = MT_LMAC_ALTX0;
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f696c20dc6e3..757b4e1c3164 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -662,7 +662,8 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 
 void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
-			   struct ieee80211_key_conf *key, u32 changed)
+			   struct ieee80211_key_conf *key,
+			   enum mt76_txq_id qid, u32 changed)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct mt76_phy *mphy = &dev->phy;
@@ -670,7 +671,7 @@ void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && dev->phy2)
 		mphy = dev->phy2;
 
-	mt76_connac2_mac_write_txwi(dev, txwi, skb, wcid, key, pid, changed);
+	mt76_connac2_mac_write_txwi(dev, txwi, skb, wcid, key, pid, qid, changed);
 
 	if (mt76_testmode_enabled(mphy))
 		mt7915_mac_write_txwi_tm(mphy->priv, txwi, skb);
@@ -717,7 +718,8 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
-	mt7915_mac_write_txwi(mdev, txwi_ptr, tx_info->skb, wcid, pid, key, 0);
+	mt7915_mac_write_txwi(mdev, txwi_ptr, tx_info->skb, wcid, pid, key,
+			      qid, 0);
 
 	txp = (struct mt76_connac_fw_txp *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 18fb205e26fb..4a841bcead0e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1812,7 +1812,7 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	buf = (u8 *)tlv + sizeof(*cont);
 	mt7915_mac_write_txwi(&dev->mt76, (__le32 *)buf, skb, wcid, 0, NULL,
-			      BSS_CHANGED_BEACON);
+			      0, BSS_CHANGED_BEACON);
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
 
@@ -1957,7 +1957,7 @@ mt7915_mcu_beacon_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vi
 	buf = (u8 *)tlv + sizeof(*discov);
 
 	mt7915_mac_write_txwi(&dev->mt76, (__le32 *)buf, skb, wcid, 0, NULL,
-			      changed);
+			      0, changed);
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 
 	dev_kfree_skb(skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b6a6aa7fcf43..db63012e8aa9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -551,7 +551,8 @@ void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy);
 void mt7915_mac_enable_nf(struct mt7915_dev *dev, bool ext_phy);
 void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
-			   struct ieee80211_key_conf *key, u32 changed);
+			   struct ieee80211_key_conf *key,
+			   enum mt76_txq_id qid, u32 changed);
 void mt7915_mac_set_timing(struct mt7915_phy *phy);
 int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index eb1bfb682e02..49b7f0debc78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -999,7 +999,7 @@ mt7921_usb_sdio_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
 	__le32 *txwi = (__le32 *)(skb->data - MT_SDIO_TXD_SIZE);
 
 	memset(txwi, 0, MT_SDIO_TXD_SIZE);
-	mt76_connac2_mac_write_txwi(&dev->mt76, txwi, skb, wcid, key, pid, 0);
+	mt76_connac2_mac_write_txwi(&dev->mt76, txwi, skb, wcid, key, pid, qid, 0);
 	skb_push(skb, MT_SDIO_TXD_SIZE);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 1b62135bdc8f..c232319d2071 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -919,7 +919,7 @@ mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
 	}
 
 	mt76_connac2_mac_write_txwi(&dev->mt76, (__le32 *)(req.beacon_tlv.pkt),
-				    skb, wcid, NULL, 0, BSS_CHANGED_BEACON);
+				    skb, wcid, NULL, 0, 0, BSS_CHANGED_BEACON);
 	memcpy(req.beacon_tlv.pkt + MT_TXD_SIZE, skb->data, skb->len);
 	req.beacon_tlv.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	req.beacon_tlv.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index f6c605a59b81..e1800674089a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -42,7 +42,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 	mt76_connac2_mac_write_txwi(mdev, txwi_ptr, tx_info->skb, wcid, key,
-				    pid, 0);
+				    pid, qid, 0);
 
 	txp = (struct mt76_connac_hw_txp *)(txwi + MT_TXD_SIZE);
 	memset(txp, 0, sizeof(struct mt76_connac_hw_txp));
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index e1d5996c4675..13c5e78dd39d 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -327,7 +327,6 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	    !ieee80211_is_data(hdr->frame_control) &&
 	    !ieee80211_is_bufferable_mmpdu(hdr->frame_control)) {
 		qid = MT_TXQ_PSD;
-		skb_set_queue_mapping(skb, qid);
 	}
 
 	if (wcid && !(wcid->tx_info & MT_WCID_TX_INFO_SET))
-- 
2.36.1

