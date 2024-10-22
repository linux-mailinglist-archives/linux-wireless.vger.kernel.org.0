Return-Path: <linux-wireless+bounces-14315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0006E9AA0DC
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 13:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881D2B225F2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D019C57D;
	Tue, 22 Oct 2024 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SzPn5cxh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523A19C543
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595344; cv=none; b=VLSstzEsNQV3qPV76VillDxjbHh95IgigNxY+KL+oYPnqF/suXCzfqyKFkzTQawuJWcccce3nL5Ux2r4O4DiRUZoy3yIaR0a63U5RDHpMJbr8McOj4UTNeaTHP9VhGygT4hTNBIWD8eKGdjuiYiLSFFLxFGoblYxrHDiB8TmixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595344; c=relaxed/simple;
	bh=KGvHiBGRbbJUmpX64hxqzX5CalzWNl+MJwqNhzWNRbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aliXgbWayG36ulMx3ua+I6y0ZcvKnmeyiU807Vi80R0bTyjQYpmlZsAewKb4LTFCeOC/Hfh/AZCnKwOINURtA5ITpRRFG7BJ4ljT+RR615vRMqAFbJSGqIme6jXRXKH1Vl3P4V64+/w9oiKi7tFvmpSnOpZn9/21Nbf2TtVZBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SzPn5cxh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M7Xr6d014285;
	Tue, 22 Oct 2024 11:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	12VuinFdU73hhBk0vPbc0W+WTT3AgG79uCMYa1VeM0M=; b=SzPn5cxhSBee6Ull
	s14RzII34elgM2QBBXQGgMIL5Vx5iKkT24pTA/jPn7dujTn9ShMLcTGard6fBCZP
	s+JkJy2/ukFoPVC1/au1bAha1Krmu+gyT14HPSDaDGPT/ktE5xpvZFa8Kfql00wQ
	BN7Pl0uYCdceuL6PpgZj7PxZWuArG9kVLPIUmoZqMDolbRTRCYbH8ZxiLATZO4fZ
	dtoxYVTZ3XPuCKj/4lLkv5GQl453JlezT8tOjdJ/6nUVR+PDQXs+WHdGqCDDBsie
	BLTP9FJrJISn2HtBIwVQRKQhLrXw6QhtGZwEqTI5xhpDY07557jeenyGVfp9PA9T
	WaF+Mg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd45wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:08:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MB8wiN010603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:08:58 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 04:08:57 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 4/8] wifi: ath12k: fix struct hal_rx_phyrx_rssi_legacy_info
Date: Tue, 22 Oct 2024 19:08:27 +0800
Message-ID: <20241022110831.974-5-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241022110831.974-1-quic_kangyang@quicinc.com>
References: <20241022110831.974-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: HmDgpztetb8WBpccWtgtkEFK4iygwfpq
X-Proofpoint-GUID: HmDgpztetb8WBpccWtgtkEFK4iygwfpq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=818
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410220071

Current struct hal_rx_phyrx_rssi_legacy_info in hal_rx.h is not matched
with hardware descriptor definition. This hardware descriptor definition
is determined by hardware. Host shall follow it.

So update struct hal_rx_phyrx_rssi_legacy_info and related code.

Both QCN9274 and WCN7850 need this modification.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 25 ++++++------------------
 drivers/net/wireless/ath/ath12k/hal_rx.h |  9 ++++++---
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f3df6365a27e..3cea1e113d4b 100644
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


