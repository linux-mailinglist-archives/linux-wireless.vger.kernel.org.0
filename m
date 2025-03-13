Return-Path: <linux-wireless+bounces-20290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F07A5E999
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 03:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705001896CA5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 02:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FFD1C683;
	Thu, 13 Mar 2025 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ya38o2KV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6F23B0
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741831364; cv=none; b=M0OgzIziRod4qX8dB7buC5l5FdHUTXRFAx3KCHPJro4Itv3VWmzDmjfsIujxx34xTyNX3AP6+G0sc1CayT36xDVm0AfM4VQmLQ6jJ4Sc/Iwoc5HXxHL9akc2vF2K43OKOXuQU1uyCcx1fHySqv3DFcdKfluOUz+5KFPYTgFSjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741831364; c=relaxed/simple;
	bh=svpPUFa26vLt85I7XamM2g/NhmTyM7X6afCtXUKtlOM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N2/1WkhD16nr/Pf1gT6zmcq/NsrUa4T2waMKVLeQQuFPzm6Kzx6C5mexMpXeZMmCJIkib6o/xTo60q8uIvtrBCgG0aAruZxyS6W0MG40dQGXOWp4o43dZx7yVI6srXuNvZi50j1LLNJhKwsb0MkSgsSvWyAw/VC6sKuiu2nvODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ya38o2KV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D01X7S003496;
	Thu, 13 Mar 2025 02:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=qpybLXRUUNGEWFeJe0UsDyjELtWs14TQ69WIouWlNqA=; b=Ya
	38o2KVzZDlRgirc0iMQMR1I6epH+62qFZFEPv/Tb11HicTOay2N61ina+n7+caDS
	Qjb4Zv6gQ+ksZT9P9G+L8DnD+Zr4Ofb8HAih0mSdRqXXy3cCU1E22oC4Y61JQ59P
	hAgbIcKfun+1gD39zBpvZ9tfY8m91m8NLr4eLakeqymj87mXAXbu9xwajbdcRE5w
	ouOea8TpIcigxmDugtkwWoR3XVPOzgAfkTk/RndePrwXpNl0DSFUG9+YYCgKUykf
	yXzOIEDAjU+765OfGj4ab68kPPBwqbJLtHckmi83lAWkUGjEcZseYKHCJpW13M/H
	OnxhkVttJ6/7dIUxcBnA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45b96ya2pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 02:02:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D22aqP013838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 02:02:36 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 19:02:35 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH wireless-next v2 0/2] wifi: cfg80211/mac80211/ath12k: Enable monitor creation in NO_VIRTUAL_MONITOR mode when AP is active
Date: Thu, 13 Mar 2025 07:31:52 +0530
Message-ID: <20250313020154.4066212-1-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OsMmrLQRRN3fdkSFuOo4lfQYWXmbGaeS
X-Authority-Analysis: v=2.4 cv=I+llRMgg c=1 sm=1 tr=0 ts=67d23cbd cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=mL3VQhBnOq_V3W7imJcA:9
X-Proofpoint-GUID: OsMmrLQRRN3fdkSFuOo4lfQYWXmbGaeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=732
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130015

Currently, in NO_VIRTUAL_MONITOR mode, when creating an
AP/STA + monitor, there is a restriction: if the AP/STA is running,
setting the channel for the monitor is not allowed. For example,
in a scenario with three supported radios where the AP uses only the
2 GHz and 5 GHz bands, the 6 GHz band remains available. However,
due to the restriction that rdev->num_running_ifaces must equal
rdev->num_running_monitor_ifaces in cfg80211_has_monitors_only(),
we are unable to create the monitor interface.

cfg80211_set_monitor_channel -> cfg80211_has_monitors_only()

static inline bool cfg80211_has_monitors_only() {
...
   return rdev->num_running_ifaces == rdev->num_running_monitor_ifaces
        && rdev->num_running_ifaces > 0;
}

To address this issue, bypass the cfg80211_has_monitors_only() call
for NO_VIRTUAL_MONITOR to allow monitor creation. In the mac80211
layer, no additional changes are required. It follows the same
sequence as standalone monitor creation in NO_VIRTUAL_MONITOR mode.

Refer link to Felix's NO_VIRTUAL_MONITOR mode patch series.
https://lore.kernel.org/linux-wireless/cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name/

Tested various scenarios with the cfg80211_has_monitors_only() bypass
modification

	standalone monitor creation case
	********************************
	1. Create multiple standalone monitor interfaces with
	different radios
	- Allowed one channel per radio but multiple interfaces
		can be created with the same channel/radio.
	
	AP+Monitor case
	***************
	1. Create monitor interface with same channel used by AP
		- allowed
	2. Create a monitor interface on a different channel (ch-6)
	on the same radio that the AP uses (ch-1) - not allowed
	3. If the system supports three radios (2 GHz, 5 GHz, and 6 GHz)
	and the AP uses 5 GHz and 6 GHz - allowed to create a monitor on
	the 2 GHz radio


Please share your thoughts on the following query

In the virtual monitor mode design, only a single monitor interface
per radio was supported and subsquent monitor creation shares the same
vif. However, in NO_VIRTUAL_MONITOR mode(multi-wiphy scenario), there
is no limitation on the number of interfaces that can be created (due
to separate SDATA for each interface) and notified to the driver.
For example, the ath driver can handle up to 16 interfaces per radio.
Should we impose any limitations in cfg80211/mac80211 ?

V2:
- Rebased patches
- Flag renamed to WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF
- Patch(2/2) renamed 
- updated all the patch comments
 
Nithyanantham Paramasivam (2):
  wifi: cfg80211: Allow monitor creation in NO_VIRTUAL_MONITOR mode with
    active AP
  wifi: mac80211: Set the WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF
    flag

 include/net/cfg80211.h | 55 ++++++++++++++++++++++--------------------
 net/mac80211/main.c    |  4 +++
 net/wireless/chan.c    |  4 ++-
 3 files changed, 36 insertions(+), 27 deletions(-)


base-commit: 42aa76e608ca845c98e79f9e23af0bdb07b2eb1d
-- 
2.17.1


