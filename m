Return-Path: <linux-wireless+bounces-18636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A62A2C937
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 17:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB13C3AADAB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81F18BC20;
	Fri,  7 Feb 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UBPq2lX1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5EA23C8AF
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738946867; cv=none; b=FhCVPQsHeczOrDNWp10uWzkq/0rEuHz7OpRHAM0NBwOG3QfNnkgDM6q2uLrAMemUeuz4RWpWctAEvpg4+eHkm0K9WzVPy8OygnJXi5Yoxox0cHI6m5kS9FaVArGLOBve0LyLG2kSZfm/yXcCgYXJR9U7+r6pM1OSZnYYjU3WZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738946867; c=relaxed/simple;
	bh=sF8LlQBFsrbRMrBz0OZ6k2+7aMb0hzsTqJCvtEae3V8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AtGMQDjxnCFZoWCD6JGYXs8xC2ZfDVIEciM/gu/AoHfHbyoXMvJdw0V79l4/4E3kyCpsXuYbpm2bgmajy9iAe2Ikme14B+CQZOXVTNN2wLMd7HdihueWXdtAbnExzR2zopO1H/Jni1vb5bxld7xyAXIZG3wD/VI42vbBxT14xM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UBPq2lX1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517FSt5o007278;
	Fri, 7 Feb 2025 16:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=8RfoObTtv22jTxsPrb+FzOHyCOeZeKvNt6O/uYbWHa4=; b=UB
	Pq2lX1nJc7JM4jbOTmpP5PCDd0z8pSf9xcY13/Twnb8gGiJah3Wlg64dbdSD7IMi
	j1X9CJewCinisKCfFkMtuJGFxeMM2GuvHq8R8AwG9LVB0AWnyH8S4d8oV6wy7VXH
	Ei1pBbnkZvClBw559OiLB/JGHWjOrjZ0+H5wWVqYbMkiApT4ExWdMwgBzM/IU1qD
	BqubiJUe11Q9qf5PahqOP37x8NdbVXbh4fyVZ5xOddn96IiJwCMergbI26cNdNfW
	Q8PUt3ZWKCGkkTWBirBbFXy/w8Qugh8xNZp+2n0Ht4cMM+XQh02hyojRW3pUv2NY
	33LqVMumKYGgF9i8L7Yw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44nmuqr6n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 16:47:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 517Glds9001346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 16:47:39 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Feb 2025 08:47:37 -0800
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: Enable REO queue lookup table on QCN9274
Date: Fri, 7 Feb 2025 22:17:00 +0530
Message-ID: <20250207164703.3818135-1-quic_nithp@quicinc.com>
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
X-Proofpoint-ORIG-GUID: FkZHr5SyIlnLmjF0KisvZQKnd7so-VEp
X-Proofpoint-GUID: FkZHr5SyIlnLmjF0KisvZQKnd7so-VEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=760 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070125

Instead of storing the REO queue address inside peer entries, REO
hardware module prefers them to be stored in SRAM which could be
directly accessed by REO using peer_ID/TID based Lookup table(LUT)
mechanism. This feature is expected to improve stability by reduced
interaction between host and firmware during both MLO and non-MLO
operations.This feature is enabled only for the QCN9274, so it does
not impact the WCN7850.

v9:
- Rebased to latest TOT
- refactored the common code to function
- reolut size variable added
- moved ab to front

v8:
- Addressed baochen comments
- For this, added changes for paddr/vaddr alignment

v7:
- updated copyrights
- removed memset

v6:
- commit subject change patch (1/3)
- tested latest FW

v5:
- Rebased to latest TOT
- updated the changes for ml peers

v4:
- Changed Read Address Name
- reo lut support check added for qref service flag
- Instead of [PATCH V4 0/3], had [PATCH V4 0/2]

v3:
- Added new patchset(patch-3) to enable the reo lut
- Edited patch names

v2:
- Rebased on ToT
- Addressed review comments

Balamurugan S (1):
  wifi: ath12k: Add support to clear qdesc array in REO cache

Nithyanantham Paramasivam (1):
  wifi: ath12k: Enable REO queue lookup table feature on QCN9274

Sriram R (1):
  wifi: ath12k: Fix the enabling of REO queue lookup table feature

 drivers/net/wireless/ath/ath12k/dp.c     | 79 ++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp.h     |  7 ++-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 11 +++-
 drivers/net/wireless/ath/ath12k/hal.h    | 10 ++-
 drivers/net/wireless/ath/ath12k/hal_rx.c | 19 +++++-
 drivers/net/wireless/ath/ath12k/hw.c     |  6 +-
 drivers/net/wireless/ath/ath12k/hw.h     |  5 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |  8 ++-
 drivers/net/wireless/ath/ath12k/wmi.h    |  1 +
 9 files changed, 110 insertions(+), 36 deletions(-)


base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9
-- 
2.17.1


