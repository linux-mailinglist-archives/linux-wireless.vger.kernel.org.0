Return-Path: <linux-wireless+bounces-7063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 715418B7E0D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB628938A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD78199EBC;
	Tue, 30 Apr 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eN0DY2Ws"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF619DF45
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496318; cv=none; b=TrAnLZAW83Dd9jStxu3ijaoV0f3wvXi7ssP2kLBPnDAv7YAEPmSTCMM5d6It9HhRmlPfvsd6tmJpbhUSVGVu9lNvWARGEM+ESNsJgQFkMamn6y9p+lAl10+sv/WeJZNCN7HuuWiI6RIRmfq+AYtzFJw1Z0MxZx70e0BuSjSfDWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496318; c=relaxed/simple;
	bh=GOcKywn09Qd1isUCrl82m8iT/DaMEu9WnX+f5iwyZgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSZyHWiKi9SmNlLOky5MGBISyKuex21Y1obYoK/tEl19eeftGF0WpXDbK5VuydVdKuk+rr6K8RNvQBW8zl0x5oj2rFN3xQmyIrsk+VvsWmVCqGdHxQrn7TWbfELecJgDFiBgDfg5j4dRo/oeWuNXwKR1PfJ/sJJqlPjgt0kiHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eN0DY2Ws; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U7BP4j003209;
	Tue, 30 Apr 2024 16:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=U+vAbfSLMuNbnl69+kcmRVmBm/Qc4uEVf6ZKyyW7Qc4=; b=eN
	0DY2WsCxPtrmAA9cDF4KnJZoZWUblnYhfPwrQpqanjWPYtj+RBxRRN5rvaCpSUuf
	Y8rBXSAVxsVmcRKJwsiibh+d1CTLpC4oPiQAKPyamItgnA4RL+kUFDCvVy45pnqi
	MyDRHhIALxP2tNNAFnZoRfBoR+4kaqoktsnVUz+7hLDQd9aUfwiDfXr4PFnSS28J
	tYJFnjyC4L0hnYrhbL4G330Jv+Dob1paEH8+dspBAdAnIu8uIxFv0TNQU9/R8iGJ
	WaBES5LaEYWqgBK6pdzFEymBRpleM8cHIoWReGXBDvr3Pc2i2heJnZ5gbS6aWNpr
	VylhMH0kFaktApbgk70Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtv1hsf6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:58:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UGwYcl018826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:58:34 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 09:58:32 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 3/4] wifi: ath12k: Introduce device index
Date: Tue, 30 Apr 2024 22:28:10 +0530
Message-ID: <20240430165811.1377182-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
References: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LNV2moXM3URiSpzgVsymw6Rw15QK9C8P
X-Proofpoint-ORIG-GUID: LNV2moXM3URiSpzgVsymw6Rw15QK9C8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300121

Introduce a device index parameter in the ath12k_base structure. This
value is used as unique identifier for devices involved in Inter-device
MLO. It is also used to configure the MLO parameter within the QMI host
capability send request. While currently set to zero, future logic will
be added for inter device support to populate this parameter with
non-zero values.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 10 ++++++++++
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/qmi.c  |  4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 6663f4e1792d..1076efd35bcb 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1262,6 +1262,16 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	ab->qmi.num_radios = U8_MAX;
 	ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
 
+	/* Device index used to identify the devices in a group.
+	 *
+	 * In Intra-device MLO, only one device present in a group,
+	 * so it is always zero.
+	 *
+	 * In Inter-device MLO, Multiple device present in a group,
+	 * expect non-zero value.
+	 */
+	ab->device_id = 0;
+
 	return ab;
 
 err_free_wq:
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 47dde4401210..d10d74e3a6d3 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -747,6 +747,7 @@ struct ath12k_base {
 	struct ath12k_qmi qmi;
 	struct ath12k_wmi_base wmi_ab;
 	struct completion fw_ready;
+	u8 device_id;
 	int num_radios;
 	/* HW channel counters frequency value in hertz common to all MACs */
 	u32 cc_freq_hz;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 5484112859a6..3bb730326a02 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2041,7 +2041,7 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_capable_valid = 1;
 	req->mlo_capable = 1;
 	req->mlo_chip_id_valid = 1;
-	req->mlo_chip_id = 0;
+	req->mlo_chip_id = ab->device_id;
 	req->mlo_group_id_valid = 1;
 	req->mlo_group_id = 0;
 	req->max_mlo_peer_valid = 1;
@@ -2053,7 +2053,7 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_num_chips = 1;
 
 	info = &req->mlo_chip_info[0];
-	info->chip_id = 0;
+	info->chip_id = ab->device_id;
 	info->num_local_links = ab->qmi.num_radios;
 
 	for (i = 0; i < info->num_local_links; i++) {
-- 
2.34.1


