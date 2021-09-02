Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447693FE8BB
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Sep 2021 07:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhIBFfk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Sep 2021 01:35:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36254 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231197AbhIBFfk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Sep 2021 01:35:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630560882; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=gjWRnhydAOjk1sR8RwwNsZBpFXGxC0oX6s53M8gpWVo=; b=bBzYEml6B6ZV76kq2sPaHOey0Rd2k71tXs7fLOnTwYIZLL+VbHYmyAHBQfKFiPFe4/IOTZsZ
 n3ppeqrdR/3JuELF9iEKE9oeyLTxGBr5eKzcQ1r1HZf1LE4e1iJFfShNq1fH7SUOy81vPs58
 MToD1k0CZbbnKClm0OlRtp/8hYk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6130627189cdb620613e1e1e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Sep 2021 05:34:41
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73BD6C43460; Thu,  2 Sep 2021 05:34:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E485AC4338F;
        Thu,  2 Sep 2021 05:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E485AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH v3 01/12] ath11k: disable unused CE8 interrupts for ipq8074
Date:   Thu,  2 Sep 2021 11:03:29 +0530
Message-Id: <1630560820-21905-2-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
References: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host driver doesn't need to process CE8 interrupts (used
by target independently)

The volume of interrupts is huge within short interval,
 CPU0           CPU1       CPU2       CPU3
14022188          0          0          0       GIC  71 Edge      ce8

Hence disabling unused CE8 interrupt will improve CPU usage.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index de8b632..b6ffe03 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -77,7 +77,7 @@ const struct ce_attr ath11k_host_ce_config_ipq8074[] = {
 
 	/* CE8: target autonomous hif_memcpy */
 	{
-		.flags = CE_ATTR_FLAGS,
+		.flags = CE_ATTR_FLAGS | CE_ATTR_DIS_INTR,
 		.src_nentries = 0,
 		.src_sz_max = 0,
 		.dest_nentries = 0,
-- 
2.7.4

