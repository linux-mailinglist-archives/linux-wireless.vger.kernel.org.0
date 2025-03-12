Return-Path: <linux-wireless+bounces-20210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11CCA5D69D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 07:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B81178019
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145611E5B71;
	Wed, 12 Mar 2025 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IMPuklV/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2415853B
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762339; cv=none; b=jwB+W2xVXcE+/Qw4J4GYuzrO70Uhy7X/qLGzLN4oXBDRRny7LyPelxicO1Esm2yt2NCNLy2HVZtG0+64xjh8XLjx80SuSZvtktK5omHm9TnvtgII11/W6Vp6Z70T5vKd8ZXrMiLwDGqrH8J48PEq5P3DbN4VEYp8GuqrDXKPXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762339; c=relaxed/simple;
	bh=I/aX5BO3KYVQ1mg1743VJH+CXUpgHr1WY0w32sHeVrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjK6SjzyXfVlinpvNhVDM+3GgaZq/F0TrtTmibEiTQOkMWPQWHbj8tToi9WemOqQWFhYO2AiWHOVfMD/WpTak1rJKmRPcV14XoVCoJnvxXXJshipt+esD3sd2gyUexMyqOzPfRS+BJQmcb8uVK5hBsRkrIF1aPFmHuGh0tL/HsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IMPuklV/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMHAPN015201;
	Wed, 12 Mar 2025 06:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GRvu9Ukzh0sVskjwa9ATxoRWNZLcYdxUuxK3Uz3hjjc=; b=IMPuklV/25mm1hny
	NDDXEeU8neDffMZcX3+fzJoz6RnLDjlWcUCLNKpejHMXwW1LMF+hK2+X+bQVGwNt
	NDnr+BpcXCsspGwzimFx8SMsfC/kB/YnirtomUqqEe2C3iE6Is8FF8XCpW6Ds6N1
	w7V0UYlHLnxdFaKb+yETMQb5t9tP4wQfjda2m2YtHpNSCeBNwd3gwfdnYjKyMuil
	YWVzp3RbQIojcHD+9d32iNVA7vwTz90ecrOWCHltPN2gfusN4f+/VNt/mqUSOLxA
	KxfIhPtfu6bOwguXtcBNCE8QJVfYeL9lWGug9JdySnf3cYMARtL+mOAsb6m3Ot91
	xaVEmA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nsdu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 06:52:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52C6q1VK023760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 06:52:01 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Mar 2025 23:51:59 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v5 06/11] wifi: cfg80211: add flag to indicate driver supports ML station statistics
Date: Wed, 12 Mar 2025 12:21:27 +0530
Message-ID: <20250312065132.3397726-7-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312065132.3397726-1-quic_sarishar@quicinc.com>
References: <20250312065132.3397726-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: tkMdWmRczgtcVZpC8UekUyxNdqJL9k0z
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d12f11 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=CilbYTUr6xf_O_4wI94A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: tkMdWmRczgtcVZpC8UekUyxNdqJL9k0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120044

Currently, while filling NL attributes for the link level station
statistics, valid_links is checked. There might be the case when
driver offload link station statistics and does not provide per-link
statistics.

Hence, add flag WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS in wiphy
structure to indicate that driver supports per link station statistics.
Set this flag if driver supports per-link station statistics and
check this flag while filling the station_info structure
for MLO and while embedding the info into NL message.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 include/net/cfg80211.h | 7 +++++++
 net/wireless/nl80211.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 578bb71e8eb2..48685e317add 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2161,6 +2161,9 @@ struct link_station_info {
  * @local_pm: local mesh STA power save mode
  * @peer_pm: peer mesh STA power save mode
  * @nonpeer_pm: non-peer mesh STA power save mode
+ * @is_per_link_stats_support: false- for non-ML STA and for ML STA,if driver
+ *	offload link decisions and do not provide per-link statistics.
+ *	true- if driver provides per-link statistics.
  * @assoc_link_id: Indicates MLO link ID of the AP, with which the station
  *	completed (re)association. This information filled for both MLO
  *	and non-MLO STA connections when the AP affiliated with an MLD.
@@ -2204,6 +2207,7 @@ struct station_info {
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
+	bool is_per_link_stats_support;
 	u8 assoc_link_id;
 	u8 mld_addr[ETH_ALEN] __aligned(2);
 	const u8 *assoc_resp_ies;
@@ -5083,6 +5087,8 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY: support connection to non-primary link
  *	of an NSTR mobile AP MLD.
  * @WIPHY_FLAG_DISABLE_WEXT: disable wireless extensions for this device
+ * @WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS: The driver does not offload
+ *	link decisions and provide per-link statistics for MLO STA.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -5111,6 +5117,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
 	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
+	WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS = BIT(26),
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0fb23bc6c1a9..0ec8e3e73e19 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6911,7 +6911,7 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		    &sinfo->sta_flags))
 		goto nla_put_failure;
 
-	if (sinfo->valid_links) {
+	if (sinfo->is_per_link_stats_support && sinfo->valid_links) {
 		/* TODO: Add accumulated stats for packets, bytes for
 		 *	 better representation at MLO level.
 		 */
-- 
2.34.1


