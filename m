Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B238D375BC7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 21:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhEFTej (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 15:34:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13586 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235405AbhEFTe2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 15:34:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620329609; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=bvkFBLKodFX+zjrUspKLrwb5Kis6mxQbCT+f8hziA0U=; b=TVVTBScQgnuEME32gfZmicseyWFOppE/eaWAcvYSMx2no9oAgLtUsMBqbCfjVyiYSwNy0SMY
 cu3sRHYJx+O01qhTHIFwijUA+RzuAXMq5/x6QNQYAuykoOgmsRCRDVeCm1ANCg2c/uMK0rgC
 fPhD7eT4Apy+zxgI40wQOMa23nI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60944484f34440a9d42760d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 19:33:23
 GMT
Sender: bbhatt=qti.qualcomm.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2AADC43143; Thu,  6 May 2021 19:33:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DED6FC00447;
        Thu,  6 May 2021 19:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DED6FC00447
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=pass (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=pass smtp.mailfrom=bbhatt@qti.qualcomm.com
From:   Bhaumik Bhatt <bbhatt@qti.qualcomm.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v4 6/6] bus: mhi: core: Add range checks for BHI and BHIe
Date:   Thu,  6 May 2021 12:32:25 -0700
Message-Id: <1620329545-32328-7-git-send-email-bbhatt@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620329545-32328-1-git-send-email-bbhatt@qti.qualcomm.com>
References: <1620329545-32328-1-git-send-email-bbhatt@qti.qualcomm.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

When obtaining the BHI or BHIe offsets during the power up
preparation phase, range checks are missing. These can help
controller drivers avoid accessing any address outside of the
MMIO region. Ensure that mhi_cntrl->reg_len is set before MHI
registration as it is a required field and range checks will
fail without it.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/bus/mhi/core/init.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 1cc2f22..aeb1e3c 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -885,7 +885,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
 	    !mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
 	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
-	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs || !mhi_cntrl->irq)
+	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs ||
+	    !mhi_cntrl->irq || !mhi_cntrl->reg_len)
 		return -EINVAL;
 
 	ret = parse_config(mhi_cntrl, config);
@@ -1077,6 +1078,13 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 		dev_err(dev, "Error getting BHI offset\n");
 		goto error_reg_offset;
 	}
+
+	if (bhi_off >= mhi_cntrl->reg_len) {
+		dev_err(dev, "BHI offset: 0x%x is out of range: 0x%zx\n",
+			bhi_off, mhi_cntrl->reg_len);
+		ret = -EINVAL;
+		goto error_reg_offset;
+	}
 	mhi_cntrl->bhi = mhi_cntrl->regs + bhi_off;
 
 	if (mhi_cntrl->fbc_download || mhi_cntrl->rddm_size) {
@@ -1086,6 +1094,14 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 			dev_err(dev, "Error getting BHIE offset\n");
 			goto error_reg_offset;
 		}
+
+		if (bhie_off >= mhi_cntrl->reg_len) {
+			dev_err(dev,
+				"BHIe offset: 0x%x is out of range: 0x%zx\n",
+				bhie_off, mhi_cntrl->reg_len);
+			ret = -EINVAL;
+			goto error_reg_offset;
+		}
 		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

