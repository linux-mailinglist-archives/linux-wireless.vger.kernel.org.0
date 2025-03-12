Return-Path: <linux-wireless+bounces-20206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE16DA5D699
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 07:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B174177C93
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC7D1E5B6F;
	Wed, 12 Mar 2025 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GYnkjeER"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDEE1DE4C2
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762328; cv=none; b=A6MUiQW0S0343+T9M44NkwRC0izFSt2jWpDy9zhXjWpX0BGhbvUKkim3boOzY/XFa54za8RUJBdmV6aE8yWxLrTIa8TjnXstqtqIPWS/Ifs2nqjZXDYpETXX+Z2p0Ury3BWvis53V0BTOsznY+ikOnpHUNHiYfSwlSBMu09OpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762328; c=relaxed/simple;
	bh=wY6KvkNzR42zcFSDjiff2WNgYeRYwKkybCg9efPBFfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g2XrXmpszP0JKcBKbRAZe2aFsvvArCvUyf0wq37JV/K5jOuIDcuJNbBgp3a0VryzVKRAvV3/By0kXKcwfVGYB9LmHAwiixUtfhAFnNtHR6ARYni3CSHN9wpukFLct8DGqMJqPvpLUrPpZhDLHzSBV1yZSud8nnCT+JJq0xbXncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GYnkjeER; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMHFpe018481;
	Wed, 12 Mar 2025 06:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5kKlI6CS5NdBCx1WiAbPah
	1lkk7CpPj61XmLGrDbGKo=; b=GYnkjeERD3Zt06a2ghSS0i8sDhKPNaAnu1zEQu
	iPisaweEKme18koNHQWmrG+C90q6IID/09iCrD5gpfcfpV1H3XldXBrl/KAJASPX
	xPClHM6vjl8qe/EOBkjEgLxYOc6UV+lm1h28Kv3POhd34Wwh9hywcwORtpCtNR6K
	JwwcsnWqxuvnZuvMdPRkU812hAZLJaRJ94USoY2gYi1DnHbiwkvEjA8qOa2kGnvW
	72B//I+g6ETf949jtpEq5QZcVRzcNWy6mUOGv06c7yXH1Hgr/vGQTGZr7pmArhmK
	Em+iWl5g3r4w17CyWBDHpL340nL6lHvXC2O4Z8TqMx3B1AmQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nsdd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 06:51:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52C6po3Q027746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 06:51:50 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Mar 2025 23:51:49 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v5 00/11] wifi: cfg80211/mac80211: add support to handle per link statistics of multi-link station
Date: Wed, 12 Mar 2025 12:21:21 +0530
Message-ID: <20250312065132.3397726-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: fkeRcekWRxa2SPeOFenNNxncZF8B8bKu
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d12f07 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=zhmOqnTLHbeoPwouv9kA:9
X-Proofpoint-ORIG-GUID: fkeRcekWRxa2SPeOFenNNxncZF8B8bKu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120044

Current implementation of NL80211_CMD_GET_STATION does not work
for multi-link operation(MLO) since in case of MLO only deflink
(or one of the links) is considered and not all links.

Hence, add the link_sinfo structure to provide infrastructure
for link-level station statistics for multi-link operation(MLO).

Additionally, accumulated stats for MLO are included in a concise
manner to provide a comprehensive overview of the ML stations.

V5:
 - Rebased the patches.

V4:
 - Update helper function for link_sta derefrence.                    
 - Instead of using unnecessary rssi variable directly use return.
 - Correct commit tittle and message for some patches.
 - Corrected cfg80211_sinfo_release_content() unnecessary logic.
 - Split the patches for cfg80211/mac80211.
 - Add additional fields at MLO level.
 - Remove Ath12k patche from this series.
 - Remove unnecessary if condition check from "add additional MLO
   statistics".

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

Sarika Sharma (11):
  wifi: mac80211: add support towards MLO handling of station statistics
  wifi: mac80211: refactoring sta_set_sinfo() to add support towards MLO
    statistics
  wifi: cfg80211: refactoring nl80211_set_station() for link attributes
    towards MLO
  wifi: cfg80211: reorg sinfo structure elements for MLO
  wifi: cfg80211: extend statistics for link level in sinfo
  wifi: cfg80211: add flag to indicate driver supports ML station
    statistics
  wifi: cfg80211: add accumulated statistics for MLO links
  wifi: cfg80211: add additional MLO statistics
  wifi: mac80211: extend support to fill link level sinfo structure
  wifi: mac80211: add support to accumulate removed link statistics
  wifi: mac80211: correct RX stats packet increment for multi-link

 drivers/net/wireless/ath/ath10k/mac.c         |   6 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   6 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  10 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  56 +--
 drivers/net/wireless/ath/wcn36xx/main.c       |   5 +-
 drivers/net/wireless/ath/wcn36xx/smd.c        |   2 +-
 drivers/net/wireless/ath/wcn36xx/smd.h        |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  32 +-
 drivers/net/wireless/ath/wil6210/debugfs.c    |  11 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  75 ++--
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/marvell/libertas/cfg.c   |  19 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  61 ++--
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
 include/net/cfg80211.h                        | 212 +++++++----
 include/net/mac80211.h                        |  21 +-
 net/mac80211/driver-ops.h                     |  14 +-
 net/mac80211/ethtool.c                        |  31 +-
 net/mac80211/ibss.c                           |   4 +-
 net/mac80211/rx.c                             |  15 +-
 net/mac80211/sta_info.c                       | 275 +++++++++-----
 net/mac80211/sta_info.h                       |  30 +-
 net/mac80211/trace.h                          |   2 +-
 net/mac80211/util.c                           |  14 +-
 net/wireless/nl80211.c                        | 334 +++++++++++++++---
 net/wireless/trace.h                          |  33 +-
 net/wireless/util.c                           |   6 +-
 net/wireless/wext-compat.c                    |  22 +-
 42 files changed, 944 insertions(+), 466 deletions(-)


base-commit: 9324731b9985478faf7f77713cc5e5fee811716e
-- 
2.34.1


