Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6CD19C8A3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbgDBSTM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 14:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbgDBSTL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 14:19:11 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22DDB208E0;
        Thu,  2 Apr 2020 18:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585851550;
        bh=osmzgVsQSgR0jbuauVXYK/TtEecEsw1L4Mactgae3oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYnzcElsK6MPGO2jbspveXIBmgLyAktVpXO45i4Q07aBeK390Sgr4n3zC81BAW1By
         KxcatvvjLi9uLrFyTVxvEEd557d3uCnu0mFOgjR2/gUP/DBHMj+6c1JnpSNa9Mr0b1
         R5LwPD2TbaiGiQl2NEtHm5wJuZmTxLu+zHBhDslw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/9] mt76: add headroom and tailroom to mt76_mcu_ops data structure
Date:   Thu,  2 Apr 2020 20:18:48 +0200
Message-Id: <a67af2692bf6a56120339fb5881de6429c647a44.1585851049.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585851049.git.lorenzo@kernel.org>
References: <cover.1585851049.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce headroom and tailroom to mt76_mcu_ops data structure in order
to unify the routine used for mcu message allocation. This is a
preliminary patch to add mt7663u support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mcu.c      |  9 +--
 drivers/net/wireless/mediatek/mt76/mt76.h     |  7 ++-
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7603/mcu.h   |  7 ---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 63 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  7 ---
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mcu.h  |  6 --
 .../wireless/mediatek/mt76/mt76x02_usb_mcu.c  |  4 +-
 9 files changed, 51 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 4048f446e3ee..ade61a5334c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -6,10 +6,11 @@
 #include "mt76.h"
 
 struct sk_buff *
-mt76_mcu_msg_alloc(const void *data, int head_len,
-		   int data_len, int tail_len)
+mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
+		   int data_len)
 {
-	int length = head_len + data_len + tail_len;
+	const struct mt76_mcu_ops *ops = dev->mcu_ops;
+	int length = ops->headroom + data_len + ops->tailroom;
 	struct sk_buff *skb;
 
 	skb = alloc_skb(length, GFP_KERNEL);
@@ -17,7 +18,7 @@ mt76_mcu_msg_alloc(const void *data, int head_len,
 		return NULL;
 
 	memset(skb->head, 0, length);
-	skb_reserve(skb, head_len);
+	skb_reserve(skb, ops->headroom);
 
 	if (data && data_len)
 		skb_put_data(skb, data, data_len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ca7475a95356..e31d98a4f88f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -137,6 +137,9 @@ struct mt76_sw_queue {
 };
 
 struct mt76_mcu_ops {
+	u32 headroom;
+	u32 tailroom;
+
 	int (*mcu_send_msg)(struct mt76_dev *dev, int cmd, const void *data,
 			    int len, bool wait_resp);
 	int (*mcu_skb_send_msg)(struct mt76_dev *dev, struct sk_buff *skb,
@@ -914,8 +917,8 @@ int mt76u_resume_rx(struct mt76_dev *dev);
 void mt76u_queues_deinit(struct mt76_dev *dev);
 
 struct sk_buff *
-mt76_mcu_msg_alloc(const void *data, int head_len,
-		   int data_len, int tail_len);
+mt76_mcu_msg_alloc(struct mt76_dev *dev, const void *data,
+		   int data_len);
 void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb);
 struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 				      unsigned long expires);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 77985d81c447..a47a3a644ecc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -62,7 +62,7 @@ mt7603_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	struct sk_buff *skb;
 	int ret, seq;
 
-	skb = mt7603_mcu_msg_alloc(data, len);
+	skb = mt76_mcu_msg_alloc(mdev, data, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -265,6 +265,7 @@ static int mt7603_load_firmware(struct mt7603_dev *dev)
 int mt7603_mcu_init(struct mt7603_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7603_mcu_ops = {
+		.headroom = sizeof(struct mt7603_mcu_txd),
 		.mcu_send_msg = mt7603_mcu_msg_send,
 		.mcu_restart = mt7603_mcu_restart,
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.h
index 1bba369d5c8a..30df8a3fd11a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.h
@@ -100,11 +100,4 @@ enum {
 	MCU_EXT_EVENT_BCN_UPDATE = 0x31,
 };
 
-static inline struct sk_buff *
-mt7603_mcu_msg_alloc(const void *data, int len)
-{
-	return mt76_mcu_msg_alloc(data, sizeof(struct mt7603_mcu_txd),
-				  len, 0);
-}
-
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 9bb65de0cc64..12759158e69a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -244,7 +244,7 @@ mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 {
 	struct sk_buff *skb;
 
-	skb = mt7615_mcu_msg_alloc(data, len);
+	skb = mt76_mcu_msg_alloc(mdev, data, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -552,7 +552,8 @@ mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
 }
 
 static struct sk_buff *
-mt7615_mcu_alloc_sta_req(struct mt7615_vif *mvif, struct mt7615_sta *msta)
+mt7615_mcu_alloc_sta_req(struct mt7615_dev *dev, struct mt7615_vif *mvif,
+			 struct mt7615_sta *msta)
 {
 	struct sta_req_hdr hdr = {
 		.bss_idx = mvif->idx,
@@ -562,7 +563,7 @@ mt7615_mcu_alloc_sta_req(struct mt7615_vif *mvif, struct mt7615_sta *msta)
 	};
 	struct sk_buff *skb;
 
-	skb = mt7615_mcu_msg_alloc(NULL, MT7615_STA_UPDATE_MAX_SIZE);
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, MT7615_STA_UPDATE_MAX_SIZE);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
@@ -572,8 +573,8 @@ mt7615_mcu_alloc_sta_req(struct mt7615_vif *mvif, struct mt7615_sta *msta)
 }
 
 static struct wtbl_req_hdr *
-mt7615_mcu_alloc_wtbl_req(struct mt7615_sta *msta, int cmd,
-			  void *sta_wtbl, struct sk_buff **skb)
+mt7615_mcu_alloc_wtbl_req(struct mt7615_dev *dev, struct mt7615_sta *msta,
+			  int cmd, void *sta_wtbl, struct sk_buff **skb)
 {
 	struct tlv *sta_hdr = sta_wtbl;
 	struct wtbl_req_hdr hdr = {
@@ -583,7 +584,8 @@ mt7615_mcu_alloc_wtbl_req(struct mt7615_sta *msta, int cmd,
 	struct sk_buff *nskb = *skb;
 
 	if (!nskb) {
-		nskb = mt7615_mcu_msg_alloc(NULL, MT7615_WTBL_UPDATE_BA_SIZE);
+		nskb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+					  MT7615_WTBL_UPDATE_BA_SIZE);
 		if (!nskb)
 			return ERR_PTR(-ENOMEM);
 
@@ -974,7 +976,7 @@ mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	struct mt7615_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
-	skb = mt7615_mcu_alloc_sta_req(mvif, NULL);
+	skb = mt7615_mcu_alloc_sta_req(dev, mvif, NULL);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1001,7 +1003,7 @@ mt7615_mcu_wtbl_tx_ba(struct mt7615_dev *dev,
 	struct sk_buff *skb = NULL;
 	int err;
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, NULL, &skb);
+	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
@@ -1012,7 +1014,7 @@ mt7615_mcu_wtbl_tx_ba(struct mt7615_dev *dev,
 	if (err < 0)
 		return err;
 
-	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1033,7 +1035,7 @@ mt7615_mcu_wtbl_rx_ba(struct mt7615_dev *dev,
 	struct sk_buff *skb;
 	int err;
 
-	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1045,7 +1047,7 @@ mt7615_mcu_wtbl_rx_ba(struct mt7615_dev *dev,
 		return err;
 
 	skb = NULL;
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, NULL, &skb);
+	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
@@ -1067,7 +1069,7 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 
 	msta = sta ? (struct mt7615_sta *)sta->drv_priv : &mvif->sta;
 
-	sskb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	sskb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
 	if (IS_ERR(sskb))
 		return PTR_ERR(sskb);
 
@@ -1075,8 +1077,8 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	if (enable && sta)
 		mt7615_mcu_sta_ht_tlv(sskb, sta);
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_RESET_AND_SET, NULL,
-					     &wskb);
+	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
+					     NULL, &wskb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
@@ -1120,7 +1122,7 @@ mt7615_mcu_sta_ba(struct mt7615_dev *dev,
 	struct tlv *sta_wtbl;
 	struct sk_buff *skb;
 
-	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1128,7 +1130,8 @@ mt7615_mcu_sta_ba(struct mt7615_dev *dev,
 
 	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
+	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
+					     &skb);
 	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
 
 	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
@@ -1163,7 +1166,7 @@ mt7615_mcu_add_sta_cmd(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 
 	msta = sta ? (struct mt7615_sta *)sta->drv_priv : &mvif->sta;
 
-	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1173,7 +1176,7 @@ mt7615_mcu_add_sta_cmd(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 
 	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_RESET_AND_SET,
+	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
 					     sta_wtbl, &skb);
 	if (enable) {
 		mt7615_mcu_wtbl_generic_tlv(skb, vif, sta, sta_wtbl, wtbl_hdr);
@@ -1499,13 +1502,14 @@ mt7615_mcu_uni_tx_ba(struct mt7615_dev *dev,
 	struct sk_buff *skb;
 	int err;
 
-	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
+	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
+					     &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
@@ -1517,7 +1521,7 @@ mt7615_mcu_uni_tx_ba(struct mt7615_dev *dev,
 	if (err < 0)
 		return err;
 
-	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1539,7 +1543,7 @@ mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
 	struct sk_buff *skb;
 	int err;
 
-	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1550,13 +1554,14 @@ mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
 	if (err < 0 || !enable)
 		return err;
 
-	skb = mt7615_mcu_alloc_sta_req(mvif, msta);
+	skb = mt7615_mcu_alloc_sta_req(dev, mvif, msta);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
-	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(msta, WTBL_SET, sta_wtbl, &skb);
+	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
+					     &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
@@ -2114,6 +2119,7 @@ static int mt7663_load_firmware(struct mt7615_dev *dev)
 int mt7615_mcu_init(struct mt7615_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7615_mcu_ops = {
+		.headroom = sizeof(struct mt7615_mcu_txd),
 		.mcu_skb_send_msg = mt7615_mcu_send_message,
 		.mcu_send_msg = mt7615_mcu_msg_send,
 		.mcu_restart = mt7615_mcu_restart,
@@ -2186,7 +2192,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 
 	req_hdr.len = cpu_to_le16(eep_len);
 
-	skb = mt7615_mcu_msg_alloc(NULL, sizeof(req_hdr) + eep_len);
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(req_hdr) + eep_len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -2601,7 +2607,7 @@ int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
 	if (!mt7615_firmware_offload(dev))
 		return 0;
 
-	skb = mt7615_mcu_msg_alloc(NULL, len);
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -2646,7 +2652,7 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (!mt7615_firmware_offload(dev))
 		return 1;
 
-	skb = mt7615_mcu_msg_alloc(NULL, sizeof(*req));
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(*req));
 	if (!skb)
 		return -ENOMEM;
 
@@ -2746,7 +2752,8 @@ int mt7615_mcu_sched_scan_req(struct mt7615_phy *phy,
 	if (!mt7615_firmware_offload(dev))
 		return -ENOTSUPP;
 
-	skb = mt7615_mcu_msg_alloc(NULL, sizeof(*req) + sreq->ie_len);
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+				 sizeof(*req) + sreq->ie_len);
 	if (!skb)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 43c13a47cea2..69cb68d6465d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -845,11 +845,4 @@ enum {
 	CH_SWITCH_SCAN_BYPASS_DPD = 9
 };
 
-static inline struct sk_buff *
-mt7615_mcu_msg_alloc(const void *data, int len)
-{
-	return mt76_mcu_msg_alloc(data, sizeof(struct mt7615_mcu_txd),
-				  len, 0);
-}
-
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 8247611d9b18..89a8992d84fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -23,7 +23,7 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	if (mt76_is_mmio(&dev->mt76) && dev->mcu_timeout)
 		return -EIO;
 
-	skb = mt76x02_mcu_msg_alloc(data, len);
+	skb = mt76_mcu_msg_alloc(mdev, data, len);
 	if (!skb)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h
index c81a9655c4c9..5fba1266c648 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h
@@ -85,12 +85,6 @@ struct mt76x02_patch_header {
 	u8 pad[2];
 };
 
-static inline struct sk_buff *
-mt76x02_mcu_msg_alloc(const void *data, int len)
-{
-	return mt76_mcu_msg_alloc(data, 0, len, 0);
-}
-
 int mt76x02_mcu_cleanup(struct mt76x02_dev *dev);
 int mt76x02_mcu_calibrate(struct mt76x02_dev *dev, int type, u32 param);
 int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
index 843b86560ed4..a30bb536fc8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
@@ -123,7 +123,7 @@ mt76x02u_mcu_send_msg(struct mt76_dev *dev, int cmd, const void *data,
 	struct sk_buff *skb;
 	int err;
 
-	skb = mt76_mcu_msg_alloc(data, MT_CMD_HDR_LEN, len, 8);
+	skb = mt76_mcu_msg_alloc(dev, data, len);
 	if (!skb)
 		return -ENOMEM;
 
@@ -291,6 +291,8 @@ EXPORT_SYMBOL_GPL(mt76x02u_mcu_fw_send_data);
 void mt76x02u_init_mcu(struct mt76_dev *dev)
 {
 	static const struct mt76_mcu_ops mt76x02u_mcu_ops = {
+		.headroom = MT_CMD_HDR_LEN,
+		.tailroom = 8,
 		.mcu_send_msg = mt76x02u_mcu_send_msg,
 		.mcu_wr_rp = mt76x02u_mcu_wr_rp,
 		.mcu_rd_rp = mt76x02u_mcu_rd_rp,
-- 
2.25.1

