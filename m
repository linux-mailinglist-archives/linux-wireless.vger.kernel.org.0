Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E35676A6D1
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 04:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjHACMl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 22:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjHACMh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 22:12:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90B5A1BE9
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 19:12:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3712CC5J0017512, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3712CC5J0017512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 10:12:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 1 Aug 2023 10:12:02 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 1 Aug 2023
 10:12:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/8] wifi: rtw89: introduce v1 format of firmware header
Date:   Tue, 1 Aug 2023 10:11:22 +0800
Message-ID: <20230801021127.15919-4-pkshih@realtek.com>
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

New firmware header is used by upcoming WiFi 7 chips to have more
information, so use common field w3[31:24] to determine header version,
and then use corresponding function to read firmware version and commit ID:

rtw89_8852be 0000:03:00.0: Firmware version 0.29.29.1 (799134c3), cmd version 1, type 5
rtw89_8852be 0000:03:00.0: Firmware version 0.29.29.1 (799134c3), cmd version 1, type 3

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  3 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 66 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/fw.h   | 33 ++++++++++++
 3 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c68082f239a29..a522a559657b3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3362,6 +3362,7 @@ enum rtw89_fw_feature {
 };
 
 struct rtw89_fw_suit {
+	enum rtw89_fw_type type;
 	const u8 *data;
 	u32 size;
 	u8 major_ver;
@@ -3374,6 +3375,8 @@ struct rtw89_fw_suit {
 	u16 build_hour;
 	u16 build_min;
 	u8 cmd_ver;
+	u8 hdr_ver;
+	u32 commitid;
 };
 
 #define RTW89_FW_VER_CODE(major, minor, sub, idx)	\
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index a891d063678da..0090127800709 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -196,30 +196,72 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	return 0;
 }
 
-static void rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
-				enum rtw89_fw_type type,
-				struct rtw89_fw_suit *fw_suit)
+static void rtw89_fw_update_ver_v0(struct rtw89_dev *rtwdev,
+				   struct rtw89_fw_suit *fw_suit,
+				   const struct rtw89_fw_hdr *hdr)
 {
-	const struct rtw89_fw_hdr *hdr = (const struct rtw89_fw_hdr *)fw_suit->data;
-
-	if (type == RTW89_FW_LOGFMT)
-		return;
-
 	fw_suit->major_ver = le32_get_bits(hdr->w1, FW_HDR_W1_MAJOR_VERSION);
 	fw_suit->minor_ver = le32_get_bits(hdr->w1, FW_HDR_W1_MINOR_VERSION);
 	fw_suit->sub_ver = le32_get_bits(hdr->w1, FW_HDR_W1_SUBVERSION);
 	fw_suit->sub_idex = le32_get_bits(hdr->w1, FW_HDR_W1_SUBINDEX);
+	fw_suit->commitid = le32_get_bits(hdr->w2, FW_HDR_W2_COMMITID);
 	fw_suit->build_year = le32_get_bits(hdr->w5, FW_HDR_W5_YEAR);
 	fw_suit->build_mon = le32_get_bits(hdr->w4, FW_HDR_W4_MONTH);
 	fw_suit->build_date = le32_get_bits(hdr->w4, FW_HDR_W4_DATE);
 	fw_suit->build_hour = le32_get_bits(hdr->w4, FW_HDR_W4_HOUR);
 	fw_suit->build_min = le32_get_bits(hdr->w4, FW_HDR_W4_MIN);
 	fw_suit->cmd_ver = le32_get_bits(hdr->w7, FW_HDR_W7_CMD_VERSERION);
+}
+
+static void rtw89_fw_update_ver_v1(struct rtw89_dev *rtwdev,
+				   struct rtw89_fw_suit *fw_suit,
+				   const struct rtw89_fw_hdr_v1 *hdr)
+{
+	fw_suit->major_ver = le32_get_bits(hdr->w1, FW_HDR_V1_W1_MAJOR_VERSION);
+	fw_suit->minor_ver = le32_get_bits(hdr->w1, FW_HDR_V1_W1_MINOR_VERSION);
+	fw_suit->sub_ver = le32_get_bits(hdr->w1, FW_HDR_V1_W1_SUBVERSION);
+	fw_suit->sub_idex = le32_get_bits(hdr->w1, FW_HDR_V1_W1_SUBINDEX);
+	fw_suit->commitid = le32_get_bits(hdr->w2, FW_HDR_V1_W2_COMMITID);
+	fw_suit->build_year = le32_get_bits(hdr->w5, FW_HDR_V1_W5_YEAR);
+	fw_suit->build_mon = le32_get_bits(hdr->w4, FW_HDR_V1_W4_MONTH);
+	fw_suit->build_date = le32_get_bits(hdr->w4, FW_HDR_V1_W4_DATE);
+	fw_suit->build_hour = le32_get_bits(hdr->w4, FW_HDR_V1_W4_HOUR);
+	fw_suit->build_min = le32_get_bits(hdr->w4, FW_HDR_V1_W4_MIN);
+	fw_suit->cmd_ver = le32_get_bits(hdr->w7, FW_HDR_V1_W3_CMD_VERSERION);
+}
+
+static int rtw89_fw_update_ver(struct rtw89_dev *rtwdev,
+			       enum rtw89_fw_type type,
+			       struct rtw89_fw_suit *fw_suit)
+{
+	const struct rtw89_fw_hdr *v0 = (const struct rtw89_fw_hdr *)fw_suit->data;
+	const struct rtw89_fw_hdr_v1 *v1 = (const struct rtw89_fw_hdr_v1 *)fw_suit->data;
+
+	if (type == RTW89_FW_LOGFMT)
+		return 0;
+
+	fw_suit->type = type;
+	fw_suit->hdr_ver = le32_get_bits(v0->w3, FW_HDR_W3_HDR_VER);
+
+	switch (fw_suit->hdr_ver) {
+	case 0:
+		rtw89_fw_update_ver_v0(rtwdev, fw_suit, v0);
+		break;
+	case 1:
+		rtw89_fw_update_ver_v1(rtwdev, fw_suit, v1);
+		break;
+	default:
+		rtw89_err(rtwdev, "Unknown firmware header version %u\n",
+			  fw_suit->hdr_ver);
+		return -ENOENT;
+	}
 
 	rtw89_info(rtwdev,
-		   "Firmware version %u.%u.%u.%u, cmd version %u, type %u\n",
+		   "Firmware version %u.%u.%u.%u (%08x), cmd version %u, type %u\n",
 		   fw_suit->major_ver, fw_suit->minor_ver, fw_suit->sub_ver,
-		   fw_suit->sub_idex, fw_suit->cmd_ver, type);
+		   fw_suit->sub_idex, fw_suit->commitid, fw_suit->cmd_ver, type);
+
+	return 0;
 }
 
 static
@@ -233,9 +275,7 @@ int __rtw89_fw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	if (ret)
 		return ret;
 
-	rtw89_fw_update_ver(rtwdev, type, fw_suit);
-
-	return 0;
+	return rtw89_fw_update_ver(rtwdev, type, fw_suit);
 }
 
 #define __DEF_FW_FEAT_COND(__cond, __op) \
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 89ab27090b0c0..ca1ab2b1beecb 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -571,7 +571,9 @@ struct rtw89_fw_hdr {
 #define FW_HDR_W1_MINOR_VERSION GENMASK(15, 8)
 #define FW_HDR_W1_SUBVERSION GENMASK(23, 16)
 #define FW_HDR_W1_SUBINDEX GENMASK(31, 24)
+#define FW_HDR_W2_COMMITID GENMASK(31, 0)
 #define FW_HDR_W3_LEN GENMASK(23, 16)
+#define FW_HDR_W3_HDR_VER GENMASK(31, 24)
 #define FW_HDR_W4_MONTH GENMASK(7, 0)
 #define FW_HDR_W4_DATE GENMASK(15, 8)
 #define FW_HDR_W4_HOUR GENMASK(23, 16)
@@ -581,6 +583,37 @@ struct rtw89_fw_hdr {
 #define FW_HDR_W7_DYN_HDR BIT(16)
 #define FW_HDR_W7_CMD_VERSERION GENMASK(31, 24)
 
+struct rtw89_fw_hdr_v1 {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 w8;
+	__le32 w9;
+	__le32 w10;
+	__le32 w11;
+} __packed;
+
+#define FW_HDR_V1_W1_MAJOR_VERSION GENMASK(7, 0)
+#define FW_HDR_V1_W1_MINOR_VERSION GENMASK(15, 8)
+#define FW_HDR_V1_W1_SUBVERSION GENMASK(23, 16)
+#define FW_HDR_V1_W1_SUBINDEX GENMASK(31, 24)
+#define FW_HDR_V1_W2_COMMITID GENMASK(31, 0)
+#define FW_HDR_V1_W3_CMD_VERSERION GENMASK(23, 16)
+#define FW_HDR_V1_W3_HDR_VER GENMASK(31, 24)
+#define FW_HDR_V1_W4_MONTH GENMASK(7, 0)
+#define FW_HDR_V1_W4_DATE GENMASK(15, 8)
+#define FW_HDR_V1_W4_HOUR GENMASK(23, 16)
+#define FW_HDR_V1_W4_MIN GENMASK(31, 24)
+#define FW_HDR_V1_W5_YEAR GENMASK(15, 0)
+#define FW_HDR_V1_W5_HDR_SIZE GENMASK(31, 16)
+#define FW_HDR_V1_W6_SEC_NUM GENMASK(15, 8)
+#define FW_HDR_V1_W7_DYN_HDR BIT(16)
+
 static inline void SET_FW_HDR_PART_SIZE(void *fwhdr, u32 val)
 {
 	le32p_replace_bits((__le32 *)fwhdr + 7, val, GENMASK(15, 0));
-- 
2.25.1

