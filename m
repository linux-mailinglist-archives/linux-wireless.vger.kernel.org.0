Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2E56897E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2019 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfGOMq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jul 2019 08:46:28 -0400
Received: from alexa-out-ams-01.qualcomm.com ([185.23.61.162]:48564 "EHLO
        alexa-out-ams-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730597AbfGOMq2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jul 2019 08:46:28 -0400
Received: from ironmsg01-ams.qualcomm.com ([10.251.56.2])
  by alexa-out-ams-01.qualcomm.com with ESMTP; 15 Jul 2019 14:46:21 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9318"; a="8781000"
Received: from unknown (HELO wigig-1329.mea.qualcomm.com) ([10.4.89.235])
  by ironmsg01-ams.qualcomm.com with ESMTP; 15 Jul 2019 14:46:20 +0200
From:   Alexei Avshalom Lazar <ailizaro@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: [PATCH v5 2/2] wil6210: Add EDMG channel support
Date:   Mon, 15 Jul 2019 15:46:07 +0300
Message-Id: <1563194767-4817-3-git-send-email-ailizaro@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1563194767-4817-1-git-send-email-ailizaro@codeaurora.org>
References: <1563194767-4817-1-git-send-email-ailizaro@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for Enhanced Directional Multi-Gigabit (EDMG) channels 9-11.
wil6210 reports it's EDMG capabilities (that are also based on FW
capability) to cfg80211 by filling
wiphy->bands[NL80211_BAND_60GHZ]->edmg_cap.
wil6210 handles edmg.channels and edmg.bw_config requested in connect
and start_ap operations.

Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c  | 205 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/wil6210/txrx_edma.c |   2 +
 drivers/net/wireless/ath/wil6210/txrx_edma.h |   6 +
 drivers/net/wireless/ath/wil6210/wil6210.h   |   8 +-
 drivers/net/wireless/ath/wil6210/wmi.c       |   5 +-
 drivers/net/wireless/ath/wil6210/wmi.h       |  30 +++-
 6 files changed, 242 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index ce68fbc..a68f148 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -25,6 +25,22 @@
 
 #define WIL_MAX_ROC_DURATION_MS 5000
 
+#define WIL_EDMG_CHANNEL_9_SUBCHANNELS	(BIT(0) | BIT(1))
+#define WIL_EDMG_CHANNEL_10_SUBCHANNELS	(BIT(1) | BIT(2))
+#define WIL_EDMG_CHANNEL_11_SUBCHANNELS	(BIT(2) | BIT(3))
+
+/* WIL_EDMG_BW_CONFIGURATION define the allowed channel bandwidth
+ * configurations as defined by IEEE 802.11 section 9.4.2.251, Table 13.
+ * The value 5 allowing CB1 and CB2 of adjacent channels.
+ */
+#define WIL_EDMG_BW_CONFIGURATION 5
+
+/* WIL_EDMG_CHANNELS is a bitmap that indicates the 2.16 GHz channel(s) that
+ * are allowed to be used for EDMG transmissions in the BSS as defined by
+ * IEEE 802.11 section 9.4.2.251.
+ */
+#define WIL_EDMG_CHANNELS (BIT(0) | BIT(1) | BIT(2) | BIT(3))
+
 bool disable_ap_sme;
 module_param(disable_ap_sme, bool, 0444);
 MODULE_PARM_DESC(disable_ap_sme, " let user space handle AP mode SME");
@@ -51,6 +67,39 @@
 	CHAN60G(4, 0),
 };
 
+/* Rx channel bonding mode */
+enum wil_rx_cb_mode {
+	WIL_RX_CB_MODE_DMG,
+	WIL_RX_CB_MODE_EDMG,
+	WIL_RX_CB_MODE_WIDE,
+};
+
+static int wil_rx_cb_mode_to_n_bonded(u8 cb_mode)
+{
+	switch (cb_mode) {
+	case WIL_RX_CB_MODE_DMG:
+	case WIL_RX_CB_MODE_EDMG:
+		return 1;
+	case WIL_RX_CB_MODE_WIDE:
+		return 2;
+	default:
+		return 1;
+	}
+}
+
+static int wil_tx_cb_mode_to_n_bonded(u8 cb_mode)
+{
+	switch (cb_mode) {
+	case WMI_TX_MODE_DMG:
+	case WMI_TX_MODE_EDMG_CB1:
+		return 1;
+	case WMI_TX_MODE_EDMG_CB2:
+		return 2;
+	default:
+		return 1;
+	}
+}
+
 static void
 wil_memdup_ie(u8 **pdst, size_t *pdst_len, const u8 *src, size_t src_len)
 {
@@ -82,6 +131,12 @@ void update_supported_bands(struct wil6210_priv *wil)
 
 	wiphy->bands[NL80211_BAND_60GHZ]->n_channels =
 						wil_num_supported_channels(wil);
+
+	if (test_bit(WMI_FW_CAPABILITY_CHANNEL_BONDING, wil->fw_capabilities))
+		wiphy->bands[NL80211_BAND_60GHZ]->edmg_cap.channels =
+							WIL_EDMG_CHANNELS;
+		wiphy->bands[NL80211_BAND_60GHZ]->edmg_cap.bw_config =
+						      WIL_EDMG_BW_CONFIGURATION;
 }
 
 /* Vendor id to be used in vendor specific command and events
@@ -296,6 +351,86 @@ int wil_iftype_nl2wmi(enum nl80211_iftype type)
 	return -EOPNOTSUPP;
 }
 
+int wil_spec2wmi_ch(u8 spec_ch, u8 *wmi_ch)
+{
+	switch (spec_ch) {
+	case 1:
+		*wmi_ch = WMI_CHANNEL_1;
+		break;
+	case 2:
+		*wmi_ch = WMI_CHANNEL_2;
+		break;
+	case 3:
+		*wmi_ch = WMI_CHANNEL_3;
+		break;
+	case 4:
+		*wmi_ch = WMI_CHANNEL_4;
+		break;
+	case 5:
+		*wmi_ch = WMI_CHANNEL_5;
+		break;
+	case 6:
+		*wmi_ch = WMI_CHANNEL_6;
+		break;
+	case 9:
+		*wmi_ch = WMI_CHANNEL_9;
+		break;
+	case 10:
+		*wmi_ch = WMI_CHANNEL_10;
+		break;
+	case 11:
+		*wmi_ch = WMI_CHANNEL_11;
+		break;
+	case 12:
+		*wmi_ch = WMI_CHANNEL_12;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int wil_wmi2spec_ch(u8 wmi_ch, u8 *spec_ch)
+{
+	switch (wmi_ch) {
+	case WMI_CHANNEL_1:
+		*spec_ch = 1;
+		break;
+	case WMI_CHANNEL_2:
+		*spec_ch = 2;
+		break;
+	case WMI_CHANNEL_3:
+		*spec_ch = 3;
+		break;
+	case WMI_CHANNEL_4:
+		*spec_ch = 4;
+		break;
+	case WMI_CHANNEL_5:
+		*spec_ch = 5;
+		break;
+	case WMI_CHANNEL_6:
+		*spec_ch = 6;
+		break;
+	case WMI_CHANNEL_9:
+		*spec_ch = 9;
+		break;
+	case WMI_CHANNEL_10:
+		*spec_ch = 10;
+		break;
+	case WMI_CHANNEL_11:
+		*spec_ch = 11;
+		break;
+	case WMI_CHANNEL_12:
+		*spec_ch = 12;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 		       struct station_info *sinfo)
 {
@@ -310,6 +445,7 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 	} __packed reply;
 	struct wil_net_stats *stats = &wil->sta[cid].stats;
 	int rc;
+	u8 txflag = RATE_INFO_FLAGS_DMG;
 
 	memset(&reply, 0, sizeof(reply));
 
@@ -322,7 +458,8 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 		    "  MCS %d TSF 0x%016llx\n"
 		    "  BF status 0x%08x RSSI %d SQI %d%%\n"
 		    "  Tx Tpt %d goodput %d Rx goodput %d\n"
-		    "  Sectors(rx:tx) my %d:%d peer %d:%d\n""}\n",
+		    "  Sectors(rx:tx) my %d:%d peer %d:%d\n"
+		    "  Tx mode %d}\n",
 		    cid, vif->mid, le16_to_cpu(reply.evt.bf_mcs),
 		    le64_to_cpu(reply.evt.tsf), reply.evt.status,
 		    reply.evt.rssi,
@@ -333,7 +470,8 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 		    le16_to_cpu(reply.evt.my_rx_sector),
 		    le16_to_cpu(reply.evt.my_tx_sector),
 		    le16_to_cpu(reply.evt.other_rx_sector),
-		    le16_to_cpu(reply.evt.other_tx_sector));
+		    le16_to_cpu(reply.evt.other_tx_sector),
+		    reply.evt.tx_mode);
 
 	sinfo->generation = wil->sinfo_gen;
 
@@ -346,9 +484,16 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 			BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC) |
 			BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 
-	sinfo->txrate.flags = RATE_INFO_FLAGS_DMG;
+	if (wil->use_enhanced_dma_hw && reply.evt.tx_mode != WMI_TX_MODE_DMG)
+		txflag = RATE_INFO_FLAGS_EDMG;
+
+	sinfo->txrate.flags = txflag;
 	sinfo->txrate.mcs = le16_to_cpu(reply.evt.bf_mcs);
 	sinfo->rxrate.mcs = stats->last_mcs_rx;
+	sinfo->txrate.n_bonded_ch =
+				  wil_tx_cb_mode_to_n_bonded(reply.evt.tx_mode);
+	sinfo->rxrate.n_bonded_ch =
+			     wil_rx_cb_mode_to_n_bonded(stats->last_cb_mode_rx);
 	sinfo->rx_bytes = stats->rx_bytes;
 	sinfo->rx_packets = stats->rx_packets;
 	sinfo->rx_dropped_misc = stats->rx_dropped;
@@ -1006,6 +1151,33 @@ static int wil_ft_connect(struct wiphy *wiphy,
 	return rc;
 }
 
+static int wil_get_wmi_edmg_channel(struct wil6210_priv *wil, u8 edmg_bw_config,
+				    u8 edmg_channels, u8 *wmi_ch)
+{
+	if (!edmg_bw_config) {
+		*wmi_ch = 0;
+		return 0;
+	} else if (edmg_bw_config == WIL_EDMG_BW_CONFIGURATION) {
+		/* convert from edmg channel bitmap into edmg channel number */
+		switch (edmg_channels) {
+		case WIL_EDMG_CHANNEL_9_SUBCHANNELS:
+			return wil_spec2wmi_ch(9, wmi_ch);
+		case WIL_EDMG_CHANNEL_10_SUBCHANNELS:
+			return wil_spec2wmi_ch(10, wmi_ch);
+		case WIL_EDMG_CHANNEL_11_SUBCHANNELS:
+			return wil_spec2wmi_ch(11, wmi_ch);
+		default:
+			wil_err(wil, "Unsupported edmg channel bitmap 0x%x\n",
+				edmg_channels);
+			return -EINVAL;
+		}
+	} else {
+		wil_err(wil, "Unsupported EDMG BW configuration %d\n",
+			edmg_bw_config);
+		return -EINVAL;
+	}
+}
+
 static int wil_cfg80211_connect(struct wiphy *wiphy,
 				struct net_device *ndev,
 				struct cfg80211_connect_params *sme)
@@ -1151,6 +1323,11 @@ static int wil_cfg80211_connect(struct wiphy *wiphy,
 	memcpy(conn.ssid, ssid_eid+2, conn.ssid_len);
 	conn.channel = ch - 1;
 
+	rc = wil_get_wmi_edmg_channel(wil, sme->edmg.bw_config,
+				      sme->edmg.channels, &conn.edmg_channel);
+	if (rc < 0)
+		return rc;
+
 	ether_addr_copy(conn.bssid, bss->bssid);
 	ether_addr_copy(conn.dst_mac, bss->bssid);
 
@@ -1707,7 +1884,7 @@ static int _wil_cfg80211_set_ies(struct wil6210_vif *vif,
 static int _wil_cfg80211_start_ap(struct wiphy *wiphy,
 				  struct net_device *ndev,
 				  const u8 *ssid, size_t ssid_len, u32 privacy,
-				  int bi, u8 chan,
+				  int bi, u8 chan, u8 wmi_edmg_channel,
 				  struct cfg80211_beacon_data *bcon,
 				  u8 hidden_ssid, u32 pbss)
 {
@@ -1770,6 +1947,7 @@ static int _wil_cfg80211_start_ap(struct wiphy *wiphy,
 
 	vif->privacy = privacy;
 	vif->channel = chan;
+	vif->wmi_edmg_channel = wmi_edmg_channel;
 	vif->hidden_ssid = hidden_ssid;
 	vif->pbss = pbss;
 	vif->bi = bi;
@@ -1780,7 +1958,8 @@ static int _wil_cfg80211_start_ap(struct wiphy *wiphy,
 	if (!wil_has_other_active_ifaces(wil, ndev, false, true))
 		wil6210_bus_request(wil, WIL_MAX_BUS_REQUEST_KBPS);
 
-	rc = wmi_pcp_start(vif, bi, wmi_nettype, chan, hidden_ssid, is_go);
+	rc = wmi_pcp_start(vif, bi, wmi_nettype, chan, wmi_edmg_channel,
+			   hidden_ssid, is_go);
 	if (rc)
 		goto err_pcp_start;
 
@@ -1832,7 +2011,8 @@ void wil_cfg80211_ap_recovery(struct wil6210_priv *wil)
 		rc = _wil_cfg80211_start_ap(wiphy, ndev,
 					    vif->ssid, vif->ssid_len,
 					    vif->privacy, vif->bi,
-					    vif->channel, &bcon,
+					    vif->channel,
+					    vif->wmi_edmg_channel, &bcon,
 					    vif->hidden_ssid, vif->pbss);
 		if (rc) {
 			wil_err(wil, "vif %d recovery failed (%d)\n", i, rc);
@@ -1882,7 +2062,8 @@ static int wil_cfg80211_change_beacon(struct wiphy *wiphy,
 		rc = _wil_cfg80211_start_ap(wiphy, ndev, vif->ssid,
 					    vif->ssid_len, privacy,
 					    wdev->beacon_interval,
-					    vif->channel, bcon,
+					    vif->channel,
+					    vif->wmi_edmg_channel, bcon,
 					    vif->hidden_ssid,
 					    vif->pbss);
 	} else {
@@ -1901,10 +2082,17 @@ static int wil_cfg80211_start_ap(struct wiphy *wiphy,
 	struct ieee80211_channel *channel = info->chandef.chan;
 	struct cfg80211_beacon_data *bcon = &info->beacon;
 	struct cfg80211_crypto_settings *crypto = &info->crypto;
+	u8 wmi_edmg_channel;
 	u8 hidden_ssid;
 
 	wil_dbg_misc(wil, "start_ap\n");
 
+	rc = wil_get_wmi_edmg_channel(wil, info->chandef.edmg.bw_config,
+				      info->chandef.edmg.channels,
+				      &wmi_edmg_channel);
+	if (rc < 0)
+		return rc;
+
 	if (!channel) {
 		wil_err(wil, "AP: No channel???\n");
 		return -EINVAL;
@@ -1944,7 +2132,8 @@ static int wil_cfg80211_start_ap(struct wiphy *wiphy,
 	rc = _wil_cfg80211_start_ap(wiphy, ndev,
 				    info->ssid, info->ssid_len, info->privacy,
 				    info->beacon_interval, channel->hw_value,
-				    bcon, hidden_ssid, info->pbss);
+				    wmi_edmg_channel, bcon, hidden_ssid,
+				    info->pbss);
 
 	return rc;
 }
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index c387738..0c9bb2c 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -1006,6 +1006,8 @@ static struct sk_buff *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
 			stats->rx_per_mcs[stats->last_mcs_rx]++;
 	}
 
+	stats->last_cb_mode_rx  = wil_rx_status_get_cb_mode(msg);
+
 	if (!wil->use_rx_hw_reordering && !wil->use_compressed_rx_status &&
 	    wil_check_bar(wil, msg, cid, skb, stats) == -EAGAIN) {
 		kfree_skb(skb);
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.h b/drivers/net/wireless/ath/wil6210/txrx_edma.h
index 343516a..2680ffc 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.h
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.h
@@ -366,6 +366,12 @@ static inline u8 wil_rx_status_get_mcs(void *msg)
 			    16, 21);
 }
 
+static inline u8 wil_rx_status_get_cb_mode(void *msg)
+{
+	return WIL_GET_BITS(((struct wil_rx_status_compressed *)msg)->d1,
+			    22, 23);
+}
+
 static inline u16 wil_rx_status_get_flow_id(void *msg)
 {
 	return WIL_GET_BITS(((struct wil_rx_status_compressed *)msg)->d0,
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index e1b1039b..d32c0bf 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -590,6 +590,7 @@ struct wil_net_stats {
 	unsigned long	rx_amsdu_error; /* eDMA specific */
 	unsigned long	rx_csum_err;
 	u16 last_mcs_rx;
+	u8 last_cb_mode_rx;
 	u64 rx_per_mcs[WIL_MCS_MAX + 1];
 	u32 ft_roams; /* relevant in STA mode */
 };
@@ -851,6 +852,7 @@ struct wil6210_vif {
 	DECLARE_BITMAP(status, wil_vif_status_last);
 	u32 privacy; /* secure connection? */
 	u16 channel; /* relevant in AP mode */
+	u8 wmi_edmg_channel; /* relevant in AP mode */
 	u8 hidden_ssid; /* relevant in AP mode */
 	u32 ap_isolate; /* no intra-BSS communication */
 	bool pbss;
@@ -1313,7 +1315,7 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 
 int wmi_set_mac_address(struct wil6210_priv *wil, void *addr);
 int wmi_pcp_start(struct wil6210_vif *vif, int bi, u8 wmi_nettype, u8 chan,
-		  u8 hidden_ssid, u8 is_go);
+		  u8 edmg_chan, u8 hidden_ssid, u8 is_go);
 int wmi_pcp_stop(struct wil6210_vif *vif);
 int wmi_led_cfg(struct wil6210_priv *wil, bool enable);
 int wmi_abort_scan(struct wil6210_vif *vif);
@@ -1389,6 +1391,10 @@ int wmi_start_sched_scan(struct wil6210_priv *wil,
 int wmi_mgmt_tx_ext(struct wil6210_vif *vif, const u8 *buf, size_t len,
 		    u8 channel, u16 duration_ms);
 
+int wil_wmi2spec_ch(u8 wmi_ch, u8 *spec_ch);
+int wil_spec2wmi_ch(u8 spec_ch, u8 *wmi_ch);
+void wil_update_supported_bands(struct wil6210_priv *wil);
+
 int reverse_memcmp(const void *cs, const void *ct, size_t count);
 
 /* WMI for enhanced DMA */
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index bda4a97..fe8530d 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -2123,8 +2123,8 @@ int wmi_led_cfg(struct wil6210_priv *wil, bool enable)
 	return rc;
 }
 
-int wmi_pcp_start(struct wil6210_vif *vif,
-		  int bi, u8 wmi_nettype, u8 chan, u8 hidden_ssid, u8 is_go)
+int wmi_pcp_start(struct wil6210_vif *vif, int bi, u8 wmi_nettype,
+		  u8 chan, u8 wmi_edmg_chan, u8 hidden_ssid, u8 is_go)
 {
 	struct wil6210_priv *wil = vif_to_wil(vif);
 	int rc;
@@ -2134,6 +2134,7 @@ int wmi_pcp_start(struct wil6210_vif *vif,
 		.network_type = wmi_nettype,
 		.disable_sec_offload = 1,
 		.channel = chan - 1,
+		.edmg_channel = wmi_edmg_chan,
 		.pcp_max_assoc_sta = max_assoc_sta,
 		.hidden_ssid = hidden_ssid,
 		.is_go = is_go,
diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index b668758..1b39aeb 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -95,6 +95,7 @@ enum wmi_fw_capability {
 	WMI_FW_CAPABILITY_SET_SILENT_RSSI_TABLE		= 13,
 	WMI_FW_CAPABILITY_LO_POWER_CALIB_FROM_OTP	= 14,
 	WMI_FW_CAPABILITY_PNO				= 15,
+	WMI_FW_CAPABILITY_CHANNEL_BONDING		= 17,
 	WMI_FW_CAPABILITY_REF_CLOCK_CONTROL		= 18,
 	WMI_FW_CAPABILITY_AP_SME_OFFLOAD_NONE		= 19,
 	WMI_FW_CAPABILITY_MULTI_VIFS			= 20,
@@ -355,6 +356,19 @@ enum wmi_connect_ctrl_flag_bits {
 
 #define WMI_MAX_SSID_LEN	(32)
 
+enum wmi_channel {
+	WMI_CHANNEL_1	= 0x00,
+	WMI_CHANNEL_2	= 0x01,
+	WMI_CHANNEL_3	= 0x02,
+	WMI_CHANNEL_4	= 0x03,
+	WMI_CHANNEL_5	= 0x04,
+	WMI_CHANNEL_6	= 0x05,
+	WMI_CHANNEL_9	= 0x06,
+	WMI_CHANNEL_10	= 0x07,
+	WMI_CHANNEL_11	= 0x08,
+	WMI_CHANNEL_12	= 0x09,
+};
+
 /* WMI_CONNECT_CMDID */
 struct wmi_connect_cmd {
 	u8 network_type;
@@ -366,8 +380,12 @@ struct wmi_connect_cmd {
 	u8 group_crypto_len;
 	u8 ssid_len;
 	u8 ssid[WMI_MAX_SSID_LEN];
+	/* enum wmi_channel WMI_CHANNEL_1..WMI_CHANNEL_6; for EDMG this is
+	 * the primary channel number
+	 */
 	u8 channel;
-	u8 reserved0;
+	/* enum wmi_channel WMI_CHANNEL_9..WMI_CHANNEL_12 */
+	u8 edmg_channel;
 	u8 bssid[WMI_MAC_LEN];
 	__le32 ctrl_flags;
 	u8 dst_mac[WMI_MAC_LEN];
@@ -2267,7 +2285,9 @@ struct wmi_notify_req_done_event {
 	__le32 status;
 	__le64 tsf;
 	s8 rssi;
-	u8 reserved0[3];
+	/* enum wmi_edmg_tx_mode */
+	u8 tx_mode;
+	u8 reserved0[2];
 	__le32 tx_tpt;
 	__le32 tx_goodput;
 	__le32 rx_goodput;
@@ -2283,8 +2303,12 @@ struct wmi_notify_req_done_event {
 
 /* WMI_CONNECT_EVENTID */
 struct wmi_connect_event {
+	/* enum wmi_channel WMI_CHANNEL_1..WMI_CHANNEL_6; for EDMG this is
+	 * the primary channel number
+	 */
 	u8 channel;
-	u8 reserved0;
+	/* enum wmi_channel WMI_CHANNEL_9..WMI_CHANNEL_12 */
+	u8 edmg_channel;
 	u8 bssid[WMI_MAC_LEN];
 	__le16 listen_interval;
 	__le16 beacon_interval;
-- 
1.9.1

