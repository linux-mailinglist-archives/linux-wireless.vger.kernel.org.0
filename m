Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1DE1A4503
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDJKKI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 06:10:08 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:32794 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgDJKKI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 06:10:08 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03AA9xbaE027574, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03AA9xbaE027574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Apr 2020 18:09:59 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Apr 2020 18:09:59 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Apr 2020 18:09:59 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 1/2] rtw88: make rtw_chip_ops::set_antenna return int
Date:   Fri, 10 Apr 2020 18:09:49 +0800
Message-ID: <20200410100950.3199-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410100950.3199-1-yhchuang@realtek.com>
References: <20200410100950.3199-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

To support ieee80211_ops::set_antenna, the driver can decide if the
antenna mask is accepted, otherwise it can return an error code.
Because each chip could have different limitations, let the chip
check the mask and return.

Also the antenna mask for TRX from upper space is 32-bit long.
Change the antenna mask for rtw_chip_ops::set_antenna from u8 to u32.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  9 +++++----
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 18 ++++++++++++------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c6b590fdb573..c9edcabd7c42 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -798,8 +798,9 @@ struct rtw_chip_ops {
 	void (*set_tx_power_index)(struct rtw_dev *rtwdev);
 	int (*rsvd_page_dump)(struct rtw_dev *rtwdev, u8 *buf, u32 offset,
 			      u32 size);
-	void (*set_antenna)(struct rtw_dev *rtwdev, u8 antenna_tx,
-			    u8 antenna_rx);
+	int (*set_antenna)(struct rtw_dev *rtwdev,
+			   u32 antenna_tx,
+			   u32 antenna_rx);
 	void (*cfg_ldo25)(struct rtw_dev *rtwdev, bool enable);
 	void (*false_alarm_statistics)(struct rtw_dev *rtwdev);
 	void (*phy_calibration)(struct rtw_dev *rtwdev);
@@ -1567,8 +1568,8 @@ struct rtw_hal {
 	u8 sec_ch_offset;
 	u8 rf_type;
 	u8 rf_path_num;
-	u8 antenna_tx;
-	u8 antenna_rx;
+	u32 antenna_tx;
+	u32 antenna_rx;
 	u8 bfee_sts_cap;
 
 	/* protect tx power section */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 4dd7d4143b04..c02f3a730369 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -998,8 +998,9 @@ static bool rtw8822b_check_rf_path(u8 antenna)
 	}
 }
 
-static void rtw8822b_set_antenna(struct rtw_dev *rtwdev, u8 antenna_tx,
-				 u8 antenna_rx)
+static int rtw8822b_set_antenna(struct rtw_dev *rtwdev,
+				u32 antenna_tx,
+				u32 antenna_rx)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 
@@ -1007,16 +1008,21 @@ static void rtw8822b_set_antenna(struct rtw_dev *rtwdev, u8 antenna_tx,
 		antenna_tx, antenna_rx);
 
 	if (!rtw8822b_check_rf_path(antenna_tx)) {
-		rtw_info(rtwdev, "unsupport tx path, set to default path ab\n");
-		antenna_tx = BB_PATH_AB;
+		rtw_info(rtwdev, "unsupport tx path 0x%x\n", antenna_tx);
+		return -EINVAL;
 	}
+
 	if (!rtw8822b_check_rf_path(antenna_rx)) {
-		rtw_info(rtwdev, "unsupport rx path, set to default path ab\n");
-		antenna_rx = BB_PATH_AB;
+		rtw_info(rtwdev, "unsupport rx path 0x%x\n", antenna_rx);
+		return -EINVAL;
 	}
+
 	hal->antenna_tx = antenna_tx;
 	hal->antenna_rx = antenna_rx;
+
 	rtw8822b_config_trx_mode(rtwdev, antenna_tx, antenna_rx, false);
+
+	return 0;
 }
 
 static void rtw8822b_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
-- 
2.17.1

