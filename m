Return-Path: <linux-wireless+bounces-16447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A99F465A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 09:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502A6167DA0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1A1DD54C;
	Tue, 17 Dec 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lLvh9HH6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172381DDA33
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425136; cv=none; b=ePDsEJ+/UAGjtmdO18vo89jPhh96bFB1gzk0kkxDLLwapkxcDoD8lWZv5Ci8zNvxA6PfCXXecR+rQZ7KUO+nHZo8Ddzo+DigGxAzLYpa8q3s8Kzlt1/v9jIO7XhWEwxbe5dp1ckkGjfoa59EgIEkMbDR8iVTbEZrvWYwXofdB3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425136; c=relaxed/simple;
	bh=R+Abm1likQsuTyINTl6quwEM3ens7gNUJCse9cNkF08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhGYo7BVnZFtwAW/0OPkRaVIwdikMytQ4tz2nbpV0PlHSzrEoX3HTDWybLmI2itKo9OmF2rll1alNOssxeuzIl53sJqJV4/mUFe5wcmeNaZS5gMpx6AE+bvaLQaB7Q/hlNlTDAnaUQAwkFZNT8RBDngJel9BE/wmlKdx1NG+2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lLvh9HH6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH4leFU013542;
	Tue, 17 Dec 2024 08:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VbZeGqLxWwWRlb2U9pO1X2D4T1ObcI+Idu+fpt33KUY=; b=lLvh9HH6wxPqL7vm
	yxcPlO3S6WquzHbxm2W+uzO3B+7Gj4eEK63tFt1y18KM9AF+0bcaCbqQgJ9CtdT7
	4tB9pxonOrw4IG5znC669F0IFRf4Lp2uqzjO/fl+KLlgQDj49O6LcW8YC0re2v3o
	LQOnyU7Phgs6N4weyQQHFTN9F7fGP0y0KSaljrQz1AnhiGzPKnc5rOeyqMclEQcG
	OwND8mysxerl2CJQ/ZHMwpQaxl8mAbhLOi2IEbJk7VqqxT6qInADZFppmsSY7nTN
	t/wq89fgHHY7za08fQ2kT/dyvqgfSzsZow2DQmBEDGZfmTKGFA84k73oEsBDGiPB
	B3OqCA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k2k7gj6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 08:45:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH8jWX2010696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 08:45:32 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 00:45:30 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v3 3/8] wifi: ath12k: cleanup Rx peer statistics structure
Date: Tue, 17 Dec 2024 14:15:06 +0530
Message-ID: <20241217084511.2981515-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: t2MX6JcRsoeZ86LSYDrRNNjbXAFNpidZ
X-Proofpoint-GUID: t2MX6JcRsoeZ86LSYDrRNNjbXAFNpidZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=873 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412170071

Currently, unused fields are present in the Rx peer statistics
structure. These fields are already present in the same structure
under the ath12k_rx_peer_rate_stats container structure. Therefore,
remove the unused fields from the Rx peer statistics structure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ec61ad3d82c3..b789b375b891 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -381,10 +381,6 @@ struct ath12k_rx_peer_stats {
 	u64 non_ampdu_msdu_count;
 	u64 stbc_count;
 	u64 beamformed_count;
-	u64 mcs_count[HAL_RX_MAX_MCS + 1];
-	u64 nss_count[HAL_RX_MAX_NSS];
-	u64 bw_count[HAL_RX_BW_MAX];
-	u64 gi_count[HAL_RX_GI_MAX];
 	u64 coding_count[HAL_RX_SU_MU_CODING_MAX];
 	u64 tid_count[IEEE80211_NUM_TIDS + 1];
 	u64 pream_cnt[HAL_RX_PREAMBLE_MAX];
-- 
2.34.1


