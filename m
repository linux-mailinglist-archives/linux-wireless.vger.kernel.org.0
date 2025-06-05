Return-Path: <linux-wireless+bounces-23742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525EAACECD7
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16C93ABE90
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 09:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2B21DFDBB;
	Thu,  5 Jun 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gCQGNBR2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715282114
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115884; cv=none; b=JhIbznPgC5PPYGbXtxaeORn967u30PqvoApcSB4z/OX1Q7MFDFwkcErg1ddV+wLL+5WdIo8Qd5jdUn1+DcEqW5EYtysF8pIB1Fni+3qI8afHIXhl3KI9jjlqvDQl45TJWVfai0tqzXFZ1Njxmt1FpMk2PAcLLkOcyj3DSnQrl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115884; c=relaxed/simple;
	bh=cJwbO0c5NPDZqKJ5P297DRKY7fxuRkgHmRlx4H9Ohpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohE5EhkPPHatH8zLueioWG4qVRSI2skcsocnmbbPm1trZTaC8Lk8PMVNrb2UdvUgwQQQzpL2UWXHy/hctuUmymf3Me8O1bfez4WHGSa/vxF0XMJZcKsdOmnUZrpK39+yNnoJoSNbLjIOhjQgrQdYClEY8j2lM1l9mzmkiS94HC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gCQGNBR2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557xgH4010405;
	Thu, 5 Jun 2025 09:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wMbK30HPNP/GXqa54/GRoC8mhGja/NXoZ2XPqc049XY=; b=gCQGNBR2jF85yvkS
	TWpTAJY5UNG3ulCHpqhSRVAi3c90bAwqzNKx+iY98vRYei2kiSP/Ytm1DnRUCO52
	X7nLVN5f1Ez7UJygqZIPhgin+zAIhaS/I8Yh69TE79cyuWIsHwSaCCvenyYH4elw
	okbWxpgSffG/dTEix64tO0HTABxBsCKOm1nlAEYvr6K7QBNBiByiXjPshSyyH1aG
	lBaAl7L2zsMvVOF7vKfdIYOxb1/uhLpTW6hOGNcarlqDy0wzc8/r1iLmtkgw2yyX
	/ZgeYbRZ56GdLaTuhniTb/p3C+MLfl7kiMhsGZs+XFrXW/8zun7HG2kDr3MA2CNb
	0WU31A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8yru61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 09:31:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5559VHKJ022112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 09:31:17 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Jun 2025 02:31:15 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v13 4/4] wifi: mac80211: Set RTS threshold on per-radio basis
Date: Thu, 5 Jun 2025 15:00:52 +0530
Message-ID: <20250605093052.3351173-5-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605093052.3351173-1-quic_rdevanat@quicinc.com>
References: <20250605093052.3351173-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA4MyBTYWx0ZWRfX/PBS9a9Tssew
 F905FjbV4ga/wmT4rCCa43UzlDC7y+wSdi3KXvt9ruL25bRlVce3y0B9oO29wpCnLZHzOdWS3Jf
 MoTyyysFZLu6azNeOhcqfPHcS+Z9oxdGcyW31SoU3JTEx9kfCfPo6oA1l1V6zoIoXYs6x1d7sNH
 jMUZO9h+mbyJoOwh669cLJAkKS6rzpeFUIk1eTE1S5ezHm6AdWFy/FNLMLRrye99XhwiEYY36ub
 xrZjLvfPL6SjyqilkX36GDtgOolDCTpNTyz7fGA+EeC0Ae5PAR/g2QWnHC7DVWh1ClY5/As0YZ3
 DmvGhFUF43hlsstcvushxqxuEddhIL1ls2kuRLy8Ct+zLPAT/2lkCTnJQQbOW+og30frT6ekn+N
 3Ap9ELtmaSWqnhb4yzrL2W7knVgFblBwY7FgVGoqVuJ2N+d7psfQQy/sxaFUVNeYRs0T75yx
X-Proofpoint-ORIG-GUID: -J5pt0SiNt2rQkpU7fZB8cSvDJqrgcws
X-Proofpoint-GUID: -J5pt0SiNt2rQkpU7fZB8cSvDJqrgcws
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=684163e6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=xHEeQlBAHYfg8jAzN9EA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050083

Add support to get the radio for which RTS threshold needs to be changed
from userspace. Pass on this radio index to underlying drivers as an
additional argument.

A value of -1 indicates radio index is not mentioned and that the
configuration applies to all radio(s) of the wiphy.

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 net/mac80211/cfg.c  |  8 ++++++++
 net/mac80211/util.c | 10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e2ed8401bd32..36cf52f78ee6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3060,6 +3060,14 @@ static int ieee80211_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
 	}
 
 	if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
+		u32 rts_threshold;
+
+		if (radio_idx >= wiphy->n_radio)
+			rts_threshold = wiphy->rts_threshold;
+		else
+			rts_threshold =
+				wiphy->radio_cfg[radio_idx].rts_threshold;
+
 		err = drv_set_rts_threshold(local, radio_idx,
 					    wiphy->rts_threshold);
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 78cdce9d3993..cf61716c0bb3 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1756,6 +1756,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	bool sched_scan_stopped = false;
 	bool suspended = local->suspended;
 	bool in_reconfig = false;
+	u32 rts_threshold;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1829,7 +1830,14 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	drv_set_frag_threshold(local, -1, hw->wiphy->frag_threshold);
 
 	/* setup RTS threshold */
-	drv_set_rts_threshold(local, -1, hw->wiphy->rts_threshold);
+	if (hw->wiphy->n_radio > 0) {
+		for (i = 0; i < hw->wiphy->n_radio; i++) {
+			rts_threshold = hw->wiphy->radio_cfg[i].rts_threshold;
+			drv_set_rts_threshold(local, i, rts_threshold);
+		}
+	} else {
+		drv_set_rts_threshold(local, -1, hw->wiphy->rts_threshold);
+	}
 
 	/* reset coverage class */
 	drv_set_coverage_class(local, -1, hw->wiphy->coverage_class);
-- 
2.25.1


