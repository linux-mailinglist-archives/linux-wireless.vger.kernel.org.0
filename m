Return-Path: <linux-wireless+bounces-21051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4D6A78693
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 04:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C8216E8EC
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC113C3CD;
	Wed,  2 Apr 2025 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m+q6hhwx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3B1917E4;
	Wed,  2 Apr 2025 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562008; cv=none; b=P3Og7D8xOC2XCo6dwtho/JSqqMQaSjGlz+rWFNvfgneyswSfUVlrEyhcqu2Y49dYcJKmT2DaVgZm3yezw+UF55rhzvgIG16gt4GU+o8aLGIRWjrG5IqliLazEx14G4mL8Y12hdfO458KJz3Unw+s9O7DciztX6atHy9guCCtHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562008; c=relaxed/simple;
	bh=wnwxBoN/KiwOkmZu+bE4FBIBOsQd1mK67XVkOGXn/PQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N0zAg03Xb+tASwgvAzn+WTmIsi/w5aMwsheJaYCSLZ1bi0XoIOILTKEH2Yccug1gYEnojcx4j2bOj8rccyVx2O28FBohrWoBNs7MFtQwUdKG+B3+3koUlvlXZz1N6aweabzmqb3azX21wrvI+iYRaJCXVk6EMvkQDcSNezrDFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m+q6hhwx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5320eHWN002319;
	Wed, 2 Apr 2025 02:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tuQYrFnIlrtJqztUlS4Q2t3UF423R0fluCYgPEz7v7I=; b=m+q6hhwxSQMCQTav
	SBpN4kN0Qavbzzfzt8coY+xLGDRvUMv8AS/FTkWpVYmLElZi0IbOTuOqa79cIy6C
	CkQzBGbrZkk+I63Tf84yMMCzdmmyQUFYyvgdhEc5u31EgD6qYQuyX+7fe+cRXYUc
	T3GpITzcqcFWvyXV1HJFlSn8UQKAJu0q8YAWKdcfDmislJ55LlmHzPPP68Qy7hj5
	QhFe6ni9+TpOMSI3dzIuFPxWx9TaJ5DcIURmP47Rl7R/N1/MUk9HVoXLscIprRfN
	bCKqXDU92yqYEh7WFr8bDFQ4KcOlwNoRc4Ib8vKTc1qj86vZi2snmZVasmgW3AOI
	cq6umA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45pa5bsu37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 02:46:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5322kMHw014608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 02:46:22 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 19:46:20 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 2 Apr 2025 10:45:44 +0800
Subject: [PATCH ath-next 5/9] wifi: ath12k: make assoc link associate first
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250402-ath12k-wcn7850-mlo-support-v1-5-bad47cf00704@quicinc.com>
References: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
In-Reply-To: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O7p9DuWCYvbjFxRE4yiCIw1IamdQfwv6
X-Authority-Analysis: v=2.4 cv=YqcPR5YX c=1 sm=1 tr=0 ts=67eca4ff cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=2gi8f_Aax1DoEzWgb_cA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: O7p9DuWCYvbjFxRE4yiCIw1IamdQfwv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020017

In MLO scenario WCN7850 firmware requests the assoc link to associate
before any other links. However currently in
ath12k_mac_op_vif_cfg_changed() we are doing association in an ascending
order of link id. If the assoc link does not get assigned the smallest
id, a non-assoc link gets associated first and firmware crashes.

Change to do association for the assoc link first.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2239d5a25ffef13e5e58653355148acb32b20af8..d1695432168bb3db054f0c65797a2d32413034ad 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3598,6 +3598,8 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 	unsigned long links = ahvif->links_map;
 	struct ieee80211_bss_conf *info;
 	struct ath12k_link_vif *arvif;
+	struct ieee80211_sta *sta;
+	struct ath12k_sta *ahsta;
 	struct ath12k *ar;
 	u8 link_id;
 
@@ -3610,6 +3612,35 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ASSOC) {
+		if (vif->cfg.assoc) {
+			/* only in station mode we can get here, so it's safe
+			 * to use ap_addr
+			 */
+			rcu_read_lock();
+			sta = ieee80211_find_sta(vif, vif->cfg.ap_addr);
+			if (!sta) {
+				rcu_read_unlock();
+				WARN_ONCE(1, "failed to find sta with addr %pM\n",
+					  vif->cfg.ap_addr);
+				return;
+			}
+
+			ahsta = ath12k_sta_to_ahsta(sta);
+			arvif = wiphy_dereference(hw->wiphy,
+						  ahvif->link[ahsta->assoc_link_id]);
+			rcu_read_unlock();
+
+			ar = arvif->ar;
+			/* there is no reason for which an assoc link's
+			 * bss info does not exist
+			 */
+			info = ath12k_mac_get_link_bss_conf(arvif);
+			ath12k_bss_assoc(ar, arvif, info);
+
+			/* exclude assoc link as it is done above */
+			links &= ~BIT(ahsta->assoc_link_id);
+		}
+
 		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
 			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
 			if (!arvif || !arvif->ar)

-- 
2.25.1


