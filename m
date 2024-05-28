Return-Path: <linux-wireless+bounces-8168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B3A8D1638
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C73A1F229B3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9170D13C3CC;
	Tue, 28 May 2024 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V3M//1NC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC013B5B9
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884883; cv=none; b=h4PyCv1uDU5ndF9zQQFJkLWyQqRHekxvEgX4rGrwyCsOn/vYIyYM3zGbpiYYgw1t7ATKHH76msAJp+4NFBBRVRHuZqpehET2+5XyAZg446XFz8E+ON95LFdCcIVkVw2taj8x4uL1f26vAQnKSpzl67t3prvOZbC3ywgl8p03Ejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884883; c=relaxed/simple;
	bh=7q+1wmB8VVH7Q/kfmtljhZpI+QNePfmT3XJjHEeWXyI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eIzAQUZwmdaXBsvRf76GM2990uDDINDJkx2nAh3TV5xEMxaVJz9vqF/ROgp47LOyohJj8l0dMTYWXK2XhSY8fpldqhgghFYoWbF3zR/mFQUMVGrSsrQAeA0EVBccp7L0Tlsy2/C/yuGUJz6mGKKzwJnOLrpWyQIzzAWMYoYtr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V3M//1NC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RMxZMA022352;
	Tue, 28 May 2024 08:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GkDBccU+jna43xxCUW4fE+
	BQ2WxpVck9QUzwrnWS30Y=; b=V3M//1NCMOCW39HX9nNOSHXKgbBpd7n1jkIapj
	ogGAvqCP4umkUUcj0LBBU9VB9jft1sPMaVvpqmJEtzQ3cyO2YSUyp6y06HXjiLim
	PUkHiABf/H4VIBPZuuV3B91oxZGabqql1r3ptW+YMWYPKKrf4st+pdAKU7vBUKSt
	WsTy9HV9kX3hWJ1zLBu+QNyITcg5YFPfLV/PfOQ/iBOYWGsqREAJduqEZ15/iZVf
	JzDmPUMKI7sZxNSZUbC3LgS0CckrIiEhLBMn6/Csek0A1xuVrQ+hz5eLggso1Ft1
	yblKLJWRs79w14VB70N12QIf3hXfShe6L6sikCaMEf9dAZqA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h5gw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 08:27:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44S8Rs3D011801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 08:27:54 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 01:27:52 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH] wifi: ath12k: modify remain on channel for single wiphy
Date: Tue, 28 May 2024 13:57:39 +0530
Message-ID: <20240528082739.1226758-1-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: tzsZbqj2MHW-2dbPUpt5Il-dFn7rY6mr
X-Proofpoint-ORIG-GUID: tzsZbqj2MHW-2dbPUpt5Il-dFn7rY6mr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_05,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280061

When multiple radios are advertised as a single wiphy which
supports various bands, vdev creation for the vif is deferred
until channel is assigned to it.
If a remain on channel(RoC) request is received from mac80211,
select the corresponding radio(ar) based on channel and create
a vdev on that radio to initiate an RoC scan.

Note that on RoC completion this vdev is not deleted. If a new
RoC/hw scan request is seen on that same vif for a different band the
vdev will be deleted and created on the new radio supporting the
request.

Also if the RoC scan is requested when the vdev is in started state,
no switching to new radio is allowed and RoC request can be accepted
only on channels within same radio.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 63 ++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 784964ae03ec..3668186d0926 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3372,7 +3372,7 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 static struct ath12k*
 ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
-			      struct ieee80211_scan_request *req)
+			      u32 center_freq)
 {
 	struct ath12k_hw *ah = hw->priv;
 	enum nl80211_band band;
@@ -3389,9 +3389,9 @@ ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
 	 * split the hw request and perform multiple scans
 	 */
 
-	if (req->req.channels[0]->center_freq < ATH12K_MIN_5G_FREQ)
+	if (center_freq < ATH12K_MIN_5G_FREQ)
 		band = NL80211_BAND_2GHZ;
-	else if (req->req.channels[0]->center_freq < ATH12K_MIN_6G_FREQ)
+	else if (center_freq < ATH12K_MIN_6G_FREQ)
 		band = NL80211_BAND_5GHZ;
 	else
 		band = NL80211_BAND_6GHZ;
@@ -3591,7 +3591,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	/* Since the targeted scan device could depend on the frequency
 	 * requested in the hw_req, select the corresponding radio
 	 */
-	ar = ath12k_mac_select_scan_device(hw, vif, hw_req);
+	ar = ath12k_mac_select_scan_device(hw, vif, hw_req->req.channels[0]->center_freq);
 	if (!ar)
 		return -EINVAL;
 
@@ -8416,12 +8416,63 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k_wmi_scan_req_arg arg;
-	struct ath12k *ar;
+	struct ath12k *ar, *prev_ar;
 	u32 scan_time_msec;
+	bool create = true;
 	int ret;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	if (ah->num_radio == 1) {
+		WARN_ON(!arvif->is_created);
+		ar = ath12k_ah_to_ar(ah, 0);
+		goto scan;
+	}
+
+	ar = ath12k_mac_select_scan_device(hw, vif, chan->center_freq);
+	if (!ar)
+		return -EINVAL;
+
+	/* If the vif is already assigned to a specific vdev of an ar,
+	 * check whether its already started, vdev which is started
+	 * are not allowed to switch to a new radio.
+	 * If the vdev is not started, but was earlier created on a
+	 * different ar, delete that vdev and create a new one. We don't
+	 * delete at the scan stop as an optimization to avoid redundant
+	 * delete-create vdev's for the same ar, in case the request is
+	 * always on the same band for the vif
+	 */
+	if (arvif->is_created) {
+		if (WARN_ON(!arvif->ar))
+			return -EINVAL;
+
+		if (ar != arvif->ar && arvif->is_started)
+			return -EINVAL;
 
+		if (ar != arvif->ar) {
+			/* backup the previously used ar ptr, since the vdev delete
+			 * would assign the arvif->ar to NULL after the call
+			 */
+			prev_ar = arvif->ar;
+			mutex_lock(&prev_ar->conf_mutex);
+			ret = ath12k_mac_vdev_delete(prev_ar, vif);
+			mutex_unlock(&prev_ar->conf_mutex);
+			if (ret)
+				ath12k_warn(prev_ar->ab,
+					    "unable to delete scan vdev %d\n", ret);
+		} else {
+			create = false;
+		}
+	}
+
+	if (create) {
+		mutex_lock(&ar->conf_mutex);
+		ret = ath12k_mac_vdev_create(ar, vif);
+		mutex_unlock(&ar->conf_mutex);
+		if (ret) {
+			ath12k_warn(ar->ab, "unable to create scan vdev %d\n", ret);
+			return -EINVAL;
+		}
+	}
+scan:
 	mutex_lock(&ar->conf_mutex);
 	spin_lock_bh(&ar->data_lock);
 

base-commit: f8320064a28242448eeb9fece08abd865ea8a226
-- 
2.25.1


