Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BF043AB0D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 06:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhJZETH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 00:19:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42774 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhJZETG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 00:19:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635221802; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=s3sDeVO1mHD4Ay8Uq2UsqVL8c2A989V2TO8gSEY50aU=; b=vgieg7WkphV2DCL9r/WakGZac+F79J2huhMrqVAmwhdaIrFNxDGdCZRLNhn8jRfgfUP+g8mX
 9vHCoUPUQJCQF7O3FAC7nOoBpv9JGKM/yJhrSJAezkpf3gr8SJf9XO8W7I681GNpdwRPJhkW
 +WbSsZJ83DNdaNxN9s6R/QtG35s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6177812adaa899cf7471cb53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Oct 2021 04:16:42
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0754BC4360C; Tue, 26 Oct 2021 04:16:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from bqiang-Celadon-RN.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE74DC4338F;
        Tue, 26 Oct 2021 04:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CE74DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/7] ath11k: get msi_data again after request_irq is called
Date:   Tue, 26 Oct 2021 12:16:36 +0800
Message-Id: <20211026041636.5008-1-bqiang@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

The reservation mode of interrupts in kernel assigns a dummy vector
when the interrupt is allocated and assigns a real vector when the
request_irq is called. The reservation mode helps to ease vector
pressure when devices with a large amount of queues/interrupts
are initialized, but only a minimal subset of those queues/interrupts
is actually used.

So on reservation mode, the msi_data may change after request_irq
is called, so ath11k reads msi_data again after request_irq is called,
and then the correct msi_data is programmed into QCA6390 hardware
components. Without this change, spurious interrupt occurs in case of
one MSI vector. When VT-d in BIOS is enabled and ath11k can get 32 MSI
vectors, ath11k always get the same msi_data before and after request_irq,
that's why this change is only required when one MSI vector is to be
supported.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 3d353e7c9d5c..8691e1649d6c 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -929,6 +929,25 @@ static void ath11k_pci_free_msi(struct ath11k_pci *ab_pci)
 	pci_free_irq_vectors(ab_pci->pdev);
 }
 
+static int ath11k_pci_config_msi_data(struct ath11k_pci *ab_pci)
+{
+	struct msi_desc *msi_desc;
+
+	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
+	if (!msi_desc) {
+		ath11k_err(ab_pci->ab, "msi_desc is NULL!\n");
+		pci_free_irq_vectors(ab_pci->pdev);
+		return -EINVAL;
+	}
+
+	ab_pci->msi_ep_base_data = msi_desc->msg.data;
+
+	ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "pci after request_irq msi_ep_base_data %d\n",
+		   ab_pci->msi_ep_base_data);
+
+	return 0;
+}
+
 static int ath11k_pci_claim(struct ath11k_pci *ab_pci, struct pci_dev *pdev)
 {
 	struct ath11k_base *ab = ab_pci->ab;
@@ -1328,6 +1347,17 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_ce_free;
 	}
 
+	/* kernel may allocate a dummy vector before request_irq and
+	 * then allocate a real vector when request_irq is called.
+	 * So get msi_data here again to avoid spurious interrupt
+	 * as msi_data will configured to srngs.
+	 */
+	ret = ath11k_pci_config_msi_data(ab_pci);
+	if (ret) {
+		ath11k_err(ab, "failed to config msi_data: %d\n", ret);
+		goto err_free_irq;
+	}
+
 	ret = ath11k_core_init(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to init core: %d\n", ret);
-- 
2.25.1

