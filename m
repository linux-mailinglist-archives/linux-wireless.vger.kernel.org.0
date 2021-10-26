Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C9443AB0F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 06:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhJZETf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 00:19:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42774 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhJZETZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 00:19:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635221813; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=27D10hZiVpDHr2tzdzyOU04mw3NAVnYAi7RyyhqSNWY=; b=UFsYuZLpt/qVjQ7ZScI7MmeQmOogvAq88SHTr7+q0+KO1ikkr1Tv2yNpFy3Le2FCoJeNkQaw
 Yx8wS2P8dpS4oHSjxjVmWwGSurf1uHYU3xk6Ed6+DKtHTvtWaWK2ps5oKMKLe/1C+cU0F/NI
 rJPHp/5vAUC4b5wlylwVZeNS50k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61778134c75c436a30c4fbb8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Oct 2021 04:16:52
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51490C4360D; Tue, 26 Oct 2021 04:16:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from bqiang-Celadon-RN.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19C04C43460;
        Tue, 26 Oct 2021 04:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 19C04C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/7] ath11k: add CE and ext IRQ flag to indicate irq_handler
Date:   Tue, 26 Oct 2021 12:16:46 +0800
Message-Id: <20211026041646.5060-1-bqiang@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

This change adds two flags to indicate whether IRQ handler for CE
and DP can be called. This is because in one MSI vector case,
interrupt is not disabled in hif_stop and hif_irq_disable. Otherwise,
MHI interrupt is disabled too.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  2 ++
 drivers/net/wireless/ath/ath11k/pci.c  | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 31d234a51c79..f2a08383d4ac 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -194,6 +194,8 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_REGISTERED,
 	ATH11K_FLAG_QMI_FAIL,
 	ATH11K_FLAG_HTC_SUSPEND_COMPLETE,
+	ATH11K_FLAG_CE_IRQ_ENABLED,
+	ATH11K_FLAG_EXT_IRQ_ENABLED,
 };
 
 enum ath11k_monitor_flags {
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 8691e1649d6c..bf8d34bc5afa 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -574,6 +574,8 @@ static void ath11k_pci_ce_irqs_disable(struct ath11k_base *ab)
 {
 	int i;
 
+	clear_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags);
+
 	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
@@ -607,6 +609,10 @@ static void ath11k_pci_ce_tasklet(struct tasklet_struct *t)
 static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ce_pipe *ce_pipe = arg;
+	struct ath11k_base *ab = ce_pipe->ab;
+
+	if (!test_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags))
+		return IRQ_HANDLED;
 
 	/* last interrupt received for this CE */
 	ce_pipe->timestamp = jiffies;
@@ -629,6 +635,8 @@ static void __ath11k_pci_ext_irq_disable(struct ath11k_base *sc)
 {
 	int i;
 
+	clear_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &sc->dev_flags);
+
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath11k_ext_irq_grp *irq_grp = &sc->ext_irq_grp[i];
 
@@ -651,6 +659,8 @@ static void ath11k_pci_ext_irq_enable(struct ath11k_base *ab)
 {
 	int i;
 
+	set_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
+
 	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
@@ -702,6 +712,10 @@ static int ath11k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 static irqreturn_t ath11k_pci_ext_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ext_irq_grp *irq_grp = arg;
+	struct ath11k_base *ab = irq_grp->ab;
+
+	if (!test_bit(ATH11K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
+		return IRQ_HANDLED;
 
 	ath11k_dbg(irq_grp->ab, ATH11K_DBG_PCI, "ext irq:%d\n", irq);
 
@@ -848,6 +862,8 @@ static void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
 {
 	int i;
 
+	set_bit(ATH11K_FLAG_CE_IRQ_ENABLED, &ab->dev_flags);
+
 	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
-- 
2.25.1

