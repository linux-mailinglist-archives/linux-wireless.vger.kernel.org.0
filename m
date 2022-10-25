Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7565460C801
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 11:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiJYJ0L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Oct 2022 05:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiJYJZc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Oct 2022 05:25:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4429A688AC
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 02:20:47 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29P9K5CV0006514, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29P9K5CV0006514
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Oct 2022 17:20:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 25 Oct 2022 17:20:38 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 25 Oct
 2022 17:20:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: move enable_cpu/disable_cpu into fw_download
Date:   Tue, 25 Oct 2022 17:19:49 +0800
Message-ID: <20221025091954.23957-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025091954.23957-1-pkshih@realtek.com>
References: <20221025091954.23957-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/25/2022 08:58:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI1IKRXpMggMDY6MzM6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

For WoWLAN mode, we need to download WoWLAN firmware by calling
fw_download(). Another, to disable/enable WiFi CPU is needed before
calling fw_download. Since Firmware runs on WiFi CPU, it is intuitive
to combine enable_cpu/disable_cpu functions into fw_download.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  |  5 +++++
 drivers/net/wireless/realtek/rtw89/mac.c | 10 ++--------
 drivers/net/wireless/realtek/rtw89/mac.h |  2 ++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d21f87e25ae1f..df0af5e0d49a5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -515,6 +515,11 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 	u8 val;
 	int ret;
 
+	rtw89_mac_disable_cpu(rtwdev);
+	ret = rtw89_mac_enable_cpu(rtwdev, 0, true);
+	if (ret)
+		return ret;
+
 	if (!fw || !len) {
 		rtw89_err(rtwdev, "fw type %d isn't recognized\n", type);
 		return -ENOENT;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 3531a859d6c8f..de9708eb97260 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3116,7 +3116,7 @@ static void rtw89_disable_fw_watchdog(struct rtw89_dev *rtwdev)
 	rtw89_mac_mem_write(rtwdev, R_AX_WDT_STATUS, val32, RTW89_MAC_MEM_CPU_LOCAL);
 }
 
-static void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev)
+void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev)
 {
 	clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
 
@@ -3131,8 +3131,7 @@ static void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev)
 	rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 }
 
-static int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason,
-				bool dlfw)
+int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 {
 	u32 val;
 	int ret;
@@ -3271,11 +3270,6 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev)
 			return ret;
 	}
 
-	rtw89_mac_disable_cpu(rtwdev);
-	ret = rtw89_mac_enable_cpu(rtwdev, 0, true);
-	if (ret)
-		return ret;
-
 	ret = rtw89_fw_download(rtwdev, RTW89_FW_NORMAL);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a6cbafb75a2b8..6e03f5e4ae246 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -815,6 +815,8 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 					struct ieee80211_vif *vif);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
+void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev);
+int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw);
 int rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev);
 int rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev);
 
-- 
2.25.1

