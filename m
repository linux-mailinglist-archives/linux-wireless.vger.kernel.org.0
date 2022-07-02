Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CEC564228
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jul 2022 20:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiGBSrk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jul 2022 14:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGBSrj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jul 2022 14:47:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F7DFA4
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 11:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35668B8068B
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 18:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64950C34114;
        Sat,  2 Jul 2022 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656787655;
        bh=Pe3g/si3Obtqo998vcAH4HAJR4H8mAJ/B7NAeK+BtSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FZFJX53ARNfU6nRMKDwbqVM6KOoGlynd35yUHr9GskGj4/rIyykn/f+FeLXfqZ4ST
         k/hkV3U46g6TQSBSNdK6e73gV6BMjppsOaCzGggSTwXzSEAyNXAdto9dtKCDG9unCO
         dqUKDuxGrHD/3sB8705007JYSxDeDMCn2rsRIvSHBQewiToBdJS4uSMm78G4gWWCsp
         FFBv/vH2g70/Eg5/7LA4VgP/2chcHjV2Dxw+DsVIv1KTCYxo5i/AUjOoq3yuT70xN4
         s62a6CEFGx7SMQFTTH1QNk5i+OJFjbgisY+WjhFkwoEv9oL6kMd07QGhWoDHYSeO4s
         xuYKX0UbNqYRQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        bo.jiao@mediatek.com
Subject: [PATCH v2 1/5] mt76: add phy_idx in mt76_rx_status
Date:   Sat,  2 Jul 2022 20:47:20 +0200
Message-Id: <221befb876d0c726b6afcd1088c92dc1214a851e.1656787439.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656787439.git.lorenzo@kernel.org>
References: <cover.1656787439.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce phy_idx mt76_rx_status instead of ext_idx. This is a
preliminary patch to add mt7990 chipset support

Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c   |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt76.h       | 11 ++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index ecf5bd9605db..b2c834632b37 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -739,7 +739,7 @@ static void mt76_rx_release_burst(struct mt76_phy *phy, enum mt76_rxq_id q,
 void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	struct mt76_phy *phy = mt76_dev_phy(dev, status->ext_phy);
+	struct mt76_phy *phy = mt76_dev_phy(dev, status->phy_idx);
 
 	if (!test_bit(MT76_STATE_RUNNING, &phy->state)) {
 		dev_kfree_skb(skb);
@@ -1015,7 +1015,7 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 	       sizeof(mstat.chain_signal));
 
 	*sta = wcid_to_sta(mstat.wcid);
-	*hw = mt76_phy_hw(dev, mstat.ext_phy);
+	*hw = mt76_phy_hw(dev, mstat.phy_idx);
 }
 
 static int
@@ -1178,7 +1178,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	u8 tidno = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
 	bool ps;
 
-	hw = mt76_phy_hw(dev, status->ext_phy);
+	hw = mt76_phy_hw(dev, status->phy_idx);
 	if (ieee80211_is_pspoll(hdr->frame_control) && !wcid &&
 	    !(status->flag & RX_FLAG_8023)) {
 		sta = ieee80211_find_sta_by_ifaddr(hw, hdr->addr2, NULL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6b4150c54b96..3ee7db911529 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -575,7 +575,7 @@ struct mt76_rx_status {
 
 	u8 iv[6];
 
-	u8 ext_phy:1;
+	u8 phy_idx:2;
 	u8 aggr:1;
 	u8 qos_ctl;
 	u16 seqno;
@@ -1001,17 +1001,18 @@ static inline int mt76_init_mcu_queue(struct mt76_dev *dev, int qid, int idx,
 }
 
 static inline struct mt76_phy *
-mt76_dev_phy(struct mt76_dev *dev, bool phy_ext)
+mt76_dev_phy(struct mt76_dev *dev, u8 phy_idx)
 {
-	if (phy_ext && dev->phy2)
+	if (phy_idx && dev->phy2)
 		return dev->phy2;
+
 	return &dev->phy;
 }
 
 static inline struct ieee80211_hw *
-mt76_phy_hw(struct mt76_dev *dev, bool phy_ext)
+mt76_phy_hw(struct mt76_dev *dev, u8 phy_idx)
 {
-	return mt76_dev_phy(dev, phy_ext)->hw;
+	return mt76_dev_phy(dev, phy_idx)->hw;
 }
 
 static inline u8 *
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d9dd3d404986..1afcf964a587 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -500,7 +500,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	if (phy_idx == 1 && phy2) {
 		mphy = dev->mt76.phy2;
 		phy = phy2;
-		status->ext_phy = true;
+		status->phy_idx = phy_idx;
 	}
 
 	if (!mt7615_firmware_offload(dev) && chfreq != phy->chfreq)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f696c20dc6e3..58d65904fdfb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -247,7 +247,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			return -EINVAL;
 
 		phy = mphy->priv;
-		status->ext_phy = true;
+		status->phy_idx = 1;
 	}
 
 	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
-- 
2.36.1

