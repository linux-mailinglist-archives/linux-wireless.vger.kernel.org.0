Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72624409BAD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhIMSEh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 14:04:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47879 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346278AbhIMSEg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 14:04:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631556200; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=QoSTpIAMWKIF35clN5Hl3YPd5ziftjbn1GcRrPdFY3U=; b=mwLMGOdGgvgf3MraEXLncP+JsN+r4TednUSMZUDus/42cEX0hh5huJ7OAnhQZdJ073bsrOCe
 6KDOBt85LvDVTz0LoE0mLWOcNuMw11qas2kN7CT6vl7lMzZcpRocM45tnXMy1HyJjcN7Yoo7
 aHuc0zsp0y5Xuh4fktl7xX6xsec=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 613f9257e0f78151d6ce7b55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 18:03:03
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80CA3C4360C; Mon, 13 Sep 2021 18:03:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA270C4338F;
        Mon, 13 Sep 2021 18:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BA270C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/5] ath11k: Fix inaccessible debug registers
Date:   Mon, 13 Sep 2021 21:02:44 +0300
Message-Id: <20210913180246.193388-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913180246.193388-1-jouni@codeaurora.org>
References: <20210913180246.193388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

Current code clears debug registers after SOC global reset performed
in ath11k_pci_sw_reset. However at that time those registers are
not accessible due to reset, thus they are actually not cleared at all.
For WCN6855, it may cause target fail to initialize. This issue can be
fixed by moving clear action ahead.

In addition, on some specific platforms, need to add delay to wait
those registers to become accessible.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 5abb38cc3b55..7b3bce0ba76e 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -430,6 +430,8 @@ static void ath11k_pci_force_wake(struct ath11k_base *ab)
 
 static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 {
+	mdelay(100);
+
 	if (power_on) {
 		ath11k_pci_enable_ltssm(ab);
 		ath11k_pci_clear_all_intrs(ab);
@@ -439,9 +441,9 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 	}
 
 	ath11k_mhi_clear_vector(ab);
+	ath11k_pci_clear_dbg_registers(ab);
 	ath11k_pci_soc_global_reset(ab);
 	ath11k_mhi_set_mhictrl_reset(ab);
-	ath11k_pci_clear_dbg_registers(ab);
 }
 
 int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
-- 
2.25.1

