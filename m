Return-Path: <linux-wireless+bounces-37112-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEdMDmFOGWrzuQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37112-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CB65FF2A1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6859E31081FF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2323AA1A9;
	Fri, 29 May 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Xk1jNvGB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F643B27FC
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043216; cv=none; b=RgYdJs6tNo5RzGQ2rm1eTjVcJlaOhmI6AEWevlJ9hSkDnfqd6lHRt/qVdziQ7pe5oFvKeCsSAROCGKATU1uBOdVK/zaSKPVBQkD+oBzUiqJxOCsd2OgOxbvPtpPoOmHzBNUqpVNTTeferpM3RgCmmbj6GhaMQrmLyfjlTWimT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043216; c=relaxed/simple;
	bh=jcW2/zyy1MtXG4CI5zKNTzBXMnc9xunYQopbIc+iCLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCWNu8o0RVk1zDeCZa0LsLx2Z07+4iWnsq/5VZy33uRTZV7lxH8oUUi5QslWkwueZR6rYiQFxIrBz+JOd8oPNFCy+X8o+DOPhVdkLCO4fECSEcFcR94Zg53MH9qFfspXiJgyRY3ooUJU9fS/7paFdKHGtKjwjKp9dLF8HngRWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Xk1jNvGB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=T3hoMtWQAhcb/4ovqyjdhfaNDbkKSXrUC3Qnd2+i0KA=;
	t=1780043214; x=1781252814; b=Xk1jNvGBn/P/EBJxP/XIgBi3HmwTOk+03VGBsnEK9m8F7v9
	TmCYT7su93xeGfpkzDBOmyAKeVVe5tqWAuq+dvIGIebB8Rox/01Jafw5kolxScYmde+kd9QBspKBw
	caUQ/U0ZCRxgrdRjJgdmZ3o83WV9J3PWHLpB71uVwB0vdBzcCEQ8Cl4Jx7ScSuL6NmtB8X904umyl
	D0ZxrsbM0xM7qT48UdWWWp+YrmZWKuP+9ili3bIyhnsUJBuRh9D0JqOjmJG1JiZhFzhvYp5lOiagJ
	MeWhfkGh/CdFPIt6g3z9E5KvSrn1RUnr+E9XCrKiK3giFjGZvn0LqwubpSEkoCqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYO-00000009bVp-0L1V;
	Fri, 29 May 2026 10:26:52 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 06/16] wifi: mac80211: use local ml_basic_elem in parsing
Date: Fri, 29 May 2026 10:24:59 +0200
Message-ID: <20260529102644.50187b7a6ca2.Ifef23bda96651eed0f5cd2c3ecd4817d2fb08af4@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529082644.106145-18-johannes@sipsolutions.net>
References: <20260529082644.106145-18-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37112-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 86CB65FF2A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

There's no need to store this pointer on the heap, it's
only used in a single function. Move it there. Also
clarify the comment referencing it, ml_basic_elem is
not actually relevant (any more.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index aa06c1fdf472..1dc9b1fd225c 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -54,9 +54,6 @@ struct ieee80211_elems_parse {
 	/* must be first for kfree to work */
 	struct ieee802_11_elems elems;
 
-	/* The basic Multi-Link element in the original elements */
-	const struct element *ml_basic_elem;
-
 	struct ieee80211_elem_defrag ml_reconf, ml_epcs;
 
 	bool inside_multilink;
@@ -932,6 +929,7 @@ ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
 {
 	struct ieee802_11_elems *elems = &elems_parse->elems;
 	struct ieee80211_mle_per_sta_profile *prof;
+	const struct element *ml_basic_elem = NULL;
 	const struct element *tmp, *ret;
 	ssize_t ml_len;
 	const u8 *end;
@@ -951,12 +949,11 @@ ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
 		    IEEE80211_ML_CONTROL_TYPE_BASIC)
 			continue;
 
-		elems_parse->ml_basic_elem = tmp;
+		ml_basic_elem = tmp;
 		break;
 	}
 
-	ml_len = cfg80211_defragment_element(elems_parse->ml_basic_elem,
-					     elems->ie_start,
+	ml_len = cfg80211_defragment_element(ml_basic_elem, elems->ie_start,
 					     elems->total_len,
 					     elems_parse->scratch_pos,
 					     elems_parse->scratch +
@@ -1115,7 +1112,10 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 		if (params->bss->transmitted_bss && !non_inherit)
 			non_inherit = (const void *)empty_non_inheritance;
 	} else {
-		/* must always parse to get elems_parse->ml_basic_elem */
+		/*
+		 * Find the multi-link element and the non-inherit element inside
+		 * the applicable profile, if requested by params->link_id >= 0.
+		 */
 		non_inherit = ieee80211_prep_mle_link_parse(elems_parse, params,
 							    &sub);
 		inside_multilink = true;
-- 
2.53.0


