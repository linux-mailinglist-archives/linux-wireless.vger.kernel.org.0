Return-Path: <linux-wireless+bounces-2477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CA883C2EE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA6828E86A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2D4F215;
	Thu, 25 Jan 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ja4OAlUY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56D1EF1F
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187561; cv=none; b=Si7sTBxW0XJQc6UDZy7lpJ1NhoDQoZpsz46Sbo0EYjA5sEP4H2HIjwDoesZl1t2nLvF1KmNlCCAkf5Xre3nIwcEwby+csURox51Fh6y9yzRUXCihzfDaxkw8xxm6jMIAAlKfv5QLUm5j34EqOHp9v/IBTwaUxCMMTsC4P2J1zxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187561; c=relaxed/simple;
	bh=RtlJfHsC3Su9CsQ71bolPpcSjW1SO8ot5nMC5MzrvLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtTjflyXvnCYl1ZKLNQyQp+OJDzKXjxArV/irmLwCTEelDZPY42WkOQYwyjF2b4kvy6Ga3t1i5ImmgSqomWRmdYM02ajeuD1kk58yYnwVZDicpTObWsuE4pp+9qceJBA9X5Ad8bODCGL6X6l3ns/0Od+IFFY3+jVerNbDZ5b6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ja4OAlUY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P9QGYK007655;
	Thu, 25 Jan 2024 12:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=KXo70UbS7aFCecYwXCGmD+K7xoNIqP9IA6EUA7HMEoM=; b=ja
	4OAlUYx390kE4xTRaBsgtSOxu30BSjfEd6zkYhOPRMF2Zaq8vBO7cbSPAb/et2Xk
	Lc5x+dS+LxBW9WGVni3M9f2JmPGCjd9W63HJsXn+QqXBGMxdKr7Y++vY6ukCaPdc
	SsGZn1Pef6zadtiPqQxOgfPPvitVprBIAB95MsmHxy4BnlCWj6FmzS0IQlRVf/uD
	bk1J7H99l4j0Ttmg1ernOhJtRzLP2o7pwnPzhV7IwuPKbK1fhFhbaHNvuYatim4A
	t/r6P0PCwocjOFFHYY3VgxOsYjwqcVtClg6nVKjBgqOofbuhK7BEM7lbJv41Jz7q
	Sp1M/g0jtxctRk5RDAcw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vumyngm6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:59:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PCxF8T016141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 12:59:15 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 04:59:13 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 2/3] wifi: mac80211: add link id argument for sta_flush() function
Date: Thu, 25 Jan 2024 18:28:50 +0530
Message-ID: <20240125125855.827619-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125125855.827619-1-quic_adisi@quicinc.com>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: XHc6J3bLi5hDHNmn0oUZmEZqjiyT6h1I
X-Proofpoint-ORIG-GUID: XHc6J3bLi5hDHNmn0oUZmEZqjiyT6h1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=920 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250090

Whenever sta_flush() function is invoked, all sta present in that interface
is flushed. However, there is a requirement in case of MLO that only flush
those sta who are using a given link id. This is not possible currently.

Hence add the support for the same.

Passing link id is done currently via cfg80211 op - del_station.
A subsequent patch would also use this during stopping AP.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c      |  4 ++--
 net/mac80211/ibss.c     |  4 ++--
 net/mac80211/iface.c    |  2 +-
 net/mac80211/mesh.c     |  2 +-
 net/mac80211/mlme.c     |  2 +-
 net/mac80211/ocb.c      |  2 +-
 net/mac80211/sta_info.c | 20 +++++++++++++-------
 net/mac80211/sta_info.h | 14 +++++++++++---
 8 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 489dd97f5172..26a8ea553401 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1618,7 +1618,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	link_conf->ema_ap = false;
 	link_conf->bssid_indicator = 0;
 
-	__sta_info_flush(sdata, true);
+	__sta_info_flush(sdata, true, -1);
 	ieee80211_free_keys(sdata, true);
 
 	link_conf->enable_beacon = false;
@@ -2093,7 +2093,7 @@ static int ieee80211_del_station(struct wiphy *wiphy, struct net_device *dev,
 	if (params->mac)
 		return sta_info_destroy_addr_bss(sdata, params->mac);
 
-	sta_info_flush(sdata);
+	sta_info_flush(sdata, params->link_id);
 	return 0;
 }
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 8f2b445a5ec3..e4c55760f90c 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -237,7 +237,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	drv_reset_tsf(local, sdata);
 
 	if (!ether_addr_equal(ifibss->bssid, bssid))
-		sta_info_flush(sdata);
+		sta_info_flush(sdata, -1);
 
 	/* if merging, indicate to driver that we leave the old IBSS */
 	if (sdata->vif.cfg.ibss_joined) {
@@ -682,7 +682,7 @@ static void ieee80211_ibss_disconnect(struct ieee80211_sub_if_data *sdata)
 
 	ifibss->state = IEEE80211_IBSS_MLME_SEARCH;
 
-	sta_info_flush(sdata);
+	sta_info_flush(sdata, -1);
 
 	spin_lock_bh(&ifibss->incomplete_lock);
 	while (!list_empty(&ifibss->incomplete_stations)) {
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e4e7c0b38cb6..97728bb51f9b 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -511,7 +511,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	 * would have removed them, but in other modes there shouldn't
 	 * be any stations.
 	 */
-	flushed = sta_info_flush(sdata);
+	flushed = sta_info_flush(sdata, -1);
 	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_AP_VLAN && flushed > 0);
 
 	/* don't count this interface for allmulti while it is down */
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index fccbcde3359a..16b5af8ee859 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1234,7 +1234,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 	netif_carrier_off(sdata->dev);
 
 	/* flush STAs and mpaths on this iface */
-	sta_info_flush(sdata);
+	sta_info_flush(sdata, -1);
 	ieee80211_free_keys(sdata, true);
 	mesh_path_flush_by_iface(sdata);
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 073105deb424..b3f2de3b1669 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2991,7 +2991,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.cfg.ssid_len = 0;
 
 	/* remove AP and TDLS peers */
-	sta_info_flush(sdata);
+	sta_info_flush(sdata, -1);
 
 	/* finally reset all BSS / config parameters */
 	if (!ieee80211_vif_is_mld(&sdata->vif))
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 449af4e1cca4..7d06166f63bb 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -207,7 +207,7 @@ int ieee80211_ocb_leave(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	ifocb->joined = false;
-	sta_info_flush(sdata);
+	sta_info_flush(sdata, -1);
 
 	spin_lock_bh(&ifocb->incomplete_lock);
 	while (!list_empty(&ifocb->incomplete_stations)) {
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index bf1adcd96b41..6c9aa8db3c62 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1561,7 +1561,8 @@ void sta_info_stop(struct ieee80211_local *local)
 }
 
 
-int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans)
+int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans,
+		     int link_id)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta, *tmp;
@@ -1575,12 +1576,17 @@ int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans)
 	WARN_ON(vlans && !sdata->bss);
 
 	list_for_each_entry_safe(sta, tmp, &local->sta_list, list) {
-		if (sdata == sta->sdata ||
-		    (vlans && sdata->bss == sta->sdata->bss)) {
-			if (!WARN_ON(__sta_info_destroy_part1(sta)))
-				list_add(&sta->free_list, &free_list);
-			ret++;
-		}
+		if (sdata != sta->sdata &&
+		    (!vlans || sdata->bss != sta->sdata->bss))
+			continue;
+
+		if (link_id >= 0 && !(sta->sta.valid_links & BIT(link_id)))
+			continue;
+
+		if (!WARN_ON(__sta_info_destroy_part1(sta)))
+			list_add(&sta->free_list, &free_list);
+
+		ret++;
 	}
 
 	if (!list_empty(&free_list)) {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 5ef1554f991f..f03731a5bbee 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -886,8 +886,12 @@ void sta_info_stop(struct ieee80211_local *local);
  *
  * @sdata: sdata to remove all stations from
  * @vlans: if the given interface is an AP interface, also flush VLANs
+ * @link_id: if given (>=0), all those STA entries using @link_id only
+ *	     will be removed. If -1 is passed, all STA entries will be
+ *	     removed.
  */
-int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans);
+int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans,
+		     int link_id);
 
 /**
  * sta_info_flush - flush matching STA entries from the STA table
@@ -895,10 +899,14 @@ int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans);
  * Returns the number of removed STA entries.
  *
  * @sdata: sdata to remove all stations from
+ * @link_id: if given (>=0), all those STA entries using @link_id only
+ *	     will be removed. If -1 is passed, all STA entries will be
+ *	     removed.
  */
-static inline int sta_info_flush(struct ieee80211_sub_if_data *sdata)
+static inline int sta_info_flush(struct ieee80211_sub_if_data *sdata,
+				 int link_id)
 {
-	return __sta_info_flush(sdata, false);
+	return __sta_info_flush(sdata, false, link_id);
 }
 
 void sta_set_rate_info_tx(struct sta_info *sta,
-- 
2.25.1


