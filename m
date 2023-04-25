Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D496F6EE78A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjDYSci (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjDYScc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 14:32:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B5C173
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 11:32:29 -0700 (PDT)
X-UUID: 84db8780e39711eda9a90f0bb45854f4-20230426
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RbiV4rzT1WaFwmtzAdHozU0hEjq/edyvt2cus8+kBWs=;
        b=oTGOxLaEFjuKkNvQYrKYqlKwiM3Bk5sskEz8K5lqjG4E2QkwdyplLepABPma+PfnFZhSsJAR5m7n94MGn/Skm4sg+Wh/+Se5n1PEJf9RZUZKR0jqdvXGEhOx0GZ0xYs3g+XsFXQjmAkF2o4XiZ2QK3qVa0+JiqifvTwda6AfRXk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:fb3ccaa5-622b-496e-b38b-15af90122b6b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:fb3ccaa5-622b-496e-b38b-15af90122b6b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:1b4e1eec-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230426023224EAJ1TPZ0,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 84db8780e39711eda9a90f0bb45854f4-20230426
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1483260772; Wed, 26 Apr 2023 02:32:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Apr 2023 02:32:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 26 Apr 2023 02:32:16 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/3] wifi: mt76: mt7915: rework tx bytes counting when WED is active
Date:   Wed, 26 Apr 2023 02:32:14 +0800
Message-ID: <0b59b2be7719de1d4db93d878cb8d62d98f4f777.1682446940.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <8febf5d1f44e7f0b1e9f6ca099bd5ffcc8816f86.1682446940.git.ryder.lee@mediatek.com>
References: <8febf5d1f44e7f0b1e9f6ca099bd5ffcc8816f86.1682446940.git.ryder.lee@mediatek.com>
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

Concurrent binding/non-binding skbs could be handled anywhere which leads
to mixed byte counting, so switch to use PPDU TxS reporting regardless Tx
paths when WED is active.

Fixes: 43eaa3689507 ("wifi: mt76: add PPDU based TxS support for WED device")
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  2 --
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  6 ++++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 30 ++-----------------
 drivers/net/wireless/mediatek/mt76/tx.c       |  6 ++++
 4 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index f2237ae7c4d5..bcd0f2fb0795 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -521,8 +521,6 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 		q_idx = wmm_idx * MT76_CONNAC_MAX_WMM_SETS +
 			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
 
-		/* counting non-offloading skbs */
-		wcid->stats.tx_bytes += skb->len;
 		/* mt7915 WA only counts WED path */
 		if (is_mt7915(dev) && mtk_wed_device_active(&dev->mmio.wed))
 			wcid->stats.tx_packets++;
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

