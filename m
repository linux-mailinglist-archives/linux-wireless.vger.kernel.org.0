Return-Path: <linux-wireless+bounces-8354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FDA8D68A4
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 20:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA9C1C235EE
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF6017CA04;
	Fri, 31 May 2024 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K62jfj8D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367257BB01
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178672; cv=none; b=qtXg4BtCCk3j8HQX9fOLVkfFTEQC4Y80RhHZGV0YEySuOC/KKhatZkUGS3AvPiavKiFc6QfqVSsJB4qXQmCQM/BHNjCQ8tkNzPQDWmuhfVDUBRzBBmoyJq+Sdj0zFo7ObnR05rvH36jm/FdUeWQl3UnzL0SCgsfXTdY+nfdwVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178672; c=relaxed/simple;
	bh=lFnhsGSwlOzrRBBdWjuT+lwLhaGGAu2qkryOcKl4WX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JblpP8doO1yE0+hZt0zK8qPuJLY/crCzJvNIJe5rKVhcm9thrvnwYp8mT3N+zSoaHSq5rBi+EmGSGFv5SJZrOVL0VgSq7GeyrjvX6HSLjM55W+Y8GERhXABLCjgpQYfZja+zhM2LNsViz75PWiwIyccT4PMY7XEduxA31oPNuH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K62jfj8D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V9pa98002420;
	Fri, 31 May 2024 18:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GGU+3NKFgjH
	0LK/dXrhrJ4QCEwnhtRY4CCiNPoEZ5aM=; b=K62jfj8D1MyVa14X3qkJ9xhbcd5
	KcUTXooJvLHggCHjXuPSvZN0jzIGxrVnPZrZxG4iKXkmQc/3TwBRWoUrXJynr9B2
	PioKs0AUGImEQMj8JzngtlPqigxALyqvi4eMR1dvca2lUrCVhCulfazL/9CpLSMH
	eey24UJB/05CnJV0i24Fy0WLNPSPuA1PDF6mQgUXQamiaUqM3Z9VyXs8tp4v3Wyl
	TxGW/Z9DsKuGnAuorrih16u4SqSP6reD6R5SMg5OPaFgNhJWsE/1s9xO8hdfmKip
	NFXn8ztrlmVZ7i7B0yqqMV1KvvkPVzgO0xHSg2E+j9yAynXZTH2M2daTbgw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfc9nhbxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44VI4FgT012029;
	Fri, 31 May 2024 18:04:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3yf34nn900-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:15 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44VI4F1p012021;
	Fri, 31 May 2024 18:04:15 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 44VI4FZY012019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:15 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 771A141174; Fri, 31 May 2024 23:34:14 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v8 1/8] wifi: ath12k: Refactor core start api
Date: Fri, 31 May 2024 23:34:04 +0530
Message-Id: <20240531180411.1149605-2-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531180411.1149605-1-quic_hprem@quicinc.com>
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
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
X-Proofpoint-ORIG-GUID: AqPrZtT711yhFLuPzQQGtPxqzdR9HYVv
X-Proofpoint-GUID: AqPrZtT711yhFLuPzQQGtPxqzdR9HYVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310137

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
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 59 ++++++++++++--------------
 drivers/net/wireless/ath/ath12k/pci.c  |  1 +
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index e7f628e935e4..342d0ab12105 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -565,9 +565,10 @@ static void ath12k_core_stop(struct ath12k_base *ab)
 
 	ath12k_acpi_stop(ab);
 
+	ath12k_dp_rx_pdev_reo_cleanup(ab);
 	ath12k_hif_stop(ab);
 	ath12k_wmi_detach(ab);
-	ath12k_dp_rx_pdev_reo_cleanup(ab);
+	ath12k_dp_free(ab);
 
 	/* De-Init of components as needed */
 }
@@ -669,7 +670,7 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
 
 static void ath12k_core_soc_destroy(struct ath12k_base *ab)
 {
-	ath12k_dp_free(ab);
+	ath12k_hif_power_down(ab, false);
 	ath12k_reg_free(ab);
 	ath12k_debugfs_soc_destroy(ab);
 	ath12k_qmi_deinit_service(ab);
@@ -679,30 +680,17 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
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
 
@@ -760,19 +748,12 @@ static int ath12k_core_start(struct ath12k_base *ab,
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
@@ -815,8 +796,6 @@ static int ath12k_core_start(struct ath12k_base *ab,
 
 err_reo_cleanup:
 	ath12k_dp_rx_pdev_reo_cleanup(ab);
-err_mac_destroy:
-	ath12k_mac_destroy(ab);
 err_hif_stop:
 	ath12k_hif_stop(ab);
 err_wmi_detach:
@@ -870,11 +849,25 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
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
@@ -888,10 +881,14 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
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
@@ -1205,15 +1202,15 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 {
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
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 11b95d037051..e0a24ad0480e 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1529,6 +1529,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&ab->reset_work);
 	ath12k_core_deinit(ab);
+	ath12k_fw_unmap(ab);
 
 qmi_fail:
 	ath12k_mhi_unregister(ab_pci);
-- 
2.34.1


