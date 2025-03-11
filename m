Return-Path: <linux-wireless+bounces-20146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA3A5B942
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 07:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3B2189594F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 06:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEDE1EE7B9;
	Tue, 11 Mar 2025 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Olvv6ep+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C113B1DE8A8
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674472; cv=none; b=RMqvkPGzk102NzQoVwiQubfYMSGSJW2aFfPjh/bxJisZAzxFIdU369o1oBbKfplfhD63XZdbZUEYamnNxQw2oPuhLdqCRXMeAK9LOc8K/sI1ppDd3VM9ZP2TJtzVIHt2X+ceLYFEet7LDZyEqAn4KDgGVPr3iKt6eowzAPYFkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674472; c=relaxed/simple;
	bh=zQAgmaBTBSBzbG0pOc9NxcA2P9fXuxmJHI4Ku/6Gfoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrdIfzuO5J5VJcfwgYH3xUwL4ioSNliZZ+mflFZ91mI/IrsbJimoltFghzaXIgtqTUNrIhv+w+8i4ryUprRX5D7VcURmC4HbpNW5ZK0j6IeXkEAscfDYeE+TKYWDaLmFN5xudbtWOI9rYv/0EVNN8lYEuK4A+3qYWjsoNO/Nh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Olvv6ep+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B19CZ5014492;
	Tue, 11 Mar 2025 06:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k92y4hrpWKj2/gw4AWKYYwrdS6rTh1R4QVWyg9ReKVI=; b=Olvv6ep+NT52EDKP
	N2d28bWv7x2x/J3EXCFCjDay7MguAusu+NTMPy3zMBy5p8ywG0Xo8cpg6xlQ0BKS
	cfOfN4MwZ2RqjiKLImPHdCtpT8xIi90ic6UL2Uf/nXq3s11HhFiSBl2Coskkl6S2
	DEqk/Ofd7zb/c1bTb3g8qHZDhimSVHMtsLh/0w2t9knQcn+HoDjbWD6Bqh+eA5y0
	VxVA+wQUmTl2y1WTB4xpRgi6WPQhX6i0/vRb5hehLyQkAdT7CrFmpLkTg4GxcvJV
	CH40ywPiHjiSaIoq6clFwPDGPQbXVpijAAO1nC3P97Ddxxrl7LA5D0nV+coKiw/j
	ve7Wqw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ab8m0qr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:27:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52B6ROoK017769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:27:24 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Mar 2025 23:27:22 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH wireless-next v4 06/11] wifi: cfg80211: add flag to indicate driver supports ML station statistics
Date: Tue, 11 Mar 2025 11:56:49 +0530
Message-ID: <20250311062654.1407532-7-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311062654.1407532-1-quic_sarishar@quicinc.com>
References: <20250311062654.1407532-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2lhv-TfBieEpKNqeVJIA3OwxydxeQNKX
X-Authority-Analysis: v=2.4 cv=K9nYHzWI c=1 sm=1 tr=0 ts=67cfd7dc cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=CilbYTUr6xf_O_4wI94A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 2lhv-TfBieEpKNqeVJIA3OwxydxeQNKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110042

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
index a7f7bfbc87f3..0874b0c54ef4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2158,6 +2158,9 @@ struct link_station_info {
  * @local_pm: local mesh STA power save mode
  * @peer_pm: peer mesh STA power save mode
  * @nonpeer_pm: non-peer mesh STA power save mode
+ * @is_per_link_stats_support: false- for non-ML STA and for ML STA,if driver
+ *	offload link decisions and do not provide per-link statistics.
+ *	true- if driver provides per-link statistics.
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
@@ -5065,6 +5069,8 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY: support connection to non-primary link
  *	of an NSTR mobile AP MLD.
  * @WIPHY_FLAG_DISABLE_WEXT: disable wireless extensions for this device
+ * @WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS: The driver does not offload
+ *	link decisions and provide per-link statistics for MLO STA.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -5093,6 +5099,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
 	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
+	WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS = BIT(26),
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 619427513361..522bcad71874 100644
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


