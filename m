Return-Path: <linux-wireless+bounces-23241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAA3ABFC5A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 19:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C284A20D6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE51E3DED;
	Wed, 21 May 2025 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IEFP2Nk1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE213212A
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848957; cv=none; b=CHG5RS3pXsJ83G/6a7iv5sRtc3h9Hia9WxUbFQNYxy7sq9rBzRsRVNPHEFuAdz64KMWC4ZQQKGg3SjdNcPcRc8AHfAJNMGf1XRqopWVxsm7xPJeBu3HNLllR6pvc7lnjy6mC9gfUVCsRyugYVvBepYTwr/4a683GWsPRzwUW1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848957; c=relaxed/simple;
	bh=T8s7qS2KKu28bxla7C3928YJ0N5zmLiwbIlqO5DikY0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5Qu3wl1iQf6fb1NkRMw/5mZbV6pVHWGhojRXvorxK3jO7vW1hLwUvV16PsLtKo0q1fq7MqJy6XmdITDXiyqb2kubs0XRK9aWdTL8S/LnM/UWey+DVAl4oAWV6Inu2ynOZAsyQAxmwn5JKsS819ELsZdiajYRk7bJoRHfuP3QCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IEFP2Nk1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XJHr031694;
	Wed, 21 May 2025 17:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9SpgOO/d47lbkqQcfSTVeL
	igZFEiA9E39hZzVHZd+qQ=; b=IEFP2Nk1wgu+yl1WvjG/NHi4Otjd5nWPtK2Zgf
	e0rRbUdz3qLVx2ragsQmyvWSVVJLesIryaBljsTFaidcKN1CseNoNBXLvxsYd2Dt
	sL4xrKsGLVSl+w63EpWxTRfv1ak3lojAdCgwjlfjE/RCFH/lI74rQFj290veH22K
	09y6irNqO+Aec2UVLMnIaveS9NLerp5SZpzU1coE/lMrzZS4HvyqaFsv7KMS74HR
	xwoEX86OCnXVhliRCt2HjizkAKXv4GXkKmSVMp4k67uOjkDZXZVTf7QfqGUYj/um
	3wQ4nzMzk6MkzY/pWDVPSiIzU34DbiZ/5HqL3sy3dGK8CelQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c22ahn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 17:35:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LHZnIv023642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 17:35:49 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 21 May 2025 10:35:48 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v10 0/3] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Wed, 21 May 2025 23:05:18 +0530
Message-ID: <20250521173521.3211596-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE3MyBTYWx0ZWRfX8NyIEIYfDSl5
 iCIoTROqt3KZmugik/WvKQ3fqlDWHG3Te0UQp+tz4nZdm7k++c7ST4jaQkn54G4q0WL2abhZJPq
 ZWG9mlcod9x8lFrEJ3AYnE5MakJ/MPada6qU0tTtbJsNAMyTpwpc0CwPeP1RJWkRwochuPA0OdC
 t4GpxeJAXcGr2MB7Puiz2adoiUdqpiDD2dE6tZMXg/PUpCx36UIzeSqpIKJ4ZqlmbdyMwiQoetX
 uGtQbhAcC4A5O+d5oxPeAZJ1XkJy40k/jmzs3+Dn5fvSS5YNbjBl04PjwxodrlvZLg6zpCzhisf
 nvXwM7elo71OqRBzHnfbvqRKUF49PgNhax98nzcjVAdafNFZaf99gjZVUX3FL3uvjiuNta2i+Ql
 ayeB6tzLXgrLtiDHfW1raweAFoBbF5AIGJVlOFu0NcnqK2TRQApqAey0/mAhRy51NS2XWxjJ
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682e0ef6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=OmEEMuOC34kc_pH8e8sA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JNhOAUle_ga88M_Z5YKOzgI6MQa0CybH
X-Proofpoint-GUID: JNhOAUle_ga88M_Z5YKOzgI6MQa0CybH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210173

Currently wiphy level configurations like RTS threshold, lacks radio
level get/set support and same value is applied to all radios of wiphy.
Add support to parse radio id attribute and use the same to apply the
configuration to corresponding radio of a multi radio wiphy.

This design will not disturb the global wiphy configuration. If radio id
is not passed from userspace, then the existing design of setting
attribute to all the radios will hold good.

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

v10:
 - Modified data type of radio_id to int.
 - Resolved memory leak.
v9:
 - Fixed errors reported by patchwork's wifibot.
v8:
 - Fixed warning reported by kernel test bot regarding variable
   initialization.
v7:
 - Addressed cosmetic comments from Johannes Berg.
 - Removed patches - wifi: cfg80211: set tx power per radio in a wiphy
   and wifi: mac80211: set tx power per radio in a wiphy.
v6:
 - Fixed warning reported by kernel test bot.
v5:
 - Changed default value of radio id from 0xff to -1.
 - Changed driver callback order for global wiphy parameters.
 - Fixed other minor comments related to code-cleanup.
v4:
 - Fixed stack frame size warning.
 - Added S-O-B tag in patches 4/5 and 5/5.
v3:
 - Fixed warnings to refresh copyright, to curb long lines of code and
   to include kernel documentation for a few variables.
v2:
 - Converted the series to [PATCH] from [PATCH RFC], link to which is,
   https://patchwork.kernel.org/project/linux-wireless/cover/20250107182506.1838704-1-quic_ramess@quicinc.com/

Roopni Devanathan (3):
  wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
  wifi: cfg80211: Report per-radio RTS threshold to userspace
  wifi: mac80211: Set RTS threshold on per-radio basis

 drivers/net/wireless/ath/ar5523/ar5523.c      |  3 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  5 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  3 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  3 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  3 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |  3 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |  3 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  4 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  2 +-
 drivers/net/wireless/marvell/mwl8k.c          |  3 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  3 +-
 drivers/net/wireless/mediatek/mt7601u/main.c  |  3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c    |  3 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  3 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |  3 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  3 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  2 +
 drivers/net/wireless/silabs/wfx/sta.c         |  2 +-
 drivers/net/wireless/silabs/wfx/sta.h         |  2 +-
 drivers/net/wireless/st/cw1200/sta.c          |  2 +-
 drivers/net/wireless/st/cw1200/sta.h          |  2 +-
 drivers/net/wireless/ti/wl1251/main.c         |  3 +-
 drivers/net/wireless/ti/wlcore/main.c         |  3 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  4 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  3 +-
 include/net/cfg80211.h                        | 21 +++++-
 include/net/mac80211.h                        |  3 +-
 include/uapi/linux/nl80211.h                  | 12 +++
 net/mac80211/cfg.c                            | 12 ++-
 net/mac80211/driver-ops.h                     |  7 +-
 net/mac80211/trace.h                          | 24 +++++-
 net/mac80211/util.c                           |  7 +-
 net/wireless/core.c                           | 19 +++++
 net/wireless/nl80211.c                        | 75 ++++++++++++++++++-
 net/wireless/rdev-ops.h                       |  8 +-
 net/wireless/trace.h                          | 11 ++-
 net/wireless/wext-compat.c                    |  6 +-
 51 files changed, 251 insertions(+), 64 deletions(-)


base-commit: 0b0ff976af94fc2437b62e3798f11aacc3798613
-- 
2.25.1


