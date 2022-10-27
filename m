Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A094160EF81
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 07:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiJ0F2P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Oct 2022 01:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiJ0F2A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Oct 2022 01:28:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E637915A8D5
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 22:27:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29R5REhZ4020073, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29R5REhZ4020073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Oct 2022 13:27:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 27 Oct 2022 13:27:48 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 27 Oct
 2022 13:27:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 6/7] wifi: rtw89: add WoWLAN function support
Date:   Thu, 27 Oct 2022 13:27:06 +0800
Message-ID: <20221027052707.14605-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027052707.14605-1-pkshih@realtek.com>
References: <20221027052707.14605-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/27/2022 05:04:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI2IKRVpMggMTE6MzI6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

WoWLAN is a feature which allows devices to be woken up from suspend
state through WLAN events.

When user enables WoWLAN feature and then let the device enter suspend
state, WoWLAN firmware will be loaded by the driver and periodically
monitors WiFi packets. Power consumption of WiFi chip will be reduced
in this state.

We now implement WoWLAN function in rtw8852ae and rtw8852ce chip.
Currently supported WLAN events include receiving magic packet,
rekey packet and deauth packet, and disconnecting from AP.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Makefile   |   2 +
 drivers/net/wireless/realtek/rtw89/core.c     |   8 +
 drivers/net/wireless/realtek/rtw89/core.h     |  77 ++-
 drivers/net/wireless/realtek/rtw89/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  18 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |  14 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  55 ++
 drivers/net/wireless/realtek/rtw89/pci.c      |  23 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |   2 +-
 drivers/net/wireless/realtek/rtw89/ps.h       |   1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   8 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   9 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   9 +
 drivers/net/wireless/realtek/rtw89/wow.c      | 633 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/wow.h      |  21 +
 15 files changed, 874 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/wow.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/wow.h

diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index ec0f5da65d6a1..2dc48fa10c6b6 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -15,6 +15,8 @@ rtw89_core-y += core.o \
 		chan.o \
 		ser.o
 
+rtw89_core-$(CONFIG_PM) += wow.o
+
 obj-$(CONFIG_RTW89_8852A) += rtw89_8852a.o
 rtw89_8852a-objs := rtw8852a.o \
 		    rtw8852a_table.o \
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4b6c90d5f1b6c..c7d0c2c91b999 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2204,6 +2204,9 @@ static void rtw89_track_work(struct work_struct *work)
 						track_work.work);
 	bool tfc_changed;
 
+	if (test_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags))
+		return;
+
 	mutex_lock(&rtwdev->mutex);
 
 	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
@@ -3040,6 +3043,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 			continue;
 		INIT_LIST_HEAD(&rtwdev->scan_info.pkt_list[band]);
 	}
+	INIT_LIST_HEAD(&rtwdev->wow.pkt_list);
 	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
@@ -3271,6 +3275,10 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	hw->wiphy->max_scan_ssids = RTW89_SCANOFLD_MAX_SSID;
 	hw->wiphy->max_scan_ie_len = RTW89_SCANOFLD_MAX_IE_LEN;
 
+#ifdef CONFIG_PM
+	hw->wiphy->wowlan = rtwdev->chip->wowlan_stub;
+#endif
+
 	hw->wiphy->tid_config_support.vif |= BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL);
 	hw->wiphy->tid_config_support.peer |= BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL);
 	hw->wiphy->tid_config_support.vif |= BIT(NL80211_TID_CONFIG_ATTR_AMSDU_CTRL);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d20cb3ae89e98..9f80359e27aa2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -178,7 +178,9 @@ enum rtw89_upd_mode {
 	RTW89_ROLE_REMOVE,
 	RTW89_ROLE_TYPE_CHANGE,
 	RTW89_ROLE_INFO_CHANGE,
-	RTW89_ROLE_CON_DISCONN
+	RTW89_ROLE_CON_DISCONN,
+	RTW89_ROLE_BAND_SW,
+	RTW89_ROLE_FW_RESTORE,
 };
 
 enum rtw89_self_role {
@@ -2307,6 +2309,16 @@ struct rtw89_hci_ops {
 	 */
 	void (*recovery_start)(struct rtw89_dev *rtwdev);
 	void (*recovery_complete)(struct rtw89_dev *rtwdev);
+
+	void (*ctrl_txdma_ch)(struct rtw89_dev *rtwdev, bool enable);
+	void (*ctrl_txdma_fw_ch)(struct rtw89_dev *rtwdev, bool enable);
+	void (*ctrl_trxhci)(struct rtw89_dev *rtwdev, bool enable);
+	int (*poll_txdma_ch)(struct rtw89_dev *rtwdev);
+	void (*clr_idx_all)(struct rtw89_dev *rtwdev);
+	void (*clear)(struct rtw89_dev *rtwdev, struct pci_dev *pdev);
+	void (*disable_intr)(struct rtw89_dev *rtwdev);
+	void (*enable_intr)(struct rtw89_dev *rtwdev);
+	int (*rst_bdram)(struct rtw89_dev *rtwdev);
 };
 
 struct rtw89_hci_info {
@@ -2748,6 +2760,7 @@ struct rtw89_chip_info {
 	const struct rtw89_imr_info *imr_info;
 	const struct rtw89_rrsr_cfgs *rrsr_cfgs;
 	u32 dma_ch_mask;
+	const struct wiphy_wowlan_support *wowlan_stub;
 };
 
 union rtw89_bus_info {
@@ -2944,6 +2957,8 @@ enum rtw89_flags {
 	RTW89_FLAG_LOW_POWER_MODE,
 	RTW89_FLAG_INACTIVE_PS,
 	RTW89_FLAG_CRASH_SIMULATING,
+	RTW89_FLAG_WOWLAN,
+	RTW89_FLAG_FORBIDDEN_TRACK_WROK,
 
 	NUM_OF_RTW89_FLAGS,
 };
@@ -3653,6 +3668,66 @@ static inline void rtw89_hci_recovery_complete(struct rtw89_dev *rtwdev)
 		rtwdev->hci.ops->recovery_complete(rtwdev);
 }
 
+static inline void rtw89_hci_enable_intr(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->hci.ops->enable_intr)
+		rtwdev->hci.ops->enable_intr(rtwdev);
+}
+
+static inline void rtw89_hci_disable_intr(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->hci.ops->disable_intr)
+		rtwdev->hci.ops->disable_intr(rtwdev);
+}
+
+static inline void rtw89_hci_ctrl_txdma_ch(struct rtw89_dev *rtwdev, bool enable)
+{
+	if (rtwdev->hci.ops->ctrl_txdma_ch)
+		rtwdev->hci.ops->ctrl_txdma_ch(rtwdev, enable);
+}
+
+static inline void rtw89_hci_ctrl_txdma_fw_ch(struct rtw89_dev *rtwdev, bool enable)
+{
+	if (rtwdev->hci.ops->ctrl_txdma_fw_ch)
+		rtwdev->hci.ops->ctrl_txdma_fw_ch(rtwdev, enable);
+}
+
+static inline void rtw89_hci_ctrl_trxhci(struct rtw89_dev *rtwdev, bool enable)
+{
+	if (rtwdev->hci.ops->ctrl_trxhci)
+		rtwdev->hci.ops->ctrl_trxhci(rtwdev, enable);
+}
+
+static inline int rtw89_hci_poll_txdma_ch(struct rtw89_dev *rtwdev)
+{
+	int ret = 0;
+
+	if (rtwdev->hci.ops->poll_txdma_ch)
+		ret = rtwdev->hci.ops->poll_txdma_ch(rtwdev);
+	return ret;
+}
+
+static inline void rtw89_hci_clr_idx_all(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->hci.ops->clr_idx_all)
+		rtwdev->hci.ops->clr_idx_all(rtwdev);
+}
+
+static inline int rtw89_hci_rst_bdram(struct rtw89_dev *rtwdev)
+{
+	int ret = 0;
+
+	if (rtwdev->hci.ops->rst_bdram)
+		ret = rtwdev->hci.ops->rst_bdram(rtwdev);
+	return ret;
+}
+
+static inline void rtw89_hci_clear(struct rtw89_dev *rtwdev, struct pci_dev *pdev)
+{
+	if (rtwdev->hci.ops->clear)
+		rtwdev->hci.ops->clear(rtwdev, pdev);
+}
+
 static inline u8 rtw89_read8(struct rtw89_dev *rtwdev, u32 addr)
 {
 	return rtwdev->hci.ops->read8(rtwdev, addr);
diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index ee243aadde873..e7971583acbc9 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -26,6 +26,7 @@ enum rtw89_debug_mask {
 	RTW89_DBG_HW_SCAN = BIT(15),
 	RTW89_DBG_SAR = BIT(16),
 	RTW89_DBG_STATE = BIT(17),
+	RTW89_DBG_WOW = BIT(18),
 
 	RTW89_DBG_UNEXP = BIT(31),
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5b706611d5334..bb49033b587d2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1566,6 +1566,16 @@ int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow)
 }
 #undef SET_QUOTA
 
+void rtw89_mac_hw_mgnt_sec(struct rtw89_dev *rtwdev, bool enable)
+{
+	u32 msk32 = B_AX_UC_MGNT_DEC | B_AX_BMC_MGNT_DEC;
+
+	if (enable)
+		rtw89_write32_set(rtwdev, R_AX_SEC_ENG_CTRL, msk32);
+	else
+		rtw89_write32_clr(rtwdev, R_AX_SEC_ENG_CTRL, msk32);
+}
+
 static void dle_quota_cfg(struct rtw89_dev *rtwdev,
 			  const struct rtw89_dle_mem *cfg,
 			  u16 ext_wde_min_qt_wcpu)
@@ -1915,10 +1925,10 @@ static int scheduler_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
-static int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
-				  enum rtw89_machdr_frame_type type,
-				  enum rtw89_mac_fwd_target fwd_target,
-				  u8 mac_idx)
+int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
+			   enum rtw89_machdr_frame_type type,
+			   enum rtw89_mac_fwd_target fwd_target,
+			   u8 mac_idx)
 {
 	u32 reg;
 	u32 val;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index e3b4c7830f440..34f7d51be3f97 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -980,6 +980,16 @@ static inline void rtw89_mac_ctrl_hci_dma_trx(struct rtw89_dev *rtwdev,
 				  B_AX_HCI_TXDMA_EN | B_AX_HCI_RXDMA_EN);
 }
 
+static inline bool rtw89_mac_get_power_state(struct rtw89_dev *rtwdev)
+{
+	u32 val;
+
+	val = rtw89_read32_mask(rtwdev, R_AX_IC_PWR_STATE,
+				B_AX_WLMAC_PWR_STE_MASK);
+
+	return !!val;
+}
+
 int rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  bool resume, u32 tx_time);
 int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
@@ -1038,8 +1048,12 @@ void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd);
 int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
 			struct rtw89_cpuio_ctrl *ctrl_para, bool wd);
+int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
+			   enum rtw89_machdr_frame_type type,
+			   enum rtw89_mac_fwd_target fwd_target, u8 mac_idx);
 int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow);
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 					enum rtw89_mac_idx band);
+void rtw89_mac_hw_mgnt_sec(struct rtw89_dev *rtwdev, bool wow);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a296bfa8188f2..6e79bf899901d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -14,6 +14,7 @@
 #include "sar.h"
 #include "ser.h"
 #include "util.h"
+#include "wow.h"
 
 static void rtw89_ops_tx(struct ieee80211_hw *hw,
 			 struct ieee80211_tx_control *control,
@@ -916,6 +917,55 @@ static int rtw89_ops_set_tid_config(struct ieee80211_hw *hw,
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int rtw89_ops_suspend(struct ieee80211_hw *hw,
+			     struct cfg80211_wowlan *wowlan)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	int ret;
+
+	set_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
+	cancel_delayed_work_sync(&rtwdev->track_work);
+
+	mutex_lock(&rtwdev->mutex);
+	ret = rtw89_wow_suspend(rtwdev, wowlan);
+	mutex_unlock(&rtwdev->mutex);
+
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to suspend for wow %d\n", ret);
+		clear_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int rtw89_ops_resume(struct ieee80211_hw *hw)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	int ret;
+
+	mutex_lock(&rtwdev->mutex);
+	ret = rtw89_wow_resume(rtwdev);
+	if (ret)
+		rtw89_warn(rtwdev, "failed to resume for wow %d\n", ret);
+	mutex_unlock(&rtwdev->mutex);
+
+	clear_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
+	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->track_work,
+				     RTW89_TRACK_WORK_PERIOD);
+
+	return ret ? 1 : 0;
+}
+
+static void rtw89_ops_set_wakeup(struct ieee80211_hw *hw, bool enabled)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	device_set_wakeup_enable(rtwdev->dev, enabled);
+}
+#endif
+
 const struct ieee80211_ops rtw89_ops = {
 	.tx			= rtw89_ops_tx,
 	.wake_tx_queue		= rtw89_ops_wake_tx_queue,
@@ -953,5 +1003,10 @@ const struct ieee80211_ops rtw89_ops = {
 	.set_sar_specs		= rtw89_ops_set_sar_specs,
 	.sta_rc_update		= rtw89_ops_sta_rc_update,
 	.set_tid_config		= rtw89_ops_set_tid_config,
+#ifdef CONFIG_PM
+	.suspend		= rtw89_ops_suspend,
+	.resume			= rtw89_ops_resume,
+	.set_wakeup		= rtw89_ops_set_wakeup,
+#endif
 };
 EXPORT_SYMBOL(rtw89_ops);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 5f8e19639362d..07a2e23759f0b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -186,6 +186,17 @@ static void rtw89_pci_ctrl_txdma_ch_pcie(struct rtw89_dev *rtwdev, bool enable)
 	}
 }
 
+static void rtw89_pci_ctrl_txdma_fw_ch_pcie(struct rtw89_dev *rtwdev, bool enable)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_reg_def *dma_stop1 = &info->dma_stop1;
+
+	if (enable)
+		rtw89_write32_clr(rtwdev, dma_stop1->addr, B_AX_STOP_CH12);
+	else
+		rtw89_write32_set(rtwdev, dma_stop1->addr, B_AX_STOP_CH12);
+}
+
 static bool
 rtw89_skb_put_rx_data(struct rtw89_dev *rtwdev, bool fs, bool ls,
 		      struct sk_buff *new,
@@ -2513,7 +2524,7 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 
 	/* disable all channels except to FW CMD channel to download firmware */
 	rtw89_pci_ctrl_txdma_ch_pcie(rtwdev, false);
-	rtw89_write32_clr(rtwdev, info->dma_stop1.addr, B_AX_STOP_CH12);
+	rtw89_pci_ctrl_txdma_fw_ch_pcie(rtwdev, true);
 
 	/* start DMA activities */
 	rtw89_pci_ctrl_dma_all(rtwdev, true);
@@ -3771,6 +3782,16 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 
 	.recovery_start = rtw89_pci_ops_recovery_start,
 	.recovery_complete = rtw89_pci_ops_recovery_complete,
+
+	.ctrl_txdma_ch	= rtw89_pci_ctrl_txdma_ch_pcie,
+	.ctrl_txdma_fw_ch = rtw89_pci_ctrl_txdma_fw_ch_pcie,
+	.ctrl_trxhci	= rtw89_pci_ctrl_dma_trx,
+	.poll_txdma_ch	= rtw89_poll_txdma_ch_idle_pcie,
+	.clr_idx_all	= rtw89_pci_clr_idx_all,
+	.clear		= rtw89_pci_clear_resource,
+	.disable_intr	= rtw89_pci_disable_intr_lock,
+	.enable_intr	= rtw89_pci_enable_intr_lock,
+	.rst_bdram	= rtw89_pci_rst_bdram_pcie,
 };
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index bf41a11416792..40498812205ea 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -59,7 +59,7 @@ static void rtw89_ps_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 		rtw89_mac_power_mode_change(rtwdev, enter);
 }
 
-static void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	if (rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT)
 		return;
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index 0feae39916238..6ac1f7ea53394 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -8,6 +8,7 @@
 void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_leave_lps(struct rtw89_dev *rtwdev);
 void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
+void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
 void rtw89_enter_ips(struct rtw89_dev *rtwdev);
 void rtw89_leave_ips(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 33f2b67bfca37..2f6358244934f 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -952,6 +952,9 @@
 				    B_AX_STF_OQT_OVERFLOW_ERR_INT_EN | \
 				    B_AX_STF_OQT_UNDERFLOW_ERR_INT_EN)
 
+#define R_AX_RX_FUNCTION_STOP 0x8920
+#define B_AX_HDR_RX_STOP BIT(0)
+
 #define R_AX_HCI_FC_CTRL 0x8A00
 #define B_AX_HCI_FC_CH12_FULL_COND_MASK GENMASK(11, 10)
 #define B_AX_HCI_FC_WP_CH811_FULL_COND_MASK GENMASK(9, 8)
@@ -1570,6 +1573,8 @@
 #define R_AX_ACTION_FWD0 0x9C04
 #define TRXCFG_MPDU_PROC_ACT_FRWD 0x02A95A95
 
+#define R_AX_ACTION_FWD1 0x9C08
+
 #define R_AX_TF_FWD 0x9C14
 #define TRXCFG_MPDU_PROC_TF_FRWD 0x0000AA55
 
@@ -1581,6 +1586,9 @@
 #define R_AX_CUT_AMSDU_CTRL 0x9C40
 #define TRXCFG_MPDU_PROC_CUT_CTRL	0x010E05F0
 
+#define R_AX_WOW_CTRL 0x9C50
+#define B_AX_WOW_WOWEN BIT(1)
+
 #define R_AX_MPDU_RX_ERR_ISR 0x9CF0
 #define R_AX_MPDU_RX_ERR_IMR 0x9CF4
 #define B_AX_RPT_ERR_INT_EN BIT(3)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 7995d720dc921..becce3b48f518 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1990,6 +1990,12 @@ static void rtw8852a_query_ppdu(struct rtw89_dev *rtwdev,
 		rtw8852a_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
 }
 
+#ifdef CONFIG_PM
+static const struct wiphy_wowlan_support rtw_wowlan_stub_8852a = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+};
+#endif
+
 static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.enable_bb_rf		= rtw89_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw89_mac_disable_bb_rf,
@@ -2139,6 +2145,9 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.imr_info		= &rtw8852a_imr_info,
 	.rrsr_cfgs		= &rtw8852a_rrsr_cfgs,
 	.dma_ch_mask		= 0,
+#ifdef CONFIG_PM
+	.wowlan_stub		= &rtw_wowlan_stub_8852a,
+#endif
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 470e9e9cfafd6..c731901bc90b3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2796,6 +2796,12 @@ static int rtw8852c_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static const struct wiphy_wowlan_support rtw_wowlan_stub_8852c = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+};
+#endif
+
 static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.enable_bb_rf		= rtw8852c_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852c_mac_disable_bb_rf,
@@ -2949,6 +2955,9 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.imr_info		= &rtw8852c_imr_info,
 	.rrsr_cfgs		= &rtw8852c_rrsr_cfgs,
 	.dma_ch_mask		= 0,
+#ifdef CONFIG_PM
+	.wowlan_stub		= &rtw_wowlan_stub_8852c,
+#endif
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
new file mode 100644
index 0000000000000..3d30083fcb9a8
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+#include "cam.h"
+#include "core.h"
+#include "debug.h"
+#include "fw.h"
+#include "mac.h"
+#include "phy.h"
+#include "ps.h"
+#include "reg.h"
+#include "util.h"
+#include "wow.h"
+
+static void rtw89_wow_leave_deep_ps(struct rtw89_dev *rtwdev)
+{
+	__rtw89_leave_ps_mode(rtwdev);
+}
+
+static void rtw89_wow_enter_deep_ps(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+
+	__rtw89_enter_ps_mode(rtwdev, rtwvif);
+}
+
+static void rtw89_wow_enter_lps(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+
+	rtw89_enter_lps(rtwdev, rtwvif);
+}
+
+static void rtw89_wow_leave_lps(struct rtw89_dev *rtwdev)
+{
+	rtw89_leave_lps(rtwdev);
+}
+
+static int rtw89_wow_config_mac(struct rtw89_dev *rtwdev, bool enable_wow)
+{
+	int ret;
+
+	if (enable_wow) {
+		ret = rtw89_mac_resize_ple_rx_quota(rtwdev, true);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]patch rx qta %d\n", ret);
+			return ret;
+		}
+		rtw89_write32_set(rtwdev, R_AX_RX_FUNCTION_STOP, B_AX_HDR_RX_STOP);
+		rtw89_write32_clr(rtwdev, R_AX_RX_FLTR_OPT, B_AX_SNIFFER_MODE);
+		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
+		rtw89_write32(rtwdev, R_AX_ACTION_FWD0, 0);
+		rtw89_write32(rtwdev, R_AX_ACTION_FWD1, 0);
+		rtw89_write32(rtwdev, R_AX_TF_FWD, 0);
+		rtw89_write32(rtwdev, R_AX_HW_RPT_FWD, 0);
+	} else {
+		ret = rtw89_mac_resize_ple_rx_quota(rtwdev, false);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]patch rx qta %d\n", ret);
+			return ret;
+		}
+		rtw89_write32_clr(rtwdev, R_AX_RX_FUNCTION_STOP, B_AX_HDR_RX_STOP);
+		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
+		rtw89_write32(rtwdev, R_AX_ACTION_FWD0, TRXCFG_MPDU_PROC_ACT_FRWD);
+		rtw89_write32(rtwdev, R_AX_TF_FWD, TRXCFG_MPDU_PROC_TF_FRWD);
+	}
+
+	return 0;
+}
+
+static void rtw89_wow_set_rx_filter(struct rtw89_dev *rtwdev, bool enable)
+{
+	enum rtw89_mac_fwd_target fwd_target = enable ?
+					       RTW89_FWD_DONT_CARE :
+					       RTW89_FWD_TO_HOST;
+
+	rtw89_mac_typ_fltr_opt(rtwdev, RTW89_MGNT, fwd_target, RTW89_MAC_0);
+	rtw89_mac_typ_fltr_opt(rtwdev, RTW89_CTRL, fwd_target, RTW89_MAC_0);
+	rtw89_mac_typ_fltr_opt(rtwdev, RTW89_DATA, fwd_target, RTW89_MAC_0);
+}
+
+static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	struct cfg80211_wowlan_nd_info nd_info;
+	struct cfg80211_wowlan_wakeup wakeup = {
+		.pattern_idx = -1,
+	};
+	u32 wow_reason_reg;
+	u8 reason;
+
+	if (chip_id == RTL8852A || chip_id == RTL8852B)
+		wow_reason_reg = R_AX_C2HREG_DATA3 + 3;
+	else
+		wow_reason_reg = R_AX_C2HREG_DATA3_V1 + 3;
+
+	reason = rtw89_read8(rtwdev, wow_reason_reg);
+
+	switch (reason) {
+	case RTW89_WOW_RSN_RX_DEAUTH:
+		wakeup.disconnect = true;
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx deauth\n");
+		break;
+	case RTW89_WOW_RSN_DISCONNECT:
+		wakeup.disconnect = true;
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: AP is off\n");
+		break;
+	case RTW89_WOW_RSN_RX_MAGIC_PKT:
+		wakeup.magic_pkt = true;
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx magic packet\n");
+		break;
+	case RTW89_WOW_RSN_RX_GTK_REKEY:
+		wakeup.gtk_rekey_failure = true;
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx gtk rekey\n");
+		break;
+	case RTW89_WOW_RSN_RX_PATTERN_MATCH:
+		/* Current firmware and driver don't report pattern index
+		 * Use pattern_idx to 0 defaultly.
+		 */
+		wakeup.pattern_idx = 0;
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "WOW: Rx pattern match packet\n");
+		break;
+	case RTW89_WOW_RSN_RX_NLO:
+		/* Current firmware and driver don't report ssid index.
+		 * Use 0 for n_matches based on its comment.
+		 */
+		nd_info.n_matches = 0;
+		wakeup.net_detect = &nd_info;
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "Rx NLO\n");
+		break;
+	default:
+		rtw89_warn(rtwdev, "Unknown wakeup reason %x\n", reason);
+		ieee80211_report_wowlan_wakeup(rtwdev->wow.wow_vif, NULL,
+					       GFP_KERNEL);
+		return;
+	}
+
+	ieee80211_report_wowlan_wakeup(rtwdev->wow.wow_vif, &wakeup,
+				       GFP_KERNEL);
+}
+
+static void rtw89_wow_vif_iter(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+
+	/* Current wowlan function support setting of only one STATION vif.
+	 * So when one suitable vif is found, stop the iteration.
+	 */
+	if (rtw_wow->wow_vif || vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	switch (rtwvif->net_type) {
+	case RTW89_NET_TYPE_INFRA:
+		rtw_wow->wow_vif = vif;
+		break;
+	case RTW89_NET_TYPE_NO_LINK:
+	default:
+		break;
+	}
+}
+
+static void rtw89_wow_clear_wakeups(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+
+	rtw_wow->wow_vif = NULL;
+	rtw89_core_release_all_bits_map(rtw_wow->flags, RTW89_WOW_FLAG_NUM);
+	rtw_wow->pattern_cnt = 0;
+}
+
+static int rtw89_wow_set_wakeups(struct rtw89_dev *rtwdev,
+				 struct cfg80211_wowlan *wowlan)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_vif *rtwvif;
+
+	if (wowlan->disconnect)
+		set_bit(RTW89_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags);
+	if (wowlan->magic_pkt)
+		set_bit(RTW89_WOW_FLAG_EN_MAGIC_PKT, rtw_wow->flags);
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_wow_vif_iter(rtwdev, rtwvif);
+
+	if (!rtw_wow->wow_vif)
+		return -EPERM;
+
+	return 0;
+}
+
+static int rtw89_wow_cfg_wake(struct rtw89_dev *rtwdev, bool wow)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct ieee80211_sta *wow_sta;
+	struct rtw89_sta *rtwsta = NULL;
+	bool is_conn = true;
+	int ret;
+
+	wow_sta = ieee80211_find_sta(wow_vif, rtwvif->bssid);
+	if (wow_sta)
+		rtwsta = (struct rtw89_sta *)wow_sta->drv_priv;
+	else
+		is_conn = false;
+
+	if (wow) {
+		if (rtw_wow->pattern_cnt)
+			rtwvif->wowlan_pattern = true;
+		if (test_bit(RTW89_WOW_FLAG_EN_MAGIC_PKT, rtw_wow->flags))
+			rtwvif->wowlan_magic = true;
+	} else {
+		rtwvif->wowlan_pattern = false;
+		rtwvif->wowlan_magic = false;
+	}
+
+	ret = rtw89_fw_h2c_wow_wakeup_ctrl(rtwdev, rtwvif, wow);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to fw wow wakeup ctrl\n");
+		return ret;
+	}
+
+	if (wow) {
+		ret = rtw89_chip_h2c_dctl_sec_cam(rtwdev, rtwvif, rtwsta);
+		if (ret) {
+			rtw89_err(rtwdev, "failed to update dctl cam sec entry: %d\n",
+				  ret);
+			return ret;
+		}
+	}
+
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, rtwsta, !is_conn);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c join info\n");
+		return ret;
+	}
+
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c cam\n");
+		return ret;
+	}
+
+	ret = rtw89_fw_h2c_wow_global(rtwdev, rtwvif, wow);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to fw wow global\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtw89_wow_check_fw_status(struct rtw89_dev *rtwdev, bool wow_enable)
+{
+	u8 polling;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_read8_mask, polling,
+				       wow_enable == !!polling,
+				       50, 50000, false, rtwdev,
+				       R_AX_WOW_CTRL, B_AX_WOW_WOWEN);
+	if (ret)
+		rtw89_err(rtwdev, "failed to check wow status %s\n",
+			  wow_enable ? "enabled" : "disabled");
+	return ret;
+}
+
+static void rtw89_wow_release_pkt_list(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct list_head *pkt_list = &rtw_wow->pkt_list;
+	struct rtw89_pktofld_info *info, *tmp;
+
+	list_for_each_entry_safe(info, tmp, pkt_list, list) {
+		rtw89_fw_h2c_del_pkt_offload(rtwdev, info->id);
+		rtw89_core_release_bit_map(rtwdev->pkt_offload,
+					   info->id);
+		list_del(&info->list);
+		kfree(info);
+	}
+}
+
+static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
+{
+	enum rtw89_fw_type fw_type = wow ? RTW89_FW_WOWLAN : RTW89_FW_NORMAL;
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	struct ieee80211_sta *wow_sta;
+	struct rtw89_sta *rtwsta = NULL;
+	bool is_conn = true;
+	int ret;
+
+	rtw89_hci_disable_intr(rtwdev);
+
+	wow_sta = ieee80211_find_sta(wow_vif, rtwvif->bssid);
+	if (wow_sta)
+		rtwsta = (struct rtw89_sta *)wow_sta->drv_priv;
+	else
+		is_conn = false;
+
+	ret = rtw89_fw_download(rtwdev, fw_type);
+	if (ret) {
+		rtw89_warn(rtwdev, "download fw failed\n");
+		return ret;
+	}
+
+	rtw89_phy_init_rf_reg(rtwdev, true);
+
+	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
+					 RTW89_ROLE_FW_RESTORE);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c role maintain\n");
+		return ret;
+	}
+
+	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, wow_vif, wow_sta);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c assoc cmac tbl\n");
+		return ret;
+	}
+
+	if (!is_conn)
+		rtw89_cam_reset_keys(rtwdev);
+
+	ret = rtw89_fw_h2c_join_info(rtwdev, rtwvif, rtwsta, !is_conn);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c join info\n");
+		return ret;
+	}
+
+	ret = rtw89_fw_h2c_cam(rtwdev, rtwvif, rtwsta, NULL);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to send h2c cam\n");
+		return ret;
+	}
+
+	if (is_conn) {
+		rtw89_phy_ra_assoc(rtwdev, wow_sta);
+		rtw89_phy_set_bss_color(rtwdev, wow_vif);
+		rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, wow_vif);
+	}
+
+	rtw89_mac_hw_mgnt_sec(rtwdev, wow);
+	rtw89_hci_enable_intr(rtwdev);
+
+	return 0;
+}
+
+static int rtw89_wow_enable_trx_pre(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_hci_ctrl_txdma_ch(rtwdev, false);
+	rtw89_hci_ctrl_txdma_fw_ch(rtwdev, true);
+
+	rtw89_mac_ptk_drop_by_band_and_wait(rtwdev, RTW89_MAC_0);
+
+	ret = rtw89_hci_poll_txdma_ch(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "txdma ch busy\n");
+		return ret;
+	}
+	rtw89_wow_set_rx_filter(rtwdev, true);
+
+	ret = rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
+	if (ret) {
+		rtw89_err(rtwdev, "cfg ppdu status\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtw89_wow_enable_trx_post(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_hci_disable_intr(rtwdev);
+	rtw89_hci_ctrl_trxhci(rtwdev, false);
+
+	ret = rtw89_hci_poll_txdma_ch(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to poll txdma ch idle pcie\n");
+		return ret;
+	}
+
+	ret = rtw89_wow_config_mac(rtwdev, true);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to config mac\n");
+		return ret;
+	}
+
+	rtw89_wow_set_rx_filter(rtwdev, false);
+	rtw89_hci_reset(rtwdev);
+
+	return 0;
+}
+
+static int rtw89_wow_disable_trx_pre(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_hci_clr_idx_all(rtwdev);
+
+	ret = rtw89_hci_rst_bdram(rtwdev);
+	if (ret) {
+		rtw89_warn(rtwdev, "reset bdram busy\n");
+		return ret;
+	}
+
+	rtw89_hci_ctrl_trxhci(rtwdev, true);
+	rtw89_hci_ctrl_txdma_ch(rtwdev, true);
+
+	ret = rtw89_wow_config_mac(rtwdev, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to config mac\n");
+		return ret;
+	}
+	rtw89_hci_enable_intr(rtwdev);
+
+	return 0;
+}
+
+static int rtw89_wow_disable_trx_post(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
+	if (ret)
+		rtw89_err(rtwdev, "cfg ppdu status\n");
+
+	return ret;
+}
+
+static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)rtw_wow->wow_vif->drv_priv;
+	int ret;
+
+	ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, true);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to enable keep alive\n");
+		return ret;
+	}
+
+	ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif, true);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to enable disconnect detect\n");
+		goto out;
+	}
+
+	ret = rtw89_wow_cfg_wake(rtwdev, true);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to config wake\n");
+		goto out;
+	}
+
+	ret = rtw89_wow_check_fw_status(rtwdev, true);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to check enable fw ready\n");
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)rtw_wow->wow_vif->drv_priv;
+	int ret;
+
+	ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, false);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to disable keep alive\n");
+		goto out;
+	}
+
+	rtw89_wow_release_pkt_list(rtwdev);
+
+	ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif, false);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to disable disconnect detect\n");
+		goto out;
+	}
+
+	ret = rtw89_wow_cfg_wake(rtwdev, false);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to disable config wake\n");
+		goto out;
+	}
+
+	ret = rtw89_wow_check_fw_status(rtwdev, false);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to check disable fw ready\n");
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+static int rtw89_wow_enable(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	set_bit(RTW89_FLAG_WOWLAN, rtwdev->flags);
+
+	ret = rtw89_wow_enable_trx_pre(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to enable trx_pre\n");
+		goto out;
+	}
+
+	rtw89_wow_swap_fw(rtwdev, true);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to swap to wow fw\n");
+		goto out;
+	}
+
+	rtw89_wow_fw_start(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to let wow fw start\n");
+		goto out;
+	}
+
+	rtw89_wow_enter_lps(rtwdev);
+
+	rtw89_wow_enable_trx_post(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to enable trx_post\n");
+		goto out;
+	}
+
+	return 0;
+
+out:
+	clear_bit(RTW89_FLAG_WOWLAN, rtwdev->flags);
+	return ret;
+}
+
+static int rtw89_wow_disable(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = rtw89_wow_disable_trx_pre(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to disable trx_pre\n");
+		goto out;
+	}
+
+	rtw89_wow_leave_lps(rtwdev);
+
+	ret = rtw89_wow_fw_stop(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to swap to normal fw\n");
+		goto out;
+	}
+
+	ret = rtw89_wow_swap_fw(rtwdev, false);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to disable trx_post\n");
+		goto out;
+	}
+
+	ret = rtw89_wow_disable_trx_post(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to disable trx_pre\n");
+		goto out;
+	}
+
+out:
+	clear_bit(RTW89_FLAG_WOWLAN, rtwdev->flags);
+	return ret;
+}
+
+int rtw89_wow_resume(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	if (!test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags)) {
+		rtw89_err(rtwdev, "wow is not enabled\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+	if (!rtw89_mac_get_power_state(rtwdev)) {
+		rtw89_err(rtwdev, "chip is no power when resume\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+	rtw89_wow_leave_deep_ps(rtwdev);
+
+	rtw89_wow_show_wakeup_reason(rtwdev);
+
+	ret = rtw89_wow_disable(rtwdev);
+	if (ret)
+		rtw89_err(rtwdev, "failed to disable wow\n");
+
+out:
+	rtw89_wow_clear_wakeups(rtwdev);
+	return ret;
+}
+
+int rtw89_wow_suspend(struct rtw89_dev *rtwdev, struct cfg80211_wowlan *wowlan)
+{
+	int ret;
+
+	ret = rtw89_wow_set_wakeups(rtwdev, wowlan);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to set wakeup event\n");
+		return ret;
+	}
+
+	rtw89_wow_leave_lps(rtwdev);
+
+	ret = rtw89_wow_enable(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to enable wow\n");
+		return ret;
+	}
+
+	rtw89_wow_enter_deep_ps(rtwdev);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
new file mode 100644
index 0000000000000..a2f7b2e3cdb4d
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#ifndef __RTW89_WOW_H__
+#define __RTW89_WOW_H__
+
+enum rtw89_wake_reason {
+	RTW89_WOW_RSN_RX_PTK_REKEY = 0x1,
+	RTW89_WOW_RSN_RX_GTK_REKEY = 0x2,
+	RTW89_WOW_RSN_RX_DEAUTH = 0x8,
+	RTW89_WOW_RSN_DISCONNECT = 0x10,
+	RTW89_WOW_RSN_RX_MAGIC_PKT = 0x21,
+	RTW89_WOW_RSN_RX_PATTERN_MATCH = 0x23,
+	RTW89_WOW_RSN_RX_NLO = 0x55,
+};
+
+int rtw89_wow_suspend(struct rtw89_dev *rtwdev, struct cfg80211_wowlan *wowlan);
+int rtw89_wow_resume(struct rtw89_dev *rtwdev);
+
+#endif
-- 
2.25.1

