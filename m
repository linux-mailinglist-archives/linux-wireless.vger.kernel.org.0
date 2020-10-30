Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47D72A0050
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 09:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJ3Isz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 04:48:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50440 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3Isz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 04:48:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09U8mlf87013488, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09U8mlf87013488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Oct 2020 16:48:47 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 30 Oct 2020 16:48:46 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 1/4] rtw88: sync the power state between driver and firmware
Date:   Fri, 30 Oct 2020 16:48:23 +0800
Message-ID: <20201030084826.9034-2-tehuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030084826.9034-1-tehuang@realtek.com>
References: <20201030084826.9034-1-tehuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.222]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

In current flow, driver issues power requests to firmware for entering or
leaving deep power mode. But driver does not wait for an ack from firmware
via reading CPWM register when driver requests to enter deep power mode.
The behavior will lead to unsynchronized state between firmware and driver.
Furthermore, consecutive same power requests may confuse firmware and leads
to unexpected value of CPWM register. This patch ensures that the power
request will wait for an ack from firmware and only send one power request
each time.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/ps.c | 69 +++++++++++--------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 7a189a9926fe..8ed243628dcb 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -68,48 +68,39 @@ int rtw_leave_ips(struct rtw_dev *rtwdev)
 void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
 {
 	u8 request, confirm, polling;
-	u8 polling_cnt;
-	u8 retry_cnt = 0;
-
-	for (retry_cnt = 0; retry_cnt < 3; retry_cnt++) {
-		request = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
-		confirm = rtw_read8(rtwdev, rtwdev->hci.cpwm_addr);
-
-		/* toggle to request power mode, others remain 0 */
-		request ^= request | BIT_RPWM_TOGGLE;
-		if (!enter) {
-			request |= POWER_MODE_ACK;
-		} else {
-			request |= POWER_MODE_LCLK;
-			if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
-				request |= POWER_MODE_PG;
-		}
-
-		rtw_write8(rtwdev, rtwdev->hci.rpwm_addr, request);
-
-		if (enter)
-			return;
+	int ret;
 
-		/* check confirm power mode has left power save state */
-		for (polling_cnt = 0; polling_cnt < 50; polling_cnt++) {
-			polling = rtw_read8(rtwdev, rtwdev->hci.cpwm_addr);
-			if ((polling ^ confirm) & BIT_RPWM_TOGGLE)
-				return;
-			udelay(100);
-		}
-
-		/* in case of fw/hw missed the request, retry */
-		rtw_warn(rtwdev, "failed to leave deep PS, retry=%d\n",
-			 retry_cnt);
+	request = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
+	confirm = rtw_read8(rtwdev, rtwdev->hci.cpwm_addr);
+
+	/* toggle to request power mode, others remain 0 */
+	request ^= request | BIT_RPWM_TOGGLE;
+	if (enter) {
+		request |= POWER_MODE_LCLK;
+		if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
+			request |= POWER_MODE_PG;
 	}
+	/* Each request require an ack from firmware */
+	request |= POWER_MODE_ACK;
 
-	/* Hit here means that driver failed to change hardware power mode to
-	 * active state after retry 3 times. If the power state is locked at
-	 * Deep sleep, most of the hardware circuits is not working, even
-	 * register read/write. It should be treated as fatal error and
-	 * requires an entire analysis about the firmware/hardware
-	 */
-	WARN(1, "Hardware power state locked\n");
+	rtw_write8(rtwdev, rtwdev->hci.rpwm_addr, request);
+
+	/* Check firmware get the power requset and ack via cpwm register */
+	ret = read_poll_timeout_atomic(rtw_read8, polling,
+				       (polling ^ confirm) & BIT_RPWM_TOGGLE,
+				       100, 15000, true, rtwdev,
+				       rtwdev->hci.cpwm_addr);
+	if (ret) {
+		/* Hit here means that driver failed to get an ack from firmware.
+		 * The reason could be that hardware is locked at Deep sleep,
+		 * so most of the hardware circuits are not working, even
+		 * register read/write; or firmware is locked in some state and
+		 * cannot get the request. It should be treated as fatal error
+		 * and requires an entire analysis about the firmware/hardware.
+		 */
+		WARN(1, "firmware failed to ack driver for %s Deep Power mode\n",
+		     enter ? "entering" : "leaving");
+	}
 }
 EXPORT_SYMBOL(rtw_power_mode_change);
 
-- 
2.17.1

