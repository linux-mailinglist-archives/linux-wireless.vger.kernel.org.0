Return-Path: <linux-wireless+bounces-18937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD0CA34BDE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4BE3AE197
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADAD207A11;
	Thu, 13 Feb 2025 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="diYt9soJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE25205505
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467064; cv=none; b=mH3UPj2ed7fpGDcx5EvF4CwUCZ09wZXQryngt8qor8mV1/eZyS4tj/Pzyt8okfBiBXJ1Y0D2v7EDXNGwAGy+vF1dxjy4C2J+XU52w2+GT/6+efl/FWr2/a39w419vyblsGQYaXtYdL6YRv6eGBtbzLwRHVobEpfpXAfuvEODcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467064; c=relaxed/simple;
	bh=m/LV1RpDQ5aOulxsmNUC9DyflXl9fg10DIqyQO81ed4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPqiJyme3L5C72L2pe5evMAvsZqYagol9VrqxAnSEnk6McKlkFnVyoEpmPOs/wjcxPvdpqIhZLPRjiRHNQdDEe79fGtnEbMQ5hIDNRTKkJ1BhknhGDWb83apXLhzKqyeONNd0hIBz5e912xm3nLQHwV6x6edkWKhSikQzgxKDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=diYt9soJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D81FoJ008091;
	Thu, 13 Feb 2025 17:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QVbjbeUFmzBy+XVijdUnQmTxYT+HdP+MYIiRZe0IzcA=; b=diYt9soJ8GKJpOC4
	EczSza+MyWX95ecnmi49VC6wMHwSrS5oUFTUAghFLFjhWHZOt+I4Dntu+sV0ro3o
	1QhWAz757xhmO5TWsCzpcSsUNx61N/+EgiMcZ0LWruLUbtTHQ0s0N1IKLQzPmO7R
	DcIs1DJhgU6wzT4qJOn/D4esuMmzvVJ/+uGgeBQwImJ+uLkTc3VUb2Ml4KVmD0A2
	SK9XAiXlMN2PFQlIjK4mpG6ZAvq5RtZeozHES62bBSh7GR7QlUauvFDiI9vY/gCg
	6r19kHsCFXBs53l/KactlPW8D7Ajz4GN7uqzRiSrhKHTPOG9qRoLXjGUwzs1ZuBp
	vYQrjA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rr1qvr25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHHa0X012053
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:36 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:17:34 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH v3 12/12] wifi: ath12k: correctly fetch arsta for MLO
Date: Thu, 13 Feb 2025 22:46:32 +0530
Message-ID: <20250213171632.1646538-13-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aSBg71vVWBJPzfT9X8WWmzEN8uE_cxnp
X-Proofpoint-ORIG-GUID: aSBg71vVWBJPzfT9X8WWmzEN8uE_cxnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=529 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130122

Currently in ath12k_mac_op_sta_statistics(), link sinfo structure
is filled from arsta structure and arsta is fetched from ahsta->deflink.
For both non-ML and multi-link operation (MLO), deflink is used. While
this is correct for non-ML, but the corresponding link_id should be
used for MLO.

Therefore, add support for MLO by taking the link_id from the
link_sinfo structure, fetching arsta from ahsta->link[link_id], and
filling the link_sinfo structure if valid_links.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7767971ae4c8..611cdab85329 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10023,11 +10023,18 @@ static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
 					      struct link_station_info *sinfo)
 {
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
+	int link_id = sinfo->link_id;
 	struct ath12k_link_sta *arsta;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arsta = &ahsta->deflink;
+	if (link_id < 0)
+		arsta = &ahsta->deflink;
+	else
+		arsta = wiphy_dereference(hw->wiphy, ahsta->link[link_id]);
+
+	if (!arsta)
+		return;
 
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
-- 
2.34.1


