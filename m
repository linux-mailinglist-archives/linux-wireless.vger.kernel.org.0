Return-Path: <linux-wireless+bounces-20292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44306A5E99B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 03:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75291176537
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 02:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4851C683;
	Thu, 13 Mar 2025 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QdaBIjBG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9B23B0
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741831375; cv=none; b=czyA55MmVu/m09l0sIHMHO3D5Y+AJdUz3AUDOlKx632n5jt46QjZKy3l/oi6t68w1qmUUTyA63g0c/7R1u1LpWDpJdUzwurkSdgZ1FIvtRJxwjsCeEo1ByMvc2R2PQU7cXyQu20X2zY1GhwbC/KaQwC3Qje0ozfQZDsOIWxf7Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741831375; c=relaxed/simple;
	bh=tdHku1km5UVjGiat8OFRdLR2F2Tx8WS4feNPB9UxsbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SROIhMlago3bQLKgIwKY3BsiFPF1MDYtj1lQY5D8fk3zLBr8J7sayBDtl8nPCvsXSLUxcbsb5om7awuXJU6mygNNsa4ozpno9qcwzmnoTcX7p6Pbx6eRze6JbbPVnZnmMmpxSzDIr+IE1OWoBC/5CBbvIgbGl2rhbrzbv5Qo69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QdaBIjBG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CLTI9x023249;
	Thu, 13 Mar 2025 02:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pFVxo0QOG6ak7Q1yS7aPKIRC
	Ebxu8JQFeMNFvNiRkKI=; b=QdaBIjBGU48aPTTVy52xeqXsH/MCHs3baJQMM4pK
	UQM3jRSRbatRFWXRfQBZmD8dtD3wQFD2igGEIdJ1gksWG9+gRdLwQZ3fpKMVxp6U
	8UvEE5nGQCHeaixX4AZqPmoFncFbCZLy+pC8Hb8RYXmO4lYxVwesJ4KMx1UbN3Nn
	ymSWOLadR4Z4jmdIQSbXj2lsmGLZfzdy2j7xXrk69DZ5Aj6NTzmyL0TN38dYUMDB
	2BKhEuoPM8kEC6tKeDQQg8+Lz+PjpGze+DnHDZ8jJWxSjTINPds/8K/GkXRZtQoH
	nSyfIXBTDgwKdVLy1k9x3X8rUtiheK2S/3g+YFUF+/TIKg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2mm6tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 02:02:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D22nCJ013331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 02:02:49 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 19:02:47 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH wireless-next v2 2/2] wifi: mac80211: Set the WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF flag
Date: Thu, 13 Mar 2025 07:31:54 +0530
Message-ID: <20250313020154.4066212-3-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250313020154.4066212-1-quic_nithp@quicinc.com>
References: <20250313020154.4066212-1-quic_nithp@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KljnZ2ZgEd9GYfXM1buAebo5VU_0tMvU
X-Authority-Analysis: v=2.4 cv=aKnwqa9m c=1 sm=1 tr=0 ts=67d23cc9 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=cAtGwYOs3FCezXbwKfAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: KljnZ2ZgEd9GYfXM1buAebo5VU_0tMvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130015

Set the WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF flag in
ieee80211_register_hw() when the driver advertises NO_VIRTUAL_MONITOR
support. This wiphy flag enables cfg80211 to allow concurrent
support for monitor mode alongside AP/STA/other interfaces.

Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 net/mac80211/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 741e6c7edcb7..a7fbec07a484 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1148,6 +1148,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		    (!local->ops->start_nan || !local->ops->stop_nan)))
 		return -EINVAL;
 
+	if (ieee80211_hw_check(hw, NO_VIRTUAL_MONITOR))
+		local->hw.wiphy->flags |=
+			WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF;
+
 	if (hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO) {
 		/*
 		 * For drivers capable of doing MLO, assume modern driver
-- 
2.17.1


