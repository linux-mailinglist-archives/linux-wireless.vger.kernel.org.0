Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CFC2C4D2A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 03:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbgKZCM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 21:12:27 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60672 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732902AbgKZCM1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 21:12:27 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AQ2CLVz8030333, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AQ2CLVz8030333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Nov 2020 10:12:21 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 26 Nov 2020 10:12:21 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <tony0620emma@gmail.com>, <ku920601@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 08/10] rtw88: coex: add action for coexistence in hardware initial
Date:   Thu, 26 Nov 2020 10:10:57 +0800
Message-ID: <20201126021059.11981-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201126021059.11981-1-pkshih@realtek.com>
References: <20201126021059.11981-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

The original setting misses some necessary configuration.
Make coexistence slot align to beacon and check the connection situation
to know if we need to extend WLAN slot or not.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index eab5529e6764..f1f12ff0797b 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2448,11 +2448,19 @@ static void rtw_coex_init_coex_var(struct rtw_dev *rtwdev)
 static void __rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 
 	rtw_coex_init_coex_var(rtwdev);
+
+	coex_stat->kt_ver = u8_get_bits(rtw_read8(rtwdev, 0xf1), GENMASK(7, 4));
+
 	rtw_coex_monitor_bt_enable(rtwdev);
+	rtw_coex_wl_slot_extend(rtwdev, coex_stat->wl_slot_extend);
+
+	rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
+
 	rtw_coex_set_rfe_type(rtwdev);
 	rtw_coex_set_init(rtwdev);
 
@@ -2515,6 +2523,7 @@ void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
 	rtw_coex_table(rtwdev, true, table_case);
 	/* red x issue */
 	rtw_write8(rtwdev, 0xff1a, 0x0);
+	rtw_coex_set_gnt_debug(rtwdev);
 }
 
 void rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
-- 
2.21.0

