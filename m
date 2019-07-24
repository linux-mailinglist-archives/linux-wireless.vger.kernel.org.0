Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23721727C3
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 08:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfGXGFC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 02:05:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49309 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXGFC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 02:05:02 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6O64qCN011113, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6O64qCN011113
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jul 2019 14:04:52 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Jul 2019 14:04:51 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>
Subject: [PATCH 2/5] rtw88: check efuse for BT FT S1
Date:   Wed, 24 Jul 2019 14:04:30 +0800
Message-ID: <1563948273-17910-3-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563948273-17910-1-git-send-email-yhchuang@realtek.com>
References: <1563948273-17910-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Some modules might not have full programed efuse.
Driver should check the BT FT S1 type to know that
if BT has been programed. If BT is not programed,
throw a warning to notify that this module is not
capable of working with WiFi + BT concurrently.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/efuse.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/efuse.c b/drivers/net/wireless/realtek/rtw88/efuse.c
index 66e56f3..82aa26a 100644
--- a/drivers/net/wireless/realtek/rtw88/efuse.c
+++ b/drivers/net/wireless/realtek/rtw88/efuse.c
@@ -8,6 +8,11 @@
 #include "debug.h"
 
 #define RTW_EFUSE_BANK_WIFI		0x0
+#define RTW_EFUSE_BANK_BT		0x1
+
+#define EFUSE_BT_S1_ADDR		0x4a
+#define EFUSE_BT_S1_TYPE1		0xff
+#define EFUSE_BT_S1_TYPE2		0x00
 
 static void switch_efuse_bank(struct rtw_dev *rtwdev, u8 efuse_bank)
 {
@@ -89,6 +94,7 @@ static int rtw_dump_physical_efuse_map(struct rtw_dev *rtwdev, u8 *map)
 	u32 efuse_ctl;
 	u32 addr;
 	u32 cnt;
+	u8 ft_ver;
 
 	switch_efuse_bank(rtwdev, RTW_EFUSE_BANK_WIFI);
 
@@ -113,6 +119,24 @@ static int rtw_dump_physical_efuse_map(struct rtw_dev *rtwdev, u8 *map)
 		*(map + addr) = (u8)(efuse_ctl & BIT_MASK_EF_DATA);
 	}
 
+	/* verify BT FT S1 efuse type */
+	switch_efuse_bank(rtwdev, RTW_EFUSE_BANK_BT);
+
+	efuse_ctl = rtw_read32(rtwdev, REG_EFUSE_CTRL);
+	efuse_ctl &= ~(BIT_MASK_EF_DATA | BITS_EF_ADDR);
+	efuse_ctl |= (EFUSE_BT_S1_ADDR & BIT_MASK_EF_ADDR) << BIT_SHIFT_EF_ADDR;
+	rtw_write32(rtwdev, REG_EFUSE_CTRL, efuse_ctl & (~BIT_EF_FLAG));
+
+	if (!check_hw_ready(rtwdev, REG_EFUSE_CTRL, BIT_EF_FLAG, 0x1)) {
+		rtw_err(rtwdev, "failed to read BT efuse\n");
+		return -EBUSY;
+	}
+
+	efuse_ctl = rtw_read32(rtwdev, REG_EFUSE_CTRL);
+	ft_ver = (u8)(efuse_ctl & BIT_MASK_EF_DATA);
+	if (ft_ver == EFUSE_BT_S1_TYPE1 || ft_ver == EFUSE_BT_S1_TYPE2)
+		rtw_warn(rtwdev, "BT S1 not calibrated, not recommended to verify BT for this module\n");
+
 	return 0;
 }
 
-- 
2.7.4

