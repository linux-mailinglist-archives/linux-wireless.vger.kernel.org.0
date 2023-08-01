Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7023276A6CC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 04:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjHACMV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 22:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjHACMT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 22:12:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADFC61B1
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 19:12:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3712BtQA2016561, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3712BtQA2016561
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 10:11:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 1 Aug 2023 10:12:09 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 1 Aug 2023
 10:12:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: return failure if needed firmware elements are not recognized
Date:   Tue, 1 Aug 2023 10:11:27 +0800
Message-ID: <20230801021127.15919-9-pkshih@realtek.com>
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

WiFi 7 chips doesn't have static const tables defined in driver. If tables
aren't loaded properly from firmware file, driver can get NULL pointer
access exception. One way is to add the checking statements when trying to
access these tables, but I choose to check them right after loading
firmware elements from firmware file, so I don't need to add error handlers
everywhere.

Currently, the needed firmware elements of WiFi 6 chips are all zero, and
coming WiFi 7 chip will need at least BB MCU, parameters of BB and RF.
We will add them after 8922AE is verified.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 7 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b4aa1f9f041b1..468c14d035340 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3181,6 +3181,7 @@ struct rtw89_chip_info {
 	const char *fw_basename;
 	u8 fw_format_max;
 	bool try_ce_fw;
+	u32 needed_fw_elms;
 	u32 fifo_size;
 	bool small_fifo_size;
 	u32 dle_scc_rsvd_size;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index be629746b15b0..3935646c46678 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -656,6 +656,8 @@ int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	const struct firmware *firmware = fw_info->req.firmware;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 unrecognized_elements = chip->needed_fw_elms;
 	const struct rtw89_fw_element_handler *handler;
 	const struct rtw89_fw_element_hdr *hdr;
 	u32 elm_size;
@@ -663,6 +665,8 @@ int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
 	u32 offset;
 	int ret;
 
+	BUILD_BUG_ON(sizeof(chip->needed_fw_elms) * 8 < RTW89_FW_ELEMENT_ID_NUM);
+
 	offset = rtw89_mfw_get_size(rtwdev);
 	offset = ALIGN(offset, RTW89_FW_ELEMENT_ALIGN);
 	if (offset == 0)
@@ -693,11 +697,18 @@ int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
 			rtw89_info(rtwdev, "Firmware element %s version: %4ph\n",
 				   handler->name, hdr->ver);
 
+		unrecognized_elements &= ~BIT(elem_id);
 next:
 		offset += sizeof(*hdr) + elm_size;
 		offset = ALIGN(offset, RTW89_FW_ELEMENT_ALIGN);
 	}
 
+	if (unrecognized_elements) {
+		rtw89_err(rtwdev, "Firmware elements 0x%08x are unrecognized\n",
+			  unrecognized_elements);
+		return -ENOENT;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 9eb908122a4bc..94bdfc6059ba9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3511,6 +3511,8 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_RADIO_C = 6,
 	RTW89_FW_ELEMENT_ID_RADIO_D = 7,
 	RTW89_FW_ELEMENT_ID_RF_NCTL = 8,
+
+	RTW89_FW_ELEMENT_ID_NUM,
 };
 
 struct rtw89_fw_element_hdr {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index c3ffcb645ebf7..190297087ede3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2338,6 +2338,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.fw_basename		= RTW8851B_FW_BASENAME,
 	.fw_format_max		= RTW8851B_FW_FORMAT_MAX,
 	.try_ce_fw		= true,
+	.needed_fw_elms		= 0,
 	.fifo_size		= 196608,
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 6257414a3b4bd..e157e3435daf0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2075,6 +2075,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.fw_basename		= RTW8852A_FW_BASENAME,
 	.fw_format_max		= RTW8852A_FW_FORMAT_MAX,
 	.try_ce_fw		= false,
+	.needed_fw_elms		= 0,
 	.fifo_size		= 458752,
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 718f993da62af..334b545915085 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2507,6 +2507,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.fw_basename		= RTW8852B_FW_BASENAME,
 	.fw_format_max		= RTW8852B_FW_FORMAT_MAX,
 	.try_ce_fw		= true,
+	.needed_fw_elms		= 0,
 	.fifo_size		= 196608,
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9c7c9812d4f45..208153b664935 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2806,6 +2806,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.fw_basename		= RTW8852C_FW_BASENAME,
 	.fw_format_max		= RTW8852C_FW_FORMAT_MAX,
 	.try_ce_fw		= false,
+	.needed_fw_elms		= 0,
 	.fifo_size		= 458752,
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
-- 
2.25.1

