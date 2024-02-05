Return-Path: <linux-wireless+bounces-3136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED865849F7A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6520B22363
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF7A3BB3B;
	Mon,  5 Feb 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aFPl4PE3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F526AF1
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150620; cv=none; b=e9SLjzVeaNyw12jIaEYV+O3/C4PMx7udBZj87vfY21a728wsrz/z5wCA48AYg6P5eXvw21D5XLm9KlCOMMLVa22qcDEfw34NoxuYMIek/R4h1wvtv+YJbEP0RvdilcRacIdDt7ERqrgICfhoXgRQ26gNfX3e65SWEl3PFAOS5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150620; c=relaxed/simple;
	bh=5owV8Clu0+p7o1yuq9OY1bZkPBAgic0T33FXwGE4HBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cc36KpAJjhcsNW8WcrUNjAblHCeqgRyifyPBDVWUlJhfwh8mAqd37sRldco6m/MGYP6pR7/0eofPAVfWcufa8Hp6vI/zUiCpc1dxDJdLIBGT7Pokn3AKaR2O3A671B5bPq8BLcGj/pLTGWQiRa7DhOoW132YdvxKlvL7/QP4zT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aFPl4PE3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415Cmdpn009759;
	Mon, 5 Feb 2024 16:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mPyYGkOMG8zH9WPqOf1YI01PveuxX3SCP1+Bgft9bp4=; b=aF
	Pl4PE3IGnFeoN+yKTxpZDBITLcKQNb+VbA65LK5DeU/ktr35q02d/oRBHcbmcrfL
	micvfCPRJSKJtFJKkjfZW1Z8Q7ZE/1+2x8uX/zdNUW+UWYVmmptlW2/Z5NTIhNBl
	2xHVR1dLLaL+sekG4K1p7zyB9aBPr40P93x9XUP8j9oOI/uzBFiPgd/d/nx73C6l
	x//gLqcynlnn1WlaGTzwMc7sa2cWgGUDTo5cKXkdxEX2SP8UFF4H1ld9344+vSKL
	tNx8SMHYGwuuD+BJqUtGNOG1uCw/9/OgtqUBcJJszdnxSN9Vmys9qYRZUhjG1ABV
	3R6l7i7eaVh2JFu4VN+Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2s07scsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:30:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415GUE5j016404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 16:30:14 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 08:30:12 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v2 2/3] wifi: mac80211: add link id argument for sta_flush() function
Date: Mon, 5 Feb 2024 21:59:51 +0530
Message-ID: <20240205162952.1697646-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205162952.1697646-1-quic_adisi@quicinc.com>
References: <20240205162952.1697646-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NX4IoFB7j8M0S67jIdjcb2h4FPKt8nyc
X-Proofpoint-GUID: NX4IoFB7j8M0S67jIdjcb2h4FPKt8nyc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050125

Whenever sta_flush() function is invoked, all STAs present in that
interface are flushed. In case of MLO, it is desireable to only flush such
STAs who are at least using a given link id as one of its active links.

Add support for this by making change in the __sta_info_flush API argument
to accept a link ID. And then, only if the STA is using the given link as
one of its active links, it would be flushed.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/cfg.c      |  4 ++--
 net/mac80211/ibss.c     |  4 ++--
 net/mac80211/iface.c    |  2 +-
 net/mac80211/mesh.c     |  2 +-
 net/mac80211/mlme.c     |  2 +-
 net/mac80211/ocb.c      |  2 +-
 net/mac80211/sta_info.c | 21 ++++++++++++++-------
 net/mac80211/sta_info.h | 14 +++++++++++---
 8 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2830ddac45b2..5035c2bdf348 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1618,7 +1618,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	link_conf->ema_ap = false;
 	link_conf->bssid_indicator = 0;
 
-	__sta_info_flush(sdata, true);
+	__sta_info_flush(sdata, true, -1);
 	ieee80211_free_keys(sdata, true);
 
 	link_conf->enable_beacon = false;
@@ -2096,7 +2096,7 @@ static int ieee80211_del_station(struct wiphy *wiphy, struct net_device *dev,
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
index df314222c2c9..64932eb60cc8 100644
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
index cc9a8eaffa6b..6df0e342a1be 100644
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
index 4391d8dd634b..da5fdd6f5c85 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1566,7 +1566,8 @@ void sta_info_stop(struct ieee80211_local *local)
 }
 
 
-int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans)
+int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans,
+		     int link_id)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta, *tmp;
@@ -1580,12 +1581,18 @@ int __sta_info_flush(struct ieee80211_sub_if_data *sdata, bool vlans)
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
+		if (link_id >= 0 && sta->sta.valid_links &&
+		    !(sta->sta.valid_links & BIT(link_id)))
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


