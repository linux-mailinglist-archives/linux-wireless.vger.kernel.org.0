Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575377409E5
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjF1Hwt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50390 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230447AbjF1Hwd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:33 -0400
X-UUID: 6a73a874158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=T4m+82uxst7qTjgscB/tdg3Lddg/lDHMeE/D+duRTm8=;
        b=a2cTIQM1Krk8uFeBL6ju1bvUfAU3LfzYnXDN2XjZr7TRZe+ixAeA4SRnaq7e6LlvNjlW9/mG0A81Vv+odLeTrW14vMCEAa19yjaGgerYeBW1yCF6aZ+7baRRjFdmfA79IWuAMshpMuDJeKJC4gNfPS24MGZttqD6e8EnXA8hywA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:2a3207c6-af05-44fd-b223-5d27fc9f00b9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:b0694f0d-26a8-467f-b838-f99719a9c083,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6a73a874158211eeb20a276fd37b9834-20230628
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1204726326; Wed, 28 Jun 2023 15:07:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:15 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 12/16] wifi: mt76: mt7921: move mac shared code in mt792x-lib module
Date:   Wed, 28 Jun 2023 15:05:58 +0800
Message-ID: <a45dd815273e5da47ec73a92b0c3e0d92437c50f.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Reduce duplicated code moving mac shared code in mt792x-lib module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 170 +-----------------
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |   6 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   3 -
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  20 +++
 .../net/wireless/mediatek/mt76/mt792x_mac.c   | 148 +++++++++++++++
 10 files changed, 187 insertions(+), 184 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 59920cffee6a..7d5211b99340 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -396,7 +396,7 @@ static int mt7921_chip_reset(void *data, u64 val)
 	switch (val) {
 	case 1:
 		/* Reset wifisys directly. */
-		mt7921_reset(&dev->mt76);
+		mt792x_reset(&dev->mt76);
 		break;
 	default:
 		/* Collect the core dump before reset wifisys. */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 40f006664ad7..70382194825a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -29,29 +29,6 @@ static u32 mt7921_mac_wtbl_lmac_addr(int idx, u8 offset)
 	return MT_WTBL_LMAC_OFFS(idx, 0) + offset * 4;
 }
 
-static struct mt76_wcid *mt7921_rx_get_wcid(struct mt792x_dev *dev,
-					    u16 idx, bool unicast)
-{
-	struct mt792x_sta *sta;
-	struct mt76_wcid *wcid;
-
-	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
-		return NULL;
-
-	wcid = rcu_dereference(dev->mt76.wcid[idx]);
-	if (unicast || !wcid)
-		return wcid;
-
-	if (!wcid->sta)
-		return NULL;
-
-	sta = container_of(wcid, struct mt792x_sta, wcid);
-	if (!sta->vif)
-		return NULL;
-
-	return &sta->vif->sta.wcid;
-}
-
 static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 {
 	static const u8 ac_to_tid[] = {
@@ -184,52 +161,6 @@ static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 	}
 }
 
-static void
-mt7921_get_status_freq_info(struct mt792x_dev *dev, struct mt76_phy *mphy,
-			    struct mt76_rx_status *status, u8 chfreq)
-{
-	if (chfreq > 180) {
-		status->band = NL80211_BAND_6GHZ;
-		chfreq = (chfreq - 181) * 4 + 1;
-	} else if (chfreq > 14) {
-		status->band = NL80211_BAND_5GHZ;
-	} else {
-		status->band = NL80211_BAND_2GHZ;
-	}
-	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
-}
-
-static void
-mt7921_mac_rssi_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
-{
-	struct sk_buff *skb = priv;
-	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
-
-	if (status->signal > 0)
-		return;
-
-	if (!ether_addr_equal(vif->addr, hdr->addr1))
-		return;
-
-	ewma_rssi_add(&mvif->rssi, -status->signal);
-}
-
-static void
-mt7921_mac_assoc_rssi(struct mt792x_dev *dev, struct sk_buff *skb)
-{
-	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
-
-	if (!ieee80211_is_assoc_resp(hdr->frame_control) &&
-	    !ieee80211_is_auth(hdr->frame_control))
-		return;
-
-	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
-		IEEE80211_IFACE_ITER_RESUME_ALL,
-		mt7921_mac_rssi_iter, skb);
-}
-
 static int
 mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 {
@@ -276,7 +207,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	chfreq = FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);
 	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
-	status->wcid = mt7921_rx_get_wcid(dev, idx, unicast);
+	status->wcid = mt792x_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
 		msta = container_of(status->wcid, struct mt792x_sta, wcid);
@@ -287,7 +218,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
 
-	mt7921_get_status_freq_info(dev, mphy, status, chfreq);
+	mt792x_get_status_freq_info(status, chfreq);
 
 	switch (status->band) {
 	case NL80211_BAND_5GHZ:
@@ -496,7 +427,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_8023;
 	}
 
-	mt7921_mac_assoc_rssi(dev, skb);
+	mt792x_mac_assoc_rssi(dev, skb);
 
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
 		mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv, mode);
@@ -699,81 +630,6 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 }
 EXPORT_SYMBOL_GPL(mt7921_queue_rx_skb);
 
-void mt7921_mac_reset_counters(struct mt792x_phy *phy)
-{
-	struct mt792x_dev *dev = phy->dev;
-	int i;
-
-	for (i = 0; i < 4; i++) {
-		mt76_rr(dev, MT_TX_AGG_CNT(0, i));
-		mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
-	}
-
-	dev->mt76.phy.survey_time = ktime_get_boottime();
-	memset(phy->mt76->aggr_stats, 0, sizeof(phy->mt76->aggr_stats));
-
-	/* reset airtime counters */
-	mt76_rr(dev, MT_MIB_SDR9(0));
-	mt76_rr(dev, MT_MIB_SDR36(0));
-	mt76_rr(dev, MT_MIB_SDR37(0));
-
-	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
-	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
-}
-
-static u8
-mt7921_phy_get_nf(struct mt792x_phy *phy, int idx)
-{
-	return 0;
-}
-
-static void
-mt7921_phy_update_channel(struct mt76_phy *mphy, int idx)
-{
-	struct mt792x_dev *dev = container_of(mphy->dev, struct mt792x_dev, mt76);
-	struct mt792x_phy *phy = (struct mt792x_phy *)mphy->priv;
-	struct mt76_channel_state *state;
-	u64 busy_time, tx_time, rx_time, obss_time;
-	int nf;
-
-	busy_time = mt76_get_field(dev, MT_MIB_SDR9(idx),
-				   MT_MIB_SDR9_BUSY_MASK);
-	tx_time = mt76_get_field(dev, MT_MIB_SDR36(idx),
-				 MT_MIB_SDR36_TXTIME_MASK);
-	rx_time = mt76_get_field(dev, MT_MIB_SDR37(idx),
-				 MT_MIB_SDR37_RXTIME_MASK);
-	obss_time = mt76_get_field(dev, MT_WF_RMAC_MIB_AIRTIME14(idx),
-				   MT_MIB_OBSSTIME_MASK);
-
-	nf = mt7921_phy_get_nf(phy, idx);
-	if (!phy->noise)
-		phy->noise = nf << 4;
-	else if (nf)
-		phy->noise += nf - (phy->noise >> 4);
-
-	state = mphy->chan_state;
-	state->cc_busy += busy_time;
-	state->cc_tx += tx_time;
-	state->cc_rx += rx_time + obss_time;
-	state->cc_bss_rx += rx_time;
-	state->noise = -(phy->noise >> 4);
-}
-
-void mt7921_update_channel(struct mt76_phy *mphy)
-{
-	struct mt792x_dev *dev = container_of(mphy->dev, struct mt792x_dev, mt76);
-
-	if (mt76_connac_pm_wake(mphy, &dev->pm))
-		return;
-
-	mt7921_phy_update_channel(mphy, 0);
-	/* reset obss airtime */
-	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
-
-	mt76_connac_power_save_sched(mphy, &dev->pm);
-}
-EXPORT_SYMBOL_GPL(mt7921_update_channel);
-
 static void
 mt7921_vif_connect_iter(void *priv, u8 *mac,
 			struct ieee80211_vif *vif)
@@ -843,24 +699,6 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
 }
 
-void mt7921_reset(struct mt76_dev *mdev)
-{
-	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
-	struct mt76_connac_pm *pm = &dev->pm;
-
-	if (!dev->hw_init_done)
-		return;
-
-	if (dev->hw_full_reset)
-		return;
-
-	if (pm->suspended)
-		return;
-
-	queue_work(dev->mt76.wq, &dev->reset_work);
-}
-EXPORT_SYMBOL_GPL(mt7921_reset);
-
 void mt7921_pm_wake_work(struct work_struct *work)
 {
 	struct mt792x_dev *dev;
@@ -975,7 +813,7 @@ void mt7921_coredump_work(struct work_struct *work)
 		dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
 			      GFP_KERNEL);
 
-	mt7921_reset(&dev->mt76);
+	mt792x_reset(&dev->mt76);
 }
 
 /* usb_sdio */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 223968807516..73f29fed216f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -240,7 +240,7 @@ int __mt7921_start(struct mt792x_phy *phy)
 	if (err)
 		return err;
 
-	mt7921_mac_reset_counters(phy);
+	mt792x_mac_reset_counters(phy);
 	set_bit(MT76_STATE_RUNNING, &mphy->state);
 
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
@@ -454,7 +454,7 @@ static int mt7921_set_channel(struct mt792x_phy *phy)
 
 	mt792x_mac_set_timeing(phy);
 
-	mt7921_mac_reset_counters(phy);
+	mt792x_mac_reset_counters(phy);
 	phy->noise = 0;
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 3dd9ff5e466b..ed02fa48841c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -25,7 +25,7 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (!skb) {
 		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
 			cmd, seq);
-		mt7921_reset(mdev);
+		mt792x_reset(mdev);
 
 		return -ETIMEDOUT;
 	}
@@ -958,7 +958,7 @@ int mt7921_mcu_drv_pmctrl(struct mt792x_dev *dev)
 	mutex_unlock(&pm->mutex);
 
 	if (err)
-		mt7921_reset(&dev->mt76);
+		mt792x_reset(&dev->mt76);
 
 	return err;
 }
@@ -980,7 +980,7 @@ int mt7921_mcu_fw_pmctrl(struct mt792x_dev *dev)
 	mutex_unlock(&pm->mutex);
 
 	if (err)
-		mt7921_reset(&dev->mt76);
+		mt792x_reset(&dev->mt76);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 4722952bb846..31fa51b8695e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -282,7 +282,6 @@ mt7921_skb_add_usb_sdio_hdr(struct mt792x_dev *dev, struct sk_buff *skb,
 
 void mt7921_stop(struct ieee80211_hw *hw);
 int mt7921_mac_init(struct mt792x_dev *dev);
-void mt7921_mac_reset_counters(struct mt792x_phy *phy);
 bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
@@ -291,7 +290,6 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7921_mac_reset_work(struct work_struct *work);
-void mt7921_reset(struct mt76_dev *mdev);
 int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			   struct ieee80211_sta *sta,
@@ -302,7 +300,6 @@ void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
 void mt7921_stats_work(struct work_struct *work);
 void mt7921_set_stream_he_caps(struct mt792x_phy *phy);
-void mt7921_update_channel(struct mt76_phy *mphy);
 int mt7921_init_debugfs(struct mt792x_dev *dev);
 
 int mt7921_mcu_set_beacon_filter(struct mt792x_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 4227b5028a6f..67eaa6232a02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -245,7 +245,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.sta_add = mt7921_mac_sta_add,
 		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
-		.update_survey = mt7921_update_channel,
+		.update_survey = mt792x_update_channel,
 	};
 	static const struct mt792x_hif_ops mt7921_pcie_ops = {
 		.init_reset = mt7921e_init_reset,
@@ -450,7 +450,7 @@ static int mt7921_pci_suspend(struct device *device)
 	pm->suspended = false;
 
 	if (err < 0)
-		mt7921_reset(&dev->mt76);
+		mt792x_reset(&dev->mt76);
 
 	return err;
 }
@@ -500,7 +500,7 @@ static int mt7921_pci_resume(struct device *device)
 	pm->suspended = false;
 
 	if (err < 0)
-		mt7921_reset(&dev->mt76);
+		mt792x_reset(&dev->mt76);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index b438947c2bd8..f0117ac34594 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -102,7 +102,7 @@ static int mt7921s_probe(struct sdio_func *func,
 		.sta_add = mt7921_mac_sta_add,
 		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
-		.update_survey = mt7921_update_channel,
+		.update_survey = mt792x_update_channel,
 	};
 	static const struct mt76_bus_ops mt7921s_ops = {
 		.rr = mt76s_rr,
@@ -269,7 +269,7 @@ static int mt7921s_suspend(struct device *__dev)
 	pm->suspended = false;
 
 	if (err < 0)
-		mt7921_reset(&dev->mt76);
+		mt792x_reset(&dev->mt76);
 
 	return err;
 }
@@ -302,7 +302,7 @@ static int mt7921s_resume(struct device *__dev)
 	pm->suspended = false;
 
 	if (err < 0)
-		mt7921_reset(&dev->mt76);
+		mt792x_reset(&dev->mt76);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 9d54be3d3d03..3bf902cacd28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -189,7 +189,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 		.sta_add = mt7921_mac_sta_add,
 		.sta_assoc = mt7921_mac_sta_assoc,
 		.sta_remove = mt7921_mac_sta_remove,
-		.update_survey = mt7921_update_channel,
+		.update_survey = mt792x_update_channel,
 	};
 	static const struct mt792x_hif_ops hif_ops = {
 		.mcu_init = mt7921u_mcu_init,
@@ -322,7 +322,7 @@ static int mt7921u_suspend(struct usb_interface *intf, pm_message_t state)
 	pm->suspended = false;
 
 	if (err < 0)
-		mt7921_reset(&dev->mt76);
+		mt792x_reset(&dev->mt76);
 
 	return err;
 }
@@ -364,7 +364,7 @@ static int mt7921u_resume(struct usb_interface *intf)
 	pm->suspended = false;
 
 	if (err < 0)
-		mt7921_reset(&dev->mt76);
+		mt792x_reset(&dev->mt76);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 83236a6c300e..f0f9fb3fd970 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -155,11 +155,31 @@ mt792x_hw_phy(struct ieee80211_hw *hw)
 	return phy->priv;
 }
 
+static inline void
+mt792x_get_status_freq_info(struct mt76_rx_status *status, u8 chfreq)
+{
+	if (chfreq > 180) {
+		status->band = NL80211_BAND_6GHZ;
+		chfreq = (chfreq - 181) * 4 + 1;
+	} else if (chfreq > 14) {
+		status->band = NL80211_BAND_5GHZ;
+	} else {
+		status->band = NL80211_BAND_2GHZ;
+	}
+	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
+}
+
 #define mt792x_mutex_acquire(dev)	\
 	mt76_connac_mutex_acquire(&(dev)->mt76, &(dev)->pm)
 #define mt792x_mutex_release(dev)	\
 	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
 
+void mt792x_reset(struct mt76_dev *mdev);
+void mt792x_update_channel(struct mt76_phy *mphy);
+void mt792x_mac_reset_counters(struct mt792x_phy *phy);
+void mt792x_mac_assoc_rssi(struct mt792x_dev *dev, struct sk_buff *skb);
+struct mt76_wcid *mt792x_rx_get_wcid(struct mt792x_dev *dev, u16 idx,
+				     bool unicast);
 void mt792x_mac_update_mib_stats(struct mt792x_phy *phy);
 void mt792x_mac_set_timeing(struct mt792x_phy *phy);
 void mt792x_mac_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 862cca816aae..130b4352cf92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -134,3 +134,151 @@ void mt792x_mac_update_mib_stats(struct mt792x_phy *phy)
 	}
 }
 EXPORT_SYMBOL_GPL(mt792x_mac_update_mib_stats);
+
+struct mt76_wcid *mt792x_rx_get_wcid(struct mt792x_dev *dev, u16 idx,
+				     bool unicast)
+{
+	struct mt792x_sta *sta;
+	struct mt76_wcid *wcid;
+
+	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
+		return NULL;
+
+	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	if (unicast || !wcid)
+		return wcid;
+
+	if (!wcid->sta)
+		return NULL;
+
+	sta = container_of(wcid, struct mt792x_sta, wcid);
+	if (!sta->vif)
+		return NULL;
+
+	return &sta->vif->sta.wcid;
+}
+EXPORT_SYMBOL_GPL(mt792x_rx_get_wcid);
+
+static void
+mt792x_mac_rssi_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct sk_buff *skb = priv;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+
+	if (status->signal > 0)
+		return;
+
+	if (!ether_addr_equal(vif->addr, hdr->addr1))
+		return;
+
+	ewma_rssi_add(&mvif->rssi, -status->signal);
+}
+
+void mt792x_mac_assoc_rssi(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = mt76_skb_get_hdr(skb);
+
+	if (!ieee80211_is_assoc_resp(hdr->frame_control) &&
+	    !ieee80211_is_auth(hdr->frame_control))
+		return;
+
+	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		mt792x_mac_rssi_iter, skb);
+}
+EXPORT_SYMBOL_GPL(mt792x_mac_assoc_rssi);
+
+void mt792x_mac_reset_counters(struct mt792x_phy *phy)
+{
+	struct mt792x_dev *dev = phy->dev;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		mt76_rr(dev, MT_TX_AGG_CNT(0, i));
+		mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
+	}
+
+	dev->mt76.phy.survey_time = ktime_get_boottime();
+	memset(phy->mt76->aggr_stats, 0, sizeof(phy->mt76->aggr_stats));
+
+	/* reset airtime counters */
+	mt76_rr(dev, MT_MIB_SDR9(0));
+	mt76_rr(dev, MT_MIB_SDR36(0));
+	mt76_rr(dev, MT_MIB_SDR37(0));
+
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+}
+EXPORT_SYMBOL_GPL(mt792x_mac_reset_counters);
+
+static u8
+mt792x_phy_get_nf(struct mt792x_phy *phy, int idx)
+{
+	return 0;
+}
+
+static void
+mt792x_phy_update_channel(struct mt76_phy *mphy, int idx)
+{
+	struct mt792x_dev *dev = container_of(mphy->dev, struct mt792x_dev, mt76);
+	struct mt792x_phy *phy = (struct mt792x_phy *)mphy->priv;
+	struct mt76_channel_state *state;
+	u64 busy_time, tx_time, rx_time, obss_time;
+	int nf;
+
+	busy_time = mt76_get_field(dev, MT_MIB_SDR9(idx),
+				   MT_MIB_SDR9_BUSY_MASK);
+	tx_time = mt76_get_field(dev, MT_MIB_SDR36(idx),
+				 MT_MIB_SDR36_TXTIME_MASK);
+	rx_time = mt76_get_field(dev, MT_MIB_SDR37(idx),
+				 MT_MIB_SDR37_RXTIME_MASK);
+	obss_time = mt76_get_field(dev, MT_WF_RMAC_MIB_AIRTIME14(idx),
+				   MT_MIB_OBSSTIME_MASK);
+
+	nf = mt792x_phy_get_nf(phy, idx);
+	if (!phy->noise)
+		phy->noise = nf << 4;
+	else if (nf)
+		phy->noise += nf - (phy->noise >> 4);
+
+	state = mphy->chan_state;
+	state->cc_busy += busy_time;
+	state->cc_tx += tx_time;
+	state->cc_rx += rx_time + obss_time;
+	state->cc_bss_rx += rx_time;
+	state->noise = -(phy->noise >> 4);
+}
+
+void mt792x_update_channel(struct mt76_phy *mphy)
+{
+	struct mt792x_dev *dev = container_of(mphy->dev, struct mt792x_dev, mt76);
+
+	if (mt76_connac_pm_wake(mphy, &dev->pm))
+		return;
+
+	mt792x_phy_update_channel(mphy, 0);
+	/* reset obss airtime */
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+	mt76_connac_power_save_sched(mphy, &dev->pm);
+}
+EXPORT_SYMBOL_GPL(mt792x_update_channel);
+
+void mt792x_reset(struct mt76_dev *mdev)
+{
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	if (!dev->hw_init_done)
+		return;
+
+	if (dev->hw_full_reset)
+		return;
+
+	if (pm->suspended)
+		return;
+
+	queue_work(dev->mt76.wq, &dev->reset_work);
+}
+EXPORT_SYMBOL_GPL(mt792x_reset);
-- 
2.18.0

