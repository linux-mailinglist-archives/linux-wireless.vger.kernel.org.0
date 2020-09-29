Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4E27D43C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 19:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgI2RPs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 13:15:48 -0400
Received: from z5.mailgun.us ([104.130.96.5]:42360 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgI2RPr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 13:15:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601399747; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=86OI8oxaQ6g79LRn/4kQaANHJB0A7SNMDDn4xBtE2Yc=; b=Xxqrv+NhHs3fqx/HUXj7NGpcZYroU1FpSHQbgRwAB57mh0Zjc9I0AOXybKMOqUTltnvhHLSP
 WSpCB6AHbwAZWk3jyBHz36SD+yW3jazYEOfT+NWBWWoIIMFLTru4iU7b6qun80Y0dUEZ7M0p
 C2rmU7IMFDgqQVD37lJ6+QPdZDA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f736bc397ca3ed0fb9c87f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 17:15:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9692CC433CA; Tue, 29 Sep 2020 17:15:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C50DC433C8;
        Tue, 29 Sep 2020 17:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C50DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/8] ath11k: pci: check TCSR_SOC_HW_VERSION
Date:   Tue, 29 Sep 2020 20:15:32 +0300
Message-Id: <1601399736-3210-5-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
References: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are different versions of QCA6390. Check TCSR_SOC_HW_VERSION to make sure
that the device is hw2.0, all the rest are unsupported.

This needs to be checked after ath11k_pci_claim() so move the whole switch choosing hw_ver.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 46 ++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index aec0b593c6a7..e76a8b61d037 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -24,6 +24,10 @@
 #define WINDOW_START			0x80000
 #define WINDOW_RANGE_MASK		GENMASK(18, 0)
 
+#define TCSR_SOC_HW_VERSION		0x0224
+#define TCSR_SOC_HW_VERSION_MAJOR_MASK	GENMASK(16, 8)
+#define TCSR_SOC_HW_VERSION_MINOR_MASK	GENMASK(7, 0)
+
 #define QCA6390_DEVICE_ID		0x1101
 
 static const struct pci_device_id ath11k_pci_id_table[] = {
@@ -839,21 +843,11 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 {
 	struct ath11k_base *ab;
 	struct ath11k_pci *ab_pci;
-	enum ath11k_hw_rev hw_rev;
+	u32 soc_hw_version, soc_hw_version_major, soc_hw_version_minor;
 	int ret;
 
 	dev_warn(&pdev->dev, "WARNING: ath11k PCI support is experimental!\n");
 
-	switch (pci_dev->device) {
-	case QCA6390_DEVICE_ID:
-		hw_rev = ATH11K_HW_QCA6390_HW20;
-		break;
-	default:
-		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
-			pci_dev->device);
-		return -ENOTSUPP;
-	}
-
 	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI,
 			       &ath11k_pci_bus_params);
 	if (!ab) {
@@ -862,7 +856,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	}
 
 	ab->dev = &pdev->dev;
-	ab->hw_rev = hw_rev;
 	pci_set_drvdata(pdev, ab);
 	ab_pci = ath11k_pci_priv(ab);
 	ab_pci->dev_id = pci_dev->device;
@@ -878,6 +871,35 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_free_core;
 	}
 
+	switch (pci_dev->device) {
+	case QCA6390_DEVICE_ID:
+		soc_hw_version = ath11k_pci_read32(ab, TCSR_SOC_HW_VERSION);
+		soc_hw_version_major = FIELD_GET(TCSR_SOC_HW_VERSION_MAJOR_MASK,
+						 soc_hw_version);
+		soc_hw_version_minor = FIELD_GET(TCSR_SOC_HW_VERSION_MINOR_MASK,
+						 soc_hw_version);
+
+		ath11k_dbg(ab, ATH11K_DBG_PCI, "pci tcsr_soc_hw_version major %d minor %d\n",
+			   soc_hw_version_major, soc_hw_version_minor);
+
+		switch (soc_hw_version_major) {
+		case 2:
+			ab->hw_rev = ATH11K_HW_QCA6390_HW20;
+			break;
+		default:
+			dev_err(&pdev->dev, "Unsupported QCA6390 SOC hardware version: %d %d\n",
+				soc_hw_version_major, soc_hw_version_minor);
+			ret = -EOPNOTSUPP;
+			goto err_pci_free_region;
+		}
+		break;
+	default:
+		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
+			pci_dev->device);
+		ret = -EOPNOTSUPP;
+		goto err_pci_free_region;
+	}
+
 	ret = ath11k_pci_enable_msi(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to enable msi: %d\n", ret);
-- 
2.7.4

