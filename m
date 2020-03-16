Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E091867D9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2020 10:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgCPJ23 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Mar 2020 05:28:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37498 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730287AbgCPJ23 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Mar 2020 05:28:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584350908; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ZEB2SH6+a8uN7LYUS+6GFuQ3rCq2asLO5SNRDhF6Beo=; b=ou+BdBS7mbzBtmNj3JmucGWDggXEEcSBEWCUenIpf5B12unFh4QbZIeoIYb2yUhwYi9v2N1t
 VVVt79Uz+YOfp2DDx1vPjbrEdCJmzbGqwboLwIQJkuY7MibEz1AaHGJfGW98HrojRdeY4oLd
 HW/Sw8XK7jmGsXAX9kOWbA4IYW0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6f46b5.7f6af0676ca8-smtp-out-n02;
 Mon, 16 Mar 2020 09:28:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80458C433D2; Mon, 16 Mar 2020 09:28:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55AA9C433CB;
        Mon, 16 Mar 2020 09:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55AA9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>
Subject: [PATCHv3 1/2] ath11k: Configure hash based reo destination ring selection
Date:   Mon, 16 Mar 2020 14:57:43 +0530
Message-Id: <1584350864-20622-2-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584350864-20622-1-git-send-email-srirrama@codeaurora.org>
References: <1584350864-20622-1-git-send-email-srirrama@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Current implementation of pdev based reo destination ring
selection is replaced by hash based ring selection so as to
ensure all the available rings are utilized for better performance.

The 4 reo destination rings are selected by the HW based on the
hash value computed from the received packet based on the 5 tuple
{ip src/ip dst/src port/dst port/protocol}. Out of the 32 hash values
used by the hw, the driver assigns 8 values per reo destination ring
to each of the 4 reo destination rings.

Signed-off-by: Sriram R <srirrama@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.c     | 17 +++++++++++++++-
 drivers/net/wireless/ath/ath11k/dp.h     |  2 +-
 drivers/net/wireless/ath/ath11k/hal.h    | 12 ++++++++++-
 drivers/net/wireless/ath/ath11k/hal_rx.c | 15 +++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.c    |  4 ++++
 drivers/net/wireless/ath/ath11k/wmi.c    | 35 ++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h    | 13 ++++++++++++
 7 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index a1371ab..b887520 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -218,6 +218,7 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 	struct ath11k_dp *dp = &ab->dp;
 	struct hal_srng *srng;
 	int i, ret;
+	u32 ring_hash_map;
 
 	ret = ath11k_dp_srng_setup(ab, &dp->wbm_desc_rel_ring,
 				   HAL_SW2WBM_RELEASE, 0, 0,
@@ -305,7 +306,21 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 		goto err;
 	}
 
-	ath11k_hal_reo_hw_setup(ab);
+	/* When hash based routing of rx packet is enabled, 32 entries to map
+	 * the hash values to the ring will be configured. Each hash entry uses
+	 * three bits to map to a particular ring. The ring mapping will be
+	 * 0:TCL, 1:SW1, 2:SW2, 3:SW3, 4:SW4, 5:Release, 6:FW and 7:Not used.
+	 */
+	ring_hash_map = HAL_HASH_ROUTING_RING_SW1 << 0 |
+			HAL_HASH_ROUTING_RING_SW2 << 3 |
+			HAL_HASH_ROUTING_RING_SW3 << 6 |
+			HAL_HASH_ROUTING_RING_SW4 << 9 |
+			HAL_HASH_ROUTING_RING_SW1 << 12 |
+			HAL_HASH_ROUTING_RING_SW2 << 15 |
+			HAL_HASH_ROUTING_RING_SW3 << 18 |
+			HAL_HASH_ROUTING_RING_SW4 << 21;
+
+	ath11k_hal_reo_hw_setup(ab, ring_hash_map);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index ed11728..7569ca5 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -160,7 +160,7 @@ struct ath11k_pdev_dp {
 #define DP_AVG_MPDUS_PER_TID_MAX 128
 #define DP_AVG_MSDUS_PER_MPDU 4
 
-#define DP_RX_HASH_ENABLE	0 /* Disable hash based Rx steering */
+#define DP_RX_HASH_ENABLE	1 /* Enable hash based Rx steering */
 
 #define DP_BA_WIN_SZ_MAX	256
 
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 4cfd934..449cd2f 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -96,6 +96,8 @@ struct ath11k_base;
 
 /* REO2SW(x) R0 ring configuration address */
 #define HAL_REO1_GEN_ENABLE			0x00000000
+#define HAL_REO1_DEST_RING_CTRL_IX_0		0x00000004
+#define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
 #define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
 #define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
 #define HAL_REO1_RING_BASE_LSB			0x0000029c
@@ -717,6 +719,14 @@ enum hal_ce_desc {
 	HAL_CE_DESC_DST_STATUS,
 };
 
+#define HAL_HASH_ROUTING_RING_TCL 0
+#define HAL_HASH_ROUTING_RING_SW1 1
+#define HAL_HASH_ROUTING_RING_SW2 2
+#define HAL_HASH_ROUTING_RING_SW3 3
+#define HAL_HASH_ROUTING_RING_SW4 4
+#define HAL_HASH_ROUTING_RING_REL 5
+#define HAL_HASH_ROUTING_RING_FW  6
+
 struct hal_reo_status_header {
 	u16 cmd_num;
 	enum hal_reo_cmd_status cmd_status;
@@ -850,7 +860,7 @@ void ath11k_hal_reo_qdesc_setup(void *vaddr, int tid, u32 ba_window_size,
 				u32 start_seq, enum hal_pn_type type);
 void ath11k_hal_reo_init_cmd_ring(struct ath11k_base *ab,
 				  struct hal_srng *srng);
-void ath11k_hal_reo_hw_setup(struct ath11k_base *ab);
+void ath11k_hal_reo_hw_setup(struct ath11k_base *ab, u32 ring_hash_map);
 void ath11k_hal_setup_link_idle_list(struct ath11k_base *ab,
 				     struct hal_wbm_idle_scatter_list *sbuf,
 				     u32 nsbufs, u32 tot_link_desc,
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 3a66656..f277c94 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -799,7 +799,7 @@ void ath11k_hal_reo_init_cmd_ring(struct ath11k_base *ab,
 	}
 }
 
-void ath11k_hal_reo_hw_setup(struct ath11k_base *ab)
+void ath11k_hal_reo_hw_setup(struct ath11k_base *ab, u32 ring_hash_map)
 {
 	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
 	u32 val;
@@ -821,6 +821,19 @@ void ath11k_hal_reo_hw_setup(struct ath11k_base *ab)
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
 	ath11k_ahb_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_3,
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
+
+	ath11k_ahb_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_0,
+			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
+				      ring_hash_map));
+	ath11k_ahb_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_1,
+			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
+				      ring_hash_map));
+	ath11k_ahb_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_2,
+			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
+				      ring_hash_map));
+	ath11k_ahb_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_3,
+			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
+				      ring_hash_map));
 }
 
 static enum hal_rx_mon_status
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c02e4a3..6123764 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3949,6 +3949,9 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 		goto err;
 	}
 
+	/* Configure the hash seed for hash based reo dest ring selection */
+	ath11k_wmi_pdev_lro_cfg(ar, ar->pdev->pdev_id);
+
 	mutex_unlock(&ar->conf_mutex);
 
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx],
@@ -5766,6 +5769,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 		ieee80211_hw_set(ar->hw, TX_AMPDU_SETUP_IN_HW);
 		ieee80211_hw_set(ar->hw, SUPPORTS_REORDERING_BUFFER);
 		ieee80211_hw_set(ar->hw, SUPPORTS_AMSDU_IN_AMPDU);
+		ieee80211_hw_set(ar->hw, USES_RSS);
 	}
 
 	ar->hw->wiphy->features |= NL80211_FEATURE_STATIC_SMPS;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5b35d06..2c0dfd7 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2917,6 +2917,41 @@ static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
 	return ret;
 }
 
+int ath11k_wmi_pdev_lro_cfg(struct ath11k *ar,
+			    int pdev_id)
+{
+	struct ath11k_wmi_pdev_lro_config_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct ath11k_wmi_pdev_lro_config_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_LRO_INFO_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	get_random_bytes(cmd->th_4, sizeof(uint32_t) * ATH11K_IPV4_TH_SEED_SIZE);
+	get_random_bytes(cmd->th_6, sizeof(uint32_t) * ATH11K_IPV6_TH_SEED_SIZE);
+
+	cmd->pdev_id = pdev_id;
+
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_LRO_CONFIG_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send lro cfg req wmi cmd\n");
+		goto err;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI lro cfg cmd pdev_id 0x%x\n", pdev_id);
+	return 0;
+err:
+	dev_kfree_skb(skb);
+	return ret;
+}
+
 int ath11k_wmi_wait_for_service_ready(struct ath11k_base *ab)
 {
 	unsigned long time_left;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 742fcd6..028d11f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4620,6 +4620,18 @@ struct wmi_obss_spatial_reuse_params_cmd {
 	u32 vdev_id;
 } __packed;
 
+#define ATH11K_IPV4_TH_SEED_SIZE 5
+#define ATH11K_IPV6_TH_SEED_SIZE 11
+
+struct ath11k_wmi_pdev_lro_config_cmd {
+	u32 tlv_header;
+	u32 lro_enable;
+	u32 res;
+	u32 th_4[ATH11K_IPV4_TH_SEED_SIZE];
+	u32 th_6[ATH11K_IPV6_TH_SEED_SIZE];
+	u32 pdev_id;
+} __packed;
+
 struct target_resource_config {
 	u32 num_vdevs;
 	u32 num_peers;
@@ -4814,4 +4826,5 @@ int ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id);
 int ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id);
 int ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar, u32 vdev_id,
 				 struct ieee80211_he_obss_pd *he_obss_pd);
+int ath11k_wmi_pdev_lro_cfg(struct ath11k *ar, int pdev_id);
 #endif
-- 
2.7.4
