Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C76B6056BF
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 07:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJTF0Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 01:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJTF0W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 01:26:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C310191D5E
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 22:26:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29K5PYkT4025012, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29K5PYkT4025012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 20 Oct 2022 13:25:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 20 Oct 2022 13:26:06 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 20 Oct
 2022 13:26:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: fw: adapt to new firmware format of dynamic header
Date:   Thu, 20 Oct 2022 13:25:49 +0800
Message-ID: <20221020052549.33783-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/20/2022 04:59:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzIwIKRXpMggMDM6Mzg6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since firmware size is limited, we create variant firmwares for variant
application areas. To help driver to know firmware's capabilities, firmware
dynamic header is introduced to have more information, such as firmware
features and firmware compile flags.

Since this driver rtw89 only uses single one specific firmware at runtime,
this patch is just to ignore this dynamic header, not actually use the
content.

This patch can be backward compatible, and no this kind of firmware is
added to linux-firmware yet, so I can prepare this in advance.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 22 +++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h | 12 ++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d21f87e25ae1f..548b772eccfe3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -85,15 +85,31 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 {
 	struct rtw89_fw_hdr_section_info *section_info;
 	const u8 *fw_end = fw + len;
+	const u8 *fwdynhdr;
 	const u8 *bin;
+	u32 base_hdr_len;
 	u32 i;
 
 	if (!info)
 		return -EINVAL;
 
 	info->section_num = GET_FW_HDR_SEC_NUM(fw);
-	info->hdr_len = RTW89_FW_HDR_SIZE +
-			info->section_num * RTW89_FW_SECTION_HDR_SIZE;
+	base_hdr_len = RTW89_FW_HDR_SIZE +
+		       info->section_num * RTW89_FW_SECTION_HDR_SIZE;
+	info->dynamic_hdr_en = GET_FW_HDR_DYN_HDR(fw);
+
+	if (info->dynamic_hdr_en) {
+		info->hdr_len = GET_FW_HDR_LEN(fw);
+		info->dynamic_hdr_len = info->hdr_len - base_hdr_len;
+		fwdynhdr = fw + base_hdr_len;
+		if (GET_FW_DYNHDR_LEN(fwdynhdr) != info->dynamic_hdr_len) {
+			rtw89_err(rtwdev, "[ERR]invalid fw dynamic header len\n");
+			return -EINVAL;
+		}
+	} else {
+		info->hdr_len = base_hdr_len;
+		info->dynamic_hdr_len = 0;
+	}
 
 	bin = fw + info->hdr_len;
 
@@ -534,7 +550,7 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 		goto fwdl_err;
 	}
 
-	ret = rtw89_fw_download_hdr(rtwdev, fw, info.hdr_len);
+	ret = rtw89_fw_download_hdr(rtwdev, fw, info.hdr_len - info.dynamic_hdr_len);
 	if (ret) {
 		ret = -EBUSY;
 		goto fwdl_err;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 6ef392ef9c6fb..8563efa5f6411 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -176,6 +176,8 @@ struct rtw89_fw_hdr_section_info {
 struct rtw89_fw_bin_info {
 	u8 section_num;
 	u32 hdr_len;
+	bool dynamic_hdr_en;
+	u32 dynamic_hdr_len;
 	struct rtw89_fw_hdr_section_info section_info[FWDL_SECTION_MAX_NUM];
 };
 
@@ -495,6 +497,8 @@ static inline void RTW89_SET_EDCA_PARAM(void *cmd, u32 val)
 	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(23, 16))
 #define GET_FW_HDR_SUBINDEX(fwhdr)	\
 	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(31, 24))
+#define GET_FW_HDR_LEN(fwhdr)	\
+	le32_get_bits(*((const __le32 *)(fwhdr) + 3), GENMASK(23, 16))
 #define GET_FW_HDR_MONTH(fwhdr)		\
 	le32_get_bits(*((const __le32 *)(fwhdr) + 4), GENMASK(7, 0))
 #define GET_FW_HDR_DATE(fwhdr)		\
@@ -507,8 +511,16 @@ static inline void RTW89_SET_EDCA_PARAM(void *cmd, u32 val)
 	le32_get_bits(*((const __le32 *)(fwhdr) + 5), GENMASK(31, 0))
 #define GET_FW_HDR_SEC_NUM(fwhdr)	\
 	le32_get_bits(*((const __le32 *)(fwhdr) + 6), GENMASK(15, 8))
+#define GET_FW_HDR_DYN_HDR(fwhdr)	\
+	le32_get_bits(*((const __le32 *)(fwhdr) + 7), BIT(16))
 #define GET_FW_HDR_CMD_VERSERION(fwhdr)	\
 	le32_get_bits(*((const __le32 *)(fwhdr) + 7), GENMASK(31, 24))
+
+#define GET_FW_DYNHDR_LEN(fwdynhdr)	\
+	le32_get_bits(*((const __le32 *)(fwdynhdr)), GENMASK(31, 0))
+#define GET_FW_DYNHDR_COUNT(fwdynhdr)	\
+	le32_get_bits(*((const __le32 *)(fwdynhdr) + 1), GENMASK(31, 0))
+
 static inline void SET_FW_HDR_PART_SIZE(void *fwhdr, u32 val)
 {
 	le32p_replace_bits((__le32 *)fwhdr + 7, val, GENMASK(15, 0));
-- 
2.25.1

