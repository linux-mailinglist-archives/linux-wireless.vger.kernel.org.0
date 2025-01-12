Return-Path: <linux-wireless+bounces-17373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED24A0A766
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 08:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A57F7A3AC6
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABBE1392;
	Sun, 12 Jan 2025 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JE6WoEu2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D21494D8
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736666213; cv=none; b=ddRkGNtUsYI/HMmz35AAOQFlTNsOuYNoff10HmvvAEtiZI+GILP8Ar7LJWoHUVJSnXAeCb6yju/sYx2Pz56+FPwLQKiS5UvGbQM57DWBYBm5QS6s0l3QXr39Scbcwu3nod8H8VSeWrkw1gWVNcgH/38xGelfxS1gkkdLvrldwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736666213; c=relaxed/simple;
	bh=nYk2/zg5IkUVe4KD+g9GLxONKpgvXwxbcFJ/P9MUQTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZIJzyZhD+Ph2neVTIUeoK0pbJfGvuAMo0UVzk2s5W4i3pPORMfOl1gWFSKXL0Y3HaLjE/Woh5K/ItkoOboWtkgRFXKrJNwDxOp1G2byT1aYdHfTw2yApUuYOh6c4OQq+dLbwfBdydpSNE94sHhtMLYeiSPiG5r27cUdc99b13QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JE6WoEu2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C63i09012526;
	Sun, 12 Jan 2025 07:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RklWO5Rk5L8QG6MeLKOQi9uc1TUGy3GbcKVzBO8B++8=; b=JE6WoEu2m8TWwz0Q
	LsijeWkp8bq6cN/ZLi86dxdwP041xS+5F7sLiSwkefON9IsmFTB5KcGqn3xKbJhF
	vM6UM6vfztue44zJD/uGH7xyMjqC+1R6vYJFCZ+svo+kvg3lPL6qBZ4qQHg90Q0N
	qE38EO2nXMK1hDAE43dQYhiJgx1N8condCos3vMooLP2p60arg47Rx20Ej6HFYiK
	d4Q4gUZGSXuhbhTsiThg3uxeCXXMhUakgwgUTVTCtDm0IOSPX/I5YaNQ9CdllzF+
	2XDQZSI8jyh3hTNjKWaES6DABjqqDIRyDCxyZgbL2gXzQp+chTQ1eZV7a07wlDe1
	icdgHA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44484x82cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 07:16:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C7Glog027659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 07:16:47 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 23:16:45 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH v4 1/4] wifi: ath12k: Refactor ath12k_hw set helper function argument
Date: Sun, 12 Jan 2025 12:46:27 +0530
Message-ID: <20250112071630.4059410-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
References: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: gK3eQhHgJ6l2mwIoOrTkbuk2rZ0g1sx6
X-Proofpoint-GUID: gK3eQhHgJ6l2mwIoOrTkbuk2rZ0g1sx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=838 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501120063

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


