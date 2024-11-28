Return-Path: <linux-wireless+bounces-15789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D629DBB84
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 17:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EEA280A86
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7851AE016;
	Thu, 28 Nov 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzJuezd0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7A1AA1E4
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812630; cv=none; b=D+jZMPbk2fQPHyDFSv/R6B2HU99CbnAQeNPDebdxRWEDmCR98fZ3tWjQ0EnulPIRlm/8uV/Y1HdtBrDRQuKyC4RsUsioFdaeb8ZQxCs90B4EZhsJuCnoL7NO6dLmJCrUi1DDt0ZI6UD33C6myfOcfFLcgYcxEA/Iv0l2NV7ILos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812630; c=relaxed/simple;
	bh=ZP5C0PE1cibmD1295T5bQ3/he8sNMjT7Zg7i8eeJ3X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ax7iAV/RClgBUvTMzCoSqdbF2yVtnntOJ9ShaPttmjgOiaH2/CwDIaWWQsYevKkhJMlpaf6fVMAMUrPjRsDgLPLuZBY1iTDI8yjAKybBNr3iX7XmzmY37ZY/DYHsngi4jeR7vdeS2VbZg5cO7jqFKla7MT6YITAx5nw4yj7uDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzJuezd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF4CC4CED2;
	Thu, 28 Nov 2024 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732812630;
	bh=ZP5C0PE1cibmD1295T5bQ3/he8sNMjT7Zg7i8eeJ3X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzJuezd0ZhDM5EwM8X7jQ1TVkyDrbl25cLp8moJ5VXPmqyd4+hXvJllHRAYedVrFB
	 1VsC5PUpefzT9nUH9dTuNhOD1wHjqVCFb5el45150VNEgANbVrUJt6Wfn2TFCOcRry
	 ff+nLvBg6pVNbwCdFs7AE3Mv4tbQhINWSDqFM8PPS8piVoOJj/xz6ernlJ+nKl026e
	 nYBK5TRfL6ezh8q9Bp+8Ym/fxFPefK/a90sryDUPzvxg20NSWA3sN/Wm/0BxI4sZsL
	 wLHDNGCRzrVFzbp7mJGPehv/TpTG9ZH2nX7P4z7PyyWaZLA2eQciKz4kTdIA8USYRU
	 qcZJgPkAcSVZA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] wifi: ath12k: Refactor core startup
Date: Thu, 28 Nov 2024 18:50:23 +0200
Message-Id: <20241128165026.2618331-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128165026.2618331-1-kvalo@kernel.org>
References: <20241128165026.2618331-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

In the upcoming hardware device group abstraction radios across different
devices can be grouped together to support multi-link operation and register as
a device group to mac80211.

Currently, ath12k_mac_allocate() and ath12k_mac_register() are part of
ath12k_core_start() and ath12k_core_pdev_create() respectively and are based on
per device (struct ath12k_base). These APIs can be decoupled and moved out to
ath12k_core_qmi_firmware_ready() itself. This refactor is helpful for device
group abstraction when mac80211 allocate and register will be changed from per
device (struct ath12k_base) to per device group (struct ath12k_hw_group).

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 63 ++++++++++++--------------
 drivers/net/wireless/ath/ath12k/dp.c   |  7 +++
 drivers/net/wireless/ath/ath12k/pci.c  |  9 ++++
 drivers/net/wireless/ath/ath12k/qmi.c  |  4 ++
 4 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 263a7c789122..5313b0267307 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -604,9 +604,10 @@ static void ath12k_core_stop(struct ath12k_base *ab)
 
 	ath12k_acpi_stop(ab);
 
+	ath12k_dp_rx_pdev_reo_cleanup(ab);
 	ath12k_hif_stop(ab);
 	ath12k_wmi_detach(ab);
-	ath12k_dp_rx_pdev_reo_cleanup(ab);
+	ath12k_dp_free(ab);
 
 	/* De-Init of components as needed */
 }
@@ -708,7 +709,7 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
 
 static void ath12k_core_soc_destroy(struct ath12k_base *ab)
 {
-	ath12k_dp_free(ab);
+	ath12k_hif_power_down(ab, false);
 	ath12k_reg_free(ab);
 	ath12k_debugfs_soc_destroy(ab);
 	ath12k_qmi_deinit_service(ab);
@@ -718,30 +719,17 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
 {
 	int ret;
 
-	ret = ath12k_mac_register(ab);
-	if (ret) {
-		ath12k_err(ab, "failed register the radio with mac80211: %d\n", ret);
-		return ret;
-	}
-
 	ret = ath12k_dp_pdev_alloc(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to attach DP pdev: %d\n", ret);
-		goto err_mac_unregister;
+		return ret;
 	}
 
 	return 0;
-
-err_mac_unregister:
-	ath12k_mac_unregister(ab);
-
-	return ret;
 }
 
 static void ath12k_core_pdev_destroy(struct ath12k_base *ab)
 {
-	ath12k_mac_unregister(ab);
-	ath12k_hif_irq_disable(ab);
 	ath12k_dp_pdev_free(ab);
 }
 
@@ -799,19 +787,12 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		goto err_hif_stop;
 	}
 
-	ret = ath12k_mac_allocate(ab);
-	if (ret) {
-		ath12k_err(ab, "failed to create new hw device with mac80211 :%d\n",
-			   ret);
-		goto err_hif_stop;
-	}
-
 	ath12k_dp_cc_config(ab);
 
 	ret = ath12k_dp_rx_pdev_reo_setup(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to initialize reo destination rings: %d\n", ret);
-		goto err_mac_destroy;
+		goto err_hif_stop;
 	}
 
 	ath12k_dp_hal_rx_desc_init(ab);
@@ -854,8 +835,6 @@ static int ath12k_core_start(struct ath12k_base *ab,
 
 err_reo_cleanup:
 	ath12k_dp_rx_pdev_reo_cleanup(ab);
-err_mac_destroy:
-	ath12k_mac_destroy(ab);
 err_hif_stop:
 	ath12k_hif_stop(ab);
 err_wmi_detach:
@@ -909,28 +888,46 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 		goto err_dp_free;
 	}
 
+	ret = ath12k_mac_allocate(ab);
+	if (ret) {
+		ath12k_err(ab, "failed to create new hw device with mac80211 :%d\n",
+			   ret);
+		goto err_core_stop;
+	}
+
+	ret = ath12k_mac_register(ab);
+	if (ret) {
+		ath12k_err(ab, "failed register the radio with mac80211: %d\n", ret);
+		goto err_mac_destroy;
+	}
+
 	ret = ath12k_core_pdev_create(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to create pdev core: %d\n", ret);
-		goto err_core_stop;
+		goto err_mac_unregister;
 	}
+
 	ath12k_hif_irq_enable(ab);
 
 	ret = ath12k_core_rfkill_config(ab);
 	if (ret && ret != -EOPNOTSUPP) {
 		ath12k_err(ab, "failed to config rfkill: %d\n", ret);
-		goto err_core_pdev_destroy;
+		goto err_hif_irq_disable;
 	}
 
 	mutex_unlock(&ab->core_lock);
 
 	return 0;
 
-err_core_pdev_destroy:
+err_hif_irq_disable:
+	ath12k_hif_irq_disable(ab);
 	ath12k_core_pdev_destroy(ab);
+err_mac_unregister:
+	ath12k_mac_unregister(ab);
+err_mac_destroy:
+	ath12k_mac_destroy(ab);
 err_core_stop:
 	ath12k_core_stop(ab);
-	ath12k_mac_destroy(ab);
 err_dp_free:
 	ath12k_dp_free(ab);
 	mutex_unlock(&ab->core_lock);
@@ -1270,15 +1267,15 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 
 	mutex_lock(&ab->core_lock);
 
+	ath12k_hif_irq_disable(ab);
 	ath12k_core_pdev_destroy(ab);
+	ath12k_mac_unregister(ab);
+	ath12k_mac_destroy(ab);
 	ath12k_core_stop(ab);
 
 	mutex_unlock(&ab->core_lock);
 
-	ath12k_hif_power_down(ab, false);
-	ath12k_mac_destroy(ab);
 	ath12k_core_soc_destroy(ab);
-	ath12k_fw_unmap(ab);
 }
 
 void ath12k_core_free(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 328be2c635d6..ce823b1c175f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -982,6 +982,9 @@ void ath12k_dp_pdev_free(struct ath12k_base *ab)
 {
 	int i;
 
+	if (!ab->mon_reap_timer.function)
+		return;
+
 	del_timer_sync(&ab->mon_reap_timer);
 
 	for (i = 0; i < ab->num_radios; i++)
@@ -1289,6 +1292,9 @@ void ath12k_dp_free(struct ath12k_base *ab)
 	struct ath12k_dp *dp = &ab->dp;
 	int i;
 
+	if (!dp->ab)
+		return;
+
 	ath12k_dp_link_desc_cleanup(ab, dp->link_desc_banks,
 				    HAL_WBM_IDLE_LINK, &dp->wbm_idle_ring);
 
@@ -1306,6 +1312,7 @@ void ath12k_dp_free(struct ath12k_base *ab)
 
 	ath12k_dp_rx_free(ab);
 	/* Deinit any SOC level resource */
+	dp->ab = NULL;
 }
 
 void ath12k_dp_cc_config(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index cf907550e6a4..8dbc7377ae7c 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1123,6 +1123,9 @@ void ath12k_pci_ext_irq_enable(struct ath12k_base *ab)
 
 void ath12k_pci_ext_irq_disable(struct ath12k_base *ab)
 {
+	if (!test_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
+		return;
+
 	__ath12k_pci_ext_irq_disable(ab);
 	ath12k_pci_sync_ext_irqs(ab);
 }
@@ -1147,6 +1150,11 @@ int ath12k_pci_hif_resume(struct ath12k_base *ab)
 
 void ath12k_pci_stop(struct ath12k_base *ab)
 {
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+
+	if (!test_bit(ATH12K_PCI_FLAG_INIT_DONE, &ab_pci->flags))
+		return;
+
 	ath12k_pci_ce_irq_disable_sync(ab);
 	ath12k_ce_cleanup_pipes(ab);
 }
@@ -1725,6 +1733,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 	cancel_work_sync(&ab->reset_work);
 	cancel_work_sync(&ab->dump_work);
 	ath12k_core_deinit(ab);
+	ath12k_fw_unmap(ab);
 
 qmi_fail:
 	ath12k_mhi_unregister(ab_pci);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index d2d9d03c7a28..f5388eae01dc 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3402,11 +3402,15 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 
 void ath12k_qmi_deinit_service(struct ath12k_base *ab)
 {
+	if (!ab->qmi.ab)
+		return;
+
 	qmi_handle_release(&ab->qmi.handle);
 	cancel_work_sync(&ab->qmi.event_work);
 	destroy_workqueue(ab->qmi.event_wq);
 	ath12k_qmi_m3_free(ab);
 	ath12k_qmi_free_target_mem_chunk(ab);
+	ab->qmi.ab = NULL;
 }
 
 void ath12k_qmi_free_resource(struct ath12k_base *ab)
-- 
2.39.5


