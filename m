Return-Path: <linux-wireless+bounces-22167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B106DAA0108
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCDD3B8F43
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501C224AE0;
	Tue, 29 Apr 2025 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P42vQbv+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3621B9F7
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899281; cv=none; b=NFtS9IqP5NPPpFX3gKq/vjjzH8RVOv3Ip74Pp72r5u5U7h31zF0FIWSnI1h0FKCwYybaU3QLZh7z1UJ0wBWt9ypA1l9a6hWpAM483iHb2+XP5MU9Vn7AtkjqsGwlr4UifxAC3moqVgdLYO5IX5+TpLaGOAUfPkAFzMnaex22O8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899281; c=relaxed/simple;
	bh=tWMrJ5cuUxp1G/39KwH64QiabcNPppLMg4IWq+RvZNU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eOFFupFMleGsDKgzfE4IByAtbQqv8AdgNWzOkomODw7nHYMIffAE/gT9i/ykqRCmgSV94vM8xyffPlA6dANIdNakhrIuvjFCLy51j2x3NtWfrS1cxy5Kz0ROk4WuTP5zT/VP0JyeM0OXpAM26XNVR24MVwODOcBuvABImHIaIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P42vQbv+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNq0mY000499;
	Tue, 29 Apr 2025 04:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=o3Z9YeqeO+BB9W1Vkywgy0
	+OxT2e7yVir36dngyhTMk=; b=P42vQbv+8QvmYo++MF8pu8CPKKwf+RI2P7fKIs
	dXZ5u7Twv0MBqUQqcfj+QDqMhA64GNf0+m2gYqO7IwEfRmtBhVFcpxz7WQVDZ5nh
	Ixa3XPX+AJVy/3NFveK4tR2ZU0WzgLogdMtMO/dkE5TFqST63Y/umVVabqVviSbo
	sT/zMKBkT5KNmJihOIycxBclwPvYf7chPHS6VvH+Tcds5jgsKLUuPylMcapLptyl
	jcuzHX9MPT4N8wm+StUj2+uXLXH8s/sS4MbSafYbOD92+OrmLceSj1dNZ5/YGivZ
	bRgjn/hDb/5N64zMFupfORXl+xVvg/Q+Ew4UdsowWw8YEDnQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qv9k55d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:01:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53T41EGO007609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:01:14 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 28 Apr 2025 21:01:12 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v9 0/3] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Tue, 29 Apr 2025 09:30:45 +0530
Message-ID: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=AO34vM+d c=1 sm=1 tr=0 ts=68104f0b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=OmEEMuOC34kc_pH8e8sA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6omfbLVlrz82O6hSU1JESdgHdtJwjlRA
X-Proofpoint-ORIG-GUID: 6omfbLVlrz82O6hSU1JESdgHdtJwjlRA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAyOCBTYWx0ZWRfX1f/8BMYZHKNX iwJ4b0pGtV5NUx+SCwvJ3JRYBYuvWYuzJamy/DlvdC+9n5pRvjKQvfIih2PM3Fnv3Q++C77JAPk WIRdqEGmcGzOtV4YnkXAma97hahBubqVA4nzym/bf/UoLys0J1DeE9jfeI6wINk6lwdtkftXokL
 AkWPp4TVubAEmX6dDgzIWr6jtoBCuTK+nzN9hwo38XAj1EpYgwBS1Ki5HAH5WEAs9EP183jFV5E LouJtrA4SQ0+AGmhsfNteLlZ7eWeHoJW+j1PnX85LfDXy/8u/WpfCl1HaY3TrRRaaoklAFv+ZKC P7iGPdoE7/0riMPpl283XA7tnRX0RhjIkNU1V/F5ClOg9Vldivwvzmoambat5Z/7pBEAIEnnGBb
 gh8MIxX+HWhz8EBmDdQvFMFJjqO3nZbysWOy5I4CeJPoa9p/1Btx5b7xD+5rx1uR32W2uN7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290028

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
 include/uapi/linux/nl80211.h                  | 13 ++++
 net/mac80211/cfg.c                            | 12 ++-
 net/mac80211/driver-ops.h                     |  7 +-
 net/mac80211/trace.h                          | 24 +++++-
 net/mac80211/util.c                           |  8 +-
 net/wireless/core.c                           | 19 +++++
 net/wireless/nl80211.c                        | 75 ++++++++++++++++++-
 net/wireless/rdev-ops.h                       |  8 +-
 net/wireless/trace.h                          | 11 ++-
 net/wireless/wext-compat.c                    |  9 ++-
 51 files changed, 257 insertions(+), 63 deletions(-)


base-commit: f600832794c91d7021d7337104734246b02a2b86
-- 
2.25.1


