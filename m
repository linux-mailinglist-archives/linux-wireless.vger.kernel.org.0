Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD831615E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhBJIrN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:47:13 -0500
Received: from so15.mailgun.net ([198.61.254.15]:60099 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhBJInf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946580; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=SYg/XrSIBtJw/DAkLJFryOpQMUJWF97XRfn4q28tbR0=; b=bitchxGezldK2khM4RhVAI3jT9yNcpG8jNdqwm2bW9NdMxFRcprxMPA2nP5O9qO9Nd+1Rrb2
 AKE2nUp3BUuO757/S6GOt5Uut2TiHEmSyZhIgfjvcWKkzsIOyjA44k0ljKjhizMgUfm86ZS/
 jIZdco6HLptknvaoQDQzw4m1XoQ=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60239c73d5a7a3baae3cd0b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:27
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF8A4C43461; Wed, 10 Feb 2021 08:42:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8515EC433CA;
        Wed, 10 Feb 2021 08:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8515EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 02/11] ath11k: Move qmi service_ins_id to hw_params
Date:   Wed, 10 Feb 2021 14:12:01 +0530
Message-Id: <1612946530-28504-3-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

qmi service_ins_id is unique for QCA6390 and QCN9074,
this is needed for adding QCN9074 support. No functional
changes.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 2 +-
 drivers/net/wireless/ath/ath11k/core.c | 3 +++
 drivers/net/wireless/ath/ath11k/hw.h   | 1 +
 drivers/net/wireless/ath/ath11k/pci.c  | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index d4ef45cd0685..8c9c781afc3e 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -373,7 +373,7 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
 	cfg->tgt_ce = ab->hw_params.target_ce_config;
 	cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
 	cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
-	ab->qmi.service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074;
+	ab->qmi.service_ins_id = ab->hw_params.qmi_service_ins_id;
 }
 
 static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 350b7913622c..9ccc7231afa0 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -45,6 +45,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
 		.internal_sleep_clock = false,
 		.regs = &ipq8074_regs,
+		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074,
 		.host_ce_config = ath11k_host_ce_config_ipq8074,
 		.ce_count = 12,
 		.target_ce_config = ath11k_target_ce_config_wlan_ipq8074,
@@ -83,6 +84,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
 		.internal_sleep_clock = false,
 		.regs = &ipq8074_regs,
+		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074,
 		.host_ce_config = ath11k_host_ce_config_ipq8074,
 		.ce_count = 12,
 		.target_ce_config = ath11k_target_ce_config_wlan_ipq8074,
@@ -121,6 +123,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ring_mask = &ath11k_hw_ring_mask_qca6390,
 		.internal_sleep_clock = true,
 		.regs = &qca6390_regs,
+		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390,
 		.host_ce_config = ath11k_host_ce_config_qca6390,
 		.ce_count = 9,
 		.target_ce_config = ath11k_target_ce_config_wlan_qca6390,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 8af0034fdb05..94c36e6149cf 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -134,6 +134,7 @@ struct ath11k_hw_params {
 	bool internal_sleep_clock;
 
 	const struct ath11k_hw_regs *regs;
+	u32 qmi_service_ins_id;
 	const struct ce_attr *host_ce_config;
 	u32 ce_count;
 	const struct ce_pipe_config *target_ce_config;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 0c6a6e7ef252..5edcb1ef9523 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -743,7 +743,7 @@ static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
 
 	cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
 	cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
-	ab->qmi.service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390;
+	ab->qmi.service_ins_id = ab->hw_params.qmi_service_ins_id;
 
 	ath11k_ce_get_shadow_config(ab, &cfg->shadow_reg_v2,
 				    &cfg->shadow_reg_v2_len);
-- 
2.7.4

