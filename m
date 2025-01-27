Return-Path: <linux-wireless+bounces-18014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D50CAA1D57B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 12:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3915B7A3CB3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769F01FE47C;
	Mon, 27 Jan 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bc8qg6G7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DD1FCFD6
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737978053; cv=none; b=HObtphAohn2iTNW1zdB3VofhyhJ6ckc5A+j/pOnz9oYMdDEv2gt2S0u8OCrJIKny/ClsQHoIPz0Xj8aF1bJZsV78pEbQcO0VhjlstkkRSMy83+KAID1W5Au8e+RPo7wy3Rqhe5lFGHXdkM1XNGDtrjMsDlYYbi9fByLiRvDt9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737978053; c=relaxed/simple;
	bh=XzDyb0SoXYMPO7ka3GGjbpHUvQoo/rtacUiNJU+BVt0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p1fcP/SYSUTdT6FM5YoDS4/VsyDxbwUYS2sY+D8iI9GjoLmhS2feOVDzd1+ZfpC9QcJjS8tr09C1+RFBUzfm8hVGUDz0JPUxjmVl+U48ZOi2aj6G2r7gu/KXZal4UOHWd7l0uE+waxrHpvHiwFglfRMwe245SwnCnQ91+M/Fb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bc8qg6G7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R7guZv028354;
	Mon, 27 Jan 2025 11:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=97CUAojE+94GFYYqABsGes
	Ylv+q9ifh096u9VztM3Y4=; b=Bc8qg6G7Fb5m11KSguF0to3fJfniDv1h1TOOxn
	3I3xUDxi2cmNS02LQllJgHOckhKK4UCuslMBLEYTceVrTwdPbuQTIy+TcCQF3Xxp
	d53rMxfFmItRr4hbSsbqTNrT2NNYogd4rPpC69tL4RjV34ACyme7kgRr6jhn6+Rd
	sgGc7ReQJxUbQZa23UDW7IPGMkGW/fIOIAvzBBgBF9RgK/wsCPaxE4R3hA5ekv/h
	U+4BV7ISk48OIaPb6I1jmS5XznJwz5Ua5XP7CjJr1hiZsMaSLRd4YaLlL8au3qrd
	yVRFLalNFqj1Dn1VSFvNR3XiLe2+1bcyn7c0bSFQpbDicSug==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e60bgj08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 11:40:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50RBelcT029294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 11:40:47 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 03:40:45 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 0/7] wifi: ath12k: Add monitor interface support on QCN9274
Date: Mon, 27 Jan 2025 17:10:23 +0530
Message-ID: <20250127114030.43479-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: ZssVxsH2eK89s3HUHJ_H2UqtusjKwht2
X-Proofpoint-ORIG-GUID: ZssVxsH2eK89s3HUHJ_H2UqtusjKwht2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_05,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270093

Currently, monitor interface not supported. Therefore, add the missed TLV
tags parsing in the monitor parser, configure the monitor vdev state
identifier with HTT filter setup.

Depends-On:
	[PATCH v5 0/9] wifi: ath12k: Add peer extended Rx statistics debugfs support
	https://lore.kernel.org/all/20250127104738.4174862-1-quic_periyasa@quicinc.com/

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

 drivers/net/wireless/ath/ath12k/core.c   |   5 +
 drivers/net/wireless/ath/ath12k/core.h   |  18 +-
 drivers/net/wireless/ath/ath12k/dp.h     |   4 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c | 362 +++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/dp_mon.h |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  |   5 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c  |   8 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h |  15 +-
 drivers/net/wireless/ath/ath12k/hw.c     |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c    |  74 +++--
 drivers/net/wireless/ath/ath12k/wmi.c    |  36 +--
 drivers/net/wireless/ath/ath12k/wmi.h    |  16 +-
 12 files changed, 433 insertions(+), 119 deletions(-)


base-commit: 5e40b6ac64339a78a5fbf1009581aa43eb46c352
prerequisite-patch-id: 35da9ccb2466675b50e819029c13cbda70702fc2
prerequisite-patch-id: 282cdacca7b9bbef5a94b1a78457304d38362af2
prerequisite-patch-id: d3c166741daffb6146761fef32d461daa4c0ee24
prerequisite-patch-id: 4b6f75cfa4d25f974f8fa61adbc85fff35a187fa
prerequisite-patch-id: 6a015b7d89f3d61adb5d60eff2d63fea10d9c3b0
prerequisite-patch-id: afba80a88de0869ade8954c32ebbec407608a1c0
prerequisite-patch-id: 12367e8ecdccf254c41bd0518cea6877e4673bb3
prerequisite-patch-id: d94f4a9c9b0b3bdc9e709efcae0cba4983bf440f
prerequisite-patch-id: 94f33bdde5bbe31cd2668fa840bf5b3c9a1c2a7a
-- 
2.34.1


