Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7610E245760
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgHPLcd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 07:32:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31080 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbgHPLaW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 07:30:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597577413; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=3q/TKESE1oNDYvFeWbo64YCJFZG6CZqfF4WF24zJczw=; b=FX4uk7X/xJgkzMWrrrEkjGJC29OJnN6ISZzHAtnQeQrmVdpvhmXuvkJhaXYBq8L8fiFiI2iY
 /muv9faX6kE973KfTrYprMmPpaWA0VUzKIyh4PvyvH/aSL8YU3bDgsY6gBgIBiarv+yMt1Wc
 bziy3P5w/ZDEwYvaruz+tWf8TYc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f3915ab03528d402494b483 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 11:16:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF11CC43391; Sun, 16 Aug 2020 11:16:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA496C43387;
        Sun, 16 Aug 2020 11:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA496C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 10/12] ath11k: initialize wmi config based on hw_params
Date:   Sun, 16 Aug 2020 14:16:37 +0300
Message-Id: <1597576599-8857-11-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
References: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

QCA6390 has very different wmi config parameters compared to IPQ8074,
so use different function to initialize wmi init config parameters.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hw.c  | 98 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h  |  4 ++
 drivers/net/wireless/ath/ath11k/wmi.c |  4 +-
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 5811eabf2275..338b784b0e84 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -31,12 +31,110 @@ static u8 ath11k_hw_ipq6018_mac_from_pdev_id(int pdev_idx)
 	return pdev_idx;
 }
 
+static void ath11k_init_wmi_config_qca6390(struct ath11k_base *ab,
+					   struct target_resource_config *config)
+{
+	config->num_vdevs = 4;
+	config->num_peers = 16;
+	config->num_tids = 32;
+
+	config->num_offload_peers = 3;
+	config->num_offload_reorder_buffs = 3;
+	config->num_peer_keys = TARGET_NUM_PEER_KEYS;
+	config->ast_skid_limit = TARGET_AST_SKID_LIMIT;
+	config->tx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
+	config->rx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
+	config->rx_timeout_pri[0] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[1] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
+	config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
+	config->scan_max_pending_req = TARGET_SCAN_MAX_PENDING_REQS;
+	config->bmiss_offload_max_vdev = TARGET_BMISS_OFFLOAD_MAX_VDEV;
+	config->roam_offload_max_vdev = TARGET_ROAM_OFFLOAD_MAX_VDEV;
+	config->roam_offload_max_ap_profiles = TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES;
+	config->num_mcast_groups = 0;
+	config->num_mcast_table_elems = 0;
+	config->mcast2ucast_mode = 0;
+	config->tx_dbg_log_size = TARGET_TX_DBG_LOG_SIZE;
+	config->num_wds_entries = 0;
+	config->dma_burst_size = 0;
+	config->rx_skip_defrag_timeout_dup_detection_check = 0;
+	config->vow_config = TARGET_VOW_CONFIG;
+	config->gtk_offload_max_vdev = 2;
+	config->num_msdu_desc = 0x400;
+	config->beacon_tx_offload_max_vdev = 2;
+	config->rx_batchmode = TARGET_RX_BATCHMODE;
+
+	config->peer_map_unmap_v2_support = 0;
+	config->use_pdev_id = 1;
+	config->max_frag_entries = 0xa;
+	config->num_tdls_vdevs = 0x1;
+	config->num_tdls_conn_table_entries = 8;
+	config->beacon_tx_offload_max_vdev = 0x2;
+	config->num_multicast_filter_entries = 0x20;
+	config->num_wow_filters = 0x16;
+	config->num_keep_alive_pattern = 0x1;
+	config->num_keep_alive_pattern = 0;
+}
+
+static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
+					   struct target_resource_config *config)
+{
+	config->num_vdevs = ab->num_radios * TARGET_NUM_VDEVS;
+
+	if (ab->num_radios == 2) {
+		config->num_peers = TARGET_NUM_PEERS(DBS);
+		config->num_tids = TARGET_NUM_TIDS(DBS);
+	} else if (ab->num_radios == 3) {
+		config->num_peers = TARGET_NUM_PEERS(DBS_SBS);
+		config->num_tids = TARGET_NUM_TIDS(DBS_SBS);
+	} else {
+		/* Control should not reach here */
+		config->num_peers = TARGET_NUM_PEERS(SINGLE);
+		config->num_tids = TARGET_NUM_TIDS(SINGLE);
+	}
+	config->num_offload_peers = TARGET_NUM_OFFLD_PEERS;
+	config->num_offload_reorder_buffs = TARGET_NUM_OFFLD_REORDER_BUFFS;
+	config->num_peer_keys = TARGET_NUM_PEER_KEYS;
+	config->ast_skid_limit = TARGET_AST_SKID_LIMIT;
+	config->tx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
+	config->rx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
+	config->rx_timeout_pri[0] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[1] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
+	config->rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
+	config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
+	config->scan_max_pending_req = TARGET_SCAN_MAX_PENDING_REQS;
+	config->bmiss_offload_max_vdev = TARGET_BMISS_OFFLOAD_MAX_VDEV;
+	config->roam_offload_max_vdev = TARGET_ROAM_OFFLOAD_MAX_VDEV;
+	config->roam_offload_max_ap_profiles = TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES;
+	config->num_mcast_groups = TARGET_NUM_MCAST_GROUPS;
+	config->num_mcast_table_elems = TARGET_NUM_MCAST_TABLE_ELEMS;
+	config->mcast2ucast_mode = TARGET_MCAST2UCAST_MODE;
+	config->tx_dbg_log_size = TARGET_TX_DBG_LOG_SIZE;
+	config->num_wds_entries = TARGET_NUM_WDS_ENTRIES;
+	config->dma_burst_size = TARGET_DMA_BURST_SIZE;
+	config->rx_skip_defrag_timeout_dup_detection_check =
+		TARGET_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK;
+	config->vow_config = TARGET_VOW_CONFIG;
+	config->gtk_offload_max_vdev = TARGET_GTK_OFFLOAD_MAX_VDEV;
+	config->num_msdu_desc = TARGET_NUM_MSDU_DESC;
+	config->beacon_tx_offload_max_vdev = ab->num_radios * TARGET_MAX_BCN_OFFLD;
+	config->rx_batchmode = TARGET_RX_BATCHMODE;
+	config->peer_map_unmap_v2_support = 1;
+	config->twt_ap_pdev_count = 2;
+	config->twt_ap_sta_count = 1000;
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
+	.wmi_init_config = ath11k_init_wmi_config_qca6390,
 };
 
 const struct ath11k_hw_ops ipq6018_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq6018_mac_from_pdev_id,
+	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
 };
 
 const struct ath11k_hw_ops qca6390_ops = {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 3dcd05ceeef7..4651aed2eaf0 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -6,6 +6,8 @@
 #ifndef ATH11K_HW_H
 #define ATH11K_HW_H
 
+#include "wmi.h"
+
 /* Target configuration defines */
 
 /* Num VDEVS per radio */
@@ -116,6 +118,8 @@ struct ath11k_hw_ring_mask {
 
 struct ath11k_hw_ops {
 	u8 (*get_hw_mac_from_pdev_id)(int pdev_id);
+	void (*wmi_init_config)(struct ath11k_base *ab,
+				struct target_resource_config *config);
 };
 
 struct ath11k_hw_params {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c43f54a7c54d..21f9070a1300 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3181,7 +3181,7 @@ static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
 			      (param->num_band_to_mac * sizeof(*band_to_mac));
 
 	len = sizeof(*cmd) + TLV_HDR_SIZE + sizeof(*cfg) + hw_mode_len +
-	      (sizeof(*host_mem_chunks) * WMI_MAX_MEM_REQS);
+	      (param->num_mem_chunks ? (sizeof(*host_mem_chunks) * WMI_MAX_MEM_REQS) : 0);
 
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
@@ -3387,6 +3387,8 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	config.twt_ap_pdev_count = ab->num_radios;
 	config.twt_ap_sta_count = 1000;
 
+	ab->hw_params.hw_ops->wmi_init_config(ab, &config);
+
 	memcpy(&wmi_sc->wlan_resource_config, &config, sizeof(config));
 
 	init_param.res_cfg = &wmi_sc->wlan_resource_config;
-- 
2.7.4

