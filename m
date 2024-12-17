Return-Path: <linux-wireless+bounces-16437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F689F416A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 04:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AFF1686BE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 03:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2331459FD;
	Tue, 17 Dec 2024 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GthtFaCY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A30812E1CD
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407984; cv=none; b=asfEBNdZvCl4uQGMXWsZgHhhxyLtUs3v7kINpo6mMmRDQmDGp1kFnz4gcLzAKak00rkW7e0LGHVHY6IQ0CJ1fFCVsyrr3xDUyP1KJ1EubHwbZ0H4ci76xYKXkT9NrDdszKJKPqEeIh21gUS6TGcZX5kq3gMZobGdeL1wCsYYSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407984; c=relaxed/simple;
	bh=UmrY3OCgQYBmFqblk4iW/5lG6UlTf5tOJDKqk0r7yY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdZEYrUUOidwi7gVWPorEE32WfYOh2Mvq5+WAEyS8UKOs9IcRQhLv/Gy+UmrTcUC1DvNj2ZYNvux7wCosYaTvZNpM9hDgNeiqFLuV+kO82QKYcOZrSwgfSzA7MO3TY8N4T1kXmaZfWUlJ/AY8OsCZ17ozx3o9oysawYZUI4BzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GthtFaCY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH2AU6g029279;
	Tue, 17 Dec 2024 03:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wbUB2ufcYBkl+AYPK5HcuwiuIgImA2o2x5Sa62H+dT0=; b=GthtFaCY9bp7PaBX
	Nub6usBz69BccGdCyX9C6puuOvj2TZw2GjJGMLx3cmCkE4fKWx4vQ2qgEquK+yxr
	VxjrVZKmXlsS5LKK5nsaNhKX062QEqLM3t/ZKyP93bi0XLhfcuMQ176oFV6wtLUG
	w4uk/8jFgHtFFz1N1kbUGSwVXrSbGId8prXwh7RKWeenwUnUn8EGKULHI61Oz5iC
	5MLgR3le+E95pW0pJzdPDHVK6NQLb/6DwHDj0/5bXydrwzwlock++qYIqqzciD8j
	2Z0FpZoUyBXLvBGDBRKvGcT54ubgl2Xds8u5sDwDq6CLt+Wgt0XJlHNL/IAaQhqe
	OIepmg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k09mr742-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 03:59:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH3xcZj007936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 03:59:38 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Dec 2024 19:59:36 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 1/4] wifi: ath12k: Refactor ath12k_hw set helper function argument
Date: Tue, 17 Dec 2024 09:29:17 +0530
Message-ID: <20241217035920.2683568-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
References: <20241217035920.2683568-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: o71PgjhYUCWYM_swzOJXoBvhzAk3v9mM
X-Proofpoint-ORIG-GUID: o71PgjhYUCWYM_swzOJXoBvhzAk3v9mM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=801 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170030

Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
ath12k_hw set helper function takes the device handle and the index as
parameters. Here, the index parameter is specific to the group handle.
Therefore, change this helper function argument from the device handle to
the group handle.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 4 ++--
 drivers/net/wireless/ath/ath12k/mac.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ec61ad3d82c3..efc273957b9c 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1203,10 +1203,10 @@ static inline struct ath12k_hw *ath12k_ab_to_ah(struct ath12k_base *ab, int idx)
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
index 186765fa95f5..cd22d4849ee6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11346,7 +11346,7 @@ void ath12k_mac_destroy(struct ath12k_hw_group *ag)
 			continue;
 
 		ath12k_mac_hw_destroy(ah);
-		ath12k_ab_set_ah(ab, i, NULL);
+		ath12k_ag_set_ah(ag, i, NULL);
 	}
 }
 
@@ -11427,7 +11427,7 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 			continue;
 
 		ath12k_mac_hw_destroy(ah);
-		ath12k_ab_set_ah(ab, i, NULL);
+		ath12k_ag_set_ah(ag, i, NULL);
 	}
 
 	return ret;
-- 
2.34.1


