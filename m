Return-Path: <linux-wireless+bounces-10744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79450942E4E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 14:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243121F228CF
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A259C1AE85F;
	Wed, 31 Jul 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lmn06lzy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28FF1B0123
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428548; cv=none; b=AKtfyweIqmcrbTK4WlPhr++XaoAppgmGyC/X0htL9kI1zrX5sXJZcW/7GwjAmxDsxCmqIyo2gTiwaAXOt/R9FNnLkJ/5Qdb26pmFTkkEheHtwfQrAtN0rdEVL+qlu4Bc7JamD9g6YdZ0IBQX08I+PWRkIP2XYIzXucRHQfYRrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428548; c=relaxed/simple;
	bh=YX0LPIkANBQJP3xGcEidtBiG0NlDo6QqnULwD719SkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJA02OzNAkO1VYAmPR6LoGygemQ82AOkYVdO6/iFMEZ6+4PTTBYxa3gxHR2hXvBV3X7Wyn2nXLKjZvMvhcdlAX/8fBnLcUfWA3Qi00uhORa+x6iPSGO7oCHpbQmmTjxNN8ebguhmmA5ZhiCHmDa6sbolHW/46/pDS0Oh//MDmNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lmn06lzy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VAjdB9027628;
	Wed, 31 Jul 2024 12:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gs4uMYkKX6eNPOv5K5g8Gr
	fOTu6hOIyrsM51kGJbiOE=; b=Lmn06lzy052uN6NFuHaF+zYZWQoxjsLYGpKI3W
	cQdSJ0ojSlkmXM1V1+gqOuz9GC0c3OjdZ5jTlHJ6BUTCM2S2bfGCCHnlCgMdaUZq
	jXKG++fnnGN7tUdJeLvnil6Lb4H9iQvrO7AabNMcH9TxGeVvmAJjgs9ygpCGkq3N
	WXHjnoCKbsYk1Nqq0O97U86eff0HLBpS0xKJCUN7dNYi9c4A2mfoHGD7yiV4mIW0
	LxlyPfGB6vIjMOVJ4e0BYSP/0aTzeR2uEScEsePOSyEq8dUT69arzMeRKNz1DP6p
	WfWvu2/AR6IMzXKAnkViTVy5aCPWH4Jp/TwpIcoh/NLayaqg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40q232uec6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 12:22:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46VCMMAo003628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 12:22:22 GMT
Received: from hu-ssreeela-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 31 Jul 2024 05:22:20 -0700
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>
Subject: [PATCH v2] wifi: nl80211: allow MBSSID Tx VAP bringup without MBSSID Elements
Date: Wed, 31 Jul 2024 17:52:01 +0530
Message-ID: <20240731122201.2635010-1-quic_ssreeela@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CBAqRllTphP2nXkjpDEpXh6Oc4k7V4jx
X-Proofpoint-ORIG-GUID: CBAqRllTphP2nXkjpDEpXh6Oc4k7V4jx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407310091

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Current implementation of MBSSID configuration parsing mandates
MBSSID elements for Tx BSS (index 0). However with ML link addition
it is possible that Non-Tx BSS'es can be added at a later point in
time after Tx BSS is brought up. Hence allow bring up of MBSSID Tx
BSS even if no Non-Tx BSS are present at that time when EMA is
disabled. Later when new Non-TX BSS are added TX BSS beacon can be
updated with MBSSID Elements.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
---
v2:
  - Mandate num elements check if EMA is enabled
  - Rebased and changed 'IEs' to 'elements' in commit message
---
 net/wireless/nl80211.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7397a372c78e..f1b0274681b9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5496,8 +5496,10 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 	}
 
 	config->index = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_INDEX]);
-	if (config->index >= wiphy->mbssid_max_interfaces ||
-	    (!config->index && !num_elems))
+	if (config->index >= wiphy->mbssid_max_interfaces)
+		return -EINVAL;
+
+	if (config->ema && !config->index && !num_elems)
 		return -EINVAL;
 
 	if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX]) {
-- 
2.34.1


