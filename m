Return-Path: <linux-wireless+bounces-22977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA2AB7D3E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 07:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D069E08B1
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F527E7DD;
	Thu, 15 May 2025 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ge5uw/Yq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5B1D79A0
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288168; cv=none; b=IFkp551L7ONt05l7MvxNqFR/d+eBgbykKuaDz8gjPLEIAMjLCO3knO6PfHL79F8SS69YTx+7ZmVnHlkRtYVTKE3uNlxH6j9VUL9TNSzmNYLg5LXeX8oj7E0sri/hUZwtmc+pp7p0kb2UpvlWGgPR2wnvX70J38DwtkF41yT2s3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288168; c=relaxed/simple;
	bh=jyrh6/GUhI0kMqXOgMLsflFhq1J81uxxFCM0HbwsOIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RvSiQNrIKVUi6rm0T8mUVJWbwa454iS/LwJHz3Zga8ZuxyLc35I0yRG31AvH2rbJG7Exo/E7S8MbXUCLd+fWNd+17awjDEDIArui1WylOUZI7YZ3tp02Rbz79rYG3USW76oHyl07zPWuingugFCTkOQKBinWd5wO1M6e5ybl4wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ge5uw/Yq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJ7qFL002645;
	Thu, 15 May 2025 05:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iudfQB/CJcqGzdEvsH99s3
	bitOZlBjP9ybUKt5PEYjw=; b=Ge5uw/YqOAcOKOEM8iyFjk6xBJf+0kG9UhN3DL
	VsaScJhVouPXesOY/ufzmAPTvOpmvbGmt/IINPIrtFqOBGjk2qeApQTpT0pXIzR9
	Fmnwt+zHPoWU7ngDj9O5BxpbClbzOhk4GqNhK3MsRlSHELJKRwVVClkzkMYZZBlN
	VRb6rX/VCoAc7gJDRcntTtoADPX1s4T4rCULHjHlPeHfQaCt4bBze/wF/8hhrEWN
	9pCHqWUboK95l0GhQ9/tK+gizDDvFu1Xc8NOVSmOuJYtj6yOj44Xk3Qbzs9IC6kX
	5O/6b6rqtrACisW5f5fAcCwGnQjMbPRN6zXqvpB3zXPfEi1w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbex51k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:22 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F5nMcT016447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:49:22 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 22:49:20 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v8 00/10] wifi: cfg80211/mac80211: add support to handle per link statistics of multi-link station
Date: Thu, 15 May 2025 11:18:54 +0530
Message-ID: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1NSBTYWx0ZWRfX9vXxBJqhY+v9
 LnxDwQWo7/veVlgzMOBrQlSG+CyFHYCyPxDqsaH7YyeqIpFJaKnqWPWy9mtHvja2LPRrsY9Xrzy
 DH4uoyIyIQpq6C5+RXlW6oX2HmjFN/xshbIDWBHGvKUPIk46DVlw55FAS0W7f9s8Y1w9+FMyNAB
 48quOazTBUyCBnsTuVj5qBdLF15wZ/W1DWkB0qXU0a/UQD56Y/ssdDXd7dGiGE42Fi1GJxDZhQ9
 c0u5uk+8KgjjzGkYFOu+2Qkv+n9fxYZTv0m2H4RCRvFh0zn5ummJdwkQ4eRK8wVTzTCUodlHD81
 DvTIst4RA3k4akMPdWG+aYAMNu8R+71CYu0nSkOL8QmCRYNnKkEPLJjxbmq6Vbd5yoV+F43zwFe
 Rn5qUUPRb2vkL0Jeg2K/5+6JgMMvz2q0cs3jvchwXXvpNESHFsnpmFRFZdfx3nF8vih61+Ny
X-Proofpoint-ORIG-GUID: -QTF_GMvr8jUN-idIuOZuxf4ZOk_IZTh
X-Proofpoint-GUID: -QTF_GMvr8jUN-idIuOZuxf4ZOk_IZTh
X-Authority-Analysis: v=2.4 cv=IcuHWXqa c=1 sm=1 tr=0 ts=68258062 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=0tEs9va4rEXjYGKJGLgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150055

Current implementation of NL80211_CMD_GET_STATION does not work
for multi-link operation(MLO) since in case of MLO only deflink
(or one of the links) is considered and not all links.

Hence, add the link_sinfo structure to provide infrastructure
for link-level station statistics for multi-link operation(MLO).

Additionally, accumulated stats for MLO are included in a concise
manner to provide a comprehensive overview of the ML stations.

V8:
 - Fix locking issue.

V7:
 - Redesign the approach according to provided comments( mentioned the
   current implemented approach below in "Purposed Flow").

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

Purposed Flow:
 cfg80211:
 - introduce link_station_info structure for link level statistics
    structure link_station_info {
      filled
      rates
      ...etc // all link specific fields
    }
  - add link_station_info for MAX links in station_info structure
    structure station_info {
      filled
      packets
      sta_flags
      ... etc 

      valid_links
      link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS]
    }

 - Station_info structure is used for non-ML station statistics and
   update the sinfo_structure for MLO, for accumulated, best, least
   among all valid links in cfg80211_sta_set_mld_sinfo().
 - Allocate and free memory for link_sinfo for all links.
 - Embed NL message to include link level data, if valid_links are present.

mac80211:
  - Sta_set_sinfo() - fill station specific information as filled before
    if non-ML:
    - call mac80211 ops .sta_statistics() to fill station_info structure.
    if MLO:
    - call sta_set_link_sinfo(), for all valid links to fill
      link_station_info in *links[link_id].
    - introduce and call mac80211 ops for each link- .link_sta_statistics()
      to fill link statistics from drivers.
    - Maintain accumulated data for removed links in sta_info structure
      and fill in to station_info structure for consistency.

Sarika Sharma (10):
  wifi: mac80211: add support towards MLO handling of station statistics
  wifi: cfg80211: add link_station_info structure to support MLO
    statistics
  wifi: cfg80211: extend to embed link level statistics in NL message
  wifi: cfg80211: add statistics for providing overview for MLO station
  wifi: cfg80211: allocate memory for link_station info structure
  wifi: mac80211: add support to accumulate removed link statistics
  wifi: cfg80211: reset sinfo->filled for MLO station statistics
  wifi: mac80211: extend support to fill link level sinfo structure
  wifi: mac80211: add link_sta_statistics ops to fill link station
    statistics
  wifi: mac80211: correct RX stats packet increment for multi-link

 drivers/net/wireless/intel/iwlwifi/dvm/lib.c |   2 +-
 include/net/cfg80211.h                       | 124 ++++++
 include/net/mac80211.h                       |  16 +-
 net/mac80211/cfg.c                           |  13 +
 net/mac80211/driver-ops.h                    |  19 +
 net/mac80211/ibss.c                          |   4 +-
 net/mac80211/rx.c                            |  15 +-
 net/mac80211/sta_info.c                      | 393 +++++++++++++++--
 net/mac80211/sta_info.h                      |  36 +-
 net/mac80211/trace.h                         |   7 +
 net/mac80211/util.c                          |  14 +-
 net/wireless/nl80211.c                       | 434 ++++++++++++++++++-
 net/wireless/util.c                          |  12 +
 13 files changed, 1051 insertions(+), 38 deletions(-)


base-commit: 63a9a727d373fa5b8ce509eef50dbc45e0f745b9
-- 
2.34.1


