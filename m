Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B5D409BAE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbhIMSEv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 14:04:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30640 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235868AbhIMSEv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 14:04:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631556215; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jv8bQGeZ41RIMqdQj1FGk47Jpd/siyCfxBzIJ7dFueQ=; b=kgv+JltRkay+57GzxZ9CgbOU2iwKI228GOEqRgpXG3fb5ZX4UAdqCypBMpLAeNOHsrBdjF0P
 OQdIF76e96AuEz+idYVvCt41PiIllwT7mM0k7unc/PpRqapceR46Rsj98MK/4NJgnju6AbDg
 zdE8D1lR6lFK9U/rpt6W8vhwuww=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 613f925cec62f57c9a2ba1d0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 18:03:08
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98B7EC4360D; Mon, 13 Sep 2021 18:03:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80BBDC43617;
        Mon, 13 Sep 2021 18:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 80BBDC43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 5/5] ath11k: Handle MSI enablement during rmmod and SSR
Date:   Mon, 13 Sep 2021 21:02:46 +0300
Message-Id: <20210913180246.193388-5-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913180246.193388-1-jouni@codeaurora.org>
References: <20210913180246.193388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

When doing "rmmod ath11k_pci", ath11k performs global SOC reset
and MHI reset, where 0 address access is captured by IOMMU. See
log below:

...
[  133.953860] ath11k_pci 0000:02:00.0: setting mhi state: DEINIT(1)
[  133.959714] ath11k_pci 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000a address=0x0 flags=0x0020]
[  133.973854] ath11k_pci 0000:02:00.0: MHISTATUS 0xff04
[  133.974095] ath11k_pci 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000a address=0x0 flags=0x0020]
...

This issue is also observed in SSR process, cause a similar
sequence as above is performed.

Such an invalid access occurs because, during rmmod or SSR, MSI
address is cleared but HW MSI functionality not disabled, thus HW
target is able to raise an MSI transaction with 0 as MSI address.

So it can be fixed by simply disabling MSI before reset. For SSR,
since MSI functionality is still needed after target is brought
back, we need to reenable it.

Also change naming of some interfaces related.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 7b3bce0ba76e..1094b53465bc 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -855,7 +855,18 @@ static void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
 	}
 }
 
-static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
+static void ath11k_pci_enable_msi(struct pci_dev *dev, bool enable)
+{
+	u16 control;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
+	control &= ~PCI_MSI_FLAGS_ENABLE;
+	if (enable)
+		control |= PCI_MSI_FLAGS_ENABLE;
+	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
+}
+
+static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 {
 	struct ath11k_base *ab = ab_pci->ab;
 	const struct ath11k_msi_config *msi_config = ab_pci->msi_config;
@@ -876,6 +887,7 @@ static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
 		else
 			return num_vectors;
 	}
+	ath11k_pci_enable_msi(ab_pci->pdev, false);
 
 	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
 	if (!msi_desc) {
@@ -898,7 +910,7 @@ static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
 	return ret;
 }
 
-static void ath11k_pci_disable_msi(struct ath11k_pci *ab_pci)
+static void ath11k_pci_free_msi(struct ath11k_pci *ab_pci)
 {
 	pci_free_irq_vectors(ab_pci->pdev);
 }
@@ -1019,6 +1031,8 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 	 */
 	ath11k_pci_aspm_disable(ab_pci);
 
+	ath11k_pci_enable_msi(ab_pci->pdev, true);
+
 	ret = ath11k_mhi_start(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to start mhi: %d\n", ret);
@@ -1039,6 +1053,9 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 	ath11k_pci_aspm_restore(ab_pci);
 
 	ath11k_pci_force_wake(ab_pci->ab);
+
+	ath11k_pci_enable_msi(ab_pci->pdev, false);
+
 	ath11k_mhi_stop(ab_pci);
 	clear_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
 	ath11k_pci_sw_reset(ab_pci->ab, false);
@@ -1263,7 +1280,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_pci_free_region;
 	}
 
-	ret = ath11k_pci_enable_msi(ab_pci);
+	ret = ath11k_pci_alloc_msi(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to enable msi: %d\n", ret);
 		goto err_pci_free_region;
@@ -1317,7 +1334,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	ath11k_mhi_unregister(ab_pci);
 
 err_pci_disable_msi:
-	ath11k_pci_disable_msi(ab_pci);
+	ath11k_pci_free_msi(ab_pci);
 
 err_pci_free_region:
 	ath11k_pci_free_region(ab_pci);
@@ -1348,7 +1365,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 	ath11k_mhi_unregister(ab_pci);
 
 	ath11k_pci_free_irq(ab);
-	ath11k_pci_disable_msi(ab_pci);
+	ath11k_pci_free_msi(ab_pci);
 	ath11k_pci_free_region(ab_pci);
 
 	ath11k_hal_srng_deinit(ab);
-- 
2.25.1

