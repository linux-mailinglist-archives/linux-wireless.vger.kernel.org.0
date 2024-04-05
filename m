Return-Path: <linux-wireless+bounces-5911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A6989A010
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2302871DB
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B2A16F282;
	Fri,  5 Apr 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kQ9NoWZL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799DF16EC00
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328351; cv=none; b=HMu7NoX0Fez1pNcd7QPXj4A1exuyr/BYhnNuiGV2ohzkpHleUkbjAEHf5HFH2V00QIk03NMFFv1EIqqvvAhcrTY2OmIx+RyOtHON0+zk1El7qHRNQNb5Mb+JdvQY0U1J2hAj9gslkZlEHT6MPWSmnoISdF1JdBwYpQNEOlgHteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328351; c=relaxed/simple;
	bh=cGI1cto5rWPj8Xf0qQA+Fiorvd/RGoANjMv7xEzsDj8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r8wrX8DfWFf8qVbuQYDxiRQowpS1d3JvSDjnvUtoRohwSorQHnUkzV8xPp55Z+/+DqmVj/gSbLV15S3hQQWdvXqWqSKrez/A6u8gferc4yIVIVfvoFLpC3J5qko9Y8w9fF63sQ/cNhoyu0hn/nBVn8S4cPVr3LxISOt9iv5RJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kQ9NoWZL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435EPv2E001886;
	Fri, 5 Apr 2024 14:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=aZlslQX
	rDPyewXcVyQPH1dwdKfvA81aXwKxg88r+nIE=; b=kQ9NoWZLzXTQVFgN0/mFw61
	x9UW3TdjVS8v+CKkEVMeXHusA/R+/YzR4YZ50O2GZcqFLf7t3rt5nX8pQkxgHEWd
	06Fn8hjP1Lf/9DcZpy1DLsCJjI3xx5T5EdqtnyXWcK05EUaTvbg/glfkkEHwYGBd
	n96Dg9eipJuzSQMB4/JB88I+igK366V45GY3prxRSjVbz6zwxhttYMcT5u1po2hP
	MUoDl9OMAOZ8ruI5HpbvVLXbsL9vF8huXRn08nSePivmWCE0WiVGmc8Wk2nqpyv1
	P/WB0TiUiTP1FKXEMNgjpnpbNtR96bkG+AK7N2eVi/ykX6uoBAq7k3hatzIqzzg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7m5hg99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 14:45:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435EjdVR002480
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 14:45:39 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 07:45:38 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH] wifi: ath12k: correct the capital word typo
Date: Fri, 5 Apr 2024 20:15:24 +0530
Message-ID: <20240405144524.1157122-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: vxJ0WVjnF8Rb37Ge1EwQPXd3m7MMjeQa
X-Proofpoint-GUID: vxJ0WVjnF8Rb37Ge1EwQPXd3m7MMjeQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_14,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxlogscore=808 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404050105

Rename the "ATH12k" word to "ATH12K" for consistent capitalization in the
word.

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 4 ++--
 drivers/net/wireless/ath/ath12k/dp.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 1006eef8ff0c..a0aa8c571867 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1347,7 +1347,7 @@ struct ath12k_rx_desc_info *ath12k_dp_get_rx_desc(struct ath12k_base *ab,
 	u16 ppt_idx, spt_idx;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
-	spt_idx = u32_get_bits(cookie, ATH12k_DP_CC_COOKIE_SPT);
+	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
 
 	if (ppt_idx > ATH12K_NUM_RX_SPT_PAGES ||
 	    spt_idx > ATH12K_MAX_SPT_ENTRIES)
@@ -1365,7 +1365,7 @@ struct ath12k_tx_desc_info *ath12k_dp_get_tx_desc(struct ath12k_base *ab,
 	u16 ppt_idx, spt_idx;
 
 	ppt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_PPT);
-	spt_idx = u32_get_bits(cookie, ATH12k_DP_CC_COOKIE_SPT);
+	spt_idx = u32_get_bits(cookie, ATH12K_DP_CC_COOKIE_SPT);
 
 	if (ppt_idx < ATH12K_NUM_RX_SPT_PAGES ||
 	    ppt_idx > ab->dp.num_spt_pages ||
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 443e6af619ef..4939aa41dd87 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -245,7 +245,7 @@ struct ath12k_pdev_dp {
 #define ATH12K_CC_SPT_MSB 8
 #define ATH12K_CC_PPT_MSB 19
 #define ATH12K_CC_PPT_SHIFT 9
-#define ATH12k_DP_CC_COOKIE_SPT	GENMASK(8, 0)
+#define ATH12K_DP_CC_COOKIE_SPT	GENMASK(8, 0)
 #define ATH12K_DP_CC_COOKIE_PPT	GENMASK(19, 9)
 
 #define DP_REO_QREF_NUM		GENMASK(31, 16)

base-commit: 4abf087939abe82a32e3cff8a8e48e6fd7d1e907
-- 
2.34.1


