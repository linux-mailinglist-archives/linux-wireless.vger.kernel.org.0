Return-Path: <linux-wireless+bounces-27914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAAFBC8B74
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0E23B40C9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5772E0B44;
	Thu,  9 Oct 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FYvfhA0v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB3C2E092B
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008289; cv=none; b=L9SJXVK0fNtLmjR5Om7RGt4a43ddPsMwjr/Cijxtt+vvIgSsBpqJWVZ/OuG4kfk+2uJv08vIhUTauF3extabE148P+Ztlvn2jZ1WrCJFZB0yh+HFWImB49rdhAj0YA/9oI0zJNIp/SdbA3LW+oihFCWvwp0oTz/h9+a1nTXMbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008289; c=relaxed/simple;
	bh=EifCfcJwFZju4LBN56NAJXfN1IU+WWbMqUppyEI4A60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLtpOd4/p0MF3Wm4E59BRIgBYxQZlO2NrGesN97/tnYSgKxb55Bi2vCBSi6eqt5GnrBxnSXyI9fNpj78lB9zi+rYBmH95wjTRXYTOewtH81BHqFk+GyPtmac6nZdNVv0OYmLoqkWYT2HSC3/cp07wuv/XfbLwMeVVhVb61EHmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FYvfhA0v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996Ehp8005247;
	Thu, 9 Oct 2025 11:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5v1BdVc70EuS3nbXGGw3DoMZx68JERKWH9bFPzfDXY=; b=FYvfhA0vTX7YqYzx
	Fk+KbOwdxvkvnzhaawjvZvx1e2dOhW9FqnLeOWzSfSqRbxn7rWMNemGVFpowngr3
	W/NNhZRfSoowp/GAqO9/xusVpGFeCBosjuQHGQD7tl6kFMuZWzTK2zZM7mS6h2y3
	pa40S/FFmIMLdsa6nLt80rEMugcGp58Psl677m4OGmq9wcIVmZrXMwKzTQkRu4Kc
	IYGGXhWAyP/+MILDK6MylUy+6aEa1k63egPJPebZecBgcLa8LC53CnuLEbl6LJ7v
	dgElrpSg6yeoodis1mc0oIUNx6EDsQVF+zjbvnCV0lTQja/lQmkNY/Di+PpT2+1Q
	gh4vxg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j2h4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBPsd011662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:25 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:24 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 16/18] wifi: ath12k: Remove the unused ring inits in wcn
Date: Thu, 9 Oct 2025 16:40:43 +0530
Message-ID: <20251009111045.1763001-17-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nfQexHjVOVghHgSuZ_sj8z34ICYYikcx
X-Proofpoint-ORIG-GUID: nfQexHjVOVghHgSuZ_sj8z34ICYYikcx
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e7985d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=S4Rt_psGJdqvLXfSAgIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1mu2r+pLnm7+
 PdMyUTaA2sPrWQflyYbFkNx2131OLGZ/lndCjmwi+Xud/UTw6E6xbVxodj/9ChkPlDUkPt4VbGp
 v5+q161mM8OAJMw3chxG42Py4njOpAY3TIs9afbO3LjX1xWO2MxUuxUj9rmBjWocyGe+m7dQB4+
 D+sEq9KFC9yPS6OS2q7DUEUBpGX9CL054Yw+2x4MWWv9G2UfBA+D0t/kTZ+McAVffa46qMli0AT
 m16rUZ+103XhvaZbgXfy0t+HXTCT9OnYsLKwMcddnVUamMw4bfvmJlIwcSUODEruN5KblTlhK0A
 +nRnt8V2ES4cBfQIcT9QNLwC0/ffBwRVDtRnm7I1/yAUO+5YF4+TerF0Cjr2zbMRJtiWJrwwDLJ
 oQmCVFUyaiLavOdLlY3wRxYXAvap2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Remove the initialization for the following rings in wcn as these rings
are not used for wcn chips.

HAL_RXDMA_MONITOR_BUF
HAL_PPE2TCL
HAL_PPE_RELEASE
HAL_TX_MONITOR_BUF
HAL_RXDMA_MONITOR_DST
HAL_TX_MONITOR_DST

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   | 54 +++----------------
 1 file changed, 6 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 233350ccd06e..8151c216a5e1 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -146,14 +146,7 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 		.ring_dir = HAL_SRNG_DIR_DST,
 		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
 	},
-	[HAL_RXDMA_MONITOR_BUF] = {
-		.start_ring_id = HAL_SRNG_SW2RXMON_BUF0,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_mon_buf_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	},
+	[HAL_RXDMA_MONITOR_BUF] = {},
 	[HAL_RXDMA_MONITOR_STATUS] = {
 		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2RXDMA1_STATBUF,
 		.max_rings = 1,
@@ -171,46 +164,11 @@ static const struct hal_srng_config hw_srng_config_template[] = {
 		.ring_dir = HAL_SRNG_DIR_SRC,
 		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
 	},
-	[HAL_PPE2TCL] = {
-		.start_ring_id = HAL_SRNG_RING_ID_PPE2TCL1,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_tcl_entrance_from_ppe_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_SW2TCL1_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_PPE_RELEASE] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WBM_PPE_RELEASE,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_wbm_release_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_WBM2PPE_RELEASE_RING_BASE_MSB_RING_SIZE,
-	},
-	[HAL_TX_MONITOR_BUF] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2TXMON_BUF0,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_mon_buf_ring) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_SRC,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	},
-	[HAL_RXDMA_MONITOR_DST] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_SW2RXMON_BUF0,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_mon_dest_desc) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	},
-	[HAL_TX_MONITOR_DST] = {
-		.start_ring_id = HAL_SRNG_RING_ID_WMAC1_TXMON2SW0_BUF0,
-		.max_rings = 1,
-		.entry_size = sizeof(struct hal_mon_dest_desc) >> 2,
-		.mac_type = ATH12K_HAL_SRNG_PMAC,
-		.ring_dir = HAL_SRNG_DIR_DST,
-		.max_size = HAL_RXDMA_RING_MAX_SIZE_BE,
-	}
+	[HAL_PPE2TCL] = {},
+	[HAL_PPE_RELEASE] = {},
+	[HAL_TX_MONITOR_BUF] = {},
+	[HAL_RXDMA_MONITOR_DST] = {},
+	[HAL_TX_MONITOR_DST] = {}
 };
 
 const struct ath12k_hw_regs wcn7850_regs = {
-- 
2.34.1


