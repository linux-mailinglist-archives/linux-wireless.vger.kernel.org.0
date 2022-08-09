Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5658D79C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242698AbiHIKum (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbiHIKub (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 06:50:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 668993887
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 03:50:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 279AoDCO1018846, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 279AoDCO1018846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 9 Aug 2022 18:50:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 9 Aug 2022 18:50:23 +0800
Received: from localhost (172.16.16.191) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Aug 2022
 18:50:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 06/13] wifi: rtw89: rfk: concentrate parameter control while set_channel()
Date:   Tue, 9 Aug 2022 18:49:45 +0800
Message-ID: <20220809104952.61355-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809104952.61355-1-pkshih@realtek.com>
References: <20220809104952.61355-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.191]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2022 10:19:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvOSCkV6TIIDA4OjU0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

For future support on multiple channels, there will be settings of
multiple sub-entities that we need to control. We don't want such
settings to be scattered all over the place. So, we centrally manage
controls of rtw89_phy_idx for RFK in set_channel().

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 2 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 8 +++++---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 5 +++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ebe1980b0aa08..05ec34d84a5e0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -329,7 +329,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 
 	if (!entity_active || band_changed) {
 		rtw89_btc_ntfy_switch_band(rtwdev, RTW89_PHY_0, chan.band_type);
-		rtw89_chip_rfk_band_changed(rtwdev);
+		rtw89_chip_rfk_band_changed(rtwdev, RTW89_PHY_0);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 526a595882168..34efccd18b1f0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2123,7 +2123,8 @@ struct rtw89_chip_ops {
 	void (*fem_setup)(struct rtw89_dev *rtwdev);
 	void (*rfk_init)(struct rtw89_dev *rtwdev);
 	void (*rfk_channel)(struct rtw89_dev *rtwdev);
-	void (*rfk_band_changed)(struct rtw89_dev *rtwdev);
+	void (*rfk_band_changed)(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy_idx);
 	void (*rfk_scan)(struct rtw89_dev *rtwdev, bool start);
 	void (*rfk_track)(struct rtw89_dev *rtwdev);
 	void (*power_trim)(struct rtw89_dev *rtwdev);
@@ -3665,12 +3666,13 @@ static inline void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev)
 		chip->ops->rfk_channel(rtwdev);
 }
 
-static inline void rtw89_chip_rfk_band_changed(struct rtw89_dev *rtwdev)
+static inline void rtw89_chip_rfk_band_changed(struct rtw89_dev *rtwdev,
+					       enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->ops->rfk_band_changed)
-		chip->ops->rfk_band_changed(rtwdev);
+		chip->ops->rfk_band_changed(rtwdev, phy_idx);
 }
 
 static inline void rtw89_chip_rfk_scan(struct rtw89_dev *rtwdev, bool start)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 06e2c8205eeda..3630c1801dcc4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1278,9 +1278,10 @@ static void rtw8852a_rfk_channel(struct rtw89_dev *rtwdev)
 	rtw8852a_dpk(rtwdev, phy_idx);
 }
 
-static void rtw8852a_rfk_band_changed(struct rtw89_dev *rtwdev)
+static void rtw8852a_rfk_band_changed(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx)
 {
-	rtw8852a_tssi_scan(rtwdev, RTW89_PHY_0);
+	rtw8852a_tssi_scan(rtwdev, phy_idx);
 }
 
 static void rtw8852a_rfk_scan(struct rtw89_dev *rtwdev, bool start)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 1625089d83408..ab7eb6c0408e1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1851,9 +1851,10 @@ static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev)
 	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
 }
 
-static void rtw8852c_rfk_band_changed(struct rtw89_dev *rtwdev)
+static void rtw8852c_rfk_band_changed(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx)
 {
-	rtw8852c_tssi_scan(rtwdev, RTW89_PHY_0);
+	rtw8852c_tssi_scan(rtwdev, phy_idx);
 }
 
 static void rtw8852c_rfk_scan(struct rtw89_dev *rtwdev, bool start)
-- 
2.25.1

