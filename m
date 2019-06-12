Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5C41C7C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 08:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfFLGph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 02:45:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51306 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfFLGpg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 02:45:36 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5C6jWxY004372, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5C6jWxY004372
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Jun 2019 14:45:32 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 14:45:31 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/11] rtw88: 8822c: use more accurate ofdm fa counting
Date:   Wed, 12 Jun 2019 14:45:13 +0800
Message-ID: <1560321917-17751-8-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
References: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

8822c used to count OFDM FA count by subtracting tx count from FA count.
But it need to substract more counters to be accurate.

However, we can count it by adding up all of the FA counters we want.
And it is simpler to add than list all of the components to substract.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 24 ++++++++++++++++++++----
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  5 +++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index b9185b2..4896f25 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1491,13 +1491,29 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
 	u32 cck_enable;
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
-	u32 ofdm_tx_counter;
+	u32 ofdm_fa_cnt1, ofdm_fa_cnt2, ofdm_fa_cnt3, ofdm_fa_cnt4, ofdm_fa_cnt5;
+	u16 parity_fail, rate_illegal, crc8_fail, mcs_fail, sb_search_fail,
+	    fast_fsync, crc8_fail_vhta, mcs_fail_vht;
 
 	cck_enable = rtw_read32(rtwdev, REG_ENCCK) & BIT_CCK_BLK_EN;
 	cck_fa_cnt = rtw_read16(rtwdev, REG_CCK_FACNT);
-	ofdm_fa_cnt = rtw_read16(rtwdev, REG_OFDM_FACNT);
-	ofdm_tx_counter = rtw_read16(rtwdev, REG_OFDM_TXCNT);
-	ofdm_fa_cnt -= ofdm_tx_counter;
+
+	ofdm_fa_cnt1 = rtw_read32(rtwdev, REG_OFDM_FACNT1);
+	ofdm_fa_cnt2 = rtw_read32(rtwdev, REG_OFDM_FACNT2);
+	ofdm_fa_cnt3 = rtw_read32(rtwdev, REG_OFDM_FACNT3);
+	ofdm_fa_cnt4 = rtw_read32(rtwdev, REG_OFDM_FACNT4);
+	ofdm_fa_cnt5 = rtw_read32(rtwdev, REG_OFDM_FACNT5);
+
+	parity_fail = (ofdm_fa_cnt1 & 0xffff0000) >> 16;
+	rate_illegal = (ofdm_fa_cnt2 & 0xffff);
+	crc8_fail = (ofdm_fa_cnt2 & 0xffff0000) >> 16;
+	crc8_fail_vhta = (ofdm_fa_cnt3 & 0xffff);
+	mcs_fail = (ofdm_fa_cnt4 & 0xffff);
+	mcs_fail_vht = (ofdm_fa_cnt4 & 0xffff0000) >> 16;
+	fast_fsync = (ofdm_fa_cnt5 & 0xffff);
+	sb_search_fail = (ofdm_fa_cnt5 & 0xffff0000) >> 16;
+	ofdm_fa_cnt = parity_fail + rate_illegal + crc8_fail + crc8_fail_vhta +
+		      mcs_fail + mcs_fail_vht + fast_fsync + sb_search_fail;
 
 	dm_info->cck_fa_cnt = cck_fa_cnt;
 	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index bf41359..62ef128 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -187,6 +187,11 @@ struct rtw8822c_efuse {
 #define REG_CNT_CTRL	0x1eb4
 #define BIT_ALL_CNT_RST		BIT(25)
 #define REG_OFDM_FACNT	0x2d00
+#define REG_OFDM_FACNT1	0x2d04
+#define REG_OFDM_FACNT2	0x2d08
+#define REG_OFDM_FACNT3	0x2d0c
+#define REG_OFDM_FACNT4	0x2d10
+#define REG_OFDM_FACNT5	0x2d20
 #define REG_OFDM_TXCNT	0x2de0
 #define REG_ORITXCODE2	0x4100
 #define REG_3WIRE2	0x410c
-- 
2.7.4

