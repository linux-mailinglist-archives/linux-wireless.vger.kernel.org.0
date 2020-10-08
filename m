Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972C52876E1
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgJHPND (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:13:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54596 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730874AbgJHPNC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:13:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbF-002QxQ-5e; Thu, 08 Oct 2020 18:12:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:43 +0300
Message-Id: <iwlwifi.20201008181047.a45fd1a34a39.I7709305a6dc7b88d0c5119b12c9251fa6c740262@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: [PATCH 06/13] iwlwifi: stats: add new api fields for statistics cmd/ntfy
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The new API uses TLV format for statistics to enable fast changes
and debug on the fly.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   6 +-
 .../net/wireless/intel/iwlwifi/fw/api/stats.h | 461 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 195 +++++---
 3 files changed, 602 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 14975a7e7203..8cc36dbb2311 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -411,7 +411,8 @@ enum iwl_legacy_cmds {
 	 * one of &struct iwl_statistics_cmd,
 	 * &struct iwl_notif_statistics_v11,
 	 * &struct iwl_notif_statistics_v10,
-	 * &struct iwl_notif_statistics
+	 * &struct iwl_notif_statistics,
+	 * &struct iwl_statistics_operational_ntfy
 	 */
 	STATISTICS_CMD = 0x9c,
 
@@ -419,7 +420,8 @@ enum iwl_legacy_cmds {
 	 * @STATISTICS_NOTIFICATION:
 	 * one of &struct iwl_notif_statistics_v10,
 	 * &struct iwl_notif_statistics_v11,
-	 * &struct iwl_notif_statistics
+	 * &struct iwl_notif_statistic,
+	 * &struct iwl_statistics_operational_ntfy
 	 */
 	STATISTICS_NOTIFICATION = 0x9d,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 35265c4e8c19..d41cab4016fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -464,4 +464,465 @@ struct iwl_statistics_cmd {
 	__le32 flags;
 } __packed; /* STATISTICS_CMD_API_S_VER_1 */
 
+#define MAX_BCAST_FILTER_NUM		8
+
+/**
+ * enum iwl_fw_statistics_type
+ *
+ * @FW_STATISTICS_OPERATIONAL: operational statistics
+ * @FW_STATISTICS_PHY: phy statistics
+ * @FW_STATISTICS_MAC: mac statistics
+ * @FW_STATISTICS_RX: rx statistics
+ * @FW_STATISTICS_TX: tx statistics
+ * @FW_STATISTICS_DURATION: duration statistics
+ * @FW_STATISTICS_HE: he statistics
+ */
+enum iwl_fw_statistics_type {
+	FW_STATISTICS_OPERATIONAL,
+	FW_STATISTICS_PHY,
+	FW_STATISTICS_MAC,
+	FW_STATISTICS_RX,
+	FW_STATISTICS_TX,
+	FW_STATISTICS_DURATION,
+	FW_STATISTICS_HE,
+}; /* FW_STATISTICS_TYPE_API_E_VER_1 */
+
+/**
+ * struct iwl_statistics_ntfy_hdr
+ *
+ * @type: struct type
+ * @version: version of the struct
+ * @size: size in bytes
+ */
+struct iwl_statistics_ntfy_hdr {
+	u8 type;
+	u8 version;
+	__le16 size;
+}; /* STATISTICS_NTFY_HDR_API_S_VER_1 */
+
+/**
+ * struct iwl_statistics_operational_ntfy
+ *
+ * @hdr: general statistics header
+ * @flags: bitmap of possible notification structures
+ * @mac_id: mac on which the beacon was received
+ * @beacon_filter_average_energy: Average energy [-dBm] of the 2
+ *	 antennas.
+ * @beacon_filter_reason: beacon filter reason
+ * @radio_temperature: radio temperature
+ * @air_time: air time
+ * @beacon_counter: all beacons (both filtered and not filtered)
+ * @beacon_average_energy: all beacons (both filtered and not
+ *	 filtered)
+ * @beacon_rssi_a: beacon RSSI on antenna A
+ * @beacon_rssi_b: beacon RSSI on antenna B
+ * @rx_bytes: per MAC RX byte count
+ * @rx_time: rx time
+ * @tx_time: usec the radio is transmitting.
+ * @on_time_rf: The total time in usec the RF is awake.
+ * @on_time_scan: usec the radio is awake due to scan.
+ * @average_energy: in fact it is minus the energy..
+ * @reserved: reserved
+ */
+struct iwl_statistics_operational_ntfy {
+	struct iwl_statistics_ntfy_hdr hdr;
+	__le32 flags;
+	__le32 mac_id;
+	__le32 beacon_filter_average_energy;
+	__le32 beacon_filter_reason;
+	__le32 radio_temperature;
+	__le32 air_time[MAC_INDEX_AUX];
+	__le32 beacon_counter[MAC_INDEX_AUX];
+	__le32 beacon_average_energy[MAC_INDEX_AUX];
+	__le32 beacon_rssi_a;
+	__le32 beacon_rssi_b;
+	__le32 rx_bytes[MAC_INDEX_AUX];
+	__le64 rx_time;
+	__le64 tx_time;
+	__le64 on_time_rf;
+	__le64 on_time_scan;
+	__le32 average_energy[IWL_MVM_STATION_COUNT_MAX];
+	__le32 reserved;
+} __packed; /* STATISTICS_OPERATIONAL_NTFY_API_S_VER_14 */
+
+/**
+ * struct iwl_statistics_phy_ntfy
+ *
+ * @hdr: general statistics header
+ * RX PHY related statistics
+ * @energy_and_config: ???
+ * @rssi_band: @31:24 rssiAllBand_B, 23:16 rssiInBand_B, 15:8
+ *	 rssiAllBand_A, 7:0 rssiInBand_A
+ * @agc_word: @31:16 agcWord_B, 15:0 agcWord_A
+ * @agc_gain: @19:10 agcGain_B, 9:0 agcGain_A
+ * @dfe_gain: @19:10 dfeGain_B, 9:0 dfeGain_A
+ * @snr_calc_main: @18:0 snrCalcMain
+ * @energy_calc_main: @18:0 energyCalcMain
+ * @snr_calc_aux: @18:0 snrCalcAux
+ * @dsp_dc_estim_a: @27:14 dspDcEstimQA, 13:0 dspDcEstimIA
+ * @dsp_dc_estim_b: @27:14 dspDcEstimQB, 13:0 dspDcEstimIB
+ * @ina_detec_type_and_ofdm_corr_comb: @31:31 inaDetectCckMrc,
+ *	 30:27 inaDetectType, 26:0 ofdmCorrComb
+ * @cw_corr_comb: @26:0 cwCorrComb
+ * @rssi_comb: @25:0 rssiComb
+ * @auto_corr_cck: @23:12 autoCck, 11:00 crossCck
+ * @ofdm_fine_freq_and_pina_freq_err: @18:7 ofdmFineFreq, 6:0
+ *	 ofdmPinaFreqErr
+ * @snrm_evm_main: @31:0 snrmEvmMain
+ * @snrm_evm_aux: @31:0 snrmEvmAux
+ * @rx_rate: @31:0 rate
+ * TX PHY related statistics
+ * @per_chain_enums_and_dsp_atten_a: @perChainEnumsAndDspAtten
+ *	 (per version)
+ * @target_power_and_power_meas_a: @31:16 targetPower_A, 15:0
+ *	 powerMeasuredCalc_A
+ * @tx_config_as_i_and_ac_a: @31:16 txConfigAsI_A, 15:0
+ *	 txConfigAc_A
+ * @predist_dcq_and_dci_a: @31:16 predist_dci_A, 15:0
+ *	 predist_dcq_A
+ * @per_chain_enums_and_dsp_atten_b: @perChainEnumsAndDspAtten
+ *	 (per version)
+ * @target_power_and_power_meas_b: @31:16 targetPower_B, 15:0
+ *	 powerMeasuredCalc_B
+ * @tx_config_as_i_and_ac_b: @31:16 txConfigAsI_B, 15:0
+ *	 txConfigAc_B
+ * @predist_dcq_and_dci_b: @31:16 predist_dci_B, 15:0
+ *	 predist_dcq_B
+ * @tx_rate: @31:0 rate
+ * @tlc_backoff: @31:0 tlcBackoff
+ * @mpapd_calib_mode_mpapd_calib_type_a: @31:16
+ *	 mpapdCalibMode_A, 15:0 mpapdCalibType_A
+ * @psat_and_phy_power_limit_a: @31:16 psat_A, 15:0
+ *	 phyPowerLimit_A
+ * @sar_and_regulatory_power_limit_a: @31:16 sarPowerLimit_A,
+ *	 15:0 regulatoryPowerLimit_A
+ * @mpapd_calib_mode_mpapd_calib_type_b: @31:16
+ *	 mpapdCalibMode_B, 15:0 mpapdCalibType_B
+ * @psat_and_phy_power_limit_b: @31:16 psat_B, 15:0
+ *	 phyPowerLimit_B
+ * @sar_and_regulatory_power_limit_b: @31:16 sarPowerLimit_B,
+ *	 15:0 regulatoryPowerLimit_B
+ * @srd_and_driver_power_limits: @31:16 srdPowerLimit, 15:0
+ *	 driverPowerLimit
+ * @reserved: reserved
+ */
+struct iwl_statistics_phy_ntfy {
+	struct iwl_statistics_ntfy_hdr hdr;
+	__le32 energy_and_config;
+	__le32 rssi_band;
+	__le32 agc_word;
+	__le32 agc_gain;
+	__le32 dfe_gain;
+	__le32 snr_calc_main;
+	__le32 energy_calc_main;
+	__le32 snr_calc_aux;
+	__le32 dsp_dc_estim_a;
+	__le32 dsp_dc_estim_b;
+	__le32 ina_detec_type_and_ofdm_corr_comb;
+	__le32 cw_corr_comb;
+	__le32 rssi_comb;
+	__le32 auto_corr_cck;
+	__le32 ofdm_fine_freq_and_pina_freq_err;
+	__le32 snrm_evm_main;
+	__le32 snrm_evm_aux;
+	__le32 rx_rate;
+	__le32 per_chain_enums_and_dsp_atten_a;
+	__le32 target_power_and_power_meas_a;
+	__le32 tx_config_as_i_and_ac_a;
+	__le32 predist_dcq_and_dci_a;
+	__le32 per_chain_enums_and_dsp_atten_b;
+	__le32 target_power_and_power_meas_b;
+	__le32 tx_config_as_i_and_ac_b;
+	__le32 predist_dcq_and_dci_b;
+	__le32 tx_rate;
+	__le32 tlc_backoff;
+	__le32 mpapd_calib_mode_mpapd_calib_type_a;
+	__le32 psat_and_phy_power_limit_a;
+	__le32 sar_and_regulatory_power_limit_a;
+	__le32 mpapd_calib_mode_mpapd_calib_type_b;
+	__le32 psat_and_phy_power_limit_b;
+	__le32 sar_and_regulatory_power_limit_b;
+	__le32 srd_and_driver_power_limits;
+	__le32 reserved;
+} __packed; /* STATISTICS_PHY_NTFY_API_S_VER_1 */
+
+/**
+ * struct iwl_statistics_mac_ntfy
+ *
+ * @hdr: general statistics header
+ * @bcast_filter_passed_per_mac: bcast filter passed per mac
+ * @bcast_filter_dropped_per_mac: bcast filter dropped per mac
+ * @bcast_filter_passed_per_filter: bcast filter passed per filter
+ * @bcast_filter_dropped_per_filter: bcast filter dropped per filter
+ * @reserved: reserved
+ */
+struct iwl_statistics_mac_ntfy {
+	struct iwl_statistics_ntfy_hdr hdr;
+	__le32 bcast_filter_passed_per_mac[NUM_MAC_INDEX_CDB];
+	__le32 bcast_filter_dropped_per_mac[NUM_MAC_INDEX_CDB];
+	__le32 bcast_filter_passed_per_filter[MAX_BCAST_FILTER_NUM];
+	__le32 bcast_filter_dropped_per_filter[MAX_BCAST_FILTER_NUM];
+	__le32 reserved;
+} __packed; /* STATISTICS_MAC_NTFY_API_S_VER_1 */
+
+/**
+ * struct iwl_statistics_rx_ntfy
+ *
+ * @hdr: general statistics header
+ * @rx_agg_mpdu_cnt: aggregation frame count (number of
+ *	 delimiters)
+ * @rx_agg_cnt: number of RX Aggregations
+ * @unsupported_mcs: number of PLCP headers that have rate which
+ *	 is unsupported by DSP
+ * @bogus_cts: CTS received when not expecting CTS
+ * @bogus_ack: ACK received when not expecting ACK
+ * @rx_byte_count: ???
+ * @rx_packet_count: ???
+ * @missed_beacons: ???
+ * @unresponded_rts: un-responded RTS, due to NAV not zero
+ * @rxe_frame_limit_overrun: RXE got frame limit overrun
+ * @sent_ba_rsp_cnt: BA response TX count
+ * @late_rx_handle: count the number of times the RX path was
+ *	 aborted due to late entry
+ * @num_bt_kills: ???
+ * @reserved: reserved
+ */
+struct iwl_statistics_rx_ntfy {
+	struct iwl_statistics_ntfy_hdr hdr;
+	__le32 rx_agg_mpdu_cnt;
+	__le32 rx_agg_cnt;
+	__le32 unsupported_mcs;
+	__le32 bogus_cts;
+	__le32 bogus_ack;
+	__le32 rx_byte_count[MAC_INDEX_AUX];
+	__le32 rx_packet_count[MAC_INDEX_AUX];
+	__le32 missed_beacons;
+	__le32 unresponded_rts;
+	__le32 rxe_frame_limit_overrun;
+	__le32 sent_ba_rsp_cnt;
+	__le32 late_rx_handle;
+	__le32 num_bt_kills;
+	__le32 reserved;
+} __packed; /* STATISTICS_RX_NTFY_API_S_VER_1 */
+
+/**
+ * struct iwl_statistics_tx_ntfy
+ *
+ * @hdr: general statistics header
+ * @cts_timeout: timeout when waiting for CTS
+ * @ack_timeout: timeout when waiting for ACK
+ * @dump_msdu_cnt: number of MSDUs that were dumped due to any
+ *	 reason
+ * @burst_abort_missing_next_frame_cnt: number of times a burst
+ *	 was aborted due to missing next frame bytes in txfifo
+ * number of times got timeout when waiting for CTS/ACK/BA and energy was
+ * detected just after sending the RTS/DATA. this statistics may help getting
+ * interesting indicators, like the likelihood of collision (so the benefit of
+ * protection may be estimated Vs. its cost). Or how many of the failures are
+ * due to collision and how many due to SNR.
+ * For Link-quality the CTS collision indication is more reliable then the ACK
+ * collision indication as the RTS frame is short and has more chance that the
+ * frame/s which caused the collision continue after the RTS was sent.
+ * @cts_timeout_collision: ???
+ * ACK/BA failed and energy as detected after DATA
+ * Note: to get the collision ratio need to:
+ * ackOrBaTimeoutCollision / (ack_timeout + ba_timeout)
+ * @ack_or_ba_timeout_collision: ???
+ * @ba_timeout: timeout when waiting for immediate BA response
+ * @ba_reschedule_frames: failed to get BA response and
+ *	 rescheduled all the non-ACKed frames
+ * gives the avarage number of frames inside aggregation
+ * @scd_query_agg_frame_cnt: ???
+ * @scd_query_no_agg: scheduler query prevented aggregation
+ * @scd_query_agg: scheduler query allowed aggregation
+ * @scd_query_mismatch: scheduler query inaccurate, either too
+ *	 short or too long
+ * @agg_terminated_underrun: aggregation was terminated due to
+ *	 underrun
+ * @agg_terminated_bt_prio_kill: aggregation was terminated due
+ *	 to BT
+ * @tx_kill_on_long_retry: count the tx frames dropped due to
+ *	 long retry limit (DATA frame failed)
+ * @tx_kill_on_short_retry: count the tx frames dropped due to
+ *	 short retry limit (RTS frame failed)
+ * TX deffer on energy. This counter is reset on each successful transmit.
+ * When timer exceed TX deffer limit than will be uCode assert.
+ * @tx_deffer_counter: ???
+ * @tx_deffer_base_time: Keep the time of the last successful
+ *	 transmit
+ * @tx_underrun: TX killed due to underrun
+ * @bt_defer: TX deferred due to BT priority, so probably TX was
+ *	 not started.
+ * @tx_kill_on_dsp_timeout: TX killed on DSP problem detected
+ * @tx_kill_on_immediate_quiet: TX killed due to immediate quiet
+ * @kill_ba_cnt: number of times sending BA failed
+ * @kill_ack_cnt: number of times sending ACK failed
+ * @kill_cts_cnt: number of times sending CTS failed
+ * @burst_terminated: Count burst or fragmentation termination
+ *	 occurrence
+ * @late_tx_vec_wr_cnt: ???
+ * TX is not sent because ucode failed to notify the TRM in SIFS-delta from
+ * ON_AIR deassertion.
+ * @late_rx2_tx_cnt: ???
+ * @scd_query_cnt: count the times SCD query was done to check
+ *	 for TX AGG
+ * @tx_frames_acked_in_agg: count the number of frames
+ *	 transmitted inside AGG and were successful
+ * @last_tx_ch_width_indx: ???
+ * number of deferred TX per channel width, 0 - 20, 1/2/3 - 40/80/160
+ * @rx_detected_per_ch_width: ???
+ * @success_per_ch_width: ???
+ * @fail_per_ch_width: ???
+ * @reserved: reserved
+ */
+struct iwl_statistics_tx_ntfy {
+	struct iwl_statistics_ntfy_hdr hdr;
+	__le32 cts_timeout;
+	__le32 ack_timeout;
+	__le32 dump_msdu_cnt;
+	__le32 burst_abort_missing_next_frame_cnt;
+	__le32 cts_timeout_collision;
+	__le32 ack_or_ba_timeout_collision;
+	__le32 ba_timeout;
+	__le32 ba_reschedule_frames;
+	__le32 scd_query_agg_frame_cnt;
+	__le32 scd_query_no_agg;
+	__le32 scd_query_agg;
+	__le32 scd_query_mismatch;
+	__le32 agg_terminated_underrun;
+	__le32 agg_terminated_bt_prio_kill;
+	__le32 tx_kill_on_long_retry;
+	__le32 tx_kill_on_short_retry;
+	__le32 tx_deffer_counter;
+	__le32 tx_deffer_base_time;
+	__le32 tx_underrun;
+	__le32 bt_defer;
+	__le32 tx_kill_on_dsp_timeout;
+	__le32 tx_kill_on_immediate_quiet;
+	__le32 kill_ba_cnt;
+	__le32 kill_ack_cnt;
+	__le32 kill_cts_cnt;
+	__le32 burst_terminated;
+	__le32 late_tx_vec_wr_cnt;
+	__le32 late_rx2_tx_cnt;
+	__le32 scd_query_cnt;
+	__le32 tx_frames_acked_in_agg;
+	__le32 last_tx_ch_width_indx;
+	__le32 rx_detected_per_ch_width[4];
+	__le32 success_per_ch_width[4];
+	__le32 fail_per_ch_width[4];
+	__le32 reserved;
+} __packed; /* STATISTICS_TX_NTFY_API_S_VER_1 */
+
+/**
+ * struct iwl_statistics_duration_ntfy
+ *
+ * @hdr: general statistics header
+ * @cont_burst_chk_cnt: number of times continuation or
+ *	 fragmentation or bursting was checked
+ * @cont_burst_cnt: number of times continuation or fragmentation
+ *	 or bursting was successful
+ * @wait_for_silence_timeout_cnt: ???
+ * @reserved: reserved
+ */
+struct iwl_statistics_duration_ntfy {
+	struct iwl_statistics_ntfy_hdr hdr;
+	__le32 cont_burst_chk_cnt;
+	__le32 cont_burst_cnt;
+	__le32 wait_for_silence_timeout_cnt;
+	__le32 reserved;
+} __packed; /* STATISTICS_DURATION_NTFY_API_S_VER_1 */
+
+/**
+ * struct iwl_statistics_he_ntfy
+ *
+ * @hdr: general statistics header
+ * received HE frames
+ * @rx_siga_valid_cnt: rx HE SIG-A valid
+ * @rx_siga_invalid_cnt: rx HE SIG-A invalid
+ * received HE frames w/ valid Sig-A
+ * @rx_trig_based_frame_cnt: rx HE-TB (trig-based)
+ * @rx_su_frame_cnt: rx HE-SU
+ * @rx_sigb_invalid_cnt: rx (suspected) HE-MU w/ bad SIG-B
+ * @rx_our_bss_color_cnt: rx valid HE SIG-A w/ our BSS color
+ * @rx_other_bss_color_cnt: rx valid HE SIG-A w/ other BSS color
+ * @rx_zero_bss_color_cnt: ???
+ * received HE-MU frames w/ good Sig-B
+ * @rx_mu_for_us_cnt: match AID
+ * @rx_mu_not_for_us_cnt: no matched AID
+ * received HE-MU frames for us (w/ our AID)
+ * @rx_mu_nss_ar: 0 - SISO, 1 - MIMO2
+ * @rx_mu_mimo_cnt: full BW RU, compressed SIG-B
+ * @rx_mu_ru_bw_ar: MU alloc, MHz: 0 - 2, 1 - 5, 2 - 10, 3 - 20,
+ *	 4 - 40, 5 - 80, 6 - 160
+ * received trigger frames
+ * @rx_trig_for_us_cnt: ???
+ * @rx_trig_not_for_us_cnt: ???
+ * trigger for us
+ * @rx_trig_with_cs_req_cnt: ???
+ * @rx_trig_type_ar: ???
+ * @rx_trig_in_agg_cnt: ???
+ * basic trigger for us allocations
+ * @rx_basic_trig_alloc_nss_ar: ???
+ * @rx_basic_trig_alloc_mu_mimo_cnt: ???
+ * @rx_basic_trig_alloc_ru_bw_ar: ???
+ * @rx_basic_trig_total_byte_cnt: ???
+ * trig-based TX
+ * @tx_trig_based_cs_req_fail_cnt: ???
+ * @tx_trig_based_sifs_ok_cnt: ???
+ * @tx_trig_based_sifs_fail_cnt: ???
+ * @tx_trig_based_byte_cnt: ???
+ * @tx_trig_based_pad_byte_cnt: ???
+ * @tx_trig_based_frame_cnt: ???
+ * @tx_trig_based_acked_frame_cnt: ???
+ * @tx_trig_based_ack_timeout_cnt: ???
+ * HE-SU TX
+ * @tx_su_frame_cnt: ???
+ * EDCA <--> MU-EDCA transitions
+ * @tx_edca_to_mu_edca_cnt: ???
+ * @tx_mu_edca_to_edca_by_timeout_cnt: ???
+ * @tx_mu_edca_to_edca_by_ack_fail_cnt: ???
+ * @tx_mu_edca_to_edca_by_small_alloc_cnt: ???
+ * @reserved: reserved
+ */
+struct iwl_statistics_he_ntfy {
+	struct iwl_statistics_ntfy_hdr hdr;
+	__le32 rx_siga_valid_cnt;
+	__le32 rx_siga_invalid_cnt;
+	__le32 rx_trig_based_frame_cnt;
+	__le32 rx_su_frame_cnt;
+	__le32 rx_sigb_invalid_cnt;
+	__le32 rx_our_bss_color_cnt;
+	__le32 rx_other_bss_color_cnt;
+	__le32 rx_zero_bss_color_cnt;
+	__le32 rx_mu_for_us_cnt;
+	__le32 rx_mu_not_for_us_cnt;
+	__le32 rx_mu_nss_ar[2];
+	__le32 rx_mu_mimo_cnt;
+	__le32 rx_mu_ru_bw_ar[7];
+	__le32 rx_trig_for_us_cnt;
+	__le32 rx_trig_not_for_us_cnt;
+	__le32 rx_trig_with_cs_req_cnt;
+	__le32 rx_trig_type_ar[8 + 1];
+	__le32 rx_trig_in_agg_cnt;
+	__le32 rx_basic_trig_alloc_nss_ar[2];
+	__le32 rx_basic_trig_alloc_mu_mimo_cnt;
+	__le32 rx_basic_trig_alloc_ru_bw_ar[7];
+	__le32 rx_basic_trig_total_byte_cnt;
+	__le32 tx_trig_based_cs_req_fail_cnt;
+	__le32 tx_trig_based_sifs_ok_cnt;
+	__le32 tx_trig_based_sifs_fail_cnt;
+	__le32 tx_trig_based_byte_cnt;
+	__le32 tx_trig_based_pad_byte_cnt;
+	__le32 tx_trig_based_frame_cnt;
+	__le32 tx_trig_based_acked_frame_cnt;
+	__le32 tx_trig_based_ack_timeout_cnt;
+	__le32 tx_su_frame_cnt;
+	__le32 tx_edca_to_mu_edca_cnt;
+	__le32 tx_mu_edca_to_edca_by_timeout_cnt;
+	__le32 tx_mu_edca_to_edca_by_ack_fail_cnt;
+	__le32 tx_mu_edca_to_edca_by_small_alloc_cnt;
+	__le32 reserved;
+} __packed; /* STATISTICS_HE_NTFY_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_stats_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index fe555986d863..0059c83c2783 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -569,7 +569,8 @@ struct iwl_mvm_stat_data {
 	__le32 flags;
 	__le32 mac_id;
 	u8 beacon_filter_average_energy;
-	void *general;
+	__le32 *beacon_counter;
+	u8 *beacon_average_energy;
 };
 
 static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
@@ -589,23 +590,10 @@ static void iwl_mvm_stat_iterator(void *_data, u8 *mac,
 	 * data copied into the "data" struct, but rather the data from
 	 * the notification directly.
 	 */
-	if (iwl_mvm_has_new_rx_stats_api(mvm)) {
-		struct mvm_statistics_general *general =
-			data->general;
-
-		mvmvif->beacon_stats.num_beacons =
-			le32_to_cpu(general->beacon_counter[vif_id]);
-		mvmvif->beacon_stats.avg_signal =
-			-general->beacon_average_energy[vif_id];
-	} else {
-		struct mvm_statistics_general_v8 *general =
-			data->general;
-
-		mvmvif->beacon_stats.num_beacons =
-			le32_to_cpu(general->beacon_counter[vif_id]);
-		mvmvif->beacon_stats.avg_signal =
-			-general->beacon_average_energy[vif_id];
-	}
+	mvmvif->beacon_stats.num_beacons =
+		le32_to_cpu(data->beacon_counter[vif_id]);
+	mvmvif->beacon_stats.avg_signal =
+		-data->beacon_average_energy[vif_id];
 
 	/* make sure that beacon statistics don't go backwards with TCM
 	 * request to clear statistics
@@ -701,18 +689,136 @@ iwl_mvm_rx_stats_check_trigger(struct iwl_mvm *mvm, struct iwl_rx_packet *pkt)
 	iwl_fw_dbg_collect_trig(&mvm->fwrt, trig, NULL);
 }
 
+static void iwl_mvm_update_avg_energy(struct iwl_mvm *mvm,
+				      u8 energy[IWL_MVM_STATION_COUNT_MAX])
+{
+	int i;
+
+	if (WARN_ONCE(mvm->fw->ucode_capa.num_stations >
+		      IWL_MVM_STATION_COUNT_MAX,
+		      "Driver and FW station count mismatch %d\n",
+		      mvm->fw->ucode_capa.num_stations))
+		return;
+
+	rcu_read_lock();
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
+		struct iwl_mvm_sta *sta;
+
+		if (!energy[i])
+			continue;
+
+		sta = iwl_mvm_sta_from_staid_rcu(mvm, i);
+		if (!sta)
+			continue;
+		sta->avg_energy = energy[i];
+	}
+	rcu_read_unlock();
+}
+
+static void
+iwl_mvm_update_tcm_from_stats(struct iwl_mvm *mvm, __le32 *air_time_le,
+			      __le32 *rx_bytes_le)
+{
+	int i;
+
+	spin_lock(&mvm->tcm.lock);
+	for (i = 0; i < NUM_MAC_INDEX_DRIVER; i++) {
+		struct iwl_mvm_tcm_mac *mdata = &mvm->tcm.data[i];
+		u32 rx_bytes = le32_to_cpu(rx_bytes_le[i]);
+		u32 airtime = le32_to_cpu(air_time_le[i]);
+
+		mdata->rx.airtime += airtime;
+		mdata->uapsd_nonagg_detect.rx_bytes += rx_bytes;
+		if (airtime) {
+			/* re-init every time to store rate from FW */
+			ewma_rate_init(&mdata->uapsd_nonagg_detect.rate);
+			ewma_rate_add(&mdata->uapsd_nonagg_detect.rate,
+				      rx_bytes * 8 / airtime);
+		}
+	}
+	spin_unlock(&mvm->tcm.lock);
+}
+
+static void
+iwl_mvm_handle_rx_statistics_tlv(struct iwl_mvm *mvm,
+				 struct iwl_rx_packet *pkt)
+{
+	struct iwl_mvm_stat_data data = {
+		.mvm = mvm,
+	};
+	u8 beacon_average_energy[MAC_INDEX_AUX];
+	u8 average_energy[IWL_MVM_STATION_COUNT_MAX];
+	struct iwl_statistics_operational_ntfy *stats;
+	int expected_size;
+	__le32 flags;
+	int i;
+
+	expected_size = sizeof(*stats);
+	if (WARN_ONCE(iwl_rx_packet_payload_len(pkt) < expected_size,
+		      "received invalid statistics size (%d)!, expected_size: %d\n",
+		      iwl_rx_packet_payload_len(pkt), expected_size))
+		return;
+
+	stats = (void *)&pkt->data;
+
+	if (WARN_ONCE(stats->hdr.type != FW_STATISTICS_OPERATIONAL ||
+		      stats->hdr.version != 1,
+		      "received unsupported hdr type %d, version %d\n",
+		      stats->hdr.type, stats->hdr.version))
+		return;
+
+	flags = stats->flags;
+	mvm->radio_stats.rx_time = le64_to_cpu(stats->rx_time);
+	mvm->radio_stats.tx_time = le64_to_cpu(stats->tx_time);
+	mvm->radio_stats.on_time_rf = le64_to_cpu(stats->on_time_rf);
+	mvm->radio_stats.on_time_scan = le64_to_cpu(stats->on_time_scan);
+
+	iwl_mvm_rx_stats_check_trigger(mvm, pkt);
+
+	data.mac_id = stats->mac_id;
+	data.beacon_filter_average_energy =
+		le32_to_cpu(stats->beacon_filter_average_energy);
+	data.flags = flags;
+	data.beacon_counter = stats->beacon_counter;
+	for (i = 0; i < ARRAY_SIZE(beacon_average_energy); i++)
+		beacon_average_energy[i] =
+			le32_to_cpu(stats->beacon_average_energy[i]);
+
+	data.beacon_average_energy = beacon_average_energy;
+
+	ieee80211_iterate_active_interfaces(mvm->hw,
+					    IEEE80211_IFACE_ITER_NORMAL,
+					    iwl_mvm_stat_iterator,
+					    &data);
+
+	for (i = 0; i < ARRAY_SIZE(average_energy); i++)
+		average_energy[i] = le32_to_cpu(stats->average_energy[i]);
+	iwl_mvm_update_avg_energy(mvm, average_energy);
+
+	/*
+	 * Don't update in case the statistics are not cleared, since
+	 * we will end up counting twice the same airtime, once in TCM
+	 * request and once in statistics notification.
+	 */
+	if (le32_to_cpu(flags) & IWL_STATISTICS_REPLY_FLG_CLEAR)
+		iwl_mvm_update_tcm_from_stats(mvm, stats->air_time,
+					      stats->rx_bytes);
+}
+
 void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 				  struct iwl_rx_packet *pkt)
 {
 	struct iwl_mvm_stat_data data = {
 		.mvm = mvm,
 	};
+	__le32 *bytes, *air_time, flags;
 	int expected_size;
-	int i;
 	u8 *energy;
-	__le32 *bytes;
-	__le32 *air_time;
-	__le32 flags;
+
+	/* From ver 14 and up we use TLV statistics format */
+	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
+				    STATISTICS_CMD, 0) >= 14)
+		return iwl_mvm_handle_rx_statistics_tlv(mvm, pkt);
 
 	if (!iwl_mvm_has_new_rx_stats_api(mvm)) {
 		if (iwl_mvm_has_new_rx_api(mvm))
@@ -746,8 +852,9 @@ void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 		mvm->radio_stats.on_time_scan =
 			le64_to_cpu(stats->general.common.on_time_scan);
 
-		data.general = &stats->general;
-
+		data.beacon_counter = stats->general.beacon_counter;
+		data.beacon_average_energy =
+			stats->general.beacon_average_energy;
 		flags = stats->flag;
 	} else {
 		struct iwl_notif_statistics *stats = (void *)&pkt->data;
@@ -767,8 +874,9 @@ void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 		mvm->radio_stats.on_time_scan =
 			le64_to_cpu(stats->general.common.on_time_scan);
 
-		data.general = &stats->general;
-
+		data.beacon_counter = stats->general.beacon_counter;
+		data.beacon_average_energy =
+			stats->general.beacon_average_energy;
 		flags = stats->flag;
 	}
 	data.flags = flags;
@@ -797,45 +905,16 @@ void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 		air_time = (void *)&stats->load_stats.air_time;
 	}
 
-	rcu_read_lock();
-	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
-		struct iwl_mvm_sta *sta;
-
-		if (!energy[i])
-			continue;
-
-		sta = iwl_mvm_sta_from_staid_rcu(mvm, i);
-		if (!sta)
-			continue;
-		sta->avg_energy = energy[i];
-	}
-	rcu_read_unlock();
+	iwl_mvm_update_avg_energy(mvm, energy);
 
 	/*
 	 * Don't update in case the statistics are not cleared, since
 	 * we will end up counting twice the same airtime, once in TCM
 	 * request and once in statistics notification.
 	 */
-	if (!(le32_to_cpu(flags) & IWL_STATISTICS_REPLY_FLG_CLEAR))
-		return;
+	if (le32_to_cpu(flags) & IWL_STATISTICS_REPLY_FLG_CLEAR)
+		iwl_mvm_update_tcm_from_stats(mvm, air_time, bytes);
 
-	spin_lock(&mvm->tcm.lock);
-	for (i = 0; i < NUM_MAC_INDEX_DRIVER; i++) {
-		struct iwl_mvm_tcm_mac *mdata = &mvm->tcm.data[i];
-		u32 airtime = le32_to_cpu(air_time[i]);
-		u32 rx_bytes = le32_to_cpu(bytes[i]);
-
-		mdata->uapsd_nonagg_detect.rx_bytes += rx_bytes;
-		if (airtime) {
-			/* re-init every time to store rate from FW */
-			ewma_rate_init(&mdata->uapsd_nonagg_detect.rate);
-			ewma_rate_add(&mdata->uapsd_nonagg_detect.rate,
-				      rx_bytes * 8 / airtime);
-		}
-
-		mdata->rx.airtime += airtime;
-	}
-	spin_unlock(&mvm->tcm.lock);
 }
 
 void iwl_mvm_rx_statistics(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
-- 
2.28.0

