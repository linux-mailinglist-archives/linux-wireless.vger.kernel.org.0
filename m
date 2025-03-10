Return-Path: <linux-wireless+bounces-20126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A101A5A7E0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 23:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8600C18938F7
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 22:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DD11E834D;
	Mon, 10 Mar 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O8rK83BI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E51E570B
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646138; cv=none; b=bAjlaSwEXV2MGVzmyx/gVeFclcfdlB4zSB6qtxEM89V42yr4/8Gfp9V+bDm8K7Kd8Y8q1As5h9edEEtF0TsJqKNX7JAF6TJJDMGhPDEoyuAcI+xsLmdW54iTSP+ga4LtYrdNHa7sdeWXs2UVH/+EkKk757RkXpbAHsubVw5n/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646138; c=relaxed/simple;
	bh=jtSuHVNX42j2hIwZ17/Lfod6VJseajM5RdjV3/mxblo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrmycALFm3He27rT94cqUoaR/knBEatFPrX6Y2mWABAxMqavI9Y4LIymrIkDJnWVuGx6WZStCCBLcj9eBFURiBN9ozSWOjVmWUI/BY9lk9fAb/eJpoDXa8wv+up8+cHJ7ar1VL1EoVQaNyxIykawcws27wRuBtYzJEWXLqhGbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O8rK83BI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKtTED010520
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 22:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tu09wkQaG7e
	SMxpuSAeucmfjxcWNXdEUXzUOUJECZq4=; b=O8rK83BIPszl19EjdRjIqK1G39X
	OmxzEVjRty064mjRA5jICAahne0vZM5NLosm7PaAJsWP1GnxshOILTfhbaCpVOZR
	60itKSZdd5WCbLr4fw5uN8YJ4FkjOR/+nmjVZaUvllgPqAufvFkoRbfyOKOZIH69
	wXUIJzx3L+i4vkYIwu9citdmBiDILk+Eqh4VMJOS0QlaeKxpZ7j0HVS7OT3NcaL7
	0CdAdBMxTf9W/lT9VETx2zQYk0uNGxwIyTiHwlf4xJddmo6g5UZX13E5gZ0O0nPU
	9eBwh0pm2/n+zvQ7APDbpXglP5R+idZXRaLyVaVUp1bMopugSn2mB7jgL2g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f0px9vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 22:35:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223f63b450eso74175405ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 15:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741646134; x=1742250934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu09wkQaG7eSMxpuSAeucmfjxcWNXdEUXzUOUJECZq4=;
        b=GF5BbmsqPZ3P7rtb/ti/kKUGVSDXVrdOzN6zONPdTuBXETPrSbeXqJsUzt73kaKoBA
         UwLDoqtVhoYOZO0wtAlz55Jy3Ps2jKCKoBipMMAoO8Q2oCH0Qqo9N/76nfaw2s/mym9I
         tEI11OOvvBjQ2Fd6Qh9eXX0peUXN7hLIwGKTRWTmVMcQweOzHNvVr+QPjPCRoBZK5XWd
         F5zzkuVQetQ1080uQWXDyyiX7rv2Q5o2Gjb5+JuEXj0NFZNEoPaZrYU45KlO0Kho80Lt
         FN8leS43cDGo2rE2RqXjJ0SkE5IG85i4SH/XxzOi47k3UTMcNnulEfX55uDVUVkLmyhk
         hHXA==
X-Gm-Message-State: AOJu0YxOSanVqpPsRv3SWe7LfYzOxAYldoY//+P/rjYU04ywEWVarHM/
	BXZ1bOp1Bk0CpvOQjmBxRhdiz6oRMd1z+i3+FiYDYSYRLXUIhH4daEY+gn8fUg7rQoQVptTogNn
	HcpfX/TuCba2mBC2HaS4N6YCXsA5xyLMOvel60dNZsgMB/OLhqCALXD2sjqIrf2h6i8XxHkCraA
	==
X-Gm-Gg: ASbGncs1CFt4ofzFeAVZXC+H8025TJJJKFv++ScS4xsWxcR/05xfivDPWu0s7B1pww2
	wrUspASNLF+Cc2ovuPGbWG+4r6FNKkUS/+1F0P2YYK5Wj11Qz07vW7bU0Y1R2YRezgm3b0LbbTY
	8Ji9NXoJu8IENomomMIj8F/UtT9jM1+FiVK2/4YSeoh4c60fXCUSsTA+0jPc29891X9WvnYjvjS
	BIvTAPePHQVsG4vDSjPVUIBjeJWfE3tZYH+uxx97uiN85QRXZu433ec5KSsa3xhqYEqyEvOBY5K
	hNi6SO2xa3cVKG5zLsIKY0hv3MmBHpBEIftSaDdn1vksuNNIE5+q3IPdOmoIj3Kee5O/HCd4
X-Received: by 2002:a17:902:d488:b0:223:3ef1:a30a with SMTP id d9443c01a7336-225931ad489mr14690235ad.45.1741646133679;
        Mon, 10 Mar 2025 15:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgAm/t5mVocvO1D3NUZ2SZgsr2mq2HSSVvDyqOhHrrbn2GmZ8vWvA9qKy3+ffIiPqrF189OQ==
X-Received: by 2002:a17:902:d488:b0:223:3ef1:a30a with SMTP id d9443c01a7336-225931ad489mr14690145ad.45.1741646133302;
        Mon, 10 Mar 2025 15:35:33 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109eba53sm83675825ad.53.2025.03.10.15.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 15:35:32 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [wireless-next v3 1/2] wifi: mac80211: Create separate links for VLAN interfaces
Date: Mon, 10 Mar 2025 15:35:27 -0700
Message-Id: <20250310223528.3528897-2-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310223528.3528897-1-muna.sinada@oss.qualcomm.com>
References: <20250310223528.3528897-1-muna.sinada@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oNcFu_0o5IV3rA6vOpZXfJzaiD_4J9BG
X-Authority-Analysis: v=2.4 cv=KK2gDEFo c=1 sm=1 tr=0 ts=67cf6937 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=oePGa5o3w2l9G-cHKo0A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: oNcFu_0o5IV3rA6vOpZXfJzaiD_4J9BG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100171

Currently, MLD links for an AP_VLAN interface type is not fully
supported.

Add allocation of separate links for each VLAN interface and copy
chanctx and chandef of AP bss to VLAN where necessary. Separate
links are created because for Dynamic VLAN each link will have its own
default_multicast_key.

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
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
 net/mac80211/iface.c       | 22 +++++++++-
 net/mac80211/link.c        | 90 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 112 insertions(+), 6 deletions(-)

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
index 845888ac3d2c..438a418ddf12 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2076,6 +2076,9 @@ static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata
 	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
+void ieee80211_apvlan_link_setup(struct ieee80211_sub_if_data *sdata);
+void ieee80211_apvlan_link_clear(struct ieee80211_sub_if_data *sdata);
+
 /* tx handling */
 void ieee80211_clear_tx_pending(struct ieee80211_local *local);
 void ieee80211_tx_pending(struct tasklet_struct *t);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 33c7c62d19f5..84debd0e4607 100644
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
@@ -1232,7 +1235,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	struct net_device *dev = wdev->netdev;
 	struct ieee80211_local *local = sdata->local;
 	u64 changed = 0;
-	int res;
+	int link_id, res;
 	u32 hw_reconf_flags = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -1264,6 +1267,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		sdata->crypto_tx_tailroom_needed_cnt +=
 			master->crypto_tx_tailroom_needed_cnt;
 
+		ieee80211_apvlan_link_setup(sdata);
+
 		break;
 		}
 	case NL80211_IFTYPE_AP:
@@ -1320,7 +1325,20 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
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


