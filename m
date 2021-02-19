Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5831F4E2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 06:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBSFme (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 00:42:34 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44902 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBSFmd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 00:42:33 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 11J5fkZN3028986, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 11J5fkZN3028986
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Feb 2021 13:41:47 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Feb
 2021 13:41:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH] rtw88: coex: add power off setting
Date:   Fri, 19 Feb 2021 13:41:40 +0800
Message-ID: <20210219054140.7835-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Clear WL/BT on/off bit in scoreboard register that is used to exchange
WL/BT status. Since the status is preserved after warm reboot, we must
clear it when WL is going to down.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 5 +++++
 drivers/net/wireless/realtek/rtw88/coex.h | 1 +
 drivers/net/wireless/realtek/rtw88/main.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index ea2be1e25065..7eee2c5ecb11 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2646,6 +2646,11 @@ void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
 	rtw_coex_set_gnt_debug(rtwdev);
 }
 
+void rtw_coex_power_off_setting(struct rtw_dev *rtwdev)
+{
+	rtw_write16(rtwdev, REG_WIFI_BT_INFO, BIT_BT_INT_EN);
+}
+
 void rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
 {
 	__rtw_coex_init_hw_config(rtwdev, wifi_only);
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 8ab9852ec9ed..57018700ac39 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -393,6 +393,7 @@ void rtw_coex_bt_multi_link_remain_work(struct work_struct *work);
 void rtw_coex_wl_ccklock_work(struct work_struct *work);
 
 void rtw_coex_power_on_setting(struct rtw_dev *rtwdev);
+void rtw_coex_power_off_setting(struct rtw_dev *rtwdev);
 void rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only);
 void rtw_coex_ips_notify(struct rtw_dev *rtwdev, u8 type);
 void rtw_coex_lps_notify(struct rtw_dev *rtwdev, u8 type);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e6989c0525cc..d20aa069d62a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1138,6 +1138,7 @@ int rtw_core_start(struct rtw_dev *rtwdev)
 static void rtw_power_off(struct rtw_dev *rtwdev)
 {
 	rtw_hci_stop(rtwdev);
+	rtw_coex_power_off_setting(rtwdev);
 	rtw_mac_power_off(rtwdev);
 }
 
-- 
2.21.0

