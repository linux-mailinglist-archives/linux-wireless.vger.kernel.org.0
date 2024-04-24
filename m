Return-Path: <linux-wireless+bounces-6754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4D68B0256
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 08:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964481F22F68
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 06:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3750A157489;
	Wed, 24 Apr 2024 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lAUFwekg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8F157E74
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940843; cv=none; b=irub/8A5T2ky2g9rKQif5rm0I7A5wv8vNHCMDO1B5PUWj+s//IyGPhSqFuQkbJ5L4h/0jqLr+D1BWD7rpJUX3jxdnKcMY9wHXhqTZQx31Q+Rq5dqMeeZMJK/D440G3YJ8mTR3JzqaIhpSxYYVUB0yMsdCmWSG+pCgJ58uGL3nfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940843; c=relaxed/simple;
	bh=2E3DXGLsdDE+3s7sHNCuWVLvInjw51+NEol3nuP8AOY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pECALRbW35npT1Ur3o72bQsTnq0yrbQYpF8fzYtNXUx4yIrOkMIYnU52Ww/VNQ+Es3UlOjsBSZ76OPCv0OsiENwxtqYLMQCNUblazHR/7aoidIFCvxcLQ2b0MzYV3M9tjwwLChP1GkYunSa2u2LQpdvXXmZeJPAiga1cQ3ro/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lAUFwekg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6X8ig026957;
	Wed, 24 Apr 2024 06:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=uLpixUn
	7RJFTBrbvGL1PC0hi1XN0K5AWYQA3NCBGJB8=; b=lAUFwekgMPrTyYVESSUV90y
	S6O7CbgCjn9FNNlAV658lSCLqi+jhGvtht2gIqv/Ey/21h7mliznKhALDbVOgVI8
	Y7l2K99ff5CWzYRRgG3e7opo63KsjuWgczqS4+TkGjmBcTX5gvHP6YJAcbbMyq0m
	jizLUKjjJPt8/i5qktMK8uWVTwDJahQ0bkppDzR3gdW6P22vaWcY0Z5jpEdOehve
	zuu+oQOVt2JYnHmwAhKpvXiBJ/oirl17Pvh9MVjbOPkHPnKRUQ4LzAtpDn4k1hV4
	kvu0JpwSTH6xIJYY0PQFljsyaW4li9Y3mAC5eiwpiSWmXAPrGsqIEZ2oPEKuy+Q=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9dg351-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 06:40:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O6eUDP011782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 06:40:30 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 23:40:28 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2] wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP
Date: Wed, 24 Apr 2024 14:40:19 +0800
Message-ID: <20240424064019.4847-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: 3oWTPK9R37IIWQc3oW3pMyjst5fJm6aC
X-Proofpoint-ORIG-GUID: 3oWTPK9R37IIWQc3oW3pMyjst5fJm6aC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_04,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404240028

With commit bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
ath11k fails to connect to 6 GHz AP.

This is because currently ath11k checks AP's power type in
ath11k_mac_op_assign_vif_chanctx() which would be called in AUTH stage.
However with above commit power type is not available until ASSOC stage.
As a result power type check fails and therefore connection fails.

Fix this by moving power type check to ASSOC stage, also move regulatory
rules update there because it depends on power type.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
 - add check on 'arvif->chanctx.def.chan' in ath11k_mac_op_sta_state()
   to avoid NULL pointer dereference.
 - add 'Fixes:' tag.

 drivers/net/wireless/ath/ath11k/mac.c | 38 ++++++++++++++++++---------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3202e36f9663..69ad38e0efe0 100644
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
 
@@ -9705,6 +9694,29 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 				ath11k_warn(ar->ab, "Unable to authorize peer %pM vdev %d: %d\n",
 					    sta->addr, arvif->vdev_id, ret);
 		}
+
+		if (!ret &&
+		    ath11k_wmi_supports_6ghz_cc_ext(ar) &&
+		    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+		    arvif->chanctx.def.chan &&
+		    arvif->chanctx.def.chan->band == NL80211_BAND_6GHZ) {
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

base-commit: 1b61047b44218a00c7a7836eff4f8e037d5634d8
-- 
2.25.1


