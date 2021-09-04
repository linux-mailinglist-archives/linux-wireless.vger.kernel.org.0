Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C83400ACB
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Sep 2021 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351107AbhIDKSM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Sep 2021 06:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351106AbhIDKSM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Sep 2021 06:18:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3878461054;
        Sat,  4 Sep 2021 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630750630;
        bh=QhynLhOuzeN579B/HPBCHmjBVXWBIvWAhwYUo7rS5ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mz6Sh+JYiiGJeVHdPPdtcXKfuKzJwXeCJpNtyDCIC9LsW2bC6DPjLDQ09i3D6ywJG
         M8Plz+98r8rlWhCBpPhi0JdCKV2/S5io5q/1q1xgG9YSCC5tj0Q6y+nOpErAWP8I91
         ywBC62D6bITSMHfxhcGYH5C3m/oCKnxq+INeRn1TWb3+u/1sGrLHufQPHCYu2C+g4Q
         zh0J6oYcG5vHVN6o2HF6XOXvmVsA+iMRzMo7W5bFdmDOvJcT7YHKqkSiLAlQP2N0zw
         EgEp6CR0ssq56Usq6dEeKv7dOYTVCo0fo5I+Pp3Zr/6T5jBvk5MtkUE65APAAPCphI
         JuENMBegTnM5A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH v4 5/5] mt76: mt7921: remove mt7921_sta_stats
Date:   Sat,  4 Sep 2021 12:16:47 +0200
Message-Id: <d887a8eefd20c5b799df3a658ca8cf08b6a42bec.1630750292.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630750292.git.lorenzo@kernel.org>
References: <cover.1630750292.git.lorenzo@kernel.org>
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
index def9c1d61a66..31016ea1be86 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -968,9 +968,9 @@ int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
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

