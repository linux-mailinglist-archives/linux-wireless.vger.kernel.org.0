Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10CA316164
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhBJIri (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:47:38 -0500
Received: from so15.mailgun.net ([198.61.254.15]:59255 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhBJIni (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946596; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4KMGq1lBGdZRiGhLlzbYrc1oHvI/ys8hGXxLJ1816xk=; b=sp0vqt+un8JX1HuAr8NlhvaQGQUXhq5uRHMBtGUBLhsJIudQh/QMzI++iuKl+zDWldkVPnXw
 wSr8Jrjpw1AdmnVnCvh4DTUNzolDY6FnW22CJ5migkbJkRSwQJ1vkxQfMjVyvjxEI7BE7Nx4
 jmC32WNUn/IduQIyKDOwEEDjkhU=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60239c838e43a988b7d13528 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:43
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A532EC4331D; Wed, 10 Feb 2021 08:42:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B935C43465;
        Wed, 10 Feb 2021 08:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B935C43465
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH 09/11] ath11k: add CE interrupt support for QCN9074
Date:   Wed, 10 Feb 2021 14:12:08 +0530
Message-Id: <1612946530-28504-10-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Define host CE configuration for QCN9074 since the max CE count is six.
Available MSI interrupt is five so cannot able to map the ce_id directly
for the msi_data_idx. Added get_ce_msi_idx ops in ath11k_hif_ops to get
the CE MSI idx which is used to initialize the CE ring.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ce.c   |  58 +++++++++-
 drivers/net/wireless/ath/ath11k/ce.h   |   1 +
 drivers/net/wireless/ath/ath11k/core.c |   6 +
 drivers/net/wireless/ath/ath11k/core.h |   2 +
 drivers/net/wireless/ath/ath11k/hif.h  |  10 ++
 drivers/net/wireless/ath/ath11k/hw.c   | 194 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.c  |  31 +++++-
 7 files changed, 294 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index 987c65010272..de8b632b058c 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -187,6 +187,59 @@ const struct ce_attr ath11k_host_ce_config_qca6390[] = {
 
 };
 
+const struct ce_attr ath11k_host_ce_config_qcn9074[] = {
+	/* CE0: host->target HTC control and raw streams */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 16,
+		.src_sz_max = 2048,
+		.dest_nentries = 0,
+	},
+
+	/* CE1: target->host HTT + HTC control */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 2048,
+		.dest_nentries = 512,
+		.recv_cb = ath11k_htc_rx_completion_handler,
+	},
+
+	/* CE2: target->host WMI */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 2048,
+		.dest_nentries = 32,
+		.recv_cb = ath11k_htc_rx_completion_handler,
+	},
+
+	/* CE3: host->target WMI (mac0) */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 32,
+		.src_sz_max = 2048,
+		.dest_nentries = 0,
+	},
+
+	/* CE4: host->target HTT */
+	{
+		.flags = CE_ATTR_FLAGS | CE_ATTR_DIS_INTR,
+		.src_nentries = 2048,
+		.src_sz_max = 256,
+		.dest_nentries = 0,
+	},
+
+	/* CE5: target->host pktlog */
+	{
+		.flags = CE_ATTR_FLAGS,
+		.src_nentries = 0,
+		.src_sz_max = 2048,
+		.dest_nentries = 512,
+		.recv_cb = ath11k_dp_htt_htc_t2h_msg_handler,
+	},
+};
+
 static bool ath11k_ce_need_shadow_fix(int ce_id)
 {
 	/* only ce4 needs shadow workaroud*/
@@ -455,7 +508,7 @@ static void ath11k_ce_srng_msi_ring_params_setup(struct ath11k_base *ab, u32 ce_
 						 struct hal_srng_params *ring_params)
 {
 	u32 msi_data_start;
-	u32 msi_data_count;
+	u32 msi_data_count, msi_data_idx;
 	u32 msi_irq_start;
 	u32 addr_lo;
 	u32 addr_hi;
@@ -469,10 +522,11 @@ static void ath11k_ce_srng_msi_ring_params_setup(struct ath11k_base *ab, u32 ce_
 		return;
 
 	ath11k_get_msi_address(ab, &addr_lo, &addr_hi);
+	ath11k_get_ce_msi_idx(ab, ce_id, &msi_data_idx);
 
 	ring_params->msi_addr = addr_lo;
 	ring_params->msi_addr |= (dma_addr_t)(((uint64_t)addr_hi) << 32);
-	ring_params->msi_data = (ce_id % msi_data_count) + msi_data_start;
+	ring_params->msi_data = (msi_data_idx % msi_data_count) + msi_data_start;
 	ring_params->flags |= HAL_SRNG_FLAGS_MSI_INTR;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index d6eeef919349..713f766cac22 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -173,6 +173,7 @@ struct ath11k_ce {
 
 extern const struct ce_attr ath11k_host_ce_config_ipq8074[];
 extern const struct ce_attr ath11k_host_ce_config_qca6390[];
+extern const struct ce_attr ath11k_host_ce_config_qcn9074[];
 
 void ath11k_ce_cleanup_pipes(struct ath11k_base *ab);
 void ath11k_ce_rx_replenish_retry(struct timer_list *t);
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a17812270c07..82b5e8c41f8f 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -164,6 +164,12 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hw_ops = &qcn9074_ops,
 		.internal_sleep_clock = false,
 		.regs = &qcn9074_regs,
+		.host_ce_config = ath11k_host_ce_config_qcn9074,
+		.ce_count = 6,
+		.target_ce_config = ath11k_target_ce_config_wlan_qcn9074,
+		.target_ce_count = 9,
+		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qcn9074,
+		.svc_to_ce_map_len = 18,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
 		.rx_mac_buf_ring = false,
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 912294f7657c..9cdc4f0b0690 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -878,6 +878,8 @@ extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq6018
 extern const struct ce_pipe_config ath11k_target_ce_config_wlan_qca6390[];
 extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_qca6390[];
 
+extern const struct ce_pipe_config ath11k_target_ce_config_wlan_qcn9074[];
+extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_qcn9074[];
 int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab);
 int ath11k_core_pre_init(struct ath11k_base *ab);
 int ath11k_core_init(struct ath11k_base *ath11k);
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index 6285c52afc44..e9366f786fbb 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -28,6 +28,7 @@ struct ath11k_hif_ops {
 				u32 *msi_addr_hi);
 	void (*ce_irq_enable)(struct ath11k_base *ab);
 	void (*ce_irq_disable)(struct ath11k_base *ab);
+	void (*get_ce_msi_idx)(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
 };
 
 static inline void ath11k_hif_ce_irq_enable(struct ath11k_base *ab)
@@ -124,4 +125,13 @@ static inline void ath11k_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_
 
 	ab->hif.ops->get_msi_address(ab, msi_addr_lo, msi_addr_hi);
 }
+
+static inline void ath11k_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id,
+					 u32 *msi_data_idx)
+{
+	if (ab->hif.ops->get_ce_msi_idx)
+		ab->hif.ops->get_ce_msi_idx(ab, ce_id, msi_data_idx);
+	else
+		*msi_data_idx = ce_id;
+}
 #endif /* _HIF_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 462d5e81bee8..c943e34c3721 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1241,6 +1241,200 @@ const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_qca6390[] = {
 	},
 };
 
+/* Target firmware's Copy Engine configuration. */
+const struct ce_pipe_config ath11k_target_ce_config_wlan_qcn9074[] = {
+	/* CE0: host->target HTC control and raw streams */
+	{
+		.pipenum = __cpu_to_le32(0),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE1: target->host HTT + HTC control */
+	{
+		.pipenum = __cpu_to_le32(1),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE2: target->host WMI */
+	{
+		.pipenum = __cpu_to_le32(2),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE3: host->target WMI */
+	{
+		.pipenum = __cpu_to_le32(3),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE4: host->target HTT */
+	{
+		.pipenum = __cpu_to_le32(4),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(256),
+		.nbytes_max = __cpu_to_le32(256),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS | CE_ATTR_DIS_INTR),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE5: target->host Pktlog */
+	{
+		.pipenum = __cpu_to_le32(5),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE6: Reserved for target autonomous hif_memcpy */
+	{
+		.pipenum = __cpu_to_le32(6),
+		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(16384),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE7 used only by Host */
+	{
+		.pipenum = __cpu_to_le32(7),
+		.pipedir = __cpu_to_le32(PIPEDIR_INOUT_H2H),
+		.nentries = __cpu_to_le32(0),
+		.nbytes_max = __cpu_to_le32(0),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS | CE_ATTR_DIS_INTR),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE8 target->host used only by IPA */
+	{
+		.pipenum = __cpu_to_le32(8),
+		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(16384),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+	/* CE 9, 10, 11 are used by MHI driver */
+};
+
+/* Map from service/endpoint to Copy Engine.
+ * This table is derived from the CE_PCI TABLE, above.
+ * It is passed to the Target at startup for use by firmware.
+ */
+const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_qcn9074[] = {
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
+		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		__cpu_to_le32(3),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
+		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		__cpu_to_le32(2),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BK),
+		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		__cpu_to_le32(3),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BK),
+		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		__cpu_to_le32(2),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BE),
+		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		__cpu_to_le32(3),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BE),
+		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		__cpu_to_le32(2),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VI),
+		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		__cpu_to_le32(3),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VI),
+		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		__cpu_to_le32(2),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL),
+		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		__cpu_to_le32(3),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL),
+		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		__cpu_to_le32(2),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_RSVD_CTRL),
+		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		__cpu_to_le32(0),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_RSVD_CTRL),
+		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		__cpu_to_le32(1),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_TEST_RAW_STREAMS),
+		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		__cpu_to_le32(0),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_TEST_RAW_STREAMS),
+		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		__cpu_to_le32(1),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_HTT_DATA_MSG),
+		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		__cpu_to_le32(4),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_HTT_DATA_MSG),
+		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		__cpu_to_le32(1),
+	},
+	{
+		__cpu_to_le32(ATH11K_HTC_SVC_ID_PKT_LOG),
+		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		__cpu_to_le32(5),
+	},
+
+	/* (Additions here) */
+
+	{ /* must be last */
+		__cpu_to_le32(0),
+		__cpu_to_le32(0),
+		__cpu_to_le32(0),
+	},
+};
+
 const struct ath11k_hw_regs ipq8074_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
 	.hal_tcl1_ring_base_lsb = 0x00000510,
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 6e60b132b7a1..fd6bbbc102ba 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -482,6 +482,23 @@ int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_nam
 	return -EINVAL;
 }
 
+static void ath11k_pci_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id,
+				      u32 *msi_idx)
+{
+	u32 i, msi_data_idx;
+
+	for (i = 0, msi_data_idx = 0; i < ab->hw_params.ce_count; i++) {
+		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		if (ce_id == i)
+			break;
+
+		msi_data_idx++;
+	}
+	*msi_idx = msi_data_idx;
+}
+
 static int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
 					  int *num_vectors, u32 *user_base_data,
 					  u32 *base_vector)
@@ -741,7 +758,7 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 {
 	struct ath11k_ce_pipe *ce_pipe;
 	u32 msi_data_start;
-	u32 msi_data_count;
+	u32 msi_data_count, msi_data_idx;
 	u32 msi_irq_start;
 	unsigned int msi_data;
 	int irq, i, ret, irq_idx;
@@ -753,14 +770,14 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 		return ret;
 
 	/* Configure CE irqs */
-	for (i = 0; i < ab->hw_params.ce_count; i++) {
-		msi_data = (i % msi_data_count) + msi_irq_start;
-		irq = ath11k_pci_get_msi_irq(ab->dev, msi_data);
-		ce_pipe = &ab->ce.ce_pipe[i];
-
+	for (i = 0, msi_data_idx = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
+		msi_data = (msi_data_idx % msi_data_count) + msi_irq_start;
+		irq = ath11k_pci_get_msi_irq(ab->dev, msi_data);
+		ce_pipe = &ab->ce.ce_pipe[i];
+
 		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
 
 		tasklet_setup(&ce_pipe->intr_tq, ath11k_pci_ce_tasklet);
@@ -775,6 +792,7 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 		}
 
 		ab->irq_num[irq_idx] = irq;
+		msi_data_idx++;
 
 		ath11k_pci_ce_irq_disable(ab, i);
 	}
@@ -1135,6 +1153,7 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.map_service_to_pipe = ath11k_pci_map_service_to_pipe,
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
+	.get_ce_msi_idx = ath11k_pci_get_ce_msi_idx,
 };
 
 static int ath11k_pci_probe(struct pci_dev *pdev,
-- 
2.7.4

