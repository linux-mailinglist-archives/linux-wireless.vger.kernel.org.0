Return-Path: <linux-wireless+bounces-6590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D358AB897
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 03:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53BF1F22298
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 01:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3761F205E1A;
	Sat, 20 Apr 2024 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mj3sLOnl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C517A40
	for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 01:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713578225; cv=none; b=GiRFzv/+QzIkRvLccXtS9xAvLp5B7kUD0igijaeDBFAwsGGdiPXUQ/Xl9Z3FlB32Xo0oTry1GODVISh6+n+PPTeauMJChUjZ5qnBaflXSquWdy6zGLPjNkInv1V1Nl7FUQuDyWQ7B6I2VvkUkOkMRANtjH3iHu180ScRPLqYMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713578225; c=relaxed/simple;
	bh=lGju/sK08kFtnoZWKvr/G4zNqI3wlZFwdFGl292cn+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iuCL8ZcgUjMzvDX5rNAMFf59ZjReBq3PaX59Nc7R+w720h4k/PA1nbvXBr3gI38x4Fb1OhBmIpqecm3QLgW5odfSvzc6lNPGviArn8dZPTO5nHBWXJO9mA6o36yP34Bp5jHDc5sQe2X2wtq3QD3URR3epL/gfYF9xqeCxz9Z3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mj3sLOnl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43K1um0S003176;
	Sat, 20 Apr 2024 01:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=vbT2XWd
	+8Gx2QNSgM1ZjxhaOFBdW/ebOTlvOXn2PuZ0=; b=Mj3sLOnlBf2N0Pl2vW+WKJ8
	Syf7q4sr0EPrBu3aQK+CjKrscSXh/iIfeWWC6kigMx9NpyduBgfJdlwTM+K4stre
	pZWG6e7odTWZrP353jBleBbgVfOYa5NSD8H12nUs97BLXUwfaGcZi62NPdK0IX/h
	qxRjNPQSxn3U4zKgQifB6d3obdu79q9bKo7QbiN8gUJkyIc2Gdr9unACC/H1UMy6
	TBpuZqvm68cwyZrQXPH7sDyWBhO5oMkGsrlhtWT2a6VFHhy8sGxwC4MEJ3lKNBzJ
	lhPoYSQ7uTXIPay77TG4E3jfwuiO7VHg65s4oPwSnKDDHmzIao5tGA3mwMTYEQQ=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm3uj81rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 01:56:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43K1uuF2022354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 01:56:56 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 18:56:54 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP
Date: Sat, 20 Apr 2024 09:56:32 +0800
Message-ID: <20240420015632.2869-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: u7MZA_Shh3Id-3ufElH86P76beMIAtcG
X-Proofpoint-GUID: u7MZA_Shh3Id-3ufElH86P76beMIAtcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_17,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200004

With commit bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
ath11k fails to connect to 6 GHz AP.

This is because currently ath11k checks AP's power type in
ath11k_mac_op_assign_vif_chanctx() which would be called in AUTH stage.
However with above commit power type is not available until ASSOC stage.
As a result power type check fails and therefore connection fails.

Fix this by moving power type check to ASSOC stage, also move regulatory
rules update there because it depends on power type.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 37 +++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3202e36f9663..8a0cd43b4f2b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7988,8 +7988,6 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	int ret;
-	struct cur_regulatory_info *reg_info;
-	enum ieee80211_ap_reg_power power_type;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -8000,17 +7998,6 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	if (ath11k_wmi_supports_6ghz_cc_ext(ar) &&
 	    ctx->def.chan->band == NL80211_BAND_6GHZ &&
 	    arvif->vdev_type == WMI_VDEV_TYPE_STA) {
-		reg_info = &ab->reg_info_store[ar->pdev_idx];
-		power_type = vif->bss_conf.power_type;
-
-		ath11k_dbg(ab, ATH11K_DBG_MAC, "chanctx power type %d\n", power_type);
-
-		if (power_type == IEEE80211_REG_UNSET_AP) {
-			ret = -EINVAL;
-			goto out;
-		}
-
-		ath11k_reg_handle_chan_list(ab, reg_info, power_type);
 		arvif->chanctx = *ctx;
 		ath11k_mac_parse_tx_pwr_env(ar, vif, ctx);
 	}
@@ -9626,6 +9613,8 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(sta);
+	enum ieee80211_ap_reg_power power_type;
+	struct cur_regulatory_info *reg_info;
 	struct ath11k_peer *peer;
 	int ret = 0;
 
@@ -9705,6 +9694,28 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 				ath11k_warn(ar->ab, "Unable to authorize peer %pM vdev %d: %d\n",
 					    sta->addr, arvif->vdev_id, ret);
 		}
+
+		if (!ret &&
+		    ath11k_wmi_supports_6ghz_cc_ext(ar) &&
+		    arvif->chanctx.def.chan->band == NL80211_BAND_6GHZ &&
+		    arvif->vdev_type == WMI_VDEV_TYPE_STA) {
+			reg_info = &ar->ab->reg_info_store[ar->pdev_idx];
+			power_type = vif->bss_conf.power_type;
+
+			if (power_type == IEEE80211_REG_UNSET_AP) {
+				ath11k_warn(ar->ab, "invalid power type %d\n",
+					    power_type);
+				ret = -EINVAL;
+			} else {
+				ret = ath11k_reg_handle_chan_list(ar->ab,
+								  reg_info,
+								  power_type);
+				if (ret)
+					ath11k_warn(ar->ab,
+						    "failed to handle chan list with power type %d\n",
+						    power_type);
+			}
+		}
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
 		spin_lock_bh(&ar->ab->base_lock);

base-commit: c416602943dd36fbd13af7496430723935c867a3
-- 
2.25.1


