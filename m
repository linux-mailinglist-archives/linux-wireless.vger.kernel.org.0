Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D86729CC0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbjFIOZQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbjFIOYx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A6C30F5
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CA1E615D1
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297DAC433D2;
        Fri,  9 Jun 2023 14:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320687;
        bh=HxWkpeagfcEe4JHhJJ39Ez02SU9UonVKjw3dqC00oHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0/A/jmiEdDruHnjgqg/5k30yE/Tf20dL1jc5QW+gkcffTrj9gE26tRtmHr/DOdqB
         S9V7EtDpQY8NTyAvSTmvvRcEDy5P3cdw7YLtcAv+I/bmsg1xSReA4oI5iUqiifDz0R
         p5hJ8+c1ncPruHtXzm7xFfg2r69VN5HDw2P1XOq77zFcmxU4LvLAINTUBdzdMmiyLc
         HqtOSO2AUo7DHnh9V5XG4+GYnnWORY7+kWUrprut0OvcFhj6rcVOgg54JrXXLLmz5g
         oabhIQv2JK2Yw866U5S++iz/beoV96eONChDQHlDDSM1/cpmmVVFv7skQdUarkwR84
         QuMqtE6K+txeQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 03/15] wifi: ath11k: remove manual mask names from debug messages
Date:   Fri,  9 Jun 2023 17:24:28 +0300
Message-Id: <20230609142440.24643-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609142440.24643-1-kvalo@kernel.org>
References: <20230609142440.24643-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Now that the previous patch changed ath11k_dbg() to print the debug level
there's no need to have the level in the actual message anymore. So remove those.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c   |   4 +-
 drivers/net/wireless/ath/ath11k/core.c  |  14 +--
 drivers/net/wireless/ath/ath11k/dp_rx.c |   2 +-
 drivers/net/wireless/ath/ath11k/hal.c   |   2 +-
 drivers/net/wireless/ath/ath11k/htc.c   |  20 ++--
 drivers/net/wireless/ath/ath11k/mac.c   | 110 +++++++++----------
 drivers/net/wireless/ath/ath11k/mhi.c   |   2 +-
 drivers/net/wireless/ath/ath11k/pci.c   |  12 +--
 drivers/net/wireless/ath/ath11k/peer.c  |   4 +-
 drivers/net/wireless/ath/ath11k/qmi.c   |  58 +++++-----
 drivers/net/wireless/ath/ath11k/reg.c   |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.c   | 136 ++++++++++++------------
 12 files changed, 184 insertions(+), 184 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 32911fa6e505..ddd27e05ede4 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -734,7 +734,7 @@ static int ath11k_ahb_hif_suspend(struct ath11k_base *ab)
 		return ret;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_AHB, "ahb device suspended\n");
+	ath11k_dbg(ab, ATH11K_DBG_AHB, "device suspended\n");
 
 	return ret;
 }
@@ -777,7 +777,7 @@ static int ath11k_ahb_hif_resume(struct ath11k_base *ab)
 		return -ETIMEDOUT;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_AHB, "ahb device resumed\n");
+	ath11k_dbg(ab, ATH11K_DBG_AHB, "device resumed\n");
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 8a82a4ed0af5..147395e622b9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -878,16 +878,16 @@ static void ath11k_core_check_cc_code_bdfext(const struct dmi_header *hdr, void
 	case ATH11K_SMBIOS_CC_ISO:
 		ab->new_alpha2[0] = (smbios->cc_code >> 8) & 0xff;
 		ab->new_alpha2[1] = smbios->cc_code & 0xff;
-		ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot smbios cc_code %c%c\n",
+		ath11k_dbg(ab, ATH11K_DBG_BOOT, "smbios cc_code %c%c\n",
 			   ab->new_alpha2[0], ab->new_alpha2[1]);
 		break;
 	case ATH11K_SMBIOS_CC_WW:
 		ab->new_alpha2[0] = '0';
 		ab->new_alpha2[1] = '0';
-		ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot smbios worldwide regdomain\n");
+		ath11k_dbg(ab, ATH11K_DBG_BOOT, "smbios worldwide regdomain\n");
 		break;
 	default:
-		ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot ignore smbios country code setting %d\n",
+		ath11k_dbg(ab, ATH11K_DBG_BOOT, "ignore smbios country code setting %d\n",
 			   smbios->country_code_flag);
 		break;
 	}
@@ -1001,7 +1001,7 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 		break;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot using board name '%s'\n", name);
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "using board name '%s'\n", name);
 
 	return 0;
 }
@@ -1040,7 +1040,7 @@ const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 	if (ret)
 		return ERR_PTR(ret);
 
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot firmware request %s size %zu\n",
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "firmware request %s size %zu\n",
 		   path, fw->size);
 
 	return fw;
@@ -1101,7 +1101,7 @@ static int ath11k_core_parse_bd_ie_board(struct ath11k_base *ab,
 
 			name_match_found = true;
 			ath11k_dbg(ab, ATH11K_DBG_BOOT,
-				   "boot found match %s for name '%s'",
+				   "found match %s for name '%s'",
 				   ath11k_bd_ie_type_str(ie_id),
 				   boardname);
 		} else if (board_ie_id == data_id) {
@@ -1110,7 +1110,7 @@ static int ath11k_core_parse_bd_ie_board(struct ath11k_base *ab,
 				goto next;
 
 			ath11k_dbg(ab, ATH11K_DBG_BOOT,
-				   "boot found %s for '%s'",
+				   "found %s for '%s'",
 				   ath11k_bd_ie_type_str(ie_id),
 				   boardname);
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index f67ce62b2b48..0ed3d2580e91 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1651,7 +1651,7 @@ static void ath11k_htt_backpressure_event_handler(struct ath11k_base *ab,
 
 	backpressure_time = *data;
 
-	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "htt backpressure event, pdev %d, ring type %d,ring id %d, hp %d tp %d, backpressure time %d\n",
+	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "backpressure event, pdev %d, ring type %d,ring id %d, hp %d tp %d, backpressure time %d\n",
 		   pdev_id, ring_type, ring_id, hp, tp, backpressure_time);
 
 	if (ring_type == HTT_BACKPRESSURE_UMAC_RING_TYPE) {
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 22422237500c..2cdc8478d253 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1010,7 +1010,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 				(u32 *)((unsigned long)ab->mem + reg_base);
 			else
 				ath11k_dbg(ab, ATH11k_DBG_HAL,
-					   "hal type %d ring_num %d reg_base 0x%x shadow 0x%lx\n",
+					   "type %d ring_num %d reg_base 0x%x shadow 0x%lx\n",
 					   type, ring_num,
 					   reg_base,
 					   (unsigned long)srng->u.src_ring.hp_addr -
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index ca3aedc0252d..7d277cd60b07 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -96,7 +96,7 @@ int ath11k_htc_send(struct ath11k_htc *htc,
 		spin_lock_bh(&htc->tx_lock);
 		if (ep->tx_credits < credits) {
 			ath11k_dbg(ab, ATH11K_DBG_HTC,
-				   "htc insufficient credits ep %d required %d available %d\n",
+				   "insufficient credits ep %d required %d available %d\n",
 				   eid, credits, ep->tx_credits);
 			spin_unlock_bh(&htc->tx_lock);
 			ret = -EAGAIN;
@@ -104,7 +104,7 @@ int ath11k_htc_send(struct ath11k_htc *htc,
 		}
 		ep->tx_credits -= credits;
 		ath11k_dbg(ab, ATH11K_DBG_HTC,
-			   "htc ep %d consumed %d credits (total %d)\n",
+			   "ep %d consumed %d credits (total %d)\n",
 			   eid, credits, ep->tx_credits);
 		spin_unlock_bh(&htc->tx_lock);
 	}
@@ -132,7 +132,7 @@ int ath11k_htc_send(struct ath11k_htc *htc,
 		spin_lock_bh(&htc->tx_lock);
 		ep->tx_credits += credits;
 		ath11k_dbg(ab, ATH11K_DBG_HTC,
-			   "htc ep %d reverted %d credits back (total %d)\n",
+			   "ep %d reverted %d credits back (total %d)\n",
 			   eid, credits, ep->tx_credits);
 		spin_unlock_bh(&htc->tx_lock);
 
@@ -167,7 +167,7 @@ ath11k_htc_process_credit_report(struct ath11k_htc *htc,
 		ep = &htc->endpoint[report->eid];
 		ep->tx_credits += report->credits;
 
-		ath11k_dbg(ab, ATH11K_DBG_HTC, "htc ep %d got %d credits (total %d)\n",
+		ath11k_dbg(ab, ATH11K_DBG_HTC, "ep %d got %d credits (total %d)\n",
 			   report->eid, report->credits, ep->tx_credits);
 
 		if (ep->ep_ops.ep_tx_credits) {
@@ -239,7 +239,7 @@ static int ath11k_htc_process_trailer(struct ath11k_htc *htc,
 
 static void ath11k_htc_suspend_complete(struct ath11k_base *ab, bool ack)
 {
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot suspend complete %d\n", ack);
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "suspend complete %d\n", ack);
 
 	if (ack)
 		set_bit(ATH11K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags);
@@ -276,7 +276,7 @@ void ath11k_htc_tx_completion_handler(struct ath11k_base *ab,
 
 static void ath11k_htc_wakeup_from_suspend(struct ath11k_base *ab)
 {
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot wakeup from suspend is received\n");
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "wakeup from suspend is received\n");
 }
 
 void ath11k_htc_rx_completion_handler(struct ath11k_base *ab,
@@ -393,7 +393,7 @@ void ath11k_htc_rx_completion_handler(struct ath11k_base *ab,
 		goto out;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_HTC, "htc rx completion ep %d skb %pK\n",
+	ath11k_dbg(ab, ATH11K_DBG_HTC, "rx completion ep %d skb %pK\n",
 		   eid, skb);
 	ep->ep_ops.ep_rx_complete(ab, skb);
 
@@ -615,7 +615,7 @@ int ath11k_htc_connect_service(struct ath11k_htc *htc,
 						    conn_req->service_id);
 	if (!tx_alloc)
 		ath11k_dbg(ab, ATH11K_DBG_BOOT,
-			   "boot htc service %s does not allocate target credits\n",
+			   "htc service %s does not allocate target credits\n",
 			   htc_service_name(conn_req->service_id));
 
 	skb = ath11k_htc_build_tx_ctrl_skb(htc->ab);
@@ -740,14 +740,14 @@ int ath11k_htc_connect_service(struct ath11k_htc *htc,
 		return status;
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT,
-		   "boot htc service '%s' ul pipe %d dl pipe %d eid %d ready\n",
+		   "htc service '%s' ul pipe %d dl pipe %d eid %d ready\n",
 		   htc_service_name(ep->service_id), ep->ul_pipe_id,
 		   ep->dl_pipe_id, ep->eid);
 
 	if (disable_credit_flow_ctrl && ep->tx_credit_flow_enabled) {
 		ep->tx_credit_flow_enabled = false;
 		ath11k_dbg(ab, ATH11K_DBG_BOOT,
-			   "boot htc service '%s' eid %d TX flow control disabled\n",
+			   "htc service '%s' eid %d TX flow control disabled\n",
 			   htc_service_name(ep->service_id), assigned_eid);
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a31b8e89684b..1bb2a88fecb2 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -818,7 +818,7 @@ static int ath11k_recalc_rtscts_prot(struct ath11k_vif *arvif)
 
 	arvif->rtscts_prot_mode = rts_cts;
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev %d recalc rts/cts prot %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev %d recalc rts/cts prot %d\n",
 		   arvif->vdev_id, rts_cts);
 
 	ret =  ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
@@ -974,7 +974,7 @@ static int ath11k_mac_monitor_vdev_start(struct ath11k *ar, int vdev_id,
 		goto vdev_stop;
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %i started\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "monitor vdev %i started\n",
 		   vdev_id);
 
 	return 0;
@@ -1028,7 +1028,7 @@ static int ath11k_mac_monitor_vdev_stop(struct ath11k *ar)
 		return ret;
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %i stopped\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "monitor vdev %i stopped\n",
 		   ar->monitor_vdev_id);
 
 	return 0;
@@ -1099,7 +1099,7 @@ static int ath11k_mac_monitor_vdev_create(struct ath11k *ar)
 	ar->num_created_vdevs++;
 	set_bit(ATH11K_FLAG_MONITOR_VDEV_CREATED, &ar->monitor_flags);
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %d created\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "monitor vdev %d created\n",
 		   ar->monitor_vdev_id);
 
 	return 0;
@@ -1134,7 +1134,7 @@ static int ath11k_mac_monitor_vdev_delete(struct ath11k *ar)
 	if (time_left == 0) {
 		ath11k_warn(ar->ab, "Timeout in receiving vdev delete response\n");
 	} else {
-		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %d deleted\n",
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "monitor vdev %d deleted\n",
 			   ar->monitor_vdev_id);
 
 		ar->allocated_vdev_map &= ~(1LL << ar->monitor_vdev_id);
@@ -1180,7 +1180,7 @@ static int ath11k_mac_monitor_start(struct ath11k *ar)
 		return ret;
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor started\n");
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "monitor started\n");
 
 	return 0;
 }
@@ -1210,7 +1210,7 @@ static int ath11k_mac_monitor_stop(struct ath11k *ar)
 		return ret;
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor stopped ret %d\n", ret);
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "monitor stopped ret %d\n", ret);
 
 	return 0;
 }
@@ -1261,7 +1261,7 @@ static int ath11k_mac_vif_setup_ps(struct ath11k_vif *arvif)
 		psmode = WMI_STA_PS_MODE_DISABLED;
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev %d psmode %s\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev %d psmode %s\n",
 		   arvif->vdev_id, psmode ? "enable" : "disable");
 
 	ret = ath11k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
@@ -1641,7 +1641,7 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 
 	arvif->is_up = true;
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev %d up\n", arvif->vdev_id);
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev %d up\n", arvif->vdev_id);
 }
 
 static void ath11k_mac_handle_beacon_iter(void *data, u8 *mac,
@@ -1964,7 +1964,7 @@ static void ath11k_peer_assoc_h_ht(struct ath11k *ar,
 		arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac ht peer %pM mcs cnt %d nss %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "ht peer %pM mcs cnt %d nss %d\n",
 		   arg->peer_mac,
 		   arg->peer_ht_rates.num_rates,
 		   arg->peer_nss);
@@ -2128,7 +2128,7 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 	}
 
 	if (!user_rate_valid) {
-		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac setting vht range mcs value to peer supported nss %d for peer %pM\n",
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "setting vht range mcs value to peer supported nss %d for peer %pM\n",
 			   sta->deflink.rx_nss, sta->addr);
 		vht_mcs_mask[sta->deflink.rx_nss - 1] = vht_mcs_mask[vht_nss - 1];
 	}
@@ -2185,7 +2185,7 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac vht peer %pM max_mpdu %d flags 0x%x nss_override 0x%x\n",
+		   "vht peer %pM max_mpdu %d flags 0x%x nss_override 0x%x\n",
 		   sta->addr, arg->peer_max_mpdu, arg->peer_flags,
 		   arg->peer_bw_rxnss_override);
 }
@@ -2410,7 +2410,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	}
 
 	if (!user_rate_valid) {
-		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac setting he range mcs value to peer supported nss %d for peer %pM\n",
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "setting he range mcs value to peer supported nss %d for peer %pM\n",
 			   sta->deflink.rx_nss, sta->addr);
 		he_mcs_mask[sta->deflink.rx_nss - 1] = he_mcs_mask[he_nss - 1];
 	}
@@ -2491,7 +2491,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac he peer %pM nss %d mcs cnt %d nss_override 0x%x\n",
+		   "he peer %pM nss %d mcs cnt %d nss_override 0x%x\n",
 		   sta->addr, arg->peer_nss,
 		   arg->peer_he_mcs_count,
 		   arg->peer_bw_rxnss_override);
@@ -2611,7 +2611,7 @@ static void ath11k_peer_assoc_h_qos(struct ath11k *ar,
 		break;
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac peer %pM qos %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "peer %pM qos %d\n",
 		   sta->addr, arg->qos_flag);
 }
 
@@ -2628,7 +2628,7 @@ static int ath11k_peer_assoc_qos_ap(struct ath11k *ar,
 
 	params.vdev_id = arvif->vdev_id;
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac uapsd_queues 0x%x max_sp %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "uapsd_queues 0x%x max_sp %d\n",
 		   sta->uapsd_queues, sta->max_sp);
 
 	uapsd = 0;
@@ -2814,7 +2814,7 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
 		break;
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac peer %pM phymode %s\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "peer %pM phymode %s\n",
 		   sta->addr, ath11k_wmi_phymode_str(phymode));
 
 	arg->peer_phymode = phymode;
@@ -3005,7 +3005,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev %i assoc bssid %pM aid %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev %i assoc bssid %pM aid %d\n",
 		   arvif->vdev_id, arvif->bssid, arvif->aid);
 
 	rcu_read_lock();
@@ -3071,7 +3071,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	arvif->rekey_data.enable_offload = false;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac vdev %d up (associated) bssid %pM aid %d\n",
+		   "vdev %d up (associated) bssid %pM aid %d\n",
 		   arvif->vdev_id, bss_conf->bssid, vif->cfg.aid);
 
 	spin_lock_bh(&ar->ab->base_lock);
@@ -3116,7 +3116,7 @@ static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev %i disassoc bssid %pM\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev %i disassoc bssid %pM\n",
 		   arvif->vdev_id, arvif->bssid);
 
 	ret = ath11k_wmi_vdev_down(ar, arvif->vdev_id);
@@ -3265,7 +3265,7 @@ static int ath11k_mac_config_obss_pd(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac obss pd sr_ctrl %x non_srg_thres %u srg_max %u\n",
+		   "obss pd sr_ctrl %x non_srg_thres %u srg_max %u\n",
 		   he_obss_pd->sr_ctrl, he_obss_pd->non_srg_max_offset,
 		   he_obss_pd->max_offset);
 
@@ -3593,7 +3593,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_TXPOWER) {
-		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev_id %i txpower %d\n",
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev_id %i txpower %d\n",
 			   arvif->vdev_id, info->txpower);
 
 		arvif->txpower = info->txpower;
@@ -3634,7 +3634,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		rate = ATH11K_HW_RATE_CODE(hw_value, 0, preamble);
 
 		ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-			   "mac vdev %d mcast_rate %x\n",
+			   "vdev %d mcast_rate %x\n",
 			   arvif->vdev_id, rate);
 
 		vdev_param = WMI_VDEV_PARAM_MCAST_DATA_RATE;
@@ -3743,7 +3743,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		memcpy(arvif->arp_ns_offload.mac_addr, vif->addr, ETH_ALEN);
 		arvif->arp_ns_offload.ipv4_count = ipv4_cnt;
 
-		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac arp_addr_cnt %d vif->addr %pM, offload_addr %pI4\n",
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "arp_addr_cnt %d vif->addr %pM, offload_addr %pI4\n",
 			   vif->cfg.arp_addr_cnt,
 			   vif->addr, arvif->arp_ns_offload.ipv4_addr);
 	}
@@ -4465,7 +4465,7 @@ ath11k_mac_set_peer_he_fixed_rate(struct ath11k_vif *arvif,
 		return -EINVAL;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac setting fixed he rate for peer %pM, device will not switch to any other selected rates",
+		   "setting fixed he rate for peer %pM, device will not switch to any other selected rates",
 		   sta->addr);
 
 	rate_code = ATH11K_HW_RATE_CODE(he_rate, nss - 1,
@@ -4707,14 +4707,14 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 		ath11k_peer_assoc_h_phymode(ar, arvif->vif, sta, &peer_arg);
 		peer_phymode = peer_arg.peer_phymode;
 
-		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac update sta %pM peer bw %d phymode %d\n",
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "update sta %pM peer bw %d phymode %d\n",
 			   sta->addr, bw, peer_phymode);
 
 		if (bw > bw_prev) {
 			/* BW is upgraded. In this case we send WMI_PEER_PHYMODE
 			 * followed by WMI_PEER_CHWIDTH
 			 */
-			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac BW upgrade for sta %pM new BW %d, old BW %d\n",
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "BW upgrade for sta %pM new BW %d, old BW %d\n",
 				   sta->addr, bw, bw_prev);
 
 			err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
@@ -4736,7 +4736,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 			/* BW is downgraded. In this case we send WMI_PEER_CHWIDTH
 			 * followed by WMI_PEER_PHYMODE
 			 */
-			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac BW downgrade for sta %pM new BW %d,old BW %d\n",
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "BW downgrade for sta %pM new BW %d,old BW %d\n",
 				   sta->addr, bw, bw_prev);
 
 			err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
@@ -4758,7 +4758,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	}
 
 	if (changed & IEEE80211_RC_NSS_CHANGED) {
-		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac update sta %pM nss %d\n",
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "update sta %pM nss %d\n",
 			   sta->addr, nss);
 
 		err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
@@ -4769,7 +4769,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	}
 
 	if (changed & IEEE80211_RC_SMPS_CHANGED) {
-		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac update sta %pM smps %d\n",
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "update sta %pM smps %d\n",
 			   sta->addr, smps);
 
 		err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
@@ -5227,7 +5227,7 @@ static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->ab->base_lock);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac sta rc update for %pM changed %08x bw %d nss %d smps %d\n",
+		   "sta rc update for %pM changed %08x bw %d nss %d smps %d\n",
 		   sta->addr, changed, sta->deflink.bandwidth,
 		   sta->deflink.rx_nss,
 		   sta->deflink.smps_mode);
@@ -6038,7 +6038,7 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 	spin_unlock_bh(&ar->txmgmt_idr_lock);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac tx mgmt frame, buf id %d\n", buf_id);
+		   "tx mgmt frame, buf id %d\n", buf_id);
 
 	if (buf_id < 0)
 		return -ENOSPC;
@@ -6115,7 +6115,7 @@ static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 				ath11k_mgmt_over_wmi_tx_drop(ar, skb);
 			} else {
 				ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-					   "mac tx mgmt frame, vdev_id %d\n",
+					   "tx mgmt frame, vdev_id %d\n",
 					   arvif->vdev_id);
 			}
 		} else {
@@ -6587,7 +6587,7 @@ void ath11k_mac_11d_scan_start(struct ath11k *ar, u32 vdev_id)
 
 	mutex_lock(&ar->ab->vdev_id_11d_lock);
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev id for 11d scan %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "vdev id for 11d scan %d\n",
 		   ar->vdev_id_11d_scan);
 
 	if (ar->regdom_set_by_user)
@@ -6606,7 +6606,7 @@ void ath11k_mac_11d_scan_start(struct ath11k *ar, u32 vdev_id)
 	param.start_interval_msec = 0;
 	param.scan_period_msec = ATH11K_SCAN_11D_INTERVAL;
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac start 11d scan\n");
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "start 11d scan\n");
 
 	ret = ath11k_wmi_send_11d_scan_start_cmd(ar, &param);
 	if (ret) {
@@ -6635,11 +6635,11 @@ void ath11k_mac_11d_scan_stop(struct ath11k *ar)
 	if (!test_bit(WMI_TLV_SERVICE_11D_OFFLOAD, ar->ab->wmi_ab.svc_map))
 		return;
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac stop 11d scan\n");
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "stop 11d scan\n");
 
 	mutex_lock(&ar->ab->vdev_id_11d_lock);
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac stop 11d vdev id %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "stop 11d vdev id %d\n",
 		   ar->vdev_id_11d_scan);
 
 	if (ar->state_11d == ATH11K_11D_PREPARING) {
@@ -6670,7 +6670,7 @@ void ath11k_mac_11d_scan_stop_all(struct ath11k_base *ab)
 	struct ath11k_pdev *pdev;
 	int i;
 
-	ath11k_dbg(ab, ATH11K_DBG_MAC, "mac stop soc 11d scan\n");
+	ath11k_dbg(ab, ATH11K_DBG_MAC, "stop soc 11d scan\n");
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
@@ -6798,7 +6798,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		break;
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac add interface id %d type %d subtype %d map %llx\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "add interface id %d type %d subtype %d map %llx\n",
 		   arvif->vdev_id, arvif->vdev_type, arvif->vdev_subtype,
 		   ab->free_vdev_map);
 
@@ -6989,7 +6989,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&ar->conf_mutex);
 
-	ath11k_dbg(ab, ATH11K_DBG_MAC, "mac remove interface (vdev %d)\n",
+	ath11k_dbg(ab, ATH11K_DBG_MAC, "remove interface (vdev %d)\n",
 		   arvif->vdev_id);
 
 	ret = ath11k_spectral_vif_stop(arvif);
@@ -7144,7 +7144,7 @@ static int ath11k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_base *ab = ar->ab;
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "mac chanctx add freq %u width %d ptr %pK\n",
+		   "chanctx add freq %u width %d ptr %pK\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx);
 
 	mutex_lock(&ar->conf_mutex);
@@ -7168,7 +7168,7 @@ static void ath11k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_base *ab = ar->ab;
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "mac chanctx remove freq %u width %d ptr %pK\n",
+		   "chanctx remove freq %u width %d ptr %pK\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx);
 
 	mutex_lock(&ar->conf_mutex);
@@ -7248,7 +7248,7 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 	arg.channel.passive |= !!(chandef->chan->flags & IEEE80211_CHAN_NO_IR);
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "mac vdev %d start center_freq %d phymode %s\n",
+		   "vdev %d start center_freq %d phymode %s\n",
 		   arg.vdev_id, arg.channel.freq,
 		   ath11k_wmi_phymode_str(arg.channel.mode));
 
@@ -7522,7 +7522,7 @@ static void ath11k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "mac chanctx change freq %u width %d ptr %pK changed %x\n",
+		   "chanctx change freq %u width %d ptr %pK changed %x\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx, changed);
 
 	/* This shouldn't really happen because channel switching should use
@@ -7603,7 +7603,7 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "mac chanctx assign ptr %pK vdev_id %i\n",
+		   "chanctx assign ptr %pK vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
 	/* for QCA6390 bss peer must be created before vdev_start */
@@ -7693,7 +7693,7 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "mac chanctx unassign ptr %pK vdev_id %i\n",
+		   "chanctx unassign ptr %pK vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
 	WARN_ON(!arvif->is_started);
@@ -7737,7 +7737,7 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				    arvif->bssid, arvif->vdev_id, ret);
 		else
 			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-				   "mac removed peer %pM  vdev %d after vdev stop\n",
+				   "removed peer %pM  vdev %d after vdev stop\n",
 				   arvif->bssid, arvif->vdev_id);
 	}
 
@@ -7772,7 +7772,7 @@ ath11k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac chanctx switch n_vifs %d mode %d\n",
+		   "chanctx switch n_vifs %d mode %d\n",
 		   n_vifs, mode);
 	ath11k_mac_update_vif_chan(ar, vifs, n_vifs);
 
@@ -8104,7 +8104,7 @@ static int ath11k_mac_set_rate_params(struct ath11k_vif *arvif,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac set rate params vdev %i rate 0x%02x nss 0x%02x sgi 0x%02x ldpc 0x%02x he_gi 0x%02x he_ltf 0x%02x he_fixed_rate %d\n",
+		   "set rate params vdev %i rate 0x%02x nss 0x%02x sgi 0x%02x ldpc 0x%02x he_gi 0x%02x he_ltf 0x%02x he_fixed_rate %d\n",
 		   arvif->vdev_id, rate, nss, sgi, ldpc, he_gi,
 		   he_ltf, he_fixed_rate);
 
@@ -8609,7 +8609,7 @@ static void ath11k_mac_put_chain_rssi(struct station_info *sinfo,
 			arsta->chain_signal[i] = ATH11K_INVALID_RSSI_FULL;
 
 		ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-			   "mac sta statistics %s rssi[%d] %d\n", pre, i, rssi);
+			   "sta statistics %s rssi[%d] %d\n", pre, i, rssi);
 
 		if (rssi != ATH11K_DEFAULT_NOISE_FLOOR &&
 		    rssi != ATH11K_INVALID_RSSI_FULL &&
@@ -8673,7 +8673,7 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		signal = arsta->rssi_beacon;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac sta statistics db2dbm %u rssi comb %d rssi beacon %d\n",
+		   "sta statistics db2dbm %u rssi comb %d rssi beacon %d\n",
 		   db2dbm, arsta->rssi_comb, arsta->rssi_beacon);
 
 	if (signal) {
@@ -8720,7 +8720,7 @@ static void ath11k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
 	struct list_head *p;
 	u32 count, scope;
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac op ipv6 changed\n");
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "op ipv6 changed\n");
 
 	offload = &arvif->arp_ns_offload;
 	count = 0;
@@ -8745,7 +8745,7 @@ static void ath11k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
 			memcpy(offload->ipv6_addr[count], &ifa6->addr.s6_addr,
 			       sizeof(ifa6->addr.s6_addr));
 			offload->ipv6_type[count] = ATH11K_IPV6_UC_TYPE;
-			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac count %d ipv6 uc %pI6 scope %d\n",
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "count %d ipv6 uc %pI6 scope %d\n",
 				   count, offload->ipv6_addr[count],
 				   scope);
 			count++;
@@ -8765,7 +8765,7 @@ static void ath11k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
 			memcpy(offload->ipv6_addr[count], &ifaca6->aca_addr,
 			       sizeof(ifaca6->aca_addr));
 			offload->ipv6_type[count] = ATH11K_IPV6_AC_TYPE;
-			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac count %d ipv6 ac %pI6 scope %d\n",
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "count %d ipv6 ac %pI6 scope %d\n",
 				   count, offload->ipv6_addr[count],
 				   scope);
 			count++;
@@ -8791,7 +8791,7 @@ static void ath11k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_rekey_data *rekey_data = &arvif->rekey_data;
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac set rekey data vdev %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "set rekey data vdev %d\n",
 		   arvif->vdev_id);
 
 	mutex_lock(&ar->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index a62ee05c5409..d5f25e708bdc 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -325,7 +325,7 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 {
 	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
 
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "mhi notify status reason %s\n",
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
 		   ath11k_mhi_op_callback_to_str(cb));
 
 	switch (cb) {
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 5a779abe666b..75157e6be632 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -312,14 +312,14 @@ static void ath11k_pci_enable_ltssm(struct ath11k_base *ab)
 		val = ath11k_pcic_read32(ab, PCIE_PCIE_PARF_LTSSM);
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci ltssm 0x%x\n", val);
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "ltssm 0x%x\n", val);
 
 	val = ath11k_pcic_read32(ab, GCC_GCC_PCIE_HOT_RST);
 	val |= GCC_GCC_PCIE_HOT_RST_VAL;
 	ath11k_pcic_write32(ab, GCC_GCC_PCIE_HOT_RST, val);
 	val = ath11k_pcic_read32(ab, GCC_GCC_PCIE_HOT_RST);
 
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci pcie_hot_rst 0x%x\n", val);
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_hot_rst 0x%x\n", val);
 
 	mdelay(5);
 }
@@ -487,7 +487,7 @@ static int ath11k_pci_config_msi_data(struct ath11k_pci *ab_pci)
 
 	ab_pci->ab->pci.msi.ep_base_data = msi_desc->msg.data;
 
-	ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "pci after request_irq msi_ep_base_data %d\n",
+	ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "after request_irq msi_ep_base_data %d\n",
 		   ab_pci->ab->pci.msi.ep_base_data);
 
 	return 0;
@@ -545,7 +545,7 @@ static int ath11k_pci_claim(struct ath11k_pci *ab_pci, struct pci_dev *pdev)
 
 	ab->mem_ce = ab->mem;
 
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot pci_mem 0x%pK\n", ab->mem);
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pci_mem 0x%pK\n", ab->mem);
 	return 0;
 
 release_region:
@@ -575,7 +575,7 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 	pcie_capability_read_word(ab_pci->pdev, PCI_EXP_LNKCTL,
 				  &ab_pci->link_ctl);
 
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci link_ctl 0x%04x L0s %d L1 %d\n",
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "link_ctl 0x%04x L0s %d L1 %d\n",
 		   ab_pci->link_ctl,
 		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L0S),
 		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
@@ -709,7 +709,7 @@ static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *
 	*minor = FIELD_GET(TCSR_SOC_HW_VERSION_MINOR_MASK,
 			   soc_hw_version);
 
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci tcsr_soc_hw_version major %d minor %d\n",
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "tcsr_soc_hw_version major %d minor %d\n",
 		   *major, *minor);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 1380811827a8..114aa3a9a339 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -106,7 +106,7 @@ void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id)
 		goto exit;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "htt peer unmap vdev %d peer %pM id %d\n",
+	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "peer unmap vdev %d peer %pM id %d\n",
 		   peer->vdev_id, peer->addr, peer_id);
 
 	list_del(&peer->list);
@@ -138,7 +138,7 @@ void ath11k_peer_map_event(struct ath11k_base *ab, u8 vdev_id, u16 peer_id,
 		wake_up(&ab->peer_mapping_wq);
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "htt peer map vdev %d peer %pM id %d\n",
+	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "peer map vdev %d peer %pM id %d\n",
 		   vdev_id, mac_addr, peer_id);
 
 exit:
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index fa94ad828599..5da4c7663b45 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1755,7 +1755,7 @@ static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 
 	req.nm_modem |= PLATFORM_CAP_PCIE_PME_D3COLD;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi host cap request\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "host cap request\n");
 
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
@@ -1833,7 +1833,7 @@ static int ath11k_qmi_fw_ind_register_send(struct ath11k_base *ab)
 	if (ret < 0)
 		goto out;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi indication register request\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "indication register request\n");
 
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_IND_REGISTER_REQ_V01,
@@ -1889,7 +1889,7 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 	      test_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags)) &&
 	      ab->qmi.target_mem_delayed) {
 		delayed = true;
-		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi delays mem_request %d\n",
+		ath11k_dbg(ab, ATH11K_DBG_QMI, "delays mem_request %d\n",
 			   ab->qmi.mem_seg_count);
 		memset(req, 0, sizeof(*req));
 	} else {
@@ -1901,7 +1901,7 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 			req->mem_seg[i].size = ab->qmi.target_mem[i].size;
 			req->mem_seg[i].type = ab->qmi.target_mem[i].type;
 			ath11k_dbg(ab, ATH11K_DBG_QMI,
-				   "qmi req mem_seg[%d] %pad %u %u\n", i,
+				   "req mem_seg[%d] %pad %u %u\n", i,
 				    &ab->qmi.target_mem[i].paddr,
 				    ab->qmi.target_mem[i].size,
 				    ab->qmi.target_mem[i].type);
@@ -1913,7 +1913,7 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 	if (ret < 0)
 		goto out;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi respond memory request delayed %i\n",
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "respond memory request delayed %i\n",
 		   delayed);
 
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
@@ -2002,7 +2002,7 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 		if (!chunk->vaddr) {
 			if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
 				ath11k_dbg(ab, ATH11K_DBG_QMI,
-					   "qmi dma allocation failed (%d B type %u), will try later with small size\n",
+					   "dma allocation failed (%d B type %u), will try later with small size\n",
 					    chunk->size,
 					    chunk->type);
 				ath11k_qmi_free_target_mem_chunk(ab);
@@ -2036,7 +2036,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			hremote_node = of_parse_phandle(dev->of_node, "memory-region", 0);
 			if (!hremote_node) {
 				ath11k_dbg(ab, ATH11K_DBG_QMI,
-					   "qmi fail to get hremote_node\n");
+					   "fail to get hremote_node\n");
 				return -ENODEV;
 			}
 
@@ -2044,13 +2044,13 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			of_node_put(hremote_node);
 			if (ret) {
 				ath11k_dbg(ab, ATH11K_DBG_QMI,
-					   "qmi fail to get reg from hremote\n");
+					   "fail to get reg from hremote\n");
 				return ret;
 			}
 
 			if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
 				ath11k_dbg(ab, ATH11K_DBG_QMI,
-					   "qmi fail to assign memory of sz\n");
+					   "fail to assign memory of sz\n");
 				return -EINVAL;
 			}
 
@@ -2198,7 +2198,7 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 	if (ret < 0)
 		goto out;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi target cap request\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "target cap request\n");
 
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_CAP_REQ_V01,
@@ -2251,7 +2251,7 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 	if (resp.eeprom_read_timeout_valid) {
 		ab->qmi.target.eeprom_caldata =
 					resp.eeprom_read_timeout;
-		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi cal data supported from eeprom\n");
+		ath11k_dbg(ab, ATH11K_DBG_QMI, "cal data supported from eeprom\n");
 	}
 
 	fw_build_id = ab->qmi.target.fw_build_id;
@@ -2348,7 +2348,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 		if (ret < 0)
 			goto err_iounmap;
 
-		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi bdf download req fixed addr type %d\n",
+		ath11k_dbg(ab, ATH11K_DBG_QMI, "bdf download req fixed addr type %d\n",
 			   type);
 
 		ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
@@ -2381,7 +2381,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 			remaining -= req->data_len;
 			temp += req->data_len;
 			req->seg_id++;
-			ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi bdf download request remaining %i\n",
+			ath11k_dbg(ab, ATH11K_DBG_QMI, "bdf download request remaining %i\n",
 				   remaining);
 		}
 	}
@@ -2427,7 +2427,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab,
 	else
 		bdf_type = ATH11K_QMI_BDF_TYPE_BIN;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi bdf_type %d\n", bdf_type);
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "bdf_type %d\n", bdf_type);
 
 	fw_size = min_t(u32, ab->hw_params.fw.board_size, bd.len);
 
@@ -2482,14 +2482,14 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab,
 		goto out_qmi_cal;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi caldata type: %u\n", file_type);
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "caldata type: %u\n", file_type);
 
 out_qmi_cal:
 	if (!ab->qmi.target.eeprom_caldata)
 		release_firmware(fw_entry);
 out:
 	ath11k_core_free_bdf(ab, &bd);
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi BDF download sequence completed\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "BDF download sequence completed\n");
 
 	return ret;
 }
@@ -2574,7 +2574,7 @@ static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
 	if (ret < 0)
 		goto out;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi m3 info req\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "m3 info req\n");
 
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_M3_INFO_REQ_V01,
@@ -2623,7 +2623,7 @@ static int ath11k_qmi_wlanfw_mode_send(struct ath11k_base *ab,
 	if (ret < 0)
 		goto out;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi wlan mode req mode %d\n", mode);
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "wlan mode req mode %d\n", mode);
 
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_WLAN_MODE_REQ_V01,
@@ -2718,7 +2718,7 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 	if (ret < 0)
 		goto out;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi wlan cfg req\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "wlan cfg req\n");
 
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_WLAN_CFG_REQ_V01,
@@ -2795,7 +2795,7 @@ void ath11k_qmi_firmware_stop(struct ath11k_base *ab)
 {
 	int ret;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware stop\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "firmware stop\n");
 
 	ret = ath11k_qmi_wlanfw_mode_send(ab, ATH11K_FIRMWARE_MODE_OFF);
 	if (ret < 0) {
@@ -2809,7 +2809,7 @@ int ath11k_qmi_firmware_start(struct ath11k_base *ab,
 {
 	int ret;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware start\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "firmware start\n");
 
 	if (ab->hw_params.fw_wmi_diag_event) {
 		ret = ath11k_qmi_wlanfw_wlan_ini_send(ab, true);
@@ -2967,7 +2967,7 @@ static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 	const struct qmi_wlanfw_request_mem_ind_msg_v01 *msg = data;
 	int i, ret;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware request memory request\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "firmware request memory request\n");
 
 	if (msg->mem_seg_len == 0 ||
 	    msg->mem_seg_len > ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01)
@@ -2979,7 +2979,7 @@ static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 	for (i = 0; i < qmi->mem_seg_count ; i++) {
 		ab->qmi.target_mem[i].type = msg->mem_seg[i].type;
 		ab->qmi.target_mem[i].size = msg->mem_seg[i].size;
-		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi mem seg type %d size %d\n",
+		ath11k_dbg(ab, ATH11K_DBG_QMI, "mem seg type %d size %d\n",
 			   msg->mem_seg[i].type, msg->mem_seg[i].size);
 	}
 
@@ -3011,7 +3011,7 @@ static void ath11k_qmi_msg_mem_ready_cb(struct qmi_handle *qmi_hdl,
 	struct ath11k_qmi *qmi = container_of(qmi_hdl, struct ath11k_qmi, handle);
 	struct ath11k_base *ab = qmi->ab;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware memory ready indication\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "firmware memory ready indication\n");
 	ath11k_qmi_driver_event_post(qmi, ATH11K_QMI_EVENT_FW_MEM_READY, NULL);
 }
 
@@ -3023,7 +3023,7 @@ static void ath11k_qmi_msg_fw_ready_cb(struct qmi_handle *qmi_hdl,
 	struct ath11k_qmi *qmi = container_of(qmi_hdl, struct ath11k_qmi, handle);
 	struct ath11k_base *ab = qmi->ab;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware ready\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "firmware ready\n");
 
 	if (!ab->qmi.cal_done) {
 		ab->qmi.cal_done = 1;
@@ -3044,7 +3044,7 @@ static void ath11k_qmi_msg_cold_boot_cal_done_cb(struct qmi_handle *qmi_hdl,
 
 	ab->qmi.cal_done = 1;
 	wake_up(&ab->qmi.cold_boot_waitq);
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi cold boot calibration done\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "cold boot calibration done\n");
 }
 
 static void ath11k_qmi_msg_fw_init_done_cb(struct qmi_handle *qmi_hdl,
@@ -3057,7 +3057,7 @@ static void ath11k_qmi_msg_fw_init_done_cb(struct qmi_handle *qmi_hdl,
 	struct ath11k_base *ab = qmi->ab;
 
 	ath11k_qmi_driver_event_post(qmi, ATH11K_QMI_EVENT_FW_INIT_DONE, NULL);
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware init done\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "firmware init done\n");
 }
 
 static const struct qmi_msg_handler ath11k_qmi_msg_handlers[] = {
@@ -3122,7 +3122,7 @@ static int ath11k_qmi_ops_new_server(struct qmi_handle *qmi_hdl,
 		return ret;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi wifi fw qmi service connected\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "wifi fw qmi service connected\n");
 	ath11k_qmi_driver_event_post(qmi, ATH11K_QMI_EVENT_SERVER_ARRIVE, NULL);
 
 	return ret;
@@ -3134,7 +3134,7 @@ static void ath11k_qmi_ops_del_server(struct qmi_handle *qmi_hdl,
 	struct ath11k_qmi *qmi = container_of(qmi_hdl, struct ath11k_qmi, handle);
 	struct ath11k_base *ab = qmi->ab;
 
-	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi wifi fw del server\n");
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "wifi fw del server\n");
 	ath11k_qmi_driver_event_post(qmi, ATH11K_QMI_EVENT_SERVER_EXIT, NULL);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 67443457f4da..7f9fb968dac6 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -123,7 +123,7 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
 			ar->state_11d = ATH11K_11D_IDLE;
 		}
 		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-			   "reg 11d scan wait left time %d\n", left);
+			   "11d scan wait left time %d\n", left);
 	}
 
 	if (wait &&
@@ -136,7 +136,7 @@ int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait)
 				   "failed to receive hw scan complete: timed out\n");
 
 		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
-			   "reg hw scan wait left time %d\n", left);
+			   "hw scan wait left time %d\n", left);
 	}
 
 	if (ar->state == ATH11K_STATE_RESTARTING)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 68622a850527..12a9e220df52 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -766,7 +766,7 @@ int ath11k_wmi_vdev_create(struct ath11k *ar, u8 *macaddr,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI vdev create: id %d type %d subtype %d macaddr %pM pdevid %d\n",
+		   "vdev create: id %d type %d subtype %d macaddr %pM pdevid %d\n",
 		   param->if_id, param->type, param->subtype,
 		   macaddr, param->pdev_id);
 
@@ -795,7 +795,7 @@ int ath11k_wmi_vdev_delete(struct ath11k *ar, u8 vdev_id)
 		dev_kfree_skb(skb);
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "WMI vdev delete id %d\n", vdev_id);
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "vdev delete id %d\n", vdev_id);
 
 	return ret;
 }
@@ -823,7 +823,7 @@ int ath11k_wmi_vdev_stop(struct ath11k *ar, u8 vdev_id)
 		dev_kfree_skb(skb);
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "WMI vdev stop id 0x%x\n", vdev_id);
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "vdev stop id 0x%x\n", vdev_id);
 
 	return ret;
 }
@@ -851,7 +851,7 @@ int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id)
 		dev_kfree_skb(skb);
 	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "WMI vdev down id 0x%x\n", vdev_id);
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "vdev down id 0x%x\n", vdev_id);
 
 	return ret;
 }
@@ -1049,7 +1049,7 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI mgmt vdev up id 0x%x assoc id %d bssid %pM\n",
+		   "mgmt vdev up id 0x%x assoc id %d bssid %pM\n",
 		   vdev_id, aid, bssid);
 
 	return ret;
@@ -1082,7 +1082,7 @@ int ath11k_wmi_send_peer_create_cmd(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI peer create vdev_id %d peer_addr %pM\n",
+		   "peer create vdev_id %d peer_addr %pM\n",
 		   param->vdev_id, param->peer_addr);
 
 	return ret;
@@ -1108,7 +1108,7 @@ int ath11k_wmi_send_peer_delete_cmd(struct ath11k *ar,
 	cmd->vdev_id = vdev_id;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI peer delete vdev_id %d peer_addr %pM\n",
+		   "peer delete vdev_id %d peer_addr %pM\n",
 		   vdev_id,  peer_addr);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_PEER_DELETE_CMDID);
@@ -1146,7 +1146,7 @@ int ath11k_wmi_send_pdev_set_regdomain(struct ath11k *ar,
 	cmd->pdev_id = param->pdev_id;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI pdev regd rd %d rd2g %d rd5g %d domain %d pdev id %d\n",
+		   "pdev regd rd %d rd2g %d rd5g %d domain %d pdev id %d\n",
 		   param->current_rd_in_use, param->current_rd_2g,
 		   param->current_rd_5g, param->dfs_domain, param->pdev_id);
 
@@ -1187,7 +1187,7 @@ int ath11k_wmi_set_peer_param(struct ath11k *ar, const u8 *peer_addr,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI vdev %d peer 0x%pM set param %d value %d\n",
+		   "vdev %d peer 0x%pM set param %d value %d\n",
 		   vdev_id, peer_addr, param_id, param_val);
 
 	return ret;
@@ -1222,7 +1222,7 @@ int ath11k_wmi_send_peer_flush_tids_cmd(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI peer flush vdev_id %d peer_addr %pM tids %08x\n",
+		   "peer flush vdev_id %d peer_addr %pM tids %08x\n",
 		   param->vdev_id, peer_addr, param->peer_tid_bitmap);
 
 	return ret;
@@ -1265,7 +1265,7 @@ int ath11k_wmi_peer_rx_reorder_queue_setup(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi rx reorder queue setup addr %pM vdev_id %d tid %d\n",
+		   "rx reorder queue setup addr %pM vdev_id %d tid %d\n",
 		   addr, vdev_id, tid);
 
 	return ret;
@@ -1334,7 +1334,7 @@ int ath11k_wmi_pdev_set_param(struct ath11k *ar, u32 param_id,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI pdev set param %d pdev id %d value %d\n",
+		   "pdev set param %d pdev id %d value %d\n",
 		   param_id, pdev_id, param_value);
 
 	return ret;
@@ -1365,7 +1365,7 @@ int ath11k_wmi_pdev_set_ps_mode(struct ath11k *ar, int vdev_id,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI vdev set psmode %d vdev id %d\n",
+		   "vdev set psmode %d vdev id %d\n",
 		   psmode, vdev_id);
 
 	return ret;
@@ -1398,7 +1398,7 @@ int ath11k_wmi_pdev_suspend(struct ath11k *ar, u32 suspend_opt,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI pdev suspend pdev_id %d\n", pdev_id);
+		   "pdev suspend pdev_id %d\n", pdev_id);
 
 	return ret;
 }
@@ -1421,7 +1421,7 @@ int ath11k_wmi_pdev_resume(struct ath11k *ar, u32 pdev_id)
 	cmd->pdev_id = pdev_id;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI pdev resume pdev id %d\n", pdev_id);
+		   "pdev resume pdev id %d\n", pdev_id);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_RESUME_CMDID);
 	if (ret) {
@@ -1457,7 +1457,7 @@ int ath11k_wmi_pdev_bss_chan_info_request(struct ath11k *ar,
 	cmd->pdev_id = ar->pdev->pdev_id;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI bss chan info req type %d\n", type);
+		   "bss chan info req type %d\n", type);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb,
 				  WMI_PDEV_BSS_CHAN_INFO_REQUEST_CMDID);
@@ -1499,7 +1499,7 @@ int ath11k_wmi_send_set_ap_ps_param_cmd(struct ath11k *ar, u8 *peer_addr,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI set ap ps vdev id %d peer %pM param %d value %d\n",
+		   "set ap ps vdev id %d peer %pM param %d value %d\n",
 		   param->vdev_id, peer_addr, param->param, param->value);
 
 	return ret;
@@ -1527,7 +1527,7 @@ int ath11k_wmi_set_sta_ps_param(struct ath11k *ar, u32 vdev_id,
 	cmd->value = param_value;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI set sta ps vdev_id %d param %d value %d\n",
+		   "set sta ps vdev_id %d param %d value %d\n",
 		   vdev_id, param, param_value);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_STA_POWERSAVE_PARAM_CMDID);
@@ -1596,7 +1596,7 @@ int ath11k_wmi_vdev_set_param_cmd(struct ath11k *ar, u32 vdev_id,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI vdev id 0x%x set param %d value %d\n",
+		   "vdev id 0x%x set param %d value %d\n",
 		   vdev_id, param_id, param_value);
 
 	return ret;
@@ -1629,7 +1629,7 @@ int ath11k_wmi_send_stats_request_cmd(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI request stats 0x%x vdev id %d pdev id %d\n",
+		   "request stats 0x%x vdev id %d pdev id %d\n",
 		   param->stats_id, param->vdev_id, param->pdev_id);
 
 	return ret;
@@ -1658,7 +1658,7 @@ int ath11k_wmi_send_pdev_temperature_cmd(struct ath11k *ar)
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI pdev get temperature for pdev_id %d\n", ar->pdev->pdev_id);
+		   "pdev get temperature for pdev_id %d\n", ar->pdev->pdev_id);
 
 	return ret;
 }
@@ -1684,7 +1684,7 @@ int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 	cmd->bcn_ctrl_op = bcn_ctrl_op;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI bcn ctrl offload vdev id %d ctrl_op %d\n",
+		   "bcn ctrl offload vdev id %d ctrl_op %d\n",
 		   vdev_id, bcn_ctrl_op);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_BCN_OFFLOAD_CTRL_CMDID);
@@ -1812,7 +1812,7 @@ int ath11k_wmi_vdev_install_key(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI vdev install key idx %d cipher %d len %d\n",
+		   "vdev install key idx %d cipher %d len %d\n",
 		   arg->key_idx, arg->key_cipher, arg->key_len);
 
 	return ret;
@@ -2048,7 +2048,7 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi peer assoc vdev id %d assoc id %d peer mac %pM peer_flags %x rate_caps %x peer_caps %x listen_intval %d ht_caps %x max_mpdu %d nss %d phymode %d peer_mpdu_density %d vht_caps %x he cap_info %x he ops %x he cap_info_ext %x he phy %x %x %x peer_bw_rxnss_override %x\n",
+		   "peer assoc vdev id %d assoc id %d peer mac %pM peer_flags %x rate_caps %x peer_caps %x listen_intval %d ht_caps %x max_mpdu %d nss %d phymode %d peer_mpdu_density %d vht_caps %x he cap_info %x he ops %x he cap_info_ext %x he phy %x %x %x peer_bw_rxnss_override %x\n",
 		   cmd->vdev_id, cmd->peer_associd, param->peer_mac,
 		   cmd->peer_flags, cmd->peer_rate_caps, cmd->peer_caps,
 		   cmd->peer_listen_intval, cmd->peer_ht_caps,
@@ -2457,7 +2457,7 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 			cmd->flags |= WMI_APPEND_TO_EXISTING_CHAN_LIST_FLAG;
 
 		ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-			   "WMI no.of chan = %d len = %d pdev_id = %d num_sends = %d\n",
+			   "no.of chan = %d len = %d pdev_id = %d num_sends = %d\n",
 			   num_send_chans, len, cmd->pdev_id, num_sends);
 
 		ptr = skb->data + sizeof(*cmd);
@@ -2516,7 +2516,7 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 					    tchan_info->maxregpower);
 
 			ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-				   "WMI chan scan list chan[%d] = %u, chan_info->info %8x\n",
+				   "chan scan list chan[%d] = %u, chan_info->info %8x\n",
 				   i, chan_info->mhz, chan_info->info);
 
 			ptr += sizeof(*chan_info);
@@ -2590,7 +2590,7 @@ int ath11k_wmi_send_wmm_update_cmd_tlv(struct ath11k *ar, u32 vdev_id,
 		wmm_param->no_ack = wmi_wmm_arg->no_ack;
 
 		ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-			   "wmi wmm set ac %d aifs %d cwmin %d cwmax %d txop %d acm %d no_ack %d\n",
+			   "wmm set ac %d aifs %d cwmin %d cwmax %d txop %d acm %d no_ack %d\n",
 			   ac, wmm_param->aifs, wmm_param->cwmin,
 			   wmm_param->cwmax, wmm_param->txoplimit,
 			   wmm_param->acm, wmm_param->no_ack);
@@ -2627,7 +2627,7 @@ int ath11k_wmi_send_dfs_phyerr_offload_enable_cmd(struct ath11k *ar,
 	cmd->pdev_id = pdev_id;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI dfs phy err offload enable pdev id %d\n", pdev_id);
+		   "dfs phy err offload enable pdev id %d\n", pdev_id);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb,
 				  WMI_PDEV_DFS_PHYERR_OFFLOAD_ENABLE_CMDID);
@@ -2662,7 +2662,7 @@ int ath11k_wmi_delba_send(struct ath11k *ar, u32 vdev_id, const u8 *mac,
 	cmd->reasoncode = reason;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi delba send vdev_id 0x%X mac_addr %pM tid %u initiator %u reason %u\n",
+		   "delba send vdev_id 0x%X mac_addr %pM tid %u initiator %u reason %u\n",
 		   vdev_id, mac, tid, initiator, reason);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_DELBA_SEND_CMDID);
@@ -2698,7 +2698,7 @@ int ath11k_wmi_addba_set_resp(struct ath11k *ar, u32 vdev_id, const u8 *mac,
 	cmd->statuscode = status;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi addba set resp vdev_id 0x%X mac_addr %pM tid %u status %u\n",
+		   "addba set resp vdev_id 0x%X mac_addr %pM tid %u status %u\n",
 		   vdev_id, mac, tid, status);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_ADDBA_SET_RESP_CMDID);
@@ -2733,7 +2733,7 @@ int ath11k_wmi_addba_send(struct ath11k *ar, u32 vdev_id, const u8 *mac,
 	cmd->buffersize = buf_size;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi addba send vdev_id 0x%X mac_addr %pM tid %u bufsize %u\n",
+		   "addba send vdev_id 0x%X mac_addr %pM tid %u bufsize %u\n",
 		   vdev_id, mac, tid, buf_size);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_ADDBA_SEND_CMDID);
@@ -2766,7 +2766,7 @@ int ath11k_wmi_addba_clear_resp(struct ath11k *ar, u32 vdev_id, const u8 *mac)
 	ether_addr_copy(cmd->peer_macaddr.addr, mac);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi addba clear resp vdev_id 0x%X mac_addr %pM\n",
+		   "addba clear resp vdev_id 0x%X mac_addr %pM\n",
 		   vdev_id, mac);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_ADDBA_CLEAR_RESP_CMDID);
@@ -2975,7 +2975,7 @@ ath11k_wmi_send_thermal_mitigation_param_cmd(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI vdev set thermal throt pdev_id %d enable %d dc %d dc_per_event %x levels %d\n",
+		   "vdev set thermal throt pdev_id %d enable %d dc %d dc_per_event %x levels %d\n",
 		   ar->pdev->pdev_id, param->enable, param->dc,
 		   param->dc_per_event, THERMAL_LEVELS);
 
@@ -3248,7 +3248,7 @@ int ath11k_wmi_send_twt_add_dialog_cmd(struct ath11k *ar,
 		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_PROTECTION;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi add twt dialog vdev %u dialog id %u wake interval %u mantissa %u wake duration %u service period offset %u flags 0x%x\n",
+		   "add twt dialog vdev %u dialog id %u wake interval %u mantissa %u wake duration %u service period offset %u flags 0x%x\n",
 		   cmd->vdev_id, cmd->dialog_id, cmd->wake_intvl_us,
 		   cmd->wake_intvl_mantis, cmd->wake_dura_us, cmd->sp_offset_us,
 		   cmd->flags);
@@ -3288,7 +3288,7 @@ int ath11k_wmi_send_twt_del_dialog_cmd(struct ath11k *ar,
 	cmd->dialog_id = params->dialog_id;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi delete twt dialog vdev %u dialog id %u\n",
+		   "delete twt dialog vdev %u dialog id %u\n",
 		   cmd->vdev_id, cmd->dialog_id);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_TWT_DEL_DIALOG_CMDID);
@@ -3326,7 +3326,7 @@ int ath11k_wmi_send_twt_pause_dialog_cmd(struct ath11k *ar,
 	cmd->dialog_id = params->dialog_id;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi pause twt dialog vdev %u dialog id %u\n",
+		   "pause twt dialog vdev %u dialog id %u\n",
 		   cmd->vdev_id, cmd->dialog_id);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_TWT_PAUSE_DIALOG_CMDID);
@@ -3366,7 +3366,7 @@ int ath11k_wmi_send_twt_resume_dialog_cmd(struct ath11k *ar,
 	cmd->next_twt_size = params->next_twt_size;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi resume twt dialog vdev %u dialog id %u service period offset %u next twt subfield size %u\n",
+		   "resume twt dialog vdev %u dialog id %u service period offset %u next twt subfield size %u\n",
 		   cmd->vdev_id, cmd->dialog_id, cmd->sp_offset_us,
 		   cmd->next_twt_size);
 
@@ -3734,7 +3734,7 @@ int ath11k_wmi_fils_discovery_tmpl(struct ath11k *ar, u32 vdev_id,
 	len = sizeof(*cmd) + TLV_HDR_SIZE + aligned_len;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI vdev %i set FILS discovery template\n", vdev_id);
+		   "vdev %i set FILS discovery template\n", vdev_id);
 
 	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
 	if (!skb)
@@ -3775,7 +3775,7 @@ int ath11k_wmi_probe_resp_tmpl(struct ath11k *ar, u32 vdev_id,
 	size_t aligned_len = roundup(tmpl->len, 4);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI vdev %i set probe response template\n", vdev_id);
+		   "vdev %i set probe response template\n", vdev_id);
 
 	len = sizeof(*cmd) + sizeof(*probe_info) + TLV_HDR_SIZE + aligned_len;
 
@@ -3824,7 +3824,7 @@ int ath11k_wmi_fils_discovery(struct ath11k *ar, u32 vdev_id, u32 interval,
 	struct wmi_fils_discovery_cmd *cmd;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI vdev %i set %s interval to %u TU\n",
+		   "vdev %i set %s interval to %u TU\n",
 		   vdev_id, unsol_bcast_probe_resp_enabled ?
 		   "unsolicited broadcast probe response" : "FILS discovery",
 		   interval);
@@ -4060,7 +4060,7 @@ static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
 		host_mem_chunks[idx].req_id = param->mem_chunks[idx].req_id;
 
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
-			   "WMI host mem chunk req_id %d paddr 0x%llx len %d\n",
+			   "host mem chunk req_id %d paddr 0x%llx len %d\n",
 			   param->mem_chunks[idx].req_id,
 			   (u64)param->mem_chunks[idx].paddr,
 			   param->mem_chunks[idx].len);
@@ -4147,7 +4147,7 @@ int ath11k_wmi_pdev_lro_cfg(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI lro cfg cmd pdev_id 0x%x\n", pdev_id);
+		   "lro cfg cmd pdev_id 0x%x\n", pdev_id);
 	return 0;
 err:
 	dev_kfree_skb(skb);
@@ -4268,7 +4268,7 @@ int ath11k_wmi_vdev_spectral_conf(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI spectral scan config cmd vdev_id 0x%x\n",
+		   "spectral scan config cmd vdev_id 0x%x\n",
 		   param->vdev_id);
 
 	return 0;
@@ -4306,7 +4306,7 @@ int ath11k_wmi_vdev_spectral_enable(struct ath11k *ar, u32 vdev_id,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI spectral enable cmd vdev id 0x%x\n",
+		   "spectral enable cmd vdev id 0x%x\n",
 		   vdev_id);
 
 	return 0;
@@ -4352,7 +4352,7 @@ int ath11k_wmi_pdev_dma_ring_cfg(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI DMA ring cfg req cmd pdev_id 0x%x\n",
+		   "DMA ring cfg req cmd pdev_id 0x%x\n",
 		   param->pdev_id);
 
 	return 0;
@@ -5773,7 +5773,7 @@ static int wmi_process_mgmt_tx_comp(struct ath11k *ar,
 		WARN_ON_ONCE(1);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi mgmt tx comp pending %d desc id %d\n",
+		   "mgmt tx comp pending %d desc id %d\n",
 		   num_mgmt, tx_compl_param->desc_id);
 
 	if (!num_mgmt)
@@ -6342,7 +6342,7 @@ static int ath11k_wmi_tlv_rssi_chain_parse(struct ath11k_base *ab,
 	stats->stats_id = WMI_REQUEST_RSSI_PER_CHAIN_STAT;
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "wmi stats vdev id %d mac %pM\n",
+		   "stats vdev id %d mac %pM\n",
 		   stats_rssi->vdev_id, stats_rssi->peer_macaddr.addr);
 
 	arvif = ath11k_mac_get_arvif(ar, stats_rssi->vdev_id);
@@ -6354,7 +6354,7 @@ static int ath11k_wmi_tlv_rssi_chain_parse(struct ath11k_base *ab,
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "wmi stats bssid %pM vif %pK\n",
+		   "stats bssid %pM vif %pK\n",
 		   arvif->bssid, arvif->vif);
 
 	sta = ieee80211_find_sta_by_ifaddr(ar->hw,
@@ -6375,7 +6375,7 @@ static int ath11k_wmi_tlv_rssi_chain_parse(struct ath11k_base *ab,
 	for (j = 0; j < ARRAY_SIZE(arsta->chain_signal); j++) {
 		arsta->chain_signal[j] = stats_rssi->rssi_avg_beacon[j];
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
-			   "wmi stats beacon rssi[%d] %d data rssi[%d] %d\n",
+			   "stats beacon rssi[%d] %d data rssi[%d] %d\n",
 			   j,
 			   stats_rssi->rssi_avg_beacon[j],
 			   j,
@@ -6458,7 +6458,7 @@ static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
 				arsta = (struct ath11k_sta *)sta->drv_priv;
 				arsta->rssi_beacon = src->beacon_snr;
 				ath11k_dbg(ab, ATH11K_DBG_WMI,
-					   "wmi stats vdev id %d snr %d\n",
+					   "stats vdev id %d snr %d\n",
 					   src->vdev_id, src->beacon_snr);
 			} else {
 				ath11k_dbg(ab, ATH11K_DBG_WMI,
@@ -6528,7 +6528,7 @@ static int ath11k_wmi_tlv_fw_stats_parse(struct ath11k_base *ab,
 			parse->rssi_num = parse->rssi->num_per_chain_rssi_stats;
 
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
-			   "wmi stats id 0x%x num chain %d\n",
+			   "stats id 0x%x num chain %d\n",
 			   parse->ev->stats_id,
 			   parse->rssi_num);
 		break;
@@ -6927,7 +6927,7 @@ static int ath11k_reg_11d_new_cc_event(struct ath11k_base *ab, struct sk_buff *s
 	memcpy(&ab->new_alpha2, &ev->new_alpha2, 2);
 	spin_unlock_bh(&ab->base_lock);
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "wmi 11d new cc %c%c\n",
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "11d new cc %c%c\n",
 		   ab->new_alpha2[0],
 		   ab->new_alpha2[1]);
 
@@ -7497,7 +7497,7 @@ static void ath11k_mgmt_rx_event(struct ath11k_base *ab, struct sk_buff *skb)
 	if (rx_ev.phy_mode == MODE_11B &&
 	    (status->band == NL80211_BAND_5GHZ || status->band == NL80211_BAND_6GHZ))
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
-			   "wmi mgmt rx 11b (CCK) on 5/6GHz, band = %d\n", status->band);
+			   "mgmt rx 11b (CCK) on 5/6GHz, band = %d\n", status->band);
 
 	sband = &ar->mac.sbands[status->band];
 
@@ -7747,7 +7747,7 @@ static void ath11k_roam_event(struct ath11k_base *ab, struct sk_buff *skb)
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "wmi roam event vdev %u reason 0x%08x rssi %d\n",
+		   "roam event vdev %u reason 0x%08x rssi %d\n",
 		   roam_ev.vdev_id, roam_ev.reason, roam_ev.rssi);
 
 	rcu_read_lock();
@@ -8503,7 +8503,7 @@ static void ath11k_wmi_gtk_offload_status_event(struct ath11k_base *ab,
 		return;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "wmi gtk offload event refresh_cnt %d\n",
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "gtk offload event refresh_cnt %d\n",
 		   ev->refresh_cnt);
 	ath11k_dbg_dump(ab, ATH11K_DBG_WMI, "replay_cnt",
 			NULL, ev->replay_ctr.counter, GTK_REPLAY_COUNTER_BYTES);
@@ -8760,7 +8760,7 @@ ath11k_wmi_send_unit_test_cmd(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI unit test : module %d vdev %d n_args %d token %d\n",
+		   "unit test : module %d vdev %d n_args %d token %d\n",
 		   cmd->module_id, cmd->vdev_id, cmd->num_args,
 		   cmd->diag_token);
 
@@ -8957,7 +8957,7 @@ int ath11k_wmi_hw_data_filter_cmd(struct ath11k *ar, u32 vdev_id,
 		cmd->hw_filter_bitmap = ((u32)~0U);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi hw data filter enable %d filter_bitmap 0x%x\n",
+		   "hw data filter enable %d filter_bitmap 0x%x\n",
 		   enable, filter_bitmap);
 
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
@@ -8979,7 +8979,7 @@ int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar)
 				     WMI_TAG_WOW_HOSTWAKEUP_FROM_SLEEP_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv wow host wakeup ind\n");
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow host wakeup ind\n");
 
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
 }
@@ -9001,7 +9001,7 @@ int ath11k_wmi_wow_enable(struct ath11k *ar)
 
 	cmd->enable = 1;
 	cmd->pause_iface_config = WOW_IFACE_PAUSE_ENABLED;
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv wow enable\n");
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow enable\n");
 
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
 }
@@ -9028,7 +9028,7 @@ int ath11k_wmi_scan_prob_req_oui(struct ath11k *ar,
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
 	cmd->prob_req_oui = prob_req_oui;
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi scan prob req oui %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "scan prob req oui %d\n",
 		   prob_req_oui);
 
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_SCAN_PROB_REQ_OUI_CMDID);
@@ -9055,7 +9055,7 @@ int ath11k_wmi_wow_add_wakeup_event(struct ath11k *ar, u32 vdev_id,
 	cmd->is_add = enable;
 	cmd->event_bitmap = (1 << event);
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv wow add wakeup event %s enable %d vdev_id %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow add wakeup event %s enable %d vdev_id %d\n",
 		   wow_wakeup_event(event), enable, vdev_id);
 
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID);
@@ -9160,7 +9160,7 @@ int ath11k_wmi_wow_add_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id,
 				 WMI_TAG_ARRAY_UINT32) |
 		      FIELD_PREP(WMI_TLV_LEN, sizeof(u32));
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv wow add pattern vdev_id %d pattern_id %d pattern_offset %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow add pattern vdev_id %d pattern_id %d pattern_offset %d\n",
 		   vdev_id, pattern_id, pattern_offset);
 
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ADD_WAKE_PATTERN_CMDID);
@@ -9186,7 +9186,7 @@ int ath11k_wmi_wow_del_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id)
 	cmd->pattern_id = pattern_id;
 	cmd->pattern_type = WOW_BITMAP_PATTERN;
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv wow del pattern vdev_id %d pattern_id %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow del pattern vdev_id %d pattern_id %d\n",
 		   vdev_id, pattern_id);
 
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
@@ -9299,7 +9299,7 @@ ath11k_wmi_op_gen_config_pno_start(struct ath11k *ar,
 	for (i = 0; i < cmd->num_of_channels; i++)
 		channel_list[i] = pno->a_networks[0].channels[i];
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv start pno config vdev_id %d\n",
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv start pno config vdev_id %d\n",
 		   vdev_id);
 
 	return skb;
@@ -9325,7 +9325,7 @@ static struct sk_buff *ath11k_wmi_op_gen_config_pno_stop(struct ath11k *ar,
 	cmd->flags = WMI_NLO_CONFIG_STOP;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi tlv stop pno config vdev_id %d\n", vdev_id);
+		   "tlv stop pno config vdev_id %d\n", vdev_id);
 	return skb;
 }
 
@@ -9402,7 +9402,7 @@ static void ath11k_wmi_fill_ns_offload(struct ath11k *ar,
 			}
 
 			ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-				   "wmi index %d ns_solicited %pI6 target %pI6",
+				   "index %d ns_solicited %pI6 target %pI6",
 				   i, ns->solicitation_ipaddr,
 				   ns->target_ipaddr[0]);
 		}
@@ -9440,7 +9440,7 @@ static void ath11k_wmi_fill_arp_offload(struct ath11k *ar,
 			memcpy(arp->target_ipaddr, offload->ipv4_addr[i], 4);
 			ath11k_ce_byte_swap(arp->target_ipaddr, 4);
 
-			ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi arp offload address %pI4",
+			ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "arp offload address %pI4",
 				   arp->target_ipaddr);
 		}
 
@@ -9673,7 +9673,7 @@ int ath11k_wmi_sta_keepalive(struct ath11k *ar,
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "wmi sta keepalive vdev %d enabled %d method %d interval %d\n",
+		   "sta keepalive vdev %d enabled %d method %d interval %d\n",
 		   arg->vdev_id, arg->enabled, arg->method, arg->interval);
 
 	return ath11k_wmi_cmd_send(wmi, skb, WMI_STA_KEEPALIVE_CMDID);
-- 
2.30.2

