Return-Path: <linux-wireless+bounces-20811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DBEA70C17
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 22:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F72172D52
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 21:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91743267AFA;
	Tue, 25 Mar 2025 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p4VX3kb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D70269B0E
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938297; cv=none; b=NDenDvt1UbmlTQaz/kkPOtJLQZY3398SoiHuH7KNKiVLGRbc+GVHDsiYBWw6YjaluzlImO4IhYK+FfRUV09gxGl9TPzm5bkSYIGzixlBhx8dyUIlpR81FG6sxhO/i55cheYPBfs1rJEs6rPjJR7a1b/YA7JI78dDb0RnZGZhAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938297; c=relaxed/simple;
	bh=xlPpYZxrEbdhDjnqvstKIsnHGp/r5OK/PMGvKLA+6FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQAD4Z8IAQdjBClwOWIdKaJsf6DV1PdGjKxXnbdT8O0kUc2x0ByUCH734yq/FX6gGNGA0xGrTH8e0dAi3oy0rD0m8RmXa/MT7nJIpZucOyZPP/+ijMpQrq6a7zFsaBLKWyGS4WLPIHxFnx61HU0z2BdcM0WGPiarXZLUiB1Eh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p4VX3kb1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGbRAu019493
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GemHHJ12Mto
	TyleGrTYWRbYILqu0SN/GN7NcVJJQTCM=; b=p4VX3kb1Xu1uSS/gaD+Ty6Ar7RG
	Lw2tpl9lopNAsn0vJvjoFLnzEyqD2lgZ9c3O8TcqISvtCRHMY8G/CU9tz6nfzpN7
	qpnRKW3BdHBo75VOmDq2/u2gY7ixnhpsfpq23fbu3PM/8XzXH8tZmf/oLVdyRhpK
	mEJv8PimiV3buaWXWbshOYODhJml7acITS0aD5dm2VxScXMLw+ZELLrTgPpL3VmA
	CorgIE3L46Yk9XhHxWAszIKYI/+TV9B+Y0xLzRtWMuJJnek8bjebGH8jqDLLdrQM
	f7STwp67qRD3M3mXM0cDrrkyEgZ2Wm0AzFYlqL8DOGQFlXvx1LFylUvfKlA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kyr9gqd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224347aef79so153249945ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 14:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938293; x=1743543093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GemHHJ12MtoTyleGrTYWRbYILqu0SN/GN7NcVJJQTCM=;
        b=KrjWO0fiSnwO1TCRiipk1yjC4uwqem0H4AQLC0nSTlhjVSZEXC8YHqI1u2iBOip5gM
         wzYAS2ZjEMLZLlkoBltNpi8h0oDCAmb01PC9uRv4tpbQDjgxBwSJx2eCVZ8zt7DSWsVg
         xCYK2Bi2n1QhWwO0aJmyUk0E4exWCsIBVTWxEVfluR1kKQAATNBpjGOWMfpESJSATR+U
         kuSCxVZP+im6cUl7cYh47NIGXIRqNhm+MJbuHAaaqyWnBEj8bVsPFDZL0nf2J6MJL9Hq
         livP/f4O/BAWxLwPAHF84Oq1rU8G7gCmJn/JhEJU6bmLKL6KmzQHOte8EdO3SvYhdmEN
         /Glg==
X-Gm-Message-State: AOJu0YyxLd6fQNc9aIRuK0wRsdq5NQhB9yAq9nFt6KqfbPC8phS1eezx
	vf0EvEG4D9UTiroSn5wkyLqwTcxn16eRhGS5hpxsxqVHczSsiZOgBiR/LbNGM1DJhrDnrdRwP6S
	3AO1/j5wmLpFLyv1UWiJxmtKBrPX4t5JqUdMUkvaK+WYp78HhP2uYcKZ3FSZLTUF2HiRS6xr3Mg
	==
X-Gm-Gg: ASbGncsK4xjQEj8UuvEDWiQHyH4AGMWdfxBYfqEt62Bbv1NlpGk/flUoxHlI8Uw6bbc
	4kOXIZ/NawSTqwKMP4xAJVkYHUHVxkDIJn/KFw7k8UGhdzLXHtiNo4tudkF03fkHA5yhttbuNfW
	RwX7qW2Z9y65NflYT2bY/eS+8yZUrKHqTzaXi5Ap7XMyo7dx5tPhj6ILmaGu6zoDOyPE7YYQkyo
	jCOd4aUw3LYx4oB5HdlHZGyKQeHdjOYbDkS3HH/NA8uHtrVZll7Gi85IcHLW9LnmmA0Y+uAU2Z7
	licyrlK6hNOUnKQpcTlWZTaQXCnzjOTrkapmMSb4cZPWYTgnTp9ihfzmGiU925AJSDwZuau+
X-Received: by 2002:a17:903:32ce:b0:223:6455:8752 with SMTP id d9443c01a7336-22780e17fabmr284959935ad.43.1742938292506;
        Tue, 25 Mar 2025 14:31:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCBfydGL+W11JGyBDl6WakpyBds87VBOs0GA+1mhiZAMHTqv5Y8fEM4znvzdzjlsMYI9AjuQ==
X-Received: by 2002:a17:903:32ce:b0:223:6455:8752 with SMTP id d9443c01a7336-22780e17fabmr284959525ad.43.1742938291972;
        Tue, 25 Mar 2025 14:31:31 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a2b5sm95599395ad.50.2025.03.25.14.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:31 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 2/3] wifi: mac80211: Create separate links for VLAN interfaces
Date: Tue, 25 Mar 2025 14:31:24 -0700
Message-Id: <20250325213125.1509362-3-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325213125.1509362-1-muna.sinada@oss.qualcomm.com>
References: <20250325213125.1509362-1-muna.sinada@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9VRmLumWeHquE8ZxEBRr8k9LNvRHfp94
X-Authority-Analysis: v=2.4 cv=UblRSLSN c=1 sm=1 tr=0 ts=67e320b6 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=3cN5iMaFtk8YwWzRkEUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 9VRmLumWeHquE8ZxEBRr8k9LNvRHfp94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_09,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250143

Currently, MLD links for an AP_VLAN interface type is not fully
supported.

Add allocation of separate links for each VLAN interface and copy
chanctx and chandef of AP bss to VLAN where necessary. Separate
links are created because for Dynamic VLAN each link will have its own
default_multicast_key.

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
v4: Utilize new link iteration macro

v3: rebase to cleanly apply to wireless-next

v2:
 - move clearing links for AP_VLAN into seperate function:
   ieee80211_apvlan_link_clear()
 - remove use of goto
 - replaced "master" terminalogy with "AP bss"
 - update Author signoff to new email

---
 net/mac80211/chan.c        |  3 ++
 net/mac80211/ieee80211_i.h |  3 ++
 net/mac80211/iface.c       | 12 ++++-
 net/mac80211/link.c        | 90 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index c3bfac58151f..3aaf5abf1acc 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -2131,6 +2131,9 @@ void ieee80211_link_release_channel(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		return;
+
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (rcu_access_pointer(link->conf->chanctx_conf))
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index c956072e0d77..e0b44dbebe00 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2087,6 +2087,9 @@ static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata
 	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
+void ieee80211_apvlan_link_setup(struct ieee80211_sub_if_data *sdata);
+void ieee80211_apvlan_link_clear(struct ieee80211_sub_if_data *sdata);
+
 /* tx handling */
 void ieee80211_clear_tx_pending(struct ieee80211_local *local);
 void ieee80211_tx_pending(struct tasklet_struct *t);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b0423046028c..9ab64eb4379e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -485,6 +485,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	case NL80211_IFTYPE_MONITOR:
 		list_del_rcu(&sdata->u.mntr.list);
 		break;
+	case NL80211_IFTYPE_AP_VLAN:
+		ieee80211_apvlan_link_clear(sdata);
+		break;
 	default:
 		break;
 	}
@@ -1265,6 +1268,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		sdata->crypto_tx_tailroom_needed_cnt +=
 			master->crypto_tx_tailroom_needed_cnt;
 
+		ieee80211_apvlan_link_setup(sdata);
+
 		break;
 		}
 	case NL80211_IFTYPE_AP:
@@ -1321,7 +1326,12 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_AP_VLAN:
 		/* no need to tell driver, but set carrier and chanctx */
 		if (sdata->bss->active) {
-			ieee80211_link_vlan_copy_chanctx(&sdata->deflink);
+			struct ieee80211_link_data *link;
+
+			for_each_link_data(sdata, link) {
+				ieee80211_link_vlan_copy_chanctx(link);
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


