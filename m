Return-Path: <linux-wireless+bounces-9976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823AA927042
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 09:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4B81C23082
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 07:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE06D1A0B15;
	Thu,  4 Jul 2024 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nzHX7g+d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFAB1A01DE
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076913; cv=none; b=R+vblF7ZOLkwxgSWhwIHSQFMeJAMDY+T+fEB2y+VuiMNyFXOCCEBoHtwiaFeCWwhvqFJAnT3OvAgvWqrUYBY8fCNa8Ma8bCG3ezJmS8HQpdh/9r3oA54jODyMmpZut7J/zbXEmVNzxW5FnbNq2rc8B8MsSTcGlPsYpHA/yVDsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076913; c=relaxed/simple;
	bh=RCUyiIo4H9tyyGk5E2oEGHnEEcfgnVxpNM7yAgbYx1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YkZmR1ke5oH7mDXRWgSd/Ys2vVTOP3PCqkRBHQJvy6bKTKQHsSp9iuK6CFO4ba1jituOpVz47Hd5aurqAY7nNiAUQ3JA5Ei+nl7WTJexA1ZKef4UwzV2h4XNbM9J1cEHYf4pBTBJoRWmXdKzjr8pHwVUpEpUJ0Vo7RNt+cC5T1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nzHX7g+d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46456ZYP028782;
	Thu, 4 Jul 2024 07:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Fpf6ldYby2oCoSpJ7VUUZl
	SNSzrqGhya2sV4U4VfUks=; b=nzHX7g+dgU62/ej0wCzQbhqdghk4+3IxKEdyFB
	zIB9lQJ81JQGQbrqb7ppXF3Pqgx5sBwhyBR9iikxaXcU82TYrGD2RynLoQvwU8Bo
	LAcwO3RknCWrtTtzvKP4+udrfz2F9mjCqApxYbm1pWadAXCMEey8CSlnnqSWLPVZ
	351F4vh6M+I6vcO+eL0GESCDZlMUB/TOgBFTc9V65Dj3DJ+qyycddN3/NNFj5sUz
	slg61+KDrJaU5Z1u/kTPc39/GIhCrkNn5ZVGwpnGayg++/uR8ncCqdXyeB3FnABy
	wR8S4hSbG/oJA/GjForVSBqsM+rzmnN5KIyRhg19j7eUjcjA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404kctmwh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 07:08:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46478Q5l016437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 07:08:26 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 4 Jul 2024 00:08:24 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/2] wifi: ath: fix array out-of-bound access in SoC stats
Date: Thu, 4 Jul 2024 12:38:09 +0530
Message-ID: <20240704070811.4186543-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: d-jJzWX5qH7e9uVzJSUxK4yHCwdnoHyK
X-Proofpoint-ORIG-GUID: d-jJzWX5qH7e9uVzJSUxK4yHCwdnoHyK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=542 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040050

Currently, hal_reo_error access lead to array out-of-bound issue. Fix this
issue by modifying the Rx data path handler to use the ring ID directly
instead of the SRNG ring ID.

Karthikeyan Periyasamy (2):
  wifi: ath12k: fix array out-of-bound access in SoC stats
  wifi: ath11k: fix array out-of-bound access in SoC stats

 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 73adcb561600d84aa21e06486766ca0ce64fc5a6
-- 
2.34.1


