Return-Path: <linux-wireless+bounces-5926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA189A52B
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 21:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A652B2839E3
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9266174EDA;
	Fri,  5 Apr 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pa9eKg5k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07877173353
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346358; cv=none; b=hTOSMUCtfGEHt24gIdR/uuSWF1O0isZcgHz098g5DAAynFwg8GZxf6Yhp3BaO1x0euCNnwA/3neTd+I48kRmqu8wnRX6/1ifZBjiIMhCH/U6Cgabhd59R/7X7YMD5D3wHpasthFDowRJ5pk5Sz+lfh8C+rtl/78UoLPB4S7JvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346358; c=relaxed/simple;
	bh=30VWTe3vVWJhYNiGePgYXbU44Fwwol1KWtUkDbCqBGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jp7F6mhvXaqpvYhRUmDBkAgD06Q1jmszC7DFh+zEc2Vgg5tNaZLkciJuA0/TloSESzjjVXgxhLWGOgRaiKWcwvnYQBR4dQq/4WBeVewJvTWoW6bQkmXWVmRxl0A5rDuktOkErky9hbOliLACvcgHbl2jN4YL0YuwleBMs60Sr6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pa9eKg5k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435IbnHL010146;
	Fri, 5 Apr 2024 19:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=yU/3QiSZ4pGYX7sn/DA/UjLBjTzaQwp0n0zZdu0/au0=; b=Pa
	9eKg5kD9CxQFPS5FRGrqhPb6B/pkJITLAAL3BR1aRPn2y+2nUYyYK455KH0O4AOe
	XGi1PR/OyLcTles6InrU0K0wBXMq0Wr5PmekylKKV5P2iW/hFu5OvvdlUIz27Lij
	ZATei3H9CCKESYYG7M33lzUcfWztEpMVoqTn1/lQQl/AkQKBKeqD3xd/o2z8aYCj
	mo2PlF7ZtYhSobElnbxuW26hvirgWuMX7Ux8Fo9VJQePoN7TFj2tYHhuRKbGL65H
	BtlbGRntObwSHljizVw4BTdo24M3i4O2PgfG+daHXc9NklqneyY5tRYx51y7W4cQ
	8Q365yuhp6T51U1GbCKw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xahgt0y0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 19:45:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435JjqIw011664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 19:45:52 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 12:45:50 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v7 08/12] wifi: ath12k: Add additional checks for vif and sta iterators
Date: Sat, 6 Apr 2024 01:15:15 +0530
Message-ID: <20240405194519.1337906-9-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405194519.1337906-1-quic_ramess@quicinc.com>
References: <20240405194519.1337906-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: hNRnnYOnCPgLTytpyKnnZzxGDCFi6xCZ
X-Proofpoint-ORIG-GUID: hNRnnYOnCPgLTytpyKnnZzxGDCFi6xCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=851 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050138

From: Sriram R <quic_srirrama@quicinc.com>

Since vif and sta objects of different radios are added to same
local hw list in mac80211, additional checks need to be done
in driver to ensure we are processing the intended vif
and sta corresponding to the radio when the vif and sta mac80211
iterator utils are used from driver.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 22 ++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/p2p.c  |  3 ++-
 drivers/net/wireless/ath/ath12k/p2p.h  |  1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 79d2d9d5f720..e1a7beb02df1 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -291,6 +291,7 @@ struct ath12k_vif {
 
 struct ath12k_vif_iter {
 	u32 vdev_id;
+	struct ath12k *ar;
 	struct ath12k_vif *arvif;
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fed9ce490b37..6773dce9065a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -534,7 +534,8 @@ static void ath12k_get_arvif_iter(void *data, u8 *mac,
 	struct ath12k_vif_iter *arvif_iter = data;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
-	if (arvif->vdev_id == arvif_iter->vdev_id)
+	if (arvif->vdev_id == arvif_iter->vdev_id &&
+	    arvif->ar == arvif_iter->ar)
 		arvif_iter->arvif = arvif;
 }
 
@@ -544,6 +545,7 @@ struct ath12k_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
 	u32 flags;
 
 	arvif_iter.vdev_id = vdev_id;
+	arvif_iter.ar = ar;
 
 	flags = IEEE80211_IFACE_ITER_RESUME_ALL;
 	ieee80211_iterate_active_interfaces_atomic(ath12k_ar_to_hw(ar),
@@ -6848,14 +6850,19 @@ struct ath12k_mac_change_chanctx_arg {
 	struct ieee80211_vif_chanctx_switch *vifs;
 	int n_vifs;
 	int next_vif;
+	struct ath12k *ar;
 };
 
 static void
 ath12k_mac_change_chanctx_cnt_iter(void *data, u8 *mac,
 				   struct ieee80211_vif *vif)
 {
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_mac_change_chanctx_arg *arg = data;
 
+	if (arvif->ar != arg->ar)
+		return;
+
 	if (rcu_access_pointer(vif->bss_conf.chanctx_conf) != arg->ctx)
 		return;
 
@@ -6866,9 +6873,13 @@ static void
 ath12k_mac_change_chanctx_fill_iter(void *data, u8 *mac,
 				    struct ieee80211_vif *vif)
 {
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_mac_change_chanctx_arg *arg = data;
 	struct ieee80211_chanctx_conf *ctx;
 
+	if (arvif->ar != arg->ar)
+		return;
+
 	ctx = rcu_access_pointer(vif->bss_conf.chanctx_conf);
 	if (ctx != arg->ctx)
 		return;
@@ -6987,7 +6998,7 @@ static void
 ath12k_mac_update_active_vif_chan(struct ath12k *ar,
 				  struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k_mac_change_chanctx_arg arg = { .ctx = ctx };
+	struct ath12k_mac_change_chanctx_arg arg = { .ctx = ctx, .ar = ar };
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -7563,6 +7574,9 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k *ar = arvif->ar;
 
+	if (arsta->arvif != arvif)
+		return;
+
 	spin_lock_bh(&ar->data_lock);
 	arsta->changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	spin_unlock_bh(&ar->data_lock);
@@ -7573,10 +7587,14 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 static void ath12k_mac_disable_peer_fixed_rate(void *data,
 					       struct ieee80211_sta *sta)
 {
+	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k_vif *arvif = data;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
+	if (arsta->arvif != arvif)
+		return;
+
 	ret = ath12k_wmi_set_peer_param(ar, sta->addr,
 					arvif->vdev_id,
 					WMI_PEER_PARAM_FIXED_RATE,
diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
index d334df720032..3a851ee15b2f 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.c
+++ b/drivers/net/wireless/ath/ath12k/p2p.c
@@ -121,7 +121,7 @@ static void ath12k_p2p_noa_update_vdev_iter(void *data, u8 *mac,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_p2p_noa_arg *arg = data;
 
-	if (arvif->vdev_id != arg->vdev_id)
+	if (arvif->ar != arg->ar || arvif->vdev_id != arg->vdev_id)
 		return;
 
 	ath12k_p2p_noa_update(arvif, arg->noa);
@@ -132,6 +132,7 @@ void ath12k_p2p_noa_update_by_vdev_id(struct ath12k *ar, u32 vdev_id,
 {
 	struct ath12k_p2p_noa_arg arg = {
 		.vdev_id = vdev_id,
+		.ar = ar,
 		.noa = noa,
 	};
 
diff --git a/drivers/net/wireless/ath/ath12k/p2p.h b/drivers/net/wireless/ath/ath12k/p2p.h
index 5768139a7844..b2eec51a9900 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.h
+++ b/drivers/net/wireless/ath/ath12k/p2p.h
@@ -12,6 +12,7 @@ struct ath12k_wmi_p2p_noa_info;
 
 struct ath12k_p2p_noa_arg {
 	u32 vdev_id;
+	struct ath12k *ar;
 	const struct ath12k_wmi_p2p_noa_info *noa;
 };
 
-- 
2.25.1


