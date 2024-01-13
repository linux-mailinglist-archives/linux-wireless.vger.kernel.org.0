Return-Path: <linux-wireless+bounces-1851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE9B82C843
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 01:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9190287976
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 00:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0577036D;
	Sat, 13 Jan 2024 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="caNWzge2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D2364
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CNsab5019464;
	Sat, 13 Jan 2024 00:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=rfMgev93VQedRiP1QY9J6IK/nbD45G+LSnUdtS79HSs=; b=ca
	NWzge27YX+YkW7qJUCRsOUH2srcujTjaOolf6VDBD52k7rXbjsPJlhJIjDBUWQHt
	IpTXsWKCeUaK4MsTahq6wc550O+KbzpWMrQPPb6HQtm8KMW3axrHWwteXcSp6tqq
	xZoEKTOLXkE0g+uIaAhrl5tctACNd5Ylh2PQ/Idc0jd3i4xTCqFJ1jl+B4HO80yk
	gq79tM78ApuNO8feYz3rwmNb/Dh0/jSu3MZTE8l/i/ag8ZnGhGDGlmFmkiixYO2+
	bngBn7Wg9R5Yfs4aWGqctjJKgvGiW3ilSky0BEdBGlYZ/WAPvGHt2VIUKLX5Vwo9
	3lr5HVIbOPF7BDL1dJdA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk18d27va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 00:17:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40D0HJuS022804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 00:17:19 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Jan 2024 16:17:18 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: Add QMI PHY capability learn support
Date: Sat, 13 Jan 2024 05:46:59 +0530
Message-ID: <20240113001659.1022465-3-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: NhKEapBJkKJ915uwbFDoGSW1fD_fzq0u
X-Proofpoint-ORIG-GUID: NhKEapBJkKJ915uwbFDoGSW1fD_fzq0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401130000

Currently, the number of PHY is learned from the firmware service ready
event message. However, on the QCN9274 platform, number of PHY is a
variable parameter. To enable MLO capability in the QMI host capability
request message, the driver needs the PHY count information earlier than
the firmware service ready event. Therefore, a new QMI message,
"PHY capability message", is introduced to retrieve this information.
This message allows the driver to fill in the MLO parameter in the QMI
host capability request message. If the new QMI PHY capability message
fails, the default configuration in the HW params will be used.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |   1 +
 drivers/net/wireless/ath/ath12k/qmi.c  | 124 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/qmi.h  |  17 ++++
 3 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index d73e2d33a41e..db4a71b6239a 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1176,6 +1176,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 
 	ab->dev = dev;
 	ab->hif.bus = bus;
+	ab->qmi.num_radios = U8_MAX;
 
 	return ab;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index f09d9b845794..9856750c9849 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -528,6 +528,67 @@ static const struct qmi_elem_info qmi_wlanfw_host_cap_resp_msg_v01_ei[] = {
 	},
 };
 
+static const struct qmi_elem_info qmi_wlanfw_phy_cap_req_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
+static const struct qmi_elem_info qmi_wlanfw_phy_cap_resp_msg_v01_ei[] = {
+	{
+		.data_type	= QMI_STRUCT,
+		.elem_len	= 1,
+		.elem_size	= sizeof(struct qmi_response_type_v01),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x02,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01, resp),
+		.ei_array	= qmi_response_type_v01_ei,
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   num_phy_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x10,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   num_phy),
+	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   board_id_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_4_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u32),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x11,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   board_id),
+	},
+	{
+		.data_type	= QMI_EOTI,
+		.array_type	= NO_ARRAY,
+		.tlv_type	= QMI_COMMON_TLV_TYPE,
+	},
+};
+
 static const struct qmi_elem_info qmi_wlanfw_ind_register_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_OPT_FLAG,
@@ -1900,8 +1961,12 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	u8 hw_link_id = 0;
 	int i;
 
-	if (!ab->hw_params->def_num_link)
+	if (!ab->qmi.num_radios || ab->qmi.num_radios == U8_MAX) {
+		ath12k_dbg(ab, ATH12K_DBG_QMI,
+			   "Skip QMI MLO cap due to invalid num_radio %d\n",
+			   ab->qmi.num_radios);
 		return;
+	}
 
 	req->mlo_capable_valid = 1;
 	req->mlo_capable = 1;
@@ -1919,7 +1984,7 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 
 	info = &req->mlo_chip_info[0];
 	info->chip_id = 0;
-	info->num_local_links = ab->hw_params->def_num_link;
+	info->num_local_links = ab->qmi.num_radios;
 
 	for (i = 0; i < info->num_local_links; i++) {
 		info->hw_link_id[i] = hw_link_id;
@@ -2010,6 +2075,59 @@ static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 	return ret;
 }
 
+static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
+{
+	struct qmi_wlanfw_phy_cap_req_msg_v01 req = { };
+	struct qmi_wlanfw_phy_cap_resp_msg_v01 resp = { };
+	struct qmi_txn txn;
+	int ret;
+
+	ret = qmi_txn_init(&ab->qmi.handle, &txn,
+			   qmi_wlanfw_phy_cap_resp_msg_v01_ei, &resp);
+	if (ret < 0)
+		goto out;
+
+	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
+			       QMI_WLANFW_PHY_CAP_REQ_V01,
+			       QMI_WLANFW_PHY_CAP_REQ_MSG_V01_MAX_LEN,
+			       qmi_wlanfw_phy_cap_req_msg_v01_ei, &req);
+	if (ret < 0) {
+		qmi_txn_cancel(&txn);
+		ath12k_warn(ab, "failed to send phy capability request, err = %d\n", ret);
+		goto out;
+	}
+
+	ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH12K_QMI_WLANFW_TIMEOUT_MS));
+	if (ret < 0)
+		goto out;
+
+	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!resp.num_phy_valid) {
+		ret = -ENODATA;
+		goto out;
+	}
+
+	ab->qmi.num_radios = resp.num_phy;
+
+	ath12k_dbg(ab, ATH12K_DBG_QMI, "PHY capability resp valid %d num_phy %d valid %d board_id %d\n",
+		   resp.num_phy_valid, resp.num_phy,
+		   resp.board_id_valid, resp.board_id);
+
+	return;
+
+out:
+	/* If PHY capability not advertised then rely on default num link */
+	ab->qmi.num_radios = ab->hw_params->def_num_link;
+
+	ath12k_dbg(ab, ATH12K_DBG_QMI,
+		   "No valid response from PHY capability, choose default num_phy %d\n",
+		   ab->qmi.num_radios);
+}
+
 static int ath12k_qmi_fw_ind_register_send(struct ath12k_base *ab)
 {
 	struct qmi_wlanfw_ind_register_req_msg_v01 *req;
@@ -2805,6 +2923,8 @@ static int ath12k_qmi_event_server_arrive(struct ath12k_qmi *qmi)
 	struct ath12k_base *ab = qmi->ab;
 	int ret;
 
+	ath12k_qmi_phy_cap_send(ab);
+
 	ret = ath12k_qmi_fw_ind_register_send(ab);
 	if (ret < 0) {
 		ath12k_warn(ab, "qmi failed to send FW indication QMI:%d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index e25bbaa125e8..bfed22c310be 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -141,6 +141,7 @@ struct ath12k_qmi {
 	u32 target_mem_mode;
 	bool target_mem_delayed;
 	u8 cal_done;
+	u8 num_radios;
 	struct target_info target;
 	struct m3_mem_region m3_mem;
 	unsigned int service_ins_id;
@@ -251,6 +252,22 @@ struct qmi_wlanfw_host_cap_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
+#define QMI_WLANFW_PHY_CAP_REQ_MSG_V01_MAX_LEN		0
+#define QMI_WLANFW_PHY_CAP_REQ_V01			0x0057
+#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN		18
+#define QMI_WLANFW_PHY_CAP_RESP_V01			0x0057
+
+struct qmi_wlanfw_phy_cap_req_msg_v01 {
+};
+
+struct qmi_wlanfw_phy_cap_resp_msg_v01 {
+	struct qmi_response_type_v01 resp;
+	u8 num_phy_valid;
+	u8 num_phy;
+	u8 board_id_valid;
+	u32 board_id;
+};
+
 #define QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN		54
 #define QMI_WLANFW_IND_REGISTER_REQ_V01				0x0020
 #define QMI_WLANFW_IND_REGISTER_RESP_MSG_V01_MAX_LEN		18
-- 
2.34.1


