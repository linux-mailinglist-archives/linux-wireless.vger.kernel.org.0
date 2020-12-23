Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98532E16EE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Dec 2020 04:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbgLWDDv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 22:03:51 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:57490 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731572AbgLWDDs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 22:03:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608692603; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ot/0oZtbqe97y4llOrqDK7mhoYrcCMKkAUi3OEmnWu8=; b=sEhE7EuNsnmBI/NebvU3uQXgTXGUIRtcUWeErjwCgIywqz6WtRspfdmhxZ5ZOAjvvsB/68nY
 EWrCttvfbEG/Xe6Y9jzUoBR4N4wvUCMtW0UflIY3ihTQaPAo0x/LQKbKYr22eM4+yISeX4mA
 h+Vkcb2eoUBjtaotUdqxNBmwvCg=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fe2b34db00c0d7ad4a75f98 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Dec 2020 03:02:37
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4114FC433C6; Wed, 23 Dec 2020 03:02:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FBB0C43461;
        Wed, 23 Dec 2020 03:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FBB0C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/6] ath11k: add ce and ext irq flag to indicate irq_handler
Date:   Tue, 22 Dec 2020 22:02:21 -0500
Message-Id: <20201223030225.2345-3-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223030225.2345-1-cjhuang@codeaurora.org>
References: <20201223030225.2345-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This change adds two flags to indicate whether irq handler for CE
and dp can be called. This is because in one MSI vector case,
interrupt is not disabled in hif_stop and hif_irq_disable. Otherwise,
MHI interrupt is disabled too.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  2 ++
 drivers/net/wireless/ath/ath11k/pci.c  | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 799bf3d..3dacca5 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -741,6 +741,8 @@ struct ath11k_base {
 
 	struct completion htc_suspend;
 
+	bool ce_irq_enabled_flag;
+	bool ext_irq_enabled_flag;
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index c1ae1df..deb2d47 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -487,6 +487,8 @@ static void ath11k_pci_ce_irqs_disable(struct ath11k_base *ab)
 {
 	int i;
 
+	ab->ce_irq_enabled_flag = false;
+
 	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
@@ -521,6 +523,9 @@ static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ce_pipe *ce_pipe = arg;
 
+	if (!ab->ce_irq_enabled_flag)
+		return IRQ_HANDLED;
+
 	ath11k_pci_ce_irq_disable(ce_pipe->ab, ce_pipe->pipe_num);
 	tasklet_schedule(&ce_pipe->intr_tq);
 
@@ -539,6 +544,8 @@ static void __ath11k_pci_ext_irq_disable(struct ath11k_base *sc)
 {
 	int i;
 
+	ab->ext_irq_enabled_flag = false;
+
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath11k_ext_irq_grp *irq_grp = &sc->ext_irq_grp[i];
 
@@ -561,6 +568,8 @@ static void ath11k_pci_ext_irq_enable(struct ath11k_base *ab)
 {
 	int i;
 
+	ab->ext_irq_enabled_flag = true;
+
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
@@ -613,6 +622,9 @@ static irqreturn_t ath11k_pci_ext_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ext_irq_grp *irq_grp = arg;
 
+	if (!irq_grp->ab->ext_irq_enabled_flag)
+		return IRQ_HANDLED;
+
 	ath11k_dbg(irq_grp->ab, ATH11K_DBG_PCI, "ext irq:%d\n", irq);
 
 	ath11k_pci_ext_grp_disable(irq_grp);
@@ -1026,6 +1038,7 @@ static int ath11k_pci_start(struct ath11k_base *ab)
 	set_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
 
 	ath11k_pci_aspm_restore(ab_pci);
+	ab->ce_irq_enabled_flag = true;
 
 	ath11k_pci_ce_irqs_enable(ab);
 	ath11k_ce_rx_post_buf(ab);
-- 
2.7.4

