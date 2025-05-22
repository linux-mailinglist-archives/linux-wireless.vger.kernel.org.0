Return-Path: <linux-wireless+bounces-23282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE50AC07F3
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA673AF706
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD5289356;
	Thu, 22 May 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hndCrTK+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325228688C
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904192; cv=none; b=t2WDRdvu8x4ZkbB1Y+8F+DFsDD+CuVjxheFGeMxcKnevNtfpC/po0Mt8BzUVpy8/YAdQMIM0GiUR9OoCmVRHX2kpjMVw3xE/78h1NSKVH1sWoACQ8Dm5NOiex+z9igwRK5Hm0i0Tz7aDVoOVAauj4XlpGArHjebv/+SvrZOo//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904192; c=relaxed/simple;
	bh=RgmlEusOXjUncnMKH8wc9wSEJU5aYxW/FoHqitJ1/ms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j0fkMbvjEK18U0ns3ibIUHwSAIoPDyJpgW8kyVmA42yIlB8zdmNjntUkkv1tnNvmhm8aIxNjPpVUiraDsRXzFNjihwx1NQbrC6tqwtDK2nOZPxY5Vz4BeWY02XQOqrMVhSiQTuAsIS5SJ/Vdo6DGtUD1EqUeSG27S2oAfllNBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hndCrTK+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7UAmr000720;
	Thu, 22 May 2025 08:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P5HngDToFAjVb9LA9tavQM
	aOuBxDmXi7s3r4mQHKmec=; b=hndCrTK+4skcG6sHrxiyn7bKqYtQviOHS6H0Sa
	eMiMWh8i4L94t8LqS/PmWTxkxVSgZQRlh1R1GoeW6OvBfySvNrgkw+zbmq/KcmKc
	d5cfcVu0kGdiLwUYoNA+BNkFOok+exBoD0FRaHGauiwqDWPXTif08g/aACVHVdkF
	xuKy3Jks++wYEBfPW+en/EPp4x8jOtdabNqza4MWjETeqmMVT1TZBvQzmmkVPKKj
	0GpCS8EhkSalnMTGTeiAgpHkiyniIbbCHdSqBlfM0CINWDKpGG+BYcdQnDfzE2tf
	K5fEs4ZlqIjCXtQGnEUFsMJfS7I1y4gWdjuqCOzO0PRn08Og==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s95tm32a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8uQb6029858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:56:26 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 22 May 2025 01:56:24 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v9 00/10] wifi: cfg80211/mac80211: add support to handle per link statistics of multi-link station
Date: Thu, 22 May 2025 14:25:51 +0530
Message-ID: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=QKBoRhLL c=1 sm=1 tr=0 ts=682ee6bb cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=-GMTQ58X6DO2HI_OZAoA:9
X-Proofpoint-ORIG-GUID: 7MNaIFo_F-8occh1Q47LW-4GAGLEjsMd
X-Proofpoint-GUID: 7MNaIFo_F-8occh1Q47LW-4GAGLEjsMd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfX/9gS+LdguBas
 M4Kk3nQESSVGXBockmmOWb5YJ7s05iWvW9WayQi/wM8kGwx5KI8GOroBfQCzLayZAkB3gSxr/9X
 ZRAUreuYTzHluGyql64sKEbz2/pkwJavVXKoH+kf+RSpnAScMbhexLmKKRJPW6tSUIDwtMonYAn
 EagNR1WslXTqSuel1gEXufDYDpnS9BOYq7QFwtecM5E6A0Tym79HX2MNFR03bRQ6jwAD5jmJFnh
 hsn2rUF46Cg9LviN7aJ7i+j9vGd6JhWXaLWgZjZjaY5dZysVPm/TzAxiK0jvBn2enQmRy+Yo4pg
 TaUPoQ950QuumBTBX4l0jbHbUleu+CpSEYSkc6MGWDLpSpkwF4li8TLR1gg354j3KnZ8/ODM78Q
 4pIYnLPwK1IZ6bwdYKCzSDjRLeIzIApDvA2dFfsFXtb9lDjXpZ9TPA7jMeU7IVWwxXCowI3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=1 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220089

Current implementation of NL80211_CMD_GET_STATION does not work
for multi-link operation(MLO) since in case of MLO only deflink
(or one of the links) is considered and not all links.

Hence, add the link_sinfo structure to provide infrastructure
for link-level station statistics for multi-link operation(MLO).

Additionally, accumulated stats for MLO are included in a concise
manner to provide a comprehensive overview of the ML stations.

V9:
 - Remove link_id from link_sinfo structure.
 - Simplified code at possible places.
 - Added fields in removed link sta statistics.
 - Corrected pertid filling logic for MLO level.
 - Passed link_sta to .link_sta_statistics mac80211 ops.

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
  wifi: cfg80211: clear sinfo->filled for MLO station statistics
  wifi: mac80211: extend support to fill link level sinfo structure
  wifi: mac80211: correct RX stats packet increment for multi-link
  wifi: mac80211: add link_sta_statistics ops to fill link station
    statistics

 drivers/net/wireless/intel/iwlwifi/dvm/lib.c |   2 +-
 include/net/cfg80211.h                       | 119 +++++
 include/net/mac80211.h                       |  16 +-
 net/mac80211/cfg.c                           |  13 +
 net/mac80211/driver-ops.h                    |  19 +
 net/mac80211/ibss.c                          |   4 +-
 net/mac80211/rx.c                            |  15 +-
 net/mac80211/sta_info.c                      | 416 ++++++++++++++++--
 net/mac80211/sta_info.h                      |  57 ++-
 net/mac80211/trace.h                         |  27 ++
 net/mac80211/util.c                          |  14 +-
 net/wireless/nl80211.c                       | 437 ++++++++++++++++++-
 net/wireless/util.c                          |  12 +
 13 files changed, 1112 insertions(+), 39 deletions(-)


base-commit: 0b0ff976af94fc2437b62e3798f11aacc3798613
-- 
2.34.1


