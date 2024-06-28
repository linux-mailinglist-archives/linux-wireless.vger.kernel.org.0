Return-Path: <linux-wireless+bounces-9689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EAE91BBE4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED11286803
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97759153804;
	Fri, 28 Jun 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W1NtNX30"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A64D58A
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568318; cv=none; b=OC7sD7Nz1VSHLjW3Rq6Zu8yZutUwOOOnaYLkkjkprM7G0YGZ+BW1SZ7fl906Drmi5Su5vs6Eb2jF6qnoKdPJq2QNaml5SBfejr0zolGc7lNZOb76QcaH0K/yJ7/2HqUzHhY9ZkfmfO2e+FAbS6nHiQ/DpFuYkKpqYv/ZnXsXFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568318; c=relaxed/simple;
	bh=hlEkyfSxNb1UDuFo4xCOod59aqx6f9lHMKThZ1HrRDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNpqipiLMHruoBFe6CXhs4wCx7yxFGGeKvfwoJ4bIqVbHlhlJiD7OYXd7nUSzSYkQ9dSBiIaZqTQXArlvjsmmUTkVxC4NgpAsqJnxXhKHZL9oa0NlIq/JmfQ5m2Cvfe7DxtYP+orPG28LUCIGuKk21terCASYeOIM1VXnXqXZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W1NtNX30; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8fg6l010751;
	Fri, 28 Jun 2024 09:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=W5elCaGLtwR
	BmBAq21wDwjx/gn2d97na9PLh7TF7BcA=; b=W1NtNX30AUZMFllrZ0D2Rl5PnpK
	a5tISWOMyM6/z3LaUjuzWeddg9ZbO3vX6Aw9c1J8K3FbdpOUabAj5Xwu/vujRpwb
	8e39HK5EnTvSNMJc9v9a0xtEHVaZ7+NqsMmnSnc5rgyoMRFI+WhQViB2n3jhx/cv
	z1ydyNYWAMraWK5pHteD/jDeyfrwaDdeLfJ5hO9d0TjNyZ3YAr7thL8NI5Vr8Cqr
	cEYvn+QuGgleo76ujiLEhTUKnsvialAzMggqao15lNeP9IWY5+1jG7unUHfqpJaq
	QcDIrFn8Dr7ie4bgK7uV8kq3Gm2xqJPlT/1aHEYAIi9JSn6duVyjla9Zb8w==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400bdqf4t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:51:53 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S9pn9I017443;
	Fri, 28 Jun 2024 09:51:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3ywqpmmm1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:51:49 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45S9pnDD017437;
	Fri, 28 Jun 2024 09:51:49 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45S9pnb3017436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:51:49 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id BE17A410E0; Fri, 28 Jun 2024 15:21:48 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v9 1/8] wifi: ath12k: Refactor core start api
Date: Fri, 28 Jun 2024 15:21:32 +0530
Message-Id: <20240628095139.292952-2-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628095139.292952-1-quic_hprem@quicinc.com>
References: <20240628095139.292952-1-quic_hprem@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PWyhiBjNi6q5QwFwOfUDxjOJjyiVlNqB
X-Proofpoint-GUID: PWyhiBjNi6q5QwFwOfUDxjOJjyiVlNqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280072

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Hardware device group abstraction would be introduced, in future,
where radios across different devices can be grouped together to
support multi-link operation and register as a device group to mac80211.

Currently, ath12k_mac_allocate() and ath12k_mac_register() APIs are part
of ath12k_core_start() and ath12k_core_pdev_create() respectively and are
based on per device (ath12k_base). These APIs can be decoupled and moved
out to ath12k_core_qmi_firmware_ready() itself.

This refactor would be helpful for device group abstraction when mac80211
allocate and register will be changed from per device (ath12k_base) to
per device group (ath12k_hw_group).

Add changes to move allocate and register APIs from existing one and modify
corresponding deinit sequence.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 59 ++++++++++++--------------
 drivers/net/wireless/ath/ath12k/dp.c   |  7 +++
 drivers/net/wireless/ath/ath12k/pci.c  |  9 ++++
 drivers/net/wireless/ath/ath12k/qmi.c  |  4 ++
 4 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 51252e8bc1ae..322d694e6995 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -598,9 +598,10 @@ static void ath12k_core_stop(struct ath12k_base *ab)
 
 	ath12k_acpi_stop(ab);
 
+	ath12k_dp_rx_pdev_reo_cleanup(ab);
 	ath12k_hif_stop(ab);
 	ath12k_wmi_detach(ab);
-	ath12k_dp_rx_pdev_reo_cleanup(ab);
+	ath12k_dp_free(ab);
 
 	/* De-Init of components as needed */
 }
@@ -702,7 +703,7 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
 
 static void ath12k_core_soc_destroy(struct ath12k_base *ab)
 {
-	ath12k_dp_free(ab);
+	ath12k_hif_power_down(ab, false);
 	ath12k_reg_free(ab);
 	ath12k_debugfs_soc_destroy(ab);
 	ath12k_qmi_deinit_service(ab);
@@ -712,30 +713,17 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
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
 
@@ -793,19 +781,12 @@ static int ath12k_core_start(struct ath12k_base *ab,
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
@@ -848,8 +829,6 @@ static int ath12k_core_start(struct ath12k_base *ab,
 
 err_reo_cleanup:
 	ath12k_dp_rx_pdev_reo_cleanup(ab);
-err_mac_destroy:
-	ath12k_mac_destroy(ab);
 err_hif_stop:
 	ath12k_hif_stop(ab);
 err_wmi_detach:
@@ -903,11 +882,25 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
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
@@ -921,10 +914,14 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
 	return 0;
 
 err_core_pdev_destroy:
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
@@ -1264,15 +1261,15 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 
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
index 61aa78d8bd8c..f63d90f4601e 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -974,6 +974,9 @@ void ath12k_dp_pdev_free(struct ath12k_base *ab)
 {
 	int i;
 
+	if (!ab->mon_reap_timer.function)
+		return;
+
 	del_timer_sync(&ab->mon_reap_timer);
 
 	for (i = 0; i < ab->num_radios; i++)
@@ -1266,6 +1269,9 @@ void ath12k_dp_free(struct ath12k_base *ab)
 	struct ath12k_dp *dp = &ab->dp;
 	int i;
 
+	if (!dp->ab)
+		return;
+
 	ath12k_dp_link_desc_cleanup(ab, dp->link_desc_banks,
 				    HAL_WBM_IDLE_LINK, &dp->wbm_idle_ring);
 
@@ -1281,6 +1287,7 @@ void ath12k_dp_free(struct ath12k_base *ab)
 
 	ath12k_dp_rx_free(ab);
 	/* Deinit any SOC level resource */
+	dp->ab = NULL;
 }
 
 void ath12k_dp_cc_config(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 876c029f58f6..8ec1dd4c2fd3 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1119,6 +1119,9 @@ void ath12k_pci_ext_irq_enable(struct ath12k_base *ab)
 
 void ath12k_pci_ext_irq_disable(struct ath12k_base *ab)
 {
+	if (!test_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
+		return;
+
 	__ath12k_pci_ext_irq_disable(ab);
 	ath12k_pci_sync_ext_irqs(ab);
 }
@@ -1143,6 +1146,11 @@ int ath12k_pci_hif_resume(struct ath12k_base *ab)
 
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
@@ -1537,6 +1545,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&ab->reset_work);
 	ath12k_core_deinit(ab);
+	ath12k_fw_unmap(ab);
 
 qmi_fail:
 	ath12k_mhi_unregister(ab_pci);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index b93ce9f87f61..4028672864b3 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3386,11 +3386,15 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 
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
2.34.1


