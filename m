Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74AC7C47CD
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfJBGfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57690 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfJBGfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:41 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZYeV013042, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926ZYeV013042
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:35 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:34 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 01/14] rtw88: check firmware leave lps successfully
Date:   Wed, 2 Oct 2019 14:35:18 +0800
Message-ID: <20191002063531.18135-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Driver needs to wait for firmware to restore hardware setting
to active mode after leaving lps.

After getting H2C from driver for leaving lps, firmware will
issue null packet without PS bit to inform AP driver is active,
and then restore REG_TCR Register if AP has receiced null packet.

But the transmission of null packet may cost much more time
in noisy environment. If driver does not wait for firmware,
null packet with PS bit could be sent due to incorrect REG_TCR setting.
And AP will be confused.

In our test, 100ms is enough for firmware to send null packet
to AP. If REG_TCR Register is still wrong after 100ms, we will
modify it directly, force the PS bit to be cleared

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/ps.c  | 29 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/ps.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/reg.h |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 83db6cf6a219..bf149956b04e 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -9,6 +9,7 @@
 #include "mac.h"
 #include "coex.h"
 #include "debug.h"
+#include "reg.h"
 
 static int rtw_ips_pwr_up(struct rtw_dev *rtwdev)
 {
@@ -118,6 +119,32 @@ static void __rtw_leave_lps_deep(struct rtw_dev *rtwdev)
 	rtw_hci_deep_ps(rtwdev, false);
 }
 
+static void rtw_fw_leave_lps_state_check(struct rtw_dev *rtwdev)
+{
+	int i;
+
+	/* Driver needs to wait for firmware to leave LPS state
+	 * successfully. Firmware will send null packet to inform AP,
+	 * and see if AP sends an ACK back, then firmware will restore
+	 * the REG_TCR register.
+	 *
+	 * If driver does not wait for firmware, null packet with
+	 * PS bit could be sent due to incorrect REG_TCR setting.
+	 *
+	 * In our test, 100ms should be enough for firmware to finish
+	 * the flow. If REG_TCR Register is still incorrect after 100ms,
+	 * just modify it directly, and throw a warn message.
+	 */
+	for (i = 0 ; i < LEAVE_LPS_TRY_CNT; i++) {
+		if (rtw_read32_mask(rtwdev, REG_TCR, BIT_PWRMGT_HWDATA_EN) == 0)
+			return;
+		msleep(20);
+	}
+
+	rtw_write32_mask(rtwdev, REG_TCR, BIT_PWRMGT_HWDATA_EN, 0);
+	rtw_warn(rtwdev, "firmware failed to restore hardware setting\n");
+}
+
 static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
@@ -128,6 +155,8 @@ static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
 	conf->smart_ps = 0;
 
 	rtw_fw_set_pwr_mode(rtwdev);
+	rtw_fw_leave_lps_state_check(rtwdev);
+
 	clear_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
 
 	rtw_coex_lps_notify(rtwdev, COEX_LPS_DISABLE);
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 18f687cfe211..25925eedbad4 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -11,6 +11,8 @@
 #define POWER_MODE_PG		BIT(4)
 #define POWER_MODE_LCLK		BIT(0)
 
+#define LEAVE_LPS_TRY_CNT	5
+
 int rtw_enter_ips(struct rtw_dev *rtwdev);
 int rtw_leave_ips(struct rtw_dev *rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index fe793e270d22..60014077de77 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -271,6 +271,7 @@
 #define BIT_TSFT_SEL_TIMER0	(BIT(4) | BIT(5) | BIT(6))
 
 #define REG_TCR			0x0604
+#define BIT_PWRMGT_HWDATA_EN	BIT(7)
 #define REG_RCR			0x0608
 #define BIT_APP_FCS		BIT(31)
 #define BIT_APP_MIC		BIT(30)
-- 
2.17.1

