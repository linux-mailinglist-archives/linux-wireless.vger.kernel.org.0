Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13090245758
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgHPLao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 07:30:44 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:50480 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729028AbgHPL3G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 07:29:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597577346; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UX3gvES2t+gUdUdnX5q7QI51JtmVoHZd0uP+nXt2Ru0=; b=QYVPCVi8MsHN5Y2QZAY+2BOUqmYNKZTBizirtZSlT0ZQDACpAGiH0b2MjkTnhuVTqKd3VM6E
 OaPMDHDFAeegh2Sn2YRQFJ/+sHDZFrU4YRguXPf6gi75o/YF+Xbywlpzl/AdgkyKiJhU+RAq
 pcIUwwXzmAr17Tz0+0yT0s7oObI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f3915a6d96d28d61ec54d52 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 11:16:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5E53C433CA; Sun, 16 Aug 2020 11:16:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1024C433C6;
        Sun, 16 Aug 2020 11:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1024C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 07/12] ath11k: ce: get msi_addr and msi_data before srng setup
Date:   Sun, 16 Aug 2020 14:16:34 +0300
Message-Id: <1597576599-8857-8-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
References: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Move function to get msi_addr and msi_data before srng setup,
otherwise srng is setup with no MSI configuration.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ce.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index 41c1a6e56596..b2da1f937478 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -467,6 +467,9 @@ static int ath11k_ce_init_ring(struct ath11k_base *ab,
 	params.ring_base_vaddr = ce_ring->base_addr_owner_space;
 	params.num_entries = ce_ring->nentries;
 
+	if (!(CE_ATTR_DIS_INTR & ab->hw_params.host_ce_config[ce_id].flags))
+		ath11k_ce_srng_msi_ring_params_setup(ab, ce_id, &params);
+
 	switch (type) {
 	case HAL_CE_SRC:
 		if (!(CE_ATTR_DIS_INTR & ab->hw_params.host_ce_config[ce_id].flags))
@@ -500,9 +503,6 @@ static int ath11k_ce_init_ring(struct ath11k_base *ab,
 		return ret;
 	}
 
-	if (!(CE_ATTR_DIS_INTR & ab->hw_params.host_ce_config[ce_id].flags))
-		ath11k_ce_srng_msi_ring_params_setup(ab, ce_id, &params);
-
 	ce_ring->hal_ring_id = ret;
 
 	return 0;
-- 
2.7.4

