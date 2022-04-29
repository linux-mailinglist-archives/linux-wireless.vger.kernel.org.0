Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EDE514329
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 09:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355071AbiD2HWK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 03:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355047AbiD2HWE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 03:22:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2849BE9F1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 00:18:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23T7IfQ42001368, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23T7IfQ42001368
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Apr 2022 15:18:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 15:18:41 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 29 Apr
 2022 15:18:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 06/16] rtw89: 8852c: rfk: add RX DCK
Date:   Fri, 29 Apr 2022 15:17:59 +0800
Message-ID: <20220429071809.32104-7-pkshih@realtek.com>
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

RX DCK is receiver DC calibration. Do this calibration when bringing up
interface and going to run on AP channel.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  9 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 67 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |  1 +
 4 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 028c881308237..c65598a7af268 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3312,17 +3312,24 @@
 #define RR_RXIQGEN_ATTL GENMASK(12, 8)
 #define RR_RXIQGEN_ATTH GENMASK(14, 13)
 #define RR_RXBB2 0x8f
-#define RR_EN_TIA_IDA GENMASK(11, 10)
 #define RR_RXBB2_DAC_EN BIT(13)
+#define RR_RXBB2_CKT BIT(12)
+#define RR_EN_TIA_IDA GENMASK(11, 10)
+#define RR_RXBB2_IDAC GENMASK(11, 9)
+#define RR_RXBB2_EBW GENMASK(6, 5)
 #define RR_XALNA2 0x90
 #define RR_XALNA2_SW GENMASK(1, 0)
 #define RR_DCK 0x92
+#define RR_DCK_DONE GENMASK(7, 5)
 #define RR_DCK_FINE BIT(1)
 #define RR_DCK_LV BIT(0)
 #define RR_DCK1 0x93
+#define RR_DCK1_CLR GENMASK(3, 0)
 #define RR_DCK1_SEL BIT(3)
 #define RR_DCK2 0x94
 #define RR_DCK2_CYCLE GENMASK(7, 2)
+#define RR_DCKC 0x95
+#define RR_DCKC_CHK BIT(3)
 #define RR_MIXER 0x9f
 #define RR_MIXER_GN GENMASK(4, 3)
 #define RR_XTALX2 0xb8
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 6db61e6df1ff0..cbf69670eafe0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1779,12 +1779,14 @@ static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
 
 	rtw8852c_rck(rtwdev);
 	rtw8852c_dack(rtwdev);
+	rtw8852c_rx_dck(rtwdev, RTW89_PHY_0, false);
 }
 
 static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
 
+	rtw8852c_rx_dck(rtwdev, phy_idx, false);
 	rtw8852c_tssi(rtwdev, phy_idx);
 	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 2fb188463ac79..229bb68278ef5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -491,6 +491,42 @@ static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 		    rtw89_read_rf(rtwdev, path, RR_RCKS, RFREG_MASK));
 }
 
+static void _rx_dck_toggle(struct rtw89_dev *rtwdev, u8 path)
+{
+	int ret;
+	u32 val;
+
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x1);
+
+	ret = read_poll_timeout_atomic(rtw89_read_rf, val, val,
+				       2, 1000, false, rtwdev, path, 0x93, BIT(5));
+	if (ret)
+		rtw89_warn(rtwdev, "[RX_DCK] S%d RXDCK timeout\n", path);
+	else
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RX_DCK] S%d RXDCK finish\n", path);
+
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x0);
+}
+
+static void _set_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 path,
+			bool is_afe)
+{
+	u8 res;
+
+	rtw89_write_rf(rtwdev, path, RR_DCK1, RR_DCK1_CLR, 0x0);
+
+	_rx_dck_toggle(rtwdev, path);
+	if (rtw89_read_rf(rtwdev, path, RR_DCKC, RR_DCKC_CHK) == 0)
+		return;
+	res = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_DONE);
+	if (res > 1) {
+		rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_IDAC, res);
+		_rx_dck_toggle(rtwdev, path);
+		rtw89_write_rf(rtwdev, path, RR_RXBB2, RR_RXBB2_IDAC, 0x1);
+	}
+}
+
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
@@ -1667,6 +1703,37 @@ void rtw8852c_dack(struct rtw89_dev *rtwdev)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_STOP);
 }
 
+#define RXDCK_VER_8852C 0xe
+
+void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_afe)
+{
+	u8 path, kpath;
+	u32 rf_reg5;
+
+	kpath = _kpath(rtwdev, phy);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RX_DCK] ****** RXDCK Start (Ver: 0x%x, Cv: %d) ******\n",
+		    RXDCK_VER_8852C, rtwdev->hal.cv);
+
+	for (path = 0; path < 2; path++) {
+		rf_reg5 = rtw89_read_rf(rtwdev, path, RR_RSV1, RFREG_MASK);
+		if (!(kpath & BIT(path)))
+			continue;
+
+		if (rtwdev->is_tssi_mode[path])
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK + (path << 13),
+					       B_P0_TSSI_TRK_EN, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RR_MOD_V_RX);
+		_set_rx_dck(rtwdev, phy, path, is_afe);
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RFREG_MASK, rf_reg5);
+
+		if (rtwdev->is_tssi_mode[path])
+			rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_TRK + (path << 13),
+					       B_P0_TSSI_TRK_EN, 0x0);
+	}
+}
+
 void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	u32 i, path = RF_PATH_A, path_max = RF_PATH_NUM_8852C;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
index faacdf17a9286..fd07028a49640 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -9,6 +9,7 @@
 
 void rtw8852c_rck(struct rtw89_dev *rtwdev);
 void rtw8852c_dack(struct rtw89_dev *rtwdev);
+void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool is_afe);
 void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852c_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852c_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx);
-- 
2.25.1

