Return-Path: <linux-wireless+bounces-7730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C38C703B
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 04:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98024283867
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 02:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB18410FA;
	Thu, 16 May 2024 02:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z19lRtK8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A191138C
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715825973; cv=none; b=AtpILEUJx30qH0FqxmYQgfh1kNI3IQBKrz3O2sRXZ2jipYw1qpeaiyxhpkP9chKFh9+1v9HdDeXXVvmv0ryha8nQH6r/2USD/9ZkdTQXfwb1kz2RG1WhqNQ+1CJ2poLy/QRwYTg/r/vm28aLQpuw9W0pa1xxutE1ooMzsFOFuQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715825973; c=relaxed/simple;
	bh=FSVaQKHqnya0WNeyjGU5QpxYOYB/SzNvQEFb8OGi/CE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4lg+qVDw/JYEXT6f4sWaozaB4j8vp2g8YSL6hg/kpdXlXe4SSudNPCALkzO98jN3RwIYDViJZ6RPpwETJ0dfU5262CvAYb06irfTE2VvwBGrswDe91/6Uugj5IhRW3Y/80ci5GEFEye1YrcZWBdS5AdQ1PfBP6DCPcHrwUIAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z19lRtK8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FJfA5L004205;
	Thu, 16 May 2024 02:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=5hL6KCYNQRKvYX2D/hl9zdAOqRMjwgupjV846g0kDX0=; b=Z1
	9lRtK8LXzSWpG7GcTK3gRWbxvEpCG3oYixBaQcnGiB1923p+igZ7CFo5RAgvZCKL
	Wnkgd8HriBK4pk9cmYHC8ZMedzDlpt1cXJg3VQjWP6lNVsv7z4CxlQCJIplxHu2q
	zfVQsG+htGN303ehjU3TBqHCM5D0ufyL+S72eQIZ4uNN6c7+k0IZko5nRE6u6qnk
	In/8kperIG9BdhF/gH2Nntx1MxLtCfh1+ckkUROg2AV3X/WFYi8eOAmJ/WBwB+tK
	2uAf1vdRQGqjn4aMznmM9EDODZSKrM7JMNsk2h0hqnDMWqwyAGMFGzCxkZQL9tnU
	fid5HmfDZKMO+sAZGKew==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y2125jh5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 02:19:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44G2J9LP021887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 02:19:09 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 May 2024 19:19:07 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211: correctly parse Spatial Reuse Parameter Set element
Date: Thu, 16 May 2024 10:18:54 +0800
Message-ID: <20240516021854.5682-3-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516021854.5682-1-quic_lingbok@quicinc.com>
References: <20240516021854.5682-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-GUID: 4erTGlAxMPGYbRztAmRADcv41YnZDiEX
X-Proofpoint-ORIG-GUID: 4erTGlAxMPGYbRztAmRADcv41YnZDiEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_01,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160014

Currently, the way of parsing Spatial Reuse Parameter Set element is
incorrect and some members of struct ieee80211_he_obss_pd are not assigned.

To address this issue, it must be parsed in the order of the elements of
Spatial Reuse Parameter Set defined in the IEEE Std 802.11ax specification.

The diagram of the Spatial Reuse Parameter Set element (IEEE Std 802.11ax
-2021-9.4.2.252).

-------------------------------------------------------------------------
|       |      |         |       |Non-SRG|  SRG  | SRG   | SRG  | SRG   |
|Element|Length| Element |  SR   |OBSS PD|OBSS PD|OBSS PD| BSS  |Partial|
|   ID  |      |   ID    |Control|  Max  |  Min  | Max   |Color | BSSID |
|       |      |Extension|       | Offset| Offset|Offset |Bitmap|Bitmap |
-------------------------------------------------------------------------

Fixes: 1ced169cc1c2 ("mac80211: allow setting spatial reuse parameters from bss_conf")
Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 net/mac80211/he.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 9f5ffdc9db28..ecbb042dd043 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -230,15 +230,21 @@ ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
 
 	if (!he_spr_ie_elem)
 		return;
+
+	he_obss_pd->sr_ctrl = he_spr_ie_elem->he_sr_control;
 	data = he_spr_ie_elem->optional;
 
 	if (he_spr_ie_elem->he_sr_control &
 	    IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
-		data++;
+		he_obss_pd->non_srg_max_offset = *data++;
+
 	if (he_spr_ie_elem->he_sr_control &
 	    IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT) {
-		he_obss_pd->max_offset = *data++;
 		he_obss_pd->min_offset = *data++;
+		he_obss_pd->max_offset = *data++;
+		memcpy(he_obss_pd->bss_color_bitmap, data, 8);
+		data += 8;
+		memcpy(he_obss_pd->partial_bssid_bitmap, data, 8);
 		he_obss_pd->enable = true;
 	}
 }
-- 
2.34.1


