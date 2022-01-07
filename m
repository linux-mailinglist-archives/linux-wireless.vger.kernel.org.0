Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2F24870BB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 03:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbiAGCsB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 21:48:01 -0500
Received: from p-impout007aa.msg.pkvw.co.charter.net ([47.43.26.138]:45003
        "EHLO p-impout007.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344895AbiAGCsB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 21:48:01 -0500
Received: from localhost.localdomain ([24.31.246.181])
        by cmsmtp with ESMTP
        id 5fINnexpttfLp5fINnBfIU; Fri, 07 Jan 2022 02:48:00 +0000
X-Authority-Analysis: v=2.4 cv=A+F/goaG c=1 sm=1 tr=0 ts=61d7a9e0
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17 a=n9Sqmae0AAAA:8
 a=OLL_FvSJAAAA:8 a=pGLkceISAAAA:8 a=yQdBAQUQAAAA:8 a=nXKJQCjKDyof0ucNp9gA:9
 a=0A4Jcq2VObsA:10 a=fJnPzuQwECQA:10 a=UmAUUZEt6-oIqEbegvw9:22
 a=oIrB72frpwYPwTMnlWqB:22 a=SzazLyfi1tnkUD6oumHU:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        masterzorag <masterzorag@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] rtw88: rtw8821c: enable rfe 6 devices
Date:   Thu,  6 Jan 2022 20:47:39 -0600
Message-Id: <20220107024739.20967-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIysOHecWnGHramGsNFsavxIOikeloq57U6i41WRqq9Fu5/rp07KzoBfmwMWGFWPccVgrD8biFg0AKgun3cc542NLtukAr8JqZd4c+FgVGzbiAefWG3A
 xYpPJyH4Ku0YQwizoEGc9ofsP+oViwdxGrUF+ua9UJFjdOBKeCkVkxgnCnRdqWNYX0HwdXj8joFaNKkiSJH+TZ7LBNVe7IghLFboJ0GKnfnXGq+Lo1F38+ZV
 Pa4bWv/YGT5vuWsnplv9YdR6vBhP7ZmvPALpKtgwWhL/C/GMEEmz06QjLgiQe6ql5WpK+DCw/UZYB30NfQHUCGNqSjrEXpMZREayImfi1YXXXXGnND1+wIEe
 fyTxEPD+
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

In https://www.spinics.net/lists/linux-wireless/msg217116.html, Ping-Ke Shih
answered a question for a user about an rtl8821ce device that reported
RFE 6, which the driver did not support. Ping-Ke suggested a possible
fix, but the user never reported back.

A second user discovered the above thread and tested the proposed fix.
Accordingly, I am pushing this change, even though I am not the author.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Reported-and-tested-by: masterzorag <masterzorag@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index db078df63f85..b1f4afb50830 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1514,6 +1514,7 @@ static const struct rtw_rfe_def rtw8821c_rfe_defs[] = {
 	[0] = RTW_DEF_RFE(8821c, 0, 0),
 	[2] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
 	[4] = RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
+	[6] = RTW_DEF_RFE(8821c, 0, 0),
 };
 
 static struct rtw_hw_reg rtw8821c_dig[] = {
-- 
2.34.1

