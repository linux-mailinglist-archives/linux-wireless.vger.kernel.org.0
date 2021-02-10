Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2EA316160
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhBJIrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:47:24 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:31381 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhBJIng (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946594; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=BBsLnbBmUXR8PDMx9J7saA0GhoiQeq4eDjJpAjxuJ/s=; b=Ns1DaQI2twy+a3x5/MDb0U57mRqXptjUay7uhtgPJj0qtaBt7blEDVpKJRxuehxSyG/GtGRY
 wr8H7IWI4SJV9UeRc7a2umOzSQ3ayp/NYPmDlBzWRMuZCT/4rmHheqOwN/eMFa7VeFNX77A8
 1cHY2oZ1YP1uiI/ODQfky6sXgyI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60239c86d5a7a3baae3ceea0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:46
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7DF16C4347D; Wed, 10 Feb 2021 08:42:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77D5BC43468;
        Wed, 10 Feb 2021 08:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77D5BC43468
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 11/11] ath11k: add qcn9074 pci device support
Date:   Wed, 10 Feb 2021 14:12:10 +0530
Message-Id: <1612946530-28504-12-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCN9074 is PCI based 11ax radio.
	- has 2G/5G/6G variants.
	- has NSS 2x2 and 4x4 variants.

QCN9074 uses 45MB of HOST DDR memory, target requests host memory in
segments, each segment is of 2MB size and is physcial contiguous and
use static window configuration.

Below QMI issues are seen with QCN9074,
Issue 1:
 ath11k_pci 0000:06:00.0: qmi failed memory request, err = -110
 ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-110
Issue 2:
 ath11k_pci 0000:06:00.0: firmware crashed: MHI_CB_SYS_ERROR
 ath11k_pci 0000:06:00.0: qmi failed set mode request, mode: 0, err = -110
 ath11k_pci 0000:06:00.0: qmi failed to send wlan fw mode:-110

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 70dcb80475b1..259a39e59a91 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -34,10 +34,12 @@
  */
 #define ACCESS_ALWAYS_OFF 0xFE0
 
-#define QCA6390_DEVICE_ID		0x1101
+#define QCA6390_DEVICE_ID              0x1101
+#define QCN9074_DEVICE_ID              0x1104
 
 static const struct pci_device_id ath11k_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
+	{ PCI_VDEVICE(QCOM, QCN9074_DEVICE_ID) },
 	{0}
 };
 
@@ -61,6 +63,15 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 			{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
 		},
 	},
+	{
+		.total_vectors = 16,
+		.total_users = 3,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+			{ .name = "CE", .num_vectors = 5, .base_vector = 3 },
+			{ .name = "DP", .num_vectors = 8, .base_vector = 8 },
+		},
+	},
 };
 
 static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
@@ -1219,6 +1230,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 			ret = -EOPNOTSUPP;
 			goto err_pci_free_region;
 		}
+		ab_pci->msi_config = &ath11k_msi_config[0];
+		break;
+	case QCN9074_DEVICE_ID:
+		ab_pci->msi_config = &ath11k_msi_config[1];
+		ab->bus_params.static_window_map = true;
+		ab->hw_rev = ATH11K_HW_QCN9074_HW10;
 		break;
 	default:
 		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
@@ -1227,7 +1244,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_pci_free_region;
 	}
 
-	ab_pci->msi_config = &ath11k_msi_config[0];
 	ret = ath11k_pci_enable_msi(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to enable msi: %d\n", ret);
-- 
2.7.4

