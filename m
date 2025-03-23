Return-Path: <linux-wireless+bounces-20707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F966A6CE48
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 08:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A720B189265E
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 07:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32281FFC4F;
	Sun, 23 Mar 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OxU4ijJp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B121F91C8
	for <linux-wireless@vger.kernel.org>; Sun, 23 Mar 2025 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742715636; cv=none; b=Irz5l/+ZuCxq+vmxHcLR8qpQZyDvUqrZoEch/rDtCRGkpGbAGzcppFmD4dgILQQIk0mcR8n2YRaNceCgirMBgtnEUuQWY58WS79oMtUk2kbWcz/7uxBHZzm1pOwBYHVXc9TWdB+t6/YvvLQLoSTzz2q5LrhXar4bxWYUuauSVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742715636; c=relaxed/simple;
	bh=x+CL518J1026/8nJBX+nqpCGpiGQyNX8MCf0BGVO3Ys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L3qFP6lrwMJ3cMPRhHQvzL0CDHTYVUIo6pqkpfex1D9m4h/4wUaj55icegUsOTFWHhCKjk1GVB9DmjUBKaR095vmn7UOaiFItyE9k6ct8g2UJIQnOHAG6zVL5Gl6NbE/p7igiVXA2gul59WOsRuxXtSWQl6Yh2FAbv67HIMDdFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OxU4ijJp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N5r8s5009976;
	Sun, 23 Mar 2025 07:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kNUCRGBBtaoUwOfO6dZkex
	Ad0anESfj7mKnbFn6f/2M=; b=OxU4ijJpa7Z9k1z5UHqNjf5C15GcbkYgM9njth
	F2J5zqoyv33Vr37UGUL8J9xT5PENby32U+4VPj7IiI+C3rjmKMYu+3jG3mZsdcuN
	F6yLCFwNhwEjtAm+kqG1wI2ebMhTpRzReuEe2GsyCHQL2JrhIqou06FLmKEIMbmT
	x8s76ECCXHOyZmW7N12lnWSQk8mJF3t3UZP1q1dVkQxDCGpyVRn9s63pWsybCQoV
	BEjOAaBYq31Re90O1UM0Edq3RqDOg6+eaTc8+YoLoo61GvPSans98xym5zzucerC
	7ub+g/IQcmA3kC8sCYcXs6aAimXzOnVrrcYsfbE8fjWoJAHg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnyj9nq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 07:40:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52N7eI6V005532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 07:40:18 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Mar 2025 00:40:16 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v5 0/5] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Sun, 23 Mar 2025 13:09:54 +0530
Message-ID: <20250323073959.2872641-1-quic_rdevanat@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=Ybu95xRf c=1 sm=1 tr=0 ts=67dfbae2 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NbrlMn_GpqCCBWAr1CkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sLa9AeQjMVJlSbDLJaRRp5zRvGrwddTB
X-Proofpoint-ORIG-GUID: sLa9AeQjMVJlSbDLJaRRp5zRvGrwddTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230057

Currently wiphy level configurations like RTS threshold, TX power etc.
lacks radio level get/set support and same value is applied to all
radios of wiphy. Add support to parse radio id attribute and use the
same to apply the configuration to corresponding radio of a multi radio
wiphy.

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
   https://patchwork.kernel.org/project/linux-wireless/cover/20250107182506.1838704-1-quic_ramess@quicinc.com/.

Rameshkumar Sundaram (2):
  wifi: cfg80211: set tx power per radio in a wiphy
  wifi: mac80211: set tx power per radio in a wiphy

Roopni Devanathan (3):
  wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
  wifi: cfg80211: Report per-radio RTS threshold to userspace
  wifi: mac80211: Set RTS threshold on per-radio basis

 drivers/net/wireless/ath/ar5523/ar5523.c      |   2 +-
 drivers/net/wireless/ath/ath10k/mac.c         |   4 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   3 +-
 drivers/net/wireless/ath/ath12k/mac.c         |   3 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   3 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |   2 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   4 +-
 drivers/net/wireless/marvell/mwl8k.c          |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   2 +-
 drivers/net/wireless/mediatek/mt7601u/main.c  |   2 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |   4 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c    |   2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |   4 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |   2 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |   2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |   2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |   2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   2 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |   2 +
 drivers/net/wireless/silabs/wfx/sta.c         |   2 +-
 drivers/net/wireless/silabs/wfx/sta.h         |   2 +-
 drivers/net/wireless/st/cw1200/sta.c          |   2 +-
 drivers/net/wireless/st/cw1200/sta.h          |   2 +-
 drivers/net/wireless/ti/wl1251/main.c         |   2 +-
 drivers/net/wireless/ti/wlcore/main.c         |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |   3 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   4 +-
 include/net/cfg80211.h                        |  22 ++-
 include/net/mac80211.h                        |   2 +-
 include/uapi/linux/nl80211.h                  |  13 ++
 net/mac80211/cfg.c                            |  27 +++-
 net/mac80211/driver-ops.h                     |   6 +-
 net/mac80211/trace.h                          |  24 +++-
 net/mac80211/util.c                           |   8 +-
 net/wireless/core.c                           |  18 +++
 net/wireless/nl80211.c                        | 130 ++++++++++++------
 net/wireless/rdev-ops.h                       |  12 +-
 net/wireless/trace.h                          |  16 ++-
 net/wireless/wext-compat.c                    |  12 +-
 50 files changed, 269 insertions(+), 113 deletions(-)


base-commit: 1794d7ab34d2221ac7eb921b171e75b856e10561
-- 
2.25.1


