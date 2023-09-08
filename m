Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287457980DA
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 05:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjIHDNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 23:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbjIHDNE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 23:13:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6253B1BDB
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 20:13:00 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3883Cp4eA1359579, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3883Cp4eA1359579
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 11:12:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 8 Sep 2023 11:12:50 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 8 Sep 2023
 11:12:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: rfk: disable driver tracking during MCC
Date:   Fri, 8 Sep 2023 11:11:39 +0800
Message-ID: <20230908031145.20931-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908031145.20931-1-pkshih@realtek.com>
References: <20230908031145.20931-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
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

After MCC (multi-channel concurrency) is started, FW will control channel
changes and use the corresponding backup of RF calibration result. And,
driver RF calibration (RF-K) won't be able to keep up with the speed at
which the channels are changing. So, even if we keep tracking it in driver,
the RF-K result might not be good either. To save these unnecessary things,
we disable driver RF-K tracking during MCC.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 856f3543eff2..3b80b110c4f3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2662,6 +2662,17 @@ static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
 		rtw89_vif_enter_lps(rtwdev, rtwvif);
 }
 
+static void rtw89_core_rfk_track(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_entity_mode mode;
+
+	mode = rtw89_get_entity_mode(rtwdev);
+	if (mode == RTW89_ENTITY_MODE_MCC)
+		return;
+
+	rtw89_chip_rfk_track(rtwdev);
+}
+
 void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
 			      struct rtw89_traffic_stats *stats)
 {
@@ -2704,7 +2715,7 @@ static void rtw89_track_work(struct work_struct *work)
 	rtw89_phy_stat_track(rtwdev);
 	rtw89_phy_env_monitor_track(rtwdev);
 	rtw89_phy_dig(rtwdev);
-	rtw89_chip_rfk_track(rtwdev);
+	rtw89_core_rfk_track(rtwdev);
 	rtw89_phy_ra_update(rtwdev);
 	rtw89_phy_cfo_track(rtwdev);
 	rtw89_phy_tx_path_div_track(rtwdev);
-- 
2.25.1

