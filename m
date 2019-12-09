Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9426311677A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 08:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfLIHV5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 02:21:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46350 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfLIHVw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 02:21:52 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB97Lj6r018991, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB97Lj6r018991
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 9 Dec 2019 15:21:46 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 9 Dec 2019 15:21:45 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 4/6] rtw88: support wowlan feature for 8822c
Date:   Mon, 9 Dec 2019 15:21:37 +0800
Message-ID: <20191209072139.26068-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209072139.26068-1-yhchuang@realtek.com>
References: <20191209072139.26068-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Wake on WLAN(wowlan) is a feature which allows devices
to be woken up from suspend state through wlan events.

When user enables wowlan feature and then let the device
enter suspend state, wowlan firmware will be loaded by
the driver and periodically monitors wifi packets.
Power consumption of wifi chip will be reduced in this
state.

If wowlan firmware detects that specific wlan event
happens, it will issue wakeup signal to trigger resume
process. Driver will load normal firmware and let wifi
chip return to the original state.

Currently supported wlan events include receiving magic packet,
rekey packet and deauth packet, and disconnecting from AP.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
 * no change

 drivers/net/wireless/realtek/rtw88/Makefile   |   1 +
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/fw.c       |  86 +++
 drivers/net/wireless/realtek/rtw88/fw.h       |  69 +++
 drivers/net/wireless/realtek/rtw88/mac80211.c |  44 ++
 drivers/net/wireless/realtek/rtw88/main.c     |   3 +
 drivers/net/wireless/realtek/rtw88/main.h     |  18 +
 drivers/net/wireless/realtek/rtw88/pci.c      |  18 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  13 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  12 +
 drivers/net/wireless/realtek/rtw88/util.h     |   2 +
 drivers/net/wireless/realtek/rtw88/wow.c      | 531 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/wow.h      |  38 ++
 13 files changed, 836 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/wow.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/wow.h

diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 15e12155a04c..cac148d13cf1 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -15,6 +15,7 @@ rtw88-y += main.o \
 	   ps.o \
 	   sec.o \
 	   bf.o \
+	   wow.o \
 	   regd.o
 
 rtw88-$(CONFIG_RTW88_8822BE)	+= rtw8822b.o rtw8822b_table.o
diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index cd28f675e9cb..a0f36f29b4a6 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -18,6 +18,7 @@ enum rtw_debug_mask {
 	RTW_DBG_DEBUGFS		= 0x00000200,
 	RTW_DBG_PS		= 0x00000400,
 	RTW_DBG_BF		= 0x00000800,
+	RTW_DBG_WOW		= 0x00001000,
 
 	RTW_DBG_ALL		= 0xffffffff
 };
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index b8c581161f61..16ff59576154 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -10,6 +10,7 @@
 #include "sec.h"
 #include "debug.h"
 #include "util.h"
+#include "wow.h"
 
 static void rtw_fw_c2h_cmd_handle_ext(struct rtw_dev *rtwdev,
 				      struct sk_buff *skb)
@@ -482,6 +483,91 @@ void rtw_fw_set_pwr_mode(struct rtw_dev *rtwdev)
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
+void rtw_fw_set_keep_alive_cmd(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+	struct rtw_fw_wow_keep_alive_para mode = {
+		.adopt = true,
+		.pkt_type = KEEP_ALIVE_NULL_PKT,
+		.period = 5,
+	};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_KEEP_ALIVE);
+	SET_KEEP_ALIVE_ENABLE(h2c_pkt, enable);
+	SET_KEEP_ALIVE_ADOPT(h2c_pkt, mode.adopt);
+	SET_KEEP_ALIVE_PKT_TYPE(h2c_pkt, mode.pkt_type);
+	SET_KEEP_ALIVE_CHECK_PERIOD(h2c_pkt, mode.period);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_set_disconnect_decision_cmd(struct rtw_dev *rtwdev, bool enable)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+	struct rtw_fw_wow_disconnect_para mode = {
+		.adopt = true,
+		.period = 30,
+		.retry_count = 5,
+	};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_DISCONNECT_DECISION);
+
+	if (test_bit(RTW_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags)) {
+		SET_DISCONNECT_DECISION_ENABLE(h2c_pkt, enable);
+		SET_DISCONNECT_DECISION_ADOPT(h2c_pkt, mode.adopt);
+		SET_DISCONNECT_DECISION_CHECK_PERIOD(h2c_pkt, mode.period);
+		SET_DISCONNECT_DECISION_TRY_PKT_NUM(h2c_pkt, mode.retry_count);
+	}
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_set_wowlan_ctrl_cmd(struct rtw_dev *rtwdev, bool enable)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_WOWLAN);
+
+	SET_WOWLAN_FUNC_ENABLE(h2c_pkt, enable);
+	if (rtw_wow_mgd_linked(rtwdev)) {
+		if (test_bit(RTW_WOW_FLAG_EN_MAGIC_PKT, rtw_wow->flags))
+			SET_WOWLAN_MAGIC_PKT_ENABLE(h2c_pkt, enable);
+		if (test_bit(RTW_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags))
+			SET_WOWLAN_DEAUTH_WAKEUP_ENABLE(h2c_pkt, enable);
+		if (test_bit(RTW_WOW_FLAG_EN_REKEY_PKT, rtw_wow->flags))
+			SET_WOWLAN_REKEY_WAKEUP_ENABLE(h2c_pkt, enable);
+	}
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_set_aoac_global_info_cmd(struct rtw_dev *rtwdev,
+				     u8 pairwise_key_enc,
+				     u8 group_key_enc)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_AOAC_GLOBAL_INFO);
+
+	SET_AOAC_GLOBAL_INFO_PAIRWISE_ENC_ALG(h2c_pkt, pairwise_key_enc);
+	SET_AOAC_GLOBAL_INFO_GROUP_ENC_ALG(h2c_pkt, group_key_enc);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
+void rtw_fw_set_remote_wake_ctrl_cmd(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_REMOTE_WAKE_CTRL);
+
+	SET_REMOTE_WAKECTRL_ENABLE(h2c_pkt, enable);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
 static u8 rtw_get_rsvd_page_location(struct rtw_dev *rtwdev,
 				     enum rtw_rsvd_packet_type type)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 73d1b9ca8efc..9ffc1b1ea895 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -100,6 +100,23 @@ struct rtw_rsvd_page {
 	bool add_txdesc;
 };
 
+enum rtw_keep_alive_pkt_type {
+	KEEP_ALIVE_NULL_PKT = 0,
+	KEEP_ALIVE_ARP_RSP = 1,
+};
+
+struct rtw_fw_wow_keep_alive_para {
+	bool adopt;
+	u8 pkt_type;
+	u8 period;		/* unit: sec */
+};
+
+struct rtw_fw_wow_disconnect_para {
+	bool adopt;
+	u8 period;		/* unit: sec */
+	u8 retry_count;
+};
+
 struct rtw_fw_hdr {
 	__le16 signature;
 	u8 category;
@@ -198,6 +215,11 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_QUERY_BT_MP_INFO	0x67
 #define H2C_CMD_BT_WIFI_CONTROL		0x69
 
+#define H2C_CMD_KEEP_ALIVE		0x03
+#define H2C_CMD_DISCONNECT_DECISION	0x04
+#define H2C_CMD_WOWLAN			0x80
+#define H2C_CMD_REMOTE_WAKE_CTRL	0x81
+#define H2C_CMD_AOAC_GLOBAL_INFO	0x82
 #define SET_H2C_CMD_ID_CLASS(h2c_pkt, value)				       \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(7, 0))
 
@@ -301,6 +323,45 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define SET_BT_WIFI_CONTROL_DATA5(h2c_pkt, value)                              \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(23, 16))
 
+#define SET_KEEP_ALIVE_ENABLE(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define SET_KEEP_ALIVE_ADOPT(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(9))
+#define SET_KEEP_ALIVE_PKT_TYPE(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(10))
+#define SET_KEEP_ALIVE_CHECK_PERIOD(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+
+#define SET_DISCONNECT_DECISION_ENABLE(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define SET_DISCONNECT_DECISION_ADOPT(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(9))
+#define SET_DISCONNECT_DECISION_CHECK_PERIOD(h2c_pkt, value)		       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+#define SET_DISCONNECT_DECISION_TRY_PKT_NUM(h2c_pkt, value)		       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(31, 24))
+
+#define SET_WOWLAN_FUNC_ENABLE(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define SET_WOWLAN_MAGIC_PKT_ENABLE(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(10))
+#define SET_WOWLAN_UNICAST_PKT_ENABLE(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(11))
+#define SET_WOWLAN_REKEY_WAKEUP_ENABLE(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(14))
+#define SET_WOWLAN_DEAUTH_WAKEUP_ENABLE(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(15))
+
+#define SET_REMOTE_WAKECTRL_ENABLE(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
+#define SET_REMOTE_WAKE_CTRL_NLO_OFFLOAD_EN(h2c_pkt, value)		       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(12))
+
+#define SET_AOAC_GLOBAL_INFO_PAIRWISE_ENC_ALG(h2c_pkt, value)		       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
+#define SET_AOAC_GLOBAL_INFO_GROUP_ENC_ALG(h2c_pkt, value)		       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+
 static inline struct rtw_c2h_cmd *get_c2h_from_skb(struct sk_buff *skb)
 {
 	u32 pkt_offset;
@@ -340,4 +401,12 @@ int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev,
 void rtw_send_rsvd_page_h2c(struct rtw_dev *rtwdev);
 int rtw_dump_drv_rsvd_page(struct rtw_dev *rtwdev,
 			   u32 offset, u32 size, u32 *buf);
+void rtw_fw_set_remote_wake_ctrl_cmd(struct rtw_dev *rtwdev, bool enable);
+void rtw_fw_set_wowlan_ctrl_cmd(struct rtw_dev *rtwdev, bool enable);
+void rtw_fw_set_keep_alive_cmd(struct rtw_dev *rtwdev, bool enable);
+void rtw_fw_set_disconnect_decision_cmd(struct rtw_dev *rtwdev, bool enable);
+void rtw_fw_set_aoac_global_info_cmd(struct rtw_dev *rtwdev,
+				     u8 pairwise_key_enc,
+				     u8 group_key_enc);
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 34a1c3b53cd4..1150e42539a9 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -12,6 +12,7 @@
 #include "reg.h"
 #include "bf.h"
 #include "debug.h"
+#include "wow.h"
 
 static void rtw_ops_tx(struct ieee80211_hw *hw,
 		       struct ieee80211_tx_control *control,
@@ -735,6 +736,44 @@ static int rtw_ops_set_bitrate_mask(struct ieee80211_hw *hw,
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int rtw_ops_suspend(struct ieee80211_hw *hw,
+			   struct cfg80211_wowlan *wowlan)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	int ret;
+
+	mutex_lock(&rtwdev->mutex);
+	ret = rtw_wow_suspend(rtwdev, wowlan);
+	if (ret)
+		rtw_err(rtwdev, "failed to suspend for wow %d\n", ret);
+	mutex_unlock(&rtwdev->mutex);
+
+	return ret ? 1 : 0;
+}
+
+static int rtw_ops_resume(struct ieee80211_hw *hw)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	int ret;
+
+	mutex_lock(&rtwdev->mutex);
+	ret = rtw_wow_resume(rtwdev);
+	if (ret)
+		rtw_err(rtwdev, "failed to resume for wow %d\n", ret);
+	mutex_unlock(&rtwdev->mutex);
+
+	return ret ? 1 : 0;
+}
+
+static void rtw_ops_set_wakeup(struct ieee80211_hw *hw, bool enabled)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+
+	device_set_wakeup_enable(rtwdev->dev, enabled);
+}
+#endif
+
 const struct ieee80211_ops rtw_ops = {
 	.tx			= rtw_ops_tx,
 	.wake_tx_queue		= rtw_ops_wake_tx_queue,
@@ -757,5 +796,10 @@ const struct ieee80211_ops rtw_ops = {
 	.sta_statistics		= rtw_ops_sta_statistics,
 	.flush			= rtw_ops_flush,
 	.set_bitrate_mask	= rtw_ops_set_bitrate_mask,
+#ifdef CONFIG_PM
+	.suspend		= rtw_ops_suspend,
+	.resume			= rtw_ops_resume,
+	.set_wakeup		= rtw_ops_set_wakeup,
+#endif
 };
 EXPORT_SYMBOL(rtw_ops);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 54e8a0cef14b..1ac48ccdb3c8 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1493,6 +1493,9 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 
+#ifdef CONFIG_PM
+	hw->wiphy->wowlan = rtwdev->chip->wowlan_stub;
+#endif
 	rtw_set_supported_band(hw, rtwdev->chip);
 	SET_IEEE80211_PERM_ADDR(hw, rtwdev->efuse.addr);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b7690666fd57..e403d24adbcf 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -342,6 +342,7 @@ enum rtw_flags {
 	RTW_FLAG_LEISURE_PS_DEEP,
 	RTW_FLAG_DIG_DISABLE,
 	RTW_FLAG_BUSY_TRAFFIC,
+	RTW_FLAG_WOWLAN,
 
 	NUM_OF_RTW_FLAGS,
 };
@@ -372,6 +373,15 @@ enum rtw_snr {
 	RTW_SNR_NUM
 };
 
+enum rtw_wow_flags {
+	RTW_WOW_FLAG_EN_MAGIC_PKT,
+	RTW_WOW_FLAG_EN_REKEY_PKT,
+	RTW_WOW_FLAG_EN_DISCONNECT,
+
+	/* keep it last */
+	RTW_WOW_FLAG_MAX,
+};
+
 /* the power index is represented by differences, which cck-1s & ht40-1s are
  * the base values, so for 1s's differences, there are only ht20 & ofdm
  */
@@ -907,6 +917,12 @@ struct rtw_intf_phy_para {
 	u16 platform;
 };
 
+struct rtw_wow_param {
+	struct ieee80211_vif *wow_vif;
+	DECLARE_BITMAP(flags, RTW_WOW_FLAG_MAX);
+	u8 txpause;
+};
+
 struct rtw_intf_phy_para_table {
 	struct rtw_intf_phy_para *usb2_para;
 	struct rtw_intf_phy_para *usb3_para;
@@ -1036,6 +1052,7 @@ struct rtw_chip_info {
 	u8 bfer_mu_max_num;
 
 	const char *wow_fw_name;
+	const struct wiphy_wowlan_support *wowlan_stub;
 
 	/* coex paras */
 	u32 coex_para_ver;
@@ -1589,6 +1606,7 @@ struct rtw_dev {
 	u8 mp_mode;
 
 	struct rtw_fw_state wow_fw;
+	struct rtw_wow_param wow;
 
 	/* hci related data, must be last */
 	u8 priv[0] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index c394df494c95..ed9ee4666216 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1266,6 +1266,23 @@ static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
 	rtw_pci_link_cfg(rtwdev);
 }
 
+#ifdef CONFIG_PM
+static int rtw_pci_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int rtw_pci_resume(struct device *dev)
+{
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rtw_pm_ops, rtw_pci_suspend, rtw_pci_resume);
+#define RTW_PM_OPS (&rtw_pm_ops)
+#else
+#define RTW_PM_OPS NULL
+#endif
+
 static int rtw_pci_claim(struct rtw_dev *rtwdev, struct pci_dev *pdev)
 {
 	int ret;
@@ -1491,6 +1508,7 @@ static struct pci_driver rtw_pci_driver = {
 	.id_table = rtw_pci_id_table,
 	.probe = rtw_pci_probe,
 	.remove = rtw_pci_remove,
+	.driver.pm = RTW_PM_OPS,
 };
 module_pci_driver(rtw_pci_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 7e817bc997eb..d09208a53b54 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -9,6 +9,8 @@
 #define BIT_FEN_CPUEN		BIT(2)
 #define BIT_FEN_BB_GLB_RST	BIT(1)
 #define BIT_FEN_BB_RSTB		BIT(0)
+#define BIT_R_DIS_PRST		BIT(6)
+#define BIT_WLOCK_1C_B6		BIT(5)
 #define REG_SYS_PW_CTRL		0x0004
 #define REG_SYS_CLK_CTRL	0x0008
 #define BIT_CPU_CLK_EN		BIT(14)
@@ -160,8 +162,12 @@
 #define REG_CR			0x0100
 #define REG_TRXFF_BNDY		0x0114
 #define REG_RXFF_BNDY		0x011C
+#define REG_FE1IMR		0x0120
+#define BIT_FS_RXDONE		BIT(16)
 #define REG_PKTBUF_DBG_CTRL	0x0140
 #define REG_C2HEVT		0x01A0
+#define REG_MCUTST_II		0x01C4
+#define REG_WOWLAN_WAKE_REASON	0x01C7
 #define REG_HMETFR		0x01CC
 #define REG_HMEBOX0		0x01D0
 #define REG_HMEBOX1		0x01D4
@@ -192,9 +198,16 @@
 #define REG_H2C_TAIL		0x0248
 #define REG_H2C_READ_ADDR	0x024C
 #define REG_H2C_INFO		0x0254
+#define REG_RXPKT_NUM		0x0284
+#define BIT_RXDMA_REQ		BIT(19)
+#define BIT_RW_RELEASE		BIT(18)
+#define BIT_RXDMA_IDLE		BIT(17)
+#define REG_RXPKTNUM		0x02B0
 
 #define REG_INT_MIG		0x0304
 
+#define REG_BCNQ_INFO		0x0418
+#define BIT_MGQ_CPU_EMPTY	BIT(24)
 #define REG_FWHW_TXQ_CTRL	0x0420
 #define BIT_EN_BCNQ_DL		BIT(22)
 #define BIT_EN_WR_FREE_TAIL	BIT(20)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 174029836833..e10fe672f79c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4060,6 +4060,13 @@ static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
 	.pwrtrk_2g_ccka_p = rtw8822c_pwrtrk_2g_cck_a_p,
 };
 
+#ifdef CONFIG_PM
+static const struct wiphy_wowlan_support rtw_wowlan_stub_8822c = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_GTK_REKEY_FAILURE |
+		 WIPHY_WOWLAN_DISCONNECT | WIPHY_WOWLAN_SUPPORTS_GTK_REKEY,
+};
+#endif
+
 struct rtw_chip_info rtw8822c_hw_spec = {
 	.ops = &rtw8822c_ops,
 	.id = RTW_CHIP_TYPE_8822C,
@@ -4106,6 +4113,10 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
 
+#ifdef CONFIG_PM
+	.wow_fw_name = "rtw88/rtw8822c_wow_fw.bin",
+	.wowlan_stub = &rtw_wowlan_stub_8822c,
+#endif
 	.coex_para_ver = 0x19062706,
 	.bt_desired_ver = 0x6,
 	.scbd_support = true,
@@ -4135,3 +4146,4 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 EXPORT_SYMBOL(rtw8822c_hw_spec);
 
 MODULE_FIRMWARE("rtw88/rtw8822c_fw.bin");
+MODULE_FIRMWARE("rtw88/rtw8822c_wow_fw.bin");
diff --git a/drivers/net/wireless/realtek/rtw88/util.h b/drivers/net/wireless/realtek/rtw88/util.h
index 7bd2843b0bce..41c10e7144df 100644
--- a/drivers/net/wireless/realtek/rtw88/util.h
+++ b/drivers/net/wireless/realtek/rtw88/util.h
@@ -15,6 +15,8 @@ struct rtw_dev;
 			IEEE80211_IFACE_ITER_NORMAL, iterator, data)
 #define rtw_iterate_stas_atomic(rtwdev, iterator, data)                        \
 	ieee80211_iterate_stations_atomic(rtwdev->hw, iterator, data)
+#define rtw_iterate_keys(rtwdev, vif, iterator, data)			       \
+	ieee80211_iter_keys(rtwdev->hw, vif, iterator, data)
 
 static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
new file mode 100644
index 000000000000..e1657d3cb615
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include "main.h"
+#include "fw.h"
+#include "wow.h"
+#include "reg.h"
+#include "debug.h"
+#include "mac.h"
+#include "ps.h"
+
+static void rtw_wow_show_wakeup_reason(struct rtw_dev *rtwdev)
+{
+	u8 reason;
+
+	reason = rtw_read8(rtwdev, REG_WOWLAN_WAKE_REASON);
+
+	if (reason == RTW_WOW_RSN_RX_DEAUTH)
+		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx deauth\n");
+	else if (reason == RTW_WOW_RSN_DISCONNECT)
+		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: AP is off\n");
+	else if (reason == RTW_WOW_RSN_RX_MAGIC_PKT)
+		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx magic packet\n");
+	else if (reason == RTW_WOW_RSN_RX_GTK_REKEY)
+		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx gtk rekey\n");
+	else if (reason == RTW_WOW_RSN_RX_PTK_REKEY)
+		rtw_dbg(rtwdev, RTW_DBG_WOW, "WOW: Rx ptk rekey\n");
+	else
+		rtw_warn(rtwdev, "Unknown wakeup reason %x\n", reason);
+}
+
+static void rtw_wow_bb_stop(struct rtw_dev *rtwdev)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+
+	/* wait 100ms for firmware to finish TX */
+	msleep(100);
+
+	if (!rtw_read32_mask(rtwdev, REG_BCNQ_INFO, BIT_MGQ_CPU_EMPTY))
+		rtw_warn(rtwdev, "Wrong status of MGQ_CPU empty!\n");
+
+	rtw_wow->txpause = rtw_read8(rtwdev, REG_TXPAUSE);
+	rtw_write8(rtwdev, REG_TXPAUSE, 0xff);
+	rtw_write8_clr(rtwdev, REG_SYS_FUNC_EN, BIT_FEN_BB_RSTB);
+}
+
+static void rtw_wow_bb_start(struct rtw_dev *rtwdev)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+
+	rtw_write8_set(rtwdev, REG_SYS_FUNC_EN, BIT_FEN_BB_RSTB);
+	rtw_write8(rtwdev, REG_TXPAUSE, rtw_wow->txpause);
+}
+
+static void rtw_wow_rx_dma_stop(struct rtw_dev *rtwdev)
+{
+	/* wait 100ms for HW to finish rx dma */
+	msleep(100);
+
+	rtw_write32_set(rtwdev, REG_RXPKT_NUM, BIT_RW_RELEASE);
+
+	if (!check_hw_ready(rtwdev, REG_RXPKT_NUM, BIT_RXDMA_IDLE, 1))
+		rtw_err(rtwdev, "failed to stop rx dma\n");
+}
+
+static void rtw_wow_rx_dma_start(struct rtw_dev *rtwdev)
+{
+	rtw_write32_clr(rtwdev, REG_RXPKT_NUM, BIT_RW_RELEASE);
+}
+
+static bool rtw_wow_check_fw_status(struct rtw_dev *rtwdev, bool wow_enable)
+{
+	bool ret;
+
+	/* wait 100ms for wow firmware to finish work */
+	msleep(100);
+
+	if (wow_enable) {
+		if (!rtw_read8(rtwdev, REG_WOWLAN_WAKE_REASON))
+			ret = 0;
+	} else {
+		if (rtw_read32_mask(rtwdev, REG_FE1IMR, BIT_FS_RXDONE) == 0 &&
+		    rtw_read32_mask(rtwdev, REG_RXPKT_NUM, BIT_RW_RELEASE) == 0)
+			ret = 0;
+	}
+
+	if (ret)
+		rtw_err(rtwdev, "failed to check wow status %s\n",
+			wow_enable ? "enabled" : "disabled");
+
+	return ret;
+}
+
+static void rtw_wow_fw_security_type_iter(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif,
+					  struct ieee80211_sta *sta,
+					  struct ieee80211_key_conf *key,
+					  void *data)
+{
+	struct rtw_fw_key_type_iter_data *iter_data = data;
+	struct rtw_dev *rtwdev = hw->priv;
+	u8 hw_key_type;
+
+	if (vif != rtwdev->wow.wow_vif)
+		return;
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		hw_key_type = RTW_CAM_WEP40;
+		break;
+	case WLAN_CIPHER_SUITE_WEP104:
+		hw_key_type = RTW_CAM_WEP104;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		hw_key_type = RTW_CAM_TKIP;
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIC;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+		hw_key_type = RTW_CAM_AES;
+		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
+		break;
+	default:
+		rtw_err(rtwdev, "Unsupported key type for wowlan mode\n");
+		hw_key_type = 0;
+		break;
+	}
+
+	if (sta)
+		iter_data->pairwise_key_type = hw_key_type;
+	else
+		iter_data->group_key_type = hw_key_type;
+}
+
+static void rtw_wow_fw_security_type(struct rtw_dev *rtwdev)
+{
+	struct rtw_fw_key_type_iter_data data = {};
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+
+	data.rtwdev = rtwdev;
+	rtw_iterate_keys(rtwdev, wow_vif,
+			 rtw_wow_fw_security_type_iter, &data);
+	rtw_fw_set_aoac_global_info_cmd(rtwdev, data.pairwise_key_type,
+					data.group_key_type);
+}
+
+static int rtw_wow_fw_start(struct rtw_dev *rtwdev)
+{
+	if (rtw_wow_mgd_linked(rtwdev)) {
+		rtw_send_rsvd_page_h2c(rtwdev);
+		rtw_wow_fw_security_type(rtwdev);
+		rtw_fw_set_disconnect_decision_cmd(rtwdev, true);
+		rtw_fw_set_keep_alive_cmd(rtwdev, true);
+	}
+
+	rtw_fw_set_wowlan_ctrl_cmd(rtwdev, true);
+	rtw_fw_set_remote_wake_ctrl_cmd(rtwdev, true);
+
+	return rtw_wow_check_fw_status(rtwdev, true);
+}
+
+static int rtw_wow_fw_stop(struct rtw_dev *rtwdev)
+{
+	if (rtw_wow_mgd_linked(rtwdev)) {
+		rtw_fw_set_disconnect_decision_cmd(rtwdev, false);
+		rtw_fw_set_keep_alive_cmd(rtwdev, false);
+	}
+
+	rtw_fw_set_wowlan_ctrl_cmd(rtwdev, false);
+	rtw_fw_set_remote_wake_ctrl_cmd(rtwdev, false);
+
+	return rtw_wow_check_fw_status(rtwdev, false);
+}
+
+static void rtw_wow_avoid_reset_mac(struct rtw_dev *rtwdev)
+{
+	/* When resuming from wowlan mode, some hosts issue signal
+	 * (PCIE: PREST, USB: SE0RST) to device, and lead to reset
+	 * mac core. If it happens, the connection to AP will be lost.
+	 * Setting REG_RSV_CTRL Register can avoid this process.
+	 */
+	switch (rtw_hci_type(rtwdev)) {
+	case RTW_HCI_TYPE_PCIE:
+	case RTW_HCI_TYPE_USB:
+		rtw_write8(rtwdev, REG_RSV_CTRL, BIT_WLOCK_1C_B6);
+		rtw_write8(rtwdev, REG_RSV_CTRL,
+			   BIT_WLOCK_1C_B6 | BIT_R_DIS_PRST);
+		break;
+	default:
+		rtw_warn(rtwdev, "Unsupported hci type to disable reset MAC\n");
+		break;
+	}
+}
+
+static void rtw_wow_fw_media_status_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	struct rtw_fw_media_status_iter_data *iter_data = data;
+	struct rtw_dev *rtwdev = iter_data->rtwdev;
+
+	rtw_fw_media_status_report(rtwdev, si->mac_id, iter_data->connect);
+}
+
+static void rtw_wow_fw_media_status(struct rtw_dev *rtwdev, bool connect)
+{
+	struct rtw_fw_media_status_iter_data data;
+
+	data.rtwdev = rtwdev;
+	data.connect = connect;
+
+	rtw_iterate_stas_atomic(rtwdev, rtw_wow_fw_media_status_iter, &data);
+}
+
+void __rtw_wow_config_linked_rsvd_page(struct rtw_dev *rtwdev)
+{
+	rtw_add_rsvd_page(rtwdev, RSVD_PS_POLL, true);
+	rtw_add_rsvd_page(rtwdev, RSVD_QOS_NULL, true);
+	rtw_add_rsvd_page(rtwdev, RSVD_NULL, true);
+	rtw_add_rsvd_page(rtwdev, RSVD_LPS_PG_DPK, true);
+	rtw_add_rsvd_page(rtwdev, RSVD_LPS_PG_INFO, true);
+}
+
+static void rtw_wow_config_rsvd_page(struct rtw_dev *rtwdev)
+{
+	rtw_reset_rsvd_page(rtwdev);
+
+	if (rtw_wow_mgd_linked(rtwdev))
+		__rtw_wow_config_linked_rsvd_page(rtwdev);
+}
+
+static int rtw_wow_dl_fw_rsvd_page(struct rtw_dev *rtwdev)
+{
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+
+	rtw_wow_config_rsvd_page(rtwdev);
+
+	return rtw_fw_download_rsvd_page(rtwdev, wow_vif);
+}
+
+static int rtw_wow_swap_fw(struct rtw_dev *rtwdev, enum rtw_fw_type type)
+{
+	struct rtw_fw_state *fw;
+	int ret;
+
+	switch (type) {
+	case RTW_WOWLAN_FW:
+		fw = &rtwdev->wow_fw;
+		break;
+
+	case RTW_NORMAL_FW:
+		fw = &rtwdev->fw;
+		break;
+
+	default:
+		rtw_warn(rtwdev, "unsupported firmware type to swap\n");
+		return -ENOENT;
+	}
+
+	ret = rtw_download_firmware(rtwdev, fw);
+	if (ret)
+		goto out;
+
+	rtw_fw_send_general_info(rtwdev);
+	rtw_fw_send_phydm_info(rtwdev);
+	rtw_wow_fw_media_status(rtwdev, true);
+
+out:
+	return ret;
+}
+
+static int __rtw_wow_leave_linked_ps(struct rtw_dev *rtwdev)
+{
+	if (!test_bit(RTW_FLAG_WOWLAN, rtwdev->flags))
+		cancel_delayed_work_sync(&rtwdev->watch_dog_work);
+
+	return 0;
+}
+
+static int rtw_wow_leave_ps(struct rtw_dev *rtwdev)
+{
+	int ret = 0;
+
+	if (rtw_wow_mgd_linked(rtwdev))
+		ret = __rtw_wow_leave_linked_ps(rtwdev);
+
+	return ret;
+}
+
+static int __rtw_wow_enter_linked_ps(struct rtw_dev *rtwdev)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)wow_vif->drv_priv;
+
+	rtw_enter_lps(rtwdev, rtwvif->port);
+
+	return 0;
+}
+
+static int rtw_wow_enter_ps(struct rtw_dev *rtwdev)
+{
+	int ret = 0;
+
+	if (rtw_wow_mgd_linked(rtwdev))
+		ret = __rtw_wow_enter_linked_ps(rtwdev);
+
+	return ret;
+}
+
+static void rtw_wow_stop_trx(struct rtw_dev *rtwdev)
+{
+	rtw_wow_bb_stop(rtwdev);
+	rtw_wow_rx_dma_stop(rtwdev);
+}
+
+static int rtw_wow_start(struct rtw_dev *rtwdev)
+{
+	int ret;
+
+	ret = rtw_wow_fw_start(rtwdev);
+	if (ret)
+		goto out;
+
+	rtw_hci_stop(rtwdev);
+	rtw_wow_bb_start(rtwdev);
+	rtw_wow_avoid_reset_mac(rtwdev);
+
+out:
+	return ret;
+}
+
+static int rtw_wow_enable(struct rtw_dev *rtwdev)
+{
+	int ret = 0;
+
+	rtw_wow_stop_trx(rtwdev);
+
+	ret = rtw_wow_swap_fw(rtwdev, RTW_WOWLAN_FW);
+	if (ret) {
+		rtw_err(rtwdev, "failed to swap wow fw\n");
+		goto error;
+	}
+
+	set_bit(RTW_FLAG_WOWLAN, rtwdev->flags);
+
+	ret = rtw_wow_dl_fw_rsvd_page(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to download wowlan rsvd page\n");
+		goto error;
+	}
+
+	ret = rtw_wow_start(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to start wow\n");
+		goto error;
+	}
+
+	return ret;
+
+error:
+	clear_bit(RTW_FLAG_WOWLAN, rtwdev->flags);
+	return ret;
+}
+
+static int rtw_wow_stop(struct rtw_dev *rtwdev)
+{
+	int ret;
+
+	/* some HCI related registers will be reset after resume,
+	 * need to set them again.
+	 */
+	ret = rtw_hci_setup(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to setup hci\n");
+		return ret;
+	}
+
+	ret = rtw_hci_start(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to start hci\n");
+		return ret;
+	}
+
+	ret = rtw_wow_fw_stop(rtwdev);
+	if (ret)
+		rtw_err(rtwdev, "failed to stop wowlan fw\n");
+
+	rtw_wow_bb_stop(rtwdev);
+
+	return ret;
+}
+
+static void rtw_wow_resume_trx(struct rtw_dev *rtwdev)
+{
+	rtw_wow_rx_dma_start(rtwdev);
+	rtw_wow_bb_start(rtwdev);
+	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->watch_dog_work,
+				     RTW_WATCH_DOG_DELAY_TIME);
+}
+
+static int rtw_wow_disable(struct rtw_dev *rtwdev)
+{
+	int ret;
+
+	clear_bit(RTW_FLAG_WOWLAN, rtwdev->flags);
+
+	ret = rtw_wow_stop(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to stop wow\n");
+		goto out;
+	}
+
+	ret = rtw_wow_swap_fw(rtwdev, RTW_NORMAL_FW);
+	if (ret) {
+		rtw_err(rtwdev, "failed to swap normal fw\n");
+		goto out;
+	}
+
+	ret = rtw_wow_dl_fw_rsvd_page(rtwdev);
+	if (ret)
+		rtw_err(rtwdev, "failed to download normal rsvd page\n");
+
+out:
+	rtw_wow_resume_trx(rtwdev);
+	return ret;
+}
+
+static void rtw_wow_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct rtw_dev *rtwdev = data;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+
+	/* Current wowlan function support setting of only one STATION vif.
+	 * So when one suitable vif is found, stop the iteration.
+	 */
+	if (rtw_wow->wow_vif || vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	switch (rtwvif->net_type) {
+	case RTW_NET_MGD_LINKED:
+		rtw_wow->wow_vif = vif;
+		break;
+	default:
+		break;
+	}
+}
+
+static int rtw_wow_set_wakeups(struct rtw_dev *rtwdev,
+			       struct cfg80211_wowlan *wowlan)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+
+	if (wowlan->disconnect)
+		set_bit(RTW_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags);
+	if (wowlan->magic_pkt)
+		set_bit(RTW_WOW_FLAG_EN_MAGIC_PKT, rtw_wow->flags);
+	if (wowlan->gtk_rekey_failure)
+		set_bit(RTW_WOW_FLAG_EN_REKEY_PKT, rtw_wow->flags);
+
+	rtw_iterate_vifs_atomic(rtwdev, rtw_wow_vif_iter, rtwdev);
+	if (!rtw_wow->wow_vif)
+		return -EPERM;
+
+	return 0;
+}
+
+static void rtw_wow_clear_wakeups(struct rtw_dev *rtwdev)
+{
+	struct rtw_wow_param *rtw_wow = &rtwdev->wow;
+
+	memset(rtw_wow, 0, sizeof(rtwdev->wow));
+}
+
+int rtw_wow_suspend(struct rtw_dev *rtwdev, struct cfg80211_wowlan *wowlan)
+{
+	int ret = 0;
+
+	ret = rtw_wow_set_wakeups(rtwdev, wowlan);
+	if (ret) {
+		rtw_err(rtwdev, "failed to set wakeup event\n");
+		goto out;
+	}
+
+	ret = rtw_wow_leave_ps(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to leave ps from normal mode\n");
+		goto out;
+	}
+
+	ret = rtw_wow_enable(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to enable wow\n");
+		goto out;
+	}
+
+	ret = rtw_wow_enter_ps(rtwdev);
+	if (ret)
+		rtw_err(rtwdev, "failed to enter ps for wow\n");
+
+out:
+	return ret;
+}
+
+int rtw_wow_resume(struct rtw_dev *rtwdev)
+{
+	int ret;
+
+	/* If wowlan mode is not enabled, do nothing */
+	if (!test_bit(RTW_FLAG_WOWLAN, rtwdev->flags)) {
+		rtw_err(rtwdev, "wow is not enabled\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+	ret = rtw_wow_leave_ps(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to leave ps from wowlan mode\n");
+		goto out;
+	}
+
+	rtw_wow_show_wakeup_reason(rtwdev);
+
+	ret = rtw_wow_disable(rtwdev);
+	if (ret)
+		rtw_err(rtwdev, "failed to disable wow\n");
+
+out:
+	rtw_wow_clear_wakeups(rtwdev);
+	return ret;
+}
diff --git a/drivers/net/wireless/realtek/rtw88/wow.h b/drivers/net/wireless/realtek/rtw88/wow.h
new file mode 100644
index 000000000000..617806a2f28d
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/wow.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW_WOW_H__
+#define __RTW_WOW_H__
+
+enum rtw_wake_reason {
+	RTW_WOW_RSN_RX_PTK_REKEY = 0x1,
+	RTW_WOW_RSN_RX_GTK_REKEY = 0x2,
+	RTW_WOW_RSN_RX_DEAUTH = 0x8,
+	RTW_WOW_RSN_DISCONNECT = 0x10,
+	RTW_WOW_RSN_RX_MAGIC_PKT = 0x21,
+};
+
+struct rtw_fw_media_status_iter_data {
+	struct rtw_dev *rtwdev;
+	u8 connect;
+};
+
+struct rtw_fw_key_type_iter_data {
+	struct rtw_dev *rtwdev;
+	u8 group_key_type;
+	u8 pairwise_key_type;
+};
+
+static inline bool rtw_wow_mgd_linked(struct rtw_dev *rtwdev)
+{
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)wow_vif->drv_priv;
+
+	return (rtwvif->net_type == RTW_NET_MGD_LINKED);
+}
+
+int rtw_wow_suspend(struct rtw_dev *rtwdev, struct cfg80211_wowlan *wowlan);
+int rtw_wow_resume(struct rtw_dev *rtwdev);
+
+#endif
-- 
2.17.1

