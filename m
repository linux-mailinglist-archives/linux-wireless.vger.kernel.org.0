Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B924318A2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 14:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhJRMQ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 08:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231590AbhJRMQ2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 08:16:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C60B8610A3;
        Mon, 18 Oct 2021 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634559257;
        bh=SFAD+EEahY6Ac97fEjAO1MDrUGhiio/uQ67UyBf4ur4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHPosw6OuwUb8wsvac3i5P6tIP50mTCqN+TVmBOGithnAW/AwlhvaAt6OVi/pCVVD
         94inZ9wS/BmY03OLxKha6Bo4FQDLHv8gBQ864DAmMJAz1/bDwunAjTCj7Yz12FUao8
         XyaxEX3SkNfPnGeGmrNrwJNBIm0wgvzq7R+4i6C0DDQuRiR6uCeY4BemP5RCmSYDyK
         N90lnPcM7entfa+6jYNLVPtSgJ5yGwW8ZHklK9B5l864PSOrwjiBy+6yYaVnMXsKbk
         71qUfon60h4ZJrnPJ+mo4TJtpP8YK0QA72G8gmUpO+Ie1q01y2dq27N2uevJLVeVk2
         3MWzEat2MTzrw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com
Subject: [PATCH 01/10] mt76: move mt76_sta_stats in mt76.h
Date:   Mon, 18 Oct 2021 14:14:00 +0200
Message-Id: <ebc3d54628108aab5cd72c1a879e32314b142c95.1634558817.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634558817.git.lorenzo@kernel.org>
References: <cover.1634558817.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to add ethtool stats to mt7921 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h          | 7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 9 +--------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0b8f3b7c7a38..efb25fe36d4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -773,6 +773,13 @@ enum mt76_phy_type {
 	__MT_PHY_TYPE_HE_MAX,
 };
 
+struct mt76_sta_stats {
+	u64 tx_mode[__MT_PHY_TYPE_HE_MAX];
+	u64 tx_bw[4];		/* 20, 40, 80, 160 */
+	u64 tx_nss[4];		/* 1, 2, 3, 4 */
+	u64 tx_mcs[16];		/* mcs idx */
+};
+
 #define CCK_RATE(_idx, _rate) {					\
 	.bitrate = _rate,					\
 	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b992fdd338e2..edf62e0a7ff0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1347,7 +1347,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 
 static bool
 mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
-		       __le32 *txs_data, struct mt7915_sta_stats *stats)
+		       __le32 *txs_data, struct mt76_sta_stats *stats)
 {
 	struct ieee80211_supported_band *sband;
 	struct mt76_dev *mdev = &dev->mt76;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index de9bd122e891..b60f5adab6ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1199,10 +1199,10 @@ static void mt7915_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 {
 	struct mt7915_ethtool_worker_info *wi = wi_data;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt76_sta_stats *mstats = &msta->stats;
 	int ei = wi->initial_stat_idx;
 	int q;
 	u64 *data = wi->data;
-	struct mt7915_sta_stats *mstats = &msta->stats;
 
 	if (msta->vif != wi->mvif)
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b09d2c758218..2acede0d5bf2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -65,13 +65,6 @@ enum mt7915_rxq_id {
 	MT7915_RXQ_MCU_WA_EXT,
 };
 
-struct mt7915_sta_stats {
-	unsigned long tx_mode[__MT_PHY_TYPE_HE_MAX]; /* See mt76_phy_type */
-	unsigned long tx_bw[4]; /* 20, 40, 80, 160 */
-	unsigned long tx_nss[4]; /* 1, 2, 3, 4 */
-	unsigned long tx_mcs[16]; /* mcs idx */
-};
-
 struct mt7915_sta_key_conf {
 	s8 keyidx;
 	u8 key[16];
@@ -106,7 +99,7 @@ struct mt7915_sta {
 	unsigned long jiffies;
 	unsigned long ampdu_state;
 
-	struct mt7915_sta_stats stats;
+	struct mt76_sta_stats stats;
 
 	struct mt7915_sta_key_conf bip;
 
-- 
2.31.1

