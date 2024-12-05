Return-Path: <linux-wireless+bounces-15910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B199E4BA1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 02:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807AB286390
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457D278C91;
	Thu,  5 Dec 2024 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jLo8LRBy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947E384E0A
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733360904; cv=none; b=sjUx/DyBOZym70kfouBqoe1vR36jaj0YC8O2okjp0xtAqXzwpFYNjxYIuG2ClX8TMlHmQOSikj5WOykXYrndzjcTuwZjZI2LgCtA5xskcx3bAvoEJ/wdYOIwMInhCC7rucDnAgdAdjezjg3CQ2aOVaqD4dElrMfbvaa4iWc+Tp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733360904; c=relaxed/simple;
	bh=LLySh2NQf0nVhoWCP/UbTT1wSNqdAIW9Xh5/opFc/jA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oz/Oi0kfu5GVGFkP/FaDKPxhGlxtgeN+cfQkKEKRaTklug0g9rSMSMpzYYnn/1zBCuiHFbZZ3B1wRLmDsqYc6P9TYC5Y3XZRIpyvq9LnR38PP1sTbYaMQKMT57fc/U9N/vE0REG+A/2PeDfhN/YtqYE0kNw+mfMaEx4KZQexjnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jLo8LRBy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4GUmiT031415;
	Thu, 5 Dec 2024 01:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nlOridicIQSadBz6wvX5B6TsvxBXtK6+n6R4OEhmlE8=; b=jLo8LRByD14DeX9y
	eBZG0QqvTng1vWLjcv4kli2euhJMuUAO9oLoajizyOtXIb08pCezjx4OFTLSTi2l
	m1GkGZY+vlx7zZbcWFoehm079hjM28CWxG1h2oFJz6bp23YaFPOJ1xuHIfJSdlCz
	YVnKw20A15qDrjjsAdpXSXj4ZBDJ7EwZPM9u6vKSTaXLqnZuOfIuIFp/yrXOxZ11
	3rd3SJ4HOupHJgIuf0TCHW3CCAFktQARYov8hBZyflr5YxNyzz6QlWkd0ITcngky
	UCYrDMxmmf2OsE0fFPeRWjUfR/SqvNuvHnENO3xKdcmBQa8WsnkNv8XZ6xA+F2Ku
	fQqtsA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w90wx27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 01:08:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B518I3i010086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 01:08:18 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 17:08:16 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 4/8] wifi: ath12k: Fix the misspelled of hal TLV tag HAL_PHYRX_GENERICHT_SIG
Date: Thu, 5 Dec 2024 06:37:50 +0530
Message-ID: <20241205010754.2846603-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205010754.2846603-1-quic_periyasa@quicinc.com>
References: <20241205010754.2846603-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dVew5Wht9ity-dLu_KqCpGsD_nbRGLgN
X-Proofpoint-GUID: dVew5Wht9ity-dLu_KqCpGsD_nbRGLgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=904 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050006

There is "HAL_PHYRX_GENERICHT_SIG" misspelled as
"HAL_PHYRX_GENERIC_EHT_SIG" in the comments. Fix the spelling.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal_desc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index a460d432288f..51c145ea8161 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -522,7 +522,7 @@ enum hal_tlv_tag {
 	HAL_PHYRXHT_SIG_USR_SU					= 468 /* 0x1d4 */,
 	HAL_PHYRXHT_SIG_USR_MU_MIMO				= 469 /* 0x1d5 */,
 	HAL_PHYRX_GENERIC_U_SIG					= 470 /* 0x1d6 */,
-	HAL_PHYRX_GENERICHT_SIG					= 471 /* 0x1d7 */,
+	HAL_PHYRX_GENERIC_EHT_SIG				= 471 /* 0x1d7 */,
 	HAL_OVERWRITE_RESP_START				= 472 /* 0x1d8 */,
 	HAL_OVERWRITE_RESP_PREAMBLE_INFO			= 473 /* 0x1d9 */,
 	HAL_OVERWRITE_RESP_FRAME_INFO				= 474 /* 0x1da */,
-- 
2.34.1


