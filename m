Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDC3357B9F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 06:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhDHE5z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 00:57:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43231 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhDHE5x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 00:57:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617857862; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WQu857nGaqbPeUBYM2Ptee8d7W+UMIlYnLGn1v7CjAw=; b=TpVjjy//ULGJ6e2N9j0JP5eOKS/I2EF5Dtb/ukpoaRVRyiyRyCLl5oCrDf6Fe0nmmuWktdKB
 9vCq2p97R2vctLcxWqVhyHaAHd2SnVfL6AGiXquEaRKUUBXnKTh6/9Xw3fvdH8QLTRSxiiuX
 42glgMJfRjfhoIOoDLdsfejxRIw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 606e8d468807bcde1d571253 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 04:57:42
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F21BCC433C6; Thu,  8 Apr 2021 04:57:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B066C433ED;
        Thu,  8 Apr 2021 04:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B066C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH] ath11k: fix warning in ath11k_mhi_config
Date:   Thu,  8 Apr 2021 10:27:10 +0530
Message-Id: <1617857830-19315-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initialize static variable ath11k_mhi_config for all hw_rev,
return error for unknown hw_rev.
This patch fixes below Smatch warning:
    drivers/net/wireless/ath/ath11k/mhi.c:357 ath11k_mhi_register()
    error: uninitialized symbol 'ath11k_mhi_config'.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1

Fixes: a233811ef600 ("ath11k: Add qcn9074 mhi controller config")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 626764da4d6f..27b394d115e2 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -349,10 +349,19 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	mhi_ctrl->read_reg = ath11k_mhi_op_read_reg;
 	mhi_ctrl->write_reg = ath11k_mhi_op_write_reg;
 
-	if (ab->hw_rev == ATH11K_HW_QCA6390_HW20)
-		ath11k_mhi_config = &ath11k_mhi_config_qca6390;
-	else if (ab->hw_rev == ATH11K_HW_QCN9074_HW10)
+	switch (ab->hw_rev) {
+	case ATH11K_HW_QCN9074_HW10:
 		ath11k_mhi_config = &ath11k_mhi_config_qcn9074;
+		break;
+	case ATH11K_HW_QCA6390_HW20:
+		ath11k_mhi_config = &ath11k_mhi_config_qca6390;
+		break;
+	default:
+		ath11k_err(ab, "failed assign mhi_config for unknown hw rev %d\n",
+			   ab->hw_rev);
+		mhi_free_controller(mhi_ctrl);
+		return -EINVAL;
+	}
 
 	ret = mhi_register_controller(mhi_ctrl, ath11k_mhi_config);
 	if (ret) {
-- 
2.7.4

