Return-Path: <linux-wireless+bounces-17645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD73A14FA0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 13:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180C33A888A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA471FF1D5;
	Fri, 17 Jan 2025 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dryb+GA0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E451149DF4
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118003; cv=none; b=Doc2L/PECA2gN/b0xDbUD79gXU9BzNp0OwJR3nHO8v5bbI9hrOcwAtaUqlCDt410iJ/tt/c7ve9XRadzSutjxDcLcltLc/mZ2kCKe6AJObO8BDahVBMnS4tyjjvS2h4H7hzimrDy/yV2JIZR2lzHr0J2vPtyNNZue4e8wpLErJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118003; c=relaxed/simple;
	bh=Ye1pZfVacywLyoPb2Ms+nebg99S1LQIfIg61D1EVB7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAR8yzUd8E+dh3P4EAFS3UdiZWnlyKGSfoc2JcuK+CKr2FftBXsb0Da4BpOLHWzi10lC4LRMhmV57PRwOQf/sDKcRs8qlrBNMzB2gvdbfC2rer8WYW+6V/Ml13uB2+eCsSWQZfJf6R/7IYn+ztCE5XbpE0kwPTannQFBNGAagNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dryb+GA0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H97bCm017787;
	Fri, 17 Jan 2025 12:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Cyjmy5WWsNyQ77/lADJHC/7hS1O3R1jn3rFoNSKQ+U=; b=Dryb+GA0aPH4AxU1
	S5nhyuvLZeqDuUzFGn7sG/dT0K5MaSPqKrLNYS/H/f5YDXYb37ZOOTVeH814eKmY
	ZFhyZtzTC9Cy/FQR7uVBD2APpgAK1+rJOzvOajogf4jIk12C/SEt94add3GUwGgi
	wj8nfx9npd0fLgIfAs7GgT7GJycPalGHEgIOUumnjjPx1Gv0aOYBH+mmp7rXwost
	bFveeQZMFbXfEfHegMhrPf3n3lkMN3BjPB1CMteQ7AWM2UwXuixcI8307t/ZQH6K
	CiBcD6P1RTUbBKbT9+WvWXcsBFwz8zUPH8/lQ7cVU0hmgJQyQUCDr9pzUKoXp5Nj
	1gxSlg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447ma50j1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50HCkZia014113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:46:35 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 04:46:34 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH RFC v2 08/12] wifi: cfg80211: add flag to indicate driver supports ML station statistics
Date: Fri, 17 Jan 2025 18:15:50 +0530
Message-ID: <20250117124554.3719808-9-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
References: <20250117124554.3719808-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: rOBR94_xE7dsfL95kOVx8pUkzalTym2C
X-Proofpoint-ORIG-GUID: rOBR94_xE7dsfL95kOVx8pUkzalTym2C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=2 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170103

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
index ef4f7eb07763..8023b8943fa4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10670,6 +10670,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	 * once WIPHY_FLAG_SUPPORTS_MLO is enabled.
 	 */
 	wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
+	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS;
 
 	hw->queues = ATH12K_HW_MAX_QUEUES;
 	wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 21eafad17d4b..218ecf2b52d1 100644
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
@@ -5035,6 +5039,8 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY: support connection to non-primary link
  *	of an NSTR mobile AP MLD.
  * @WIPHY_FLAG_DISABLE_WEXT: disable wireless extensions for this device
+ * @WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS: The driver does not offload
+ *	link decisions and provide per-link statistics for MLO STA.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -5063,6 +5069,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
 	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
+	WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS = BIT(26),
 };
 
 /**
@@ -8476,7 +8483,7 @@ static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 {
 	int link_id;
 
-	if (sinfo->valid_links) {
+	if (sinfo->is_per_link_stats_support && sinfo->valid_links) {
 		for_each_valid_link(sinfo, link_id) {
 			kfree(sinfo->links[link_id]->pertid);
 			kfree(sinfo->links[link_id]);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 508bb7aff1f6..4c0235f01eba 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2846,6 +2846,8 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 
 	sinfo->generation = sdata->local->sta_generation;
 	sinfo->valid_links = sta->sta.valid_links;
+	sinfo->is_per_link_stats_support =
+		!!(sdata->local->hw.wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS);
 
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
 			 BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME) |
@@ -2882,7 +2884,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
 
-	if (sinfo->valid_links) {
+	if (sinfo->is_per_link_stats_support && sinfo->valid_links) {
 		memcpy(sinfo->mld_addr, sta->addr, ETH_ALEN);
 
 		for_each_valid_link(sinfo, link_id) {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2e9dee9c4ef7..ef589a7b3bdb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6882,7 +6882,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    &sinfo->sta_flags))
 		goto nla_put_failure;
 
-	if (sinfo->valid_links) {
+	if (sinfo->is_per_link_stats_support && sinfo->valid_links) {
 		/* TODO: Add accumulated stats for packets, bytes for
 		 *	 better representation at MLO level.
 		 */
-- 
2.34.1


