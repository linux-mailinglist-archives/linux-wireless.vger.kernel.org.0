Return-Path: <linux-wireless+bounces-22000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48500A9AFA4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 15:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D4F9A6266
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FDE18785D;
	Thu, 24 Apr 2025 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZAez4mwu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BBC187876
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502504; cv=none; b=G1a+ygV4DJVRqTRchag2mZYFqOkgFpSOMnRKSmXuqMLsRAALERi0y0Kh9SCdCkMa+YgbRXOaURjUzJkOWXorfYxtsvaNYA8LQwb8cDhD9RzqT/4w3nC2mfVseR9+MeFVAaihIg8FD8PkdoBHJpXZ4r/PVOy1Sg8zVHezn6uqb5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502504; c=relaxed/simple;
	bh=zXJQq8Af4+R/QJSqMTAXIq0eCR6VYti7qMncKSs/WCU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hyrCLZUaLIfqBu7jpK/yUOMMjsBwVDFTgDmLfjDwKAsDe5WIFdgrunXb6OreTbWtZPGbt7mFD0fU8h7DKwNuiKzP23w/Lb0sMwlBhMZhqw44IbZ6jsuV0QJ/LHckFJEVp6KiFbMqi/C5C6WInKltDwfQZGFDWhDbk09m0EQGP+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZAez4mwu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OC3Ntu007190;
	Thu, 24 Apr 2025 13:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TDRHHIVAQ3TkNrqblbgH/4
	Vbw9gwnSNUDpTSJwdHb/U=; b=ZAez4mwu0WJ8jUqCzZBG/Msm6POM2zJNIjbpNX
	ULzBiCUEEVuPgrTTyAOd5FpHQU9I6r296UwFVjqmXYMPWd1eV5HV0/YhH071l7aD
	jJR+hmMORBn03I1K6IdtzmoaT0QpsaTQ/VRx7TFvCol4yeNyyUYvGhk2CfaXyGEO
	VASW1TuoefaYYS9Ewc4xpXPa0eBwmPqQApUBN66Kpi7HnuCucHU3z2zO+eIcDqGE
	FadNJdkAltMUrJv8xFN+Re4NGtMzJB2wth2oPPgOdbInN1C64Tf6p7xIdgygQI9Y
	CUxMXxlJRUAVcvoxXIHgnEQinJLPgWjpeObtXCyVDNSNcbqA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh5ds4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:48:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53ODmHa7000308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:48:17 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 24 Apr 2025 06:48:16 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v7 0/3] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Thu, 24 Apr 2025 19:17:49 +0530
Message-ID: <20250424134752.871886-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfX0z82iwxzhZNr sIJnBWX/hJWLfN2tAGTna7vAqsDLCMJEFdBkkNCLQ3bc6U7m7JMkAL5ygFN/nhtNS2eXNzYO8V7 bXJ3N2tlY3d/0o+YRGHksq1lQE5S3OvYGeWU+0i1SWO9ZQue8wmvVmCTFNwKzOpw8/I01hBjyKo
 e2nFQKSlIhwSvfj1arCOH33ZbXja98VRkweXgX8Hi7EG1mYe70s28qjuODC8OFHjGQqX2QCrdOs jK+GtV4ooTzakbwZ4+iE9XsORYQ6TTCyV00h9w1CeqnVRC+eLxezUiC7ww9Kh+oxzFEaDThtlU8 eFbAZliKlI0LqsH6vqpMTbB9ciq5x96LtbQzK9ptcRU1URUSxn3PG/gm5XRfyCDdOx9b82IduGx
 LfwX3KCjDAujOVwr53cNg3Ye//fBjgLFGSVdQ9CZtaJ7do6QSmceM+yNsj9qBlnP4i+beIQA
X-Proofpoint-GUID: _qIqeN1TdCzgs6b_4XURaDOm0EfFkL16
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=680a4122 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NbrlMn_GpqCCBWAr1CkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _qIqeN1TdCzgs6b_4XURaDOm0EfFkL16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

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


