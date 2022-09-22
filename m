Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0EA5E57B8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 03:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiIVBFg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 21:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIVBFe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 21:05:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D4587CABE
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 18:05:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28M14twpE019400, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28M14twpE019400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 22 Sep 2022 09:04:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Sep 2022 09:05:18 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 22 Sep
 2022 09:05:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: send OFDM rate only in P2P mode
Date:   Thu, 22 Sep 2022 09:04:32 +0800
Message-ID: <20220922010435.12167-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922010435.12167-1-pkshih@realtek.com>
References: <20220922010435.12167-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/22/2022 00:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjEgpFWkyCAxMDo1MjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

Check IEEE80211_TX_CTL_NO_CCK_RATE flag to avoid sending frames with
CCK rates in 2GHz band.

In TX flow, add IEEE80211_TX_CTL_NO_CCK_RATE flag to check and get its
lowest rate without CCK rates if the TX type is mgmt frames or data frames.
Besides, the decision of phy rate and retry rate in P2P mode are also
be handled.

In P2P GO mode, it should send beacon of no CCK rates in its frame rate.
Therefore, We add a condition to decide which rate is added to beacon
content.

Moreover, we avoid setting a mask of rates to be used for rate control
selection before and after connection in P2P mode.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 14 ++++++++---
 drivers/net/wireless/realtek/rtw89/fw.c       | 24 ++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  9 +++----
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 79d3182fce5a3..ee8cb7ab7e827 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -496,8 +496,14 @@ static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = tx_info->control.vif;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	u16 lowest_rate = chan->band_type == RTW89_BAND_2G ?
-			  RTW89_HW_RATE_CCK1 : RTW89_HW_RATE_OFDM6;
+	u16 lowest_rate;
+
+	if (tx_info->flags & IEEE80211_TX_CTL_NO_CCK_RATE || vif->p2p)
+		lowest_rate = RTW89_HW_RATE_OFDM6;
+	else if (chan->band_type == RTW89_BAND_2G)
+		lowest_rate = RTW89_HW_RATE_CCK1;
+	else
+		lowest_rate = RTW89_HW_RATE_OFDM6;
 
 	if (!vif || !vif->bss_conf.basic_rates || !tx_req->sta)
 		return lowest_rate;
@@ -708,7 +714,9 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	if (IEEE80211_SKB_CB(skb)->control.hw_key)
 		rtw89_core_tx_update_sec_key(rtwdev, tx_req);
 
-	if (rate_pattern->enable)
+	if (vif->p2p)
+		desc_info->data_retry_lowest_rate = RTW89_HW_RATE_OFDM6;
+	else if (rate_pattern->enable)
 		desc_info->data_retry_lowest_rate = rate_pattern->rate;
 	else if (chan->band_type == RTW89_BAND_2G)
 		desc_info->data_retry_lowest_rate = RTW89_HW_RATE_CCK1;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5e65f2c410bfd..e4b12cdeb2de6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1061,12 +1061,20 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb;
 	u8 pads[RTW89_PPE_BW_NUM];
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
+	u16 lowest_rate;
 	int ret;
 
 	memset(pads, 0, sizeof(pads));
 	if (sta)
 		__get_sta_he_pkt_padding(rtwdev, sta, pads);
 
+	if (vif->p2p)
+		lowest_rate = RTW89_HW_RATE_OFDM6;
+	else if (chan->band_type == RTW89_BAND_2G)
+		lowest_rate = RTW89_HW_RATE_CCK1;
+	else
+		lowest_rate = RTW89_HW_RATE_OFDM6;
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CMC_TBL_LEN);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
@@ -1077,10 +1085,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	SET_CTRL_INFO_OPERATION(skb->data, 1);
 	SET_CMC_TBL_DISRTSFB(skb->data, 1);
 	SET_CMC_TBL_DISDATAFB(skb->data, 1);
-	if (chan->band_type == RTW89_BAND_2G)
-		SET_CMC_TBL_RTS_RTY_LOWEST_RATE(skb->data, RTW89_HW_RATE_CCK1);
-	else
-		SET_CMC_TBL_RTS_RTY_LOWEST_RATE(skb->data, RTW89_HW_RATE_OFDM6);
+	SET_CMC_TBL_RTS_RTY_LOWEST_RATE(skb->data, lowest_rate);
 	SET_CMC_TBL_RTS_TXCNT_LMT_SEL(skb->data, 0);
 	SET_CMC_TBL_DATA_TXCNT_LMT_SEL(skb->data, 0);
 	if (vif->type == NL80211_IFTYPE_STATION)
@@ -1214,8 +1219,16 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb_beacon;
 	u16 tim_offset;
 	int bcn_total_len;
+	u16 beacon_rate;
 	int ret;
 
+	if (vif->p2p)
+		beacon_rate = RTW89_HW_RATE_OFDM6;
+	else if (chan->band_type == RTW89_BAND_2G)
+		beacon_rate = RTW89_HW_RATE_CCK1;
+	else
+		beacon_rate = RTW89_HW_RATE_OFDM6;
+
 	skb_beacon = ieee80211_beacon_get_tim(rtwdev->hw, vif, &tim_offset,
 					      NULL, 0);
 	if (!skb_beacon) {
@@ -1239,8 +1252,7 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 	SET_BCN_UPD_MACID(skb->data, rtwvif->mac_id);
 	SET_BCN_UPD_SSN_SEL(skb->data, RTW89_MGMT_HW_SSN_SEL);
 	SET_BCN_UPD_SSN_MODE(skb->data, RTW89_MGMT_HW_SEQ_MODE);
-	SET_BCN_UPD_RATE(skb->data, chan->band_type == RTW89_BAND_2G ?
-				    RTW89_HW_RATE_CCK1 : RTW89_HW_RATE_OFDM6);
+	SET_BCN_UPD_RATE(skb->data, beacon_rate);
 
 	skb_put_data(skb, skb_beacon->data, skb_beacon->len);
 	dev_kfree_skb_any(skb_beacon);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f9cd98d496157..70f555887c6ea 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -677,7 +677,7 @@ static void rtw89_ra_mask_info_update_iter(void *data, struct ieee80211_sta *sta
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta->rtwvif);
 
-	if (vif != br_data->vif)
+	if (vif != br_data->vif || vif->p2p)
 		return;
 
 	rtwsta->use_cfg_mask = true;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index be2c3715bbf42..6a6bdc652e09e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -235,6 +235,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
 	struct rtw89_ra_info *ra = &rtwsta->ra;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta->rtwvif);
 	const u64 *high_rate_masks = rtw89_ra_mask_ht_rates;
 	u8 rssi = ewma_rssi_read(&rtwsta->avg_rssi);
 	u64 ra_mask = 0;
@@ -292,10 +293,10 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	switch (chan->band_type) {
 	case RTW89_BAND_2G:
 		ra_mask |= sta->deflink.supp_rates[NL80211_BAND_2GHZ];
-		if (sta->deflink.supp_rates[NL80211_BAND_2GHZ] <= 0xf)
+		if (sta->deflink.supp_rates[NL80211_BAND_2GHZ] & 0xf)
 			mode |= RTW89_RA_MODE_CCK;
-		else
-			mode |= RTW89_RA_MODE_CCK | RTW89_RA_MODE_OFDM;
+		if (sta->deflink.supp_rates[NL80211_BAND_2GHZ] & 0xff0)
+			mode |= RTW89_RA_MODE_OFDM;
 		break;
 	case RTW89_BAND_5G:
 		ra_mask |= (u64)sta->deflink.supp_rates[NL80211_BAND_5GHZ] << 4;
@@ -358,7 +359,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	    IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_16_QAM)
 		ra->dcm_cap = 1;
 
-	if (rate_pattern->enable) {
+	if (rate_pattern->enable && !vif->p2p) {
 		ra_mask = rtw89_phy_ra_mask_cfg(rtwdev, rtwsta);
 		ra_mask &= rate_pattern->ra_mask;
 		mode = rate_pattern->ra_mode;
-- 
2.25.1

