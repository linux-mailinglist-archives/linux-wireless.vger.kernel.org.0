Return-Path: <linux-wireless+bounces-4048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0057086882F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 05:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795F8B25739
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 04:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51B84D10A;
	Tue, 27 Feb 2024 04:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lF3vUFrc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD62134BC
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 04:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007804; cv=none; b=Qx5x9Bxl6FwZJcWbABC50jH59dYL1Ek4tgMNQmdshbKiBwTgGgRfGL6098wXB1TAjlH8F+6ygniOdofGU9yPPDSTmXR65FNsoxx5/iisMQNW5UqPCYeE8bIw2eU9tx5SrxgIJjl/J6F0AF5dvE/nqXkdiycQSy5S8qH422Xc9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007804; c=relaxed/simple;
	bh=UmYWl9jyUn1EP53A36/T25zT0WT0QFENr91Y9emizfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoPiaBrYJ+tVB3dwsX49B6+J3VlgyR94QQLdX5+7YQzSQdUDBI2Yqx2zrheRUN7PfugHdZVsN9Kc5TJrVSrOpLN2XwfS92gBO5w41+v7j2aORF5RYO4fjVAuirTSVoFl2UX9VNrP1snIR5yFlTtCA/s4TJy46uA8scLawcd4K0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lF3vUFrc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R3oQwW005626;
	Tue, 27 Feb 2024 04:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=1NnSU2jowxh56U1d/1F10VSBMF5i9l1FfJD6FE8Qcg8=; b=lF
	3vUFrchqCab6ptq9vqz7wiNbXXzWNWeoMZX6lZ6bG6QuuMkZp7Rwls2HizAgS3wz
	9qNAQubboBtly8xa/2rk3fF1Q8qB28fbv1huJJ+quEJhJIfpRlTIYzvqZevqTTHd
	E5PpCf745vOCEOZ+gyej1SzdgIyem1/n+96hAO4J0X4CeZxYLx1gQCc4Z1htvJ7y
	2pUB0rf5esQsrCBgyX0p0OvEut5glgtI5i+uBLjaQkNpmkrfNtOvabbBJJVLemc8
	3Z9zZrho25LCNJ7ao01QNhN5lOHtXH5fnkolMUXceZcuCbDGbY5BlBt4VwZQhiut
	PyzLT5Mk+V3d1vkppZoQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh5078dwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 04:23:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R4NFFa026063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 04:23:15 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 20:23:14 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211: handle netif carrier up/down with link AP during MLO
Date: Tue, 27 Feb 2024 09:52:51 +0530
Message-ID: <20240227042251.1511122-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227042251.1511122-1-quic_adisi@quicinc.com>
References: <20240227042251.1511122-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -RuUPBF8Y-UpXnZz119ilqICHf8JM5Vs
X-Proofpoint-GUID: -RuUPBF8Y-UpXnZz119ilqICHf8JM5Vs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=833 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270033

Currently whenever link AP is started, netif_carrier_up() function is
called and whenever it is brought down, netif_carrier_down() function is
called. However, with MLO, all the links of the same MLD would use the
same netdev. Hence there is no need to indicate for each link up/down.
Also, calling it down when only one of the links went down is not
desirable.

Add changes to call the netif_carrier_up() function only when first link
is brought up. Similarly, add changes to call the netif_carrier_down()
function only when last link is brought down.

In order to check the number of beaconing links in the given interface,
introduce a new helper function ieee80211_num_beaconing_links().

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9989f4a6c0ff..1c2aac1733b8 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1241,6 +1241,30 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	return 0;
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
 static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			      struct cfg80211_ap_settings *params)
 {
@@ -1470,7 +1494,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_SSID);
 	ieee80211_link_info_change_notify(sdata, link, changed);
 
-	netif_carrier_on(dev);
+	if (ieee80211_num_beaconing_links(sdata) <= 1)
+		netif_carrier_on(dev);
+
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
 		netif_carrier_on(vlan->dev);
 
@@ -1592,7 +1618,9 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	/* turn off carrier for this interface and dependent VLANs */
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
 		netif_carrier_off(vlan->dev);
-	netif_carrier_off(dev);
+
+	if (ieee80211_num_beaconing_links(sdata) <= 1)
+		netif_carrier_off(dev);
 
 	/* remove beacon and probe response */
 	sdata->u.ap.active = false;
-- 
2.25.1


