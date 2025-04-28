Return-Path: <linux-wireless+bounces-22112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC87A9E729
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 06:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6651718930D2
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 04:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1B17A2E3;
	Mon, 28 Apr 2025 04:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P3JkVJ3m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071713AD38
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 04:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745815133; cv=none; b=snGkVxiS/lDaf5IFfTfpaHGuuT/Vp9C+9pJvaoKZjM2JAIH1SU9VJVr3xn7HUT2yPvQ8ha9PplbtW2YyVP1Lfur1jeZguHLOnS+XSyfeDlORjEp8MzaDiYSaRW39Vjz3OTMBxb5SeuS2bMghlA0i+/68dMGBrKofJpNdLxmWDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745815133; c=relaxed/simple;
	bh=PjBS6ANGIeE31QdwVcloVDN3+MVgmmkmbcVJfnheYT8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0vAK1L68ubCGP8z6EnFENd+IEidWN6LoJOLmfQAcH0ZQeoM09XNJFILJt1QC01OhksLGGioOnSlNei/c5oIblj+0VguMYHZT8ngvippBEKGiaZr130LrpT4SpHOGITltX1i2VSU+sVMLEF2w26yG2GIxRMzeTFAflAHmyywgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P3JkVJ3m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S39PQq004532;
	Mon, 28 Apr 2025 04:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tRNyoV6UzWompKXz6n+Duc
	CD12q1rPSMK7ICjdxCopY=; b=P3JkVJ3mTO39buo8qcKIZ1GmvPNvYORPFn1WOx
	UPEywcVoDP8TX4LBsG97XJGyHm2MkLm7eV/4RvUvpFTtlYuVm5dVGzShRyIw57dd
	mxqgOMTH3AV+Y24XftdJ5ojJ1PToRi5mP4qJk+H7dOx/CvbsxNc6CGKtX3Y5fvNO
	OCG0qUlh0pzEzKjmfItoOlNRGNjXgblerUhocbZfGHTBmQvzsveMYn+Wy3iPLl51
	wjKlwoYeKQdR32x6RDVDZARpSdQWUkwWLEgAkSd+mD1qeOM31hyVASa5CXLc6OER
	m7ZRxr1bjjECVWE5I5QWf0COdovwdunEjAYBkZK69lcrY4pQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468rsb5txx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 04:38:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53S4ckMi022444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 04:38:46 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 27 Apr 2025 21:38:44 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v8 0/3] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Mon, 28 Apr 2025 10:08:25 +0530
Message-ID: <20250428043828.1931147-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDAzNyBTYWx0ZWRfX+pwZ3OAv6N41 SkKxLZBkfnflDi/zUQUu8T736lF36wod7uWLnoP7VpHR7Ka2ZP6xyo8v01Dg3/A+yvSYhTgnkfR bFsmRTtLNF+V682uTo4v4nDDqy9Hl3YYINNIyjY17aI67FYAootZu4OFSmR+zDb5CQBFJyMC1Sm
 7eG7GIEid7sTM0rlDABbmy6nPSLgrzkgrmEKplcYRkgdZRMWOuuWjksGntJcxgW72VMGRA8tLvW FbTsct14IASbvSi9W42QOxhEtl0Ek4rPdvP8zR0pjwrGkkSDl4m5bHXiUrDkDk87qdeyUv7zdB7 QYksmZjO4490N31TIOadegDUdI8/Mw9xAXersQ/OOfjohZ8VfjhmyEymzpSegvChn9M65r9tth4
 A17gBAgUyENeFka2igfmTqpmxcOpJecP+1pX+tPbSr6wNjq8c1MPk8ZWxwTp7Zy0CJsZYNTC
X-Proofpoint-GUID: E8lRGlqx0bMNMQ7-STmr7SHWZlQfOWtS
X-Proofpoint-ORIG-GUID: E8lRGlqx0bMNMQ7-STmr7SHWZlQfOWtS
X-Authority-Analysis: v=2.4 cv=I8ZlRMgg c=1 sm=1 tr=0 ts=680f0657 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=OmEEMuOC34kc_pH8e8sA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280037

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

 drivers/net/wireless/ath/ar5523/ar5523.c      |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  4 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  3 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  3 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  3 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |  2 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |  2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  2 +-
 drivers/net/wireless/marvell/mwl8k.c          |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt7601u/main.c  |  2 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c    |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  3 +-
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
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  3 +-
 include/net/cfg80211.h                        | 20 ++++-
 include/net/mac80211.h                        |  2 +-
 include/uapi/linux/nl80211.h                  | 13 ++++
 net/mac80211/cfg.c                            | 10 ++-
 net/mac80211/driver-ops.h                     |  6 +-
 net/mac80211/trace.h                          | 24 +++++-
 net/mac80211/util.c                           |  8 +-
 net/wireless/core.c                           | 19 +++++
 net/wireless/nl80211.c                        | 74 ++++++++++++++++++-
 net/wireless/rdev-ops.h                       |  7 +-
 net/wireless/trace.h                          | 11 ++-
 net/wireless/wext-compat.c                    |  9 ++-
 50 files changed, 228 insertions(+), 62 deletions(-)


base-commit: f600832794c91d7021d7337104734246b02a2b86
-- 
2.25.1


