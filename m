Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE7E14359F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2020 03:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAUCUT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 21:20:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728093AbgAUCUT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 21:20:19 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9B8EE16B131EA39C95F9;
        Tue, 21 Jan 2020 10:20:14 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 21 Jan 2020
 10:20:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <pkshih@realtek.com>, <kvalo@codeaurora.org>,
        <davem@davemloft.net>, <yuehaibing@huawei.com>,
        <Larry.Finger@lwfinger.net>
CC:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtlwifi: rtl8192ee: remove unused variables
Date:   Tue, 21 Jan 2020 10:19:24 +0800
Message-ID: <20200121021924.18792-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c:15:18:
 warning: ofdmswing_table defined but not used [-Wunused-const-variable=]
drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c:61:17:
 warning: cckswing_table_ch1ch13 defined but not used [-Wunused-const-variable=]
drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c:97:17:
 warning: cckswing_table_ch14 defined but not used [-Wunused-const-variable=]

These variable is never used, so remove them.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 .../net/wireless/realtek/rtlwifi/rtl8192ee/dm.c    | 118 ---------------------
 1 file changed, 118 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
index 648f910..551aa86 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
@@ -12,124 +12,6 @@
 #include "fw.h"
 #include "trx.h"
 
-static const u32 ofdmswing_table[OFDM_TABLE_SIZE] = {
-	0x7f8001fe,		/* 0, +6.0dB */
-	0x788001e2,		/* 1, +5.5dB */
-	0x71c001c7,		/* 2, +5.0dB */
-	0x6b8001ae,		/* 3, +4.5dB */
-	0x65400195,		/* 4, +4.0dB */
-	0x5fc0017f,		/* 5, +3.5dB */
-	0x5a400169,		/* 6, +3.0dB */
-	0x55400155,		/* 7, +2.5dB */
-	0x50800142,		/* 8, +2.0dB */
-	0x4c000130,		/* 9, +1.5dB */
-	0x47c0011f,		/* 10, +1.0dB */
-	0x43c0010f,		/* 11, +0.5dB */
-	0x40000100,		/* 12, +0dB */
-	0x3c8000f2,		/* 13, -0.5dB */
-	0x390000e4,		/* 14, -1.0dB */
-	0x35c000d7,		/* 15, -1.5dB */
-	0x32c000cb,		/* 16, -2.0dB */
-	0x300000c0,		/* 17, -2.5dB */
-	0x2d4000b5,		/* 18, -3.0dB */
-	0x2ac000ab,		/* 19, -3.5dB */
-	0x288000a2,		/* 20, -4.0dB */
-	0x26000098,		/* 21, -4.5dB */
-	0x24000090,		/* 22, -5.0dB */
-	0x22000088,		/* 23, -5.5dB */
-	0x20000080,		/* 24, -6.0dB */
-	0x1e400079,		/* 25, -6.5dB */
-	0x1c800072,		/* 26, -7.0dB */
-	0x1b00006c,		/* 27. -7.5dB */
-	0x19800066,		/* 28, -8.0dB */
-	0x18000060,		/* 29, -8.5dB */
-	0x16c0005b,		/* 30, -9.0dB */
-	0x15800056,		/* 31, -9.5dB */
-	0x14400051,		/* 32, -10.0dB */
-	0x1300004c,		/* 33, -10.5dB */
-	0x12000048,		/* 34, -11.0dB */
-	0x11000044,		/* 35, -11.5dB */
-	0x10000040,		/* 36, -12.0dB */
-	0x0f00003c,		/* 37, -12.5dB */
-	0x0e400039,		/* 38, -13.0dB */
-	0x0d800036,		/* 39, -13.5dB */
-	0x0cc00033,		/* 40, -14.0dB */
-	0x0c000030,		/* 41, -14.5dB */
-	0x0b40002d,		/* 42, -15.0dB */
-};
-
-static const u8 cckswing_table_ch1ch13[CCK_TABLE_SIZE][8] = {
-	{0x36, 0x35, 0x2e, 0x25, 0x1c, 0x12, 0x09, 0x04}, /* 0, +0dB */
-	{0x33, 0x32, 0x2b, 0x23, 0x1a, 0x11, 0x08, 0x04}, /* 1, -0.5dB */
-	{0x30, 0x2f, 0x29, 0x21, 0x19, 0x10, 0x08, 0x03}, /* 2, -1.0dB */
-	{0x2d, 0x2d, 0x27, 0x1f, 0x18, 0x0f, 0x08, 0x03}, /* 3, -1.5dB */
-	{0x2b, 0x2a, 0x25, 0x1e, 0x16, 0x0e, 0x07, 0x03}, /* 4, -2.0dB */
-	{0x28, 0x28, 0x22, 0x1c, 0x15, 0x0d, 0x07, 0x03}, /* 5, -2.5dB */
-	{0x26, 0x25, 0x21, 0x1b, 0x14, 0x0d, 0x06, 0x03}, /* 6, -3.0dB */
-	{0x24, 0x23, 0x1f, 0x19, 0x13, 0x0c, 0x06, 0x03}, /* 7, -3.5dB */
-	{0x22, 0x21, 0x1d, 0x18, 0x11, 0x0b, 0x06, 0x02}, /* 8, -4.0dB */
-	{0x20, 0x20, 0x1b, 0x16, 0x11, 0x08, 0x05, 0x02}, /* 9, -4.5dB */
-	{0x1f, 0x1e, 0x1a, 0x15, 0x10, 0x0a, 0x05, 0x02}, /* 10, -5.0dB */
-	{0x1d, 0x1c, 0x18, 0x14, 0x0f, 0x0a, 0x05, 0x02}, /* 11, -5.5dB */
-	{0x1b, 0x1a, 0x17, 0x13, 0x0e, 0x09, 0x04, 0x02}, /* 12, -6.0dB */
-	{0x1a, 0x19, 0x16, 0x12, 0x0d, 0x09, 0x04, 0x02}, /* 13, -6.5dB */
-	{0x18, 0x17, 0x15, 0x11, 0x0c, 0x08, 0x04, 0x02}, /* 14, -7.0dB */
-	{0x17, 0x16, 0x13, 0x10, 0x0c, 0x08, 0x04, 0x02}, /* 15, -7.5dB */
-	{0x16, 0x15, 0x12, 0x0f, 0x0b, 0x07, 0x04, 0x01}, /* 16, -8.0dB */
-	{0x14, 0x14, 0x11, 0x0e, 0x0b, 0x07, 0x03, 0x02}, /* 17, -8.5dB */
-	{0x13, 0x13, 0x10, 0x0d, 0x0a, 0x06, 0x03, 0x01}, /* 18, -9.0dB */
-	{0x12, 0x12, 0x0f, 0x0c, 0x09, 0x06, 0x03, 0x01}, /* 19, -9.5dB */
-	{0x11, 0x11, 0x0f, 0x0c, 0x09, 0x06, 0x03, 0x01}, /* 20, -10.0dB */
-	{0x10, 0x10, 0x0e, 0x0b, 0x08, 0x05, 0x03, 0x01}, /* 21, -10.5dB */
-	{0x0f, 0x0f, 0x0d, 0x0b, 0x08, 0x05, 0x03, 0x01}, /* 22, -11.0dB */
-	{0x0e, 0x0e, 0x0c, 0x0a, 0x08, 0x05, 0x02, 0x01}, /* 23, -11.5dB */
-	{0x0d, 0x0d, 0x0c, 0x0a, 0x07, 0x05, 0x02, 0x01}, /* 24, -12.0dB */
-	{0x0d, 0x0c, 0x0b, 0x09, 0x07, 0x04, 0x02, 0x01}, /* 25, -12.5dB */
-	{0x0c, 0x0c, 0x0a, 0x09, 0x06, 0x04, 0x02, 0x01}, /* 26, -13.0dB */
-	{0x0b, 0x0b, 0x0a, 0x08, 0x06, 0x04, 0x02, 0x01}, /* 27, -13.5dB */
-	{0x0b, 0x0a, 0x09, 0x08, 0x06, 0x04, 0x02, 0x01}, /* 28, -14.0dB */
-	{0x0a, 0x0a, 0x09, 0x07, 0x05, 0x03, 0x02, 0x01}, /* 29, -14.5dB */
-	{0x0a, 0x09, 0x08, 0x07, 0x05, 0x03, 0x02, 0x01}, /* 30, -15.0dB */
-	{0x09, 0x09, 0x08, 0x06, 0x05, 0x03, 0x01, 0x01}, /* 31, -15.5dB */
-	{0x09, 0x08, 0x07, 0x06, 0x04, 0x03, 0x01, 0x01}  /* 32, -16.0dB */
-};
-
-static const u8 cckswing_table_ch14[CCK_TABLE_SIZE][8] = {
-	{0x36, 0x35, 0x2e, 0x1b, 0x00, 0x00, 0x00, 0x00}, /* 0, +0dB */
-	{0x33, 0x32, 0x2b, 0x19, 0x00, 0x00, 0x00, 0x00}, /* 1, -0.5dB */
-	{0x30, 0x2f, 0x29, 0x18, 0x00, 0x00, 0x00, 0x00}, /* 2, -1.0dB */
-	{0x2d, 0x2d, 0x17, 0x17, 0x00, 0x00, 0x00, 0x00}, /* 3, -1.5dB */
-	{0x2b, 0x2a, 0x25, 0x15, 0x00, 0x00, 0x00, 0x00}, /* 4, -2.0dB */
-	{0x28, 0x28, 0x24, 0x14, 0x00, 0x00, 0x00, 0x00}, /* 5, -2.5dB */
-	{0x26, 0x25, 0x21, 0x13, 0x00, 0x00, 0x00, 0x00}, /* 6, -3.0dB */
-	{0x24, 0x23, 0x1f, 0x12, 0x00, 0x00, 0x00, 0x00}, /* 7, -3.5dB */
-	{0x22, 0x21, 0x1d, 0x11, 0x00, 0x00, 0x00, 0x00}, /* 8, -4.0dB */
-	{0x20, 0x20, 0x1b, 0x10, 0x00, 0x00, 0x00, 0x00}, /* 9, -4.5dB */
-	{0x1f, 0x1e, 0x1a, 0x0f, 0x00, 0x00, 0x00, 0x00}, /* 10, -5.0dB */
-	{0x1d, 0x1c, 0x18, 0x0e, 0x00, 0x00, 0x00, 0x00}, /* 11, -5.5dB */
-	{0x1b, 0x1a, 0x17, 0x0e, 0x00, 0x00, 0x00, 0x00}, /* 12, -6.0dB */
-	{0x1a, 0x19, 0x16, 0x0d, 0x00, 0x00, 0x00, 0x00}, /* 13, -6.5dB */
-	{0x18, 0x17, 0x15, 0x0c, 0x00, 0x00, 0x00, 0x00}, /* 14, -7.0dB */
-	{0x17, 0x16, 0x13, 0x0b, 0x00, 0x00, 0x00, 0x00}, /* 15, -7.5dB */
-	{0x16, 0x15, 0x12, 0x0b, 0x00, 0x00, 0x00, 0x00}, /* 16, -8.0dB */
-	{0x14, 0x14, 0x11, 0x0a, 0x00, 0x00, 0x00, 0x00}, /* 17, -8.5dB */
-	{0x13, 0x13, 0x10, 0x0a, 0x00, 0x00, 0x00, 0x00}, /* 18, -9.0dB */
-	{0x12, 0x12, 0x0f, 0x09, 0x00, 0x00, 0x00, 0x00}, /* 19, -9.5dB */
-	{0x11, 0x11, 0x0f, 0x09, 0x00, 0x00, 0x00, 0x00}, /* 20, -10.0dB */
-	{0x10, 0x10, 0x0e, 0x08, 0x00, 0x00, 0x00, 0x00}, /* 21, -10.5dB */
-	{0x0f, 0x0f, 0x0d, 0x08, 0x00, 0x00, 0x00, 0x00}, /* 22, -11.0dB */
-	{0x0e, 0x0e, 0x0c, 0x07, 0x00, 0x00, 0x00, 0x00}, /* 23, -11.5dB */
-	{0x0d, 0x0d, 0x0c, 0x07, 0x00, 0x00, 0x00, 0x00}, /* 24, -12.0dB */
-	{0x0d, 0x0c, 0x0b, 0x06, 0x00, 0x00, 0x00, 0x00}, /* 25, -12.5dB */
-	{0x0c, 0x0c, 0x0a, 0x06, 0x00, 0x00, 0x00, 0x00}, /* 26, -13.0dB */
-	{0x0b, 0x0b, 0x0a, 0x06, 0x00, 0x00, 0x00, 0x00}, /* 27, -13.5dB */
-	{0x0b, 0x0a, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00}, /* 28, -14.0dB */
-	{0x0a, 0x0a, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00}, /* 29, -14.5dB */
-	{0x0a, 0x09, 0x08, 0x05, 0x00, 0x00, 0x00, 0x00}, /* 30, -15.0dB */
-	{0x09, 0x09, 0x08, 0x05, 0x00, 0x00, 0x00, 0x00}, /* 31, -15.5dB */
-	{0x09, 0x08, 0x07, 0x04, 0x00, 0x00, 0x00, 0x00}  /* 32, -16.0dB */
-};
-
 static void rtl92ee_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 {
 	u32 ret_value;
-- 
2.7.4


