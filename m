Return-Path: <linux-wireless+bounces-23266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9904AC0409
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 07:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7521B63124
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 05:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724A18E20;
	Thu, 22 May 2025 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mxVToYJc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45464D
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747892043; cv=none; b=ZGtYRFln6YZYmnMoq6fKognMe7t4YrG/MFC2Ps73/7NhRJ5mzCHJoj9FW2vBzeqGG20Pd6X37+TWjqlxSe3hg/B7Er2XXlrFyxakek3kEZp9fapzhObWaGtNabD4BXDhMNgIlSr/kRFJkWacHG5vQbGyHvMA+Vt2w2J0i0CznZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747892043; c=relaxed/simple;
	bh=JDBAcAqlWoJ4M5HzQSH6EHwaICqmP1Sbmog85SecYls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HMiFy9PDYZJTap6sv/ptlwhXygKyze7E5xj1MnknT+4uUsvBz7Xt0nx8UxVTFiVsj8vgokRRRmselvJ+0LDVTg88L0rkx6/EyPfrPQ/BmKc+ndxRq1HTCYJ1yNzHwGWpwT4C39sWvTsUfxbWEbNPK09csnS294cAJZ14rtsM2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mxVToYJc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHVTK6016898;
	Thu, 22 May 2025 05:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HAiYU7E9VR4OuOKa6MS9a3
	ixo3sZ8J0ova5w3rNHW3M=; b=mxVToYJcfYX4QKxglg2uz0IRySz8GaqXgbcClf
	QrltrWHnNeTgA2iGdTKr+5pU4GN1WY3PMbXa5cN+XggVMYuUJv6EuHA4EAWvzkr/
	317aJPYUXWwGwRCHU6SzTLOOUglt9smdrh2RA8UJKH15hC5oY8N2GHeZKlqEP5kh
	VLkVyEKlTjgdoQrIGl7AzEku4tEAv0LyXNM41oTQwOpbxSE3EOvXVoiN4IbF1JUO
	UAkvVMf0QacI6p4Unn5LF1jNnOXtN9VFdIFWfsvsk4Tbj5F5K33zHPk3mIw3H0nY
	UdSM/IB45XdZDTQwRvf6ZzKgkgjtTnzXNfr5wBc0v9nbMCig==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9w4r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 05:33:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M5XuKw022880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 05:33:56 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 21 May 2025 22:33:45 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH wireless-next v11 0/3] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Thu, 22 May 2025 11:03:23 +0530
Message-ID: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682eb745 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=OmEEMuOC34kc_pH8e8sA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: olk7Uw-HS3HhxJOoNFhSs7sO0bzw2uN_
X-Proofpoint-GUID: olk7Uw-HS3HhxJOoNFhSs7sO0bzw2uN_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA1MyBTYWx0ZWRfX+9H9TxMVw8ib
 /6vXntivMnf62Rt6zUnZP1t8cQcjnExaHduxqnEWg2dzzTopYw7YdAe+H/YQSN2NLDpxgJAqDG7
 0r5Z20JXSjflx55/5/3Try33uLPKsV5nfthwl72ylXdjzqk5rFg8Lp3l+s+sdXRIDYicx+sx+wS
 IxJfclhS04eFWhs4kffo1p7YvB6//R1KpfSrCNo60wqPgZHsXdO20Os+mB/6uAJFBG5P7ViWtA5
 s8mKmpKK5SrolrW4A245x9AMnbttWCWelOoEpT+m6Pr+ZmTudyTiRDCYjRioOl7GJ5qQDdMOaMj
 CZ493eQDQTj17BvwhRahJ2U0LGIAJEHFIZqYm53+9w6qFJGpw8fErAcDwLds7XdoFde7KCoFbfr
 zIic6q66QTQxZb1T5SUpUVveVCF7w2ckOqDU/jJjlD2mI5Dh2NjZ8C6ISjitWqKk7PGOxSPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220053

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

Roopni Devanathan (3):
  wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
  wifi: cfg80211: Report per-radio RTS threshold to userspace
  wifi: mac80211: Set RTS threshold on per-radio basis

 drivers/net/wireless/ath/ar5523/ar5523.c      |  3 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  5 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  4 +-
 drivers/net/wireless/ath/ath12k/mac.c         |  4 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  3 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |  3 +-
 drivers/net/wireless/ath/wcn36xx/main.c       |  3 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  4 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  3 +-
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
 51 files changed, 254 insertions(+), 64 deletions(-)


base-commit: 0b0ff976af94fc2437b62e3798f11aacc3798613
-- 
2.25.1


