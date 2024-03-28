Return-Path: <linux-wireless+bounces-5430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5F788F8AF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E061C295B5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D622C6B8;
	Thu, 28 Mar 2024 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aOLx+VvO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7CF2561F
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610992; cv=none; b=JooKGgh0LcRpzi4ew9lqwQAGl46raaMYnhF6o1zg9+R3Jhx7d8NpXbbGCVdXzL0kkmztm19JhXLsE/X+i4ACoIKwVZ9AAV+sZrHzPXZE5HE+m4tJzIGaIHkvK45SFMtwt42r4vr7tKJD1F2wzdi/D4Mz9XvJFX6FsCD+j10Uks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610992; c=relaxed/simple;
	bh=tF5dKHTeElpSxSLYWJDF9+iN7PE5oN5vazMHvD7wfJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kc2uPnKPcomkEY9276/D5aMuVuzncJhBj0gvaTv0m9rlJYy/f2IrZAt0mhEaEfEa2+c/CC9xm7GEE0deJ9iyhPlLtRiJnTgmvbltYLLjIeitBm8TQ5MqYxDcRHHqi/HJ/nkew69Z41/iWJfMUYPM3Pk00P7FhwcwpryM6bsv86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aOLx+VvO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S6qiJc027519;
	Thu, 28 Mar 2024 07:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=jMc2+5p
	oLNzreiQAFk+cGSB4CBkoY0ZEbfzRKenmm2g=; b=aOLx+VvOVhkLERlhztBbyrN
	OeD+Rn53JCJp8tGmX5rbiFiGjcrtMTBoO/OqeWh+XPNYIWjXaFh+Yw6OComRG0An
	Pw5t7WubHkm3K0iXJqArnTyN42IryMsDZOmCG8DGghLA9Ho832Ng04WyA1uHKJbF
	CidsTsOg7gh2AnAnaowQ6ZgeFMcDj8Ogxom/6TOBj67AIko8VhCdciLvI14Qt8ZP
	kDfTfZXfus3eXns6w2jRcoo4C/SpkHtwNvYCuat+2RJKOaMCSIoaJqWZGVmTMYxY
	UKrm3p9mDHytK0ajd20JNLHw2TR36hAj8tcWRW78+KZrTk89NArBv+YL1FUKv4A=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x53nxg4vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7ThIE032340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:29:43 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:29:41 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 00/13] wifi: Add multi physical hardware iface combination support
Date: Thu, 28 Mar 2024 12:59:03 +0530
Message-ID: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: RtRZRNyD0slKJC1On8ugK3Mkd9d2KYkC
X-Proofpoint-ORIG-GUID: RtRZRNyD0slKJC1On8ugK3Mkd9d2KYkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=648 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280048

The prerequisite for MLO support in cfg80211/mac80211 is that all the links
participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
expectation, some drivers may need to group multiple discrete hardware each
acting as a link in MLO under single wiphy. So it required to have some
sort of mapping while describing interface combination capabilities for
each of the underlying physical hardware. This patch set tries to add an
infrastructure to advertise underlying hw specific capabilities like
channel and interface combinations.

Some of the todos

 - More than one concurrent monitor mode support each operating on
   different channels under one ieee80211_hw
 - Mechanism for each underlying radio specific configurations like
   txpower, channel, etc.

RFC series Link: https://lore.kernel.org/linux-wireless/20220920100518.19705-1-quic_vthiagar@quicinc.com/

Harshitha Prem (1):
  wifi: ath12k: Advertise multi hardware iface combination

Karthikeyan Periyasamy (1):
  wifi: ath12k: Introduce iface combination cleanup helper

Vasanthakumar Thiagarajan (11):
  wifi: cfg80211: Add provision to advertise multiple radio in one wiphy
  wifi: nl80211: send underlying multi-hardware channel capabilities to
    user space
  wifi: cfg80211: Refactor the interface combination limit check
  wifi: cfg80211/mac80211: extend iface comb advertisement for
    multi-hardware dev
  wifi: nl80211: Refactor the interface combination limit check
  wifi: nl80211: send iface combination to user space in multi-hardware
    wiphy
  wifi: cfg80211/mac80211: Refactor iface comb iterate callback for
    multi-hardware dev
  wifi: cfg80211: Refactor the iface combination iteration helper
    function
  wifi: cfg80211: Add multi-hardware iface combination support
  wifi: mac80211: expose channel context helper function
  wifi: mac80211: Add multi-hardware support in the iface comb helper

 drivers/net/wireless/ath/ath12k/mac.c | 147 +++++++++++-
 include/net/cfg80211.h                | 175 +++++++++++++-
 include/uapi/linux/nl80211.h          |  78 ++++++-
 net/mac80211/chan.c                   |  35 ++-
 net/mac80211/ieee80211_i.h            |   5 +-
 net/mac80211/main.c                   |  46 ++++
 net/mac80211/util.c                   | 196 ++++++++++++++--
 net/wireless/core.c                   | 294 +++++++++++++++++++----
 net/wireless/nl80211.c                | 154 ++++++++++--
 net/wireless/util.c                   | 321 ++++++++++++++++++++++----
 10 files changed, 1318 insertions(+), 133 deletions(-)


base-commit: d69aef8084cc72df7b0f2583096d9b037c647ec8
-- 
2.34.1


