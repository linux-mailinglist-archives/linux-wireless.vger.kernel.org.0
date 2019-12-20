Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3A31277FD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 10:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLTJWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 04:22:31 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47434 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLTJWb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 04:22:31 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBK9MOZU025713, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBK9MOZU025713
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Dec 2019 17:22:24 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Dec 2019 17:22:23 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 04/11] rtw88: 8822c: update power sequence to v15
Date:   Fri, 20 Dec 2019 17:21:49 +0800
Message-ID: <20191220092156.13443-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220092156.13443-1-yhchuang@realtek.com>
References: <20191220092156.13443-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

Update card enable power sequence flow, to fix CMD11 fail after
reboot and wrong PLL clock.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 57faef21ea52..7c8db951a5bc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3487,12 +3487,12 @@ static struct rtw_pwr_seq_cmd trans_cardemu_to_act_8822c[] = {
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
 	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(7), 0},
-	{0x0005,
+	 RTW_PWR_CMD_WRITE, (BIT(4) | BIT(3)), 0},
+	{0x1018,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
 	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, (BIT(4) | BIT(3)), 0},
+	 RTW_PWR_CMD_WRITE, BIT(2), BIT(2)},
 	{0x0005,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
-- 
2.17.1

