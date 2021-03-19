Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB42B341507
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 06:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhCSFoC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 01:44:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39751 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbhCSFna (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 01:43:30 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12J5hP3r9007767, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12J5hP3r9007767
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Mar 2021 13:43:25 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Mar
 2021 13:43:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>,
        <phhuang@realtek.com>, <shaofu@realtek.com>,
        <steventing@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 7/7] rtw88: coex: fix A2DP stutters while WL busy + WL scan
Date:   Fri, 19 Mar 2021 13:42:18 +0800
Message-ID: <20210319054218.3319-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210319054218.3319-1-pkshih@realtek.com>
References: <20210319054218.3319-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

While WL scan, WL is more high priority than BT. The packets from AP
will be a big interference to A2DP. It will lead to A2DP stutters. Stop
answering CTS to AP to decrease AP's packets Tx while WL scan + WL busy.
Enable BT AFH feature to make BT leave away from WL channel.

Desired BT firmware BT-COEX version: 0x1c
Desired WL firmware version: 9.9.x

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c     | 8 +++++---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 7eee2c5ecb11..cedbf3825848 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -787,7 +787,6 @@ static void rtw_coex_update_wl_ch_info(struct rtw_dev *rtwdev, u8 type)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex_dm *coex_dm = &rtwdev->coex.dm;
-	struct rtw_efuse *efuse = &rtwdev->efuse;
 	u8 link = 0;
 	u8 center_chan = 0;
 	u8 bw;
@@ -798,7 +797,7 @@ static void rtw_coex_update_wl_ch_info(struct rtw_dev *rtwdev, u8 type)
 	if (type != COEX_MEDIA_DISCONNECT)
 		center_chan = rtwdev->hal.current_channel;
 
-	if (center_chan == 0 || (efuse->share_ant && center_chan <= 14)) {
+	if (center_chan == 0) {
 		link = 0;
 		center_chan = 0;
 		bw = 0;
@@ -2325,8 +2324,11 @@ static void rtw_coex_action_wl_linkscan(struct rtw_dev *rtwdev)
 	if (efuse->share_ant) { /* Shared-Ant */
 		if (coex_stat->bt_a2dp_exist) {
 			slot_type = TDMA_4SLOT;
-			table_case = 9;
 			tdma_case = 11;
+			if (coex_stat->wl_gl_busy)
+				table_case = 26;
+			else
+				table_case = 9;
 		} else {
 			table_case = 9;
 			tdma_case = 7;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 8ed70f468cda..9f05c60c8a03 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4520,7 +4520,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.wowlan_stub = &rtw_wowlan_stub_8822c,
 	.max_sched_scan_ssids = 4,
 #endif
-	.coex_para_ver = 0x201029,
+	.coex_para_ver = 0x2103181c,
 	.bt_desired_ver = 0x1c,
 	.scbd_support = true,
 	.new_scbd10_def = true,
-- 
2.21.0

