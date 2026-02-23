Return-Path: <linux-wireless+bounces-32110-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BV5FapMnGnYDQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32110-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:48:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0E01766EA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7EA930C828F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B28366069;
	Mon, 23 Feb 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R8KgHpuI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CA365A10
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850452; cv=none; b=omMHEJeL2GjvrwSwwm0zReDMq7fJCLbgbpulyAJ9tKhZM9M5yo/ktqD3icMglqZM7acXoEsrXFO09kVtXN1wu3uRxIEnbJoILawJtWNBy9tZeXP5r79OvynheK17keAWZiOPC+h9lUEQ3WFGydN+4n4rgy0g38tLJN8b5V+6Xzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850452; c=relaxed/simple;
	bh=rrNKQihW+153iSaKVpWHC2weCvwBRdZTYOu6MIle4D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZBut62wlGeA2kHXGm5DPTD7gvE4DBfIojfOMxIn07i6MPucBCe0BBUb0jtDuu0L1m5O4U4UVwCoPjSdtSoPjlE+RJcY8BV6fDZSNJnwWtfWvHqYK4WB+iS/9SEsgdn6wbC4lE/mjpfPhmOkRKCcIpJ/VBTuISZcbt4000+tmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R8KgHpuI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3xFaXh6yzIA+z4XLTR6NFe8Edw95Yd06ODC+bB+EM7M=;
	t=1771850450; x=1773060050; b=R8KgHpuItP4WIMCx0zJSbRN5mMPf2fMr3Ffnrlxgj31Aj7J
	T04Q/oFdhzNzHC8jqHFpTBreRNuVqvNrEOabN5X4WRZRZqD/pynIFCOmoqmjNBeWCvc+1iuuaTfqi
	ANlxF3jRiXdGSukgMzTMZasjb0Zu05KN0t4l7y2rnjsuA2ObrC+Stv+ziCecgSPD6m4P+XdAlhzlp
	VJq0p5sufZV5zuaTwF/xSUF2aUSWdeZ+GIeJyeqCEkskX/XEPesgi86sD9DJkZ3eTs+LML5c5E/Yi
	6+BPPZgel9YvUx2xDwIYRdJjt/sz5kNekstx5kH+WQLM0fJkFUNeNGltDx+HuHzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vuVF1-0000000H2xI-2lJG;
	Mon, 23 Feb 2026 13:40:47 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH v2 4/8] wifi: mac80211: rework RX packet handling
Date: Mon, 23 Feb 2026 13:38:23 +0100
Message-ID: <20260223133818.20f4ab7aaa41.Ie12ec077142c6a7fdbb58cdfc5660497cc75150e@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223123818.384184-10-benjamin@sipsolutions.net>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32110-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: AC0E01766EA
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

The code has grown over time and it was not correctly handling all
cases. Examples of issues are that for management frames we would match
the received address against the MLD address even though we should not
resolve the station in that case. Another issue was that for data frames
we would not correctly fall back to use link addresses when the driver
does not provide the pubsta already.

The new code still uses the same approach as before. For data frames,
assume that we a valid station exists and interfaces do not need to be
iterated. On the other hand, for non-data frames (or if a data frame
without a station is received) all interfaces must be iterated.

Note that this rework makes mac80211 slightly more strict. For example,
previously mac80211 would have incorrectly accepted a data frame that
was transmitted on the wrong link.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 net/mac80211/rx.c | 282 +++++++++++++++++++++++++++-------------------
 1 file changed, 169 insertions(+), 113 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1b8ec391991f..d76e8ee1a607 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4284,9 +4284,33 @@ static bool
 ieee80211_rx_is_valid_sta_link_id(struct ieee80211_sta *sta, u8 link_id)
 {
 	if (sta->mlo)
-		return !!(sta->valid_links & BIT(link_id));
-	else
-		return sta->deflink.link_id == link_id;
+		return sta->valid_links & BIT(link_id);
+
+	return sta->deflink.link_id == link_id;
+}
+
+static bool ieee80211_rx_data_set_link_sta(struct ieee80211_rx_data *rx,
+					   struct link_sta_info *link_sta)
+{
+	struct sta_info *sta;
+
+	if (WARN_ON_ONCE(!link_sta) ||
+	    !ieee80211_rx_is_valid_sta_link_id(&link_sta->sta->sta,
+					       link_sta->link_id))
+		return false;
+
+	sta = link_sta->sta;
+
+	rx->sta = sta;
+	rx->local = sta->sdata->local;
+	rx->link = rcu_dereference(sta->sdata->link[link_sta->link_id]);
+	if (!rx->link)
+		return false;
+
+	rx->link_id = rx->link->link_id;
+	rx->link_sta = link_sta;
+
+	return true;
 }
 
 static bool ieee80211_rx_data_set_link(struct ieee80211_rx_data *rx,
@@ -5192,53 +5216,18 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 	dev_kfree_skb(skb);
 }
 
-static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
-				       struct sk_buff *skb, bool consume)
+static bool ieee80211_rx_valid_freq(int freq, struct ieee80211_link_data *link)
 {
-	struct link_sta_info *link_sta;
-	struct ieee80211_hdr *hdr = (void *)skb->data;
-	struct sta_info *sta;
-	int link_id = -1;
+	struct ieee80211_chanctx_conf *conf;
 
-	/*
-	 * FIXME: Here we can assume that link addresses have not
-	 * been translated.
-	 *
-	 * Look up link station first, in case there's a
-	 * chance that they might have a link address that
-	 * is identical to the MLD address, that way we'll
-	 * have the link information if needed.
-	 */
-	link_sta = link_sta_info_get_bss(rx->sdata, hdr->addr2);
-	if (link_sta) {
-		sta = link_sta->sta;
-		link_id = link_sta->link_id;
-	} else {
-		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-
-		sta = sta_info_get_bss(rx->sdata, hdr->addr2);
-		if (ieee80211_vif_is_mld(&rx->sdata->vif) &&
-		    status->freq) {
-			struct ieee80211_link_data *link;
-			struct ieee80211_chanctx_conf *conf;
-
-			for_each_link_data_rcu(rx->sdata, link) {
-				conf = rcu_dereference(link->conf->chanctx_conf);
-				if (!conf || !conf->def.chan)
-					continue;
-
-				if (status->freq == conf->def.chan->center_freq) {
-					link_id = link->link_id;
-					break;
-				}
-			}
-		}
-	}
+	if (!freq || link->sdata->vif.type == NL80211_IFTYPE_NAN)
+		return true;
 
-	if (!ieee80211_rx_data_set_sta(rx, sta, link_id))
+	conf = rcu_dereference(link->conf->chanctx_conf);
+	if (!conf || !conf->def.chan)
 		return false;
 
-	return ieee80211_prepare_and_rx_handle(rx, skb, consume);
+	return freq == conf->def.chan->center_freq;
 }
 
 /*
@@ -5252,11 +5241,14 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr;
+	struct link_sta_info *link_sta;
+	struct sta_info *sta;
 	__le16 fc;
 	struct ieee80211_rx_data rx;
-	struct ieee80211_sub_if_data *prev;
 	struct rhlist_head *tmp;
+	bool rx_data_pending;
 	int err = 0;
 
 	fc = ((struct ieee80211_hdr *)skb->data)->frame_control;
@@ -5292,92 +5284,102 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		     ieee80211_is_s1g_beacon(hdr->frame_control)))
 		ieee80211_scan_rx(local, skb);
 
+	/*
+	 * RX of a data frame should only happen to existing stations.
+	 * It is therefore more efficient to use the one provided by the driver
+	 * or search based on the station's address.
+	 *
+	 * Note we will fall through and handle a spurious data frame in the
+	 * same way as a management frame.
+	 */
 	if (ieee80211_is_data(fc)) {
-		struct sta_info *sta, *prev_sta;
-
 		if (link_pubsta) {
-			sta = container_of(link_pubsta->sta,
-					   struct sta_info, sta);
-			if (!ieee80211_rx_data_set_sta(&rx, sta,
-						       link_pubsta->link_id))
-				goto out;
+			sta = container_of(link_pubsta->sta, struct sta_info,
+					   sta);
+			link_sta = rcu_dereference(sta->link[link_pubsta->link_id]);
 
-			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
+			rx.sdata = sta->sdata;
+			if (ieee80211_rx_data_set_link_sta(&rx, link_sta) &&
+			    ieee80211_prepare_and_rx_handle(&rx, skb, true))
 				return;
+
 			goto out;
 		}
 
-		prev_sta = NULL;
+		rx_data_pending = false;
 
+		/* Search for stations on non-MLD interfaces */
 		for_each_sta_info(local, hdr->addr2, sta, tmp) {
-			int link_id;
+			struct ieee80211_link_data *link;
 
-			if (!prev_sta) {
-				prev_sta = sta;
+			if (ieee80211_vif_is_mld(&sta->sdata->vif))
 				continue;
-			}
-
-			rx.sdata = prev_sta->sdata;
-
-			/*
-			 * FIXME: This is not correct as the addr2 cannot be a
-			 * link address if the loop itself is iterated.
-			 */
-			if (prev_sta->sta.mlo) {
-				struct link_sta_info *link_sta;
 
-				link_sta = link_sta_info_get_bss(rx.sdata,
-								 hdr->addr2);
-				if (!link_sta)
-					continue;
+			link = &sta->sdata->deflink;
+			if (!ieee80211_rx_valid_freq(status->freq, link))
+				continue;
 
-				link_id = link_sta->link_id;
-			} else {
-				link_id = sta->deflink.link_id;
+			if (rx_data_pending) {
+				ieee80211_prepare_and_rx_handle(&rx, skb,
+								false);
+				rx_data_pending = false;
 			}
 
-			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
-				goto out;
-
-			ieee80211_prepare_and_rx_handle(&rx, skb, false);
+			rx.sdata = sta->sdata;
+			if (!ieee80211_rx_data_set_link_sta(&rx, &sta->deflink))
+				continue;
 
-			prev_sta = sta;
+			rx_data_pending = true;
 		}
 
-		if (prev_sta) {
-			int link_id;
+		/* And search stations on MLD interfaces */
+		for_each_link_sta_info(local, hdr->addr2, link_sta, tmp) {
+			struct ieee80211_link_data *link;
 
-			rx.sdata = prev_sta->sdata;
+			sta = link_sta->sta;
+			sdata =	sta->sdata;
+			link = rcu_dereference(sdata->link[link_sta->link_id]);
 
-			/*
-			 * FIXME: This is not correct as the addr2 cannot be a
-			 * link address if the loop itself is iterated.
-			 */
-			if (prev_sta->sta.mlo) {
-				struct link_sta_info *link_sta;
-
-				link_sta = link_sta_info_get_bss(rx.sdata,
-								 hdr->addr2);
-				if (!link_sta)
-					goto out;
+			if (!ieee80211_rx_valid_freq(status->freq, link))
+				continue;
 
-				link_id = link_sta->link_id;
-			} else {
-				link_id = sta->deflink.link_id;
+			if (rx_data_pending) {
+				ieee80211_prepare_and_rx_handle(&rx, skb,
+								false);
+				rx_data_pending = false;
 			}
 
-			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
-				goto out;
+			rx.sdata = sta->sdata;
+			if (!ieee80211_rx_data_set_link_sta(&rx, link_sta))
+				continue;
+
+			rx_data_pending = true;
+		}
 
+		if (rx_data_pending) {
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
 				return;
+
 			goto out;
 		}
+
+		/* fall through, e.g. for spurious frame notification */
 	}
 
-	prev = NULL;
+	/*
+	 * This is a management frame (or a data frame without a station) and
+	 * it will be delivered independent of whether a station exists,
+	 * so iterate the interfaces.
+	 */
+	rx_data_pending = false;
+
+	/* We expect the driver to provide frequency information */
+	if (WARN_ON_ONCE(!local->emulate_chanctx && !status->freq))
+		goto out;
 
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		struct ieee80211_link_data *link = NULL;
+
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
@@ -5385,30 +5387,84 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		    sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 			continue;
 
+		/* Try to resolve the station */
+		if (!ieee80211_vif_is_mld(&sdata->vif)) {
+			sta = sta_info_get_bss(sdata, hdr->addr2);
+
+			if (sta) {
+				link_sta = &sta->deflink;
+				link = &sdata->deflink;
+			}
+		} else {
+			link_sta = link_sta_info_get_bss(sdata, hdr->addr2);
+
+			if (link_sta) {
+				sta = link_sta->sta;
+				link = rcu_dereference(sdata->link[link_sta->link_id]);
+			}
+		}
+
 		/*
-		 * frame is destined for this interface, but if it's
-		 * not also for the previous one we handle that after
-		 * the loop to avoid copying the SKB once too much
+		 * If we found a STA and it has a valid link information, then
+		 * RX using the station.
 		 */
+		if (link_sta && link &&
+		    ieee80211_rx_valid_freq(status->freq, link)) {
+			if (rx_data_pending) {
+				ieee80211_prepare_and_rx_handle(&rx, skb, false);
+				rx_data_pending = false;
+			}
+
+			/* No valid_links check as we need to RX beacons */
+
+			rx.sdata = sdata;
+			if (ieee80211_rx_data_set_link_sta(&rx, link_sta))
+				rx_data_pending = true;
 
-		if (!prev) {
-			prev = sdata;
 			continue;
 		}
 
-		rx.sdata = prev;
-		ieee80211_rx_for_interface(&rx, skb, false);
+		/* No station, try to resolve the link and RX */
+		if (ieee80211_vif_is_mld(&sdata->vif)) {
+			struct ieee80211_chanctx_conf *conf;
+			bool found = false;
 
-		prev = sdata;
-	}
+			for_each_link_data_rcu(sdata, link) {
+				conf = rcu_dereference(link->conf->chanctx_conf);
+				if (!conf || !conf->def.chan)
+					continue;
+
+				if (status->freq == conf->def.chan->center_freq) {
+					found = true;
+					break;
+				}
+			}
 
-	if (prev) {
-		rx.sdata = prev;
+			if (!found)
+				link = &sdata->deflink;
+		} else {
+			link = &sdata->deflink;
+		}
 
-		if (ieee80211_rx_for_interface(&rx, skb, true))
-			return;
+		if (rx_data_pending) {
+			ieee80211_prepare_and_rx_handle(&rx, skb, false);
+			rx_data_pending = false;
+		}
+
+		rx.sdata = sdata;
+		rx.local = sdata->local;
+		rx.link = link;
+		rx.link_id = link->link_id;
+		rx.sta = NULL;
+		rx.link_sta = NULL;
+
+		rx_data_pending = true;
 	}
 
+	if (rx_data_pending &&
+	    ieee80211_prepare_and_rx_handle(&rx, skb, true))
+		return;
+
  out:
 	dev_kfree_skb(skb);
 }
-- 
2.53.0


