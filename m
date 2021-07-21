Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72343D14FD
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 19:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhGUQj1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 12:39:27 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21235 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhGUQj0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 12:39:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626888003; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Ib2sOujqm4pVij7so2ZcxYyNd29Su/jl1soeDPFAMhQ=; b=WpPBGtZLqMNmudkCJXqgXnzUmIKhiey3nSpSkynZDs0++huSlXMJKu6iPQbm/YRHlfqFmaoK
 F5cztTlbWXw9DFPpvWgtEI0G4Q0TI+SGvLqCtM30y/7a+zuMRYcQqB+uTaHlAxyLYvYcA2Sm
 bQSBwt2x1n1oNZ9ByAg/gqWHUqk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60f85732e31d882d181dfbee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 17:19:46
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7E3BDC433D3; Wed, 21 Jul 2021 17:19:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D49A7C433D3;
        Wed, 21 Jul 2021 17:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D49A7C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/3] ath11k: add htt cmd to enable full monitor mode
Date:   Wed, 21 Jul 2021 20:19:03 +0300
Message-Id: <20210721171905.61838-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721171905.61838-1-jouni@codeaurora.org>
References: <20210721171905.61838-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

Add a new hw_param full_monitor_mode to enable full monitor support for
QCN9074. HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to the
firmware to enable the full monitor mode.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c  |  4 ++
 drivers/net/wireless/ath/ath11k/dp.h    | 74 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/dp_tx.c | 48 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/dp_tx.h |  2 +
 drivers/net/wireless/ath/ath11k/hw.h    |  1 +
 5 files changed, 129 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 969bf1a590d9..3179495cb3c9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -65,6 +65,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 					BIT(NL80211_IFTYPE_AP) |
 					BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = true,
+		.full_monitor_mode = false,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.cold_boot_calib = true,
@@ -106,6 +107,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 					BIT(NL80211_IFTYPE_AP) |
 					BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = true,
+		.full_monitor_mode = false,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.cold_boot_calib = true,
@@ -146,6 +148,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					BIT(NL80211_IFTYPE_AP),
 		.supports_monitor = false,
+		.full_monitor_mode = false,
 		.supports_shadow_regs = true,
 		.idle_ps = true,
 		.cold_boot_calib = false,
@@ -184,6 +187,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 					BIT(NL80211_IFTYPE_AP) |
 					BIT(NL80211_IFTYPE_MESH_POINT),
 		.supports_monitor = true,
+		.full_monitor_mode = true,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.cold_boot_calib = false,
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index ee768ccce46e..b39a6652d631 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -289,6 +289,7 @@ enum htt_h2t_msg_type {
 	HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG	= 0xc,
 	HTT_H2T_MSG_TYPE_EXT_STATS_CFG		= 0x10,
 	HTT_H2T_MSG_TYPE_PPDU_STATS_CFG		= 0x11,
+	HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE	= 0x17,
 };
 
 #define HTT_VER_REQ_INFO_MSG_ID		GENMASK(7, 0)
@@ -953,6 +954,79 @@ struct htt_rx_ring_tlv_filter {
 	u32 pkt_filter_flags3; /* DATA */
 };
 
+/**
+ * @brief Host-->target HTT RX Full monitor mode register configuration message
+ * @details
+ * The host will send this Full monitor mode register configuration message.
+ * This message can be sent per SOC or per PDEV which is differentiated
+ * by pdev id values.
+ *
+ *       |31                            16|15  11|10   8|7      3|2|1|0|
+ *       |-------------------------------------------------------------|
+ *       |             reserved           |   pdev_id   |  MSG_TYPE    |
+ *       |-------------------------------------------------------------|
+ *       |                      reserved         |Release Ring   |N|Z|E|
+ *       |-------------------------------------------------------------|
+ *
+ * where E  is 1-bit full monitor mode enable/disable.
+ *       Z  is 1-bit additional descriptor for zero mpdu enable/disable
+ *       N  is 1-bit additional descriptor for non zero mdpu enable/disable
+ *
+ * The following field definitions describe the format of the full monitor
+ * mode configuration message sent from the host to target for each pdev.
+ *
+ * Header fields:
+ *  dword0 - b'7:0   - msg_type: This will be set to
+ *                     HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE.
+ *           b'15:8  - pdev_id:  0 indicates msg is for all LMAC rings, i.e. soc
+ *                     1, 2, 3 indicates pdev_id 0,1,2 and the msg is for the
+ *                     specified pdev's LMAC ring.
+ *           b'31:16 - reserved : Reserved for future use.
+ *  dword1 - b'0     - full_monitor_mode enable: This indicates that the full
+ *                     monitor mode rxdma register is to be enabled or disabled.
+ *           b'1     - addnl_descs_zero_mpdus_end: This indicates that the
+ *                     additional descriptors at ppdu end for zero mpdus
+ *                     enabled or disabled.
+ *           b'2     - addnl_descs_non_zero_mpdus_end: This indicates that the
+ *                     additional descriptors at ppdu end for non zero mpdus
+ *                     enabled or disabled.
+ *           b'10:3  - release_ring: This indicates the destination ring
+ *                     selection for the descriptor at the end of PPDU
+ *                     0 - REO ring select
+ *                     1 - FW  ring select
+ *                     2 - SW  ring select
+ *                     3 - Release ring select
+ *                     Refer to htt_rx_full_mon_release_ring.
+ *           b'31:11  - reserved for future use
+ */
+
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
index 253d0564f923..2f21e3378ae1 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -1034,6 +1034,15 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
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
@@ -1100,3 +1109,42 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 
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
index 62f5978b3005..5b7ce4c7e489 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -157,6 +157,7 @@ struct ath11k_hw_params {
 
 	u16 interface_modes;
 	bool supports_monitor;
+	bool full_monitor_mode;
 	bool supports_shadow_regs;
 	bool idle_ps;
 	bool cold_boot_calib;
-- 
2.25.1

