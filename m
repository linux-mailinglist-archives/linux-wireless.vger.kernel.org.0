Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2081539AD1
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 03:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349001AbiFABkC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 21:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348936AbiFABkA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 21:40:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8207355D
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 18:39:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2511dggF7006003, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2511dggF7006003
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Jun 2022 09:39:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 1 Jun 2022 09:39:42 +0800
Received: from localhost (172.16.20.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 1 Jun
 2022 09:39:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <echuang@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 3/3] rtw89: add new state to CFO state machine for UL-OFDMA
Date:   Wed, 1 Jun 2022 09:39:17 +0800
Message-ID: <20220601013917.18814-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601013917.18814-1-pkshih@realtek.com>
References: <20220601013917.18814-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.31]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/01/2022 01:18:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMzEgpFWkyCAxMDoxMjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Eric Huang <echuang@realtek.com>

Add an new state, RTW89_PHY_DCFO_STATE_HOLD, to keep CFO acceleration
after CFO_PERIOD_CNT if the traffic is UL-OFDMA, which is calculated
based on RX trigger frame counter.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  7 +++++++
 drivers/net/wireless/realtek/rtw89/phy.c  | 24 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/phy.h  |  1 +
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1fa6fe8b99530..239d47d0ec6d6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2809,13 +2809,20 @@ enum rtw89_multi_cfo_mode {
 enum rtw89_phy_cfo_status {
 	RTW89_PHY_DCFO_STATE_NORMAL = 0,
 	RTW89_PHY_DCFO_STATE_ENHANCE = 1,
+	RTW89_PHY_DCFO_STATE_HOLD = 2,
 	RTW89_PHY_DCFO_STATE_MAX
 };
 
+enum rtw89_phy_cfo_ul_ofdma_acc_mode {
+	RTW89_CFO_UL_OFDMA_ACC_DISABLE = 0,
+	RTW89_CFO_UL_OFDMA_ACC_ENABLE = 1
+};
+
 struct rtw89_cfo_tracking_info {
 	u16 cfo_timer_ms;
 	bool cfo_trig_by_timer_en;
 	enum rtw89_phy_cfo_status phy_cfo_status;
+	enum rtw89_phy_cfo_ul_ofdma_acc_mode cfo_ul_ofdma_acc_mode;
 	u8 phy_cfo_trk_cnt;
 	bool is_adjust;
 	enum rtw89_multi_cfo_mode rtw89_multi_cfo_mode;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 762cdba9d3cfd..217aacb6e8c1b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2151,6 +2151,7 @@ static void rtw89_phy_cfo_init(struct rtw89_dev *rtwdev)
 	cfo->cfo_trig_by_timer_en = false;
 	cfo->phy_cfo_trk_cnt = 0;
 	cfo->phy_cfo_status = RTW89_PHY_DCFO_STATE_NORMAL;
+	cfo->cfo_ul_ofdma_acc_mode = RTW89_CFO_UL_OFDMA_ACC_ENABLE;
 }
 
 static void rtw89_phy_cfo_crystal_cap_adjust(struct rtw89_dev *rtwdev,
@@ -2419,6 +2420,13 @@ void rtw89_phy_cfo_track(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_cfo_tracking_info *cfo = &rtwdev->cfo_tracking;
 	struct rtw89_traffic_stats *stats = &rtwdev->stats;
+	bool is_ul_ofdma = false, ofdma_acc_en = false;
+
+	if (stats->rx_tf_periodic > CFO_TF_CNT_TH)
+		is_ul_ofdma = true;
+	if (cfo->cfo_ul_ofdma_acc_mode == RTW89_CFO_UL_OFDMA_ACC_ENABLE &&
+	    is_ul_ofdma)
+		ofdma_acc_en = true;
 
 	switch (cfo->phy_cfo_status) {
 	case RTW89_PHY_DCFO_STATE_NORMAL:
@@ -2430,16 +2438,26 @@ void rtw89_phy_cfo_track(struct rtw89_dev *rtwdev)
 		}
 		break;
 	case RTW89_PHY_DCFO_STATE_ENHANCE:
-		if (cfo->phy_cfo_trk_cnt >= CFO_PERIOD_CNT) {
+		if (stats->tx_throughput <= CFO_TP_LOWER)
+			cfo->phy_cfo_status = RTW89_PHY_DCFO_STATE_NORMAL;
+		else if (ofdma_acc_en &&
+			 cfo->phy_cfo_trk_cnt >= CFO_PERIOD_CNT)
+			cfo->phy_cfo_status = RTW89_PHY_DCFO_STATE_HOLD;
+		else
+			cfo->phy_cfo_trk_cnt++;
+
+		if (cfo->phy_cfo_status == RTW89_PHY_DCFO_STATE_NORMAL) {
 			cfo->phy_cfo_trk_cnt = 0;
 			cfo->cfo_trig_by_timer_en = false;
 		}
-		if (cfo->cfo_trig_by_timer_en == 1)
-			cfo->phy_cfo_trk_cnt++;
+		break;
+	case RTW89_PHY_DCFO_STATE_HOLD:
 		if (stats->tx_throughput <= CFO_TP_LOWER) {
 			cfo->phy_cfo_status = RTW89_PHY_DCFO_STATE_NORMAL;
 			cfo->phy_cfo_trk_cnt = 0;
 			cfo->cfo_trig_by_timer_en = false;
+		} else {
+			cfo->phy_cfo_trk_cnt++;
 		}
 		break;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 291660154d58d..e20636f54b553 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -62,6 +62,7 @@
 #define CFO_COMP_PERIOD 250
 #define CFO_COMP_WEIGHT 8
 #define MAX_CFO_TOLERANCE 30
+#define CFO_TF_CNT_TH 300
 
 #define CCX_MAX_PERIOD 2097
 #define CCX_MAX_PERIOD_UNIT 32
-- 
2.25.1

