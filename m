Return-Path: <linux-wireless+bounces-4593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A32787904B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 10:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA461C21A03
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E110477F37;
	Tue, 12 Mar 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OAxrE+jR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83678274
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234267; cv=none; b=YwvjOHjjTmoEkJvT2yFOLzU5Ncs1UzA6EAOQYfQ4Yz/KEPPe7EY7YHU12WzKQ1U8jwFJo3AQwrNec88UWzit8gLT4mYaBPgiWeXVhg/g9ZVFU+OHxDsyqooIIrkzqFFmPkse8ZU0LQDvoj1KWwgeh7mokZ33AQba43+wiqYRjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234267; c=relaxed/simple;
	bh=D9c3odD5uwawjkVjEaT6bNjwayFp574LHr6X0AgfgDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r5QN9Z3NRM+MQJ4XsOrJ6P71dVOq++7y2rM0ozSsyrM39rlTd9mhKa8GMJZPcTeHZ1bTW0WJga8mcf/3I6yNd0juQaH44SPTVHNzMCB9/MoQfkGHgiLgKybQjOBWdzbfL/vs1cHVxUsQ7elbRGknTtgZy3o/qfpWWnvn+1uTnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OAxrE+jR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C7jT8I022963;
	Tue, 12 Mar 2024 09:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=YObG3Tz
	ADuvhRjC2q7ksDzeFiPU8CLKxUy23PrmGfOQ=; b=OAxrE+jRC2QLQuKLFeMV3dc
	Jl+2GuFZ7rVRO98RRfsN08VDQAIAy/BhY7IJ1B7/K9dy5fVaWZZCWRn9mL0qg9vy
	fqAFG33Zf69TDK4z8M+dNkI2KCSNqCW78pBILI//VaIKxNYqSYBFZ0Io3joWhbUR
	ysYfdikcASkxdI5gopLh9/UqE2N7o0ssvXCWGTS5kRqvkysUcXf2IXgoHEjytQhm
	ZOb7rcdkwMU0XZANg5ioRtsNG8NQQqViQzkXykv6zrGj7RrMLEYJfCmIShD3jtTG
	PjTxecEqSpbCtiVqtGea5na9d2BfkhsyNKxSyp8f3fZSNBImWsLXLnlLOiEMfgg=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtjwur53a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:04:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C94KQ1022613
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:04:20 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 02:04:18 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH v3 00/12] wifi: ath12k: Add single wiphy support
Date: Tue, 12 Mar 2024 14:33:39 +0530
Message-ID: <20240312090351.1620218-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e45BLpY82qnLJ9tZhn9zqccw3seaNIpk
X-Proofpoint-ORIG-GUID: e45BLpY82qnLJ9tZhn9zqccw3seaNIpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=952 clxscore=1011
 malwarescore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120068

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


