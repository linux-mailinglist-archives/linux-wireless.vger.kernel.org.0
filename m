Return-Path: <linux-wireless+bounces-20730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A42A6D43D
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 07:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D3A1893CAF
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11CA19CC24;
	Mon, 24 Mar 2025 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pvIWHCcw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE218DB34
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797558; cv=none; b=uExbZVpyZxXM6cTDatnLo83il2MHU6t3vEVRAVi1V12wVuY4CfXCKVdZ0itWvd6K2anb3HfiUmBa65Q6azs+ylAVNogV7ajf649Ny5w96RbZZOJFkqMd2EznVRevsrRxjTpw6hJuYoWIV+asEaOozwJDEuj3l2vfk0Ufzl0riAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797558; c=relaxed/simple;
	bh=ojGR4noWSh8vwVghAtzR0zclAqOlVr21GQC6zsUGn9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=km4GNTCSbDu6x9fHgJ9+ynilLn4dvMUyOiPAtChVzrl0uxxBJQMzMUX1EHxmk4AxGKEj3TtTffa/e9yE3ovH3SECLuKNAWAQOFAw5OtLhWIhV7kGm07kLrdA0F3Rl1kS2kugOwhOZRooxPzlOacfoGWiYgovRHF/n6kRfpwliJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pvIWHCcw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6FX3W014959;
	Mon, 24 Mar 2025 06:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RTSReIR0TPx+oe+hpDgttW
	h4jDmFF+zEBsJyeFN6xhY=; b=pvIWHCcw4m4Kc8pTWADWSi/r245MTs3LAnQE5y
	cbYFMSlbd7s9FPjrIBaErWseZBiTulfzXBCk/IUy6R8QIzdeOYcHiM9grDuRCZlH
	twuWwna2mDh3WNmNcpPc4D2LcOXMwPt9JpU4D/ubWp1chLC1YjjvS+KdDWvEq0vf
	4MljlU50euvXDvpnU24GqgpnY5dxjTtUVGHKctoJTp5VoT1OLXbcvA6Iu5iNfkE1
	rmwVQq/jXJKMhz4i470CCKTcMpvPu45tp+d5pmT5/UiIbjuGJP3Ev/P7mTZgHswn
	RdRYLHxVb1nM4zHhm/TKmRFs/y7n/TdTPUtHMxww4Rb8ZhfA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79kcb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 06:25:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52O6PXid012779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 06:25:33 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Mar 2025 23:25:32 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v11 00/10] wifi: ath12k: Add monitor interface support on QCN9274
Date: Mon, 24 Mar 2025 11:55:08 +0530
Message-ID: <20250324062518.2752822-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: gjZPLfNHDWYl84JBMzOvBdWT7qKIwABq
X-Proofpoint-ORIG-GUID: gjZPLfNHDWYl84JBMzOvBdWT7qKIwABq
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e0faf1 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=drny9eR6pwTjfYRCe2kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=964 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240046

Currently, monitor interface not supported. Therefore, add the missed TLV
tags parsing in the monitor parser, configure the monitor vdev state
identifier with HTT filter setup.

v11:
 wifi: ath12k: Move to NO_VIRTUAL monitor
  - Added new patch to avoid multiple change in a patch
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

Karthikeyan Periyasamy (4):
  wifi: ath12k: Replace band define G with GHZ where appropriate
  wifi: ath12k: fix NULL access in assign channel context handler
  wifi: ath12k: Refactor the monitor channel context procedure
  wifi: ath12k: Move to NO_VIRTUAL monitor

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
 drivers/net/wireless/ath/ath12k/mac.c     | 237 +++++---------
 drivers/net/wireless/ath/ath12k/wmi.c     |  36 +--
 drivers/net/wireless/ath/ath12k/wmi.h     |  16 +-
 13 files changed, 460 insertions(+), 256 deletions(-)


base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
-- 
2.34.1


