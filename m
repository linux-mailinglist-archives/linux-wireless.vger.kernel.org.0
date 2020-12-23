Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9096D2E16F0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Dec 2020 04:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgLWDD4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 22:03:56 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:45991 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbgLWDDs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 22:03:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608692602; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Cp+v/hvvHuSsDUmrcryJLVqRnc77HgvUCu3B5wnD2ck=; b=FIzDnfUqo1t9i1LKU8KpZn3oLk98704hK8IuUEtq1qfDikUfvR+ftret7Xh2j8ylXjQ2NwAS
 hEA0faCOC+S/1DuViPqJGBkd/1B2VpDAWwEny5J2Vz/Kn2kOeb+jFsJ+1pJ38UT19vwtEHR2
 N1MO1g3yhbFEWzFA4IG4EWQYuqk=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fe2b34e120d248bb52064c5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Dec 2020 03:02:38
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6BCD4C433C6; Wed, 23 Dec 2020 03:02:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53662C433ED;
        Wed, 23 Dec 2020 03:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53662C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/6] ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for dp irqx
Date:   Tue, 22 Dec 2020 22:02:22 -0500
Message-Id: <20201223030225.2345-4-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223030225.2345-1-cjhuang@codeaurora.org>
References: <20201223030225.2345-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Like ATH11K_PCI_IRQ_CE0_OFFSET, define ATH11K_PCI_IRQ_DP_OFFSET for
dp to save the irq instead of base_vector from msi config.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index deb2d47..7ec2209 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -16,7 +16,8 @@
 #define ATH11K_PCI_BAR_NUM		0
 #define ATH11K_PCI_DMA_MASK		32
 
-#define ATH11K_PCI_IRQ_CE0_OFFSET		3
+#define ATH11K_PCI_IRQ_CE0_OFFSET	3
+#define ATH11K_PCI_IRQ_DP_OFFSET	14
 
 #define WINDOW_ENABLE_BIT		0x40000000
 #define WINDOW_REG_ADDRESS		0x310c
@@ -668,7 +669,7 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 		}
 
 		irq_grp->num_irq = num_irq;
-		irq_grp->irqs[0] = base_vector + i;
+		irq_grp->irqs[0] = ATH11K_PCI_IRQ_DP_OFFSET + i;
 
 		for (j = 0; j < irq_grp->num_irq; j++) {
 			int irq_idx = irq_grp->irqs[j];
-- 
2.7.4

