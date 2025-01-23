Return-Path: <linux-wireless+bounces-17847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E0A19C1B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 02:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1F63A259A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 01:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A11117543;
	Thu, 23 Jan 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YpTdgBbA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A4AD27
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737594686; cv=none; b=Df/tNCIAuiwQFYPCP63HV8Yu+5iJzXLRF1JbqPjaFgZCzOeJ10lH2O+xrkgcAhl0SoQzTqLIa4Oa4INwoPzATIrA+YPH/u4A8feD6A03fjWLmxWXzjkOAF9CLhhRYu11mgi6clM1BYYbRrfe2F8vpkhd3XKKmUt7rL5vnzVfK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737594686; c=relaxed/simple;
	bh=6feFgiaX+3SQYB1ME6bZCYcpc3XLacmw8DjbZI65img=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CzXPDlFbetyTyQXxxBvt3CRSQwlLY9pZeUSvN2lOseXlEjKVqcRc8D05BSmBxHhomdEqCs3GOpdL676jAIvd+JxGLlxlvI521nH+RMwzwcaZNVQb07QeIM6QKoMZnCFUif+urR3K4teDjlV0SJk8PCDZcbJHOBUn0I3zcZ88YMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YpTdgBbA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MKEisQ004250;
	Thu, 23 Jan 2025 01:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=HEX8UQwObdRr3oq0wMkpNTtwL/yb8sC0JTVkFGFBESg=; b=Yp
	TdgBbAKiZPxpRR1ftyZvmDuyC7Qc+e/FmH18LT5pPRPM7F28N6zd328+sEBTxpwU
	pUo+AgG2Q/Py/QKp+MTh6e4jM/lwxebjYfwNU2HLs+jgJwyrwxwpvX+vgtJAHy0A
	nt5cLO7hRiQXhtmKY36XtUBiuKjQKYLu6M9tcWUBOLzEskqRk5/UkQT1dk1LttDO
	BKj735bHjgXy72HuemIHnVpModq7VchXfmFSDPFuLnHcZWMqrltOvJdLPlhfdbmK
	OTajyj1DaNWRjywOy6Mod4PsQMW+2P0QUxI8K2JWcO17gARVmwmQ7Kx2ebyv6ObZ
	7niZzaQXX3noBTTxcMOQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44b7ht0ey4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 01:11:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50N1B6tk018068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 01:11:06 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 Jan 2025 17:11:04 -0800
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH 0/2] wifi: cfg80211/mac80211/ath12k: Enable monitor creation in NO_VIRTUAL_MONITOR mode when AP is active
Date: Thu, 23 Jan 2025 06:39:48 +0530
Message-ID: <20250123010950.1958211-1-quic_nithp@quicinc.com>
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
X-Proofpoint-ORIG-GUID: OFWiBcthiA3FvuBOxn_C1AEMVp5ghoZn
X-Proofpoint-GUID: OFWiBcthiA3FvuBOxn_C1AEMVp5ghoZn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_11,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=475
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230007

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

To address this issue, bypass the cfg80211_has_monitors_only()
call for NO_VIRTUAL_MONITOR to allow monitor creation. Subsequently,
cfg80211_set_monitor_channel() will manage all interface combinations
and allowed radio conditions, eliminating the need for special
handling.

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

Nithyanantham Paramasivam (2):
  wifi: cfg80211: Allow monitor creation in NO_VIRTUAL_MONITOR mode with
    active AP
  wifi: mac80211: Set the WIPHY_FLAG_SUPPORTS_NO_VIRTUAL_MONITOR flag
    for cfg80211

 include/net/cfg80211.h | 3 +++
 net/mac80211/main.c    | 4 ++++
 net/wireless/chan.c    | 3 ++-
 3 files changed, 9 insertions(+), 1 deletion(-)


base-commit: c4e4e37afc8b8d178b0f00f607c30b3b81253597
-- 
2.17.1


