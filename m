Return-Path: <linux-wireless+bounces-14936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B049BD41F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 19:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A921F23348
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4951EC008;
	Tue,  5 Nov 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LXexr+Mq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11741EBFF6;
	Tue,  5 Nov 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829948; cv=none; b=m3QTatT6+hItlam5Q/Tc4bu4LRAwOwwNPw3sJG1G3aUuOxTQKtHGd7gWF8sQWONXver6s9MxApDm3csrdj0ZoI/o3A4hA/z1mtgX8Mz7wjLbmMDETOTBoerh0I7Omn5I4f3r/Tq4/HYwaAgK64nPUx9vN4GKIOy+rEoD0Us+o28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829948; c=relaxed/simple;
	bh=lk5wtXaSW2fCZuWZftr0WUHMTvIvtLqrS5Y8YXOmbew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avmEMXLpo3DASROrWMGE/IwpbWtIKyFa8g1aj0U/6ToRo1NW7ZAa3rTTTv09n7yJuu84p43AVAUBODelatrL5W9iQ1JnZ1cEdnbnMTFrG+8TaZ/j/ezrqdHiXqDzaXQq3n+9R5gvsBVzncg9eNF3NW+50s9EonIcdCl9KTa+/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LXexr+Mq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A59LldI009101;
	Tue, 5 Nov 2024 18:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UUU3cFi/DqXlj7chCzyg9IJQbxDlJYop7VnNjUMNe9A=; b=LXexr+MqRnKC9lXg
	N7G3SSRk03CBjU7AwIb8+TZ0vNn7biWr/zFLpAxEDldkM0hpOqL2HQuQkykbdtED
	tde139cZ/r5tlJxWPU+dQVv73R0U7B1hNPwP9WFRj58h+riOzkQ2J/EaCdZm6u0u
	1ZoDBzJbMPROCq/jIwIkpWCtaLw2rZs2pskUqdMViM+zXzhTLAPUmOp9/+EDTJ2E
	WMrHPGFocQTzoJZyG1xTS87oRIGIn2FK5E5SlXrkREKWoj3oZmMWMZLBMKoY3nC5
	388XXFSR+kd+mdAjOAFyYt4Z6xOeYls6fI2TrNTHpu//bTctHTVxZ5TWUsQyAnjL
	4roXFQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4urmwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 18:05:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A5I5dOo009112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 18:05:39 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 5 Nov 2024 10:05:35 -0800
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
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH v3 4/5] wifi: ath12k: Assign unique hardware link IDs during QMI host capability
Date: Tue, 5 Nov 2024 23:34:43 +0530
Message-ID: <20241105180444.770951-5-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: kgkoAMOQjHlQQ4KPhZXMu_qMt03_ak46
X-Proofpoint-ORIG-GUID: kgkoAMOQjHlQQ4KPhZXMu_qMt03_ak46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050139

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

Currently, in the QMI host capability, the device index, the number of
local links, and the corresponding hardware link IDs are sent. The
hardware link ID assignment is based on the local variable `hw_link_id`,
which starts from 0 and ranges up to `num_local_links` in the device.
Starting from 0 is not ideal because it can result in the same link ID
being assigned to different devices in certain scenarios (e.g., split MAC).
Additionally, for multi link operations the firmware expects the hardware
link IDs in the same order as the Wireless Serial Interface (WSI)
connection.

Hence, for MLO to function seamlessly, the hardware link IDs across
devices need to be unique and should follow the order of the WSI
connection.

To address this, a previous change read the WSI index from the Device Tree
(DT) and stored it. Use this WSI index to determine the starting hardware
link IDs for each device, ensuring uniqueness and correct order across all
devices.

While at it, add debug prints to clearly show the MLO capability
advertisement sent during QMI host capability exchange.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/qmi.c  | 40 ++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 619407398a99..a532cfdc7558 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -845,11 +845,13 @@ struct ath12k_hw_group {
 	u8 num_hw;
 	bool mlo_capable;
 	struct device_node *wsi_node[ATH12K_MAX_SOCS];
+	bool hw_link_id_init_done;
 };
 
 /* Holds WSI info specific to each device, excluding WSI group info */
 struct ath12k_wsi_info {
 	u32 index;
+	u32 hw_link_id_base;
 };
 
 /* Master structure to hold the hw data which may be used in core module */
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 689171b7b19f..ab34f4788867 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2016,6 +2016,25 @@ static const struct qmi_elem_info qmi_wlanfw_wlan_ini_resp_msg_v01_ei[] = {
 	},
 };
 
+static void ath12k_host_cap_hw_link_id_init(struct ath12k_hw_group *ag)
+{
+	struct ath12k_base *ab, *partner_ab;
+	int i, j, hw_id_base;
+
+	for (i = 0; i < ag->num_devices; i++) {
+		hw_id_base = 0;
+		ab = ag->ab[i];
+		for (j = 0; j < ag->num_devices; j++) {
+			partner_ab = ag->ab[j];
+			if (partner_ab->wsi_info.index >= ab->wsi_info.index)
+				continue;
+			hw_id_base += partner_ab->qmi.num_radios;
+		}
+		ab->wsi_info.hw_link_id_base = hw_id_base;
+	}
+	ag->hw_link_id_init_done = true;
+}
+
 static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 				     struct qmi_wlanfw_host_cap_req_msg_v01 *req)
 {
@@ -2060,7 +2079,17 @@ static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_num_chips_valid = 1;
 	req->mlo_num_chips = ag->num_devices;
 
+	ath12k_dbg(ab, ATH12K_DBG_QMI, "MLO Capability advertisement:");
+	ath12k_dbg(ab, ATH12K_DBG_QMI, " * device_id: %d", req->mlo_chip_id);
+	ath12k_dbg(ab, ATH12K_DBG_QMI, " * group_id: %d", req->mlo_group_id);
+	ath12k_dbg(ab, ATH12K_DBG_QMI, " * num_devices: %d", req->mlo_num_chips);
+	ath12k_dbg(ab, ATH12K_DBG_QMI, " * Devices info:");
+
 	mutex_lock(&ag->mutex_lock);
+
+	if (!ag->hw_link_id_init_done)
+		ath12k_host_cap_hw_link_id_init(ag);
+
 	for (i = 0; i < ag->num_devices; i++) {
 		info = &req->mlo_chip_info[i];
 		partner_ab = ag->ab[i];
@@ -2074,12 +2103,17 @@ static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 		info->chip_id = partner_ab->device_id;
 		info->num_local_links = partner_ab->qmi.num_radios;
 
-		ath12k_dbg(ab, ATH12K_DBG_QMI, "MLO device id %d num_link %d\n",
-			   info->chip_id, info->num_local_links);
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "   * device_id: %d",
+			   info->chip_id);
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "     * num_links: %d",
+			   info->num_local_links);
 
 		for (j = 0; j < info->num_local_links; j++) {
-			info->hw_link_id[j] = hw_link_id;
+			info->hw_link_id[j] = partner_ab->wsi_info.hw_link_id_base + j;
 			info->valid_mlo_link_id[j] = 1;
+			ath12k_dbg(ab, ATH12K_DBG_QMI,
+				   "       * hw_link_id: %d\n",
+				   info->hw_link_id[j]);
 
 			hw_link_id++;
 		}
-- 
2.34.1


