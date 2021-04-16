Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C1A3627EF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 20:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245163AbhDPSru (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 14:47:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64956 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245116AbhDPSrt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 14:47:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618598844; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=yTL51vP4I8DlfmVuqLvxyNkWqtWu8S6OS4xbflwDpZo=; b=LhwLXoAAJEqNuNQOAWK4bBxGGuvzGTnG4bHLOzLXD+ER2oJKZeo0H14XwDwwe1sk6V+uf6sO
 bCcUndjVnGET3FdchJq0EWSJ+FF1m1TkgUycaU64l9blmAMoETdxvbYBJ0l7IYlan2pScn6p
 If3xl3Jd9U0H6/MNtpqJ5Necx6Q=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6079dbb62cbba88980699212 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Apr 2021 18:47:18
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6CCD9C43462; Fri, 16 Apr 2021 18:47:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58E26C433C6;
        Fri, 16 Apr 2021 18:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58E26C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 1/6] bus: mhi: core: Set BHI/BHIe offsets on power up preparation
Date:   Fri, 16 Apr 2021 11:47:00 -0700
Message-Id: <1618598825-18629-2-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618598825-18629-1-git-send-email-bbhatt@codeaurora.org>
References: <1618598825-18629-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set the BHI and/or BHIe offsets in mhi_prepare_for_power_up(),
rearrange the function, and remove the equivalent from
mhi_async_power_up(). This helps consolidate multiple checks
in different parts of the driver and can help MHI fail early on
before power up begins if the offsets are not read correctly.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/init.c | 42 +++++++++++++++++++++++-------------------
 drivers/bus/mhi/core/pm.c   | 28 ++++------------------------
 2 files changed, 27 insertions(+), 43 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index c81b377..11c7a3d 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1063,7 +1063,7 @@ EXPORT_SYMBOL_GPL(mhi_free_controller);
 int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 {
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	u32 bhie_off;
+	u32 bhi_off, bhie_off;
 	int ret;
 
 	mutex_lock(&mhi_cntrl->pm_mutex);
@@ -1072,29 +1072,36 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 	if (ret)
 		goto error_dev_ctxt;
 
-	/*
-	 * Allocate RDDM table if specified, this table is for debugging purpose
-	 */
-	if (mhi_cntrl->rddm_size) {
-		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
-				     mhi_cntrl->rddm_size);
+	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &bhi_off);
+	if (ret) {
+		dev_err(dev, "Error getting BHI offset\n");
+		goto error_reg_offset;
+	}
+	mhi_cntrl->bhi = mhi_cntrl->regs + bhi_off;
 
-		/*
-		 * This controller supports RDDM, so we need to manually clear
-		 * BHIE RX registers since POR values are undefined.
-		 */
+	if (mhi_cntrl->fbc_download || mhi_cntrl->rddm_size) {
 		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIEOFF,
 				   &bhie_off);
 		if (ret) {
 			dev_err(dev, "Error getting BHIE offset\n");
-			goto bhie_error;
+			goto error_reg_offset;
 		}
-
 		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
+	}
+
+	if (mhi_cntrl->rddm_size) {
+		/*
+		 * This controller supports RDDM, so we need to manually clear
+		 * BHIE RX registers since POR values are undefined.
+		 */
 		memset_io(mhi_cntrl->bhie + BHIE_RXVECADDR_LOW_OFFS,
 			  0, BHIE_RXVECSTATUS_OFFS - BHIE_RXVECADDR_LOW_OFFS +
 			  4);
-
+		/*
+		 * Allocate RDDM table for debugging purpose if specified
+		 */
+		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
+				     mhi_cntrl->rddm_size);
 		if (mhi_cntrl->rddm_image)
 			mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
 	}
@@ -1103,11 +1110,8 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 
 	return 0;
 
-bhie_error:
-	if (mhi_cntrl->rddm_image) {
-		mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->rddm_image);
-		mhi_cntrl->rddm_image = NULL;
-	}
+error_reg_offset:
+	mhi_deinit_dev_ctxt(mhi_cntrl);
 
 error_dev_ctxt:
 	mutex_unlock(&mhi_cntrl->pm_mutex);
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index e2e59a3..adf426c 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -1066,28 +1066,8 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 	if (ret)
 		goto error_setup_irq;
 
-	/* Setup BHI offset & INTVEC */
+	/* Setup BHI INTVEC */
 	write_lock_irq(&mhi_cntrl->pm_lock);
-	ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &val);
-	if (ret) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
-		goto error_bhi_offset;
-	}
-
-	mhi_cntrl->bhi = mhi_cntrl->regs + val;
-
-	/* Setup BHIE offset */
-	if (mhi_cntrl->fbc_download) {
-		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIEOFF, &val);
-		if (ret) {
-			write_unlock_irq(&mhi_cntrl->pm_lock);
-			dev_err(dev, "Error reading BHIE offset\n");
-			goto error_bhi_offset;
-		}
-
-		mhi_cntrl->bhie = mhi_cntrl->regs + val;
-	}
-
 	mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
 	mhi_cntrl->pm_state = MHI_PM_POR;
 	mhi_cntrl->ee = MHI_EE_MAX;
@@ -1098,7 +1078,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 	if (!MHI_IN_PBL(current_ee) && current_ee != MHI_EE_AMSS) {
 		dev_err(dev, "Not a valid EE for power on\n");
 		ret = -EIO;
-		goto error_bhi_offset;
+		goto error_async_power_up;
 	}
 
 	state = mhi_get_mhi_state(mhi_cntrl);
@@ -1117,7 +1097,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 		if (!ret) {
 			ret = -EIO;
 			dev_info(dev, "Failed to reset MHI due to syserr state\n");
-			goto error_bhi_offset;
+			goto error_async_power_up;
 		}
 
 		/*
@@ -1139,7 +1119,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 
 	return 0;
 
-error_bhi_offset:
+error_async_power_up:
 	mhi_deinit_free_irq(mhi_cntrl);
 
 error_setup_irq:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

