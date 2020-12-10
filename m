Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846A52D5D03
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 15:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbgLJOGs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 09:06:48 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:49349 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389971AbgLJOGV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 09:06:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607609162; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=I2VRYS0aQo33VyXwNsJosFngtpQyyVbRxtfCror+cIw=; b=UmuT4oyCn0aVO9p+5T2iIakNUZpP9myIxZIcG3m0vxC7t/ipFTLvCBPSr6PKcnnc2p8H3aZD
 TxjozShkUtuY2gg+04IoA5okevKOBslZb50kc8xTD85yP905sWlE3TlQSqhA3NIKAP3Icxg+
 szYbaLMiYVrJXGPhmwavXXChrB0=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fd22b2f35a25d1b166cf95b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Dec 2020 14:05:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B903DC43462; Thu, 10 Dec 2020 14:05:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F0ECC43464;
        Thu, 10 Dec 2020 14:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F0ECC43464
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/6] ath11k: pci: fix L1ss clock unstable problem
Date:   Thu, 10 Dec 2020 16:05:22 +0200
Message-Id: <1607609124-17250-5-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
References: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390, one PCI related clock drifts sometimes, and
it makes PCI link difficult to quit L1ss. Fix it by writing
some registers which are known to fix the problem.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 70 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.h | 11 ++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 9b6d4bb40e6c..064c35052697 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -239,6 +239,75 @@ static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
 	ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause:%d\n", val);
 }
 
+static int ath11k_pci_set_link_reg(struct ath11k_base *ab,
+				   u32 offset, u32 value, u32 mask)
+{
+	u32 v;
+	int i;
+
+	v = ath11k_pci_read32(ab, offset);
+	if ((v & mask) == value)
+		return 0;
+
+	for (i = 0; i < 10; i++) {
+		ath11k_pci_write32(ab, offset, (v & ~mask) | value);
+
+		v = ath11k_pci_read32(ab, offset);
+		if ((v & mask) == value)
+			return 0;
+
+		mdelay(2);
+	}
+
+	ath11k_warn(ab, "failed to set pcie link register 0x%08x: 0x%08x != 0x%08x\n",
+		    offset, v & mask, value);
+
+	return -ETIMEDOUT;
+}
+
+static int ath11k_pci_fix_l1ss(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_pci_set_link_reg(ab,
+				      PCIE_QSERDES_COM_SYSCLK_EN_SEL_REG,
+				      PCIE_QSERDES_COM_SYSCLK_EN_SEL_VAL,
+				      PCIE_QSERDES_COM_SYSCLK_EN_SEL_MSK);
+	if (!ret) {
+		ath11k_warn(ab, "failed to set sysclk: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath11k_pci_set_link_reg(ab,
+				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG1_REG,
+				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG1_VAL,
+				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK);
+	if (!ret) {
+		ath11k_warn(ab, "failed to set dtct config1 error: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath11k_pci_set_link_reg(ab,
+				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG2_REG,
+				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG2_VAL,
+				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK);
+	if (!ret) {
+		ath11k_warn(ab, "failed to set dtct config2: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath11k_pci_set_link_reg(ab,
+				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_REG,
+				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_VAL,
+				      PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK);
+	if (!ret) {
+		ath11k_warn(ab, "failed to set dtct config4: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void ath11k_pci_enable_ltssm(struct ath11k_base *ab)
 {
 	u32 val;
@@ -288,6 +357,7 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 	if (power_on) {
 		ath11k_pci_enable_ltssm(ab);
 		ath11k_pci_clear_all_intrs(ab);
+		ath11k_pci_fix_l1ss(ab);
 	}
 
 	ath11k_mhi_clear_vector(ab);
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 296f1ca6b3ec..6e7cc8904c3d 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -34,6 +34,17 @@
 #define PCIE_SMLH_REQ_RST_LINK_DOWN		0x2
 #define PCIE_INT_CLEAR_ALL			0xffffffff
 
+#define PCIE_QSERDES_COM_SYSCLK_EN_SEL_REG	0x01e0c0ac
+#define PCIE_QSERDES_COM_SYSCLK_EN_SEL_VAL	0x10
+#define PCIE_QSERDES_COM_SYSCLK_EN_SEL_MSK	0xffffffff
+#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG1_REG	0x01e0c628
+#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG1_VAL	0x02
+#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG2_REG	0x01e0c62c
+#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG2_VAL	0x52
+#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_REG	0x01e0c634
+#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_VAL	0xff
+#define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK	0x000000ff
+
 struct ath11k_msi_user {
 	char *name;
 	int num_vectors;
-- 
2.7.4

