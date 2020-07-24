Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D5422BE95
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGXHFt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 03:05:49 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:28628 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgGXHFs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 03:05:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595574347; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=KEdZoSJR+ZRxgx/tXWopgh8yFdtQ4kc14lnRyIfweuM=; b=YeG/xvXo62hnCVvRNrwRyNpcX6Y+qjA+Bo+jv5zqTppEkpCgFT3zHOfhOdePgO57mkaGx3k4
 13UfQHnLTQzHniII9yBK5fhNhPzcuIk/xaVBhYAmdtvKqp4C/tqaAB0dMXAnyOFr4pupgwu7
 TqIsHaAEYreCEoLkO6n2irJqBFg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f1a88463dbcb593a9554b0f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Jul 2020 07:05:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F773C433CA; Fri, 24 Jul 2020 07:05:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51141C43395;
        Fri, 24 Jul 2020 07:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51141C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        akolli@codeaurora.org
Subject: [PATCH v5 3/3] ath11k: add IPQ6018 support
Date:   Fri, 24 Jul 2020 12:35:25 +0530
Message-Id: <1595574325-16300-4-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595574325-16300-1-git-send-email-akolli@codeaurora.org>
References: <1595574325-16300-1-git-send-email-akolli@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IPQ6018 has one 5G and one 2G radio with 2x2,
shares ipq8074 configurations.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 115 ++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/core.c |  12 ++++
 drivers/net/wireless/ath/ath11k/core.h |   1 +
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index aa74d27e5871..21f23ac75650 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -20,6 +20,9 @@ static const struct of_device_id ath11k_ahb_of_match[] = {
 	{ .compatible = "qcom,ipq8074-wifi",
 	  .data = (void *)ATH11K_HW_IPQ8074,
 	},
+	{ .compatible = "qcom,ipq6018-wifi",
+	  .data = (void *)ATH11K_HW_IPQ6018,
+	},
 	{ }
 };
 
@@ -264,6 +267,108 @@ static const struct service_to_pipe target_service_to_ce_map_wlan_ipq8074[] = {
 	{ /* terminator entry */ }
 };
 
+static const struct service_to_pipe target_service_to_ce_map_wlan_ipq6018[] = {
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
 #define ATH11K_IRQ_CE0_OFFSET 4
 
 static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
@@ -956,9 +1061,15 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ab->hw_params.svc_to_ce_map_len =
+	if (ab->hw_rev == ATH11K_HW_IPQ8074) {
+		ab->hw_params.svc_to_ce_map_len =
 			ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
-	ab->hw_params.svc_to_ce_map = target_service_to_ce_map_wlan_ipq8074;
+		ab->hw_params.svc_to_ce_map = target_service_to_ce_map_wlan_ipq8074;
+	} else if (ab->hw_rev == ATH11K_HW_IPQ6018) {
+		ab->hw_params.svc_to_ce_map_len =
+			ARRAY_SIZE(target_service_to_ce_map_wlan_ipq6018);
+		ab->hw_params.svc_to_ce_map = target_service_to_ce_map_wlan_ipq6018;
+	}
 
 	ath11k_ahb_init_qmi_ce_config(ab);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 0bf8bb1674dc..5f794f97d359 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -30,6 +30,18 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.bdf_addr = 0x4B0C0000,
 		.hw_ops = &ipq8074_ops,
 	},
+	{
+		.hw_rev = ATH11K_HW_IPQ6018,
+		.name = "ipq6018 hw1.0",
+		.fw = {
+			.dir = "IPQ6018/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_size = 256 * 1024,
+		},
+		.max_radios = 2,
+		.bdf_addr = 0x4ABC0000,
+		.hw_ops = &ipq6018_ops,
+	},
 };
 
 static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 98b994984c25..fe11fcd9e914 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -90,6 +90,7 @@ struct ath11k_skb_rxcb {
 
 enum ath11k_hw_rev {
 	ATH11K_HW_IPQ8074,
+	ATH11K_HW_IPQ6018,
 };
 
 enum ath11k_firmware_mode {
-- 
2.7.4

