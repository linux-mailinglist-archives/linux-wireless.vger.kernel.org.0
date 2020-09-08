Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59638260CA0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgIHHzh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 03:55:37 -0400
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:56904
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbgIHHzg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 03:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599551735;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=rkwOvS/PAYRBxfOyJ0c5DJIjYB05ezniCcLS/lnMgNE=;
        b=maea9CFB/71TGM2m4IKNYP5qyzt4EwSZdYwCsm29VAiVnPoO0ly36Wr5tqCZO+8l
        hQbl1IfajJS4sJuMfsjT+kid9O6ODndfhInkMGP9isU1KEby5O1Kc9iJ14EDrCAiEB3
        8e0X6tqrI5WIlB3JcaWlstwg7TNdVvgeBULVDpQ0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599551735;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=rkwOvS/PAYRBxfOyJ0c5DJIjYB05ezniCcLS/lnMgNE=;
        b=Uo4QpPj/jLMMlwcl/OMig0uaojjtu/VbTcGrp++QRznDduGK7Z9efT0BJFCwwq/p
        ZkltMI7ZuO/swQmR8EbHfDZtO5K0XeWnWsodO8rR74sgYIni8d9/fsF8uZUb9VhpJjY
        KCc14V3lBy2Dj1yxnsKvZagggjgdMsz6r8nGPDkc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB01DC433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v7 2/3] ath11k: move target ce configs to hw_params
Date:   Tue, 8 Sep 2020 07:55:35 +0000
Message-ID: <010101746cb685d9-6bedeccb-29a1-4d32-8664-fcfe7d105f4a-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599551717-3801-1-git-send-email-akolli@codeaurora.org>
References: <1599551717-3801-1-git-send-email-akolli@codeaurora.org>
X-SES-Outgoing: 2020.09.08-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move target CE config and target CE service config to hw_params.
No functional changes.

Tested on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1 

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V3:
 - added ce svc configs in hw_params
V7:
 - Move ce target configs to hw.c to remove hw_rev checks in code(Julian, Kalle)

 drivers/net/wireless/ath/ath11k/ahb.c  | 254 +-------------------
 drivers/net/wireless/ath/ath11k/core.c |   8 +
 drivers/net/wireless/ath/ath11k/core.h |   6 +
 drivers/net/wireless/ath/ath11k/hw.c   | 410 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |   5 +-
 drivers/net/wireless/ath/ath11k/pci.c  | 193 +---------------
 6 files changed, 442 insertions(+), 434 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 6380d48e013d..2e59dd9025ee 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -32,244 +32,6 @@ static const struct ath11k_bus_params ath11k_ahb_bus_params = {
 	.fixed_mem_region = true,
 };
 
-/* Target firmware's Copy Engine configuration. */
-static const struct ce_pipe_config target_ce_config_wlan[] = {
-	/* CE0: host->target HTC control and raw streams */
-	{
-		.pipenum = __cpu_to_le32(0),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE1: target->host HTT + HTC control */
-	{
-		.pipenum = __cpu_to_le32(1),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE2: target->host WMI */
-	{
-		.pipenum = __cpu_to_le32(2),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE3: host->target WMI */
-	{
-		.pipenum = __cpu_to_le32(3),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE4: host->target HTT */
-	{
-		.pipenum = __cpu_to_le32(4),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
-		.nentries = __cpu_to_le32(256),
-		.nbytes_max = __cpu_to_le32(256),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS | CE_ATTR_DIS_INTR),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE5: target->host Pktlog */
-	{
-		.pipenum = __cpu_to_le32(5),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(0),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE6: Reserved for target autonomous hif_memcpy */
-	{
-		.pipenum = __cpu_to_le32(6),
-		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(65535),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE7 used only by Host */
-	{
-		.pipenum = __cpu_to_le32(7),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE8 target->host used only by IPA */
-	{
-		.pipenum = __cpu_to_le32(8),
-		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(65535),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE9 host->target HTT */
-	{
-		.pipenum = __cpu_to_le32(9),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE10 target->host HTT */
-	{
-		.pipenum = __cpu_to_le32(10),
-		.pipedir = __cpu_to_le32(PIPEDIR_INOUT_H2H),
-		.nentries = __cpu_to_le32(0),
-		.nbytes_max = __cpu_to_le32(0),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE11 Not used */
-	{
-		.pipenum = __cpu_to_le32(0),
-		.pipedir = __cpu_to_le32(0),
-		.nentries = __cpu_to_le32(0),
-		.nbytes_max = __cpu_to_le32(0),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-};
-
-/* Map from service/endpoint to Copy Engine.
- * This table is derived from the CE_PCI TABLE, above.
- * It is passed to the Target at startup for use by firmware.
- */
-static const struct service_to_pipe target_service_to_ce_map_wlan[] = {
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		.pipenum = __cpu_to_le32(3),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(2),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BK),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		.pipenum = __cpu_to_le32(3),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BK),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(2),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BE),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		.pipenum = __cpu_to_le32(3),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BE),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(2),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VI),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		.pipenum = __cpu_to_le32(3),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VI),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(2),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		.pipenum = __cpu_to_le32(3),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(2),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL_MAC1),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		.pipenum = __cpu_to_le32(7),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL_MAC1),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(2),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL_MAC2),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		.pipenum = __cpu_to_le32(9),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL_MAC2),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(2),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_RSVD_CTRL),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		.pipenum = __cpu_to_le32(0),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_RSVD_CTRL),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(1),
-	},
-	{ /* not used */
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_TEST_RAW_STREAMS),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		.pipenum = __cpu_to_le32(0),
-	},
-	{ /* not used */
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_TEST_RAW_STREAMS),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(1),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_HTT_DATA_MSG),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		.pipenum = __cpu_to_le32(4),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_HTT_DATA_MSG),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(1),
-	},
-	{
-		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_PKT_LOG),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		.pipenum = __cpu_to_le32(5),
-	},
-
-	/* (Additions here) */
-
-	{ /* terminator entry */ }
-};
 
 #define ATH11K_IRQ_CE0_OFFSET 4
 
@@ -444,7 +206,7 @@ static void ath11k_ahb_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
 {
 	const struct ce_pipe_config *ce_config;
 
-	ce_config = &target_ce_config_wlan[ce_id];
+	ce_config = &ab->hw_params.target_ce_config[ce_id];
 	if (__le32_to_cpu(ce_config->pipedir) & PIPEDIR_OUT)
 		ath11k_ahb_setbit32(ab, ce_id, CE_HOST_IE_ADDRESS);
 
@@ -459,7 +221,7 @@ static void ath11k_ahb_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
 {
 	const struct ce_pipe_config *ce_config;
 
-	ce_config = &target_ce_config_wlan[ce_id];
+	ce_config = &ab->hw_params.target_ce_config[ce_id];
 	if (__le32_to_cpu(ce_config->pipedir) & PIPEDIR_OUT)
 		ath11k_ahb_clearbit32(ab, ce_id, CE_HOST_IE_ADDRESS);
 
@@ -577,10 +339,10 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
 {
 	struct ath11k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
 
-	cfg->tgt_ce_len = ARRAY_SIZE(target_ce_config_wlan) - 1;
-	cfg->tgt_ce = target_ce_config_wlan;
-	cfg->svc_to_ce_map_len = ARRAY_SIZE(target_service_to_ce_map_wlan);
-	cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
+	cfg->tgt_ce_len = ab->hw_params.target_ce_count;
+	cfg->tgt_ce = ab->hw_params.target_ce_config;
+	cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
+	cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
 	ab->qmi.service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074;
 }
 
@@ -788,8 +550,8 @@ static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
 	bool ul_set = false, dl_set = false;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(target_service_to_ce_map_wlan); i++) {
-		entry = &target_service_to_ce_map_wlan[i];
+	for (i = 0; i < ab->hw_params.svc_to_ce_map_len; i++) {
+		entry = &ab->hw_params.svc_to_ce_map[i];
 
 		if (__le32_to_cpu(entry->service_id) != service_id)
 			continue;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 437b1123a34f..bdde8764c796 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -35,6 +35,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.regs = &ipq8074_regs,
 		.host_ce_config = ath11k_host_ce_config_ipq8074,
 		.ce_count = 12,
+		.target_ce_config = ath11k_target_ce_config_wlan_ipq8074,
+		.target_ce_count = 11,
+		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq8074,
+		.svc_to_ce_map_len = 21,
 		.single_pdev_only = false,
 		.needs_band_to_mac = true,
 		.rxdma1_enable = true,
@@ -60,6 +64,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.regs = &qca6390_regs,
 		.host_ce_config = ath11k_host_ce_config_qca6390,
 		.ce_count = 9,
+		.target_ce_config = ath11k_target_ce_config_wlan_qca6390,
+		.target_ce_count = 9,
+		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
+		.svc_to_ce_map_len = 14,
 		.single_pdev_only = true,
 		.needs_band_to_mac = false,
 		.rxdma1_enable = false,
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index d21191c51e10..cb6c5e42732d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -845,6 +845,12 @@ struct ath11k_fw_stats_bcn {
 	u32 tx_bcn_outage_cnt;
 };
 
+extern const struct ce_pipe_config ath11k_target_ce_config_wlan_ipq8074[];
+extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq8074[];
+
+extern const struct ce_pipe_config ath11k_target_ce_config_wlan_qca6390[];
+extern const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_qca6390[];
+
 void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id);
 void ath11k_peer_map_event(struct ath11k_base *ab, u8 vdev_id, u16 peer_id,
 			   u8 *mac_addr, u16 ast_hash);
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index e0788994ea22..35cbb1338d43 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -276,6 +276,416 @@ const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390 = {
 	},
 };
 
+/* Target firmware's Copy Engine configuration. */
+const struct ce_pipe_config ath11k_target_ce_config_wlan_ipq8074[] = {
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
+		.flags = __cpu_to_le32(0),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE6: Reserved for target autonomous hif_memcpy */
+	{
+		.pipenum = __cpu_to_le32(6),
+		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(65535),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE7 used only by Host */
+	{
+		.pipenum = __cpu_to_le32(7),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE8 target->host used only by IPA */
+	{
+		.pipenum = __cpu_to_le32(8),
+		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(65535),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE9 host->target HTT */
+	{
+		.pipenum = __cpu_to_le32(9),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
+		.nentries = __cpu_to_le32(32),
+		.nbytes_max = __cpu_to_le32(2048),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE10 target->host HTT */
+	{
+		.pipenum = __cpu_to_le32(10),
+		.pipedir = __cpu_to_le32(PIPEDIR_INOUT_H2H),
+		.nentries = __cpu_to_le32(0),
+		.nbytes_max = __cpu_to_le32(0),
+		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
+		.reserved = __cpu_to_le32(0),
+	},
+
+	/* CE11 Not used */
+};
+
+/* Map from service/endpoint to Copy Engine.
+ * This table is derived from the CE_PCI TABLE, above.
+ * It is passed to the Target at startup for use by firmware.
+ */
+const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq8074[] = {
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum = __cpu_to_le32(3),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(2),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BK),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum = __cpu_to_le32(3),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BK),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(2),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BE),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum = __cpu_to_le32(3),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BE),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(2),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VI),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum = __cpu_to_le32(3),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VI),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(2),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum = __cpu_to_le32(3),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(2),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL_MAC1),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum = __cpu_to_le32(7),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL_MAC1),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(2),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL_MAC2),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum = __cpu_to_le32(9),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL_MAC2),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(2),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_RSVD_CTRL),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum = __cpu_to_le32(0),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_RSVD_CTRL),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(1),
+	},
+	{ /* not used */
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_TEST_RAW_STREAMS),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum = __cpu_to_le32(0),
+	},
+	{ /* not used */
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_TEST_RAW_STREAMS),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(1),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_HTT_DATA_MSG),
+		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
+		.pipenum = __cpu_to_le32(4),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_HTT_DATA_MSG),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(1),
+	},
+	{
+		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_PKT_LOG),
+		.pipedir = __cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
+		.pipenum = __cpu_to_le32(5),
+	},
+
+	/* (Additions here) */
+
+	{ /* terminator entry */ }
+};
+
+/* Target firmware's Copy Engine configuration. */
+const struct ce_pipe_config ath11k_target_ce_config_wlan_qca6390[] = {
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
+const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_qca6390[] = {
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
+		__cpu_to_le32(2),
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
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index d15fa7fd6d5d..57960a7c09a4 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -129,7 +129,6 @@ struct ath11k_hw_params {
 	} fw;
 
 	const struct ath11k_hw_ops *hw_ops;
-
 	const struct ath11k_hw_ring_mask *ring_mask;
 
 	bool internal_sleep_clock;
@@ -137,6 +136,10 @@ struct ath11k_hw_params {
 	const struct ath11k_hw_regs *regs;
 	const struct ce_attr *host_ce_config;
 	u32 ce_count;
+	const struct ce_pipe_config *target_ce_config;
+	u32 target_ce_count;
+	const struct service_to_pipe *svc_to_ce_map;
+	u32 svc_to_ce_map_len;
 
 	bool single_pdev_only;
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 058885776a3a..aec0b593c6a7 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -51,187 +51,6 @@ static const struct ath11k_msi_config msi_config = {
 	},
 };
 
-/* Target firmware's Copy Engine configuration. */
-static const struct ce_pipe_config target_ce_config_wlan[] = {
-	/* CE0: host->target HTC control and raw streams */
-	{
-		.pipenum = __cpu_to_le32(0),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE1: target->host HTT + HTC control */
-	{
-		.pipenum = __cpu_to_le32(1),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE2: target->host WMI */
-	{
-		.pipenum = __cpu_to_le32(2),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE3: host->target WMI */
-	{
-		.pipenum = __cpu_to_le32(3),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE4: host->target HTT */
-	{
-		.pipenum = __cpu_to_le32(4),
-		.pipedir = __cpu_to_le32(PIPEDIR_OUT),
-		.nentries = __cpu_to_le32(256),
-		.nbytes_max = __cpu_to_le32(256),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS | CE_ATTR_DIS_INTR),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE5: target->host Pktlog */
-	{
-		.pipenum = __cpu_to_le32(5),
-		.pipedir = __cpu_to_le32(PIPEDIR_IN),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(2048),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE6: Reserved for target autonomous hif_memcpy */
-	{
-		.pipenum = __cpu_to_le32(6),
-		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(16384),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE7 used only by Host */
-	{
-		.pipenum = __cpu_to_le32(7),
-		.pipedir = __cpu_to_le32(PIPEDIR_INOUT_H2H),
-		.nentries = __cpu_to_le32(0),
-		.nbytes_max = __cpu_to_le32(0),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS | CE_ATTR_DIS_INTR),
-		.reserved = __cpu_to_le32(0),
-	},
-
-	/* CE8 target->host used only by IPA */
-	{
-		.pipenum = __cpu_to_le32(8),
-		.pipedir = __cpu_to_le32(PIPEDIR_INOUT),
-		.nentries = __cpu_to_le32(32),
-		.nbytes_max = __cpu_to_le32(16384),
-		.flags = __cpu_to_le32(CE_ATTR_FLAGS),
-		.reserved = __cpu_to_le32(0),
-	},
-	/* CE 9, 10, 11 are used by MHI driver */
-};
-
-/* Map from service/endpoint to Copy Engine.
- * This table is derived from the CE_PCI TABLE, above.
- * It is passed to the Target at startup for use by firmware.
- */
-static const struct service_to_pipe target_service_to_ce_map_wlan[] = {
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
-		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		__cpu_to_le32(3),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
-		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		__cpu_to_le32(2),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BK),
-		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		__cpu_to_le32(3),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BK),
-		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		__cpu_to_le32(2),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BE),
-		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		__cpu_to_le32(3),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_BE),
-		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		__cpu_to_le32(2),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VI),
-		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		__cpu_to_le32(3),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VI),
-		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		__cpu_to_le32(2),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL),
-		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		__cpu_to_le32(3),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_CONTROL),
-		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		__cpu_to_le32(2),
-	},
-
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_RSVD_CTRL),
-		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		__cpu_to_le32(0),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_RSVD_CTRL),
-		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		__cpu_to_le32(2),
-	},
-
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_HTT_DATA_MSG),
-		__cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
-		__cpu_to_le32(4),
-	},
-	{
-		__cpu_to_le32(ATH11K_HTC_SVC_ID_HTT_DATA_MSG),
-		__cpu_to_le32(PIPEDIR_IN),	/* in = DL = target -> host */
-		__cpu_to_le32(1),
-	},
-
-	/* (Additions here) */
-
-	{ /* must be last */
-		__cpu_to_le32(0),
-		__cpu_to_le32(0),
-		__cpu_to_le32(0),
-	},
-};
-
 static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
 	"bhi",
 	"mhi-er0",
@@ -757,11 +576,11 @@ static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
 {
 	struct ath11k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
 
-	cfg->tgt_ce = target_ce_config_wlan;
-	cfg->tgt_ce_len = ARRAY_SIZE(target_ce_config_wlan);
+	cfg->tgt_ce = ab->hw_params.target_ce_config;
+	cfg->tgt_ce_len = ab->hw_params.target_ce_count;
 
-	cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
-	cfg->svc_to_ce_map_len = ARRAY_SIZE(target_service_to_ce_map_wlan);
+	cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
+	cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
 	ab->qmi.service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390;
 }
 
@@ -965,8 +784,8 @@ static int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
 	bool ul_set = false, dl_set = false;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(target_service_to_ce_map_wlan); i++) {
-		entry = &target_service_to_ce_map_wlan[i];
+	for (i = 0; i < ab->hw_params.svc_to_ce_map_len; i++) {
+		entry = &ab->hw_params.svc_to_ce_map[i];
 
 		if (__le32_to_cpu(entry->service_id) != service_id)
 			continue;
-- 
2.7.4

