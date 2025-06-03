Return-Path: <linux-wireless+bounces-23570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB6ACCC26
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 19:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054573A23FB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7043A179A3;
	Tue,  3 Jun 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N2ieY6Pi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0529D0D
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971793; cv=none; b=JYaRAYnjTcTC2GSXOP8miUrYYa8C9s8TTInFmJxBWkFPoG/maLDxZkA/9nfRmnE3FBxDo/fO1SvRndGB3MpIFSKqmbJIsaTqKe70ITLnsFSY8ZHSIJdPnWytBhD9zHKN42ru6KSu6cUH+9T4E9rOPwOTWxZ6sJta2PqQHZZhdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971793; c=relaxed/simple;
	bh=fmsDxQRA0CUOMWweozC6HfIEikUiEhDAm8Wv7W1mBZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GuhggvNj03DMSWKMqU5YyfblWeKumqfFk9wLyR+XDPG9b3qarp3Wgof4qG93fZb2nMsOL4A2d5LDa+r6eN2DLM0JfVhUHneiOvV0w6kXntwUusX2txtiKydQESGxvqiYE1ZJsG7XJXGldXdpRDzkRqn/aXooa1W98s9JKaxQUa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N2ieY6Pi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539JGDw006332;
	Tue, 3 Jun 2025 17:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=i0Ef69iY5+QiUKPbRreuB3
	6/XsfGgxdGyqX1bTDgHy8=; b=N2ieY6PiGRc4jAk3jnUwe/Yr/sc96VgxgKiBuU
	5S2MKrRcgiv9wN1mm7cl11HBZWSL6i7jWIKEaZ44ge28xFV7dmylaJ1KJzLrIgav
	MaNWfizhxPh0FOqiDddTMDV3n4DUOuo3WBmsQmdBGzu53s7t/0duzIOT03uTe7Rr
	T5n5gd3KJdZytk+XnRdmPk+N3U9rzh5eYl8JBrvS+0UmiN9jKEIeEnyTBIRzanSy
	+0a9rP6US7mjRq4lHzqDsBBClJ/lScKdSJCMkBgnuUh75SeH9PP26D0JP6AiEetu
	HDiYHlRyNKEz35DNUOao1Zj5v/gBx4tEMa15YYF6TWTlXyFg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8sucd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 17:29:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 553HTjEx031232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Jun 2025 17:29:45 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Jun 2025 10:29:44 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v12 0/4] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Tue, 3 Jun 2025 22:59:20 +0530
Message-ID: <20250603172924.336883-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2t48ZYWTtL4FX0k-k-Cx4hMdAzukA3NE
X-Authority-Analysis: v=2.4 cv=EPcG00ZC c=1 sm=1 tr=0 ts=683f310a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=2c0AOgb8h_DJ-AJeJB0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 2t48ZYWTtL4FX0k-k-Cx4hMdAzukA3NE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE1MiBTYWx0ZWRfX4uLA/a4zlpt3
 +4myR4TcOH8ZuAo0UKqBg3KlWCJcAUa435fEbp4q8nWKXcb2LCL5/viUzZZF5QPJjkHyJg8Rlsr
 pW1HiVhWBH4ajevqGuwurSQZa2hWzJggOgqaT+/F08SQ3uGcXni/1x6541XZ/PO3bH9MzElxhrp
 cNF8/wgGnYdyJGq6gvseciAEWb6jUdmL0Q3wQ0NWagroQCP0uim/q6p2zY2xZ7ol99PD5MRzBi2
 o/fqDotHvY8QwcpwvKsnYwY4sAKECNcRlp1BIpeb2xh2l4ttKp7+fb7TtZbJLFvw/N3ys/QPS/v
 BRKr778g2ulPeU+n3XY4+1uF9xs0r59DzsForqwNMqf4H/wBphjD4pfApKDXi7NBKI2fusSfG9/
 hk4WSjVbG+3MTD55xUt2NPvqDzjTQGRB5X+BhAhDp8TxK9czkG5ABk0EBVGAj0zBRY06TSWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030152

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
 drivers/net/wireless/ath/ath10k/hw.c          |  1 +
 drivers/net/wireless/ath/ath10k/hw.h          |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c         | 14 ++-
 drivers/net/wireless/ath/ath11k/mac.c         | 11 ++-
 drivers/net/wireless/ath/ath12k/mac.c         | 11 ++-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c |  9 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  7 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c | 10 +-
 drivers/net/wireless/ath/ath9k/main.c         |  6 +-
 drivers/net/wireless/ath/carl9170/main.c      |  2 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |  5 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 drivers/net/wireless/atmel/at76c50x-usb.c     |  2 +-
 drivers/net/wireless/broadcom/b43/main.c      |  2 +-
 .../net/wireless/broadcom/b43legacy/main.c    |  2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  8 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c |  3 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +-
 drivers/net/wireless/intersil/p54/main.c      |  3 +-
 .../net/wireless/marvell/libertas_tf/main.c   |  2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  8 +-
 drivers/net/wireless/marvell/mwl8k.c          |  5 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  8 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 11 ++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  8 +-
 drivers/net/wireless/mediatek/mt7601u/main.c  |  5 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  7 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c    |  5 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  8 +-
 .../wireless/realtek/rtl818x/rtl8180/dev.c    |  2 +-
 .../wireless/realtek/rtl818x/rtl8187/dev.c    |  2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |  8 +-
 drivers/net/wireless/realtek/rtlwifi/core.c   |  2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  6 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  8 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |  7 +-
 drivers/net/wireless/ti/wl1251/main.c         |  5 +-
 drivers/net/wireless/ti/wlcore/main.c         |  8 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  6 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c  |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  6 +-
 include/net/cfg80211.h                        | 27 +++++-
 include/net/mac80211.h                        | 14 ++-
 include/uapi/linux/nl80211.h                  | 12 +++
 net/mac80211/cfg.c                            | 35 +++++--
 net/mac80211/chan.c                           |  2 +-
 net/mac80211/driver-ops.h                     | 34 ++++---
 net/mac80211/ieee80211_i.h                    |  5 +-
 net/mac80211/iface.c                          |  6 +-
 net/mac80211/main.c                           |  9 +-
 net/mac80211/mlme.c                           | 12 +--
 net/mac80211/offchannel.c                     |  2 +-
 net/mac80211/pm.c                             |  2 +-
 net/mac80211/trace.h                          | 78 ++++++++++++----
 net/mac80211/tx.c                             |  4 +-
 net/mac80211/util.c                           | 21 +++--
 net/wireless/core.c                           | 19 ++++
 net/wireless/nl80211.c                        | 92 +++++++++++++++++--
 net/wireless/rdev-ops.h                       | 37 ++++----
 net/wireless/trace.h                          | 82 +++++++++++++----
 net/wireless/wext-compat.c                    | 10 +-
 69 files changed, 548 insertions(+), 223 deletions(-)


base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
-- 
2.25.1


