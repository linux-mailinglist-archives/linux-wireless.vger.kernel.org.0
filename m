Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B11ABF7DE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfIZRro (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:44 -0400
Received: from nbd.name ([46.4.11.11]:55256 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfIZRrg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OyFXF0YuowzSTjo3loIAYrnKUEb1eori/zD8C3EWSys=; b=BdWthinoi5Urp6feCm5irsrl6p
        GBnmWrkvmEvCkwyTkETj5u26G51WBM2w441it064FYm7BtjqBKzi11uGJWOL3d5M4d082rOOKn93I
        PznFBT/C4Ywd+Bbp8SG0Bj3D2Ey9I1Jtput7zvGWbJiOxQwxZVxpjcLbJp/XNtJD1r04=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXra-0000yz-J7
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:34 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B7D7A69B6A8C; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 06/15] mt76: mt7603: track tx airtime for airtime fairness and survey
Date:   Thu, 26 Sep 2019 19:47:23 +0200
Message-Id: <20190926174732.42375-6-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Poll per-station hardware counters after tx status events

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  2 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  2 +
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  3 +
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 86 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  7 ++
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  7 ++
 7 files changed, 109 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index aab181bc6eb2..5fcadd712f89 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -481,6 +481,7 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	memset(survey, 0, sizeof(*survey));
 	survey->channel = chan;
 	survey->filled = SURVEY_INFO_TIME | SURVEY_INFO_TIME_BUSY;
+	survey->filled |= dev->drv->survey_flags;
 	if (chan == dev->main_chan) {
 		survey->filled |= SURVEY_INFO_IN_USE;
 
@@ -492,6 +493,7 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	survey->time = div_u64(state->cc_active, 1000);
 	survey->time_busy = div_u64(state->cc_busy, 1000);
 	survey->time_bss_rx = div_u64(state->cc_bss_rx, 1000);
+	survey->time_tx = div_u64(state->cc_tx, 1000);
 	spin_unlock_bh(&dev->cc_lock);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 911347bd272c..4f3849b4f677 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -285,6 +285,7 @@ struct mt76_hw_cap {
 
 struct mt76_driver_ops {
 	u32 drv_flags;
+	u32 survey_flags;
 	u16 txwi_size;
 
 	void (*update_survey)(struct mt76_dev *dev);
@@ -321,6 +322,7 @@ struct mt76_channel_state {
 	u64 cc_active;
 	u64 cc_busy;
 	u64 cc_bss_rx;
+	u64 cc_tx;
 };
 
 struct mt76_sband {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index 24d82a20d046..a6ab73060aad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -152,6 +152,8 @@ static int mt7603_poll_tx(struct napi_struct *napi, int budget)
 	for (i = MT_TXQ_MCU; i >= 0; i--)
 		mt76_queue_tx_cleanup(dev, i, false);
 
+	mt7603_mac_sta_poll(dev);
+
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index a68533684b18..3a2927a524c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -8,6 +8,7 @@
 const struct mt76_driver_ops mt7603_drv_ops = {
 	.txwi_size = MT_TXD_SIZE,
 	.drv_flags = MT_DRV_SW_RX_AIRTIME,
+	.survey_flags = SURVEY_INFO_TIME_TX,
 	.tx_prepare_skb = mt7603_tx_prepare_skb,
 	.tx_complete_skb = mt7603_tx_complete_skb,
 	.rx_skb = mt7603_queue_rx_skb,
@@ -525,6 +526,8 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	bus_ops->rmw = mt7603_rmw;
 	dev->mt76.bus = bus_ops;
 
+	INIT_LIST_HEAD(&dev->sta_poll_list);
+	spin_lock_init(&dev->sta_poll_lock);
 	spin_lock_init(&dev->ps_lock);
 
 	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7603_mac_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 0212384d0d56..caa1456adc50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -160,6 +160,8 @@ void mt7603_wtbl_init(struct mt7603_dev *dev, int idx, int vif,
 	addr = mt7603_wtbl4_addr(idx);
 	for (i = 0; i < MT_WTBL4_SIZE; i += 4)
 		mt76_wr(dev, addr + i, 0);
+
+	mt7603_wtbl_update(dev, idx, MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 }
 
 static void
@@ -380,6 +382,84 @@ void mt7603_mac_tx_ba_reset(struct mt7603_dev *dev, int wcid, int tid,
 	mt76_rmw(dev, addr + (15 * 4), tid_mask, tid_val);
 }
 
+void mt7603_mac_sta_poll(struct mt7603_dev *dev)
+{
+	static const u8 ac_to_tid[4] = {
+		[IEEE80211_AC_BE] = 0,
+		[IEEE80211_AC_BK] = 1,
+		[IEEE80211_AC_VI] = 4,
+		[IEEE80211_AC_VO] = 6
+	};
+	struct ieee80211_sta *sta;
+	struct mt7603_sta *msta;
+	u32 total_airtime = 0;
+	u32 airtime[4];
+	u32 addr;
+	int i;
+
+	rcu_read_lock();
+
+	while (1) {
+		bool clear = false;
+
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&dev->sta_poll_list)) {
+			spin_unlock_bh(&dev->sta_poll_lock);
+			break;
+		}
+
+		msta = list_first_entry(&dev->sta_poll_list, struct mt7603_sta,
+					poll_list);
+		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		addr = mt7603_wtbl4_addr(msta->wcid.idx);
+		for (i = 0; i < 4; i++) {
+			u32 airtime_last = msta->tx_airtime_ac[i];
+
+			msta->tx_airtime_ac[i] = mt76_rr(dev, addr + i * 8);
+			airtime[i] = msta->tx_airtime_ac[i] - airtime_last;
+			airtime[i] *= 32;
+			total_airtime += airtime[i];
+
+			if (msta->tx_airtime_ac[i] & BIT(22))
+				clear = true;
+		}
+
+		if (clear) {
+			mt7603_wtbl_update(dev, msta->wcid.idx,
+					   MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+			memset(msta->tx_airtime_ac, 0,
+			       sizeof(msta->tx_airtime_ac));
+		}
+
+		if (!msta->wcid.sta)
+			continue;
+
+		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
+		for (i = 0; i < 4; i++) {
+			struct mt76_queue *q = dev->mt76.q_tx[i].q;
+			u8 qidx = q->hw_idx;
+			u8 tid = ac_to_tid[i];
+			u32 txtime = airtime[qidx];
+
+			if (!txtime)
+				continue;
+
+			ieee80211_sta_register_airtime(sta, tid, txtime, 0);
+		}
+	}
+
+	rcu_read_unlock();
+
+	if (!total_airtime)
+		return;
+
+	spin_lock_bh(&dev->mt76.cc_lock);
+	dev->mt76.chan_state->cc_tx += total_airtime;
+	spin_unlock_bh(&dev->mt76.cc_lock);
+}
+
 static struct mt76_wcid *
 mt7603_rx_get_wcid(struct mt7603_dev *dev, u8 idx, bool unicast)
 {
@@ -1159,6 +1239,12 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	msta = container_of(wcid, struct mt7603_sta, wcid);
 	sta = wcid_to_sta(wcid);
 
+	if (list_empty(&msta->poll_list)) {
+		spin_lock_bh(&dev->sta_poll_lock);
+		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+	}
+
 	if (mt7603_mac_add_txs_skb(dev, msta, pid, txs_data))
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index e7b57f20b629..180eb6bb781a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -66,6 +66,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	idx = MT7603_WTBL_RESERVED - 1 - mvif->idx;
 	dev->vif_mask |= BIT(mvif->idx);
+	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 
@@ -325,6 +326,7 @@ mt7603_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
+	INIT_LIST_HEAD(&msta->poll_list);
 	__skb_queue_head_init(&msta->psq);
 	msta->ps = ~0;
 	msta->smps = ~0;
@@ -361,6 +363,11 @@ mt7603_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7603_filter_tx(dev, wcid->idx, true);
 	spin_unlock_bh(&dev->ps_lock);
 
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&msta->poll_list))
+		list_del_init(&msta->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
 	mt7603_wtbl_clear(dev, wcid->idx);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 01b933538c25..ab54b0612e98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -61,6 +61,9 @@ struct mt7603_sta {
 
 	struct mt7603_vif *vif;
 
+	struct list_head poll_list;
+	u32 tx_airtime_ac[4];
+
 	struct sk_buff_head psq;
 
 	struct ieee80211_tx_rate rates[4];
@@ -103,6 +106,9 @@ struct mt7603_dev {
 
 	u8 vif_mask;
 
+	struct list_head sta_poll_list;
+	spinlock_t sta_poll_lock;
+
 	struct mt7603_sta global_sta;
 
 	u32 agc0, agc3;
@@ -202,6 +208,7 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data);
 void mt7603_mac_rx_ba_reset(struct mt7603_dev *dev, void *addr, u8 tid);
 void mt7603_mac_tx_ba_reset(struct mt7603_dev *dev, int wcid, int tid,
 			    int ba_size);
+void mt7603_mac_sta_poll(struct mt7603_dev *dev);
 
 void mt7603_pse_client_reset(struct mt7603_dev *dev);
 
-- 
2.17.0

