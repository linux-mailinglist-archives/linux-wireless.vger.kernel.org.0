Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41443127801
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 10:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLTJWf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 04:22:35 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47429 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTJWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 04:22:30 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBK9MMWV025702, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBK9MMWV025702
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Dec 2019 17:22:23 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Dec 2019 17:22:22 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 02/11] rtw88: fix TX secondary channel offset of 40M if current bw is 20M or 40M
Date:   Fri, 20 Dec 2019 17:21:47 +0800
Message-ID: <20191220092156.13443-3-yhchuang@realtek.com>
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

From: Ping-Ke Shih <pkshih@realtek.com>

TX secondary channel offset is valid only if current bandwidth is 80M,
otherwise leave this value as zero. The wrong value of txsc40 causes
MAC unpredictable behavior.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 507970387b2a..ed9bb427ba60 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -16,10 +16,12 @@ void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 	u8 value8;
 
 	txsc20 = primary_ch_idx;
-	if (txsc20 == 1 || txsc20 == 3)
-		txsc40 = 9;
-	else
-		txsc40 = 10;
+	if (bw == RTW_CHANNEL_WIDTH_80) {
+		if (txsc20 == 1 || txsc20 == 3)
+			txsc40 = 9;
+		else
+			txsc40 = 10;
+	}
 	rtw_write8(rtwdev, REG_DATA_SC,
 		   BIT_TXSC_20M(txsc20) | BIT_TXSC_40M(txsc40));
 
-- 
2.17.1

