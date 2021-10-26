Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15FE43AB13
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 06:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhJZEUC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 00:20:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42774 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231164AbhJZEUB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 00:20:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635221858; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=SKLngKpFsur3nfUpF13GoxuU1+g7qBfwoE4jGMjLIqo=; b=dT0Uj4+1QwZUL3pOO2Lg9pueih8ArNYXt8freOoyQUEtguw6b6+hA5bSm4za3kGbpE+5ltX2
 +/DEhnL402vKSd15aXtlfxKrCE30bkxtfAl2IWUW9sdBNJlRzhLCT6b9joj1D2ZbuSo42BZV
 ffsGYnqiegmcnb6nZJ7WBlD/nZU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6177816259612e010027cd2e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Oct 2021 04:17:38
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E317FC43616; Tue, 26 Oct 2021 04:17:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from bqiang-Celadon-RN.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 750C1C43460;
        Tue, 26 Oct 2021 04:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 750C1C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 7/7] ath11k: Set IRQ affinity to CPU0 in case of one MSI vector
Date:   Tue, 26 Oct 2021 12:17:32 +0800
Message-Id: <20211026041732.5323-1-bqiang@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With VT-d disabled on Intel platform, ath11k gets only one MSI
vector. In that case, ath11k does not free IRQ when doing suspend,
hence the kernel has to migrate it to CPU0 (if it was affine to
other CPUs) and allocates a new MSI vector. However, ath11k has
no chance to reconfig it to HW srngs during this phase, thus
ath11k fails to resume.

This issue can be fixed by setting IRQ affinity to CPU0 before
request_irq is called. With such affinity, migration will not
happen and thus the vector keeps unchanged during suspend/resume.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index b450b4ed35d1..1cad7545ceb9 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -840,6 +840,14 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 	return 0;
 }
 
+static int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci, const struct cpumask *m)
+{
+	if (!test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return irq_set_affinity_hint(ab_pci->pdev->irq, m);
+
+	return 0;
+}
+
 static int ath11k_pci_config_irq(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
@@ -856,6 +864,12 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 	if (ret)
 		return ret;
 
+	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
+	if (ret) {
+		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
+		return ret;
+	}
+
 	/* Configure CE irqs */
 	for (i = 0, msi_data_idx = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
@@ -875,7 +889,7 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 		if (ret) {
 			ath11k_err(ab, "failed to request irq %d: %d\n",
 				   irq_idx, ret);
-			return ret;
+			goto err_irq_affinity_cleanup;
 		}
 
 		ab->irq_num[irq_idx] = irq;
@@ -886,9 +900,13 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 
 	ret = ath11k_pci_ext_irq_config(ab);
 	if (ret)
-		return ret;
+		goto err_irq_affinity_cleanup;
 
 	return 0;
+
+err_irq_affinity_cleanup:
+	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
+	return ret;
 }
 
 static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
@@ -1475,6 +1493,8 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	struct ath11k_base *ab = pci_get_drvdata(pdev);
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
+	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
+
 	if (test_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags)) {
 		ath11k_pci_power_down(ab);
 		ath11k_debugfs_soc_destroy(ab);
-- 
2.25.1

