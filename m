Return-Path: <linux-wireless+bounces-17929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27CEA1C43E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 17:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C6516831F
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB8B2D057;
	Sat, 25 Jan 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iWA/S2sZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8C2AF00
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737821601; cv=none; b=CEti9R2fBwmaMDkytTJQaMCUGxfRjoeufYoj9SETSX/t1lw2wN+Jc0RK6Sp7iNhz8I+Kx+6T/SX9OGF+aTfuqWLPbt+Ltd5Zu+oMXnkVkgKS+KnonnX0nvpo7Zq5dZ5MmHR9VaxkVYdw+DQs660Uxzz4esg0WZo7vQfjjuFJwh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737821601; c=relaxed/simple;
	bh=NgucDrddbC4kL48SrswbmoD2o7RWgxXdSeOKXU7pMqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jqpEv/shN53szFZPV5TCil3UaZ5B2Oge6EgUVrKxWaewRNt9BSaQD9oCj3c6TGnhhic5ufQ8PAdTruAf15aThQMiAQo7jKMXSO4PwEpXIHSklLnIscTlEhtU8DdCGajLg6r6qEDHK5/4KY9m88s58OiujHaLJIsYs74OYI6rVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iWA/S2sZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50PBp0wR009379;
	Sat, 25 Jan 2025 16:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vSo3aiO5qu3HROg5ofl6Qp
	4Cy86kTs5nCOFq/s3QLOQ=; b=iWA/S2sZ+b0uacICKLXWGhvgnJo9P3rya4wXSG
	otNQdOWE3tsyo4sxn9g3XHEgCvB83v5lrlbpjav/hgDJ4BqXmh+/072XNutXpHpe
	JaD2J9yPeA3mpjMh0G6fs+g3e8jPQ7fgvZ7h0Bq0QA0StlkmJ2O4PZiQOp4WEimO
	zb+xWTAm6z6+a+6zuGJJLzKPHis7juHlLAKaqHN7k1Ryx+nIyVTauagmV7uKKRzo
	51DNQcMRREwEIHcf3ZS4+FtxxHZnZmG5fV2I4CAOtbvRXEAntYZ7Ec2an8nkK7zw
	CaGG7dv2QUlZdr/5Pz9Uukif7oP5pY+LGne2NVWiqbIQBJbg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs20rqew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 16:13:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50PGDDeW024479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 16:13:13 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 25 Jan 2025 08:13:11 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v3 0/5] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Sat, 25 Jan 2025 21:42:43 +0530
Message-ID: <20250125161248.1042318-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5bH7EpC1gIIV8SR8hqhjk9ED2U5FyL6p
X-Proofpoint-ORIG-GUID: 5bH7EpC1gIIV8SR8hqhjk9ED2U5FyL6p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0
 suspectscore=0 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501250118

Currently wiphy level configurations like RTS threshold, TX power etc.
lacks radio level get/set support and same value is applied to all radios
of wiphy. Add support to parse radio id attribute and use the same to
apply the configuration to corresponding radio of a multi radio wiphy.

This design will not disturb the global wiphy configuration. If radio id is
not passed from userspace, then the existing design of setting attribute to
all the radios will hold good.

Also add support to get the radio specific attributes in a multi-radio
wiphy from userspace.

The attributes that can be handled for each radio are:
NL80211_ATTR_WIPHY_FREQ
NL80211_ATTR_WIPHY_ANTENNA_TX
NL80211_ATTR_WIPHY_ANTENNA_RX
NL80211_ATTR_WIPHY_RETRY_SHORT
NL80211_ATTR_WIPHY_RETRY_LONG
NL80211_ATTR_WIPHY_FRAG_THRESHOLD
NL80211_ATTR_WIPHY_RTS_THRESHOLD
NL80211_ATTR_WIPHY_COVERAGE_CLASS
NL80211_ATTR_WIPHY_DYN_AC

With this design, the new userspace designed to set/get per-radio
parameters can work with both traditional and multi-radio wiphys.

v3:
 - Fixed warnings to refresh copyright, to curb long lines of code and
   to include kernel documentation for a few variables.
v2:
 - Converted the series to [PATCH] from [PATCH RFC], link to which is,
   https://patchwork.kernel.org/project/linux-wireless/cover/20250107182506.1838704-1-quic_ramess@quicinc.com/.

Rameshkumar Sundaram (2):
  wifi: cfg80211: set tx power per radio in a wiphy
  wifi: mac80211: set tx power per radio in a wiphy

Roopni Devanathan (3):
  wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
  wifi: cfg80211: Report per-radio RTS threshold to userspace
  wifi: mac80211: Set RTS threshold on per-radio basis

 drivers/net/wireless/ath/ar5523/ar5523.c      |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  4 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  5 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  3 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  3 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |  2 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |  2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  4 +-
 drivers/net/wireless/marvell/mwl8k.c          |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt7601u/main.c  |  2 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  4 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c    |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  4 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |  2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  2 +
 drivers/net/wireless/silabs/wfx/sta.c         |  2 +-
 drivers/net/wireless/silabs/wfx/sta.h         |  2 +-
 drivers/net/wireless/st/cw1200/sta.c          |  2 +-
 drivers/net/wireless/st/cw1200/sta.h          |  2 +-
 drivers/net/wireless/ti/wl1251/main.c         |  2 +-
 drivers/net/wireless/ti/wlcore/main.c         |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  3 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  4 +-
 include/net/cfg80211.h                        | 22 ++++++-
 include/net/mac80211.h                        |  2 +-
 include/uapi/linux/nl80211.h                  | 10 +++
 net/mac80211/cfg.c                            | 25 +++++++-
 net/mac80211/driver-ops.h                     |  6 +-
 net/mac80211/trace.h                          | 24 +++++++-
 net/mac80211/util.c                           |  8 ++-
 net/wireless/core.c                           | 18 ++++++
 net/wireless/nl80211.c                        | 61 ++++++++++++++++---
 net/wireless/rdev-ops.h                       | 12 ++--
 net/wireless/trace.h                          | 16 +++--
 net/wireless/wext-compat.c                    | 11 ++--
 50 files changed, 227 insertions(+), 84 deletions(-)


base-commit: 376673aa393c1c232299be3e910d7f2e6d974b2f
-- 
2.17.1


