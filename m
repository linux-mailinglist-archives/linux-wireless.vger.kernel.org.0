Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BDD7409E3
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjF1Hwq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50256 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230428AbjF1Hwc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:32 -0400
X-UUID: 6a10dcee158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6W20mET5aDc0SA/UqzSO2SKxnGxj9YptieDWuLUDIn0=;
        b=j86bK2/jiQPkCrIRXR1nQSopL+Jn+uok3tGWzf3S22w8afd19xvQqKUY72SKbZgVaHu/02UKlx3tsVaj/Dl3iLKfLrXa5FwvpPDBsqW7bQoASZk/AOsFG7/ONoP3LFR3ZOFhbHjG2WeRqCJC7NwDy/ncMSRoTY/Nd+palxLWxC0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:11927846-6b38-457d-9ad5-dad83e2f576c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.27,REQID:11927846-6b38-457d-9ad5-dad83e2f576c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:01c9525,CLOUDID:ba7b9b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:2306281507179UEDRAEZ,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: 6a10dcee158211eeb20a276fd37b9834-20230628
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1238394099; Wed, 28 Jun 2023 15:07:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
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
Subject: [PATCH 09/16] wifi: mt76: mt7921: move mt792x_mutex_{acquire/release} in mt792x.h
Date:   Wed, 28 Jun 2023 15:05:55 +0800
Message-ID: <27a2b80edda9df4e845610d39c35814f9443d14d.1687919628.git.deren.wu@mediatek.com>
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

This is a preliminary patch to introduce WiFi7 chipset support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  32 ++--
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   8 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  12 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 144 +++++++++---------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   5 -
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   5 +
 6 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 6137a10c022a..0c94fa7ae485 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -8,9 +8,9 @@ mt7921_reg_set(void *data, u64 val)
 {
 	struct mt792x_dev *dev = data;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	mt76_wr(dev, dev->mt76.debugfs_reg, val);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return 0;
 }
@@ -20,9 +20,9 @@ mt7921_reg_get(void *data, u64 *val)
 {
 	struct mt792x_dev *dev = data;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	*val = mt76_rr(dev, dev->mt76.debugfs_reg);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return 0;
 }
@@ -34,12 +34,12 @@ mt7921_fw_debug_set(void *data, u64 val)
 {
 	struct mt792x_dev *dev = data;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	dev->fw_debug = (u8)val;
 	mt7921_mcu_fw_log_2_host(dev, dev->fw_debug);
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return 0;
 }
@@ -98,7 +98,7 @@ mt7921_tx_stats_show(struct seq_file *file, void *data)
 	struct mt76_mib_stats *mib = &phy->mib;
 	int i;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	mt7921_ampdu_stat_read_phy(phy, file);
 
@@ -113,7 +113,7 @@ mt7921_tx_stats_show(struct seq_file *file, void *data)
 			seq_puts(file, "\n");
 	}
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return 0;
 }
@@ -126,7 +126,7 @@ mt7921_queues_acq(struct seq_file *s, void *data)
 	struct mt792x_dev *dev = dev_get_drvdata(s->private);
 	int i;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	for (i = 0; i < 4; i++) {
 		u32 ctrl, val, qlen = 0;
@@ -146,7 +146,7 @@ mt7921_queues_acq(struct seq_file *s, void *data)
 		seq_printf(s, "AC%d: queued=%d\n", i, qlen);
 	}
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return 0;
 }
@@ -215,9 +215,9 @@ mt7921_txpwr(struct seq_file *s, void *data)
 	struct mt7921_txpwr txpwr;
 	int ret;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	ret = mt7921_get_txpwr_info(dev, &txpwr);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	if (ret)
 		return ret;
@@ -316,7 +316,7 @@ mt7921_deep_sleep_set(void *data, u64 val)
 	if (mt76_is_usb(&dev->mt76))
 		return -EOPNOTSUPP;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	if (pm->ds_enable_user == enable)
 		goto out;
 
@@ -324,7 +324,7 @@ mt7921_deep_sleep_set(void *data, u64 val)
 	pm->ds_enable = enable && !monitor;
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 out:
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return 0;
 }
@@ -400,9 +400,9 @@ static int mt7921_chip_reset(void *data, u64 val)
 		break;
 	default:
 		/* Collect the core dump before reset wifisys. */
-		mt7921_mutex_acquire(dev);
+		mt792x_mutex_acquire(dev);
 		ret = mt76_connac_mcu_chip_config(&dev->mt76);
-		mt7921_mutex_release(dev);
+		mt792x_mutex_release(dev);
 		break;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index bace86813b76..100479c2e9f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -64,9 +64,9 @@ static ssize_t mt7921_thermal_temp_show(struct device *dev,
 		struct mt792x_dev *mdev = phy->dev;
 		int temperature;
 
-		mt7921_mutex_acquire(mdev);
+		mt792x_mutex_acquire(mdev);
 		temperature = mt7921_mcu_get_temperature(phy);
-		mt7921_mutex_release(mdev);
+		mt792x_mutex_release(mdev);
 
 		if (temperature < 0)
 			return temperature;
@@ -116,11 +116,11 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 	dev->mt76.region = request->dfs_region;
 	dev->country_ie_env = request->country_ie_env;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	mt7921_mcu_set_clc(dev, request->alpha2, request->country_ie_env);
 	mt76_connac_mcu_set_channel_domain(hw->priv);
 	mt7921_set_tx_sar_pwr(hw, NULL);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index a17d70aa90da..49ba23ecf495 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -971,7 +971,7 @@ void mt7921_mac_work(struct work_struct *work)
 					       mac_work.work);
 	phy = mphy->priv;
 
-	mt7921_mutex_acquire(phy->dev);
+	mt792x_mutex_acquire(phy->dev);
 
 	mt76_update_survey(mphy);
 	if (++mphy->mac_work_count == 2) {
@@ -980,7 +980,7 @@ void mt7921_mac_work(struct work_struct *work)
 		mt7921_mac_update_mib_stats(phy);
 	}
 
-	mt7921_mutex_release(phy->dev);
+	mt792x_mutex_release(phy->dev);
 
 	mt76_tx_status_check(mphy->dev, false);
 	ieee80211_queue_delayed_work(phy->mt76->hw, &mphy->mac_work,
@@ -1191,9 +1191,9 @@ bool mt7921_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	mt7921_mac_sta_poll(dev);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return false;
 }
@@ -1213,10 +1213,10 @@ void mt7921_set_ipv6_ns_work(struct work_struct *work)
 		if (!skb)
 			break;
 
-		mt7921_mutex_acquire(dev);
+		mt792x_mutex_acquire(dev);
 		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
 					    MCU_UNI_CMD(OFFLOAD), true);
-		mt7921_mutex_release(dev);
+		mt792x_mutex_release(dev);
 
 	} while (!ret);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2f597fb3ae5c..2cd85fdd15f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -255,9 +255,9 @@ static int mt7921_start(struct ieee80211_hw *hw)
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int err;
 
-	mt7921_mutex_acquire(phy->dev);
+	mt792x_mutex_acquire(phy->dev);
 	err = __mt7921_start(phy);
-	mt7921_mutex_release(phy->dev);
+	mt792x_mutex_release(phy->dev);
 
 	return err;
 }
@@ -274,10 +274,10 @@ void mt7921_stop(struct ieee80211_hw *hw)
 	cancel_work_sync(&dev->reset_work);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, false, false);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 EXPORT_SYMBOL_GPL(mt7921_stop);
 
@@ -290,7 +290,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
 	if (mvif->mt76.idx >= MT7921_MAX_INTERFACES) {
@@ -333,7 +333,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 
 	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
 out:
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return ret;
 }
@@ -347,7 +347,7 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, false);
 
@@ -355,7 +355,7 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 
 	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta->wcid.poll_list))
@@ -384,11 +384,11 @@ void mt7921_roc_work(struct work_struct *work)
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return;
 
-	mt7921_mutex_acquire(phy->dev);
+	mt792x_mutex_acquire(phy->dev);
 	ieee80211_iterate_active_interfaces(phy->mt76->hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_roc_iter, phy);
-	mt7921_mutex_release(phy->dev);
+	mt792x_mutex_release(phy->dev);
 	ieee80211_remain_on_channel_expired(phy->mt76->hw);
 }
 
@@ -406,10 +406,10 @@ static int mt7921_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif)
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
-	mt7921_mutex_acquire(phy->dev);
+	mt792x_mutex_acquire(phy->dev);
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		err = mt7921_mcu_abort_roc(phy, vif, phy->roc_token_id);
-	mt7921_mutex_release(phy->dev);
+	mt792x_mutex_release(phy->dev);
 
 	return err;
 }
@@ -454,9 +454,9 @@ static int mt7921_remain_on_channel(struct ieee80211_hw *hw,
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	int err;
 
-	mt7921_mutex_acquire(phy->dev);
+	mt792x_mutex_acquire(phy->dev);
 	err = mt7921_set_roc(phy, mvif, chan, duration, MT7921_ROC_REQ_ROC);
-	mt7921_mutex_release(phy->dev);
+	mt792x_mutex_release(phy->dev);
 
 	return err;
 }
@@ -477,7 +477,7 @@ static int mt7921_set_channel(struct mt792x_phy *phy)
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	set_bit(MT76_RESET, &phy->mt76->state);
 
 	mt76_set_channel(phy->mt76);
@@ -493,7 +493,7 @@ static int mt7921_set_channel(struct mt792x_phy *phy)
 
 out:
 	clear_bit(MT76_RESET, &phy->mt76->state);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mt76->mac_work,
@@ -546,7 +546,7 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return -EOPNOTSUPP;
 	}
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	if (cmd == SET_KEY) {
 		*wcid_keyidx = idx;
@@ -570,7 +570,7 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 					      key, MCU_UNI_CMD(STA_REC_UPDATE),
 					      &mvif->wep_sta->wcid, cmd);
 out:
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return err;
 }
@@ -642,7 +642,7 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 		ieee80211_wake_queues(hw);
 	}
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
 		ret = mt7921_set_tx_sar_pwr(hw, NULL);
@@ -657,7 +657,7 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 out:
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return ret;
 }
@@ -698,9 +698,9 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 	MT7921_FILTER(FIF_CONTROL, CONTROL);
 	MT7921_FILTER(FIF_OTHER_BSS, OTHER_BSS);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	mt7921_mcu_set_rxfilter(dev, flags, 0, 0);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	*total_flags &= (FIF_OTHER_BSS | FIF_FCSFAIL | FIF_CONTROL);
 }
@@ -713,7 +713,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		int slottime = info->use_short_slot ? 9 : 20;
@@ -749,7 +749,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 						  info);
 	}
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -800,7 +800,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
@@ -814,7 +814,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	mt7921_mcu_sta_update(dev, sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_assoc);
 
@@ -909,9 +909,9 @@ static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, 0);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return 0;
 }
@@ -935,7 +935,7 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mtxq = (struct mt76_txq *)txq->drv_priv;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
@@ -968,7 +968,7 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return ret;
 }
@@ -982,9 +982,9 @@ static int mt7921_sta_state(struct ieee80211_hw *hw,
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
 	if (dev->pm.ds_enable) {
-		mt7921_mutex_acquire(dev);
+		mt792x_mutex_acquire(dev);
 		mt76_connac_sta_state_dp(&dev->mt76, old_state, new_state);
-		mt7921_mutex_release(dev);
+		mt792x_mutex_release(dev);
 	}
 
 	return mt76_sta_state(hw, vif, sta, old_state, new_state);
@@ -997,14 +997,14 @@ mt7921_get_stats(struct ieee80211_hw *hw,
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt76_mib_stats *mib = &phy->mib;
 
-	mt7921_mutex_acquire(phy->dev);
+	mt792x_mutex_acquire(phy->dev);
 
 	stats->dot11RTSSuccessCount = mib->rts_cnt;
 	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
 	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
 	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
 
-	mt7921_mutex_release(phy->dev);
+	mt792x_mutex_release(phy->dev);
 
 	return 0;
 }
@@ -1144,7 +1144,7 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	};
 	int i, ei = 0;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	mt7921_mac_update_mib_stats(phy);
 
@@ -1184,7 +1184,7 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	wi.initial_stat_idx = ei;
 	ieee80211_iterate_stations_atomic(hw, mt7921_ethtool_worker, &wi);
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	if (!wi.sta_count)
 		return;
@@ -1212,7 +1212,7 @@ mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	} tsf;
 	u16 n;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
 	/* TSF software read */
@@ -1220,7 +1220,7 @@ mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(0));
 	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(0));
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return tsf.t64;
 }
@@ -1238,7 +1238,7 @@ mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	} tsf = { .t64 = timestamp, };
 	u16 n;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
 	mt76_wr(dev, MT_LPON_UTTR0(0), tsf.t32[0]);
@@ -1246,7 +1246,7 @@ mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	/* TSF software overwrite */
 	mt76_set(dev, MT_LPON_TCR(0, n), MT_LPON_TCR_SW_WRITE);
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 
 static void
@@ -1255,10 +1255,10 @@ mt7921_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 	struct mt792x_dev *dev = phy->dev;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	phy->coverage_class = max_t(s16, coverage_class, 0);
 	mt7921_mac_set_timing(phy);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 
 void mt7921_scan_work(struct work_struct *work)
@@ -1302,9 +1302,9 @@ mt7921_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	err = mt76_connac_mcu_hw_scan(mphy, vif, req);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return err;
 }
@@ -1315,9 +1315,9 @@ mt7921_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	mt76_connac_mcu_cancel_hw_scan(mphy, vif);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 
 static int
@@ -1329,7 +1329,7 @@ mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_sched_scan_req(mphy, vif, req);
 	if (err < 0)
@@ -1337,7 +1337,7 @@ mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, true);
 out:
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return err;
 }
@@ -1349,9 +1349,9 @@ mt7921_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, false);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return err;
 }
@@ -1369,7 +1369,7 @@ mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
 		return -EINVAL;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	phy->mt76->antenna_mask = tx_ant;
 	phy->mt76->chainmask = tx_ant;
@@ -1377,7 +1377,7 @@ mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7921_set_stream_he_caps(phy);
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return 0;
 }
@@ -1432,7 +1432,7 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&dev->pm.ps_work);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
@@ -1440,7 +1440,7 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 					    mt7921_mcu_set_suspend_iter,
 					    &dev->mphy);
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return 0;
 }
@@ -1450,7 +1450,7 @@ static int mt7921_resume(struct ieee80211_hw *hw)
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
@@ -1461,7 +1461,7 @@ static int mt7921_resume(struct ieee80211_hw *hw)
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7921_WATCHDOG_TIME);
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return 0;
 }
@@ -1480,9 +1480,9 @@ static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
 {
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	mt76_connac_mcu_update_gtk_rekey(hw, vif, data);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 #endif /* CONFIG_PM */
 
@@ -1503,7 +1503,7 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	if (enabled)
 		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
@@ -1513,7 +1513,7 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 	mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76, vif, &msta->wcid,
 					     MCU_UNI_CMD(STA_REC_UPDATE));
 
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1601,7 +1601,7 @@ static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	int err;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	err = mt7921_mcu_set_clc(dev, dev->mt76.alpha2,
 				 dev->country_ie_env);
 	if (err < 0)
@@ -1609,7 +1609,7 @@ static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
 
 	err = mt7921_set_tx_sar_pwr(hw, sar);
 out:
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return err;
 }
@@ -1621,9 +1621,9 @@ mt7921_channel_switch_beacon(struct ieee80211_hw *hw,
 {
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	mt7921_mcu_uni_add_beacon_offload(dev, hw, vif, true);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 
 static int
@@ -1635,7 +1635,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	int err;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
 					  true, mvif->ctx);
@@ -1649,7 +1649,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	err = mt7921_mcu_sta_update(dev, NULL, vif, true,
 				    MT76_STA_INFO_STATE_NONE);
 out:
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 
 	return err;
 }
@@ -1663,7 +1663,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = mt7921_hw_dev(hw);
 	int err;
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 
 	err = mt7921_mcu_set_bss_pm(dev, vif, false);
 	if (err)
@@ -1673,7 +1673,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				    mvif->ctx);
 
 out:
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 
 static int
@@ -1711,11 +1711,11 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 {
 	struct mt792x_phy *phy = mt7921_hw_phy(hw);
 
-	mt7921_mutex_acquire(phy->dev);
+	mt792x_mutex_acquire(phy->dev);
 	ieee80211_iterate_active_interfaces(phy->mt76->hw,
 					    IEEE80211_IFACE_ITER_ACTIVE,
 					    mt7921_ctx_iter, ctx);
-	mt7921_mutex_release(phy->dev);
+	mt792x_mutex_release(phy->dev);
 }
 
 static int
@@ -1757,10 +1757,10 @@ static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
 	u16 duration = info->duration ? info->duration :
 		       jiffies_to_msecs(HZ);
 
-	mt7921_mutex_acquire(dev);
+	mt792x_mutex_acquire(dev);
 	mt7921_set_roc(mvif->phy, mvif, mvif->ctx->def.chan, duration,
 		       MT7921_ROC_REQ_JOIN);
-	mt7921_mutex_release(dev);
+	mt792x_mutex_release(dev);
 }
 
 static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index b04d78a5d51a..2ca8560aa523 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -224,11 +224,6 @@ mt7921_hw_dev(struct ieee80211_hw *hw)
 	return container_of(phy->dev, struct mt792x_dev, mt76);
 }
 
-#define mt7921_mutex_acquire(dev)	\
-	mt76_connac_mutex_acquire(&(dev)->mt76, &(dev)->pm)
-#define mt7921_mutex_release(dev)	\
-	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
-
 extern const struct ieee80211_ops mt7921_ops;
 
 u32 mt7921_reg_map(struct mt792x_dev *dev, u32 addr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 2c17c2e71af1..bc7d11acfa6a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -126,4 +126,9 @@ struct mt792x_dev {
 	u32 backup_l2;
 };
 
+#define mt792x_mutex_acquire(dev)	\
+	mt76_connac_mutex_acquire(&(dev)->mt76, &(dev)->pm)
+#define mt792x_mutex_release(dev)	\
+	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
+
 #endif /* __MT7925_H */
-- 
2.18.0

