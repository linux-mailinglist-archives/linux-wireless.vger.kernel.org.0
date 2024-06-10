Return-Path: <linux-wireless+bounces-8747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86872901D4E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 10:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E415B212BD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1AB5227;
	Mon, 10 Jun 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pRUA+K/e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207046F2F5
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009554; cv=none; b=gX81BB+DuMz6UbYgiepin+3zNRvaLeG0bwfxmfncEMxKeZrYPRTvMMSFdl9TeMacBE3/zA6xclNlw+dYwYJPidrfK5bqSBPZo4zvUg942TPSD0ZIHRKWRBOs3xWLhFM6WO1ELHGLxYv6EEs+g7pBvFTCA6oTPGoQk+JQb4IMSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009554; c=relaxed/simple;
	bh=ShECwHzCRIxs611lh9BxR3YkfbR23mZBhpA+Vaj/HtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfX2+Ofw61vLuT7LkNFSkQqfoVPDtdATdKJ9o0bvdDHpaTd+vv1jtvSN6G950BjSMHv71TDEp0qqko7LHoeQ7BePwCUEmg0mXyVBvT2foS8X87+E+k98xb/RiltRO4OkIdHFIC7pfGbYV+yK3wTUY46V5ZhPHpXunKbI81GMi48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pRUA+K/e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A2p2gx032146;
	Mon, 10 Jun 2024 08:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tfx37LDcTDx6aVBr1MJR8xDR
	yxtNlWiJZmKJu33E9L8=; b=pRUA+K/e/05+b0Ye5ut58sEJwuingcLsL5zA3/mH
	qHbV+5XJ6uHyZDj2D2hc92X/RBkvtvA31YLTLrlKjUkF4Rt3+1eSF7qVAffzNfgr
	R5S8qRkYPFsVzKk4CMg+k6/ByHV8SIcCieHIaj5yQRWOkxXrHuJZgHRlX8a7bFkG
	Lo4ifX9iSmz+jBj8ePtyAZZhanD9o9M/jhTtsG/dWF/mnYomjdHlkW+4rtwceE+6
	4CysM6CfwTJDUrfIUcAKF+3/05zydCmtVoE0HoDzZlrM79+7oGlI0mOaSLTKdXse
	1/1CTaoMtPymy3VplTTH/WLdqjxt8qXV5IAbu4qAflbKww==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfp7atev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45A8qSDJ029470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 08:52:28 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Jun 2024 01:52:26 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH 3/4] wifi: cfg80211: skip overriding direct/MBSSID BSS with per-STA profile BSS
Date: Mon, 10 Jun 2024 14:22:03 +0530
Message-ID: <1718009524-5579-4-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o4a2HmfhS3SBJbcAAFC_ef_s-Q0nMeRY
X-Proofpoint-ORIG-GUID: o4a2HmfhS3SBJbcAAFC_ef_s-Q0nMeRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=452 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100067

Skip overriding BSS information generated from MBSSID or direct source
with BSS information generated from per-STA profile source to avoid
loosing actual signal strength and information elements such as RNR and
Basic ML elements.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 2850718..37ebe5a 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1891,6 +1891,10 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 	found = rb_find_bss(rdev, tmp, BSS_CMP_REGULAR);
 
 	if (found) {
+		if (tmp->bss_source == BSS_SOURCE_STA_PROFILE &&
+		    found->bss_source != BSS_SOURCE_STA_PROFILE)
+			goto free_ies;
+
 		if (!cfg80211_update_known_bss(rdev, found, tmp, signal_valid))
 			return NULL;
 	} else {
-- 
2.7.4


