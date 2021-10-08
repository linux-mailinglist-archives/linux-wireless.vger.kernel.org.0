Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECBF42637E
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 05:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhJHEAX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 00:00:23 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43621 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhJHEAW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 00:00:22 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1983wOvZ5006647, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1983wOvZ5006647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Oct 2021 11:58:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 8 Oct 2021 11:58:23 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 8 Oct 2021
 11:58:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v7 22/24] rtw89: add PS files
Date:   Fri, 8 Oct 2021 11:56:25 +0800
Message-ID: <20211008035627.19463-23-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008035627.19463-1-pkshih@realtek.com>
References: <20211008035627.19463-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/08/2021 03:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEwLzcgpFWkyCAxMToyMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 10/08/2021 03:43:35
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 166592 [Oct 07 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 463 463 5854868460de3f0d8e8c0a4df98aeb05fb764a09
X-KSE-AntiSpam-Info: {Tracking_all_Bitcoin, bb}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/08/2021 03:46:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Power saving contains two main types -- IPS (idle PS) and LPS (Leisure PS).
If there's no any connection, wifi can enter IPS mode that power
consumption is the lowest. After connecting to an AP, it can only wake up
at TBTT to receive beacon to check if AP is buffering any packets; this
case is called LPS mode that the average power is low, but peak appears
at TBTT. With heavy traffic, no power saving mechanism operates, and it
costs high power in this case.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/ps.c | 150 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/ps.h |  16 +++
 2 files changed, 166 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/ps.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/ps.h

diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
new file mode 100644
index 000000000000..7eaa01e41ef2
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "coex.h"
+#include "core.h"
+#include "debug.h"
+#include "fw.h"
+#include "mac.h"
+#include "ps.h"
+#include "reg.h"
+#include "util.h"
+
+static int rtw89_fw_leave_lps_check(struct rtw89_dev *rtwdev, u8 macid)
+{
+	u32 pwr_en_bit = 0xE;
+	u32 chk_msk = pwr_en_bit << (4 * macid);
+	u32 polling;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_read32_mask, polling, !polling,
+				       1000, 50000, false, rtwdev,
+				       R_AX_PPWRBIT_SETTING, chk_msk);
+	if (ret) {
+		rtw89_info(rtwdev, "rtw89: failed to leave lps state\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev)
+{
+	if (!rtwdev->ps_mode)
+		return;
+
+	if (test_and_set_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags))
+		return;
+
+	rtw89_mac_power_mode_change(rtwdev, true);
+}
+
+void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
+{
+	if (!rtwdev->ps_mode)
+		return;
+
+	if (test_and_clear_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags))
+		rtw89_mac_power_mode_change(rtwdev, false);
+}
+
+static void __rtw89_enter_lps(struct rtw89_dev *rtwdev, u8 mac_id)
+{
+	struct rtw89_lps_parm lps_param = {
+		.macid = mac_id,
+		.psmode = RTW89_MAC_AX_PS_MODE_LEGACY,
+		.lastrpwm = RTW89_LAST_RPWM_PS,
+	};
+
+	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_FW_CTRL);
+	rtw89_fw_h2c_lps_parm(rtwdev, &lps_param);
+}
+
+static void __rtw89_leave_lps(struct rtw89_dev *rtwdev, u8 mac_id)
+{
+	struct rtw89_lps_parm lps_param = {
+		.macid = mac_id,
+		.psmode = RTW89_MAC_AX_PS_MODE_ACTIVE,
+		.lastrpwm = RTW89_LAST_RPWM_ACTIVE,
+	};
+
+	rtw89_fw_h2c_lps_parm(rtwdev, &lps_param);
+	rtw89_fw_leave_lps_check(rtwdev, 0);
+	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_ON);
+}
+
+void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
+{
+	lockdep_assert_held(&rtwdev->mutex);
+
+	__rtw89_leave_ps_mode(rtwdev);
+}
+
+void rtw89_enter_lps(struct rtw89_dev *rtwdev, u8 mac_id)
+{
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (test_and_set_bit(RTW89_FLAG_LEISURE_PS, rtwdev->flags))
+		return;
+
+	__rtw89_enter_lps(rtwdev, mac_id);
+	__rtw89_enter_ps_mode(rtwdev);
+}
+
+static void rtw89_leave_lps_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION)
+		return;
+
+	__rtw89_leave_ps_mode(rtwdev);
+	__rtw89_leave_lps(rtwdev, rtwvif->mac_id);
+}
+
+void rtw89_leave_lps(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_vif *rtwvif;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	if (!test_and_clear_bit(RTW89_FLAG_LEISURE_PS, rtwdev->flags))
+		return;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_leave_lps_vif(rtwdev, rtwvif);
+}
+
+void rtw89_enter_ips(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_vif *rtwvif;
+
+	set_bit(RTW89_FLAG_INACTIVE_PS, rtwdev->flags);
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_mac_vif_deinit(rtwdev, rtwvif);
+
+	rtw89_core_stop(rtwdev);
+}
+
+void rtw89_leave_ips(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_vif *rtwvif;
+	int ret;
+
+	ret = rtw89_core_start(rtwdev);
+	if (ret)
+		rtw89_err(rtwdev, "failed to leave idle state\n");
+
+	rtw89_set_channel(rtwdev);
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_mac_vif_init(rtwdev, rtwvif);
+
+	clear_bit(RTW89_FLAG_INACTIVE_PS, rtwdev->flags);
+}
+
+void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl)
+{
+	if (btc_ctrl)
+		rtw89_leave_lps(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
new file mode 100644
index 000000000000..a184b68994aa
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#ifndef __RTW89_PS_H_
+#define __RTW89_PS_H_
+
+void rtw89_enter_lps(struct rtw89_dev *rtwdev, u8 mac_id);
+void rtw89_leave_lps(struct rtw89_dev *rtwdev);
+void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
+void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
+void rtw89_enter_ips(struct rtw89_dev *rtwdev);
+void rtw89_leave_ips(struct rtw89_dev *rtwdev);
+void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl);
+
+#endif
-- 
2.25.1

