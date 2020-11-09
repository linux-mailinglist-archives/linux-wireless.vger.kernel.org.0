Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB42AB302
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgKIJAX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:00:23 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60055 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbgKIJAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:00:19 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A990CmZ4021869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A990CmZ4021869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 9 Nov 2020 17:00:12 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 9 Nov 2020 17:00:12 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 09/11] rtw88: coex: update WLAN 5G AFH parameter for 8822b
Date:   Mon, 9 Nov 2020 16:59:07 +0800
Message-ID: <20201109085909.9143-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201109085909.9143-1-pkshih@realtek.com>
References: <20201109085909.9143-1-pkshih@realtek.com>
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

Adaptive Frequency Hopping(AFH) is a method of transmitting
radio signals by rapidly changing the carrier frequency among
many distinct frequencies, which can avoid interference.
Add this feature to update AFH parameter for 8822b.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index c1a96c7fe67d..eeb0a658e712 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2259,7 +2259,6 @@ static const struct coex_tdma_para tdma_nsant_8822b[] = {
 /* rssi in percentage % (dbm = % - 100) */
 static const u8 wl_rssi_step_8822b[] = {60, 50, 44, 30};
 static const u8 bt_rssi_step_8822b[] = {30, 30, 30, 30};
-static const struct coex_5g_afh_map afh_5g_8822b[] = { {0, 0, 0} };
 
 /* wl_tx_dec_power, bt_tx_dec_power, wl_rx_gain, bt_rx_lna_constrain */
 static const struct coex_rf_para rf_para_tx_8822b[] = {
@@ -2280,6 +2279,27 @@ static const struct coex_rf_para rf_para_rx_8822b[] = {
 	{1, 13, true, 1}
 };
 
+static const struct coex_5g_afh_map afh_5g_8822b[] = {
+	{120, 2, 4},
+	{124, 8, 8},
+	{128, 17, 8},
+	{132, 26, 10},
+	{136, 34, 8},
+	{140, 42, 10},
+	{144, 51, 8},
+	{149, 62, 8},
+	{153, 71, 10},
+	{157, 77, 4},
+	{118, 2, 4},
+	{126, 12, 16},
+	{134, 29, 16},
+	{142, 46, 16},
+	{151, 66, 16},
+	{159, 76, 4},
+	{122, 10, 20},
+	{138, 37, 34},
+	{155, 68, 20}
+};
 static_assert(ARRAY_SIZE(rf_para_tx_8822b) == ARRAY_SIZE(rf_para_rx_8822b));
 
 static const u8
-- 
2.21.0

