Return-Path: <linux-wireless+bounces-20930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10153A749C4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 13:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAE03B6904
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F37721B8F7;
	Fri, 28 Mar 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gUyVAL/N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978A21B9E2
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164760; cv=none; b=kX0fIFkNRjR2zgunshLvaLgjXPFBnVn11yg4Ba98cv9FUH7yFJ94IhlUavM7WtJT0r09nmC6HQ+ZtNoGDX/Ges0Z5jkyJG1xjrwDT3DQKLXOBa+4pCpuCWU/A9QQKPv9xBI9ARUNKj1wUXTXbNLnm5yh+OLcLF/ankI1FuWSbiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164760; c=relaxed/simple;
	bh=H12LfoypRAnNb55mYl+nnwV+TDi4fS98HKPjxnChwJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BjKWug+MUfnW6E7asmyPAOw944+AjBpMjGurC15zaAnI/AnNYwt0CYt1DY1d9Nwgan6FrZhC9bz9fJF4cDe3n9+flYXScbPlOFrdtKJ6AWLDJOiO5V7fe7ST5bNlEalnj3JtbdjeGlwUF2FMHR7tcPm1dBoe/zhmd45KBm4/rV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gUyVAL/N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S5AneA013774;
	Fri, 28 Mar 2025 12:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Fz3kgUKNHKum5XEz4pYA/0
	WLO8gfrpkq2Zr50s5znaY=; b=gUyVAL/NOEFR48TZVGYr4wjQSZ4cytXy6sl942
	GCeaS5kvPVQwun/P+QcYgCk8UUDzJxOhMT1ESqmFXeLLkQsv2v1g9hh+0gyhOCun
	8WMeCN+Mqz7uYNljXUTD052bV2FYI9aGwnfRE7IFAeanOE62P5Hc6ufyhxjqhsPK
	RBjljf2E47FLb99LPnZhyZyKRTKbcNGBums5qT0Rr/tsfLoV7e2A5mmDOo9/Gog7
	wahpsSVkES012iqd+cshA/adJ6rJYOLAngDAkVNqwVuGgkfvr0lInDAz1x+UiSd+
	Ipwlpf27ntoL/+bbJxYmrGMWTW7w9ZyiibDzDFOqi5aM6KkA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mffcqfbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 12:25:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52SCPcJk014679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 12:25:38 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Mar 2025 05:25:36 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v6 0/5] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Fri, 28 Mar 2025 17:55:14 +0530
Message-ID: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=67e6954e cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NbrlMn_GpqCCBWAr1CkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: w6lB9G13PdCc7yjhLu4Dg9XfMu4jV5xN
X-Proofpoint-ORIG-GUID: w6lB9G13PdCc7yjhLu4Dg9XfMu4jV5xN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280086

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
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   2 +-
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
 51 files changed, 270 insertions(+), 114 deletions(-)


base-commit: 1794d7ab34d2221ac7eb921b171e75b856e10561
-- 
2.17.1


