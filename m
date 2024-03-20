Return-Path: <linux-wireless+bounces-5011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4A8817A8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5B51F231DD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BE685284;
	Wed, 20 Mar 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QMYkJK40"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A284A43
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961841; cv=none; b=aW8IwENBqSf3rMZrPWlvR/PklFgKq7tIjoHm0fa5i8uajtxSsMdHpLdwh8w7m1IpoC6XOnJtEQy4/WDCsZDRamIwiMgomq8Qla/OejlNzjTu1Q1Wgk/0TRDenC859avbOHv+8apf6Pw4X1u+ypAgM++lGrsjftWtmK5MvUne+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961841; c=relaxed/simple;
	bh=cvAe1IbbfpMdNg15L7yuDuh5W4yHtNURa4PFAW93ZjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L4Gl3BTXVRp64ibeo/yXZju2uoeJwF1bMT7IlykV+P+tCa09Hbq10tc4uaJ1Smgm/lWbI+l/xTfqj/1jvJKXq4HRfzYUwAdHJZnvgLkX1m6a44PNwzV8x8WwQcH3fDxG7DBb22XcPhZFl3BXnL51Grnt/pZBQrGNXMz98aPIxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QMYkJK40; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KI0QBV001324;
	Wed, 20 Mar 2024 19:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=rnJwfDg
	c5Fxy6A1s47uO2AdPMaQlLbvtxjYhJPf5uhI=; b=QMYkJK40pfHxXxmAOYQRpXN
	0RUcyqcnVWc6+8dpFg0gTu6heKCVQ9I5SyqbGV0IHIdIQQ2KH1iRnsromao0dNBN
	sXhxr//J5j9cFCb0smwD9e2h0grB8TBpp7AFVK3D5thenyvYpv6mp1vep+TcyedE
	rrz/4zYwOpFBvDjpNMYZ4SSLK9nIHG2bDvrQ8vw8nyZkxfcKviHAUEU2mkplJq4/
	Xxw+N0Io3fJOu3RDipTmj6XqB6Pf2ByUaeixszGETrGpeojGijgX3RVAoOh3UngV
	l7WmxM3xk9lq+/7ZcdqgRqyDOK0n4HF7CsZsWo7O16Yz3ie9HA2uoB56OooIBZg=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wypxq23pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 19:09:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KJ9vgW006667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 19:09:57 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 12:09:56 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v5 00/12] wifi: ath12k: Add single wiphy support
Date: Thu, 21 Mar 2024 00:39:31 +0530
Message-ID: <20240320190943.3850106-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: r9SnIIRNFCNQ0rlVwnE9GMtmuEH5OIud
X-Proofpoint-GUID: r9SnIIRNFCNQ0rlVwnE9GMtmuEH5OIud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200154

From: Sriram R <quic_srirrama@quicinc.com>

With the introduction of Multi Link Operation (MLO) support in
IEEE802.11be, each EHT AP/non AP interface is capable of
operating with multiple radio links.

cfg80211/mac80211 expects drivers to abstract the communication
between such Multi Link HW and mac80211/cfg80211 since it depends
on different driver/HW implementation. Hence the single wiphy
abstraction with changes in datastructures were introduced in
"wifi: ath12k: Introduce hw abstraction"

This patchset extends the implementation to allow combination
of multiple underlying radios into a single composite hw/wiphy
for registration. Since now multiple radios are represented by
a single wiphy, changes are required in various mac ops that the
driver supports since the driver now needs to learn on how to tunnel
various mac ops properly to a specific radio.

This patchset covers the basic mac80211 ops for an interface bring up
and operation.

Note:
Monitor and hw reconfig support for Single Wiphy will be done in future
patchsets.

---
 v5:
 - Addressed Jeff's comments
 - Made arvif config cache to be dynamic in PATCH 07/12

 v4:
 - Updated missing Signed-off details for patches.

 v3:
  - Rebased on ToT (added additional ar check in PATCH 08/12 for p2p)
  - Introduced iterator to loop through ars in an ah(for_each_ar())
  - Addressed comments on reverse xmas tree declaration style.

 v2:
  - Rebased on ToT and dependent patchset

Karthikeyan Periyasamy (1):
  wifi: ath12k: add multiple radio support in a single MAC HW
    un/register

Sriram R (11):
  wifi: ath12k: Modify add and remove chanctx ops for single wiphy
    support
  wifi: ath12k: modify ath12k mac start/stop ops for single wiphy
  wifi: ath12k: vdev statemachine changes for single wiphy
  wifi: ath12k: scan statemachine changes for single wiphy
  wifi: ath12k: fetch correct radio based on vdev status
  wifi: ath12k: Cache vdev configs before vdev create
  wifi: ath12k: Add additional checks for vif and sta iterators
  wifi: ath12k: modify regulatory support for single wiphy architecture
  wifi: ath12k: Modify set and get antenna mac ops for single wiphy
  wifi: ath12k: Modify rts threshold mac op for single wiphy
  wifi: ath12k: support get_survey mac op for single wiphy

 drivers/net/wireless/ath/ath12k/core.h |  38 +-
 drivers/net/wireless/ath/ath12k/hw.h   |   1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 946 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/p2p.c  |   3 +-
 drivers/net/wireless/ath/ath12k/p2p.h  |   1 +
 drivers/net/wireless/ath/ath12k/reg.c  |  55 +-
 6 files changed, 815 insertions(+), 229 deletions(-)


base-commit: 4b2f0ce6f2fe0fd906d408a01e494b85c272c7d7
-- 
2.25.1


