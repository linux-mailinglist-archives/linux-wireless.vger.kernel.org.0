Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8CDB3511
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 09:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfIPHEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 03:04:11 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60344 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfIPHEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 03:04:01 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8G73tHR029983, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8G73tHR029983
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Sep 2019 15:03:55 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 16 Sep 2019 15:03:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 07/15] rtw88: not to control LPS by each vif
Date:   Mon, 16 Sep 2019 15:03:37 +0800
Message-ID: <1568617425-28062-8-git-send-email-yhchuang@realtek.com>
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

The original design of LPS enter/leave routines allows
to control the LPS state by each interface. But the
hardware cannot actually handle it that way. This means
the hardware can only enter LPS once with an associated
port, so there is no need to keep tracking the state of
each vif.

Hence the logic of enter/leave LPS state can be simple,
just to check the state of the device's flag. And for
leaving LPS state, it will get the same port id to send
to inform the hardware.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 10 ++--------
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw88/main.c     |  4 ++--
 drivers/net/wireless/realtek/rtw88/main.h     |  2 --
 drivers/net/wireless/realtek/rtw88/ps.c       | 19 +++++--------------
 drivers/net/wireless/realtek/rtw88/ps.h       |  4 ++--
 6 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 4a0b569..9d8cbd9 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -810,8 +810,6 @@ static void rtw_coex_ignore_wlan_act(struct rtw_dev *rtwdev, bool enable)
 static void rtw_coex_power_save_state(struct rtw_dev *rtwdev, u8 ps_type,
 				      u8 lps_val, u8 rpwm_val)
 {
-	struct rtw_lps_conf *lps_conf = &rtwdev->lps_conf;
-	struct rtw_vif *rtwvif;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	u8 lps_mode = 0x0;
@@ -823,18 +821,14 @@ static void rtw_coex_power_save_state(struct rtw_dev *rtwdev, u8 ps_type,
 		/* recover to original 32k low power setting */
 		coex_stat->wl_force_lps_ctrl = false;
 
-		rtwvif = lps_conf->rtwvif;
-		if (rtwvif && rtw_in_lps(rtwdev))
-			rtw_leave_lps(rtwdev, rtwvif);
+		rtw_leave_lps(rtwdev);
 		break;
 	case COEX_PS_LPS_OFF:
 		coex_stat->wl_force_lps_ctrl = true;
 		if (lps_mode)
 			rtw_fw_coex_tdma_type(rtwdev, 0x8, 0, 0, 0, 0);
 
-		rtwvif = lps_conf->rtwvif;
-		if (rtwvif && rtw_in_lps(rtwdev))
-			rtw_leave_lps(rtwdev, rtwvif);
+		rtw_leave_lps(rtwdev);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 6d5cce0..66c05c4 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -464,7 +464,7 @@ static void rtw_ops_sw_scan_start(struct ieee80211_hw *hw,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	u32 config = 0;
 
-	rtw_leave_lps(rtwdev, rtwvif);
+	rtw_leave_lps(rtwdev);
 
 	mutex_lock(&rtwdev->mutex);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 22fc5d6..85d83f1 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -181,9 +181,9 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	 */
 	if (rtw_fw_support_lps &&
 	    data.rtwvif && !data.active && data.assoc_cnt == 1)
-		rtw_enter_lps(rtwdev, data.rtwvif);
+		rtw_enter_lps(rtwdev, data.rtwvif->port);
 	else
-		rtw_leave_lps(rtwdev, rtwdev->lps_conf.rtwvif);
+		rtw_leave_lps(rtwdev);
 
 	if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
 		return;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 0955970..8472134c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -533,8 +533,6 @@ enum rtw_pwr_state {
 };
 
 struct rtw_lps_conf {
-	/* the interface to enter lps */
-	struct rtw_vif *rtwvif;
 	enum rtw_lps_mode mode;
 	enum rtw_pwr_state state;
 	u8 awake_interval;
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index ffba3bd..a154177 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -96,36 +96,27 @@ bool rtw_in_lps(struct rtw_dev *rtwdev)
 	return test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
 }
 
-void rtw_enter_lps(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
+void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
 
-	if (WARN_ON(!rtwvif))
-		return;
-
-	if (rtwvif->in_lps)
+	if (test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
 
 	conf->mode = RTW_MODE_LPS;
-	conf->rtwvif = rtwvif;
-	rtwvif->in_lps = true;
+	conf->port_id = port_id;
 
 	rtw_enter_lps_core(rtwdev);
 }
 
-void rtw_leave_lps(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
+void rtw_leave_lps(struct rtw_dev *rtwdev)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
 
-	if (WARN_ON(!rtwvif))
-		return;
-
-	if (!rtwvif->in_lps)
+	if (!test_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
 
 	conf->mode = RTW_MODE_ACTIVE;
-	conf->rtwvif = rtwvif;
-	rtwvif->in_lps = false;
 
 	rtw_leave_lps_core(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 0ac6c29..d2aae61 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -10,8 +10,8 @@
 int rtw_enter_ips(struct rtw_dev *rtwdev);
 int rtw_leave_ips(struct rtw_dev *rtwdev);
 
-void rtw_enter_lps(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif);
-void rtw_leave_lps(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif);
+void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id);
+void rtw_leave_lps(struct rtw_dev *rtwdev);
 bool rtw_in_lps(struct rtw_dev *rtwdev);
 
 #endif
-- 
2.7.4

