Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52135FE8A4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 08:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJNGEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 02:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJNGEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 02:04:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A339E1ACA88
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 23:03:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29E62THx8023539, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (mapi.realtek.com[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29E62THx8023539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Oct 2022 14:02:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 14 Oct 2022 14:03:00 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 14 Oct
 2022 14:02:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: 8852b: add chip_ops related to RF calibration
Date:   Fri, 14 Oct 2022 14:02:35 +0800
Message-ID: <20221014060237.29050-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014060237.29050-1-pkshih@realtek.com>
References: <20221014060237.29050-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/14/2022 05:44:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzE0IKRXpMggMDM6MTg6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since RF calibrations are added, add chip_ops to call them. These chip_ops
include initial, full calibration, configuration when switching band and
scanning, and track work in period of 2 seconds.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 0918b75ab1d94..0df044b1c392a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1513,6 +1513,43 @@ static void rtw8852b_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 	}
 }
 
+static void rtw8852b_rfk_init(struct rtw89_dev *rtwdev)
+{
+	rtwdev->is_tssi_mode[RF_PATH_A] = false;
+	rtwdev->is_tssi_mode[RF_PATH_B] = false;
+
+	rtw8852b_dpk_init(rtwdev);
+	rtw8852b_rck(rtwdev);
+	rtw8852b_dack(rtwdev);
+	rtw8852b_rx_dck(rtwdev, RTW89_PHY_0);
+}
+
+static void rtw8852b_rfk_channel(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+
+	rtw8852b_rx_dck(rtwdev, phy_idx);
+	rtw8852b_iqk(rtwdev, phy_idx);
+	rtw8852b_tssi(rtwdev, phy_idx, true);
+	rtw8852b_dpk(rtwdev, phy_idx);
+}
+
+static void rtw8852b_rfk_band_changed(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx)
+{
+	rtw8852b_tssi_scan(rtwdev, phy_idx);
+}
+
+static void rtw8852b_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+{
+	rtw8852b_wifi_scan_notify(rtwdev, start, RTW89_PHY_0);
+}
+
+static void rtw8852b_rfk_track(struct rtw89_dev *rtwdev)
+{
+	rtw8852b_dpk_track(rtwdev);
+}
+
 static u32 rtw8852b_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 				     enum rtw89_phy_idx phy_idx, s16 ref)
 {
@@ -2346,6 +2383,11 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.read_efuse		= rtw8852b_read_efuse,
 	.read_phycap		= rtw8852b_read_phycap,
 	.fem_setup		= NULL,
+	.rfk_init		= rtw8852b_rfk_init,
+	.rfk_channel		= rtw8852b_rfk_channel,
+	.rfk_band_changed	= rtw8852b_rfk_band_changed,
+	.rfk_scan		= rtw8852b_rfk_scan,
+	.rfk_track		= rtw8852b_rfk_track,
 	.power_trim		= rtw8852b_power_trim,
 	.set_txpwr		= rtw8852b_set_txpwr,
 	.set_txpwr_ctrl		= rtw8852b_set_txpwr_ctrl,
-- 
2.25.1

