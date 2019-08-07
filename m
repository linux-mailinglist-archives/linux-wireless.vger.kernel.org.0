Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD1849D7
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfHGKk0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 06:40:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:56215 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfHGKk0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 06:40:26 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x77AeEF1010041, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x77AeEF1010041
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 7 Aug 2019 18:40:15 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 7 Aug 2019 18:40:14 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <sgruszka@redhat.com>
Subject: [PATCH 3/8] rtw88: 8822c: Enable interrupt migration
Date:   Wed, 7 Aug 2019 18:40:00 +0800
Message-ID: <1565174405-2689-4-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565174405-2689-1-git-send-email-yhchuang@realtek.com>
References: <1565174405-2689-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tsang-Shian Lin <thlin@realtek.com>

Enable 8822C Tx/Rx interrupt migration.
In some platforms, performance test may cause heavy cpu loading and get
bad results. Interrupt migration can decrease the amount of interrupts,
and lower cpu loading.

Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/reg.h      | 2 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 0bd0717..78ad053 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -193,6 +193,8 @@
 #define REG_H2C_READ_ADDR	0x024C
 #define REG_H2C_INFO		0x0254
 
+#define REG_INT_MIG		0x0304
+
 #define REG_FWHW_TXQ_CTRL	0x0420
 #define BIT_EN_BCNQ_DL		BIT(22)
 #define BIT_EN_WR_FREE_TAIL	BIT(20)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index b072d43..e11bbc3 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1114,6 +1114,7 @@ static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 #define WLAN_MAC_OPT_NORM_FUNC1		0x98
 #define WLAN_MAC_OPT_LB_FUNC1		0x80
 #define WLAN_MAC_OPT_FUNC2		0x30810041
+#define WLAN_MAC_INT_MIG_CFG		0x33330000
 
 #define WLAN_SIFS_CFG	(WLAN_SIFS_CCK_CONT_TX | \
 			(WLAN_SIFS_OFDM_CONT_TX << BIT_SHIFT_SIFS_OFDM_CTX) | \
@@ -1251,6 +1252,9 @@ static int rtw8822c_mac_init(struct rtw_dev *rtwdev)
 	value16 = BIT_SET_RXPSF_ERRTHR(value16, 0x07);
 	rtw_write16(rtwdev, REG_RXPSF_CTRL, value16);
 
+	/* Interrupt migration configuration */
+	rtw_write32(rtwdev, REG_INT_MIG, WLAN_MAC_INT_MIG_CFG);
+
 	return 0;
 }
 
-- 
2.7.4

