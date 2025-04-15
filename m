Return-Path: <linux-wireless+bounces-21524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F033BA892C2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 06:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA29189A97C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 04:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA78192D8A;
	Tue, 15 Apr 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AzydChCD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DB2DFA51
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744690869; cv=none; b=mvF1Hs3JtujDoXVpxzjrE1hQTcZ9fJdExnLFkGkNDjwujJi17CeTTmKIj9z24afkEnbIuxq/nxjl+lXxe13ZaXaAx7WqA/+r4AIlr7fNRpDJtUQtI6EoIYiW8d7W4dNXPuP+YO+ttS+9+MZTAnJTTPQrTJl96DvFy0vqhHOd4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744690869; c=relaxed/simple;
	bh=62spu9sQ7ngQTW4ywrBe6hIXk4gUsNrJm6Aj0qOVFNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A0pgwDSGZ6Ngc9WsUsRHyA/geuWNpuDuNkSAOT0/hBGJjNr2JVpxXe+NmXVAaRdVIyFaNydlx8u3fllOqZZrRMoestZB2a56lh/SCdo7+GwR9J6ogEpqFo80aKV4RQj1m4PunLDgoLMtfutreAzu+n+tYFg6UMOpHv9ADmdDWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AzydChCD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F16OEX016669;
	Tue, 15 Apr 2025 04:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=O/gLlAvYNCYh6C3onbj7mi
	pYorqEhFQIYfZgPJXtCag=; b=AzydChCDnCAoXQOL7McNUEDAP7zGPYVNASVbjL
	MtMzF9iqFYWTqyDY0mh4NRQFXlhfd958mwJcSKTSXJId4yx+92CWSKUxrZvEucCF
	8Yl+8RtWtRlblt1DJXd9Syf+jecupphyOmzkCDpgNEYFUsOpl7MykOv9G6Lx+cx0
	o/MUs4ISoTVJ7c4awpUJ72LE0QEMgkydwK/WPtjFl1ubx91z3J9ROsBGZRIPb1NM
	g5PRZJT30sC18J9Gm4pBBQaj33l4aLgj4WjoD2kkIU7I6lko9x/pEN0rHheurZ3h
	+AxPiLy7s6slFIZc4fhCZ5lvWb68q0xOR9D4h0vAPL3cRCZw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhfcxgxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F4L0LQ018681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 04:21:00 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Apr 2025 21:20:58 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v6 00/11] wifi: cfg80211/mac80211: add support to handle per link statistics of multi-link station
Date: Tue, 15 Apr 2025 09:50:19 +0530
Message-ID: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=67fddead cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=Dk_v5eGsZCe3ORKsRBYA:9
X-Proofpoint-GUID: ogtVa7gI3RRK9RJJyqsdVYDmVFKplvJd
X-Proofpoint-ORIG-GUID: ogtVa7gI3RRK9RJJyqsdVYDmVFKplvJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150026

Current implementation of NL80211_CMD_GET_STATION does not work
for multi-link operation(MLO) since in case of MLO only deflink
(or one of the links) is considered and not all links.

Hence, add the link_sinfo structure to provide infrastructure
for link-level station statistics for multi-link operation(MLO).

Additionally, accumulated stats for MLO are included in a concise
manner to provide a comprehensive overview of the ML stations.

V6:
 - Fix compilation failure.
 - Add expected_throughput, beacon_loss_count, rx_dropped_misc at MLO
   level.
 - Removed is_per_link_stats_support boolean from sinfo structure.
 - Used ether_addr_copy() instead of memcpy().

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

 drivers/net/wireless/ath/ath10k/mac.c         |   8 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   6 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  10 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  56 +--
 drivers/net/wireless/ath/wcn36xx/main.c       |   5 +-
 drivers/net/wireless/ath/wcn36xx/smd.c        |   2 +-
 drivers/net/wireless/ath/wcn36xx/smd.h        |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  36 +-
 drivers/net/wireless/ath/wil6210/debugfs.c    |  13 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  84 +++--
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   2 +-
 .../net/wireless/intel/iwlwifi/mld/stats.c    |  10 +-
 .../net/wireless/intel/iwlwifi/mld/stats.h    |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/marvell/libertas/cfg.c   |  22 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  69 ++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   2 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   4 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  38 +-
 .../net/wireless/quantenna/qtnfmac/commands.c |  60 +--
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |   4 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |   4 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   4 +-
 drivers/net/wireless/ti/wlcore/main.c         |   4 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  14 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  37 +-
 include/net/cfg80211.h                        | 215 +++++++----
 include/net/mac80211.h                        |  21 +-
 net/batman-adv/bat_v_elp.c                    |  11 +-
 net/mac80211/driver-ops.h                     |  14 +-
 net/mac80211/ethtool.c                        |  31 +-
 net/mac80211/ibss.c                           |   4 +-
 net/mac80211/rx.c                             |  15 +-
 net/mac80211/sta_info.c                       | 274 ++++++++++----
 net/mac80211/sta_info.h                       |  30 +-
 net/mac80211/trace.h                          |   2 +-
 net/mac80211/util.c                           |  14 +-
 net/wireless/nl80211.c                        | 353 +++++++++++++++---
 net/wireless/trace.h                          |  33 +-
 net/wireless/util.c                           |   6 +-
 net/wireless/wext-compat.c                    |  22 +-
 48 files changed, 1056 insertions(+), 507 deletions(-)


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.34.1


