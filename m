Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABC46C12C0
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 14:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCTNIb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 09:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjCTNI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 09:08:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F11CAF0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 06:08:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32KD84voC025931, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32KD84voC025931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Mar 2023 21:08:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 20 Mar 2023 21:07:20 +0800
Received: from localhost (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Mar
 2023 21:07:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: add firmware format version to backward compatible with older drivers
Date:   Mon, 20 Mar 2023 21:06:06 +0800
Message-ID: <20230320130606.20777-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320130606.20777-1-pkshih@realtek.com>
References: <20230320130606.20777-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.31]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the discuss threads [1] [2], new firmware format break user space
because older drivers can't recognize new firmware format. To avoid this,
the new format will be named rtw89/rtw8852b_fw-1.bin and only new driver
try to load it. Old drivers only load original and understandable firmware
rtw89/rtw8852b_fw.bin.

More, new driver will be still backward compatible with old firmware, so
original firmware can be used by new driver.

If there is newer firmware format is introduced, rtw89/rtw8852b_fw-2.bin
will be given. The same rules will be applied like above. So, we will have
firmware like below in linux-firmware in the future.

  rtw89/rtw8852b_fw-2.bin
  rtw89/rtw8852b_fw-1.bin
  rtw89/rtw8852b_fw.bin

After this patch, MODULE_FIRMWARE() of 8852A/B/C become
  rtw89/rtw8852a_fw.bin
  rtw89/rtw8852b_fw-1.bin
  rtw89/rtw8852c_fw.bin

[1] https://lore.kernel.org/linux-wireless/df1ce994-3368-a57e-7078-8bdcccf4a1fd@gmail.com/T/#m24cb43be31a762d0ea70bf07f27ae96c59f6931b
[2] https://bugzilla.kernel.org/show_bug.cgi?id=217207

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  4 ++-
 drivers/net/wireless/realtek/rtw89/core.h     |  4 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 33 ++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/fw.h       | 12 ++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 10 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 10 ++++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 10 ++++--
 7 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 33460954ebf13..592e26b627d21 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3761,9 +3761,10 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	struct rtw89_dev *rtwdev;
 	struct ieee80211_ops *ops;
 	u32 driver_data_size;
+	int fw_format = -1;
 	bool no_chanctx;
 
-	firmware = rtw89_early_fw_feature_recognize(device, chip, &early_fw);
+	firmware = rtw89_early_fw_feature_recognize(device, chip, &early_fw, &fw_format);
 
 	ops = kmemdup(&rtw89_ops, sizeof(rtw89_ops), GFP_KERNEL);
 	if (!ops)
@@ -3794,6 +3795,7 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	rtwdev->ops = ops;
 	rtwdev->chip = chip;
 	rtwdev->fw.req.firmware = firmware;
+	rtwdev->fw.fw_format = fw_format;
 
 	rtw89_debug(rtwdev, RTW89_DBG_FW, "probe driver %s chanctx\n",
 		    no_chanctx ? "without" : "with");
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5fd189dde17e7..e483381f8c1e9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3058,7 +3058,8 @@ struct rtw89_phy_ul_tb_info {
 struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
 	const struct rtw89_chip_ops *ops;
-	const char *fw_name;
+	const char *fw_basename;
+	u8 fw_format_max;
 	bool try_ce_fw;
 	u32 fifo_size;
 	u32 dle_scc_rsvd_size;
@@ -3281,6 +3282,7 @@ struct rtw89_fw_req_info {
 
 struct rtw89_fw_info {
 	struct rtw89_fw_req_info req;
+	int fw_format;
 	u8 h2c_seq;
 	u8 rec_seq;
 	u8 h2c_counter;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9edc421e176cf..239dfb33eed5f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -302,11 +302,14 @@ static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
 const struct firmware *
 rtw89_early_fw_feature_recognize(struct device *device,
 				 const struct rtw89_chip_info *chip,
-				 struct rtw89_fw_info *early_fw)
+				 struct rtw89_fw_info *early_fw,
+				 int *used_fw_format)
 {
 	union rtw89_compat_fw_hdr buf = {};
 	const struct firmware *firmware;
 	bool full_req = false;
+	char fw_name[64];
+	int fw_format;
 	u32 ver_code;
 	int ret;
 
@@ -317,12 +320,22 @@ rtw89_early_fw_feature_recognize(struct device *device,
 	if (IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCE))
 		full_req = true;
 
-	if (full_req)
-		ret = request_firmware(&firmware, chip->fw_name, device);
-	else
-		ret = request_partial_firmware_into_buf(&firmware, chip->fw_name,
-							device, &buf, sizeof(buf),
-							0);
+	for (fw_format = chip->fw_format_max; fw_format >= 0; fw_format--) {
+		rtw89_fw_get_filename(fw_name, sizeof(fw_name),
+				      chip->fw_basename, fw_format);
+
+		if (full_req)
+			ret = request_firmware(&firmware, fw_name, device);
+		else
+			ret = request_partial_firmware_into_buf(&firmware, fw_name,
+								device, &buf, sizeof(buf),
+								0);
+		if (!ret) {
+			dev_info(device, "loaded firmware %s\n", fw_name);
+			*used_fw_format = fw_format;
+			break;
+		}
+	}
 
 	if (ret) {
 		dev_err(device, "failed to early request firmware: %d\n", ret);
@@ -666,7 +679,11 @@ void rtw89_load_firmware_work(struct work_struct *work)
 {
 	struct rtw89_dev *rtwdev =
 		container_of(work, struct rtw89_dev, load_firmware_work);
-	const char *fw_name = rtwdev->chip->fw_name;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	char fw_name[64];
+
+	rtw89_fw_get_filename(fw_name, sizeof(fw_name),
+			      chip->fw_basename, rtwdev->fw.fw_format);
 
 	rtw89_load_firmware_req(rtwdev, &rtwdev->fw.req, fw_name, false);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 661e08ae7bc8c..a2ff173e55446 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3515,6 +3515,15 @@ static inline u32 rtw89_compat_fw_hdr_ver_code(const void *fw_buf)
 		return RTW89_FW_HDR_VER_CODE(&compat->fw_hdr);
 }
 
+static inline void rtw89_fw_get_filename(char *buf, size_t size,
+					 const char *fw_basename, int fw_format)
+{
+	if (fw_format <= 0)
+		snprintf(buf, size, "%s.bin", fw_basename);
+	else
+		snprintf(buf, size, "%s-%d.bin", fw_basename, fw_format);
+}
+
 #define RTW89_H2C_RF_PAGE_SIZE 500
 #define RTW89_H2C_RF_PAGE_NUM 3
 struct rtw89_fw_h2c_rf_reg_info {
@@ -3658,7 +3667,8 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev);
 const struct firmware *
 rtw89_early_fw_feature_recognize(struct device *device,
 				 const struct rtw89_chip_info *chip,
-				 struct rtw89_fw_info *early_fw);
+				 struct rtw89_fw_info *early_fw,
+				 int *used_fw_format);
 int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type);
 void rtw89_load_firmware_work(struct work_struct *work);
 void rtw89_unload_firmware(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 5f7e948507f8a..018fad3bc462c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -12,6 +12,11 @@
 #include "rtw8852a_table.h"
 #include "txrx.h"
 
+#define RTW8852A_FW_FORMAT_MAX 0
+#define RTW8852A_FW_BASENAME "rtw89/rtw8852a_fw"
+#define RTW8852A_MODULE_FIRMWARE \
+	RTW8852A_FW_BASENAME ".bin"
+
 static const struct rtw89_hfc_ch_cfg rtw8852a_hfc_chcfg_pcie[] = {
 	{128, 1896, grp_0}, /* ACH 0 */
 	{128, 1896, grp_0}, /* ACH 1 */
@@ -2054,7 +2059,8 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 const struct rtw89_chip_info rtw8852a_chip_info = {
 	.chip_id		= RTL8852A,
 	.ops			= &rtw8852a_chip_ops,
-	.fw_name		= "rtw89/rtw8852a_fw.bin",
+	.fw_basename		= RTW8852A_FW_BASENAME,
+	.fw_format_max		= RTW8852A_FW_FORMAT_MAX,
 	.try_ce_fw		= false,
 	.fifo_size		= 458752,
 	.dle_scc_rsvd_size	= 0,
@@ -2150,7 +2156,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
-MODULE_FIRMWARE("rtw89/rtw8852a_fw.bin");
+MODULE_FIRMWARE(RTW8852A_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852A driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 895d216cfa27b..639c65025dd6f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -12,6 +12,11 @@
 #include "rtw8852b_table.h"
 #include "txrx.h"
 
+#define RTW8852B_FW_FORMAT_MAX 1
+#define RTW8852B_FW_BASENAME "rtw89/rtw8852b_fw"
+#define RTW8852B_MODULE_FIRMWARE \
+	RTW8852B_FW_BASENAME "-" __stringify(RTW8852B_FW_FORMAT_MAX) ".bin"
+
 static const struct rtw89_hfc_ch_cfg rtw8852b_hfc_chcfg_pcie[] = {
 	{5, 343, grp_0}, /* ACH 0 */
 	{5, 343, grp_0}, /* ACH 1 */
@@ -2431,7 +2436,8 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_id		= RTL8852B,
 	.ops			= &rtw8852b_chip_ops,
-	.fw_name		= "rtw89/rtw8852b_fw.bin",
+	.fw_basename		= RTW8852B_FW_BASENAME,
+	.fw_format_max		= RTW8852B_FW_FORMAT_MAX,
 	.try_ce_fw		= true,
 	.fifo_size		= 196608,
 	.dle_scc_rsvd_size	= 98304,
@@ -2526,7 +2532,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 };
 EXPORT_SYMBOL(rtw8852b_chip_info);
 
-MODULE_FIRMWARE("rtw89/rtw8852b_fw.bin");
+MODULE_FIRMWARE(RTW8852B_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852B driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index e8e577a1b9fc4..63af0c89bd80f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -13,6 +13,11 @@
 #include "rtw8852c_table.h"
 #include "util.h"
 
+#define RTW8852C_FW_FORMAT_MAX 0
+#define RTW8852C_FW_BASENAME "rtw89/rtw8852c_fw"
+#define RTW8852C_MODULE_FIRMWARE \
+	RTW8852C_FW_BASENAME ".bin"
+
 static const struct rtw89_hfc_ch_cfg rtw8852c_hfc_chcfg_pcie[] = {
 	{13, 1614, grp_0}, /* ACH 0 */
 	{13, 1614, grp_0}, /* ACH 1 */
@@ -2786,7 +2791,8 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 const struct rtw89_chip_info rtw8852c_chip_info = {
 	.chip_id		= RTL8852C,
 	.ops			= &rtw8852c_chip_ops,
-	.fw_name		= "rtw89/rtw8852c_fw.bin",
+	.fw_basename		= RTW8852C_FW_BASENAME,
+	.fw_format_max		= RTW8852C_FW_FORMAT_MAX,
 	.try_ce_fw		= false,
 	.fifo_size		= 458752,
 	.dle_scc_rsvd_size	= 0,
@@ -2886,7 +2892,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
-MODULE_FIRMWARE("rtw89/rtw8852c_fw.bin");
+MODULE_FIRMWARE(RTW8852C_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852C driver");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

