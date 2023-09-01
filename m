Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331A678F93B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 09:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348518AbjIAHlK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjIAHlI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 03:41:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81CCFE7F
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 00:41:05 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3817eWftD006891, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3817eWftD006891
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 15:40:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 1 Sep 2023 15:40:58 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 1 Sep 2023
 15:40:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/8] wifi: rtw89: fw: add checking type for variant type of firmware
Date:   Fri, 1 Sep 2023 15:39:52 +0800
Message-ID: <20230901073956.54203-5-pkshih@realtek.com>
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

For WiFi 6 chips, there is only single one firmware i.e. WiFi CPU firmware,
so no need an argument to discriminate them. For WiFi 7 chips, BB MCU
firmware is introduced, and we need to check it ready after downloading.

For each type of firmware, we need to check corresponding hardware ready
bit. After downloading all firmware, check status code to determine if
all things are ready.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/core.h   |  8 +++++++
 drivers/net/wireless/realtek/rtw89/fw.c     | 19 ++++++++--------
 drivers/net/wireless/realtek/rtw89/fw.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/mac.c    |  4 ++--
 drivers/net/wireless/realtek/rtw89/mac.h    |  2 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c | 25 +++++++++++++++++++--
 6 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 04ce221730f9..da737525856b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3610,6 +3610,14 @@ struct rtw89_mac_info {
 	struct rtw89_wait_info fw_ofld_wait;
 };
 
+enum rtw89_fwdl_check_type {
+	RTW89_FWDL_CHECK_FREERTOS_DONE,
+	RTW89_FWDL_CHECK_WCPU_FWDL_DONE,
+	RTW89_FWDL_CHECK_DCPU_FWDL_DONE,
+	RTW89_FWDL_CHECK_BB0_FWDL_DONE,
+	RTW89_FWDL_CHECK_BB1_FWDL_DONE,
+};
+
 enum rtw89_fw_type {
 	RTW89_FW_NORMAL = 1,
 	RTW89_FW_WOWLAN = 3,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 459597c28bc9..ccb4a233e855 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -47,7 +47,7 @@ struct sk_buff *rtw89_fw_h2c_alloc_skb_no_hdr(struct rtw89_dev *rtwdev, u32 len)
 	return rtw89_fw_h2c_alloc_skb(rtwdev, len, false);
 }
 
-int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev)
+int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u8 val;
@@ -55,7 +55,7 @@ int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev)
 
 	ret = read_poll_timeout_atomic(mac->fwdl_get_status, val,
 				       val == RTW89_FWDL_WCPU_FW_INIT_RDY,
-				       1, FWDL_WAIT_CNT, false, rtwdev);
+				       1, FWDL_WAIT_CNT, false, rtwdev, type);
 	if (ret) {
 		switch (val) {
 		case RTW89_FWDL_CHECKSUM_FAIL:
@@ -837,13 +837,6 @@ static int rtw89_fw_download_main(struct rtw89_dev *rtwdev, const u8 *fw,
 		section_info++;
 	}
 
-	mdelay(5);
-
-	ret = rtw89_fw_check_rdy(rtwdev);
-	if (ret) {
-		rtw89_warn(rtwdev, "download firmware fail\n");
-		return ret;
-	}
 
 	return 0;
 }
@@ -924,6 +917,14 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 	rtwdev->mac.rpwm_seq_num = RPWM_SEQ_NUM_MAX;
 	rtwdev->mac.cpwm_seq_num = CPWM_SEQ_NUM_MAX;
 
+	mdelay(5);
+
+	ret = rtw89_fw_check_rdy(rtwdev, RTW89_FWDL_CHECK_FREERTOS_DONE);
+	if (ret) {
+		rtw89_warn(rtwdev, "download firmware fail\n");
+		return ret;
+	}
+
 	return ret;
 
 fwdl_err:
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ed2619fec419..dd6715543371 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3620,7 +3620,7 @@ struct rtw89_fw_h2c_rf_get_mccch {
 
 #define FWDL_WAIT_CNT 400000
 
-int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev);
+int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type);
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
 int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev);
 const struct firmware *
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index fe8dbb2fe8e1..f02828f295ce 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3505,7 +3505,7 @@ static int rtw89_mac_enable_cpu_ax(struct rtw89_dev *rtwdev, u8 boot_reason, boo
 	if (!dlfw) {
 		mdelay(5);
 
-		ret = rtw89_fw_check_rdy(rtwdev);
+		ret = rtw89_fw_check_rdy(rtwdev, RTW89_FWDL_CHECK_FREERTOS_DONE);
 		if (ret)
 			return ret;
 	}
@@ -5684,7 +5684,7 @@ int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-static u8 rtw89_fw_get_rdy_ax(struct rtw89_dev *rtwdev)
+static u8 rtw89_fw_get_rdy_ax(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type)
 {
 	u8 val = rtw89_read8(rtwdev, R_AX_WCPU_FW_CTRL);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index ecf143a671c6..0b772c37d566 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -861,7 +861,7 @@ struct rtw89_mac_gen_def {
 
 	void (*disable_cpu)(struct rtw89_dev *rtwdev);
 	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw);
-	u8 (*fwdl_get_status)(struct rtw89_dev *rtwdev);
+	u8 (*fwdl_get_status)(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type);
 	int (*fwdl_check_path_ready)(struct rtw89_dev *rtwdev, bool h2c_or_fwdl);
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 0b389eb656ac..2a80d8bb4758 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -100,7 +100,7 @@ static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 	rtw89_write32_set(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_WCPU_EN);
 
 	if (!dlfw) {
-		ret = rtw89_fw_check_rdy(rtwdev);
+		ret = rtw89_fw_check_rdy(rtwdev, RTW89_FWDL_CHECK_FREERTOS_DONE);
 		if (ret)
 			return ret;
 	}
@@ -129,13 +129,34 @@ static const u8 fwdl_status_map[] = {
 	[9] = RTW89_FWDL_RSVD0,
 };
 
-static u8 fwdl_get_status_be(struct rtw89_dev *rtwdev)
+static u8 fwdl_get_status_be(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type)
 {
+	bool check_pass = false;
 	u32 val32;
 	u8 st;
 
 	val32 = rtw89_read32(rtwdev, R_BE_WCPU_FW_CTRL);
 
+	switch (type) {
+	case RTW89_FWDL_CHECK_WCPU_FWDL_DONE:
+		check_pass = !(val32 & B_BE_WLANCPU_FWDL_EN);
+		break;
+	case RTW89_FWDL_CHECK_DCPU_FWDL_DONE:
+		check_pass = !(val32 & B_BE_DATACPU_FWDL_EN);
+		break;
+	case RTW89_FWDL_CHECK_BB0_FWDL_DONE:
+		check_pass = !(val32 & B_BE_BBMCU0_FWDL_EN);
+		break;
+	case RTW89_FWDL_CHECK_BB1_FWDL_DONE:
+		check_pass = !(val32 & B_BE_BBMCU1_FWDL_EN);
+		break;
+	default:
+		break;
+	}
+
+	if (check_pass)
+		return RTW89_FWDL_WCPU_FW_INIT_RDY;
+
 	st = u32_get_bits(val32, B_BE_WCPU_FWDL_STATUS_MASK);
 	if (st < ARRAY_SIZE(fwdl_status_map))
 		return fwdl_status_map[st];
-- 
2.25.1

