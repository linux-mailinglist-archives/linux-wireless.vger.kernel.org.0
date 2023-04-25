Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3226EDE53
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 10:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjDYIlO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 04:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDYIka (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 04:40:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC233161B7
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 01:38:39 -0700 (PDT)
X-UUID: 7c4b0efee34411edb6b9f13eb10bd0fe-20230425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=N+Pu1MiLUq3HuJzTe5iVNKtzd38e9coS6ER0bmvmodE=;
        b=NIhLgo8DajRnE5CzLiQiOVGEbOjHRFhANZPiARtGjn62y99nZUTkaTv6qzdP7HKkV56p2+b1s4rM42URmo6qQt7p0TV9QAEQUHwWj+4FDEk1Nw2tNMMCn3ngrgiQ6dbujp2pTRZuwRB1McrLq07c1L8u3BZd5marvcf7c5NfRvc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:06ef9c21-eeeb-462d-b79c-a3c7090fee7e,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:aed32b85-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 7c4b0efee34411edb6b9f13eb10bd0fe-20230425
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 541313204; Tue, 25 Apr 2023 16:38:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 25 Apr 2023 16:37:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Apr 2023 16:37:59 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt7915: rework tx bytes/packets when WED is active
Date:   Tue, 25 Apr 2023 16:37:45 +0800
Message-ID: <d9466e4641a7db661058896f4ccd4bba4a9cdb3b.1682411744.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

1. Mixed tx_byte calculation - need to handle both (non)binding packets
   when WED is enabled.
2. PPDU based TxS can only reports MPDU counts whereas mac80211 requires
   MSDU unit(NL80211_STA_INFO_TX_PACKETS).

To solve above issues - switch to use TxS reporting for all tx_byte when
WED is active and get MSDU Tx counts from WA statistic.

Note that mt7915 WA firmware only counts tx_packet for WED path, so
driver needs to take care of host path.

Fixes: 43eaa3689507 ("wifi: mt76: add PPDU based TxS support for WED device")
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  8 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  6 ++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  6 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 74 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 30 +-------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 drivers/net/wireless/mediatek/mt76/tx.c       |  6 ++
 9 files changed, 91 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6b07b8fafec2..0e9f4197213a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -277,7 +277,7 @@ struct mt76_sta_stats {
 	u64 tx_mcs[16];		/* mcs idx */
 	u64 tx_bytes;
 	/* WED TX */
-	u32 tx_packets;
+	u32 tx_packets;		/* unit: MSDU */
 	u32 tx_retries;
 	u32 tx_failed;
 	/* WED RX */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index d39a3cc5e381..84985a989293 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -521,9 +521,9 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 		q_idx = wmm_idx * MT76_CONNAC_MAX_WMM_SETS +
 			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
 
-		/* counting non-offloading skbs */
-		wcid->stats.tx_bytes += skb->len;
-		wcid->stats.tx_packets++;
+		/* mt7915 WA only counts WED path */
+		if (mtk_wed_device_active(&dev->mmio.wed) && is_mt7915(dev))
+			wcid->stats.tx_packets++;
 	}
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
@@ -610,8 +610,6 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		stats->tx_bytes +=
 			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_BYTE) -
 			le32_get_bits(txs_data[7], MT_TXS7_MPDU_RETRY_BYTE);
-		stats->tx_packets +=
-			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_CNT);
 		stats->tx_failed +=
 			le32_get_bits(txs_data[6], MT_TXS6_MPDU_FAIL_CNT);
 		stats->tx_retries +=
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ca1ce97a6d2f..7a52b68491b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -998,6 +998,7 @@ enum {
 	MCU_EXT_EVENT_ASSERT_DUMP = 0x23,
 	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
 	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
+	MCU_EXT_EVENT_WA_TX_STAT = 0x74,
 	MCU_EXT_EVENT_BCC_NOTIFY = 0x75,
 	MCU_EXT_EVENT_MURU_CTRL = 0x9f,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ac2049f49bb3..927a98a315ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -499,6 +499,12 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	set = FIELD_PREP(MT_WTBLOFF_TOP_RSCR_RCPI_MODE, 0) |
 	      FIELD_PREP(MT_WTBLOFF_TOP_RSCR_RCPI_PARAM, 0x3);
 	mt76_rmw(dev, MT_WTBLOFF_TOP_RSCR(band), mask, set);
+
+	/* MT_TXD5_TX_STATUS_HOST (MPDU format) has higher priority than
+	 * MT_AGG_ACR_PPDU_TXS2H (PPDU format) even though ACR bit is set.
+	 */
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mt76_set(dev, MT_AGG_ACR4(band), MT_AGG_ACR_PPDU_TXS2H);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 61157248d742..b306a4fae1fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1043,8 +1043,10 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->tx_bytes = msta->wcid.stats.tx_bytes;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
 
-		sinfo->tx_packets = msta->wcid.stats.tx_packets;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+		if (!mt7915_mcu_wed_wa_tx_stats(phy->dev, msta->wcid.idx)) {
+			sinfo->tx_packets = msta->wcid.stats.tx_packets;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+		}
 
 		if (mtk_wed_get_rx_capa(&phy->dev->mt76.mmio.wed)) {
 			sinfo->rx_bytes = msta->wcid.stats.rx_bytes;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 9fcb22fa1f97..5916dcaa8c7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -164,7 +164,9 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	}
 
 	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
-	if (seq != rxd->seq)
+	if (seq != rxd->seq &&
+	    !(rxd->eid == MCU_CMD_EXT_CID &&
+	      rxd->ext_eid == MCU_EXT_EVENT_WA_TX_STAT))
 		return -EAGAIN;
 
 	if (cmd == MCU_CMD(PATCH_SEM_CONTROL)) {
@@ -395,12 +397,14 @@ void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	struct mt76_connac2_mcu_rxd *rxd;
 
 	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
-	if (rxd->ext_eid == MCU_EXT_EVENT_THERMAL_PROTECT ||
-	    rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
-	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
-	    rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
-	    rxd->ext_eid == MCU_EXT_EVENT_BCC_NOTIFY ||
-	    !rxd->seq)
+	if ((rxd->ext_eid == MCU_EXT_EVENT_THERMAL_PROTECT ||
+	     rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
+	     rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
+	     rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
+	     rxd->ext_eid == MCU_EXT_EVENT_BCC_NOTIFY ||
+	     !rxd->seq) &&
+	     !(rxd->eid == MCU_CMD_EXT_CID &&
+	       rxd->ext_eid == MCU_EXT_EVENT_WA_TX_STAT))
 		mt7915_mcu_rx_unsolicited_event(dev, skb);
 	else
 		mt76_mcu_rx_event(&dev->mt76, skb);
@@ -3733,6 +3737,62 @@ int mt7915_mcu_twt_agrt_update(struct mt7915_dev *dev,
 				 &req, sizeof(req), true);
 }
 
+int mt7915_mcu_wed_wa_tx_stats(struct mt7915_dev *dev, u16 wlan_idx)
+{
+	struct {
+		__le32 cmd;
+		__le32 num;
+		__le32 __rsv;
+		__le16 wlan_idx;
+	} req = {
+		.cmd = cpu_to_le32(0x15),
+		.num = cpu_to_le32(1),
+		.wlan_idx = cpu_to_le16(wlan_idx),
+	};
+	struct mt7915_mcu_wa_tx_stat {
+		__le16 wlan_idx;
+		u8 __rsv[2];
+
+		/* tx_bytes is deprecated since WA byte counter uses u32,
+		 * which easily leads to overflow.
+		 */
+		__le32 tx_bytes;
+		__le32 tx_packets;
+	} *res;
+	struct mt76_wcid *wcid;
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_WA_PARAM_CMD(QUERY),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	if (!is_mt7915(&dev->mt76))
+		skb_pull(skb, 4);
+
+	res = (struct mt7915_mcu_wa_tx_stat *)skb->data;
+
+	if (le16_to_cpu(res->wlan_idx) != wlan_idx) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rcu_read_lock();
+
+	wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+	if (wcid)
+		wcid->stats.tx_packets += le32_to_cpu(res->tx_packets);
+	else
+		ret = -EINVAL;
+
+	rcu_read_unlock();
+out:
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
 int mt7915_mcu_rf_regval(struct mt7915_dev *dev, u32 regidx, u32 *val, bool set)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 45f3558bf31c..2fa059af23de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -545,8 +545,6 @@ static u32 mt7915_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 static int mt7915_mmio_wed_offload_enable(struct mtk_wed_device *wed)
 {
 	struct mt7915_dev *dev;
-	struct mt7915_phy *phy;
-	int ret;
 
 	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
 
@@ -554,43 +552,19 @@ static int mt7915_mmio_wed_offload_enable(struct mtk_wed_device *wed)
 	dev->mt76.token_size = wed->wlan.token_start;
 	spin_unlock_bh(&dev->mt76.token_lock);
 
-	ret = wait_event_timeout(dev->mt76.tx_wait,
-				 !dev->mt76.wed_token_count, HZ);
-	if (!ret)
-		return -EAGAIN;
-
-	phy = &dev->phy;
-	mt76_set(dev, MT_AGG_ACR4(phy->mt76->band_idx), MT_AGG_ACR_PPDU_TXS2H);
-
-	phy = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
-	if (phy)
-		mt76_set(dev, MT_AGG_ACR4(phy->mt76->band_idx),
-			 MT_AGG_ACR_PPDU_TXS2H);
-
-	return 0;
+	return !wait_event_timeout(dev->mt76.tx_wait,
+				   !dev->mt76.wed_token_count, HZ);
 }
 
 static void mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
 {
 	struct mt7915_dev *dev;
-	struct mt7915_phy *phy;
 
 	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
 
 	spin_lock_bh(&dev->mt76.token_lock);
 	dev->mt76.token_size = MT7915_TOKEN_SIZE;
 	spin_unlock_bh(&dev->mt76.token_lock);
-
-	/* MT_TXD5_TX_STATUS_HOST (MPDU format) has higher priority than
-	 * MT_AGG_ACR_PPDU_TXS2H (PPDU format) even though ACR bit is set.
-	 */
-	phy = &dev->phy;
-	mt76_clear(dev, MT_AGG_ACR4(phy->mt76->band_idx), MT_AGG_ACR_PPDU_TXS2H);
-
-	phy = dev->mt76.phys[MT_BAND1] ? dev->mt76.phys[MT_BAND1]->priv : NULL;
-	if (phy)
-		mt76_clear(dev, MT_AGG_ACR4(phy->mt76->band_idx),
-			   MT_AGG_ACR_PPDU_TXS2H);
 }
 
 static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b3ead3530740..3053f4abf7db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -539,6 +539,7 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7915_mcu_rdd_background_enable(struct mt7915_phy *phy,
 				     struct cfg80211_chan_def *chandef);
+int mt7915_mcu_wed_wa_tx_stats(struct mt7915_dev *dev, u16 wcid);
 int mt7915_mcu_rf_regval(struct mt7915_dev *dev, u32 regidx, u32 *val, bool set);
 int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
 int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 type, u8 ctrl);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 72b3ec715e47..99d395bd1bba 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -121,6 +121,7 @@ int
 mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		       struct sk_buff *skb)
 {
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 	int pid;
@@ -133,6 +134,11 @@ mt76_tx_status_skb_add(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
 		return MT_PACKET_ID_NO_ACK;
 
+	if (mtk_wed_device_active(&dev->mmio.wed) &&
+	    ((info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) ||
+	      ieee80211_is_data(hdr->frame_control)))
+		return MT_PACKET_ID_WED;
+
 	if (!(info->flags & (IEEE80211_TX_CTL_REQ_TX_STATUS |
 			     IEEE80211_TX_CTL_RATE_CTRL_PROBE)))
 		return MT_PACKET_ID_NO_SKB;
-- 
2.18.0

