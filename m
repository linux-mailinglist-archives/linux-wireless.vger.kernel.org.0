Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686D230644D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 20:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbhA0Tmp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 14:42:45 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43373 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344605AbhA0Thf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 14:37:35 -0500
X-UUID: 29b27a51330646d4a7add4973985bbe7-20210128
X-UUID: 29b27a51330646d4a7add4973985bbe7-20210128
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2034605012; Thu, 28 Jan 2021 03:34:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 03:34:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 03:34:01 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v8 16/20] mt76: mt7921: introduce Runtime PM support
Date:   Thu, 28 Jan 2021 03:33:53 +0800
Message-ID: <f5bb3f5a1b50c6ab515de00e0d7b9732cd252a9d.1611774181.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1611774181.git.objelf@gmail.com>
References: <cover.1611774181.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce runtime PM to mt7921 driver

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  57 +++++++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   7 +
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  98 ++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 157 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  69 ++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  21 ++-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  12 ++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |   5 +
 8 files changed, 372 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 9cdeb14cc933..390e0e49724d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -159,6 +159,60 @@ mt7921_queues_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+static int
+mt7921_pm_set(void *data, u64 val)
+{
+	struct mt7921_dev *dev = data;
+	struct mt76_phy *mphy = dev->phy.mt76;
+	int ret = 0;
+
+	mt7921_mutex_acquire(dev);
+
+	dev->pm.enable = val;
+
+	ieee80211_iterate_active_interfaces(mphy->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7921_pm_interface_iter, mphy->priv);
+	mt7921_mutex_release(dev);
+
+	return ret;
+}
+
+static int
+mt7921_pm_get(void *data, u64 *val)
+{
+	struct mt7921_dev *dev = data;
+
+	*val = dev->pm.enable;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_pm, mt7921_pm_get, mt7921_pm_set, "%lld\n");
+
+static int
+mt7921_pm_idle_timeout_set(void *data, u64 val)
+{
+	struct mt7921_dev *dev = data;
+
+	dev->pm.idle_timeout = msecs_to_jiffies(val);
+
+	return 0;
+}
+
+static int
+mt7921_pm_idle_timeout_get(void *data, u64 *val)
+{
+	struct mt7921_dev *dev = data;
+
+	*val = jiffies_to_msecs(dev->pm.idle_timeout);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_pm_idle_timeout, mt7921_pm_idle_timeout_get,
+			 mt7921_pm_idle_timeout_set, "%lld\n");
+
 int mt7921_init_debugfs(struct mt7921_dev *dev)
 {
 	struct dentry *dir;
@@ -173,6 +227,9 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
 				    mt7921_queues_acq);
 	debugfs_create_file("tx_stats", 0400, dir, dev, &fops_tx_stats);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
+	debugfs_create_file("runtime-pm", 0600, dir, dev, &fops_pm);
+	debugfs_create_file("idle-timeout", 0600, dir, dev,
+			    &fops_pm_idle_timeout);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 04fc69de7369..efc3e94f89d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -201,6 +201,12 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
 	dev->mt76.phy.priv = &dev->phy;
+
+	INIT_DELAYED_WORK(&dev->pm.ps_work, mt7921_pm_power_save_work);
+	INIT_WORK(&dev->pm.wake_work, mt7921_pm_wake_work);
+	init_completion(&dev->pm.wake_cmpl);
+	spin_lock_init(&dev->pm.txq_lock);
+	set_bit(MT76_STATE_PM, &dev->mphy.state);
 	INIT_LIST_HEAD(&dev->phy.stats_list);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7921_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7921_scan_work);
@@ -216,6 +222,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 		return ret;
 
 	mt7921_init_wiphy(hw);
+	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
 	dev->mphy.sband_2g.sband.ht_cap.cap |=
 			IEEE80211_HT_CAP_LDPC_CODING |
 			IEEE80211_HT_CAP_MAX_AMSDU;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 968894cfc98b..006cf7fe1bff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1001,22 +1001,27 @@ void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 		mt76_put_txwi(mdev, txwi);
 	}
 
-	mt7921_mac_sta_poll(dev);
-
 	if (wake) {
 		spin_lock_bh(&dev->token_lock);
 		mt7921_set_tx_blocked(dev, false);
 		spin_unlock_bh(&dev->token_lock);
 	}
 
-	mt76_worker_schedule(&dev->mt76.tx_worker);
-
 	napi_consume_skb(skb, 1);
 
 	list_for_each_entry_safe(skb, tmp, &free_list, list) {
 		skb_list_del_init(skb);
 		napi_consume_skb(skb, 1);
 	}
+
+	if (test_bit(MT76_STATE_PM, &dev->phy.mt76->state))
+		return;
+
+	mt7921_mac_sta_poll(dev);
+
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+
+	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
 void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
@@ -1166,9 +1171,14 @@ void mt7921_update_channel(struct mt76_dev *mdev)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 
+	if (mt76_connac_pm_wake(&dev->mphy, &dev->pm))
+		return;
+
 	mt7921_phy_update_channel(&mdev->phy, 0);
 	/* reset obss airtime */
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
 
 static bool
@@ -1257,7 +1267,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	napi_disable(&dev->mt76.napi[2]);
 	napi_disable(&dev->mt76.tx_napi);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
@@ -1292,7 +1302,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
 	mt7921_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT7921_WATCHDOG_TIME);
@@ -1373,7 +1383,10 @@ void mt7921_mac_work(struct work_struct *work)
 					       mac_work.work);
 	phy = mphy->priv;
 
-	mutex_lock(&mphy->dev->mutex);
+	if (test_bit(MT76_STATE_PM, &mphy->state))
+		goto out;
+
+	mt7921_mutex_acquire(phy->dev);
 
 	mt76_update_survey(mphy->dev);
 	if (++mphy->mac_work_count == 5) {
@@ -1386,8 +1399,75 @@ void mt7921_mac_work(struct work_struct *work)
 		mt7921_mac_sta_stats_work(phy);
 	};
 
-	mutex_unlock(&mphy->dev->mutex);
+	mt7921_mutex_release(phy->dev);
 
-	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+out:
+	ieee80211_queue_delayed_work(phy->mt76->hw, &mphy->mac_work,
 				     MT7921_WATCHDOG_TIME);
 }
+
+void mt7921_pm_wake_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev;
+	struct mt76_phy *mphy;
+
+	dev = (struct mt7921_dev *)container_of(work, struct mt7921_dev,
+						pm.wake_work);
+	mphy = dev->phy.mt76;
+
+	if (!mt7921_mcu_drv_pmctrl(dev))
+		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
+	else
+		dev_err(mphy->dev->dev, "failed to wake device\n");
+
+	ieee80211_wake_queues(mphy->hw);
+	complete_all(&dev->pm.wake_cmpl);
+}
+
+void mt7921_pm_power_save_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev;
+	unsigned long delta;
+
+	dev = (struct mt7921_dev *)container_of(work, struct mt7921_dev,
+						pm.ps_work.work);
+
+	delta = dev->pm.idle_timeout;
+	if (time_is_after_jiffies(dev->pm.last_activity + delta)) {
+		delta = dev->pm.last_activity + delta - jiffies;
+		goto out;
+	}
+
+	if (!mt7921_mcu_fw_pmctrl(dev))
+		return;
+out:
+	queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work, delta);
+}
+
+int mt7921_mac_set_beacon_filter(struct mt7921_phy *phy,
+				 struct ieee80211_vif *vif,
+				 bool enable)
+{
+	struct mt7921_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	int err;
+
+	if (!dev->pm.enable)
+		return -EOPNOTSUPP;
+
+	err = mt7921_mcu_set_bss_pm(dev, vif, enable);
+	if (err)
+		return err;
+
+	if (enable) {
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		mt76_set(dev, MT_WF_RFCR(ext_phy),
+			 MT_WF_RFCR_DROP_OTHER_BEACON);
+	} else {
+		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		mt76_clear(dev, MT_WF_RFCR(ext_phy),
+			   MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 288f0bb9f55e..729f6c42cdde 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -174,7 +174,7 @@ static int mt7921_start(struct ieee80211_hw *hw)
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, true, false);
 	mt76_connac_mcu_set_channel_domain(phy->mt76);
@@ -186,7 +186,7 @@ static int mt7921_start(struct ieee80211_hw *hw)
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7921_WATCHDOG_TIME);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return 0;
 }
@@ -198,10 +198,14 @@ static void mt7921_stop(struct ieee80211_hw *hw)
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
-	mutex_lock(&dev->mt76.mutex);
+	cancel_delayed_work_sync(&dev->pm.ps_work);
+	cancel_work_sync(&dev->pm.wake_work);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	mt7921_mutex_acquire(dev);
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, false, false);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 }
 
 static inline int get_free_idx(u32 mask, u8 start, u8 end)
@@ -264,7 +268,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR &&
 	    is_zero_ether_addr(vif->addr))
@@ -291,6 +295,15 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		goto out;
 
+	if (dev->pm.enable) {
+		ret = mt7921_mcu_set_bss_pm(dev, vif, true);
+		if (ret)
+			goto out;
+
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		mt76_set(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
+
 	dev->mt76.vif_mask |= BIT(mvif->mt76.idx);
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
@@ -318,7 +331,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
 out:
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return ret;
 }
@@ -335,14 +348,22 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 	if (vif == phy->monitor_vif)
 		phy->monitor_vif = NULL;
 
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
+
+	if (dev->pm.enable) {
+		mt7921_mcu_set_bss_pm(dev, vif, false);
+		mt76_clear(dev, MT_WF_RFCR(0),
+			   MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
+
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 	dev->mt76.vif_mask &= ~BIT(mvif->mt76.idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
@@ -357,7 +378,7 @@ int mt7921_set_channel(struct mt7921_phy *phy)
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 	set_bit(MT76_RESET, &phy->mt76->state);
 
 	mt76_set_channel(phy->mt76);
@@ -373,7 +394,7 @@ int mt7921_set_channel(struct mt7921_phy *phy)
 
 out:
 	clear_bit(MT76_RESET, &phy->mt76->state);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	mt76_txq_schedule_all(phy->mt76);
 
@@ -449,7 +470,7 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 		ieee80211_wake_queues(hw);
 	}
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
@@ -464,7 +485,7 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
 	}
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return 0;
 }
@@ -504,7 +525,7 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 		phy->rxfilter |= !(flags & FIF_##_flag) * (_hw);	\
 	} while (0)
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	phy->rxfilter &= ~(MT_WF_RFCR_DROP_OTHER_BSS |
 			   MT_WF_RFCR_DROP_OTHER_BEACON |
@@ -537,7 +558,7 @@ static void mt7921_configure_filter(struct ieee80211_hw *hw,
 	else
 		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 }
 
 static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
@@ -548,7 +569,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		int slottime = info->use_short_slot ? 9 : 20;
@@ -566,7 +587,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_PS)
 		mt7921_mcu_uni_bss_ps(dev, vif);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 }
 
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -590,6 +611,10 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->stats.jiffies = jiffies;
 
+	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
+	if (ret)
+		return ret;
+
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
 					    true);
@@ -602,6 +627,8 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+
 	return 0;
 }
 
@@ -611,8 +638,12 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
 
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
+	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
+
 	mt76_connac_mcu_add_sta_cmd(&dev->mphy, vif, sta, &msta->wcid, false,
 				    MCU_UNI_CMD_STA_REC_UPDATE);
+
 	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
@@ -629,6 +660,27 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (!list_empty(&msta->stats_list))
 		list_del_init(&msta->stats_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
+
+	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+}
+
+static void
+mt7921_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt76_phy *mphy = phy->mt76;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
+		return;
+
+	if (test_bit(MT76_STATE_PM, &mphy->state)) {
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return;
+	}
+
+	dev->pm.last_activity = jiffies;
+	mt76_worker_schedule(&dev->mt76.tx_worker);
 }
 
 static void mt7921_tx(struct ieee80211_hw *hw,
@@ -640,6 +692,7 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	int qid;
 
 	if (control->sta) {
 		struct mt7921_sta *sta;
@@ -655,16 +708,28 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 		wcid = &mvif->sta.wcid;
 	}
 
-	mt76_tx(mphy, control->sta, wcid, skb);
+	if (!test_bit(MT76_STATE_PM, &mphy->state)) {
+		dev->pm.last_activity = jiffies;
+		mt76_tx(mphy, control->sta, wcid, skb);
+		return;
+	}
+
+	qid = skb_get_queue_mapping(skb);
+	if (qid >= MT_TXQ_PSD) {
+		qid = IEEE80211_AC_BE;
+		skb_set_queue_mapping(skb, qid);
+	}
+
+	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
 }
 
 static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 	mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, 0);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return 0;
 }
@@ -688,7 +753,7 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mtxq = (struct mt76_txq *)txq->drv_priv;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
@@ -721,7 +786,7 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return ret;
 }
@@ -771,7 +836,7 @@ mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	} tsf;
 	u16 n;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
 	/* TSF software read */
@@ -779,7 +844,7 @@ mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(band));
 	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(band));
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return tsf.t64;
 }
@@ -799,7 +864,7 @@ mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	} tsf = { .t64 = timestamp, };
 	u16 n;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
 	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
@@ -807,7 +872,7 @@ mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	/* TSF software overwrite */
 	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_WRITE);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 }
 
 static void
@@ -816,10 +881,10 @@ mt7921_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = phy->dev;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 	phy->coverage_class = max_t(s16, coverage_class, 0);
 	mt7921_mac_set_timing(phy);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 }
 
 void mt7921_scan_work(struct work_struct *work)
@@ -863,9 +928,9 @@ mt7921_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 	err = mt76_connac_mcu_hw_scan(mphy, vif, req);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return err;
 }
@@ -876,9 +941,9 @@ mt7921_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 	mt76_connac_mcu_cancel_hw_scan(mphy, vif);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 }
 
 static int
@@ -890,7 +955,7 @@ mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_sched_scan_req(mphy, vif, req);
 	if (err < 0)
@@ -898,7 +963,7 @@ mt7921_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, true);
 out:
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return err;
 }
@@ -910,9 +975,9 @@ mt7921_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct mt76_phy *mphy = hw->priv;
 	int err;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 	err = mt76_connac_mcu_sched_scan_enable(mphy, vif, false);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return err;
 }
@@ -930,7 +995,7 @@ mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
 		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	phy->mt76->antenna_mask = tx_ant;
 	phy->mt76->chainmask = tx_ant;
@@ -938,7 +1003,7 @@ mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	mt76_set_stream_caps(phy->mt76, true);
 	mt7921_set_stream_he_caps(phy);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return 0;
 }
@@ -987,7 +1052,10 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
-	mutex_lock(&dev->mt76.mutex);
+	cancel_delayed_work_sync(&dev->pm.ps_work);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
+
+	mt7921_mutex_acquire(dev);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
@@ -999,7 +1067,7 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 
 	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true);
 
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 
 	return err;
 }
@@ -1010,7 +1078,7 @@ static int mt7921_resume(struct ieee80211_hw *hw)
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	int err;
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
 	if (err < 0)
@@ -1026,7 +1094,8 @@ static int mt7921_resume(struct ieee80211_hw *hw)
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7921_WATCHDOG_TIME);
 out:
-	mutex_unlock(&dev->mt76.mutex);
+
+	mt7921_mutex_release(dev);
 
 	return err;
 }
@@ -1045,9 +1114,9 @@ static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
-	mutex_lock(&dev->mt76.mutex);
+	mt7921_mutex_acquire(dev);
 	mt76_connac_mcu_update_gtk_rekey(hw, vif, data);
-	mutex_unlock(&dev->mt76.mutex);
+	mt7921_mutex_release(dev);
 }
 #endif /* CONFIG_PM */
 
@@ -1068,7 +1137,7 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_key = mt7921_set_key,
 	.ampdu_action = mt7921_ampdu_action,
 	.set_rts_threshold = mt7921_set_rts_threshold,
-	.wake_tx_queue = mt76_wake_tx_queue,
+	.wake_tx_queue = mt7921_wake_tx_queue,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt76_get_txpower,
 	.get_stats = mt7921_get_stats,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index eed65df2ed8b..6ad313fd398e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -896,6 +896,8 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
 #endif /* CONFIG_PM */
 
+	clear_bit(MT76_STATE_PM, &dev->mphy.state);
+
 	dev_err(dev->mt76.dev, "Firmware init done\n");
 
 	return 0;
@@ -1232,3 +1234,70 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED, &req,
 				 sizeof(req), false);
 }
+
+int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	int i;
+
+	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
+		goto out;
+
+	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
+		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
+		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
+				   PCIE_LPCR_HOST_OWN_SYNC, 0, 50))
+			break;
+	}
+
+	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
+		dev_err(dev->mt76.dev, "driver own failed\n");
+		return -EIO;
+	}
+
+out:
+	dev->pm.last_activity = jiffies;
+
+	return 0;
+}
+
+int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	int i;
+
+	if (test_and_set_bit(MT76_STATE_PM, &mphy->state))
+		return 0;
+
+	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
+		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_SET_OWN);
+		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
+				   PCIE_LPCR_HOST_OWN_SYNC, 4, 50))
+			break;
+	}
+
+	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
+		dev_err(dev->mt76.dev, "firmware own failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void
+mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt7921_phy *phy = priv;
+	struct mt7921_dev *dev = phy->dev;
+
+	if (mt7921_mcu_set_bss_pm(dev, vif, dev->pm.enable))
+		return;
+
+	if (dev->pm.enable) {
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+		mt76_set(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
+	} else {
+		vif->driver_flags &= ~IEEE80211_VIF_BEACON_FILTER;
+		mt76_clear(dev, MT_WF_RFCR(0), MT_WF_RFCR_DROP_OTHER_BEACON);
+	}
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 33de0be341bf..c0f26eaa269e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -6,7 +6,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/ktime.h>
-#include "../mt76.h"
+#include "../mt76_connac.h"
 #include "regs.h"
 
 #define MT7921_MAX_INTERFACES		4
@@ -16,6 +16,7 @@
 #define MT7921_WTBL_STA			(MT7921_WTBL_RESERVED - \
 					 MT7921_MAX_INTERFACES)
 
+#define MT7921_PM_TIMEOUT		(HZ / 12)
 #define MT7921_HW_SCAN_TIMEOUT		(HZ / 10)
 #define MT7921_WATCHDOG_TIME		(HZ / 10)
 #define MT7921_RESET_TIMEOUT		(30 * HZ)
@@ -27,6 +28,8 @@
 #define MT7921_RX_RING_SIZE		1536
 #define MT7921_RX_MCU_RING_SIZE		512
 
+#define MT7921_DRV_OWN_RETRY_COUNT	10
+
 #define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
 
@@ -159,6 +162,8 @@ struct mt7921_dev {
 	struct idr token;
 
 	u8 fw_debug;
+
+	struct mt76_connac_pm pm;
 };
 
 enum {
@@ -187,6 +192,11 @@ mt7921_hw_dev(struct ieee80211_hw *hw)
 	return container_of(phy->dev, struct mt7921_dev, mt76);
 }
 
+#define mt7921_mutex_acquire(dev)	\
+	mt76_connac_mutex_acquire(&(dev)->mt76, &(dev)->pm)
+#define mt7921_mutex_release(dev)	\
+	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
+
 static inline u8 mt7921_lmac_mapping(struct mt7921_dev *dev, u8 ac)
 {
 	/* LMAC uses the reverse order of mac80211 AC indexes */
@@ -318,4 +328,13 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 int mt7921_mcu_update_arp_filter(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *info);
+int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
+int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
+void mt7921_pm_wake_work(struct work_struct *work);
+void mt7921_pm_power_save_work(struct work_struct *work);
+bool mt7921_wait_for_mcu_init(struct mt7921_dev *dev);
+int mt7921_mac_set_beacon_filter(struct mt7921_phy *phy,
+				 struct ieee80211_vif *vif,
+				 bool enable);
+void mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ff5fbc1e23aa..5f28e00bba45 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -176,6 +176,10 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	bool hif_suspend;
 	int i, err;
 
+	err = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
+	if (err < 0)
+		return err;
+
 	hif_suspend = !test_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
 	if (hif_suspend) {
 		err = mt76_connac_mcu_set_hif_suspend(mdev, true);
@@ -210,6 +214,10 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	if (err)
 		goto restore;
 
+	err = mt7921_mcu_drv_pmctrl(dev);
+	if (err)
+		goto restore;
+
 	return 0;
 
 restore:
@@ -229,6 +237,10 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	int i, err;
 
+	err = mt7921_mcu_fw_pmctrl(dev);
+	if (err < 0)
+		return err;
+
 	err = pci_set_power_state(pdev, PCI_D0);
 	if (err)
 		return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 2071eeec04d7..18980bb32dee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -408,6 +408,11 @@
 
 #define MT_DMASHDL_SCHED_SET(_n)	MT_DMA_SHDL(0x070 + ((_n) << 2))
 
+#define MT_CONN_ON_LPCTL		0x7c060010
+#define PCIE_LPCR_HOST_OWN_SYNC		BIT(2)
+#define PCIE_LPCR_HOST_CLR_OWN		BIT(1)
+#define PCIE_LPCR_HOST_SET_OWN		BIT(0)
+
 #define MT_CONN_ON_MISC			0x7c0600f0
 #define MT_TOP_MISC2_FW_N9_RDY		GENMASK(1, 0)
 
-- 
2.25.1

