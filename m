Return-Path: <linux-wireless+bounces-17780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A8CA17A06
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E39167D05
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9073C1B87CA;
	Tue, 21 Jan 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gJdBjPcf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FDA1BF7E0
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451160; cv=none; b=aMQm5PN61YWQavYkFR7Ih7vLtQMcqE2k/ygbioi0OcMHhXH/7FkVmfix1cuk3gOTJdqH6MO0NAi8G9QMhLUn/4dibc95r7HfB2CszRIKfmFm+Th8dJJyqMTOV1qGDOWnpBDUTLIXRx8c8S/x6MD1StXwe94Lk+qJFrNVP6Ue7rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451160; c=relaxed/simple;
	bh=vOQaJyc2YDbmXjNWcWCNdTlCIhSnqxmv2rkSYmRi9Gs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFIjdWoLJ33z7xJZzNetijaOehYsP7hw3Y0z1RpwwUVE8+26bcSuAv+v/2VJZfabTkykYh5UCUEnBrd2eL2jCRgNlxTHCjhjsQNZipEABmrO8/kHFPcGTcDuFYw28U1gombm1wFWEMLPyxVVmLK7OvF2YdMtgwCTmKaZc38+c/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gJdBjPcf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8YwSD027456;
	Tue, 21 Jan 2025 09:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3JZ+LBlGZwUHnDEUlLvsVjY3V1K4AnXx4YBTCHrE3FA=; b=gJdBjPcfGtbvwjI9
	W0zmCr4J4zKFIUj8EwLKZc5c82MF3qJMo0F4+bqRef1OoZ3lyjm8olXwvpimVpdC
	6yVxD+wqe4GneHLv4CW1S2RqLioN+7jA2btRXrskjXFIAG5/qaqpDhDCVUNLpLmK
	RFrBWp6LYVAiJS5ptrJWso0FPj4J6FHrWSHVPBvMhab+oqXmjumNjMLe2nJBXHIx
	6dl8eEwiuz458ZE2eiftF6MvOj+6IQDIVzMvF8f6REybSv7qH0JlotyZMDgz0ftc
	cGKoFTGX4+PJzpLz4wC7d95EIRqBKf3rEtxk3gbZ1K1lfxyP9im0sw2xTa0xCM/Z
	el6t4w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a6vxrccd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:19:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L9JF6q026464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:19:15 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 Jan 2025 01:19:14 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v8 4/4] wifi: ath12k: store and send country code to firmware after recovery
Date: Tue, 21 Jan 2025 17:18:44 +0800
Message-ID: <20250121091844.1987-5-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250121091844.1987-1-quic_kangyang@quicinc.com>
References: <20250121091844.1987-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 636O_8StGy2Op-sv8mhObhDNpY73X_Zj
X-Proofpoint-ORIG-GUID: 636O_8StGy2Op-sv8mhObhDNpY73X_Zj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210075

From: Wen Gong <quic_wgong@quicinc.com>

Currently ath12k does not send the country code to firmware after device
recovery. As a result the country code will be the default one which
is reported from firmware. Country code is important, so ath12k also
need to restore it to the value which was used before recovery.

This is only needed for platforms which support the current_cc_support
hardware parameter.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 1 +
 drivers/net/wireless/ath/ath12k/core.h | 1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 8 ++++++++
 drivers/net/wireless/ath/ath12k/reg.c  | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index c77e88613945..00e1904af7ab 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1292,6 +1292,7 @@ static void ath12k_update_11d(struct work_struct *work)
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 
+		memcpy(&ar->alpha2, &arg.alpha2, 2);
 		ret = ath12k_wmi_send_set_current_country_cmd(ar, &arg);
 		if (ret)
 			ath12k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 0992de487d4e..31a9bf0ae9dc 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -724,6 +724,7 @@ struct ath12k {
 	u32 vdev_id_11d_scan;
 	struct completion completed_11d_scan;
 	enum ath12k_11d_state state_11d;
+	u8 alpha2[REG_ALPHA2_LEN];
 	bool regdom_set_by_user;
 
 	struct completion mlo_setup_done;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 062c461985d6..9a3aae68427e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10037,6 +10037,14 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 		ath12k_warn(ar->ab, "pdev %d successfully recovered\n",
 			    ar->pdev->pdev_id);
 
+		if (ar->ab->hw_params->current_cc_support &&
+		    ar->alpha2[0] != 0 && ar->alpha2[1] != 0) {
+			struct wmi_set_current_country_arg arg = {};
+
+			memcpy(&arg.alpha2, ar->alpha2, 2);
+			ath12k_wmi_send_set_current_country_cmd(ar, &arg);
+		}
+
 		if (ab->is_reset) {
 			recovery_count = atomic_inc_return(&ab->recovery_count);
 
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index c7b0d66f4874..c3ebb0247e6f 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -85,6 +85,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	for_each_ar(ah, ar, i) {
 		if (ar->ab->hw_params->current_cc_support) {
 			memcpy(&current_arg.alpha2, request->alpha2, 2);
+			memcpy(&ar->alpha2, &current_arg.alpha2, 2);
 			ret = ath12k_wmi_send_set_current_country_cmd(ar, &current_arg);
 			if (ret)
 				ath12k_warn(ar->ab,
-- 
2.34.1


