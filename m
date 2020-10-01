Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD127FC8C
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgJAJfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 05:35:46 -0400
Received: from z5.mailgun.us ([104.130.96.5]:11882 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgJAJfq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 05:35:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601544946; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=MZDdKb7tWJ/ILRdnJ7vFlyFuaTvDKHsOvFzzq1ZqwTA=; b=IsAMCfnC0LP5tLS/Lx8Bs38bZcfIDp8ZbJhlO3jAhrfvKs2S3KOu6iWu1xQ8lJRLeGE6fjdT
 GvmuXj6wnxR1xAJD8WIqqNpMBTptY4q40PH2MPOrWHgclRvLuJs+J6On5cb6cW6T/OFQq5PS
 1NRcdVJmAxaTf1CZdt/x2SgD29M=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f75a2c03aed3d14c0922ef8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 09:34:56
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3A9F1C433CB; Thu,  1 Oct 2020 09:34:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7691C433C8;
        Thu,  1 Oct 2020 09:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7691C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/8] ath11k: read and write registers below unwindowed address
Date:   Thu,  1 Oct 2020 12:34:43 +0300
Message-Id: <1601544890-13450-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
References: <1601544890-13450-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390, host can read and write registers below unwindowed
address directly without programming the window register. For
registers below bar0 + 4k - 32, host can read and write regardless
of the power save state. Shadow registers are located below
bar0 + 4K - 32.

Before MHI power up, there is no need to wakeup MHI so ini_done is
added to indicate it.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.h |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 69e5b7c57695..e72dca4fa577 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -28,6 +28,12 @@
 #define TCSR_SOC_HW_VERSION_MAJOR_MASK	GENMASK(16, 8)
 #define TCSR_SOC_HW_VERSION_MINOR_MASK	GENMASK(7, 0)
 
+/* BAR0 + 4k is always accessible, and no
+ * need to force wakeup.
+ * 4K - 32 = 0xFE0
+ */
+#define ACCESS_ALWAYS_OFF 0xFE0
+
 #define QCA6390_DEVICE_ID		0x1101
 
 static const struct pci_device_id ath11k_pci_id_table[] = {
@@ -128,6 +134,13 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
+	/* for offset beyond BAR + 4K - 32, may
+	 * need to wakeup MHI to access.
+	 */
+	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	    offset >= ACCESS_ALWAYS_OFF)
+		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+
 	if (offset < WINDOW_START) {
 		iowrite32(value, ab->mem  + offset);
 	} else {
@@ -136,6 +149,10 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 		iowrite32(value, ab->mem + WINDOW_START + (offset & WINDOW_RANGE_MASK));
 		spin_unlock_bh(&ab_pci->window_lock);
 	}
+
+	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	    offset >= ACCESS_ALWAYS_OFF)
+		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 }
 
 u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
@@ -143,6 +160,13 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	u32 val;
 
+	/* for offset beyond BAR + 4K - 32, may
+	 * need to wakeup MHI to access.
+	 */
+	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	    offset >= ACCESS_ALWAYS_OFF)
+		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+
 	if (offset < WINDOW_START) {
 		val = ioread32(ab->mem + offset);
 	} else {
@@ -152,6 +176,10 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 		spin_unlock_bh(&ab_pci->window_lock);
 	}
 
+	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+	    offset >= ACCESS_ALWAYS_OFF)
+		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+
 	return val;
 }
 
@@ -731,6 +759,8 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	int ret;
 
+	ab_pci->register_window = 0;
+	clear_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
 	ath11k_pci_sw_reset(ab_pci->ab);
 
 	ret = ath11k_mhi_start(ab_pci);
@@ -747,6 +777,7 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
 	ath11k_mhi_stop(ab_pci);
+	clear_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
 	ath11k_pci_force_wake(ab_pci->ab);
 	ath11k_pci_sw_reset(ab_pci->ab);
 }
@@ -775,6 +806,10 @@ static void ath11k_pci_stop(struct ath11k_base *ab)
 
 static int ath11k_pci_start(struct ath11k_base *ab)
 {
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	set_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
+
 	ath11k_pci_ce_irqs_enable(ab);
 	ath11k_ce_rx_post_buf(ab);
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index f2f280eb8b55..43562f774a37 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -36,6 +36,10 @@ struct ath11k_msi_config {
 	struct ath11k_msi_user *users;
 };
 
+enum ath11k_pci_flags {
+	ATH11K_PCI_FLAG_INIT_DONE,
+};
+
 struct ath11k_pci {
 	struct pci_dev *pdev;
 	struct ath11k_base *ab;
@@ -48,6 +52,9 @@ struct ath11k_pci {
 
 	/* protects register_window above */
 	spinlock_t window_lock;
+
+	/* enum ath11k_pci_flags */
+	unsigned long flags;
 };
 
 static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
-- 
2.7.4

