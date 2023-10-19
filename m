Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9385A7CF42C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 11:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343953AbjJSJkE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 05:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJSJkD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 05:40:03 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B5E106
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 02:39:58 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1924:0:640:6d5b:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id 3E43D60AFE;
        Thu, 19 Oct 2023 12:39:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qdiH1B2W1W20-vL3tPciy;
        Thu, 19 Oct 2023 12:39:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697708392; bh=1aSyeouYsXjVmBgQDkKA30om2A0G0pSvS9tl1UVZo5k=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=DAzGm9CM2GoALl1vN7g+pOwxVvqIjGrrMMM9dBmyURWXDfPjrjdFLKVbOwxyZGVa9
         06pVY0vKxFB8VJGRY9OKDZGmQnt6PFn+HzJ/jy99jnIUmFzGKrKM6OFP/zFF60bz2H
         Q0GCwbFEalLQrZYBsMtNiI5e5/+fB0MzgEGWSjTU=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Tom Rix <trix@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtw89: fix clang-specific -Wvoid-pointer-to-enum-cast
Date:   Thu, 19 Oct 2023 12:38:01 +0300
Message-ID: <20231019093805.66324-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When compiling with clang-18, I've noticed the following:

drivers/net/wireless/realtek/rtw89/fw.c:389:28: warning: cast to smaller
integer type 'enum rtw89_fw_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
  389 |         enum rtw89_fw_type type = (enum rtw89_fw_type)data;
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/realtek/rtw89/fw.c:569:13: warning: cast to smaller
integer type 'enum rtw89_rf_path' from 'const void *' [-Wvoid-pointer-to-enum-cast]
  569 |                 rf_path = (enum rtw89_rf_path)data;
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~

So avoid brutal everything-to-const-void-and-back casts, introduce
'union rtw89_fw_element_data' to pass parameters to element handler
callbacks, and adjust all of the related bits accordingly. Compile
tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 81 +++++++++++++++----------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7cfcf536d6fe..13a98c44d304 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -13,6 +13,20 @@
 #include "reg.h"
 #include "util.h"
 
+union rtw89_fw_element_data {
+	size_t offset;
+	enum rtw89_rf_path path;
+	enum rtw89_fw_type type;
+};
+
+struct rtw89_fw_element_handler {
+	int (*fn)(struct rtw89_dev *rtwdev,
+		  const struct rtw89_fw_element_hdr *elm,
+		  const union rtw89_fw_element_data data);
+	const union rtw89_fw_element_data data;
+	const char *name;
+};
+
 static void rtw89_fw_c2h_cmd_handle(struct rtw89_dev *rtwdev,
 				    struct sk_buff *skb);
 static int rtw89_h2c_tx_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
@@ -384,9 +398,9 @@ int __rtw89_fw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 static
 int __rtw89_fw_recognize_from_elm(struct rtw89_dev *rtwdev,
 				  const struct rtw89_fw_element_hdr *elm,
-				  const void *data)
+				  const union rtw89_fw_element_data data)
 {
-	enum rtw89_fw_type type = (enum rtw89_fw_type)data;
+	enum rtw89_fw_type type = data.type;
 	struct rtw89_fw_suit *fw_suit;
 
 	fw_suit = rtw89_fw_suit_get(rtwdev, type);
@@ -542,7 +556,7 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 static
 int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 				 const struct rtw89_fw_element_hdr *elm,
-				 const void *data)
+				 const union rtw89_fw_element_data data)
 {
 	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
 	struct rtw89_phy_table *tbl;
@@ -566,7 +580,7 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 	case RTW89_FW_ELEMENT_ID_RADIO_B:
 	case RTW89_FW_ELEMENT_ID_RADIO_C:
 	case RTW89_FW_ELEMENT_ID_RADIO_D:
-		rf_path = (enum rtw89_rf_path)data;
+		rf_path = data.path;
 		idx = elm->u.reg2.idx;
 
 		elm_info->rf_radio[idx] = tbl;
@@ -604,10 +618,10 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 static
 int rtw89_fw_recognize_txpwr_from_elm(struct rtw89_dev *rtwdev,
 				      const struct rtw89_fw_element_hdr *elm,
-				      const void *data)
+				      union rtw89_fw_element_data data)
 {
 	const struct __rtw89_fw_txpwr_element *txpwr_elm = &elm->u.txpwr;
-	const unsigned long offset = (const unsigned long)data;
+	const unsigned long offset = data.offset;
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_txpwr_conf *conf;
 
@@ -644,64 +658,69 @@ int rtw89_fw_recognize_txpwr_from_elm(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-struct rtw89_fw_element_handler {
-	int (*fn)(struct rtw89_dev *rtwdev,
-		  const struct rtw89_fw_element_hdr *elm, const void *data);
-	const void *data;
-	const char *name;
-};
-
 static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 	[RTW89_FW_ELEMENT_ID_BBMCU0] = {__rtw89_fw_recognize_from_elm,
-					(const void *)RTW89_FW_BBMCU0, NULL},
+					{ .type = RTW89_FW_BBMCU0 }, NULL},
 	[RTW89_FW_ELEMENT_ID_BBMCU1] = {__rtw89_fw_recognize_from_elm,
-					(const void *)RTW89_FW_BBMCU1, NULL},
-	[RTW89_FW_ELEMENT_ID_BB_REG] = {rtw89_build_phy_tbl_from_elm, NULL, "BB"},
-	[RTW89_FW_ELEMENT_ID_BB_GAIN] = {rtw89_build_phy_tbl_from_elm, NULL, NULL},
+					{ .type = RTW89_FW_BBMCU1 }, NULL},
+	[RTW89_FW_ELEMENT_ID_BB_REG] = {rtw89_build_phy_tbl_from_elm,
+					{ 0 }, "BB"},
+	[RTW89_FW_ELEMENT_ID_BB_GAIN] = {rtw89_build_phy_tbl_from_elm,
+					 { 0 }, NULL},
 	[RTW89_FW_ELEMENT_ID_RADIO_A] = {rtw89_build_phy_tbl_from_elm,
-					 (const void *)RF_PATH_A, "radio A"},
+					 { .path = RF_PATH_A }, "radio A"},
 	[RTW89_FW_ELEMENT_ID_RADIO_B] = {rtw89_build_phy_tbl_from_elm,
-					 (const void *)RF_PATH_B, NULL},
+					 { .path = RF_PATH_B }, NULL},
 	[RTW89_FW_ELEMENT_ID_RADIO_C] = {rtw89_build_phy_tbl_from_elm,
-					 (const void *)RF_PATH_C, NULL},
+					 { .path = RF_PATH_C }, NULL},
 	[RTW89_FW_ELEMENT_ID_RADIO_D] = {rtw89_build_phy_tbl_from_elm,
-					 (const void *)RF_PATH_D, NULL},
-	[RTW89_FW_ELEMENT_ID_RF_NCTL] = {rtw89_build_phy_tbl_from_elm, NULL, "NCTL"},
+					 { .path = RF_PATH_D }, NULL},
+	[RTW89_FW_ELEMENT_ID_RF_NCTL] = {rtw89_build_phy_tbl_from_elm,
+					 { 0 }, "NCTL"},
 	[RTW89_FW_ELEMENT_ID_TXPWR_BYRATE] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, byrate.conf), "TXPWR",
+		{ .offset = offsetof(struct rtw89_rfe_data, byrate.conf) },
+		"TXPWR",
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_2GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_2ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_2ghz.conf) },
+		NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_5GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_5ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_5ghz.conf) },
+		NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_6GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_6ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_6ghz.conf) },
+		NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_2GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_ru_2ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_ru_2ghz.conf) },
+		NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_5GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_ru_5ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_ru_5ghz.conf) },
+		NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_6GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_ru_6ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_ru_6ghz.conf) },
+		NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, tx_shape_lmt.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, tx_shape_lmt.conf) },
+		NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, tx_shape_lmt_ru.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, tx_shape_lmt_ru.conf) },
+		NULL,
 	},
 };
 
-- 
2.41.0

