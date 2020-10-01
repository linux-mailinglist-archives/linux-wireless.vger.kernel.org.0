Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3427FC89
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 11:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbgJAJfJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 05:35:09 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:21984 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731813AbgJAJfJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 05:35:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601544908; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=BIBLX0sNUYsHGHDpsuvAcqwW3Rgnc5nFC/l+alkPTMY=; b=QNCTdn/c2bL7l1dHNn86CfeejNIgML8/TOajc7cYb1xcCxyOzblWW4Jia9vpQbWCh7c7m2cF
 kgY7ra9ZJIztcHkJa5H3EJPl6R491pzSs5FWaPEJITjQDZvGBK7w/pP+GCnJqWdFVVUrxwf+
 rzhhD8AcQpY+DxdlsbPE3mwCsWw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f75a2ccbe8c3d2701097cae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 09:35:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 443C2C433C8; Thu,  1 Oct 2020 09:35:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2299EC433FF;
        Thu,  1 Oct 2020 09:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2299EC433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 8/8] ath11k: remove unnecessary casts to u32
Date:   Thu,  1 Oct 2020 12:34:50 +0300
Message-Id: <1601544890-13450-9-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
References: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These casts are not needed. No changes in functionality.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 20f9cebc86d2..9904c0eb7587 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -330,7 +330,7 @@ static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
 	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
 		ath11k_hif_write32(ab, reg_base +
 				   HAL_REO1_RING_MSI1_BASE_LSB_OFFSET(ab),
-				   (u32)srng->msi_addr);
+				   srng->msi_addr);
 
 		val = FIELD_PREP(HAL_REO1_RING_MSI1_BASE_MSB_ADDR,
 				 ((u64)srng->msi_addr >>
@@ -344,7 +344,7 @@ static void ath11k_hal_srng_dst_hw_init(struct ath11k_base *ab,
 				   srng->msi_data);
 	}
 
-	ath11k_hif_write32(ab, reg_base, (u32)srng->ring_base_paddr);
+	ath11k_hif_write32(ab, reg_base, srng->ring_base_paddr);
 
 	val = FIELD_PREP(HAL_REO1_RING_BASE_MSB_RING_BASE_ADDR_MSB,
 			 ((u64)srng->ring_base_paddr >>
@@ -409,7 +409,7 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 	if (srng->flags & HAL_SRNG_FLAGS_MSI_INTR) {
 		ath11k_hif_write32(ab, reg_base +
 				   HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(ab),
-				   (u32)srng->msi_addr);
+				   srng->msi_addr);
 
 		val = FIELD_PREP(HAL_TCL1_RING_MSI1_BASE_MSB_ADDR,
 				 ((u64)srng->msi_addr >>
@@ -424,7 +424,7 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 				   srng->msi_data);
 	}
 
-	ath11k_hif_write32(ab, reg_base, (u32)srng->ring_base_paddr);
+	ath11k_hif_write32(ab, reg_base, srng->ring_base_paddr);
 
 	val = FIELD_PREP(HAL_TCL1_RING_BASE_MSB_RING_BASE_ADDR_MSB,
 			 ((u64)srng->ring_base_paddr >>
-- 
2.7.4

