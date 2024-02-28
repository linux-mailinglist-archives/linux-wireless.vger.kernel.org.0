Return-Path: <linux-wireless+bounces-4169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05D86AB6D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 10:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B782282C2C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F80374F5;
	Wed, 28 Feb 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ESm+lLTm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC336AEE
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112967; cv=none; b=kWPOA+JtzAqg8VNNdNwuUISHv86tVFrfP8qPRLH/Bef1IFv+/2baZ6nr3dstvrHT06zqHS3aw2t/wUdyr4fD/w1JJkqc8VwRoltQCDrF6iRZfZoxS7vjZmbIb3B3VnH4RH9i8I/uaoAN7iRHFrIQ/GmuaVgnR+p0h18c/6t/53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112967; c=relaxed/simple;
	bh=8Ik2EFBhyvSQy1zRhJ8dm6HcQDXXpkHOH7SbkiNP58c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d53EcmwB2UYohmKp2B/WpvS6KQYT92DfRt2IklkqXWC0kaWGnp4KJp1s8mUHcvMcRLAOSwWsMyO6X82r+Dd/6aIQ1gv2KZKIN7cZ0UWnn1cFqmEOvLJqDRbhX+PdtdeFfkxcEpL6K0BoHuY9K1m59jzzRN3bw2hoxywwR3LEi8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ESm+lLTm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S99ZCm026579;
	Wed, 28 Feb 2024 09:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=HQlgUflcXlAdqMQrwHDJHgAmMdEyD98BYOjQF2npL9Y=; b=ES
	m+lLTmgIz5Of+k5/MXSdV2B/hEujXfsHcTs0AkmXYMmPYepPCYAgOnbL7WST4T4E
	6HcwjRBlcVQ31UK/Hj/o8aYKy/wTKAB3fYcfQ2QBRKazhddO7sCnd9ZdD/9fByv3
	DTsavbk9hF+emx8RH9mFZf2GrSRDjcGh5AebN6+s9Fb3FgyOEiWPsmYyTkjAGTgB
	uJyFPg5tF/GZboBilbvEqfao8xdh8ORC0mtoQvELkohkBNlwIKXuyJva4t84iQL1
	9i0V/fVSkTkcZwvmHozN3FweVd0ByUPnuF7jo3AECTZY9eDtP2Gr7WJONjetqJa7
	U86A7Z54u6GTDS8gJO0Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj1d9r43h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:36:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S9a1bf015644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:36:01 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 01:36:00 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 5/6] wifi: ath11k: change scan flag scan_f_filter_prb_req for QCA6390/WCN6855/QCA2066
Date: Wed, 28 Feb 2024 17:35:36 +0800
Message-ID: <20240228093537.25052-6-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228093537.25052-1-quic_kangyang@quicinc.com>
References: <20240228093537.25052-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: z_Q5-BzroKfxxlQuFT93t5Id_laF7XZT
X-Proofpoint-ORIG-GUID: z_Q5-BzroKfxxlQuFT93t5Id_laF7XZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280075

Current ROC scan will filter probe request. So P2P device cannot receive
probe request. But it is necessary for P2P mode. A P2P device cannot be
discovered if it doesn't respond to others' probe request.

In addition, station won't filter probe request with common scan. But
for station, there is no needed to receive probe request.

Based on the above two points, change scan flag scan_f_filter_prb_req
for QCA6390/WCN6855/QCA2066.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 24aab590b05c..d66d09adf2fa 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4083,6 +4083,9 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH11K_SCAN_ID;
 
+	if (ar->ab->hw_params.single_pdev_only)
+		arg->scan_f_filter_prb_req = 1;
+
 	if (req->ie_len) {
 		arg->extraie.ptr = kmemdup(req->ie, req->ie_len, GFP_KERNEL);
 		if (!arg->extraie.ptr) {
@@ -9340,9 +9343,11 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	arg->dwell_time_passive = scan_time_msec;
 	arg->max_scan_time = scan_time_msec;
 	arg->scan_f_passive = 1;
-	arg->scan_f_filter_prb_req = 1;
 	arg->burst_duration = duration;
 
+	if (!ar->ab->hw_params.single_pdev_only)
+		arg->scan_f_filter_prb_req = 1;
+
 	ret = ath11k_start_scan(ar, arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to start roc scan: %d\n", ret);
-- 
2.34.1


