Return-Path: <linux-wireless+bounces-18933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D9A34B90
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0F416204D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF9221575;
	Thu, 13 Feb 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HycCiZeo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D02045BD
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467055; cv=none; b=jsp0dSzBjy7fet7XTL20qT73bl4X4m4ViPnO8jEg2gwq5WDVUbULhAurRl4l7rhMt2JF5JG48lf7/Ku2g3T24p4MjC2zfQ1c25VojuO2U75znAlU6LqFKHv/LwUkLk75z6ZkYdJ9Fb+hQBQ6WGLGYn31H8LLL5YB5Zs1TozcVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467055; c=relaxed/simple;
	bh=oQWgt4oUl5aA4fLRdDnGb/pVIJTC3YWmTe0J50QIUY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4hX/7mSFvCYPThW/m/DrZpsuk3qj1qjBph5ghNWHCVXksGOpr1XzXdfxD25d9nRSqHddWt9yPGegowyqKm5YlPMwbAAxuH7C4ilCpTkCiHht4RHfLItA7/RTdu1oFOWxpNebFzC9Lii1tYqJBUXosn+SNe+ZnPpV+UDiuw//Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HycCiZeo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DA2T2T002672;
	Thu, 13 Feb 2025 17:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	doNGXOtworPWqNThpwZb166Zp7vEEFOlEnpy8F2P3lo=; b=HycCiZeoruAKMc6I
	edgfQg8+Hx5Hi/gdQ7f1WN3M33nuuRVsp1nQasZYhqYrsQLW2lrmX7Nnnt/VfYrO
	cx3bfAQe2/PGyZ+FOTSS91Dkq2EbLGSWn2AzFlJRl69DViLb3E3DHxRz02BmmQ/c
	pD9Gu6ejxQJDUEdwWwQZ0y8bY8l70PfAsJmkM8/5pFBa9yVgjYJS6RIkY02rbphf
	oSnZTT9gY7sKsUz/yvK1Od4DZDIfxHWebKiJqbN8kJkfhSDHH5tOsCbM0dvh+AQY
	1TohIrvK0TtfVn0D6OekHnUYqbDZdxoOepf7TTOfy5Xdu9z8lR346lnRTeT+ravb
	joztBA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44semp944s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:29 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DHHTid011893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 17:17:29 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Feb 2025 09:17:27 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH v3 08/12] wifi: cfg80211: add flag to indicate driver supports ML station statistics
Date: Thu, 13 Feb 2025 22:46:28 +0530
Message-ID: <20250213171632.1646538-9-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JqtPjh6O8fP70vhGhxy9su5GwhIl1vBU
X-Proofpoint-GUID: JqtPjh6O8fP70vhGhxy9su5GwhIl1vBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130123

Currently, while filling the link level station statistics, valid_links
is checked. There might be the case when driver offload link station
statistics and does not provide per-link statistics.

Hence, add flag WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS in wiphy
structure to indicate that driver supports per link station statistics.
Set this flag during hw_register if driver supports per-link station
statistics and check this flag while filling the station_info structure
for MLO.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 1 +
 include/net/cfg80211.h                | 9 ++++++++-
 net/mac80211/sta_info.c               | 4 +++-
 net/wireless/nl80211.c                | 2 +-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 82fc1a5d71e8..7767971ae4c8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10942,6 +10942,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	 * once WIPHY_FLAG_SUPPORTS_MLO is enabled.
 	 */
 	wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
+	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS;
 
 	/* Copy over MLO related capabilities received from
 	 * WMI_SERVICE_READY_EXT2_EVENT if single_chip_mlo_supp is set.
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e07eb657fdfe..eb0fba002776 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2158,6 +2158,9 @@ struct link_station_info {
  * @local_pm: local mesh STA power save mode
  * @peer_pm: peer mesh STA power save mode
  * @nonpeer_pm: non-peer mesh STA power save mode
+ * @is_per_link_stats_support: 0- for non-ML STA and for ML STA,if driver
+ *	offload link decisions and do not provide per-link statistics.
+ *	1- if driver provides per-link statistics.
  * @assoc_link_id: Indicates MLO link ID of the AP, with which the station
  *	completed (re)association. This information filled for both MLO
  *	and non-MLO STA connections when the AP affiliated with an MLD.
@@ -2201,6 +2204,7 @@ struct station_info {
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
+	bool is_per_link_stats_support;
 	u8 assoc_link_id;
 	u8 mld_addr[ETH_ALEN] __aligned(2);
 	const u8 *assoc_resp_ies;
@@ -5062,6 +5066,8 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY: support connection to non-primary link
  *	of an NSTR mobile AP MLD.
  * @WIPHY_FLAG_DISABLE_WEXT: disable wireless extensions for this device
+ * @WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS: The driver does not offload
+ *	link decisions and provide per-link statistics for MLO STA.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -5090,6 +5096,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
 	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
+	WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS = BIT(26),
 };
 
 /**
@@ -8503,7 +8510,7 @@ static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
 	int link_id;
 
-	if (sinfo->valid_links) {
+	if (sinfo->is_per_link_stats_support && sinfo->valid_links) {
 		for_each_valid_link(sinfo, link_id) {
 			if (sinfo->links[link_id]) {
 				kfree(sinfo->links[link_id]->pertid);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 1bfe1a55888d..694ba84ec778 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2867,6 +2867,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 
 	sinfo->generation = sdata->local->sta_generation;
 	sinfo->valid_links = sta->sta.valid_links;
+	sinfo->is_per_link_stats_support =
+		!!(sdata->local->hw.wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS);
 
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
 			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
@@ -2903,7 +2905,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
-	if (sinfo->valid_links) {
+	if (sinfo->is_per_link_stats_support && sinfo->valid_links) {
 		memcpy(sinfo->mld_addr, sta->addr, ETH_ALEN);
 
 		for_each_valid_link(sinfo, link_id) {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3527cea4e071..7c68c5f87f9d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6906,7 +6906,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    &sinfo->sta_flags))
 		goto nla_put_failure;
 
-	if (sinfo->valid_links) {
+	if (sinfo->is_per_link_stats_support && sinfo->valid_links) {
 		/* TODO: Add accumulated stats for packets, bytes for
 		 *	 better representation at MLO level.
 		 */
-- 
2.34.1


