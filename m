Return-Path: <linux-wireless+bounces-21268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1D6A80BB2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 15:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA9A906374
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D35145348;
	Tue,  8 Apr 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O39UlQkK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39239158DD8
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117319; cv=none; b=a/zBu073PKXriZEryO1339zB/S56VAzAtfSw/IJGiGJmX6zsAT4RotSIMOs3KFKtmnJ6fIL2+vBSiZBOTSi6taxtukPBzTn7XBIDGAP0l+Vl4JP7mxMDl0P4PHkT3159+fhyIaOQqY1+NM8o9Zw9YRUPL9b/033WxNAc5ef1qXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117319; c=relaxed/simple;
	bh=YVZ14CKPQMsqgrqGHzVe8Sq+v81R9Q02SXXkFt8rqK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SguHdw712xHVmWw/4a5aN7nZFGj+qZo3L/0uT7NKc7/BXmTTB4inBoYbMZrPFnntKT3P+hoBkM8BDI/ad+Ji/3dg3zj51i9S76z5xcEKDiIk0ehznpzpH/RWn/KeU4OQON5q5HF8g6yDSOtN+4CLzEs2Jiyo8XTSQoxfz3Me9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O39UlQkK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538Bmdkv015965;
	Tue, 8 Apr 2025 13:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LczO5m9Vdozc6Omm7oiHJB
	qtxBUALXTbZ5uRQEtqkhA=; b=O39UlQkK1WTm5kJDTud3jnrBjfHJrhdbd5+769
	dEx/4tpYpD74KBpENt3OEkQGiD8WaEAltrNFtDXLLVMt6HCo5db4ap3nF8owNaL9
	6c5SqB+rJxZno7IDFSYQ5TxPcmpLiM2Qlz4u6Ng2Gqt2D8A0jThlWLMaYqAmUjR5
	+bmT8Hf5ZU5fhl5bPReyzA8Rl5GP/okk97AMbxOJocFoW5N3kf5A3MUP1xsmr8vI
	2lQ5L9nfyV89CleKMrkwCVWbtsAKwZzIBwvqjqcnzAj+nKutMDeWOHiaaai6oxJq
	qV0trtaRTPXZz8Kgn8ouQ8OC+Lu2/nGYOU/qGkoP9fzcneng==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftfq0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 13:01:55 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 538D1sr8028576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 13:01:54 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Apr 2025 06:01:53 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: correctly check RX multicast bit
Date: Tue, 8 Apr 2025 18:31:30 +0530
Message-ID: <20250408130132.2919329-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f51e43 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=0b8t2eLurJbve7txGXYA:9
X-Proofpoint-GUID: VwmgUvZzdjgEWKprs8POanl-ijKXGzak
X-Proofpoint-ORIG-GUID: VwmgUvZzdjgEWKprs8POanl-ijKXGzak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_05,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=523
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080092

Currently, the RX multicast broadcast bit is fetched from the MPDU
start descriptor. However, in some scenarios, the value is not
accurate. Therefore, changing the process to fetch the bit from the
MSDU end descriptor for improved reliability.

Sarika Sharma (2):
  wifi: ath12k: using msdu end descriptor to check for rx multicast
    packets
  wifi: ath12k: correctly handle mcast packets for clients

 drivers/net/wireless/ath/ath12k/dp_rx.c | 5 +++++
 drivers/net/wireless/ath/ath12k/hal.c   | 8 ++++----
 drivers/net/wireless/ath/ath12k/peer.c  | 5 ++++-
 drivers/net/wireless/ath/ath12k/peer.h  | 3 ++-
 4 files changed, 15 insertions(+), 6 deletions(-)


base-commit: ac17b1211841c98a9b4c2900ba2a7f457c80cf90
-- 
2.34.1


