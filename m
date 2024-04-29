Return-Path: <linux-wireless+bounces-6980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7C8B571A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 13:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583CC1F211B9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6B54CE19;
	Mon, 29 Apr 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kFEWrhYC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E044377
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391383; cv=none; b=XhFvglAYOap1fEDbyxLxStXhhfvsBJ/HuHaoAcguUuoJ6FFOKfZxKk8dLp2YLol2TwmlRAPLoBlxfXB954TNEhR0kAiJfHt0KR7tiOM3Rj02SkbadCQSWYyFBgMclPv6J2k0+sG41oUm9gBKM4fb7hTyxcrNWb1WwogE9/CI3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391383; c=relaxed/simple;
	bh=O/Kby1HsaS0/zlkBLUb3YdlyfUZ2r80s1X3mox8fols=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOLX8ZkHajul5MXayYZ55zch3aAE9IL/xDbhgNuqMDN0DWDn+EgiQhfpClWA8EIMcp2mECb2F7e+OAkWya+9oXvi60X6KxLPqVuixzik1GSbZU2UD0fiRZ9HOJqC71EBtq9U7Uca6cAiiffVjmejpFrOOeO+vmTbzeohWSVoPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kFEWrhYC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T63389009334;
	Mon, 29 Apr 2024 11:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=0BmmmKM
	cT64VV0Pe5dRqAPeOoBL9XXUfG7gjWqIL+W8=; b=kFEWrhYCV283NS5/w/XGP6V
	RhAZYDicI3guoYAViufd5CaDLoCyLuXdAqCKGEus6yd0RX6BljhjShyh2mlrLxQO
	gI/Hq2hy7YFOGdekmjipEYcW7PXzLM0Z91TZmkp+hxk90crFT3wI2WNFVBxLgrMh
	hWT2ey0rzdBc+0RyTi3ldu6eef7HlOqIASQ1KHA3mtTbGkwqBH38ye+TEIJ7QCn/
	v+rdGMUCitA5xRDbsy4B+wvAYB1X+d5rcebgB3Hj4DqPRTLuAQ8+WkGUaoh+4xIh
	SnrHQW2vsY49GQEmCtERyzJ1LszKNqECqW42CsdEfi8BL1FAnDvepjh3rqWqvrw=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xt5xk8v80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 11:49:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TBnX86010392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 11:49:33 GMT
Received: from hu-kathirve-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 04:49:31 -0700
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
Subject: [PATCH v3 0/2] wifi: ath12k: drop failed transmitted frames from metric calculation
Date: Mon, 29 Apr 2024 17:18:38 +0530
Message-ID: <20240429114841.413901-1-quic_kathirve@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o8km_Cri60ngdL7LU_0fyxcfRUl3XXv3
X-Proofpoint-GUID: o8km_Cri60ngdL7LU_0fyxcfRUl3XXv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_08,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=925
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290074

- Use ieee80211_free_txskb() instead of dev_kfree_skb_any().
- Drop failed transmitted frames from mesh metric calculation to avoid
false link metric averaging.

Karthikeyan Kathirvel (1):
  wifi: ath12k: drop failed transmitted frames from metric calculation.

Sven Eckelmann (1):
  wifi: ath12k: Don't drop tx_status in failure case

 drivers/net/wireless/ath/ath12k/dp_tx.c    | 43 ++++++++++++++++------
 drivers/net/wireless/ath/ath12k/hal_desc.h | 22 ++++++++++-
 2 files changed, 52 insertions(+), 13 deletions(-)


base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
-- 
2.34.1


