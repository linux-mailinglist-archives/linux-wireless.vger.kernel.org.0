Return-Path: <linux-wireless+bounces-5918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E003889A523
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 21:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 027A3B22A50
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56060172BCE;
	Fri,  5 Apr 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ya4J4Phb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB578172BA3
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346343; cv=none; b=bAhtOmDDYV5mqOKPVahgBTWWMXQKWQqHh7aqXmck8bC3lwj/lGAjf0DRfm97oqi0ugaDDTjm6Te8mOKhZATXk/Oqkv5+wWjhp60ccrdn9heEpLlYgkBGn/5YkWM94fAqZpF32cOFL2048CQVqmgNgNjmiE4/Z+5JZtsEQOJQ1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346343; c=relaxed/simple;
	bh=ECSLhig8q6tukDw+6Svuc+VlvvgffONEVhSUIlgMZRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PdGe1PP792ur50REcMOAfs8qbpiGp8wm+bgp72Ie6w/T8STIghygrhdrHKeeAJbew+kdLfrviTXMvbyyN+1b9DbM4eh5MYbJmzZTUJCEQQ+A1LSqCSLsDlB1r0pVhZw1I28VvA3TWeU10ii/SHnXoacII2eAodbmecoHSYocnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ya4J4Phb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435Hvbef005830;
	Fri, 5 Apr 2024 19:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Fdkd0XH
	D89ZbnG/alY/Inj0QyEas9iRiB5CkNkJnE2g=; b=Ya4J4Phb9Go52CSzCE4INYL
	ZgU592d8mK1ZeITgUcyJkNwei5zBgLF+LP1pT2oZvcg/hLhmv75Zk6nCY2n22wHN
	3KM9vjyenuQ+edBjyGvxTF7ELB0YL2ZsN7KKkn6mGaT6l+Cn6jbI6ZtkEotpewXD
	aXU+HoDpOfUl9Cliqmc9nwQD2rxkE0A+8Px1xaT82FnaTt8KzNP1C/UkI8bai6n1
	EuIjUU+lVteZTBHgD5QIxgRvvUil1aCTXPH1JKkOjXXJpY8k8RuXtCeAUFCM3UvA
	kcyko40/XIihtVwUbfDEF4xWfXZC+5bruLA1fVMpawutO9rccMRwJ1HwrW7x8lQ=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xahb10yvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 19:45:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435JjXeD017827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 19:45:33 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 12:45:32 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v7 00/12] wifi: ath12k: Add single wiphy support
Date: Sat, 6 Apr 2024 01:15:07 +0530
Message-ID: <20240405194519.1337906-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dsg6HE939dYrbNyqS0p0FshmjrYi1MWm
X-Proofpoint-GUID: dsg6HE939dYrbNyqS0p0FshmjrYi1MWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050138

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
 v7:
 - Added get/put cache routines on PATCH 07/12

 v6:
 - Fixed print message typo in PATCH 05/12
 - Modified ath12k_mac_assign_vif_to_vdev() of PATCH 05/12 to
   not have multiple jump statements.
 - Modified PATCH 07/12 to have whole cache allocated dynamically &
   fixed cach flush in casewhere we reuese vdev created on scan.

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
 drivers/net/wireless/ath/ath12k/mac.c  | 942 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/p2p.c  |   3 +-
 drivers/net/wireless/ath/ath12k/p2p.h  |   1 +
 drivers/net/wireless/ath/ath12k/reg.c  |  55 +-
 6 files changed, 812 insertions(+), 228 deletions(-)


base-commit: 007c5443ab7bba338f81bf6ebc64375257c6af41
-- 
2.25.1


