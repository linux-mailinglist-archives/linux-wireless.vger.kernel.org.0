Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFD4D58A5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 04:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbiCKDFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 22:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345930AbiCKDFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 22:05:12 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D1C1A7DA1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 19:04:08 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22B342uM4021557, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22B342uM4021557
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Mar 2022 11:04:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Mar 2022 11:04:02 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 11:04:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH 10/11] rtw89: extend mac tx_en bits from 16 to 32
Date:   Fri, 11 Mar 2022 11:03:00 +0800
Message-ID: <20220311030301.33921-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311030301.33921-1-pkshih@realtek.com>
References: <20220311030301.33921-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/11/2022 02:42:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTEgpFekyCAwMTowNjowMA==?=
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

In order to support 8852C that uses 32 bits to control TX types.

This patch doesn't really use 32 bits tx_en yet, but next patch will
use it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h         | 2 +-
 drivers/net/wireless/realtek/rtw89/mac.c          | 6 +++---
 drivers/net/wireless/realtek/rtw89/mac.h          | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 08416f005b508..0ffb163c23f0f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -609,7 +609,7 @@ struct rtw89_channel_params {
 };
 
 struct rtw89_channel_help_params {
-	u16 tx_en;
+	u32 tx_en;
 };
 
 struct rtw89_port_reg {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e00ae35253f38..793059853a6aa 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2247,7 +2247,7 @@ static int rtw89_set_hw_sch_tx_en(struct rtw89_dev *rtwdev, u8 mac_idx,
 }
 
 int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
-			  u16 *tx_en, enum rtw89_sch_tx_sel sel)
+			  u32 *tx_en, enum rtw89_sch_tx_sel sel)
 {
 	int ret;
 
@@ -2285,7 +2285,7 @@ int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
 }
 EXPORT_SYMBOL(rtw89_mac_stop_sch_tx);
 
-int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u16 tx_en)
+int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
 {
 	int ret;
 
@@ -2459,7 +2459,7 @@ static int band1_enable(struct rtw89_dev *rtwdev)
 	int ret, i;
 	u32 sleep_bak[4] = {0};
 	u32 pause_bak[4] = {0};
-	u16 tx_en;
+	u32 tx_en;
 
 	ret = rtw89_mac_stop_sch_tx(rtwdev, 0, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 0fb09d6e176d1..07a8c7c816a35 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -791,8 +791,8 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func);
 int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev);
 int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
-			  u16 *tx_en, enum rtw89_sch_tx_sel sel);
-int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u16 tx_en);
+			  u32 *tx_en, enum rtw89_sch_tx_sel sel);
+int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
 int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_ids, bool enable);
 void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx);
 void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index acdad5a300ddb..4b29dc9a5c078 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -3526,7 +3526,7 @@ static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	const struct rtw89_chip_info *mac_reg = rtwdev->chip;
 	u8 ch = rtwdev->hal.current_channel, ch_tmp;
 	u8 bw = rtwdev->hal.current_band_width;
-	u16 tx_en;
+	u32 tx_en;
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, 0);
 	s8 power;
 	s16 xdbm;
@@ -3623,7 +3623,7 @@ void rtw8852a_dack(struct rtw89_dev *rtwdev)
 
 void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	u16 tx_en;
+	u32 tx_en;
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
@@ -3648,7 +3648,7 @@ void rtw8852a_iqk_track(struct rtw89_dev *rtwdev)
 void rtw8852a_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 		     bool is_afe)
 {
-	u16 tx_en;
+	u32 tx_en;
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
@@ -3663,7 +3663,7 @@ void rtw8852a_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 
 void rtw8852a_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	u16 tx_en;
+	u32 tx_en;
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
-- 
2.25.1

