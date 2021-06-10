Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B933A25B3
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFJHqQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 03:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJHqP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 03:46:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A222613C1;
        Thu, 10 Jun 2021 07:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623311059;
        bh=a/6v0hO6KlTETav0fObFmNvGoQ0R7KniiSrtd7W+TGs=;
        h=From:To:Cc:Subject:Date:From;
        b=aqFepXOnAbB9+YG+4rQjUwMu4gxwsqXCfnZAIpXzqBg5VOBQGHxlaBNMVN/rjX21C
         m6EGOIKdsly+wuVLTwj9JygTMjz98BbGUteV/tykpF2yfQ8110URZRY6UCStSBAEzO
         ga3ymfLlP95hzpkKn7+kqFikcotlsrrDLrGowr+KY30kqmOCRWYtEF5lsfX5e/dooY
         SeJwnK9BshXqa8T+gZxbua6cT7qyGDJPhyQl6XLWF/uR1ciIbF+q8aVnf5mTCKNzkV
         ZXMW27BCKhaSlGvVpb/acR120obDaYunYOSX5713+2552zeSW4Jpd+/b4uM1Y/KLTe
         Jwkfihhijetvw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: move mt76_get_next_pkt_id in mt76.h
Date:   Thu, 10 Jun 2021 09:44:12 +0200
Message-Id: <21fd76c13fb30b56893411f3d6c9af72adab52d0.1623310950.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to remove duplicated code, move mt76_get_next_pkt_id routine
in mt76.h

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h       | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 15 +++------------
 drivers/net/wireless/mediatek/mt76/tx.c         |  7 +------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 338219024ba7..a50ba8e9344e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1276,4 +1276,15 @@ mt76_token_put(struct mt76_dev *dev, int token)
 
 	return txwi;
 }
+
+static inline int
+mt76_get_next_pkt_id(struct mt76_wcid *wcid)
+{
+	wcid->packet_id = (wcid->packet_id + 1) & MT_PACKET_ID_MASK;
+	if (wcid->packet_id == MT_PACKET_ID_NO_ACK ||
+	    wcid->packet_id == MT_PACKET_ID_NO_SKB)
+		wcid->packet_id = MT_PACKET_ID_FIRST;
+
+	return wcid->packet_id;
+}
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index f518c84d7fa9..fb4de73df701 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -13,16 +13,6 @@
 #define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
 						 IEEE80211_RADIOTAP_HE_##f)
 
-static u8
-mt7921_next_pid(struct mt7921_dev *dev, struct mt76_wcid *wcid)
-{
-	wcid->packet_id = (wcid->packet_id + 1) & MT_PACKET_ID_MASK;
-	if (wcid->packet_id == MT_PACKET_ID_NO_ACK ||
-	    wcid->packet_id == MT_PACKET_ID_NO_SKB)
-		wcid->packet_id = MT_PACKET_ID_FIRST;
-	return wcid->packet_id;
-}
-
 unsigned long
 mt7921_next_txs_set(struct mt7921_dev *dev, struct mt76_wcid *wcid,
 		    u32 timeout)
@@ -756,7 +746,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_phy *mphy = &dev->mphy;
-	u8 pid, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
+	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	u16 tx_count = 15;
 	u32 val;
@@ -829,8 +819,9 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 	if ((FIELD_GET(MT_TXD2_FRAME_TYPE, txwi[2]) &
 		(IEEE80211_FTYPE_DATA >> 2)) &&
 		mt7921_next_txs_timeout(dev, wcid)) {
+		u8 pid = mt76_get_next_pkt_id(wcid);
+
 		mt7921_next_txs_set(dev, wcid, 250);
-		pid = mt7921_next_pid(dev, wcid);
 		val = MT_TXD5_TX_STATUS_MCU | FIELD_PREP(MT_TXD5_PID, pid);
 		txwi[5] |= cpu_to_le32(val);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 5cc3e4d75c4f..f0f7a913eaab 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -129,12 +129,7 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	spin_lock_bh(&dev->status_list.lock);
 
 	memset(cb, 0, sizeof(*cb));
-	wcid->packet_id = (wcid->packet_id + 1) & MT_PACKET_ID_MASK;
-	if (wcid->packet_id == MT_PACKET_ID_NO_ACK ||
-	    wcid->packet_id == MT_PACKET_ID_NO_SKB)
-		wcid->packet_id = MT_PACKET_ID_FIRST;
-
-	pid = wcid->packet_id;
+	pid = mt76_get_next_pkt_id(wcid);
 	cb->wcid = wcid->idx;
 	cb->pktid = pid;
 	cb->jiffies = jiffies;
-- 
2.31.1

