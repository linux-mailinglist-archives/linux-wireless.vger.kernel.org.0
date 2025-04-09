Return-Path: <linux-wireless+bounces-21293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF554A81AF9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 04:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4BD3B17B5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 02:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0327C1CDFCE;
	Wed,  9 Apr 2025 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F92APzmO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B0C1C5D7D;
	Wed,  9 Apr 2025 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165649; cv=none; b=jTITc89PWrtZ1w7RvOsN30zwHrfFJoUVSunt0GXBNyxd3rqrbLhirMpJ7dL221PPJIwrY7LcWiFipz18JdOMjocoHZRtzmQno7cz8hvlwJFWfX1aunQ5GEu9tfWkSrV/8+tmmXi8VzOokG3//TEYwtN/Yzi40HIrkjpnkEF4eD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165649; c=relaxed/simple;
	bh=S2pxjejGfz5Ktt2gEQIuDnhQlIdGdOJN+KVmVp4UlcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bCeAiHmWFiNKwb9foLr4mL08n0Vws4LBY8PHch3gdtxccHSSTyJ4kA7tWV3iBl4Y3YjHgd0EsgQT2j1ZE1i66G09yH5psWTvioMxAmGqIEsXcvE1Ji6iW2/MA2MSwuy2Ti3hULCyXIcYANCH18QwHChaJD4Ptt6ZJmEoy48TmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F92APzmO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYnaE004675;
	Wed, 9 Apr 2025 02:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K49ClcNJNOENscp7xtR/Zw7NBYHdUaiSNDgj+lzTJ1c=; b=F92APzmOcCqMMX6c
	tvzZL2PcnjBf2TS4oj2LO2pnkQRNE4mgBwUZNRqUXytXlxLkuH/c9G/Zb1I3Fqm6
	p1aU09AkhEKZcWVRSYJqTt+d3sFT4+vT82HA+z+2/y9buvEjJVHe0bDuNem5kdD+
	6ZsWb/EZnZrcvqDNJojzNDqgvdzQkFgmxg7Ki+OhpVAlV1CYLDrO93mdY+ZqbNXA
	FqMU3V+F4yWkTij0n5YNQQPye37EgxiIJMDC6D5IHk2bWJnjTPNR7abQmu0SUS5t
	M8GaWHNNkXb4e065ckX1HNX3rSZl08WNBtQ0PSFCtI/65lRtka5e/6U3QzOpv04W
	Ds4rsA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtb1vby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 02:27:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5392RLFL006654
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 02:27:21 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 19:27:19 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 9 Apr 2025 10:26:38 +0800
Subject: [PATCH ath-next v2 5/9] wifi: ath12k: make assoc link associate
 first
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250409-ath12k-wcn7850-mlo-support-v2-5-3801132ca2c3@quicinc.com>
References: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
In-Reply-To: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
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
X-Proofpoint-GUID: Q5iWOIK8QivH7yHxZc6I0lXZRV64jn5O
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f5db09 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EtMFwaiasCmdoeVE0uMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Q5iWOIK8QivH7yHxZc6I0lXZRV64jn5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090002

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
index 316df6e36c6bac00eef4d98a03c1335f5c0cca4a..699772a471f5f81c42009b529e756fa75bca0779 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3611,6 +3611,8 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
 	unsigned long links = ahvif->links_map;
 	struct ieee80211_bss_conf *info;
 	struct ath12k_link_vif *arvif;
+	struct ieee80211_sta *sta;
+	struct ath12k_sta *ahsta;
 	struct ath12k *ar;
 	u8 link_id;
 
@@ -3623,6 +3625,35 @@ static void ath12k_mac_op_vif_cfg_changed(struct ieee80211_hw *hw,
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


