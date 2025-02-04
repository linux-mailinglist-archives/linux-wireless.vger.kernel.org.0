Return-Path: <linux-wireless+bounces-18402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77CA26EA6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 10:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D327A154A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E6207A3A;
	Tue,  4 Feb 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nk0fdvVY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD7207676
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661949; cv=none; b=XrfeWibT0p1x/G2OyCVepsxP5uAZwz4s88CqmPtRCTEj3c5C3jXjlaJofmboeUxd4v7IsEhNLHzIxQIf/RrEkk1nO67xsZuko+Qi5HuZKLLlgyNEUrYolKJYPXql2lP4U19PSqm0I+U4knL9nL2MgT7zstOTgVgdqkBovOo02AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661949; c=relaxed/simple;
	bh=3JsOo5e2k45SkuYvB+IODqGxuf/XrOylzcfPNiL+NCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sVczb2l4r9y9JT9P68g508lIRCFX5+yHMKYOr2jqK2iMEBJtB4MysNCwA1IYDA13OYDgBeY8Emv10vJZYbvyIptlV3/8AwwF5+//8kbOm2iX5NZIhcIwNyek0eG0oXjXDX+LIcvC0nh2ZK3g3N6Ztcbo2N7xjuXQ6h7wxpmfyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nk0fdvVY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5141Blxe021352;
	Tue, 4 Feb 2025 09:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VDH708nq/0zC/3U8ctx5si
	ds7bJpkR6KcCz5QV8TIik=; b=Nk0fdvVYAcUU4qBP31bhp5MY9X/sERNFJxzBNL
	PWFW6UZf9ktSOom8mUvYck0zSgt7YLkkqQUpReRW/EhWrTYh04UvLvIYr5YId6dO
	Eri2Z0Ozl57EvaZ6sGpJtGTQWFXv9cwr5REo8BE/9ZXYd7zyE53D1AV32a20EdZF
	xKBdz7TCTmqDeldfqh7eaLe4cCHlKqR/WVn7iyByFS3AKZ/4XO+pAnm9id+1QTcs
	3vFCP1t44WD/mdhUax2QDLAJAI0cvfx12CmYliwEfrbYqmDEhiIoSdquqAPStu2G
	Ny4muNmP29CO7xWxByKiyY0qHivvMKiI783V+uxAYq0AmPFg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k911gypr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 09:39:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5149d2fc018238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 09:39:02 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Feb 2025 01:39:01 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v4 0/7] wifi: ath12k: Add monitor interface support on QCN9274
Date: Tue, 4 Feb 2025 15:06:49 +0530
Message-ID: <20250204093656.3682278-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: UyrGVbo8lqrnvu1rPJcnkPUsmXai586I
X-Proofpoint-ORIG-GUID: UyrGVbo8lqrnvu1rPJcnkPUsmXai586I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=982
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040077

Currently, monitor interface not supported. Therefore, add the missed TLV
tags parsing in the monitor parser, configure the monitor vdev state
identifier with HTT filter setup.

Depends-On:
	[PATCH v8 0/9] wifi: ath12k: Add peer extended Rx statistics debugfs support
	https://lore.kernel.org/all/20250204035718.3227726-1-quic_periyasa@quicinc.com/

v4:
 - Rebased on ToT
 wifi: ath12k: Replace band define G with GHZ where appropriate
  - Dropped the tags due to rebase changes
v3:
 - rebased to ToT
v2:
 wifi: ath12k: add monitor interface support on QCN9274
  - remove redundant filter setting in ath12k_mac_monitor_start()
  - set the default filter when the htt monitor configuration get disable

Hari Chandrakanthan (1):
  wifi: ath12k: fix link valid field initialization in the monitor Rx

Karthikeyan Periyasamy (1):
  wifi: ath12k: Replace band define G with GHZ where appropriate

P Praneesh (5):
  wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
  wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
  wifi: ath12k: change the status update in the monitor Rx
  wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
  wifi: ath12k: add monitor interface support on QCN9274

 drivers/net/wireless/ath/ath12k/core.c    |   5 +
 drivers/net/wireless/ath/ath12k/core.h    |  18 +-
 drivers/net/wireless/ath/ath12k/debugfs.c |   4 +-
 drivers/net/wireless/ath/ath12k/dp.h      |   4 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c  | 362 ++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/dp_mon.h  |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   |   5 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c   |   8 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h  |  15 +-
 drivers/net/wireless/ath/ath12k/hw.c      |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c     |  74 +++--
 drivers/net/wireless/ath/ath12k/wmi.c     |  36 +--
 drivers/net/wireless/ath/ath12k/wmi.h     |  16 +-
 13 files changed, 435 insertions(+), 121 deletions(-)


base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9
prerequisite-patch-id: e5e05751e1a2a54b5c705222ef05a5f76cbd6858
prerequisite-patch-id: f503436fb6fa4e65cbbb0b52dcb1ab41b65d6e2b
prerequisite-patch-id: 5651ab3bfa84c40524c70a55f821b6a884908de7
prerequisite-patch-id: 4b6f75cfa4d25f974f8fa61adbc85fff35a187fa
prerequisite-patch-id: 6a015b7d89f3d61adb5d60eff2d63fea10d9c3b0
prerequisite-patch-id: afba80a88de0869ade8954c32ebbec407608a1c0
prerequisite-patch-id: 12367e8ecdccf254c41bd0518cea6877e4673bb3
prerequisite-patch-id: d94f4a9c9b0b3bdc9e709efcae0cba4983bf440f
prerequisite-patch-id: d777e315103b196f906c853881ca666a0423c8f6
-- 
2.34.1


