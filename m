Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37037ABCE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhEKQYR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 12:24:17 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23522 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEKQYL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 12:24:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620750184; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hc/1p8cJTdVEDwtZzilpVuHsrAStI7FEtcQ/+B6Pr9Y=; b=KMi4KHnzQP+AqjodAeZdzqgSs8FXZ2MiRztuubAIAzL35Hv9QAhGij5j5NceXd6LN5OEtUtU
 VSNzNIbnKc0BQtLfHK8Lb67tEF9YkmmOXY+RYnhQj+yKOLDHrSEEZdbyZCxwg/RM7BJPJRt4
 BzHpMStDqB4tZlImkx7iHbd6Ohc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 609aaf5fd951beb69e6b4fb0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 May 2021 16:22:55
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 97D78C43143; Tue, 11 May 2021 16:22:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-96-12-nat.elisa-mobile.fi [85.76.96.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED88EC433D3;
        Tue, 11 May 2021 16:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED88EC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/7] ath11k: add hw reg support for WCN6855
Date:   Tue, 11 May 2021 19:22:08 +0300
Message-Id: <20210511162214.29475-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511162214.29475-1-jouni@codeaurora.org>
References: <20210511162214.29475-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

Reg address of WCN6855 is different from other devices,
so add separate reg definition for this target.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hw.c | 71 ++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h |  1 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 377ae8d5b58f..d9d7c4608052 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1688,3 +1688,74 @@ const struct ath11k_hw_regs qcn9074_regs = {
 	.pcie_qserdes_sysclk_en_sel = 0x01e0e0a8,
 	.pcie_pcs_osc_dtct_config_base = 0x01e0f45c,
 };
+
+const struct ath11k_hw_regs wcn6855_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.hal_tcl1_ring_base_lsb = 0x00000690,
+	.hal_tcl1_ring_base_msb = 0x00000694,
+	.hal_tcl1_ring_id = 0x00000698,
+	.hal_tcl1_ring_misc = 0x000006a0,
+	.hal_tcl1_ring_tp_addr_lsb = 0x000006ac,
+	.hal_tcl1_ring_tp_addr_msb = 0x000006b0,
+	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x000006c0,
+	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x000006c4,
+	.hal_tcl1_ring_msi1_base_lsb = 0x000006d8,
+	.hal_tcl1_ring_msi1_base_msb = 0x000006dc,
+	.hal_tcl1_ring_msi1_data = 0x000006e0,
+	.hal_tcl2_ring_base_lsb = 0x000006e8,
+	.hal_tcl_ring_base_lsb = 0x00000798,
+
+	/* TCL STATUS ring address */
+	.hal_tcl_status_ring_base_lsb = 0x000008a0,
+
+	/* REO2SW(x) R0 ring configuration address */
+	.hal_reo1_ring_base_lsb = 0x00000244,
+	.hal_reo1_ring_base_msb = 0x00000248,
+	.hal_reo1_ring_id = 0x0000024c,
+	.hal_reo1_ring_misc = 0x00000254,
+	.hal_reo1_ring_hp_addr_lsb = 0x00000258,
+	.hal_reo1_ring_hp_addr_msb = 0x0000025c,
+	.hal_reo1_ring_producer_int_setup = 0x00000268,
+	.hal_reo1_ring_msi1_base_lsb = 0x0000028c,
+	.hal_reo1_ring_msi1_base_msb = 0x00000290,
+	.hal_reo1_ring_msi1_data = 0x00000294,
+	.hal_reo2_ring_base_lsb = 0x0000029c,
+	.hal_reo1_aging_thresh_ix_0 = 0x000005bc,
+	.hal_reo1_aging_thresh_ix_1 = 0x000005c0,
+	.hal_reo1_aging_thresh_ix_2 = 0x000005c4,
+	.hal_reo1_aging_thresh_ix_3 = 0x000005c8,
+
+	/* REO2SW(x) R2 ring pointers (head/tail) address */
+	.hal_reo1_ring_hp = 0x00003030,
+	.hal_reo1_ring_tp = 0x00003034,
+	.hal_reo2_ring_hp = 0x00003038,
+
+	/* REO2TCL R0 ring configuration address */
+	.hal_reo_tcl_ring_base_lsb = 0x00000454,
+	.hal_reo_tcl_ring_hp = 0x00003060,
+
+	/* REO status address */
+	.hal_reo_status_ring_base_lsb = 0x0000055c,
+	.hal_reo_status_hp = 0x00003078,
+
+	/* WCSS relative address */
+	.hal_seq_wcss_umac_ce0_src_reg = 0x1b80000,
+	.hal_seq_wcss_umac_ce0_dst_reg = 0x1b81000,
+	.hal_seq_wcss_umac_ce1_src_reg = 0x1b82000,
+	.hal_seq_wcss_umac_ce1_dst_reg = 0x1b83000,
+
+	/* WBM Idle address */
+	.hal_wbm_idle_link_ring_base_lsb = 0x00000870,
+	.hal_wbm_idle_link_ring_misc = 0x00000880,
+
+	/* SW2WBM release address */
+	.hal_wbm_release_ring_base_lsb = 0x000001e8,
+
+	/* WBM2SW release address */
+	.hal_wbm0_release_ring_base_lsb = 0x00000920,
+	.hal_wbm1_release_ring_base_lsb = 0x00000978,
+
+	/* PCIe base address */
+	.pcie_qserdes_sysclk_en_sel = 0x01e0c0ac,
+	.pcie_pcs_osc_dtct_config_base = 0x01e0c628,
+};
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index c81a6328361d..4e7261c0dca1 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -318,5 +318,6 @@ struct ath11k_hw_regs {
 extern const struct ath11k_hw_regs ipq8074_regs;
 extern const struct ath11k_hw_regs qca6390_regs;
 extern const struct ath11k_hw_regs qcn9074_regs;
+extern const struct ath11k_hw_regs wcn6855_regs;
 
 #endif
-- 
2.25.1

