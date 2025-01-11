Return-Path: <linux-wireless+bounces-17347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B4FA0A216
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2025 10:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5C1168A90
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2025 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB524B259;
	Sat, 11 Jan 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K5wfrHXV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD1F15445D
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jan 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586126; cv=none; b=K1SmdVkV51OfTpgJrwAJnZ2lQQ5jY0F9J9acP0UjlXslseggz00/vUdc9G4PtZgnp7jLdf5toNmFbKCaOgWueckNX4JarkXTwbo03ru3IDtNKTpcjL6gnsclOzYgT56MBf4J5mI4zWAurdNnXRWZWhXPnzPJS+y+Rag8QP1R4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586126; c=relaxed/simple;
	bh=7H2puIdR2ddl3H7nP6AFyQmYUh6MNejNxFbN33ZGG9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lU7F5LxjDBbC9gSzoEh+S0I6GaU13dYeSZz1Z0blBNzTt0uAEAOOFbXgMm/RbzuNY5p4ZJJW2g4x6Il75oM5rJRIHG5873uHbS1mp84qk/EOOkvE9oC+FLW2lzYBOE2EwddJkoPTMkGtIpdObCqt2tgPYVn6P7l7Xey8o7nP1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K5wfrHXV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50B7wjFT009308;
	Sat, 11 Jan 2025 09:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=faDT+EAGHCrOstZmun4MDH
	i8pMCG/yN8mSo0uJi+Kbk=; b=K5wfrHXVqthG52FP4s6lUVKttk3fPVis6qw/pR
	727slNivKQlDJFx2oi1U84bpQn3razvJar7kkT+Y0jKSFt72in++MEDco8e1DeEJ
	iggGcdEWXTkuEL4O5glC198evNZ2+0Wdn/AJ9xaIWAjiP8uRBPJ45nzBeXaPofCA
	BmGAwF4T/O3uJwPGFZo+OPZVEpwNxwJmL1kMK3UgH40q6q2DcTdoeKyKQ034tUuh
	NUY6Bv3jPSpbJ/U7d8iexzkOcbs49wl6l65ic3p2IS9uPq/6YMS6H+W8SCNed9iY
	mhvSHKSEK2wrgid4j17CeNFB0IOjt13MTKdeHvBCx7k5Zd4Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hhvra8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 09:01:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50B91s2v026081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 09:01:54 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 01:01:52 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 0/4] wifi: ath12k: Fix the static checker warning
Date: Sat, 11 Jan 2025 14:31:25 +0530
Message-ID: <20250111090129.2733338-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -mUQITiUperL4Hlkx-DscYRPEOhoKnZs
X-Proofpoint-GUID: -mUQITiUperL4Hlkx-DscYRPEOhoKnZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=467 impostorscore=0
 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501110076

This patch series fix the below Smatch static checker warnings

Warnings:
mac.c:10941 ath12k_mac_destroy() error: we previously assumed 'ab' could be null (see line 11348)
mac.c:11007 ath12k_mac_allocate() error: uninitialized symbol 'ab'.
mac.c:11013 ath12k_mac_allocate() error: uninitialized symbol 'ab'.

v3:
 wifi: ath12k: Remove ath12k_get_num_hw() helper function
  - Renamed the patch title
  - Removed ath12k_get_num_hw() helper function
v2:
 - Rebased on ToT

Karthikeyan Periyasamy (4):
  wifi: ath12k: Refactor ath12k_hw set helper function argument
  wifi: ath12k: Refactor the ath12k_hw get helper function argument
  wifi: ath12k: Remove ath12k_get_num_hw() helper function
  wifi: ath12k: Fix uninitialized variable access in
    ath12k_mac_allocate() function

 drivers/net/wireless/ath/ath12k/core.c | 20 ++++++-----
 drivers/net/wireless/ath/ath12k/core.h | 13 +++----
 drivers/net/wireless/ath/ath12k/mac.c  | 47 +++++++++++++++++---------
 3 files changed, 47 insertions(+), 33 deletions(-)


base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256
-- 
2.34.1


