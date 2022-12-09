Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1000647B4D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 02:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLIBXY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 20:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLIBXX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 20:23:23 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FDB72FBCB
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 17:23:22 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2B91MQYI0003761, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2B91MQYI0003761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 9 Dec 2022 09:22:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 9 Dec 2022 09:23:14 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 9 Dec 2022
 09:23:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: fw: adapt to new firmware format of security section
Date:   Fri, 9 Dec 2022 09:22:15 +0800
Message-ID: <20221209012215.7342-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 12/09/2022 00:53:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzggpFWkyCAwNzoyOTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Normally, system image should ensure firmware integrity, but we provide
an advance feature to ensure this by security section along with firmware.
To enable this feature, custom ID is programmed into efuse, and driver
will download proper security section to firmware.

Since I don't have this kind hardware modules on hand yet, but new format
is used by newer firmware. Therefore, I prepare this patch in advance to
consider size of security section as a factor of checking rule of firmware
size, but don't actually download security section to firmware.

This patch is backward compatible, so it will be safe to have this change
before adding an new format firmware to linux-firmware repository.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 11 ++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h | 13 +++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index de1f23779fc62..65b6bd44c5ac7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -91,6 +91,7 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 	const u8 *fwdynhdr;
 	const u8 *bin;
 	u32 base_hdr_len;
+	u32 mssc_len = 0;
 	u32 i;
 
 	if (!info)
@@ -120,6 +121,14 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 	fw += RTW89_FW_HDR_SIZE;
 	section_info = info->section_info;
 	for (i = 0; i < info->section_num; i++) {
+		section_info->type = GET_FWSECTION_HDR_SECTIONTYPE(fw);
+		if (section_info->type == FWDL_SECURITY_SECTION_TYPE) {
+			section_info->mssc = GET_FWSECTION_HDR_MSSC(fw);
+			mssc_len += section_info->mssc * FWDL_SECURITY_SIGLEN;
+		} else {
+			section_info->mssc = 0;
+		}
+
 		section_info->len = GET_FWSECTION_HDR_SEC_SIZE(fw);
 		if (GET_FWSECTION_HDR_CHECKSUM(fw))
 			section_info->len += FWDL_SECTION_CHKSUM_LEN;
@@ -132,7 +141,7 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 		section_info++;
 	}
 
-	if (fw_end != bin) {
+	if (fw_end != bin + mssc_len) {
 		rtw89_err(rtwdev, "[ERR]fw bin size\n");
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 4d2f9ea9e0022..4326e0ede54b8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -171,6 +171,8 @@ struct rtw89_fw_hdr_section_info {
 	const u8 *addr;
 	u32 len;
 	u32 dladdr;
+	u32 mssc;
+	u8 type;
 };
 
 struct rtw89_fw_bin_info {
@@ -480,14 +482,21 @@ static inline void RTW89_SET_EDCA_PARAM(void *cmd, u32 val)
 #define FW_EDCA_PARAM_CWMIN_MSK GENMASK(11, 8)
 #define FW_EDCA_PARAM_AIFS_MSK GENMASK(7, 0)
 
+#define FWDL_SECURITY_SECTION_TYPE 9
+#define FWDL_SECURITY_SIGLEN 512
+
+#define GET_FWSECTION_HDR_DL_ADDR(fwhdr)	\
+	le32_get_bits(*((const __le32 *)(fwhdr)), GENMASK(31, 0))
+#define GET_FWSECTION_HDR_SECTIONTYPE(fwhdr)	\
+	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(27, 24))
 #define GET_FWSECTION_HDR_SEC_SIZE(fwhdr)	\
 	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(23, 0))
 #define GET_FWSECTION_HDR_CHECKSUM(fwhdr)	\
 	le32_get_bits(*((const __le32 *)(fwhdr) + 1), BIT(28))
 #define GET_FWSECTION_HDR_REDL(fwhdr)	\
 	le32_get_bits(*((const __le32 *)(fwhdr) + 1), BIT(29))
-#define GET_FWSECTION_HDR_DL_ADDR(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr)), GENMASK(31, 0))
+#define GET_FWSECTION_HDR_MSSC(fwhdr)	\
+	le32_get_bits(*((const __le32 *)(fwhdr) + 2), GENMASK(31, 0))
 
 #define GET_FW_HDR_MAJOR_VERSION(fwhdr)	\
 	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(7, 0))
-- 
2.25.1

