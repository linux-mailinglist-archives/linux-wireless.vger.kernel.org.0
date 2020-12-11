Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A52D7D10
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405552AbgLKRiC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:38:02 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:11322 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395384AbgLKRgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:36:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708187; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=2Cg4Rqa+UOEIOoK3t14dX/pyi6K6BBAQCym9VkBXtVw=; b=Y7aKJp9ycUdSBdjFdrysb9Hw6zPGb2QKp7LT7WtMnmhG6GPJPc0BI4YFv3zAhyeVIgPJx7Yv
 mew4qL5ikUJy7wweZTTJjHVRbojQNnNgzAfycLGOVDHirKeus3V3ozVamsF/fw5BnwE7LSAd
 n7fvXG3rLZ+BNWMMfKvHMnuDKfg=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fd3adfd95aeb115f3989a4d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:35:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91528C433ED; Fri, 11 Dec 2020 17:35:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37F95C433CA;
        Fri, 11 Dec 2020 17:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37F95C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 01/10] ath11k: mhi: hook suspend and resume
Date:   Fri, 11 Dec 2020 19:35:41 +0200
Message-Id: <1607708150-21066-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

MHI suspend and resume isn't hooked in ath11k yet, so hook these
functions needed for suspend support.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 11 +++++++++++
 drivers/net/wireless/ath/ath11k/mhi.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 4cf093718888..72aa39afc04c 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -418,8 +418,10 @@ static int ath11k_mhi_set_state(struct ath11k_pci *ab_pci,
 		ret = 0;
 		break;
 	case ATH11K_MHI_SUSPEND:
+		ret = mhi_pm_suspend(ab_pci->mhi_ctrl);
 		break;
 	case ATH11K_MHI_RESUME:
+		ret = mhi_pm_resume(ab_pci->mhi_ctrl);
 		break;
 	case ATH11K_MHI_TRIGGER_RDDM:
 		ret = mhi_force_rddm_mode(ab_pci->mhi_ctrl);
@@ -470,3 +472,12 @@ void ath11k_mhi_stop(struct ath11k_pci *ab_pci)
 	ath11k_mhi_set_state(ab_pci, ATH11K_MHI_DEINIT);
 }
 
+void ath11k_mhi_suspend(struct ath11k_pci *ab_pci)
+{
+	ath11k_mhi_set_state(ab_pci, ATH11K_MHI_SUSPEND);
+}
+
+void ath11k_mhi_resume(struct ath11k_pci *ab_pci)
+{
+	ath11k_mhi_set_state(ab_pci, ATH11K_MHI_RESUME);
+}
diff --git a/drivers/net/wireless/ath/ath11k/mhi.h b/drivers/net/wireless/ath/ath11k/mhi.h
index a7fd5e201d18..488dada5d31c 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.h
+++ b/drivers/net/wireless/ath/ath11k/mhi.h
@@ -36,4 +36,7 @@ void ath11k_mhi_unregister(struct ath11k_pci *ar_pci);
 void ath11k_mhi_set_mhictrl_reset(struct ath11k_base *ab);
 void ath11k_mhi_clear_vector(struct ath11k_base *ab);
 
+void ath11k_mhi_suspend(struct ath11k_pci *ar_pci);
+void ath11k_mhi_resume(struct ath11k_pci *ar_pci);
+
 #endif
-- 
2.7.4

