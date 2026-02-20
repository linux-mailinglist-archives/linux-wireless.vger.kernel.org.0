Return-Path: <linux-wireless+bounces-32059-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H+KK+VtmGn4IAMAu9opvQ
	(envelope-from <linux-wireless+bounces-32059-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 15:21:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BE71684BA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 15:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29DBA30A200E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60B334D4E2;
	Fri, 20 Feb 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="H4gEGGSq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC1C34D4CE
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597223; cv=none; b=mpy7I0DlHucAcIT6ElvqYh2fnGqvoICNHzzDyz/LYaH4xoekIRWqr9ETADitREM1MbDnMcbs54/+xsNTHrsNHtl3y5RO/mEKddTo8qCoDJrpxG7NFcoPlGIQ1x2mJQRviI3a8tudypz0pI4FZfWei26vkMRlAyfmJxyzB+EDe18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597223; c=relaxed/simple;
	bh=sMOS0jUgSPNBASUotdrrsf3h3bEUx5N3gLOgPWhldPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRMncBJexNChl7uUkHBi9VwsChPHQsgvfSCoprZOy/8pE50/Xte+Re/HPdJu7bFm1wuOdjHp9oURkG3CUp8rvYCQj+LjgP0gmIZAkyOxqXm1V8dj9VhPIqoa+dfiTIyg6cYspTaAVx/dxq0o/OwRsrXjEZTwb4lQZzCXUReSbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=H4gEGGSq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PMJF0Qk60QBaJbiEyuLH2pngysjULRAgN5QV/2Rd/AI=;
	t=1771597221; x=1772806821; b=H4gEGGSqLEUpVq3xtKrE9GpvOJ7cTpSKbE7eirOd9NIhPi0
	RxMvMAaHq5XlffbF1fvloS0B3v2e4rUsyIyC+YU22EokdlKegT4VCWOjtHp4+xnJ+KzVTJiS/ro5/
	vi+8ChpdjwfCuwvI9SGpQ8JlBH/KxKfxwJRshuSejx/3fhyw+ximaT4rJ/Ddau0N57/QJ1P7Ikth6
	HFieWV94mQD1zJHwCv8HYhgMygdDCB6AMxiduam4LCOJ9KRWv74FQXvfIF8fyEBu0u5sYv/8SQRHE
	zY9jtd+5TZwAugFQSw2hF7ZXT3i++yynZh5Dc5rJ1YxQ4W4l+FjmVQjqBRAXfOxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vtRMa-0000000ECBC-1sDY;
	Fri, 20 Feb 2026 15:20:12 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 3/8] wifi: mac80211: refactor RX link_id and station handling
Date: Fri, 20 Feb 2026 15:19:33 +0100
Message-ID: <20260220151929.5b3a42e30504.I8abe3601d0335dca22d48bcee864817cfccf0de0@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220141929.206976-10-benjamin@sipsolutions.net>
References: <20260220141929.206976-10-benjamin@sipsolutions.net>
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
	TAGGED_FROM(0.00)[bounces-32059-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 07BE71684BA
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

The link ID for one frequency may be different between VIFs. As such,
the sensible thing is to set the link ID later in the flow once the SKB
is duplicated for each VIF. As the link ID is not passed in from outside
mac80211 it is always valid and the corresponding bit can be dropped.

Also switch a few more places to pass the link STA as that is a natural
way to pass the link information around.

This fixes the per-link statistics when frames are reordered.

Note that this patch deliberately leaves some places unchanged and even
incorrect as this will be addressed by further refactorings.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/net/mac80211.h |   9 +-
 net/mac80211/eht.c     |   3 -
 net/mac80211/iface.c   |   7 +-
 net/mac80211/mlme.c    |   9 +-
 net/mac80211/rx.c      | 209 ++++++++++++++++++-----------------------
 net/mac80211/scan.c    |  10 +-
 6 files changed, 105 insertions(+), 142 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4d9dbd35369b..6db15227d4e1 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1655,10 +1655,9 @@ enum mac80211_rx_encoding {
  * @ampdu_reference: A-MPDU reference number, must be a different value for
  *	each A-MPDU but the same for each subframe within one A-MPDU
  * @zero_length_psdu_type: radiotap type of the 0-length PSDU
- * @link_valid: if the link which is identified by @link_id is valid. This flag
- *	is set only when connection is MLO.
- * @link_id: id of the link used to receive the packet. This is used along with
- *	@link_valid.
+ * @link_id: id of the link used to receive the packet. Set and used by
+ *	mac80211 internally, it uses @freq set by the driver to identify the
+ *	correct link per vif.
  */
 struct ieee80211_rx_status {
 	u64 mactime;
@@ -1698,7 +1697,7 @@ struct ieee80211_rx_status {
 	u8 chains;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 	u8 zero_length_psdu_type;
-	u8 link_valid:1, link_id:4;
+	u8 link_id:4;
 };
 
 static inline u32
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 75096b2195d2..f49c4729e8e8 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -174,9 +174,6 @@ void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 	if (!ift_ext_capa)
 		return;
 
-	if (!status->link_valid)
-		return;
-
 	sta = sta_info_get_bss(sdata, mgmt->sa);
 	if (!sta)
 		return;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 676b2a43c9f2..ddb384d7cfa2 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1611,11 +1611,8 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 				break;
 
 			status = IEEE80211_SKB_RXCB(skb);
-			if (!status->link_valid)
-				link_sta = &sta->deflink;
-			else
-				link_sta = rcu_dereference_protected(sta->link[status->link_id],
-							lockdep_is_held(&local->hw.wiphy->mtx));
+			link_sta = wiphy_dereference(local->hw.wiphy,
+						     sta->link[status->link_id]);
 			if (link_sta)
 				ieee80211_ht_handle_chanwidth_notif(local, sdata, sta,
 								    link_sta, chanwidth,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e83582b2c377..4190c2830ac5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8273,12 +8273,9 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 	mgmt = (struct ieee80211_mgmt *) skb->data;
 	fc = le16_to_cpu(mgmt->frame_control);
 
-	if (rx_status->link_valid) {
-		link = sdata_dereference(sdata->link[rx_status->link_id],
-					 sdata);
-		if (!link)
-			return;
-	}
+	link = sdata_dereference(sdata->link[rx_status->link_id], sdata);
+	if (!link)
+		return;
 
 	switch (fc & IEEE80211_FCTL_STYPE) {
 	case IEEE80211_STYPE_BEACON:
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4098f63ec824..1b8ec391991f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -222,43 +222,21 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 }
 
 static void __ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
-					   int link_id,
-					   struct sta_info *sta,
+					   struct link_sta_info *link_sta,
 					   struct sk_buff *skb)
 {
-	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-
-	if (link_id >= 0) {
-		status->link_valid = 1;
-		status->link_id = link_id;
-	} else {
-		status->link_valid = 0;
-	}
-
 	skb_queue_tail(&sdata->skb_queue, skb);
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
-	if (sta) {
-		struct link_sta_info *link_sta_info;
-
-		if (link_id >= 0) {
-			link_sta_info = rcu_dereference(sta->link[link_id]);
-			if (!link_sta_info)
-				return;
-		} else {
-			link_sta_info = &sta->deflink;
-		}
-
-		link_sta_info->rx_stats.packets++;
-	}
+	if (link_sta)
+		link_sta->rx_stats.packets++;
 }
 
 static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
-					 int link_id,
-					 struct sta_info *sta,
+					 struct link_sta_info *link_sta,
 					 struct sk_buff *skb)
 {
 	skb->protocol = 0;
-	__ieee80211_queue_skb_to_iface(sdata, link_id, sta, skb);
+	__ieee80211_queue_skb_to_iface(sdata, link_sta, skb);
 }
 
 static void ieee80211_handle_mu_mimo_mon(struct ieee80211_sub_if_data *sdata,
@@ -301,7 +279,7 @@ static void ieee80211_handle_mu_mimo_mon(struct ieee80211_sub_if_data *sdata,
 	if (!skb)
 		return;
 
-	ieee80211_queue_skb_to_iface(sdata, -1, NULL, skb);
+	ieee80211_queue_skb_to_iface(sdata, NULL, skb);
 }
 
 /*
@@ -1496,7 +1474,7 @@ static void ieee80211_rx_reorder_ampdu(struct ieee80211_rx_data *rx,
 	/* if this mpdu is fragmented - terminate rx aggregation session */
 	sc = le16_to_cpu(hdr->seq_ctrl);
 	if (sc & IEEE80211_SCTL_FRAG) {
-		ieee80211_queue_skb_to_iface(rx->sdata, rx->link_id, NULL, skb);
+		ieee80211_queue_skb_to_iface(rx->sdata, NULL, skb);
 		return;
 	}
 
@@ -2498,7 +2476,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 
  out:
 	ieee80211_led_rx(rx->local);
-	if (rx->sta)
+	if (rx->link_sta)
 		rx->link_sta->rx_stats.packets++;
 	return RX_CONTINUE;
 }
@@ -3309,8 +3287,8 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 		    (tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_REQUEST ||
 		     tf->action_code == WLAN_TDLS_CHANNEL_SWITCH_RESPONSE)) {
 			rx->skb->protocol = cpu_to_be16(ETH_P_TDLS);
-			__ieee80211_queue_skb_to_iface(sdata, rx->link_id,
-						       rx->sta, rx->skb);
+			__ieee80211_queue_skb_to_iface(sdata, rx->link_sta,
+						       rx->skb);
 			return RX_QUEUED;
 		}
 	}
@@ -3956,7 +3934,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	return RX_QUEUED;
 
  queue:
-	ieee80211_queue_skb_to_iface(sdata, rx->link_id, rx->sta, rx->skb);
+	ieee80211_queue_skb_to_iface(sdata, rx->link_sta, rx->skb);
 	return RX_QUEUED;
 }
 
@@ -4113,7 +4091,7 @@ ieee80211_rx_h_ext(struct ieee80211_rx_data *rx)
 		return RX_DROP_U_UNEXPECTED_EXT_FRAME;
 
 	/* for now only beacons are ext, so queue them */
-	ieee80211_queue_skb_to_iface(sdata, rx->link_id, rx->sta, rx->skb);
+	ieee80211_queue_skb_to_iface(sdata, rx->link_sta, rx->skb);
 
 	return RX_QUEUED;
 }
@@ -4170,7 +4148,7 @@ ieee80211_rx_h_mgmt(struct ieee80211_rx_data *rx)
 		return RX_DROP_U_UNHANDLED_MGMT_STYPE;
 	}
 
-	ieee80211_queue_skb_to_iface(sdata, rx->link_id, rx->sta, rx->skb);
+	ieee80211_queue_skb_to_iface(sdata, rx->link_sta, rx->skb);
 
 	return RX_QUEUED;
 }
@@ -4214,12 +4192,28 @@ static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
 	spin_lock_bh(&rx->local->rx_path_lock);
 
 	while ((skb = __skb_dequeue(frames))) {
+		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+
 		/*
-		 * all the other fields are valid across frames
-		 * that belong to an aMPDU since they are on the
-		 * same TID from the same station
+		 * Most fields are valid across frames. However,
+		 * in the case of reordering frames may have arrived
+		 * on different links, so adjust the link_id, link
+		 * and link_sta accordingly.
 		 */
 		rx->skb = skb;
+		if (ieee80211_vif_is_mld(&rx->sdata->vif) &&
+		    unlikely(rx->link_id != status->link_id)) {
+			if (rx->sta) {
+				rx->link_sta =
+					rcu_dereference(rx->sta->link[rx->link_id]);
+
+				/* Link got disabled, just use deflink */
+				if (!rx->link_sta)
+					rx->link_sta = &rx->sta->deflink;
+			}
+			rx->link_id = status->link_id;
+			rx->link = rcu_dereference(rx->sdata->link[status->link_id]);
+		}
 
 		if (WARN_ON_ONCE(!rx->link)) {
 			res = RX_DROP_U_NO_LINK;
@@ -4289,7 +4283,10 @@ static void ieee80211_invoke_rx_handlers(struct ieee80211_rx_data *rx)
 static bool
 ieee80211_rx_is_valid_sta_link_id(struct ieee80211_sta *sta, u8 link_id)
 {
-	return !!(sta->valid_links & BIT(link_id));
+	if (sta->mlo)
+		return !!(sta->valid_links & BIT(link_id));
+	else
+		return sta->deflink.link_id == link_id;
 }
 
 static bool ieee80211_rx_data_set_link(struct ieee80211_rx_data *rx,
@@ -4326,11 +4323,13 @@ static bool ieee80211_rx_data_set_sta(struct ieee80211_rx_data *rx,
 
 	if (link_id < 0) {
 		if (ieee80211_vif_is_mld(&rx->sdata->vif) &&
-		    sta && !sta->sta.valid_links)
+		    sta && !sta->sta.valid_links) {
 			rx->link =
 				rcu_dereference(rx->sdata->link[sta->deflink.link_id]);
-		else
+			rx->link_sta = rcu_dereference(rx->sta->link[link_id]);
+		} else {
 			rx->link = &rx->sdata->deflink;
+		}
 	} else if (!ieee80211_rx_data_set_link(rx, link_id)) {
 		return false;
 	}
@@ -4353,7 +4352,7 @@ void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid)
 	struct tid_ampdu_rx *tid_agg_rx;
 	int link_id = -1;
 
-	/* FIXME: statistics won't be right with this */
+	/* NOTE: the correct link STA for the frame is set later */
 	if (sta->sta.valid_links)
 		link_id = ffs(sta->sta.valid_links) - 1;
 
@@ -4824,20 +4823,14 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 {
 	struct ieee80211_sta_rx_stats *stats;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
-	struct sta_info *sta = rx->sta;
-	struct link_sta_info *link_sta;
+	struct link_sta_info *link_sta = rx->link_sta;
 	struct sk_buff *skb = rx->skb;
 	void *sa = skb->data + ETH_ALEN;
 	void *da = skb->data;
 
-	if (rx->link_id >= 0) {
-		link_sta = rcu_dereference(sta->link[rx->link_id]);
-		if (WARN_ON_ONCE(!link_sta)) {
-			dev_kfree_skb(rx->skb);
-			return;
-		}
-	} else {
-		link_sta = &sta->deflink;
+	if (WARN_ON_ONCE(!link_sta)) {
+		dev_kfree_skb(rx->skb);
+		return;
 	}
 
 	stats = &link_sta->rx_stats;
@@ -5060,6 +5053,9 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		goto drop;
 	}
 
+	status = IEEE80211_SKB_RXCB(skb);
+	status->link_id = rx->link_id < 0 ? 0 : rx->link_id;
+
 	ieee80211_rx_8023(rx, fast_rx, orig_len);
 
 	return true;
@@ -5084,6 +5080,7 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct link_sta_info *link_sta = rx->link_sta;
 	struct ieee80211_link_data *link = rx->link;
+	struct ieee80211_rx_status *status;
 
 	rx->skb = skb;
 
@@ -5127,6 +5124,9 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 		hdr = (struct ieee80211_hdr *)rx->skb->data;
 	}
 
+	status = IEEE80211_SKB_RXCB(rx->skb);
+	status->link_id = rx->link_id < 0 ? 0 : rx->link_id;
+
 	if (unlikely(rx->sta && rx->sta->sta.mlo) &&
 	    is_unicast_ether_addr(hdr->addr1) &&
 	    !ieee80211_is_probe_resp(hdr->frame_control) &&
@@ -5152,22 +5152,19 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 }
 
 static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
-				       struct ieee80211_sta *pubsta,
+				       struct ieee80211_link_sta *link_pubsta,
 				       struct sk_buff *skb,
 				       struct list_head *list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
-	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_fast_rx *fast_rx;
 	struct ieee80211_rx_data rx;
 	struct sta_info *sta;
-	int link_id = -1;
 
 	memset(&rx, 0, sizeof(rx));
 	rx.skb = skb;
 	rx.local = local;
 	rx.list = list;
-	rx.link_id = -1;
 
 	I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
 
@@ -5175,23 +5172,15 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 	if (skb->len < sizeof(struct ethhdr))
 		goto drop;
 
-	if (!pubsta)
+	if (!link_pubsta)
 		goto drop;
 
-	if (status->link_valid)
-		link_id = status->link_id;
-
-	/*
-	 * TODO: Should the frame be dropped if the right link_id is not
-	 * available? Or may be it is fine in the current form to proceed with
-	 * the frame processing because with frame being in 802.3 format,
-	 * link_id is used only for stats purpose and updating the stats on
-	 * the deflink is fine?
-	 */
-	sta = container_of(pubsta, struct sta_info, sta);
-	if (!ieee80211_rx_data_set_sta(&rx, sta, link_id))
+	sta = container_of(link_pubsta->sta, struct sta_info, sta);
+	if (!ieee80211_rx_data_set_sta(&rx, sta, link_pubsta->link_id))
 		goto drop;
 
+	rx.link_id = link_pubsta->link_id;
+
 	fast_rx = rcu_dereference(rx.sta->fast_rx);
 	if (!fast_rx)
 		goto drop;
@@ -5212,6 +5201,9 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	int link_id = -1;
 
 	/*
+	 * FIXME: Here we can assume that link addresses have not
+	 * been translated.
+	 *
 	 * Look up link station first, in case there's a
 	 * chance that they might have a link address that
 	 * is identical to the MLD address, that way we'll
@@ -5225,10 +5217,8 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
 		sta = sta_info_get_bss(rx->sdata, hdr->addr2);
-		if (status->link_valid) {
-			link_id = status->link_id;
-		} else if (ieee80211_vif_is_mld(&rx->sdata->vif) &&
-			   status->freq) {
+		if (ieee80211_vif_is_mld(&rx->sdata->vif) &&
+		    status->freq) {
 			struct ieee80211_link_data *link;
 			struct ieee80211_chanctx_conf *conf;
 
@@ -5256,12 +5246,11 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
  * be called with rcu_read_lock protection.
  */
 static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
-					 struct ieee80211_sta *pubsta,
+					 struct ieee80211_link_sta *link_pubsta,
 					 struct sk_buff *skb,
 					 struct list_head *list)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
-	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_hdr *hdr;
 	__le16 fc;
@@ -5275,7 +5264,6 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	rx.skb = skb;
 	rx.local = local;
 	rx.list = list;
-	rx.link_id = -1;
 
 	if (ieee80211_is_data(fc) || ieee80211_is_mgmt(fc))
 		I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
@@ -5306,35 +5294,14 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 
 	if (ieee80211_is_data(fc)) {
 		struct sta_info *sta, *prev_sta;
-		int link_id = -1;
-
-		if (status->link_valid)
-			link_id = status->link_id;
 
-		if (pubsta) {
-			sta = container_of(pubsta, struct sta_info, sta);
-			if (!ieee80211_rx_data_set_sta(&rx, sta, link_id))
+		if (link_pubsta) {
+			sta = container_of(link_pubsta->sta,
+					   struct sta_info, sta);
+			if (!ieee80211_rx_data_set_sta(&rx, sta,
+						       link_pubsta->link_id))
 				goto out;
 
-			/*
-			 * In MLO connection, fetch the link_id using addr2
-			 * when the driver does not pass link_id in status.
-			 * When the address translation is already performed by
-			 * driver/hw, the valid link_id must be passed in
-			 * status.
-			 */
-
-			if (!status->link_valid && pubsta->mlo) {
-				struct link_sta_info *link_sta;
-
-				link_sta = link_sta_info_get_bss(rx.sdata,
-								 hdr->addr2);
-				if (!link_sta)
-					goto out;
-
-				ieee80211_rx_data_set_link(&rx, link_sta->link_id);
-			}
-
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
 				return;
 			goto out;
@@ -5343,13 +5310,20 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		prev_sta = NULL;
 
 		for_each_sta_info(local, hdr->addr2, sta, tmp) {
+			int link_id;
+
 			if (!prev_sta) {
 				prev_sta = sta;
 				continue;
 			}
 
 			rx.sdata = prev_sta->sdata;
-			if (!status->link_valid && prev_sta->sta.mlo) {
+
+			/*
+			 * FIXME: This is not correct as the addr2 cannot be a
+			 * link address if the loop itself is iterated.
+			 */
+			if (prev_sta->sta.mlo) {
 				struct link_sta_info *link_sta;
 
 				link_sta = link_sta_info_get_bss(rx.sdata,
@@ -5358,6 +5332,8 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 					continue;
 
 				link_id = link_sta->link_id;
+			} else {
+				link_id = sta->deflink.link_id;
 			}
 
 			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
@@ -5369,8 +5345,15 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		}
 
 		if (prev_sta) {
+			int link_id;
+
 			rx.sdata = prev_sta->sdata;
-			if (!status->link_valid && prev_sta->sta.mlo) {
+
+			/*
+			 * FIXME: This is not correct as the addr2 cannot be a
+			 * link address if the loop itself is iterated.
+			 */
+			if (prev_sta->sta.mlo) {
 				struct link_sta_info *link_sta;
 
 				link_sta = link_sta_info_get_bss(rx.sdata,
@@ -5379,6 +5362,8 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 					goto out;
 
 				link_id = link_sta->link_id;
+			} else {
+				link_id = sta->deflink.link_id;
 			}
 
 			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
@@ -5441,7 +5426,6 @@ void ieee80211_rx_list(struct ieee80211_hw *hw,
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	struct ieee80211_sta *pubsta;
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
@@ -5564,16 +5548,6 @@ void ieee80211_rx_list(struct ieee80211_hw *hw,
 		}
 	}
 
-	/* FIXME: Emulate the old driver behaviour for now */
-	if (link_pubsta) {
-		status->link_valid = 1;
-		status->link_id = link_pubsta->link_id;
-		pubsta = link_pubsta->sta;
-	} else {
-		status->link_valid = 0;
-		pubsta = NULL;
-	}
-
 	status->rx_flags = 0;
 
 	kcov_remote_start_common(skb_get_kcov_handle(skb));
@@ -5592,9 +5566,10 @@ void ieee80211_rx_list(struct ieee80211_hw *hw,
 			ieee80211_tpt_led_trig_rx(local, skb->len);
 
 		if (status->flag & RX_FLAG_8023)
-			__ieee80211_rx_handle_8023(hw, pubsta, skb, list);
+			__ieee80211_rx_handle_8023(hw, link_pubsta, skb, list);
 		else
-			__ieee80211_rx_handle_packet(hw, pubsta, skb, list);
+			__ieee80211_rx_handle_packet(hw, link_pubsta, skb,
+						     list);
 	}
 
 	kcov_remote_stop();
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 4823c8d45639..bcbae67e2f49 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright 2016-2017  Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #include <linux/if_arp.h>
@@ -204,12 +204,10 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 		 * an indication on which of the links the frame was received
 		 */
 		if (ieee80211_vif_is_mld(&scan_sdata->vif)) {
-			if (rx_status->link_valid) {
-				s8 link_id = rx_status->link_id;
+			s8 link_id = rx_status->link_id;
 
-				link_conf =
-					rcu_dereference(scan_sdata->vif.link_conf[link_id]);
-			}
+			link_conf =
+				rcu_dereference(scan_sdata->vif.link_conf[link_id]);
 		} else {
 			link_conf = &scan_sdata->vif.bss_conf;
 		}
-- 
2.53.0


