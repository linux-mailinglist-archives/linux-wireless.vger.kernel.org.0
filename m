Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16B78F93F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 09:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348517AbjIAHlK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjIAHlK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 03:41:10 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B49EC10D5
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 00:41:06 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3817eXkZ5006899, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3817eXkZ5006899
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 15:40:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 1 Sep 2023 15:40:59 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 1 Sep 2023
 15:40:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 5/8] wifi: rtw89: fw: propagate an argument include_bb for BB MCU firmware
Date:   Fri, 1 Sep 2023 15:39:53 +0800
Message-ID: <20230901073956.54203-6-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Though WiFi 7 chips need BB MCU firmware, we don't download it in probe
stage. Instead, only bring interface up under normal operation or WoWLAN
mode. So, add an argument to assist download flow to setup download
settings properly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/core.c     |  2 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  5 +++--
 drivers/net/wireless/realtek/rtw89/fw.h       |  3 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 11 +++++++----
 drivers/net/wireless/realtek/rtw89/mac.h      |  5 +++--
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 10 +++++++---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/wow.c      |  4 +++-
 12 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 133bf289bacb..d5f34504b6e9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3788,7 +3788,7 @@ static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 {
 	int ret;
 
-	ret = rtw89_mac_partial_init(rtwdev);
+	ret = rtw89_mac_partial_init(rtwdev, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index da737525856b..368aaf850b5a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3446,6 +3446,7 @@ struct rtw89_chip_info {
 	const char *fw_basename;
 	u8 fw_format_max;
 	bool try_ce_fw;
+	u8 bbmcu_nr;
 	u32 needed_fw_elms;
 	u32 fifo_size;
 	bool small_fifo_size;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ccb4a233e855..2878954abe1f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -872,7 +872,8 @@ static void rtw89_fw_dl_fail_dump(struct rtw89_dev *rtwdev)
 	rtw89_fw_prog_cnt_dump(rtwdev);
 }
 
-int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
+int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
+		      bool include_bb)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
@@ -881,7 +882,7 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 	int ret;
 
 	mac->disable_cpu(rtwdev);
-	ret = mac->fwdl_enable_wcpu(rtwdev, 0, true);
+	ret = mac->fwdl_enable_wcpu(rtwdev, 0, true, include_bb);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index dd6715543371..ca13c5821ad8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3628,7 +3628,8 @@ rtw89_early_fw_feature_recognize(struct device *device,
 				 const struct rtw89_chip_info *chip,
 				 struct rtw89_fw_info *early_fw,
 				 int *used_fw_format);
-int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type);
+int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
+		      bool include_bb);
 void rtw89_load_firmware_work(struct work_struct *work);
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev);
 int rtw89_wait_firmware_completion(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f02828f295ce..9a03f7fa9188 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3467,7 +3467,8 @@ static void rtw89_mac_disable_cpu_ax(struct rtw89_dev *rtwdev)
 	rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 }
 
-static int rtw89_mac_enable_cpu_ax(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
+static int rtw89_mac_enable_cpu_ax(struct rtw89_dev *rtwdev, u8 boot_reason,
+				   bool dlfw, bool include_bb)
 {
 	u32 val;
 	int ret;
@@ -3592,7 +3593,7 @@ int rtw89_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_mac_disable_bb_rf);
 
-int rtw89_mac_partial_init(struct rtw89_dev *rtwdev)
+int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
 {
 	int ret;
 
@@ -3616,7 +3617,7 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev)
 			return ret;
 	}
 
-	ret = rtw89_fw_download(rtwdev, RTW89_FW_NORMAL);
+	ret = rtw89_fw_download(rtwdev, RTW89_FW_NORMAL, include_bb);
 	if (ret)
 		return ret;
 
@@ -3625,9 +3626,11 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev)
 
 int rtw89_mac_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool include_bb = !!chip->bbmcu_nr;
 	int ret;
 
-	ret = rtw89_mac_partial_init(rtwdev);
+	ret = rtw89_mac_partial_init(rtwdev, include_bb);
 	if (ret)
 		goto fail;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 0b772c37d566..03d3956f77eb 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -860,7 +860,8 @@ struct rtw89_mac_gen_def {
 	u32 rx_fltr;
 
 	void (*disable_cpu)(struct rtw89_dev *rtwdev);
-	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw);
+	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason,
+				bool dlfw, bool include_bb);
 	u8 (*fwdl_get_status)(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type);
 	int (*fwdl_check_path_ready)(struct rtw89_dev *rtwdev, bool h2c_or_fwdl);
 };
@@ -962,7 +963,7 @@ rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 }
 
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev);
-int rtw89_mac_partial_init(struct rtw89_dev *rtwdev);
+int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb);
 int rtw89_mac_init(struct rtw89_dev *rtwdev);
 int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 band,
 			   enum rtw89_mac_hwmod_sel sel);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 2a80d8bb4758..8cdc594e5703 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -51,10 +51,13 @@ static void rtw89_mac_disable_cpu_be(struct rtw89_dev *rtwdev)
 	rtw89_write32(rtwdev, R_BE_UDM2, 0);
 }
 
-static void set_cpu_en(struct rtw89_dev *rtwdev)
+static void set_cpu_en(struct rtw89_dev *rtwdev, bool include_bb)
 {
 	u32 set = B_BE_WLANCPU_FWDL_EN;
 
+	if (include_bb)
+		set |= B_BE_BBMCU0_FWDL_EN;
+
 	rtw89_write32_set(rtwdev, R_BE_WCPU_FW_CTRL, set);
 }
 
@@ -109,9 +112,10 @@ static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 }
 
 static int rtw89_mac_fwdl_enable_wcpu_be(struct rtw89_dev *rtwdev,
-					 u8 boot_reason, bool dlfw)
+					 u8 boot_reason, bool dlfw,
+					 bool include_bb)
 {
-	set_cpu_en(rtwdev);
+	set_cpu_en(rtwdev, include_bb);
 
 	return wcpu_on(rtwdev, boot_reason, dlfw);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 103893f28b51..401c2b68dd5f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2345,6 +2345,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.fw_basename		= RTW8851B_FW_BASENAME,
 	.fw_format_max		= RTW8851B_FW_FORMAT_MAX,
 	.try_ce_fw		= true,
+	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
 	.fifo_size		= 196608,
 	.small_fifo_size	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index d068eae6a2f0..7810f72e8457 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2081,6 +2081,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.fw_basename		= RTW8852A_FW_BASENAME,
 	.fw_format_max		= RTW8852A_FW_FORMAT_MAX,
 	.try_ce_fw		= false,
+	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
 	.fifo_size		= 458752,
 	.small_fifo_size	= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 0063301952b3..38a00c26e2ad 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2514,6 +2514,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.fw_basename		= RTW8852B_FW_BASENAME,
 	.fw_format_max		= RTW8852B_FW_FORMAT_MAX,
 	.try_ce_fw		= true,
+	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
 	.fifo_size		= 196608,
 	.small_fifo_size	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 1e16cc0a05dc..56d85d5a6eb9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2811,6 +2811,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.fw_basename		= RTW8852C_FW_BASENAME,
 	.fw_format_max		= RTW8852C_FW_FORMAT_MAX,
 	.try_ce_fw		= false,
+	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
 	.fifo_size		= 458752,
 	.small_fifo_size	= false,
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index aa9efca04025..660bf2ece927 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -488,6 +488,8 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool include_bb = !!chip->bbmcu_nr;
 	struct ieee80211_sta *wow_sta;
 	struct rtw89_sta *rtwsta = NULL;
 	bool is_conn = true;
@@ -501,7 +503,7 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	else
 		is_conn = false;
 
-	ret = rtw89_fw_download(rtwdev, fw_type);
+	ret = rtw89_fw_download(rtwdev, fw_type, include_bb);
 	if (ret) {
 		rtw89_warn(rtwdev, "download fw failed\n");
 		return ret;
-- 
2.25.1

