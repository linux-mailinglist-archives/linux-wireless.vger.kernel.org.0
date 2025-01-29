Return-Path: <linux-wireless+bounces-18150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78510A220EA
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 16:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BCE162FE8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC618F2EA;
	Wed, 29 Jan 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hUN41M0g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB158224EA
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165992; cv=none; b=mZmaGJA6yEOQutqDFd5KA43hGDI/eRAImKYrOng77Mn+9AGzzZjliQwF5R+UMP1iPcZvZfCUHG4iK0PTUFG4pEiXveWVE9c4+shq+Z7GA7zAWr3cNk2fhSpdEInolnBeX31Rg1Y0r12WqYvhaku2Gn2KmpertcyEoag8WG92rd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165992; c=relaxed/simple;
	bh=hhJ0WQwMO61jx/B8fsfuyCZMDZOkVgqbe/RG8vG+2+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JD6QId+SwCwfBzGpMJ4pvqMPpnlsYnOmyae5zk/CYNw4vL0J89xTEC+7LO1iDNQvSLLQVEawjnqVMn4VjggqFMLL3vzZUGUQpfGSmp2tw/urUoL+SaaK1oF063KRiPCkjQ1x3iD8G92zvHN+fKJBnkwfVJI4zD2BeCioslH5Pfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hUN41M0g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T6RV6O008605;
	Wed, 29 Jan 2025 15:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jHSbZFqSJjMifpl2inlU7S
	ZBB1IYt6DnvfMpLfDzLNQ=; b=hUN41M0gt4/gwBI+ZYDH0xvjTp9vQN0nOFMDZ4
	nVVex67fBG9AXbjjdAebHXW7y2utZn+tlQ+rScjmdBac0Yic0Z20Hp6C0PCKtr/a
	XGw3+oVYC8jMRKLfQb7cm3X7GgCvU+oERR02Lse9oH+/gbYtNKlQxnSXLj2O6NXS
	6DeNNwNxLWone24freXBBRjHmpE3fw8CQxiet6JoK4HJpvQyKdvg0jDmJm+UF3lf
	bsxYdBH+BJiv1ASmZWDvNTNY26J2aLG2ENvcOkO1WJIZC+ypoxsrjG5syA4lEQ38
	Xc8sf8lfD7pYVWw8/7on3PSb5w422PSjD1PqFoNk8sf9kkEA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ff33s0u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TFr4l0026262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:04 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 07:53:03 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v4 0/5] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Wed, 29 Jan 2025 21:22:41 +0530
Message-ID: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0zNc9xEReRQ00Z_hmQQhUCKHX9SdkxRM
X-Proofpoint-GUID: 0zNc9xEReRQ00Z_hmQQhUCKHX9SdkxRM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290128

Currently wiphy level configurations like RTS threshold, TX power etc.
lacks radio level get/set support and same value is applied to all
radios
of wiphy. Add support to parse radio id attribute and use the same to
apply the configuration to corresponding radio of a multi radio wiphy.

This design will not disturb the global wiphy configuration. If radio id
is
not passed from userspace, then the existing design of setting attribute
to
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
 drivers/net/wireless/ath/ath11k/mac.c         |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c         |   3 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   3 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |   2 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +-
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
 include/net/cfg80211.h                        |  22 +++-
 include/net/mac80211.h                        |   2 +-
 include/uapi/linux/nl80211.h                  |  10 ++
 net/mac80211/cfg.c                            |  25 +++-
 net/mac80211/driver-ops.h                     |   6 +-
 net/mac80211/trace.h                          |  24 +++-
 net/mac80211/tx.c                             |  11 +-
 net/mac80211/util.c                           |   8 +-
 net/wireless/core.c                           |  18 +++
 net/wireless/debugfs.c                        |  35 +++++-
 net/wireless/nl80211.c                        | 117 ++++++++++++------
 net/wireless/rdev-ops.h                       |  12 +-
 net/wireless/trace.h                          |  16 ++-
 net/wireless/wext-compat.c                    |  11 +-
 52 files changed, 294 insertions(+), 119 deletions(-)


base-commit: 22f3551b60be7d126db9233998d262edfc577d0b
-- 
2.17.1


