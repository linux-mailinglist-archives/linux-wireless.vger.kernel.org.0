Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E913514324
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355078AbiD2HWN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiD2HWJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 03:22:09 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E76BF303
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 00:18:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23T7Ij1E2001479, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23T7Ij1E2001479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Apr 2022 15:18:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 15:18:45 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 29 Apr
 2022 15:18:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 10/16] rtw89: 8852c: add chip_ops::bb_ctrl_btc_preagc
Date:   Fri, 29 Apr 2022 15:18:03 +0800
Message-ID: <20220429071809.32104-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429071809.32104-1-pkshih@realtek.com>
References: <20220429071809.32104-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/29/2022 06:59:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjkgpFekyCAwNjowMDowMA==?=
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

Add to configure BT share RX path and related settings.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 44b694ccada9f..2a8271aa6cec3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2338,6 +2338,69 @@ static void rtw8852c_ctrl_tx_path_tmac(struct rtw89_dev *rtwdev, u8 tx_path,
 	}
 }
 
+static void rtw8852c_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
+{
+	if (bt_en) {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_FRC_FIR_TYPE_V1,
+				       B_PATH0_FRC_FIR_TYPE_MSK_V1, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_FRC_FIR_TYPE_V1,
+				       B_PATH1_FRC_FIR_TYPE_MSK_V1, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_RXBB_V1,
+				       B_PATH0_RXBB_MSK_V1, 0xf);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_RXBB_V1,
+				       B_PATH1_RXBB_MSK_V1, 0xf);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_G_LNA6_OP1DB_V1,
+				       B_PATH0_G_LNA6_OP1DB_V1, 0x80);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_LNA6_OP1DB_V1,
+				       B_PATH1_G_LNA6_OP1DB_V1, 0x80);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_G_TIA0_LNA6_OP1DB_V1,
+				       B_PATH0_G_TIA0_LNA6_OP1DB_V1, 0x80);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_G_TIA1_LNA6_OP1DB_V1,
+				       B_PATH0_G_TIA1_LNA6_OP1DB_V1, 0x80);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_TIA0_LNA6_OP1DB_V1,
+				       B_PATH1_G_TIA0_LNA6_OP1DB_V1, 0x80);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_TIA1_LNA6_OP1DB_V1,
+				       B_PATH1_G_TIA1_LNA6_OP1DB_V1, 0x80);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_BACKOFF_V1,
+				       B_PATH0_BT_BACKOFF_V1, 0x780D1E);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_BACKOFF_V1,
+				       B_PATH1_BT_BACKOFF_V1, 0x780D1E);
+		rtw89_phy_write32_mask(rtwdev, R_P0_BACKOFF_IBADC_V1,
+				       B_P0_BACKOFF_IBADC_V1, 0x34);
+		rtw89_phy_write32_mask(rtwdev, R_P1_BACKOFF_IBADC_V1,
+				       B_P1_BACKOFF_IBADC_V1, 0x34);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_FRC_FIR_TYPE_V1,
+				       B_PATH0_FRC_FIR_TYPE_MSK_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_FRC_FIR_TYPE_V1,
+				       B_PATH1_FRC_FIR_TYPE_MSK_V1, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_RXBB_V1,
+				       B_PATH0_RXBB_MSK_V1, 0x60);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_RXBB_V1,
+				       B_PATH1_RXBB_MSK_V1, 0x60);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_G_LNA6_OP1DB_V1,
+				       B_PATH0_G_LNA6_OP1DB_V1, 0x1a);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_LNA6_OP1DB_V1,
+				       B_PATH1_G_LNA6_OP1DB_V1, 0x1a);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_G_TIA0_LNA6_OP1DB_V1,
+				       B_PATH0_G_TIA0_LNA6_OP1DB_V1, 0x2a);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_G_TIA1_LNA6_OP1DB_V1,
+				       B_PATH0_G_TIA1_LNA6_OP1DB_V1, 0x2a);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_TIA0_LNA6_OP1DB_V1,
+				       B_PATH1_G_TIA0_LNA6_OP1DB_V1, 0x2a);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_G_TIA1_LNA6_OP1DB_V1,
+				       B_PATH1_G_TIA1_LNA6_OP1DB_V1, 0x2a);
+		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_BACKOFF_V1,
+				       B_PATH0_BT_BACKOFF_V1, 0x79E99E);
+		rtw89_phy_write32_mask(rtwdev, R_PATH1_BT_BACKOFF_V1,
+				       B_PATH1_BT_BACKOFF_V1, 0x79E99E);
+		rtw89_phy_write32_mask(rtwdev, R_P0_BACKOFF_IBADC_V1,
+				       B_P0_BACKOFF_IBADC_V1, 0x26);
+		rtw89_phy_write32_mask(rtwdev, R_P1_BACKOFF_IBADC_V1,
+				       B_P1_BACKOFF_IBADC_V1, 0x26);
+	}
+}
+
 static void rtw8852c_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
@@ -2747,6 +2810,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.init_txpwr_unit	= rtw8852c_init_txpwr_unit,
 	.get_thermal		= rtw8852c_get_thermal,
 	.query_ppdu		= rtw8852c_query_ppdu,
+	.bb_ctrl_btc_preagc	= rtw8852c_bb_ctrl_btc_preagc,
 	.read_rf		= rtw89_phy_read_rf_v1,
 	.write_rf		= rtw89_phy_write_rf_v1,
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
-- 
2.25.1

