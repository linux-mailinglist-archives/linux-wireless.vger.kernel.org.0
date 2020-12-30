Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C325D2E75D7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Dec 2020 04:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL3DhT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Dec 2020 22:37:19 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39177 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL3DhT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Dec 2020 22:37:19 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0BU3aVbhD017533, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0BU3aVbhD017533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Dec 2020 11:36:31 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 30 Dec
 2020 11:36:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>
Subject: [PATCH] rtw88: coex: set 4 slot TDMA for BT link and WL busy
Date:   Wed, 30 Dec 2020 11:36:02 +0800
Message-ID: <20201230033602.13636-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To protect both of WL/BT performance while BT is under re-link state.
4-slot mode TDMA can make the re-link more sensitive and mitigate the WL
throughput drop.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 24530cafcba7..ea2be1e25065 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1607,6 +1607,7 @@ static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
+	u32 slot_type = 0;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 
@@ -1618,6 +1619,7 @@ static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 			table_case = 26;
 			if (coex_stat->bt_hid_exist &&
 			    coex_stat->bt_profile_num == 1) {
+				slot_type = TDMA_4SLOT;
 				tdma_case = 20;
 			} else {
 				tdma_case = 20;
@@ -1635,7 +1637,7 @@ static void rtw_coex_action_bt_relink(struct rtw_dev *rtwdev)
 	}
 
 	rtw_coex_table(rtwdev, false, table_case);
-	rtw_coex_tdma(rtwdev, false, tdma_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
 }
 
 static void rtw_coex_action_bt_idle(struct rtw_dev *rtwdev)
-- 
2.21.0

