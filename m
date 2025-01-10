Return-Path: <linux-wireless+bounces-17275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13310A08628
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B76037A0537
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 04:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA581A9B45;
	Fri, 10 Jan 2025 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LOzdwoqu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C21126C10
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736483155; cv=none; b=fcdzMCpiPkbBNIU9SPricYPnHvnwpTABvqsImuR9hFX+TLwHl+850nfljuc1USNBS/CIz/L3sEhPKMUuSAdtOfCFEbQ8cbpLaMRnqttbSTsUBP9BPG7eAKFzrVYIhSuhoDQatjBKHZgLf3bLtOtuA3gqoWZ0CZZcjR/iwjhgHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736483155; c=relaxed/simple;
	bh=5VvJEsWAwAouRB+ZnCBITAPCpUHrErFry5XF/Ei8t+M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ksk7X1yNHb3mzU32SnEKd1qEcTLZdnzlQcKFN7LEY4qR87lN/uN2WSUuUvOoeuHEixrPc7/mB+NYmKAZUqxiNDRj7C+WUMnIwaPzUgDbyHpPyaDAhOyuyZOXvjsYRakB3s2MfZegTFIQ2fqwE/79NSgn/CUe5qxENnOt0GyL3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LOzdwoqu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509FrxZj007709;
	Fri, 10 Jan 2025 04:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=K8KRzsQX+79ya57WDDhhtn
	MdPHt8clRemQ0ryV27ipU=; b=LOzdwoquDjuSsGedI8OSIDYUMAbskZkVT+I/+O
	DmIiiTi385jwT0dHpwfyeTpNKPSApi7IbgJQU3jFlj8zNeIMDY+QBw+QkiTbibr4
	bF2gr9IL8xhz+eUfa9F/nU7OY9vk6wTkJr+K44g0aCQMA9ex7rcgX/vbscN89Qlt
	lRumpO9z7MPcqeLcH44Fezki/8sXnK5SBPPqgBbmbUYS40JzJyv+7qvoTXjWeFxm
	quMZKN1c+s+HnjZ263wZ+OpAXttzgQlugOQ7TOnVCDCAP6VkwvxCCNVK9/iNg8KB
	e0fGQJaRy6DNY+auef+oJglFKS3nfsiwHNkOXAqpUKHdIfbw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442hgg1gxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A4PaG1004571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 04:25:36 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 20:25:35 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC 0/7] wifi: cfg80211/mac80211: add support to handle per link statistics of multi-link station
Date: Fri, 10 Jan 2025 09:54:42 +0530
Message-ID: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: M5xfZf5g3FpZMbFaJXo7rlJMi0exljzA
X-Proofpoint-ORIG-GUID: M5xfZf5g3FpZMbFaJXo7rlJMi0exljzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=934 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100034

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

Current flow:

      +-------------------------+                                            
      |      From userspace -   |                                            
      | NL80211_CMD_GET_STATION |                                            
      |                         |                                            
      +-------------------------+                                            
                   |                                                         
                   |                                                         
 +---------------------------------------+                                   
 |        nl80211_get_station()          |                                   
 |                                       |                                   
 | 1. Locally define sinfo               |                                   
 | 2. call cfg80211 ops - .get_station() |                                   
 +---------------------------------------+                                   
                    |                                                        
                    |                                                         
+-------------------------------------------+                                
|          sta_set_sinfo()                  |                                
| 1. call mac80211 ops - .sta_statistics()  |                                
|    to fill sinfo structure                |                                
| 2. fill remaining sinfo structure, if     |                                
|    not filled from driver                 |                                
+-------------------------------------------+  


Proposed flow: (Changes in last block)

      +-------------------------+                                            
      |      From userspace -   |                                            
      | NL80211_CMD_GET_STATION |                                            
      |                         |                                            
      +-------------------------+                                            
                   |                                                         
                   |                                                         
 +---------------------------------------+                                   
 |        nl80211_get_station()          |                                   
 |                                       |                                   
 | 1. Locally define sinfo               |                                   
 | 2. call cfg80211 ops - .get_station() |                                   
 +---------------------------------------+ 
                   |
                   |
 +----------------------------------------------------------+
 |                 sta_set_sinfo()                          |
 |   1. fill sinfo structure- info related to station       |
 |   2. if MLO                                              |
 |      a. call sta_set_link_sinfo() for each valid link    |
 |         i. Call mac80211 ops- .link_sta_statistics()     |
 |            to fill link_sinfo structure                  |
 |         ii. fill remaining link_sinfo structure          |
 |      b. call sta_set_mld_info()- to fill accumulated     |
 |         stats at MLO level                               |
 |   3. if non-ML                                           |
 |      a. call sta_set_link_sinfo() for deflink            |
 |         i. Call mac80211 ops - .link_sta_statistics()    |
 |            to fill deflink link_sinfo structure          |
 |         ii. fill remaining link_sinfo structure          |
 +----------------------------------------------------------+

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

Sarika Sharma (7):
  wifi: cfg80211: reorg sinfo structure elements for mesh
  wifi: cfg80211: reorg sinfo structure elements for MLO
  wifi: cfg80211: extend statistics for link level in sinfo
  wifi: cfg80211: add accumulated statistics for MLO links
  wifi: mac80211: add support to accumulate removed link statistics
  wifi: cfg80211: add additional MLO statistics
  wifi: ath12k: correctly fetch arsta for MLO

 drivers/net/wireless/ath/ath12k/mac.c |  51 +--
 include/net/cfg80211.h                | 204 ++++++----
 include/net/mac80211.h                |  21 +-
 net/mac80211/driver-ops.h             |  14 +-
 net/mac80211/ethtool.c                |  30 +-
 net/mac80211/ibss.c                   |   4 +-
 net/mac80211/sta_info.c               | 537 ++++++++++++++++++--------
 net/mac80211/sta_info.h               |  30 +-
 net/mac80211/trace.h                  |   2 +-
 net/mac80211/util.c                   |  18 +-
 net/wireless/nl80211.c                | 353 +++++++++++------
 net/wireless/trace.h                  |  33 +-
 net/wireless/util.c                   |  10 +-
 net/wireless/wext-compat.c            |  22 +-
 14 files changed, 889 insertions(+), 440 deletions(-)


base-commit: 7bf1659bad4e9413cdba132ef9cbd0caa9cabcc4
-- 
2.34.1


