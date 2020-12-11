Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6679A2D7D13
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395358AbgLKRiL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:38:11 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:12699 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395393AbgLKRgy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:36:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708195; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=DsFqG5baMqOC/DxmzdqQidTkdO3n7hX7oiG1bJHN3rc=; b=o3IqgLpyZCoRRcDFxNotCEM9p4tK8WsJ47t88RkCEGwAG4aFyV19r6q55jKtXDCEt28pK9I6
 SZTjbqY+JMxv5slosOcGpm+s51LNA27t+mpTRFwNFP1AkY9ahOkMzEs0CNjhTMJXU4UUxuL/
 +Uj3sWeo73VyzgmCuDtDYk8a8gI=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fd3adfe42c04000269ff216 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:35:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2468DC433CA; Fri, 11 Dec 2020 17:35:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA6E6C43461;
        Fri, 11 Dec 2020 17:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA6E6C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 02/10] ath11k: hif: implement suspend and resume functions
Date:   Fri, 11 Dec 2020 19:35:42 +0200
Message-Id: <1607708150-21066-3-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For suspend support add suspend and resume to HIF layer. These ops are optional
and, for example, AHB bus driver does not need to implement these.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hif.h | 18 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.c | 20 ++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index dbe5568916e8..147f1e802ca9 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -17,6 +17,8 @@ struct ath11k_hif_ops {
 	void (*stop)(struct ath11k_base *sc);
 	int (*power_up)(struct ath11k_base *sc);
 	void (*power_down)(struct ath11k_base *sc);
+	int (*suspend)(struct ath11k_base *ab);
+	int (*resume)(struct ath11k_base *ab);
 	int (*map_service_to_pipe)(struct ath11k_base *sc, u16 service_id,
 				   u8 *ul_pipe, u8 *dl_pipe);
 	int (*get_user_msi_vector)(struct ath11k_base *ab, char *user_name,
@@ -56,6 +58,22 @@ static inline void ath11k_hif_power_down(struct ath11k_base *sc)
 	sc->hif.ops->power_down(sc);
 }
 
+static inline int ath11k_hif_suspend(struct ath11k_base *ab)
+{
+	if (ab->hif.ops->suspend)
+		return ab->hif.ops->suspend(ab);
+
+	return 0;
+}
+
+static inline int ath11k_hif_resume(struct ath11k_base *ab)
+{
+	if (ab->hif.ops->resume)
+		return ab->hif.ops->resume(ab);
+
+	return 0;
+}
+
 static inline u32 ath11k_hif_read32(struct ath11k_base *sc, u32 address)
 {
 	return sc->hif.ops->read32(sc, address);
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 818e37c32a85..770cefd53290 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -913,6 +913,24 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 	ath11k_pci_sw_reset(ab_pci->ab, false);
 }
 
+static int ath11k_pci_hif_suspend(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ar_pci = ath11k_pci_priv(ab);
+
+	ath11k_mhi_suspend(ar_pci);
+
+	return 0;
+}
+
+static int ath11k_pci_hif_resume(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ar_pci = ath11k_pci_priv(ab);
+
+	ath11k_mhi_resume(ar_pci);
+
+	return 0;
+}
+
 static void ath11k_pci_kill_tasklets(struct ath11k_base *ab)
 {
 	int i;
@@ -997,6 +1015,8 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.write32 = ath11k_pci_write32,
 	.power_down = ath11k_pci_power_down,
 	.power_up = ath11k_pci_power_up,
+	.suspend = ath11k_pci_hif_suspend,
+	.resume = ath11k_pci_hif_resume,
 	.irq_enable = ath11k_pci_ext_irq_enable,
 	.irq_disable = ath11k_pci_ext_irq_disable,
 	.get_msi_address =  ath11k_pci_get_msi_address,
-- 
2.7.4

