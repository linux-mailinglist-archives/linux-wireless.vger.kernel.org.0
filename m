Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB150455FC
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 09:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFNHY1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 03:24:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48172 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfFNHY1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 03:24:27 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5E7ONt3024943, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5E7ONt3024943
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 14 Jun 2019 15:24:23 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 15:24:22 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 06/11] rtw88: 8822c: disable rx clock gating before counter reset
Date:   Fri, 14 Jun 2019 15:24:10 +0800
Message-ID: <1560497055-17197-7-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560497055-17197-1-git-send-email-yhchuang@realtek.com>
References: <1560497055-17197-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Driver Could fail to reset counter if rx clock gating is not disabled.
So we need to disable rx clock gating before resetting counters.
Otherwise counters may increase unexpected.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 4 ++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index be46a1b..22380b1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1508,8 +1508,12 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
 	rtw_write32_mask(rtwdev, REG_CCANRX, BIT_CCK_FA_RST, 2);
 	rtw_write32_mask(rtwdev, REG_CCANRX, BIT_OFDM_FA_RST, 0);
 	rtw_write32_mask(rtwdev, REG_CCANRX, BIT_OFDM_FA_RST, 2);
+
+	/* disable rx clk gating to reset counters */
+	rtw_write32_clr(rtwdev, REG_RX_BREAK, BIT_COM_RX_GCK_EN);
 	rtw_write32_set(rtwdev, REG_CNT_CTRL, BIT_ALL_CNT_RST);
 	rtw_write32_clr(rtwdev, REG_CNT_CTRL, BIT_ALL_CNT_RST);
+	rtw_write32_set(rtwdev, REG_RX_BREAK, BIT_COM_RX_GCK_EN);
 }
 
 static void rtw8822c_do_iqk(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index ef708ba..33125e7 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -177,6 +177,8 @@ struct rtw8822c_efuse {
 #define BIT_CCK_BLK_EN		BIT(1)
 #define BIT_CCK_OFDM_BLK_EN	(BIT(0) | BIT(1))
 #define REG_CCAMSK	0x1c80
+#define REG_RX_BREAK	0x1d2c
+#define BIT_COM_RX_GCK_EN	BIT(31)
 #define REG_RXFNCTL	0x1d30
 #define REG_RXIGI	0x1d70
 #define REG_ENFN	0x1e24
-- 
2.7.4

