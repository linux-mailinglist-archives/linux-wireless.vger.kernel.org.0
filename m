Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D593F76A6C9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 04:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjHACMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 22:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjHACMR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 22:12:17 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03A671BDC
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 19:12:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3712BnVJ2016424, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3712BnVJ2016424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 10:11:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 1 Aug 2023 10:12:03 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 1 Aug 2023
 10:12:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: add firmware parser for v1 format
Date:   Tue, 1 Aug 2023 10:11:23 +0800
Message-ID: <20230801021127.15919-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801021127.15919-1-pkshih@realtek.com>
References: <20230801021127.15919-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A firmware with v1 format contains many sections to download. Add parser to
read section type, target address, length, checksum and so on, and then
download the section to WiFi CPU with proper location.

The additional dynamic header length named dynamic_hdr_len is used to
skip content of dynamic header containing compiler flags of firmware, which
can help to determine variant firmware build, but currently rtw89 only
use single one variant. So, just skip the content.

The layout of a WiFi CPU firmware with v1 format looks like:

+---------------------------------------+
|      Header (12 words)                |
+---------------------------------------+
|      Section header 1 (4 words)       |
|      Section header 2 (4 words)       |
|      Section header 3 (4 words)       |
|      ...                              |
+---------------------------------------+
|      Dynamic header (variable length) |
+---------------------------------------+
|      Data used & pointed by section   |
|      ...                              |
+---------------------------------------+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 106 +++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h |  17 ++++
 2 files changed, 111 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0090127800709..61b9af79f91dd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -86,8 +86,8 @@ int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
-			       struct rtw89_fw_bin_info *info)
+static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
+				  struct rtw89_fw_bin_info *info)
 {
 	const struct rtw89_fw_hdr *fw_hdr = (const struct rtw89_fw_hdr *)fw;
 	struct rtw89_fw_hdr_section_info *section_info;
@@ -154,6 +154,94 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 	return 0;
 }
 
+static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
+				  struct rtw89_fw_bin_info *info)
+{
+	const struct rtw89_fw_hdr_v1 *fw_hdr = (const struct rtw89_fw_hdr_v1 *)fw;
+	struct rtw89_fw_hdr_section_info *section_info;
+	const struct rtw89_fw_dynhdr_hdr *fwdynhdr;
+	const struct rtw89_fw_hdr_section_v1 *section;
+	const u8 *fw_end = fw + len;
+	const u8 *bin;
+	u32 base_hdr_len;
+	u32 mssc_len = 0;
+	u32 i;
+
+	info->section_num = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_SEC_NUM);
+	base_hdr_len = struct_size(fw_hdr, sections, info->section_num);
+	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_DYN_HDR);
+
+	if (info->dynamic_hdr_en) {
+		info->hdr_len = le32_get_bits(fw_hdr->w5, FW_HDR_V1_W5_HDR_SIZE);
+		info->dynamic_hdr_len = info->hdr_len - base_hdr_len;
+		fwdynhdr = (const struct rtw89_fw_dynhdr_hdr *)(fw + base_hdr_len);
+		if (le32_to_cpu(fwdynhdr->hdr_len) != info->dynamic_hdr_len) {
+			rtw89_err(rtwdev, "[ERR]invalid fw dynamic header len\n");
+			return -EINVAL;
+		}
+	} else {
+		info->hdr_len = base_hdr_len;
+		info->dynamic_hdr_len = 0;
+	}
+
+	bin = fw + info->hdr_len;
+
+	/* jump to section header */
+	section_info = info->section_info;
+	for (i = 0; i < info->section_num; i++) {
+		section = &fw_hdr->sections[i];
+		section_info->type =
+			le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_SECTIONTYPE);
+		if (section_info->type == FWDL_SECURITY_SECTION_TYPE) {
+			section_info->mssc =
+				le32_get_bits(section->w2, FWSECTION_HDR_V1_W2_MSSC);
+			mssc_len += section_info->mssc * FWDL_SECURITY_SIGLEN;
+		} else {
+			section_info->mssc = 0;
+		}
+
+		section_info->len =
+			le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_SEC_SIZE);
+		if (le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_CHECKSUM))
+			section_info->len += FWDL_SECTION_CHKSUM_LEN;
+		section_info->redl = le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_REDL);
+		section_info->dladdr =
+			le32_get_bits(section->w0, FWSECTION_HDR_V1_W0_DL_ADDR);
+		section_info->addr = bin;
+		bin += section_info->len;
+		section_info++;
+	}
+
+	if (fw_end != bin + mssc_len) {
+		rtw89_err(rtwdev, "[ERR]fw bin size\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev,
+			       const struct rtw89_fw_suit *fw_suit,
+			       struct rtw89_fw_bin_info *info)
+{
+	const u8 *fw = fw_suit->data;
+	u32 len = fw_suit->size;
+
+	if (!fw || !len) {
+		rtw89_err(rtwdev, "fw type %d isn't recognized\n", fw_suit->type);
+		return -ENOENT;
+	}
+
+	switch (fw_suit->hdr_ver) {
+	case 0:
+		return rtw89_fw_hdr_parser_v0(rtwdev, fw, len, info);
+	case 1:
+		return rtw89_fw_hdr_parser_v1(rtwdev, fw, len, info);
+	default:
+		return -ENOENT;
+	}
+}
+
 static
 int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 			struct rtw89_fw_suit *fw_suit, bool nowarn)
@@ -642,8 +730,6 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	struct rtw89_fw_suit *fw_suit = rtw89_fw_suit_get(rtwdev, type);
 	struct rtw89_fw_bin_info info;
-	const u8 *fw = fw_suit->data;
-	u32 len = fw_suit->size;
 	u8 val;
 	int ret;
 
@@ -652,12 +738,7 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 	if (ret)
 		return ret;
 
-	if (!fw || !len) {
-		rtw89_err(rtwdev, "fw type %d isn't recognized\n", type);
-		return -ENOENT;
-	}
-
-	ret = rtw89_fw_hdr_parser(rtwdev, fw, len, &info);
+	ret = rtw89_fw_hdr_parser(rtwdev, fw_suit, &info);
 	if (ret) {
 		rtw89_err(rtwdev, "parse fw header fail\n");
 		goto fwdl_err;
@@ -671,13 +752,14 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 		goto fwdl_err;
 	}
 
-	ret = rtw89_fw_download_hdr(rtwdev, fw, info.hdr_len - info.dynamic_hdr_len);
+	ret = rtw89_fw_download_hdr(rtwdev, fw_suit->data, info.hdr_len -
+							   info.dynamic_hdr_len);
 	if (ret) {
 		ret = -EBUSY;
 		goto fwdl_err;
 	}
 
-	ret = rtw89_fw_download_main(rtwdev, fw, &info);
+	ret = rtw89_fw_download_main(rtwdev, fw_suit->data, &info);
 	if (ret) {
 		ret = -EBUSY;
 		goto fwdl_err;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ca1ab2b1beecb..eb3300cd9147f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -583,6 +583,22 @@ struct rtw89_fw_hdr {
 #define FW_HDR_W7_DYN_HDR BIT(16)
 #define FW_HDR_W7_CMD_VERSERION GENMASK(31, 24)
 
+struct rtw89_fw_hdr_section_v1 {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+} __packed;
+
+#define FWSECTION_HDR_V1_W0_DL_ADDR GENMASK(31, 0)
+#define FWSECTION_HDR_V1_W1_METADATA GENMASK(31, 24)
+#define FWSECTION_HDR_V1_W1_SECTIONTYPE GENMASK(27, 24)
+#define FWSECTION_HDR_V1_W1_SEC_SIZE GENMASK(23, 0)
+#define FWSECTION_HDR_V1_W1_CHECKSUM BIT(28)
+#define FWSECTION_HDR_V1_W1_REDL BIT(29)
+#define FWSECTION_HDR_V1_W2_MSSC GENMASK(7, 0)
+#define FWSECTION_HDR_V1_W2_BBMCU_IDX GENMASK(27, 24)
+
 struct rtw89_fw_hdr_v1 {
 	__le32 w0;
 	__le32 w1;
@@ -596,6 +612,7 @@ struct rtw89_fw_hdr_v1 {
 	__le32 w9;
 	__le32 w10;
 	__le32 w11;
+	struct rtw89_fw_hdr_section_v1 sections[];
 } __packed;
 
 #define FW_HDR_V1_W1_MAJOR_VERSION GENMASK(7, 0)
-- 
2.25.1

