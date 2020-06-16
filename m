Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF641FB3C8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgFPOK6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:10:58 -0400
Received: from p54ae948c.dip0.t-ipconnect.de ([84.174.148.140]:49551 "EHLO
        maeck.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729003AbgFPOK5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:10:57 -0400
X-Greylist: delayed 1021 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 10:10:57 EDT
Received: by maeck.local (Postfix, from userid 501)
        id 433CD8E33D0B; Tue, 16 Jun 2020 11:40:55 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] mt76: mt7615: re-enable offloading of sequence number assignment
Date:   Tue, 16 Jun 2020 11:40:55 +0200
Message-Id: <20200616094055.4070-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Preparation for supporting more offload features

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: fix WTBL address offset
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 44 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  5 +++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d97315ec7265..d150fac50c00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -617,16 +617,19 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	}
 
 	val = FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
-	if (ieee80211_is_data_qos(hdr->frame_control)) {
-		seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
-		val |= MT_TXD3_SN_VALID;
-	} else if (ieee80211_is_back_req(hdr->frame_control)) {
-		struct ieee80211_bar *bar = (struct ieee80211_bar *)skb->data;
-
-		seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(bar->start_seq_num));
-		val |= MT_TXD3_SN_VALID;
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
+		seqno = le16_to_cpu(hdr->seq_ctrl);
+
+		if (ieee80211_is_back_req(hdr->frame_control)) {
+			struct ieee80211_bar *bar;
+
+			bar = (struct ieee80211_bar *)skb->data;
+			seqno = le16_to_cpu(bar->start_seq_num);
+		}
+
+		val |= MT_TXD3_SN_VALID |
+		       FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
 	}
-	val |= FIELD_PREP(MT_TXD3_SEQ, seqno);
 
 	txwi[3] |= cpu_to_le32(val);
 
@@ -893,6 +896,29 @@ mt7615_mac_queue_rate_update(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	return 0;
 }
 
+u32 mt7615_mac_get_sta_tid_sn(struct mt7615_dev *dev, int wcid, u8 tid)
+{
+	u32 addr, val, val2;
+	u8 offset;
+
+	addr = mt7615_mac_wtbl_addr(dev, wcid) + 11 * 4;
+
+	offset = tid * 12;
+	addr += 4 * (offset / 32);
+	offset %= 32;
+
+	val = mt76_rr(dev, addr);
+	val >>= (tid % 32);
+
+	if (offset > 20) {
+		addr += 4;
+		val2 = mt76_rr(dev, addr);
+		val |= val2 << (32 - offset);
+	}
+
+	return val & GENMASK(11, 0);
+}
+
 void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index beaca8127680..dfebf86b86d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -660,6 +660,9 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
 		mt7615_mcu_add_tx_ba(dev, params, true);
+		ssn = mt7615_mac_get_sta_tid_sn(dev, msta->wcid.idx, tid);
+		ieee80211_send_bar(vif, sta->addr, tid,
+				   IEEE80211_SN_TO_SEQ(ssn));
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
@@ -667,6 +670,8 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mt7615_mcu_add_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
+		ssn = mt7615_mac_get_sta_tid_sn(dev, msta->wcid.idx, tid);
+		params->ssn = ssn;
 		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 3e7d51bf42a4..640ff8b9b266 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -516,6 +516,7 @@ int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
 			       enum mt7615_cipher_type cipher,
 			       enum set_key_cmd cmd);
 void mt7615_mac_reset_work(struct work_struct *work);
+u32 mt7615_mac_get_sta_tid_sn(struct mt7615_dev *dev, int wcid, u8 tid);
 
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
-- 
2.24.0

