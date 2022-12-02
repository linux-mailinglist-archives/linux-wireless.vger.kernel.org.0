Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8152264001F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 07:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiLBGGh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 01:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiLBGGf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 01:06:35 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30F9EDC858
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 22:06:31 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B265cH52001505, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B265cH52001505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Dec 2022 14:05:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 2 Dec 2022 14:06:24 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Dec 2022
 14:06:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: don't request partial firmware if SECURITY_LOADPIN_ENFORCE
Date:   Fri, 2 Dec 2022 14:05:20 +0800
Message-ID: <20221202060521.501512-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202060521.501512-1-pkshih@realtek.com>
References: <20221202060521.501512-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/02/2022 05:46:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzIgpFekyCAwMToyMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Kernel logs on platform enabling SECURITY_LOADPIN_ENFORCE
------
```
LoadPin: firmware old-api-denied obj=<unknown> pid=810 cmdline="modprobe -q -- rtw89_8852ce"
rtw89_8852ce 0000:01:00.0: loading /lib/firmware/rtw89/rtw8852c_fw.bin failed with error -1
rtw89_8852ce 0000:01:00.0: Direct firmware load for rtw89/rtw8852c_fw.bin failed with error -1
rtw89_8852ce 0000:01:00.0: failed to early request firmware: -1
```

Trace
------
```
request_partial_firmware_into_buf()
> _request_firmware()
>> fw_get_filesystem_firmware()
>>> kernel_read_file_from_path_initns()
>>>> kernel_read_file()
>>>>> security_kernel_read_file()
// It will iterate enabled LSMs' hooks for kernel_read_file.
// With loadpin, it hooks loadpin_read_file.
```

If SECURITY_LOADPIN_ENFORCE is enabled, doing kernel_read_file() on partial
files will be denied and return -EPERM (-1). Then, the outer API based on it,
e.g. request_partial_firmware_into_buf(), will get the error.

In the case, we cannot get the firmware stuffs right, even though there might
be no error other than a permission issue on reading a partial file. So we have
to request full firmware if SECURITY_LOADPIN_ENFORCE is enabled. It makes us
still have a chance to do early firmware work on this kind of platforms.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 30 +++++++++++++++++--------
 drivers/net/wireless/realtek/rtw89/fw.h | 15 +++++++++++++
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7e682709232d7..f5daea0d4f93c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -277,25 +277,37 @@ void rtw89_early_fw_feature_recognize(struct device *device,
 				      const struct rtw89_chip_info *chip,
 				      u32 *early_feat_map)
 {
-	union {
-		struct rtw89_mfw_hdr mfw_hdr;
-		u8 fw_hdr[RTW89_FW_HDR_SIZE];
-	} buf = {};
+	union rtw89_compat_fw_hdr buf = {};
 	const struct firmware *firmware;
+	bool full_req = false;
 	u32 ver_code;
 	int ret;
 	int i;
 
-	ret = request_partial_firmware_into_buf(&firmware, chip->fw_name,
-						device, &buf, sizeof(buf), 0);
+	/* If SECURITY_LOADPIN_ENFORCE is enabled, reading partial files will
+	 * be denied (-EPERM). Then, we don't get right firmware things as
+	 * expected. So, in this case, we have to request full firmware here.
+	 */
+	if (IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCE))
+		full_req = true;
+
+	if (full_req)
+		ret = request_firmware(&firmware, chip->fw_name, device);
+	else
+		ret = request_partial_firmware_into_buf(&firmware, chip->fw_name,
+							device, &buf, sizeof(buf),
+							0);
+
 	if (ret) {
 		dev_err(device, "failed to early request firmware: %d\n", ret);
 		return;
 	}
 
-	ver_code = buf.mfw_hdr.sig != RTW89_MFW_SIG ?
-		   RTW89_FW_HDR_VER_CODE(&buf.fw_hdr) :
-		   RTW89_MFW_HDR_VER_CODE(&buf.mfw_hdr);
+	if (full_req)
+		ver_code = rtw89_compat_fw_hdr_ver_code(firmware->data);
+	else
+		ver_code = rtw89_compat_fw_hdr_ver_code(&buf);
+
 	if (!ver_code)
 		goto out;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 46d57414f24e2..5c4c7de1b4f5d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3291,6 +3291,21 @@ struct fwcmd_hdr {
 	__le32 hdr1;
 };
 
+union rtw89_compat_fw_hdr {
+	struct rtw89_mfw_hdr mfw_hdr;
+	u8 fw_hdr[RTW89_FW_HDR_SIZE];
+};
+
+static inline u32 rtw89_compat_fw_hdr_ver_code(const void *fw_buf)
+{
+	const union rtw89_compat_fw_hdr *compat = (typeof(compat))fw_buf;
+
+	if (compat->mfw_hdr.sig == RTW89_MFW_SIG)
+		return RTW89_MFW_HDR_VER_CODE(&compat->mfw_hdr);
+	else
+		return RTW89_FW_HDR_VER_CODE(&compat->fw_hdr);
+}
+
 #define RTW89_H2C_RF_PAGE_SIZE 500
 #define RTW89_H2C_RF_PAGE_NUM 3
 struct rtw89_fw_h2c_rf_reg_info {
-- 
2.25.1

