Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A844C43AB14
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 06:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhJZEUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 00:20:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57628 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhJZEUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 00:20:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635221863; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=jEEIgUVrINI0IucnhBKSg0qksHoIt+oGv9TeC+tnQHU=; b=vg44jYSTJmKRNduPm5+BNjEprbOpwk4pT2E6QG5sPN6a9WtIoWQnVv91gmaaqEeViMG6KFHh
 oKzwYNVQ56dqAcsfvWcHGQQWNpAXaE1iClXIKF6mhvTtxuWAFs6tb+IpNuBki5Vhn2Z1Ka3s
 kOLp+EpDhIEeltXgIGXMi5uTYTk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 617781585baa84c77be2fbb4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Oct 2021 04:17:28
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9630C4360D; Tue, 26 Oct 2021 04:17:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from bqiang-Celadon-RN.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECC69C43460;
        Tue, 26 Oct 2021 04:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org ECC69C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/7] ath11k: do not restore ASPM in case of single MSI vector
Date:   Tue, 26 Oct 2021 12:17:22 +0800
Message-Id: <20211026041722.5271-1-bqiang@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Current code enables ASPM by default, it allows MHI to enter M2 state.
In case of one MSI vector, system hang is observed if ath11k does MHI
register reading in this state. The issue was reported on Dell XPS 13
9310 but is seen also on XPS 15 and XPS 17 laptops.

The workaround here is to prevent MHI from entering M2 state, this can
be done by disabling ASPM if only one MSI vector is used. When using 32
vectors ASPM is enabled as before.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 0a87d00a3a23..b450b4ed35d1 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1220,7 +1220,13 @@ static int ath11k_pci_start(struct ath11k_base *ab)
 
 	set_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
 
-	ath11k_pci_aspm_restore(ab_pci);
+	/* TODO: for now don't restore ASPM in case of single MSI
+	 * vector as MHI register reading in M2 causes system hang.
+	 */
+	if (test_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		ath11k_pci_aspm_restore(ab_pci);
+	else
+		ath11k_info(ab, "leaving PCI ASPM disabled to avoid MHI M2 problems\n");
 
 	ath11k_pci_ce_irqs_enable(ab);
 	ath11k_ce_rx_post_buf(ab);
-- 
2.25.1

