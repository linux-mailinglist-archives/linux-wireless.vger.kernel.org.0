Return-Path: <linux-wireless+bounces-23750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B05ACEE52
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC94F7A9F14
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFA2214A64;
	Thu,  5 Jun 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YgVqsKZM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9F1C4A20
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121881; cv=none; b=H/XmpVTPjviinsZ+Ydi2a9gjZ/lPdNXQyYk8lgOAP2XMkx2rO7+i17tKGL/QjJohoIGsWFEjGk7nVodDFzejwoD+usURAzHJGdNUwf2tJKpAkThvFnvOQixek5go6vwtQXi4HCbb5n2aKFNcbWcbnxBAic5q0bbECR0uJLrEKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121881; c=relaxed/simple;
	bh=Y+a5j3bpZUn7/H6H6vVGCVIfRkVrEJNmGQ8W4sn0pMM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L3BqMd9Mclkgaag1Ft70eEtNaeY9ifq7SEitMiW3UPSCcKQ8Yw9dD8buH2Vf8YQGu7Z/kT1N0qkh05z5qx4rPQ+FUP2Ocv9DLLmmqzsbtwc+ir4zgXxxPQz0bsHS9wbSugkxV+14QQnvz30p0TbYbW76rp8J2CUh/zEU4V3TwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YgVqsKZM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557vcBe000905;
	Thu, 5 Jun 2025 11:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vdyj8j0FSCnJre1PtfyRSd
	4j204kcXANTvPhJ7Kn4HY=; b=YgVqsKZMeN9D/vCXhVX+bMDkIk94qFgAQzZBca
	0zS0zbUYC6h1c5xI9JmGi8E0wlAwkEMZJP8Rx0lmdxYVWg3Pk9SsLz4DlLEduf8r
	PfZJl0tymE91r/hE9iSvGfjNujVceRdahgH+tzejiWGZv4QRhBdhv6KrNMPqDVCE
	Fu8OOP8HdYDBeOlSf6O3uiYMuE9LO1TJslq9IJMkW9wRrwIvvREefYIgx6TLn4rc
	8JT/4Eg1kSVpSvdGfOPDKsDW86MWTVHJIrKNBcHunl4cwm+K7ebyrpWgWhCcxzkW
	TrgL80m9DRAEVEG7ld/+kD5Z3NDERTqs+yiFzco5KrNf465g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8q9414-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 11:11:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 555BBA8t002809
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 11:11:10 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Jun 2025 04:11:08 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v14 0/4] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Thu, 5 Jun 2025 16:40:36 +0530
Message-ID: <20250605111040.3451328-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: i575yL9nAkfcjTg66DCxpSDPo4sa0gKR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA5NiBTYWx0ZWRfXxlXVsSI4h/a5
 i8lkTIRQ5AV8UvtAUMtloEQiFkIJiFmUTW3f+K8S2OTJ4KHa3of/acqMTEqB+fwzK/v6YEFeuNH
 WufGatjQKS0oIYsrOvkyMwPZqeGx8g0y8CgySG95M9XhDdv5XJEnlHl0g4YqxZY3BJ9/Ej7E4E/
 3M50vl22O9Lgmd5J2eO3vPKszWkcOH4w/jtaj5P2XnP68rerrNVfdINlBl39dTzvHNTMrvsvkap
 uQBJn1EjB067Ci55OhWLpND8eOWl8j9cJQz//nfdeylcAP6EjI1N0+2k122s7gYfrPCXww8d3wi
 edYMLAkyBGVEEMm+me7x53cGp2EofqZ6Amf0K4KYM0wTWUlrM00XTdSdnv+yw/Tsd1ZIX4IzGzF
 hlbWz6mrNnQfN1S3PUnq8wrH15uX+kjMR9vqUCDUC1Wlw3+c6vc89uPEkIcNzQ2QHTqZ+7TM
X-Proofpoint-ORIG-GUID: i575yL9nAkfcjTg66DCxpSDPo4sa0gKR
X-Authority-Analysis: v=2.4 cv=PrmTbxM3 c=1 sm=1 tr=0 ts=68417b51 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=AQ-yx8gawSN0C7fi4YkA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050096

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
 net/mac80211/driver-ops.h                     | 36 ++++----
 net/mac80211/ieee80211_i.h                    |  5 +-
 net/mac80211/iface.c                          |  6 +-
 net/mac80211/main.c                           |  9 +-
 net/mac80211/mlme.c                           | 12 +--
 net/mac80211/offchannel.c                     |  2 +-
 net/mac80211/pm.c                             |  2 +-
 net/mac80211/trace.h                          | 78 ++++++++++++----
 net/mac80211/tx.c                             |  4 +-
 net/mac80211/util.c                           | 24 +++--
 net/wireless/core.c                           | 19 ++++
 net/wireless/nl80211.c                        | 92 +++++++++++++++++--
 net/wireless/rdev-ops.h                       | 39 ++++----
 net/wireless/trace.h                          | 79 +++++++++++-----
 net/wireless/wext-compat.c                    | 10 +-
 94 files changed, 638 insertions(+), 293 deletions(-)


base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
-- 
2.25.1


