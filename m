Return-Path: <linux-wireless+bounces-9571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492659177A9
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 06:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96FA1F223A3
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 04:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4286FA31;
	Wed, 26 Jun 2024 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JGHE/pO4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF721E880
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377569; cv=none; b=E663N7HCS0v1ttrMIGY4zVDR6sfOolBmaRUPZDN9S77vzEALbsnNg+IcoQEpT8Yq49RIcpL2B42mglVzFA7avsGRT4/iuemSboYoqYrJp/39GfR8ipNqE4ylOsClR3/H5joDdtD8ekvKdnh2FuktDAholroj41ujDLZzv6WmA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377569; c=relaxed/simple;
	bh=HvrbFUm3P/5gaHKGyqexfMvGLUiCBhtQg28xJal9dYw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRGyF2+adgLfeJyvs2nAEBlrMJG7jmJS/c8zHSWm7tiZaGCE+OkP3+40HQBnhGU1BHmgYjX6+wriraMz3mEwbUU4kNC/vL3ASDU6UM3ORu5t5XUTHmkiZXbMUu/4vTU6Xxw/Wwnb7CNO5krzdPMObWjUYIT4sKh9Hk/SUPHxtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JGHE/pO4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q4b4LS002109;
	Wed, 26 Jun 2024 04:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rzaMBGTNUkllwnDAqzw59I
	wrFCexnF6gf4isKRhWNHs=; b=JGHE/pO4b8zcXHYZruAAYTDF+F8eXE0+eiyLdR
	rzKfvobu8TC9o/oXliJ1qgxl25yegnHD59CBliSJ8rDVfhz3SIYY0f94tCHg+OG6
	CGBDu1O31MhNiUKNgK4zZuvlcQBiXoE8X1QHrDzAp1gAzmeqUb4cCWok6rjRh6Yl
	Y9xB4IfAuYKegQeXmpZlWLJnO7e79LnkP70FY9k1UnMsGGvuCKn6E2GnDiXssMF6
	SEW/3U12ci1wwWE0Vz1U50vli64z2FkKFgXPX7RWZC2OP9SIoIYFkIZe20WaTm4P
	MEkCCRzJtjNh8tiT0smBuK9dgggca4gSEQHldNIayBPdmCzw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400c4680v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:52:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q4qgOE011167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 04:52:42 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Jun 2024 21:52:40 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 0/9] wifi: cfg80211/mac80211: add DFS support for MLO
Date: Wed, 26 Jun 2024 10:22:07 +0530
Message-ID: <20240626045216.3754013-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2FaTfHe4vPr-QVuJWX3RzqFm1wCW2DaL
X-Proofpoint-GUID: 2FaTfHe4vPr-QVuJWX3RzqFm1wCW2DaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_02,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=884 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260036

Currently, Dynamic Frequency Selection (DFS) and its related radar events
are supported only for non-MLO case where deflink (or link_id 0) is always
considered. However, with MLO in place, there is need to handle DFS in
per-link manner instead of always handling it on per device.

Add support to handle DFS interference related events per-link basis.

Aditya Kumar Singh (9):
  Revert "wifi: mac80211: move radar detect work to sdata"
  wifi: cfg80211: move DFS related members to links[] in wireless_dev
  wifi: nl80211: allow CAC while other links are beaconing during MLO
  wifi: trace: unlink rdev_end_cac trace event from wiphy_netdev_evt
    class
  wifi: cfg80211: handle DFS on per link
  wifi: mac80211: remove label usage in
    ieee80211_start_radar_detection()
  wifi: mac80211: handle DFS on per link
  wifi: mac80211: handle ieee80211_radar_detected() for MLO
  wifi: mac80211: abort active CAC while freeing the links during MLO
---
v2: * No changes except patch [6/9].
    * In [6/9], removed usage of label and directly used return statements

 drivers/net/wireless/ath/ath10k/debug.c       |  4 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath9k/dfs.c          |  2 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c    |  2 +-
 drivers/net/wireless/marvell/mwifiex/11h.c    | 11 ++-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  6 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_dfs.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  2 +-
 .../net/wireless/quantenna/qtnfmac/event.c    | 12 +--
 drivers/net/wireless/ti/wl18xx/event.c        |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +-
 include/net/cfg80211.h                        | 25 ++---
 include/net/mac80211.h                        |  5 +-
 net/mac80211/cfg.c                            | 49 +++++-----
 net/mac80211/ieee80211_i.h                    |  9 +-
 net/mac80211/iface.c                          |  8 +-
 net/mac80211/link.c                           | 26 +++++-
 net/mac80211/main.c                           |  8 ++
 net/mac80211/mlme.c                           | 13 +--
 net/mac80211/scan.c                           |  2 +-
 net/mac80211/util.c                           | 93 ++++++++++++++++---
 net/wireless/ibss.c                           |  2 +-
 net/wireless/mesh.c                           |  2 +-
 net/wireless/mlme.c                           | 20 ++--
 net/wireless/nl80211.c                        | 35 +++++--
 net/wireless/rdev-ops.h                       | 13 +--
 net/wireless/reg.c                            | 19 ++--
 net/wireless/trace.h                          | 40 +++++---
 34 files changed, 291 insertions(+), 139 deletions(-)


base-commit: 5ad8897fd15a3716601509ed4a7bc47bf0cab661
-- 
2.34.1


