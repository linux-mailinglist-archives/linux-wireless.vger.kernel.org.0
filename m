Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4E6375A00
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhEFSOp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 14:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhEFSOp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 14:14:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C106561166;
        Thu,  6 May 2021 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620324826;
        bh=6PK6VAihN1zzWkKUf4ewFr+c6S9O8OrxXH4hUIaeYlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzdTL0F4BdYybtrI8fUXHLDxeYfcPFWleue5L7sIwFysQnsO3p+OpP1t2V6QyXVEH
         VMmppGx02w1CkV3RhA0nOAplQSgzypJW7pL0BVEOeDYmAkYaMHaFcEYLl3ffv1yw8J
         JG/6dmV3EkFh22DTUKs/8bpsrgSCG0iaVA1IXmH51SByp7QyvM9IWWfo96t1IcQ0Jg
         nFXxBKreKvY2AF0LQ8b+oKUqqFoEmMEP5dZQ68iMX379tmmGZ7L1c1mLBgo/RW3RAM
         dGBYyQaQx7WkCGVXVmXwCyVD7hPf50Xix16siLXXLK4XG2dFgjNhmr+//dFs1fK1s9
         AqbXlQpo8JV3w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 1/4] mt76: mt7921: enable rx hw de-amsdu
Date:   Thu,  6 May 2021 20:13:32 +0200
Message-Id: <2115cb0033a49369d2f5776e2602b6a0de0aca44.1620322988.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620322988.git.lorenzo@kernel.org>
References: <cover.1620322988.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable hw rx-amsdu de-aggregation support available in 7921 devices.
This is a preliminary patch to enable rx checksum offload.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  | 16 +++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.h  |  3 +++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 225f4d327a4e..93cd05f653dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -125,8 +125,8 @@ void mt7921_mac_init(struct mt7921_dev *dev)
 	int i;
 
 	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 1536);
-	/* disable hardware de-agg */
-	mt76_clear(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
+	/* enable hardware de-agg */
+	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
 	mt76_clear(dev, MT_MDP_DCR0, MT_MDP_DCR0_RX_HDR_TRANS_EN);
 
 	for (i = 0; i < MT7921_WTBL_SIZE; i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index decf2d5f0ce3..7e57d230e63a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -319,8 +319,9 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
+	u32 rxd4 = le32_to_cpu(rxd[4]);
 	bool unicast, insert_ccmp_hdr = false;
-	u8 remove_pad;
+	u8 remove_pad, amsdu_info;
 	int i, idx;
 	u8 chfreq;
 
@@ -332,6 +333,9 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
 		return -EINVAL;
 
+	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
+		return -EINVAL;
+
 	chfreq = FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);
 	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
@@ -540,6 +544,16 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	skb_pull(skb, (u8 *)rxd - skb->data + 2 * remove_pad);
 
+	amsdu_info = FIELD_GET(MT_RXD4_NORMAL_PAYLOAD_FORMAT, rxd4);
+	status->amsdu = !!amsdu_info;
+	if (status->amsdu) {
+		status->first_amsdu = amsdu_info == MT_RXD4_FIRST_AMSDU_FRAME;
+		status->last_amsdu = amsdu_info == MT_RXD4_LAST_AMSDU_FRAME;
+		memmove(skb->data + 2, skb->data,
+			ieee80211_get_hdrlen_from_skb(skb));
+		skb_pull(skb, 2);
+	}
+
 	if (insert_ccmp_hdr) {
 		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index 109c8849d106..435c138c27d1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -88,6 +88,9 @@ enum rx_pkt_type {
 
 /* RXD DW4 */
 #define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
+#define MT_RXD4_FIRST_AMSDU_FRAME	GENMASK(1, 0)
+#define MT_RXD4_MID_AMSDU_FRAME		BIT(1)
+#define MT_RXD4_LAST_AMSDU_FRAME	BIT(0)
 #define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
 #define MT_RXD4_NORMAL_CLS		BIT(10)
 #define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
-- 
2.30.2

