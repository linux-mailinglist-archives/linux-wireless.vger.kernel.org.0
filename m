Return-Path: <linux-wireless+bounces-14680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA949B50F9
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 18:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3031F22072
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041EB20ADE5;
	Tue, 29 Oct 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cVc82bBL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED720ADCB;
	Tue, 29 Oct 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223106; cv=none; b=EXydkkT9MZRsM5xHb8DXOoSGPn7S/QI2ozyXu7Bjb9p87MThYCCtZ3Vo1NrYnYGi8IgLuEHwgRS3f7n4z6eySgLYyv0EyRwK9Xh46Cttr8C7EYGxFRnB+EhlKb5RPkfgInB75cpH3CyJPdrDCUhgDSob1M+rfuuj2vQ8EyJSZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223106; c=relaxed/simple;
	bh=HYF5Iq4Q9TjseQhZaMlec1WVhiNYlw7rxMHbsBMt/xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbicXE+QPjVHPW4iVkHV1xNQkhGk7aZjmf2aeAAmroCKXDmUd8/GqvW/O0emOJqtPX4wjjLcSUyfVevas0NrEBiW5+mjiihvAd59ojO0zh7H9ssXT67BvkZouLPW+PSfYOZERSwWqtkmrK5uHlm2GH3Wb+t16i37uzFRbe5PXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cVc82bBL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T9aLrn010746;
	Tue, 29 Oct 2024 17:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VZ6szvlA0Ilv5PHdmu4JIiqAYVgmeX9bYSCSHXNxfuA=; b=cVc82bBLWWSGsjkG
	Xh5rCZbfgbevbAfFGfk8vrI4JUJOaK82DvXAdh+74xs4Q52HORDQ+WGURi4acMUJ
	MpCL/Xm+ZOLbW/UeMMP802v92P321CD30/uM8H0paiFNCNcOiWbta0zrValfllhd
	TlUXct0jjaeBMFG1UIrgdYkezGdpf2/3PKC3PA6OquIJLuEdeFZWnPhKi2hG1DrP
	Now+SEdQPRILbm3XfSWlKCEJmBxaHXU3oTeqNP5DJ/7xn1w0wl3ZpfmzBuxwrFHf
	zINWpK88fdTCH5NHobJ5ksWjEvABJt4A/4Ul9d4OYvrW23X1Cft+qgvO3z4w5Szo
	mvye9w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqcqsa2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:31:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49THVdAq014410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:31:39 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 29 Oct 2024 10:31:34 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        "Raj
 Kumar Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH v2 3/5] wifi: ath12k: Send partner device details in QMI MLO capability
Date: Tue, 29 Oct 2024 23:00:48 +0530
Message-ID: <20241029173050.2188150-4-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
References: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: GpxKaNrGcUGgVmf4pbZ2aGn5diDzJCTO
X-Proofpoint-GUID: GpxKaNrGcUGgVmf4pbZ2aGn5diDzJCTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290132

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, QMI MLO host capability is sent with the details of
local links and hw_link id only for particular device but in case
of multi device group abstraction, it has to include the details
of hw_link_id, num_local_links of every partner device that is
involved in the group during QMI MLO capability exchange.

Add changes to send partner device details in QMI MLO capability
exchange.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 86 ++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 5ebfe13b5313..689171b7b19f 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2016,17 +2016,19 @@ static const struct qmi_elem_info qmi_wlanfw_wlan_ini_resp_msg_v01_ei[] = {
 	},
 };
 
-static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
-				      struct qmi_wlanfw_host_cap_req_msg_v01 *req)
+static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
+				     struct qmi_wlanfw_host_cap_req_msg_v01 *req)
 {
 	struct wlfw_host_mlo_chip_info_s_v01 *info;
+	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_base *partner_ab;
 	u8 hw_link_id = 0;
-	int i;
+	int i, j, ret;
 
-	if (!ab->ag->mlo_capable) {
+	if (!ag->mlo_capable) {
 		ath12k_dbg(ab, ATH12K_DBG_QMI,
 			   "MLO is disabled hence skip QMI MLO cap");
-		return;
+		return 0;
 	}
 
 	if (!ab->qmi.num_radios || ab->qmi.num_radios == U8_MAX) {
@@ -2035,7 +2037,13 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 		ath12k_dbg(ab, ATH12K_DBG_QMI,
 			   "skip QMI MLO cap due to invalid num_radio %d\n",
 			   ab->qmi.num_radios);
-		return;
+		return 0;
+	}
+
+	if (ab->device_id == ATH12K_INVALID_DEVICE_ID) {
+		ath12k_err(ab, "failed to send MLO cap due to invalid device id\n");
+		ret = -EINVAL;
+		return ret;
 	}
 
 	req->mlo_capable_valid = 1;
@@ -2043,27 +2051,71 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_chip_id_valid = 1;
 	req->mlo_chip_id = ab->device_id;
 	req->mlo_group_id_valid = 1;
-	req->mlo_group_id = 0;
+	req->mlo_group_id = ag->id;
 	req->max_mlo_peer_valid = 1;
 	/* Max peer number generally won't change for the same device
 	 * but needs to be synced with host driver.
 	 */
 	req->max_mlo_peer = ab->hw_params->max_mlo_peer;
 	req->mlo_num_chips_valid = 1;
-	req->mlo_num_chips = 1;
+	req->mlo_num_chips = ag->num_devices;
 
-	info = &req->mlo_chip_info[0];
-	info->chip_id = ab->device_id;
-	info->num_local_links = ab->qmi.num_radios;
+	mutex_lock(&ag->mutex_lock);
+	for (i = 0; i < ag->num_devices; i++) {
+		info = &req->mlo_chip_info[i];
+		partner_ab = ag->ab[i];
+
+		if (partner_ab->device_id == ATH12K_INVALID_DEVICE_ID) {
+			ath12k_err(ab, "failed to send MLO cap due to invalid partner device id\n");
+			ret = -EINVAL;
+			goto device_cleanup;
+		}
+
+		info->chip_id = partner_ab->device_id;
+		info->num_local_links = partner_ab->qmi.num_radios;
 
-	for (i = 0; i < info->num_local_links; i++) {
-		info->hw_link_id[i] = hw_link_id;
-		info->valid_mlo_link_id[i] = 1;
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "MLO device id %d num_link %d\n",
+			   info->chip_id, info->num_local_links);
 
-		hw_link_id++;
+		for (j = 0; j < info->num_local_links; j++) {
+			info->hw_link_id[j] = hw_link_id;
+			info->valid_mlo_link_id[j] = 1;
+
+			hw_link_id++;
+		}
 	}
 
+	if (hw_link_id <= 0)
+		ag->mlo_capable = false;
+
 	req->mlo_chip_info_valid = 1;
+
+	mutex_unlock(&ag->mutex_lock);
+	return 0;
+
+device_cleanup:
+	for (i = i - 1; i >= 0; i--) {
+		info = &req->mlo_chip_info[i];
+
+		memset(info, 0, sizeof(*info));
+	}
+
+	req->mlo_num_chips = 0;
+	req->mlo_num_chips_valid = 0;
+
+	req->max_mlo_peer = 0;
+	req->max_mlo_peer_valid = 0;
+	req->mlo_group_id = 0;
+	req->mlo_group_id_valid = 0;
+	req->mlo_chip_id = 0;
+	req->mlo_chip_id_valid = 0;
+	req->mlo_capable = 0;
+	req->mlo_capable_valid = 0;
+
+	ag->mlo_capable = false;
+	mutex_unlock(&ag->mutex_lock);
+
+	return ret;
 }
 
 static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
@@ -2111,7 +2163,9 @@ static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 		req.nm_modem |= PLATFORM_CAP_PCIE_GLOBAL_RESET;
 	}
 
-	ath12k_host_cap_parse_mlo(ab, &req);
+	ret = ath12k_host_cap_parse_mlo(ab, &req);
+	if (ret < 0)
+		goto out;
 
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
-- 
2.34.1


