Return-Path: <linux-wireless+bounces-19555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5574DA4889F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 20:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCDA188CAAE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B726FA74;
	Thu, 27 Feb 2025 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WMfETJv/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779526E65D;
	Thu, 27 Feb 2025 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683488; cv=none; b=P/BwpIX/CxPDk6jUrYsqy/tMcaEGXdH/Y49IAvpYuNuAwOZAjZzfz1B8UEXjdE8tUBCbvR+6Ply5Enr8WBvZZ5WsQ6N1st0EIbPfKnJXLjxzZIhJRZu4ar5qYyFhQFSgSPjrfT1iT8EZPvFBrF60eJ1gxj+E04rq6FtzdsC1vxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683488; c=relaxed/simple;
	bh=hsZwUvHX/8mIQjUmLf2XCsMmkCmCHb7ahyHpjf/QMPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbchtGplA93S7JXjgwbp4x/BAMEEJOkpCfWTZyMc3K88yYc4ajoGuq8HU+hFVYnUO1cBwGoj1CfVzW1qBikwFYofRmczovfA41FwErynuQ5WWsF4f35l7rMd5GTUSoq/ffIM28eyL4gZTkpgN4Hxb4o50+UUMZEBDw06JNtGfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WMfETJv/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHevUQ021807;
	Thu, 27 Feb 2025 19:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6UPqro2A4t+6dGrcMG1QVtsONIWe1YM1p2VBZkFe2VM=; b=WMfETJv/viZmrydB
	WO4t4SJvDkFGOtUKcr2WU1dMpA1zdQ0yqZo4BV1DMPj+j7SyvKz44DfZB9TaloDz
	TdSIzHURz279ispjs+1skQkzeNAEFj77HjdqVuCCZaZ2pZYtPTsQfFeu9dWsjj8P
	wtGXoap0uO6kj1bIykhMkDK51kHpMSiJ/5oR1aDX+y1qG0d9Cb2f0x2wpN1iBy59
	1x8VF6PkqLFMiTfSPq73I0cyXyb+x2WoguwPI3do/ZcJvJj6xEidTysPGIQMKlEO
	mxosLTdRDm+V8tMD46CfoJUVvzIgzcIuH46igVNIWcsmnw6QZRvq7gKt9S8z/kFB
	H26wXQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkpv3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:11:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RJBIUh006292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:11:18 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 11:11:14 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [PATCH v7 05/13] wifi: ath12k: avoid m3 firmware download in AHB device IPQ5332
Date: Fri, 28 Feb 2025 00:40:26 +0530
Message-ID: <20250227191034.1949954-6-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
References: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: 4C_7M-ZcLXih9u_cqUqo2HRdp2Vm4Dpt
X-Proofpoint-ORIG-GUID: 4C_7M-ZcLXih9u_cqUqo2HRdp2Vm4Dpt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270142

From: Balamurugan S <quic_bselvara@quicinc.com>

Current ath12k devices, QCN9274 and WCN7850, supports m3.bin firmware
download through ath12k driver. The new ath12k AHB based device
IPQ5332 supports m3 firmware download through remoteproc driver.

Hence, add new parameter (fw.m3_loader) in ath12k_hw_params to avoid
m3 firmware download in IPQ5332.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  |  4 ++++
 drivers/net/wireless/ath/ath12k/hw.h  |  6 ++++++
 drivers/net/wireless/ath/ath12k/qmi.c | 28 ++++++++++++++++-----------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 86c4ce143169..84f542c02c94 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1235,6 +1235,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 			.dir = "QCN9274/hw1.0",
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
+			.m3_loader = ath12k_m3_fw_loader_driver,
 		},
 		.max_radios = 1,
 		.single_pdev_only = false,
@@ -1312,6 +1313,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 			.dir = "WCN7850/hw2.0",
 			.board_size = 256 * 1024,
 			.cal_offset = 256 * 1024,
+			.m3_loader = ath12k_m3_fw_loader_driver,
 		},
 
 		.max_radios = 1,
@@ -1391,6 +1393,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 			.dir = "QCN9274/hw2.0",
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
+			.m3_loader = ath12k_m3_fw_loader_driver,
 		},
 		.max_radios = 2,
 		.single_pdev_only = false,
@@ -1467,6 +1470,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 			.dir = "IPQ5332/hw1.0",
 			.board_size = 256 * 1024,
 			.cal_offset = 128 * 1024,
+			.m3_loader = ath12k_m3_fw_loader_remoteproc,
 		},
 		.max_radios = 1,
 		.single_pdev_only = false,
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index acb81b5798ac..fbe1aec475ce 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -146,6 +146,11 @@ struct ath12k_hw_hal_params {
 	u32	  wbm2sw_cc_enable;
 };
 
+enum ath12k_m3_fw_loaders {
+	ath12k_m3_fw_loader_driver,
+	ath12k_m3_fw_loader_remoteproc,
+};
+
 struct ath12k_hw_params {
 	const char *name;
 	u16 hw_rev;
@@ -154,6 +159,7 @@ struct ath12k_hw_params {
 		const char *dir;
 		size_t board_size;
 		size_t cal_offset;
+		enum ath12k_m3_fw_loaders m3_loader;
 	} fw;
 
 	u8 max_radios;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 348dbc81bad8..6978200fb79a 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2168,10 +2168,12 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 	req.bdf_support_valid = 1;
 	req.bdf_support = 1;
 
-	req.m3_support_valid = 1;
-	req.m3_support = 1;
-	req.m3_cache_support_valid = 1;
-	req.m3_cache_support = 1;
+	if (ab->hw_params->fw.m3_loader == ath12k_m3_fw_loader_driver) {
+		req.m3_support_valid = 1;
+		req.m3_support = 1;
+		req.m3_cache_support_valid = 1;
+		req.m3_cache_support = 1;
+	}
 
 	req.cal_done_valid = 1;
 	req.cal_done = ab->qmi.cal_done;
@@ -2939,6 +2941,9 @@ static void ath12k_qmi_m3_free(struct ath12k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
 
+	if (ab->hw_params->fw.m3_loader == ath12k_m3_fw_loader_remoteproc)
+		return;
+
 	if (!m3_mem->vaddr)
 		return;
 
@@ -3019,15 +3024,16 @@ int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 	struct qmi_txn txn;
 	int ret = 0;
 
-	ret = ath12k_qmi_m3_load(ab);
-	if (ret) {
-		ath12k_err(ab, "failed to load m3 firmware: %d", ret);
-		return ret;
+	if (ab->hw_params->fw.m3_loader == ath12k_m3_fw_loader_driver) {
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


