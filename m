Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5C243722
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMJFT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:05:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62235 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgHMJFT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:05:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597309518; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=bFposhUySHtPymHNP6hUc158SQ0QlAaw6JEsU+7eIik=; b=lX/s6cNYANOtTV03ZYtursudkvgEuqO9cbPx1tkc4itnjdyHeOJx8QzbP6y/6GtjcUo5tcjk
 vWWRGdrXEgYnEXeEASeNJj168+IWtd13yvIf9HsbGyBeGrXVXIoDuFM1cE5WTm8FxcJ1Lq0f
 45RSVufOQWRD7K9660TRqFSBOnc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f35022e85672017511c8092 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 09:04:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13DB7C433C9; Thu, 13 Aug 2020 09:04:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AFB5C433C6;
        Thu, 13 Aug 2020 09:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AFB5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 10/10] ath11k: use remoteproc only with AHB devices
Date:   Thu, 13 Aug 2020 12:04:26 +0300
Message-Id: <1597309466-19688-11-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
References: <1597309466-19688-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

QCA6390 and other PCI devices use MHI based firmware loading and do not use
remoteproc, so enable it only for AHB devices.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Kconfig |  2 +-
 drivers/net/wireless/ath/ath11k/ahb.c   |  6 +++++-
 drivers/net/wireless/ath/ath11k/core.c  | 29 ++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/core.h  | 10 +++++++++-
 drivers/net/wireless/ath/ath11k/pci.c   |  7 ++++++-
 5 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 7e5094e0e7bb..ad5cc6cac05b 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -2,7 +2,6 @@
 config ATH11K
 	tristate "Qualcomm Technologies 802.11ax chipset support"
 	depends on MAC80211 && HAS_DMA
-	depends on REMOTEPROC
 	depends on CRYPTO_MICHAEL_MIC
 	select ATH_COMMON
 	select QCOM_QMI_HELPERS
@@ -15,6 +14,7 @@ config ATH11K
 config ATH11K_AHB
 	tristate "Atheros ath11k AHB support"
 	depends on ATH11K
+	depends on REMOTEPROC
 	help
 	  This module adds support for AHB bus
 
diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index f4c346bcc676..f00c4cc76d74 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -25,6 +25,10 @@ static const struct of_device_id ath11k_ahb_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, ath11k_ahb_of_match);
 
+static const struct ath11k_bus_params ath11k_ahb_bus_params = {
+	.mhi_support = false,
+};
+
 /* Target firmware's Copy Engine configuration. */
 static const struct ce_pipe_config target_ce_config_wlan[] = {
 	/* CE0: host->target HTC control and raw streams */
@@ -855,7 +859,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ab = ath11k_core_alloc(&pdev->dev, 0, ATH11K_BUS_AHB);
+	ab = ath11k_core_alloc(&pdev->dev, 0, ATH11K_BUS_AHB, &ath11k_ahb_bus_params);
 	if (!ab) {
 		dev_err(&pdev->dev, "failed to allocate ath11k base\n");
 		return -ENOMEM;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 741093de3a83..22657dac7749 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -756,12 +756,14 @@ int ath11k_core_pre_init(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_core_pre_init);
 
-int ath11k_core_init(struct ath11k_base *ab)
+static int ath11k_core_get_rproc(struct ath11k_base *ab)
 {
 	struct device *dev = ab->dev;
 	struct rproc *prproc;
 	phandle rproc_phandle;
-	int ret;
+
+	if (ab->bus_params.mhi_support)
+		return 0;
 
 	if (of_property_read_u32(dev->of_node, "qcom,rproc", &rproc_phandle)) {
 		ath11k_err(ab, "failed to get q6_rproc handle\n");
@@ -775,6 +777,25 @@ int ath11k_core_init(struct ath11k_base *ab)
 	}
 	ab->tgt_rproc = prproc;
 
+	return 0;
+}
+
+int ath11k_core_init(struct ath11k_base *ab)
+{
+	int ret;
+
+	ret = ath11k_core_get_rproc(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to get rproc: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath11k_init_hw_params(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to get hw params %d\n", ret);
+		return ret;
+	}
+
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create soc core: %d\n", ret);
@@ -807,7 +828,8 @@ void ath11k_core_free(struct ath11k_base *ab)
 EXPORT_SYMBOL(ath11k_core_free);
 
 struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
-				      enum ath11k_bus bus)
+				      enum ath11k_bus bus,
+				      const struct ath11k_bus_params *bus_params)
 {
 	struct ath11k_base *ab;
 
@@ -830,6 +852,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	ab->dev = dev;
+	ab->bus_params = *bus_params;
 
 	return ab;
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a0a7c7b003c1..0309b13e38c9 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -580,6 +580,10 @@ struct ath11k_board_data {
 	size_t len;
 };
 
+struct ath11k_bus_params {
+	bool mhi_support;
+};
+
 /* IPQ8074 HW channel counters frequency value in hertz */
 #define IPQ8074_CC_FREQ_HERTZ 320000
 
@@ -668,7 +672,10 @@ struct ath11k_base {
 	u32 ext_service_bitmap[WMI_SERVICE_EXT_BM_SIZE];
 	bool pdevs_macaddr_valid;
 	int bd_api;
+
 	struct ath11k_hw_params hw_params;
+	struct ath11k_bus_params bus_params;
+
 	const struct firmware *cal_file;
 
 	/* Below regd's are protected by ab->data_lock */
@@ -845,7 +852,8 @@ int ath11k_core_pre_init(struct ath11k_base *ab);
 int ath11k_core_init(struct ath11k_base *ath11k);
 void ath11k_core_deinit(struct ath11k_base *ath11k);
 struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
-				      enum ath11k_bus bus);
+				      enum ath11k_bus bus,
+				      const struct ath11k_bus_params *bus_params);
 void ath11k_core_free(struct ath11k_base *ath11k);
 int ath11k_core_fetch_bdf(struct ath11k_base *ath11k,
 			  struct ath11k_board_data *bd);
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d1068766972d..d09faaf747ba 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -27,6 +27,10 @@ static const struct pci_device_id ath11k_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, ath11k_pci_id_table);
 
+static const struct ath11k_bus_params ath11k_pci_bus_params = {
+	.mhi_support = true,
+};
+
 static const struct ath11k_msi_config msi_config = {
 	.total_vectors = 32,
 	.total_users = 4,
@@ -594,7 +598,8 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		return -ENOTSUPP;
 	}
 
-	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI);
+	ab = ath11k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH11K_BUS_PCI,
+			       &ath11k_pci_bus_params);
 	if (!ab) {
 		dev_err(&pdev->dev, "failed to allocate ath11k base\n");
 		return -ENOMEM;
-- 
2.7.4

