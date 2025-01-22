Return-Path: <linux-wireless+bounces-17800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFEA1891D
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 01:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4CA16B487
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6A749C;
	Wed, 22 Jan 2025 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ksfv/Zyp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07C22615
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737506891; cv=none; b=t9ry9MkRdRq+I3WI3XE6XqNXYDaiEIXF0ts8eQisF/ug+Tt0298IXbh/ZKa2XB/uiwONV+xK/rdUBxFDY/PvN5aUh1XnIHFDRodewuuzUBZkPGHwNGmvc5pVR0r8hXknXxVJDbd68sfBbT0EMAWkEWUkWquBe+gcH68AzVvWMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737506891; c=relaxed/simple;
	bh=g316UeWgLd62enRyTp2qNe47DjUTtR12MA0mDQHrAFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bMmmEaquw4SxuMpuBleT99SkWYosnhdc0fH1XHAeNCGWjdrbl9sHNCfmR8OmlgUehIuZvZFuYCqG+UNTiQSlBcSkfArT9/bOttn/7PTsqyNzRCgf4UE1JN9ing7mmO/NbyAAFowucOC60/rl6cDWQV/KjwGTtvNutmSLwD5rh7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ksfv/Zyp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LHvZFa018671;
	Wed, 22 Jan 2025 00:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2YYAB/ep/YZZppUkqlI22N
	/igoxz27uWM1GzbyhfFfo=; b=Ksfv/ZypuxZ3spClpqchRRgPtd05mi23e4X9qX
	bkB80yB6AetcIJZ3b/ZuTYQqepSEPo7Iam/ZmTihau/5ckHwJs5qWTMOUgJgpcmz
	2wzYtDlXkFkwYvMOn/hCCjI7dze1TWqf9nsxJZocaAd2sVmRb4jjXUOrklckqwlh
	sLMSYoba58HOI9xgwmbvGMnY+wEOYoHAs1UKDqVvUbCmfxLEdumze7CrXERYtKT5
	hAC2lvfK99lhLq4xqERlrfv7736+5882HqQN3FLxNURcmKJpK8Tze8MUtKSYb9Cr
	KiqnWCdI33RkKedSenfqQQ/GHh/Xm56BmTb6kXZHVzVHea+w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44agej8tw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 00:48:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50M0m5mF018057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 00:48:05 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 Jan 2025 16:48:04 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v4 00/10] wifi: ath12k: Add peer extended Rx statistics debugfs support
Date: Wed, 22 Jan 2025 06:17:37 +0530
Message-ID: <20250122004747.488438-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: l_n8y9C1JNm95yRmqM8WuI_h33NkStSe
X-Proofpoint-GUID: l_n8y9C1JNm95yRmqM8WuI_h33NkStSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_10,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=721 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220003

Currently, peer extended Rx statistics are not supported. Peer extended Rx
statistics are collected form the TLV data reported in the monitor status
Rx path. Therefore, add support for TLV tag parser handling and debugfs
to configure and dump the collected information. Additionally, this series
does not impact the WCN7850.

Depends-On:
	[PATCH v2 00/14] wifi: ath12k: Enable monitor ring for updating station dump in QCN9274
	https://lore.kernel.org/all/20241223060132.3506372-1-quic_ppranees@quicinc.com/

v4:
 wifi: ath12k: Add peer extended Rx statistics debugfs support
  - fixed the kernel test robot noticed build errors
v3:
 wifi: ath12k: Add peer extended Rx statistics debugfs support
  - avoid ext_rx_stats filter overwrite in default filter setting
v2:
 wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
 wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
  - fixed the length calculation in the EHT radiotap procedure

Balamurugan Mahalingam (2):
  wifi: ath12k: Add EHT MCS support in Extended Rx statistics
  wifi: ath12k: Refactor the format of peer rate table information

Karthikeyan Periyasamy (7):
  wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
  wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
  wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
  wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
  wifi: ath12k: Update the peer id in PPDU end user stats TLV
  wifi: ath12k: Add EHT rate statistics support
  wifi: ath12k: Add peer extended Rx statistics debugfs support

P Praneesh (1):
  wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV

 drivers/net/wireless/ath/ath12k/Makefile      |    2 +-
 drivers/net/wireless/ath/ath12k/core.h        |   11 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |  100 +-
 drivers/net/wireless/ath/ath12k/debugfs.h     |   21 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c |  337 ++++++
 drivers/net/wireless/ath/ath12k/debugfs_sta.h |   24 +
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 1064 ++++++++++++++++-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |   15 +
 drivers/net/wireless/ath/ath12k/hal_rx.h      |  433 ++++++-
 drivers/net/wireless/ath/ath12k/mac.c         |   19 +-
 drivers/net/wireless/ath/ath12k/mac.h         |    6 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h     |   10 +-
 12 files changed, 1977 insertions(+), 65 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.h


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
-- 
2.34.1


