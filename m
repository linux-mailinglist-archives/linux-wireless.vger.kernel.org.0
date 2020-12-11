Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381B62D7D15
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395399AbgLKRiN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:38:13 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:10976 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395318AbgLKRhA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:37:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708194; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=vyT2YED8heOH9emnKcHTBirliBYO8Z6XOPCIim2VnIo=; b=kjgMIf42aj+2bED94ArBtw1sgMXkHe19ux0qf4FeEXuu0dSOyNG0cJzTD1hmn7NvqkgJGDE+
 3MWWCL388ST0D4HB20JbAB809F7DOKy+sZ540OHipDorL14ZXqUXuHHOT4aPQcFACsj/6Ce4
 Ohnz9mjB8l+HR8xa8TzZXc/yRyg=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fd3ae0995aeb115f398d1b0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:36:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7E3EAC433CA; Fri, 11 Dec 2020 17:36:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 275E2C433C6;
        Fri, 11 Dec 2020 17:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 275E2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 09/10] ath11k: hif: add ce irq enable and disable functions
Date:   Fri, 11 Dec 2020 19:35:49 +0200
Message-Id: <1607708150-21066-10-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Add ce irq enable and disable hif layer functions, so core module can enable
enable them without cleaning pipe and refilling pipe. Needed for suspend.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hif.h | 14 ++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.c | 19 ++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index 147f1e802ca9..6285c52afc44 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -26,8 +26,22 @@ struct ath11k_hif_ops {
 				   u32 *base_vector);
 	void (*get_msi_address)(struct ath11k_base *ab, u32 *msi_addr_lo,
 				u32 *msi_addr_hi);
+	void (*ce_irq_enable)(struct ath11k_base *ab);
+	void (*ce_irq_disable)(struct ath11k_base *ab);
 };
 
+static inline void ath11k_hif_ce_irq_enable(struct ath11k_base *ab)
+{
+	if (ab->hif.ops->ce_irq_enable)
+		ab->hif.ops->ce_irq_enable(ab);
+}
+
+static inline void ath11k_hif_ce_irq_disable(struct ath11k_base *ab)
+{
+	if (ab->hif.ops->ce_irq_disable)
+		ab->hif.ops->ce_irq_disable(ab);
+}
+
 static inline int ath11k_hif_start(struct ath11k_base *sc)
 {
 	return sc->hif.ops->start(sc);
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index ee1c2edefa20..e720ac6354fc 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -946,11 +946,16 @@ static void ath11k_pci_kill_tasklets(struct ath11k_base *ab)
 	}
 }
 
-static void ath11k_pci_stop(struct ath11k_base *ab)
+static void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab)
 {
 	ath11k_pci_ce_irqs_disable(ab);
 	ath11k_pci_sync_ce_irqs(ab);
 	ath11k_pci_kill_tasklets(ab);
+}
+
+static void ath11k_pci_stop(struct ath11k_base *ab)
+{
+	ath11k_pci_ce_irq_disable_sync(ab);
 	ath11k_ce_cleanup_pipes(ab);
 }
 
@@ -966,6 +971,16 @@ static int ath11k_pci_start(struct ath11k_base *ab)
 	return 0;
 }
 
+static void ath11k_pci_hif_ce_irq_enable(struct ath11k_base *ab)
+{
+	ath11k_pci_ce_irqs_enable(ab);
+}
+
+static void ath11k_pci_hif_ce_irq_disable(struct ath11k_base *ab)
+{
+	ath11k_pci_ce_irq_disable_sync(ab);
+}
+
 static int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 					  u8 *ul_pipe, u8 *dl_pipe)
 {
@@ -1023,6 +1038,8 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.get_msi_address =  ath11k_pci_get_msi_address,
 	.get_user_msi_vector = ath11k_get_user_msi_assignment,
 	.map_service_to_pipe = ath11k_pci_map_service_to_pipe,
+	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
+	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
 };
 
 static int ath11k_pci_probe(struct pci_dev *pdev,
-- 
2.7.4

