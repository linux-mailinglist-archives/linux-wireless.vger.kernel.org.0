Return-Path: <linux-wireless+bounces-1850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F5F82C842
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 01:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314C11C22A69
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 00:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64536B;
	Sat, 13 Jan 2024 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G+G2NXdW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666D2F50
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CNPmi9010937;
	Sat, 13 Jan 2024 00:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=q8zEPx3Q2TQawDB881Y/ccQ6BxSLwmgoNjlmvEMPmS8=; b=G+
	G2NXdW4dH+tEOetSCJ1ocQj7PeLHvjrqx9g9q//yakESGqM3rN13+GYh7ch7+Bkn
	7b7T1JgIKyN10yCPYc9ZdU/vK3YksF3JbZlClDeUd4S5pr7sWoE2rRthjoytCRVR
	S7hpyy/9r3jZANrL8FnnjM1a01GLByDYFN1Z+DOCLGBAKdBmau7Edhpm1Zsm7hX5
	c5KT9hE13+3rbgmEObp31GiEb2aoTvZs/+Pr9gkGZlOEWli7/LEsI2BFgh6JWMQW
	gGLar/8idXXpZT9UNDYdNcnuWm2eadv1l2HHB42Tkl2K3TJvpZnXujVY2Nu9kI6h
	ZETYd8AYew8uA5mOI6bA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkb74gkaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 00:17:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40D0HH6V023133
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 00:17:17 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Jan 2024 16:17:16 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: Refactor QMI MLO host capability helper function
Date: Sat, 13 Jan 2024 05:46:58 +0530
Message-ID: <20240113001659.1022465-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240113001659.1022465-1-quic_periyasa@quicinc.com>
References: <20240113001659.1022465-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: XujiIPVYq0YpwkxoKMSvN9rl69_ZL8eK
X-Proofpoint-ORIG-GUID: XujiIPVYq0YpwkxoKMSvN9rl69_ZL8eK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401130000

Currently, QMI MLO host capability parameters are specific to the WCN7850
platform. To make use of this helper function across all the platforms,
move the platform specific MLO capability parameter to the HW param
configuration.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  |  9 +++++++
 drivers/net/wireless/ath/ath12k/hw.h  |  3 +++
 drivers/net/wireless/ath/ath12k/qmi.c | 34 +++++++++++++++++++--------
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index de60d988d860..cbb6e2b6d826 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -914,6 +914,9 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_on_level = 0,
 
 		.rddm_size = 0,
+
+		.def_num_link = 0,
+		.max_mlo_peer = 256,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -978,6 +981,9 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_on_level = 1,
 
 		.rddm_size = 0x780000,
+
+		.def_num_link = 2,
+		.max_mlo_peer = 32,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1040,6 +1046,9 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rfkill_on_level = 0,
 
 		.rddm_size = 0,
+
+		.def_num_link = 0,
+		.max_mlo_peer = 256,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index fa8230def22b..0c3b416ae150 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -192,6 +192,9 @@ struct ath12k_hw_params {
 	u32 rfkill_on_level;
 
 	u32 rddm_size;
+
+	u8 def_num_link;
+	u16 max_mlo_peer;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 536856234f3b..f09d9b845794 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1893,8 +1893,16 @@ static const struct qmi_elem_info qmi_wlanfw_fw_ready_ind_msg_v01_ei[] = {
 	},
 };
 
-static void ath12k_host_cap_parse_mlo(struct qmi_wlanfw_host_cap_req_msg_v01 *req)
+static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
+				      struct qmi_wlanfw_host_cap_req_msg_v01 *req)
 {
+	struct wlfw_host_mlo_chip_info_s_v01 *info;
+	u8 hw_link_id = 0;
+	int i;
+
+	if (!ab->hw_params->def_num_link)
+		return;
+
 	req->mlo_capable_valid = 1;
 	req->mlo_capable = 1;
 	req->mlo_chip_id_valid = 1;
@@ -1905,16 +1913,22 @@ static void ath12k_host_cap_parse_mlo(struct qmi_wlanfw_host_cap_req_msg_v01 *re
 	/* Max peer number generally won't change for the same device
 	 * but needs to be synced with host driver.
 	 */
-	req->max_mlo_peer = 32;
+	req->max_mlo_peer = ab->hw_params->max_mlo_peer;
 	req->mlo_num_chips_valid = 1;
 	req->mlo_num_chips = 1;
+
+	info = &req->mlo_chip_info[0];
+	info->chip_id = 0;
+	info->num_local_links = ab->hw_params->def_num_link;
+
+	for (i = 0; i < info->num_local_links; i++) {
+		info->hw_link_id[i] = hw_link_id;
+		info->valid_mlo_link_id[i] = 1;
+
+		hw_link_id++;
+	}
+
 	req->mlo_chip_info_valid = 1;
-	req->mlo_chip_info[0].chip_id = 0;
-	req->mlo_chip_info[0].num_local_links = 2;
-	req->mlo_chip_info[0].hw_link_id[0] = 0;
-	req->mlo_chip_info[0].hw_link_id[1] = 1;
-	req->mlo_chip_info[0].valid_mlo_link_id[0] = 1;
-	req->mlo_chip_info[0].valid_mlo_link_id[1] = 1;
 }
 
 static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
@@ -1963,10 +1977,10 @@ static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 		 */
 		req.nm_modem |= SLEEP_CLOCK_SELECT_INTERNAL_BIT;
 		req.nm_modem |= PLATFORM_CAP_PCIE_GLOBAL_RESET;
-
-		ath12k_host_cap_parse_mlo(&req);
 	}
 
+	ath12k_host_cap_parse_mlo(ab, &req);
+
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
 	if (ret < 0)
-- 
2.34.1


