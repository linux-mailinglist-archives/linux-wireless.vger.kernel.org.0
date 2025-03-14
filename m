Return-Path: <linux-wireless+bounces-20384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9070AA61416
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 15:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A1117C9AC
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B530201013;
	Fri, 14 Mar 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fCXzoe1H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF1D1A83F2
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963860; cv=none; b=oyyXLruMwg2waMes7Y2894j7Xl/FCfSNCIWMokR6z05zj39emeJlw6186BiXbbk9q+Xdj6aODWSjrbnigjlMEC+L1Tcbs5QJQFzez6qu6gunZGC1JGT4M4UCkGWs1tOtWxw3Hz/r99pq1nnjxR2XpXMELTBhjPYf0HyaT87rin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963860; c=relaxed/simple;
	bh=0R4EAvQ+4oIhHkYJqfLqNih127xqsH5JaBlBr4u71nE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BvC7daZXVRC7pl0jwjwy+rLLucNF7ECYqfoPC5dMrYXN6wt7ZQpg/PT7NE+m1m6ClXnNyUbdA1S4ANEwyT6YuWWucu0zeRnag3OTbiB48DAzoFry8Eltew4clGVUcEP8noC2OE4nEdh9NuchtLS/iAB7ErXBR+P9ImX5b3qehLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fCXzoe1H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBTkjF009124;
	Fri, 14 Mar 2025 14:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=63kCCC8AmsDeW6TPbWRgdh
	j99LFqnNmSkCbJ3DJV7Dk=; b=fCXzoe1HcYhlNGURY+K5DurbgcQnFeZQKTnTdC
	ypaze52ZC/DnZSTS6t7rqiguSNrU+3CcgcfGVNNTdB1RM6YVn9IkTaJE/tLigyyK
	HbGqPZDbBn0hYGSidTyvK22bjexcL0hfS01rQa/ynBJIa7XPJncrNChqEHARFvRQ
	sHIkVRtiPx+bnZL/DdbZCvmGjUdg5ezpRDN1SIrfIzugrC/nbyxuh/jG/+nbSZHY
	rsfhrl8YszL9c/oHZjKqvyuGx++qdxtJ+AddMJF7kWLVW+i+B6QS/frQJqfQp8r8
	t65WttFbvk9+dC3j13b5YT8uGiwgUxsahgPgZ4jVLWSJQOaw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2rhhhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:50:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52EEosMf014803
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:50:54 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 14 Mar 2025 07:50:52 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v10 0/9] wifi: ath12k: Add monitor interface support on QCN9274
Date: Fri, 14 Mar 2025 20:20:28 +0530
Message-ID: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=D6NHKuRj c=1 sm=1 tr=0 ts=67d4424f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=drny9eR6pwTjfYRCe2kA:9
X-Proofpoint-GUID: LXPEU3vWekx5nKKjU9G0ugw_pguObpRn
X-Proofpoint-ORIG-GUID: LXPEU3vWekx5nKKjU9G0ugw_pguObpRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=948 clxscore=1015 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140117

Currently, monitor interface not supported. Therefore, add the missed TLV
tags parsing in the monitor parser, configure the monitor vdev state
identifier with HTT filter setup.

v10:
 wifi: ath12k: add monitor interface support on QCN9274
  - Cleanup the VIRTUAL_MONITOR handler procedures
  - Removed "Reviewed-by" tag
v9:
 wifi: ath12k: fix NULL access in assign channel context handler
  - Updated the commit message
 wifi: ath12k: add monitor interface support on QCN9274
  - Removed the mac80211 callback config handler procedure
  - Removed "Reviewed-by" tag
v8:
 wifi: ath12k: add monitor interface support on QCN9274
  - Added comment section for restricting one monitor i/f in each radio
v7:
 wifi: ath12k: Refactor the monitor channel context procedure
  - Added new patch to avoid multiple change in a patch
 wifi: ath12k: fix NULL access in assign channel context handler
  - Added fixes tag
v6:
 wifi: ath12k: fix NULL access in assign channel context handler
  - Added new patch
 wifi: ath12k: add monitor interface support on QCN9274
  - Moved to NO_VIRTUAL_MONITOR mac80211 feature for adapting single wiphy usecase
  - Removed tags
v5:
 - updated the s-o-b as a last tag
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

Karthikeyan Periyasamy (3):
  wifi: ath12k: Replace band define G with GHZ where appropriate
  wifi: ath12k: fix NULL access in assign channel context handler
  wifi: ath12k: Refactor the monitor channel context procedure

P Praneesh (5):
  wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
  wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
  wifi: ath12k: change the status update in the monitor Rx
  wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
  wifi: ath12k: add monitor interface support on QCN9274

 drivers/net/wireless/ath/ath12k/core.c    |   4 +
 drivers/net/wireless/ath/ath12k/core.h    |  19 +-
 drivers/net/wireless/ath/ath12k/debugfs.c |   4 +-
 drivers/net/wireless/ath/ath12k/dp.h      |   2 +
 drivers/net/wireless/ath/ath12k/dp_mon.c  | 362 ++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/dp_mon.h  |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c   |   6 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c   |   6 +
 drivers/net/wireless/ath/ath12k/hal_rx.h  |  15 +-
 drivers/net/wireless/ath/ath12k/hw.c      |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c     | 224 ++++---------
 drivers/net/wireless/ath/ath12k/wmi.c     |  36 +--
 drivers/net/wireless/ath/ath12k/wmi.h     |  16 +-
 13 files changed, 452 insertions(+), 251 deletions(-)


base-commit: 42aa76e608ca845c98e79f9e23af0bdb07b2eb1d
-- 
2.34.1


