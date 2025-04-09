Return-Path: <linux-wireless+bounces-21291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE931A81AF1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 04:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB711B66128
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 02:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D41BD01D;
	Wed,  9 Apr 2025 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dnNFLZVF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88811ADC94;
	Wed,  9 Apr 2025 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165646; cv=none; b=FNraZuS8nw+J4AF4ta+FjKhv+XsP6nxV4pfJBv9Thf7OTgCIWWka3i3xYHu6hltqm1qxbXQIXFwimzHMvl96uwoEJrL861YYoY1JQjieM/qiBgcZQKJFeVWM/7vrsA5yyWFLmzFasmJpyKaxgA3siJhe+BjNJk6rdMWnxI7c39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165646; c=relaxed/simple;
	bh=cykj4yQASsTHIhqbB303hh4XZz4afESBUGwGeNwsjq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MRr2DsU7itGrMhUs8kxl+njduLAqN+5bK57JhWaag3jdzmUMUvgu2Vgu7Ez1w8ybOYrVIdAf7aimFqxl+6mICI95aBe+lgrqkFPMxy9rYgP8qo5k73yU89xbsfAlK4Q4vKGYxVmpPV6QUYCRHDfMhsWPFPprRCJzspJlc9hXxMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dnNFLZVF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYumA029085;
	Wed, 9 Apr 2025 02:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xZfNp9/5BVM5+PAuNHdGYmp/rTl5YlyBbXMm9ePdBas=; b=dnNFLZVFYmEIwPDe
	ylb+umNutffzj7ZoET33q42rdNlb1xzDxlrplNl7EF8AGpKpU6bKu1Vdv3aG6IrM
	zTbZwvX7vR7BFiEGE/4dC3Vb99f+UL72PlsKrh25S55nA1drFzdsg2D8j/uEAuTI
	WllMdzzxuww1x8hb82m1wPJ5MV2NWVB/t6RU59phuBfcFD8ErF5kJ4p3phmT+3cA
	vZMdWWz9p8Bw+Nyeye2ZdpLObGORM6DAoE7SZCOQPTxdw8xZiXi0T/VR0kg5L9Na
	IayUsLMozzHVjsoqX72AGkKFiYsZ2olv+8VQiCHiVZLfmLfgkzn2NL5ewmsZK9Ws
	J2TFqA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpm9qnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 02:27:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5392RGbv015402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 02:27:16 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 19:27:15 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 9 Apr 2025 10:26:36 +0800
Subject: [PATCH ath-next v2 3/9] wifi: ath12k: support MLO as well if
 single_chip_mlo_support flag is set
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250409-ath12k-wcn7850-mlo-support-v2-3-3801132ca2c3@quicinc.com>
References: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
In-Reply-To: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JycNwMgmR4guArFMcHberelBEMyeUYJ3
X-Proofpoint-ORIG-GUID: JycNwMgmR4guArFMcHberelBEMyeUYJ3
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f5db05 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=-1g4LLEghsqRnekGNmIA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=701 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090002

Currently firmware MLO capability is validated via firmware IE, however
WCN7850 firmware does not support this method but instead advertises
MLO by single_chip_mlo_support bit in QMI phy capability message.

Change to consider single_chip_mlo_support bit as well for MLO capability
validation.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 21 ++++++++++-----------
 drivers/net/wireless/ath/ath12k/core.h |  3 +++
 drivers/net/wireless/ath/ath12k/qmi.c  |  6 +++++-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index d8c9b666598540783e6abe3927ab4524d0a6fcbd..d2f92eed6971c6c35ee2f0e644c51fce3d073e30 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1959,20 +1959,18 @@ void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag)
 
 	lockdep_assert_held(&ag->mutex);
 
-	/* If more than one devices are grouped, then inter MLO
-	 * functionality can work still independent of whether internally
-	 * each device supports single_chip_mlo or not.
-	 * Only when there is one device, then disable for WCN chipsets
-	 * till the required driver implementation is in place.
-	 */
 	if (ag->num_devices == 1) {
 		ab = ag->ab[0];
-
-		/* WCN chipsets does not advertise in firmware features
-		 * hence skip checking
-		 */
-		if (ab->hw_params->def_num_link)
+		/* QCN9274 firmware uses firmware IE for MLO advertisement */
+		if (ab->fw.fw_features_valid) {
+			ag->mlo_capable =
+				ath12k_fw_feature_supported(ab, ATH12K_FW_FEATURE_MLO);
 			return;
+		}
+
+		/* while WCN7850 firmware uses QMI single_chip_mlo_support bit */
+		ag->mlo_capable = ab->single_chip_mlo_support;
+		return;
 	}
 
 	ag->mlo_capable = true;
@@ -2092,6 +2090,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	ab->dev = dev;
 	ab->hif.bus = bus;
 	ab->qmi.num_radios = U8_MAX;
+	ab->single_chip_mlo_support = false;
 
 	/* Device index used to identify the devices in a group.
 	 *
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index eebfb20cb089db0ce126ecf7f658bb15861d38c0..fa8c3f9ab7a92f17f83b3378bc00aa884bc6bdcf 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1123,6 +1123,9 @@ struct ath12k_base {
 	enum ath12k_firmware_mode fw_mode;
 	struct ath12k_ftm_event_obj ftm_event_obj;
 
+	/* Denote whether MLO is possible within the device */
+	bool single_chip_mlo_support;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7df6c6eebed6855ab42519610962d2b21825d9ec..9d360ea3ba973d6d8231a08780b19a66aef20178 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2268,6 +2268,9 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 		goto out;
 	}
 
+	if (resp.single_chip_mlo_support_valid && resp.single_chip_mlo_support)
+		ab->single_chip_mlo_support = true;
+
 	if (!resp.num_phy_valid) {
 		ret = -ENODATA;
 		goto out;
@@ -2276,7 +2279,8 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 	ab->qmi.num_radios = resp.num_phy;
 
 	ath12k_dbg(ab, ATH12K_DBG_QMI,
-		   "phy capability resp valid %d num_phy %d valid %d board_id %d\n",
+		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
+		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
 		   resp.num_phy_valid, resp.num_phy,
 		   resp.board_id_valid, resp.board_id);
 

-- 
2.25.1


