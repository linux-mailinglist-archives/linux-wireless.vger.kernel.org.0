Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5ECF4E3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfJHIVN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:21:13 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47340 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbfJHIVM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:21:12 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x988L61b028133, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x988L61b028133
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 8 Oct 2019 16:21:06 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 8 Oct 2019 16:21:06 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 03/10] rtw88: config 8822c multicast address in MAC init flow
Date:   Tue, 8 Oct 2019 16:20:54 +0800
Message-ID: <20191008082101.2494-4-yhchuang@realtek.com>
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

From: Tzu-En Huang <tehuang@realtek.com>

Multicast address should be congiured in the initialization flow.
The value is created by a hashed calculation that is also implemented
by the hardware for multicast address filtering.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/reg.h      | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index a6d1260acb91..7e817bc997eb 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -310,6 +310,7 @@
 #define REG_RX_PKT_LIMIT	0x060C
 #define REG_RX_DRVINFO_SZ	0x060F
 #define BIT_APP_PHYSTS		BIT(28)
+#define REG_MAR			0x0620
 #define REG_USTIME_EDCA		0x0638
 #define REG_ACKTO_CCK		0x0639
 #define REG_RESP_SIFS_CCK	0x063C
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 434b7d726ee5..4c8916516064 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1136,6 +1136,7 @@ static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 #define WLAN_RTS_RATE_FB_RATE4_H	0x400003E0
 #define WLAN_RTS_RATE_FB_RATE5		0x0600F015
 #define WLAN_RTS_RATE_FB_RATE5_H	0x000000E0
+#define WLAN_MULTI_ADDR			0xFFFFFFFF
 
 #define WLAN_TX_FUNC_CFG1		0x30
 #define WLAN_TX_FUNC_CFG2		0x30
@@ -1245,6 +1246,8 @@ static int rtw8822c_mac_init(struct rtw_dev *rtwdev)
 	rtw_write8(rtwdev, REG_BCN_MAX_ERR, WLAN_BCN_MAX_ERR);
 
 	/* WMAC configuration */
+	rtw_write32(rtwdev, REG_MAR, WLAN_MULTI_ADDR);
+	rtw_write32(rtwdev, REG_MAR + 4, WLAN_MULTI_ADDR);
 	rtw_write8(rtwdev, REG_BBPSF_CTRL + 2, WLAN_RESP_TXRATE);
 	rtw_write8(rtwdev, REG_ACKTO, WLAN_ACK_TO);
 	rtw_write8(rtwdev, REG_ACKTO_CCK, WLAN_ACK_TO_CCK);
-- 
2.17.1

