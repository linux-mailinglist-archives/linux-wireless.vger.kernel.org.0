Return-Path: <linux-wireless+bounces-23842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03219AD177B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 05:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10FF16A8F7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 03:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C574E1E0DE2;
	Mon,  9 Jun 2025 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KbOTC8LR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277927FD49;
	Mon,  9 Jun 2025 03:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749439154; cv=none; b=s4qgG8sOuRXO/xOZk/wVZwyJ/TFrhzal/F3Rng4uQhXByXSJ/yz00aNPUguBE+Ci5lHG4gAnbcF5SGEk4Jf0dTpZw1H6EB2L/q7rWUjm5BsX9+ynASdUhdNBvPSP86Aw/XudbN6NJlma11MLKHx3+Q0idNj9wQ+6eedxKEDy0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749439154; c=relaxed/simple;
	bh=ZAsRHojzJMNFzoua3WF1+EIxkEZsc5RalZrhUXdjU10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qLDL7VPl5yCg6c5DQ41zX7Q/FAJnGTIlaSds+drAonmL4xS84K8eMmMMKManPxKdamcnE+e/U7kpvd8WLW3ylf5E+OzA1AAQsgFXdgK7FSpJT23fPDB03G9pLmAiuSk/z/2X8QD+2reA2wZeLxD8JCF3rAXyW0F4Y9dpW646scc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KbOTC8LR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5590KufS021751;
	Mon, 9 Jun 2025 03:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=neOOCqGuLWm+KVMj7rLo1y
	mhr1KTJeRa+0cIY4vP5BM=; b=KbOTC8LR1in63GNV1PE6PuMJm8DnJQxajy3Wfs
	85021XjRjYn6BuMk0S2gPXFLxvfe0SQY/2GDbfONadjpPA2XQBXNclV1+TdXawRx
	PzfKk0Cb4bqOJrBGZHLQll0PGHm4idWF3fvJoZWeyJlazowcN8TEKQcFAZPiTqgr
	ME19MOlwJn8aL5H7i8YS++MQJIxyjYqyHqCAl4R1NTvoEXyb/gYKdFwFw8BM4xia
	1sK8DP8cADpJ4Od/LCblLauBCUdiu1HXS1VaGj+71+vRey0lJMrYJElVMjBhYpJY
	Dyp+vZNtRgaXNCDn54x+u/XrTVeF1nQatjPCfv0vCcKI1Zng==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ce9msm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 03:19:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5593J3ef001703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Jun 2025 03:19:03 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 8 Jun 2025 20:19:02 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Mon, 9 Jun 2025 08:48:50 +0530
Subject: [PATCH ath-next] wifi: ath12k: Enable REO queue lookup table
 feature on QCN9274 hw2.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250609-qcn9274-reoq-v1-1-a92c91abc9b9@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJlSRmgC/x3MTQqAIBBA4avErBsw6ce6SrSQccrZWGlEIN09a
 fkt3suQOAonmKoMkW9JsoeCpq6AvA0bo7hi0Ep3qlcGTwqjHlqMvJ9orCXqjGPqHZTkiLzK8+9
 msJfHwM8Fy/t+qcuY5GgAAAA=
X-Change-ID: 20250608-qcn9274-reoq-8aacc58dec6d
To: Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZFVp4cVxJoe8kjoAmgQnCOcc9zRRrPjw
X-Authority-Analysis: v=2.4 cv=drjbC0g4 c=1 sm=1 tr=0 ts=684652a8 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=R5ACGwntwPhpxkBjR5gA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ZFVp4cVxJoe8kjoAmgQnCOcc9zRRrPjw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDAyNSBTYWx0ZWRfX7R08xUlgmpFY
 R2PHskYKGsnbNcZEThYW053RnpAMD//PFRT/8ZZVBRgC25cJFmpDatuRZS27ZFBFroTNLgiAvoE
 aUrluURN2D/hYPyiLaKsk3p7tblHPuHiLJAQkAslKDnRKPDz33ktRxrxnopRcBT0+tKLVsdH8Gb
 pDS0c4K7EUl0JeOwNJ7DIuLmrE2zHdBzFfem5eex7dhHv3+WW47o8UfIy7aXuXpD/aINU4K6zOJ
 DIQsOFDVXBQg6QUTKfgaQtvbqVMljrg1MpsHLB7VMycOAKoD4UxVrzk/C16w/1Z6+rcyQRgGD78
 08TYb9mEigbHS/bYI768kf/Yb7zw0/NcLYyhoQx7kQ3gz9ZR5cikL/dApW2wJa3VbgEUXXdxv5e
 7Ql7PWkZ0qq39EEXd/Rg7jb9qtQQDcO+QM1pyDf0MUAJZUUey0tvcLO4qWen+n5i6c55ZnUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_01,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=926 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090025

The commit 89ac53e96217 ("wifi: ath12k: Enable REO queue lookup table
feature on QCN9274") originally intended to enable the reoq_lut_support
hardware parameter flag for both QCN9274 hw1.0 and hw2.0. However,
it enabled it only for QCN9274 hw1.0.

Hence, enable REO queue lookup table feature on QCN9274 hw2.0.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 8254dc10b53bbfb54a44c7ff2f705c72461d1031..ec77ad498b33a20bc92e30e52257be70cc406d36 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1478,7 +1478,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.download_calib = true,
 		.supports_suspend = false,
 		.tcl_ring_retry = true,
-		.reoq_lut_support = false,
+		.reoq_lut_support = true,
 		.supports_shadow_regs = false,
 
 		.num_tcl_banks = 48,

---
base-commit: 9f92c4a01c5268f57fa19dd7cbcb1f59b0e66da6
change-id: 20250608-qcn9274-reoq-8aacc58dec6d


