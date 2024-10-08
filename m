Return-Path: <linux-wireless+bounces-13708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6C994100
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C161F28F4F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216BC1D4166;
	Tue,  8 Oct 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SkxBjrec"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A91D417C
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372974; cv=none; b=U7WMs+yV7v5NbIUn24TF2tt1FpDW1gzyyuZUIHmNtaoQCOlNRa8plz+6NM9XF26r8WkS2v2q+29Rad8zmMbXdqEgh+PLYeKagTH+AnOKGOaq+h/FgOV9iCtOeRZIymPIdXHO5V1GfW8tx+JLVp/tAoCquD4B2fC+KSpn1m933fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372974; c=relaxed/simple;
	bh=Qr90rch5CiczVooZHfO1z6zwt0RQfXwaunF2wbS48oQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALyJFIzGTfPhsh/a13T4BPpHFM1nGFSSk8zYZsQjLlDuWGw4xEhIzWx1qBPPARuD3oMLJ/fUcDI/7YGJGmPtNw/4IMt7r/gbJTKh6lLTpMs4fW5d98Mt2l2PVb1E2jZLLHqy63Op/NQ6NP984lcUUGcDpDzG920lxecFCm4r5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SkxBjrec; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984CbS5000565;
	Tue, 8 Oct 2024 07:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g8k++hW0yYeawWsABFKSOwUPR8iyYpR4D2ee0lgG17c=; b=SkxBjreckhZQDebA
	6oMZvP5cD/btCo3oCvgUxjPhK1xW/WJo2sPu4v4TSafUxT8rUQU01Cjpk/3QsAmv
	c4GJh0ELuu9JeQa1ZqMyU1O0yex5IMFXGm06ycmFuShpTEMyZ6fqvdTqM1a4O4PP
	F5+q1Yto8P0rte7myRZsfeDVCf0asbvnFbBP3wDbF9AqmcTRnN62HZLBV7OahpRl
	G+JX3zbVm2yh6atnB/wgsxwwfHrHKPQCAsz6jjxT+b29/NYPSuDi48m6gpH6HSQ1
	HCaPgeYBAY8EQgpNcG/n3ErtwG7SHT+Hw+eR2cGgRQTOfdMcrxjUXNb6gJxcg3xT
	VqaK8Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424wgs0dkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:36:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4987a7L6024039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 07:36:07 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Oct 2024 00:36:06 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 05/11] wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
Date: Tue, 8 Oct 2024 15:35:28 +0800
Message-ID: <20241008073534.1195-6-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241008073534.1195-1-quic_kangyang@quicinc.com>
References: <20241008073534.1195-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: hakNkFlCSWjLKm3yp18yURxm9BKaCgtO
X-Proofpoint-ORIG-GUID: hakNkFlCSWjLKm3yp18yURxm9BKaCgtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=822
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080048

Current struct hal_rx_phyrx_rssi_legacy_info in hal_rx.h is not matched
with hardware descriptor definition.

So update this structure and related code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 25 ++++++------------------
 drivers/net/wireless/ath/ath12k/hal_rx.h |  9 ++++++---
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 95f4507179c4..5fc78b34b1a8 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -731,33 +731,20 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 	case HAL_PHYRX_RSSI_LEGACY: {
 		struct hal_rx_phyrx_rssi_legacy_info *rssi =
 			(struct hal_rx_phyrx_rssi_legacy_info *)tlv_data;
-		u32 reception_type = 0;
-		u32 rssi_legacy_info = __le32_to_cpu(rssi->rsvd[0]);
 
 		info[0] = __le32_to_cpu(rssi->info0);
+		info[1] = __le32_to_cpu(rssi->info1);
 
 		/* TODO: Please note that the combined rssi will not be accurate
 		 * in MU case. Rssi in MU needs to be retrieved from
 		 * PHYRX_OTHER_RECEIVE_INFO TLV.
 		 */
 		ppdu_info->rssi_comb =
-			u32_get_bits(info[0],
-				     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RSSI_COMB);
-		reception_type =
-			u32_get_bits(rssi_legacy_info,
-				     HAL_RX_PHYRX_RSSI_LEGACY_INFO_RSVD1_RECEPTION);
-
-		switch (reception_type) {
-		case HAL_RECEPTION_TYPE_ULOFMDA:
-			ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_OFDMA;
-			break;
-		case HAL_RECEPTION_TYPE_ULMIMO:
-			ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
-			break;
-		default:
-			ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
-			break;
-		}
+			u32_get_bits(info[1],
+				     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB);
+
+		ppdu_info->bw = u32_get_bits(info[0],
+					     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RX_BW);
 		break;
 	}
 	case HAL_RXPCU_PPDU_END_INFO: {
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 6ab33d5f1b2a..c69df852ae69 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -441,12 +441,15 @@ enum hal_rx_ul_reception_type {
 	HAL_RECEPTION_TYPE_FRAMELESS
 };
 
-#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RSSI_COMB	GENMASK(15, 8)
-#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_RSVD1_RECEPTION   GENMASK(3, 0)
+#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RECEPTION	GENMASK(3, 0)
+#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RX_BW	GENMASK(7, 5)
+#define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB	GENMASK(15, 8)
 
 struct hal_rx_phyrx_rssi_legacy_info {
-	__le32 rsvd[35];
 	__le32 info0;
+	__le32 rsvd0[39];
+	__le32 info1;
+	__le32 rsvd1;
 } __packed;
 
 #define HAL_RX_MPDU_START_INFO0_PPDU_ID	GENMASK(31, 16)
-- 
2.34.1


