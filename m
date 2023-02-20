Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2392869C5FC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 08:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBTH3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 02:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBTH3V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 02:29:21 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0266EC5E
        for <linux-wireless@vger.kernel.org>; Sun, 19 Feb 2023 23:29:19 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31K72oRnA025248, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31K72oRnA025248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Feb 2023 15:02:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Feb 2023 15:02:54 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Feb
 2023 15:02:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: refine FW feature judgement on packet drop
Date:   Mon, 20 Feb 2023 15:02:02 +0800
Message-ID: <20230220070202.29868-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220070202.29868-1-pkshih@realtek.com>
References: <20230220070202.29868-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The newer chips use the newer firmware branches, e.g. v027, v029.
And, those firmware branches are supposed to support packet drop
when they are just branched out.

The initial firmware branch used by each chip is as below.
* 8852A: v009
* 8852C: v027
* 8852B: v027

So, only 8852A may use firmware which doesn't support packet drop at
runtime. To save trivial positive listing in firmware feature table,
we change to reverse judgment.

Besides, rtw89_mac_ptk_drop_by_band_and_wait() missed to check firmware
feature before calling rtw89_fw_h2c_pkt_drop(). We also fix it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 4 ++--
 drivers/net/wireless/realtek/rtw89/mac.c      | 2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 41365ffb7e5ea..b1a886898c5a0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3023,7 +3023,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_SCAN_OFFLOAD,
 	RTW89_FW_FEATURE_TX_WAKE,
 	RTW89_FW_FEATURE_CRASH_TRIGGER,
-	RTW89_FW_FEATURE_PACKET_DROP,
+	RTW89_FW_FEATURE_NO_PACKET_DROP,
 	RTW89_FW_FEATURE_NO_DEEP_PS,
 	RTW89_FW_FEATURE_NO_LPS_PG,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b99cb611597c6..f9089a7668b7d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -235,6 +235,7 @@ static bool __fw_feat_cond_ ## __cond(u32 suit_ver_code, u32 comp_ver_code) \
 
 __DEF_FW_FEAT_COND(ge, >=); /* greater or equal */
 __DEF_FW_FEAT_COND(le, <=); /* less or equal */
+__DEF_FW_FEAT_COND(lt, <); /* less than */
 
 struct __fw_feat_cfg {
 	enum rtw89_core_chip_id chip_id;
@@ -256,12 +257,11 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 36, 0, CRASH_TRIGGER),
-	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 38, 0, PACKET_DROP),
+	__CFG_FW_FEAT(RTL8852A, lt, 0, 13, 38, 0, NO_PACKET_DROP),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 26, 0, NO_LPS_PG),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 26, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, SCAN_OFFLOAD),
-	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 20, 0, PACKET_DROP),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2e2a2b6eab09d..3d1e4ffef1b16 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5426,7 +5426,7 @@ int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 	for (i = 0; i < try_cnt; i++) {
 		ret = read_poll_timeout(mac_is_txq_empty, empty, empty, 50,
 					50000, false, rtwdev);
-		if (ret)
+		if (ret && !RTW89_CHK_FW_FEATURE(NO_PACKET_DROP, &rtwdev->fw))
 			rtw89_fw_h2c_pkt_drop(rtwdev, &params);
 		else
 			return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index d43281f7335b1..367a7bf319dae 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -676,7 +676,7 @@ static void rtw89_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	rtw89_leave_lps(rtwdev);
 	rtw89_hci_flush_queues(rtwdev, queues, drop);
 
-	if (drop && RTW89_CHK_FW_FEATURE(PACKET_DROP, &rtwdev->fw))
+	if (drop && !RTW89_CHK_FW_FEATURE(NO_PACKET_DROP, &rtwdev->fw))
 		__rtw89_drop_packets(rtwdev, vif);
 	else
 		rtw89_mac_flush_txq(rtwdev, queues, drop);
-- 
2.25.1

