Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FAF73270F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242161AbjFPGGw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241312AbjFPGGk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:06:40 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC2B2D60
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:06:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35G66AndC000649, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35G66AndC000649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Jun 2023 14:06:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 16 Jun 2023 14:06:29 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Jun
 2023 14:06:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: use struct to parse firmware header
Date:   Fri, 16 Jun 2023 14:06:01 +0800
Message-ID: <20230616060601.28460-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A firmware contains basic header, sections and optional dynamic header.
Define them by a struct, so it will be easier to understand the layout,
and also simply access these elements.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |   8 +-
 drivers/net/wireless/realtek/rtw89/fw.c   |  58 +++++++------
 drivers/net/wireless/realtek/rtw89/fw.h   | 101 ++++++++++++----------
 3 files changed, 87 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0f7ca12e4b34f..c085dff3ae35e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3387,10 +3387,10 @@ struct rtw89_fw_suit {
 			  (mfw_hdr)->ver.idx)
 
 #define RTW89_FW_HDR_VER_CODE(fw_hdr)				\
-	RTW89_FW_VER_CODE(GET_FW_HDR_MAJOR_VERSION(fw_hdr),	\
-			  GET_FW_HDR_MINOR_VERSION(fw_hdr),	\
-			  GET_FW_HDR_SUBVERSION(fw_hdr),	\
-			  GET_FW_HDR_SUBINDEX(fw_hdr))
+	RTW89_FW_VER_CODE(le32_get_bits((fw_hdr)->w1, FW_HDR_W1_MAJOR_VERSION),	\
+			  le32_get_bits((fw_hdr)->w1, FW_HDR_W1_MINOR_VERSION),	\
+			  le32_get_bits((fw_hdr)->w1, FW_HDR_W1_SUBVERSION),	\
+			  le32_get_bits((fw_hdr)->w1, FW_HDR_W1_SUBINDEX))
 
 struct rtw89_fw_req_info {
 	const struct firmware *firmware;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 65202f82e3bea..9637f5e48d842 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -89,9 +89,11 @@ int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev)
 static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 			       struct rtw89_fw_bin_info *info)
 {
+	const struct rtw89_fw_hdr *fw_hdr = (const struct rtw89_fw_hdr *)fw;
 	struct rtw89_fw_hdr_section_info *section_info;
+	const struct rtw89_fw_dynhdr_hdr *fwdynhdr;
+	const struct rtw89_fw_hdr_section *section;
 	const u8 *fw_end = fw + len;
-	const u8 *fwdynhdr;
 	const u8 *bin;
 	u32 base_hdr_len;
 	u32 mssc_len = 0;
@@ -100,16 +102,15 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 	if (!info)
 		return -EINVAL;
 
-	info->section_num = GET_FW_HDR_SEC_NUM(fw);
-	base_hdr_len = RTW89_FW_HDR_SIZE +
-		       info->section_num * RTW89_FW_SECTION_HDR_SIZE;
-	info->dynamic_hdr_en = GET_FW_HDR_DYN_HDR(fw);
+	info->section_num = le32_get_bits(fw_hdr->w6, FW_HDR_W6_SEC_NUM);
+	base_hdr_len = struct_size(fw_hdr, sections, info->section_num);
+	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_W7_DYN_HDR);
 
 	if (info->dynamic_hdr_en) {
-		info->hdr_len = GET_FW_HDR_LEN(fw);
+		info->hdr_len = le32_get_bits(fw_hdr->w3, FW_HDR_W3_LEN);
 		info->dynamic_hdr_len = info->hdr_len - base_hdr_len;
-		fwdynhdr = fw + base_hdr_len;
-		if (GET_FW_DYNHDR_LEN(fwdynhdr) != info->dynamic_hdr_len) {
+		fwdynhdr = (const struct rtw89_fw_dynhdr_hdr *)(fw + base_hdr_len);
+		if (le32_to_cpu(fwdynhdr->hdr_len) != info->dynamic_hdr_len) {
 			rtw89_err(rtwdev, "[ERR]invalid fw dynamic header len\n");
 			return -EINVAL;
 		}
@@ -121,26 +122,27 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 	bin = fw + info->hdr_len;
 
 	/* jump to section header */
-	fw += RTW89_FW_HDR_SIZE;
 	section_info = info->section_info;
 	for (i = 0; i < info->section_num; i++) {
-		section_info->type = GET_FWSECTION_HDR_SECTIONTYPE(fw);
+		section = &fw_hdr->sections[i];
+		section_info->type =
+			le32_get_bits(section->w1, FWSECTION_HDR_W1_SECTIONTYPE);
 		if (section_info->type == FWDL_SECURITY_SECTION_TYPE) {
-			section_info->mssc = GET_FWSECTION_HDR_MSSC(fw);
+			section_info->mssc =
+				le32_get_bits(section->w2, FWSECTION_HDR_W2_MSSC);
 			mssc_len += section_info->mssc * FWDL_SECURITY_SIGLEN;
 		} else {
 			section_info->mssc = 0;
 		}
 
-		section_info->len = GET_FWSECTION_HDR_SEC_SIZE(fw);
-		if (GET_FWSECTION_HDR_CHECKSUM(fw))
+		section_info->len = le32_get_bits(section->w1, FWSECTION_HDR_W1_SEC_SIZE);
+		if (le32_get_bits(section->w1, FWSECTION_HDR_W1_CHECKSUM))
 			section_info->len += FWDL_SECTION_CHKSUM_LEN;
-		section_info->redl = GET_FWSECTION_HDR_REDL(fw);
+		section_info->redl = le32_get_bits(section->w1, FWSECTION_HDR_W1_REDL);
 		section_info->dladdr =
-				GET_FWSECTION_HDR_DL_ADDR(fw) & 0x1fffffff;
+			le32_get_bits(section->w0, FWSECTION_HDR_W0_DL_ADDR) & 0x1fffffff;
 		section_info->addr = bin;
 		bin += section_info->len;
-		fw += RTW89_FW_SECTION_HDR_SIZE;
 		section_info++;
 	}
 
@@ -195,18 +197,18 @@ static void rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
 				enum rtw89_fw_type type,
 				struct rtw89_fw_suit *fw_suit)
 {
-	const u8 *hdr = fw_suit->data;
-
-	fw_suit->major_ver = GET_FW_HDR_MAJOR_VERSION(hdr);
-	fw_suit->minor_ver = GET_FW_HDR_MINOR_VERSION(hdr);
-	fw_suit->sub_ver = GET_FW_HDR_SUBVERSION(hdr);
-	fw_suit->sub_idex = GET_FW_HDR_SUBINDEX(hdr);
-	fw_suit->build_year = GET_FW_HDR_YEAR(hdr);
-	fw_suit->build_mon = GET_FW_HDR_MONTH(hdr);
-	fw_suit->build_date = GET_FW_HDR_DATE(hdr);
-	fw_suit->build_hour = GET_FW_HDR_HOUR(hdr);
-	fw_suit->build_min = GET_FW_HDR_MIN(hdr);
-	fw_suit->cmd_ver = GET_FW_HDR_CMD_VERSERION(hdr);
+	const struct rtw89_fw_hdr *hdr = (const struct rtw89_fw_hdr *)fw_suit->data;
+
+	fw_suit->major_ver = le32_get_bits(hdr->w1, FW_HDR_W1_MAJOR_VERSION);
+	fw_suit->minor_ver = le32_get_bits(hdr->w1, FW_HDR_W1_MINOR_VERSION);
+	fw_suit->sub_ver = le32_get_bits(hdr->w1, FW_HDR_W1_SUBVERSION);
+	fw_suit->sub_idex = le32_get_bits(hdr->w1, FW_HDR_W1_SUBINDEX);
+	fw_suit->build_year = le32_get_bits(hdr->w5, FW_HDR_W5_YEAR);
+	fw_suit->build_mon = le32_get_bits(hdr->w4, FW_HDR_W4_MONTH);
+	fw_suit->build_date = le32_get_bits(hdr->w4, FW_HDR_W4_DATE);
+	fw_suit->build_hour = le32_get_bits(hdr->w4, FW_HDR_W4_HOUR);
+	fw_suit->build_min = le32_get_bits(hdr->w4, FW_HDR_W4_MIN);
+	fw_suit->cmd_ver = le32_get_bits(hdr->w7, FW_HDR_W7_CMD_VERSERION);
 
 	rtw89_info(rtwdev,
 		   "Firmware version %u.%u.%u.%u, cmd version %u, type %u\n",
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 78d808f1e8c84..45f927dc212ef 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -528,50 +528,58 @@ static inline void RTW89_SET_EDCA_PARAM(void *cmd, u32 val)
 #define FWDL_SECURITY_SECTION_TYPE 9
 #define FWDL_SECURITY_SIGLEN 512
 
-#define GET_FWSECTION_HDR_DL_ADDR(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr)), GENMASK(31, 0))
-#define GET_FWSECTION_HDR_SECTIONTYPE(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(27, 24))
-#define GET_FWSECTION_HDR_SEC_SIZE(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(23, 0))
-#define GET_FWSECTION_HDR_CHECKSUM(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 1), BIT(28))
-#define GET_FWSECTION_HDR_REDL(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 1), BIT(29))
-#define GET_FWSECTION_HDR_MSSC(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 2), GENMASK(31, 0))
-
-#define GET_FW_HDR_MAJOR_VERSION(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(7, 0))
-#define GET_FW_HDR_MINOR_VERSION(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(15, 8))
-#define GET_FW_HDR_SUBVERSION(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(23, 16))
-#define GET_FW_HDR_SUBINDEX(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 1), GENMASK(31, 24))
-#define GET_FW_HDR_LEN(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 3), GENMASK(23, 16))
-#define GET_FW_HDR_MONTH(fwhdr)		\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 4), GENMASK(7, 0))
-#define GET_FW_HDR_DATE(fwhdr)		\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 4), GENMASK(15, 8))
-#define GET_FW_HDR_HOUR(fwhdr)		\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 4), GENMASK(23, 16))
-#define GET_FW_HDR_MIN(fwhdr)		\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 4), GENMASK(31, 24))
-#define GET_FW_HDR_YEAR(fwhdr)		\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 5), GENMASK(31, 0))
-#define GET_FW_HDR_SEC_NUM(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 6), GENMASK(15, 8))
-#define GET_FW_HDR_DYN_HDR(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 7), BIT(16))
-#define GET_FW_HDR_CMD_VERSERION(fwhdr)	\
-	le32_get_bits(*((const __le32 *)(fwhdr) + 7), GENMASK(31, 24))
-
-#define GET_FW_DYNHDR_LEN(fwdynhdr)	\
-	le32_get_bits(*((const __le32 *)(fwdynhdr)), GENMASK(31, 0))
-#define GET_FW_DYNHDR_COUNT(fwdynhdr)	\
-	le32_get_bits(*((const __le32 *)(fwdynhdr) + 1), GENMASK(31, 0))
+struct rtw89_fw_dynhdr_sec {
+	__le32 w0;
+	u8 content[];
+} __packed;
+
+struct rtw89_fw_dynhdr_hdr {
+	__le32 hdr_len;
+	__le32 setcion_count;
+	/* struct rtw89_fw_dynhdr_sec (nested flexible structures) */
+} __packed;
+
+struct rtw89_fw_hdr_section {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+} __packed;
+
+#define FWSECTION_HDR_W0_DL_ADDR GENMASK(31, 0)
+#define FWSECTION_HDR_W1_METADATA GENMASK(31, 24)
+#define FWSECTION_HDR_W1_SECTIONTYPE GENMASK(27, 24)
+#define FWSECTION_HDR_W1_SEC_SIZE GENMASK(23, 0)
+#define FWSECTION_HDR_W1_CHECKSUM BIT(28)
+#define FWSECTION_HDR_W1_REDL BIT(29)
+#define FWSECTION_HDR_W2_MSSC GENMASK(31, 0)
+
+struct rtw89_fw_hdr {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	struct rtw89_fw_hdr_section sections[];
+	/* struct rtw89_fw_dynhdr_hdr (optional) */
+} __packed;
+
+#define FW_HDR_W1_MAJOR_VERSION GENMASK(7, 0)
+#define FW_HDR_W1_MINOR_VERSION GENMASK(15, 8)
+#define FW_HDR_W1_SUBVERSION GENMASK(23, 16)
+#define FW_HDR_W1_SUBINDEX GENMASK(31, 24)
+#define FW_HDR_W3_LEN GENMASK(23, 16)
+#define FW_HDR_W4_MONTH GENMASK(7, 0)
+#define FW_HDR_W4_DATE GENMASK(15, 8)
+#define FW_HDR_W4_HOUR GENMASK(23, 16)
+#define FW_HDR_W4_MIN GENMASK(31, 24)
+#define FW_HDR_W5_YEAR GENMASK(31, 0)
+#define FW_HDR_W6_SEC_NUM GENMASK(15, 8)
+#define FW_HDR_W7_DYN_HDR BIT(16)
+#define FW_HDR_W7_CMD_VERSERION GENMASK(31, 24)
 
 static inline void SET_FW_HDR_PART_SIZE(void *fwhdr, u32 val)
 {
@@ -3392,9 +3400,6 @@ struct rtw89_h2c_ofld {
 #define RTW89_H2C_OFLD_W0_TX_TP GENMASK(17, 8)
 #define RTW89_H2C_OFLD_W0_RX_TP GENMASK(27, 18)
 
-#define RTW89_FW_HDR_SIZE 32
-#define RTW89_FW_SECTION_HDR_SIZE 16
-
 #define RTW89_MFW_SIG	0xFF
 
 struct rtw89_mfw_info {
@@ -3428,7 +3433,7 @@ struct fwcmd_hdr {
 
 union rtw89_compat_fw_hdr {
 	struct rtw89_mfw_hdr mfw_hdr;
-	u8 fw_hdr[RTW89_FW_HDR_SIZE];
+	struct rtw89_fw_hdr fw_hdr;
 };
 
 static inline u32 rtw89_compat_fw_hdr_ver_code(const void *fw_buf)
-- 
2.25.1

