Return-Path: <linux-wireless+bounces-5282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E18688C66A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046C82C69C2
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B0E13C808;
	Tue, 26 Mar 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IuM8ujOZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C11CAA5
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465926; cv=none; b=emlD4jE9regzv4mHWg2Aeld4Qq5p5qUy/8whLkaRzDgsxK+4rp5kAqtFI+AzdDorYK0KhHNhK1jToDMxYidmzpJE5FiC2E8tltP6xDg4zGoS9FBdsZxC2XgiWdLCjQisUHariQm3hyPGgQEGE1VjzesWOqGpxtk8sHR/JEyk+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465926; c=relaxed/simple;
	bh=oUYxYMT0Zs/nsS7aXBXWrnvqJfOonW7UjFZX6e3LKi4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PmUGFIvgEOhRX0x+ZNu/y1Ev6bg78/Ze+KheHenLd8AlPnj5VzKPB/y23PdpbhRA73qGNqt3L3jeGRW4claLY1RiKWDIIw/krqUVKJrsxj1krCSykN6o1WXhpWTbRIZvV/HnNE6n+DiGvYsRiAetZL9g/HqJHHbsTSJzWD1WCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IuM8ujOZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q672tJ005665;
	Tue, 26 Mar 2024 15:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=7V62Mmx
	tQJHzpRfLGaN+zHLQHB69JVeWoL7+4Iq8Nng=; b=IuM8ujOZYtJBZ8FsgNNIbjl
	x7HgcAKbY6v5zg4icCZILxLHd+mky0yft4VC5XgVbSVy+iZlExgZ6nMFxW43kNkP
	+t6ORfXdC9vIEb1pimltBZL7OL0kcXNDKQctjMX8SrZPa6WcUGevhxtiARkeAV0Q
	zjSTO0JnQTtLY3zRp1GSzQ+APwaTfUn0oJRVYHAK7NXZ6Y0cT+t6Hdgc+UZXGb2e
	XEMo3GUYATbEYuR/7m1Rzu+8ltHaD4AYeN5WufnfVXIc5JDUG/7CvhoxqVn8P1k2
	nZsmqXqLiD/lk8N0r71EfTgC6Bqeic7vVdU4s9zZbHwi+IZYOm//7ddSB0YlpxA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3rt81jdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 15:11:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QFBwqw003890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 15:11:58 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 08:11:56 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH] wifi: mac80211: handle sdata->u.ap.active flag with MLO
Date: Tue, 26 Mar 2024 20:41:41 +0530
Message-ID: <20240326151141.3824454-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: bfh-ZyHYP7AzFD7rcB0g4XmyOWpK3xrG
X-Proofpoint-ORIG-GUID: bfh-ZyHYP7AzFD7rcB0g4XmyOWpK3xrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=935 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403260107

Currently whenever link AP beacon is assigned, sdata->u.ap.active flag is
set and whenever it is brought down, the flag is reset. However, with MLO,
all the links of the same MLD would use the same sdata. Hence there is no
need to set/reset for each link up/down. Also, resetting it  when only one
of the links went down is not desirable.

Add changes to set the active flag only when first link is assigned
beacon. Similarly, add changes to reset that flag only when last link is
brought down.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 62 +++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f03452dc716d..ca0a3e6ba0fb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1092,6 +1092,30 @@ ieee80211_copy_rnr_beacon(u8 *pos, struct cfg80211_rnr_elems *dst,
 	return offset;
 }
 
+static u8 ieee80211_num_beaconing_links(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_link_data *link;
+	u8 link_id, num = 0;
+
+	if (sdata->vif.type != NL80211_IFTYPE_AP &&
+	    sdata->vif.type != NL80211_IFTYPE_P2P_GO)
+		return num;
+
+	if (!sdata->vif.valid_links)
+		return num;
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link)
+			continue;
+
+		if (sdata_dereference(link->u.ap.beacon, sdata))
+			num++;
+	}
+
+	return num;
+}
+
 static int
 ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 			struct ieee80211_link_data *link,
@@ -1232,7 +1256,9 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	}
 
 	rcu_assign_pointer(link->u.ap.beacon, new);
-	sdata->u.ap.active = true;
+
+	if (ieee80211_num_beaconing_links(sdata) <= 1)
+		sdata->u.ap.active = true;
 
 	if (old)
 		kfree_rcu(old, rcu_head);
@@ -1241,30 +1267,6 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static u8 ieee80211_num_beaconing_links(struct ieee80211_sub_if_data *sdata)
-{
-	struct ieee80211_link_data *link;
-	u8 link_id, num = 0;
-
-	if (sdata->vif.type != NL80211_IFTYPE_AP &&
-	    sdata->vif.type != NL80211_IFTYPE_P2P_GO)
-		return num;
-
-	if (!sdata->vif.valid_links)
-		return num;
-
-	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
-		link = sdata_dereference(sdata->link[link_id], sdata);
-		if (!link)
-			continue;
-
-		if (sdata_dereference(link->u.ap.beacon, sdata))
-			num++;
-	}
-
-	return num;
-}
-
 static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			      struct cfg80211_ap_settings *params)
 {
@@ -1486,7 +1488,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		if (old)
 			kfree_rcu(old, rcu_head);
 		RCU_INIT_POINTER(link->u.ap.beacon, NULL);
-		sdata->u.ap.active = false;
+
+		if (!ieee80211_num_beaconing_links(sdata))
+			sdata->u.ap.active = false;
+
 		goto error;
 	}
 
@@ -1619,11 +1624,12 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
 		netif_carrier_off(vlan->dev);
 
-	if (ieee80211_num_beaconing_links(sdata) <= 1)
+	if (ieee80211_num_beaconing_links(sdata) <= 1) {
 		netif_carrier_off(dev);
+		sdata->u.ap.active = false;
+	}
 
 	/* remove beacon and probe response */
-	sdata->u.ap.active = false;
 	RCU_INIT_POINTER(link->u.ap.beacon, NULL);
 	RCU_INIT_POINTER(link->u.ap.probe_resp, NULL);
 	RCU_INIT_POINTER(link->u.ap.fils_discovery, NULL);

base-commit: d69aef8084cc72df7b0f2583096d9b037c647ec8
-- 
2.25.1


