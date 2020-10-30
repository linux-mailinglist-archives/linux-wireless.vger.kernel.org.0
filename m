Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFE52A0051
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Oct 2020 09:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgJ3Isz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 04:48:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50442 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3Isz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 04:48:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09U8mlfB7013488, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09U8mlfB7013488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Oct 2020 16:48:47 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 30 Oct 2020 16:48:47 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 3/4] rtw88: add C2H response for checking firmware leave lps
Date:   Fri, 30 Oct 2020 16:48:25 +0800
Message-ID: <20201030084826.9034-4-tehuang@realtek.com>
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

Originally driver checks if firmware has left lps via reading the setting
of REG_TCR register. But this way may fail when firmware is frequently
changing power state. Therefore, firmware provides a safer option for
driver. When firmware leaves lps successfully, it sends a C2H response
to inform driver.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c   |  3 ++
 drivers/net/wireless/realtek/rtw88/fw.h   |  1 +
 drivers/net/wireless/realtek/rtw88/main.c |  1 +
 drivers/net/wireless/realtek/rtw88/main.h |  1 +
 drivers/net/wireless/realtek/rtw88/ps.c   | 52 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/ps.h   |  1 +
 6 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 042015bc8055..29fffacf4085 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -183,6 +183,9 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 	case C2H_BT_MP_INFO:
 		rtw_coex_info_response(rtwdev, skb);
 		break;
+	case C2H_WLAN_RFON:
+		complete(&rtwdev->lps_leave_check);
+		break;
 	default:
 		/* pass offset for further operation */
 		*((u32 *)skb->cb) = pkt_offset;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 5b74830c4d2c..39c905c1b1d8 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -31,6 +31,7 @@ enum rtw_c2h_cmd_id {
 	C2H_RA_RPT = 0x0c,
 	C2H_HW_FEATURE_REPORT = 0x19,
 	C2H_WLAN_INFO = 0x27,
+	C2H_WLAN_RFON = 0x32,
 	C2H_HW_FEATURE_DUMP = 0xfd,
 	C2H_HALMAC = 0xff,
 };
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 259ad849af93..5c46f5d2e87c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1652,6 +1652,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	mutex_init(&rtwdev->hal.tx_power_mutex);
 
 	init_waitqueue_head(&rtwdev->coex.wait);
+	init_completion(&rtwdev->lps_leave_check);
 
 	rtwdev->sec.total_cam_num = 32;
 	rtwdev->hal.current_channel = 1;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b00235573a13..53ddd8661c44 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1740,6 +1740,7 @@ struct rtw_dev {
 	/* lps power state & handler work */
 	struct rtw_lps_conf lps_conf;
 	bool ps_enabled;
+	struct completion lps_leave_check;
 
 	struct dentry *debugfs;
 
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 8ed243628dcb..233b3df264b3 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -109,7 +109,7 @@ static void __rtw_leave_lps_deep(struct rtw_dev *rtwdev)
 	rtw_hci_deep_ps(rtwdev, false);
 }
 
-static void rtw_fw_leave_lps_state_check(struct rtw_dev *rtwdev)
+static int __rtw_fw_leave_lps_check_reg(struct rtw_dev *rtwdev)
 {
 	int i;
 
@@ -127,12 +127,53 @@ static void rtw_fw_leave_lps_state_check(struct rtw_dev *rtwdev)
 	 */
 	for (i = 0 ; i < LEAVE_LPS_TRY_CNT; i++) {
 		if (rtw_read32_mask(rtwdev, REG_TCR, BIT_PWRMGT_HWDATA_EN) == 0)
-			return;
+			return 0;
 		msleep(20);
 	}
 
-	rtw_write32_mask(rtwdev, REG_TCR, BIT_PWRMGT_HWDATA_EN, 0);
-	rtw_warn(rtwdev, "firmware failed to restore hardware setting\n");
+	return -EBUSY;
+}
+
+static  int __rtw_fw_leave_lps_check_c2h(struct rtw_dev *rtwdev)
+{
+	if (wait_for_completion_timeout(&rtwdev->lps_leave_check,
+					LEAVE_LPS_TIMEOUT))
+		return 0;
+	return -EBUSY;
+}
+
+static void rtw_fw_leave_lps_check(struct rtw_dev *rtwdev)
+{
+	bool ret = false;
+	struct rtw_fw_state *fw;
+
+	if (test_bit(RTW_FLAG_WOWLAN, rtwdev->flags))
+		fw = &rtwdev->wow_fw;
+	else
+		fw = &rtwdev->fw;
+
+	if (fw->feature & FW_FEATURE_LPS_C2H)
+		ret = __rtw_fw_leave_lps_check_c2h(rtwdev);
+	else
+		ret = __rtw_fw_leave_lps_check_reg(rtwdev);
+
+	if (ret) {
+		rtw_write32_clr(rtwdev, REG_TCR, BIT_PWRMGT_HWDATA_EN);
+		rtw_warn(rtwdev, "firmware failed to leave lps state\n");
+	}
+}
+
+static void rtw_fw_leave_lps_check_prepare(struct rtw_dev *rtwdev)
+{
+	struct rtw_fw_state *fw;
+
+	if (test_bit(RTW_FLAG_WOWLAN, rtwdev->flags))
+		fw = &rtwdev->wow_fw;
+	else
+		fw = &rtwdev->fw;
+
+	if (fw->feature & FW_FEATURE_LPS_C2H)
+		reinit_completion(&rtwdev->lps_leave_check);
 }
 
 static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
@@ -145,8 +186,9 @@ static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
 	conf->smart_ps = 0;
 
 	rtw_hci_link_ps(rtwdev, false);
+	rtw_fw_leave_lps_check_prepare(rtwdev);
 	rtw_fw_set_pwr_mode(rtwdev);
-	rtw_fw_leave_lps_state_check(rtwdev);
+	rtw_fw_leave_lps_check(rtwdev);
 
 	clear_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
 
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 19afceca7d0e..915b200081fc 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -12,6 +12,7 @@
 #define POWER_MODE_LCLK		BIT(0)
 
 #define LEAVE_LPS_TRY_CNT	5
+#define LEAVE_LPS_TIMEOUT	msecs_to_jiffies(100)
 
 int rtw_enter_ips(struct rtw_dev *rtwdev);
 int rtw_leave_ips(struct rtw_dev *rtwdev);
-- 
2.17.1

