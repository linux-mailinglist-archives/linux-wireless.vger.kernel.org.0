Return-Path: <linux-wireless+bounces-7225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598928BD3EA
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C11C219BC
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3181586D2;
	Mon,  6 May 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oh+s+X+C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508E157491
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017200; cv=none; b=ihx4ps06H5eKYs4SRqJmK792ja3jv1kVtL6zDsouaND+Ao/dCHyEfWq1/t+y0bj1WkJitKPyKolRWxi6zuQt2/SgQGdODjBbnAr+CebKJ7Plu6AMstpWluH4/QwFe3GXqTGzwH7WFod+KCzMWam5UNVR2GDhJsWtXZfcs1zOHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017200; c=relaxed/simple;
	bh=MEYFZ5MABB6EjZnve70XbpUqKjnci73AVkdkpKIDX3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OzDDrl1Pqyp9PFwOGwhpmQbmS0BWe3fmOvVCQjQAhauQVcil7U7l7OZ6Nxa+6vY8/11lebh+Kip+KNm3LckoZ8b3kvx6bjYABd9u1Ntt6QY9OZnhTv1MxPFv6gHgHyMh21I9Cd5W1O/mJdqy6ePnzP2z6MgVQqY+oAboogSe0tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oh+s+X+C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446FX06f000611;
	Mon, 6 May 2024 17:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=hUm/pAv
	K6mKyvgct10Gmbjsv96ZtqOOL7JDvfonWpMo=; b=Oh+s+X+C1uyiOaB0v0VHFQr
	njEQhpuEqjwgKf2TjeIaTSusc212KNQMkA5oJXjp8hRaW96ikilTaU0ir1MMNOXw
	uvSn+IB9o6EKsIBgv2a3Ixa5781sINKiGJmTU8oMSSlMWIpkNxtWc7BbYBpNf24p
	R6509A1GmMihoMq52WHY2IwVapkBhU1PHt7kv4tRKXAGbiB2zmuvk6ZHVHKh6mr1
	JPSF/yozVpp/XGTyKPH0Z9E/olvxy4aJYBdgJy4GKfUT9ooLBm98J5i8MKuUm/7/
	l2n6QXlFIx53dRYjF8ODRbDkbcz3dg+XLyYJVxeqOskdcHgDsw+WZpRQ7swYdKA=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxw38s02j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 17:39:53 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 446HdnnW009741;
	Mon, 6 May 2024 17:39:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xwe3k9tvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 17:39:49 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446HdmbG009719;
	Mon, 6 May 2024 17:39:49 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 446HdncB009734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 17:39:49 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id E8A324114D; Mon,  6 May 2024 23:09:48 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH v3 1/8] wifi: ath12k: Refactor core start api
Date: Mon,  6 May 2024 23:09:36 +0530
Message-Id: <20240506173943.1747037-2-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506173943.1747037-1-quic_hprem@quicinc.com>
References: <20240506173943.1747037-1-quic_hprem@quicinc.com>
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
X-Proofpoint-GUID: R0t2HYjST5fTQ5euJNlL0sbu8MdpXJ9v
X-Proofpoint-ORIG-GUID: R0t2HYjST5fTQ5euJNlL0sbu8MdpXJ9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_12,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405060126

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
---
 drivers/net/wireless/ath/ath12k/core.c | 59 ++++++++++++--------------
 drivers/net/wireless/ath/ath12k/pci.c  |  1 +
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 9482d5db71e7..b7fcdc39f990 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -568,9 +568,10 @@ static void ath12k_core_stop(struct ath12k_base *ab)
 
 	ath12k_acpi_stop(ab);
 
+	ath12k_dp_rx_pdev_reo_cleanup(ab);
 	ath12k_hif_stop(ab);
 	ath12k_wmi_detach(ab);
-	ath12k_dp_rx_pdev_reo_cleanup(ab);
+	ath12k_dp_free(ab);
 
 	/* De-Init of components as needed */
 }
@@ -672,7 +673,7 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
 
 static void ath12k_core_soc_destroy(struct ath12k_base *ab)
 {
-	ath12k_dp_free(ab);
+	ath12k_hif_power_down(ab, false);
 	ath12k_reg_free(ab);
 	ath12k_debugfs_soc_destroy(ab);
 	ath12k_qmi_deinit_service(ab);
@@ -682,30 +683,17 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
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
 
@@ -763,19 +751,12 @@ static int ath12k_core_start(struct ath12k_base *ab,
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
@@ -818,8 +799,6 @@ static int ath12k_core_start(struct ath12k_base *ab,
 
 err_reo_cleanup:
 	ath12k_dp_rx_pdev_reo_cleanup(ab);
-err_mac_destroy:
-	ath12k_mac_destroy(ab);
 err_hif_stop:
 	ath12k_hif_stop(ab);
 err_wmi_detach:
@@ -873,11 +852,25 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
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
@@ -891,10 +884,14 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab)
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
@@ -1208,15 +1205,15 @@ void ath12k_core_deinit(struct ath12k_base *ab)
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
index 16af046c33d9..95259b8cf251 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1512,6 +1512,7 @@ static void ath12k_pci_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&ab->reset_work);
 	ath12k_core_deinit(ab);
+	ath12k_fw_unmap(ab);
 
 qmi_fail:
 	ath12k_mhi_unregister(ab_pci);
-- 
2.17.1


