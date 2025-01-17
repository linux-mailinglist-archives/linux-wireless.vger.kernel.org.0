Return-Path: <linux-wireless+bounces-17649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6093A14FA4
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 13:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067F6163014
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFA61FF1BA;
	Fri, 17 Jan 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dKQEFgzf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FE1FF7D1
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118009; cv=none; b=VQ/iO4v4IOlYdBfURI7pMTo75tEshQUaDJbBfqEb/rEkdjZNQ6GDdOW8791GnmW1VO0D7nk8fvh/6wRMPJI04KZiKl3V5d3SOWyon7iYuEP6nlisCXqD9igFC93wJFn+vCzVNjKP+z3M95H8TXmi5Rh+cZGgSa9iBYzHd15JXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118009; c=relaxed/simple;
	bh=N7AOMXOlxpWKliW8rjOTsAxZiPgxUJJ5yVcjMLDKRy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2P26MaWQ7yra6jtKcbGDJzwuTxQG19IaV3TeWre+12iHTOewMbrjNC9SfflNR6xp1bbR5ScYkkESz50fXn1vnkonh8TtpmL1B5pDf1deWn6Ql7ckci0cWGzmFEvRETOfNXZFFIygypUXBTQd7KacROZSsZ5VhXoUIahFGYMyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dKQEFgzf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H7KuDC015434;
	Fri, 17 Jan 2025 12:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sEGdGdQg91cjLr4IRTqigPGHulFSRD470Yhbk+3/904=; b=dKQEFgzfDcp0Iuo9
	fQ4BJHUubVhQXvkmQN/yqR2G1W2bW2/tbMAbFidx9NBZ1YFQj/xvqY+xSzqdAnN1
	EHITBwC7YGJ4I4fjHJ4JJFvgyMuNkIMWeK03tVQQg89gP5hnpitehgL4OPTOIiYr
	xpkaNTR9w96ufZB0bHGFFhvYHrI3oda7J+zrw4nWXhlA9psmEqKy3r6giUbk3Eyw
	A0bJWpGQhALfPOGaPFdPGGFdBoH51x21i/j319Zb6cg2g3lB4YwgQUdlX2tPhEkT
	JYJyNva+MW+coEybAbAA4ZE3Xe61SSh4UHwHAwERHfB/FJoL4kbFwORTyv7mz5C7
	XTBvbg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447jr38trx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50HCkgwe014872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:43 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 04:46:41 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC v2 12/12] wifi: ath12k: correctly fetch arsta for MLO
Date: Fri, 17 Jan 2025 18:15:54 +0530
Message-ID: <20250117124554.3719808-13-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
References: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-ORIG-GUID: RKiCCYbRZuvRq_Ou_ymDizb-haae85GG
X-Proofpoint-GUID: RKiCCYbRZuvRq_Ou_ymDizb-haae85GG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=552
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170103

Currently in ath12k_mac_op_sta_statistics(), link sinfo structure
is filled from arsta structure and arsta is fetched from ahsta->deflink.
For both non-ML and multi-link operation (MLO), deflink is used. While
this is correct for non-ML, but the corresponding link_id should be
used for MLO.

Therefore, add support for MLO by taking the link_id from the
link_sinfo structure, fetching arsta from ahsta->link[link_id], and
filling the link_sinfo structure if valid_links.

NOTE:
 - Currently ath12k changes are only included as an reference to other
   drivers.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8023b8943fa4..17e799a9b2cb 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9902,11 +9902,18 @@ static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
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


