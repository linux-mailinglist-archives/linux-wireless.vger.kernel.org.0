Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8D4C3C2C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Feb 2022 04:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiBYDKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 22:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbiBYDKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 22:10:09 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8002C033F
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 19:09:35 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21P39R4N0000876, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21P39R4N0000876
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Feb 2022 11:09:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 25 Feb 2022 11:09:26 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 25 Feb
 2022 11:09:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 1/2] rtw89: 8852a: add ieee80211_ops::hw_scan
Date:   Fri, 25 Feb 2022 11:08:50 +0800
Message-ID: <20220225030851.13327-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225030851.13327-1-pkshih@realtek.com>
References: <20220225030851.13327-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/25/2022 02:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMjUgpFekyCAwMToyMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

From: Po Hao Huang <phhuang@realtek.com>

Declare this function allows us to use customized scanning policy, so
each scan takes less time. This is a similar implementation to hw_scan
in rtw88, except that we offload more items to firmware and extend the
maximum IE length. For backward compatibility, we fallback to sw_scan
when firmware does not support this feature.

Signed-off-by: Po Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  74 +++
 drivers/net/wireless/realtek/rtw89/core.h     |  21 +
 drivers/net/wireless/realtek/rtw89/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 515 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 351 ++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  52 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  67 ++-
 8 files changed, 1069 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a0086b14550a8..88f1d452e5d64 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -374,6 +374,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 	hal->current_channel = center_chan;
 	hal->current_freq = ch_param.center_freq;
 	hal->prev_primary_channel = hal->current_primary_channel;
+	hal->prev_band_type = hal->current_band_type;
 	hal->current_primary_channel = ch_param.primary_chan;
 	hal->current_band_type = ch_param.band_type;
 	hal->current_subband = ch_param.subband_type;
@@ -1242,6 +1243,15 @@ static void rtw89_core_hw_to_sband_rate(struct ieee80211_rx_status *rx_status)
 	if (rx_status->band == NL80211_BAND_2GHZ ||
 	    rx_status->encoding != RX_ENC_LEGACY)
 		return;
+
+	/* Some control frames' freq(ACKs in this case) are reported wrong due
+	 * to FW notify timing, set to lowest rate to prevent overflow.
+	 */
+	if (rx_status->rate_idx < RTW89_HW_RATE_OFDM6) {
+		rx_status->rate_idx = 0;
+		return;
+	}
+
 	/* No 4 CCK rates for non-2G */
 	rx_status->rate_idx -= 4;
 }
@@ -1418,6 +1428,7 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 					struct ieee80211_rx_status *rx_status)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	u16 data_rate;
 	u8 data_rate_mode;
 
@@ -1425,6 +1436,13 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 	rx_status->freq = hw->conf.chandef.chan->center_freq;
 	rx_status->band = hw->conf.chandef.chan->band;
 
+	if (rtwdev->scanning && rtwdev->fw.scan_offload) {
+		rx_status->freq =
+			ieee80211_channel_to_frequency(hal->current_channel,
+						       hal->current_band_type);
+		rx_status->band = rtwdev->hal.current_band_type;
+	}
+
 	if (desc_info->icv_err || desc_info->crc32_err)
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
 
@@ -1757,6 +1775,16 @@ static void rtw89_core_txq_schedule(struct rtw89_dev *rtwdev, u8 ac, bool *reinv
 	ieee80211_txq_schedule_end(hw, ac);
 }
 
+static void rtw89_ips_work(struct work_struct *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						ips_work);
+
+	mutex_lock(&rtwdev->mutex);
+	rtw89_enter_ips(rtwdev);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 static void rtw89_core_txq_work(struct work_struct *w)
 {
 	struct rtw89_dev *rtwdev = container_of(w, struct rtw89_dev, txq_work);
@@ -2570,10 +2598,16 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	int ret;
+	u8 band;
 
 	INIT_LIST_HEAD(&rtwdev->ba_list);
 	INIT_LIST_HEAD(&rtwdev->rtwvifs_list);
 	INIT_LIST_HEAD(&rtwdev->early_h2c_list);
+	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
+		if (!(rtwdev->chip->support_bands & BIT(band)))
+			continue;
+		INIT_LIST_HEAD(&rtwdev->scan_info.pkt_list[band]);
+	}
 	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
@@ -2589,6 +2623,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	rtwdev->total_sta_assoc = 0;
 
 	INIT_WORK(&rtwdev->c2h_work, rtw89_fw_c2h_work);
+	INIT_WORK(&rtwdev->ips_work, rtw89_ips_work);
 	skb_queue_head_init(&rtwdev->c2h_queue);
 	rtw89_core_ppdu_sts_init(rtwdev);
 	rtw89_traffic_stats_init(rtwdev, &rtwdev->stats);
@@ -2624,6 +2659,41 @@ void rtw89_core_deinit(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_core_deinit);
 
+void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			   const u8 *mac_addr, bool hw_scan)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	rtwdev->scanning = true;
+	rtw89_leave_lps(rtwdev);
+	if (hw_scan && rtwvif->net_type == RTW89_NET_TYPE_NO_LINK)
+		rtw89_leave_ips(rtwdev);
+
+	ether_addr_copy(rtwvif->mac_addr, mac_addr);
+	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, hal->current_band_type);
+	rtw89_chip_rfk_scan(rtwdev, true);
+	rtw89_hci_recalc_int_mit(rtwdev);
+
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, mac_addr);
+}
+
+void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
+			      struct ieee80211_vif *vif, bool hw_scan)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+
+	ether_addr_copy(rtwvif->mac_addr, vif->addr);
+	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
+
+	rtw89_chip_rfk_scan(rtwdev, false);
+	rtw89_btc_ntfy_scan_finish(rtwdev, RTW89_PHY_0);
+
+	rtwdev->scanning = false;
+	rtwdev->dig.bypass_dig = true;
+	if (hw_scan && rtwvif->net_type == RTW89_NET_TYPE_NO_LINK)
+		ieee80211_queue_work(rtwdev->hw, &rtwdev->ips_work);
+}
+
 static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
 {
 	u8 cv;
@@ -2739,6 +2809,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
+	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				     BIT(NL80211_IFTYPE_AP);
@@ -2747,6 +2818,9 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 
 	hw->wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 
+	hw->wiphy->max_scan_ssids = RTW89_SCANOFLD_MAX_SSID;
+	hw->wiphy->max_scan_ie_len = RTW89_SCANOFLD_MAX_IE_LEN;
+
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 
 	ret = rtw89_core_set_supported_band(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1a409add81f91..e033deb38efd9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1971,6 +1971,8 @@ struct rtw89_vif {
 	struct ieee80211_tx_queue_params tx_params[IEEE80211_NUM_ACS];
 	struct rtw89_traffic_stats stats;
 	struct rtw89_phy_rate_pattern rate_pattern;
+	struct cfg80211_scan_request *scan_req;
+	struct ieee80211_scan_ies *scan_ies;
 };
 
 enum rtw89_lv1_rcvy_step {
@@ -2348,6 +2350,7 @@ struct rtw89_fw_info {
 	struct rtw89_fw_suit wowlan;
 	bool fw_log_enable;
 	bool old_ht_ra_format;
+	bool scan_offload;
 };
 
 struct rtw89_cam_info {
@@ -2389,6 +2392,7 @@ struct rtw89_hal {
 	u8 current_primary_channel;
 	enum rtw89_subband current_subband;
 	u8 current_band_width;
+	u8 prev_band_type;
 	u8 current_band_type;
 	u32 sw_amsdu_max_size;
 	u32 antenna_tx;
@@ -2399,6 +2403,7 @@ struct rtw89_hal {
 };
 
 #define RTW89_MAX_MAC_ID_NUM 128
+#define RTW89_MAX_PKT_OFLD_NUM 255
 
 enum rtw89_flags {
 	RTW89_FLAG_POWERON,
@@ -2807,11 +2812,21 @@ struct rtw89_early_h2c {
 	u16 h2c_len;
 };
 
+struct rtw89_hw_scan_info {
+	struct ieee80211_vif *scanning_vif;
+	struct list_head pkt_list[NUM_NL80211_BANDS];
+	u8 op_pri_ch;
+	u8 op_chan;
+	u8 op_bw;
+	u8 op_band;
+};
+
 struct rtw89_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
 
 	bool dbcc_en;
+	struct rtw89_hw_scan_info scan_info;
 	const struct rtw89_chip_info *chip;
 	struct rtw89_hal hal;
 	struct rtw89_mac_info mac;
@@ -2838,6 +2853,7 @@ struct rtw89_dev {
 
 	struct sk_buff_head c2h_queue;
 	struct work_struct c2h_work;
+	struct work_struct ips_work;
 
 	struct list_head early_h2c_list;
 
@@ -2846,6 +2862,7 @@ struct rtw89_dev {
 	DECLARE_BITMAP(hw_port, RTW89_PORT_NUM);
 	DECLARE_BITMAP(mac_id_map, RTW89_MAX_MAC_ID_NUM);
 	DECLARE_BITMAP(flags, NUM_OF_RTW89_FLAGS);
+	DECLARE_BITMAP(pkt_offload, RTW89_MAX_PKT_OFLD_NUM);
 
 	struct rtw89_phy_stat phystat;
 	struct rtw89_dack_info dack;
@@ -3462,5 +3479,9 @@ void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
 int rtw89_core_start(struct rtw89_dev *rtwdev);
 void rtw89_core_stop(struct rtw89_dev *rtwdev);
 void rtw89_core_update_beacon_work(struct work_struct *work);
+void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			   const u8 *mac_addr, bool hw_scan);
+void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
+			      struct ieee80211_vif *vif, bool hw_scan);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index f14b726c1a9fb..1745815f5e00f 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -23,6 +23,7 @@ enum rtw89_debug_mask {
 	RTW89_DBG_FW = BIT(12),
 	RTW89_DBG_BTC = BIT(13),
 	RTW89_DBG_BF = BIT(14),
+	RTW89_DBG_HW_SCAN = BIT(15),
 };
 
 enum rtw89_debug_mac_reg_sel {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7fa60fd00143a..b610f676dab25 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -201,6 +201,10 @@ static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
 	if (chip->chip_id == RTL8852A &&
 	    RTW89_FW_SUIT_VER_CODE(fw_suit) <= RTW89_FW_VER_CODE(0, 13, 29, 0))
 		rtwdev->fw.old_ht_ra_format = true;
+
+	if (chip->chip_id == RTL8852A &&
+	    RTW89_FW_SUIT_VER_CODE(fw_suit) >= RTW89_FW_VER_CODE(0, 13, 35, 0))
+		rtwdev->fw.scan_offload = true;
 }
 
 int rtw89_fw_recognize(struct rtw89_dev *rtwdev)
@@ -1467,6 +1471,198 @@ int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev)
 	return -EBUSY;
 }
 
+#define H2C_LEN_PKT_OFLD 4
+int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id)
+{
+	struct sk_buff *skb;
+	u8 *cmd;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_LEN_PKT_OFLD);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c pkt offload\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_LEN_PKT_OFLD);
+	cmd = skb->data;
+
+	RTW89_SET_FWCMD_PACKET_OFLD_PKT_IDX(cmd, id);
+	RTW89_SET_FWCMD_PACKET_OFLD_PKT_OP(cmd, RTW89_PKT_OFLD_OP_DEL);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_PACKET_OFLD, 1, 1,
+			      H2C_LEN_PKT_OFLD);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
+				 struct sk_buff *skb_ofld)
+{
+	struct sk_buff *skb;
+	u8 *cmd;
+	u8 alloc_id;
+
+	alloc_id = rtw89_core_acquire_bit_map(rtwdev->pkt_offload,
+					      RTW89_MAX_PKT_OFLD_NUM);
+	if (alloc_id == RTW89_MAX_PKT_OFLD_NUM)
+		return -ENOSPC;
+
+	*id = alloc_id;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_LEN_PKT_OFLD + skb_ofld->len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c pkt offload\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_LEN_PKT_OFLD);
+	cmd = skb->data;
+
+	RTW89_SET_FWCMD_PACKET_OFLD_PKT_IDX(cmd, alloc_id);
+	RTW89_SET_FWCMD_PACKET_OFLD_PKT_OP(cmd, RTW89_PKT_OFLD_OP_ADD);
+	RTW89_SET_FWCMD_PACKET_OFLD_PKT_LENGTH(cmd, skb_ofld->len);
+	skb_put_data(skb, skb_ofld->data, skb_ofld->len);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_PACKET_OFLD, 1, 1,
+			      H2C_LEN_PKT_OFLD + skb_ofld->len);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_LEN_SCAN_LIST_OFFLOAD 4
+int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int len,
+				   struct list_head *chan_list)
+{
+	struct rtw89_mac_chinfo *ch_info;
+	struct sk_buff *skb;
+	int skb_len = H2C_LEN_SCAN_LIST_OFFLOAD + len * RTW89_MAC_CHINFO_SIZE;
+	u8 *cmd;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(skb_len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c scan list\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_LEN_SCAN_LIST_OFFLOAD);
+	cmd = skb->data;
+
+	RTW89_SET_FWCMD_SCANOFLD_CH_NUM(cmd, len);
+	/* in unit of 4 bytes */
+	RTW89_SET_FWCMD_SCANOFLD_CH_SIZE(cmd, RTW89_MAC_CHINFO_SIZE / 4);
+
+	list_for_each_entry(ch_info, chan_list, list) {
+		cmd = skb_put(skb, RTW89_MAC_CHINFO_SIZE);
+
+		RTW89_SET_FWCMD_CHINFO_PERIOD(cmd, ch_info->period);
+		RTW89_SET_FWCMD_CHINFO_DWELL(cmd, ch_info->dwell_time);
+		RTW89_SET_FWCMD_CHINFO_CENTER_CH(cmd, ch_info->central_ch);
+		RTW89_SET_FWCMD_CHINFO_PRI_CH(cmd, ch_info->pri_ch);
+		RTW89_SET_FWCMD_CHINFO_BW(cmd, ch_info->bw);
+		RTW89_SET_FWCMD_CHINFO_ACTION(cmd, ch_info->notify_action);
+		RTW89_SET_FWCMD_CHINFO_NUM_PKT(cmd, ch_info->num_pkt);
+		RTW89_SET_FWCMD_CHINFO_TX(cmd, ch_info->tx_pkt);
+		RTW89_SET_FWCMD_CHINFO_PAUSE_DATA(cmd, ch_info->pause_data);
+		RTW89_SET_FWCMD_CHINFO_BAND(cmd, ch_info->ch_band);
+		RTW89_SET_FWCMD_CHINFO_PKT_ID(cmd, ch_info->probe_id);
+		RTW89_SET_FWCMD_CHINFO_DFS(cmd, ch_info->dfs_ch);
+		RTW89_SET_FWCMD_CHINFO_TX_NULL(cmd, ch_info->tx_null);
+		RTW89_SET_FWCMD_CHINFO_RANDOM(cmd, ch_info->rand_seq_num);
+		RTW89_SET_FWCMD_CHINFO_PKT0(cmd, ch_info->pkt_id[0]);
+		RTW89_SET_FWCMD_CHINFO_PKT1(cmd, ch_info->pkt_id[1]);
+		RTW89_SET_FWCMD_CHINFO_PKT2(cmd, ch_info->pkt_id[2]);
+		RTW89_SET_FWCMD_CHINFO_PKT3(cmd, ch_info->pkt_id[3]);
+		RTW89_SET_FWCMD_CHINFO_PKT4(cmd, ch_info->pkt_id[4]);
+		RTW89_SET_FWCMD_CHINFO_PKT5(cmd, ch_info->pkt_id[5]);
+		RTW89_SET_FWCMD_CHINFO_PKT6(cmd, ch_info->pkt_id[6]);
+		RTW89_SET_FWCMD_CHINFO_PKT7(cmd, ch_info->pkt_id[7]);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_ADD_SCANOFLD_CH, 1, 1, skb_len);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
+#define H2C_LEN_SCAN_OFFLOAD 20
+int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
+			      struct rtw89_scan_option *option,
+			      struct rtw89_vif *rtwvif)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct sk_buff *skb;
+	u8 *cmd;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_LEN_SCAN_OFFLOAD);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c scan offload\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_LEN_SCAN_OFFLOAD);
+	cmd = skb->data;
+
+	RTW89_SET_FWCMD_SCANOFLD_MACID(cmd, rtwvif->mac_id);
+	RTW89_SET_FWCMD_SCANOFLD_PORT_ID(cmd, rtwvif->port);
+	RTW89_SET_FWCMD_SCANOFLD_BAND(cmd, RTW89_PHY_0);
+	RTW89_SET_FWCMD_SCANOFLD_OPERATION(cmd, option->enable);
+	RTW89_SET_FWCMD_SCANOFLD_NOTIFY_END(cmd, true);
+	RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_MODE(cmd, option->target_ch_mode);
+	RTW89_SET_FWCMD_SCANOFLD_START_MODE(cmd, RTW89_SCAN_IMMEDIATE);
+	RTW89_SET_FWCMD_SCANOFLD_SCAN_TYPE(cmd, RTW89_SCAN_ONCE);
+	if (option->target_ch_mode) {
+		RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BW(cmd, scan_info->op_bw);
+		RTW89_SET_FWCMD_SCANOFLD_TARGET_PRI_CH(cmd,
+						       scan_info->op_pri_ch);
+		RTW89_SET_FWCMD_SCANOFLD_TARGET_CENTRAL_CH(cmd,
+							   scan_info->op_chan);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_SCANOFLD, 1, 1,
+			      H2C_LEN_SCAN_OFFLOAD);
+
+	if (rtw89_h2c_tx(rtwdev, skb, false)) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return -EBUSY;
+}
+
 int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
 			u16 len, u8 page)
@@ -1739,3 +1935,322 @@ void rtw89_fw_st_dbg_dump(struct rtw89_dev *rtwdev)
 
 	rtw89_fw_prog_cnt_dump(rtwdev);
 }
+
+static void rtw89_release_pkt_list(struct rtw89_dev *rtwdev)
+{
+	struct list_head *pkt_list = rtwdev->scan_info.pkt_list;
+	struct rtw89_pktofld_info *info, *tmp;
+	u8 idx;
+
+	for (idx = RTW89_BAND_2G; idx < NUM_NL80211_BANDS; idx++) {
+		if (!(rtwdev->chip->support_bands & BIT(idx)))
+			continue;
+
+		list_for_each_entry_safe(info, tmp, &pkt_list[idx], list) {
+			rtw89_fw_h2c_del_pkt_offload(rtwdev, info->id);
+			rtw89_core_release_bit_map(rtwdev->pkt_offload,
+						   info->id);
+			list_del(&info->list);
+			kfree(info);
+		}
+	}
+}
+
+static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif *rtwvif,
+				     struct sk_buff *skb)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct ieee80211_scan_ies *ies = rtwvif->scan_ies;
+	struct rtw89_pktofld_info *info;
+	struct sk_buff *new;
+	int ret;
+	u8 band;
+
+	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
+		if (!(rtwdev->chip->support_bands & BIT(band)))
+			continue;
+
+		new = skb_copy(skb, GFP_KERNEL);
+		if (!new) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		skb_put_data(new, ies->ies[band], ies->len[band]);
+		skb_put_data(new, ies->common_ies, ies->common_ie_len);
+
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+		if (!info) {
+			ret = -ENOMEM;
+			kfree_skb(new);
+			goto out;
+		}
+
+		list_add_tail(&info->list, &scan_info->pkt_list[band]);
+		ret = rtw89_fw_h2c_add_pkt_offload(rtwdev, &info->id, new);
+		if (ret)
+			goto out;
+
+		kfree_skb(new);
+	}
+out:
+	return ret;
+}
+
+static int rtw89_hw_scan_update_probe_req(struct rtw89_dev *rtwdev,
+					  struct rtw89_vif *rtwvif)
+{
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct sk_buff *skb;
+	u8 num = req->n_ssids, i;
+	int ret;
+
+	for (i = 0; i < num; i++) {
+		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif->mac_addr,
+					     req->ssids[i].ssid,
+					     req->ssids[i].ssid_len,
+					     req->ie_len);
+		if (!skb)
+			return -ENOMEM;
+
+		ret = rtw89_append_probe_req_ie(rtwdev, rtwvif, skb);
+		kfree_skb(skb);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
+				   int ssid_num,
+				   struct rtw89_mac_chinfo *ch_info)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_pktofld_info *info;
+	u8 band, probe_count = 0;
+
+	ch_info->notify_action = RTW89_SCANOFLD_DEBUG_MASK;
+	ch_info->dfs_ch = chan_type == RTW89_CHAN_DFS;
+	ch_info->bw = RTW89_SCAN_WIDTH;
+	ch_info->tx_pkt = true;
+	ch_info->cfg_tx_pwr = false;
+	ch_info->tx_pwr_idx = 0;
+	ch_info->tx_null = false;
+	ch_info->pause_data = false;
+
+	if (ssid_num) {
+		ch_info->num_pkt = ssid_num;
+		band = ch_info->ch_band;
+
+		list_for_each_entry(info, &scan_info->pkt_list[band], list) {
+			ch_info->probe_id = info->id;
+			ch_info->pkt_id[probe_count] = info->id;
+			if (++probe_count >= ssid_num)
+				break;
+		}
+		if (probe_count != ssid_num)
+			rtw89_err(rtwdev, "SSID num differs from list len\n");
+	}
+
+	switch (chan_type) {
+	case RTW89_CHAN_OPERATE:
+		ch_info->probe_id = RTW89_SCANOFLD_PKT_NONE;
+		ch_info->central_ch = scan_info->op_chan;
+		ch_info->pri_ch = scan_info->op_pri_ch;
+		ch_info->ch_band = scan_info->op_band;
+		ch_info->bw = scan_info->op_bw;
+		ch_info->tx_null = true;
+		ch_info->num_pkt = 0;
+		break;
+	case RTW89_CHAN_DFS:
+		ch_info->period = min_t(u8, ch_info->period,
+					RTW89_DFS_CHAN_TIME);
+		ch_info->dwell_time = RTW89_DWELL_TIME;
+		break;
+	case RTW89_CHAN_ACTIVE:
+		break;
+	default:
+		rtw89_err(rtwdev, "Channel type out of bound\n");
+	}
+}
+
+static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif *rtwvif)
+{
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
+	struct rtw89_mac_chinfo	*ch_info, *tmp;
+	struct ieee80211_channel *channel;
+	struct list_head chan_list;
+	bool random_seq = req->flags & NL80211_SCAN_FLAG_RANDOM_SN;
+	int list_len = req->n_channels, off_chan_time = 0;
+	enum rtw89_chan_type type;
+	int ret = 0, i;
+
+	INIT_LIST_HEAD(&chan_list);
+	for (i = 0; i < req->n_channels; i++) {
+		channel = req->channels[i];
+		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
+		if (!ch_info) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ch_info->period = req->duration_mandatory ?
+				  req->duration : RTW89_CHANNEL_TIME;
+		ch_info->ch_band = channel->band;
+		ch_info->central_ch = channel->hw_value;
+		ch_info->pri_ch = channel->hw_value;
+		ch_info->rand_seq_num = random_seq;
+
+		if (channel->flags &
+		    (IEEE80211_CHAN_RADAR | IEEE80211_CHAN_NO_IR))
+			type = RTW89_CHAN_DFS;
+		else
+			type = RTW89_CHAN_ACTIVE;
+		rtw89_hw_scan_add_chan(rtwdev, type, req->n_ssids, ch_info);
+
+		if (rtwvif->net_type != RTW89_NET_TYPE_NO_LINK &&
+		    off_chan_time + ch_info->period > RTW89_OFF_CHAN_TIME) {
+			tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+			if (!tmp) {
+				ret = -ENOMEM;
+				kfree(ch_info);
+				goto out;
+			}
+
+			type = RTW89_CHAN_OPERATE;
+			tmp->period = req->duration_mandatory ?
+				      req->duration : RTW89_CHANNEL_TIME;
+			rtw89_hw_scan_add_chan(rtwdev, type, 0, tmp);
+			list_add_tail(&tmp->list, &chan_list);
+			off_chan_time = 0;
+			list_len++;
+		}
+		list_add_tail(&ch_info->list, &chan_list);
+		off_chan_time += ch_info->period;
+	}
+	rtw89_fw_h2c_scan_list_offload(rtwdev, list_len, &chan_list);
+
+out:
+	list_for_each_entry_safe(ch_info, tmp, &chan_list, list) {
+		list_del(&ch_info->list);
+		kfree(ch_info);
+	}
+
+	return ret;
+}
+
+static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif *rtwvif)
+{
+	int ret;
+
+	ret = rtw89_hw_scan_update_probe_req(rtwdev, rtwvif);
+	if (ret) {
+		rtw89_err(rtwdev, "Update probe request failed\n");
+		goto out;
+	}
+	ret = rtw89_hw_scan_add_chan_list(rtwdev, rtwvif);
+out:
+	return ret;
+}
+
+void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			 struct ieee80211_scan_request *scan_req)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct cfg80211_scan_request *req = &scan_req->req;
+	u8 mac_addr[ETH_ALEN];
+
+	rtwdev->scan_info.scanning_vif = vif;
+	rtwvif->scan_ies = &scan_req->ies;
+	rtwvif->scan_req = req;
+	ieee80211_stop_queues(rtwdev->hw);
+
+	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
+		get_random_mask_addr(mac_addr, req->mac_addr,
+				     req->mac_addr_mask);
+	else
+		ether_addr_copy(mac_addr, vif->addr);
+	rtw89_core_scan_start(rtwdev, rtwvif, mac_addr, true);
+
+	rtwdev->hal.rx_fltr &= ~B_AX_A_BCN_CHK_EN;
+	rtwdev->hal.rx_fltr &= ~B_AX_A_BC;
+	rtwdev->hal.rx_fltr &= ~B_AX_A_A1_MATCH;
+	rtw89_write32_mask(rtwdev,
+			   rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   B_AX_RX_FLTR_CFG_MASK,
+			   rtwdev->hal.rx_fltr);
+}
+
+void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			    bool aborted)
+{
+	struct cfg80211_scan_info info = {
+		.aborted = aborted,
+	};
+	struct rtw89_vif *rtwvif;
+
+	if (!vif)
+		return;
+
+	rtwdev->hal.rx_fltr |= B_AX_A_BCN_CHK_EN;
+	rtwdev->hal.rx_fltr |= B_AX_A_BC;
+	rtwdev->hal.rx_fltr |= B_AX_A_A1_MATCH;
+	rtw89_write32_mask(rtwdev,
+			   rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   B_AX_RX_FLTR_CFG_MASK,
+			   rtwdev->hal.rx_fltr);
+
+	rtw89_core_scan_complete(rtwdev, vif, true);
+	ieee80211_scan_completed(rtwdev->hw, &info);
+	ieee80211_wake_queues(rtwdev->hw);
+
+	rtw89_release_pkt_list(rtwdev);
+	rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	rtwvif->scan_req = NULL;
+	rtwvif->scan_ies = NULL;
+	rtwdev->scan_info.scanning_vif = NULL;
+}
+
+void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
+{
+	rtw89_hw_scan_offload(rtwdev, vif, false);
+	rtw89_hw_scan_complete(rtwdev, vif, true);
+}
+
+int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			  bool enable)
+{
+	struct rtw89_scan_option opt = {0};
+	struct rtw89_vif *rtwvif;
+	int ret = 0;
+
+	rtwvif = vif ? (struct rtw89_vif *)vif->drv_priv : NULL;
+	if (!rtwvif)
+		return -EINVAL;
+
+	opt.enable = enable;
+	opt.target_ch_mode = rtwvif->net_type != RTW89_NET_TYPE_NO_LINK;
+	if (enable) {
+		ret = rtw89_hw_scan_prehandle(rtwdev, rtwvif);
+		if (ret)
+			goto out;
+	}
+	rtw89_fw_h2c_scan_offload(rtwdev, &opt, rtwvif);
+out:
+	return ret;
+}
+
+void rtw89_store_op_chan(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	scan_info->op_pri_ch = hal->current_primary_channel;
+	scan_info->op_chan = hal->current_channel;
+	scan_info->op_bw = hal->current_band_width;
+	scan_info->op_band = hal->current_band_type;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 83f4eaaf90f3b..ed8609b204e09 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -123,6 +123,27 @@ enum rtw89_fw_log_comp {
 	RTW89_FW_LOG_COMP_MCC = 20,
 };
 
+enum rtw89_pkt_offload_op {
+	RTW89_PKT_OFLD_OP_ADD,
+	RTW89_PKT_OFLD_OP_DEL,
+	RTW89_PKT_OFLD_OP_READ,
+};
+
+enum rtw89_scanofld_notify_reason {
+	RTW89_SCAN_DWELL_NOTIFY,
+	RTW89_SCAN_PRE_TX_NOTIFY,
+	RTW89_SCAN_POST_TX_NOTIFY,
+	RTW89_SCAN_ENTER_CH_NOTIFY,
+	RTW89_SCAN_LEAVE_CH_NOTIFY,
+	RTW89_SCAN_END_SCAN_NOTIFY,
+};
+
+enum rtw89_chan_type {
+	RTW89_CHAN_OPERATE = 0,
+	RTW89_CHAN_ACTIVE,
+	RTW89_CHAN_DFS,
+};
+
 #define FWDL_SECTION_MAX_NUM 10
 #define FWDL_SECTION_CHKSUM_LEN	8
 #define FWDL_SECTION_PER_PKT_LEN 2020
@@ -156,6 +177,50 @@ struct rtw89_h2creg_sch_tx_en {
 	u16 rsvd:15;
 } __packed;
 
+#define RTW89_CHANNEL_TIME 45
+#define RTW89_DFS_CHAN_TIME 105
+#define RTW89_OFF_CHAN_TIME 100
+#define RTW89_DWELL_TIME 20
+#define RTW89_SCAN_WIDTH 0
+#define RTW89_SCANOFLD_MAX_SSID 8
+#define RTW89_SCANOFLD_MAX_IE_LEN 512
+#define RTW89_SCANOFLD_PKT_NONE 0xFF
+#define RTW89_SCANOFLD_DEBUG_MASK 0x1F
+#define RTW89_MAC_CHINFO_SIZE 20
+
+struct rtw89_mac_chinfo {
+	u8 period;
+	u8 dwell_time;
+	u8 central_ch;
+	u8 pri_ch;
+	u8 bw:3;
+	u8 notify_action:5;
+	u8 num_pkt:4;
+	u8 tx_pkt:1;
+	u8 pause_data:1;
+	u8 ch_band:2;
+	u8 probe_id;
+	u8 dfs_ch:1;
+	u8 tx_null:1;
+	u8 rand_seq_num:1;
+	u8 cfg_tx_pwr:1;
+	u8 rsvd0: 4;
+	u8 pkt_id[RTW89_SCANOFLD_MAX_SSID];
+	u16 tx_pwr_idx;
+	u8 rsvd1;
+	struct list_head list;
+};
+
+struct rtw89_scan_option {
+	bool enable;
+	bool target_ch_mode;
+};
+
+struct rtw89_pktofld_info {
+	struct list_head list;
+	u8 id;
+};
+
 static inline void RTW89_SET_FWCMD_RA_IS_DIS(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, BIT(0));
@@ -1436,6 +1501,14 @@ enum rtw89_btc_cxdrvinfo {
 	CXDRVINFO_MAX,
 };
 
+enum rtw89_scan_mode {
+	RTW89_SCAN_IMMEDIATE,
+};
+
+enum rtw89_scan_type {
+	RTW89_SCAN_ONCE,
+};
+
 static inline void RTW89_SET_FWCMD_CXHDR_TYPE(void *cmd, u8 val)
 {
 	u8p_replace_bits((u8 *)(cmd) + 0, val, GENMASK(7, 0));
@@ -1706,6 +1779,242 @@ static inline void RTW89_SET_FWCMD_CXRFK_TYPE(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(17, 10));
 }
 
+static inline void RTW89_SET_FWCMD_PACKET_OFLD_PKT_IDX(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_PACKET_OFLD_PKT_OP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(10, 8));
+}
+
+static inline void RTW89_SET_FWCMD_PACKET_OFLD_PKT_LENGTH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(31, 16));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_CH_NUM(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_CH_SIZE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PERIOD(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_DWELL(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_CENTER_CH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PRI_CH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_BW(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(2, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_ACTION(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(7, 3));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_NUM_PKT(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(11, 8));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_TX(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(12));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PAUSE_DATA(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(13));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_BAND(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(15, 14));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PKT_ID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_DFS(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(24));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_TX_NULL(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(25));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_RANDOM(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(26));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_CFG_TX(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(27));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PKT0(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PKT1(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PKT2(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PKT3(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PKT4(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 12), val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PKT5(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 12), val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PKT6(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 12), val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_PKT7(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 12), val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_FWCMD_CHINFO_POWER_IDX(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 16), val, GENMASK(15, 0));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_MACID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_NORM_CY(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_PORT_ID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(18, 16));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_BAND(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, BIT(19));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_OPERATION(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(21, 20));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BAND(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd)), val, GENMASK(23, 22));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_NOTIFY_END(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(0));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_MODE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(1));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_START_MODE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, BIT(2));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_SCAN_TYPE(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(4, 3));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_TARGET_CH_BW(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(7, 5));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_TARGET_PRI_CH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(15, 8));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_TARGET_CENTRAL_CH(void *cmd,
+							      u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_PROBE_REQ_PKT_ID(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 4), val, GENMASK(31, 24));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_NORM_PD(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(15, 0));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_SLOW_PD(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 8), val, GENMASK(23, 16));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_TSF_HIGH(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 12), val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_SCANOFLD_TSF_SLOW(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 16), val, GENMASK(31, 0));
+}
+
 #define RTW89_C2H_HEADER_LEN 8
 
 #define RTW89_GET_C2H_CATEGORY(c2h) \
@@ -1762,6 +2071,26 @@ static inline void RTW89_SET_FWCMD_CXRFK_TYPE(void *cmd, u32 val)
 #define RTW89_MK_HT_RATE(nss, mcs) (FIELD_PREP(GENMASK(4, 3), nss) | \
 				    FIELD_PREP(GENMASK(2, 0), mcs))
 
+#define RTW89_GET_MAC_C2H_PKTOFLD_ID(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 0))
+#define RTW89_GET_MAC_C2H_PKTOFLD_OP(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(10, 8))
+#define RTW89_GET_MAC_C2H_PKTOFLD_LEN(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(31, 16))
+
+#define RTW89_GET_MAC_C2H_SCANOFLD_PRI_CH(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 0))
+#define RTW89_GET_MAC_C2H_SCANOFLD_RSP(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(19, 16))
+#define RTW89_GET_MAC_C2H_SCANOFLD_STATUS(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 20))
+#define RTW89_GET_MAC_C2H_SCANOFLD_TX_FAIL(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 5), GENMASK(3, 0))
+#define RTW89_GET_MAC_C2H_SCANOFLD_AIR_DENSITY(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 5), GENMASK(7, 4))
+#define RTW89_GET_MAC_C2H_SCANOFLD_BAND(c2h) \
+	le32_get_bits(*((const __le32 *)(c2h) + 5), GENMASK(25, 24))
+
 #define RTW89_FW_HDR_SIZE 32
 #define RTW89_FW_SECTION_HDR_SIZE 16
 
@@ -1842,9 +2171,12 @@ struct rtw89_fw_h2c_rf_reg_info {
 
 /* CLASS 9 - FW offload */
 #define H2C_CL_MAC_FW_OFLD		0x9
+#define H2C_FUNC_PACKET_OFLD		0x1
 #define H2C_FUNC_MAC_MACID_PAUSE	0x8
 #define H2C_FUNC_USR_EDCA		0xF
 #define H2C_FUNC_OFLD_CFG		0x14
+#define H2C_FUNC_ADD_SCANOFLD_CH	0x16
+#define H2C_FUNC_SCANOFLD		0x17
 
 /* CLASS 10 - Security CAM */
 #define H2C_CL_MAC_SEC_CAM		0xa
@@ -1900,6 +2232,14 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id);
+int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
+				 struct sk_buff *skb_ofld);
+int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int len,
+				   struct list_head *chan_list);
+int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
+			      struct rtw89_scan_option *opt,
+			      struct rtw89_vif *vif);
 int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
 			u16 len, u8 page);
@@ -1922,5 +2262,16 @@ int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
 		     struct rtw89_mac_c2h_info *c2h_info);
 int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_fw_st_dbg_dump(struct rtw89_dev *rtwdev);
+void rtw89_store_op_chan(struct rtw89_dev *rtwdev);
+void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			 struct ieee80211_scan_request *req);
+void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			    bool aborted);
+int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
+			  bool enable);
+void rtw89_hw_scan_status_report(struct rtw89_dev *rtwdev, struct sk_buff *skb);
+void rtw89_hw_scan_chan_switch(struct rtw89_dev *rtwdev, struct sk_buff *skb);
+void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw89_store_op_chan(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 031e6e99d4bed..5e140290fe04a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3129,6 +3129,57 @@ rtw89_mac_c2h_macid_pause(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len
 {
 }
 
+static bool rtw89_is_op_chan(struct rtw89_dev *rtwdev, u8 band, u8 channel)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+
+	return band == scan_info->op_band && channel == scan_info->op_pri_ch;
+}
+
+static void
+rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
+			   u32 len)
+{
+	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 reason, status, tx_fail, band;
+	u16 chan;
+
+	tx_fail = RTW89_GET_MAC_C2H_SCANOFLD_TX_FAIL(c2h->data);
+	status = RTW89_GET_MAC_C2H_SCANOFLD_STATUS(c2h->data);
+	chan = RTW89_GET_MAC_C2H_SCANOFLD_PRI_CH(c2h->data);
+	reason = RTW89_GET_MAC_C2H_SCANOFLD_RSP(c2h->data);
+	band = RTW89_GET_MAC_C2H_SCANOFLD_BAND(c2h->data);
+
+	if (!(rtwdev->chip->support_bands & BIT(NL80211_BAND_6GHZ)))
+		band = chan > 14 ? RTW89_BAND_5G : RTW89_BAND_2G;
+
+	rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
+		    "band: %d, chan: %d, reason: %d, status: %d, tx_fail: %d\n",
+		    band, chan, reason, status, tx_fail);
+
+	switch (reason) {
+	case RTW89_SCAN_LEAVE_CH_NOTIFY:
+		if (rtw89_is_op_chan(rtwdev, band, chan))
+			ieee80211_stop_queues(rtwdev->hw);
+		return;
+	case RTW89_SCAN_END_SCAN_NOTIFY:
+		rtw89_hw_scan_complete(rtwdev, vif, false);
+		break;
+	case RTW89_SCAN_ENTER_CH_NOTIFY:
+		if (rtw89_is_op_chan(rtwdev, band, chan))
+			ieee80211_wake_queues(rtwdev->hw);
+		break;
+	default:
+		return;
+	}
+
+	hal->prev_band_type = hal->current_band_type;
+	hal->prev_primary_channel = hal->current_channel;
+	hal->current_channel = chan;
+	hal->current_band_type = band;
+}
+
 static void
 rtw89_mac_c2h_rec_ack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
@@ -3172,6 +3223,7 @@ void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_PKT_OFLD_RSP] = NULL,
 	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = NULL,
 	[RTW89_MAC_C2H_FUNC_MACID_PAUSE] = rtw89_mac_c2h_macid_pause,
+	[RTW89_MAC_C2H_FUNC_SCANOFLD_RSP] = rtw89_mac_c2h_scanofld_rsp,
 };
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index e5db0a2eb9c29..9ea84349e593c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -301,6 +301,7 @@ enum rtw89_mac_c2h_ofld_func {
 	RTW89_MAC_C2H_FUNC_PKT_OFLD_RSP,
 	RTW89_MAC_C2H_FUNC_BCN_RESEND,
 	RTW89_MAC_C2H_FUNC_MACID_PAUSE,
+	RTW89_MAC_C2H_FUNC_SCANOFLD_RSP = 0x9,
 	RTW89_MAC_C2H_FUNC_OFLD_MAX,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 5df7aceabdf5e..fca9f82bb462f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -66,6 +66,9 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
+	/* let previous ips work finish to ensure we don't leave ips twice */
+	cancel_work_sync(&rtwdev->ips_work);
+
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
 
@@ -347,6 +350,13 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw89_phy_set_bss_color(rtwdev, vif);
 			rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, vif);
 			rtw89_mac_port_update(rtwdev, rtwvif);
+			rtw89_store_op_chan(rtwdev);
+		} else {
+			/* Abort ongoing scan if cancel_scan isn't issued
+			 * when disconnected by peer
+			 */
+			if (rtwdev->scanning)
+				rtw89_hw_scan_abort(rtwdev, vif);
 		}
 	}
 
@@ -684,15 +694,9 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
-	struct rtw89_hal *hal = &rtwdev->hal;
 
 	mutex_lock(&rtwdev->mutex);
-	rtwdev->scanning = true;
-	rtw89_leave_lps(rtwdev);
-	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, hal->current_band_type);
-	rtw89_chip_rfk_scan(rtwdev, true);
-	rtw89_hci_recalc_int_mit(rtwdev);
-	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, mac_addr);
+	rtw89_core_scan_start(rtwdev, rtwvif, mac_addr, false);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -700,14 +704,9 @@ static void rtw89_ops_sw_scan_complete(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 
 	mutex_lock(&rtwdev->mutex);
-	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
-	rtw89_chip_rfk_scan(rtwdev, false);
-	rtw89_btc_ntfy_scan_finish(rtwdev, RTW89_PHY_0);
-	rtwdev->scanning = false;
-	rtwdev->dig.bypass_dig = true;
+	rtw89_core_scan_complete(rtwdev, vif, false);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -720,6 +719,46 @@ static void rtw89_ops_reconfig_complete(struct ieee80211_hw *hw,
 		rtw89_ser_recfg_done(rtwdev);
 }
 
+static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			     struct ieee80211_scan_request *req)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	int ret = 0;
+
+	if (!rtwdev->fw.scan_offload)
+		return 1;
+
+	if (rtwdev->scanning)
+		return -EBUSY;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw89_hw_scan_start(rtwdev, vif, req);
+	ret = rtw89_hw_scan_offload(rtwdev, vif, true);
+	if (ret) {
+		rtw89_hw_scan_abort(rtwdev, vif);
+		rtw89_err(rtwdev, "HW scan failed with status: %d\n", ret);
+	}
+	mutex_unlock(&rtwdev->mutex);
+
+	return ret;
+}
+
+static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	if (!rtwdev->fw.scan_offload)
+		return;
+
+	if (!rtwdev->scanning)
+		return;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw89_hw_scan_abort(rtwdev, vif);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 const struct ieee80211_ops rtw89_ops = {
 	.tx			= rtw89_ops_tx,
 	.wake_tx_queue		= rtw89_ops_wake_tx_queue,
@@ -746,6 +785,8 @@ const struct ieee80211_ops rtw89_ops = {
 	.sw_scan_start		= rtw89_ops_sw_scan_start,
 	.sw_scan_complete	= rtw89_ops_sw_scan_complete,
 	.reconfig_complete	= rtw89_ops_reconfig_complete,
+	.hw_scan		= rtw89_ops_hw_scan,
+	.cancel_hw_scan		= rtw89_ops_cancel_hw_scan,
 	.set_sar_specs		= rtw89_ops_set_sar_specs,
 };
 EXPORT_SYMBOL(rtw89_ops);
-- 
2.25.1

