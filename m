Return-Path: <linux-wireless+bounces-7723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F718C6F68
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 02:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F07B21095
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A9C64A;
	Thu, 16 May 2024 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="id6jHrXC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72F15C3
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715818114; cv=none; b=McP4Xpc0ELZ9aVkZ21HU6xUC8LKTQXOFrKGqOJvaHmdWjWS/QCseiEzFBPtABW11asq6Kob/jau5DxsbQ0DkCs6vvoY7mJwF8FPVqYhQJk/7P4qZkICbQTcdOi4U+fifkj/9iKdKLfs3x0bg9QGil24pjgDzgX01aZ+H+7TIL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715818114; c=relaxed/simple;
	bh=UpSJ1Uaqo+ukdg0sIBvLHB4LgHH+e39Arl2vp43jAFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+D1bhVBGNEryGQnlhYyw1BcPSKkq7VLJlNAcN+jzSaT0IT+y/O7471bKF2vSMBR0qM5zb1qOJJB6/fWaVOL8mR16YQ2Q9VDSGUF/SWw45q9LfR48mInoMDy7Dh4QXHfJZCBh79z7jVDSGaA/0egkzVo8OTPzAez/DyPX/2R6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=id6jHrXC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FKx63Y024796;
	Thu, 16 May 2024 00:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=pifyNKyCHXAxFxG2r1DdmMPldPHSkFi1rkPwU17WBMY=; b=id
	6jHrXCfGF+HHPAwkQtSgBeOO3X5PYLkbBcN3y5uNAcTliKQnMTHStvVaTqyhggvi
	2v20ZH/yov/NkFaNzupuL4bJHfPeDq8JaY++xlqQkoZQ2Z+EVYSs+5mu2H4MVtOW
	8HVdXuveDb0S3GMvqaqtFR6BMcZlL5EamJ0e4IITvZVeJD49WzGD5dDOsgh4dV9P
	e/ux7vlyJ9pHqT1EcI/nkkby793jI1DasHTTOlzgASu8NnFUcU+aqKBy2sZoHNfn
	yGLATl93nK+UVoaU7WcSPRFWS/JnFei8Ojdek5IQrRdWz49avjRt7GZCvwqMqDML
	De6drnjtwlm8/6rVg2rw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y49gdusmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 00:08:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44G08T6I016882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 00:08:29 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 17:08:27 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: improve the rx descriptor error information
Date: Thu, 16 May 2024 05:38:07 +0530
Message-ID: <20240516000807.1704913-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516000807.1704913-1-quic_periyasa@quicinc.com>
References: <20240516000807.1704913-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: EjCX0DMVvErPpx058C3ymXgy7g53zwtq
X-Proofpoint-ORIG-GUID: EjCX0DMVvErPpx058C3ymXgy7g53zwtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_14,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=245
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150171

The ath12k_dp_get_rx_desc() failure log currently contains the same
information across multiple Rx data paths and lacks sufficient detail for
debugging purposes. To address this, change the ath12k_dp_get_rx_desc()
failure log to include cookie information along with Rx path details.
This will provide more specific data for debugging purposes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 37205e894afe..85ce6e840efa 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2625,7 +2625,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		if (!desc_info) {
 			desc_info = ath12k_dp_get_rx_desc(ab, cookie);
 			if (!desc_info) {
-				ath12k_warn(ab, "Invalid cookie in manual desc retrieval");
+				ath12k_warn(ab, "Rx, invalid cookie 0x%x\n", cookie);
 				continue;
 			}
 		}
@@ -3323,7 +3323,7 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 	if (!desc_info) {
 		desc_info = ath12k_dp_get_rx_desc(ab, cookie);
 		if (!desc_info) {
-			ath12k_warn(ab, "Invalid cookie in manual desc retrieval");
+			ath12k_warn(ab, "Rx Exception, invalid cookie 0x%x\n", cookie);
 			return -EINVAL;
 		}
 	}
@@ -3742,7 +3742,8 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		if (!desc_info) {
 			desc_info = ath12k_dp_get_rx_desc(ab, err_info.cookie);
 			if (!desc_info) {
-				ath12k_warn(ab, "Invalid cookie in manual desc retrieval");
+				ath12k_warn(ab, "WBM Rx err, invalid cookie 0x%x\n",
+					    err_info.cookie);
 				continue;
 			}
 		}
-- 
2.34.1


