Return-Path: <linux-wireless+bounces-34773-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGqnBoWI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34773-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:45:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFBA40464A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F2F43026D0A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C30218E91;
	Wed, 15 Apr 2026 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tY1i6jcn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2419E98D
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257121; cv=none; b=E6CkKK73xE0GkKpyOfZJnAYiGOnGr+lxE8sGIc5Rj3yNKCnCdV6Dnum3TDxm8UC5Iux5eeqRgwi4g6TCIclJ+o40v4IbltHt2YqADv98OBOPV6DSGCHt6L2EOUbJNChXFKa2T+c9J3OOqq0OqrHZ2Mc2k5FHenmxg5XrBMp4H74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257121; c=relaxed/simple;
	bh=Hwq22JMDBgZqegdBhk6e5lkB/GVQoXJ5t0vWKA50HRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzFKN5wCDMRvO33L0wL9NysT13qISUWuyjn9t6igQkFYqNK0Wgva+KQVki9JaxASbvGMkCmYX9xlbN+Jz6W8cEHo8B6rCGDVl1vofCq4extSPCQbUkUlJvccMK/mzrFY6n5Mt7GZue2Le0aTIbrojvKEzLmZMWwLrANk5fKHkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tY1i6jcn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hDDhtr14T8TSKVdypLqOB0zgBmIEHJZHTJ30LR+mMIM=;
	t=1776257120; x=1777466720; b=tY1i6jcnwCSvHRAIBY9OWsv4K7KpaZyQm1csoNeiYn57+1Y
	W55YwW/b4eHbov0+V8rvLCsVL7j6rRf77w13FAEuAmH8C4xSiCcioU9DsTbiXz8ExiK+A53J3hvpa
	vLKa/JF8D4HxNT3kmO8oN3MO95JybsTO07M9t3O/UNWBntLtoEcUGIi89E04al7NsOKI997VLfxuu
	IvNSb6xbc7Hy/xgvpzAJaSn4KvpJFUVNfXUaV6XUu16/MASNjTmLlEkSihLjCf7uq1nhsVc62ALmI
	x1b9ssU5/paZ6+4eopoISmFu3x4qw7Ev5to2BwSPhd9Gde811sr+mi7uD5HMRROw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcM-00000006OgW-1CMn;
	Wed, 15 Apr 2026 14:45:18 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 01/20] wifi: mac80211: remove NAN guards on ieee80211_sta_cur_vht_bw() calls
Date: Wed, 15 Apr 2026 14:41:59 +0200
Message-ID: <20260415144514.be6bc3fd5fdf.I38ce6c763c361a3ce50618e820a0818eb18e49dd@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34773-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: EAFBA40464A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

The NAN guards here make little sense, just don't WARN inside
the function (and return maximum instead of minimum). Otherwise
we need to guard more calls, such as in EHT in the future.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/he.c  | 5 ++---
 net/mac80211/vht.c | 9 ++++-----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index a3e16a5bec22..92d9c4f095b3 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -3,7 +3,7 @@
  * HE handling
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019-2025 Intel Corporation
+ * Copyright(c) 2019-2026 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -160,8 +160,7 @@ _ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 	he_cap->has_he = true;
 
 	link_sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(link_sta);
-	if (sdata->vif.type != NL80211_IFTYPE_NAN)
-		link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
+	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
 	if (he_6ghz_capa)
 		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, link_sta);
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index f3bb5a561a38..edce0b16dc3d 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -324,8 +324,7 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				IEEE80211_STA_RX_BW_160;
 	}
 
-	if (sdata->vif.type != NL80211_IFTYPE_NAN)
-		link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
+	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
 	/*
 	 * Work around the Cisco 9115 FW 17.3 bug by taking the min of
@@ -528,9 +527,9 @@ _ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
 		struct ieee80211_bss_conf *link_conf;
 
 		/* NAN operates on multiple channels so a chandef must be given */
-		if (WARN_ON_ONCE(sta->sdata->vif.type == NL80211_IFTYPE_NAN ||
-				 sta->sdata->vif.type == NL80211_IFTYPE_NAN_DATA))
-			return IEEE80211_STA_RX_BW_20;
+		if (sta->sdata->vif.type == NL80211_IFTYPE_NAN ||
+		    sta->sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+			return IEEE80211_STA_RX_BW_MAX;
 
 		rcu_read_lock();
 		link_conf = rcu_dereference(sta->sdata->vif.link_conf[link_sta->link_id]);
-- 
2.53.0


