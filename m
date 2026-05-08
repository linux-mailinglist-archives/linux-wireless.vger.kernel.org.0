Return-Path: <linux-wireless+bounces-36111-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLcbDHuO/WnWfgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36111-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 09:19:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 346F24F2E6A
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 09:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06958300F622
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 07:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441437B000;
	Fri,  8 May 2026 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TBGPqopm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605D378D82
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778224243; cv=none; b=oLQOeTi4Npg3Cu4s4DDwbS+yIohmzHI3kItPGGki5QkikYvWGNo2PQgGJP78wPbwgpduaY0UggCM1Bb5zaj8174WNLxChgDnqhKlMJy4f8FEx7wOZIuaeMn6/qWuJMZGD52517jFiVXLd/3mIY9Pjcp+3HSvWlFd9vlHoAHXPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778224243; c=relaxed/simple;
	bh=8gZiv4s3p2zBASdbkFXPjXShk6/dme1z7nE5TVuacAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGaUXzJh4OwAw79LAjlT+E1Zh8+vNNLJsNvS7I2a3+SKdVGCOdYg3v2GIGw+wbtyPV1epK/COQzFT5LkdTTwpGEzrlNN3Vpdi7DydGHMazGT2vJhkHU4jqUeKYFmbv5579Jp7DYXsQoeOLYrC0xP2hdeHGYIv4EldIeuzXTi7dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TBGPqopm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CJ8Ygff8fkOBqu8Ssz73usXVr7veKnrFA3lJhMXksoQ=;
	t=1778224240; x=1779433840; b=TBGPqopmWeVV1nXv1SAW+DlqKDDKilL7hk/FuLqZsGM96Ue
	dtZMK9CWwHSMiJphI5tHAJs7DdXMpnA+OG398pRiQJrS27vqDsXfMRtG+eu+ErNP2t65JTpe+WZqA
	RPQR8w+v8iJPsE49yWdiuZeEEMD/nSq0hiiaWxyJkYu3rqPZmY11hAWcOS3KjAu63n0WdL4koJWqF
	Z9o7Qt90cjdcjxtKkBqC1WUOFMPRHQJNRc4h0iafKgkUEKTeVx3/p3bKo5jl+pdmjRg7PUGXXH/NC
	DciXkWgRrvW6Si36aK6H0XA/PKAisYX78+aQu934kCEWXO/gLU7a7qDPDqfPbUnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wLFM4-000000064Um-169R;
	Fri, 08 May 2026 09:10:36 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless 2/2] wifi: mac80211: fix multi-link element inheritance
Date: Fri,  8 May 2026 09:10:32 +0200
Message-ID: <20260508091032.92184c0a3f08.I3c43b0b63d2cef8a4ddddaef1c2faaeb1de711ad@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508091031.8a6c34613178.I4de16ebbce2d27f2f8f98fc49949c7a376c2fe8d@changeid>
References: <20260508091031.8a6c34613178.I4de16ebbce2d27f2f8f98fc49949c7a376c2fe8d@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 346F24F2E6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-36111-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

When parsing a beacon, mac80211 erroneously inherits any
reconfiguration or EPCS multi-link elements from the outer
elements into the multi-BSSID profile that's requested, if
connected to a non-transmitted BSS, unless that profile
has a non-inheritance element.

This also happens if parsing a multi-BSSID profile that
doesn't have a non-inheritance element.

Fix this by having an empty non-inheritance element so
cfg80211_is_element_inherited() is invoked in these cases
and causes the parser to skip the elements that should
never be inherited.

Fixes: cf36cdef10e2 ("wifi: mac80211: Add support for parsing Reconfiguration Multi Link element")
Fixes: 24711d60f849 ("wifi: mac80211: Support parsing EPCS ML element")
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 666cdd5fd0ea..77894d997113 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -34,6 +34,15 @@
 #include "led.h"
 #include "wep.h"
 
+static const u8 empty_non_inheritance[] = {
+	WLAN_EID_EXTENSION, 1, WLAN_EID_EXT_NON_INHERITANCE,
+	/*
+	 * cfg80211_is_element_inherited() hardcodes elements that
+	 * cannot be inherited, so we just need an empty one to be
+	 * calling it at all.
+	 */
+};
+
 struct ieee80211_elem_defrag {
 	const struct element *elem;
 	/* container start/len */
@@ -923,7 +932,7 @@ ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
 {
 	struct ieee802_11_elems *elems = &elems_parse->elems;
 	struct ieee80211_mle_per_sta_profile *prof;
-	const struct element *tmp;
+	const struct element *tmp, *ret;
 	ssize_t ml_len;
 	const u8 *end;
 
@@ -993,8 +1002,17 @@ ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
 	sub->from_ap = params->from_ap;
 	sub->link_id = -1;
 
-	return cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-				      sub->start, sub->len);
+	ret = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+				     sub->start, sub->len);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since we know we want and found a profile, apply an empty
+	 * non-inheritance if the profile didn't have one, so that any
+	 * element that shouldn't be inherited by spec isn't.
+	 */
+	return (const void *)empty_non_inheritance;
 }
 
 static const void *
@@ -1030,6 +1048,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	size_t scratch_len = 3 * params->len;
 	bool multi_link_inner = false;
 
+	BUILD_BUG_ON(sizeof(empty_non_inheritance) != empty_non_inheritance[1] + 2);
 	BUILD_BUG_ON(offsetof(typeof(*elems_parse), elems) != 0);
 
 	/* cannot parse for both a specific link and non-transmitted BSS */
@@ -1077,6 +1096,17 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 
 		non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
 						     sub.start, nontx_len);
+		/*
+		 * If it's a non-transmitted BSS, we shouldn't pick
+		 * any elements in the outer parsing that shouldn't
+		 * be inherited. If the profile has a non-inheritance
+		 * element this automatically happens, but if not then
+		 * provide an empty one so that the hard-coded elements
+		 * in cfg80211_is_element_inherited() are ignored, but
+		 * it must be called.
+		 */
+		if (params->bss->transmitted_bss && !non_inherit)
+			non_inherit = (const void *)empty_non_inheritance;
 	} else {
 		/* must always parse to get elems_parse->ml_basic_elem */
 		non_inherit = ieee80211_prep_mle_link_parse(elems_parse, params,
-- 
2.53.0


