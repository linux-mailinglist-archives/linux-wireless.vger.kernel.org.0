Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08128532DA3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiEXPgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238947AbiEXPgr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 11:36:47 -0400
Received: from p-impout007.msg.pkvw.co.charter.net (p-impout007aa.msg.pkvw.co.charter.net [47.43.26.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC69F3135E
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 08:36:45 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id tWaMnfPwitfLptWaTny5bq; Tue, 24 May 2022 15:36:45 +0000
X-Authority-Analysis: v=2.4 cv=A+F/goaG c=1 sm=1 tr=0 ts=628cfb8d
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=yQdBAQUQAAAA:8
 a=n9Sqmae0AAAA:8 a=GMpMNBm-7sDyb4zJ14QA:9 a=SzazLyfi1tnkUD6oumHU:22
 a=UmAUUZEt6-oIqEbegvw9:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH v3 1/4] rtw88: Fix sparse warning for rtw8822b_hw_spec
Date:   Tue, 24 May 2022 10:36:18 -0500
Message-Id: <20220524153621.19027-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524153621.19027-1-Larry.Finger@lwfinger.net>
References: <20220524153621.19027-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfC4CsaDp9Dbbiqe17PI2S1qEZMHvfGc1asURbwLZtviMNMz0nkGtneSnAlND+U1Fi6oiF+OjzgSeP8Jr8nR65bD8cPha0Pck9UHLLRuYidk5jOfHxJlq
 iqY43v1kH3WF1a2NsFWJeRgJlVubG/l303i/zhGrqt807YIkSJfoCqgYztrWb4oFE7/lB4H3GeCZnLGqqVBg/Qt05ft2xeENQnTlWR6G9rRwDEBx8ALcqdQy
 MaW9AtO4fwKu5aKd8yW5ytE2mp/PKzP7R3EHR/J6Eol6i1o5rg0UWZGI4zGiRjIhV4ljZOPDPJfuCwQyGcAVPVwZM01nHjw6RVyTUt2PWn+th/xGe6zYiadK
 ngryS9/ebfUHN4uV+jK+cdGCkrd0S4ThkLfDj+gcoJ+ufBa9iIk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sparse lists the following for rtw88:

  CHECK   drivers/net/wireless/realtek/rtw88/rtw8822b.c
drivers/net/wireless/realtek/rtw88/rtw8822b.c:2500:22: warning: symbol 'rtw8822b_hw_spec' was not declared. Should it be static?

The warning arises because the external declaration for rtw8822b_hw_spec
occurs in rtw8822be.h, which is not included in rtw8822b.h. That line is
moved, and the now empty file rtw8822be.h is deleted.

Symbol 'rtw8822b_hw_spec' can be made constant.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Ping-Ke Shih <pkshih@realtek.com>
---
v2 Change patch subjects as recommended by Kalle
v3 Make the correct fix for the warnings - 'static' is incorrect, but const is correct
---

 drivers/net/wireless/realtek/rtw88/rtw8822b.c  |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8822be.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822be.h | 10 ----------
 4 files changed, 4 insertions(+), 12 deletions(-)
 delete mode 100644 drivers/net/wireless/realtek/rtw88/rtw8822be.h

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index dccd722b8e62..321848870561 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2497,7 +2497,7 @@ static struct rtw_hw_reg_offset rtw8822b_edcca_th[] = {
 	[EDCCA_TH_H2L_IDX] = {{.addr = 0x8a4, .mask = MASKBYTE1}, .offset = 0},
 };
 
-struct rtw_chip_info rtw8822b_hw_spec = {
+const struct rtw_chip_info rtw8822b_hw_spec = {
 	.ops = &rtw8822b_ops,
 	.id = RTW_CHIP_TYPE_8822B,
 	.fw_name = "rtw88/rtw8822b_fw.bin",
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.h b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
index 3fff8b881854..01d3644e0c94 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
@@ -187,4 +187,6 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_ANTWT	0x1904
 #define REG_IQKFAILMSK	0x1bf0
 
+extern const struct rtw_chip_info rtw8822b_hw_spec;
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822be.c b/drivers/net/wireless/realtek/rtw88/rtw8822be.c
index 62ee7e62cac0..4994950776cd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822be.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822be.c
@@ -5,7 +5,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "pci.h"
-#include "rtw8822be.h"
+#include "rtw8822b.h"
 
 static const struct pci_device_id rtw_8822be_id_table[] = {
 	{
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822be.h b/drivers/net/wireless/realtek/rtw88/rtw8822be.h
deleted file mode 100644
index 6668460d664d..000000000000
--- a/drivers/net/wireless/realtek/rtw88/rtw8822be.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2018-2019  Realtek Corporation
- */
-
-#ifndef __RTW_8822BE_H_
-#define __RTW_8822BE_H_
-
-extern struct rtw_chip_info rtw8822b_hw_spec;
-
-#endif
-- 
2.36.1

