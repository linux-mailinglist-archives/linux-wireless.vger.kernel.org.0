Return-Path: <linux-wireless+bounces-13114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD8B98438E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C11E1F2203E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B9C17ADE2;
	Tue, 24 Sep 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P4ygPloD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0816F8E5
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173469; cv=none; b=LKt08XSLy8i6MNMHZWIusq77+tWw3UftgLlSsmWIBza1lfFKClJMQTdY4OjR+3GX03eio/UeWC5UgZZNh+fh7FEbmCW7YZ9gxWQr4dj5IUePaiRoaDys+QPfxyykKiujUAferJbXZ8O3hUvVVxNVpuZaK4ytnxLr2YyCrLWMtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173469; c=relaxed/simple;
	bh=DpLkY1EQ8Lu5bs9yWcyf0Ho7jYgipvVWp+o2VUJl9y8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I6YYV1wKqT1JJ/8MsGcpH1dWO3VphDlKMzGobhOWYUsGsscrE0EiFRGdYn0SgkKYRLdUneudDwxkuhHLZ/rnMageRZG+ZShgPtF93zyHZJJLeoXC/WGllYNl97ClPfT45hn/2pHpv0bIwyBlgNZ0tLybmTATlzvgM/1mqtAvgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P4ygPloD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O8FxS8012810;
	Tue, 24 Sep 2024 10:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fbFEXkc8bjo7ZrYOh1K1+1
	QSGNTa3/UFHJEy6l29fzQ=; b=P4ygPloDqdXN164Rhx+MJFc8z7chqmLnghxsfy
	jlcahymP1+J1Y6geUuAMbUohTxcnJT2Tse2UYjHAs5n0hbg1QXZWYPhND8jBMqPE
	RS//BJBQjXYL/1DMN9/T9Lor6hHCbtvX5YMDhHjQzBgGPeqaEKCG81JUhMfexkvz
	tYYLDgl6zt04W+MY60YW97gIpJ6noSrTMJd7Uw2Rb7f6K/Kw6XM3Yh7+5W+m+fYd
	NHZ65poPkB2BN4ndbpKNXCwysb25Otoa2dzevZvI6WN87W5XCeULzk55JDXcDnL8
	R3+1Dp/XOxeWsm1w0/MWL6ftEVju4VXx/olKm00Vd/ZF7Wkw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqakfve7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:24:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OAONVC032033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:24:23 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Sep 2024 03:24:22 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath11k: fix full monitor mode for QCN9074 
Date: Tue, 24 Sep 2024 18:23:43 +0800
Message-ID: <20240924102345.811-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vggE54HlDAauKUt1sejp28xxEEs9N-jN
X-Proofpoint-GUID: vggE54HlDAauKUt1sejp28xxEEs9N-jN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=750
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240072

Fix a warning and a bug for full monitor mode. With these two fixes,
full monitor mode can work properly to capture packets on QCN9074.

v2:
    1. delete duplicate commit message in patch #1.
    2. explain this fix is for QCN9074.

Kang Yang (1):
  wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode

P Praneesh (1):
  wifi: ath11k: fix RCU stall while reaping monitor destination ring

 drivers/net/wireless/ath/ath11k/dp_rx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


base-commit: d35bb26e150d7fb7434959fad9fcaeaac99906e6
-- 
2.34.1


