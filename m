Return-Path: <linux-wireless+bounces-17348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A1A0A217
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2025 10:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F01188C898
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2025 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E0185924;
	Sat, 11 Jan 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="diL7WCr4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6616BE3A
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jan 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586127; cv=none; b=rpXJf8bIJMrkdN/9h7ZXcb01ZJuzuMx92p7xpAopjVxJzL7rwbwJy3w448SAGA0xgEin1NTVGtudF5SIq01okgkTKn+rJ35NLc/Dfe81S6rkQUez7My+rj/UucArjTakwYkvcF5ttF3GWQaFcjM9MazPasIJp5GaO3s8/yiTUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586127; c=relaxed/simple;
	bh=nYk2/zg5IkUVe4KD+g9GLxONKpgvXwxbcFJ/P9MUQTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owsQyHal/OXF4GXF3XSjvHV4KK0E/+tgeM7KJifyXyy1e2whxumUhq8+QTnrbF3tY2F4TIHFBCN7UFYmE0MpZDbZqqnx+NUPYuNrODeXnnaB7fI/a9vHdEUHQyah9jH5HR30uH7OclMcG31adkmZxflFyaUu6IEYDEBBJZ6GfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=diL7WCr4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50B7XaqU022931;
	Sat, 11 Jan 2025 09:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RklWO5Rk5L8QG6MeLKOQi9uc1TUGy3GbcKVzBO8B++8=; b=diL7WCr4AR/kSX/C
	CbT5G5yR4ZIxVsbsBdYzU5IWA8+6NUIesoFJHmqDp4peO1t6zlDjUnUmkW95Ejub
	hDaoLl8Zf6j4c105io7ong1CBB3NB6DC85fSVK4HQDzv52hnItP0jRDjPHACOUbv
	DGqNTqlA22rP5S5U4okxNTpBhtZ9nYibW3w6TaP8ovY5c2Yy7b6E90d99M0HP+XZ
	JmiK32P2rqdmJ5JTa7P+NL3NeNPoYXd3idBEniPHCDnN4+fwyadO9MltnETT2yU0
	/rb3lwOvldY0xvAOO33hTXTAL2eisVjteHePG82L6SaSAnOaqcer7BHLxeoEKean
	L0Jr5w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hj2ra4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 09:01:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50B91uj5010852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 09:01:56 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 01:01:54 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH v3 1/4] wifi: ath12k: Refactor ath12k_hw set helper function argument
Date: Sat, 11 Jan 2025 14:31:26 +0530
Message-ID: <20250111090129.2733338-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111090129.2733338-1-quic_periyasa@quicinc.com>
References: <20250111090129.2733338-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: nPGdcMl_MNvekOhy9VkQDeF_6cmR3suR
X-Proofpoint-ORIG-GUID: nPGdcMl_MNvekOhy9VkQDeF_6cmR3suR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 mlxlogscore=838 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501110077

Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
ath12k_hw set helper function takes the device handle and the index as
parameters. Here, the index parameter is specific to the group handle.
Therefore, change this helper function argument from the device handle to
the group handle.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 4 ++--
 drivers/net/wireless/ath/ath12k/mac.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3dd01ad100c5..9eb4eb410af2 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1199,10 +1199,10 @@ static inline struct ath12k_hw *ath12k_ab_to_ah(struct ath12k_base *ab, int idx)
 	return ab->ag->ah[idx];
 }
 
-static inline void ath12k_ab_set_ah(struct ath12k_base *ab, int idx,
+static inline void ath12k_ag_set_ah(struct ath12k_hw_group *ag, int idx,
 				    struct ath12k_hw *ah)
 {
-	ab->ag->ah[idx] = ah;
+	ag->ah[idx] = ah;
 }
 
 static inline int ath12k_get_num_hw(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 48d110e2a7de..6a7a01c35f02 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11362,7 +11362,7 @@ void ath12k_mac_destroy(struct ath12k_hw_group *ag)
 			continue;
 
 		ath12k_mac_hw_destroy(ah);
-		ath12k_ab_set_ah(ab, i, NULL);
+		ath12k_ag_set_ah(ag, i, NULL);
 	}
 }
 
@@ -11443,7 +11443,7 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 			continue;
 
 		ath12k_mac_hw_destroy(ah);
-		ath12k_ab_set_ah(ab, i, NULL);
+		ath12k_ag_set_ah(ag, i, NULL);
 	}
 
 	return ret;
-- 
2.34.1


