Return-Path: <linux-wireless+bounces-28228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C53EC07AD4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30ED1C25FB8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060B239E8B;
	Fri, 24 Oct 2025 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M4Az8mj8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784021A9F85
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329776; cv=none; b=oq7NCRzAoVGKmAIrFGKZvWTGSzl9PTbEZMji92kRNVJ2dUbIOZnEtRBHfgg+VQDSRaWDeVejsLY3HY5ZAhp+AgyxsmjfOKLfFmTe5O/aMQtktzij5cI4jW9CvkMgPl6S6cHwVb5uJ8l6d409C4eQ6tZWFGeRPmunpj4Xt7TVWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329776; c=relaxed/simple;
	bh=yM/NYfcmTXSVHJHFtQaDyvi/muEK0U/MynxW02WiJbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a9rtVBx8vhdny4E5bWa1r3NT+QQ3L5/QFtkRofUf9bvUZntyieFdG3TgY3DEG7L4lNVKHJSOduuUKkrXkCLZO+pCOYC8F4wMIUS7wa+7iT88NfBITFw1GSrWA+PnAYby2OWDeTyeU5hjJa9SoC/0USOF7TqP7WXzq/ZufG6eDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M4Az8mj8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9Iu4023506;
	Fri, 24 Oct 2025 18:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GRE105ykZ7VpJJmvugSTi7
	HIJXlHdrPsLorDBv36q1Y=; b=M4Az8mj83lSq03E+ELaQJmo/ohNTKFhpGxj73/
	1pQ7mKs1fK8nMDiWBhj112c/0o4gVO2wWFTIh0TAAQiPeTf7ncp3CUUbirL6/MUg
	Kn4reqN8Bsxyc/IIjRfUaDpB/19XG6IZQTX3OX4RC24bODnj1/D7pfcqOAWcmvY/
	Wmq26nUsAgGRMf/hIIVMoco0u52m5KYVKusTvUV0ylwoytGmu94cBWZNLvWup5eH
	RfgnEiFsJRNWe20xSeZDtz7Fw9uzdu9vlRIucPkxiCewIPJgK3c0REuBOb9NsRxE
	s832vHXqSdo7d+Rm7UFlCidRspD/tocsW1UJoYqF5Wd1Ya6Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8q3rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59OIG5gp021910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:05 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 24 Oct 2025 11:16:04 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 0/9] wifi: ath12k: Modularization of peer object
Date: Fri, 24 Oct 2025 23:45:39 +0530
Message-ID: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ETFUM0se3J-OoIag-GmddZWXIBgN1FWT
X-Proofpoint-GUID: ETFUM0se3J-OoIag-GmddZWXIBgN1FWT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX1NHZ8F5MR8rl
 38DbM2oxuIreX/+rC/D4w5J7CVhz4mlcJ3xI70q6VA7b1NmD4sbQOk9KMM2CxI/aX1mX+7zYFJP
 yPXLrMZdUkppUaMZdOLT9YMK7z6AfPn/hKRkWpW9W8ThlIwxKumhxbuIT/kyxSac033E07AnXFc
 h9E+FyxXECtp2ayoaU19PUk8iRPwaYuucx3d5h2Qr0J2It6htX3pMHk71DJRS9Ua7GRNfOkRBRq
 iM2K5RZS83k2fVcuuntlt6GI3Hk6W2hLeIp/rtShQKestN5CwwHKPK0GdFn9E4CbIFVS/gplMmk
 kASSpNcMIOE/lS2lti84Ff1oIodx9n54LoAWikKOBbbCpZIaOiMDg5zBx1n18Xmn0yhUoVE5GcB
 IFYOBheGWxvHmZwY00WTWp5fGmPDVQ==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fbc266 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PZzZyu-LANIpnL0jNGgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

struct ath12k_sta has an array of struct ath12k_link_sta wherein each index
represents one link of the connected station.

For each ath12k_link_sta, there is a corresponding data path peer which is
represented by struct ath12k_peer.

Diagrammatic view of the station is a below:

        ath12k_sta
            |
            |-> ath12k_link_sta <--> ath12k_peer
            |
            |-> ath12k_link_sta <--> ath12k_peer
            |
            |-> ath12k_link_sta <--> ath12k_peer

Currently, in control path, ath12k_link_sta and ath12k_peer are used
interchangeably, while the data path makes use of ath12k_peer only.

With ath12k next-generation driver framework, in order to have a clean
segregation between control and data path, the plan is to use ath12k_link_sta
only for control path operations.

Station view for the data path is revamped as below:

        ath12k_dp_peer
               |
               |-> ath12k_dp_link_peer
               |
               |-> ath12k_dp_link_peer
               |
               |-> ath12k_dp_link_peer

where:
ath12k_dp_peer is newly introduced structure and represents the data path
version of corresponding ath12k_sta.

This ath12k_dp_peer contains the fields used in the per packet Tx Rx paths
applicable across all the links and maintains an array of ath12k_dp_link_peer.
Per packet Tx and Rx path operates on ath12k_dp_peer. This ath12k_dp_peer is a
standalone new object and has back pointer reference to ieee80211_sta.

ath12k_peer has been renamed to ath12k_dp_link_peer and the fields which
are common across all the links are moved to ath12k_dp_peer. ath12k_dp_link_peer
contains the fields specific to a link and these are mostly for statistics and
monitor usage.

Final view of station is shown below:

            Control Path                            Data Path
        -------------------------------------------------------------------
        ath12k_sta                            ath12k_dp_peer
            |                                       |
            |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
            |                                       |
            |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
            |                                       |
            |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer

To achieve this, following set of changes are done in this patch series:
1. Refactor functions present in file peer.c in such a way to retain functions
   operating on ath12k_link_sta in peer.c and move functions operating on
   ath12k_peer to dp_peer.c
2. Rename ath12k_peer to ath12k_dp_link_peer and change find APIs
   correspondingly
3. Add hash table for ath12k_link_sta in ath12k_base
4. Move peer linked list from ath12k_base to ath12k_dp
5. Add hash table for ath12k_dp_link_peer in ath12k_dp
6. Define ath12k_dp_peer structure and APIs for creation and deletion
7. APIs for assign and unassignment of ath12k_dp_link_peer to ath12k_dp_peer
8. Use ath12k_dp_peer in per packet Tx and Rx path
---
Harsh Kumar Bijlani (8):
  wifi: ath12k: Move DP related functions from peer.c to dp_peer.c file
  wifi: ath12k: Rename ath12k_peer to ath12k_dp_link_peer
  wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base
  wifi: ath12k: Move ath12k_dp_link_peer list from ath12k_base to
    ath12k_dp
  wifi: ath12k: Add hash table for ath12k_dp_link_peer
  wifi: ath12k: Define ath12k_dp_peer structure & APIs for create &
    delete
  wifi: ath12k: Attach and detach ath12k_dp_link_peer to ath12k_dp_peer
  wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths

Ripan Deuri (1):
  wifi: ath12k: Add lockdep warn for RCU

 drivers/net/wireless/ath/ath12k/Makefile      |   1 +
 drivers/net/wireless/ath/ath12k/core.c        |  12 +-
 drivers/net/wireless/ath/ath12k/core.h        |  17 +-
 drivers/net/wireless/ath/ath12k/dp.c          |  48 +-
 drivers/net/wireless/ath/ath12k/dp.h          |  17 +-
 drivers/net/wireless/ath/ath12k/dp_cmn.h      |  28 +-
 drivers/net/wireless/ath/ath12k/dp_htt.c      |  44 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c      |  30 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c     | 627 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/dp_peer.h     | 125 ++++
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 151 +++--
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  19 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 381 ++++++++---
 drivers/net/wireless/ath/ath12k/mac.h         |   1 +
 drivers/net/wireless/ath/ath12k/peer.c        | 439 +++++-------
 drivers/net/wireless/ath/ath12k/peer.h        | 112 +---
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  47 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   6 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  24 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |   5 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  19 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |  14 +-
 23 files changed, 1504 insertions(+), 664 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.c
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.h


base-commit: 25122460e7f96864a80b59ffe6c953911516d3b3
-- 
2.34.1


