Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D26C1211
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCTMmr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 08:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCTMmq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 08:42:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF60C66E
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 05:42:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32KCgLzqD023699, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32KCgLzqD023699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Mar 2023 20:42:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 20 Mar 2023 20:42:35 +0800
Received: from localhost (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Mar
 2023 20:42:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v4 1/5] wifi: rtw89: 8852c: add beacon filter and CQM support
Date:   Mon, 20 Mar 2023 20:41:21 +0800
Message-ID: <20230320124125.15873-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320124125.15873-1-pkshih@realtek.com>
References: <20230320124125.15873-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.31]
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

From: Po-Hao Huang <phhuang@realtek.com>

Adding this supports beacon filter and connection quality monitor.
To make host CPU wake up less, let firmware perform signal
monitoring and beacon processing, then notify driver upon signal
changes or beacon loss.

This feature needs firmware 0.27.56 or newer to support it.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  11 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 101 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       |  63 +++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  59 ++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   8 ++
 7 files changed, 243 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 489fa7a86160d..0e32bb58bade3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1438,6 +1438,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
 	struct sk_buff *skb = iter_data->skb;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct rtw89_rx_phy_ppdu *phy_ppdu = iter_data->phy_ppdu;
 	const u8 *bssid = iter_data->bssid;
 
 	if (rtwdev->scanning &&
@@ -1456,8 +1457,11 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	if (!ether_addr_equal(vif->bss_conf.bssid, bssid))
 		return;
 
-	if (ieee80211_is_beacon(hdr->frame_control))
+	if (ieee80211_is_beacon(hdr->frame_control)) {
+		if (vif->type == NL80211_IFTYPE_STATION)
+			rtw89_fw_h2c_rssi_offload(rtwdev, phy_ppdu);
 		pkt_stat->beacon_nr++;
+	}
 
 	if (!ether_addr_equal(vif->addr, hdr->addr1))
 		return;
@@ -2520,6 +2524,9 @@ int rtw89_core_sta_disassoc(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 
+	if (vif->type == NL80211_IFTYPE_STATION)
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, false);
+
 	rtwdev->total_sta_assoc--;
 	if (sta->tdls)
 		rtwvif->tdls_peer--;
@@ -3394,6 +3401,8 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	if (RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
+		ieee80211_hw_set(hw, CONNECTION_MONITOR);
 
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				     BIT(NL80211_IFTYPE_AP) |
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e447bfec508b8..622fd991a1f94 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3204,6 +3204,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_NO_PACKET_DROP,
 	RTW89_FW_FEATURE_NO_DEEP_PS,
 	RTW89_FW_FEATURE_NO_LPS_PG,
+	RTW89_FW_FEATURE_BEACON_FILTER,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 713aefd0cf8dd..15323af2e6edf 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -266,6 +266,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 40, 0, CRASH_TRIGGER),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 56, 10, BEACON_FILTER),
 };
 
 static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
@@ -1735,6 +1736,106 @@ int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
+int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
+				  struct ieee80211_vif *vif,
+				  bool connect)
+{
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
+	struct ieee80211_bss_conf *bss_conf = vif ? &vif->bss_conf : NULL;
+	struct rtw89_h2c_bcnfltr *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	if (!RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
+		return -EINVAL;
+
+	if (!rtwvif || !bss_conf || rtwvif->net_type != RTW89_NET_TYPE_INFRA)
+		return -EINVAL;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c bcn filter\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_bcnfltr *)skb->data;
+
+	h2c->w0 = le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_RSSI) |
+		  le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_BCN) |
+		  le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_EN) |
+		  le32_encode_bits(RTW89_BCN_FLTR_OFFLOAD_MODE_DEFAULT,
+				   RTW89_H2C_BCNFLTR_W0_MODE) |
+		  le32_encode_bits(RTW89_BCN_LOSS_CNT, RTW89_H2C_BCNFLTR_W0_BCN_LOSS_CNT) |
+		  le32_encode_bits(bss_conf->cqm_rssi_hyst, RTW89_H2C_BCNFLTR_W0_RSSI_HYST) |
+		  le32_encode_bits(bss_conf->cqm_rssi_thold + MAX_RSSI,
+				   RTW89_H2C_BCNFLTR_W0_RSSI_THRESHOLD) |
+		  le32_encode_bits(rtwvif->mac_id, RTW89_H2C_BCNFLTR_W0_MAC_ID);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_CFG_BCNFLTR, 0, 1, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
+			      struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	struct rtw89_h2c_ofld_rssi *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	s8 rssi;
+	int ret;
+
+	if (!RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
+		return -EINVAL;
+
+	if (!phy_ppdu)
+		return -EINVAL;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c rssi\n");
+		return -ENOMEM;
+	}
+
+	rssi = phy_ppdu->rssi_avg >> RSSI_FACTOR;
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ofld_rssi *)skb->data;
+
+	h2c->w0 = le32_encode_bits(phy_ppdu->mac_id, RTW89_H2C_OFLD_RSSI_W0_MACID) |
+		  le32_encode_bits(1, RTW89_H2C_OFLD_RSSI_W0_NUM);
+	h2c->w1 = le32_encode_bits(rssi, RTW89_H2C_OFLD_RSSI_W1_VAL);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_OFLD_RSSI, 0, 1, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 #define H2C_RA_LEN 16
 int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index c3c67ddf61a24..4d8d961f7b236 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -162,6 +162,27 @@ enum rtw89_p2pps_action {
 	RTW89_P2P_ACT_TERMINATE = 3,
 };
 
+enum rtw89_bcn_fltr_offload_mode {
+	RTW89_BCN_FLTR_OFFLOAD_MODE_0 = 0,
+	RTW89_BCN_FLTR_OFFLOAD_MODE_1,
+	RTW89_BCN_FLTR_OFFLOAD_MODE_2,
+	RTW89_BCN_FLTR_OFFLOAD_MODE_3,
+
+	RTW89_BCN_FLTR_OFFLOAD_MODE_DEFAULT = RTW89_BCN_FLTR_OFFLOAD_MODE_0,
+};
+
+enum rtw89_bcn_fltr_type {
+	RTW89_BCN_FLTR_BEACON_LOSS,
+	RTW89_BCN_FLTR_RSSI,
+	RTW89_BCN_FLTR_NOTIFY,
+};
+
+enum rtw89_bcn_fltr_rssi_event {
+	RTW89_BCN_FLTR_RSSI_NOT_CHANGED,
+	RTW89_BCN_FLTR_RSSI_HIGH,
+	RTW89_BCN_FLTR_RSSI_LOW,
+};
+
 #define FWDL_SECTION_MAX_NUM 10
 #define FWDL_SECTION_CHKSUM_LEN	8
 #define FWDL_SECTION_PER_PKT_LEN 2020
@@ -216,6 +237,8 @@ struct rtw89_h2creg_sch_tx_en {
 #define RTW89_SCAN_LIST_LIMIT \
 		((RTW89_H2C_MAX_SIZE / RTW89_MAC_CHINFO_SIZE) - RTW89_SCAN_LIST_GUARD)
 
+#define RTW89_BCN_LOSS_CNT 10
+
 struct rtw89_mac_chinfo {
 	u8 period;
 	u8 dwell_time;
@@ -3317,6 +3340,17 @@ static inline struct rtw89_fw_c2h_attr *RTW89_SKB_C2H_CB(struct sk_buff *skb)
 #define RTW89_GET_MAC_C2H_REV_ACK_H2C_SEQ(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
 
+struct rtw89_c2h_mac_bcnfltr_rpt {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+} __packed;
+
+#define RTW89_C2H_MAC_BCNFLTR_RPT_W2_MACID GENMASK(7, 0)
+#define RTW89_C2H_MAC_BCNFLTR_RPT_W2_TYPE GENMASK(9, 8)
+#define RTW89_C2H_MAC_BCNFLTR_RPT_W2_EVENT GENMASK(11, 10)
+#define RTW89_C2H_MAC_BCNFLTR_RPT_W2_MA GENMASK(23, 16)
+
 #define RTW89_GET_PHY_C2H_RA_RPT_MACID(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 0))
 #define RTW89_GET_PHY_C2H_RA_RPT_RETRY_RATIO(c2h) \
@@ -3410,6 +3444,28 @@ static_assert(sizeof(struct rtw89_mac_mcc_tsf_rpt) <= RTW89_COMPLETION_BUF_SIZE)
 #define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_TSF_HIGH(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 4), GENMASK(31, 0))
 
+struct rtw89_h2c_bcnfltr {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_BCNFLTR_W0_MON_RSSI BIT(0)
+#define RTW89_H2C_BCNFLTR_W0_MON_BCN BIT(1)
+#define RTW89_H2C_BCNFLTR_W0_MON_EN BIT(2)
+#define RTW89_H2C_BCNFLTR_W0_MODE GENMASK(4, 3)
+#define RTW89_H2C_BCNFLTR_W0_BCN_LOSS_CNT GENMASK(11, 8)
+#define RTW89_H2C_BCNFLTR_W0_RSSI_HYST GENMASK(15, 12)
+#define RTW89_H2C_BCNFLTR_W0_RSSI_THRESHOLD GENMASK(23, 16)
+#define RTW89_H2C_BCNFLTR_W0_MAC_ID GENMASK(31, 24)
+
+struct rtw89_h2c_ofld_rssi {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
+#define RTW89_H2C_OFLD_RSSI_W0_MACID GENMASK(7, 0)
+#define RTW89_H2C_OFLD_RSSI_W0_NUM GENMASK(15, 8)
+#define RTW89_H2C_OFLD_RSSI_W1_VAL GENMASK(7, 0)
+
 #define RTW89_FW_HDR_SIZE 32
 #define RTW89_FW_SECTION_HDR_SIZE 16
 
@@ -3537,6 +3593,8 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_FUNC_ADD_SCANOFLD_CH	0x16
 #define H2C_FUNC_SCANOFLD		0x17
 #define H2C_FUNC_PKT_DROP		0x1b
+#define H2C_FUNC_CFG_BCNFLTR		0x1e
+#define H2C_FUNC_OFLD_RSSI		0x1f
 
 /* CLASS 10 - Security CAM */
 #define H2C_CL_MAC_SEC_CAM		0xa
@@ -3637,6 +3695,11 @@ int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			  u8 ac, u32 val);
 int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
+				  struct ieee80211_vif *vif,
+				  bool connect);
+int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
+			      struct rtw89_rx_phy_ppdu *phy_ppdu);
 int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi);
 int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 7866fe925d248..5fe11921cf24b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4235,6 +4235,64 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 	}
 }
 
+static void
+rtw89_mac_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		       struct sk_buff *skb)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif_safe(rtwvif);
+	enum nl80211_cqm_rssi_threshold_event nl_event;
+	const struct rtw89_c2h_mac_bcnfltr_rpt *c2h =
+		(const struct rtw89_c2h_mac_bcnfltr_rpt *)skb->data;
+	u8 type, event, mac_id;
+	s8 sig;
+
+	type = le32_get_bits(c2h->w2, RTW89_C2H_MAC_BCNFLTR_RPT_W2_TYPE);
+	sig = le32_get_bits(c2h->w2, RTW89_C2H_MAC_BCNFLTR_RPT_W2_MA) - MAX_RSSI;
+	event = le32_get_bits(c2h->w2, RTW89_C2H_MAC_BCNFLTR_RPT_W2_EVENT);
+	mac_id = le32_get_bits(c2h->w2, RTW89_C2H_MAC_BCNFLTR_RPT_W2_MACID);
+
+	if (mac_id != rtwvif->mac_id)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_FW,
+		    "C2H bcnfltr rpt macid: %d, type: %d, ma: %d, event: %d\n",
+		    mac_id, type, sig, event);
+
+	switch (type) {
+	case RTW89_BCN_FLTR_BEACON_LOSS:
+		if (!rtwdev->scanning)
+			ieee80211_connection_loss(vif);
+		else
+			rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
+		return;
+	case RTW89_BCN_FLTR_NOTIFY:
+		nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
+		break;
+	case RTW89_BCN_FLTR_RSSI:
+		if (event == RTW89_BCN_FLTR_RSSI_LOW)
+			nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW;
+		else if (event == RTW89_BCN_FLTR_RSSI_HIGH)
+			nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
+		else
+			return;
+		break;
+	default:
+		return;
+	}
+
+	ieee80211_cqm_rssi_notify(vif, nl_event, sig, GFP_KERNEL);
+}
+
+static void
+rtw89_mac_c2h_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
+			   u32 len)
+{
+	struct rtw89_vif *rtwvif;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_mac_bcn_fltr_rpt(rtwdev, rtwvif, c2h);
+}
+
 static void
 rtw89_mac_c2h_rec_ack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
@@ -4455,6 +4513,7 @@ void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_MACID_PAUSE] = rtw89_mac_c2h_macid_pause,
 	[RTW89_MAC_C2H_FUNC_SCANOFLD_RSP] = rtw89_mac_c2h_scanofld_rsp,
 	[RTW89_MAC_C2H_FUNC_TSF32_TOGL_RPT] = rtw89_mac_c2h_tsf32_toggle_rpt,
+	[RTW89_MAC_C2H_FUNC_BCNFLTR_RPT] = rtw89_mac_c2h_bcn_fltr_rpt,
 };
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8064d3953d7f2..899c45c6774e2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -359,6 +359,7 @@ enum rtw89_mac_c2h_ofld_func {
 	RTW89_MAC_C2H_FUNC_MACID_PAUSE,
 	RTW89_MAC_C2H_FUNC_TSF32_TOGL_RPT = 0x6,
 	RTW89_MAC_C2H_FUNC_SCANOFLD_RSP = 0x9,
+	RTW89_MAC_C2H_FUNC_BCNFLTR_RPT = 0xd,
 	RTW89_MAC_C2H_FUNC_OFLD_MAX,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 367a7bf319dae..629b32dafecb8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -114,6 +114,11 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 		    vif->addr, vif->type, vif->p2p);
 
 	mutex_lock(&rtwdev->mutex);
+
+	if (RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
+		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER |
+				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
+
 	rtwvif->rtwdev = rtwdev;
 	list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
 	INIT_WORK(&rtwvif->update_beacon_work, rtw89_core_update_beacon_work);
@@ -425,6 +430,9 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_P2P_PS)
 		rtw89_process_p2p_ps(rtwdev, vif);
 
+	if (changed & BSS_CHANGED_CQM)
+		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
+
 	mutex_unlock(&rtwdev->mutex);
 }
 
-- 
2.25.1

