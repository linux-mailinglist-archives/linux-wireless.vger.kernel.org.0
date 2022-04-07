Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F064F8069
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbiDGNZn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 09:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243504AbiDGNZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 09:25:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90523A88B3
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 06:23:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 237DNaywE007539, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 237DNaywE007539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 Apr 2022 21:23:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 21:23:36 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 7 Apr
 2022 21:23:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 08/13] rtw89: Skip useless dig gain and igi related settings for 8852C
Date:   Thu, 7 Apr 2022 21:23:11 +0800
Message-ID: <20220407132316.61132-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407132316.61132-1-pkshih@realtek.com>
References: <20220407132316.61132-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.190]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/07/2022 13:10:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyCkV6TIIDA4OjExOjAw?=
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

From: Johnson Lin <johnson.lin@realtek.com>

Separated DIG RX gain, IGI configurations from not supportted HW using
"support_igi" capability flag.

Signed-off-by: Johnson Lin <johnson.lin@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c      | 9 +++++++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 193afb1f53f5a..be9c0cf9e4696 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2930,6 +2930,9 @@ static void rtw89_phy_dig_update_gain_para(struct rtw89_dev *rtwdev)
 	u32 tmp;
 	u8 i;
 
+	if (!rtwdev->hal.support_igi)
+		return;
+
 	tmp = rtw89_phy_read32_mask(rtwdev, R_PATH0_IB_PKPW,
 				    B_PATH0_IB_PKPW_MSK);
 	dig->ib_pkpwr = sign_extend32(tmp >> DIG_GAIN_SHIFT, U8_MAX_BIT);
@@ -3184,6 +3187,9 @@ static void rtw89_phy_dig_config_igi(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_dig_info *dig = &rtwdev->dig;
 
+	if (!rtwdev->hal.support_igi)
+		return;
+
 	if (dig->force_gaincode_idx_en) {
 		rtw89_phy_dig_set_igi_cr(rtwdev, dig->force_gaincode);
 		rtw89_debug(rtwdev, RTW89_DBG_DIG,
@@ -3309,8 +3315,7 @@ void rtw89_phy_dig(struct rtw89_dev *rtwdev)
 		    dig->igi_rssi, dig->dyn_igi_max, dig->dyn_igi_min,
 		    dig->igi_fa_rssi);
 
-	if (rtwdev->hal.support_igi)
-		rtw89_phy_dig_config_igi(rtwdev);
+	rtw89_phy_dig_config_igi(rtwdev);
 
 	rtw89_phy_dig_dyn_pd_th(rtwdev, dig->igi_fa_rssi, dig->dyn_pd_th_en);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9689fc5a63723..ca254339ea7a9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -598,6 +598,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.rf_base_addr		= {0xe000, 0xf000},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
+	.dig_table		= NULL,
 	.hw_sec_hdr		= true,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
-- 
2.25.1

