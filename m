Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903732C38C5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 06:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgKYFkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 00:40:24 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45830 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgKYFkX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 00:40:23 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AP5eINP1026142, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AP5eINP1026142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 Nov 2020 13:40:18 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 25 Nov 2020 13:40:17 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <yhchuang@realtek.com>, <ku920601@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 05/10] rtw88: coex: change the coexistence mechanism for HID
Date:   Wed, 25 Nov 2020 13:38:56 +0800
Message-ID: <20201125053901.29678-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201125053901.29678-1-pkshih@realtek.com>
References: <20201125053901.29678-1-pkshih@realtek.com>
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

Add TDMA slot type setting for later usage.
Since the transmission of HID profile is very frequently,
it may bring a big impact to WLAN performance.
To change slot type, it can make mechanism be more flexible.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 3a86b7191ba3..8ea5e115a81e 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1677,6 +1677,7 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
 	u32 wl_bw;
+	u32 slot_type = 0;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
@@ -1739,7 +1740,7 @@ static void rtw_coex_action_bt_hid(struct rtw_dev *rtwdev)
 	}
 
 	rtw_coex_table(rtwdev, false, table_case);
-	rtw_coex_tdma(rtwdev, false, tdma_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
 static void rtw_coex_action_bt_a2dp(struct rtw_dev *rtwdev)
-- 
2.21.0

