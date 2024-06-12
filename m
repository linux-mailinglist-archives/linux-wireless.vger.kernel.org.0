Return-Path: <linux-wireless+bounces-8867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88890527C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3497F281C28
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7316F904;
	Wed, 12 Jun 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hXT7fCCj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE0172BB4
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195452; cv=none; b=kzax9fsaoymxfCIEtcjUnf+4ValC3eTeDjZs5b/HD8Q3hPRaNBVZj9MVdyituVpProuKL3LTHuZm0PAnUkasgJqALGFdAoouhopmek0WQlN9g2gRrcjbyQOJ9k4UFwnOibXKxNZDNl53beNnfO560o6aoXDE2V1Z1bgqZBpxrY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195452; c=relaxed/simple;
	bh=rXWVpPJSmrZeIMwIYPumKfK4GVLNb4W1vc4dJkf2o4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6E/XRVh3PzIC8bfNfvMDKp5VaZivulqNf3AyJHW9P+HS/8MUPd9nwTtjp9Zb3UpuWe4JFnhtSGoMVyFrY23tMy0jP56qXakXaFtjU62zovEyXZAKIJqtGUgxvj4+PA4bJe95jMP6rbbERVHczqaPc0Yzw8sHuXIAghiIhgot44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hXT7fCCj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=f+tBL6jsuxg4/cteUR+Zg4T0+hK93MbFfuCAnwuxS4Q=;
	t=1718195450; x=1719405050; b=hXT7fCCjOIGXwFWbtinKEi9/jLM9pd0QXaVcD38g7ONDxQt
	AxDdBf9CZnEgZ5C36Ygzkykj0+EFu4Fxe80p/rprTVixmbO+KLlKbCiJtldX3hhy6oCrHEV4+ZbtF
	RXSkVf56f5G8Ld5AfRbLV77cztGDbNj/MsuWF0NQEFZ50w1Gryl6w7Gk5bbP4rFtyrGKhTkT8zHpK
	yVOAP1dJwjTm4ThTBmqjut5PSBOqHoZAAMy3OIArAASPEKhFJflZPGbdAo39jJci765L/dr8sTq9m
	vyTdLeXexUsltJtBc2Mhp2QBKxFRC68HdlXFMZIS6JNBaFZkTAEjgFjlhLXXwEsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHN7m-0000000AGRh-07bo;
	Wed, 12 Jun 2024 14:30:46 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/3] wifi: mac80211: restrict public action ECSA frame handling
Date: Wed, 12 Jun 2024 14:28:36 +0200
Message-ID: <20240612143037.ec7ccc45903e.Ife17d55c7ecbf98060f9c52889f3c8ba48798970@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612123037.36687-5-johannes@sipsolutions.net>
References: <20240612123037.36687-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Public action extended channel switch announcement (ECSA)
frames cannot be protected well, the spec is unclear about
what should happen in the presence of stations that can
receive protected dual and stations that cannot.

Mitigate these issues by not treating public action frames
as the absolute truth, only treat them as a hint to stop
transmitting (quiet mode), and do the remainder of the CSA
handling only when receiving the next beacon (or protected
action frame) that contains the CSA; or, if it doesn't,
simply stop being quiet and continue operating normally.

This limits the exposure to malicious ECSA public action
frames, since they cannot cause a disconnect now, only a
short interruption in traffic.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ibss.c        |  3 +-
 net/mac80211/ieee80211_i.h |  4 ++-
 net/mac80211/mesh.c        |  2 +-
 net/mac80211/mlme.c        | 59 ++++++++++++++++++++++++++++++++------
 net/mac80211/spectmgmt.c   | 15 ++++++----
 5 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index bf338f3d4dd3..7db4c3ee7e6d 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -785,7 +785,8 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	err = ieee80211_parse_ch_switch_ie(sdata, elems,
 					   ifibss->chandef.chan->band,
 					   vht_cap_info, &conn,
-					   ifibss->bssid, &csa_ie);
+					   ifibss->bssid, false,
+					   &csa_ie);
 	/* can't switch to destination channel, fail */
 	if (err < 0)
 		goto disconnect;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b482763e9f99..cb3e28f88089 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2218,6 +2218,8 @@ void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
  * @conn: contains information about own capabilities and restrictions
  *	to decide which channel switch announcements can be accepted
  * @bssid: the currently connected bssid (for reporting)
+ * @unprot_action: whether the frame was an unprotected frame or not,
+ *	used for reporting
  * @csa_ie: parsed 802.11 csa elements on count, mode, chandef and mesh ttl.
  *	All of them will be filled with if success only.
  * Return: 0 on success, <0 on error and >0 if there is nothing to parse.
@@ -2227,7 +2229,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 enum nl80211_band current_band,
 				 u32 vht_cap_info,
 				 struct ieee80211_conn_settings *conn,
-				 u8 *bssid,
+				 u8 *bssid, bool unprot_action,
 				 struct ieee80211_csa_ie *csa_ie);
 
 /* Suspend/resume and hw reconfiguration */
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 6d4510221c98..f94e4be0be12 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1312,7 +1312,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	memset(&params, 0, sizeof(params));
 	err = ieee80211_parse_ch_switch_ie(sdata, elems, sband->band,
 					   vht_cap_info, &conn,
-					   sdata->vif.addr,
+					   sdata->vif.addr, false,
 					   &csa_ie);
 	if (err < 0)
 		return false;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ac376ec47a59..fff158b1615f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2352,7 +2352,8 @@ ieee80211_sta_other_link_csa_disappeared(struct ieee80211_link_data *link,
 enum ieee80211_csa_source {
 	IEEE80211_CSA_SOURCE_BEACON,
 	IEEE80211_CSA_SOURCE_OTHER_LINK,
-	IEEE80211_CSA_SOURCE_ACTION,
+	IEEE80211_CSA_SOURCE_PROT_ACTION,
+	IEEE80211_CSA_SOURCE_UNPROT_ACTION,
 };
 
 static void
@@ -2393,7 +2394,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 						   current_band,
 						   bss->vht_cap_info,
 						   &link->u.mgd.conn,
-						   link->u.mgd.bssid, &csa_ie);
+						   link->u.mgd.bssid,
+						   source == IEEE80211_CSA_SOURCE_UNPROT_ACTION,
+						   &csa_ie);
 		if (res == 0) {
 			ch_switch.block_tx = csa_ie.mode;
 			ch_switch.chandef = csa_ie.chanreq.oper;
@@ -2412,12 +2415,17 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		res = 1;
 	}
 
-	if (res < 0)
+	if (res < 0) {
+		/* ignore this case, not a protected frame */
+		if (source == IEEE80211_CSA_SOURCE_UNPROT_ACTION)
+			return;
 		goto drop_connection;
+	}
 
 	if (link->conf->csa_active) {
 		switch (source) {
-		case IEEE80211_CSA_SOURCE_ACTION:
+		case IEEE80211_CSA_SOURCE_PROT_ACTION:
+		case IEEE80211_CSA_SOURCE_UNPROT_ACTION:
 			/* already processing - disregard action frames */
 			return;
 		case IEEE80211_CSA_SOURCE_BEACON:
@@ -2466,9 +2474,35 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		}
 	}
 
-	/* nothing to do at all - no active CSA nor a new one */
-	if (res)
+	/* no active CSA nor a new one */
+	if (res) {
+		/*
+		 * However, we may have stopped queues when receiving a public
+		 * action frame that couldn't be protected, if it had the quiet
+		 * bit set. This is a trade-off, we want to be quiet as soon as
+		 * possible, but also don't trust the public action frame much,
+		 * as it can't be protected.
+		 */
+		if (unlikely(link->u.mgd.csa.blocked_tx)) {
+			link->u.mgd.csa.blocked_tx = false;
+			ieee80211_vif_unblock_queues_csa(sdata);
+		}
 		return;
+	}
+
+	/*
+	 * We don't really trust public action frames, but block queues (go to
+	 * quiet mode) for them anyway, we should get a beacon soon to either
+	 * know what the CSA really is, or figure out the public action frame
+	 * was actually an attack.
+	 */
+	if (source == IEEE80211_CSA_SOURCE_UNPROT_ACTION) {
+		if (csa_ie.mode) {
+			link->u.mgd.csa.blocked_tx = true;
+			ieee80211_vif_block_queues_csa(sdata);
+		}
+		return;
+	}
 
 	if (link->conf->chanreq.oper.chan->band !=
 	    csa_ie.chanreq.oper.chan->band) {
@@ -7453,12 +7487,16 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 					mgmt->u.action.u.chan_switch.variable,
 					ies_len, true, NULL);
 
-			if (elems && !elems->parse_error)
+			if (elems && !elems->parse_error) {
+				enum ieee80211_csa_source src =
+					IEEE80211_CSA_SOURCE_PROT_ACTION;
+
 				ieee80211_sta_process_chanswitch(link,
 								 rx_status->mactime,
 								 rx_status->device_timestamp,
 								 elems, elems,
-								 IEEE80211_CSA_SOURCE_ACTION);
+								 src);
+			}
 			kfree(elems);
 		} else if (mgmt->u.action.category == WLAN_CATEGORY_PUBLIC) {
 			struct ieee802_11_elems *elems;
@@ -7479,6 +7517,9 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 					ies_len, true, NULL);
 
 			if (elems && !elems->parse_error) {
+				enum ieee80211_csa_source src =
+					IEEE80211_CSA_SOURCE_UNPROT_ACTION;
+
 				/* for the handling code pretend it was an IE */
 				elems->ext_chansw_ie =
 					&mgmt->u.action.u.ext_chan_switch.data;
@@ -7487,7 +7528,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 								 rx_status->mactime,
 								 rx_status->device_timestamp,
 								 elems, elems,
-								 IEEE80211_CSA_SOURCE_ACTION);
+								 src);
 			}
 
 			kfree(elems);
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index df96d3db1c0e..e91ca4ccdd37 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -223,7 +223,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 enum nl80211_band current_band,
 				 u32 vht_cap_info,
 				 struct ieee80211_conn_settings *conn,
-				 u8 *bssid,
+				 u8 *bssid, bool unprot_action,
 				 struct ieee80211_csa_ie *csa_ie)
 {
 	enum nl80211_band new_band = current_band;
@@ -258,8 +258,10 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 
 		if (!ieee80211_operating_class_to_band(new_op_class, &new_band)) {
 			new_op_class = 0;
-			sdata_info(sdata, "cannot understand ECSA IE operating class, %d, ignoring\n",
-				   ext_chansw_elem->new_operating_class);
+			if (!unprot_action)
+				sdata_info(sdata,
+					   "cannot understand ECSA IE operating class, %d, ignoring\n",
+					   ext_chansw_elem->new_operating_class);
 		} else {
 			new_chan_no = ext_chansw_elem->new_ch_num;
 			csa_ie->count = ext_chansw_elem->count;
@@ -293,9 +295,10 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	new_freq = ieee80211_channel_to_frequency(new_chan_no, new_band);
 	new_chan = ieee80211_get_channel(sdata->local->hw.wiphy, new_freq);
 	if (!new_chan || new_chan->flags & IEEE80211_CHAN_DISABLED) {
-		sdata_info(sdata,
-			   "BSS %pM switches to unsupported channel (%d MHz), disconnecting\n",
-			   bssid, new_freq);
+		if (!unprot_action)
+			sdata_info(sdata,
+				   "BSS %pM switches to unsupported channel (%d MHz), disconnecting\n",
+				   bssid, new_freq);
 		return -EINVAL;
 	}
 
-- 
2.45.2


