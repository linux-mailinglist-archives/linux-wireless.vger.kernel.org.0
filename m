Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC92D5D05
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 15:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbgLJOGt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 09:06:49 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:62636 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389974AbgLJOG1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 09:06:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607609169; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=+o0onyNdRe1GsZJpxVscNvvCxXl9h3Aw2qAPmXw9ugw=; b=iYs4yEr+CpRnCqQwp/MVlWdfHR9Dy8AE41koss8LmIz5LafVDevNwYAdcBmdQbi9hTxPll0r
 R9AKdlsBVwZI9bp2ONpUgUQ8RvHoC0X+TmoHbNP7wTidRW0xHvWCs1GHmcGcfOI9BZ5Uvpz0
 Oux1aWojbP5jP69EwgP92anUxf8=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fd22b2d42c04000264f8d99 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Dec 2020 14:05:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC61DC43463; Thu, 10 Dec 2020 14:05:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2700C433C6;
        Thu, 10 Dec 2020 14:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2700C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/6] ath11k: pci: fix hot reset stability issues
Date:   Thu, 10 Dec 2020 16:05:21 +0200
Message-Id: <1607609124-17250-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
References: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390, host needs to reset some registers before MHI power up to fix PCI
link unstable issue if hot reset happened. Also clear all pending interrupts
during power up.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 52 +++++++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/pci.h | 10 +++++++
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index c9ab1e9fc0fa..9b6d4bb40e6c 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -239,15 +239,57 @@ static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause:%d\n", val);
 }
 
+static void ath11k_pci_enable_ltssm(struct ath11k_base *ab)
+{
+	u32 val;
+	int i;
+
+	val = ath11k_pci_read32(ab, PCIE_PCIE_PARF_LTSSM);
+
+	/* PCIE link seems very unstable after the Hot Reset*/
+	for (i = 0; val != PARM_LTSSM_VALUE && i < 5; i++) {
+		if (val == 0xffffffff)
+			mdelay(5);
+
+		ath11k_pci_write32(ab, PCIE_PCIE_PARF_LTSSM, PARM_LTSSM_VALUE);
+		val = ath11k_pci_read32(ab, PCIE_PCIE_PARF_LTSSM);
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci ltssm 0x%x\n", val);
+
+	val = ath11k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST);
+	val |= GCC_GCC_PCIE_HOT_RST_VAL | 0x10;
+	ath11k_pci_write32(ab, GCC_GCC_PCIE_HOT_RST, val);
+	val = ath11k_pci_read32(ab, GCC_GCC_PCIE_HOT_RST);
+
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci pcie_hot_rst 0x%x\n", val);
+
+	mdelay(5);
+}
+
+static void ath11k_pci_clear_all_intrs(struct ath11k_base *ab)
+{
+	/* This is a WAR for PCIE Hotreset.
+	 * When target receive Hotreset, but will set the interrupt.
+	 * So when download SBL again, SBL will open Interrupt and
+	 * receive it, and crash immediately.
+	 */
+	ath11k_pci_write32(ab, PCIE_PCIE_INT_ALL_CLEAR, PCIE_INT_CLEAR_ALL);
+}
+
 static void ath11k_pci_force_wake(struct ath11k_base *ab)
 {
 	ath11k_pci_write32(ab, PCIE_SOC_WAKE_PCIE_LOCAL_REG, 1);
 	mdelay(5);
 }
 
-static void ath11k_pci_sw_reset(struct ath11k_base *ab)
+static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 {
-	ath11k_pci_soc_global_reset(ab);
+	if (power_on) {
+		ath11k_pci_enable_ltssm(ab);
+		ath11k_pci_clear_all_intrs(ab);
+	}
+
 	ath11k_mhi_clear_vector(ab);
 	ath11k_pci_soc_global_reset(ab);
 	ath11k_mhi_set_mhictrl_reset(ab);
@@ -770,7 +812,7 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 
 	ab_pci->register_window = 0;
 	clear_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
-	ath11k_pci_sw_reset(ab_pci->ab);
+	ath11k_pci_sw_reset(ab_pci->ab, true);
 
 	ret = ath11k_mhi_start(ab_pci);
 	if (ret) {
@@ -785,10 +827,10 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 
+	ath11k_pci_force_wake(ab_pci->ab);
 	ath11k_mhi_stop(ab_pci);
 	clear_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags);
-	ath11k_pci_force_wake(ab_pci->ab);
-	ath11k_pci_sw_reset(ab_pci->ab);
+	ath11k_pci_sw_reset(ab_pci->ab, false);
 }
 
 static void ath11k_pci_kill_tasklets(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 9c503a17c237..296f1ca6b3ec 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -24,6 +24,16 @@
 /* register used for handshake mechanism to validate UMAC is awake */
 #define PCIE_SOC_WAKE_PCIE_LOCAL_REG		0x3004
 
+#define PCIE_PCIE_PARF_LTSSM			0x1e081b0
+#define PARM_LTSSM_VALUE			0x111
+
+#define GCC_GCC_PCIE_HOT_RST			0x1e402bc
+#define GCC_GCC_PCIE_HOT_RST_VAL		0x10
+
+#define PCIE_PCIE_INT_ALL_CLEAR			0x1e08228
+#define PCIE_SMLH_REQ_RST_LINK_DOWN		0x2
+#define PCIE_INT_CLEAR_ALL			0xffffffff
+
 struct ath11k_msi_user {
 	char *name;
 	int num_vectors;
-- 
2.7.4

