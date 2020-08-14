Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D359124454D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgHNHLJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:11:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16270 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgHNHLI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:11:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389067; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=W5c9romc241Uj29qNWX2iWte6L3uLbR0b8Bc9yAmzsM=; b=t5JCrL16DwmNxIPWR6Ggl8+cHiS+A60DALFxEHdgBiqdHoo32U1BtuMtYMgQTlmiLfDJ4avV
 V4ICGaWPVf0u2X01bmTmECTJoWLIeSrgQD1mjxoEktPwfn+4tEwcs4vWb2J3YjPaHNjrhXo9
 Mv6oNBXbE/5xkxz/Bwm7kTbQ7I8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f3638f0d96d28d61eef40c9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88097C433C6; Fri, 14 Aug 2020 07:10:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40695C433CB;
        Fri, 14 Aug 2020 07:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40695C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 04/11] ath11k: pci: add read32() and write32() hif operations
Date:   Fri, 14 Aug 2020 10:10:23 +0300
Message-Id: <1597389030-13887-5-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

Add support for bus read/write/window selection operations
for reading hardware memory.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 55 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.h |  4 +++
 2 files changed, 59 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 47ee5689a5e2..10c281ece3d4 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -18,6 +18,12 @@
 
 #define ATH11K_PCI_IRQ_CE0_OFFSET		3
 
+#define WINDOW_ENABLE_BIT		0x40000000
+#define WINDOW_REG_ADDRESS		0x310c
+#define WINDOW_VALUE_MASK		GENMASK(24, 19)
+#define WINDOW_START			0x80000
+#define WINDOW_RANGE_MASK		GENMASK(18, 0)
+
 #define QCA6390_DEVICE_ID		0x1101
 
 static const struct pci_device_id ath11k_pci_id_table[] = {
@@ -280,6 +286,52 @@ static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
 	"tcl2host-status-ring",
 };
 
+static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
+{
+	struct ath11k_base *ab = ab_pci->ab;
+
+	u32 window = FIELD_GET(WINDOW_VALUE_MASK, offset);
+
+	lockdep_assert_held(&ab_pci->window_lock);
+
+	if (window != ab_pci->register_window) {
+		iowrite32(WINDOW_ENABLE_BIT | window,
+			  ab->mem + WINDOW_REG_ADDRESS);
+		ab_pci->register_window = window;
+	}
+}
+
+static void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	if (offset < WINDOW_START) {
+		iowrite32(value, ab->mem  + offset);
+	} else {
+		spin_lock_bh(&ab_pci->window_lock);
+		ath11k_pci_select_window(ab_pci, offset);
+		iowrite32(value, ab->mem + WINDOW_START + (offset & WINDOW_RANGE_MASK));
+		spin_unlock_bh(&ab_pci->window_lock);
+	}
+}
+
+static u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 val;
+
+	if (offset < WINDOW_START) {
+		val = ioread32(ab->mem + offset);
+	} else {
+		spin_lock_bh(&ab_pci->window_lock);
+		ath11k_pci_select_window(ab_pci, offset);
+		val = ioread32(ab->mem + WINDOW_START + (offset & WINDOW_RANGE_MASK));
+		spin_unlock_bh(&ab_pci->window_lock);
+	}
+
+	return val;
+}
+
 int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -578,6 +630,8 @@ static int ath11k_pci_start(struct ath11k_base *ab)
 static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.start = ath11k_pci_start,
 	.stop = ath11k_pci_stop,
+	.read32 = ath11k_pci_read32,
+	.write32 = ath11k_pci_write32,
 	.power_down = ath11k_pci_power_down,
 	.power_up = ath11k_pci_power_up,
 };
@@ -618,6 +672,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	ab_pci->pdev = pdev;
 	ab->hif.ops = &ath11k_pci_hif_ops;
 	pci_set_drvdata(pdev, ab);
+	spin_lock_init(&ab_pci->window_lock);
 
 	ret = ath11k_pci_claim(ab_pci, pdev);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 85e033069d7a..0a262c7307fd 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -29,6 +29,10 @@ struct ath11k_pci {
 	u32 msi_ep_base_data;
 	struct mhi_controller *mhi_ctrl;
 	unsigned long mhi_state;
+	u32 register_window;
+
+	/* protects register_window above */
+	spinlock_t window_lock;
 };
 
 static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
-- 
2.7.4

