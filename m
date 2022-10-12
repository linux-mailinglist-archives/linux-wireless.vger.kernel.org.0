Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F75FC20E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 10:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJLIdo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 04:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJLIdc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 04:33:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2F80B56FD
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 01:33:05 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29C8WReoC026287, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29C8WReoC026287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 12 Oct 2022 16:32:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 12 Oct 2022 16:32:56 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 12 Oct
 2022 16:32:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: 8852b: rfk: add RCK
Date:   Wed, 12 Oct 2022 16:32:31 +0800
Message-ID: <20221012083234.20224-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012083234.20224-1-pkshih@realtek.com>
References: <20221012083234.20224-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/12/2022 08:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzEyIKRXpMggMDY6MDA6MDA=?=
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

RCK is synchronize RC calibration. Driver triggers this calibration and
sets the result to register. This calibration is needed once when interface
is going to up.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 43 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 5c35f4fb38ff5..1dcb900ef7007 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -32,6 +32,41 @@ static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return val;
 }
 
+static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	u32 rf_reg5;
+	u32 rck_val;
+	u32 val;
+	int ret;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RCK] ====== S%d RCK ======\n", path);
+
+	rf_reg5 = rtw89_read_rf(rtwdev, path, RR_RSV1, RFREG_MASK);
+
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RR_MOD_V_RX);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RCK] RF0x00 = 0x%05x\n",
+		    rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK));
+
+	/* RCK trigger */
+	rtw89_write_rf(rtwdev, path, RR_RCKC, RFREG_MASK, 0x00240);
+
+	ret = read_poll_timeout_atomic(rtw89_read_rf, val, val, 2, 30,
+				       false, rtwdev, path, RR_RCKS, BIT(3));
+
+	rck_val = rtw89_read_rf(rtwdev, path, RR_RCKC, RR_RCKC_CA);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RCK] rck_val = 0x%x, ret = %d\n",
+		    rck_val, ret);
+
+	rtw89_write_rf(rtwdev, path, RR_RCKC, RFREG_MASK, rck_val);
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RFREG_MASK, rf_reg5);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RCK] RF 0x1b = 0x%x\n",
+		    rtw89_read_rf(rtwdev, path, RR_RCKC, RFREG_MASK));
+}
+
 static void _afe_init(struct rtw89_dev *rtwdev)
 {
 	rtw89_write32(rtwdev, R_AX_PHYREG_SET, 0xf);
@@ -453,6 +488,14 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK finish!!!\n");
 }
 
+void rtw8852b_rck(struct rtw89_dev *rtwdev)
+{
+	u8 path;
+
+	for (path = 0; path < RF_PATH_NUM_8852B; path++)
+		_rck(rtwdev, path);
+}
+
 void rtw8852b_dack(struct rtw89_dev *rtwdev)
 {
 	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
index bc2ff7380b927..84325abc7f2c2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
@@ -7,6 +7,7 @@
 
 #include "core.h"
 
+void rtw8852b_rck(struct rtw89_dev *rtwdev);
 void rtw8852b_dack(struct rtw89_dev *rtwdev);
 void rtw8852b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
-- 
2.25.1

