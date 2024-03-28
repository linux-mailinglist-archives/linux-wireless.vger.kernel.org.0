Return-Path: <linux-wireless+bounces-5436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABE988F8B8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295321F2772E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DCD50A93;
	Thu, 28 Mar 2024 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nE+iEZna"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1451C54
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611011; cv=none; b=oAgyqrqGkK8GKsbfnwjFQWjFWSjXZNO3Kd9YsfkF87NE3k6KwTQV3DkWEpiXHZ9/376rcE2+yTVkUBDdu7mM/UFwJVcSi/m25twDCdjxc/cA9jXVYInAKmkYPcLLGE4lynIsO+DtydoNxYKW3strhko8HTgSPM7OZiwM+Gi8omA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611011; c=relaxed/simple;
	bh=oRWDMjZoeZroMUZE4S1jnm/ekwhc6o8X0x42JdybI28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1wDSlrAL3JtLT23Nr5jvGA+RQT4HCUicqAdYhAgO6LchCA7+Xf/0wxWm/HZVMZWqQcB4mSyXHftleZMIgr/kY6djGE0nYG2kri95+fd7SC6B+lxCF3f18ZSIAaW/lPSHkYkOE0vbS/zHLYStiYyIz7Op3c0E7Zsg7HjTWE33P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nE+iEZna; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S3RDub008039;
	Thu, 28 Mar 2024 07:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vzFMCWN64d8JTCXizncnmHel3u9nVpLxYSuQ9oJegME=; b=nE
	+iEZnaeZmHzEBQF0HOs7kUTd1EDP0F0DruxoXQN16qyJMC+2zQpt2gpQcIUNLk94
	O/lljfgGWPbjVqwwHJgkOGzDZNrzYbEKRX9u1DYfy3S7kZ9hEmOVrVWqUJ52kR1/
	OWGC16n63mVFvOXeEJ7PlSbW9Y9NHl4x87JoiTE4HH6AZvMADeyyXXyqD08gfr+6
	Xj4AzeivZ20gJy0926bUdICFHt6UuRdOn4eQ1KPROVSQOWD3XlUFtavFdVznhr+y
	nVAUOj+qaE8zfCs1CEDYlWfWiW3cuXqFX9T7+ZLgz1B6omWRVCkw3JLKjUFj92r0
	eMciHcf8MANcuPYwawjA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u1wt9de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7U2sd004429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:30:02 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:30:00 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 08/13] wifi: cfg80211: Refactor the iface combination iteration helper function
Date: Thu, 28 Mar 2024 12:59:11 +0530
Message-ID: <20240328072916.1164195-9-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1ARFm6oLhtyOzb6ZR50mqk4Y5zNld8ki
X-Proofpoint-GUID: 1ARFm6oLhtyOzb6ZR50mqk4Y5zNld8ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280048

From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

Currently, the iteration helper function retrieves iface types information
from the iface combination parameter and performs iface combination limit
validation. To accommodate per physical hardware iface combinations, the
aforementioned validation and information retrieval need to be executed
for each physical hardware instance. Consequently, relocate the validation
and retrieval operations to a new helper function and scale it to support
per physical hardware iface combinations.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 net/wireless/util.c | 135 ++++++++++++++++++++++++++++++++------------
 1 file changed, 98 insertions(+), 37 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index b60a6a6da744..39358b69dd36 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2360,6 +2360,84 @@ int cfg80211_validate_beacon_int(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int
+cfg80211_validate_iface_limits(struct wiphy *wiphy,
+			       const int iftype_num[NUM_NL80211_IFTYPES],
+			       struct ieee80211_iface_limit *limits,
+			       u8 n_limits,
+			       u32 *all_iftypes)
+{
+	enum nl80211_iftype iftype;
+	int i;
+
+	for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
+		if (cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
+			continue;
+
+		for (i = 0; i < n_limits; i++) {
+			*all_iftypes |= limits[i].types;
+
+			if (!(limits[i].types & BIT(iftype)))
+				continue;
+
+			if (limits[i].max < iftype_num[iftype])
+				return -EINVAL;
+
+			limits[i].max -= iftype_num[iftype];
+		}
+	}
+
+	return 0;
+}
+
+static int
+cfg80211_validate_iface_comb_limits(struct wiphy *wiphy,
+				    struct iface_combination_params *params,
+				    const struct ieee80211_iface_combination *c,
+				    u16 num_interfaces, u32 *all_iftypes)
+{
+	struct ieee80211_iface_limit *limits;
+	int ret = 0;
+
+	if (num_interfaces > c->max_interfaces)
+		return -EINVAL;
+
+	if (params->num_different_channels > c->num_different_channels)
+		return -EINVAL;
+
+	limits = kmemdup(c->limits, sizeof(limits[0]) * c->n_limits,
+			 GFP_KERNEL);
+	if (!limits)
+		return -ENOMEM;
+
+	ret = cfg80211_validate_iface_limits(wiphy,
+					     params->iftype_num,
+					     limits,
+					     c->n_limits,
+					     all_iftypes);
+
+	kfree(limits);
+
+	return ret;
+}
+
+static u16 cfg80211_get_iftype_info(struct wiphy *wiphy,
+				    const int iftype_num[NUM_NL80211_IFTYPES],
+				    u32 *used_iftypes)
+{
+	enum nl80211_iftype iftype;
+	u16 num_interfaces = 0;
+
+	for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
+		num_interfaces += iftype_num[iftype];
+		if (iftype_num[iftype] > 0 &&
+		    !cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
+			*used_iftypes |= BIT(iftype);
+	}
+
+	return num_interfaces;
+}
+
 int cfg80211_iter_combinations(struct wiphy *wiphy,
 			       struct iface_combination_params *params,
 			       void (*iter)(const struct ieee80211_iface_combination *c,
@@ -2368,11 +2446,13 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 {
 	const struct ieee80211_regdomain *regdom;
 	enum nl80211_dfs_regions region = 0;
-	int i, j, iftype;
-	int num_interfaces = 0, hw_chan_idx = -1;
+	int i;
+	int hw_chan_idx = -1;
 	u32 used_iftypes = 0;
 	u32 beacon_int_gcd;
+	u16 num_interfaces = 0;
 	bool beacon_int_different;
+	int ret = 0;
 
 	/*
 	 * This is a bit strange, since the iteration used to rely only on
@@ -2395,50 +2475,33 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		rcu_read_unlock();
 	}
 
-	for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
-		num_interfaces += params->iftype_num[iftype];
-		if (params->iftype_num[iftype] > 0 &&
-		    !cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
-			used_iftypes |= BIT(iftype);
-	}
+	num_interfaces = cfg80211_get_iftype_info(wiphy,
+						  params->iftype_num,
+						  &used_iftypes);
 
 	for (i = 0; i < wiphy->n_iface_combinations; i++) {
 		const struct ieee80211_iface_combination *c;
-		struct ieee80211_iface_limit *limits;
 		u32 all_iftypes = 0;
 
 		c = &wiphy->iface_combinations[i];
 
-		if (num_interfaces > c->max_interfaces)
-			continue;
-		if (params->num_different_channels > c->num_different_channels)
+		ret = cfg80211_validate_iface_comb_limits(wiphy, params,
+							  c, num_interfaces,
+							  &all_iftypes);
+		if (ret == -ENOMEM) {
+			break;
+		} else if (ret) {
+			ret = 0;
 			continue;
-
-		limits = kmemdup(c->limits, sizeof(limits[0]) * c->n_limits,
-				 GFP_KERNEL);
-		if (!limits)
-			return -ENOMEM;
-
-		for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
-			if (cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
-				continue;
-			for (j = 0; j < c->n_limits; j++) {
-				all_iftypes |= limits[j].types;
-				if (!(limits[j].types & BIT(iftype)))
-					continue;
-				if (limits[j].max < params->iftype_num[iftype])
-					goto cont;
-				limits[j].max -= params->iftype_num[iftype];
-			}
 		}
 
 		if (params->radar_detect !=
 			(c->radar_detect_widths & params->radar_detect))
-			goto cont;
+			continue;
 
 		if (params->radar_detect && c->radar_detect_regions &&
 		    !(c->radar_detect_regions & BIT(region)))
-			goto cont;
+			continue;
 
 		/* Finally check that all iftypes that we're currently
 		 * using are actually part of this combination. If they
@@ -2446,14 +2509,14 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		 * to continue to the next.
 		 */
 		if ((all_iftypes & used_iftypes) != used_iftypes)
-			goto cont;
+			continue;
 
 		if (beacon_int_gcd) {
 			if (c->beacon_int_min_gcd &&
 			    beacon_int_gcd < c->beacon_int_min_gcd)
-				goto cont;
+				continue;
 			if (!c->beacon_int_min_gcd && beacon_int_different)
-				goto cont;
+				continue;
 		}
 
 		/* This combination covered all interface types and
@@ -2461,11 +2524,9 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		 */
 
 		(*iter)(c, hw_chan_idx, data);
- cont:
-		kfree(limits);
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(cfg80211_iter_combinations);
 
-- 
2.34.1


