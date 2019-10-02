Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67AAC47D5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfJBGfs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:48 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57722 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfJBGfs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:48 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926Zg0I013089, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926Zg0I013089
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:42 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:41 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 11/14] rtw88: raise firmware version debug level
Date:   Wed, 2 Oct 2019 14:35:28 +0800
Message-ID: <20191002063531.18135-12-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

It's better to print firmware version at load time.
But since we need to set debug_mask properly to default print
rtw_dbg(), raise the debug level to rtw_info() instead.

Also change the multiple line style to one line only, it will
be easier for log analyzing.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index f40877bc9c9a..75f35a97dca7 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -578,10 +578,8 @@ static void update_firmware_info(struct rtw_dev *rtwdev,
 	fw->sub_version = *(data + FW_HDR_SUBVERSION);
 	fw->sub_index = *(data + FW_HDR_SUBINDEX);
 
-	rtw_dbg(rtwdev, RTW_DBG_FW, "fw h2c version: %x\n", fw->h2c_version);
-	rtw_dbg(rtwdev, RTW_DBG_FW, "fw version:     %x\n", fw->version);
-	rtw_dbg(rtwdev, RTW_DBG_FW, "fw sub version: %x\n", fw->sub_version);
-	rtw_dbg(rtwdev, RTW_DBG_FW, "fw sub index:   %x\n", fw->sub_index);
+	rtw_info(rtwdev, "Firmware version %u.%u.%u, H2C version %u\n",
+		 fw->version, fw->sub_version, fw->sub_index, fw->h2c_version);
 }
 
 static int
-- 
2.17.1

