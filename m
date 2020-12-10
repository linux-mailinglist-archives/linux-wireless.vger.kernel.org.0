Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE78C2D5D0B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 15:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389981AbgLJOG6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 09:06:58 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:55380 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389973AbgLJOGZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 09:06:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607609170; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=8f6Wwbr3ebIfIkoU5u7amqc1MjaQk77CnDn7dwd3XYM=; b=taPBNQGjndHUYJDE8/e4lvLKNK2zkjPJeZIDwd3sd73/Pmik5CQfwLkbvzBNq7KOgPXTKVpT
 D1RnxXJ1zP9TIbQn+7lHtTzv44WLw/CpfuirXf/LhJn9QciXeBtWJWikod6QP+sRiRQq0eDR
 T9COQuLmCcmR71TFQ0wljDmr7h4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fd22b306752249c541f2706 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Dec 2020 14:05:36
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D4CA5C43462; Thu, 10 Dec 2020 14:05:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A45ADC43461;
        Thu, 10 Dec 2020 14:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A45ADC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/6] ath11k: pci: disable VDD4BLOW
Date:   Thu, 10 Dec 2020 16:05:23 +0200
Message-Id: <1607609124-17250-6-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
References: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

It's recommended to disable VDD4BLOW during initialisation.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 10 ++++++++++
 drivers/net/wireless/ath/ath11k/pci.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 064c35052697..818e37c32a85 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -346,6 +346,15 @@ static void ath11k_pci_clear_all_intrs(struct ath11k_base *ab)
 	ath11k_pci_write32(ab, PCIE_PCIE_INT_ALL_CLEAR, PCIE_INT_CLEAR_ALL);
 }
 
+static void ath11k_pci_set_wlaon_pwr_ctrl(struct ath11k_base *ab)
+{
+	u32 val;
+
+	val = ath11k_pci_read32(ab, WLAON_QFPROM_PWR_CTRL_REG);
+	val &= ~QFPROM_PWR_CTRL_VDD4BLOW_MASK;
+	ath11k_pci_write32(ab, WLAON_QFPROM_PWR_CTRL_REG, val);
+}
+
 static void ath11k_pci_force_wake(struct ath11k_base *ab)
 {
 	ath11k_pci_write32(ab, PCIE_SOC_WAKE_PCIE_LOCAL_REG, 1);
@@ -357,6 +366,7 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 	if (power_on) {
 		ath11k_pci_enable_ltssm(ab);
 		ath11k_pci_clear_all_intrs(ab);
+		ath11k_pci_set_wlaon_pwr_ctrl(ab);
 		ath11k_pci_fix_l1ss(ab);
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 6e7cc8904c3d..0432a702416b 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -45,6 +45,9 @@
 #define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG4_VAL	0xff
 #define PCIE_USB3_PCS_MISC_OSC_DTCT_CONFIG_MSK	0x000000ff
 
+#define WLAON_QFPROM_PWR_CTRL_REG		0x01f8031c
+#define QFPROM_PWR_CTRL_VDD4BLOW_MASK		0x4
+
 struct ath11k_msi_user {
 	char *name;
 	int num_vectors;
-- 
2.7.4

