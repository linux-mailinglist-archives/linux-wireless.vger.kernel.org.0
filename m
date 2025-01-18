Return-Path: <linux-wireless+bounces-17673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17C1A15AF3
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 02:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B79168F14
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3577839FD9;
	Sat, 18 Jan 2025 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oZ16ygrb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B121078F
	for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165269; cv=none; b=XjOd7FQUBJ7UXqayqNjrfb1bQ97KjHcmNLAK8OGoYhOOHdKd/CqQnup4uZLy1BqEy93yrHznILUktdrr62Y7bPvzl7osIDga2NBl6E989hYsRIw5y72+bzD6e2DOBtDWOejDUn/ckqj44IrO6f5KUXzzpPbA41lFvv3669jtC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165269; c=relaxed/simple;
	bh=3XTUsKw8AAXuTC5xyT0qHgiF+R7RKEcvSZPVmfUQZIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mphweN9lbKL4kM+AphBn/gJZdjdWda46TadWuiTp3MsTpZ40T0j4LNhu6IxcyFVkweEAjKxoU5AM9TdDXXxMBomaYmyDL9p1f/iJOdFrwjrUv19yfavlX+7g+tYhE2bIJpK88q8r4OsewCTlURnz+L6LLSotOy7v9TnPkc1fIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oZ16ygrb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50I0h0RG012577;
	Sat, 18 Jan 2025 01:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nVZirLLCBHUoKpaLScRnN4tcRJIPrs53IcA9B5b4ZmU=; b=oZ16ygrb0FilF616
	NOXmlHhaFFKw80j3dtv94yukeg8F7L+wbnthOvnGZAw27zXszoHgFGrwWcM9h9qp
	OE7OffS+GAhVpwvQCLOUAg9wOun7KUPXsRTsPEPPaJAPU5fMZZqXafDEL2oxwG1x
	bOJhWjWUGq/I05vmgILUFUXHeWIR6cXUBZt10wLr4aPijXjqTGHDXQG5fXMhCLtj
	js8qul+rJ/Ebg4WrqvVSpDkNqP16CqYuovNHqPl4kkz2OU03BtPqOhOPUrKhquKH
	VKUKaHGdzxELuwPhj5jE6ciNG3NilPkwbt8u3xXzZeu+iKhoqJFcBR66ltaPxHXv
	s6xYdQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44820cg30a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 01:54:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50I1sFZU013491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 01:54:15 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 17:54:14 -0800
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 1/2] wifi: mac80211: Create separate links for VLAN interfaces
Date: Fri, 17 Jan 2025 17:53:59 -0800
Message-ID: <20250118015400.1919688-2-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250118015400.1919688-1-quic_msinada@quicinc.com>
References: <20250118015400.1919688-1-quic_msinada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: F2lwA6odeMUVlwLtPHKc7CCxNFxPeCFV
X-Proofpoint-GUID: F2lwA6odeMUVlwLtPHKc7CCxNFxPeCFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 phishscore=0 mlxlogscore=784 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501180012

Currently, MLD links for an AP_VLAN interface type is not fully
supported.

Add allocation of separate links for each VLAN interface and copy
chanctx and chandef of master AP to VLAN where necessary. Separate
links are created because for Dynamic VLAN each link will have its own
default_multicast_key.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 net/mac80211/chan.c        |  3 ++
 net/mac80211/ieee80211_i.h |  2 +
 net/mac80211/iface.c       | 23 +++++++++-
 net/mac80211/link.c        | 86 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index a442cb667520..553fc998f5d0 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -2124,6 +2124,9 @@ void ieee80211_link_release_channel(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		return;
+
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (rcu_access_pointer(link->conf->chanctx_conf))
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9f0db39b28ff..fdd2d422ac5e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2057,6 +2057,8 @@ static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata
 	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
+void ieee80211_apvlan_link_setup(struct ieee80211_sub_if_data *sdata);
+
 /* tx handling */
 void ieee80211_clear_tx_pending(struct ieee80211_local *local);
 void ieee80211_tx_pending(struct tasklet_struct *t);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 806dffa48ef9..28aa45a9601c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -493,6 +493,10 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 			break;
 		list_del_rcu(&sdata->u.mntr.list);
 		break;
+	case NL80211_IFTYPE_AP_VLAN:
+		sdata->wdev.valid_links = 0;
+		ieee80211_vif_clear_links(sdata);
+		break;
 	default:
 		break;
 	}
@@ -1236,7 +1240,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	struct net_device *dev = wdev->netdev;
 	struct ieee80211_local *local = sdata->local;
 	u64 changed = 0;
-	int res;
+	int link_id, res;
 	u32 hw_reconf_flags = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -1268,6 +1272,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		sdata->crypto_tx_tailroom_needed_cnt +=
 			master->crypto_tx_tailroom_needed_cnt;
 
+		ieee80211_apvlan_link_setup(sdata);
+
 		break;
 		}
 	case NL80211_IFTYPE_AP:
@@ -1324,7 +1330,20 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_AP_VLAN:
 		/* no need to tell driver, but set carrier and chanctx */
 		if (sdata->bss->active) {
-			ieee80211_link_vlan_copy_chanctx(&sdata->deflink);
+			struct ieee80211_link_data *link;
+			unsigned long valid_links = sdata->vif.valid_links;
+
+			if (valid_links) {
+				for_each_set_bit(link_id, &valid_links,
+						 IEEE80211_MLD_MAX_NUM_LINKS) {
+					link = sdata_dereference(sdata->link[link_id],
+								 sdata);
+					ieee80211_link_vlan_copy_chanctx(link);
+				}
+			} else {
+				ieee80211_link_vlan_copy_chanctx(&sdata->deflink);
+			}
+
 			netif_carrier_on(dev);
 			ieee80211_set_vif_encap_ops(sdata);
 		} else {
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 58a76bcd6ae6..f7db6d90a9dc 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -12,6 +12,62 @@
 #include "key.h"
 #include "debugfs_netdev.h"
 
+static void ieee80211_update_apvlan_links(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_sub_if_data *vlan;
+	struct ieee80211_link_data *link;
+	u16 master_links = sdata->vif.valid_links;
+	u16 new_links, vlan_links;
+	unsigned long add;
+
+	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
+		int link_id;
+
+		if (!vlan)
+			continue;
+
+		/* No support for 4addr with MLO yet */
+		if (vlan->wdev.use_4addr)
+			return;
+
+		vlan_links = vlan->vif.valid_links;
+
+		new_links = master_links;
+
+		add = new_links & ~vlan_links;
+		if (!add)
+			continue;
+
+		ieee80211_vif_set_links(vlan, add, 0);
+
+		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+			link = sdata_dereference(vlan->link[link_id], vlan);
+			ieee80211_link_vlan_copy_chanctx(link);
+		}
+	}
+}
+
+void ieee80211_apvlan_link_setup(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_sub_if_data *master = container_of(sdata->bss,
+					    struct ieee80211_sub_if_data, u.ap);
+	u16 new_links = master->vif.valid_links;
+	unsigned long add;
+	int link_id;
+
+	if (!master->vif.valid_links)
+		return;
+
+	add = new_links;
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		sdata->wdev.valid_links |= BIT(link_id);
+		ether_addr_copy(sdata->wdev.links[link_id].addr,
+				master->wdev.links[link_id].addr);
+	}
+
+	ieee80211_vif_set_links(sdata, new_links, 0);
+}
+
 void ieee80211_link_setup(struct ieee80211_link_data *link)
 {
 	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
@@ -31,6 +87,22 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
 	rcu_assign_pointer(sdata->link[link_id], link);
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		struct ieee80211_sub_if_data *master;
+		struct ieee80211_bss_conf *master_conf;
+
+		master = container_of(sdata->bss,
+				      struct ieee80211_sub_if_data, u.ap);
+		if (!master)
+			goto skip_vlan_conf;
+
+		master_conf = sdata_dereference(master->vif.link_conf[link_id],
+						master);
+
+		memcpy(link_conf, master_conf, sizeof(*link_conf));
+	}
+
+skip_vlan_conf:
 	link->sdata = sdata;
 	link->link_id = link_id;
 	link->conf = link_conf;
@@ -54,6 +126,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	if (!deflink) {
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_AP_VLAN:
 			ether_addr_copy(link_conf->addr,
 					sdata->wdev.links[link_id].addr);
 			link_conf->bssid = link_conf->addr;
@@ -177,6 +250,7 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_AP_VLAN:
 		/* in an AP all links are always active */
 		sdata->vif.active_links = valid_links;
 
@@ -278,12 +352,16 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		ieee80211_set_vif_links_bitmaps(sdata, new_links, dormant_links);
 
 		/* tell the driver */
-		ret = drv_change_vif_links(sdata->local, sdata,
-					   old_links & old_active,
-					   new_links & sdata->vif.active_links,
-					   old);
+		if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
+			ret = drv_change_vif_links(sdata->local, sdata,
+						   old_links & old_active,
+						   new_links & sdata->vif.active_links,
+						   old);
 		if (!new_links)
 			ieee80211_debugfs_recreate_netdev(sdata, false);
+
+		if (sdata->vif.type == NL80211_IFTYPE_AP)
+			ieee80211_update_apvlan_links(sdata);
 	}
 
 	if (ret) {
-- 
2.34.1


