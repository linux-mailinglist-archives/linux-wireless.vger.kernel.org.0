Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68AF5F5509
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJENIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJENIa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:08:30 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7678588
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/7zzQC1yacgPTLdD2YHcvnkJ3Ea2OXoO0GySLvmUrlU=; b=kYb6fkAxgowEO864qNim1zgQCs
        sL+gEdHt9kDyvVIXZuAG7i+F0l/ErT6IBcJ1/pkg3AP4dxPOZVD1KPwVhjSLj9uOJK51WQ508txD1
        0katGEUcbWO3TDQjReRoXkYz8mPYvllz4X8iymCqSejKfTdlo4mY8wVF9qR0PVm8kH4Q=;
Received: from p200300daa7301d005d133ca52e775ee5.dip0.t-ipconnect.de ([2003:da:a730:1d00:5d13:3ca5:2e77:5ee5] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1og48Q-00ANpv-Gj; Wed, 05 Oct 2022 15:08:26 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org
Subject: [PATCH 6.1 2/2] wifi: mt76: fix rx checksum offload on mt7615/mt7915/mt7921
Date:   Wed,  5 Oct 2022 15:08:24 +0200
Message-Id: <20221005130824.23371-2-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221005130824.23371-1-nbd@nbd.name>
References: <20221005130824.23371-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Checking the relevant rxd bits for the checksum information only indicates
if the checksum verification was performed by the hardware and doesn't show
actual checksum errors. Checksum errors are indicated in the info field of
the DMA descriptor. Fix packets erroneously marked as CHECKSUM_UNNECESSARY
by checking the extra bits as well.
Those bits are only passed to the driver for MMIO devices at the moment, so
limit checksum offload to those.

Fixes: 2122dfbfd0bd ("mt76: mt7615: add rx checksum offload support")
Fixes: 94244d2ea503 ("mt76: mt7915: add rx checksum offload support")
Fixes: 0e75732764e8 ("mt76: mt7921: enable rx csum offload")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c        | 5 +----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 4 +++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index ceb63b3aaced..c8ab7abcdbb5 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -717,10 +717,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 
 		skb_reserve(skb, q->buf_offset);
 
-		if (q == &dev->q_rx[MT_RXQ_MCU]) {
-			u32 *rxfce = (u32 *)skb->cb;
-			*rxfce = info;
-		}
+		*(u32 *)skb->cb = info;
 
 		__skb_put(skb, len);
 		done++;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index cbc6859e38ac..2ce1705c0f43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -345,6 +345,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
+	u32 csum_status = *(u32 *)skb->cb;
 	bool unicast, hdr_trans, remove_pad, insert_ccmp_hdr = false;
 	u16 hdr_gap;
 	int phy_idx;
@@ -394,7 +395,8 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		spin_unlock_bh(&dev->sta_poll_lock);
 	}
 
-	if ((rxd0 & csum_mask) == csum_mask)
+	if (mt76_is_mmio(&dev->mt76) && (rxd0 & csum_mask) == csum_mask &&
+	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	if (rxd2 & MT_RXD2_NORMAL_FCS_ERR)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index ec996a587142..324f0f58572b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -233,6 +233,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	u8 remove_pad, amsdu_info;
 	u8 mode = 0, qos_ctl = 0;
 	struct mt7915_sta *msta = NULL;
+	u32 csum_status = *(u32 *)skb->cb;
 	bool hdr_trans;
 	u16 hdr_gap;
 	u16 seq_ctrl = 0;
@@ -288,7 +289,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (!sband->channels)
 		return -EINVAL;
 
-	if ((rxd0 & csum_mask) == csum_mask)
+	if ((rxd0 & csum_mask) == csum_mask &&
+	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	if (rxd1 & MT_RXD1_NORMAL_FCS_ERR)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 8de5e36a3780..6860468ed191 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -230,6 +230,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt7921_phy *phy = &dev->phy;
 	struct ieee80211_supported_band *sband;
+	u32 csum_status = *(u32 *)skb->cb;
 	u32 rxd0 = le32_to_cpu(rxd[0]);
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
@@ -290,7 +291,8 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	if (!sband->channels)
 		return -EINVAL;
 
-	if ((rxd0 & csum_mask) == csum_mask)
+	if (mt76_is_mmio(&dev->mt76) && (rxd0 & csum_mask) == csum_mask &&
+	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	if (rxd1 & MT_RXD1_NORMAL_FCS_ERR)
-- 
2.36.1

