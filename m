Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9DBB350C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 09:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfIPHEG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 03:04:06 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60360 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfIPHEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 03:04:05 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8G73xsP030019, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8G73xsP030019
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Sep 2019 15:04:00 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 16 Sep 2019 15:03:59 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 13/15] rtw88: select deep PS mode when module is inserted
Date:   Mon, 16 Sep 2019 15:03:43 +0800
Message-ID: <1568617425-28062-14-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Add a module parameter to select deep PS mode. And the mode
cannot be changed after the module has been inserted and probed.
If anyone wants to change the deep mode, should change the mode
and probe the device again to setup the changed deep mode.

When the device is probed, driver will check the deep PS mode
with different IC's PS mode suppotability. If none of the
PS mode is matched, the deep PS mode is changed to NONE,
means deep PS is disabled.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     | 9 +++++++++
 drivers/net/wireless/realtek/rtw88/main.h     | 8 ++++++++
 drivers/net/wireless/realtek/rtw88/ps.c       | 3 +++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 5 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 0d7ad17..3c366a3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -14,13 +14,17 @@
 #include "efuse.h"
 #include "debug.h"
 
+unsigned int rtw_fw_lps_deep_mode;
+EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
 static bool rtw_fw_support_lps;
 unsigned int rtw_debug_mask;
 EXPORT_SYMBOL(rtw_debug_mask);
 
+module_param_named(lps_deep_mode, rtw_fw_lps_deep_mode, uint, 0644);
 module_param_named(support_lps, rtw_fw_support_lps, bool, 0644);
 module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
 
+MODULE_PARM_DESC(lps_deep_mode, "Deeper PS mode. If 0, deep PS is disabled");
 MODULE_PARM_DESC(support_lps, "Set Y to enable Leisure Power Save support, to turn radio off between beacons");
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
@@ -1152,6 +1156,7 @@ EXPORT_SYMBOL(rtw_chip_info_setup);
 
 int rtw_core_init(struct rtw_dev *rtwdev)
 {
+	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	int ret;
 
@@ -1183,6 +1188,10 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	rtwdev->sec.total_cam_num = 32;
 	rtwdev->hal.current_channel = 1;
 	set_bit(RTW_BC_MC_MACID, rtwdev->mac_id_map);
+	if (!(BIT(rtw_fw_lps_deep_mode) & chip->lps_deep_mode_supported))
+		rtwdev->lps_conf.deep_mode = LPS_DEEP_MODE_NONE;
+	else
+		rtwdev->lps_conf.deep_mode = rtw_fw_lps_deep_mode;
 
 	mutex_lock(&rtwdev->mutex);
 	rtw_add_rsvd_page(rtwdev, RSVD_BEACON, false);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 6e6b047..a59cbae 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -27,6 +27,7 @@
 #define RTW_RF_PATH_MAX			4
 #define HW_FEATURE_LEN			13
 
+extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
 extern const struct ieee80211_ops rtw_ops;
 extern struct rtw_chip_info rtw8822b_hw_spec;
@@ -528,6 +529,11 @@ enum rtw_lps_mode {
 	RTW_MODE_WMM_PS	= 2,
 };
 
+enum rtw_lps_deep_mode {
+	LPS_DEEP_MODE_NONE	= 0,
+	LPS_DEEP_MODE_LCLK	= 1,
+};
+
 enum rtw_pwr_state {
 	RTW_RF_OFF	= 0x0,
 	RTW_RF_ON	= 0x4,
@@ -536,6 +542,7 @@ enum rtw_pwr_state {
 
 struct rtw_lps_conf {
 	enum rtw_lps_mode mode;
+	enum rtw_lps_deep_mode deep_mode;
 	enum rtw_pwr_state state;
 	u8 awake_interval;
 	u8 rlbm;
@@ -844,6 +851,7 @@ struct rtw_chip_info {
 
 	bool ht_supported;
 	bool vht_supported;
+	u8 lps_deep_mode_supported;
 
 	/* init values */
 	u8 sys_func_en;
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 1661cc2..02e104a 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -132,6 +132,9 @@ static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
 
 static void __rtw_enter_lps_deep(struct rtw_dev *rtwdev)
 {
+	if (rtwdev->lps_conf.deep_mode == LPS_DEEP_MODE_NONE)
+		return;
+
 	if (!test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags)) {
 		rtw_dbg(rtwdev, RTW_DBG_PS,
 			"Should enter LPS before entering deep PS\n");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 63abda3..2b6cd7cf 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1977,6 +1977,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.dig_min = 0x1c,
 	.ht_supported = true,
 	.vht_supported = true,
+	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
 	.sys_func_en = 0xDC,
 	.pwr_on_seq = card_enable_flow_8822b,
 	.pwr_off_seq = card_disable_flow_8822b,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 084c18d..b92940e5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3747,6 +3747,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.dig_min = 0x20,
 	.ht_supported = true,
 	.vht_supported = true,
+	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
 	.sys_func_en = 0xD8,
 	.pwr_on_seq = card_enable_flow_8822c,
 	.pwr_off_seq = card_disable_flow_8822c,
-- 
2.7.4

