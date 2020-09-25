Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31AF278074
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 08:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgIYGTi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 02:19:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39831 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgIYGTi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 02:19:38 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08P6CMvT4010490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08P6CMvT4010490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 14:12:22 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 25 Sep 2020 14:12:22 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <yhchuang@realtek.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] rtw88: handle and recover when firmware crash
Date:   Fri, 25 Sep 2020 14:12:16 +0800
Message-ID: <20200925061219.23754-3-tehuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925061219.23754-1-tehuang@realtek.com>
References: <20200925061219.23754-1-tehuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.222]
X-ClientProxiedBy: RTEXMB05.realtek.com.tw (172.21.6.98) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

This handles the situation when firmware crashes.
When firmware crashes, it will send an interrupt, and driver will queue
a work for recovery.
In the work, driver will reset it's internal association state, which
includes removing associated sta's macid, resetting vifs' states
and removing keys. After resetting the driver's state, driver will call
rtw_enter_ips() to force the chipset power off to reset the chip.
Finally, driver calls ieee80211_restart_hw() to inform mac80211 stack
to restart.
Since only 8822c firmware supports this feature, the interrupt will only
be triggered when 8822c chipset is loaded.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       |   9 ++
 drivers/net/wireless/realtek/rtw88/fw.h       |   1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |  81 +++--------
 drivers/net/wireless/realtek/rtw88/main.c     | 132 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  14 ++
 drivers/net/wireless/realtek/rtw88/pci.c      |   3 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   3 +
 drivers/net/wireless/realtek/rtw88/util.h     |   2 +
 8 files changed, 181 insertions(+), 64 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 63b00bc19000..6a50bb993caf 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -193,6 +193,15 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 }
 EXPORT_SYMBOL(rtw_fw_c2h_cmd_rx_irqsafe);
 
+void rtw_fw_c2h_cmd_isr(struct rtw_dev *rtwdev)
+{
+	if (rtw_read8(rtwdev, REG_MCU_TST_CFG) == VAL_FW_TRIGGER)
+		rtw_fw_recovery(rtwdev);
+	else
+		rtw_warn(rtwdev, "unhandled firmware c2h interrupt\n");
+}
+EXPORT_SYMBOL(rtw_fw_c2h_cmd_isr);
+
 static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
 				    u8 *h2c)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 686dcd3bbda6..b4e3f755e8fb 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -564,5 +564,6 @@ void rtw_fw_update_pkt_probe_req(struct rtw_dev *rtwdev,
 				 struct cfg80211_ssid *ssid);
 void rtw_fw_channel_switch(struct rtw_dev *rtwdev, bool enable);
 void rtw_fw_h2c_cmd_dbg(struct rtw_dev *rtwdev, u8 *h2c);
+void rtw_fw_c2h_cmd_isr(struct rtw_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 6b199152abcf..c92fba2fa480 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -358,13 +358,10 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	rtw_leave_lps_deep(rtwdev);
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		enum rtw_net_type net_type;
-
+		rtw_vif_assoc_changed(rtwvif, conf);
 		if (conf->assoc) {
 			rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_FINISH);
-			net_type = RTW_NET_MGD_LINKED;
 
-			rtwvif->aid = conf->aid;
 			rtw_fw_download_rsvd_page(rtwdev);
 			rtw_send_rsvd_page_h2c(rtwdev);
 			rtw_coex_media_status_notify(rtwdev, conf->assoc);
@@ -372,12 +369,9 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 				rtw_bf_assoc(rtwdev, vif, conf);
 		} else {
 			rtw_leave_lps(rtwdev);
-			net_type = RTW_NET_NO_LINK;
-			rtwvif->aid = 0;
 			rtw_bf_disassoc(rtwdev, vif, conf);
 		}
 
-		rtwvif->net_type = net_type;
 		config |= PORT_SET_NET_TYPE;
 		config |= PORT_SET_AID;
 	}
@@ -429,56 +423,17 @@ static int rtw_ops_conf_tx(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static u8 rtw_acquire_macid(struct rtw_dev *rtwdev)
-{
-	unsigned long mac_id;
-
-	mac_id = find_first_zero_bit(rtwdev->mac_id_map, RTW_MAX_MAC_ID_NUM);
-	if (mac_id < RTW_MAX_MAC_ID_NUM)
-		set_bit(mac_id, rtwdev->mac_id_map);
-
-	return mac_id;
-}
-
-static void rtw_release_macid(struct rtw_dev *rtwdev, u8 mac_id)
-{
-	clear_bit(mac_id, rtwdev->mac_id_map);
-}
-
 static int rtw_ops_sta_add(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
-	int i;
 	int ret = 0;
 
 	mutex_lock(&rtwdev->mutex);
-
-	si->mac_id = rtw_acquire_macid(rtwdev);
-	if (si->mac_id >= RTW_MAX_MAC_ID_NUM) {
-		ret = -ENOSPC;
-		goto out;
-	}
-
-	si->sta = sta;
-	si->vif = vif;
-	si->init_ra_lv = 1;
-	ewma_rssi_init(&si->avg_rssi);
-	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
-		rtw_txq_init(rtwdev, sta->txq[i]);
-
-	rtw_update_sta_info(rtwdev, si);
-	rtw_fw_media_status_report(rtwdev, si->mac_id, true);
-
-	rtwdev->sta_cnt++;
-
-	rtw_info(rtwdev, "sta %pM joined with macid %d\n",
-		 sta->addr, si->mac_id);
-
-out:
+	ret = rtw_sta_add(rtwdev, sta, vif);
 	mutex_unlock(&rtwdev->mutex);
+
 	return ret;
 }
 
@@ -487,25 +442,11 @@ static int rtw_ops_sta_remove(struct ieee80211_hw *hw,
 			      struct ieee80211_sta *sta)
 {
 	struct rtw_dev *rtwdev = hw->priv;
-	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
-	int i;
 
 	mutex_lock(&rtwdev->mutex);
-
-	rtw_release_macid(rtwdev, si->mac_id);
-	rtw_fw_media_status_report(rtwdev, si->mac_id, false);
-
-	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
-		rtw_txq_cleanup(rtwdev, sta->txq[i]);
-
-	kfree(si->mask);
-
-	rtwdev->sta_cnt--;
-
-	rtw_info(rtwdev, "sta %pM with macid %d left\n",
-		 sta->addr, si->mac_id);
-
+	rtw_sta_remove(rtwdev, sta, true);
 	mutex_unlock(&rtwdev->mutex);
+
 	return 0;
 }
 
@@ -845,6 +786,17 @@ static void rtw_ops_set_wakeup(struct ieee80211_hw *hw, bool enabled)
 }
 #endif
 
+static void rtw_reconfig_complete(struct ieee80211_hw *hw,
+				  enum ieee80211_reconfig_type reconfig_type)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	if (reconfig_type == IEEE80211_RECONFIG_TYPE_RESTART)
+		clear_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 const struct ieee80211_ops rtw_ops = {
 	.tx			= rtw_ops_tx,
 	.wake_tx_queue		= rtw_ops_wake_tx_queue,
@@ -871,6 +823,7 @@ const struct ieee80211_ops rtw_ops = {
 	.set_bitrate_mask	= rtw_ops_set_bitrate_mask,
 	.set_antenna		= rtw_ops_set_antenna,
 	.get_antenna		= rtw_ops_get_antenna,
+	.reconfig_complete	= rtw_reconfig_complete,
 #ifdef CONFIG_PM
 	.suspend		= rtw_ops_suspend,
 	.resume			= rtw_ops_resume,
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 9770982b2f14..ba16da557363 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -259,6 +259,137 @@ static void rtw_c2h_work(struct work_struct *work)
 	}
 }
 
+static u8 rtw_acquire_macid(struct rtw_dev *rtwdev)
+{
+	unsigned long mac_id;
+
+	mac_id = find_first_zero_bit(rtwdev->mac_id_map, RTW_MAX_MAC_ID_NUM);
+	if (mac_id < RTW_MAX_MAC_ID_NUM)
+		set_bit(mac_id, rtwdev->mac_id_map);
+
+	return mac_id;
+}
+
+int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
+		struct ieee80211_vif *vif)
+{
+	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	int i;
+
+	si->mac_id = rtw_acquire_macid(rtwdev);
+	if (si->mac_id >= RTW_MAX_MAC_ID_NUM)
+		return -ENOSPC;
+
+	si->sta = sta;
+	si->vif = vif;
+	si->init_ra_lv = 1;
+	ewma_rssi_init(&si->avg_rssi);
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
+		rtw_txq_init(rtwdev, sta->txq[i]);
+
+	rtw_update_sta_info(rtwdev, si);
+	rtw_fw_media_status_report(rtwdev, si->mac_id, true);
+
+	rtwdev->sta_cnt++;
+	rtw_info(rtwdev, "sta %pM joined with macid %d\n",
+		 sta->addr, si->mac_id);
+
+	return 0;
+}
+
+void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
+		    bool fw_exist)
+{
+	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	int i;
+
+	rtw_release_macid(rtwdev, si->mac_id);
+	if (fw_exist)
+		rtw_fw_media_status_report(rtwdev, si->mac_id, false);
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
+		rtw_txq_cleanup(rtwdev, sta->txq[i]);
+
+	kfree(si->mask);
+
+	rtwdev->sta_cnt--;
+	rtw_info(rtwdev, "sta %pM with macid %d left\n",
+		 sta->addr, si->mac_id);
+}
+
+void rtw_vif_assoc_changed(struct rtw_vif *rtwvif,
+			   struct ieee80211_bss_conf *conf)
+{
+	if (conf && conf->assoc) {
+		rtwvif->aid = conf->aid;
+		rtwvif->net_type = RTW_NET_MGD_LINKED;
+	} else {
+		rtwvif->aid = 0;
+		rtwvif->net_type = RTW_NET_NO_LINK;
+	}
+}
+
+static void rtw_reset_key_iter(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta,
+			       struct ieee80211_key_conf *key,
+			       void *data)
+{
+	struct rtw_dev *rtwdev = (struct rtw_dev *)data;
+	struct rtw_sec_desc *sec = &rtwdev->sec;
+
+	rtw_sec_clear_cam(rtwdev, sec, key->hw_key_idx);
+}
+
+static void rtw_reset_sta_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw_dev *rtwdev = (struct rtw_dev *)data;
+
+	if (rtwdev->sta_cnt == 0) {
+		rtw_warn(rtwdev, "sta count before reset should not be 0\n");
+		return;
+	}
+	rtw_sta_remove(rtwdev, sta, false);
+}
+
+static void rtw_reset_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct rtw_dev *rtwdev = (struct rtw_dev *)data;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+
+	rtw_bf_disassoc(rtwdev, vif, NULL);
+	rtw_vif_assoc_changed(rtwvif, NULL);
+	rtw_txq_cleanup(rtwdev, vif->txq);
+}
+
+void rtw_fw_recovery(struct rtw_dev *rtwdev)
+{
+	if (!test_bit(RTW_FLAG_RESTARTING, rtwdev->flags))
+		ieee80211_queue_work(rtwdev->hw, &rtwdev->fw_recovery_work);
+}
+
+static void rtw_fw_recovery_work(struct work_struct *work)
+{
+	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
+					      fw_recovery_work);
+
+	WARN(1, "firmware crash, start reset and recover\n");
+
+	mutex_lock(&rtwdev->mutex);
+
+	set_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
+	rcu_read_lock();
+	rtw_iterate_keys_rcu(rtwdev, NULL, rtw_reset_key_iter, rtwdev);
+	rcu_read_unlock();
+	rtw_iterate_stas_atomic(rtwdev, rtw_reset_sta_iter, rtwdev);
+	rtw_iterate_vifs_atomic(rtwdev, rtw_reset_vif_iter, rtwdev);
+	rtw_enter_ips(rtwdev);
+
+	mutex_unlock(&rtwdev->mutex);
+
+	ieee80211_restart_hw(rtwdev->hw);
+}
+
 struct rtw_txq_ba_iter_data {
 };
 
@@ -1431,6 +1562,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	INIT_DELAYED_WORK(&coex->wl_remain_work, rtw_coex_wl_remain_work);
 	INIT_DELAYED_WORK(&coex->bt_remain_work, rtw_coex_bt_remain_work);
 	INIT_WORK(&rtwdev->c2h_work, rtw_c2h_work);
+	INIT_WORK(&rtwdev->fw_recovery_work, rtw_fw_recovery_work);
 	INIT_WORK(&rtwdev->ba_work, rtw_txq_ba_work);
 	skb_queue_head_init(&rtwdev->c2h_queue);
 	skb_queue_head_init(&rtwdev->coex.queue);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 276b5d381467..292336387b89 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -359,6 +359,7 @@ enum rtw_flags {
 	RTW_FLAG_DIG_DISABLE,
 	RTW_FLAG_BUSY_TRAFFIC,
 	RTW_FLAG_WOWLAN,
+	RTW_FLAG_RESTARTING,
 
 	NUM_OF_RTW_FLAGS,
 };
@@ -1699,6 +1700,7 @@ struct rtw_dev {
 	/* c2h cmd queue & handler work */
 	struct sk_buff_head c2h_queue;
 	struct work_struct c2h_work;
+	struct work_struct fw_recovery_work;
 
 	/* used to protect txqs list */
 	spinlock_t txq_lock;
@@ -1799,6 +1801,11 @@ static inline bool rtw_chip_has_rx_ldpc(struct rtw_dev *rtwdev)
 	return rtwdev->chip->rx_ldpc;
 }
 
+static inline void rtw_release_macid(struct rtw_dev *rtwdev, u8 mac_id)
+{
+	clear_bit(mac_id, rtwdev->mac_id_map);
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
@@ -1821,5 +1828,12 @@ void rtw_core_deinit(struct rtw_dev *rtwdev);
 int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw);
 void rtw_unregister_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw);
 u16 rtw_desc_to_bitrate(u8 desc_rate);
+void rtw_vif_assoc_changed(struct rtw_vif *rtwvif,
+			   struct ieee80211_bss_conf *conf);
+int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
+		struct ieee80211_vif *vif);
+void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
+		    bool fw_exist);
+void rtw_fw_recovery(struct rtw_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 135dd331691c..e72ea99d9430 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -389,6 +389,7 @@ static int rtw_pci_init(struct rtw_dev *rtwdev)
 			      IMR_VODOK |
 			      IMR_ROK |
 			      IMR_BCNDMAINT_E |
+			      IMR_C2HCMD |
 			      0;
 	rtwpci->irq_mask[1] = IMR_TXFOVW |
 			      0;
@@ -1079,6 +1080,8 @@ static irqreturn_t rtw_pci_interrupt_threadfn(int irq, void *dev)
 		rtw_pci_tx_isr(rtwdev, rtwpci, RTW_TX_QUEUE_H2C);
 	if (irq_status[0] & IMR_ROK)
 		rtw_pci_rx_isr(rtwdev, rtwpci, RTW_RX_QUEUE_MPDU);
+	if (unlikely(irq_status[0] & IMR_C2HCMD))
+		rtw_fw_c2h_cmd_isr(rtwdev);
 
 	/* all of the jobs for this interrupt have been done */
 	rtw_pci_enable_interrupt(rtwdev, rtwpci);
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 8f468d6b5f78..9a696ac17d69 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -126,6 +126,9 @@
 				 BIT_WINTINI_RDY | BIT_RAM_DL_SEL)
 #define FW_READY_MASK		0xffff
 
+#define REG_MCU_TST_CFG		0x84
+#define VAL_FW_TRIGGER		0x1
+
 #define REG_EFUSE_ACCESS	0x00CF
 #define EFUSE_ACCESS_ON		0x69
 #define EFUSE_ACCESS_OFF	0x00
diff --git a/drivers/net/wireless/realtek/rtw88/util.h b/drivers/net/wireless/realtek/rtw88/util.h
index 41c10e7144df..0c23b5069be0 100644
--- a/drivers/net/wireless/realtek/rtw88/util.h
+++ b/drivers/net/wireless/realtek/rtw88/util.h
@@ -17,6 +17,8 @@ struct rtw_dev;
 	ieee80211_iterate_stations_atomic(rtwdev->hw, iterator, data)
 #define rtw_iterate_keys(rtwdev, vif, iterator, data)			       \
 	ieee80211_iter_keys(rtwdev->hw, vif, iterator, data)
+#define rtw_iterate_keys_rcu(rtwdev, vif, iterator, data)		       \
+	ieee80211_iter_keys_rcu((rtwdev)->hw, vif, iterator, data)
 
 static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
 {
-- 
2.17.1

