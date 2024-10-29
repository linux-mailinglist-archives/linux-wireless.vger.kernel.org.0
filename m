Return-Path: <linux-wireless+bounces-14629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198F9B444B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 09:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413AF283584
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2611F7565;
	Tue, 29 Oct 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BvKhgSSq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988011E048B
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190838; cv=none; b=sHEm4qrtYyZ8BRk4h9FRD5u0nNObjRJlO85qvgiItdHS+FK52vmsDIlgKJ0aIoVfxXY9fYiQSJI4sLDJSWscRyF2HJo7+sCSGLdO2BWHqi5iJuC4HbbcExIoFt/s3sza2rdux/eJcq4YMB11tFDN+CZ7C1dRPBc6Pc/t+c1KUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190838; c=relaxed/simple;
	bh=ysRCRit5VIxbHWG3YUhU/VJelVejFaOAiPNch6P/sgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KQ2hVfebyFuWGx1j0qhdsM6GE5C99qZfReMCTnufWrMDgvEN6Ahw8R8Kv5Ps7eWbLLKmwlGzYKYRq7E1P6iEQiKVREUtdMCUMvPZFdl8506w4lc8gFf46gbDt1lMfbgR3bjN70YQMuB54osdU/K4bhJTOpjIjY2MBPNksd0kNlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BvKhgSSq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKYPkG012047;
	Tue, 29 Oct 2024 08:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ND7P14RGUCa/3njBpgO0LodGoDDkZ/lSdMM
	fyom5wfM=; b=BvKhgSSqCsAl0YzUAj0gW9Xw3KcLV07EgCLb/XoW7OGXS1XDM47
	4JMcZowBdQY8WgmV3vbjsojEnd16OzXxIhv+BpsqXz4m2LFyHyTMKmvfNTD1t5NE
	6kUB/tebAQZVULoynoOjIxFEZaGxOIjDikOvANrv5p/LqTuEJUjOovwV9CMQjTHN
	4cJdVAhKHngr4UjOktqaaV5uwlDVsUCKm1wjN0pP2sHK7YDpmCXZ1DoWHgM7Qt9M
	jhbf6wBHKY0oVEUFAxP0l33zUhXwIq861urO0mv3FVdf+BwY3RNVBOfO14a3aR1C
	NF4c5+4UcixYHBw6fcpmYeFIJgALiSbI6KA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gp4dyxy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 08:33:51 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 49T8Xmd9008331;
	Tue, 29 Oct 2024 08:33:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 42gsgkvtk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 08:33:48 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49T8Xmel008325;
	Tue, 29 Oct 2024 08:33:48 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com ([10.213.97.93])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 49T8Xlne008323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 08:33:47 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 460767)
	id 055964A8; Tue, 29 Oct 2024 14:03:47 +0530 (+0530)
From: Balaji Pothunoori <quic_bpothuno@quicinc.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Balaji Pothunoori <quic_bpothuno@quicinc.com>
Subject: [PATCH] wifi: ath11k: Suspend hardware before firmware mode off for WCN6750
Date: Tue, 29 Oct 2024 14:03:40 +0530
Message-Id: <20241029083340.3010798-1-quic_bpothuno@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: _onm_X5DIw0JJ4VfGMo2aKwI7XeYTKBK
X-Proofpoint-GUID: _onm_X5DIw0JJ4VfGMo2aKwI7XeYTKBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290067

During rmmod, the ath11k host driver sends a QMI MODE OFF command
to firmware.
As part of this command, firmware initiates WLAN de-initialization
and accesses certain UMAC registers during this process.
Currently, on WCN6750 WLAN hardware, the system is in a sleep state when
firmware receives the QMI MODE OFF command.
This results in a firmware/hardware reset while accessing the UMAC hardware
registers during sleep state.

To avoid this, add logic to send WCN6750 hardware specific
WMI_PDEV_SUSPEND_AND_DISABLE_INTR command to firmware prior to sending
the QMI MODE OFF command.
This will cause firmware to cease all activities and put the device in
a powered-on state that prevents access to registers which have been
powered off.

Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 45 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index be67382c00f6..a9aefb1a705d 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -123,6 +123,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_dual_stations = false,
+		.pdev_suspend = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -207,6 +208,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
 		.support_dual_stations = false,
+		.pdev_suspend = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -296,6 +298,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
+		.pdev_suspend = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -379,6 +382,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
 		.support_dual_stations = false,
+		.pdev_suspend = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -468,6 +472,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
+		.pdev_suspend = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -555,6 +560,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
+		.pdev_suspend = false,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -637,6 +643,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = true,
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = false,
+		.pdev_suspend = true,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ5018_HW10,
@@ -719,6 +726,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
 		.support_dual_stations = false,
+		.pdev_suspend = false,
 	},
 	{
 		.name = "qca2066 hw2.1",
@@ -808,6 +816,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
 		.support_dual_stations = true,
+		.pdev_suspend = false,
 	},
 };
 
@@ -1669,11 +1678,47 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 	return ret;
 }
 
+static void ath11k_core_pdev_suspend_target(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	unsigned long time_left;
+	int ret;
+	int i;
+
+	if (!ab->hw_params.pdev_suspend)
+		return;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+
+		reinit_completion(&ab->htc_suspend);
+
+		ret = ath11k_wmi_pdev_suspend(ar, WMI_PDEV_SUSPEND_AND_DISABLE_INTR,
+					      pdev->pdev_id);
+		if (ret) {
+			ath11k_warn(ab, "could not suspend target :%d\n", ret);
+			/* pointless to try other pdevs */
+			return;
+		}
+
+		time_left = wait_for_completion_timeout(&ab->htc_suspend, 3 * HZ);
+
+		if (!time_left) {
+			ath11k_warn(ab, "suspend timed out - target pause event never came\n");
+			/* pointless to try other pdevs */
+			return;
+		}
+	}
+}
+
 static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 {
 	ath11k_spectral_deinit(ab);
 	ath11k_thermal_unregister(ab);
 	ath11k_mac_unregister(ab);
+	ath11k_core_pdev_suspend_target(ab);
 	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
 	ath11k_debugfs_pdev_destroy(ab);
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 300322535766..52d9f4c13b13 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -227,6 +227,7 @@ struct ath11k_hw_params {
 	bool smp2p_wow_exit;
 	bool support_fw_mac_sequence;
 	bool support_dual_stations;
+	bool pdev_suspend;
 };
 
 struct ath11k_hw_ops {
-- 
2.34.1


