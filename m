Return-Path: <linux-wireless+bounces-10172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A8792DEEC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 05:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1261F21889
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 03:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2119D20332;
	Thu, 11 Jul 2024 03:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CN1ID2me"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015A1A28B
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669938; cv=none; b=LswqW4RrgZ8Op1xuiBnaHJSJwGPsknkTRxglOuFCiqCTP1SyXeYUlNFyiI5XSJfVT8XA9eBZLwiORlzMwlROM39TgfJnwW572/6sD6BIpIY4VbCVJyiQiN1cgmiHnvfzqtKwdkypktLxnhzR06etIQTRG7yj7wQkjWL/MMOloPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669938; c=relaxed/simple;
	bh=0vy1KVvczivsXOHhsA8f7FzIDvEm5xZfTxXPYcmdSXc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u4OJeFeAmdh8zOdySww2kYZeaDH98FQ4KiZEm9KM7fRPlzQZpZpd+/ihWLRch1BQnWXPhy1UB4FoGbmj0bqt2E15nLeXKj6mx7g+yoBVaq/WvJR5rvjGXdA7RGFfQG+XNPpwI6nTLdznRLEIzSShdFGi5LtHklVYP00E2vWlgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CN1ID2me; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B33XuQ005347;
	Thu, 11 Jul 2024 03:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tdyPbetiFgvhVvLpSHFIfg
	nfBORAETGtQvkZgResjkc=; b=CN1ID2mefZyqqIyI2MxSOkhg+reXnmXxOWLnJd
	+L2edXf9pVkdjcVW50hBwMPrnsIvXySI6cRwx8huoKqGFu10n9VrFyw8nfteomh3
	jlj7c15Bv6wlecw4+BHMVxz4OmBVnvXP8uOhbSCg3KKoNFYoZLnWBmzxGvpXLNna
	rl6lMmGstZC7EicOJeSgchrv4eUIVjYmiJGza4RWdXgvkJpkOQcm31sK+wk5CyDB
	cYtK0Js7+wpywIctFkRehLjnTzYM3AmW6KNdka+x/Wrz73xbVBVZ/F7Uu+T4hDTb
	YJO4ZXrMCJWLAqdb/Lb68VleFuhK9cwBoj1mUPsHVngb7ThQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409kdtjyac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 03:52:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B3qACO002260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 03:52:10 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 20:52:08 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v3 0/8] wifi: cfg80211/mac80211: add DFS support for MLO
Date: Thu, 11 Jul 2024 09:21:39 +0530
Message-ID: <20240711035147.1896538-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: G5rdFSVShdBC9Eiz1oRfw8tVb0RJ8pD3
X-Proofpoint-GUID: G5rdFSVShdBC9Eiz1oRfw8tVb0RJ8pD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_20,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110024

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
v3: * Rebased on ToT
    * 12-digit sha1 in [1/8]
    * moved trivial preparation patches on top.
    * changed radar detection handling logic in [8/8]
    * minor commit text changes in in [5/8], [6/8]
    * removed patch [v2 9/9]

v2: * No changes except patch [6/9].
    * In [6/9], removed usage of label and directly used return statements

 drivers/net/wireless/ath/ath10k/debug.c       |   4 +-
 drivers/net/wireless/ath/ath10k/mac.c         |   2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |   2 +-
 drivers/net/wireless/ath/ath9k/dfs.c          |   2 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c    |   2 +-
 drivers/net/wireless/marvell/mwifiex/11h.c    |  11 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_dfs.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |   2 +-
 .../net/wireless/quantenna/qtnfmac/event.c    |  12 +--
 drivers/net/wireless/ti/wl18xx/event.c        |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   2 +-
 include/net/cfg80211.h                        |  25 +++--
 include/net/mac80211.h                        |   7 +-
 net/mac80211/cfg.c                            |  49 +++++----
 net/mac80211/chan.c                           |   1 +
 net/mac80211/ieee80211_i.h                    |   8 +-
 net/mac80211/iface.c                          |   8 +-
 net/mac80211/link.c                           |  12 +++
 net/mac80211/mlme.c                           |  13 +--
 net/mac80211/scan.c                           |   6 +-
 net/mac80211/util.c                           | 100 +++++++++++++++---
 net/wireless/ibss.c                           |   2 +-
 net/wireless/mesh.c                           |   2 +-
 net/wireless/mlme.c                           |  20 ++--
 net/wireless/nl80211.c                        |  35 ++++--
 net/wireless/rdev-ops.h                       |  13 +--
 net/wireless/reg.c                            |  19 ++--
 net/wireless/trace.h                          |  40 +++++--
 34 files changed, 282 insertions(+), 139 deletions(-)


base-commit: dabcfd5e116800496eb9bec2ba7c015ca2043aa0
-- 
2.34.1


