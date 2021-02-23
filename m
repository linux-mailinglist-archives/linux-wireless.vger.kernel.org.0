Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C33228F5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 11:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhBWKni (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 05:43:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhBWKnh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 05:43:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AB4D64DE8;
        Tue, 23 Feb 2021 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614076976;
        bh=tIpgtBtrQUFxjCMSSM3O2XzC1WXeUKLpyERx7y9GjVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=QIKyoIGnr5xeWE+sHKjLqu8jVdiWzgRueuWWE9kew/rGPQGSrCwpqB4x5tAsW+Hc+
         +EAVWoDCStS/dixrvlyFbBPb//2xFlI+QpcIh/tqGKZrb16RbwuosGAv34bSEJBm//
         cTsGCFxaVj74rx4fLH3Z8BB/aA8sy/d+8+wymRz5wo0sgKNbESccsgKp8x8RSZbmNP
         SUJ6qjnkh1+hh6srGEmSioLDywiFRuVrsvOK/5qJKyl5OfKqigdqPagAaJoSW41g/q
         zcV29ZLGpc4R9/J6wE8g4EnpQTdqkPqNm2GA3gXreRAJyeoEagjE1bZweQWivpis0t
         0unjXM2GqaPzA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7615: fix mib stats counter reporting to mac80211
Date:   Tue, 23 Feb 2021 11:42:49 +0100
Message-Id: <32f0cb79fd3b95af5cd1dcb0bbf8a4846b7f7c8e.1614076891.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to properly report MIB counters to mac80211, resets stats in
mt7615_get_stats routine and hold mt76 mutex accessing MIB counters.
Sum up MIB counters in mt7615_mac_update_mib_stats routine.

Fixes: c388d8584bc83 ("mt76: mt7615: add a get_stats() callback")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 26 ++++++-------------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  6 +++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 10 +++----
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f5c6cad23efd..1bbe193db1cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1830,10 +1830,8 @@ mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
 	int i, aggr;
 	u32 val, val2;
 
-	memset(mib, 0, sizeof(*mib));
-
-	mib->fcs_err_cnt = mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
-					  MT_MIB_SDR3_FCS_ERR_MASK);
+	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
+					   MT_MIB_SDR3_FCS_ERR_MASK);
 
 	val = mt76_get_field(dev, MT_MIB_SDR14(ext_phy),
 			     MT_MIB_AMPDU_MPDU_COUNT);
@@ -1846,24 +1844,16 @@ mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
 	aggr = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0; i < 4; i++) {
 		val = mt76_rr(dev, MT_MIB_MB_SDR1(ext_phy, i));
-
-		val2 = FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
-		if (val2 > mib->ack_fail_cnt)
-			mib->ack_fail_cnt = val2;
-
-		val2 = FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
-		if (val2 > mib->ba_miss_cnt)
-			mib->ba_miss_cnt = val2;
+		mib->ba_miss_cnt += FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
+		mib->ack_fail_cnt += FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK,
+					       val);
 
 		val = mt76_rr(dev, MT_MIB_MB_SDR0(ext_phy, i));
-		val2 = FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
-		if (val2 > mib->rts_retries_cnt) {
-			mib->rts_cnt = FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
-			mib->rts_retries_cnt = val2;
-		}
+		mib->rts_cnt += FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
+		mib->rts_retries_cnt += FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK,
+						  val);
 
 		val = mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
-
 		dev->mt76.aggr_stats[aggr++] += val & 0xffff;
 		dev->mt76.aggr_stats[aggr++] += val >> 16;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 63e98371f863..0500b3bfcf83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -810,11 +810,17 @@ mt7615_get_stats(struct ieee80211_hw *hw,
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	struct mib_stats *mib = &phy->mib;
 
+	mt7615_mutex_acquire(phy->dev);
+
 	stats->dot11RTSSuccessCount = mib->rts_cnt;
 	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
 	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
 	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
 
+	memset(mib, 0, sizeof(*mib));
+
+	mt7615_mutex_release(phy->dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 919242652213..157bec6a1d88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -133,11 +133,11 @@ struct mt7615_vif {
 };
 
 struct mib_stats {
-	u16 ack_fail_cnt;
-	u16 fcs_err_cnt;
-	u16 rts_cnt;
-	u16 rts_retries_cnt;
-	u16 ba_miss_cnt;
+	u32 ack_fail_cnt;
+	u32 fcs_err_cnt;
+	u32 rts_cnt;
+	u32 rts_retries_cnt;
+	u32 ba_miss_cnt;
 	unsigned long aggr_per;
 };
 
-- 
2.29.2

