Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE9E54257F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiFHFSA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 01:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiFHFRg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 01:17:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480C93E48E5
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 19:25:25 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25823UPs8016357, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25823UPs8016357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 8 Jun 2022 10:03:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 10:03:30 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 8 Jun
 2022 10:03:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>, <nathan@kernel.org>,
        <Larry.Finger@lwfinger.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw88: 8821c: fix access const table of channel parameters
Date:   Wed, 8 Jun 2022 10:03:12 +0800
Message-ID: <20220608020312.9663-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/08/2022 01:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvNyCkVaTIIDEwOjAwOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We would like to make chip_info table const, but 8821c uses one field as
a variable, and causes core dump. To fix this, move the field to another
struct that can be read and written.

BUG: unable to handle page fault for address: ffffffffc09f52f4
PGD 5b5215067 P4D 5b5215067 PUD 5b5217067 PMD 111f61067 PTE 8000000111e07161
Oops: 0003 [#1] PREEMPT SMP NOPTI
CPU: 6 PID: 436 Comm: NetworkManager Not tainted 5.18.0-rc7-debug-01822-g89d8f53ff6e7 #1 5cac31ca93432e53341863abfb3332fd98b144da
Hardware name: HP HP Desktop M01-F1xxx/87D6, BIOS F.12 12/17/2020
RIP: 0010:rtw8821c_phy_set_param+0x262/0x380 [rtw88_8821c]
Code: e8 53 f3 c0 d6 48 8b 43 10 4c 8b 63 38 be 24 0a 00 00 48 89 df 48
 8b 40 68 e8 3a f3 c0 d6 89 e9 be 28 0a 00 00 48 89 df d3 e8 <41> 89 84
 24 54 01 00 00 48 8b 43 10 4c 8b 63 38 48 8b 40 68 e8 15
RSP: 0018:ffffb08c417cb6f0 EFLAGS: 00010286
RAX: 0000000064b80c1c RBX: ffff93d15a0120e0 RCX: 0000000000000000
RDX: 0000000034028211 RSI: 0000000000000a28 RDI: ffff93d15a0120e0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000006 R12: ffffffffc09f51a0
R13: ffff93d15a0156d0 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f4e9b73d1c0(0000) GS:ffff93d83ab80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc09f52f4 CR3: 0000000103b9e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 rtw_core_start+0xbd/0x190 [rtw88_core de79d6bdfd083d102030858972032e5706726279]
 rtw_ops_start+0x26/0x40 [rtw88_core de79d6bdfd083d102030858972032e5706726279]
 drv_start+0x42/0x100 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
 ieee80211_do_open+0x2fb/0x900 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
 ieee80211_open+0x67/0x80 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
 __dev_open+0xdd/0x180
 [...]

Fixes: 89d8f53ff6e7 ("wifi: rtw88: Fix Sparse warning for rtw8821c_hw_spec")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  6 +++---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 14 ++++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 0baaf5a32e82d..5d00c161162c3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1233,9 +1233,6 @@ struct rtw_chip_info {
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const u8 max_sched_scan_ssids;
 
-	/* for 8821c set channel */
-	u32 ch_param[3];
-
 	/* coex paras */
 	u32 coex_para_ver;
 	u8 bt_desired_ver;
@@ -1937,6 +1934,9 @@ struct rtw_hal {
 
 	enum rtw_sar_bands sar_band;
 	struct rtw_sar sar;
+
+	/* for 8821c set channel */
+	u32 ch_param[3];
 };
 
 struct rtw_path_div {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 42841f5d502c2..025262a8970eb 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -125,6 +125,7 @@ static void rtw8821c_phy_bf_init(struct rtw_dev *rtwdev)
 
 static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 {
+	struct rtw_hal *hal = &rtwdev->hal;
 	u8 crystal_cap, val;
 
 	/* power on BB/RF domain */
@@ -159,9 +160,9 @@ static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 
 	/* post init after header files config */
 	rtw_write32_set(rtwdev, REG_RXPSEL, BIT_RX_PSEL_RST);
-	rtwdev->chip->ch_param[0] = rtw_read32_mask(rtwdev, REG_TXSF2, MASKDWORD);
-	rtwdev->chip->ch_param[1] = rtw_read32_mask(rtwdev, REG_TXSF6, MASKDWORD);
-	rtwdev->chip->ch_param[2] = rtw_read32_mask(rtwdev, REG_TXFILTER, MASKDWORD);
+	hal->ch_param[0] = rtw_read32_mask(rtwdev, REG_TXSF2, MASKDWORD);
+	hal->ch_param[1] = rtw_read32_mask(rtwdev, REG_TXSF6, MASKDWORD);
+	hal->ch_param[2] = rtw_read32_mask(rtwdev, REG_TXFILTER, MASKDWORD);
 
 	rtw_phy_init(rtwdev);
 	rtwdev->dm_info.cck_pd_default = rtw_read8(rtwdev, REG_CSRATIO) & 0x1f;
@@ -351,6 +352,7 @@ static void rtw8821c_set_channel_rxdfir(struct rtw_dev *rtwdev, u8 bw)
 static void rtw8821c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 				    u8 primary_ch_idx)
 {
+	struct rtw_hal *hal = &rtwdev->hal;
 	u32 val32;
 
 	if (channel <= 14) {
@@ -367,11 +369,11 @@ static void rtw8821c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 			rtw_write32_mask(rtwdev, REG_TXFILTER, MASKDWORD, 0x00003667);
 		} else {
 			rtw_write32_mask(rtwdev, REG_TXSF2, MASKDWORD,
-					 rtwdev->chip->ch_param[0]);
+					 hal->ch_param[0]);
 			rtw_write32_mask(rtwdev, REG_TXSF6, MASKLWORD,
-					 rtwdev->chip->ch_param[1] & MASKLWORD);
+					 hal->ch_param[1] & MASKLWORD);
 			rtw_write32_mask(rtwdev, REG_TXFILTER, MASKDWORD,
-					 rtwdev->chip->ch_param[2]);
+					 hal->ch_param[2]);
 		}
 	} else if (channel > 35) {
 		rtw_write32_mask(rtwdev, REG_ENTXCCK, BIT(18), 0x1);
-- 
2.25.1

