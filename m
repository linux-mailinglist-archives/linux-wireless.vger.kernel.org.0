Return-Path: <linux-wireless+bounces-11922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D87095E674
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 03:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594702811E0
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 01:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3391A5256;
	Mon, 26 Aug 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LBrriOwT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A194A11
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637017; cv=none; b=EUiPvkMUgP1U3uXz432D/dnLvz1ZWMloieqg7Styk/TYUXH50/SM43ESJy3x/J03EbT5odfiILsiuAC9JZ+zurry2lcLNBH44XllIPR0tODsZUB6uw2LFuPJIku4sf5rYoOLS1sTVp7Bh+6sfHtxFqCe0Udnl8VcCEOrJm5NUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637017; c=relaxed/simple;
	bh=G7eb7EXfM7vTw1Wey8ehAcPd9pfDMXy4cgmojcYwqgw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GRbD5ypxex5eaeajwfcF3DOBQ8yTiYC5fkYbp+Ng2TTFXLz1tV7y1ShBO1g4cYHaoOd5yfYbjgIda4nAL+nJM2tDRAXHx3ZSWkeTm8hNNXStCNE0mCRfYSe8lBsspR3814Abh7KPeGJzhFMfHCg6iBWeD79pZzgQG3onVIeCN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LBrriOwT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PMVqbM031820;
	Mon, 26 Aug 2024 01:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yzA8JSeNjFP7XSu/UCIW+O
	kfVBkGyPITHBjSdUsewMc=; b=LBrriOwTsKUgpEj+snAXw4c0HHzPlKr20O6SqO
	Kgvs3zQ81vi3oFDx5atuUGVTJB8nJGPrlbgNazlq4PW6j5PCRnxfXOfa5itINGD7
	2Epn26ELfVPv1NW23XpZ6OApgrw3zvA1n+Iba2FoKtAqSYoNtp7GK/CArOu92znj
	KkrQE1Dr+skkkTomHqgXliTEhPjuEANCCNKULonjivMbRaqI9vDjaoO4cfYTTU4u
	m5yvYZOSd9n+uGWUqVQqx9y/FVD+3JEoNFiFyqNfNFjvC4ZSOk9p/olIkWpr4aRu
	rUKsuWJ8G3m4B5pS2N2eK5PwsvPA2IX+P9XeBJ2JPbz1bGRw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41798et679-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 01:50:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47Q1o2PH030244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 01:50:02 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 25 Aug
 2024 18:50:01 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 0/3] wifi: ath11k: fix memory leak in reset scenario
Date: Mon, 26 Aug 2024 09:49:39 +0800
Message-ID: <20240826014942.87783-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: UNgOCNQ_JFhg_wwcXhjxz_PDjvvkIuw9
X-Proofpoint-ORIG-GUID: UNgOCNQ_JFhg_wwcXhjxz_PDjvvkIuw9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_20,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=665
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408260012

ath11k_peer::tfm_mmic and ath11k_sta::rx_stats/tx_stats are leaked
in reset scenario, fix them.

Baochen Qiang (3):
  wifi: ath11k: refactor ath11k_dp_peer_cleanup()
  wifi: ath11k: fix leaking peer->tfm_mmic in reset scenario
  wifi: ath11k: fix leaking station RX/TX stats in reset scenario

 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/dp.c   |  5 ++---
 drivers/net/wireless/ath/ath11k/mac.c  | 31 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/mac.h  |  3 ++-
 4 files changed, 30 insertions(+), 10 deletions(-)


base-commit: 8fb3b2b8d6d489416a7ff8a28cd4083340ad9e55
-- 
2.25.1


