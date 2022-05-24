Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7F0532DA9
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 17:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbiEXPhG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 11:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbiEXPhC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 11:37:02 -0400
Received: from p-impout007.msg.pkvw.co.charter.net (p-impout007aa.msg.pkvw.co.charter.net [47.43.26.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC033EBD
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 08:36:59 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id tWaMnfPwitfLptWahny5eG; Tue, 24 May 2022 15:36:59 +0000
X-Authority-Analysis: v=2.4 cv=A+F/goaG c=1 sm=1 tr=0 ts=628cfb9b
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=jSSIIWNXt1tgi8AzHDQA:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v3 3/4] rtw88: Fix Sparse warning for rtw8723d_hw_spec
Date:   Tue, 24 May 2022 10:36:20 -0500
Message-Id: <20220524153621.19027-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524153621.19027-1-Larry.Finger@lwfinger.net>
References: <20220524153621.19027-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBRWF71EEEHP9kEEUduP0slXZOl2vMcHVMB31VkM6N8mR9bKADKljP/GoYt7z9B+7KCY0dDdsQ4Lf3cBllwNB7k4GUBfO52FLgQgL7hGWP8wWd7k/bK8
 RA6IcmGUY8m0m4OJAGuLWN4HdrT6oQ7lPFhjKuXwb1z+uypEe6JSsqQdVYMeKC/ElKs7BYEUkRNtGYxMtMd7aY0K388wLUo+VwhXdfqYihzeRawXspuMyquD
 1GHfBPykn3AMqSUxq11wo87W4Yu63+SHJL0Di42C/+8oork64rCt2Wtj+tDnjY4OyFpUrpnDaYksPQSKMGXY5Z/jlVKfjgEgbKFhjTNPV4iT1Z9bjhqJvxhK
 HYOsgsWTyV1KGXiAlJKsb5MiBVTX4k2PLxGl68TGwqs1DwbLyso=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse lists the following:

  CHECK   drivers/net/wireless/realtek/rtw88/rtw8723d.c
drivers/net/wireless/realtek/rtw88/rtw8723d.c:2704:22: warning: symbol 'rtw8723d_hw_spec' was not declared. Should it be static?

The warning arises because the external declaration for rtw8723d_hw_spec
occurs in rtw8723de.h, which is not included in rtw8723d.h. That line is
moved, and the now empty file rtw8723de.h is deleted.

Symbol 'rtw8723d_hw_spec' can be made constant.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 Change patch subjects as recommended by Kalle
v3 Make the correct fix for the warnings - 'static' is incorrect, but const is correct
---

 drivers/net/wireless/realtek/rtw88/rtw8723d.c  |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8723de.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723de.h | 10 ----------
 4 files changed, 4 insertions(+), 12 deletions(-)
 delete mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723de.h

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 93cce44df531..993bd6b1d723 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2701,7 +2701,7 @@ static const struct rtw_reg_domain coex_info_hw_regs_8723d[] = {
 	{0x953, BIT(1), RTW_REG_DOMAIN_MAC8},
 };
 
-struct rtw_chip_info rtw8723d_hw_spec = {
+const struct rtw_chip_info rtw8723d_hw_spec = {
 	.ops = &rtw8723d_ops,
 	.id = RTW_CHIP_TYPE_8723D,
 	.fw_name = "rtw88/rtw8723d_fw.bin",
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 41d35174a542..4641f6e047b4 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -72,6 +72,8 @@ struct rtw8723d_efuse {
 	struct rtw8723de_efuse e;
 };
 
+extern const struct rtw_chip_info rtw8723d_hw_spec;
+
 /* phy status page0 */
 #define GET_PHY_STAT_P0_PWDB(phy_stat)                                         \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(15, 8))
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723de.c b/drivers/net/wireless/realtek/rtw88/rtw8723de.c
index 2dd689441e8d..abbaafa32851 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723de.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723de.c
@@ -5,7 +5,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "pci.h"
-#include "rtw8723de.h"
+#include "rtw8723d.h"
 
 static const struct pci_device_id rtw_8723de_id_table[] = {
 	{
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723de.h b/drivers/net/wireless/realtek/rtw88/rtw8723de.h
deleted file mode 100644
index 2b4894846a07..000000000000
--- a/drivers/net/wireless/realtek/rtw88/rtw8723de.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2018-2019  Realtek Corporation
- */
-
-#ifndef __RTW_8723DE_H_
-#define __RTW_8723DE_H_
-
-extern struct rtw_chip_info rtw8723d_hw_spec;
-
-#endif
-- 
2.36.1

