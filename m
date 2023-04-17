Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3CB6E3D69
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 04:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjDQCTs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 22:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjDQCTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 22:19:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33063AB3
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 19:19:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33H2IqyT6031609, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33H2IqyT6031609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 17 Apr 2023 10:18:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Apr 2023 10:19:15 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 17 Apr
 2023 10:19:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: add EVM for antenna diversity
Date:   Mon, 17 Apr 2023 10:17:07 +0800
Message-ID: <20230417021707.16369-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417021707.16369-1-pkshih@realtek.com>
References: <20230417021707.16369-1-pkshih@realtek.com>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eric Huang <echuang@realtek.com>

Take EVM into consideration when doing antenna diversity, and the priority
is higher than RSSI. Since EVM is more relevant to performance than RSSI,
especially in OTA environment.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c  | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cc84b5512e28e..02dc44cab31c7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3131,6 +3131,7 @@ struct rtw89_antdiv_stats {
 	u16 pkt_cnt_cck;
 	u16 pkt_cnt_ofdm;
 	u16 pkt_cnt_non_legacy;
+	u32 evm;
 };
 
 struct rtw89_antdiv_info {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index b9a3ebc2e7901..5eac00cd51881 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2956,6 +2956,7 @@ void rtw89_phy_antdiv_sts_instance_reset(struct rtw89_antdiv_stats *antdiv_sts)
 	antdiv_sts->pkt_cnt_cck = 0;
 	antdiv_sts->pkt_cnt_ofdm = 0;
 	antdiv_sts->pkt_cnt_non_legacy = 0;
+	antdiv_sts->evm = 0;
 }
 
 static void rtw89_phy_antdiv_sts_instance_add(struct rtw89_dev *rtwdev,
@@ -2969,10 +2970,12 @@ static void rtw89_phy_antdiv_sts_instance_add(struct rtw89_dev *rtwdev,
 		} else {
 			ewma_rssi_add(&stats->ofdm_rssi_avg, phy_ppdu->rssi_avg);
 			stats->pkt_cnt_ofdm++;
+			stats->evm += phy_ppdu->ofdm.evm_min;
 		}
 	} else {
 		ewma_rssi_add(&stats->non_legacy_rssi_avg, phy_ppdu->rssi_avg);
 		stats->pkt_cnt_non_legacy++;
+		stats->evm += phy_ppdu->ofdm.evm_min;
 	}
 }
 
@@ -2988,6 +2991,11 @@ static u8 rtw89_phy_antdiv_sts_instance_get_rssi(struct rtw89_antdiv_stats *stat
 		return ewma_rssi_read(&stats->cck_rssi_avg);
 }
 
+static u8 rtw89_phy_antdiv_sts_instance_get_evm(struct rtw89_antdiv_stats *stats)
+{
+	return phy_div(stats->evm, stats->pkt_cnt_non_legacy + stats->pkt_cnt_ofdm);
+}
+
 void rtw89_phy_antdiv_parse(struct rtw89_dev *rtwdev,
 			    struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
@@ -4270,15 +4278,22 @@ static void rtw89_phy_antdiv_decision_state(struct rtw89_dev *rtwdev)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	bool no_change = false;
 	u8 main_rssi, aux_rssi;
+	u8 main_evm, aux_evm;
 	u32 candidate;
 
 	antdiv->get_stats = false;
 	antdiv->training_count = 0;
 
 	main_rssi = rtw89_phy_antdiv_sts_instance_get_rssi(&antdiv->main_stats);
+	main_evm = rtw89_phy_antdiv_sts_instance_get_evm(&antdiv->main_stats);
 	aux_rssi = rtw89_phy_antdiv_sts_instance_get_rssi(&antdiv->aux_stats);
+	aux_evm = rtw89_phy_antdiv_sts_instance_get_evm(&antdiv->aux_stats);
 
-	if (main_rssi > aux_rssi + RTW89_TX_DIV_RSSI_RAW_TH)
+	if (main_evm > aux_evm + ANTDIV_EVM_DIFF_TH)
+		candidate = RF_A;
+	else if (aux_evm > main_evm + ANTDIV_EVM_DIFF_TH)
+		candidate = RF_B;
+	else if (main_rssi > aux_rssi + RTW89_TX_DIV_RSSI_RAW_TH)
 		candidate = RF_A;
 	else if (aux_rssi > main_rssi + RTW89_TX_DIV_RSSI_RAW_TH)
 		candidate = RF_B;
-- 
2.25.1

