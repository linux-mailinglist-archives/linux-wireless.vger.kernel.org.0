Return-Path: <linux-wireless+bounces-18133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27328A21B75
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 11:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC347A2C43
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD301C3BF7;
	Wed, 29 Jan 2025 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oa2ENbXw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D051B6D1C
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148322; cv=none; b=ueCkiOKeEIqpUEQvnqg98evBhoL3ToDiMA7zB+6xWlfpgofoxpF/irJl8ih+wyqjITlmF7JTgWf0gcEqh7524w7cBXEKsSmd5FRfOrDn1faW00gAYx7bN8IraS11VDZ1xUI0I/YITq1Od+vPBMGSxpQN3cVom5E29POZHvTBLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148322; c=relaxed/simple;
	bh=wkdJ/6nkEODPkjuDaClkNgdBeIuW5OApNHZ4oB60iy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9k3La5pL6b3TiU7fy1nbijJLl/NQS0gYFxEA8krpdDd6hI2pSIBZP6cJv6k5raxku4zhOYKVOQ3oRaceCEX+EWbOtR5bF1uV6Ah0Ky7BtnzvcELsBMmKPq5hVxJ5I0qfcZW5eJX5d4gidFL6v7lQwzUHWJ9tgPvPvaZFl3nPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oa2ENbXw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T6Pb9E008941;
	Wed, 29 Jan 2025 10:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QUXUfbuYGNfygl4L6i4xlnfQNTQj3ql467raIfXC1nU=; b=Oa2ENbXwYaHj06Qu
	Bk8GJMGS/YD8e8ADd9Sg5kdqmVFjipXGPdpKbrOylaMX2RDjYB2XSraHz1dlvjdc
	IY9687bVczLo4bxI6Ztw162q/ouwDrVjdFEaWFkveGdVVqio1Nykjycog0X+AFIW
	s1kdHA21zMLLiw32WCLYauxrwmXBXkj/FhgmWffjfSYi3CxRZq07GO/W1zgCJWwY
	vj67t0DkCgrmM2MPwwu0+smgyndm3CgOPTicv7RAL3/7+8H4JZTlDtD7SCXIrjMx
	JXdHqrwXx/cv8uwsSv7yMYAgol3RFpcZ2cw+RC59fR/O8yQR3dgm/wwiSndJg/b2
	peEerQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ff1q0dxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 10:58:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TAwaah001357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 10:58:36 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 02:58:33 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH v6 4/9] wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
Date: Wed, 29 Jan 2025 16:28:05 +0530
Message-ID: <20250129105810.1094359-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250129105810.1094359-1-quic_periyasa@quicinc.com>
References: <20250129105810.1094359-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: vBusnK4PSFHsaax9syvnv3pfrRoNkbd8
X-Proofpoint-ORIG-GUID: vBusnK4PSFHsaax9syvnv3pfrRoNkbd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501290089

Currently, monitor is not enabled. However, in the future, the monitor
will be enabled. Therefore, add the necessary HAL_PHYRX_OTHER_RECEIVE_INFO
TLV parsing support in the monitor Rx path, which helps to populate the
extended Rx statistics.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 7 +++++++
 drivers/net/wireless/ath/ath12k/hal_rx.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 96e9d68618d3..f4552bc05eef 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1599,6 +1599,13 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 					     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RX_BW);
 		break;
 	}
+	case HAL_PHYRX_OTHER_RECEIVE_INFO: {
+		const struct hal_phyrx_common_user_info *cmn_usr_info = tlv_data;
+
+		ppdu_info->gi = le32_get_bits(cmn_usr_info->info0,
+					      HAL_RX_PHY_CMN_USER_INFO0_GI);
+		break;
+	}
 	case HAL_RX_PPDU_START_USER_INFO:
 		ath12k_dp_mon_hal_rx_parse_user_info(tlv_data, userid, ppdu_info);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 765b53741861..445d1c33b41f 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -683,6 +683,14 @@ struct hal_rx_resp_req_info {
 #define HAL_RX_MPDU_ERR_MPDU_LEN		BIT(6)
 #define HAL_RX_MPDU_ERR_UNENCRYPTED_FRAME	BIT(7)
 
+#define HAL_RX_PHY_CMN_USER_INFO0_GI		GENMASK(17, 16)
+
+struct hal_phyrx_common_user_info {
+	__le32 rsvd[2];
+	__le32 info0;
+	__le32 rsvd1;
+} __packed;
+
 #define HAL_RX_EHT_SIG_NDP_CMN_INFO0_SPATIAL_REUSE	GENMASK(3, 0)
 #define HAL_RX_EHT_SIG_NDP_CMN_INFO0_GI_LTF		GENMASK(5, 4)
 #define HAL_RX_EHT_SIG_NDP_CMN_INFO0_NUM_LTF_SYM	GENMASK(8, 6)
-- 
2.34.1


