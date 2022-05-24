Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C728532DAA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbiEXPh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 11:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiEXPhZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 11:37:25 -0400
Received: from p-impout007.msg.pkvw.co.charter.net (p-impout007aa.msg.pkvw.co.charter.net [47.43.26.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78FD6223D
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 08:37:21 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id tWb2nfQAktfLptWb2ny5i8; Tue, 24 May 2022 15:37:20 +0000
X-Authority-Analysis: v=2.4 cv=A+F/goaG c=1 sm=1 tr=0 ts=628cfbb0
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=TcJKRCS9Dne6_0BgUPwA:9 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
Date:   Tue, 24 May 2022 10:37:16 -0500
Message-Id: <20220524153716.20450-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKXdI5JdOdRDI0h2q/oxxcBBA6Rw2hqZQvQQe3GfZLXb0+Im+I0PPBhvrk7d9a3iYmryZ8Ts77Alt1x/IynnhrIw4ddH82lDQw9g2HcioIamYZ8nmr5W
 MOwHdSwXZeN1GYwWDDvZeC0R3evPmZ6yOdLTYFUPEFh/4IQVvCQnJSmUYfUAgEdkH7yc8ZZsixX7rlEu8JaKHUy5A4/uIQSPcU0huJkfzOEYR5K+JDjYgj7y
 oIYwwzEx3zHksspvC12PVTdE988GwgmI5AMBak9Sky8elPQSvVMise4ZWHRqHgYD1Ln9Xc7KpFfAdpkh8eSSWkBaznxXS/q76eWyifSo8kiOLX2PTGdsVyt0
 d6Qx5wZ5mDbI7ipNtMqT4FKS76tqVfXZ+pNMGQMxCTsfJ7TCxpo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse lists the following:

  CHECK   drivers/net/wireless/realtek/rtw88/rtw8821c.c
drivers/net/wireless/realtek/rtw88/rtw8821c.c:1880:22: warning: symbol 'rtw8821c_hw_spec' was not declared. Should it be static?

The warning arises because the external declaration for rtw8821c_hw_spec
occurs in rtw8821ce.h, which is not included in rtw8821c.h. That line is
moved, and the now empty file rtw8821ce.h is deleted.

Symbol 'rtw8821c_hw_spec' can be made constant.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 Change patch subjects as recommended by Kalle
v3 Make the correct fix for the warnings - 'static' is incorrect, but const is correct
---

 drivers/net/wireless/realtek/rtw88/rtw8821c.c  |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821ce.h | 10 ----------
 4 files changed, 4 insertions(+), 12 deletions(-)
 delete mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821ce.h

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index ffee39ea5df6..42841f5d502c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1877,7 +1877,7 @@ static const struct rtw_reg_domain coex_info_hw_regs_8821c[] = {
 	{0x60A, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
 };
 
-struct rtw_chip_info rtw8821c_hw_spec = {
+const struct rtw_chip_info rtw8821c_hw_spec = {
 	.ops = &rtw8821c_ops,
 	.id = RTW_CHIP_TYPE_8821C,
 	.fw_name = "rtw88/rtw8821c_fw.bin",
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index d9fbddd7b0f3..2698801fc35d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -84,6 +84,8 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 	rtw_write32_mask(rtwdev, addr + 0x200, mask, data);
 }
 
+extern const struct rtw_chip_info rtw8821c_hw_spec;
+
 #define rtw_write32s_mask(rtwdev, addr, mask, data)			       \
 	do {								       \
 		BUILD_BUG_ON((addr) < 0xC00 || (addr) >= 0xD00);	       \
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821ce.c b/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
index 56d22f9de904..f3d971feda04 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
@@ -5,7 +5,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "pci.h"
-#include "rtw8821ce.h"
+#include "rtw8821c.h"
 
 static const struct pci_device_id rtw_8821ce_id_table[] = {
 	{
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821ce.h b/drivers/net/wireless/realtek/rtw88/rtw8821ce.h
deleted file mode 100644
index 54142acca534..000000000000
--- a/drivers/net/wireless/realtek/rtw88/rtw8821ce.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2018-2019  Realtek Corporation
- */
-
-#ifndef __RTW_8821CE_H_
-#define __RTW_8821CE_H_
-
-extern struct rtw_chip_info rtw8821c_hw_spec;
-
-#endif
-- 
2.36.1

