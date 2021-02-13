Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F8431AD6F
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Feb 2021 18:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhBMRvt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 12:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhBMRvq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 12:51:46 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3ABC061756
        for <linux-wireless@vger.kernel.org>; Sat, 13 Feb 2021 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jjiti78Iz9569e7fRLLUxli2KGgXXyorjlfJRwTIOkI=; b=IGz1lwZCOmod9Ulk5+dyrZbefv
        4FiyEud/lloZrZ3wgPziqCjaER71eRdK+otT9tYvJTw/Lu5eHOnhLmotxAbqP75/4aP0vNBf1WbS0
        J9yl4WsMZYVALoU7P4bnzIYEDZnxdIqbbRAeo3MdFyQ/SFWnX9w6oYul8+LySpw5Wxz0=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lAz4Q-0007si-JF
        for linux-wireless@vger.kernel.org; Sat, 13 Feb 2021 18:51:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/7] mt76: mt7915: add support for rx decapsulation offload
Date:   Sat, 13 Feb 2021 18:50:57 +0100
Message-Id: <20210213175100.22608-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210213175100.22608-1-nbd@nbd.name>
References: <20210213175100.22608-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For AP and Client mode, the hardware can pass received packets as 802.3 frames
that can be passed to the network stack as-is.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 44 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 11 +++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 21 ++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 25 +++++++++++
 6 files changed, 92 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3911d333bb41..d0193cf2f1ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -197,6 +197,7 @@ enum mt76_wcid_flags {
 	MT_WCID_FLAG_CHECK_PS,
 	MT_WCID_FLAG_PS,
 	MT_WCID_FLAG_4ADDR,
+	MT_WCID_FLAG_HDR_TRANS,
 };
 
 #define MT76_N_WCIDS 288
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 34a4fee24c48..c599b44a728c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -109,6 +109,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 
 	hw->max_tx_fragments = 4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 22d4f16cf830..71ccefcdc89c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -325,6 +325,10 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
 	bool unicast, insert_ccmp_hdr = false;
 	u8 remove_pad, amsdu_info;
+	bool hdr_trans;
+	u16 seq_ctrl = 0;
+	u8 qos_ctl = 0;
+	__le16 fc = 0;
 	int i, idx;
 
 	memset(status, 0, sizeof(*status));
@@ -346,6 +350,7 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
+	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
 	status->wcid = mt7915_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
@@ -404,6 +409,13 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	rxd += 6;
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
+		u32 v0 = le32_to_cpu(rxd[0]);
+		u32 v2 = le32_to_cpu(rxd[2]);
+
+		fc = cpu_to_le16(FIELD_GET(MT_RXD6_FRAME_CONTROL, v0));
+		qos_ctl = FIELD_GET(MT_RXD8_QOS_CTL, v2);
+		seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, v2);
+
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
@@ -555,28 +567,42 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (status->amsdu) {
 		status->first_amsdu = amsdu_info == MT_RXD4_FIRST_AMSDU_FRAME;
 		status->last_amsdu = amsdu_info == MT_RXD4_LAST_AMSDU_FRAME;
-		memmove(skb->data + 2, skb->data,
-			ieee80211_get_hdrlen_from_skb(skb));
-		skb_pull(skb, 2);
+		if (!hdr_trans) {
+			memmove(skb->data + 2, skb->data,
+				ieee80211_get_hdrlen_from_skb(skb));
+			skb_pull(skb, 2);
+		}
 	}
 
-	if (insert_ccmp_hdr) {
+	if (insert_ccmp_hdr && !hdr_trans) {
 		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
 
 		mt76_insert_ccmp_hdr(skb, key_id);
 	}
 
+	if (!hdr_trans) {
+		hdr = mt76_skb_get_hdr(skb);
+		fc = hdr->frame_control;
+		if (ieee80211_is_data_qos(fc)) {
+			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
+			qos_ctl = *ieee80211_get_qos_ctl(hdr);
+		}
+	} else {
+		status->flag &= ~(RX_FLAG_RADIOTAP_HE |
+				  RX_FLAG_RADIOTAP_HE_MU);
+		status->flag |= RX_FLAG_8023;
+	}
+
 	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE)
 		mt7915_mac_decode_he_radiotap(skb, status, rxv, mode);
 
-	hdr = mt76_skb_get_hdr(skb);
-	if (!status->wcid || !ieee80211_is_data_qos(hdr->frame_control))
+	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
 
 	status->aggr = unicast &&
-		       !ieee80211_is_qos_nullfunc(hdr->frame_control);
-	status->qos_ctl = *ieee80211_get_qos_ctl(hdr);
-	status->seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
+		       !ieee80211_is_qos_nullfunc(fc);
+	status->qos_ctl = qos_ctl;
+	status->seqno = IEEE80211_SEQ_TO_SN(seq_ctrl);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 6ad8af835fd4..0f929fb53027 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -101,6 +101,17 @@ enum rx_pkt_type {
 
 #define MT_RXV_HDR_BAND_IDX		BIT(24)
 
+/* RXD GROUP4 */
+#define MT_RXD6_FRAME_CONTROL		GENMASK(15, 0)
+#define MT_RXD6_TA_LO			GENMASK(31, 16)
+
+#define MT_RXD7_TA_HI			GENMASK(31, 0)
+
+#define MT_RXD8_SEQ_CTRL		GENMASK(15, 0)
+#define MT_RXD8_QOS_CTL			GENMASK(31, 16)
+
+#define MT_RXD9_HT_CONTROL		GENMASK(31, 0)
+
 /* P-RXV */
 #define MT_PRXV_TX_RATE			GENMASK(6, 0)
 #define MT_PRXV_TX_DCM			BIT(4)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index d4969b2e1ffb..2406733f542d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -34,14 +34,14 @@ static int mt7915_start(struct ieee80211_hw *hw)
 
 	if (!running) {
 		mt7915_mcu_set_pm(dev, 0, 0);
-		mt7915_mcu_set_mac(dev, 0, true, false);
+		mt7915_mcu_set_mac(dev, 0, true, true);
 		mt7915_mcu_set_scs(dev, 0, true);
 		mt7915_mac_enable_nf(dev, 0);
 	}
 
 	if (phy != &dev->phy) {
 		mt7915_mcu_set_pm(dev, 1, 0);
-		mt7915_mcu_set_mac(dev, 1, true, false);
+		mt7915_mcu_set_mac(dev, 1, true, true);
 		mt7915_mcu_set_scs(dev, 1, true);
 		mt7915_mac_enable_nf(dev, 1);
 	}
@@ -888,6 +888,22 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 	mt7915_mcu_sta_update_hdr_trans(dev, vif, sta);
 }
 
+static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 bool enabled)
+{
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+
+	if (enabled)
+		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+	else
+		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+
+	mt7915_mcu_sta_update_hdr_trans(dev, vif, sta);
+}
+
 const struct ieee80211_ops mt7915_ops = {
 	.tx = mt7915_tx,
 	.start = mt7915_start,
@@ -920,6 +936,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.set_coverage_class = mt7915_set_coverage_class,
 	.sta_statistics = mt7915_sta_statistics,
 	.sta_set_4addr = mt7915_sta_set_4addr,
+	.sta_set_decap_offload = mt7915_sta_set_decap_offload,
 	CFG80211_TESTMODE_CMD(mt76_testmode_cmd)
 	CFG80211_TESTMODE_DUMP(mt76_testmode_dump)
 #ifdef CONFIG_MAC80211_DEBUGFS
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 195929242b72..6a8a1aa50756 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1685,6 +1685,7 @@ mt7915_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		return;
 
 	msta = (struct mt7915_sta *)sta->drv_priv;
+	htr->no_rx_trans = !test_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
 	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags)) {
 		htr->to_ds = true;
 		htr->from_ds = true;
@@ -2869,6 +2870,27 @@ void mt7915_mcu_exit(struct mt7915_dev *dev)
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 
+static int
+mt7915_mcu_set_rx_hdr_trans_blacklist(struct mt7915_dev *dev, int band)
+{
+	struct {
+		u8 operation;
+		u8 count;
+		u8 _rsv[2];
+		u8 index;
+		u8 enable;
+		__le16 etype;
+	} req = {
+		.operation = 1,
+		.count = 1,
+		.enable = 1,
+		.etype = cpu_to_le16(ETH_P_PAE),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RX_HDR_TRANS),
+				 &req, sizeof(req), false);
+}
+
 int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band,
 		       bool enable, bool hdr_trans)
 {
@@ -2899,6 +2921,9 @@ int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band,
 	if (ret)
 		return ret;
 
+	if (hdr_trans)
+		mt7915_mcu_set_rx_hdr_trans_blacklist(dev, band);
+
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MAC_INIT_CTRL),
 				 &req_mac, sizeof(req_mac), true);
 }
-- 
2.28.0

