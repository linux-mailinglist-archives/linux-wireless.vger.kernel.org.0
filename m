Return-Path: <linux-wireless+bounces-6524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 392068A9A75
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 14:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924B7B211DC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341112880F;
	Thu, 18 Apr 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gdsPfyG4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A6141995
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444997; cv=none; b=K4PAZX++dKcauyN5tPl9+g1IYchM9I4w/LddfE7WnEF5BEgBxJMYwJ4yqs0ya4gmK69NGinaK4vRWcpzSXeRD7CHTaioHTb6Uya58spMUIZcjhhU2KoFTO95vZc8SbnRcgERMKrZIF9hPnDDPkuBnmrhzu/K2SlLX5ksiGDjLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444997; c=relaxed/simple;
	bh=Q35jSQfsk3Vq5L85cgusgkrtMQZ/MAfdld9YGR6uM1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBU5G/dUih1y7KamnL5Xz0jH/9Nt9IL0n4MGNFZ5oR1bF2dwhQP83dOvJ1Ma7hgG2MKOydfaGgw/0ia777Aa4j4/WThr5aHtlorGU0OiQVZRbSn4ejISkWLTOU9R2LLxcGqZI04xDqgHGxQROREtKWb1g+FSCIrRAMXd6q8x81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gdsPfyG4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ICkuk4010626;
	Thu, 18 Apr 2024 12:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=HTNe+FVQjOMyTUkjet102IyEgdKaxB/3ZRF28LVTWiE=; b=gd
	sPfyG4gUTn5Uhb47QZ0FpVBHkRE2YjKjColXPGbsUAkHK4iD7Hx7UfcrVFTDujGg
	upbQOqdzbV2uCxYrESNr1/x8VZxIZKYPfDbiAStyOCYuMKvHPi1U58Sa4HBx5miu
	WS740OSv/Zd7RxIGPlB1yJR+gxaY5dx0ExhrFzuNhUA5cUaEd58h0tuJFzs3NWQi
	vxqilu2zny9gnqrl6k+QODLpBj2znSUFlyenGr71EXa30VfhJVkjdwsX8uEAEz7L
	5t00mPLeWaYicQw9F/THcfBDgT5RYXvzx9Wv9GaTPVWV+h6MrgpjrJjy9Gwl2R8c
	U+WSrm1xmP/xTSmXfW5g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk3tx80m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 12:56:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ICuUA6025104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 12:56:30 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 05:56:28 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: read single_chip_mlo_support parameter from QMI PHY capability
Date: Thu, 18 Apr 2024 18:26:08 +0530
Message-ID: <20240418125609.3867730-2-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418125609.3867730-1-quic_rajkbhag@quicinc.com>
References: <20240418125609.3867730-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: WWOvBe2xdGqkRJQ7N34JExCKfl6rPTc2
X-Proofpoint-ORIG-GUID: WWOvBe2xdGqkRJQ7N34JExCKfl6rPTc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_11,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180092

New parameter 'single_chip_mlo_support' was added in QMI PHY
capability response message. This is an optional parameter added
in QCN9274 firmware. This parameter states if the firmware
supports Single-Link Operation (SLO) and Multi-Link Operation (MLO)
within the same device.

If single_chip_mlo_support = 1, then intra device SLO/MLO is supported
in the firmware.
If single_chip_mlo_support = 0, then intra device SLO/MLO is not
supported in the firmware.

Hence, add support to read 'single_chip_mlo_support' parameter from
the QMI PHY capability response message.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 24 ++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/qmi.h |  2 ++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index db8ba5fec2ae..a555839dae8e 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -582,6 +582,24 @@ static const struct qmi_elem_info qmi_wlanfw_phy_cap_resp_msg_v01_ei[] = {
 		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
 					   board_id),
 	},
+	{
+		.data_type      = QMI_OPT_FLAG,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x13,
+		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   single_chip_mlo_support_valid),
+	},
+	{
+		.data_type      = QMI_UNSIGNED_1_BYTE,
+		.elem_len       = 1,
+		.elem_size      = sizeof(u8),
+		.array_type     = NO_ARRAY,
+		.tlv_type       = 0x13,
+		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   single_chip_mlo_support),
+	},
 	{
 		.data_type	= QMI_EOTI,
 		.array_type	= NO_ARRAY,
@@ -2160,9 +2178,11 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 
 	ab->qmi.num_radios = resp.num_phy;
 
-	ath12k_dbg(ab, ATH12K_DBG_QMI, "phy capability resp valid %d num_phy %d valid %d board_id %d\n",
+	ath12k_dbg(ab, ATH12K_DBG_QMI,
+		   "phy capability resp valid %d num_phy %d valid %d board_id %d valid %d single_chip_mlo_support %d\n",
 		   resp.num_phy_valid, resp.num_phy,
-		   resp.board_id_valid, resp.board_id);
+		   resp.board_id_valid, resp.board_id,
+		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support);
 
 	return;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 6ee33c9851c6..f7a5eb11ce44 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -265,6 +265,8 @@ struct qmi_wlanfw_phy_cap_resp_msg_v01 {
 	u8 num_phy;
 	u8 board_id_valid;
 	u32 board_id;
+	u8 single_chip_mlo_support_valid;
+	u8 single_chip_mlo_support;
 };
 
 #define QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN		54
-- 
2.34.1


