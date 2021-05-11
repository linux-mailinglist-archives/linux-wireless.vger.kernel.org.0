Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567CB37ABD0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhEKQYT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 12:24:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31550 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhEKQYP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 12:24:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620750188; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vtyuWCUgaC24+ysgVPL7pIxIwB7fT6eCYf1JfxEDu3k=; b=vK771gTsk0djZWABpIwdMQ5bubvRg2FW3jxtdQrnJmFNtTu5Fm27nkQLnl19/mF3z/xGmgr9
 WA4eS+4AW43CzBN3wP99rGKVremSjEbEomjwn77PqxoKHOCjjpeRkQCUDcRU5WOm5QPqy27h
 VKEcWxK5Cv1pHU1pl4V7PmICnS0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 609aaf66da4b8b13329269b6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 May 2021 16:23:02
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C22F9C4338A; Tue, 11 May 2021 16:23:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-96-12-nat.elisa-mobile.fi [85.76.96.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CF69C43143;
        Tue, 11 May 2021 16:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CF69C43143
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 4/7] ath11k: setup WBM_IDLE_LINK ring once again
Date:   Tue, 11 May 2021 19:22:11 +0300
Message-Id: <20210511162214.29475-5-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511162214.29475-1-jouni@codeaurora.org>
References: <20210511162214.29475-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

For WCN6855, WBM idle link ring needs a reinit.
Without this reinit, firmware crash might happen occasionally.
This is requested by the hw team.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 08e3c72d9237..eaa0edca5576 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -382,6 +382,16 @@ static void ath11k_hal_srng_src_hw_init(struct ath11k_base *ab,
 	val = FIELD_PREP(HAL_REO1_RING_ID_ENTRY_SIZE, srng->entry_size);
 	ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_ID_OFFSET(ab), val);
 
+	if (srng->ring_id == HAL_SRNG_RING_ID_WBM_IDLE_LINK) {
+		ath11k_hif_write32(ab, reg_base, (u32)srng->ring_base_paddr);
+		val = FIELD_PREP(HAL_TCL1_RING_BASE_MSB_RING_BASE_ADDR_MSB,
+				 ((u64)srng->ring_base_paddr >>
+				 HAL_ADDR_MSB_REG_SHIFT)) |
+			FIELD_PREP(HAL_TCL1_RING_BASE_MSB_RING_SIZE,
+				   (srng->entry_size * srng->num_entries));
+		ath11k_hif_write32(ab, reg_base + HAL_TCL1_RING_BASE_MSB_OFFSET(ab), val);
+	}
+
 	/* interrupt setup */
 	/* NOTE: IPQ8074 v2 requires the interrupt timer threshold in the
 	 * unit of 8 usecs instead of 1 usec (as required by v1).
-- 
2.25.1

