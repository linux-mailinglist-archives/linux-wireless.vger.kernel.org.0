Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260F2321F4C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 19:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhBVSnY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 13:43:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhBVSmh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 13:42:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0069E64EEC;
        Mon, 22 Feb 2021 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017876;
        bh=hQaP5O5wDLoLB+MsFGtGz195urSTevRTGvmwTlUANHE=;
        h=From:To:Cc:Subject:Date:From;
        b=BHI1EtUBzwVyHJkljdOkcWzK39E/vrMprAds7Dc9bLaj3vZFWKi13KPTviP4JcFey
         YZDiEfSPV0ybSooBcLRkutw888uSK5kJXA5XplVoDfStHJ9AcpXOVpoOTTEZD/plGC
         6a/Nn4l4C6MRMnyaPDDGVRCW/H4du+vse++fHSPFtwaAjVsr2NCqZl9w3HyMzhmra5
         Reel9GhF34XZ1zJey1dwMa2ejeSAnCUCXMmy4UsgFNLgPb3w+FGUWD/7l1qkN+me1B
         iamP9lIbwC/V/AQgZxGr+mmxsmqILJKJBxqai+0c4mDYJ8B6y5d6hnl2K4no42N0/i
         vQoYzQwW5pOBA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2] mt76: mt7921: fix stats register definitions
Date:   Mon, 22 Feb 2021 19:17:49 +0100
Message-Id: <c1cb1c5fe9d7200bf356e4a565ecc05c2338d9ac.1614017756.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix register definitions for mac80211 stats reporting.
Move mib counter reset to mt7921_get_stats routine.

Fixes: 163f4d22c118d ("mt76: mt7921: add MAC support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- fix stats register access
- move mib counter reset to mt7921_get_stats routine
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 31 ++++++-------------
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  6 ++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 10 +++---
 .../net/wireless/mediatek/mt76/mt7921/regs.h  | 15 ++++++---
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index f1015ac3866d..48a60d43a4e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1320,31 +1320,20 @@ mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 	struct mib_stats *mib = &phy->mib;
 	int i, aggr0 = 0, aggr1;
 
-	memset(mib, 0, sizeof(*mib));
-
-	mib->fcs_err_cnt = mt76_get_field(dev, MT_MIB_SDR3(0),
-					  MT_MIB_SDR3_FCS_ERR_MASK);
+	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(0),
+					   MT_MIB_SDR3_FCS_ERR_MASK);
+	mib->ack_fail_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR3(0),
+					    MT_MIB_ACK_FAIL_COUNT_MASK);
+	mib->ba_miss_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR2(0),
+					   MT_MIB_BA_FAIL_COUNT_MASK);
+	mib->rts_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR0(0),
+				       MT_MIB_RTS_COUNT_MASK);
+	mib->rts_retries_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR1(0),
+					       MT_MIB_RTS_FAIL_COUNT_MASK);
 
 	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
 		u32 val, val2;
 
-		val = mt76_rr(dev, MT_MIB_MB_SDR1(0, i));
-
-		val2 = FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
-		if (val2 > mib->ack_fail_cnt)
-			mib->ack_fail_cnt = val2;
-
-		val2 = FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
-		if (val2 > mib->ba_miss_cnt)
-			mib->ba_miss_cnt = val2;
-
-		val = mt76_rr(dev, MT_MIB_MB_SDR0(0, i));
-		val2 = FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
-		if (val2 > mib->rts_retries_cnt) {
-			mib->rts_cnt = FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
-			mib->rts_retries_cnt = val2;
-		}
-
 		val = mt76_rr(dev, MT_TX_AGG_CNT(0, i));
 		val2 = mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7e76bf7fa99b..8f9ac96cccb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -838,11 +838,17 @@ mt7921_get_stats(struct ieee80211_hw *hw,
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mib_stats *mib = &phy->mib;
 
+	mt7921_mutex_acquire(phy->dev);
+
 	stats->dot11RTSSuccessCount = mib->rts_cnt;
 	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
 	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
 	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
 
+	memset(mib, 0, sizeof(*mib));
+
+	mt7921_mutex_release(phy->dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 46e53fa00796..3931237a75a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -102,11 +102,11 @@ struct mt7921_vif {
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
 };
 
 struct mt7921_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index d7e316eb006c..5cab39c9e7a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -96,8 +96,8 @@
 #define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
 #define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
 
-#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x014)
-#define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x698)
+#define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(31, 16)
 
 #define MT_MIB_SDR9(_band)		MT_WF_MIB(_band, 0x02c)
 #define MT_MIB_SDR9_BUSY_MASK		GENMASK(23, 0)
@@ -121,9 +121,14 @@
 #define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
 #define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
 
-#define MT_MIB_MB_SDR1(_band, n)	MT_WF_MIB(_band, 0x104 + ((n) << 4))
-#define MT_MIB_BA_MISS_COUNT_MASK	GENMASK(15, 0)
-#define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(31, 16)
+#define MT_MIB_MB_BSDR0(_band)		MT_WF_MIB(_band, 0x688)
+#define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
+#define MT_MIB_MB_BSDR1(_band)		MT_WF_MIB(_band, 0x690)
+#define MT_MIB_RTS_FAIL_COUNT_MASK	GENMASK(15, 0)
+#define MT_MIB_MB_BSDR2(_band)		MT_WF_MIB(_band, 0x518)
+#define MT_MIB_BA_FAIL_COUNT_MASK	GENMASK(15, 0)
+#define MT_MIB_MB_BSDR3(_band)		MT_WF_MIB(_band, 0x520)
+#define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(15, 0)
 
 #define MT_MIB_MB_SDR2(_band, n)	MT_WF_MIB(_band, 0x108 + ((n) << 4))
 #define MT_MIB_FRAME_RETRIES_COUNT_MASK	GENMASK(15, 0)
-- 
2.29.2

