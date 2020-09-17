Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2488326E47A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 20:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIQSuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 14:50:19 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:54132 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728434AbgIQQ1L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 12:27:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600360011; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BgUm+Qk+8+MmnpcCJCYWxq5Zrw21NGcWN0FivfJL1OY=; b=B2B1Tc7d5L7bOiKlKdX5wH9b4kJ3aGR9v3ikmJL7QMLHjT51MaPeuvtItmssOrqCyVg0TIjF
 GQopwPbxI7Z6FrBIjecqX1dOV+2oICuNGrazmaRI7I6BKJBf3SLE+IcaL0SDXM7puadsWj2w
 nsVjzeWaNhvkhiM93Zyl2Ge7fUQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f6380a028e87a878b5fa09b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Sep 2020 15:28:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D364C433CA; Thu, 17 Sep 2020 15:28:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA061C433F0;
        Thu, 17 Sep 2020 15:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA061C433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, vnaralas@codeaurora.org
Subject: [PATCH] ath11k: wmi: remove redundant configuration values from init
Date:   Thu, 17 Sep 2020 18:28:27 +0300
Message-Id: <1600356507-29237-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In commit 2d4bcbed5b7d ("ath11k: initialize wmi config based on hw_params") the
wmi config initialisation was moved to hw_ops->wmi_init_config() but the old
initialisation values were accidentally left to ath11k_wmi_cmd_init(). This
is very confusing, so remove the redundant values.

And this was actually so confusing that in commit aa2092a9bab3 ("ath11k: add
raw mode and software crypto support") I actually it caused a bug: when
ATH11K_FLAG_RAW_MODE was enabled rx_decap_mode was assigned back to
TARGET_DECAP_MODE_NATIVE_WIFI in ath11k_init_wmi_config_ipq8074(). Fix this at
the same time.

Compile tested only.

Fixes: 2d4bcbed5b7d ("ath11k: initialize wmi config based on hw_params")
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hw.c  |  7 ++++-
 drivers/net/wireless/ath/ath11k/wmi.c | 49 -----------------------------------
 2 files changed, 6 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 4d7d2dc691d2..11a411b76fe4 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -103,7 +103,12 @@ static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
 	config->rx_timeout_pri[1] = TARGET_RX_TIMEOUT_LO_PRI;
 	config->rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
 	config->rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
-	config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
+
+	if (test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags))
+		config->rx_decap_mode = TARGET_DECAP_MODE_RAW;
+	else
+		config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
+
 	config->scan_max_pending_req = TARGET_SCAN_MAX_PENDING_REQS;
 	config->bmiss_offload_max_vdev = TARGET_BMISS_OFFLOAD_MAX_VDEV;
 	config->roam_offload_max_vdev = TARGET_ROAM_OFFLOAD_MAX_VDEV;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index adde14a390ec..92c7345dc150 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3342,55 +3342,6 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	memset(&init_param, 0, sizeof(init_param));
 	memset(&config, 0, sizeof(config));
 
-	config.num_vdevs = ab->num_radios * TARGET_NUM_VDEVS;
-
-	if (ab->num_radios == 2) {
-		config.num_peers = TARGET_NUM_PEERS(DBS);
-		config.num_tids = TARGET_NUM_TIDS(DBS);
-	} else if (ab->num_radios == 3) {
-		config.num_peers = TARGET_NUM_PEERS(DBS_SBS);
-		config.num_tids = TARGET_NUM_TIDS(DBS_SBS);
-	} else {
-		/* Control should not reach here */
-		config.num_peers = TARGET_NUM_PEERS(SINGLE);
-		config.num_tids = TARGET_NUM_TIDS(SINGLE);
-	}
-	config.num_offload_peers = TARGET_NUM_OFFLD_PEERS;
-	config.num_offload_reorder_buffs = TARGET_NUM_OFFLD_REORDER_BUFFS;
-	config.num_peer_keys = TARGET_NUM_PEER_KEYS;
-	config.ast_skid_limit = TARGET_AST_SKID_LIMIT;
-	config.tx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
-	config.rx_chain_mask = (1 << ab->target_caps.num_rf_chains) - 1;
-	config.rx_timeout_pri[0] = TARGET_RX_TIMEOUT_LO_PRI;
-	config.rx_timeout_pri[1] = TARGET_RX_TIMEOUT_LO_PRI;
-	config.rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
-	config.rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
-	config.rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
-
-	if (test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags))
-		config.rx_decap_mode = TARGET_DECAP_MODE_RAW;
-
-	config.scan_max_pending_req = TARGET_SCAN_MAX_PENDING_REQS;
-	config.bmiss_offload_max_vdev = TARGET_BMISS_OFFLOAD_MAX_VDEV;
-	config.roam_offload_max_vdev = TARGET_ROAM_OFFLOAD_MAX_VDEV;
-	config.roam_offload_max_ap_profiles = TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES;
-	config.num_mcast_groups = TARGET_NUM_MCAST_GROUPS;
-	config.num_mcast_table_elems = TARGET_NUM_MCAST_TABLE_ELEMS;
-	config.mcast2ucast_mode = TARGET_MCAST2UCAST_MODE;
-	config.tx_dbg_log_size = TARGET_TX_DBG_LOG_SIZE;
-	config.num_wds_entries = TARGET_NUM_WDS_ENTRIES;
-	config.dma_burst_size = TARGET_DMA_BURST_SIZE;
-	config.rx_skip_defrag_timeout_dup_detection_check =
-		TARGET_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK;
-	config.vow_config = TARGET_VOW_CONFIG;
-	config.gtk_offload_max_vdev = TARGET_GTK_OFFLOAD_MAX_VDEV;
-	config.num_msdu_desc = TARGET_NUM_MSDU_DESC;
-	config.beacon_tx_offload_max_vdev = ab->num_radios * TARGET_MAX_BCN_OFFLD;
-	config.rx_batchmode = TARGET_RX_BATCHMODE;
-	config.peer_map_unmap_v2_support = 1;
-	config.twt_ap_pdev_count = ab->num_radios;
-	config.twt_ap_sta_count = 1000;
-
 	ab->hw_params.hw_ops->wmi_init_config(ab, &config);
 
 	memcpy(&wmi_sc->wlan_resource_config, &config, sizeof(config));
-- 
2.7.4

