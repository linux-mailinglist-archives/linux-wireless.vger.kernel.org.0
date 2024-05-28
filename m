Return-Path: <linux-wireless+bounces-8158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E208D147C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 08:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA72EB21202
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C1F61FFC;
	Tue, 28 May 2024 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o7j30Q9C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92153368
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878174; cv=none; b=WdfIK2tX16n0KCDeifT+bD/Bi/VvGFBjVyxcqswlJAvVOScjGtHByFOwLYvLmE/81hJaNhS0sAH27vlX7fysqixINDq3nWlcoCvqVzvuxs0oyJC0DY5cwJCFJSz1pM7K6oIRKtUOXsNl/GPgDU/6SV66emE7Wh+XKhy+E8X1BZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878174; c=relaxed/simple;
	bh=3FB+QHAAAfpdyskcQ8tKj+CyJfEqRu5rF5PrZ8Oro9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FlCZ+2WKzdfRxVhvutTDtmFvOctk5iG+lf10t9J1UOagszCJBkJWw3GtBzmDzZF/c1I/JsUNf9NKd12jFcPYu6lliRfq8SOV9QQEMK8TVTT01lw93jvDdA+WPTiUzCkP8gJWLwkI6H1R8Y4aSfCMJdPH5Xmsn4JyFJfDrnueeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o7j30Q9C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RNg5AV011441;
	Tue, 28 May 2024 06:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v8T3sAjhzPr
	qu0X2wF9xd6B4jRKAemg+UKlmHd79xqc=; b=o7j30Q9CukpUrP+3KdBy/V62l0h
	Su/zff1Ooz+XAPL3co8I7mfBHt9tSUZiFOq0hoOweqMjzDxB/oqPJXyRRCvect0B
	8t6HpKINI9lmvJJ7BhnrXBpV8Vn7qtBO4MFjZ/VuwMtccm6/IyEgGLB+xwG9XqBG
	I2ewUnfJb8WSsl1FrtWFZlH5502cURRRKpwHRcbCnWGClgexyMcbABbQIhJUazat
	qxKzGuzwMlCH/5YRPdQHbA6lrg3yLEwSOBSFiJOJfokd5ssL7hCEh4pik/3ypHcQ
	ARPX6UUAJYKrWEiSWDeOh1sGc7wm8evig2SZEDg1KJFo8AOg/g61cDZguYQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qd8x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 06:36:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44S6a0LH012701;
	Tue, 28 May 2024 06:36:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3yb92kd5wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 06:36:00 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S6ZvwD012660;
	Tue, 28 May 2024 06:36:00 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44S6a0Q6012695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 06:36:00 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id B3F9F4114D; Tue, 28 May 2024 12:05:59 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v7 1/8] wifi: ath12k: Refactor core start api
Date: Tue, 28 May 2024 12:05:40 +0530
Message-Id: <20240528063547.1400700-2-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528063547.1400700-1-quic_hprem@quicinc.com>
References: <20240528063547.1400700-1-quic_hprem@quicinc.com>
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
X-Proofpoint-GUID: eNrG8IYTVEqQUesK06jLSVP-f5vbQZcF
X-Proofpoint-ORIG-GUID: eNrG8IYTVEqQUesK06jLSVP-f5vbQZcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_03,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280047

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
index ac75e8e3916b..8f37f6efb8a2 100644
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


