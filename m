Return-Path: <linux-wireless+bounces-5249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5489788B29C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 22:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868961C3DA00
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 21:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1DD6D1B9;
	Mon, 25 Mar 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UWVOoZAe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D286D1A3
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401805; cv=none; b=Kq/rU+vs2k8fzt/bLQIR+LVlzMG1uD782L+ZvYo7sNHATBY7qbC+H6oXjaluH0DHZv84hT8bBd3snomEejvp7edWGjhMEPqTaTgfksd1S49c+fJG15gWzGU5N4A5zHnrqi+x2M4B1iEQhz7PQLpwYuzc3sYtir7sU8oCrCubANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401805; c=relaxed/simple;
	bh=Wmuyx3Dc1a/owdPwuGwKPDHtY7ThKKEEHte02sDF8wA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkCQPtVM1fiWeFp+m9A3VEaeXymJOwPR3ek6FbiefmLK6qhfwBSlF2fsea6AGG5NJ//KXzgW5yeEF03neAKYjhNAIVKS3qR6dzsJ7Z5wqohCV1uWalZFkAIfdQ3Un2N/XSS5z6zEEoymfFHW04OEbKV2j+DcsedHutUYuIArtdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UWVOoZAe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PKOFVA025259;
	Mon, 25 Mar 2024 21:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=jg8xl7uwBk1gr6TnoYR3
	C/kZMIXoRnQIfg+/9BKo3wM=; b=UWVOoZAenKQmCvsmLDrq9tfNOP7WZE+Y82A1
	9Gf4FIeD+yv1+qGGyY4HGHzes66Na5oLy3As6WoeLmsrsgM34iU3wHf42ZQeCktV
	sjJNvjjUXuwRN7vFNfWIp6V/4MC9ZxZ5j94eb+mXj72ief41oOb0D2J+GcrABB4y
	Cl0zLQIQg0tG1LaPycyFqVp94GY7L6hDZB6u/cnrAAzNav/5xKYrhq2ivjyv3Ak4
	gHrV0jjVzNHuHE6ZVXYrTED2FF1ypjeCZgLhKG6YKB6o1T5Ljs8F1imgA0pWqZKL
	oUjyy2SZwWoMTnatV5Y7pVPFYWJtQ/1PuzCgfoaBfDAqSrSa7g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x319ja5t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 21:23:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PLNJQ8001601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 21:23:19 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 14:23:18 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH 5/6] wifi: ath12k: refactor smps configuration
Date: Mon, 25 Mar 2024 14:23:03 -0700
Message-ID: <20240325212304.28241-6-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240325212304.28241-1-quic_pradeepc@quicinc.com>
References: <20240325212304.28241-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: moiuApOKFh23pKOP6VLt6oW6rSpIdyKA
X-Proofpoint-GUID: moiuApOKFh23pKOP6VLt6oW6rSpIdyKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_21,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403250132

Move fetching smps value to a new function and use u16_get_bits
to extract smps value from capabilities. This will help in
extending the functionality when SMPS support in 6 GHz band gets
added in subsequent patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 32 ++++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7e296140439a..b4114dd22bf0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1963,18 +1963,29 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
 				     ampdu_factor)) - 1;
 }
 
+static inline int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
+					    int *smps)
+{
+	if (!ht_cap->ht_supported)
+		return -EOPNOTSUPP;
+
+	*smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
+
+	if (*smps >= ARRAY_SIZE(ath12k_smps_map))
+		return -EINVAL;
+
+	return 0;
+}
+
 static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
 				     struct ath12k_wmi_peer_assoc_arg *arg)
 {
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
 	int smps;
 
-	if (!ht_cap->ht_supported)
+	if (ath12k_get_smps_from_capa(ht_cap, &smps))
 		return;
 
-	smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
-	smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
-
 	switch (smps) {
 	case WLAN_HT_CAP_SM_PS_STATIC:
 		arg->static_mimops_flag = true;
@@ -2448,16 +2459,11 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
 				  const u8 *addr,
 				  const struct ieee80211_sta_ht_cap *ht_cap)
 {
-	int smps;
+	int smps, ret = 0;
 
-	if (!ht_cap->ht_supported)
-		return 0;
-
-	smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
-	smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
-
-	if (smps >= ARRAY_SIZE(ath12k_smps_map))
-		return -EINVAL;
+	ret = ath12k_get_smps_from_capa(ht_cap, &smps);
+	if (ret < 0)
+		return ret;
 
 	return ath12k_wmi_set_peer_param(ar, addr, arvif->vdev_id,
 					 WMI_PEER_MIMO_PS_STATE,
-- 
2.17.1


