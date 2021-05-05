Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F489374647
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbhEERNk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 13:13:40 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14297 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238796AbhEERJr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 13:09:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620234530; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ViCBV9ZqYaGdrBTwcWYN9MlUwBTPVDXH7dcqPtxWNWo=; b=wH8DtIT3Odjm3I22/4IdzGhzV+JUB3Yj3j6dhlDRItdxcxLPHCzzhKEkf5YOvo72Pmty2Unn
 ufEdfCllDX+p9csNfXjCrfZ1En0Pc8xAWrgR8N06ccVchMmgbkH/2aYQqW/UGPUWZfe/ynHh
 h3lZsf32wWO1Wt8+pZ7D/DSJwC8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6092d120febcffa80fc4fa29 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 May 2021 17:08:48
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD9C8C43152; Wed,  5 May 2021 17:08:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EF47C43143;
        Wed,  5 May 2021 17:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EF47C43143
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v3 3/6] bus: mhi: Add MMIO region length to controller structure
Date:   Wed,  5 May 2021 10:08:18 -0700
Message-Id: <1620234501-30461-4-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620234501-30461-1-git-send-email-bbhatt@codeaurora.org>
References: <1620234501-30461-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make controller driver specify the MMIO register region length
for range checking of BHI or BHIe space. This can help validate
that offsets are in acceptable memory region or not and avoid any
boot-up issues due to BHI or BHIe memory accesses.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 include/linux/mhi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 944aa3a..9c347f5 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -303,6 +303,7 @@ struct mhi_controller_config {
  * @rddm_size: RAM dump size that host should allocate for debugging purpose
  * @sbl_size: SBL image size downloaded through BHIe (optional)
  * @seg_len: BHIe vector size (optional)
+ * @reg_len: Length of the MHI MMIO region (required)
  * @fbc_image: Points to firmware image buffer
  * @rddm_image: Points to RAM dump buffer
  * @mhi_chan: Points to the channel configuration table
@@ -386,6 +387,7 @@ struct mhi_controller {
 	size_t rddm_size;
 	size_t sbl_size;
 	size_t seg_len;
+	size_t reg_len;
 	struct image_info *fbc_image;
 	struct image_info *rddm_image;
 	struct mhi_chan *mhi_chan;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

