Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B082C1E3D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 07:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgKXG3N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 01:29:13 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:63791 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgKXG3N (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 01:29:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606199352; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ngU1uLLBA6qMsX5Zz6zJy+WGAWNr5Ww8c2/wClYtjW0=; b=CY3uls2fp1ZKi+BNcGsTA+YP8ehg3XvaJSPOtQYS3uG9dwdRcvdqHpfZnRfU1xYecm8Edbmj
 MNCl2+qHmN11d+wuaiHtDqys1WBF0ObtVtG0MGMwMHUbXpDibXK1mFV6BizCBED3+J+La2b5
 qqZeieHRmq0zzYaw8rGZfNLgYms=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fbca834a5a29b56a196994b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 06:29:08
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C25CC433C6; Tue, 24 Nov 2020 06:29:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DFE3C433ED;
        Tue, 24 Nov 2020 06:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DFE3C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2] ath11k: add 64bit check before reading msi high addr
Date:   Tue, 24 Nov 2020 11:58:54 +0530
Message-Id: <1606199334-18206-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In QCN9074 ath11k boot, firmware crash is observed in 64-bit
builds and is due to wrong 64 bit MSI address size. This patch
fixes the firmware crash. Read msi high addr if 64-bit addresses
allowed on MSI.

Tested-On: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V2:
  - Fixes compilation issues

 drivers/net/wireless/ath/ath11k/pci.c | 11 +++++++++--
 drivers/net/wireless/ath/ath11k/pci.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index b75f47dc36de..54ac0a861063 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -264,13 +264,18 @@ int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
 static void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
 				       u32 *msi_addr_hi)
 {
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
 
 	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
 			      msi_addr_lo);
 
-	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
-			      msi_addr_hi);
+	if (test_bit(ATH11K_PCI_FLAG_IS_MSI_64, &ab_pci->flags)) {
+		pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
+				      msi_addr_hi);
+	} else {
+		*msi_addr_hi = 0;
+	}
 }
 
 int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_name,
@@ -658,6 +663,8 @@ static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
 	}
 
 	ab_pci->msi_ep_base_data = msi_desc->msg.data;
+	if (msi_desc->msi_attrib.is_64)
+		set_bit(ATH11K_PCI_FLAG_IS_MSI_64, &ab_pci->flags);
 
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", ab_pci->msi_ep_base_data);
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 43562f774a37..9c503a17c237 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -38,6 +38,7 @@ struct ath11k_msi_config {
 
 enum ath11k_pci_flags {
 	ATH11K_PCI_FLAG_INIT_DONE,
+	ATH11K_PCI_FLAG_IS_MSI_64,
 };
 
 struct ath11k_pci {
-- 
2.7.4

