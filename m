Return-Path: <linux-wireless+bounces-18925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBF9A34B96
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9776118902EA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD522202F72;
	Thu, 13 Feb 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jq9zW2vn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123A201259
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467040; cv=none; b=Tum+dxWWHRjtIT2XkNJmpFoHOF4mL0Ex+qmbjvOCTsmyxy7Non6JnrxN4yUSe8geTG9syEr3O/yW05Zzh8Cg+T7Tcnw+JnX1J0GczO/CRPYItlKM6mlRZ4SlsoxJzkvX9ZG7JjoqbWWQnrfDNA9z6E2uNVrkNvtVD6AMS+PbdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467040; c=relaxed/simple;
	bh=KZ0XDPlNyMrGnxfovKXkU5uQOtSXLY2zLnVHqnl8xJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=llbesSChFlQYC9y7sxTQSYcMetTg9xIT8lt6S1GNZFk3Cu4mct9fl4F1/YsG7n6p35BauFpIA/GZba6QTx0F6QedmFF/lAxsKaNnKW9TXCtlGJD84EgEIUUbXIsZHwb2vC5foVDkLDJi0VfQAuReVY1aM65lLfKG6V6W5tFDW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jq9zW2vn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D9hHHw028708;
	Thu, 13 Feb 2025 17:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2CVDaFA55T2R55keia3gCy
	7ZVKG/QRUUa80GVJ0IR3I=; b=Jq9zW2vnhxPHFRvKaCKLcgne9TV06TRJUB9hWc
	Sc9q6Vjepj5/8EbQ7mRHa8IB3EgzLnAcrZ3bq7Nx8MojyMsk7lTYiHiOzq1B9G7m
	0fJixmZM0VpRU3ONqnvDaylMk6w3ukGsjekENCVjW+XbUpChLi/sk0VwO/V0oFCK
	Dmr4IDOGj1nvPohjEuDYjTx9o3G0DihYMx2lubS1iLxs6G2ziJbyG9ygK4NBRCgt
	9dXQiijeAdDQgH/ILmD/2Oay62SW7Qqn3a+Wp8xStZrefbH4+G/HbRRI4+Flu0JJ
	wMDl7/N81q5xuOxt7sdCNRuICGirHGz+cmBr1DJOdGwMuNTQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sebn9783-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:14 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHHE5U021920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:14 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:17:12 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH v3 00/12] wifi: cfg80211/mac80211: add support to handle per link statistics of multi-link station
Date: Thu, 13 Feb 2025 22:46:20 +0530
Message-ID: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P-WNsOdA5Ofs7fYElQZofJ4DMrq64vYW
X-Proofpoint-ORIG-GUID: P-WNsOdA5Ofs7fYElQZofJ4DMrq64vYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130123

Current implementation of NL80211_CMD_GET_STATION does not work
for multi-link operation(MLO) since in case of MLO only deflink
(or one of the links) is considered and not all links.

Hence, add the link_sinfo structure to provide infrastructure
for link-level station statistics for multi-link operation(MLO).

Additionally, accumulated stats for MLO are included in a concise
manner to provide a comprehensive overview of the ML stations.

V3:
 - Convert RFC patch to actual PATCH with each patch bisectable.
 - Add logic for MLO level signal and rates.

V2:
 - Update cover letter to give more details on structural changes.
 - Split the patch(1/7) in two patches.
 - Do the required changes for MLO bringup before as seperate patches.
 - Remove link_sinfo naming to sinfo for better clarity on changes.
 - Add accumulated stats logic in cfg80211.
 - Add flag to indicate driver supports per-link station statistics or not.

Current flow:
  cfg80211:
  - Structure station_info is used to fill all station information (station
    level as well link level).
  - Nl80211_get_station() - locally define sinfo, call -.get_station() ops

  mac80211:
  - Sta_set_sinfo() - fill station information and call mac80211
    ops - .sta_statistics()(to fill the station_info structure).

Purposed flow:
 cfg80211:
  - Structure changes for station_info
    structure station_info {
      filled
      packets
      sta_flags
      ... etc // station specific fields
      link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS]
    }
    structure link_station_info {
      filled
      rates
      ...etc // all link specific fields
    }

  - Split station_info structure into station specific and link specific
    fields- (station_info and link_station_info).
  - Add array pointers in station_info structure for link_station_info.
    for non-ML use links[0], for ML use *links for each valid links.
  - Nl80211_get_station() - locally define sinfo, call -.get_station() ops.
  - Once link station information filled, fill mld level information in
    cfg80211_sta_set_mld_sinfo() for MLO.
  - Introduce a flag to indicate if driver provides per-link station
    statistics or not and embed NL attributes accordingly.

 mac80211:
  - Sta_set_sinfo() - fill station specific information and call
    sta_set_link_sinfo()
     a. If MLO and driver provides per-link statistics
         - For each link fill link specific data in *links[link_id]
         - Call mac80211 ops for each link- .link_sta_statistics() to
           fill link statistics.
     b. If non-ML or driver does not provides per-link statistics
         - Fill link level data for links[0]
         - Call mac80211 ops- .link_sta_statistics() to fill link statistics
  - Maintain accumulated data for removed links in sta_info structure
    and fill in to station_info structure for consistency.

Sarika Sharma (12):
  wifi: cfg80211: reorg sinfo structure elements for mesh
  wifi: mac80211: add API to populated mesh related fields in sinfo
  wifi: mac80211: add support towards MLO handling of station statistics
  wifi: mac80211: introduce sta_set_link_sinfo API to add support
    towards MLO statistics
  wifi: cfg80211: introduced nl80211_fill_link_station API for link
    attributes towards MLO
  wifi: cfg80211: reorg sinfo structure elements for MLO
  wifi: cfg80211: extend statistics for link level in sinfo
  wifi: cfg80211: add flag to indicate driver supports ML station
    statistics
  wifi: cfg80211: add accumulated statistics for MLO links
  wifi: mac80211: add support to accumulate removed link statistics
  wifi: cfg80211: add additional MLO statistics
  wifi: ath12k: correctly fetch arsta for MLO

 drivers/net/wireless/ath/ath10k/mac.c         |   6 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   6 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  20 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  56 +--
 drivers/net/wireless/ath/wcn36xx/main.c       |   4 +-
 drivers/net/wireless/ath/wcn36xx/smd.c        |   2 +-
 drivers/net/wireless/ath/wcn36xx/smd.h        |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  32 +-
 drivers/net/wireless/ath/wil6210/debugfs.c    |  11 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  74 ++--
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/marvell/libertas/cfg.c   |  19 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  60 ++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   2 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   4 +-
 .../net/wireless/quantenna/qtnfmac/commands.c |  60 ++--
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |   4 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |   4 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   4 +-
 drivers/net/wireless/ti/wlcore/main.c         |   4 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  10 +-
 include/net/cfg80211.h                        | 214 +++++++----
 include/net/mac80211.h                        |  21 +-
 net/mac80211/driver-ops.h                     |  14 +-
 net/mac80211/ethtool.c                        |  31 +-
 net/mac80211/ibss.c                           |   4 +-
 net/mac80211/sta_info.c                       | 340 ++++++++++++------
 net/mac80211/sta_info.h                       |  30 +-
 net/mac80211/trace.h                          |   2 +-
 net/mac80211/util.c                           |  18 +-
 net/wireless/nl80211.c                        | 305 +++++++++++++---
 net/wireless/trace.h                          |  33 +-
 net/wireless/util.c                           |   6 +-
 net/wireless/wext-compat.c                    |  22 +-
 41 files changed, 954 insertions(+), 490 deletions(-)


base-commit: c61da149b9c2e439abe27845a71dae5ce5f5985c
-- 
2.34.1


