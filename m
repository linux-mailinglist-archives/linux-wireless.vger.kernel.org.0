Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82699375BBF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhEFTeL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 15:34:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21907 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbhEFTeJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 15:34:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620329591; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=qqLzVjtXrQshZwmYUXuuv/rvwTmeHj2Lr0oRq+Jm5Ls=; b=WxLEefiRepEIE76kASIg9weX5yy3kTeZT2BWZXKS5xJMMfU1sMV/QI3XGDykO3vQwxCf0+9w
 Zdtm101NSjpwLo7uN5E69Fz78nEp8fQFZczh5AqKJnu7vk2FjVbl8FPfQSFfUjuQkyFsdvil
 IA+3yEigAn4DtlLit9AC/QEpDtY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6094446dc06dd10a2d4e07d0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 19:33:01
 GMT
Sender: bbhatt=qti.qualcomm.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 791C4C43145; Thu,  6 May 2021 19:33:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB06CC43143;
        Thu,  6 May 2021 19:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB06CC43143
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=tempfail smtp.mailfrom=bbhatt@qti.qualcomm.com
From:   Bhaumik Bhatt <bbhatt@qti.qualcomm.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v4 2/6] bus: mhi: core: Set BHI and BHIe pointers to NULL in clean-up
Date:   Thu,  6 May 2021 12:32:21 -0700
Message-Id: <1620329545-32328-3-git-send-email-bbhatt@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620329545-32328-1-git-send-email-bbhatt@qti.qualcomm.com>
References: <1620329545-32328-1-git-send-email-bbhatt@qti.qualcomm.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Set the BHI and BHIe pointers to NULL as part of clean-up. This
makes sure that stale pointers are not accessed after powering
MHI down.

Suggested-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 11c7a3d..1cc2f22 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1132,6 +1132,9 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
 		mhi_cntrl->rddm_image = NULL;
 	}
 
+	mhi_cntrl->bhi = NULL;
+	mhi_cntrl->bhie = NULL;
+
 	mhi_deinit_dev_ctxt(mhi_cntrl);
 }
 EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

