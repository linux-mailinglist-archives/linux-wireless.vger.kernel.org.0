Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406022DD40F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 16:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgLQPXO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 10:23:14 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:28918 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgLQPXO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 10:23:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608218570; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pyf2tLIZ+/7kutI8YsczrpoByzU49mm9UT18IYwlNEs=; b=Cqj3jSqL+0Lqmw32Tpx7UXO7dK19qd2eb8RRrb4ccJA/QFrZ+3yVKQ82TqpClapC0VriNBAs
 KabQ7T4yGIUrmweAaOgzXq7aND617c0GTCapqIkf2ULCWJhp9JEXi5yKbM5fEimgce+haQq3
 lfujxg0NERdWIz2XiceeMLW4WKQ=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fdb77a793a3d2b1cda629e2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 17 Dec 2020 15:22:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 035E0C433CA; Thu, 17 Dec 2020 15:22:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B4E3C433C6;
        Thu, 17 Dec 2020 15:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B4E3C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] ath11k: pci: disable ASPM L0sLs before downloading firmware
Date:   Thu, 17 Dec 2020 17:22:10 +0200
Message-Id: <1608218530-15426-1-git-send-email-kvalo@codeaurora.org>
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

v2:

* add debug messages for asmp state 

* add comment to power_down()

 drivers/net/wireless/ath/ath11k/pci.c | 36 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 9f9a824a4c2d..20b415cd96c4 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -886,6 +886,32 @@ static void ath11k_pci_free_region(struct ath11k_pci *ab_pci)
 		pci_disable_device(pci_dev);
 }
 
+static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+
+	pcie_capability_read_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+				  &ab_pci->link_ctl);
+
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci link_ctl 0x%04x L0s %d L1 %d\n",
+		   ab_pci->link_ctl,
+		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L0S),
+		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
+
+	/* disable L0s and L1 */
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
@@ -895,6 +921,11 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
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
@@ -908,6 +939,9 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
+	/* restore aspm in case firmware bootup fails */
+	ath11k_pci_aspm_restore(ab_pci);
+
 	ath11k_pci_force_wake(ab_pci->ab);
 	ath11k_mhi_stop(ab_pci);
 	clear_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
@@ -965,6 +999,8 @@ static int ath11k_pci_start(struct ath11k_base *ab)
 
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

