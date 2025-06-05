Return-Path: <linux-wireless+bounces-23752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9CACEE54
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DC7189A006
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7BA214815;
	Thu,  5 Jun 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iHDBLOwV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF407219315
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121884; cv=none; b=pjh8hj/p4r9j0HSA37DVHQpkUHqdvxfNWtXK4VoI9iLZSpx8WHZnocKgjfOfEwRy4m5xF3Dx8WFkBvje80ajluFoVphq6GoiOnXsgMyl6xyf5TnyZnMw5wzgL8a3SKkyVEZqnKWbVlusG7HcXanJhS3t/r3qmpPaxb3dzVJpROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121884; c=relaxed/simple;
	bh=GS1V1d3vucARyQOuPaP3FEU9JYCZpYmSKoomuLLnDVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEr5orsJFJTuia+hCKYfvWulBz4KdS8Fvke12PUyqvQVJgdCX4DKYu2YEsM/rniGqj+j/lJdx6czNag9yYOY/ixshfwcnu9enerHedEmc8lIRGS++wJri54BOqgsQJtBl87WmzynBMaW6tcl8Q5a30BMZmBPF1cmdwqFhliEiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iHDBLOwV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557Zk94004229;
	Thu, 5 Jun 2025 11:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KU+aKITSc1Myv9xAmUjz8FuYZwoo9nMtpmqKC1D3q44=; b=iHDBLOwVPtDDbgMM
	Ly9iv/sp5v5+kn2vgxwZpgEWzzH2lI7YAET3DIbCSRMmvnfsuh7nnoEkJvRhFWJA
	wBHAfhkCCTrhs+KacKYj6QzEVqaAfV7Kri2CEjoO5r+sgUaxXkip45lSrS1Eye5S
	5toXeWmGf8IShR1gAaIUQBwEGkTGddrgDFm6Fh27e25jyzfx0L/0gsAxw/stfcqb
	F9Yr4EHi5R+/+/XyHJqRggM+oA8PhLU0/nINBv8M2RtDN+GBvApwpGZwOES0bfD1
	QA7Ew54CxSZJ39VYPnAQkS+0o3rMI3nattlXsa5hWdPwbYFreaPVpqIX2Wk1gTon
	SFaR2g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8s141j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 11:11:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 555BBFLu028639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 11:11:16 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Jun 2025 04:11:14 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v14 3/4] wifi: cfg80211: Report per-radio RTS threshold to userspace
Date: Thu, 5 Jun 2025 16:40:39 +0530
Message-ID: <20250605111040.3451328-4-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605111040.3451328-1-quic_rdevanat@quicinc.com>
References: <20250605111040.3451328-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KN3yUvkEJ6AAMaUP89a0_uWUiZANNYe6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA5NiBTYWx0ZWRfX+jQo7yWxMNwJ
 Z/ItbZl8vEoGBvfqQKVmUEMWfbzmr1JYSeAfq0W0WjPbJuqzNXYvmRuq2OC6ejy/NFIHILENLPM
 +w2/bUUC2s9Zogd285tZdGpDgHBHkeRiAndnv5BbAa0evt/GmtVT25K50K/OL9IFGL6xff2V0wG
 qGXOOxiQjjX1ncTaFnPMRbXp1kedLiwt63sfvGIZrY941t53MVei0o9JugdCoz5IvGDQB4ptMse
 LWro48uubRJd4picnBYKsWNq/rlGrRXGaFJ8BNI3KvrV/HR8LyrLfO/wQleYGkiBmDZW2M6wRXe
 5TCjDtfca2f5/cXitfoHH0lGZT7LOv+XttF3d2oNAhEZNa873gV7rojK5uqH3xCqcX8FiYTF1sV
 mONmpi3Gt80V61c2jY5kajbvRNRZFeCYxf9LnsnuZM+dE2L5CYCgESeicVz21tAVbNjDW64x
X-Authority-Analysis: v=2.4 cv=RdWQC0tv c=1 sm=1 tr=0 ts=68417b55 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=t2xFH_FA9tHEZGNgIz8A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: KN3yUvkEJ6AAMaUP89a0_uWUiZANNYe6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050096

In case of multi-radio wiphys, with per-radio RTS threshold brought
into use, RTS threshold for each radio in a wiphy can be recorded in
wiphy parameter - wiphy_radio_cfg, as an array. Add a new attribute -
NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD in nested parameter -
NL80211_ATTR_WIPHY_RADIOS. When a request for getting RTS threshold
for a particular radio is received, parse the radio id and get the
required data. Add this data to the newly added nested attribute
NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD. Add support to report this
data to userspace.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 464240e1903f..fe559fd1d4b2 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8098,6 +8098,7 @@ enum nl80211_ap_settings_flags {
  *	and contains attributes defined in &enum nl80211_if_combination_attrs.
  * @NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK: bitmask (u32) of antennas
  *	connected to this radio.
+ * @NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD: RTS threshold (u32) of this radio.
  *
  * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
  * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
@@ -8109,6 +8110,7 @@ enum nl80211_wiphy_radio_attrs {
 	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE,
 	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
 	NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
+	NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD,
 
 	/* keep last */
 	__NL80211_WIPHY_RADIO_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 23f4bfd404e9..787a020f550a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2447,6 +2447,7 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
 {
 	const struct wiphy_radio *r = &wiphy->radio[idx];
+	const struct wiphy_radio_cfg *rcfg = &wiphy->radio_cfg[idx];
 	struct nlattr *radio, *freq;
 	int i;
 
@@ -2457,6 +2458,11 @@ static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
 	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx))
 		goto nla_put_failure;
 
+	if (rcfg->rts_threshold &&
+	    nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD,
+			rcfg->rts_threshold))
+		goto nla_put_failure;
+
 	if (r->antenna_mask &&
 	    nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
 			r->antenna_mask))
-- 
2.25.1


