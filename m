Return-Path: <linux-wireless+bounces-16588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E69F7A12
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37F5189319B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C161522371D;
	Thu, 19 Dec 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FP12D/hB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33C22332C
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734606395; cv=none; b=dTmMRsuo/rSdmnWIwM2sqdSobWFiq5lEFUHMdDXNzKUcy7eeIe1v6CuEeljM5juAz2nhNi2kVTnr7S5bfL6mSydz3t9V7S6PfGU5zTh43E1ETaTUnDICMB99Do7cGQ6vOdpjf7LromN+KWG1BiDSi5IwG0xLie412QrfRzBjR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734606395; c=relaxed/simple;
	bh=Nix7oNzVS0hEkh8SpzsarHn1U5KWyr4RwPsc4yfu9mI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DpSk9v73atJ6m2DCVJI2Nh4Q41giRZjK77yxJWRwoVrdL092R1JjcnPySwnvZgGlrPMOYJekvuPrfrdffAZrVA1pb//VCtxxsOKJ2NQMMRCofigrduFjjshkgY8DwFV8mcntW9SFQHyJKVDKICIwDNNxZPX8PqIFoSfmxI5EMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FP12D/hB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ9i2nT000587;
	Thu, 19 Dec 2024 11:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dYWRR8HDMxF+ZlSRUHXmdm
	ZfKg0Bt4ET9lXvmzuhP/M=; b=FP12D/hBSFVQa+rEiC6WAcz6i9dL9vxWq9eeyZ
	+rseN346BDDmUMkxI1lGXhg03MPbhAIesl5qZTpubVXTm/rrl9qRLSs+0x2ebXLn
	IXj3+HxZDlxtdq2L09xhtNSzU6w34BpqWx715vaSzxMJK+Ci9c+nU7Uu/cYFLMCY
	cOgAstXREpOVbXxCeKedyoZ+r36itGbrqmDUbPT0ELZ+504IZjcOh0mK6bfgdVGe
	AT7KNprP90z6pjdWoJrMOjjtRM5nVbVIOpfd7sHSXfQlSg4Yeexo5s+8K/Eu6LAb
	AUYEXgDExV1GHgdYC/YwkAS27/ZewAg9O1xl2Qy/rEVlI3EA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mh3y86cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 11:06:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJB6UrB025166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 11:06:30 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Dec 2024 03:06:28 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 0/2] wifi: ath11k: fix full monitor mode for QCN9074
Date: Thu, 19 Dec 2024 19:05:29 +0800
Message-ID: <20241219110531.2096-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
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
X-Proofpoint-ORIG-GUID: LHp82QKI3R5axrDZSGvxgvnGSt2L1O6O
X-Proofpoint-GUID: LHp82QKI3R5axrDZSGvxgvnGSt2L1O6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=940 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190089

Fix a warning and a bug for full monitor mode. With these two fixes,
full monitor mode can work properly to capture packets on QCN9074.

v4: explain why change the srng definition and initialization.
v3:
    1. add fix tag for all patches.
    2. typo error: occurr/occur.
    3. delete unnecessary Unicode characters in patch #1.
v2:
    1. delete duplicate commit message in patch #1.
    2. explain this fix is for QCN9074.

Kang Yang (1):
  wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode

P Praneesh (1):
  wifi: ath11k: fix RCU stall while reaping monitor destination ring

 drivers/net/wireless/ath/ath11k/dp_rx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


base-commit: 27909c77d085d32db141cbb32b2cc9fbef874197
-- 
2.34.1


