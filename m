Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25AE3CF4E9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfJHIVQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:21:16 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47349 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHIVP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:21:15 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x988L9hR028150, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x988L9hR028150
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 8 Oct 2019 16:21:09 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 8 Oct 2019 16:21:09 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 07/10] rtw88: Use rtw_write8_set to set SYS_FUNC
Date:   Tue, 8 Oct 2019 16:20:58 +0800
Message-ID: <20191008082101.2494-8-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008082101.2494-1-yhchuang@realtek.com>
References: <20191008082101.2494-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

rtw_write8 could modify the values that we do not want
to change, use rtw_write8_set instead to only enable the
bits of sys_func_en

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index aa1f15e18c7a..8d72825ed3a7 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -261,7 +261,7 @@ static int rtw_mac_init_system_cfg(struct rtw_dev *rtwdev)
 	value |= BIT_WL_PLATFORM_RST | BIT_DDMA_EN;
 	rtw_write32(rtwdev, REG_CPU_DMEM_CON, value);
 
-	rtw_write8(rtwdev, REG_SYS_FUNC_EN + 1, sys_func_en);
+	rtw_write8_set(rtwdev, REG_SYS_FUNC_EN + 1, sys_func_en);
 	value8 = (rtw_read8(rtwdev, REG_CR_EXT + 3) & 0xF0) | 0x0C;
 	rtw_write8(rtwdev, REG_CR_EXT + 3, value8);
 
-- 
2.17.1

