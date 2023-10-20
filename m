Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD087D074A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 06:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376266AbjJTELi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 00:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346941AbjJTELh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 00:11:37 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C67C9
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 21:11:31 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1f9b:0:640:e5b1:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 1E65660AB1;
        Fri, 20 Oct 2023 07:11:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id RBBV4C6DcKo0-oyxosPKv;
        Fri, 20 Oct 2023 07:11:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697775088; bh=kXTgyleFl/FXwYKCmo08PbR36t++EBLs3ba1wqNW9dA=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=eMI5MB+Wcz7sXamTnz3lccvvIwMGph0tfHM3ebvuESLSrcN9PdDy13vyTnLI08yeD
         26AYN/R6Mdp5ruS9TA6fKGgx2l1ch1aerH11/fCnlVpSg6UFJmxcHsLbpiOh3i+7TC
         hrg0ws5WAnRXUrdwjzylQarFAmqvGEE7KZf+OE40=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Tom Rix <trix@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: rtw89: cleanup firmware elements parsing
Date:   Fri, 20 Oct 2023 07:09:36 +0300
Message-ID: <20231020040940.33154-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <661e7dffafdb403abc2c4cab23c7d1ed@realtek.com>
References: <661e7dffafdb403abc2c4cab23c7d1ed@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
'union rtw89_fw_element_arg' to pass parameters to element handler
callbacks, and adjust all of the related bits accordingly. Compile
tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: prefer more subject-specific title and fix style issues (Ping-Ke Shih)
---
 drivers/net/wireless/realtek/rtw89/fw.c | 71 ++++++++++++++-----------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7cfcf536d6fe..a732c22a2d54 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -13,6 +13,20 @@
 #include "reg.h"
 #include "util.h"
 
+union rtw89_fw_element_arg {
+	size_t offset;
+	enum rtw89_rf_path rf_path;
+	enum rtw89_fw_type fw_type;
+};
+
+struct rtw89_fw_element_handler {
+	int (*fn)(struct rtw89_dev *rtwdev,
+		  const struct rtw89_fw_element_hdr *elm,
+		  const union rtw89_fw_element_arg arg);
+	const union rtw89_fw_element_arg arg;
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
+				  const union rtw89_fw_element_arg arg)
 {
-	enum rtw89_fw_type type = (enum rtw89_fw_type)data;
+	enum rtw89_fw_type type = arg.fw_type;
 	struct rtw89_fw_suit *fw_suit;
 
 	fw_suit = rtw89_fw_suit_get(rtwdev, type);
@@ -542,7 +556,7 @@ int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
 static
 int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 				 const struct rtw89_fw_element_hdr *elm,
-				 const void *data)
+				 const union rtw89_fw_element_arg arg)
 {
 	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
 	struct rtw89_phy_table *tbl;
@@ -566,7 +580,7 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 	case RTW89_FW_ELEMENT_ID_RADIO_B:
 	case RTW89_FW_ELEMENT_ID_RADIO_C:
 	case RTW89_FW_ELEMENT_ID_RADIO_D:
-		rf_path = (enum rtw89_rf_path)data;
+		rf_path = arg.rf_path;
 		idx = elm->u.reg2.idx;
 
 		elm_info->rf_radio[idx] = tbl;
@@ -604,10 +618,10 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 static
 int rtw89_fw_recognize_txpwr_from_elm(struct rtw89_dev *rtwdev,
 				      const struct rtw89_fw_element_hdr *elm,
-				      const void *data)
+				      const union rtw89_fw_element_arg arg)
 {
 	const struct __rtw89_fw_txpwr_element *txpwr_elm = &elm->u.txpwr;
-	const unsigned long offset = (const unsigned long)data;
+	const unsigned long offset = arg.offset;
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_txpwr_conf *conf;
 
@@ -644,64 +658,57 @@ int rtw89_fw_recognize_txpwr_from_elm(struct rtw89_dev *rtwdev,
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
+					{ .fw_type = RTW89_FW_BBMCU0 }, NULL},
 	[RTW89_FW_ELEMENT_ID_BBMCU1] = {__rtw89_fw_recognize_from_elm,
-					(const void *)RTW89_FW_BBMCU1, NULL},
-	[RTW89_FW_ELEMENT_ID_BB_REG] = {rtw89_build_phy_tbl_from_elm, NULL, "BB"},
-	[RTW89_FW_ELEMENT_ID_BB_GAIN] = {rtw89_build_phy_tbl_from_elm, NULL, NULL},
+					{ .fw_type = RTW89_FW_BBMCU1 }, NULL},
+	[RTW89_FW_ELEMENT_ID_BB_REG] = {rtw89_build_phy_tbl_from_elm, {}, "BB"},
+	[RTW89_FW_ELEMENT_ID_BB_GAIN] = {rtw89_build_phy_tbl_from_elm, {}, NULL},
 	[RTW89_FW_ELEMENT_ID_RADIO_A] = {rtw89_build_phy_tbl_from_elm,
-					 (const void *)RF_PATH_A, "radio A"},
+					 { .rf_path =  RF_PATH_A }, "radio A"},
 	[RTW89_FW_ELEMENT_ID_RADIO_B] = {rtw89_build_phy_tbl_from_elm,
-					 (const void *)RF_PATH_B, NULL},
+					 { .rf_path =  RF_PATH_B }, NULL},
 	[RTW89_FW_ELEMENT_ID_RADIO_C] = {rtw89_build_phy_tbl_from_elm,
-					 (const void *)RF_PATH_C, NULL},
+					 { .rf_path =  RF_PATH_C }, NULL},
 	[RTW89_FW_ELEMENT_ID_RADIO_D] = {rtw89_build_phy_tbl_from_elm,
-					 (const void *)RF_PATH_D, NULL},
-	[RTW89_FW_ELEMENT_ID_RF_NCTL] = {rtw89_build_phy_tbl_from_elm, NULL, "NCTL"},
+					 { .rf_path =  RF_PATH_D }, NULL},
+	[RTW89_FW_ELEMENT_ID_RF_NCTL] = {rtw89_build_phy_tbl_from_elm, {}, "NCTL"},
 	[RTW89_FW_ELEMENT_ID_TXPWR_BYRATE] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, byrate.conf), "TXPWR",
+		{ .offset = offsetof(struct rtw89_rfe_data, byrate.conf) }, "TXPWR",
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_2GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_2ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_2ghz.conf) }, NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_5GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_5ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_5ghz.conf) }, NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_6GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_6ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_6ghz.conf) }, NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_2GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_ru_2ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_ru_2ghz.conf) }, NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_5GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_ru_5ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_ru_5ghz.conf) }, NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_6GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, lmt_ru_6ghz.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, lmt_ru_6ghz.conf) }, NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, tx_shape_lmt.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, tx_shape_lmt.conf) }, NULL,
 	},
 	[RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU] = {
 		rtw89_fw_recognize_txpwr_from_elm,
-		(const void *)offsetof(struct rtw89_rfe_data, tx_shape_lmt_ru.conf), NULL,
+		{ .offset = offsetof(struct rtw89_rfe_data, tx_shape_lmt_ru.conf) }, NULL,
 	},
 };
 
@@ -742,7 +749,7 @@ int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
 		if (!handler->fn)
 			goto next;
 
-		ret = handler->fn(rtwdev, hdr, handler->data);
+		ret = handler->fn(rtwdev, hdr, handler->arg);
 		if (ret)
 			return ret;
 
-- 
2.41.0

