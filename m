Return-Path: <linux-wireless+bounces-33985-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ91NcJkxWkn+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33985-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:54:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DF3338C36
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89B0F311B1BF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF3928506B;
	Thu, 26 Mar 2026 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FNRFlf//"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECBD41C30E
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543664; cv=none; b=sOT8gcSK3lQZVtPkKRU3pSr6EdS4z2xKDh27WQBaGGrrt52534Fe+Z9BdmtIWIpHlCVQn47gvWnv4px3CkoYoYvpn/0bBOK6bdyX57Um2zO87cJ6rykoPnu/hM67Zggq1rjcobtIJJK/tnFxNXMsejSjweDjCWhtsSSe2UHYqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543664; c=relaxed/simple;
	bh=2fnpkH4x/yOJ41T7Yypw2QQW1MuOPHsc5QL9jxZ9pDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SqzJ8kSV3wwkFJr9BH8mPCKnSttbB1R3iASc/ZNYehaA5Rk4kcTuYjoI98qxr0PVyipdmE3HP48QLyk+yXAnfPzyFIZQE7FcueQu6tKDWCQ9g75u8+EQi6wxowqSk6bwX5TE/1kuz97dIitwvbiq/QpqMQ3Iyl+sAbS0i4bQopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FNRFlf//; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9iCw3373709;
	Thu, 26 Mar 2026 16:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fanMaQF3gAb
	y0McC8hEu00KaokXKTYuX5jxxAmmhxN4=; b=FNRFlf//HFGNLK41JK8TtVoKx9c
	Be4wsx2W3Lc2yfc+FB3fSUyN3K42QlHFTaU0OUDU/NciItIvzJBDioUtmhVKRxKX
	ZfooPEqlrCNa2Z8Ma0jerkngdm3NN1iSxV/1rW/cE19SYETQXlRPsa3vn7IG9XNV
	kbHc+xH1yl+3hWQnfgjzAMXdlV5J8qovkGxemDiI4RGbhUK4ge7dm3rkN9jjoeyh
	5e2G+v+Ipjmiyo39sUHyxTVMTiU8lxGdDfsl1uN6r4P2sAVfTHPWU+MinYIiC7QG
	aQQNxfO1abc6s/ztNZ9CdPbvcXHntjNBkBbxkTS5XVz92xs0hiywL+xa+HA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4qksujhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:36 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QGlX4Z010556;
	Thu, 26 Mar 2026 16:47:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d1mdn6skj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:33 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62QGlXLS010551;
	Thu, 26 Mar 2026 16:47:33 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 62QGlXWM010550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 16:47:33 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 779B8417A3; Thu, 26 Mar 2026 22:17:32 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH wireless-next 1/3] wifi: mac80211: synchronize valid links for WDS AP_VLAN interfaces
Date: Thu, 26 Mar 2026 22:17:21 +0530
Message-Id: <20260326164723.553927-2-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326164723.553927-1-tamizh.raja@oss.qualcomm.com>
References: <20260326164723.553927-1-tamizh.raja@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExOSBTYWx0ZWRfX5rbmT65/ZUpF
 xOzPA7AyebgTFsg2sN2UHfvknVIym2PySJkhRsu0zOOMFIsim7aZONlt0+i9H+vRPzmTbUUfBX4
 HRwSTJYYGW62b402EpVbBkmbwvnVUE087QY4oHXZ1ies9ckd8pwzaLBJSruMfAbH0igel0fL0gf
 xEcT7+7oKBodpoxB6eKk/RTWJQAmBcwAcbDwbzF+Q5jXfp0gH05E5J1Ofpi8KCPXv0IkHdvPOFT
 YSd902T+gzYY76x0P5qRbwcm6E3oCf0ntX6jDAttscnuQQPR4PsqhnuHjCngoKZqdia6x7PxVRd
 vzTjwKoqdCwSRjQWd+EfBVv4noEbf5wFgVjen+xB1SUIe0haFtrgDHVQMPoVJeLT9GOuN/WrYbS
 Xull1snXn/IrnC8D8kevnLawxe36cJwVZ1uO5zChDedK1LkaFZ7/xFCk8Vz7ppAhCkHDi9MvfNy
 7vCEq7RMO/c2MfXxDuQ==
X-Proofpoint-ORIG-GUID: ZK6ZQmf08GDK-sb4ZHJy0Oh0I9Bdke1h
X-Authority-Analysis: v=2.4 cv=eOMeTXp1 c=1 sm=1 tr=0 ts=69c56328 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=2Gf0lDweJzrqxerLSDIA:9
X-Proofpoint-GUID: ZK6ZQmf08GDK-sb4ZHJy0Oh0I9Bdke1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260119
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33985-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 53DF3338C36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current code does not provide any link-configuration support
for 4-address mode WDS AP_VLAN interfaces in MLO setups, preventing
MLD stations from being added correctly. Add the required handling
to enable proper integration of 4-address WDS stations into
an MLO environment.

When a 4-address station associates with an MLO AP, compute the
intersection of valid links between the master AP interface and
the station's advertised capabilities. Configure the AP_VLAN interface
with only these common links to ensure correct data-path operation.

This update ensures AP_VLAN interfaces correctly track link-state
transitions and maintain consistent addressing across all active MLO links.

Co-developed-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 net/mac80211/cfg.c  | 67 +++++++++++++++++++++++++++++++++++++++++----
 net/mac80211/chan.c |  8 ++++++
 net/mac80211/link.c | 43 ++++++++++++++++++++---------
 3 files changed, 100 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 13132215afb4..e4f28e33400c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2444,6 +2444,65 @@ static int ieee80211_del_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 	return 0;
 }
 
+static int ieee80211_set_sta_4addr(struct ieee80211_local *local,
+				   struct ieee80211_sub_if_data *sdata,
+				   struct sta_info *sta)
+{
+	struct ieee80211_vif *vif = &sdata->vif;
+	struct wiphy *wiphy = local->hw.wiphy;
+	struct ieee80211_sub_if_data *master;
+	struct ieee80211_bss_conf *link_conf;
+	struct wireless_dev *wdev;
+	unsigned long master_iter;
+	int link_id;
+	int err;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (sdata->u.vlan.sta)
+		return -EBUSY;
+
+	wdev = &sdata->wdev;
+	master = container_of(sdata->bss,
+			      struct ieee80211_sub_if_data,
+			      u.ap);
+
+	if (sta->sta.valid_links) {
+		u16 sta_links = sta->sta.valid_links;
+		u16 new_links = master->vif.valid_links & sta_links;
+		u16 orig_links = wdev->valid_links;
+
+		wdev->valid_links = new_links;
+
+		err = ieee80211_vif_set_links(sdata, new_links, 0);
+		if (err) {
+			wdev->valid_links = orig_links;
+			return err;
+		}
+
+		master_iter = master->vif.valid_links;
+
+		for_each_set_bit(link_id, &master_iter,
+				 IEEE80211_MLD_MAX_NUM_LINKS) {
+			if (!(sta_links & BIT(link_id))) {
+				eth_zero_addr(wdev->links[link_id].addr);
+			} else {
+				link_conf = wiphy_dereference(wiphy,
+							      vif->link_conf[link_id]);
+
+				ether_addr_copy(wdev->links[link_id].addr,
+						link_conf->bssid);
+			}
+		}
+	}
+
+	rcu_assign_pointer(sdata->u.vlan.sta, sta);
+	__ieee80211_check_fast_rx_iface(sdata);
+	drv_sta_set_4addr(local, sta->sdata, &sta->sta, true);
+
+	return 0;
+}
+
 static int ieee80211_change_station(struct wiphy *wiphy,
 				    struct wireless_dev *wdev, const u8 *mac,
 				    struct station_parameters *params)
@@ -2500,12 +2559,10 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 		vlansdata = IEEE80211_DEV_TO_SUB_IF(params->vlan);
 
 		if (params->vlan->ieee80211_ptr->use_4addr) {
-			if (vlansdata->u.vlan.sta)
-				return -EBUSY;
+			err = ieee80211_set_sta_4addr(local, vlansdata, sta);
+			if (err)
+				return err;
 
-			rcu_assign_pointer(vlansdata->u.vlan.sta, sta);
-			__ieee80211_check_fast_rx_iface(vlansdata);
-			drv_sta_set_4addr(local, sta->sdata, &sta->sta, true);
 		}
 
 		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN &&
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 1e4bfcd25697..9bacc840bed7 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1239,6 +1239,10 @@ __ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 		struct ieee80211_bss_conf *vlan_conf;
 
+		if (vlan->vif.valid_links &&
+		    !(vlan->vif.valid_links & BIT(link_id)))
+			continue;
+
 		vlan_conf = wiphy_dereference(local->hw.wiphy,
 					      vlan->vif.link_conf[link_id]);
 		if (WARN_ON(!vlan_conf))
@@ -1482,6 +1486,10 @@ ieee80211_link_update_chanreq(struct ieee80211_link_data *link,
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 		struct ieee80211_bss_conf *vlan_conf;
 
+		if (vlan->vif.valid_links &&
+		    !(vlan->vif.valid_links & BIT(link_id)))
+			continue;
+
 		vlan_conf = wiphy_dereference(sdata->local->hw.wiphy,
 					      vlan->vif.link_conf[link_id]);
 		if (WARN_ON(!vlan_conf))
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 03bfca27d205..93e290dd783f 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -14,26 +14,38 @@
 
 static void ieee80211_update_apvlan_links(struct ieee80211_sub_if_data *sdata)
 {
+	unsigned long rem = ~sdata->vif.valid_links &
+				    GENMASK(IEEE80211_MLD_MAX_NUM_LINKS - 1, 0);
+	struct ieee80211_local *local = sdata->local;
+	unsigned long add = sdata->vif.valid_links;
+	struct wiphy *wiphy = local->hw.wiphy;
 	struct ieee80211_sub_if_data *vlan;
 	struct ieee80211_link_data *link;
-	u16 ap_bss_links = sdata->vif.valid_links;
-	u16 new_links, vlan_links;
-	unsigned long add;
+	struct sta_info *sta;
 
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 		int link_id;
 
-		/* No support for 4addr with MLO yet */
-		if (vlan->wdev.use_4addr)
-			return;
+		if (vlan->wdev.use_4addr) {
+			sta = wiphy_dereference(wiphy,
+						vlan->u.vlan.sta);
+			if (sta)
+				add = add & sta->sta.valid_links;
+		}
 
-		vlan_links = vlan->vif.valid_links;
+		if (add == vlan->vif.valid_links)
+			continue;
 
-		new_links = ap_bss_links;
+		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+			vlan->wdev.valid_links |= BIT(link_id);
+			ether_addr_copy(vlan->wdev.links[link_id].addr,
+					sdata->wdev.links[link_id].addr);
+		}
 
-		add = new_links & ~vlan_links;
-		if (!add)
-			continue;
+		for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+			vlan->wdev.valid_links &= ~BIT(link_id);
+			eth_zero_addr(vlan->wdev.links[link_id].addr);
+		}
 
 		ieee80211_vif_set_links(vlan, add, 0);
 
@@ -96,8 +108,13 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 
 		ap_bss = container_of(sdata->bss,
 				      struct ieee80211_sub_if_data, u.ap);
-		ap_bss_conf = sdata_dereference(ap_bss->vif.link_conf[link_id],
-						ap_bss);
+
+		if (deflink)
+			ap_bss_conf = &ap_bss->vif.bss_conf;
+		else
+			ap_bss_conf = sdata_dereference(ap_bss->vif.link_conf[link_id],
+							ap_bss);
+
 		memcpy(link_conf, ap_bss_conf, sizeof(*link_conf));
 	}
 
-- 
2.34.1


