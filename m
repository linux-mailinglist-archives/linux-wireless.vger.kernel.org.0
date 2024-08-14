Return-Path: <linux-wireless+bounces-11410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964609517F7
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448082820F5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3005516B385;
	Wed, 14 Aug 2024 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cEn/CDiN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13616BE39
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628684; cv=none; b=kdISub576q+tDGF6XUy1CAnxH2IfdrUeKzj3tNIdQ4RjNbGlPryoMFQckKSr19TiSaxWKdx9VW5D800V8y8sb00FK0MHMLOxCihlFGKWCir9GVmD+O84/VrnGh/lIW5R7H5JiUDJp7A6i/Ppy6fXKrNW38IEyzDK3tMMxWgO13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628684; c=relaxed/simple;
	bh=RZqQHFI+FkSfXgN/8t+Z71TNHqQqvSetRffLdSuilxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8PZ7zemgos6KPHpCUL4dX1B6kfCL0y5J+xNntk69IWyqH91oJ5P0tDDnC58RG4uB4OpQP/LlTfxwrNruIzO7exW4jubrneDKKYRDUPo3u3pSRVswslO/v56UBC7IKB5B3AOnboSsRfPBZgOWEgIp5Ys9oPeJw09kaCQy03ABek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cEn/CDiN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DNFk6L031130;
	Wed, 14 Aug 2024 09:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RsvfOzhj5BKclpW+etMSL7ugsDpt4z+vpKn2XCqSKTQ=; b=cEn/CDiNl6i34xOD
	pvdBt7Nk9rkRACuTjDLzKYmqYmxtMjqn9y2tLbw3KwdvC9dz7YhwciNH+xv7Tdim
	zZZNyfH5fhWCNIOeoSmXfJydvnOai+x2qgIkS2sCQUDQcqEPTi+YlEdh2tZhYz0Q
	K2nZRRHxcw8nvw+Gh3lQXewWxSGly5qlrTOQyxSYXRfBSReVhOz5maaQ7cgqgSVn
	khrwuZmUaX1U4s+imiK4G87AkDSVov0uHjRRH5DY0lRpyU7tK7I7+UFJ0HpmK4On
	1eHLAGKKJTXZJhNeGzruYqRePb2dQxYX4OF8Jl+ZZMjfDcLdhu3a78zSqmM4+W8n
	hzllUA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4103ws3uj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E9idnc010529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:39 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 02:44:37 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 09/18] wifi: ath12k: avoid m3 firmware download in AHB device IPQ5332
Date: Wed, 14 Aug 2024 15:13:14 +0530
Message-ID: <20240814094323.3927603-10-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HWRBNSr24X5tLpyvKH9mJK9Dol9Q57GB
X-Proofpoint-ORIG-GUID: HWRBNSr24X5tLpyvKH9mJK9Dol9Q57GB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140067

From: Balamurugan S <quic_bselvara@quicinc.com>

Current ath12k devices, QCN9274 and WCN7850, supports m3.bin firmware
download through ath12k driver. The new ath12k AHB based device
IPQ5332 supports m3 firmware download through remoteproc driver.

Hence, add new parameter (m3_fw_support) in ath12k_hw_params to avoid
m3 firmware download in IPQ5332.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  |  8 ++++++++
 drivers/net/wireless/ath/ath12k/hw.h  |  2 ++
 drivers/net/wireless/ath/ath12k/qmi.c | 28 ++++++++++++++++-----------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index fcf2b462263b..58ffdef3efcb 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1298,6 +1298,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.iova_mask = 0,
 		.supports_aspm = false,
+
+		.m3_fw_support = true,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1377,6 +1379,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.iova_mask = ATH12K_PCIE_MAX_PAYLOAD_SIZE - 1,
 		.supports_aspm = true,
+
+		.m3_fw_support = true,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1452,6 +1456,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.iova_mask = 0,
 		.supports_aspm = false,
+
+		.m3_fw_support = true,
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -1523,6 +1529,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.iova_mask = 0,
 		.supports_aspm = false,
+
+		.m3_fw_support = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 36bec99e9e4d..22bd0a91b3e9 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -220,6 +220,8 @@ struct ath12k_hw_params {
 	bool supports_dynamic_smps_6ghz;
 
 	u32 iova_mask;
+
+	bool m3_fw_support;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index b93ce9f87f61..668232d83c10 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2080,10 +2080,12 @@ static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 	req.bdf_support_valid = 1;
 	req.bdf_support = 1;
 
-	req.m3_support_valid = 1;
-	req.m3_support = 1;
-	req.m3_cache_support_valid = 1;
-	req.m3_cache_support = 1;
+	if (ab->hw_params->m3_fw_support) {
+		req.m3_support_valid = 1;
+		req.m3_support = 1;
+		req.m3_cache_support_valid = 1;
+		req.m3_cache_support = 1;
+	}
 
 	req.cal_done_valid = 1;
 	req.cal_done = ab->qmi.cal_done;
@@ -2721,6 +2723,9 @@ static void ath12k_qmi_m3_free(struct ath12k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
 
+	if (!ab->hw_params->m3_fw_support)
+		return;
+
 	if (!m3_mem->vaddr)
 		return;
 
@@ -2799,15 +2804,16 @@ static int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 	struct qmi_txn txn;
 	int ret = 0;
 
-	ret = ath12k_qmi_m3_load(ab);
-	if (ret) {
-		ath12k_err(ab, "failed to load m3 firmware: %d", ret);
-		return ret;
+	if (ab->hw_params->m3_fw_support) {
+		ret = ath12k_qmi_m3_load(ab);
+		if (ret) {
+			ath12k_err(ab, "failed to load m3 firmware: %d", ret);
+			return ret;
+		}
+		req.addr = m3_mem->paddr;
+		req.size = m3_mem->size;
 	}
 
-	req.addr = m3_mem->paddr;
-	req.size = m3_mem->size;
-
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_m3_info_resp_msg_v01_ei, &resp);
 	if (ret < 0)
-- 
2.34.1


