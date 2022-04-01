Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F7D4EF8FB
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350104AbiDARcm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350106AbiDARcl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 13:32:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D7F1AA8E2
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 10:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 167A8B82592
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 17:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252E6C2BBE4;
        Fri,  1 Apr 2022 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648834248;
        bh=AGUbQ/6tuDhyCxox2uCn1cj6QMdBMBZn2WDJZ7Y3XWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=THJsbTClVnoE6JaSctC2GiG4TVcvrqN/3jesTnhGjR8bWA3XnWWhpjQmrY/SQSNyt
         DvDziymXiG5ptMyzQWCc+X+rm0yrM0EqzFie57G4kudEo6zU1jnUrcECuPmOTWGUZL
         9OfTJS00HrJeNjWPqwUfcqICrY+ol+x1CsyHuH985W7CUXhKikd0s3mEd7kWLfOF4J
         1pRyYCp+QHUqRE1nCCHwKuBYPUhYz5ANAoTJoLmTmEg0V6UBvb49MXTHw+KtVVJM+O
         ucN//y2xqrAghb8uvoD4ejt0iUcHyUFswUdT/p8n3AtwWBZfNu8gaPMqdNywTrFN4T
         T5O0MHcEB/HGQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] ath11k: mhi: add error handling for suspend and resume
Date:   Fri,  1 Apr 2022 20:30:41 +0300
Message-Id: <20220401173042.17467-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220401173042.17467-1-kvalo@kernel.org>
References: <20220401173042.17467-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

While reviewing the mhi.c I noticed we were just ignoring the errors coming
from MHI subsystem during suspend and resume. Add proper checks and warning
messages. Also pass the error value to callers.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 26 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/mhi.h |  4 ++--
 drivers/net/wireless/ath/ath11k/pci.c |  8 ++------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index d9b63a1f8219..706de7b0b4a1 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -487,16 +487,34 @@ void ath11k_mhi_stop(struct ath11k_pci *ab_pci)
 	mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
 }
 
-void ath11k_mhi_suspend(struct ath11k_pci *ab_pci)
+int ath11k_mhi_suspend(struct ath11k_pci *ab_pci)
 {
-	mhi_pm_suspend(ab_pci->mhi_ctrl);
+	struct ath11k_base *ab = ab_pci->ab;
+	int ret;
+
+	ret = mhi_pm_suspend(ab_pci->mhi_ctrl);
+	if (ret) {
+		ath11k_warn(ab, "failed to suspend mhi: %d", ret);
+		return ret;
+	}
+
+	return 0;
 }
 
-void ath11k_mhi_resume(struct ath11k_pci *ab_pci)
+int ath11k_mhi_resume(struct ath11k_pci *ab_pci)
 {
+	struct ath11k_base *ab = ab_pci->ab;
+	int ret;
+
 	/* Do force MHI resume as some devices like QCA6390, WCN6855
 	 * are not in M3 state but they are functional. So just ignore
 	 * the MHI state while resuming.
 	 */
-	mhi_pm_resume_force(ab_pci->mhi_ctrl);
+	ret = mhi_pm_resume_force(ab_pci->mhi_ctrl);
+	if (ret) {
+		ath11k_warn(ab, "failed to resume mhi: %d", ret);
+		return ret;
+	}
+
+	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
index 5dd024f879c4..8d9f852da695 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -23,7 +23,7 @@ void ath11k_mhi_unregister(struct ath11k_pci *ar_pci);
 void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab);
 void ath11k_mhi_clear_vector(struct ath11k_base *ab);
 
-void ath11k_mhi_suspend(struct ath11k_pci *ar_pci);
-void ath11k_mhi_resume(struct ath11k_pci *ar_pci);
+int ath11k_mhi_suspend(struct ath11k_pci *ar_pci);
+int ath11k_mhi_resume(struct ath11k_pci *ar_pci);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 8a3ff12057e8..d2f220b4121a 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1206,18 +1206,14 @@ static int ath11k_pci_hif_suspend(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ar_pci = ath11k_pci_priv(ab);
 
-	ath11k_mhi_suspend(ar_pci);
-
-	return 0;
+	return ath11k_mhi_suspend(ar_pci);
 }
 
 static int ath11k_pci_hif_resume(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ar_pci = ath11k_pci_priv(ab);
 
-	ath11k_mhi_resume(ar_pci);
-
-	return 0;
+	return ath11k_mhi_resume(ar_pci);
 }
 
 static void ath11k_pci_kill_tasklets(struct ath11k_base *ab)
-- 
2.30.2

