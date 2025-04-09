Return-Path: <linux-wireless+bounces-21289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51951A81AEE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 04:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0801B65AB7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 02:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405419ADA4;
	Wed,  9 Apr 2025 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LMy1fAil"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF018A6CF;
	Wed,  9 Apr 2025 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165642; cv=none; b=tZtQteTH6sSw9n1oPZ02Vmgx2pSNg0U2jsE78QQT70Hd3yF0+ze8G5NhHgenDPqQOPimYXyrizlTHPfNhBpbfLY6vRV7mPvuU/jXRzMn7CI956uFoMVLusY3ELkTZCxX1P+N6BtQPGHGmYKyDaDn6h422pw56zuk0VEmxVXJcuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165642; c=relaxed/simple;
	bh=pJ4nlpbqt01FQ3uSn7UkVLgNU9clgTpbywHnmJwiSDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rvPkU99PW5jX8XiCcfk0XfOzljsV8FykoH8He4w1yrv5nl9REGaVZDlKur12WHWBNrgrU6zHGkJIKnS3mrzZ5uzyrVupgbwIn4Syc+Wb5l9xoqtMWlXD75D20PhhY2BapiSkSS0AguEteQF4ZVJ2Z4znSC359m3lxwWeo9NAIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LMy1fAil; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYvVG015749;
	Wed, 9 Apr 2025 02:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nbaVlp3FjkCfjhRbHVE/VhU/SG7aRmPwUkchZ1iDlAM=; b=LMy1fAilqK8Vpzak
	oNb07VoYliktRZVp7DorA0rLbkE0ygXh0XTtO4Uv1FrwzThJFpCuiQYk4Um24wwf
	923S32w6DWe5YKVrgvY8gT/HGqIclz0llCaqF+KfNXQ6Lmsmxctfkxbb2uA7XHnn
	/2S1WTtMB+KNy3gNEHoy3uPjfWLOZxsOPzOiFm56aq1JG/5b7d6kgVlvrme9mr8Q
	oUFu5QhZYeVSWecWdzvhEXAawuOJ8627W8HePkAEwlXv1j/bkJa+eOUH+tzEpqYb
	gv1Egz9eWqTd8WXubdSf4bPCYCWkB9lgR1NZ/33eKARCIGhM6xPDtwzyPjionUpo
	BUbGdw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2ssmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 02:27:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5392RCxl000921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 02:27:12 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 19:27:11 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 9 Apr 2025 10:26:34 +0800
Subject: [PATCH ath-next v2 1/9] wifi: ath12k: introduce
 ath12k_fw_feature_supported()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250409-ath12k-wcn7850-mlo-support-v2-1-3801132ca2c3@quicinc.com>
References: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
In-Reply-To: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _lwGxlb6CWdUqOUNTjKqP5mccv7MSbJG
X-Proofpoint-GUID: _lwGxlb6CWdUqOUNTjKqP5mccv7MSbJG
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f5db01 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=qqn00rXgNp02u2b5aRIA:9 a=QEXdDO2ut3YA:10
 a=RVmHIydaz68A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=979 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090002

There are several places checking if a specific bit set in
ab->fw.fw_features, and in an upcoming patch additional check needs to be
added at all places.

Introduce a new helper ath12k_fw_feature_supported() to avoid code
duplication.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 2 +-
 drivers/net/wireless/ath/ath12k/fw.c   | 7 ++++++-
 drivers/net/wireless/ath/ath12k/fw.h   | 3 ++-
 drivers/net/wireless/ath/ath12k/pci.c  | 4 ++--
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0e71935b272033c5322e76a01e931087ced875ca..d8c9b666598540783e6abe3927ab4524d0a6fcbd 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1985,7 +1985,7 @@ void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag)
 		/* even if 1 device's firmware feature indicates MLO
 		 * unsupported, make MLO unsupported for the whole group
 		 */
-		if (!test_bit(ATH12K_FW_FEATURE_MLO, ab->fw.fw_features)) {
+		if (!ath12k_fw_feature_supported(ab, ATH12K_FW_FEATURE_MLO)) {
 			ag->mlo_capable = false;
 			return;
 		}
diff --git a/drivers/net/wireless/ath/ath12k/fw.c b/drivers/net/wireless/ath/ath12k/fw.c
index 5be4b2d4a19d8920042b7b05460aecf380490c4f..af8b87ca4ccbe748974d17955397b4b23b52e8a8 100644
--- a/drivers/net/wireless/ath/ath12k/fw.c
+++ b/drivers/net/wireless/ath/ath12k/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
- * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -169,3 +169,8 @@ void ath12k_fw_unmap(struct ath12k_base *ab)
 	release_firmware(ab->fw.fw);
 	memset(&ab->fw, 0, sizeof(ab->fw));
 }
+
+bool ath12k_fw_feature_supported(struct ath12k_base *ab, enum ath12k_fw_features feat)
+{
+	return test_bit(feat, ab->fw.fw_features);
+}
diff --git a/drivers/net/wireless/ath/ath12k/fw.h b/drivers/net/wireless/ath/ath12k/fw.h
index 273c003eff3ba709a248fed799fb64326c1e3e92..7afaefed5086f19a742e0d6b5af04f210c0fd5a9 100644
--- a/drivers/net/wireless/ath/ath12k/fw.h
+++ b/drivers/net/wireless/ath/ath12k/fw.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
- * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_FW_H
@@ -32,5 +32,6 @@ enum ath12k_fw_features {
 
 void ath12k_fw_map(struct ath12k_base *ab);
 void ath12k_fw_unmap(struct ath12k_base *ab);
+bool ath12k_fw_feature_supported(struct ath12k_base *ab, enum ath12k_fw_features feat);
 
 #endif /* ATH12K_FW_H */
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 7f1bb150f326b317157f6721d990d61a27f38d6a..3c550497f74a32ce30f6c86e6727ef2dfd14e7bb 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -718,7 +718,7 @@ static void ath12k_pci_init_qmi_ce_config(struct ath12k_base *ab)
 	cfg->svc_to_ce_map_len = ab->hw_params->svc_to_ce_map_len;
 	ab->qmi.service_ins_id = ab->hw_params->qmi_service_ins_id;
 
-	if (test_bit(ATH12K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features)) {
+	if (ath12k_fw_feature_supported(ab, ATH12K_FW_FEATURE_MULTI_QRTR_ID)) {
 		ab_pci->qmi_instance =
 			u32_encode_bits(pci_domain_nr(bus), DOMAIN_NUMBER_MASK) |
 			u32_encode_bits(bus->number, BUS_NUMBER_MASK);
@@ -1468,7 +1468,7 @@ int ath12k_pci_power_up(struct ath12k_base *ab)
 
 	ath12k_pci_msi_enable(ab_pci);
 
-	if (test_bit(ATH12K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features))
+	if (ath12k_fw_feature_supported(ab, ATH12K_FW_FEATURE_MULTI_QRTR_ID))
 		ath12k_pci_update_qrtr_node_id(ab);
 
 	ret = ath12k_mhi_start(ab_pci);

-- 
2.25.1


