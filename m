Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA272B6BCD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Nov 2020 18:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgKQReE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 12:34:04 -0500
Received: from z5.mailgun.us ([104.130.96.5]:23232 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgKQReE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 12:34:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605634443; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hbYPURUy4rEsO3NS33AYuYsnQqkoBPXfFip0tDNVbE8=; b=Iz6hOIvBt9xjt8AmyB9OT4KyxwwSFLNeuGq6KhqP7W2gF7NttESD/FFpAEEaxSBFpnVj9LS1
 iJAi6uMevWKA6WUoUT8TxvU2oilCtR8cq57o6WfXjnNfxz2OK0NUGcm2jOfYWdUYAEpVeOWJ
 CtpCAs51p1w77rRSTu3+gga87ZY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fb4098a40d44461258d4a5f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Nov 2020 17:34:02
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D1EAC433C6; Tue, 17 Nov 2020 17:34:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B622BC43460;
        Tue, 17 Nov 2020 17:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B622BC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [RESEND PATCH] ath11k: use MHI provided APIs to allocate and free MHI controller
Date:   Tue, 17 Nov 2020 09:33:56 -0800
Message-Id: <1605634436-36506-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use MHI provided APIs to allocate and free MHI controller to
improve MHI host driver handling. This also fixes a memory leak
as the MHI controller was allocated but never freed.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index aded9a7..1c9d9dc 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -218,7 +218,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	struct mhi_controller *mhi_ctrl;
 	int ret;
 
-	mhi_ctrl = kzalloc(sizeof(*mhi_ctrl), GFP_KERNEL);
+	mhi_ctrl = mhi_alloc_controller();
 	if (!mhi_ctrl)
 		return -ENOMEM;
 
@@ -234,7 +234,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	ret = ath11k_mhi_get_msi(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to get msi for mhi\n");
-		kfree(mhi_ctrl);
+		mhi_free_controller(mhi_ctrl);
 		return ret;
 	}
 
@@ -252,7 +252,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	ret = mhi_register_controller(mhi_ctrl, &ath11k_mhi_config);
 	if (ret) {
 		ath11k_err(ab, "failed to register to mhi bus, err = %d\n", ret);
-		kfree(mhi_ctrl);
+		mhi_free_controller(mhi_ctrl);
 		return ret;
 	}
 
@@ -265,6 +265,7 @@ void ath11k_mhi_unregister(struct ath11k_pci *ab_pci)
 
 	mhi_unregister_controller(mhi_ctrl);
 	kfree(mhi_ctrl->irq);
+	mhi_free_controller(mhi_ctrl);
 }
 
 static char *ath11k_mhi_state_to_str(enum ath11k_mhi_state mhi_state)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

