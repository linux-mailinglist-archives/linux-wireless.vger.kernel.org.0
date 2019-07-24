Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1142727C4
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 08:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfGXGFC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 02:05:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49310 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfGXGFC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 02:05:02 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6O64pu7011109, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6O64pu7011109
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jul 2019 14:04:51 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Jul 2019 14:04:50 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>
Subject: [PATCH 1/5] rtw88: switch specified efuse bank
Date:   Wed, 24 Jul 2019 14:04:29 +0800
Message-ID: <1563948273-17910-2-git-send-email-yhchuang@realtek.com>
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

Allows to switch different type of efuse bank by passing
the bank type to swtich to.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/efuse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/efuse.c b/drivers/net/wireless/realtek/rtw88/efuse.c
index 212c837..66e56f3 100644
--- a/drivers/net/wireless/realtek/rtw88/efuse.c
+++ b/drivers/net/wireless/realtek/rtw88/efuse.c
@@ -9,10 +9,10 @@
 
 #define RTW_EFUSE_BANK_WIFI		0x0
 
-static void switch_efuse_bank(struct rtw_dev *rtwdev)
+static void switch_efuse_bank(struct rtw_dev *rtwdev, u8 efuse_bank)
 {
 	rtw_write32_mask(rtwdev, REG_LDO_EFUSE_CTRL, BIT_MASK_EFUSE_BANK_SEL,
-			 RTW_EFUSE_BANK_WIFI);
+			 efuse_bank);
 }
 
 #define invalid_efuse_header(hdr1, hdr2) \
@@ -90,7 +90,7 @@ static int rtw_dump_physical_efuse_map(struct rtw_dev *rtwdev, u8 *map)
 	u32 addr;
 	u32 cnt;
 
-	switch_efuse_bank(rtwdev);
+	switch_efuse_bank(rtwdev, RTW_EFUSE_BANK_WIFI);
 
 	/* disable 2.5V LDO */
 	chip->ops->cfg_ldo25(rtwdev, false);
-- 
2.7.4

