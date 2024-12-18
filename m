Return-Path: <linux-wireless+bounces-16525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFBA9F5DAF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 05:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4936B189081A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 04:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E895849652;
	Wed, 18 Dec 2024 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U8YTM0CM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9935956
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734494544; cv=none; b=BD/iPXFCmNbKy7pVDow+19zI0k16aYuima+3L4hR0Tvinfk6sw3IebQ47MCtZJVIf5YpVDzhiu3xb7DqdRIrU4bV2FhaPgmcEEKR+Uud08yTmWpSVTqfMA333vwLDRYmK+EuZKLoqAQ9akS9PyMXAwrIDXhMmrG+BHl72MO/SZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734494544; c=relaxed/simple;
	bh=dIQjl206Albrh/qkLdavwpueZ0/k2XMrLAoIAH0jcl0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DddHkQIe32/jyqxuQCuWG5C3I8Hmy6uf01HNPh/6dJ5CD4n+LEAj0lsDRISX0srw61DIUcNwgZ4vCLcIrGuW5pXsSIQPqxtmRxABjI3aRW5x08lYuud92kHB+io24qNBXDLzhC2DBuQZnkDe2nNba0fHFdgz4+ThZ1JqKcmmlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U8YTM0CM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHLL8P7017955;
	Wed, 18 Dec 2024 04:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=B4xaBfTwlbhTZBdioQ314V
	XzYNLWYXE51uDaXOjxQ74=; b=U8YTM0CMvpW0fJyMQruT1b44B9WkLJxLnaKxxI
	cl1USDvSidtY6lMM2B6PCK/i84ucgbsDxdTDbV0Y9MajQG42BXADOVk//+pdZwOY
	u2st2+0F67avuVnSf258w6SI/me5meJA0KVofL4g1OQALQ/7OSaV28KtoA+FxyB/
	yEX7Gbv2x/mdCUuJCy07vnZhE7RuScs+NK3V5tIVdYtekTG1krZiZXnY4EuqXHAJ
	taBFGGOaTzQjJCk9CSOf9VNy8E1eq4vMkP0Xsy+Nn9h42gaT5f+L9XGTES8+BWqV
	G8T8QQU/aWDDsa1tsglzykFjtJAfVkd0S/Hj12ko4HGhwsVg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kefxh3fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 04:02:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BI42EDD015594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 04:02:14 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 20:02:12 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH] wifi: ath12k: Include MLO memory in firmware coredump collection
Date: Wed, 18 Dec 2024 09:31:49 +0530
Message-ID: <20241218040149.4041728-1-quic_rajkbhag@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1fCbYxJVq6idNqtp6VEdIDvFOWv08WAZ
X-Proofpoint-ORIG-GUID: 1fCbYxJVq6idNqtp6VEdIDvFOWv08WAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=991 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180029

The current firmware coredump collection in ath12k does not include
the MLO_GLOBAL_MEM_REGION_TYPE memory. This memory region is essential
for debugging issues related to Multi-Link Operation (MLO).

Hence, add support to include MLO_GLOBAL_MEM_REGION_TYPE memory in
firmware coredump collection.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/coredump.c | 3 +++
 drivers/net/wireless/ath/ath12k/coredump.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/coredump.c b/drivers/net/wireless/ath/ath12k/coredump.c
index 72d675d15e64..ce1beeb54836 100644
--- a/drivers/net/wireless/ath/ath12k/coredump.c
+++ b/drivers/net/wireless/ath/ath12k/coredump.c
@@ -27,6 +27,9 @@ ath12k_fw_crash_dump_type ath12k_coredump_get_dump_type(enum ath12k_qmi_target_m
 	case CALDB_MEM_REGION_TYPE:
 		dump_type = FW_CRASH_DUMP_NONE;
 		break;
+	case MLO_GLOBAL_MEM_REGION_TYPE:
+		dump_type = FW_CRASH_DUMP_MLO_GLOBAL_DATA;
+		break;
 	default:
 		dump_type = FW_CRASH_DUMP_TYPE_MAX;
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/coredump.h b/drivers/net/wireless/ath/ath12k/coredump.h
index 5d6003b1c12d..13f46a605113 100644
--- a/drivers/net/wireless/ath/ath12k/coredump.h
+++ b/drivers/net/wireless/ath/ath12k/coredump.h
@@ -15,6 +15,7 @@ enum ath12k_fw_crash_dump_type {
 	FW_CRASH_DUMP_PAGEABLE_DATA,
 	FW_CRASH_DUMP_M3_DUMP,
 	FW_CRASH_DUMP_NONE,
+	FW_CRASH_DUMP_MLO_GLOBAL_DATA,
 
 	/* keep last */
 	FW_CRASH_DUMP_TYPE_MAX,

base-commit: 9a448415ed0c46edeb9170091a03b620986ca0b2
-- 
2.34.1


