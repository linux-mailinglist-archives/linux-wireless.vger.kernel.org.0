Return-Path: <linux-wireless+bounces-12230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88D965753
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7561F24714
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA36A148827;
	Fri, 30 Aug 2024 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="czxGJmS5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63353389
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998181; cv=none; b=OcOhzGrr9sjiTRamt+OYGxH3qvZPIkVL59+wSxltDROn5JDCdscs6aRkCdO1op1oA9xCpHLtrGnWv/A+X79m3AhBUNVbOd04HFjN8zzgsU2NMK7WRiACLjT97e5+8zf07x8w2cTpcThSLV2ptQtoOHmdAEp6n4dFKWuC6iDSGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998181; c=relaxed/simple;
	bh=Mi2C9p/EAu4oYaYde2+QhFVa4XPytVJPrQ7qNJG8/00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C4pHhqiELdD12Amr5/mTZrJymq4+WcMUC7xQCsvLpbgjArKIZ9Yh7T8eXqbOXA3KhhJw60lZ72fLZjhQpvc3lSub+ksbGLmo4+E5tDaFnTuQ8r4NriW2pJ0j8fNrrfAHDJHFKFsYmp/zr+XwMoNousqz3vvd5XD3eYMoxWULTGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=czxGJmS5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47THUnXa013573;
	Fri, 30 Aug 2024 06:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MWIqFvwXR/PzgOKe4fqGwB
	ePOIezaIAtWMM4//VqXNw=; b=czxGJmS5Vn3+lISbIalzNE3aLg5RyD6MbqdfzH
	xtPPSqkkEUKwV53Yw0CXBfUCNfP/cZpV1e2EsuqLial0b6+sTnC/TdV+Uc1Ldqyf
	Hqg8mEFHs7FupSQFI1DqvtN+KGTnPmxam+1l+NWcSaYxOl4W/HOpVZY58C7fnK8T
	ek3rYiaAIz2G4bCvtN6hAfDwdJvgmKy5u6PvPbgmGrCRnfAENxo0XkqEMwtiDiJR
	Bearx9E7+KEpwOjTClDX/nLX/hljf6HbO8JKWzSWAw1ycri2JUI/4R16Y7XJruG8
	F0xUv4m8AXFBxPqgzO8Xn35aoeuxePRqdRezqYqbPfMnJhpQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419px5qgjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U69Y06011662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:34 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 23:09:32 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v4 0/8] wifi: cfg80211/mac80211: add DFS support for MLO
Date: Fri, 30 Aug 2024 11:39:10 +0530
Message-ID: <20240830060918.2418701-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 49OMRjAGz4ReQ6Fcnwbp_a-EuBnVA-85
X-Proofpoint-GUID: 49OMRjAGz4ReQ6Fcnwbp_a-EuBnVA-85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408300043

Currently, Dynamic Frequency Selection (DFS) and its related radar events
are supported only for non-MLO case where deflink (or link_id 0) is always
considered. However, with MLO in place, there is need to handle DFS in
per-link manner instead of always handling it on per device.

Add support to handle DFS interference related events per-link basis.

Aditya Kumar Singh (8):
  Revert "wifi: mac80211: move radar detect work to sdata"
  wifi: mac80211: remove label usage in
    ieee80211_start_radar_detection()
  wifi: trace: unlink rdev_end_cac trace event from wiphy_netdev_evt
    class
  wifi: cfg80211: move DFS related members to links[] in wireless_dev
  wifi: cfg80211: handle DFS per link
  wifi: mac80211: handle DFS per link
  wifi: cfg80211/mac80211: use proper link ID for DFS
  wifi: mac80211: handle ieee80211_radar_detected() for MLO
---
v4: * Rebased on ToT
    * No other changes in [1-7]
    * Removed local linked list usage and refactored code to directly
      cancel and notify while iterating over radar detected channel
      context [8]

v3: * Rebased on ToT
    * 12-digit sha1 in [1/8]
    * moved trivial preparation patches on top.
    * changed radar detection handling logic in [8/8]
    * minor commit text changes in in [5/8], [6/8]
    * removed patch [v2 9/9]

v2: * No changes except patch [6/9].
    * In [6/9], removed usage of label and directly used return statements
---
 
 drivers/net/wireless/ath/ath10k/debug.c       |  4 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath9k/dfs.c          |  2 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c    |  2 +-
 drivers/net/wireless/marvell/mwifiex/11h.c    | 11 +--
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  6 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_dfs.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  2 +-
 .../net/wireless/quantenna/qtnfmac/event.c    | 12 +--
 drivers/net/wireless/ti/wl18xx/event.c        |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +-
 include/net/cfg80211.h                        | 25 +++---
 include/net/mac80211.h                        |  5 +-
 net/mac80211/cfg.c                            | 49 ++++++-----
 net/mac80211/chan.c                           |  1 +
 net/mac80211/ieee80211_i.h                    |  8 +-
 net/mac80211/iface.c                          |  8 +-
 net/mac80211/link.c                           | 12 +++
 net/mac80211/mlme.c                           | 13 +--
 net/mac80211/pm.c                             |  2 +-
 net/mac80211/scan.c                           |  6 +-
 net/mac80211/util.c                           | 84 +++++++++++++++----
 net/wireless/ibss.c                           |  2 +-
 net/wireless/mesh.c                           |  2 +-
 net/wireless/mlme.c                           | 20 +++--
 net/wireless/nl80211.c                        | 33 ++++++--
 net/wireless/rdev-ops.h                       | 13 +--
 net/wireless/reg.c                            | 19 +++--
 net/wireless/trace.h                          | 40 ++++++---
 35 files changed, 261 insertions(+), 142 deletions(-)


base-commit: 20361712880396e44ce80aaeec2d93d182035651
-- 
2.34.1


