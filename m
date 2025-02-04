Return-Path: <linux-wireless+bounces-18352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A88A26ADE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD23A42A4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 03:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB015E5D4;
	Tue,  4 Feb 2025 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C0g69JHV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10815DBBA
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641459; cv=none; b=trSupEeWaynb3F0t5+X/MreDl9dsIx9EVbyIomaNS0jgaoETbgf6TdpW/ctPwvPrrSD1KKEeaXDfcKvO8bHZRgOVNHqkpXqq0k9cVJd2jfdb8FxhhQx81RajyPLagbkibDpfmaeZs+cH1rZWLCEB3065+R4rm0FIUl33HtOxYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641459; c=relaxed/simple;
	bh=byaATgad/qeqTdwU5HQjDtAF0Lt33Ks5LI+xeAS8Pwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SHRwUu8GFfIzAOf4vZZsPRXanCAIC/Wr2BFuaeg4sp1rwgvsE1HQj1Vt4vlF6S8BXln8QJhMzi2q5SM6Rs9fs+elU2Va2H+3XogymOaM2ONyaAfUP6Pdz8GZz7W6giyjPvlycWwhZtyxJUnlcduf3DQuj88/axTw/JZEgbtUxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C0g69JHV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5141aQRA003779;
	Tue, 4 Feb 2025 03:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5MNGgrxgMnuwaOtzYSFJU6
	X2x2ArJRyBfH3ty2W8J20=; b=C0g69JHVJS5oOl8VOTdnOd58uY0JZSdZy18mbB
	n+lJmRsNFxijQUrwhVd+KYJmivbzIxBQgyFfiVelDDsEyjA//PUZ5f9cuxsArYMs
	JSOxlqv/r3o8kMHrtrzzIEAMeh1QgZ6/302yEshR2EVSeQD2DLTVEFSpTJ/z76V5
	3qW13p/mCGEXED95OUqOqLYXthcRtTX0TvV8oc6aJCmUok0BLsWAXaDc6zYyWGfs
	iF0TStD/AqqJ6mifVT5+r49YXioDNelIhWsb4CiZnuF3MHp0OpOCtGezMkBl8pzN
	FOmYPTqIDSFBe3VeM6DD8kNGq0mc8kotDJaYICvPwNXlygoA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k9cn0782-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 03:57:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5143vZpG008371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 03:57:35 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 19:57:33 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v8 0/9] wifi: ath12k: Add peer extended Rx statistics debugfs support
Date: Tue, 4 Feb 2025 09:27:09 +0530
Message-ID: <20250204035718.3227726-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 1MHmxHsJh0AMn9-n7dhqANwL8aHaLJFI
X-Proofpoint-ORIG-GUID: 1MHmxHsJh0AMn9-n7dhqANwL8aHaLJFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 mlxlogscore=863 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040029

Currently, peer extended Rx statistics are not supported. Peer extended Rx
statistics are collected form the TLV data reported in the monitor status
Rx path. Therefore, add support for TLV tag parser handling and debugfs
to configure and dump the collected information. Additionally, this series
does not impact the WCN7850.

v8:
 - Resend due to missed patches
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


