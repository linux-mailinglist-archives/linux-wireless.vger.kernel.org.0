Return-Path: <linux-wireless+bounces-16455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981029F47FF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 10:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911967A3CD0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C05A1D95BE;
	Tue, 17 Dec 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L2w1spie"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE51D934D
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429085; cv=none; b=I0S3nkdX5T3tNr8Az5Que1pUwHqBWmH1ncICkF64pd23IUE7AWTdkyS3XDUUQmj5MsDJzErA2jMYQejcKxHqz6laplaRG21Iie+DIrlU+NBqECLSzwyuIk1LCe2PIpX3L5jj8VsFBybD3L070atJR4Wbq1Z83cZ4lOpzCoJiK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429085; c=relaxed/simple;
	bh=D02xpGrxrj8onGyov/uQR70LIodNYeJlJudde5y1ViQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QCW84pReSQ3Fkt4OZ6548uJkfO0HF7/UjK/xjjdQQkZ26GS/TaO7IN5PYVa4iqqgZ1OoMNGSNAauw3dRyQ/L0v4ySAusfJOEceEyW/Sm0el8qIuEl4EKADZZrbIvZJsCVwHxaKLtfrxpB3s3AOxiTFGJSwbw9aTYubG2+P6FsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L2w1spie; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH82RAa002824;
	Tue, 17 Dec 2024 09:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CSMKATEnJDEq+oGOoz53hR
	SKx54/2Cc0PKj6ZT+MT7E=; b=L2w1spie2OmPsbbSwKAqxTinNo2PS8tLqZFNLv
	AeJ3Jf+Ph0dmzqc/V4DxrDedsiZ9hxACg0opMPd1NFIF7S4yjZv6XB/HWrWTPSjS
	Py2btRXjN6Rl97YNht5+Hir8v/pwZ0dxlAu+wzmVJ/SpvmHjitgeysTnD17GOgbC
	X1ahDy9nZmeWQtkrOq96EVsABjoDOOUYeHHs4aegqaClLKEtal+8pJ6MvsfvW/LR
	8l/ZDiN1yKrMXw5TL6u/aZsl4mgAUmB8vUKFz+cGFiZpFRJLn4jIZ63dtYR4Bq4q
	bdI595jibjAAjMmn8pqdL9Wss5cx+NyecTLh/5++wH/atd8g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k5ek09sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 09:51:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH9pLNj020421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 09:51:21 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 01:51:19 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: Add support for parsing 64-bit TLVs
Date: Tue, 17 Dec 2024 15:20:58 +0530
Message-ID: <20241217095058.2725755-1-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: 3QHy-VFDk_cSNGt3Tf9o-5OI0LLAVmGo
X-Proofpoint-ORIG-GUID: 3QHy-VFDk_cSNGt3Tf9o-5OI0LLAVmGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170081

There is mismatch between the format of monitor destination TLVs received
and the expected format by the current implementation. The received TLVs
are in 64-bit format, while the implementation is designed to handle
32-bit TLVs. This leads to incorrect parsing. Fix it by adding support
for parsing 64-bit TLVs.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
v2:
	- Updated Tested-on tag for WCN7850.
	- Rebased to the TOT.
---
 drivers/net/wireless/ath/ath12k/dp_mon.c   | 14 +++++++-------
 drivers/net/wireless/ath/ath12k/hal_desc.h |  2 ++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 2d53404095d6..c6cc4a1a5230 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1205,19 +1205,19 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k_base *ab, struct ath12k_mon_data *pmon
 			    struct sk_buff *skb)
 {
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	struct hal_tlv_hdr *tlv;
+	struct hal_tlv_64_hdr *tlv;
 	enum hal_rx_mon_status hal_status;
-	u32 tlv_userid = 0;
+	u32 tlv_userid;
 	u16 tlv_tag, tlv_len;
 	u8 *ptr = skb->data;
 
 	memset(ppdu_info, 0, sizeof(struct hal_rx_mon_ppdu_info));
 
 	do {
-		tlv = (struct hal_tlv_hdr *)ptr;
-		tlv_tag = le32_get_bits(tlv->tl, HAL_TLV_HDR_TAG);
-		tlv_len = le32_get_bits(tlv->tl, HAL_TLV_HDR_LEN);
-		tlv_userid = le32_get_bits(tlv->tl, HAL_TLV_USR_ID);
+		tlv = (struct hal_tlv_64_hdr *)ptr;
+		tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
+		tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
+		tlv_userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
 		ptr += sizeof(*tlv);
 
 		/* The actual length of PPDU_END is the combined length of many PHY
@@ -1232,7 +1232,7 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k_base *ab, struct ath12k_mon_data *pmon
 		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ab, pmon,
 							       tlv_tag, ptr, tlv_userid);
 		ptr += tlv_len;
-		ptr = PTR_ALIGN(ptr, HAL_TLV_ALIGN);
+		ptr = PTR_ALIGN(ptr, HAL_TLV_64_ALIGN);
 
 		if ((ptr - skb->data) >= DP_RX_BUFFER_SIZE)
 			break;
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index a460d432288f..b90a6da72e29 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -579,6 +579,8 @@ struct hal_tlv_hdr {
 
 #define HAL_TLV_64_HDR_TAG		GENMASK(9, 1)
 #define HAL_TLV_64_HDR_LEN		GENMASK(21, 10)
+#define HAL_TLV_64_USR_ID		GENMASK(31, 26)
+#define HAL_TLV_64_ALIGN		8
 
 struct hal_tlv_64_hdr {
 	__le64 tl;

base-commit: 9a448415ed0c46edeb9170091a03b620986ca0b2
-- 
2.34.1


