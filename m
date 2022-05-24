Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7DB532DA6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 17:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbiEXPg4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 11:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbiEXPgz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 11:36:55 -0400
Received: from p-impout007.msg.pkvw.co.charter.net (p-impout007aa.msg.pkvw.co.charter.net [47.43.26.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A93831347
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 08:36:53 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id tWaMnfPwitfLptWabny5d6; Tue, 24 May 2022 15:36:53 +0000
X-Authority-Analysis: v=2.4 cv=A+F/goaG c=1 sm=1 tr=0 ts=628cfb95
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=XEJPoD4cSoQjHLxuymgA:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v3 2/4] rtw88: Fix Sparse warning for rtw8822c_hw_spec
Date:   Tue, 24 May 2022 10:36:19 -0500
Message-Id: <20220524153621.19027-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524153621.19027-1-Larry.Finger@lwfinger.net>
References: <20220524153621.19027-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfN3Dj96fLLeUg8jvG5BDNCBFxUD4biK+00ptUWJEjk2twM5UzZU/M2JthiUvyy1zntsCEvFhSCuQmTub9+0/5/nU0RJibLpNIZ2VmcZsmZo9pkUOjZDe
 kb4bRHDoezdOGKIe89xBsYvRGm4YNA8zxbrYWu66OUptfmBswWe+wJhGhVaqCrViIV9qZbpgLOJG1U4NvnZfSBUdkZhvedhknnFOXgGxEStt5iVcd7oVJ7cM
 t/4LSDmRHrTdiXX9dR5rItCIMR7DdRfSts+6oe95aTdFH5sq3DO8x+jvN4b5d9yasHFfBMwQgE1bwxLgIobZMonUvfkgVzq7dTU/iiMK9H7JyW/zmJ1cYOQ1
 kzffT3wV8MnXHD2sQTjNyFAXX7N3BYZ7InJz9CxnXL34toXsjuY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse reports the following:

  CHECK   drivers/net/wireless/realtek/rtw88/rtw8822c.c
drivers/net/wireless/realtek/rtw88/rtw8822c.c:5313:22: warning: symbol 'rtw8822c_hw_spec' was not declared. Should it be static?

The warning arises because the external declaration for rtw8822c_hw_spec
occurs in rtw8822ce.h, which is not included in rtw8822c.h. That line is
moved, and the now empty file rtw8822ce.h is deleted.

Symbol 'rtw8822c_hw_spec' can be made constant.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 Change patch subjects as recommended by Kalle
v3 Make the correct fix for the warnings - 'static' is incorrect, but const is correct
---

 drivers/net/wireless/realtek/rtw88/rtw8822c.c  |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8822ce.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822ce.h | 10 ----------
 4 files changed, 4 insertions(+), 12 deletions(-)
 delete mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822ce.h

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index c043b5c520b9..09f9e4adcf34 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5310,7 +5310,7 @@ static const struct rtw_reg_domain coex_info_hw_regs_8822c[] = {
 	{0xc50, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
 };
 
-struct rtw_chip_info rtw8822c_hw_spec = {
+const struct rtw_chip_info rtw8822c_hw_spec = {
 	.ops = &rtw8822c_ops,
 	.id = RTW_CHIP_TYPE_8822C,
 	.fw_name = "rtw88/rtw8822c_fw.bin",
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index 8201955e1f21..479d5d769c52 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -118,6 +118,8 @@ enum rtw8822c_dpk_one_shot_action {
 void rtw8822c_parse_tbl_dpk(struct rtw_dev *rtwdev,
 			    const struct rtw_table *tbl);
 
+extern const struct rtw_chip_info rtw8822c_hw_spec;
+
 #define RTW_DECL_TABLE_DPK(name)			\
 const struct rtw_table name ## _tbl = {			\
 	.data = name,					\
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822ce.c b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
index 3845b1333dc3..e26c6bc82936 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
@@ -5,7 +5,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "pci.h"
-#include "rtw8822ce.h"
+#include "rtw8822c.h"
 
 static const struct pci_device_id rtw_8822ce_id_table[] = {
 	{
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822ce.h b/drivers/net/wireless/realtek/rtw88/rtw8822ce.h
deleted file mode 100644
index fee32d7a4504..000000000000
--- a/drivers/net/wireless/realtek/rtw88/rtw8822ce.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2018-2019  Realtek Corporation
- */
-
-#ifndef __RTW_8822CE_H_
-#define __RTW_8822CE_H_
-
-extern struct rtw_chip_info rtw8822c_hw_spec;
-
-#endif
-- 
2.36.1

