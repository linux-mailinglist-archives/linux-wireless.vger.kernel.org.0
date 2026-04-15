Return-Path: <linux-wireless+bounces-34774-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LYLtDKWI32kHVAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34774-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13EC404671
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E547B307A506
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F97823DD;
	Wed, 15 Apr 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NKTZ9lu8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D32D1303
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257122; cv=none; b=uiPNtoBEh2F4CC3NzsyLKj/k//xZno4DY+3LLFJNWsPNNNsh5toKeubHWGd3JbcM+0yYj/ZOWcl2HVcNfMT3NqKjrfxKUdtH/omj2aCW23ki2VUA502BpUQ49s6qV2SdcdY5+iekk7H/L/OLMAkBMuoE4TB22unUPBWX6gWgbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257122; c=relaxed/simple;
	bh=qI274SiVnnUbe2aqls9ZStNQAj7M3INQNntXy6Xsp2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4pr0wUqGHo0wu5TUXOtuXEwXNy5W4nHZ7i6Cx044lryM3uNPS9NelGvgZOuAYXHu4wv3QMzB7uMYvF9c6c5HKNdD63GHvH2rt8Bklj/MppHiY0c6R/ulF5OrGCHmX6zuhhw2Ho9mmAKsaIpLpd9USDL0+tXv3NRHfFbm6x+LOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NKTZ9lu8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9Lavfx8GEiObh2+hAo+qGwzPBtykQryCuaBJU0jeo5E=;
	t=1776257121; x=1777466721; b=NKTZ9lu8bBkgjYVG4aD/6DUwx572Lfvig2YG6zKbYTFCpYM
	t+EDPx6RcvhUUojQeKY+s+CNn460WspFgi7dAv567+kegvucL0hTvk45UY6aZwD52CE6Vl3Oo1Sle
	Bnb9qGOanDbXkucU2bVyoFn5h/SoXHzECDC80lLkO02RhzmJMK+OViGT4N5rLQ+TMas9IrL18PS1N
	iF2TdsL3MAgZixkJbYbqUCTJ+AuJWWiUx7PNLtNbl5t/X1MmhS/0OGq8ZgXfV9P4nLnAqlp7NGVI4
	71t4NJ1wZSUlFb3vfcUU4c+Yqx0myXU9Yf7zxnpMtJ/AS/M8Jsw9nehcHJOE57JQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcM-00000006OgW-3Xwu;
	Wed, 15 Apr 2026 14:45:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 02/20] wifi: mac80211: set cur_max_bandwidth to maximum
Date: Wed, 15 Apr 2026 14:42:00 +0200
Message-ID: <20260415144514.43cdb11b5c7e.I99a7ea2ab10b6fffb68a401a26b98d546e428c11@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415124514.284345-22-johannes@sipsolutions.net>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34774-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: A13EC404671
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Instead of calculating the individual maximum for each
station from its capabilities, just unconditionally set
cur_max_bandwidth to IEEE80211_STA_RX_BW_MAX. This still
works because cur_max_bandwidth is only used together
with the capabilities of the station anyway, and then
adjusted by HT channel width notification or VHT opmode
notification action frames.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/eht.c      |  3 +--
 net/mac80211/he.c       |  1 -
 net/mac80211/ht.c       |  4 ----
 net/mac80211/sta_info.c |  2 ++
 net/mac80211/sta_info.h |  2 +-
 net/mac80211/vht.c      | 23 -----------------------
 6 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 768bfc4e737d..66dd104f8c73 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -2,7 +2,7 @@
 /*
  * EHT handling
  *
- * Copyright(c) 2021-2025 Intel Corporation
+ * Copyright(c) 2021-2026 Intel Corporation
  */
 
 #include "driver-ops.h"
@@ -74,7 +74,6 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 
 	eht_cap->has_eht = true;
 
-	link_sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(link_sta);
 	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
 	/*
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 92d9c4f095b3..19e2f359b796 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -159,7 +159,6 @@ _ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	he_cap->has_he = true;
 
-	link_sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(link_sta);
 	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
 	if (he_6ghz_capa)
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 97719298e038..8f76440e9e48 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -291,10 +291,6 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 
 	link_sta->pub->bandwidth = bw;
 
-	link_sta->cur_max_bandwidth =
-		ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
-				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
-
 	if (sta->sdata->vif.type == NL80211_IFTYPE_AP ||
 	    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
 	    sta->sdata->vif.type == NL80211_IFTYPE_NAN ||
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 4c31ef8817ce..e08db1b0cb30 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -572,6 +572,8 @@ static int sta_info_alloc_link(struct ieee80211_local *local,
 	link_info->rx_omi_bw_tx = IEEE80211_STA_RX_BW_MAX;
 	link_info->rx_omi_bw_staging = IEEE80211_STA_RX_BW_MAX;
 
+	link_info->cur_max_bandwidth = IEEE80211_STA_RX_BW_MAX;
+
 	/*
 	 * Cause (a) warning(s) if IEEE80211_STA_RX_BW_MAX != 320
 	 * or if new values are added to the enum.
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 3e5d003bd31f..05a776dba3e9 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -504,7 +504,7 @@ struct ieee80211_fragment_cache {
  * @status_stats.last_ack_signal: last ACK signal
  * @status_stats.ack_signal_filled: last ACK signal validity
  * @status_stats.avg_ack_signal: average ACK signal
- * @cur_max_bandwidth: maximum bandwidth to use for TX to the station,
+ * @cur_max_bandwidth: dynamic bandwidth limit for the station,
  *	taken from HT/VHT capabilities or VHT operating mode notification.
  *	Invalid for NAN since that is operating on multiple bands.
  * @rx_omi_bw_rx: RX OMI bandwidth restriction to apply for RX
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index edce0b16dc3d..6da8a5021136 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -301,29 +301,6 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	/* finally set up the bandwidth */
-	switch (vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
-	case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
-	case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ:
-		link_sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
-		break;
-	default:
-		link_sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
-
-		if (!(vht_cap->vht_mcs.tx_highest &
-				cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE)))
-			break;
-
-		/*
-		 * If this is non-zero, then it does support 160 MHz after all,
-		 * in one form or the other. We don't distinguish here (or even
-		 * above) between 160 and 80+80 yet.
-		 */
-		if (cap_info & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK)
-			link_sta->cur_max_bandwidth =
-				IEEE80211_STA_RX_BW_160;
-	}
-
 	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
 	/*
-- 
2.53.0


