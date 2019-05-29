Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952472D7BC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 10:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfE2I0I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 04:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2I0I (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 04:26:08 -0400
Received: from lore-desk.lan (unknown [151.66.7.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E85BF20665;
        Wed, 29 May 2019 08:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559118367;
        bh=YnvWoDdrijA6cn0+NRNDW6xHDlEOP1OH+96LBCQYHFE=;
        h=From:To:Cc:Subject:Date:From;
        b=YkZ56bnCOAKNLM4J/B5L41Z4pe2sq9rXA5aAxGua1+/cyzvYkfqBEC/vk5zLzoWqR
         1gVJ0fF8feS7kyA8/7DgQlHSSn3P7bcNkDsMGLU3VHbwBoC/LUkeKVWF79YEXAfJO1
         G2nue9FD4ctL8Ob8tGKzrc2KAgkpEaCVwDoybqfA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: move mt76_get_rate in mt76-module
Date:   Wed, 29 May 2019 10:25:55 +0200
Message-Id: <d6b2de1b739a394d5dcdd686a7dff198a743669e.1559118081.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7603_get_rate in mac80211.c and rename it to mt76_get_rate
since it is shared between mt7603 and mt7615 drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on 'mt76: move mt76_insert_ccmp_hdr in mt76-module'
https://patchwork.kernel.org/patch/10942973/
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 24 +++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 30 ++-----------------
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 30 ++-----------------
 4 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index f9e83971902e..ec9efb79985f 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -854,3 +854,27 @@ void mt76_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id)
 	status->flag &= ~RX_FLAG_IV_STRIPPED;
 }
 EXPORT_SYMBOL_GPL(mt76_insert_ccmp_hdr);
+
+int mt76_get_rate(struct mt76_dev *dev,
+		  struct ieee80211_supported_band *sband,
+		  int idx, bool cck)
+{
+	int i, offset = 0, len = sband->n_bitrates;
+
+	if (cck) {
+		if (sband == &dev->sband_5g.sband)
+			return 0;
+
+		idx &= ~BIT(2); /* short preamble */
+	} else if (sband == &dev->sband_2g.sband) {
+		offset = 4;
+	}
+
+	for (i = offset; i < len; i++) {
+		if ((sband->bitrates[i].hw_value & GENMASK(7, 0)) == idx)
+			return i;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_get_rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8edf476f9f2f..97a1296562d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -751,6 +751,9 @@ void mt76_csa_finish(struct mt76_dev *dev);
 
 int mt76_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, bool set);
 void mt76_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id);
+int mt76_get_rate(struct mt76_dev *dev,
+		  struct ieee80211_supported_band *sband,
+		  int idx, bool cck);
 
 /* internal */
 void mt76_tx_free(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 5c09b2dbf3fd..2648fa333f93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -370,31 +370,6 @@ void mt7603_mac_tx_ba_reset(struct mt7603_dev *dev, int wcid, int tid,
 	mt76_rmw(dev, addr + (15 * 4), tid_mask, tid_val);
 }
 
-static int
-mt7603_get_rate(struct mt7603_dev *dev, struct ieee80211_supported_band *sband,
-		int idx, bool cck)
-{
-	int offset = 0;
-	int len = sband->n_bitrates;
-	int i;
-
-	if (cck) {
-		if (sband == &dev->mt76.sband_5g.sband)
-			return 0;
-
-		idx &= ~BIT(2); /* short preamble */
-	} else if (sband == &dev->mt76.sband_2g.sband) {
-		offset = 4;
-	}
-
-	for (i = offset; i < len; i++) {
-		if ((sband->bitrates[i].hw_value & GENMASK(7, 0)) == idx)
-			return i;
-	}
-
-	return 0;
-}
-
 static struct mt76_wcid *
 mt7603_rx_get_wcid(struct mt7603_dev *dev, u8 idx, bool unicast)
 {
@@ -508,7 +483,7 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 			cck = true;
 			/* fall through */
 		case MT_PHY_TYPE_OFDM:
-			i = mt7603_get_rate(dev, sband, i, cck);
+			i = mt76_get_rate(&dev->mt76, sband, i, cck);
 			break;
 		case MT_PHY_TYPE_HT_GF:
 		case MT_PHY_TYPE_HT:
@@ -1018,7 +993,8 @@ mt7603_fill_txs(struct mt7603_dev *dev, struct mt7603_sta *sta,
 		else
 			sband = &dev->mt76.sband_2g.sband;
 		final_rate &= GENMASK(5, 0);
-		final_rate = mt7603_get_rate(dev, sband, final_rate, cck);
+		final_rate = mt76_get_rate(&dev->mt76, sband, final_rate,
+					   cck);
 		final_rate_flags = 0;
 		break;
 	case MT_PHY_TYPE_HT_GF:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 1547bce561d3..7ca2e31f96fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -36,31 +36,6 @@ static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 	return &sta->vif->sta.wcid;
 }
 
-static int mt7615_get_rate(struct mt7615_dev *dev,
-			   struct ieee80211_supported_band *sband,
-			   int idx, bool cck)
-{
-	int offset = 0;
-	int len = sband->n_bitrates;
-	int i;
-
-	if (cck) {
-		if (sband == &dev->mt76.sband_5g.sband)
-			return 0;
-
-		idx &= ~BIT(2); /* short preamble */
-	} else if (sband == &dev->mt76.sband_2g.sband) {
-		offset = 4;
-	}
-
-	for (i = offset; i < len; i++) {
-		if ((sband->bitrates[i].hw_value & GENMASK(7, 0)) == idx)
-			return i;
-	}
-
-	return 0;
-}
-
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
@@ -154,7 +129,7 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 			cck = true;
 			/* fall through */
 		case MT_PHY_TYPE_OFDM:
-			i = mt7615_get_rate(dev, sband, i, cck);
+			i = mt76_get_rate(&dev->mt76, sband, i, cck);
 			break;
 		case MT_PHY_TYPE_HT_GF:
 		case MT_PHY_TYPE_HT:
@@ -608,7 +583,8 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		else
 			sband = &dev->mt76.sband_2g.sband;
 		final_rate &= MT_TX_RATE_IDX;
-		final_rate = mt7615_get_rate(dev, sband, final_rate, cck);
+		final_rate = mt76_get_rate(&dev->mt76, sband, final_rate,
+					   cck);
 		final_rate_flags = 0;
 		break;
 	case MT_PHY_TYPE_HT_GF:
-- 
2.21.0

