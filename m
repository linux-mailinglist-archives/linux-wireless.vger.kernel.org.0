Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B0530AB0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 10:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiEWHqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 03:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiEWHqb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 03:46:31 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9FD18388
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653291988; x=1684827988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E3Ix6skTU/ChiwdneFC08WAQXDRPjr6009fjmvtbd8U=;
  b=ggeYrQcLlmrL1WTSSZ5SKVv5dnOsM717vocNUICdUzewGqHMN6zkRGsB
   hLTUxJ4FOjIvYzruFGTWIxqSrlc2Eg9KRBlXjJVZ0nmcmNxFZ8cXek1QT
   a0DXILzr/8eukOuX/t/35SqTUsgaiHA+p32NYZUKvwJ2eIsgBJY/sxC7s
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 22 May 2022 23:01:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 23:01:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:26 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:26 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 2/9] ath11k: add WMI resource config for EMA
Date:   Sun, 22 May 2022 23:01:01 -0700
Message-ID: <20220523060108.23982-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220523060108.23982-1-quic_alokad@quicinc.com>
References: <20220523060108.23982-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new fields in structures target_resource_config and
wmi_resource_config to configure maximum vdev count and profile
periodicity when enhanced multiple BSSID advertisements (EMA) are
enabled.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
- This patch-set splits the changes from following patch in
logical separate patches:
https://patchwork.kernel.org/project/linux-wireless/patch/20210120003221.21984-1-alokad@codeaurora.org/
And also use the latest API changes in MAC80211 which were different
at the time of V6.

 drivers/net/wireless/ath/ath11k/hw.c  |  3 +++
 drivers/net/wireless/ath/ath11k/hw.h  |  1 +
 drivers/net/wireless/ath/ath11k/wmi.c |  3 +++
 drivers/net/wireless/ath/ath11k/wmi.h | 16 ++++++++++++++++
 4 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 96db85c55585..5672def09e32 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -201,6 +201,9 @@ static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
 	config->twt_ap_pdev_count = ab->num_radios;
 	config->twt_ap_sta_count = 1000;
 	config->flag1 |= WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64;
+	config->ema_max_vap_cnt = ab->num_radios;
+	config->ema_max_profile_period = TARGET_EMA_MAX_PROFILE_PERIOD;
+	config->beacon_tx_offload_max_vdev += config->ema_max_vap_cnt;
 }
 
 static int ath11k_hw_mac_id_to_pdev_id_ipq8074(struct ath11k_hw_params *hw,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 77dc5c851c9b..a9e8d325a059 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -64,6 +64,7 @@
 #define TARGET_NUM_WDS_ENTRIES		32
 #define TARGET_DMA_BURST_SIZE		1
 #define TARGET_RX_BATCHMODE		1
+#define TARGET_EMA_MAX_PROFILE_PERIOD	8
 
 #define ATH11K_HW_MAX_QUEUES		4
 #define ATH11K_QUEUE_LEN		4096
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 84d1c7054013..b71f68d675f1 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3934,6 +3934,9 @@ ath11k_wmi_copy_resource_config(struct wmi_resource_config *wmi_cfg,
 	wmi_cfg->sched_params = tg_cfg->sched_params;
 	wmi_cfg->twt_ap_pdev_count = tg_cfg->twt_ap_pdev_count;
 	wmi_cfg->twt_ap_sta_count = tg_cfg->twt_ap_sta_count;
+	wmi_cfg->flags2 = WMI_RSRC_CFG_FLAG2_CALC_NEXT_DTIM_COUNT_SET;
+	wmi_cfg->ema_max_vap_cnt = tg_cfg->ema_max_vap_cnt;
+	wmi_cfg->ema_max_profile_period = tg_cfg->ema_max_profile_period;
 }
 
 static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b1fad4707dc6..842c074c7efa 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2308,6 +2308,7 @@ struct wmi_init_cmd {
 } __packed;
 
 #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 BIT(5)
+#define WMI_RSRC_CFG_FLAG2_CALC_NEXT_DTIM_COUNT_SET BIT(9)
 
 struct wmi_resource_config {
 	u32 tlv_header;
@@ -2368,6 +2369,18 @@ struct wmi_resource_config {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	u32 max_nlo_ssids;
+	u32 num_pkt_filters;
+	u32 num_max_sta_vdevs;
+	u32 max_bssid_indicator;
+	u32 ul_resp_config;
+	u32 msdu_flow_override_config0;
+	u32 msdu_flow_override_config1;
+	u32 flags2;
+	u32 host_service_flags;
+	u32 max_rnr_neighbours;
+	u32 ema_max_vap_cnt;
+	u32 ema_max_profile_period;
 } __packed;
 
 struct wmi_service_ready_event {
@@ -5326,6 +5339,9 @@ struct target_resource_config {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	bool is_reg_cc_ext_event_supported;
+	u32 ema_max_vap_cnt;
+	u32 ema_max_profile_period;
 };
 
 enum wmi_sys_cap_info_flags {
-- 
2.31.1

