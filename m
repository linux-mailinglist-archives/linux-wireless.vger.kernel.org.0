Return-Path: <linux-wireless+bounces-12310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAE6967FAB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B901C20444
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939DE155CAC;
	Mon,  2 Sep 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k/KuOjSW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05315442D
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259754; cv=none; b=YDHn6O2B2yf+xg4FgFbQ68N+bbrMhpObx6WYmMYi1etBBtAwGzCeVVsWWZxh8aPlI36/ktFsAjAe7HnXYvF/kBiLwhm9QxBiX0WnuXn6yuVyoaQ7OyGsgvXE/FyC4c4jZO3bPSKrBjfnqvgeVPq6vutJmlnrm98m0d4i68MHvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259754; c=relaxed/simple;
	bh=aD/CYMyCknwpNttj0MPTsWEcUwXZPvo9K46Q7j1K2N8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dFhATQMyW1zDsaDoYNTsb61ZJZgSVi6jTObUY/DFndMJv1SvQrt6QD+/Verlusmls+7NfLK8DZecZREUjzp4m8kjS9hZnaY874Tl4+cTnW4aj1ucLuM2vn/5kvhq7qocbDX9NY+2dVZyTiUCBXFE74MRh8aYtvECbTzbqMEUFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k/KuOjSW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 481NikjN008832;
	Mon, 2 Sep 2024 06:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6oPkwpwZH0NP6TTpuYN6r0
	Wu7jfR/EqpIBNg59tZ8r0=; b=k/KuOjSWEEU/s2prEz0iXv6OW7BzgQ8JBJaqtr
	hJ7PXaO3QR0KC4Cd3R3OYE0EHWrzm8sW0/U2DbtJt2ev5lWYZQrmsBNss8rcZGup
	XCfGljWhYOSZvG2kyXf20+YJCFdMv49ZI1vk4EPW04UHREuvWGZPB+/LoOEzR/G1
	J9vvgoHGYc68oqg5UW/QFiWIGh63VM7ZsOvjH8wgKbFGyELNerNcSd7c4dVZcZfr
	Z+WITVtxgnbM8mPKpAhSwE2yjk+EuKEjXX3pFpXnCiC91f+g7I+BNiqreehQj62Y
	VNsFn8wfRSwgZ63IP6pkyyYPV1+CjSEQQIgWEoLVkz3bJZvA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btrxkqqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 06:49:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4826n5vh028329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Sep 2024 06:49:05 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 1 Sep 2024 23:49:04 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v5 0/8] wifi: cfg80211/mac80211: add DFS support for MLO
Date: Mon, 2 Sep 2024 12:18:39 +0530
Message-ID: <20240902064847.2506090-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: Bijs-zSD_QCifXvCVEzPaKCYqYGL-K8P
X-Proofpoint-ORIG-GUID: Bijs-zSD_QCifXvCVEzPaKCYqYGL-K8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-01_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409020055

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
v5: * No changes in 1-7.
    * Fixed sparse warning in 8.

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


