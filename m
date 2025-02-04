Return-Path: <linux-wireless+bounces-18338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE5A26ACD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C295E3A46CD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00215A856;
	Tue,  4 Feb 2025 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iOemJuIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8528741A8F
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 03:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641045; cv=none; b=Xt9cEzV1BP0x0sK60Fopt5Uc45RqxcDlsbzySTuGQ3YWQeJvAkDO+GFYz69scHRfVrmyU4TkMzQlX6G7oumnQRKiF4LS88zY2QzhPkGFRm1ISQ9BkAfWiy3I34YqGtuVz8p6NZklZbiFTCWIyeloIKN0D0LL2ET01FK1Y9y43FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641045; c=relaxed/simple;
	bh=q0kn6tbpf1xpROxJ9NOhihX0zw1rSS+xu4GDMlyds/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bu2UE3Fh+H075eqfWYo7BtL0I60h1ScRQBY5Cfl7UnN0a5Ywudqu3ZdWiKn6tgfrlz+4zLwIwHb6Pn4qO83Qdc5ZnbkcQ0swzzajE42ExfHbr+g1dwoAPUCiTVRoaqfPR+KclR5v8PccUohADBPufghpK45Lsvvte4duTf+kEsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iOemJuIt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQjqW027019;
	Tue, 4 Feb 2025 03:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IDLGWVSf7MYwArAQ5dXd6e
	0OogI9aNOf4I8AG05xzFo=; b=iOemJuIt5GJxq2T/vjNoLM4STe6ayK4sQ27b5t
	WmC9chFc3CE83OXWHCH1enGk5DfZJW0ZRUHTqDX4ZiAF8aRPFZ6ahfDFlmxzIxAD
	Tug0llkZOTJbJ87HtosKLEcDFf2IEFEAOMtUYzqxmHbFluk++X6b+OSIMwVDTAz+
	cCxO6cFxAoMhgBt+sKoJGnEiRULmjCZMGfYL3cml19r9hUHdcxjk3A26OiNtUzSq
	gdPJgMnRAY5EIgaGhpRfybdDPmgJgsTPFjDduaBxkCm59MnDBCVY8yVpZ3ZvpC+k
	phLHleg/6JeD5GUq526FBw8E3/8VItonBDbd21Bxp/bn/8Lg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufrrew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 03:50:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5143odOj014733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 03:50:39 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 19:50:37 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v7 0/9] wifi: ath12k: Add peer extended Rx statistics debugfs support
Date: Tue, 4 Feb 2025 09:20:15 +0530
Message-ID: <20250204035022.3227100-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 9pOx2yR7yaFmBj2cwchbiYn9nMDgCDq5
X-Proofpoint-ORIG-GUID: 9pOx2yR7yaFmBj2cwchbiYn9nMDgCDq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=820
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040027

Currently, peer extended Rx statistics are not supported. Peer extended Rx
statistics are collected form the TLV data reported in the monitor status
Rx path. Therefore, add support for TLV tag parser handling and debugfs
to configure and dump the collected information. Additionally, this series
does not impact the WCN7850.

v7:
 - Rebased on ToT
v6:
 wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
 wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
 wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
  - modified the return type as void
v5:
 Removed the patch "wifi: ath12k: Add EHT rate statistics support" since it
 is already merged
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

Karthikeyan Periyasamy (6):
  wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
  wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
  wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
  wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
  wifi: ath12k: Update the peer id in PPDU end user stats TLV
  wifi: ath12k: Add peer extended Rx statistics debugfs support

P Praneesh (1):
  wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV

 drivers/net/wireless/ath/ath12k/Makefile      |    2 +-
 drivers/net/wireless/ath/ath12k/core.h        |   10 +-
 drivers/net/wireless/ath/ath12k/debugfs.c     |   97 ++
 drivers/net/wireless/ath/ath12k/debugfs.h     |   21 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c |  337 ++++++
 drivers/net/wireless/ath/ath12k/debugfs_sta.h |   24 +
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 1033 ++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_rx.h      |  433 ++++++-
 drivers/net/wireless/ath/ath12k/mac.c         |   18 +-
 drivers/net/wireless/ath/ath12k/mac.h         |    4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h     |    9 -
 11 files changed, 1924 insertions(+), 64 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.h


base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9
-- 
2.34.1


