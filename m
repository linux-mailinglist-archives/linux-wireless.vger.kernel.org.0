Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5C78F940
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 09:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348523AbjIAHlL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 03:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348520AbjIAHlK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 03:41:10 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A94A110D7
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 00:41:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3817eZ8s9006911, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3817eZ8s9006911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 15:40:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 1 Sep 2023 15:41:01 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 1 Sep 2023
 15:41:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 7/8] wifi: rtw89: fw: refine download flow to support variant firmware suits
Date:   Fri, 1 Sep 2023 15:39:55 +0800
Message-ID: <20230901073956.54203-8-pkshih@realtek.com>
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

To support download more than one firmware, adjust flow to download
firmware by unit of firmware suit. Then, flow becomes

 1. initial setup - disable/enable_wcpu
 2. for all firmware suits
 2.1. download WiFi CPU, and check ready
 2.2. download BB MCU, and check ready
 3. check status code to make sure all ready

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/fw.c | 84 +++++++++++++++++++------
 1 file changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2878954abe1f..b27d3cb6f1d9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -823,10 +823,27 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-static int rtw89_fw_download_main(struct rtw89_dev *rtwdev, const u8 *fw,
+static enum rtw89_fwdl_check_type
+rtw89_fw_get_fwdl_chk_type_from_suit(struct rtw89_dev *rtwdev,
+				     const struct rtw89_fw_suit *fw_suit)
+{
+	switch (fw_suit->type) {
+	case RTW89_FW_BBMCU0:
+		return RTW89_FWDL_CHECK_BB0_FWDL_DONE;
+	case RTW89_FW_BBMCU1:
+		return RTW89_FWDL_CHECK_BB1_FWDL_DONE;
+	default:
+		return RTW89_FWDL_CHECK_WCPU_FWDL_DONE;
+	}
+}
+
+static int rtw89_fw_download_main(struct rtw89_dev *rtwdev,
+				  const struct rtw89_fw_suit *fw_suit,
 				  struct rtw89_fw_bin_info *info)
 {
 	struct rtw89_fw_hdr_section_info *section_info = info->section_info;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	enum rtw89_fwdl_check_type chk_type;
 	u8 section_num = info->section_num;
 	int ret;
 
@@ -837,6 +854,16 @@ static int rtw89_fw_download_main(struct rtw89_dev *rtwdev, const u8 *fw,
 		section_info++;
 	}
 
+	if (chip->chip_gen == RTW89_CHIP_AX)
+		return 0;
+
+	chk_type = rtw89_fw_get_fwdl_chk_type_from_suit(rtwdev, fw_suit);
+	ret = rtw89_fw_check_rdy(rtwdev, chk_type);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to download firmware type %u\n",
+			   fw_suit->type);
+		return ret;
+	}
 
 	return 0;
 }
@@ -872,43 +899,62 @@ static void rtw89_fw_dl_fail_dump(struct rtw89_dev *rtwdev)
 	rtw89_fw_prog_cnt_dump(rtwdev);
 }
 
-int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
-		      bool include_bb)
+static int rtw89_fw_download_suit(struct rtw89_dev *rtwdev,
+				  struct rtw89_fw_suit *fw_suit)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	struct rtw89_fw_info *fw_info = &rtwdev->fw;
-	struct rtw89_fw_suit *fw_suit = rtw89_fw_suit_get(rtwdev, type);
 	struct rtw89_fw_bin_info info;
 	int ret;
 
-	mac->disable_cpu(rtwdev);
-	ret = mac->fwdl_enable_wcpu(rtwdev, 0, true, include_bb);
-	if (ret)
-		return ret;
-
 	ret = rtw89_fw_hdr_parser(rtwdev, fw_suit, &info);
 	if (ret) {
 		rtw89_err(rtwdev, "parse fw header fail\n");
-		goto fwdl_err;
+		return ret;
 	}
 
 	ret = mac->fwdl_check_path_ready(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]H2C path ready\n");
-		goto fwdl_err;
+		return ret;
 	}
 
 	ret = rtw89_fw_download_hdr(rtwdev, fw_suit->data, info.hdr_len -
 							   info.dynamic_hdr_len);
-	if (ret) {
-		ret = -EBUSY;
-		goto fwdl_err;
-	}
+	if (ret)
+		return ret;
 
-	ret = rtw89_fw_download_main(rtwdev, fw_suit->data, &info);
-	if (ret) {
-		ret = -EBUSY;
+	ret = rtw89_fw_download_main(rtwdev, fw_suit, &info);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
+		      bool include_bb)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	struct rtw89_fw_info *fw_info = &rtwdev->fw;
+	struct rtw89_fw_suit *fw_suit = rtw89_fw_suit_get(rtwdev, type);
+	u8 bbmcu_nr = rtwdev->chip->bbmcu_nr;
+	int ret;
+	int i;
+
+	mac->disable_cpu(rtwdev);
+	ret = mac->fwdl_enable_wcpu(rtwdev, 0, true, include_bb);
+	if (ret)
+		return ret;
+
+	ret = rtw89_fw_download_suit(rtwdev, fw_suit);
+	if (ret)
 		goto fwdl_err;
+
+	for (i = 0; i < bbmcu_nr && include_bb; i++) {
+		fw_suit = rtw89_fw_suit_get(rtwdev, RTW89_FW_BBMCU0 + i);
+
+		ret = rtw89_fw_download_suit(rtwdev, fw_suit);
+		if (ret)
+			goto fwdl_err;
 	}
 
 	fw_info->h2c_seq = 0;
-- 
2.25.1

