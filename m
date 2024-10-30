Return-Path: <linux-wireless+bounces-14731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EBC9B622B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 12:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3362CB223AB
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 11:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DBA1E47CE;
	Wed, 30 Oct 2024 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mTzSNZ29"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CA199223
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288803; cv=none; b=L3zL1rkb/z7BExPnBG0BBfBNo/kIg8vcQT7gDpR8Qz3J+/Ug/e5KWlJ7p4d6nSeRQDfq70rGJjdmkRP71vLG+NriAhLypxxGVkSsvTIQs6XcxRb3rFDUB07OaKL+3xS1LF6x3OvQ0ZN+sEQ/uIDVm+kE93IQV8IlUOsEBEEj/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288803; c=relaxed/simple;
	bh=3ZHO6Epsvpeg4ofz6dZY/vGnvXazKf85NAzDadLa60w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E6T/Purq7r/NzO45Fw8YVZ0ZsZXqs2tYLx8HSvQYycGw0fK5rt+SwrXJnbMsdQnY6xGKPx6p4lPig+rhGkoUW4uUKZ2jnek9xZE6UtFIMJ4lQ1n5LgKkwnpHPSdYvmrjWb9fSF2v4Asg4mUKA5FSeycLerLBGFXRL0oH/VCod7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mTzSNZ29; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U90pWx017964;
	Wed, 30 Oct 2024 11:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JFhnX9S46RIZBGUfFUIlb49bWJSRoCWYTVP
	UJ8avtN4=; b=mTzSNZ29rKRZdaGHrgGe3dbiiHJTbjP5nrnmkpjWyy50fJ5S83o
	qxPYjeoVOAub8xLP427CcZyni8MZfHVOX/dLUDUoT/1K2DIwUHJNEHofWjrN4Jub
	H+swv9ka3MuRSGpazmm1Kxk2IMV8XPlJoosh3ED+4X5R/y95YAL+wtZA1CeuZCUp
	3dCq8BYZ87QEz8cbmbKBLjrJbQpU49fQFGPAiFYprM5/EBOPLDNQnZMcyytTwBR3
	9oheHyd7B+cwcHnCuOVsf2TUC4zXsh0FYAIRI1UrO0GOZIWSDrir9PXul3uPvSjg
	hEQu2VObhNrwUKlE1gx1TedQs/gwo8lRLvQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grn53w9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 11:46:36 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 49UBkXsc021870;
	Wed, 30 Oct 2024 11:46:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 42gsgm07mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 11:46:33 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49UBkWuo021863;
	Wed, 30 Oct 2024 11:46:32 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com ([10.213.97.93])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49UBkW2K021862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 11:46:32 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 460767)
	id B00A4515; Wed, 30 Oct 2024 17:16:31 +0530 (+0530)
From: Balaji Pothunoori <quic_bpothuno@quicinc.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Balaji Pothunoori <quic_bpothuno@quicinc.com>
Subject: [PATCH] wifi: ath11k: Fix unexpected return buffer manager error for WCN6750/WCN6855
Date: Wed, 30 Oct 2024 17:16:25 +0530
Message-Id: <20241030114625.2416942-1-quic_bpothuno@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vwH7Q0ZNUKpWh58_hFIAYwL09eaj5lv2
X-Proofpoint-ORIG-GUID: vwH7Q0ZNUKpWh58_hFIAYwL09eaj5lv2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=766
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300092

The following error messages were encountered while parsing fragmented RX
packets for WCN6750/WCN6855:

ath11k 17a10040.wifi: invalid return buffer manager 4

This issue arose due to a hardcoded check for HAL_RX_BUF_RBM_SW3_BM
introduced in 'commit 71c748b5e01e ("ath11k: Fix unexpected return buffer
manager error for QCA6390")'

For WCN6750 and WCN6855, the return buffer manager ID should be
HAL_RX_BUF_RBM_SW1_BM. The incorrect conditional check caused fragmented
packets to be dropped, resulting in the above error log.

Fix this by adding a check for HAL_RX_BUF_RBM_SW1_BM.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.2.0.c2-00258-QCAMSLSWPL-1
Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Fixes: 71c748b5e01e ("ath11k: Fix unexpected return buffer manager error for QCA6390")
Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 40088e62572e..40b52d12b432 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3872,6 +3872,7 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
 		ath11k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
 						 &rbm);
 		if (rbm != HAL_RX_BUF_RBM_WBM_IDLE_DESC_LIST &&
+		    rbm != HAL_RX_BUF_RBM_SW1_BM &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM) {
 			ab->soc_stats.invalid_rbm++;
 			ath11k_warn(ab, "invalid return buffer manager %d\n", rbm);
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 8f7dd43dc1bd..753bd93f0212 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -372,7 +372,8 @@ int ath11k_hal_wbm_desc_parse_err(struct ath11k_base *ab, void *desc,
 
 	ret_buf_mgr = FIELD_GET(BUFFER_ADDR_INFO1_RET_BUF_MGR,
 				wbm_desc->buf_addr_info.info1);
-	if (ret_buf_mgr != HAL_RX_BUF_RBM_SW3_BM) {
+	if (ret_buf_mgr != HAL_RX_BUF_RBM_SW1_BM &&
+	    ret_buf_mgr != HAL_RX_BUF_RBM_SW3_BM) {
 		ab->soc_stats.invalid_rbm++;
 		return -EINVAL;
 	}
-- 
2.34.1


