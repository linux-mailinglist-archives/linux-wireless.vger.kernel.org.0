Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A512DC5E4
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 19:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgLPSFi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 13:05:38 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:44662 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgLPSFi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 13:05:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608141912; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=i6REmjbfH6NDLaDwJC6HuByuUaR5n0yZupQpaJzoXR0=; b=MOqgUytPjgk/eDwYXAht0b4YBzFTDyvObOBbvelkp+N/EyTcPWQ7YdiUdKDJbBNuno299TX+
 /32Jnpueqx9rNWjurazAm8toPxAkCGunxIDVcwTkHzxI5EhH050QwlGOcelH03592x+WmE61
 IuiSXonvC2iczg3pMFvfeW0E1oE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fda4c33f5e9af65f87c874a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Dec 2020 18:04:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71627C433ED; Wed, 16 Dec 2020 18:04:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F295C433CA;
        Wed, 16 Dec 2020 18:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F295C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: pci: disable ASPM L0sLs before downloading firmware
Date:   Wed, 16 Dec 2020 20:04:31 +0200
Message-Id: <1608141871-23779-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Sometimes QCA6390 doesn't switch to amss state as device enters
L1ss state, so disable L0sL1s during firmware downloading.
Driver recovers the ASPM to default value in start callback
or powerdown callback.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 27 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 9f9a824a4c2d..7024648c9e4f 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -886,6 +886,24 @@ static void ath11k_pci_free_region(struct ath11k_pci *ab_pci)
 		pci_disable_device(pci_dev);
 }
 
+static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
+{
+	/* disable L0sL1 */
+	pcie_capability_read_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+				  &ab_pci->link_ctl);
+	pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+				   ab_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
+
+	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
+}
+
+static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
+{
+	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
+		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+					   ab_pci->link_ctl);
+}
+
 static int ath11k_pci_power_up(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
@@ -895,6 +913,11 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 	clear_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
 	ath11k_pci_sw_reset(ab_pci->ab, true);
 
+	/* Disable ASPM during firmware download due to problems switching
+	 * to AMSS state.
+	 */
+	ath11k_pci_aspm_disable(ab_pci);
+
 	ret = ath11k_mhi_start(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to start mhi: %d\n", ret);
@@ -908,6 +931,8 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
+	ath11k_pci_aspm_restore(ab_pci);
+
 	ath11k_pci_force_wake(ab_pci->ab);
 	ath11k_mhi_stop(ab_pci);
 	clear_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
@@ -965,6 +990,8 @@ static int ath11k_pci_start(struct ath11k_base *ab)
 
 	set_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
 
+	ath11k_pci_aspm_restore(ab_pci);
+
 	ath11k_pci_ce_irqs_enable(ab);
 	ath11k_ce_rx_post_buf(ab);
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 0432a702416b..fe44d0dfce19 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -63,6 +63,7 @@ struct ath11k_msi_config {
 enum ath11k_pci_flags {
 	ATH11K_PCI_FLAG_INIT_DONE,
 	ATH11K_PCI_FLAG_IS_MSI_64,
+	ATH11K_PCI_ASPM_RESTORE,
 };
 
 struct ath11k_pci {
@@ -80,6 +81,7 @@ struct ath11k_pci {
 
 	/* enum ath11k_pci_flags */
 	unsigned long flags;
+	u16 link_ctl;
 };
 
 static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
-- 
2.7.4

