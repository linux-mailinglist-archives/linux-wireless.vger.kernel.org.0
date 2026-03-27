Return-Path: <linux-wireless+bounces-34040-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fv+OZZQxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34040-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:40:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E99CC341E66
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A932B3074581
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D83DC4A2;
	Fri, 27 Mar 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G/m5CoIG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D89F3D6684
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604232; cv=none; b=rQD6TP/tt2R1+mN4R533Brt0i7I5iNq6xu5oxoMpMVqSE+jDykuKnBEXXdSs55AxVDb0PnDiavAebl+wLUfmHBwvXX3u7XHnfArL0ddnMSWSrUvEB2wqPVkuKQVZO6c0It2i6i2fDLbI40BbHIm6mgU26+3sZIlL7kn+dPmxEjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604232; c=relaxed/simple;
	bh=biirNkLE4mxcYbIZGOJV21ApVIiLGf9Z1jtbzUTztLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHqpyk61NE41Lwfi5g7uU2Q9gEATTqvCzB+ZO5L27hOO5biynM95/vZT2ZVyQA8UMR67rENRH4vA3H1FI0rmLEQk37SnlHukefDU1MI6IM4sgPdW1CQPOv3K8LxGUQYpVemWApcWkChiaCtnOcfNLJOjj44Tms8BWHDqLVtnmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G/m5CoIG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aHI7wDMVASkfqaXq9yLtGmLe+T9FrmX80zI034fqc5o=;
	t=1774604231; x=1775813831; b=G/m5CoIGnJe4QgG28xNR0M5pGOBU4B8kHzlJc+7m/R1odnd
	RmM30Kr4k/6XMUTsgx74myIoWRDtUosOydIkMGwUpcyDmmC629QLt0kgwBu982sSgL/HH8UOUWKzm
	SIqQpSf42e3EbCeOH64AfbDgevkrjRFZqw3eMtF1eMiY1yBq50Jkbj6q7FfQ3IEVWEoGFNX7feE9K
	YhmLxRUkzuKmeoC1E66PoQcDq4peLilhQjn73YkbKmco3F6u4oq55zrxe+OPmAitE1NrnU7HpUJF4
	W8tKe4aKKVU6GdOYbJIMhiDAfGlIuZzcXwf81APizi/MZCJDe4lfYqJ/cRhwfAOA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63ck-0000000E83L-3CrY;
	Fri, 27 Mar 2026 10:37:02 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 01/19] wifi: mac80211: set cur_max_bandwidth to maximum
Date: Fri, 27 Mar 2026 10:31:27 +0100
Message-ID: <20260327103659.b39f14ca647d.I99a7ea2ab10b6fffb68a401a26b98d546e428c11@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327093659.711584-21-johannes@sipsolutions.net>
References: <20260327093659.711584-21-johannes@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34040-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E99CC341E66
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
index 93e0342cff4f..70da246f8a2d 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -155,7 +155,6 @@ _ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	he_cap->has_he = true;
 
-	link_sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(link_sta);
 	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
 	if (he_6ghz_capa)
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 410e2354f33a..27b5578601ff 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -280,10 +280,6 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 
 	link_sta->pub->bandwidth = bw;
 
-	link_sta->cur_max_bandwidth =
-		ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
-				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
-
 	if (sta->sdata->vif.type == NL80211_IFTYPE_AP ||
 	    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
 		enum ieee80211_smps_mode smps_mode;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 7923ee9eafab..b3a016f3736b 100644
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
index 58ccbea7f6f6..92ba477e7c37 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -504,7 +504,7 @@ struct ieee80211_fragment_cache {
  * @status_stats.last_ack_signal: last ACK signal
  * @status_stats.ack_signal_filled: last ACK signal validity
  * @status_stats.avg_ack_signal: average ACK signal
- * @cur_max_bandwidth: maximum bandwidth to use for TX to the station,
+ * @cur_max_bandwidth: dynamic bandwidth limit for the station,
  *	taken from HT/VHT capabilities or VHT operating mode notification
  * @rx_omi_bw_rx: RX OMI bandwidth restriction to apply for RX
  * @rx_omi_bw_tx: RX OMI bandwidth restriction to apply for TX
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index a6570781740a..148a4cde5ec7 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -297,29 +297,6 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
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


