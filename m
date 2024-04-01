Return-Path: <linux-wireless+bounces-5728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABA5894538
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 21:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6991C21575
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D02953E20;
	Mon,  1 Apr 2024 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XYPWoWqm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9A453E01
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998322; cv=none; b=Y1MWUfiYWQ34sqm8SM4Ctr9+shvmSCk3do/eFr2ZgxmJkpBxjbwOxA/P8Fa6lIh/Rws2pRhCBdEq3/CxKVmEUT5xQIELqCf69VTc09fE7mxOgWeYWul6oEGlF6CJoEGiqG+mVC8W0ywnza1Gy27iiqG2kwcvvJOF7raZdz/iu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998322; c=relaxed/simple;
	bh=NJ8CrdjDqk+fkwmPDNeQ7wUjva8KmoAspB3xXZyiKZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUOkrqOI1SzHzS5dY4x8jL8XNTtEHFVaBw53PJ4EjrGwwDluz4YITkedF9sG2d3UZ6rnud9NOd/wVDfMEQ5DqqQ8Hd6pStKWwPyfYbNze8mi4IhfTTvH6z5rvGM11l5jEdBkt+YIXW8ZgE12kPuRuYxOo5SjLdG2qpAb5joNPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XYPWoWqm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431Gwu5x001427;
	Mon, 1 Apr 2024 19:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vVwvcKa92aaQ0Cc5SrkZw9UYZdbbGrZU2Ma6xGEiKzs=; b=XY
	PWoWqm2i4PBAJvOXsN7YN5DtVujnQhIHGWh0akGAHVa6uSmXV6LkNKXHzqWFm1fJ
	cfyo9hMMRukvauQZF5t9nR+n5jNhi7HOfdZEwiwWqINtgmZPtw27zP4f4VSRYVO+
	lS2DnElFbRmkI2GKYRiz4501e+9j5OwW9/wuVMQbNwIeY8sGuycVgpFGCUzI3OGR
	xWW4mvE6X65W+/zdLY3RyIM43f1AabTWLF8kvGYnMUFT5GypS4DWzfngBcq8bGwU
	D/xoGSZwZn9lFmQS8W/GOkO4FaGpJyxXGrTDfCdIWC8m5SG288jJJrDL6z3oILYi
	GVK5ZZvtvteWk5Ec/ETQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x80w5gb2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:05:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431J5FWb000659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 19:05:15 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Apr 2024 12:05:13 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v6 08/12] wifi: ath12k: Add additional checks for vif and sta iterators
Date: Tue, 2 Apr 2024 00:34:05 +0530
Message-ID: <20240401190409.2461819-9-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401190409.2461819-1-quic_ramess@quicinc.com>
References: <20240401190409.2461819-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: 7Um1bb3CMNTRMlikThj5lumYvZlcWrA0
X-Proofpoint-ORIG-GUID: 7Um1bb3CMNTRMlikThj5lumYvZlcWrA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_13,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=850
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010134

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
index dd6c474bd507..4d71267bbb60 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -291,6 +291,7 @@ struct ath12k_vif {
 
 struct ath12k_vif_iter {
 	u32 vdev_id;
+	struct ath12k *ar;
 	struct ath12k_vif *arvif;
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 3f2d1b00ae24..ec592504f926 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -533,7 +533,8 @@ static void ath12k_get_arvif_iter(void *data, u8 *mac,
 	struct ath12k_vif_iter *arvif_iter = data;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
-	if (arvif->vdev_id == arvif_iter->vdev_id)
+	if (arvif->vdev_id == arvif_iter->vdev_id &&
+	    arvif->ar == arvif_iter->ar)
 		arvif_iter->arvif = arvif;
 }
 
@@ -543,6 +544,7 @@ struct ath12k_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
 	u32 flags;
 
 	arvif_iter.vdev_id = vdev_id;
+	arvif_iter.ar = ar;
 
 	flags = IEEE80211_IFACE_ITER_RESUME_ALL;
 	ieee80211_iterate_active_interfaces_atomic(ath12k_ar_to_hw(ar),
@@ -6845,14 +6847,19 @@ struct ath12k_mac_change_chanctx_arg {
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
 
@@ -6863,9 +6870,13 @@ static void
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
@@ -6984,7 +6995,7 @@ static void
 ath12k_mac_update_active_vif_chan(struct ath12k *ar,
 				  struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k_mac_change_chanctx_arg arg = { .ctx = ctx };
+	struct ath12k_mac_change_chanctx_arg arg = { .ctx = ctx, .ar = ar };
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -7560,6 +7571,9 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 	struct ath12k *ar = arvif->ar;
 
+	if (arsta->arvif != arvif)
+		return;
+
 	spin_lock_bh(&ar->data_lock);
 	arsta->changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	spin_unlock_bh(&ar->data_lock);
@@ -7570,10 +7584,14 @@ static void ath12k_mac_set_bitrate_mask_iter(void *data,
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


