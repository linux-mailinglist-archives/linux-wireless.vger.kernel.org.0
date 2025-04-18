Return-Path: <linux-wireless+bounces-21703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EABA9303D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 04:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22087A48C4
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8881F267F61;
	Fri, 18 Apr 2025 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eiwEJ3WB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4526A0B0;
	Fri, 18 Apr 2025 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944982; cv=none; b=lAaNfR6V7mn/bIjEj0rSofB4KL0iyw5nATQtBvnl+L+yBM6t0KI8Scj1UeW6VF9zhYmGG3tAjmjINCvF5YNUxP0BDGr7Ud3AaLM33hm6gUz6HQ1Sec089AuWUDB+q9vLPHyFAmy+lYStzT6u4DM0pBvxatRkIr8CGFaxekGIlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944982; c=relaxed/simple;
	bh=lCKwNfAou23rO492AoM6QEqugwY/2B+XN18V7dsRlEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=u7lW/ZFJ1n1yBPXrkuZ7Zgb5b/cKZYCYdU6QHPpWIyY9KJ9DdjVzWYJa7cw8A4dr7/C/0ScDM6LSOS0CrAveuTsRQsBLKMBPBKhgBnGAxGde0Yi5v2kQXgisQh3reHdTQ55AV7wKXwNh7uVa5H8T4YOHXs/Fsu2biEFLxpkmyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eiwEJ3WB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I20j5O013024;
	Fri, 18 Apr 2025 02:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T4vlO5ZTex8CtlS1NhJU4t/IWK2cco/c9UXFcaOXEbI=; b=eiwEJ3WBZh45ggZF
	I5KPeSdnba4D6euubvvk7VgAiC70ts1uxRET92PaG3wiwiqoN5Gci+ig8BTShJlN
	gEdmHktE4pN2BFILqJi1bbSEWkW5/foIKDKvWEXwdC3JvFUsdnjowoQ7QaW2WgZA
	nHhSSDgsmWMKIP9hF8G89ZCb1+TgBtXvQg3F5/pHMfPlwjowPCGXV2z/rd2YQ/Zn
	lB84eNp5fgROCovtANc7Raq/zlzXaC3i3NzWFI/J8v3wW+jfHp7b/immAqNLlLW8
	kjL0cJqEdfn9rdZ7j/+z5BIhZS9uBpMvFP1GbPyA3oRIUxrjB9O8lMuZQmsixz45
	SXJv+A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjrpq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2uBOn002829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:11 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:56:10 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 18 Apr 2025 10:55:42 +0800
Subject: [PATCH ath-next 09/15] wifi: ath12k: update regulatory rules when
 connection established
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-9-c869c86cad60@quicinc.com>
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uaaQ-ffSbJ8zFPYI0t2Z8QWcqHVG5Cff
X-Proofpoint-ORIG-GUID: uaaQ-ffSbJ8zFPYI0t2Z8QWcqHVG5Cff
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=6801bf4c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=W8zyP7hdZROLGDgUGToA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

Once connection to AP established we know the exact power type, it is time
to update regulatory rules based on such info.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 90734136528b55983bdcd56c447c818b889e9404..4d59572ff207dd084b32bff51fa973e525f2aa70 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5765,12 +5765,15 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 					    enum ieee80211_sta_state new_state)
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	struct ieee80211_bss_conf *link_conf;
 	struct ath12k *ar = arvif->ar;
+	struct ath12k_reg_info *reg_info;
+	struct ath12k_base *ab = ar->ab;
 	int ret = 0;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac handle link %u sta %pM state %d -> %d\n",
+	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac handle link %u sta %pM state %d -> %d\n",
 		   arsta->link_id, arsta->addr, old_state, new_state);
 
 	/* IEEE80211_STA_NONE -> IEEE80211_STA_NOTEXIST: Remove the station
@@ -5780,7 +5783,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 	     new_state == IEEE80211_STA_NOTEXIST)) {
 		ret = ath12k_mac_station_remove(ar, arvif, arsta);
 		if (ret) {
-			ath12k_warn(ar->ab, "Failed to remove station: %pM for VDEV: %d\n",
+			ath12k_warn(ab, "Failed to remove station: %pM for VDEV: %d\n",
 				    arsta->addr, arvif->vdev_id);
 			goto exit;
 		}
@@ -5791,7 +5794,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 	    new_state == IEEE80211_STA_NONE) {
 		ret = ath12k_mac_station_add(ar, arvif, arsta);
 		if (ret)
-			ath12k_warn(ar->ab, "Failed to add station: %pM for VDEV: %d\n",
+			ath12k_warn(ab, "Failed to add station: %pM for VDEV: %d\n",
 				    arsta->addr, arvif->vdev_id);
 
 	/* IEEE80211_STA_AUTH -> IEEE80211_STA_ASSOC: Send station assoc command for
@@ -5804,7 +5807,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 		    vif->type == NL80211_IFTYPE_ADHOC)) {
 		ret = ath12k_mac_station_assoc(ar, arvif, arsta, false);
 		if (ret)
-			ath12k_warn(ar->ab, "Failed to associate station: %pM\n",
+			ath12k_warn(ab, "Failed to associate station: %pM\n",
 				    arsta->addr);
 
 	/* IEEE80211_STA_ASSOC -> IEEE80211_STA_AUTHORIZED: set peer status as
@@ -5813,9 +5816,20 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTHORIZED) {
 		ret = ath12k_mac_station_authorize(ar, arvif, arsta);
-		if (ret)
-			ath12k_warn(ar->ab, "Failed to authorize station: %pM\n",
+		if (ret) {
+			ath12k_warn(ab, "Failed to authorize station: %pM\n",
 				    arsta->addr);
+			goto exit;
+		}
+
+		if (ath12k_wmi_supports_6ghz_cc_ext(ar) &&
+		    arvif->ahvif->vdev_type == WMI_VDEV_TYPE_STA) {
+			link_conf = ath12k_mac_get_link_bss_conf(arvif);
+			reg_info = ab->reg_info[ar->pdev_idx];
+			ath12k_dbg(ab, ATH12K_DBG_MAC, "connection done, update reg rules\n");
+			ath12k_reg_handle_chan_list(ab, reg_info, arvif->ahvif->vdev_type,
+						    link_conf->power_type);
+		}
 
 	/* IEEE80211_STA_AUTHORIZED -> IEEE80211_STA_ASSOC: station may be in removal,
 	 * deauthorize it.
@@ -5834,7 +5848,7 @@ static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
 		    vif->type == NL80211_IFTYPE_ADHOC)) {
 		ret = ath12k_mac_station_disassoc(ar, arvif, arsta);
 		if (ret)
-			ath12k_warn(ar->ab, "Failed to disassociate station: %pM\n",
+			ath12k_warn(ab, "Failed to disassociate station: %pM\n",
 				    arsta->addr);
 	}
 

-- 
2.34.1


