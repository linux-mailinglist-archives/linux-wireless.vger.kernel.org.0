Return-Path: <linux-wireless+bounces-9978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357DB927045
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 09:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660181C23048
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BCE1A256D;
	Thu,  4 Jul 2024 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KUO180vE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC701A2555
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076915; cv=none; b=DNXi/rpDas8yP0hylG5YKWuO3B12MmWn6+Kls5BrUm1p6QGIHPTnu7KdEag3Vc/vf4dwk5KmOmUHZxbsTgv17wdWJLUCvVHXuWYeGwl7A9yeQflpnfqWzauA5AsY9eW1rKv+btaq7o+/n9zhRCSA2yEl8EQ4wclUTf/woitESRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076915; c=relaxed/simple;
	bh=/imNGoFl9G/4NS/uaMLuzAwKj58l7QxetJK4vBKfkKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P98RUij3u6AQ/CXhHQP9Dcj4kIZq5ZV1pe3RYgW1iPLbOh//VKM5jmOriU7zIyE/PsQ/2e4rt5PYig4gsoAtk9i7g4Us5Ars0gjIAXX7ynIVK/vVir2yN6h+zRDsIuO+K/GrLs5U8CRJgCI0LdQer/rmKDsONjVVIOR8G/Pqom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KUO180vE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4641LU19013436;
	Thu, 4 Jul 2024 07:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fkTpbVb9ERJR4BPtBl12AWxG5KRx5gd5beDP2T07MLw=; b=KUO180vErG3sR0Uc
	rJZZENEWmMnKGXyWutWd3VAYadR3eG4ZRsMwfEOBRayX9+sShgLzPogbMSrrT44p
	qJeNj1JU0OFoVVM06IXGdUTGp/C5EKv+b64iUwe0CCIEBU1C2VnEpcaO5y9DBT0M
	rCRNdWn5nOrIGHwC3uBIC5Jw9JYRM51mzKkl/tW0mMcAutQfJ1GpmPVs0C3f5rnh
	81U8i7sOSMvyKxrMhsyBX+J9adY1Yj/zh7Gn7ijWZXoXz2IwCSdSx3IGIJtjxbUx
	j3UssfiKOUYZQYP9EdqUIbU0H2h4Stsfg/evE5SBucKFURubRwNSDeP+LCRVoPKi
	qZjDSQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4054ndt6xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 07:08:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46478VtJ004688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 07:08:31 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 4 Jul 2024 00:08:29 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/2] wifi: ath11k: fix array out-of-bound access in SoC stats
Date: Thu, 4 Jul 2024 12:38:11 +0530
Message-ID: <20240704070811.4186543-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704070811.4186543-1-quic_periyasa@quicinc.com>
References: <20240704070811.4186543-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: pZnHWnQQqgqHjAlK0XElIdZGKKS-GMUZ
X-Proofpoint-ORIG-GUID: pZnHWnQQqgqHjAlK0XElIdZGKKS-GMUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=956
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407040050

Currently, the ath11k_soc_dp_stats::hal_reo_error array is defined with a
maximum size of DP_REO_DST_RING_MAX. However, the ath11k_dp_process_rx()
function access ath11k_soc_dp_stats::hal_reo_error using the REO
destination SRNG ring ID, which is incorrect. SRNG ring ID differ from
normal ring ID, and this usage leads to out-of-bounds array access. To fix
this issue, modify ath11k_dp_process_rx() to use the normal ring ID
directly instead of the SRNG ring ID to avoid out-of-bounds array access.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 86485580dd89..c087d8a0f5b2 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2697,7 +2697,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		if (unlikely(push_reason !=
 			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
-			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
+			ab->soc_stats.hal_reo_error[ring_id]++;
 			continue;
 		}
 
-- 
2.34.1


