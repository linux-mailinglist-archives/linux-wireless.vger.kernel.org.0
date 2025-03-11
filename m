Return-Path: <linux-wireless+bounces-20168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA9DA5BE8D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3543189832D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B3253331;
	Tue, 11 Mar 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dli9FddN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE4250BF8
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691412; cv=none; b=ZzQwYXhgL7SXU1+Jc41OqvOsebsFn9cE+bDvFDJL+UXIrxGVVVm7Maw4OvBqmP91cXBVIc9M6R/fzecLcsllWf1JftiDI6IGjtWmNIk7QDxL4tgVxZlCYUa1id2zhByY09meZs4tipTNEIWpo/G08PT7PNtmDhBgYbJdE5xSEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691412; c=relaxed/simple;
	bh=VhkBZk/DVQukZz1I5F2xas+qB4Zbb8S6v+MnKkp09w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ms3UihC31SSBlgTE9d7jP+xTeNWWjszYRaGhtRB4QGsUHQ+UC4HzmQ1tJ30MYEkIoTFfZgmS8iDq+nvt6PG+q7ITWXzD0uiVG0kSxYrosVfcCpeNhASFAMQcZqIj+bJa54jsXoWdZaprjzSPvTKo69wIh5iaaf9atsrQEWnnu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dli9FddN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ETHiPfeBa4v+Ud78NWvYJVGeDwFRiyAXF/vfO260/OE=;
	t=1741691410; x=1742901010; b=dli9FddNsHZbUuH4Gcvf12qJRBf5MabEGyXoKhBRT1/TB1s
	WnAD0y/OpvGAPgN+U8UYcayQk6Nh1VPhoKZ8TxbCShS6RD2jJ9qrFC0YLiOYkvPaiLeuLDvv3USgm
	E8SZilH+d/DBZDSPXI+/LKKBcNbRwlAih/gRYqQ+rJ+ndYAgntPiQolmMgf7G5hKzTxJK3qsB7b1D
	DvUwQ4fxUl6SwWhHCxNxmnsktkfst159KosJ6km/E0MQZs7FUKIhmLZ5VzVFaMb2l0TadNUX8fVyc
	pOosCvBWUhWMQc+klHX7s+BK9BpxnD9P+myBNOsP+FOoVU5jFy2+uqFtABiMzPkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trxUt-00000007ol7-1YEp;
	Tue, 11 Mar 2025 12:10:07 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 2/2] wifi: mac80211: use supported selectors from assoc in ML reconf
Date: Tue, 11 Mar 2025 12:10:04 +0100
Message-ID: <20250311121004.771de0c36a75.I72f87d048c8693919b99dd9d4eee39833f06d15f@changeid>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311121004.fdf08f90bc30.I07f88d3a6f592a0df65d48f55d65c46a4d261007@changeid>
References: <20250311121004.fdf08f90bc30.I07f88d3a6f592a0df65d48f55d65c46a4d261007@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For multi-link reconfiguration, we shouldn't have any BSS
membership selectors that are different from the association.
Track the association selectors and use them to check the new
link(s) added during reconfiguration.

Fixes: 36e05b0b8390 ("wifi: mac80211: Support dynamic link addition and removal")
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/mlme.c        | 29 +++++++++++------------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 217e949bb756..fb05f3cd37ec 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -444,8 +444,6 @@ struct ieee80211_mgd_assoc_data {
 	const u8 *supp_rates;
 	u8 supp_rates_len;
 
-	unsigned long userspace_selectors[BITS_TO_LONGS(128)];
-
 	unsigned long timeout;
 	int tries;
 
@@ -524,6 +522,8 @@ struct ieee80211_if_managed {
 	struct ieee80211_mgd_auth_data *auth_data;
 	struct ieee80211_mgd_assoc_data *assoc_data;
 
+	unsigned long userspace_selectors[BITS_TO_LONGS(128)];
+
 	bool powersave; /* powersave requested for this iface */
 	bool broken_ap; /* AP is broken -- turn off powersave */
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3dae02345ab8..9bff639b5220 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4164,6 +4164,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	ifmgd->epcs.enabled = false;
 	ifmgd->epcs.dialog_token = 0;
+
+	memset(ifmgd->userspace_selectors, 0,
+	       sizeof(ifmgd->userspace_selectors));
 }
 
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
@@ -6136,7 +6139,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 			err = ieee80211_prep_channel(sdata, link, link_id, cbss,
 						     true, &link->u.mgd.conn,
-						     assoc_data->userspace_selectors);
+						     sdata->u.mgd.userspace_selectors);
 			if (err) {
 				link_info(link, "prep_channel failed\n");
 				goto out_err;
@@ -9400,7 +9403,9 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 					    false);
 	}
 
-	ieee80211_parse_cfg_selectors(assoc_data->userspace_selectors,
+	memset(sdata->u.mgd.userspace_selectors, 0,
+	       sizeof(sdata->u.mgd.userspace_selectors));
+	ieee80211_parse_cfg_selectors(sdata->u.mgd.userspace_selectors,
 				      req->supported_selectors,
 				      req->supported_selectors_len);
 
@@ -9651,7 +9656,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		err = ieee80211_prep_channel(sdata, NULL, i,
 					     assoc_data->link[i].bss, true,
 					     &assoc_data->link[i].conn,
-					     assoc_data->userspace_selectors);
+					     sdata->u.mgd.userspace_selectors);
 		if (err) {
 			req->links[i].error = err;
 			goto err_clear;
@@ -9668,7 +9673,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 					req->ap_mld_addr, true,
 					&assoc_data->link[assoc_link_id].conn,
 					override,
-					assoc_data->userspace_selectors);
+					sdata->u.mgd.userspace_selectors);
 	if (err)
 		goto err_clear;
 
@@ -9912,14 +9917,6 @@ void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif)
 }
 EXPORT_SYMBOL(ieee80211_disable_rssi_reports);
 
-static void ieee80211_ml_reconf_selectors(unsigned long *userspace_selectors)
-{
-	/* these selectors are mandatory for ML reconfiguration */
-	set_bit(BSS_MEMBERSHIP_SELECTOR_SAE_H2E, userspace_selectors);
-	set_bit(BSS_MEMBERSHIP_SELECTOR_HE_PHY, userspace_selectors);
-	set_bit(BSS_MEMBERSHIP_SELECTOR_EHT_PHY, userspace_selectors);
-}
-
 void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_mgmt *mgmt, size_t len)
 {
@@ -9933,7 +9930,6 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 		                sdata->u.mgd.reconf.removed_links;
 	u16 link_mask, valid_links;
 	unsigned int link_id;
-	unsigned long userspace_selectors[BITS_TO_LONGS(128)] = {};
 	size_t orig_len = len;
 	u8 i, group_key_data_len;
 	u8 *pos;
@@ -10041,7 +10037,6 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	}
 
 	ieee80211_vif_set_links(sdata, valid_links, sdata->vif.dormant_links);
-	ieee80211_ml_reconf_selectors(userspace_selectors);
 	link_mask = 0;
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		struct cfg80211_bss *cbss = add_links_data->link[link_id].bss;
@@ -10087,7 +10082,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 		link->u.mgd.conn = add_links_data->link[link_id].conn;
 		if (ieee80211_prep_channel(sdata, link, link_id, cbss,
 					   true, &link->u.mgd.conn,
-					   userspace_selectors)) {
+					   sdata->u.mgd.userspace_selectors)) {
 			link_info(link, "mlo: reconf: prep_channel failed\n");
 			goto disconnect;
 		}
@@ -10423,7 +10418,6 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (added_links) {
 		bool uapsd_supported;
-		unsigned long userspace_selectors[BITS_TO_LONGS(128)] = {};
 
 		data = kzalloc(sizeof(*data), GFP_KERNEL);
 		if (!data)
@@ -10433,7 +10427,6 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 		data->wmm = true;
 
 		uapsd_supported = true;
-		ieee80211_ml_reconf_selectors(userspace_selectors);
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
 		     link_id++) {
 			struct ieee80211_supported_band *sband;
@@ -10509,7 +10502,7 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 						     data->link[link_id].bss,
 						     true,
 						     &data->link[link_id].conn,
-						     userspace_selectors);
+						     sdata->u.mgd.userspace_selectors);
 			if (err)
 				goto err_free;
 		}
-- 
2.48.1


