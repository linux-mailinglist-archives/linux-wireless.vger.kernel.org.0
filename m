Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBD13F000C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 11:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhHRJLE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 05:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhHRJLE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 05:11:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77CF761053;
        Wed, 18 Aug 2021 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629277829;
        bh=JtDZl5lLgHQ3HXh+IZ10r1oelsDgOkfXASzEO8lr6Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Owc840fIJQThqoiX88rn6RclfpXEuYlfXzSNeYJ88o0vqoRYj+ZsIQU/rva9V3LpC
         6JR5XoEZBxVT3iAMsQhraaSjLbrGxq4uvTzLWpiFhETR+NTwo7metSL/JF83uAUbg8
         WOAsihqg7ZbC4tInkP17+fC5pnWAm7pH5RkhVivvvpWZ9spus0F/WkuBBVVJOrPGd1
         J9SEctVJQpqabGq1Z3i1K0GuK16vl0kzcgTx8+h7uQ39NfxjjioapYETlOuxXPO6oc
         eUdzWhSU5f1/0IthFOtgwkYcHlwWhSOKpZ2F0JLTRUQvN04u1XV73WtKb3VmgvK6ZS
         6U0JnkCanX9FA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 5/5] mt76: mt7921: remove mt7921_sta_stats
Date:   Wed, 18 Aug 2021 11:10:00 +0200
Message-Id: <59abfc3592108a1bb1eb04ddaf654f1df4d7aa74.1629277624.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629277624.git.lorenzo@kernel.org>
References: <cover.1629277624.git.lorenzo@kernel.org>
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
index d9e0b993a698..8e14451a065c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -966,9 +966,9 @@ int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
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

