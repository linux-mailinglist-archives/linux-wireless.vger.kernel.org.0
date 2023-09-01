Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6604678F93A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348511AbjIAHlI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 03:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjIAHlH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 03:41:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6AD410D5
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 00:41:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3817eSDA1006868, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3817eSDA1006868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 15:40:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 1 Sep 2023 15:40:54 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 1 Sep 2023
 15:40:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/8] wifi: rtw89: fw: move polling function of firmware path ready to an individual function
Date:   Fri, 1 Sep 2023 15:39:49 +0800
Message-ID: <20230901073956.54203-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901073956.54203-1-pkshih@realtek.com>
References: <20230901073956.54203-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To download firmware, we need to check path is ready. There are two kinds
of path -- one is to download firmware header, and the other is to download
firmware body.

Since the polling method is different from WiFi 7 chips, make it to be
an individual function, and then we can reuse the download flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 11 ++---------
 drivers/net/wireless/realtek/rtw89/fw.h  |  2 ++
 drivers/net/wireless/realtek/rtw89/mac.c | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h |  2 ++
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index df1dc2f43c86..7c2fa732db18 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -54,7 +54,6 @@ static u8 _fw_get_rdy(struct rtw89_dev *rtwdev)
 	return FIELD_GET(B_AX_WCPU_FWDL_STS_MASK, val);
 }
 
-#define FWDL_WAIT_CNT 400000
 int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev)
 {
 	u8 val;
@@ -768,7 +767,6 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 l
 
 static int rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 len)
 {
-	u8 val;
 	int ret;
 
 	ret = __rtw89_fw_download_hdr(rtwdev, fw, len);
@@ -777,9 +775,7 @@ static int rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 len
 		return ret;
 	}
 
-	ret = read_poll_timeout_atomic(rtw89_read8, val, val & B_AX_FWDL_PATH_RDY,
-				       1, FWDL_WAIT_CNT, false,
-				       rtwdev, R_AX_WCPU_FW_CTRL);
+	ret = rtw89_fwdl_check_path_ready_ax(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]FWDL path ready\n");
 		return ret;
@@ -892,7 +888,6 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	struct rtw89_fw_suit *fw_suit = rtw89_fw_suit_get(rtwdev, type);
 	struct rtw89_fw_bin_info info;
-	u8 val;
 	int ret;
 
 	rtw89_mac_disable_cpu(rtwdev);
@@ -906,9 +901,7 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 		goto fwdl_err;
 	}
 
-	ret = read_poll_timeout_atomic(rtw89_read8, val, val & B_AX_H2C_PATH_RDY,
-				       1, FWDL_WAIT_CNT, false,
-				       rtwdev, R_AX_WCPU_FW_CTRL);
+	ret = rtw89_fwdl_check_path_ready_ax(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]H2C path ready\n");
 		goto fwdl_err;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 775f4e8fbda4..ed2619fec419 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3618,6 +3618,8 @@ struct rtw89_fw_h2c_rf_get_mccch {
 #define RTW89_FW_BACKTRACE_MAX_SIZE 512 /* 8 * 64 (entries) */
 #define RTW89_FW_BACKTRACE_KEY 0xBACEBACE
 
+#define FWDL_WAIT_CNT 400000
+
 int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev);
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index fab9f5004a75..013114fd9d19 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5684,6 +5684,17 @@ int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_fwdl_check_path_ready_ax(struct rtw89_dev *rtwdev,
+				   bool h2c_or_fwdl)
+{
+	u8 check = h2c_or_fwdl ? B_AX_H2C_PATH_RDY : B_AX_FWDL_PATH_RDY;
+	u8 val;
+
+	return read_poll_timeout_atomic(rtw89_read8, val, val & check,
+					1, FWDL_WAIT_CNT, false,
+					rtwdev, R_AX_WCPU_FW_CTRL);
+}
+
 const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.band1_offset = RTW89_MAC_AX_BAND_REG_OFFSET,
 	.filter_model_addr = R_AX_FILTER_MODEL_ADDR,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 7cf34137c0bc..a9a571df3a77 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1207,5 +1207,7 @@ int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow);
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 					enum rtw89_mac_idx band);
 void rtw89_mac_hw_mgnt_sec(struct rtw89_dev *rtwdev, bool wow);
+int rtw89_fwdl_check_path_ready_ax(struct rtw89_dev *rtwdev,
+				   bool h2c_or_fwdl);
 
 #endif
-- 
2.25.1

