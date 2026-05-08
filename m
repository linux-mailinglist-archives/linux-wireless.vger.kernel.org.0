Return-Path: <linux-wireless+bounces-36110-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIybKnaM/WnWfgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36110-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 09:10:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E44F2D77
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 09:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E9B3001865
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 07:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB2537AA97;
	Fri,  8 May 2026 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HnouVuGW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD131AAB8
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778224242; cv=none; b=IMnrKk4DMZ3WpJ2fkZrAqsDVJNfAjMGh7/Ywm1LRcFFpXaqHDh2JKnCPy52nuLzx6hs5q4JItvXNnDNjhh4u5UKh4TqrAyTUJK6duzHZArPvjANn8jz1hZrkW5Iaj4DotAhyb+9k/AxCBHwv4Q+tIkLSKVOIQSmjmxX4YzUXiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778224242; c=relaxed/simple;
	bh=/3a3KtOmi5HLW0vDVypPKVSrmy8AXVF5hn9TjW+p7Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3cyqMjlRPa7j55FM/9iN4pp26VUhy+5wky9rTgPj3Bl5CrerDiKexfOpOuqrg6ucmnL01FRu9bUokUJfRsIJEWN3VCQwCXnFgvF/LVh3/0uKeUgzk2o1aVSR9mOl1Tjj1Rep2fMW6dUezLQ1dw1iREWNH2kTMh5c4KriC/nC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HnouVuGW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=B3fhZWVbjdn88yQBr/5AcDHwbeXkb5Df6McegTG8j9w=; t=1778224239; x=1779433839; 
	b=HnouVuGWgRQdPxQiQteyWWdNChfsxv5rhVlrRJzgjJO+77Cx9a7J6WwSbnSiQ0ww4Rlgm1U+67+
	5Rl19WQnQuCt45BL7YMU8aHpjV1ahVhJBwX1W5Vv8bZZIyjVjF25zNi3XwFnt1bfQ9h0I86zEWgLi
	sxV5YwcH5qd5ddXY33vt0z/0hvovKSb86YsKLuLRnv1zLP+QQY0kiwTsNxMHdlxc2EV4c7iUrBuH2
	PqGa7FQ+cZgsppsMej/unTChvonYX5kHJVRwKTBEjnrKCNQ72qF7+0irrNt3NqxFKfw8U5eND0ehR
	9WDXdL1EWHYtqdzvreASXzQeiZ6uU6rVU69A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wLFM3-000000064Um-1CF6;
	Fri, 08 May 2026 09:10:35 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless 1/2] wifi: mac80211: fix MLE defragmentation
Date: Fri,  8 May 2026 09:10:31 +0200
Message-ID: <20260508091031.8a6c34613178.I4de16ebbce2d27f2f8f98fc49949c7a376c2fe8d@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 156E44F2D77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-36110-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

If either reconf or EPCS multi-link element (MLE) is contained in
a non-transmitted profile, the defragmentation routine is called
with a pointer to the defragmented copy, but the original elements.

This is incorrect for two reasons:
 - if the original defragmentation was needed, it will not find the
   correct data
 - if the original frame is at a higher address, the parsing will
   potentially overrun the heap data (though given the layout of
   the buffers, only into the new defragmentation buffer, and then
   it has to stop and fail once that's filled with copied data.

Fix it by tracking the container along with the pointer and in
doing so also unify the two almost identical defragmentation
routines.

Fixes: 4d70e9c5488d ("wifi: mac80211: defragment reconfiguration MLE when parsing")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 71 +++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 2b3632c6008a..666cdd5fd0ea 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -34,6 +34,13 @@
 #include "led.h"
 #include "wep.h"
 
+struct ieee80211_elem_defrag {
+	const struct element *elem;
+	/* container start/len */
+	const u8 *start;
+	size_t len;
+};
+
 struct ieee80211_elems_parse {
 	/* must be first for kfree to work */
 	struct ieee802_11_elems elems;
@@ -41,11 +48,7 @@ struct ieee80211_elems_parse {
 	/* The basic Multi-Link element in the original elements */
 	const struct element *ml_basic_elem;
 
-	/* The reconfiguration Multi-Link element in the original elements */
-	const struct element *ml_reconf_elem;
-
-	/* The EPCS Multi-Link element in the original elements */
-	const struct element *ml_epcs_elem;
+	struct ieee80211_elem_defrag ml_reconf, ml_epcs;
 
 	bool multi_link_inner;
 	bool skip_vendor;
@@ -162,10 +165,14 @@ ieee80211_parse_extension_element(u32 *crc,
 				}
 				break;
 			case IEEE80211_ML_CONTROL_TYPE_RECONF:
-				elems_parse->ml_reconf_elem = elem;
+				elems_parse->ml_reconf.elem = elem;
+				elems_parse->ml_reconf.start = params->start;
+				elems_parse->ml_reconf.len = params->len;
 				break;
 			case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
-				elems_parse->ml_epcs_elem = elem;
+				elems_parse->ml_epcs.elem = elem;
+				elems_parse->ml_epcs.start = params->start;
+				elems_parse->ml_epcs.len = params->len;
 				break;
 			default:
 				break;
@@ -990,46 +997,27 @@ ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
 				      sub->start, sub->len);
 }
 
-static void
-ieee80211_mle_defrag_reconf(struct ieee80211_elems_parse *elems_parse)
+static const void *
+ieee80211_mle_defrag(struct ieee80211_elems_parse *elems_parse,
+		     struct ieee80211_elem_defrag *defrag,
+		     size_t *out_len)
 {
-	struct ieee802_11_elems *elems = &elems_parse->elems;
+	const void *ret;
 	ssize_t ml_len;
 
-	ml_len = cfg80211_defragment_element(elems_parse->ml_reconf_elem,
-					     elems->ie_start,
-					     elems->total_len,
+	ml_len = cfg80211_defragment_element(defrag->elem,
+					     defrag->start, defrag->len,
 					     elems_parse->scratch_pos,
 					     elems_parse->scratch +
 						elems_parse->scratch_len -
 						elems_parse->scratch_pos,
 					     WLAN_EID_FRAGMENT);
 	if (ml_len < 0)
-		return;
-	elems->ml_reconf = (void *)elems_parse->scratch_pos;
-	elems->ml_reconf_len = ml_len;
-	elems_parse->scratch_pos += ml_len;
-}
-
-static void
-ieee80211_mle_defrag_epcs(struct ieee80211_elems_parse *elems_parse)
-{
-	struct ieee802_11_elems *elems = &elems_parse->elems;
-	ssize_t ml_len;
-
-	ml_len = cfg80211_defragment_element(elems_parse->ml_epcs_elem,
-					     elems->ie_start,
-					     elems->total_len,
-					     elems_parse->scratch_pos,
-					     elems_parse->scratch +
-						elems_parse->scratch_len -
-						elems_parse->scratch_pos,
-					     WLAN_EID_FRAGMENT);
-	if (ml_len < 0)
-		return;
-	elems->ml_epcs = (void *)elems_parse->scratch_pos;
-	elems->ml_epcs_len = ml_len;
+		return NULL;
+	ret = elems_parse->scratch_pos;
+	*out_len = ml_len;
 	elems_parse->scratch_pos += ml_len;
+	return ret;
 }
 
 struct ieee802_11_elems *
@@ -1109,9 +1097,12 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 		_ieee802_11_parse_elems_full(&sub, elems_parse, NULL);
 	}
 
-	ieee80211_mle_defrag_reconf(elems_parse);
-
-	ieee80211_mle_defrag_epcs(elems_parse);
+	elems->ml_reconf = ieee80211_mle_defrag(elems_parse,
+						&elems_parse->ml_reconf,
+						&elems->ml_reconf_len);
+	elems->ml_epcs = ieee80211_mle_defrag(elems_parse,
+					      &elems_parse->ml_epcs,
+					      &elems->ml_epcs_len);
 
 	if (elems->tim && !elems->parse_error) {
 		const struct ieee80211_tim_ie *tim_ie = elems->tim;
-- 
2.53.0


