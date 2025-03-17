Return-Path: <linux-wireless+bounces-20422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9337A64358
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 08:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB6416E3E9
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 07:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80488219306;
	Mon, 17 Mar 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cFjpXA/v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB31422AB;
	Mon, 17 Mar 2025 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196060; cv=none; b=o5atlqcBYAF0v2M+St7nK3iPjCyfrlyBubm4PSWWL/ndz+q5zs1wH7JqS0n/LcfUQEwF29W3BvmcomShiCaxCPFfuszX2KPynWElhD2sjtKQU//vNuh6VUvDTujDomFmuRbCgA0yKsPuN3lsX+D0AYiLUgzlaZIrATFgWYrVfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196060; c=relaxed/simple;
	bh=BLwEvq677Y5sIK2sRhUBNughuHnK2jwjXUizTI1Ln8U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tpMCoeomkKgKN7M1R7JZH434zT4u7qLQltNL9ODKK8L26F0UJ4PhBjR+TsE/3eI4jysWp+pigOOryGHIl6GnH8ouxT1HgcGEJ6La99ANHvffs7mWCjusmeWnj9mKnuvZI5Y/ic+DxZBu9lwm6vTlSJciOKRcCHvEQII18Ymtyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cFjpXA/v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GMbtPn026060;
	Mon, 17 Mar 2025 07:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Zqf7o/zOSVOymj+dOZ4eU7
	eGH7z4Hu5sUf59UxuLG9o=; b=cFjpXA/vckO1zjV1i/jttAl6wOZIhM0L+GDv0a
	V3hlKuK0cnJK2To4zM17fJUjijXoOSSOn9PbqusUCZuh8aWB1R/D7up9IdmxngAb
	/zHe5XR3VqYa/T4fybVm/vJRbV7HZrYFhYbtFqz/y7e3fI7QMGxYCpUBSTTqGWGJ
	C1BNrBXEx52l2bNgl2qVjY6bsg5e+rljzS7UE3ex8C2rOOfkmgsbpIfJF8sNPjeN
	poLAfq5fAUE18nTEIEZSIfbHpL+Jt2al8aToxQlFPJAYr172A8gxp9zHO7rsUMsB
	ziHaOY4dV/thScfN7Egmgzdbdn6GJqHZSoCkz/gqrCgQvYMg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sxur2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 07:20:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52H7KpL1015581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 07:20:51 GMT
Received: from localhost.localdomain (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Mar 2025 00:20:49 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <johan+linaro@kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [PATCH v4 ath-next 0/2] wifi: ath11k: fix HTC rx insufficient length
Date: Mon, 17 Mar 2025 15:20:34 +0800
Message-ID: <20250317072036.2066518-1-quic_miaoqing@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O2A91ObrAwYlYxpL4K-Os50DZMHS2dAh
X-Proofpoint-ORIG-GUID: O2A91ObrAwYlYxpL4K-Os50DZMHS2dAh
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d7cd54 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=xr_cD6ut0Tu7_UOcYl0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=559 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170052

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
v4:
 - update commit message.
 - remove is_desc_len0 flag.
 - skip updating the length field of the descriptor when it is 0.
---
Miaoqing Pan (2):
  wifi: ath11k: add function to get next srng desc
  wifi: ath11k: fix HTC rx insufficient length

 drivers/net/wireless/ath/ath11k/ce.c  | 14 +++++++++++---
 drivers/net/wireless/ath/ath11k/hal.c | 23 +++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/hal.h |  3 ++-
 3 files changed, 34 insertions(+), 6 deletions(-)


base-commit: 42aa76e608ca845c98e79f9e23af0bdb07b2eb1d
-- 
2.25.1


