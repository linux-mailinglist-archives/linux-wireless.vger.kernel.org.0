Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A525183AD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 14:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiECMEP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 May 2022 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiECMDy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 May 2022 08:03:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A7C14027
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 05:00:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 243C0BbP4004961, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 243C0BbP4004961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 May 2022 20:00:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 3 May 2022 20:00:11 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 3 May
 2022 20:00:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] rtw89: 8852c: rfk: get calibrated channels to notify firmware
Date:   Tue, 3 May 2022 19:59:54 +0800
Message-ID: <20220503120001.79272-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503120001.79272-1-pkshih@realtek.com>
References: <20220503120001.79272-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/03/2022 11:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMyCkV6TIIDEwOjAxOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The commit 16b44ed0ffd3 ("rtw89: add RF H2C to notify firmware") is to
add firmware command, and this commit is to prepare the channels. Then,
firmware can get proper channels.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  |  1 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c  | 18 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h  |  1 +
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 4fb3de71d032f..44b694ccada9f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1786,6 +1786,7 @@ static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
 
+	rtw8852c_mcc_get_ch_info(rtwdev, phy_idx);
 	rtw8852c_rx_dck(rtwdev, phy_idx, false);
 	rtw8852c_iqk(rtwdev, phy_idx);
 	rtw8852c_tssi(rtwdev, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index ffc71ad249270..dfb9caba9bc41 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -3809,6 +3809,24 @@ void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 			    param->bandwidth);
 }
 
+void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
+	u8 idx = mcc_info->table_idx;
+	int i;
+
+	for (i = 0; i < RTW89_IQK_CHS_NR; i++) {
+		if (mcc_info->ch[idx] == 0)
+			break;
+		if (++idx >= RTW89_IQK_CHS_NR)
+			idx = 0;
+	}
+
+	mcc_info->table_idx = idx;
+	mcc_info->ch[idx] = rtwdev->hal.current_channel;
+	mcc_info->band[idx] = rtwdev->hal.current_band_type;
+}
+
 void rtw8852c_rck(struct rtw89_dev *rtwdev)
 {
 	u8 path;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
index e42fb1a4965ef..c32756f0c01a9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -7,6 +7,7 @@
 
 #include "core.h"
 
+void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852c_rck(struct rtw89_dev *rtwdev);
 void rtw8852c_dack(struct rtw89_dev *rtwdev);
 void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-- 
2.25.1

