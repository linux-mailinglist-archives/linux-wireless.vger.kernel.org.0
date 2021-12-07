Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2609646BBDF
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 13:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhLGM6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 07:58:40 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:42646 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231748AbhLGM6j (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 07:58:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638881709; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=LrghA2BPxZFpQjzDKAGFKVXBwdp+/5HlSkw9Xdxl0cM=; b=MiymDrowWnOE8Av3tPXFYAA9ABqPB92bT3eeVwttH9qOtYG7SvsDU15nTMQk6iZ2d7i3lXw2
 Ino3EezjwVrqRwSA5TbPPwculVh9OUxz5S59TDbRs6QyicQlPC6dCTk8A8JyoydUAFTiuUAK
 Qfky/Vm7+yify+wHHEvR/AAYbMg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61af59ad903341b2e49a9525 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Dec 2021 12:55:09
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C7FBC4360D; Tue,  7 Dec 2021 12:55:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BA26C43616;
        Tue,  7 Dec 2021 12:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5BA26C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2 1/3] ath11k: Add htt cmd to enable full monitor mode
Date:   Tue,  7 Dec 2021 18:24:53 +0530
Message-Id: <1638881695-22155-2-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638881695-22155-1-git-send-email-akolli@codeaurora.org>
References: <1638881695-22155-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new hw_param full_monitor_mode is added to enable full
monitor support for QCN9074.
HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to FW
to enable the full monitor mode.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V2:
  - Rebase on latest ath.git

 drivers/net/wireless/ath/ath11k/core.c  |  5 ++++
 drivers/net/wireless/ath/ath11k/dp.h    | 28 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/dp_tx.c | 48 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/dp_tx.h |  2 ++
 drivers/net/wireless/ath/ath11k/hw.h    |  1 +
 5 files changed, 84 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index dd1a1bb078c3..072387bcdeb5 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -74,6 +74,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 					BIT(NL80211_IFTYPE_AP) |
 					BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = true,
+		.full_monitor_mode = false,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.supports_sta_ps = false,
@@ -128,6 +129,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 					BIT(NL80211_IFTYPE_AP) |
 					BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = true,
+		.full_monitor_mode = false,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.supports_sta_ps = false,
@@ -181,6 +183,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					BIT(NL80211_IFTYPE_AP),
 		.supports_monitor = false,
+		.full_monitor_mode = false,
 		.supports_shadow_regs = true,
 		.idle_ps = true,
 		.supports_sta_ps = true,
@@ -234,6 +237,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 					BIT(NL80211_IFTYPE_AP) |
 					BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = true,
+		.full_monitor_mode = true,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.supports_sta_ps = false,
@@ -287,6 +291,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					BIT(NL80211_IFTYPE_AP),
 		.supports_monitor = false,
+		.full_monitor_mode = false,
 		.supports_shadow_regs = true,
 		.idle_ps = true,
 		.supports_sta_ps = true,
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index a4c36a9be338..10f234b3f11c 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -292,6 +292,7 @@ enum htt_h2t_msg_type {
 	HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG	= 0xc,
 	HTT_H2T_MSG_TYPE_EXT_STATS_CFG		= 0x10,
 	HTT_H2T_MSG_TYPE_PPDU_STATS_CFG		= 0x11,
+	HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE	= 0x17,
 };
 
 #define HTT_VER_REQ_INFO_MSG_ID		GENMASK(7, 0)
@@ -957,6 +958,33 @@ struct htt_rx_ring_tlv_filter {
 	u32 pkt_filter_flags3; /* DATA */
 };
 
+#define HTT_RX_FULL_MON_MODE_CFG_CMD_INFO0_MSG_TYPE	GENMASK(7, 0)
+#define HTT_RX_FULL_MON_MODE_CFG_CMD_INFO0_PDEV_ID	GENMASK(15, 8)
+
+#define HTT_RX_FULL_MON_MODE_CFG_CMD_CFG_ENABLE			BIT(0)
+#define HTT_RX_FULL_MON_MODE_CFG_CMD_CFG_ZERO_MPDUS_END		BIT(1)
+#define HTT_RX_FULL_MON_MODE_CFG_CMD_CFG_NON_ZERO_MPDUS_END	BIT(2)
+#define HTT_RX_FULL_MON_MODE_CFG_CMD_CFG_RELEASE_RING		GENMASK(10, 3)
+
+/**
+ * Enumeration for full monitor mode destination ring select
+ * 0 - REO destination ring select
+ * 1 - FW destination ring select
+ * 2 - SW destination ring select
+ * 3 - Release destination ring select
+ */
+enum htt_rx_full_mon_release_ring {
+	HTT_RX_MON_RING_REO,
+	HTT_RX_MON_RING_FW,
+	HTT_RX_MON_RING_SW,
+	HTT_RX_MON_RING_RELEASE,
+};
+
+struct htt_rx_full_monitor_mode_cfg_cmd {
+	u32 info0;
+	u32 cfg;
+} __packed;
+
 /* HTT message target->host */
 
 enum htt_t2h_msg_type {
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 7587e1679ec3..8560f3b33812 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -1033,6 +1033,15 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	int ret = 0, ring_id = 0, i;
 
+	if (ab->hw_params.full_monitor_mode) {
+		ret = ath11k_dp_tx_htt_rx_full_mon_setup(ab,
+							 dp->mac_id, !reset);
+		if (ret < 0) {
+			ath11k_err(ab, "failed to setup full monitor %d\n", ret);
+			return ret;
+		}
+	}
+
 	ring_id = dp->rxdma_mon_buf_ring.refill_buf_ring.ring_id;
 
 	if (!reset) {
@@ -1098,3 +1107,42 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 
 	return ret;
 }
+
+int ath11k_dp_tx_htt_rx_full_mon_setup(struct ath11k_base *ab, int mac_id,
+				       bool config)
+{
+	struct htt_rx_full_monitor_mode_cfg_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len = sizeof(*cmd);
+
+	skb = ath11k_htc_alloc_skb(ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put(skb, len);
+	cmd = (struct htt_rx_full_monitor_mode_cfg_cmd *)skb->data;
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->info0 = FIELD_PREP(HTT_RX_FULL_MON_MODE_CFG_CMD_INFO0_MSG_TYPE,
+				HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE);
+
+	cmd->info0 |= FIELD_PREP(HTT_RX_FULL_MON_MODE_CFG_CMD_INFO0_PDEV_ID, mac_id);
+
+	cmd->cfg = HTT_RX_FULL_MON_MODE_CFG_CMD_CFG_ENABLE |
+		   FIELD_PREP(HTT_RX_FULL_MON_MODE_CFG_CMD_CFG_RELEASE_RING,
+			      HTT_RX_MON_RING_SW);
+	if (config) {
+		cmd->cfg |= HTT_RX_FULL_MON_MODE_CFG_CMD_CFG_ZERO_MPDUS_END |
+			    HTT_RX_FULL_MON_MODE_CFG_CMD_CFG_NON_ZERO_MPDUS_END;
+	}
+
+	ret = ath11k_htc_send(&ab->htc, ab->dp.eid, skb);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.h b/drivers/net/wireless/ath/ath11k/dp_tx.h
index 698b907b878d..e373dbccf417 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
@@ -37,4 +37,6 @@ int ath11k_dp_tx_htt_rx_filter_setup(struct ath11k_base *ab, u32 ring_id,
 				     int rx_buf_size,
 				     struct htt_rx_ring_tlv_filter *tlv_filter);
 
+int ath11k_dp_tx_htt_rx_full_mon_setup(struct ath11k_base *ab, int mac_id,
+				       bool config);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 2c9d232ebfed..fe6e0cb9476c 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -168,6 +168,7 @@ struct ath11k_hw_params {
 
 	u16 interface_modes;
 	bool supports_monitor;
+	bool full_monitor_mode;
 	bool supports_shadow_regs;
 	bool idle_ps;
 	bool supports_sta_ps;
-- 
2.7.4

