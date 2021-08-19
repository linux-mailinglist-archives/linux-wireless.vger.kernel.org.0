Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E333F153C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 10:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbhHSIdO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 04:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237318AbhHSIdM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 04:33:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 775A661101;
        Thu, 19 Aug 2021 08:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629361956;
        bh=PqJDBUX1vUQTnYtC4cgmckgX6tpFhcGk9KLGtKf8JdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTb6dK7u46GNh+pWSzNpsfC/IGb/4mqcMGu9A2HyxNT6Nb0huxKWIUqirraCUghLf
         nXs/SsMEKoLdBWllcCQSCbyEY1qn6n10U2tzSZih6HmdesGM+wmdwJaVCowXce7AvQ
         HHxheHqzd0f5//2bayui/rCuWwwf9ey/NASJB4qT1D/3LHxFnNtDT2X9CoGvgEHuXk
         0on/szwCC7Ukrh7SqJ+7ywCeVVLnWo4gml0FmnusEy0oenkNOHmvuvqZRPVLUfyMTv
         8sZa8ccxpslqQeC/FG3KrXYSNypZdK+32P2nKlvRdL85sQFeH2MFVGKEM4XSwsjbny
         wex3zKLAAj5GQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH v2 5/5] mt76: mt7921: remove mt7921_sta_stats
Date:   Thu, 19 Aug 2021 10:32:05 +0200
Message-Id: <9cb6e1a19c64a27ebad929a3b7c9c8ddfd3ac42a.1629361688.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629361688.git.lorenzo@kernel.org>
References: <cover.1629361688.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7921_sta_stats is no longer needed

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 12 +-----------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 1d15599c782a..a5db5c3b0a6a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -967,9 +967,9 @@ int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (sta) {
 		struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
 
-		if (time_after(jiffies, msta->stats.jiffies + HZ / 4)) {
+		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
 			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-			msta->stats.jiffies = jiffies;
+			msta->last_txs = jiffies;
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 8a7b4e78c097..217ed7055aa0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -586,7 +586,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.idx = idx;
 	msta->wcid.ext_phy = mvif->mt76.band_idx;
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	msta->stats.jiffies = jiffies;
+	msta->last_txs = jiffies;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 61fa53af3840..a6caca73fdda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -65,15 +65,6 @@ enum mt7921_rxq_id {
 	MT7921_RXQ_MCU_WM = 0,
 };
 
-struct mt7921_sta_stats {
-	struct rate_info prob_rate;
-	struct rate_info tx_rate;
-
-	unsigned long per;
-	unsigned long changed;
-	unsigned long jiffies;
-};
-
 struct mt7921_sta_key_conf {
 	s8 keyidx;
 	u8 key[16];
@@ -87,8 +78,7 @@ struct mt7921_sta {
 	struct list_head poll_list;
 	u32 airtime_ac[8];
 
-	struct mt7921_sta_stats stats;
-
+	unsigned long last_txs;
 	unsigned long ampdu_state;
 
 	struct mt7921_sta_key_conf bip;
-- 
2.31.1

