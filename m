Return-Path: <linux-wireless+bounces-24103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400DADA142
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Jun 2025 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AA616FA31
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Jun 2025 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178E45C0B;
	Sun, 15 Jun 2025 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LbCm8IbR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233AE1E4BE
	for <linux-wireless@vger.kernel.org>; Sun, 15 Jun 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749975874; cv=none; b=hVM/Q4hde6g9SXVEgmVb6E3YmZXYbB6GPWC2dWYcNY9PpMUk2Tw8WXCSZuhEcQ0S382kG1MLZ/pIRfRKFrAT3hNgBzcV2gZduzFU3zJwL7WelI5/IL7uDU6q1yluLT8aZhmg78ODfZ8lMPTSZWe0dL2LqTg6XKPKAOxppwFaeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749975874; c=relaxed/simple;
	bh=xUDSH5oEAYV7LjmiuhVBPkm5qgqSkNiO3uISZBqbF8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rMRxJSwctNY/NWr9BVVkpOJAjAWv6pcwWcZpUPtEHfIVBdy6e2NJ+vgKm9HdY4Jl6iMFSv5WHCkZKXUF86UlYVyMxz87jIm/7IX9VjSgBSHpS/2xHRiy/2vhvjQ1qGUbThte7bNwcwYEkZREmgyQm5ayPV6H5bvgCL4Jn9sTyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LbCm8IbR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55F3V8dj002891;
	Sun, 15 Jun 2025 08:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=l7lXg/x2lisppHpSeSqAY4
	YLiqgJq+m8hGCeNRcB/XQ=; b=LbCm8IbRvKi8JrKnLQY5IyJNxzF+AnT3VBD+Ct
	w2M2Q8hm808oO8qJlmM1UxKHGBGhtfwKeFQw+cCCG+Qusp0jam6tT7IGKtM462iE
	8v553PNcTkFTNlVAMF9RYcuk6JQgGUkTHmnOoZ8xJz+1QtsQNNC5BUnBL4wn/z9P
	RktQZy5ifNqVb7Tu6hVTYzdnfxDRUTiPe/6LCH2qX8oJrNQrVdS8O0waHLvR1nYy
	IXceV0gDCFy8ZV1oI9g2emex75zjVd3zy5o48cCYq3mW0nInHvyEYhq1SX2vLroi
	5A1DKgXvxIboZ/AyEgALr+V18OH5pdm8vqRtBzEs+ixJOVug==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791en9md5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 08:24:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55F8OMvj009709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 08:24:22 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 15 Jun 2025 01:24:20 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v15 0/4] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Sun, 15 Jun 2025 13:53:08 +0530
Message-ID: <20250615082312.619639-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lS8NhGNRCAwlCEZLjcXEelmFHG0eCIJu
X-Authority-Analysis: v=2.4 cv=D6RHKuRj c=1 sm=1 tr=0 ts=684e8337 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=AQ-yx8gawSN0C7fi4YkA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: lS8NhGNRCAwlCEZLjcXEelmFHG0eCIJu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDA2MCBTYWx0ZWRfX5E/XcP3xWZbU
 PZ+X7/9wqOdp5dTyxP/tLO97akULoOSxJ7YU0ht1kKL4lVf7mPmaojgHQJKmvdcxTowFBmjIwhW
 015T6tqogkkQ2UXKwUXutkBIT07peeuQ0NytmCAS2TzuRs2ihQS/CpNzcTYlqxzzxAkXkVJzYHR
 5dUec9shb1zU3FafgVly+ze6Oyt/M+L2W4kusAeD9VcCfkJVENOYGyqptluwUI/TKhMth0m3U8s
 mKRCrR3sP1D5SWECFeM66cstBxRXtVFRDR6iNN1WMeJro+IqfewtQUihXYc/CGRFp8F9iAu6fbw
 ZabH65QqoB1nWiYSqJzMU/XTtzL0b/Vu5ujTk5t3im4GOFTY/UFXWl088nlkAdrSmdXb6MrA0Qe
 JJNb1yVNq133MDQoVrNof3NG+B4QYKU4vRm2sJ/KucwKadAlFsOcokcZcnx6kkDBljBWTmH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506150060

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
NL80211_ATTR_WIPHY_TX_POWER_LEVEL
NL80211_ATTR_WIPHY_ANTENNA_TX
NL80211_ATTR_WIPHY_ANTENNA_RX
NL80211_ATTR_WIPHY_RETRY_SHORT
NL80211_ATTR_WIPHY_RETRY_LONG
NL80211_ATTR_WIPHY_FRAG_THRESHOLD
NL80211_ATTR_WIPHY_RTS_THRESHOLD
NL80211_ATTR_WIPHY_COVERAGE_CLASS
NL80211_ATTR_TXQ_LIMIT
NL80211_ATTR_TXQ_MEMORY_LIMIT
NL80211_ATTR_TXQ_QUANTUM

With this design, the new userspace designed to set/get per-radio
parameters can work with both traditional and multi-radio wiphys.

v15:
 - Fixed hwsim warnings.
v14:
 - Fixed errors and warnings reported by kernel test bot.
v13:
 - Fixed errors and warnings reported by kernel test bot.
v12:
 - Added a patch to introduce a new NL attribute -
   NL80211_ATTR_WIPHY_RADIO_INDEX.
 - Modified the APIs handling per-radio attributes to take radio index
   from the userspace.
v11:
 - Resolved warning flagged by clang compiler.
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


Roopni Devanathan (4):
  wifi: cfg80211/mac80211: Add support to get radio index
  wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
  wifi: cfg80211: Report per-radio RTS threshold to userspace
  wifi: mac80211: Set RTS threshold on per-radio basis

 drivers/net/wireless/admtek/adm8211.c         |  2 +-
 drivers/net/wireless/ath/ar5523/ar5523.c      |  5 +-
 drivers/net/wireless/ath/ath10k/core.c        |  2 +-
 drivers/net/wireless/ath/ath10k/hw.c          |  1 +
 drivers/net/wireless/ath/ath10k/hw.h          |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c         | 19 ++--
 drivers/net/wireless/ath/ath11k/mac.c         | 14 ++-
 drivers/net/wireless/ath/ath12k/mac.c         | 14 ++-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c | 12 ++-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  7 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c | 10 +-
 drivers/net/wireless/ath/ath9k/main.c         |  9 +-
 drivers/net/wireless/ath/carl9170/main.c      |  2 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |  5 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 drivers/net/wireless/atmel/at76c50x-usb.c     |  2 +-
 drivers/net/wireless/broadcom/b43/main.c      |  6 +-
 .../net/wireless/broadcom/b43legacy/main.c    |  2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  8 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c |  3 +-
 drivers/net/wireless/intel/iwlegacy/common.c  |  2 +-
 drivers/net/wireless/intel/iwlegacy/common.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c |  2 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 12 ++-
 drivers/net/wireless/intersil/p54/main.c      |  3 +-
 .../net/wireless/marvell/libertas_tf/main.c   |  2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 11 ++-
 drivers/net/wireless/marvell/mwl8k.c          | 12 ++-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  3 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 11 ++-
 .../net/wireless/mediatek/mt76/mt76x0/main.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  4 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  4 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  6 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 13 ++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  8 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  8 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  3 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 11 ++-
 drivers/net/wireless/mediatek/mt7601u/main.c  |  5 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  7 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c    |  5 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  8 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  3 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  8 +-
 .../net/wireless/ralink/rt2x00/rt2x00mac.c    |  8 +-
 .../wireless/realtek/rtl818x/rtl8180/dev.c    |  2 +-
 .../wireless/realtek/rtl818x/rtl8187/dev.c    |  2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |  8 +-
 drivers/net/wireless/realtek/rtlwifi/core.c   |  2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  9 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 10 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  9 +-
 drivers/net/wireless/silabs/wfx/sta.c         |  4 +-
 drivers/net/wireless/silabs/wfx/sta.h         |  4 +-
 drivers/net/wireless/st/cw1200/sta.c          |  5 +-
 drivers/net/wireless/st/cw1200/sta.h          |  5 +-
 drivers/net/wireless/ti/wl1251/main.c         |  5 +-
 drivers/net/wireless/ti/wlcore/main.c         |  8 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  6 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c  |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  6 +-
 include/net/cfg80211.h                        | 30 +++++-
 include/net/mac80211.h                        | 17 ++--
 include/uapi/linux/nl80211.h                  | 12 +++
 net/mac80211/cfg.c                            | 37 +++++---
 net/mac80211/chan.c                           |  2 +-
 net/mac80211/driver-ops.h                     | 36 +++----
 net/mac80211/ieee80211_i.h                    |  5 +-
 net/mac80211/iface.c                          |  6 +-
 net/mac80211/main.c                           |  9 +-
 net/mac80211/mlme.c                           | 12 +--
 net/mac80211/offchannel.c                     |  2 +-
 net/mac80211/pm.c                             |  2 +-
 net/mac80211/trace.h                          | 78 +++++++++++----
 net/mac80211/tx.c                             |  4 +-
 net/mac80211/util.c                           | 24 +++--
 net/wireless/core.c                           | 19 ++++
 net/wireless/nl80211.c                        | 94 +++++++++++++++++--
 net/wireless/rdev-ops.h                       | 39 ++++----
 net/wireless/trace.h                          | 79 +++++++++++-----
 net/wireless/wext-compat.c                    | 10 +-
 94 files changed, 639 insertions(+), 294 deletions(-)


base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
-- 
2.25.1


