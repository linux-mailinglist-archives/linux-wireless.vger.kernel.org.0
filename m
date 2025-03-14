Return-Path: <linux-wireless+bounces-20367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C963CA608FE
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 07:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481B519C27DF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1001553BC;
	Fri, 14 Mar 2025 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PXiGZKtG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031F1519A7;
	Fri, 14 Mar 2025 06:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932853; cv=none; b=myVquBvm+sDVEfX+V/uYn8HKGP3qLnUj7VMZZbfZCfCK500wZhbc8g1cmgOwhAKrxn+lzt96PBFVKFeZecsPxzkm6Hf2UB+bTBuS/CE4S4GHVkBjSS7+akbTY/ydxSHOlqiBAzYIhKGRf0ORmN5I/broD1RUAR2dxmnSMVFGxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932853; c=relaxed/simple;
	bh=vM75esDZNoc5eIyqIMM5pg4yUI1lb1AGnRM5dLBr4IM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tIraG5v9iNetnvxEzW9pkYesV6z5amoJcWzAtpzWn+d+cRu9xE97f15qP5rdatf1pkoxfD7FE0CnmU7uFn1O9Ba1ZdSYtCMKdJPTqXrG0w1fDXK2ZscMbi4oe+LVvB0VQ/0bJPNWVDfoxpKIgCvLdKL7dpfPEQRzBz11u3h8/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PXiGZKtG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E2eiBF008320;
	Fri, 14 Mar 2025 06:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xLkxTvQzpblIezC+X3oafD
	SrnMCuJEVdKTkizgn4mz8=; b=PXiGZKtGt4dCAQ94nh+y+3eNRYQdva7+oan6IT
	3+2iQMcTWlehZNVFN0JhZ9GrIUnUtR9LPLWSbqV8qcyAibQaGDBduh50Wu9X0XN+
	Go8shDRz09wKehBrJECXzgVz2osnNc4sjdnzY1lPk3WEwEpZrSQT8Vh0sFmFewpD
	8knJX6dOTTFRJB3IdbNOSTuvfwzYK9MqktURuFFodpzCtFVFU2pGfSgAim2B9Ize
	zJNtjfW2r8LB9cOXLmSmYvF0UM2A0IPbpRyPq6T2VQumCry+6kMA1gyaLhVGVM1g
	+tDW1TgrLIkS8RllzBcaMtSrVtwhBO0LM/GpLchVsAO9mBdw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bpg8bxda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 06:14:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52E6E6nJ012234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 06:14:06 GMT
Received: from localhost.localdomain (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 23:14:04 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <johan+linaro@kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [PATCH v3 ath-next 0/2] wifi: ath11k: fix HTC rx insufficient length
Date: Fri, 14 Mar 2025 14:13:51 +0800
Message-ID: <20250314061353.106194-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Authority-Analysis: v=2.4 cv=PtWTbxM3 c=1 sm=1 tr=0 ts=67d3c92e cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=G9Sqsl_jvRD_TnvheR8A:9
X-Proofpoint-GUID: LWx9p1uUpUACt0IeYHTsFHaowHpx9142
X-Proofpoint-ORIG-GUID: LWx9p1uUpUACt0IeYHTsFHaowHpx9142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=561 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140047

This series of patches is to address the issue reported in
https://bugzilla.kernel.org/show_bug.cgi?id=218623.

ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484

---
v2: add Reported-by tag.
v3:
 - update commit message.
 - revert the modifications to ath11k_hal_srng_dst_get_next_entry to ensure efficiency.
 - change warning to dbg when see zero-length descriptor.
---
Miaoqing Pan (2):
  wifi: ath11k: add function to get next srng desc
  wifi: ath11k: fix HTC rx insufficient length

 drivers/net/wireless/ath/ath11k/ce.c   | 38 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hal.c  | 17 +++++++++++-
 drivers/net/wireless/ath/ath11k/hal.h  |  3 +-
 4 files changed, 49 insertions(+), 10 deletions(-)


base-commit: 42aa76e608ca845c98e79f9e23af0bdb07b2eb1d
-- 
2.25.1


