Return-Path: <linux-wireless+bounces-17703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519BCA162A3
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 16:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF51632AE
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1C1DF727;
	Sun, 19 Jan 2025 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R3SK0rv9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1E1DF26F
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737300581; cv=none; b=RGxgjxrNf1LLyWEDWE+Eur0X/6m9j3yxfFmyaglwC3pYx92odaYAIGVpHmoYtx0xjLdYZCNifXEGm5HyevYrV4T6mooeEx5oITiQ3efPFw5KDHzWafShqd/PytCjGavrOnlbacc+PrUIOpW9XimZpBqRGDUeg9J5bmym/cxK6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737300581; c=relaxed/simple;
	bh=VZCeuKYqgDeySIq9cMF+Un5LsqOJoIPcN8JzNTnt2Oo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e/QQteLDZbDCOeMs/9CEwH95BhurPDIJdMzBBN9rmEThjTpygoJrDpM07CNrhwA5aFuDqFnGUZDm88BsFsJwA17pIzf3FsaxYKnnopQw5IuqN1DHkM2NOK3ER5S5IIenxg0DXEtTsd9R/61xNC0hHWajWeIENhNPmYNDem5TcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R3SK0rv9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50JE2sKQ027395;
	Sun, 19 Jan 2025 15:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eG5QH9yGPTX98iRAGgjbG7
	esMMFlsbLgulNsfSc9oiY=; b=R3SK0rv98/Jas9Mtbp2IFs9dADJVDUoCN98jun
	SiF10DXSJcxjhhkvohGi6erCRh993stXZ/373bkhkdkrxsIc7NOwmKB5pmdKM57/
	KKsZGfibD99Rfgu8SBvlPOLKzTxyvR3ACkhNovgqIsyuo6/ZkPyF1mKaQSdmjmIr
	RbaihIVTieZ20aZh9cRsR2OjYs3FTxdcpNR/20JJOV4CvnVXwca6gMfpVwDLL1Yi
	kn7Vzw0Jq3c3ow3OcAwdFUmq5M095Wb0e0hXZ0GjCuGABCt/0cuSepEFN8nioZq8
	SiSL1lLdH7KVZqqSlWquFcsnNRN590Vzk336+IlzShQIoldw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4492tg82ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jan 2025 15:29:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50JFTYrp006873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jan 2025 15:29:34 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 Jan 2025 07:29:32 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/7] wifi: ath12k: Add monitor interface support on QCN9274
Date: Sun, 19 Jan 2025 20:59:10 +0530
Message-ID: <20250119152917.2316514-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: ZGBjg76FCzUJ4BFAKINYXFh23KoR79WG
X-Proofpoint-ORIG-GUID: ZGBjg76FCzUJ4BFAKINYXFh23KoR79WG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-19_02,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501190120

Currently, monitor interface not supported. Therefore, add the missed TLV
tags parsing in the monitor parser, configure the monitor vdev state
identifier with HTT filter setup.

Depends-On:
	[PATCH v2 00/14] wifi: ath12k: Enable monitor ring for updating station dump in QCN9274
	https://lore.kernel.org/all/20241223060132.3506372-1-quic_ppranees@quicinc.com/

	[PATCH v3 00/10] wifi: ath12k: Add peer extended Rx statistics debugfs support
	https://lore.kernel.org/all/20250119135751.2221902-1-quic_periyasa@quicinc.com/

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

 drivers/net/wireless/ath/ath12k/core.c   |   5 +
 drivers/net/wireless/ath/ath12k/core.h   |  18 +-
 drivers/net/wireless/ath/ath12k/dp.h     |   4 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c | 362 +++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/dp_mon.h |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |   7 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  |   8 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h |  17 +-
 drivers/net/wireless/ath/ath12k/hw.c     |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c    |  74 +++--
 drivers/net/wireless/ath/ath12k/wmi.c    |  38 +--
 drivers/net/wireless/ath/ath12k/wmi.h    |  20 +-
 12 files changed, 438 insertions(+), 124 deletions(-)


base-commit: e7ef944b3e2c31b608800925e784f67596375770
prerequisite-patch-id: afb04ab90da26435239077de723d1276946a194a
prerequisite-patch-id: 1b12bea72973c14f461b8202eed9432f27932876
prerequisite-patch-id: a6719494f46b8568504be8c64255676e67b4deda
prerequisite-patch-id: 054756eb1705babff324a743e62685bb78035198
prerequisite-patch-id: 889c4a0174fac23261705a42b46e923d7e7a0a18
prerequisite-patch-id: ea0321fbd8a59c09191873f59b6aea8225f4b8e5
prerequisite-patch-id: 3c8ccb635d319f8755649e445b68feb615fd82c4
prerequisite-patch-id: d516b2a3196218f42fdf4567516a1fd2c8b4c40f
prerequisite-patch-id: a2c59b4e468384e27d934a986e5fe9a951685fd9
prerequisite-patch-id: 359fecf93ef53f39243cc1b3466ab06fbd33cc71
prerequisite-patch-id: bf0b6542c65299c0bfa7fef2da6f09dd8453c39f
prerequisite-patch-id: 1dc79cafb399be590d1e418afcc5a719ae35834f
prerequisite-patch-id: fb1e39f2dce024ff692b0e6b112dc90c6a43ad00
prerequisite-patch-id: 9ea3943ae0b6e6a5a09cb648eaa35f8087967ac3
prerequisite-patch-id: 35da9ccb2466675b50e819029c13cbda70702fc2
prerequisite-patch-id: 282cdacca7b9bbef5a94b1a78457304d38362af2
prerequisite-patch-id: 5bdb2bd29cd4c92d23708432f451e92951c23f0e
prerequisite-patch-id: 4b6f75cfa4d25f974f8fa61adbc85fff35a187fa
prerequisite-patch-id: 6a015b7d89f3d61adb5d60eff2d63fea10d9c3b0
prerequisite-patch-id: afba80a88de0869ade8954c32ebbec407608a1c0
prerequisite-patch-id: 12367e8ecdccf254c41bd0518cea6877e4673bb3
prerequisite-patch-id: d94f4a9c9b0b3bdc9e709efcae0cba4983bf440f
prerequisite-patch-id: 8c9df1e16a25c3b9a3fb709ba9bc8d37e6f14a5e
prerequisite-patch-id: 8db0be3595dc82725d9a195f3239402b9062d9f3
-- 
2.34.1


