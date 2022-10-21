Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49336073BC
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 11:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiJUJQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 05:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiJUJQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 05:16:49 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE56A20B13D
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 02:16:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29L9FkvpE028549, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29L9FkvpE028549
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 21 Oct 2022 17:15:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Oct 2022 17:16:18 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 21 Oct
 2022 17:16:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: add BW info for both TX and RX in phy_info
Date:   Fri, 21 Oct 2022 17:16:01 +0800
Message-ID: <20221021091601.39884-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/21/2022 08:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzIxIKRXpMggMDc6MjY6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Eric Huang <echuang@realtek.com>

In order to debug performance issue intuitively, add bandwidth information
into debugfs entry phy_info. After applying this patch, it looks like:

 TX rate [0]: HE 2SS MCS-11 GI:0.8 BW:80 (hw_rate=0x19b) ==> agg_wait=1 (3500)
 RX rate [0]: HE 2SS MCS-9 GI:0.8 BW:80  (hw_rate=0x199)

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 8f27c883eeabb..cd44d9aa37ca0 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -51,6 +51,22 @@ struct rtw89_debugfs_priv {
 	};
 };
 
+static const u16 rtw89_rate_info_bw_to_mhz_map[] = {
+	[RATE_INFO_BW_20] = 20,
+	[RATE_INFO_BW_40] = 40,
+	[RATE_INFO_BW_80] = 80,
+	[RATE_INFO_BW_160] = 160,
+	[RATE_INFO_BW_320] = 320,
+};
+
+static u16 rtw89_rate_info_bw_to_mhz(enum rate_info_bw bw)
+{
+	if (bw < ARRAY_SIZE(rtw89_rate_info_bw_to_mhz_map))
+		return rtw89_rate_info_bw_to_mhz_map[bw];
+
+	return 0;
+}
+
 static int rtw89_debugfs_single_show(struct seq_file *m, void *v)
 {
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
@@ -2379,6 +2395,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	else
 		seq_printf(m, "Legacy %d", rate->legacy);
 	seq_printf(m, "%s", rtwsta->ra_report.might_fallback_legacy ? " FB_G" : "");
+	seq_printf(m, " BW:%u", rtw89_rate_info_bw_to_mhz(rate->bw));
 	seq_printf(m, "\t(hw_rate=0x%x)", rtwsta->ra_report.hw_rate);
 	seq_printf(m, "\t==> agg_wait=%d (%d)\n", rtwsta->max_agg_wait,
 		   sta->deflink.agg.max_rc_amsdu_len);
@@ -2404,6 +2421,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 			   he_gi_str[rate->he_gi] : "N/A");
 		break;
 	}
+	seq_printf(m, " BW:%u", rtw89_rate_info_bw_to_mhz(status->bw));
 	seq_printf(m, "\t(hw_rate=0x%x)\n", rtwsta->rx_hw_rate);
 
 	rssi = ewma_rssi_read(&rtwsta->avg_rssi);
-- 
2.25.1

