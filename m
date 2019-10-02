Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0907EC45EF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 04:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfJBCbp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 22:31:45 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46015 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfJBCbo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 22:31:44 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x922Vbs2031857, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x922Vbs2031857
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 10:31:37 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 10:31:36 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 08/12] rtw88: add deep power save support
Date:   Wed, 2 Oct 2019 10:31:24 +0800
Message-ID: <20191002023128.12090-9-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002023128.12090-1-yhchuang@realtek.com>
References: <20191002023128.12090-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Deep power save allows firmware/hardware to operate in a
lower power state. And the deep power save mode depends on
LPS mode. So, before entering deep PS, driver must first
enter LPS mode.

Under Deep PS, most of hardware functions are shutdown,
driver will not be able to read/write registers and transfer
data to the device. Hence TX path must be protected by each
interface. Take PCI for example, DMA engine should be idle,
and no nore activities on the PCI bus.

If driver wants to operate on the device, such as register
read/write, it must first acquire the mutex lock and wake
up from Deep PS, otherwise the behavior is undefined.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
  - rebase on top of wireless-drivers-next

 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/hci.h      |   6 ++
 drivers/net/wireless/realtek/rtw88/mac80211.c |  14 +++
 drivers/net/wireless/realtek/rtw88/main.c     |   1 +
 drivers/net/wireless/realtek/rtw88/main.h     |   2 +
 drivers/net/wireless/realtek/rtw88/pci.c      |  71 +++++++++++++
 drivers/net/wireless/realtek/rtw88/ps.c       | 100 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/ps.h       |   5 +
 8 files changed, 195 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index 45851cbbd2ab..9449105f4259 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -16,6 +16,7 @@ enum rtw_debug_mask {
 	RTW_DBG_RFK		= 0x00000080,
 	RTW_DBG_REGD		= 0x00000100,
 	RTW_DBG_DEBUGFS		= 0x00000200,
+	RTW_DBG_PS		= 0x00000400,
 
 	RTW_DBG_ALL		= 0xffffffff
 };
diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index aba329c9d0cf..4afbf0d163d1 100644
--- a/drivers/net/wireless/realtek/rtw88/hci.h
+++ b/drivers/net/wireless/realtek/rtw88/hci.h
@@ -13,6 +13,7 @@ struct rtw_hci_ops {
 	int (*setup)(struct rtw_dev *rtwdev);
 	int (*start)(struct rtw_dev *rtwdev);
 	void (*stop)(struct rtw_dev *rtwdev);
+	void (*deep_ps)(struct rtw_dev *rtwdev, bool enter);
 
 	int (*write_data_rsvd_page)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
 	int (*write_data_h2c)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
@@ -47,6 +48,11 @@ static inline void rtw_hci_stop(struct rtw_dev *rtwdev)
 	rtwdev->hci.ops->stop(rtwdev);
 }
 
+static inline void rtw_hci_deep_ps(struct rtw_dev *rtwdev, bool enter)
+{
+	rtwdev->hci.ops->deep_ps(rtwdev, enter);
+}
+
 static inline int
 rtw_hci_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf, u32 size)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 984644f64610..e241d054bf0f 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -60,6 +60,8 @@ static int rtw_ops_config(struct ieee80211_hw *hw, u32 changed)
 
 	mutex_lock(&rtwdev->mutex);
 
+	rtw_leave_lps_deep(rtwdev);
+
 	if (changed & IEEE80211_CONF_CHANGE_IDLE) {
 		if (hw->conf.flags & IEEE80211_CONF_IDLE) {
 			rtw_enter_ips(rtwdev);
@@ -139,6 +141,8 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 
+	rtw_leave_lps_deep(rtwdev);
+
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
@@ -181,6 +185,8 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 
+	rtw_leave_lps_deep(rtwdev);
+
 	eth_zero_addr(rtwvif->mac_addr);
 	config |= PORT_SET_MAC_ADDR;
 	rtwvif->net_type = RTW_NET_NO_LINK;
@@ -204,6 +210,8 @@ static void rtw_ops_configure_filter(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 
+	rtw_leave_lps_deep(rtwdev);
+
 	if (changed_flags & FIF_ALLMULTI) {
 		if (*new_flags & FIF_ALLMULTI)
 			rtwdev->hal.rcr |= BIT_AM | BIT_AB;
@@ -249,6 +257,8 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 
+	rtw_leave_lps_deep(rtwdev);
+
 	if (changed & BSS_CHANGED_ASSOC) {
 		struct rtw_chip_info *chip = rtwdev->chip;
 		enum rtw_net_type net_type;
@@ -266,6 +276,7 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw_send_rsvd_page_h2c(rtwdev);
 			rtw_coex_media_status_notify(rtwdev, conf->assoc);
 		} else {
+			rtw_leave_lps(rtwdev);
 			net_type = RTW_NET_NO_LINK;
 			rtwvif->aid = 0;
 			rtw_reset_rsvd_page(rtwdev);
@@ -397,6 +408,8 @@ static int rtw_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mutex_lock(&rtwdev->mutex);
 
+	rtw_leave_lps_deep(rtwdev);
+
 	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
 		hw_key_idx = rtw_sec_get_free_cam(sec);
 	} else {
@@ -508,6 +521,7 @@ static void rtw_ops_mgd_prepare_tx(struct ieee80211_hw *hw,
 	struct rtw_dev *rtwdev = hw->priv;
 
 	mutex_lock(&rtwdev->mutex);
+	rtw_leave_lps_deep(rtwdev);
 	rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_START);
 	mutex_unlock(&rtwdev->mutex);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 00ebf8cc81b1..0d7ad1756bd6 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -922,6 +922,7 @@ static int rtw_chip_parameter_setup(struct rtw_dev *rtwdev)
 	switch (rtw_hci_type(rtwdev)) {
 	case RTW_HCI_TYPE_PCIE:
 		rtwdev->hci.rpwm_addr = 0x03d9;
+		rtwdev->hci.cpwm_addr = 0x03da;
 		break;
 	default:
 		rtw_err(rtwdev, "unsupported hci type\n");
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 8472134c65b7..6e6b04759ace 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -50,6 +50,7 @@ struct rtw_hci {
 	enum rtw_hci_type type;
 
 	u32 rpwm_addr;
+	u32 cpwm_addr;
 
 	u8 bulkout_num;
 };
@@ -309,6 +310,7 @@ enum rtw_flags {
 	RTW_FLAG_SCANNING,
 	RTW_FLAG_INACTIVE_PS,
 	RTW_FLAG_LEISURE_PS,
+	RTW_FLAG_LEISURE_PS_DEEP,
 	RTW_FLAG_DIG_DISABLE,
 	RTW_FLAG_BUSY_TRAFFIC,
 
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 509743cfd70a..772a14d851fc 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -9,6 +9,7 @@
 #include "tx.h"
 #include "rx.h"
 #include "fw.h"
+#include "ps.h"
 #include "debug.h"
 
 static bool rtw_disable_msi;
@@ -536,6 +537,69 @@ static void rtw_pci_stop(struct rtw_dev *rtwdev)
 	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 }
 
+static void rtw_pci_deep_ps_enter(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	struct rtw_pci_tx_ring *tx_ring;
+	bool tx_empty = true;
+	u8 queue;
+
+	lockdep_assert_held(&rtwpci->irq_lock);
+
+	/* Deep PS state is not allowed to TX-DMA */
+	for (queue = 0; queue < RTK_MAX_TX_QUEUE_NUM; queue++) {
+		/* BCN queue is rsvd page, does not have DMA interrupt
+		 * H2C queue is managed by firmware
+		 */
+		if (queue == RTW_TX_QUEUE_BCN ||
+		    queue == RTW_TX_QUEUE_H2C)
+			continue;
+
+		tx_ring = &rtwpci->tx_rings[queue];
+
+		/* check if there is any skb DMAing */
+		if (skb_queue_len(&tx_ring->queue)) {
+			tx_empty = false;
+			break;
+		}
+	}
+
+	if (!tx_empty) {
+		rtw_dbg(rtwdev, RTW_DBG_PS,
+			"TX path not empty, cannot enter deep power save state\n");
+		return;
+	}
+
+	set_bit(RTW_FLAG_LEISURE_PS_DEEP, rtwdev->flags);
+	rtw_power_mode_change(rtwdev, true);
+}
+
+static void rtw_pci_deep_ps_leave(struct rtw_dev *rtwdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+
+	lockdep_assert_held(&rtwpci->irq_lock);
+
+	if (test_and_clear_bit(RTW_FLAG_LEISURE_PS_DEEP, rtwdev->flags))
+		rtw_power_mode_change(rtwdev, false);
+}
+
+static void rtw_pci_deep_ps(struct rtw_dev *rtwdev, bool enter)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+
+	if (enter && !test_bit(RTW_FLAG_LEISURE_PS_DEEP, rtwdev->flags))
+		rtw_pci_deep_ps_enter(rtwdev);
+
+	if (!enter && test_bit(RTW_FLAG_LEISURE_PS_DEEP, rtwdev->flags))
+		rtw_pci_deep_ps_leave(rtwdev);
+
+	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+}
+
 static u8 ac_to_hwq[] = {
 	[IEEE80211_AC_VO] = RTW_TX_QUEUE_VO,
 	[IEEE80211_AC_VI] = RTW_TX_QUEUE_VI,
@@ -616,6 +680,7 @@ static int rtw_pci_xmit(struct rtw_dev *rtwdev,
 	u8 *pkt_desc;
 	struct rtw_pci_tx_buffer_desc *buf_desc;
 	u32 bd_idx;
+	unsigned long flags;
 
 	ring = &rtwpci->tx_rings[queue];
 
@@ -651,6 +716,10 @@ static int rtw_pci_xmit(struct rtw_dev *rtwdev,
 	tx_data = rtw_pci_get_tx_data(skb);
 	tx_data->dma = dma;
 	tx_data->sn = pkt_info->sn;
+
+	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+
+	rtw_pci_deep_ps_leave(rtwdev);
 	skb_queue_tail(&ring->queue, skb);
 
 	/* kick off tx queue */
@@ -666,6 +735,7 @@ static int rtw_pci_xmit(struct rtw_dev *rtwdev,
 		reg_bcn_work |= BIT_PCI_BCNQ_FLAG;
 		rtw_write8(rtwdev, RTK_PCI_TXBD_BCN_WORK, reg_bcn_work);
 	}
+	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 
 	return 0;
 }
@@ -1142,6 +1212,7 @@ static struct rtw_hci_ops rtw_pci_ops = {
 	.setup = rtw_pci_setup,
 	.start = rtw_pci_start,
 	.stop = rtw_pci_stop,
+	.deep_ps = rtw_pci_deep_ps,
 
 	.read8 = rtw_pci_read8,
 	.read16 = rtw_pci_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index af5c7be2ef0f..4b5774687d21 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -3,6 +3,7 @@
  */
 
 #include "main.h"
+#include "reg.h"
 #include "fw.h"
 #include "ps.h"
 #include "mac.h"
@@ -61,6 +62,59 @@ int rtw_leave_ips(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
+{
+	u8 request, confirm, polling;
+	u8 polling_cnt;
+	u8 retry_cnt = 0;
+
+retry:
+	request = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
+	confirm = rtw_read8(rtwdev, rtwdev->hci.cpwm_addr);
+
+	/* toggle to request power mode, others remain 0 */
+	request ^= request | BIT_RPWM_TOGGLE;
+	if (!enter)
+		request |= POWER_MODE_ACK;
+	else
+		request |= POWER_MODE_LCLK;
+
+	rtw_write8(rtwdev, rtwdev->hci.rpwm_addr, request);
+
+	/* check confirm power mode has left power save state */
+	if (!enter) {
+		for (polling_cnt = 0; polling_cnt < 3; polling_cnt++) {
+			polling = rtw_read8(rtwdev, rtwdev->hci.cpwm_addr);
+			if ((polling ^ confirm) & BIT_RPWM_TOGGLE)
+				return;
+			mdelay(20);
+		}
+
+		/* in case of fw/hw missed the request, retry 3 times */
+		if (retry_cnt < 3) {
+			rtw_warn(rtwdev, "failed to leave deep PS, retry=%d\n",
+				 retry_cnt);
+			retry_cnt++;
+			goto retry;
+		}
+
+		/* Hit here means that driver failed to change hardware
+		 * power mode to active state after retry 3 times.
+		 * If the power state is locked at Deep sleep, most of
+		 * the hardware circuits is not working, even register
+		 * read/write. It should be treated as fatal error and
+		 * requires an entire analysis about the firmware/hardware
+		 */
+		WARN_ON("Hardware power state locked\n");
+	}
+}
+EXPORT_SYMBOL(rtw_power_mode_change);
+
+static void __rtw_leave_lps_deep(struct rtw_dev *rtwdev)
+{
+	rtw_hci_deep_ps(rtwdev, false);
+}
+
 static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
@@ -76,6 +130,17 @@ static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
 	rtw_coex_lps_notify(rtwdev, COEX_LPS_DISABLE);
 }
 
+static void __rtw_enter_lps_deep(struct rtw_dev *rtwdev)
+{
+	if (!test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags)) {
+		rtw_dbg(rtwdev, RTW_DBG_PS,
+			"Should enter LPS before entering deep PS\n");
+		return;
+	}
+
+	rtw_hci_deep_ps(rtwdev, true);
+}
+
 static void rtw_enter_lps_core(struct rtw_dev *rtwdev)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
@@ -91,12 +156,10 @@ static void rtw_enter_lps_core(struct rtw_dev *rtwdev)
 	set_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
 }
 
-void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id)
+static void __rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
 
-	lockdep_assert_held(&rtwdev->mutex);
-
 	if (test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
 
@@ -106,11 +169,15 @@ void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id)
 	rtw_enter_lps_core(rtwdev);
 }
 
-void rtw_leave_lps(struct rtw_dev *rtwdev)
+static void __rtw_leave_lps(struct rtw_dev *rtwdev)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	if (test_and_clear_bit(RTW_FLAG_LEISURE_PS_DEEP, rtwdev->flags)) {
+		rtw_dbg(rtwdev, RTW_DBG_PS,
+			"Should leave deep PS before leaving LPS\n");
+		__rtw_leave_lps_deep(rtwdev);
+	}
 
 	if (!test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
@@ -119,3 +186,26 @@ void rtw_leave_lps(struct rtw_dev *rtwdev)
 
 	rtw_leave_lps_core(rtwdev);
 }
+
+void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id)
+{
+	lockdep_assert_held(&rtwdev->mutex);
+
+	__rtw_enter_lps(rtwdev, port_id);
+	__rtw_enter_lps_deep(rtwdev);
+}
+
+void rtw_leave_lps(struct rtw_dev *rtwdev)
+{
+	lockdep_assert_held(&rtwdev->mutex);
+
+	__rtw_leave_lps_deep(rtwdev);
+	__rtw_leave_lps(rtwdev);
+}
+
+void rtw_leave_lps_deep(struct rtw_dev *rtwdev)
+{
+	lockdep_assert_held(&rtwdev->mutex);
+
+	__rtw_leave_lps_deep(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 5aed11b5c182..03b08bd98dc4 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -7,10 +7,15 @@
 
 #define RTW_LPS_THRESHOLD	2
 
+#define POWER_MODE_ACK		BIT(6)
+#define POWER_MODE_LCLK		BIT(0)
+
 int rtw_enter_ips(struct rtw_dev *rtwdev);
 int rtw_leave_ips(struct rtw_dev *rtwdev);
 
+void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter);
 void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id);
 void rtw_leave_lps(struct rtw_dev *rtwdev);
+void rtw_leave_lps_deep(struct rtw_dev *rtwdev);
 
 #endif
-- 
2.17.1

