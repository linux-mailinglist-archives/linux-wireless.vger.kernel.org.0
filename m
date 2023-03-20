Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49AA6C0D59
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 10:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCTJch (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCTJcd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 05:32:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A91A954
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 02:32:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32K9W3Cg8018074, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32K9W3Cg8018074
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Mar 2023 17:32:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Mar 2023 17:32:17 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Mar
 2023 17:32:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: set data lowest rate according to AP supported rate
Date:   Mon, 20 Mar 2023 17:31:10 +0800
Message-ID: <20230320093112.30466-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Chih-Kang Chang <gary.chang@realtek.com>

By default the driver uses the 1M and 6M rate (0x0) for data frames in
2 GHz and 5/6 GHz bands respectively. But the rate that might not AP
supported. Therefore, We modify the data lowest rate according to the
lowest of AP supported rate.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 38 +++++++++++++++++------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 489fa7a86160d..208fd589ffa25 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -686,6 +686,33 @@ rtw89_core_tx_update_he_qos_htc(struct rtw89_dev *rtwdev,
 	desc_info->bk = true;
 }
 
+static u16 rtw89_core_get_data_rate(struct rtw89_dev *rtwdev,
+				    struct rtw89_core_tx_request *tx_req)
+{
+	struct ieee80211_vif *vif = tx_req->vif;
+	struct ieee80211_sta *sta = tx_req->sta;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
+	enum rtw89_sub_entity_idx idx = rtwvif->sub_entity_idx;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, idx);
+	u16 lowest_rate;
+
+	if (rate_pattern->enable)
+		return rate_pattern->rate;
+
+	if (vif->p2p)
+		lowest_rate = RTW89_HW_RATE_OFDM6;
+	else if (chan->band_type == RTW89_BAND_2G)
+		lowest_rate = RTW89_HW_RATE_CCK1;
+	else
+		lowest_rate = RTW89_HW_RATE_OFDM6;
+
+	if (!sta->deflink.supp_rates[chan->band_type])
+		return lowest_rate;
+
+	return __ffs(sta->deflink.supp_rates[chan->band_type]) + lowest_rate;
+}
+
 static void
 rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
@@ -694,8 +721,6 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	struct ieee80211_sta *sta = tx_req->sta;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
-	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct sk_buff *skb = tx_req->skb;
 	u8 tid, tid_indicate;
@@ -719,14 +744,7 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	if (IEEE80211_SKB_CB(skb)->control.hw_key)
 		rtw89_core_tx_update_sec_key(rtwdev, tx_req);
 
-	if (vif->p2p)
-		desc_info->data_retry_lowest_rate = RTW89_HW_RATE_OFDM6;
-	else if (rate_pattern->enable)
-		desc_info->data_retry_lowest_rate = rate_pattern->rate;
-	else if (chan->band_type == RTW89_BAND_2G)
-		desc_info->data_retry_lowest_rate = RTW89_HW_RATE_CCK1;
-	else
-		desc_info->data_retry_lowest_rate = RTW89_HW_RATE_OFDM6;
+	desc_info->data_retry_lowest_rate = rtw89_core_get_data_rate(rtwdev, tx_req);
 }
 
 static enum btc_pkt_type
-- 
2.25.1

