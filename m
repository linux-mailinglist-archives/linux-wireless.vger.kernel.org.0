Return-Path: <linux-wireless+bounces-17639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45E1A14F99
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 13:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F30A1885F1D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D31FF1BA;
	Fri, 17 Jan 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="my+jHCqH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C6E1FF1D8
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117993; cv=none; b=gZogHiodeJRkfHqlxLq/xdMhSl+T0ZBAWOdJRnnqNO4qrMAaf+nXU9TJl6BWXOSIpOo95Yap9tnfg/mBQ6NiGV+DEN6YkzSpNo3vX9dsjDZHBex6COWyqvaAmP4whHSy5rh6CYyiqOMZs3R1B1o1eZbsTA5shUDPYuM5jlvOrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117993; c=relaxed/simple;
	bh=wbWFBvwlxPhJB5szlAIBYiod1NjEQLnRprgVzOuxtzs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s7z1dZ4SFHXB29ffSXLcvkRo3TBba6HNhqXmqBRk0LtSK1yToejrpYxp6RffDqhosZvIs5v0UXaafj+Y+Bpm9gSOOH3Oj3Bt799pHIoohq5rIFpsvfFsHJRTGpqfqBH4fs8RAZgQpJqphoxiRNqRphy1lQ/ueoTxr3pOG1M3M3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=my+jHCqH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H9ImSw030630;
	Fri, 17 Jan 2025 12:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=E0T+TXnYTpTHLsxUla+xig
	nnqlbiayEmy+cmdmK8ARQ=; b=my+jHCqHL310J7HyuzKEmqfFH7J0kcF2sQjlny
	gqfvgV2PIi760mAtN3DU21PriDBoptd22sbm+58p8PbZ2baZADaFqzw3UC+G7oPd
	DIR9VjuJ8jd3DYKdNCQCSS18J7zaTl5EOPuhWRKPDLDGMLc3EIG0+4eclTythO8h
	oKIk+JurQhmcX9yLqu1BwzkMVSYJWaitosmn9h1wyQLrD9mEbTp+atVb+lM37RRN
	kgHUFsVN9l5XXau97NsSFVvwLDQzvnrQ+4w9j/WsZjaCsojmfQy42fli3MYzG1hd
	0Urni5CUWd3rxnh5OYJGqk3JJO578ZsUezqCI0ZbA5yf5kOQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447mfcrhat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50HCkKJA013994
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:20 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 04:46:19 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC v2 00/12] wifi: cfg80211/mac80211: add support to handle per link statistics of multi-link station
Date: Fri, 17 Jan 2025 18:15:42 +0530
Message-ID: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: hRlQTwJcBHSE19TDXhT4XurTuusJQSxA
X-Proofpoint-ORIG-GUID: hRlQTwJcBHSE19TDXhT4XurTuusJQSxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170103

Current implementation of NL80211_CMD_GET_STATION does not work
for multi-link operation(MLO) since in case of MLO only deflink
(or one of the links) is considered and not all links.

Hence, add the link_sinfo structure to provide infrastructure
for link-level station statistics for multi-link operation(MLO).

Additionally, accumulated stats for MLO are included in a concise
manner to provide a comprehensive overview of the ML stations.

NOTE:
   1. Current code changes are done to get an early feedback on design.
   2. Once RFC patches are approved will add the required driver changes.
   3. Ath12k changes are included in this series for reference to other
      driver changes.

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

Alternate approach:
   - Keep sinfo structure as it is and use this for non-ML or
     accumulated statistics for ML station.
   - Add link sinfo for links with only certain link specific statistics.
   - Keep mac_op_sta_statistics at MLD level and let driver fill the
     MLO and link level data, if driver not filling let mac80211 fill
     the data.
   - Corresponding changes done to embed statistics into the NL message
     based on the sinfo/link_sinfo.
	 
pseudo code for alternate approach:

 - cfg80211/mac80211:
	structure sinfo {
	filled
	packets
	bytes
	etc... //retain the structure as it was there before
	add structure link_sinfo{
		filled
		packets
		bytes
		etc ... //all link level applicable fields
		}
	}
 - Call drv_sta_statistics at MLO level or deflink if non-ML and let
   driver fill MLO statistics and link level statistics.
 - Check if sinfo->filled is set if not fill the corresponding data
   in sinfo and link sinfo for MLO or sinfo for non-ML.

Why not considered this approach for implementation:

 - The required changes here to other drivers are minimal. However,
   since sinfo is retained, every field needs to be filled at the MLO
   level. MLO statistics for tx_duration, pertid, etc., may not be
   very useful.
 - If these elements are not filled for MLO, they will remain unused
   in sinfo.

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

 drivers/net/wireless/ath/ath12k/mac.c        |  22 +-
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c |   2 +-
 include/net/cfg80211.h                       | 210 ++++++++----
 include/net/mac80211.h                       |  21 +-
 net/mac80211/driver-ops.h                    |  14 +-
 net/mac80211/ethtool.c                       |  31 +-
 net/mac80211/ibss.c                          |   4 +-
 net/mac80211/sta_info.c                      | 340 +++++++++++++------
 net/mac80211/sta_info.h                      |  30 +-
 net/mac80211/trace.h                         |   2 +-
 net/mac80211/util.c                          |  18 +-
 net/wireless/nl80211.c                       | 298 +++++++++++++---
 net/wireless/trace.h                         |  33 +-
 net/wireless/util.c                          |   6 +-
 net/wireless/wext-compat.c                   |  22 +-
 15 files changed, 743 insertions(+), 310 deletions(-)


base-commit: 7bf1659bad4e9413cdba132ef9cbd0caa9cabcc4
-- 
2.34.1


