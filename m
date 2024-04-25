Return-Path: <linux-wireless+bounces-6897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA48B2CF7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 00:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125C828351D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1C156238;
	Thu, 25 Apr 2024 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q7h2cuJc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32657153BD7
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083560; cv=none; b=V/4glAjviYV+I2vQJlTZ7KgogSukFoCs3L4YBbBLTkzdcoK/+AwBWUG7kgvWdKockkg0xGaibFCxgd3ZQkiUR1+q1SCULWucbx6S1jdJzlPwJyZg9CUhAtkSsgSrG1CCEmJ1aPKt09z+wIRcCW5nHQMwo/NsxdCwKAWBEyrLekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083560; c=relaxed/simple;
	bh=jM0fPJdJOwIv5IV34r2l+9R+LjiFPL9AGzJMjx8pOJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JABzlypndiDBGDpuJ4GRsANOZqzhoMlriry2WiBapS2SfINieePmRTsLvCVkdw5NwLB45/3vWDLwt+10ePGy5hWx4sv6VbaRUrWopxBd8klN5dCjOGcIBObK4WhKy1tTIuTeN8BLxXAf3vKrtgTg5461avQTbWTLwfX13i1p4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q7h2cuJc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PLjKxe021088;
	Thu, 25 Apr 2024 22:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=kGUj3v0Pv5TVgXxV2YJ8
	yl6KXgZxFwuvlfUYyUuvN6s=; b=Q7h2cuJczJH6U1qGwza7zwO/MnIvL1U72H+n
	7Dqsw4XhVRP52uaY/QczrirEaPDeunuhegRBxunege3/ZccVs0k1uivDNULWP1FV
	wkAZhjW4VpBQFrPUW5/DynIDN7d2kjpFjwyz7b8IvgTE1hOJ5JqpOu2rIG05q+XF
	QHzFAS9Xtl4odVyz31FVtgmFEMk7N/lJoU+QgcuteK5IO7ks0jpElD16+uFjAT2X
	2MZSiFYaolQl3bRzleUlu+FISCh2HTwf6uPPIyeiVuIfz7okMxt7OAZYfFcW8ftd
	uNIMojEcnC6GbGD3/FBTn1xso0vYTwHLYjfQLGO+CRYj/Uixeg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenh3tr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:19:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PMJEUW017357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:19:14 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 15:19:14 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V4 5/6] wifi: ath12k: refactor SMPS configuration
Date: Thu, 25 Apr 2024 15:19:01 -0700
Message-ID: <20240425221902.11553-6-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
References: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WPh1qsQ7Yo7Wsq4bS2ySx90ppD0zsMwW
X-Proofpoint-GUID: WPh1qsQ7Yo7Wsq4bS2ySx90ppD0zsMwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250163

Move fetching SMPS value to a new function and use u16_get_bits
to extract smps value from capabilities. This will help in
extending the functionality when SMPS support in 6 GHz band gets
added in subsequent patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 32 ++++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8836dc67f7e0..d4bae41a32d4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2086,18 +2086,29 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
 				     ampdu_factor)) - 1;
 }
 
+static int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
+				     int *smps)
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
@@ -2571,16 +2582,11 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
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


