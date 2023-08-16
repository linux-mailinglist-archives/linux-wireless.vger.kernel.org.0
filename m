Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91FD77DC1D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbjHPIW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242881AbjHPIWc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:22:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 538A61FD0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:22:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37G8M38X0001414, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37G8M38X0001414
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Aug 2023 16:22:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 16 Aug 2023 16:22:23 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 16 Aug
 2023 16:22:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: call rtw89_chan_get() by vif chanctx if aware of vif
Date:   Wed, 16 Aug 2023 16:21:31 +0800
Message-ID: <20230816082133.57474-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816082133.57474-1-pkshih@realtek.com>
References: <20230816082133.57474-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We adjust these processes which can work accodrding to vif but call
rtw89_chan_get() with static RTW89_SUB_ENTITY_0. After multi-channel
support, chanctx of vif won't always be on RTW89_SUB_ENTITY_0. So,
we make them call rtw89_chan_get() with rtwvif->sub_entity_idx.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     |  3 ++-
 drivers/net/wireless/realtek/rtw89/core.c     | 22 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/core.h     | 12 ++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       |  6 +++--
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 ++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 21 ++++++++++--------
 6 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index bda0e1e99a8c..4ba8b3df70ae 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5666,7 +5666,8 @@ enum btc_wl_mode {
 void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			      struct rtw89_sta *rtwsta, enum btc_role_state state)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
 	struct rtw89_btc *btc = &rtwdev->btc;
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index aedabd262251..91f9a587220b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -523,12 +523,12 @@ rtw89_core_tx_update_sec_key(struct rtw89_dev *rtwdev,
 }
 
 static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
-				    struct rtw89_core_tx_request *tx_req)
+				    struct rtw89_core_tx_request *tx_req,
+				    const struct rtw89_chan *chan)
 {
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = tx_info->control.vif;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u16 lowest_rate;
 
 	if (tx_info->flags & IEEE80211_TX_CTL_NO_CCK_RATE ||
@@ -567,7 +567,8 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 	struct ieee80211_vif *vif = tx_req->vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
 	u8 qsel, ch_dma;
 
 	qsel = desc_info->hiq ? RTW89_TX_QSEL_B0_HI : RTW89_TX_QSEL_B0_MGMT;
@@ -584,7 +585,7 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 	desc_info->en_wd_info = true;
 	desc_info->use_rate = true;
 	desc_info->dis_data_fb = true;
-	desc_info->data_rate = rtw89_core_get_mgmt_rate(rtwdev, tx_req);
+	desc_info->data_rate = rtw89_core_get_mgmt_rate(rtwdev, tx_req, chan);
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 		    "tx mgmt frame with rate 0x%x on channel %d (band %d, bw %d)\n",
@@ -603,7 +604,8 @@ rtw89_core_tx_update_h2c_info(struct rtw89_dev *rtwdev,
 	desc_info->ch_dma = RTW89_DMA_H2C;
 }
 
-static void rtw89_core_get_no_ul_ofdma_htc(struct rtw89_dev *rtwdev, __le32 *htc)
+static void rtw89_core_get_no_ul_ofdma_htc(struct rtw89_dev *rtwdev, __le32 *htc,
+					   const struct rtw89_chan *chan)
 {
 	static const u8 rtw89_bandwidth_to_om[] = {
 		[RTW89_CHANNEL_WIDTH_20] = HTC_OM_CHANNEL_WIDTH_20,
@@ -614,7 +616,6 @@ static void rtw89_core_get_no_ul_ofdma_htc(struct rtw89_dev *rtwdev, __le32 *htc
 	};
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_hal *hal = &rtwdev->hal;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 om_bandwidth;
 
 	if (!chip->dis_2g_40m_ul_ofdma ||
@@ -1899,7 +1900,6 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 {
 	const struct cfg80211_chan_def *chandef =
 		rtw89_chandef_get(rtwdev, RTW89_SUB_ENTITY_0);
-	const struct rtw89_chan *cur = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u16 data_rate;
 	u8 data_rate_mode;
 
@@ -1909,6 +1909,7 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 
 	if (rtwdev->scanning &&
 	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
+		const struct rtw89_chan *cur = rtw89_scan_chan_get(rtwdev);
 		u8 chan = cur->primary_channel;
 		u8 band = cur->band_type;
 		enum nl80211_band nl_band;
@@ -2970,6 +2971,8 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif, rtwsta);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
@@ -3023,7 +3026,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_END);
-		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta->htc_template);
+		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta->htc_template, chan);
 		rtw89_phy_ul_tb_assoc(rtwdev, rtwvif);
 
 		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif, rtwsta->mac_id);
@@ -3656,7 +3659,8 @@ EXPORT_SYMBOL(rtw89_core_deinit);
 void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   const u8 *mac_addr, bool hw_scan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
 
 	rtwdev->scanning = true;
 	rtw89_leave_lps(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5b60bc72b4a5..257582fc39ea 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4929,6 +4929,18 @@ const struct rtw89_chan_rcd *rtw89_chan_rcd_get(struct rtw89_dev *rtwdev,
 	return &hal->sub[idx].rcd;
 }
 
+static inline
+const struct rtw89_chan *rtw89_scan_chan_get(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+
+	if (rtwvif)
+		return rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
+	else
+		return rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+}
+
 static inline void rtw89_chip_fem_setup(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2811a94b5f69..7dd7bc4be9c7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1758,7 +1758,8 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
 	struct sk_buff *skb;
 	u8 pads[RTW89_PPE_BW_NUM];
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
@@ -1915,7 +1916,8 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
 	struct sk_buff *skb;
 	struct sk_buff *skb_beacon;
 	u16 tim_offset;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a66503eb35b8..7c3066c0a550 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -296,7 +296,8 @@ static u8 rtw89_aifsn_to_aifs(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif *rtwvif, u8 aifsn)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
 	u8 slot_time;
 	u8 sifs;
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index fcdc61597b9b..5ff2871b230b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -133,10 +133,10 @@ static u64 rtw89_phy_ra_mask_recover(u64 ra_mask, u64 ra_mask_bak)
 	return ra_mask;
 }
 
-static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
+static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+				 const struct rtw89_chan *chan)
 {
 	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct cfg80211_bitrate_mask *mask = &rtwsta->mask;
 	enum nl80211_band band;
 	u64 cfg_mask;
@@ -197,9 +197,9 @@ rtw89_ra_mask_he_rates[4] = {RA_MASK_HE_1SS_RATES, RA_MASK_HE_2SS_RATES,
 
 static void rtw89_phy_ra_gi_ltf(struct rtw89_dev *rtwdev,
 				struct rtw89_sta *rtwsta,
+				const struct rtw89_chan *chan,
 				bool *fix_giltf_en, u8 *fix_giltf)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct cfg80211_bitrate_mask *mask = &rtwsta->mask;
 	u8 band = chan->band_type;
 	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
@@ -236,7 +236,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
 	struct rtw89_ra_info *ra = &rtwsta->ra;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta->rtwvif);
 	const u64 *high_rate_masks = rtw89_ra_mask_ht_rates;
 	u8 rssi = ewma_rssi_read(&rtwsta->avg_rssi);
@@ -265,7 +266,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		if (sta->deflink.he_cap.he_cap_elem.phy_cap_info[1] &
 		    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD)
 			ldpc_en = 1;
-		rtw89_phy_ra_gi_ltf(rtwdev, rtwsta, &fix_giltf_en, &fix_giltf);
+		rtw89_phy_ra_gi_ltf(rtwdev, rtwsta, chan, &fix_giltf_en, &fix_giltf);
 	} else if (sta->deflink.vht_cap.vht_supported) {
 		u16 mcs_map = le16_to_cpu(sta->deflink.vht_cap.vht_mcs.rx_mcs_map);
 
@@ -332,7 +333,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		ra_mask &= rtw89_phy_ra_mask_rssi(rtwdev, rssi, 0);
 
 	ra_mask = rtw89_phy_ra_mask_recover(ra_mask, ra_mask_bak);
-	ra_mask &= rtw89_phy_ra_mask_cfg(rtwdev, rtwsta);
+	ra_mask &= rtw89_phy_ra_mask_cfg(rtwdev, rtwsta, chan);
 
 	switch (sta->deflink.bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
@@ -362,7 +363,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		ra->dcm_cap = 1;
 
 	if (rate_pattern->enable && !vif->p2p) {
-		ra_mask = rtw89_phy_ra_mask_cfg(rtwdev, rtwsta);
+		ra_mask = rtw89_phy_ra_mask_cfg(rtwdev, rtwsta, chan);
 		ra_mask &= rate_pattern->ra_mask;
 		mode = rate_pattern->ra_mode;
 	}
@@ -457,7 +458,8 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	struct ieee80211_supported_band *sband;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_phy_rate_pattern next_pattern = {0};
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
 	static const u16 hw_rate_he[][RTW89_CHIP_GEN_NUM] = {
 		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS1_MCS0),
 		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS2_MCS0),
@@ -2889,7 +2891,8 @@ void rtw89_phy_cfo_parse(struct rtw89_dev *rtwdev, s16 cfo_val,
 void rtw89_phy_ul_tb_assoc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
+						       rtwvif->sub_entity_idx);
 	struct rtw89_phy_ul_tb_info *ul_tb_info = &rtwdev->ul_tb_info;
 
 	if (!chip->support_ul_tb_ctrl)
-- 
2.25.1

