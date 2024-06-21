Return-Path: <linux-wireless+bounces-9362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7550911D02
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6182E1F21913
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC4514038F;
	Fri, 21 Jun 2024 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HNQMyVkA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC5C259C
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955675; cv=none; b=r3GEkuuhPnkJkenoNhRWT43aomtWQ8klehjoWLJZTDB5XYCCIAzCY+BLrNearncz141dDhdd6N+XNw65yCVoJVNCzq2h31aKck6MlL+HbzK0HATsdxf+z4VoHFU/1XFEFPPZaPT+a6InqqdnwqHXpr58e+g5IR+4Pc8NgJovBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955675; c=relaxed/simple;
	bh=AproKwDDuiQdd0gOGDsjVMjSaFW5irip4B2jGVpFwdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UZAtrOiGnUs6se/JsUDqV3jLmUZLgIUZbXg/PCKnyEl/4mno6Y6vq4u3Bm/NjadmEKmCjOzc/+wEg8bX7oZ8KWEFexBQvnv4TqaBgOUfFM/N8MOLzscISMdsqFMeQdIyhQgItlN2RfUtC1KEXRJarNj4Hrez7qAGGgsBFHEf5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HNQMyVkA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L6JVIj017892;
	Fri, 21 Jun 2024 07:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bXWghcVs7JjFchdR0lOSZk
	doiXDHIAQm7E3tKGX76lU=; b=HNQMyVkAjurlagQY/4WpMQkCPPcW//O+W7cTG+
	9+dm+/CN64CzRbclwZKgM43ey5WwaF7O7xq2WU4h7FEkqIAwa/D5hIQpZt8cAhgN
	N30LDis7zlqHVVcOItOK0mkzgjegbOLY4nPxwvfPkRyfTACDClf1vlrB1Z4pORt6
	WE1mo5gHGSm2agDgbi79lQbaqpveEyZkXmbAMaidXb78Ou56GWaNcqGjJgw3Nz/R
	h9sA14V6LNampvmB52urlLs9KEDnrIRybptetv+ql+R24cg/xPE3F9Rt0CecOEdB
	aHw54/AlpR/AD6ELl965aw+57QTSOSpmY8zIysAXBIQazGZA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrm09utc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 07:41:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45L7f9sQ018972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 07:41:09 GMT
Received: from hu-ssreeela-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Jun 2024 00:41:07 -0700
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>
Subject: [PATCH] wifi: nl80211: allow MBSSID Tx VAP bringup without MBSSID IEs
Date: Fri, 21 Jun 2024 13:10:38 +0530
Message-ID: <20240621074038.3938005-1-quic_ssreeela@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: xG2UMggRZokjE5NgBMg0FSsq0cLl69lm
X-Proofpoint-GUID: xG2UMggRZokjE5NgBMg0FSsq0cLl69lm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_02,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210056

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Current implementation of MBSSID configuration parsing mandates
MBSSID elements for Tx BSS (index 0). However with ML link addition
it is possible that Non-Tx BSS'es can be added at a later point in
time after Tx BSS is brought up. Hence allow bring up of MBSSID Tx
BSS even if no Non-Tx BSS are present at that time. Later when new
Non-TX BSS are added TX BSS beacon can be updated with MBSSID IEs.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
---
 net/wireless/nl80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fcac7dedcd61..e579cc0c860c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5400,8 +5400,7 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 	}
 
 	config->index = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_INDEX]);
-	if (config->index >= wiphy->mbssid_max_interfaces ||
-	    (!config->index && !num_elems))
+	if (config->index >= wiphy->mbssid_max_interfaces)
 		return -EINVAL;
 
 	if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX]) {
-- 
2.34.1


