Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36E72D7EFE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 20:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbgLKTCF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 14:02:05 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:44961 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389247AbgLKTBf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 14:01:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607713275; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0dLCwOYu91d/7oLZRXNy8415GxOO/gg8wxKza4j250U=; b=q6BuEXEoz1HwITmyEkmi+m2Aq6KXFqj63XtJGxIy5KoLAbAPcmhNU4rwVz9qbAGWBrE5QaZ7
 5XamLMi7w86NrD1ODp9n4IkpWGUroMGERX/7kRDjzxb5A9clFv8c3i0oZucbzdtQvX01DCLX
 dNFcUUzKJlN/1VRzBMFchjslXE4=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fd3c1d635a25d1b162d7575 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 19:00:38
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 035D6C433CA; Fri, 11 Dec 2020 19:00:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7722CC433C6;
        Fri, 11 Dec 2020 19:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7722CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        briannorris@chromium.org, dianders@chromium.org,
        kuabhs@chromium.org, youghand@codeaurora.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v2] ath10k: Remove voltage regulator votes during wifi disable
Date:   Sat, 12 Dec 2020 00:30:30 +0530
Message-Id: <1607713230-18382-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the wlan is disabled, i.e when all the interfaces are
deleted, voltage regulator votes are not removed. This leads
to more power consumption even when wlan is disabled.

Move the adding/removing of voltage regulator votes as part
of hif power on/off in SNOC targets, so that these voltage
regulator votes are there only when wlan is enabled.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
Changes from v1:
- Remove the CE pipe init failure handling. Posted as a different patch
---
 drivers/net/wireless/ath/ath10k/snoc.c | 92 +++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index daae470..a5443fb 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1003,6 +1003,39 @@ static int ath10k_snoc_wlan_enable(struct ath10k *ar,
 				       NULL);
 }
 
+static int ath10k_hw_power_on(struct ath10k *ar)
+{
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	int ret;
+
+	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
+
+	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
+	if (ret)
+		goto vreg_off;
+
+	return ret;
+
+vreg_off:
+	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+	return ret;
+}
+
+static int ath10k_hw_power_off(struct ath10k *ar)
+{
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+
+	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power off\n");
+
+	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
+
+	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+}
+
 static void ath10k_snoc_wlan_disable(struct ath10k *ar)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
@@ -1024,6 +1057,7 @@ static void ath10k_snoc_hif_power_down(struct ath10k *ar)
 
 	ath10k_snoc_wlan_disable(ar);
 	ath10k_ce_free_rri(ar);
+	ath10k_hw_power_off(ar);
 }
 
 static int ath10k_snoc_hif_power_up(struct ath10k *ar,
@@ -1034,10 +1068,16 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "%s:WCN3990 driver state = %d\n",
 		   __func__, ar->state);
 
+	ret = ath10k_hw_power_on(ar);
+	if (ret) {
+		ath10k_err(ar, "failed to power on device: %d\n", ret);
+		return ret;
+	}
+
 	ret = ath10k_snoc_wlan_enable(ar, fw_mode);
 	if (ret) {
 		ath10k_err(ar, "failed to enable wcn3990: %d\n", ret);
-		return ret;
+		goto err_hw_power_off;
 	}
 
 	ath10k_ce_alloc_rri(ar);
@@ -1054,6 +1094,9 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 	ath10k_ce_free_rri(ar);
 	ath10k_snoc_wlan_disable(ar);
 
+err_hw_power_off:
+	ath10k_hw_power_off(ar);
+
 	return ret;
 }
 
@@ -1370,39 +1413,6 @@ static void ath10k_snoc_release_resource(struct ath10k *ar)
 		ath10k_ce_free_pipe(ar, i);
 }
 
-static int ath10k_hw_power_on(struct ath10k *ar)
-{
-	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
-	int ret;
-
-	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
-
-	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
-	if (ret)
-		return ret;
-
-	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
-	if (ret)
-		goto vreg_off;
-
-	return ret;
-
-vreg_off:
-	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
-	return ret;
-}
-
-static int ath10k_hw_power_off(struct ath10k *ar)
-{
-	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
-
-	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power off\n");
-
-	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
-
-	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
-}
-
 static void ath10k_msa_dump_memory(struct ath10k *ar,
 				   struct ath10k_fw_crash_data *crash_data)
 {
@@ -1712,22 +1722,16 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_irq;
 
-	ret = ath10k_hw_power_on(ar);
-	if (ret) {
-		ath10k_err(ar, "failed to power on device: %d\n", ret);
-		goto err_free_irq;
-	}
-
 	ret = ath10k_setup_msa_resources(ar, msa_size);
 	if (ret) {
 		ath10k_warn(ar, "failed to setup msa resources: %d\n", ret);
-		goto err_power_off;
+		goto err_free_irq;
 	}
 
 	ret = ath10k_fw_init(ar);
 	if (ret) {
 		ath10k_err(ar, "failed to initialize firmware: %d\n", ret);
-		goto err_power_off;
+		goto err_free_irq;
 	}
 
 	ret = ath10k_qmi_init(ar, msa_size);
@@ -1743,9 +1747,6 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 err_fw_deinit:
 	ath10k_fw_deinit(ar);
 
-err_power_off:
-	ath10k_hw_power_off(ar);
-
 err_free_irq:
 	ath10k_snoc_free_irq(ar);
 
@@ -1773,7 +1774,6 @@ static int ath10k_snoc_remove(struct platform_device *pdev)
 	set_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags);
 
 	ath10k_core_unregister(ar);
-	ath10k_hw_power_off(ar);
 	ath10k_fw_deinit(ar);
 	ath10k_snoc_free_irq(ar);
 	ath10k_snoc_release_resource(ar);
-- 
2.7.4

