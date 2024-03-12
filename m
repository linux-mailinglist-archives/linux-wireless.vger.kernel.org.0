Return-Path: <linux-wireless+bounces-4611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6D687956A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 14:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEEA1C22178
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0C7A714;
	Tue, 12 Mar 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IHU38GT5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2779B96
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251782; cv=none; b=IiV0gc1wWH0mb8pT+5iCNONiPevf9nz3pBGdqRlocl8QwoQXD8kifjddKb5aKgUp+oyb5jN/nwC8GzFq6n7aZVFB1GlaMZd3EBkyGQSAiLxQsjjWzoyxGKG1MHr0U/75eAakN3GpbhOzPXywsbZTyZ0aQ/uLlvzHXqP4JWSSKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251782; c=relaxed/simple;
	bh=vWt7eiPYWs22ea9zzNM0u5XUhVkPGMWzuKixwTMLtd0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cy72YZr1v7vLNSsNwqi8dMCWDHcx7Tw9tAyQBsDC2VrYnKMWAfHjz8rZH6rAEbv8RpBS8vUM/M7tbCDOEdwKBjU+B3XE1KwxVFHxvMsFopi8+PUjd463kEtICbx5/MzEBiAI8SKXjNXYxCh+gcCM914VDv0k7NvEdNu6X5l8VVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IHU38GT5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CDTsEL010071;
	Tue, 12 Mar 2024 13:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=I3n3Vwu
	gK6Q8zEq8WEjFwlN8V28bp3nCeUOeS3k4Hus=; b=IHU38GT5VmfEOH8wL7rc2KU
	mtQxLu/duT0t985wLnk/P34n9yKwt3uvGaEeqkMw9M2g9JQKXsuZZgIPvOLrlr5L
	GUljku/anUYkEjgwTljbpgFHqTeRtT8fFOmQXa/vf9BgeaLUxqYOejSD93V+xddw
	iTqhpjKsZv/eOUV/4JZpG7qaYHxAsc/Rz6L2WNGPG7yaiGekC3IgF2UN192IVmjQ
	L7Ayiym8LMUTO833yPjOSTtsxbjShJPqg/KoKJUQqrOuKzPJJshERJV792Crxxn3
	K5C15cyqJY9p5IZPj0TaO2MWADcbMNI6YCfQGkdlTe9lKApgNxMduG89G39gDnw=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtprj87uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 13:56:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CDuFSI010698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 13:56:15 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 06:56:13 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v4 00/12] wifi: ath12k: Add single wiphy support
Date: Tue, 12 Mar 2024 19:25:45 +0530
Message-ID: <20240312135557.1778379-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: GZd6sDOEyUT7b5P_syzuv3THw7LgHmRc
X-Proofpoint-ORIG-GUID: GZd6sDOEyUT7b5P_syzuv3THw7LgHmRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=997 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403120106

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
 drivers/net/wireless/ath/ath12k/mac.c  | 911 +++++++++++++++++++------
 drivers/net/wireless/ath/ath12k/p2p.c  |   3 +-
 drivers/net/wireless/ath/ath12k/p2p.h  |   1 +
 drivers/net/wireless/ath/ath12k/reg.c  |  55 +-
 6 files changed, 785 insertions(+), 224 deletions(-)

-- 
2.25.1


