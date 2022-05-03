Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBEA5183AB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 14:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiECMEQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 May 2022 08:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiECMDy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 May 2022 08:03:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D1D140FF
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 05:00:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 243C0Ca94004998, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 243C0Ca94004998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 May 2022 20:00:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 20:00:12 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 3 May
 2022 20:00:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] rtw89: 8852c: add chip_ops::bb_ctrl_btc_preagc
Date:   Tue, 3 May 2022 19:59:55 +0800
Message-ID: <20220503120001.79272-3-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

