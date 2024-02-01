Return-Path: <linux-wireless+bounces-2925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD0E844FF9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 04:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396551F22F46
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 03:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E2D3B19E;
	Thu,  1 Feb 2024 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XfCHGdVL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546963A8C2
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759936; cv=none; b=MNpz2FEzhiH4itn9p6rkaAuVIrm75YthpfYRpPHfB/LstLMzRdEODZJVQ9BHaEyM3++DhTSp2/x5Fjb/XR1IyBln2Ck0LrwdYZXYm0tNOl9gL/+JTjvyGIGNNDhVSgPsMRqqcviaVYcvoQqu2IpOg6zoJRSCw7iQLcqd8i0tARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759936; c=relaxed/simple;
	bh=ueEsYXArIld1WhIX8cnp4yIp8bY01CSexNFj5624m7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S03yWU8zAGqyKP0RtUjKeA3BfcffwfUQHVdi3BMfkJKoE2bUnBi8wyCuBQbGhW1brxoZPn8SStGFYHSzPZbijlWALfyB9c74x9lRsDTx6D5TQKSpaF5ttuUGzPyy8tPx52FP68beFedUUEfCEsdhY0AqQwDQe/kpz6JoRPK/qNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XfCHGdVL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VM7qe1006534;
	Thu, 1 Feb 2024 03:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=TV6S+Sx
	UsgpOAXSrXJ9Tfvsz/WfGAW4yRzCgDGwN0Ps=; b=XfCHGdVL8Cjz/3vGlEplavT
	i5kXCF+8lLUG+I5bpEJKXLGkAYUGiuumWMQzWSWD5tlpxi6lv4KkNb9ENF7BEfhH
	ilICky1VrYYTjHbzHzFfYzwQt1quzwIdb6E0cuZDPnOdc7XsSezuaU6Yqyqr35I8
	o0hHezT68gPDONnpawZOg0tXCZJWhq0Sdg2TJtomanwQJ+vOR2x90fjUJy1wMUUf
	/o3hMY7EGyWD7DcV4KouTkYsOqzmV2nFDbiTL0xcG/ByceDL+Je4WQnWf9ixhiYO
	VQtHN6b2J3Gob659cW/hZ8R+85Dqpp34mrgOCJn7XzPP5Hnu145qep94jitQhlA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyq0dsxyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 03:58:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4113wgPO006396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 03:58:42 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 19:58:40 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: enable 802.11 power save mode in station mode
Date: Thu, 1 Feb 2024 11:58:30 +0800
Message-ID: <20240201035830.2534-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: xTp-VcRjQ2esePdtQ4ZaW7cyQkJOhDi1
X-Proofpoint-ORIG-GUID: xTp-VcRjQ2esePdtQ4ZaW7cyQkJOhDi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 mlxlogscore=709
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2402010030

To reduce power consumption enable 802.11 power save mode in
station mode. This allows both radio and CPU to sleep more.

Only enable the mode on WCN7850, other chips don't support it
for now.

To test that power save mode is running, run below command and
check there is no NULL Data frame seen by a sniffer:
        iw dev <inf> set power_save off

And run below command, then check there is a NULL Data frame
in sniffer:
        iw dev <inf> set power_save on

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/hw.c   |  8 +++-
 drivers/net/wireless/ath/ath12k/hw.h   |  4 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 54 ++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 5c6c1e2eddb6..6843ec91780d 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -264,6 +264,7 @@ struct ath12k_vif {
 	u8 tx_encap_type;
 	u8 vdev_stats_id;
 	u32 punct_bitmap;
+	bool ps;
 };
 
 struct ath12k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index cbb6e2b6d826..6070064a25c7 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/types.h>
@@ -917,6 +917,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.def_num_link = 0,
 		.max_mlo_peer = 256,
+
+		.supports_sta_ps = false,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -984,6 +986,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.def_num_link = 2,
 		.max_mlo_peer = 32,
+
+		.supports_sta_ps = true,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1049,6 +1053,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.def_num_link = 0,
 		.max_mlo_peer = 256,
+
+		.supports_sta_ps = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 0c3b416ae150..6a85ddbb34e4 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_HW_H
@@ -195,6 +195,8 @@ struct ath12k_hw_params {
 
 	u8 def_num_link;
 	u16 max_mlo_peer;
+
+	bool supports_sta_ps;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a27480a69b27..465480f52903 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2509,12 +2509,60 @@ static int ath12k_mac_fils_discovery(struct ath12k_vif *arvif,
 	return ret;
 }
 
+static void ath12k_mac_vif_setup_ps(struct ath12k_vif *arvif)
+{
+	struct ath12k *ar = arvif->ar;
+	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_conf *conf = &ath12k_ar_to_hw(ar)->conf;
+	enum wmi_sta_powersave_param param;
+	enum wmi_sta_ps_mode psmode;
+	int ret;
+	int timeout;
+	bool enable_ps;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	enable_ps = arvif->ps;
+	if (enable_ps) {
+		psmode = WMI_STA_PS_MODE_ENABLED;
+		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
+
+		timeout = conf->dynamic_ps_timeout;
+		if (timeout == 0) {
+			/* firmware doesn't like 0 */
+			timeout = ieee80211_tu_to_usec(vif->bss_conf.beacon_int) / 1000;
+		}
+
+		ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
+						  timeout);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
+				    arvif->vdev_id, ret);
+			return;
+		}
+	} else {
+		psmode = WMI_STA_PS_MODE_DISABLED;
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d psmode %s\n",
+		   arvif->vdev_id, psmode ? "enable" : "disable");
+
+	ret = ath12k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
+	if (ret)
+		ath12k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
+			    psmode, arvif->vdev_id, ret);
+}
+
 static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 					struct ath12k_vif *arvif,
 					struct ieee80211_bss_conf *info,
 					u64 changed)
 {
 	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_vif_cfg *vif_cfg = &vif->cfg;
 	struct cfg80211_chan_def def;
 	u32 param_id, param_value;
 	enum nl80211_band band;
@@ -2787,6 +2835,12 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 
 	if (changed & BSS_CHANGED_EHT_PUNCTURING)
 		arvif->punct_bitmap = info->eht_puncturing;
+
+	if (changed & BSS_CHANGED_PS &&
+	    ar->ab->hw_params->supports_sta_ps) {
+		arvif->ps = vif_cfg->ps;
+		ath12k_mac_vif_setup_ps(arvif);
+	}
 }
 
 static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,

base-commit: d4d13947306ab3c98c84389d9397563b550b71b8
-- 
2.25.1


