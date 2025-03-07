Return-Path: <linux-wireless+bounces-19970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65A0A55C12
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 01:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA423A687A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 00:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0867E611E;
	Fri,  7 Mar 2025 00:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NrGCO0hn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5D9454
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 00:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307872; cv=none; b=gN3mBXJZ42CALWupV3qNmynVuRBxLnxA8UXEOoxssy4e40SQq344jKFrSe+2qr1/B9zg+wSf/AhsKhD15EX2Rgj5UA84wpVo/PLegoQFZPH0uG+6w8XdVgfv2SVELzykHNZugMVuQUmtPNpeQo+sJiXSJ5VDecjGECJ2IbFIMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307872; c=relaxed/simple;
	bh=mlqVMxB4erT8Xq7SiHR181pnbZK052Q3iJfvX6k0oWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbgsXmThWFZ+LWejomk9Om7NV/IF0gMNG8Q74tfg9lJ1ln8eEq0BH3IcZXjTqDxhQAV16ksYZRol43E2l8fX7/QrWgyM5Ie1Esa3Mv4DVYlOQECxPHBazwbKaHvsXchc3vwYHUcmT1sSgslGR+mQLa2kJaFTjfjnkuQJs2RWS0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NrGCO0hn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526G8h77005496
	for <linux-wireless@vger.kernel.org>; Fri, 7 Mar 2025 00:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mx3ArUN7ekz
	5VVT16aGsegJVxVTNRtF6nFZeS6A3Q4Y=; b=NrGCO0hnj5IV9LWZhrhXvO933kG
	LxP+i1u0JvozTwOrrH/nnOClJ8l4hdoc1B/mPeWGXouwxItkFhU/G/1RUxMKFyYY
	071oB/Ij8Vp6P1Fnh6odxewwOBjzMZn2jqa+fH4twDjpuOFx1yyp+5glMFSLZzkQ
	eqLlZ6fkxJBOQbz/w3SPDhalUWgxuIw68UtP9tjNSo9t/6O2h2XxAO78VTfhvRnC
	8GwrwOzKz2V6rWShi+t+AiTU6XcCS2mjYxTo6tznvD9E8eXPmOMvdhBEiJp2OfEh
	iEB8Ct8tpGz1a6XwMrla8TPnr/5g8ffkRXO6/HI57joqchDf4gvcHsSsfqw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4577mxapaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Mar 2025 00:37:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22368a8979cso22217625ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 06 Mar 2025 16:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741307868; x=1741912668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx3ArUN7ekz5VVT16aGsegJVxVTNRtF6nFZeS6A3Q4Y=;
        b=EqaDoNPo5EyOLT7caCGQ9+IIHFzzqOHXPVWt/VBCOaWk9GlRZYaGpqsYU5ag+belBU
         x2UsnZM5wtTkt25j8Y7/2uAuWELSTv9DS8xiWe5kagyXKTZDTs7BFhhDWcgVLCabIbcV
         YA6vQl+y9qs39Nsq8AXLx306lzu7no8zX0biWVDJabLq4RzWFnnmD4m2Z4gIns8MPRxg
         KZmxwq5YMeTu70LyyIOK6xLsMwPyiX1UEsogRNvZ07uo+XQiuU7dZTc2atIBJTgdmNXM
         TqcAA5Ulxqi8GR6awrrLVSe8awCCOb2GMLg8H68we8ukrt3aKRdiR6s/zbgUIoCfqrse
         eoOw==
X-Gm-Message-State: AOJu0YyGR5Y3CAbTI044SNCPRgO72YiaojpElGUz+Z6oX5c32kiZGFc+
	ApfaNHYOvA3pIjuYQM0Z7+y37fmXuwIC16MLTJQKswWrQCd9q7qLXoGEND/M/+1yLFV/FPoorZL
	8x3A6TBToGMWCOeV0mzDPL2u9U9T3MgIap2WYvJmzWEXKfjDo8x+FG9u2TTAXKiJnUA==
X-Gm-Gg: ASbGncsFuUpRr7ygkvZn0mJYXNMQxv2A4f3LRADiXPcjRZmwr7GSjAHaG0gVK7EPN5o
	Di1kbSD0zwc5qKugt+UkkmLwufH/OFWJdubGTcIdiCyrcEKH9ibwK4FvbunTj3nVoARvtq+RIzi
	8IrVnQ2hSW6K7PMom73G61SMGLOWC7yGNkFrsULALAZKPYZzAk2yvgfRD0MM/hsVYrzVnwaFgWW
	GMwcW1/6zszIImcLNQ8KqceiEVG88huPv0fOlYv4eH5upON66w16LSUoTELT1XqN3x2kGnVMUMw
	A9kAfv7YQhgjdrblVW1cGInlnZzcOUQcEu2kLDoOI+UMYndR9leoEkxqW3SRrIZPNvXf1ZT7
X-Received: by 2002:a17:902:f54e:b0:223:54aa:6d15 with SMTP id d9443c01a7336-2242888bfcemr25169565ad.12.1741307868068;
        Thu, 06 Mar 2025 16:37:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFofBiJEEItktv9y6ue5riplfOtPVGn2WQ+G/PDPOOQXvXhrN245JSEvnh4sAuPC4Z0GTsFlg==
X-Received: by 2002:a17:902:f54e:b0:223:54aa:6d15 with SMTP id d9443c01a7336-2242888bfcemr25169165ad.12.1741307867546;
        Thu, 06 Mar 2025 16:37:47 -0800 (PST)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8b6sm18559185ad.136.2025.03.06.16.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 16:37:47 -0800 (PST)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [wireless-next v2 1/2] wifi: mac80211: Create separate links for VLAN interfaces
Date: Thu,  6 Mar 2025 16:37:39 -0800
Message-Id: <20250307003740.1329351-2-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307003740.1329351-1-muna.sinada@oss.qualcomm.com>
References: <20250307003740.1329351-1-muna.sinada@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AWUhQAVIwxEPaWv1kK5dWdmyr_TvDxnR
X-Authority-Analysis: v=2.4 cv=cOIaskeN c=1 sm=1 tr=0 ts=67ca3fdd cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=oePGa5o3w2l9G-cHKo0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: AWUhQAVIwxEPaWv1kK5dWdmyr_TvDxnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_08,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 mlxlogscore=965
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070001

Currently, MLD links for an AP_VLAN interface type is not fully
supported.

Add allocation of separate links for each VLAN interface and copy
chanctx and chandef of AP bss to VLAN where necessary. Separate
links are created because for Dynamic VLAN each link will have its own
default_multicast_key.

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
v2:
 - move clearing links for AP_VLAN into seperate function:
   ieee80211_apvlan_link_clear()
 - remove use of goto
 - replaced "master" terminalogy with "AP bss"
 - update Author signoff to new email

---
 net/mac80211/chan.c        |  3 ++
 net/mac80211/ieee80211_i.h |  3 ++
 net/mac80211/iface.c       | 22 +++++++++-
 net/mac80211/link.c        | 90 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 112 insertions(+), 6 deletions(-)

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
index 9f0db39b28ff..a7778d9b401c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2057,6 +2057,9 @@ static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata
 	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
+void ieee80211_apvlan_link_setup(struct ieee80211_sub_if_data *sdata);
+void ieee80211_apvlan_link_clear(struct ieee80211_sub_if_data *sdata);
+
 /* tx handling */
 void ieee80211_clear_tx_pending(struct ieee80211_local *local);
 void ieee80211_tx_pending(struct tasklet_struct *t);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 806dffa48ef9..e688e7eb3ad4 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -493,6 +493,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 			break;
 		list_del_rcu(&sdata->u.mntr.list);
 		break;
+	case NL80211_IFTYPE_AP_VLAN:
+		ieee80211_apvlan_link_clear(sdata);
+		break;
 	default:
 		break;
 	}
@@ -1236,7 +1239,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	struct net_device *dev = wdev->netdev;
 	struct ieee80211_local *local = sdata->local;
 	u64 changed = 0;
-	int res;
+	int link_id, res;
 	u32 hw_reconf_flags = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -1268,6 +1271,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		sdata->crypto_tx_tailroom_needed_cnt +=
 			master->crypto_tx_tailroom_needed_cnt;
 
+		ieee80211_apvlan_link_setup(sdata);
+
 		break;
 		}
 	case NL80211_IFTYPE_AP:
@@ -1324,7 +1329,20 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
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
index 58a76bcd6ae6..d40c2bd3b50b 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -12,6 +12,71 @@
 #include "key.h"
 #include "debugfs_netdev.h"
 
+static void ieee80211_update_apvlan_links(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_sub_if_data *vlan;
+	struct ieee80211_link_data *link;
+	u16 ap_bss_links = sdata->vif.valid_links;
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
+		new_links = ap_bss_links;
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
+	struct ieee80211_sub_if_data *ap_bss = container_of(sdata->bss,
+					    struct ieee80211_sub_if_data, u.ap);
+	u16 new_links = ap_bss->vif.valid_links;
+	unsigned long add;
+	int link_id;
+
+	if (!ap_bss->vif.valid_links)
+		return;
+
+	add = new_links;
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		sdata->wdev.valid_links |= BIT(link_id);
+		ether_addr_copy(sdata->wdev.links[link_id].addr,
+				ap_bss->wdev.links[link_id].addr);
+	}
+
+	ieee80211_vif_set_links(sdata, new_links, 0);
+}
+
+void ieee80211_apvlan_link_clear(struct ieee80211_sub_if_data *sdata)
+{
+	if (!sdata->wdev.valid_links)
+		return;
+
+	sdata->wdev.valid_links = 0;
+	ieee80211_vif_clear_links(sdata);
+}
+
 void ieee80211_link_setup(struct ieee80211_link_data *link)
 {
 	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
@@ -31,6 +96,17 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
 	rcu_assign_pointer(sdata->link[link_id], link);
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		struct ieee80211_sub_if_data *ap_bss;
+		struct ieee80211_bss_conf *ap_bss_conf;
+
+		ap_bss = container_of(sdata->bss,
+				      struct ieee80211_sub_if_data, u.ap);
+		ap_bss_conf = sdata_dereference(ap_bss->vif.link_conf[link_id],
+						ap_bss);
+		memcpy(link_conf, ap_bss_conf, sizeof(*link_conf));
+	}
+
 	link->sdata = sdata;
 	link->link_id = link_id;
 	link->conf = link_conf;
@@ -54,6 +130,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	if (!deflink) {
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_AP_VLAN:
 			ether_addr_copy(link_conf->addr,
 					sdata->wdev.links[link_id].addr);
 			link_conf->bssid = link_conf->addr;
@@ -177,6 +254,7 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_AP_VLAN:
 		/* in an AP all links are always active */
 		sdata->vif.active_links = valid_links;
 
@@ -278,12 +356,16 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
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


