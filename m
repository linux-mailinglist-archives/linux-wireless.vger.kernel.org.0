Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAD2509F61
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384219AbiDUMNV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383701AbiDUMMm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 08:12:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18777322
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 05:09:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23LC9lWnA029038, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23LC9lWnA029038
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 20:09:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 20:09:47 +0800
Received: from localhost (172.16.16.159) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 21 Apr
 2022 20:09:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 12/14] rtw89: 8852c: implement chip_ops::get_thermal
Date:   Thu, 21 Apr 2022 20:09:01 +0800
Message-ID: <20220421120903.73715-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421120903.73715-1-pkshih@realtek.com>
References: <20220421120903.73715-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.159]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/21/2022 11:49:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjEgpFekyCAxMDowNzowMA==?=
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

Read thermal value, and then we can use EWMA thermal value to do RF
calibrations if the value is changed over a threshold.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index adcc2b597419d..daf467eaef665 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2327,6 +2327,17 @@ static void rtw8852c_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 	rtw8852c_ctrl_tx_path_tmac(rtwdev, RF_PATH_AB, RTW89_MAC_0);
 }
 
+static u8 rtw8852c_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
+{
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x0);
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
+
+	fsleep(200);
+
+	return rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL);
+}
+
 static void rtw8852c_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
 {
 	if (btg) {
@@ -2487,6 +2498,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.set_txpwr		= rtw8852c_set_txpwr,
 	.set_txpwr_ctrl		= rtw8852c_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852c_init_txpwr_unit,
+	.get_thermal		= rtw8852c_get_thermal,
 	.read_rf		= rtw89_phy_read_rf_v1,
 	.write_rf		= rtw89_phy_write_rf_v1,
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
-- 
2.25.1

