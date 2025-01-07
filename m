Return-Path: <linux-wireless+bounces-17160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C864A0492B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 19:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2503A4CA7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 18:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033491EF09E;
	Tue,  7 Jan 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="irsURU3A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A019C54F
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274421; cv=none; b=ZFQfwJOnIhVU38wwnCjyD5JNLGUrFowe752wB527FDZ+Yq8bDwOiEjlrTSCiVbjFfoEXwpfJY9ylH3UzBT91XFmx32omFjPVFNOF78y/bxRJ7orXA3eTbD+81OXdEYiiwcWeUdBERFDbgvUOt4s8vyKnCyPNReK8KVd8bLrosG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274421; c=relaxed/simple;
	bh=PtfXZZxwlX1EGTrJKGjNR7MFBDbAobtyuIohPTqcfUo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dI+QCCpF4HM++RJZs0wr9mHqIvnd93ayRBLcQ2YdknZwYZqNUpbok5qtHIa+w+qkuLWf8sMHcBkQRvP54wiKkzDD2WR/EBlgt4mOrQtllRy1ciqZ83Px3EqzxZPsZM2bmtEUpByr++rfNvPpS6IMWLHHCOQfaTK5jILXD6w8D90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=irsURU3A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507A8gge023536;
	Tue, 7 Jan 2025 18:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=R7FacEFbitcuEYNY1F4FO2
	Tfbtt4hwL41iS1F7PhKaQ=; b=irsURU3AcaYZxR2gKS1GpoIoJoVjEEwfZs9EDd
	b4yg+13xpLfeTBOVZnJLLx+8lyosHaAUAPBpyaISOroKD5+CL2xHZ6JL8+PZFK3l
	KVf7poRRWXU+WqYEUqk5BtDLwubOVOxr1Bcs9bwGATFRouX4RNYCfcRS5Jkh26pq
	u/9HLzxoufvMO8t9kK6X/oDAsmBG+lmdeYZuTJ+n4qE2WO696/loJdq+ZEDbopUZ
	3W6bXcIuY4Dc3VSnY1ShPkiztfYRFbK5jen6a5P3OtSaTLWsIMbWXv5Nlq2q4SBu
	sDChBgN/upOlLyxtdU+NDaHG0ntgSsCPTD6odEWabeVSbU+w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44128ns8v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 18:26:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507IQtc0016659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 18:26:55 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 10:26:53 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH RFC 0/5] wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis
Date: Tue, 7 Jan 2025 23:55:01 +0530
Message-ID: <20250107182506.1838704-1-quic_ramess@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aZn6Uf-GN_ISxO4sN6gl_7-p0EMO8Tyy
X-Proofpoint-ORIG-GUID: aZn6Uf-GN_ISxO4sN6gl_7-p0EMO8Tyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070153

Currently wiphy level configurations like RTS threshold, TX power etc.
lacks radio level get/set support and same value is applied to all radios
of wiphy. Add support to parse radio id attribute and use the same to
apply the configuration to corresponding radio of a multi radio wiphy.

This design will not disturb the global wiphy configuration. If radio id is
not passed from userspace, then the existing design of setting attribute to
all the radios will hold good.
Also add support to get the radio specific attributes in a multi-radio
wiphy from userspace.

Note:
This is design proposal to extend support to set RTS threshold/tx power for
each radio and get the same from the userspace and hence sent as RFC.
If we agree on this design, all per-radio attributes supported in wiphy
can follow this design to modify attributes for a specific radio without
disturbing other radios in the wiphy.

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

An alternate design is to allow multiple radios to be configured with
different per-radio attributes in a single command. To achieve this,
a new nested attribute can be added to hold all per-radio attributes
for all the radios in multi-radio wiphy. The attributes and respective
values passed from userspace (say iw) can be parsed in NL80211 and for
each attribute, corresponding handlers can be called in iteration for
each radio. This design will require adding an attribute indicating index
of the radio along with the nested attribute to circle down the radio of
interest.

Rameshkumar Sundaram (2):
  wifi: cfg80211: set tx power per radio in a wiphy
  wifi: mac80211: set tx power per radio in a wiphy

Roopni Devanathan (3):
  wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
  wifi: cfg80211: Report per-radio RTS threshold to userspace
  wifi: mac80211: Set RTS threshold on per-radio basis

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  3 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  4 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  4 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  4 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  4 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  3 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  4 +-
 include/net/cfg80211.h                        | 23 ++++++-
 include/net/mac80211.h                        |  2 +-
 include/uapi/linux/nl80211.h                  | 14 ++++
 net/mac80211/cfg.c                            | 25 ++++++-
 net/mac80211/driver-ops.h                     |  6 +-
 net/mac80211/trace.h                          | 24 ++++++-
 net/mac80211/util.c                           |  7 +-
 net/wireless/core.c                           | 18 +++++
 net/wireless/nl80211.c                        | 67 +++++++++++++++----
 net/wireless/rdev-ops.h                       | 12 ++--
 net/wireless/trace.h                          | 16 +++--
 net/wireless/wext-compat.c                    | 11 +--
 20 files changed, 197 insertions(+), 56 deletions(-)


base-commit: b73e56f16250c6124f8975636f1844472f6fd450
-- 
2.34.1


