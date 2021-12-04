Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78046845F
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 12:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384767AbhLDLO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 06:14:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50390 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1384734AbhLDLO0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 06:14:26 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtSwV-0017RD-4M; Sat, 04 Dec 2021 13:11:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 13:10:46 +0200
Message-Id: <iwlwifi.20211204130722.832c7b599202.If192dce8f51ec13005999c3ff96fe09a73cd8f91@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204111053.852455-1-luca@coelho.fi>
References: <20211204111053.852455-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: mvm: add support for statistics update version 15
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The main changes are remove the respond from STATISTICS_CMD and sending
it with STATISTICS_NOTIFICATION, and updating for all mac id's and phy
id's in one notification.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   3 +-
 .../net/wireless/intel/iwlwifi/fw/api/stats.h |  92 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 261 +++++++++++++-----
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  51 +++-
 4 files changed, 335 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 8ce03b08592c..2792fd5d9c9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -357,7 +357,7 @@ enum iwl_legacy_cmds {
 	 * &struct iwl_notif_statistics_v11,
 	 * &struct iwl_notif_statistics_v10,
 	 * &struct iwl_notif_statistics,
-	 * &struct iwl_statistics_operational_ntfy
+	 * &struct iwl_statistics_operational_ntfy_ver_14
 	 */
 	STATISTICS_CMD = 0x9c,
 
@@ -366,6 +366,7 @@ enum iwl_legacy_cmds {
 	 * one of &struct iwl_notif_statistics_v10,
 	 * &struct iwl_notif_statistics_v11,
 	 * &struct iwl_notif_statistic,
+	 * &struct iwl_statistics_operational_ntfy_ver_14
 	 * &struct iwl_statistics_operational_ntfy
 	 */
 	STATISTICS_NOTIFICATION = 0x9d,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 18cca15caa3a..898e62326e6c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020 - 2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -432,6 +432,7 @@ enum iwl_fw_statistics_type {
 	FW_STATISTICS_HE,
 }; /* FW_STATISTICS_TYPE_API_E_VER_1 */
 
+#define IWL_STATISTICS_TYPE_MSK 0x7f
 /**
  * struct iwl_statistics_ntfy_hdr
  *
@@ -445,11 +446,98 @@ struct iwl_statistics_ntfy_hdr {
 	__le16 size;
 }; /* STATISTICS_NTFY_HDR_API_S_VER_1 */
 
+/**
+ * struct iwl_statistics_ntfy_per_mac
+ *
+ * @beacon_filter_average_energy: Average energy [-dBm] of the 2
+ *	 antennas.
+ * @air_time: air time
+ * @beacon_counter: all beacons (both filtered and not filtered)
+ * @beacon_average_energy: all beacons (both filtered and not
+ *	 filtered)
+ * @beacon_rssi_a: beacon RSSI on antenna A
+ * @beacon_rssi_b: beacon RSSI on antenna B
+ * @rx_bytes: RX byte count
+ */
+struct iwl_statistics_ntfy_per_mac {
+	__le32 beacon_filter_average_energy;
+	__le32 air_time;
+	__le32 beacon_counter;
+	__le32 beacon_average_energy;
+	__le32 beacon_rssi_a;
+	__le32 beacon_rssi_b;
+	__le32 rx_bytes;
+} __packed; /* STATISTICS_NTFY_PER_MAC_API_S_VER_1 */
+
+#define IWL_STATS_MAX_BW_INDEX 5
+/** struct iwl_statistics_ntfy_per_phy
+ * @channel_load: channel load
+ * @channel_load_by_us: device contribution to MCLM
+ * @channel_load_not_by_us: other devices' contribution to MCLM
+ * @clt: CLT HW timer (TIM_CH_LOAD2)
+ * @act: active accumulator SW
+ * @elp: elapsed time accumulator SW
+ * @rx_detected_per_ch_width: number of deferred TX per channel width,
+ *	0 - 20, 1/2/3 - 40/80/160
+ * @success_per_ch_width: number of frames that got ACK/BACK/CTS
+ *	per channel BW. note, BACK counted as 1
+ * @fail_per_ch_width: number of frames that didn't get ACK/BACK/CTS
+ *	per channel BW. note BACK counted as 1
+ * @last_tx_ch_width_indx: last txed frame channel width index
+ */
+struct iwl_statistics_ntfy_per_phy {
+	__le32 channel_load;
+	__le32 channel_load_by_us;
+	__le32 channel_load_not_by_us;
+	__le32 clt;
+	__le32 act;
+	__le32 elp;
+	__le32 rx_detected_per_ch_width[IWL_STATS_MAX_BW_INDEX];
+	__le32 success_per_ch_width[IWL_STATS_MAX_BW_INDEX];
+	__le32 fail_per_ch_width[IWL_STATS_MAX_BW_INDEX];
+	__le32 last_tx_ch_width_indx;
+} __packed; /* STATISTICS_NTFY_PER_PHY_API_S_VER_1 */
+
+/**
+ * struct iwl_statistics_ntfy_per_sta
+ *
+ * @average_energy: in fact it is minus the energy..
+ */
+struct iwl_statistics_ntfy_per_sta {
+	__le32 average_energy;
+} __packed; /* STATISTICS_NTFY_PER_STA_API_S_VER_1 */
+
+#define IWL_STATS_MAX_PHY_OPERTINAL 3
 /**
  * struct iwl_statistics_operational_ntfy
  *
  * @hdr: general statistics header
  * @flags: bitmap of possible notification structures
+ * @per_mac_stats: per mac statistics, &struct iwl_statistics_ntfy_per_mac
+ * @per_phy_stats: per phy statistics, &struct iwl_statistics_ntfy_per_phy
+ * @per_sta_stats: per sta statistics, &struct iwl_statistics_ntfy_per_sta
+ * @rx_time: rx time
+ * @tx_time: usec the radio is transmitting.
+ * @on_time_rf: The total time in usec the RF is awake.
+ * @on_time_scan: usec the radio is awake due to scan.
+ */
+struct iwl_statistics_operational_ntfy {
+	struct iwl_statistics_ntfy_hdr hdr;
+	__le32 flags;
+	struct iwl_statistics_ntfy_per_mac per_mac_stats[MAC_INDEX_AUX];
+	struct iwl_statistics_ntfy_per_phy per_phy_stats[IWL_STATS_MAX_PHY_OPERTINAL];
+	struct iwl_statistics_ntfy_per_sta per_sta_stats[IWL_MVM_STATION_COUNT_MAX];
+	__le64 rx_time;
+	__le64 tx_time;
+	__le64 on_time_rf;
+	__le64 on_time_scan;
+} __packed; /* STATISTICS_OPERATIONAL_NTFY_API_S_VER_15 */
+
+/**
+ * struct iwl_statistics_operational_ntfy_ver_14
+ *
+ * @hdr: general statistics header
+ * @flags: bitmap of possible notification structures
  * @mac_id: mac on which the beacon was received
  * @beacon_filter_average_energy: Average energy [-dBm] of the 2
  *	 antennas.
@@ -469,7 +557,7 @@ struct iwl_statistics_ntfy_hdr {
  * @average_energy: in fact it is minus the energy..
  * @reserved: reserved
  */
-struct iwl_statistics_operational_ntfy {
+struct iwl_statistics_operational_ntfy_ver_14 {
 	struct iwl_statistics_ntfy_hdr hdr;
 	__le32 flags;
 	__le32 mac_id;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index d22f40a5354d..64446a11ef98 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -527,40 +527,19 @@ struct iwl_mvm_stat_data {
 	u8 *beacon_average_energy;
 };
 
-static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
-				  struct ieee80211_vif *vif)
+struct iwl_mvm_stat_data_all_macs {
+	struct iwl_mvm *mvm;
+	__le32 flags;
+	struct iwl_statistics_ntfy_per_mac *per_mac_stats;
+};
+
+static void iwl_mvm_update_vif_sig(struct ieee80211_vif *vif, int sig)
 {
-	struct iwl_mvm_stat_data *data = _data;
-	struct iwl_mvm *mvm = data->mvm;
-	int sig = -data->beacon_filter_average_energy;
-	int last_event;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
 	int thold = vif->bss_conf.cqm_rssi_thold;
 	int hyst = vif->bss_conf.cqm_rssi_hyst;
-	u16 id = le32_to_cpu(data->mac_id);
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	u16 vif_id = mvmvif->id;
-
-	/* This doesn't need the MAC ID check since it's not taking the
-	 * data copied into the "data" struct, but rather the data from
-	 * the notification directly.
-	 */
-	mvmvif->beacon_stats.num_beacons =
-		le32_to_cpu(data->beacon_counter[vif_id]);
-	mvmvif->beacon_stats.avg_signal =
-		-data->beacon_average_energy[vif_id];
-
-	/* make sure that beacon statistics don't go backwards with TCM
-	 * request to clear statistics
-	 */
-	if (le32_to_cpu(data->flags) & IWL_STATISTICS_REPLY_FLG_CLEAR)
-		mvmvif->beacon_stats.accu_num_beacons +=
-			mvmvif->beacon_stats.num_beacons;
-
-	if (mvmvif->id != id)
-		return;
-
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return;
+	int last_event;
 
 	if (sig == 0) {
 		IWL_DEBUG_RX(mvm, "RSSI is 0 - skip signal based decision\n");
@@ -618,6 +597,73 @@ static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
 	}
 }
 
+static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
+				  struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_stat_data *data = _data;
+	int sig = -data->beacon_filter_average_energy;
+	u16 id = le32_to_cpu(data->mac_id);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	u16 vif_id = mvmvif->id;
+
+	/* This doesn't need the MAC ID check since it's not taking the
+	 * data copied into the "data" struct, but rather the data from
+	 * the notification directly.
+	 */
+	mvmvif->beacon_stats.num_beacons =
+		le32_to_cpu(data->beacon_counter[vif_id]);
+	mvmvif->beacon_stats.avg_signal =
+		-data->beacon_average_energy[vif_id];
+
+	if (mvmvif->id != id)
+		return;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	/* make sure that beacon statistics don't go backwards with TCM
+	 * request to clear statistics
+	 */
+	if (le32_to_cpu(data->flags) & IWL_STATISTICS_REPLY_FLG_CLEAR)
+		mvmvif->beacon_stats.accu_num_beacons +=
+			mvmvif->beacon_stats.num_beacons;
+
+	iwl_mvm_update_vif_sig(vif, sig);
+}
+
+static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
+					   struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_stat_data_all_macs *data = _data;
+	struct iwl_statistics_ntfy_per_mac *mac_stats;
+	int sig;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	u16 vif_id = mvmvif->id;
+
+	if (WARN_ONCE(vif_id > MAC_INDEX_AUX, "invalid vif id: %d", vif_id))
+		return;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	mac_stats = &data->per_mac_stats[vif_id];
+
+	mvmvif->beacon_stats.num_beacons =
+		le32_to_cpu(mac_stats->beacon_counter);
+	mvmvif->beacon_stats.avg_signal =
+		-le32_to_cpu(mac_stats->beacon_average_energy);
+
+	/* make sure that beacon statistics don't go backwards with TCM
+	 * request to clear statistics
+	 */
+	if (le32_to_cpu(data->flags) & IWL_STATISTICS_REPLY_FLG_CLEAR)
+		mvmvif->beacon_stats.accu_num_beacons +=
+			mvmvif->beacon_stats.num_beacons;
+
+	sig = -le32_to_cpu(mac_stats->beacon_filter_average_energy);
+	iwl_mvm_update_vif_sig(vif, sig);
+}
+
 static inline void
 iwl_mvm_rx_stats_check_trigger(struct iwl_mvm *mvm, struct iwl_rx_packet *pkt)
 {
@@ -684,47 +730,41 @@ iwl_mvm_update_tcm_from_stats(struct iwl_mvm *mvm, __le32 *air_time_le,
 }
 
 static void
-iwl_mvm_handle_rx_statistics_tlv(struct iwl_mvm *mvm,
-				 struct iwl_rx_packet *pkt)
+iwl_mvm_stats_ver_15(struct iwl_mvm *mvm,
+		     struct iwl_statistics_operational_ntfy *stats)
+{
+	struct iwl_mvm_stat_data_all_macs data = {
+		.mvm = mvm,
+		.flags = stats->flags,
+		.per_mac_stats = stats->per_mac_stats,
+	};
+
+	ieee80211_iterate_active_interfaces(mvm->hw,
+					    IEEE80211_IFACE_ITER_NORMAL,
+					    iwl_mvm_stat_iterator_all_macs,
+					    &data);
+}
+
+static void
+iwl_mvm_stats_ver_14(struct iwl_mvm *mvm,
+		     struct iwl_statistics_operational_ntfy_ver_14 *stats)
 {
 	struct iwl_mvm_stat_data data = {
 		.mvm = mvm,
 	};
+
 	u8 beacon_average_energy[MAC_INDEX_AUX];
-	u8 average_energy[IWL_MVM_STATION_COUNT_MAX];
-	struct iwl_statistics_operational_ntfy *stats;
-	int expected_size;
 	__le32 flags;
 	int i;
 
-	expected_size = sizeof(*stats);
-	if (WARN_ONCE(iwl_rx_packet_payload_len(pkt) < expected_size,
-		      "received invalid statistics size (%d)!, expected_size: %d\n",
-		      iwl_rx_packet_payload_len(pkt), expected_size))
-		return;
-
-	stats = (void *)&pkt->data;
-
-	if (WARN_ONCE(stats->hdr.type != FW_STATISTICS_OPERATIONAL ||
-		      stats->hdr.version !=
-		      iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, STATISTICS_CMD, 0),
-		      "received unsupported hdr type %d, version %d\n",
-		      stats->hdr.type, stats->hdr.version))
-		return;
-
 	flags = stats->flags;
-	mvm->radio_stats.rx_time = le64_to_cpu(stats->rx_time);
-	mvm->radio_stats.tx_time = le64_to_cpu(stats->tx_time);
-	mvm->radio_stats.on_time_rf = le64_to_cpu(stats->on_time_rf);
-	mvm->radio_stats.on_time_scan = le64_to_cpu(stats->on_time_scan);
-
-	iwl_mvm_rx_stats_check_trigger(mvm, pkt);
 
 	data.mac_id = stats->mac_id;
 	data.beacon_filter_average_energy =
 		le32_to_cpu(stats->beacon_filter_average_energy);
 	data.flags = flags;
 	data.beacon_counter = stats->beacon_counter;
+
 	for (i = 0; i < ARRAY_SIZE(beacon_average_energy); i++)
 		beacon_average_energy[i] =
 			le32_to_cpu(stats->beacon_average_energy[i]);
@@ -735,9 +775,105 @@ iwl_mvm_handle_rx_statistics_tlv(struct iwl_mvm *mvm,
 					    IEEE80211_IFACE_ITER_NORMAL,
 					    iwl_mvm_stat_iterator,
 					    &data);
+}
+
+static bool iwl_mvm_verify_stats_len(struct iwl_mvm *mvm,
+				     struct iwl_rx_packet *pkt,
+				     u32 expected_size)
+{
+	struct iwl_statistics_ntfy_hdr *hdr;
+
+	if (WARN_ONCE(iwl_rx_packet_payload_len(pkt) < expected_size,
+		      "received invalid statistics size (%d)!, expected_size: %d\n",
+		      iwl_rx_packet_payload_len(pkt), expected_size))
+		return false;
+
+	hdr = (void *)&pkt->data;
+
+	if (WARN_ONCE((hdr->type & IWL_STATISTICS_TYPE_MSK) != FW_STATISTICS_OPERATIONAL ||
+		      hdr->version !=
+		      iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP, STATISTICS_NOTIFICATION, 0),
+		      "received unsupported hdr type %d, version %d\n",
+		      hdr->type, hdr->version))
+		return false;
+
+	if (WARN_ONCE(le16_to_cpu(hdr->size) != expected_size,
+		      "received invalid statistics size in header (%d)!, expected_size: %d\n",
+		      le16_to_cpu(hdr->size), expected_size))
+		return false;
+
+	return true;
+}
+
+static void
+iwl_mvm_handle_rx_statistics_tlv(struct iwl_mvm *mvm,
+				 struct iwl_rx_packet *pkt)
+{
+	u8 average_energy[IWL_MVM_STATION_COUNT_MAX];
+	__le32 air_time[MAC_INDEX_AUX];
+	__le32 rx_bytes[MAC_INDEX_AUX];
+	__le32 flags = 0;
+	int i;
+	u32 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+					      STATISTICS_NOTIFICATION, 0);
+
+	if (WARN_ONCE(notif_ver > 15,
+		      "invalid statistics version id: %d\n", notif_ver))
+		return;
+
+	if (notif_ver == 14) {
+		struct iwl_statistics_operational_ntfy_ver_14 *stats =
+			(void *)pkt->data;
+
+		if (!iwl_mvm_verify_stats_len(mvm, pkt, sizeof(*stats)))
+			return;
+
+		iwl_mvm_stats_ver_14(mvm, stats);
+
+		flags = stats->flags;
+		mvm->radio_stats.rx_time = le64_to_cpu(stats->rx_time);
+		mvm->radio_stats.tx_time = le64_to_cpu(stats->tx_time);
+		mvm->radio_stats.on_time_rf = le64_to_cpu(stats->on_time_rf);
+		mvm->radio_stats.on_time_scan =
+			le64_to_cpu(stats->on_time_scan);
+
+		for (i = 0; i < ARRAY_SIZE(average_energy); i++)
+			average_energy[i] = le32_to_cpu(stats->average_energy[i]);
+
+		for (i = 0; i < ARRAY_SIZE(air_time); i++) {
+			air_time[i] = stats->air_time[i];
+			rx_bytes[i] = stats->rx_bytes[i];
+		}
+	}
+
+	if (notif_ver == 15) {
+		struct iwl_statistics_operational_ntfy *stats =
+			(void *)pkt->data;
+
+		if (!iwl_mvm_verify_stats_len(mvm, pkt, sizeof(*stats)))
+			return;
+
+		iwl_mvm_stats_ver_15(mvm, stats);
+
+		flags = stats->flags;
+		mvm->radio_stats.rx_time = le64_to_cpu(stats->rx_time);
+		mvm->radio_stats.tx_time = le64_to_cpu(stats->tx_time);
+		mvm->radio_stats.on_time_rf = le64_to_cpu(stats->on_time_rf);
+		mvm->radio_stats.on_time_scan =
+			le64_to_cpu(stats->on_time_scan);
+
+		for (i = 0; i < ARRAY_SIZE(average_energy); i++)
+			average_energy[i] =
+				le32_to_cpu(stats->per_sta_stats[i].average_energy);
+
+		for (i = 0; i < ARRAY_SIZE(air_time); i++) {
+			air_time[i] = stats->per_mac_stats[i].air_time;
+			rx_bytes[i] = stats->per_mac_stats[i].rx_bytes;
+		}
+	}
+
+	iwl_mvm_rx_stats_check_trigger(mvm, pkt);
 
-	for (i = 0; i < ARRAY_SIZE(average_energy); i++)
-		average_energy[i] = le32_to_cpu(stats->average_energy[i]);
 	ieee80211_iterate_stations_atomic(mvm->hw, iwl_mvm_stats_energy_iter,
 					  average_energy);
 	/*
@@ -746,8 +882,7 @@ iwl_mvm_handle_rx_statistics_tlv(struct iwl_mvm *mvm,
 	 * request and once in statistics notification.
 	 */
 	if (le32_to_cpu(flags) & IWL_STATISTICS_REPLY_FLG_CLEAR)
-		iwl_mvm_update_tcm_from_stats(mvm, stats->air_time,
-					      stats->rx_bytes);
+		iwl_mvm_update_tcm_from_stats(mvm, air_time, rx_bytes);
 }
 
 void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
@@ -761,8 +896,8 @@ void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 	u8 *energy;
 
 	/* From ver 14 and up we use TLV statistics format */
-	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
-				    STATISTICS_CMD, 0) >= 14)
+	if (iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+				    STATISTICS_NOTIFICATION, 0) >= 14)
 		return iwl_mvm_handle_rx_statistics_tlv(mvm, pkt);
 
 	if (!iwl_mvm_has_new_rx_stats_api(mvm)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index caf1dcf48888..1f3e90e5dbd4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -340,25 +340,64 @@ void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	ieee80211_request_smps(vif, smps_mode);
 }
 
+static bool iwl_wait_stats_complete(struct iwl_notif_wait_data *notif_wait,
+				    struct iwl_rx_packet *pkt, void *data)
+{
+	WARN_ON(pkt->hdr.cmd != STATISTICS_NOTIFICATION);
+
+	return true;
+}
+
 int iwl_mvm_request_statistics(struct iwl_mvm *mvm, bool clear)
 {
 	struct iwl_statistics_cmd scmd = {
 		.flags = clear ? cpu_to_le32(IWL_STATISTICS_FLG_CLEAR) : 0,
 	};
+
 	struct iwl_host_cmd cmd = {
 		.id = STATISTICS_CMD,
 		.len[0] = sizeof(scmd),
 		.data[0] = &scmd,
-		.flags = CMD_WANT_SKB,
 	};
 	int ret;
 
-	ret = iwl_mvm_send_cmd(mvm, &cmd);
-	if (ret)
-		return ret;
+	/* From version 15 - STATISTICS_NOTIFICATION, the reply for
+	 * STATISTICS_CMD is empty, and the response is with
+	 * STATISTICS_NOTIFICATION notification
+	 */
+	if (iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+				    STATISTICS_NOTIFICATION, 0) < 15) {
+		cmd.flags = CMD_WANT_SKB;
 
-	iwl_mvm_handle_rx_statistics(mvm, cmd.resp_pkt);
-	iwl_free_resp(&cmd);
+		ret = iwl_mvm_send_cmd(mvm, &cmd);
+		if (ret)
+			return ret;
+
+		iwl_mvm_handle_rx_statistics(mvm, cmd.resp_pkt);
+		iwl_free_resp(&cmd);
+	} else {
+		struct iwl_notification_wait stats_wait;
+		static const u16 stats_complete[] = {
+			STATISTICS_NOTIFICATION,
+		};
+
+		iwl_init_notification_wait(&mvm->notif_wait, &stats_wait,
+					   stats_complete, ARRAY_SIZE(stats_complete),
+					   iwl_wait_stats_complete, NULL);
+
+		ret = iwl_mvm_send_cmd(mvm, &cmd);
+		if (ret) {
+			iwl_remove_notification(&mvm->notif_wait, &stats_wait);
+			return ret;
+		}
+
+		/* 200ms should be enough for FW to collect data from all
+		 * LMACs and send STATISTICS_NOTIFICATION to host
+		 */
+		ret = iwl_wait_notification(&mvm->notif_wait, &stats_wait, HZ / 5);
+		if (ret)
+			return ret;
+	}
 
 	if (clear)
 		iwl_mvm_accu_radio_stats(mvm);
-- 
2.33.1

