Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5598F190DF7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 13:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCXMr5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 08:47:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:36975 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727597AbgCXMr5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 08:47:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585054077; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5Sre8Tm4VS59NCnHbjdwZMcLATTbFgJ8z/xFYnP3XD0=; b=FYtO9KqygtE6TKocWCK1YVKlnvx6Jz5GlZwrnWHpCm/bxbwngxjMneTbbIt7KFs5DtAdrlBw
 /lgAKuTW3OIt1FONl4mzuCAwi5QC8rgtrxJmJQ+GlPow1+FuXsZZurfNpgp3xYP8HJP/KHSC
 HTNqBOL+6qDUteOWeF0J8lkg038=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7a0169.7f3a78071810-smtp-out-n03;
 Tue, 24 Mar 2020 12:47:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7380DC433CB; Tue, 24 Mar 2020 12:47:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20269C432C2;
        Tue, 24 Mar 2020 12:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20269C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH 2/3] ath10k: Setup the msa resources before qmi init
Date:   Tue, 24 Mar 2020 18:17:23 +0530
Message-Id: <1585054044-18667-3-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585054044-18667-1-git-send-email-pillair@codeaurora.org>
References: <1585054044-18667-1-git-send-email-pillair@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move the msa resources setup out of qmi init and
setup the msa resources as a part of probe before
the qmi init is done.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.h |  5 ++++
 drivers/net/wireless/ath/ath10k/qmi.c  | 55 ++++------------------------------
 drivers/net/wireless/ath/ath10k/qmi.h  |  3 --
 drivers/net/wireless/ath/ath10k/snoc.c | 51 +++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index bd8ef57..89d5c07 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -949,6 +949,11 @@ struct ath10k {
 	struct ieee80211_hw *hw;
 	struct ieee80211_ops *ops;
 	struct device *dev;
+	struct msa_region {
+		dma_addr_t paddr;
+		u32 mem_size;
+		void *vaddr;
+	} msa;
 	u8 mac_addr[ETH_ALEN];
 
 	enum ath10k_hw_rev hw_rev;
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 85dce43..b57e962 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -122,8 +122,8 @@ static int ath10k_qmi_msa_mem_info_send_sync_msg(struct ath10k_qmi *qmi)
 	int ret;
 	int i;
 
-	req.msa_addr = qmi->msa_pa;
-	req.size = qmi->msa_mem_size;
+	req.msa_addr = ar->msa.paddr;
+	req.size = ar->msa.mem_size;
 
 	ret = qmi_txn_init(&qmi->qmi_hdl, &txn,
 			   wlfw_msa_info_resp_msg_v01_ei, &resp);
@@ -1006,54 +1006,10 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
 	spin_unlock(&qmi->event_lock);
 }
 
-static int ath10k_qmi_setup_msa_resources(struct ath10k_qmi *qmi, u32 msa_size)
-{
-	struct ath10k *ar = qmi->ar;
-	struct device *dev = ar->dev;
-	struct device_node *node;
-	struct resource r;
-	int ret;
-
-	node = of_parse_phandle(dev->of_node, "memory-region", 0);
-	if (node) {
-		ret = of_address_to_resource(node, 0, &r);
-		if (ret) {
-			dev_err(dev, "failed to resolve msa fixed region\n");
-			return ret;
-		}
-		of_node_put(node);
-
-		qmi->msa_pa = r.start;
-		qmi->msa_mem_size = resource_size(&r);
-		qmi->msa_va = devm_memremap(dev, qmi->msa_pa, qmi->msa_mem_size,
-					    MEMREMAP_WT);
-		if (IS_ERR(qmi->msa_va)) {
-			dev_err(dev, "failed to map memory region: %pa\n", &r.start);
-			return PTR_ERR(qmi->msa_va);
-		}
-	} else {
-		qmi->msa_va = dmam_alloc_coherent(dev, msa_size,
-						  &qmi->msa_pa, GFP_KERNEL);
-		if (!qmi->msa_va) {
-			ath10k_err(ar, "failed to allocate dma memory for msa region\n");
-			return -ENOMEM;
-		}
-		qmi->msa_mem_size = msa_size;
-	}
-
-	if (of_property_read_bool(dev->of_node, "qcom,msa-fixed-perm"))
-		qmi->msa_fixed_perm = true;
-
-	ath10k_dbg(ar, ATH10K_DBG_QMI, "msa pa: %pad , msa va: 0x%p\n",
-		   &qmi->msa_pa,
-		   qmi->msa_va);
-
-	return 0;
-}
-
 int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	struct device *dev = ar->dev;
 	struct ath10k_qmi *qmi;
 	int ret;
 
@@ -1064,9 +1020,8 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
 	qmi->ar = ar;
 	ar_snoc->qmi = qmi;
 
-	ret = ath10k_qmi_setup_msa_resources(qmi, msa_size);
-	if (ret)
-		goto err;
+	if (of_property_read_bool(dev->of_node, "qcom,msa-fixed-perm"))
+		qmi->msa_fixed_perm = true;
 
 	ret = qmi_handle_init(&qmi->qmi_hdl,
 			      WLFW_BDF_DOWNLOAD_REQ_MSG_V01_MAX_MSG_LEN,
diff --git a/drivers/net/wireless/ath/ath10k/qmi.h b/drivers/net/wireless/ath/ath10k/qmi.h
index dc25737..450be18 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.h
+++ b/drivers/net/wireless/ath/ath10k/qmi.h
@@ -93,9 +93,6 @@ struct ath10k_qmi {
 	spinlock_t event_lock; /* spinlock for qmi event list */
 	u32 nr_mem_region;
 	struct ath10k_msa_mem_info mem_region[MAX_NUM_MEMORY_REGIONS];
-	dma_addr_t msa_pa;
-	u32 msa_mem_size;
-	void *msa_va;
 	struct ath10k_qmi_chip_info chip_info;
 	struct ath10k_qmi_board_info board_info;
 	struct ath10k_qmi_soc_info soc_info;
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 21081b4..baba36c 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of_address.h>
 
 #include "ce.h"
 #include "coredump.h"
@@ -1455,6 +1456,50 @@ void ath10k_snoc_fw_crashed_dump(struct ath10k *ar)
 	mutex_unlock(&ar->dump_mutex);
 }
 
+static int ath10k_setup_msa_resources(struct ath10k *ar, u32 msa_size)
+{
+	struct device *dev = ar->dev;
+	struct device_node *node;
+	struct resource r;
+	int ret;
+
+	node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (node) {
+		ret = of_address_to_resource(node, 0, &r);
+		if (ret) {
+			dev_err(dev, "failed to resolve msa fixed region\n");
+			return ret;
+		}
+		of_node_put(node);
+
+		ar->msa.paddr = r.start;
+		ar->msa.mem_size = resource_size(&r);
+		ar->msa.vaddr = devm_memremap(dev, ar->msa.paddr,
+					      ar->msa.mem_size,
+					      MEMREMAP_WT);
+		if (IS_ERR(ar->msa.vaddr)) {
+			dev_err(dev, "failed to map memory region: %pa\n",
+				&r.start);
+			return PTR_ERR(ar->msa.vaddr);
+		}
+	} else {
+		ar->msa.vaddr = dmam_alloc_coherent(dev, msa_size,
+						    &ar->msa.paddr,
+						    GFP_KERNEL);
+		if (!ar->msa.vaddr) {
+			ath10k_err(ar, "failed to allocate dma memory for msa region\n");
+			return -ENOMEM;
+		}
+		ar->msa.mem_size = msa_size;
+	}
+
+	ath10k_dbg(ar, ATH10K_DBG_QMI, "qmi msa.paddr: %pad , msa.vaddr: 0x%p\n",
+		   &ar->msa.paddr,
+		   ar->msa.vaddr);
+
+	return 0;
+}
+
 static const struct of_device_id ath10k_snoc_dt_match[] = {
 	{ .compatible = "qcom,wcn3990-wifi",
 	 .data = &drv_priv,
@@ -1557,6 +1602,12 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
+	ret = ath10k_setup_msa_resources(ar, msa_size);
+	if (ret) {
+		ath10k_warn(ar, "failed to setup msa resources: %d\n", ret);
+		goto err_power_off;
+	}
+
 	ret = ath10k_qmi_init(ar, msa_size);
 	if (ret) {
 		ath10k_warn(ar, "failed to register wlfw qmi client: %d\n", ret);
-- 
2.7.4
