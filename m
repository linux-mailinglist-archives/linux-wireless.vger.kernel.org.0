Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4BD50F10D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiDZGgU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 02:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiDZGgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 02:36:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEAA15A11
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 23:33:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23Q6X4Yl8015234, This message is accepted by code: ctloc85258
Received: from mail.realtek.com ([172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23Q6X4Yl8015234
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Apr 2022 14:33:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 14:33:04 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 26 Apr
 2022 14:33:04 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 05/15] rtw89: 8852c: rfk: add RCK
Date:   Tue, 26 Apr 2022 14:32:25 +0800
Message-ID: <20220426063235.41650-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426063235.41650-1-pkshih@realtek.com>
References: <20220426063235.41650-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/26/2022 06:17:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjYgpFekyCAwNDozODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

RCK is synchronize RC calibration. It needs to be triggered only once when
interface is going to up.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 43 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |  1 +
 3 files changed, 45 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 80c6471269e78..7e7a7b30bc6f4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1777,6 +1777,7 @@ static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
 	memset(mcc_info, 0, sizeof(*mcc_info));
 	rtw8852c_lck_init(rtwdev);
 
+	rtw8852c_rck(rtwdev);
 	rtw8852c_dack(rtwdev);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 21693dce79e82..2fb188463ac79 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -456,6 +456,41 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK finish!!!\n");
 }
 
+static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	u32 rf_reg5, rck_val = 0;
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
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RCK] RF0x00 = 0x%x\n",
+		    rtw89_read_rf(rtwdev, path, RR_MOD, RFREG_MASK));
+
+	/* RCK trigger */
+	rtw89_write_rf(rtwdev, path, RR_RCKC, RFREG_MASK, 0x00240);
+
+	ret = read_poll_timeout_atomic(rtw89_read_rf, val, val, 2, 20,
+				       false, rtwdev, path, 0x1c, BIT(3));
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RCK] RCK timeout\n");
+
+	rck_val = rtw89_read_rf(rtwdev, path, RR_RCKC, RR_RCKC_CA);
+	rtw89_write_rf(rtwdev, path, RR_RCKC, RFREG_MASK, rck_val);
+
+	rtw89_write_rf(rtwdev, path, RR_RSV1, RFREG_MASK, rf_reg5);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RCK] RF 0x1b / 0x1c = 0x%x / 0x%x\n",
+		    rtw89_read_rf(rtwdev, path, RR_RCKC, RFREG_MASK),
+		    rtw89_read_rf(rtwdev, path, RR_RCKS, RFREG_MASK));
+}
+
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
@@ -1615,6 +1650,14 @@ void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 			    param->bandwidth);
 }
 
+void rtw8852c_rck(struct rtw89_dev *rtwdev)
+{
+	u8 path;
+
+	for (path = 0; path < 2; path++)
+		_rck(rtwdev, path);
+}
+
 void rtw8852c_dack(struct rtw89_dev *rtwdev)
 {
 	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
index a16ad9305ba42..faacdf17a9286 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -7,6 +7,7 @@
 
 #include "core.h"
 
+void rtw8852c_rck(struct rtw89_dev *rtwdev);
 void rtw8852c_dack(struct rtw89_dev *rtwdev);
 void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
-- 
2.25.1

