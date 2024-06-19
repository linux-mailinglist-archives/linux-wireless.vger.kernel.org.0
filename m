Return-Path: <linux-wireless+bounces-9222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0765D90E232
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 06:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98CB284F9F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFEE37700;
	Wed, 19 Jun 2024 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b4l9AY+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A44D4C635
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770232; cv=none; b=BUnEOjOivBnO6Pmen/41PFbEz1Aoo46zNrTAkaC0SEfJOLFATsTcqaGYVZYHSw7cGXuj6grtQ86bjycTkRIUm58ncirQlavPLnf3rGmHnKP+BXpPAm+Jr32G9fDqIlbJV707hq1w1kqzKRk7EcFGP272nUQlp1VAMibqnEoyTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770232; c=relaxed/simple;
	bh=hl/e46bt+NV7xhSLcpwshQaRHMSZpy2jWbNDJoj1F00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q+uCeixA5x23/nxhIwn8Zj0giVvESb0w98H+jy0iy3lPf6aPI/Vu5gDJn7EkfnkotiwP9TkQmCYgUO/Ua/7NAyeq1vk1ngL8eH1Qwh/TxDPKP5hB/LV7r4auwVLaMf7cNed82fkL8zBobeP//RyCE/HGAiNAW6xBH8eCatrq3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b4l9AY+m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IMFw6f016036;
	Wed, 19 Jun 2024 04:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zalxSQ9cDU7f7E+fQijsIy
	M+ge3uidgooW+tRavYCU8=; b=b4l9AY+m77Hnr28FyowyHjbeO3VOPf4VKK6ZBG
	UQLYubO40eAHfnNQhZpbQubEA1yVMGIQbVNK01LCJCh8I03j0SY4VhMGwFEE2acf
	Ydu1+Gdz1RU9wNshCqvOG+B+jcUXFFINuOkvrjbaUzy0vdMgnBng/YVGKkdNdR3z
	wvYt1QiKqJ+IjUB99ndP2unIGt+NW7uIvX6B0QUlRcVltIMZqMWw12hOqzQnibKf
	zKzwwW5SoW6xDzdtpVYMI+ang3NkRHDA3tZ5yPQfPk25EXHUW7xh7pCK4jB4wKnu
	6UcvyJViwCT2PreupyV+I16w7ELW6+XL0cky5LoyvTqlyrYQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujah8kdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J4APNY013276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:25 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 21:10:24 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 0/9] wifi: cfg80211/mac80211: add DFS support for MLO
Date: Wed, 19 Jun 2024 09:39:50 +0530
Message-ID: <20240619040959.1457547-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xJhLxTbAUxkT-x54CsVNv7IJQGl8oE_K
X-Proofpoint-GUID: xJhLxTbAUxkT-x54CsVNv7IJQGl8oE_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190029

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
  wifi: mac80211: fix label name in ieee80211_start_radar_detection()
  wifi: mac80211: handle DFS on per link
  wifi: mac80211: handle ieee80211_radar_detected() for MLO
  wifi: mac80211: abort active CAC while freeing the links during MLO
---

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
 net/mac80211/cfg.c                            | 46 +++++----
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
 34 files changed, 292 insertions(+), 135 deletions(-)


base-commit: 5ad8897fd15a3716601509ed4a7bc47bf0cab661
-- 
2.34.1


