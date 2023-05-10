Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D56FD578
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 06:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjEJExk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 00:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjEJExf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 00:53:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD634E2
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 21:53:32 -0700 (PDT)
X-UUID: 9832aafeeeee11edb20a276fd37b9834-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rA3lxUADbTuelJc5zY3xRP2kN4cElBgjCQFOd1G/DQg=;
        b=KTOPpUYoO+2Os0fWIMp21j9nsl2ibW84fnleXHrzNoGOOKMOHmoEZI7jlDVRQRrull81k25c7hjh3MlTuRLbT7ZRWUu6Gx72I3WXAybkCbv9NiDHxfGuCSGXEKa/gbNIWqEXWio0OqAGfkcx2+Fd0IN1UIJNV7b1FIRwXhmFudA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:4bd6719a-43ce-46b2-94c9-f437cad00f64,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.24,REQID:4bd6719a-43ce-46b2-94c9-f437cad00f64,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:178d4d4,CLOUDID:69a7ad3a-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:2305101253265MTHUJAZ,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 9832aafeeeee11edb20a276fd37b9834-20230510
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 364955994; Wed, 10 May 2023 12:53:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 12:53:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 12:53:22 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 2/6] wifi: mt76: mt7915: rework tx packets counting when WED is active
Date:   Wed, 10 May 2023 12:53:17 +0800
Message-ID: <6f90887e061e9d500fc42752599e8882913b1709.1683670255.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <e3cddf1cff5f060478c2de9e4e4021541549e750.1683670255.git.ryder.lee@mediatek.com>
References: <e3cddf1cff5f060478c2de9e4e4021541549e750.1683670255.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

PPDU TxS can only report MPDU count whereas mac80211 requires MSDU scale
(NL80211_STA_INFO_TX_PACKETS), so switch to get MSDU counts from WA
statistic.

Note that mt7915 WA firmware only counts tx_packet for WED path, so driver
needs to take care of host path additionally.

Fixes: 43eaa3689507 ("wifi: mt76: add PPDU based TxS support for WED device")
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
v3:
- add a mtk_wed_device_active() check in mt76_connac2_mac_fill_txs()
v2:
- split to small patch mt7921 crashes
- swap wcid->stats.tx_packets check condition to avoid mt7921 crash
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  9 ++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  6 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 74 +++++++++++++++++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 6 files changed, 79 insertions(+), 14 deletions(-)

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
index 368668448542..f6346a458978 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -523,7 +523,9 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 
 		/* counting non-offloading skbs */
 		wcid->stats.tx_bytes += skb->len;
-		wcid->stats.tx_packets++;
+		/* mt7915 WA only counts WED path */
+		if (is_mt7915(dev) && mtk_wed_device_active(&dev->mmio.wed))
+			wcid->stats.tx_packets++;
 	}
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
@@ -606,12 +608,11 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	txs = le32_to_cpu(txs_data[0]);
 
 	/* PPDU based reporting */
-	if (FIELD_GET(MT_TXS0_TXS_FORMAT, txs) > 1) {
+	if (mtk_wed_device_active(&dev->mmio.wed) &&
+	    FIELD_GET(MT_TXS0_TXS_FORMAT, txs) > 1) {
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
-- 
2.18.0

