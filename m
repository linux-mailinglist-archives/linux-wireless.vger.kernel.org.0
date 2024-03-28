Return-Path: <linux-wireless+bounces-5427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DE588F77A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 06:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E351C259E5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 05:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D028DA4;
	Thu, 28 Mar 2024 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M1NULnU1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92850291E
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605179; cv=none; b=UIDi6zMIcRApwlbK5qKZ1kLPlEpP7JUl0PYn9a3UmOLvmZwpq3e6p+i3xq4RZLLPbaFzGivrsDqJVqhJdLG+tr4ATuYJ46RF1n6uVdGoADr2tXWsZiDYu8BEwwHvuldu5NbIRf5njD1QrNWCqIq5cl4CIe029CFu8gMGRaQobmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605179; c=relaxed/simple;
	bh=wLI4DoM1eqDCNB/4UHu+2qLmMUj+emHwecl9h2uU4Ck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WGg8PA0qME96uRhweqPbyf5AM0M2WWo/SeElRgAB+/5GBdz7Vfj+q+Detj7Hctdusl8XngIFXp0z+2ZWL7rCbFCF0rlkRnrOY255Rq24WURoBotVFdawVD5WByXbiPggPXm3wXrhTT8fWqTZ4jfiEjBy67oyYTWLo/frQNogWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M1NULnU1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S5PJpR009224;
	Thu, 28 Mar 2024 05:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=IVWn5nY
	Y6BUk2xjfTo5SFjXZHOx7gGLeFO9HHC8j9DI=; b=M1NULnU1YS6dGTROw5Z0CUE
	uxrUoKledIt+8l/Gf1xkVmSK6Q2G2XC8uVhXOwUeCJlW4DiKdrpNMuiUxGVc6L4K
	sqJK4j7yKkE0HkyvWhxfMeqd8Edm5LojF7P37hsSlUV1DhhE3JQsKEcllljqPdZ8
	iT9QYWTHq2Fn/l47051X2XgA/6mziiP8qEBY3dhgj6Egml4FOV5KVFOUXj/Rvok8
	0cpXKI/Y1nXlRrBEsHlzDOf4Ze61OVjCMlBC2/bu8n6mfRDIWqzTCjf4mwFPrh57
	n9iZlz7iETfQqRc/6JgU5j+Vf5PNgowNymCadQ3eIDYbisLoia9e6ee2QCoPMtA=
	=
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1w1yjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:52:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S5qq29001253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:52:52 GMT
Received: from hu-mdharane-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 27 Mar 2024 22:52:51 -0700
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Manish Dharanenthiran
	<quic_mdharane@quicinc.com>
Subject: [RFC 0/2] Add Multi-Link Reconfigure link removal support
Date: Thu, 28 Mar 2024 11:22:33 +0530
Message-ID: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
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
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eilt2kl5juwtDV5gyhN1cMYksm80RIDF
X-Proofpoint-ORIG-GUID: eilt2kl5juwtDV5gyhN1cMYksm80RIDF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_04,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=614 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280035

This is a preparation for supporting Multi-Link reconfigure link removal
procedure[IEEE P802.11be/D5.0 - 35.3.6.3 Removing affiliated APs] for
driver which supports offloaded Multi-Link reconfigure link removal.

Multi-Link reconfigure link removal offloaded drivers will take care
of updating the reconfiguration MLE in self and partner beacons. It
also updates the AP removal timer automatically and notifies once the
counter is expired.

This patchset also adds mac80211 routine to support sending link
removal command from userspace to offloaded driver which accepts
reconfigure Multi-Link IE and the TBTT count for the link to be removed.

Driver (ath12k) changes that utilize this will be posted in the future
versions.

Manish Dharanenthiran (2):
  wifi: cfg80211/mac80211: Introduce nl80211 commands to support MLD
    link removal offload
  wifi: mac80211: Add support for link reconfigure removal

 include/net/cfg80211.h       |  63 ++++++++++++++++++++++
 include/net/mac80211.h       |  25 +++++++++
 include/uapi/linux/nl80211.h |  30 +++++++++++
 net/mac80211/cfg.c           |  12 +++++
 net/mac80211/driver-ops.h    |  19 +++++++
 net/mac80211/ieee80211_i.h   |   4 ++
 net/mac80211/link.c          |  40 ++++++++++++++
 net/mac80211/trace.h         |  30 +++++++++++
 net/wireless/core.h          |   2 +
 net/wireless/nl80211.c       | 101 ++++++++++++++++++++++++++++++++++-
 net/wireless/rdev-ops.h      |  17 ++++++
 net/wireless/trace.h         |  56 +++++++++++++++++++
 net/wireless/util.c          |  18 +++++++
 13 files changed, 415 insertions(+), 2 deletions(-)


base-commit: d69aef8084cc72df7b0f2583096d9b037c647ec8
-- 
2.34.1


