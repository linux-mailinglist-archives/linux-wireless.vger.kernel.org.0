Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87688729CB9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbjFIOZM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbjFIOYu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C184530F2
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3612616E0
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8208AC433EF;
        Fri,  9 Jun 2023 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320688;
        bh=CC91WB83wgkBbrPA1NezyIA1tJgUAXQBAga1loXIoDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Is8IOz3RkhwiSCIqtYNF//QYu9D6l5PiYj7QbwZwmbK2yd8LYe9c2Ne7mzCrZCrPd
         oo/vSkX1Tn0efrcQGf5or4X87ehmIbUk70gVXUVqbInCut8JpU3k3AyDtqtZz+FFPh
         RAgBH7JS3KJPXfSuYWHgr2nixR+qw/4k+HC/GCMdBSCFWG66SL+DebleKR32RvHAbl
         Pa1hx8h1HicI6tpUWzYc2LwEa3sN8jJNGxeXgD45/OrkCyyNhnOQdghTN9CU1Qa4Kp
         MkgXRFSIiOlTFCFzeQv95YJfXH1JEUcwjDRZXa3J83zbQ5z2s9R/OlJChVITJEvRIq
         /PB8q8/GfgElw==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 04/15] wifi: ath11k: add WMI event debug messages
Date:   Fri,  9 Jun 2023 17:24:29 +0300
Message-Id: <20230609142440.24643-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609142440.24643-1-kvalo@kernel.org>
References: <20230609142440.24643-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Add a debug message for every WMI event to make it easier track what's
happening in WMI. For better readability start every debug message with
"event".

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 72 ++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 12a9e220df52..99beb7636835 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -606,6 +606,8 @@ static int ath11k_service_ready_event(struct ath11k_base *ab, struct sk_buff *sk
 		return ret;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event service ready");
+
 	return 0;
 }
 
@@ -3866,6 +3868,8 @@ ath11k_wmi_obss_color_collision_event(struct ath11k_base *ab, struct sk_buff *sk
 		return;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event obss color collision");
+
 	rcu_read_lock();
 
 	ev = tb[WMI_TAG_OBSS_COLOR_COLLISION_EVT];
@@ -4458,6 +4462,8 @@ static void ath11k_wmi_pdev_dma_ring_buf_release_event(struct ath11k_base *ab,
 		return;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event pdev dma ring buf release");
+
 	param.fixed		= parse.fixed;
 	param.buf_entry		= parse.buf_entry;
 	param.num_buf_entry	= parse.num_buf_entry;
@@ -4852,6 +4858,8 @@ static int ath11k_service_ready_ext_event(struct ath11k_base *ab,
 		goto err;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event service ready ext");
+
 	if (!test_bit(WMI_TLV_SERVICE_EXT2_MSG, ab->wmi_ab.svc_map))
 		complete(&ab->wmi_ab.service_ready);
 
@@ -4902,6 +4910,8 @@ static int ath11k_service_ready_ext2_event(struct ath11k_base *ab,
 		goto err;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event service ready ext2");
+
 	complete(&ab->wmi_ab.service_ready);
 
 	return 0;
@@ -6927,7 +6937,7 @@ static int ath11k_reg_11d_new_cc_event(struct ath11k_base *ab, struct sk_buff *s
 	memcpy(&ab->new_alpha2, &ev->new_alpha2, 2);
 	spin_unlock_bh(&ab->base_lock);
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "11d new cc %c%c\n",
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event 11d new cc %c%c\n",
 		   ab->new_alpha2[0],
 		   ab->new_alpha2[1]);
 
@@ -7011,6 +7021,8 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 		goto fallback;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg chan list id %d", id);
+
 	if (reg_info->status_code != REG_SET_CC_STATUS_PASS) {
 		/* In case of failure to set the requested ctry,
 		 * fw retains the current regd. We print a failure info
@@ -7176,6 +7188,8 @@ static int ath11k_ready_event(struct ath11k_base *ab, struct sk_buff *skb)
 		return ret;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event ready");
+
 	complete(&ab->wmi_ab.unified_ready);
 	return 0;
 }
@@ -7190,6 +7204,8 @@ static void ath11k_peer_delete_resp_event(struct ath11k_base *ab, struct sk_buff
 		return;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event peer delete resp");
+
 	rcu_read_lock();
 	ar = ath11k_mac_get_ar_by_vdev_id(ab, peer_del_resp.vdev_id);
 	if (!ar) {
@@ -7229,7 +7245,7 @@ static void ath11k_vdev_delete_resp_event(struct ath11k_base *ab,
 
 	rcu_read_unlock();
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "vdev delete resp for vdev id %d\n",
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event vdev delete resp for vdev id %d\n",
 		   vdev_id);
 }
 
@@ -7260,6 +7276,8 @@ static void ath11k_vdev_start_resp_event(struct ath11k_base *ab, struct sk_buff
 		return;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event start resp event");
+
 	rcu_read_lock();
 	ar = ath11k_mac_get_ar_by_vdev_id(ab, vdev_start_resp.vdev_id);
 	if (!ar) {
@@ -7298,6 +7316,8 @@ static void ath11k_bcn_tx_status_event(struct ath11k_base *ab, struct sk_buff *s
 		return;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event offload bcn tx status");
+
 	rcu_read_lock();
 	arvif = ath11k_mac_get_arvif_by_vdev_id(ab, vdev_id);
 	if (!arvif) {
@@ -7337,7 +7357,7 @@ static void ath11k_wmi_event_peer_sta_ps_state_chg(struct ath11k_base *ab,
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "peer sta ps change ev addr %pM state %u sup_bitmap %x ps_valid %u ts %u\n",
+		   "event peer sta ps change ev addr %pM state %u sup_bitmap %x ps_valid %u ts %u\n",
 		   ev->peer_macaddr.addr, ev->peer_ps_state,
 		   ev->ps_supported_bitmap, ev->peer_ps_valid,
 		   ev->peer_ps_timestamp);
@@ -7421,6 +7441,8 @@ static void ath11k_vdev_stopped_event(struct ath11k_base *ab, struct sk_buff *sk
 		return;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event vdev stopped");
+
 	rcu_read_lock();
 	ar = ath11k_mac_get_ar_by_vdev_id(ab, vdev_id);
 	if (!ar) {
@@ -7454,7 +7476,7 @@ static void ath11k_mgmt_rx_event(struct ath11k_base *ab, struct sk_buff *skb)
 
 	memset(status, 0, sizeof(*status));
 
-	ath11k_dbg(ab, ATH11K_DBG_MGMT, "mgmt rx event status %08x\n",
+	ath11k_dbg(ab, ATH11K_DBG_MGMT, "event mgmt rx status %08x\n",
 		   rx_ev.status);
 
 	rcu_read_lock();
@@ -7573,7 +7595,7 @@ static void ath11k_mgmt_tx_compl_event(struct ath11k_base *ab, struct sk_buff *s
 	wmi_process_mgmt_tx_comp(ar, &tx_compl_param);
 
 	ath11k_dbg(ab, ATH11K_DBG_MGMT,
-		   "mgmt tx compl ev pdev_id %d, desc_id %d, status %d ack_rssi %d",
+		   "event mgmt tx compl ev pdev_id %d, desc_id %d, status %d ack_rssi %d",
 		   tx_compl_param.pdev_id, tx_compl_param.desc_id,
 		   tx_compl_param.status, tx_compl_param.ack_rssi);
 
@@ -7644,7 +7666,7 @@ static void ath11k_scan_event(struct ath11k_base *ab, struct sk_buff *skb)
 	spin_lock_bh(&ar->data_lock);
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "scan event %s type %d reason %d freq %d req_id %d scan_id %d vdev_id %d state %s (%d)\n",
+		   "event scan %s type %d reason %d freq %d req_id %d scan_id %d vdev_id %d state %s (%d)\n",
 		   ath11k_wmi_event_scan_type_str(scan_ev.event_type, scan_ev.reason),
 		   scan_ev.event_type, scan_ev.reason, scan_ev.channel_freq,
 		   scan_ev.scan_req_id, scan_ev.scan_id, scan_ev.vdev_id,
@@ -7727,7 +7749,7 @@ static void ath11k_peer_sta_kickout_event(struct ath11k_base *ab, struct sk_buff
 		goto exit;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "peer sta kickout event %pM",
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event peer sta kickout %pM",
 		   arg.mac_addr);
 
 	ieee80211_report_low_ack(sta, 10);
@@ -7747,7 +7769,7 @@ static void ath11k_roam_event(struct ath11k_base *ab, struct sk_buff *skb)
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "roam event vdev %u reason 0x%08x rssi %d\n",
+		   "event roam vdev %u reason 0x%08x rssi %d\n",
 		   roam_ev.vdev_id, roam_ev.reason, roam_ev.rssi);
 
 	rcu_read_lock();
@@ -7794,7 +7816,7 @@ static void ath11k_chan_info_event(struct ath11k_base *ab, struct sk_buff *skb)
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "chan info vdev_id %d err_code %d freq %d cmd_flags %d noise_floor %d rx_clear_count %d cycle_count %d mac_clk_mhz %d\n",
+		   "event chan info vdev_id %d err_code %d freq %d cmd_flags %d noise_floor %d rx_clear_count %d cycle_count %d mac_clk_mhz %d\n",
 		   ch_info_ev.vdev_id, ch_info_ev.err_code, ch_info_ev.freq,
 		   ch_info_ev.cmd_flags, ch_info_ev.noise_floor,
 		   ch_info_ev.rx_clear_count, ch_info_ev.cycle_count,
@@ -7883,7 +7905,7 @@ ath11k_pdev_bss_chan_info_event(struct ath11k_base *ab, struct sk_buff *skb)
 			bss_ch_info_ev.rx_bss_cycle_count_low;
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "pdev bss chan info:\n pdev_id: %d freq: %d noise: %d cycle: busy %llu total %llu tx %llu rx %llu rx_bss %llu\n",
+		   "event pdev bss chan info:\n pdev_id: %d freq: %d noise: %d cycle: busy %llu total %llu tx %llu rx %llu rx_bss %llu\n",
 		   bss_ch_info_ev.pdev_id, bss_ch_info_ev.freq,
 		   bss_ch_info_ev.noise_floor, busy, total,
 		   tx, rx, rx_bss);
@@ -7937,7 +7959,7 @@ static void ath11k_vdev_install_key_compl_event(struct ath11k_base *ab,
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "vdev install key ev idx %d flags %08x macaddr %pM status %d\n",
+		   "event vdev install key ev idx %d flags %08x macaddr %pM status %d\n",
 		   install_key_compl.key_idx, install_key_compl.key_flags,
 		   install_key_compl.macaddr, install_key_compl.status);
 
@@ -8020,6 +8042,8 @@ static void ath11k_service_available_event(struct ath11k_base *ab, struct sk_buf
 				  NULL);
 	if (ret)
 		ath11k_warn(ab, "failed to parse services available tlv %d\n", ret);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event service available");
 }
 
 static void ath11k_peer_assoc_conf_event(struct ath11k_base *ab, struct sk_buff *skb)
@@ -8033,7 +8057,7 @@ static void ath11k_peer_assoc_conf_event(struct ath11k_base *ab, struct sk_buff
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "peer assoc conf ev vdev id %d macaddr %pM\n",
+		   "event peer assoc conf ev vdev id %d macaddr %pM\n",
 		   peer_assoc_conf.vdev_id, peer_assoc_conf.macaddr);
 
 	rcu_read_lock();
@@ -8066,6 +8090,8 @@ static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *sk
 		goto free;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event update stats");
+
 	rcu_read_lock();
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, stats.pdev_id);
 	if (!ar) {
@@ -8126,7 +8152,7 @@ static void ath11k_pdev_ctl_failsafe_check_event(struct ath11k_base *ab,
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "pdev ctl failsafe check ev status %d\n",
+		   "event pdev ctl failsafe check status %d\n",
 		   ev->ctl_failsafe_status);
 
 	/* If ctl_failsafe_status is set to 1 FW will max out the Transmit power
@@ -8193,7 +8219,7 @@ ath11k_wmi_pdev_csa_switch_count_status_event(struct ath11k_base *ab,
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "pdev csa switch count %d for pdev %d, num_vdevs %d",
+		   "event pdev csa switch count %d for pdev %d, num_vdevs %d",
 		   ev->current_switch_count, ev->pdev_id,
 		   ev->num_vdevs);
 
@@ -8226,7 +8252,7 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "pdev dfs radar detected on pdev %d, detection mode %d, chan freq %d, chan_width %d, detector id %d, seg id %d, timestamp %d, chirp %d, freq offset %d, sidx %d",
+		   "event pdev dfs radar detected on pdev %d, detection mode %d, chan freq %d, chan_width %d, detector id %d, seg id %d, timestamp %d, chirp %d, freq offset %d, sidx %d",
 		   ev->pdev_id, ev->detection_mode, ev->chan_freq, ev->chan_width,
 		   ev->detector_id, ev->segment_id, ev->timestamp, ev->is_chirp,
 		   ev->freq_offset, ev->sidx);
@@ -8274,8 +8300,8 @@ ath11k_wmi_pdev_temperature_event(struct ath11k_base *ab,
 		return;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "pdev temperature ev temp %d pdev_id %d\n", ev->temp, ev->pdev_id);
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event pdev temperature ev temp %d pdev_id %d\n",
+		   ev->temp, ev->pdev_id);
 
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
 	if (!ar) {
@@ -8305,6 +8331,8 @@ static void ath11k_fils_discovery_event(struct ath11k_base *ab,
 		return;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event fils discovery");
+
 	ev = tb[WMI_TAG_HOST_SWFDA_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch FILS discovery event\n");
@@ -8335,6 +8363,8 @@ static void ath11k_probe_resp_tx_status_event(struct ath11k_base *ab,
 		return;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event probe resp tx status");
+
 	ev = tb[WMI_TAG_OFFLOAD_PRB_RSP_TX_STATUS_EVENT];
 	if (!ev) {
 		ath11k_warn(ab,
@@ -8401,6 +8431,8 @@ static void ath11k_wmi_event_wow_wakeup_host(struct ath11k_base *ab, struct sk_b
 		return;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event wow wakeup host");
+
 	complete(&ab->wow.wakeup_completed);
 }
 
@@ -8408,6 +8440,8 @@ static void
 ath11k_wmi_diag_event(struct ath11k_base *ab,
 		      struct sk_buff *skb)
 {
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event diag");
+
 	trace_ath11k_wmi_diag(ab, skb->data, skb->len);
 }
 
@@ -8455,6 +8489,8 @@ static void ath11k_wmi_twt_add_dialog_event(struct ath11k_base *ab,
 		return;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event twt add dialog");
+
 	ev = tb[WMI_TAG_TWT_ADD_DIALOG_COMPLETE_EVENT];
 	if (!ev) {
 		ath11k_warn(ab, "failed to fetch twt add dialog wmi event\n");
@@ -8503,7 +8539,7 @@ static void ath11k_wmi_gtk_offload_status_event(struct ath11k_base *ab,
 		return;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "gtk offload event refresh_cnt %d\n",
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event gtk offload refresh_cnt %d\n",
 		   ev->refresh_cnt);
 	ath11k_dbg_dump(ab, ATH11K_DBG_WMI, "replay_cnt",
 			NULL, ev->replay_ctr.counter, GTK_REPLAY_COUNTER_BYTES);
-- 
2.30.2

