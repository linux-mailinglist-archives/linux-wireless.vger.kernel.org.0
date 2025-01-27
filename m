Return-Path: <linux-wireless+bounces-18008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA903A1D4BB
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 11:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331E61651C8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBFA1FDE08;
	Mon, 27 Jan 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j5MWIo/Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A801FECA5
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974891; cv=none; b=kwQwPQU/zf7HD9gZbFpPj3SVd3/Ley7RcgX8nANE4xdRud3SDHf4s2yN5wwEDl0SMBluXAN65xqRSWNXbuHmPDJoMk9L7R8L/BUMYv/nT7JtG0mzui6/y+lQ5BQO3tCVPWtOU7K09J5a87R+R2ur8Wj3R8zy3ebVIUfcHtQLF6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974891; c=relaxed/simple;
	bh=ztIfTnGbjAbW4sknR6nFHEa3RgPi9BMQ7jTTevkDGrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mc64TxrVb3oy4m0JgO3Zlyrn1RMWHU+G9od2DDfm28MLifxsCI7urtTDcC4B7gBDF+A2Jn5WHHY53lOMCUhPvwf+Wskygj02uWBO98RiG1C1lJH232a/mrnjkfZRozj0QrF3jwrK/0Hc7g+Dtkhf8OFL7dYUfJsGUU6griXRJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j5MWIo/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R63YDN021912;
	Mon, 27 Jan 2025 10:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nJlXBEjjiRl6WbRafxT+YCQL/t+OcLUqihKaZQwuX4Y=; b=j5MWIo/ZSBdD8n4V
	tMGCo3a7ZVztYlsrhORhOKie3wxAsBWEwXUf3GHJkgXr5hfWya7ZTaZuskhqCSmV
	qb4a8yuGBA+ItonAi306jQ/G+QPjClVq5yPSdHo9AELxxSf+ZDrjVwuwld+ux8jV
	zQ0A1iJ2D7BiqMGq/zmUJ+8zp+c+UkQRPWoMCADaDxlJb+BYvvxmFCiZBY5/JPl1
	4M2N1k5JBVdpaLyHZ6foPpbBRl59fHRuk7Lz8H3HlrLI+MS9b31xduvWlqraMLgi
	zOErjwDOMWo/vK+OpDAv3fSzB5Ro2CoOiIkZNcpTXzAUMZHNgMYfGhm3X9FpMZ/B
	Sqo6Rg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e4hvrgv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:48:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50RAm5eI027738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:48:05 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 02:48:03 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v5 4/9] wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
Date: Mon, 27 Jan 2025 16:17:33 +0530
Message-ID: <20250127104738.4174862-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
References: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 0cUWJOAf0f5sHWn_QKdnLinG_VgyUA4n
X-Proofpoint-ORIG-GUID: 0cUWJOAf0f5sHWn_QKdnLinG_VgyUA4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501270087

Currently, monitor is not enabled. However, in the future, the monitor
will be enabled. Therefore, add the necessary HAL_PHYRX_OTHER_RECEIVE_INFO
TLV parsing support in the monitor Rx path, which helps to populate the
extended Rx statistics.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 7 +++++++
 drivers/net/wireless/ath/ath12k/hal_rx.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f9de8c509061..8ded73d87c73 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1630,6 +1630,13 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
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


