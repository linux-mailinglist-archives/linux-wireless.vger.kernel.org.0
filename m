Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3920660018
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 13:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjAFMP7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Jan 2023 07:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjAFMPj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Jan 2023 07:15:39 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8648736C5
        for <linux-wireless@vger.kernel.org>; Fri,  6 Jan 2023 04:15:37 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 306CEYvS4000743, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 306CEYvS4000743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Jan 2023 20:14:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 6 Jan 2023 20:15:31 +0800
Received: from localhost (172.16.18.220) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 6 Jan 2023
 20:15:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: set the correct mac_id for management frames
Date:   Fri, 6 Jan 2023 20:15:17 +0800
Message-ID: <20230106121517.19841-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106121517.19841-1-pkshih@realtek.com>
References: <20230106121517.19841-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.18.220]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/06/2023 11:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvNiCkV6TIIDA5OjMyOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kuan-Chung Chen <damon.chen@realtek.com>

The mac_id of management frames should follow rtwvif->mac_id or
rtwsta->mac_id. Add this patch to set the correct mac_id and
prevent unexpected behavior.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 31 ++++++++++++-----------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index f06840634e113..2c66703a7c89e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -512,6 +512,21 @@ static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
 	return __ffs(vif->bss_conf.basic_rates) + lowest_rate;
 }
 
+static u8 rtw89_core_tx_get_mac_id(struct rtw89_dev *rtwdev,
+				   struct rtw89_core_tx_request *tx_req)
+{
+	struct ieee80211_vif *vif = tx_req->vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct ieee80211_sta *sta = tx_req->sta;
+	struct rtw89_sta *rtwsta;
+
+	if (!sta)
+		return rtwvif->mac_id;
+
+	rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	return rtwsta->mac_id;
+}
+
 static void
 rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
@@ -528,6 +543,7 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 	desc_info->qsel = qsel;
 	desc_info->ch_dma = ch_dma;
 	desc_info->port = desc_info->hiq ? rtwvif->port : 0;
+	desc_info->mac_id = rtw89_core_tx_get_mac_id(rtwdev, tx_req);
 	desc_info->hw_ssn_sel = RTW89_MGMT_HW_SSN_SEL;
 	desc_info->hw_seq_mode = RTW89_MGMT_HW_SEQ_MODE;
 
@@ -670,21 +686,6 @@ rtw89_core_tx_update_he_qos_htc(struct rtw89_dev *rtwdev,
 	desc_info->bk = true;
 }
 
-static u8 rtw89_core_tx_get_mac_id(struct rtw89_dev *rtwdev,
-				   struct rtw89_core_tx_request *tx_req)
-{
-	struct ieee80211_vif *vif = tx_req->vif;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	struct ieee80211_sta *sta = tx_req->sta;
-	struct rtw89_sta *rtwsta;
-
-	if (!sta)
-		return rtwvif->mac_id;
-
-	rtwsta = (struct rtw89_sta *)sta->drv_priv;
-	return rtwsta->mac_id;
-}
-
 static void
 rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
-- 
2.25.1

