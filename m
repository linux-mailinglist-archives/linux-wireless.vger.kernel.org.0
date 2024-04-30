Return-Path: <linux-wireless+bounces-7031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6612A8B6C05
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 09:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD711F225A4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 07:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B363AC34;
	Tue, 30 Apr 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fFyoL0+C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470A179A7
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463024; cv=none; b=uLNb0VHsQjcYI+du3z2KMcw9YN2aiipE8X0bU4VWpH4cxyYfEnkxhW2TflX/90rLmxrYQUvHGKrheA96n0zA5WqZ9fMZANQ+x8LmiJiPkSNBhjZqfGQPadaoRzVek4k2exxYYfIEvp0dWc6evYhHTUV/UxbhwfCy9VhBb0baEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463024; c=relaxed/simple;
	bh=RwNsXFsNUIBI8pFor2Y2hs6XqrTmfi80n6F/ydRTLLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UIZndOnsn5TuhMFqFc4fnOCF4BooHQ7UwWAQKomnbMxe83T6DX2Qtnj4BlNencDBLtjEIO/B9TwYP0Ix7FAKdbiIH60kXU3mMyGzxV7r3vVRYA8chwxiuIY/VFip33nZ3xl7Oi1dLI3RCfTioNa6drV+KDUvQWMvrs/EQI5AQ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fFyoL0+C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U7ewEL001828;
	Tue, 30 Apr 2024 07:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=ZKf9Am5
	uSibPx6rVg8Bxxng0Qs+fK/1XtQlUCRIJkI8=; b=fFyoL0+C6W6rBN4ktIh2amA
	dSz1vig1kDOJ1d4T10acFjRWv7/1yaHymvTf8nso+bI/GvVabdFv0/lcYCvcRTtW
	qDI7volGmugbuynEW/HiFmlTCEiOU1BpF+DPoy+4z7OCEH/fL07O5FRPmwni7GNw
	RPWtJ2iDkR3q3AS3Cb5+PTwPvl9SP6Upr5i2Rr/K4GkNvVuxz2WuaIjIrnzEN5qE
	ft56CfjgQ0gT7bThtexqJVjn5dMG32UjwqBfNnYKzUR2CfEhhONa+hTlWtIe6xf8
	dzgfv+fLeUhiXzdnaJhFnlMbBEqSw01We3iEVQQtpQgEkiOoDGGL1/0Xd8dGRpw=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtvf7g07r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 07:43:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U7hdbZ021480
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 07:43:39 GMT
Received: from hu-kathirve-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 00:43:37 -0700
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
Subject: [PATCH v4 0/2] wifi: ath12k: drop failed transmitted frames from metric calculation
Date: Tue, 30 Apr 2024 13:13:11 +0530
Message-ID: <20240430074313.885807-1-quic_kathirve@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T3BOwQ6Isjhfmf2m_oopdHvedir6D9Xf
X-Proofpoint-ORIG-GUID: T3BOwQ6Isjhfmf2m_oopdHvedir6D9Xf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=862 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300055

- Use ieee80211_free_txskb() instead of dev_kfree_skb_any().
- Drop failed transmitted frames from mesh metric calculation to avoid
false link metric averaging.

Karthikeyan Kathirvel (1):
  wifi: ath12k: drop failed transmitted frames from metric calculation.

Sven Eckelmann (1):
  wifi: ath12k: Don't drop tx_status in failure case
---
v4:
	- Removed an invalid patch uploaded in v3
	- Replaced a dev_kfree_skb_any() by
	  ieee80211_free_txskb() in
	  ath12k_dp_tx_free_txbuf()
v3:
	Addressed Nicolas Escande's comment
v2:
	Addressed Jeff's comment
---
 drivers/net/wireless/ath/ath12k/dp_tx.c    | 47 +++++++++++++++-------
 drivers/net/wireless/ath/ath12k/hal_desc.h | 22 +++++++++-
 2 files changed, 54 insertions(+), 15 deletions(-)


base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
-- 
2.34.1


