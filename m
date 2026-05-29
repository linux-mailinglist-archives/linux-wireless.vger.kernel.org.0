Return-Path: <linux-wireless+bounces-37114-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMLOCHROGWr2uggAu9opvQ
	(envelope-from <linux-wireless+bounces-37114-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8B35FF2C7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB02A313405B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5CF33F5B0;
	Fri, 29 May 2026 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RHKqHTh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEDD3AFD01
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043218; cv=none; b=JVpOkAhO2Jqg2d/rlLPeWS/eg3/Thg7CK2bs6LzMK2Pvd4nZ3BHLOjHtZ4Eir2GD54HG5toZoMhBsxbk7zYxB28Hrn+qj2x+L00Otng9VCwa8jyL1P85ffMtt7sZORlC0l2fLRFz6ipU8M81r4IKpsZE2l4YKaNHU5+ndG5ZD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043218; c=relaxed/simple;
	bh=A8dt8h5Or5Ybwa87bRt07q64G7pN/ckXDNZg919+6RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMp7LMyq21U+/iYlxkq8w95Tv5FMTYpSpK0mrblrf5/jveyOiYjr7BoyWULguLgk4Q5tm/9oz+X9zBX5NStzS2Yvy/fUN+aYh6JpJcm6l82XvmrVPENkv4xweJbNgnNFMFb5l4f0I0L2eMxlCd1CLViMNZcKK59K0GgjOx2nICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RHKqHTh7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TLyNdzZFioppA/rqg/hVmfdJMiMQOCynbMasVi8oFqE=;
	t=1780043216; x=1781252816; b=RHKqHTh7CkFYBETzxpERNdn1wTmc1PndwgKCmb5Ih+RMlzf
	60Gl0Gat8rX2oGVRRAvWdGKEZBPZgeD/rnUyPlYt4gnNuAXo/IoLE25t0Az7ox/ZvEjNMYcAAm9ok
	ci2ND7xiv6QnyDV+Do1y2BB20/L5LOb2yMaZ8ZZO7PDIx37hIIZYpaeGS5SJ7RvYXC7OxhChT4NmE
	zJAiEGMf0zzN4R0LGliSAGjJWF/vef657Nf6Bt0rdALmMFaaIpBDM63dArIr7Xc30m1nYMNwjssLw
	e7n5SsIKwXGoD9ptW0OPwRScQm8O4EmiqcIm58fy41qjj5F826lN5ABAcz7CdHHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYP-00000009bVp-2yPL;
	Fri, 29 May 2026 10:26:54 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 08/16] wifi: mac80211: always expose multi-link element
Date: Fri, 29 May 2026 10:25:01 +0200
Message-ID: <20260529102644.2a74b2659f50.I8f9454bf5e05c419a9b1eb23ecad302a6bf63fbb@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37114-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 6A8B35FF2C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

During beacon processing, the parser is always called with
a BSS to find the correct multi-BSSID profile (if any) and
therefore never attempts to parse a multi-link element.
This means the code to handle cross-link CSA can effectively
never do anything.

Fix this by parsing the multi-link element in the regular
parser as well.

Fixes: 7ef8f6821d16 ("wifi: mac80211: mlme: handle cross-link CSA")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 1dc9b1fd225c..ab9b87fdba1e 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -54,7 +54,7 @@ struct ieee80211_elems_parse {
 	/* must be first for kfree to work */
 	struct ieee802_11_elems elems;
 
-	struct ieee80211_elem_defrag ml_reconf, ml_epcs;
+	struct ieee80211_elem_defrag ml_reconf, ml_epcs, ml_basic;
 
 	bool inside_multilink;
 	bool skip_vendor;
@@ -169,6 +169,9 @@ ieee80211_parse_extension_element(u32 *crc,
 						IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC;
 					break;
 				}
+				elems_parse->ml_basic.elem = elem;
+				elems_parse->ml_basic.start = params->start;
+				elems_parse->ml_basic.len = params->len;
 				break;
 			case IEEE80211_ML_CONTROL_TYPE_RECONF:
 				elems_parse->ml_reconf.elem = elem;
@@ -1140,6 +1143,10 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	elems->ml_epcs = ieee80211_mle_defrag(elems_parse,
 					      &elems_parse->ml_epcs,
 					      &elems->ml_epcs_len);
+	if (!elems->ml_basic)
+		elems->ml_basic = ieee80211_mle_defrag(elems_parse,
+						       &elems_parse->ml_basic,
+						       &elems->ml_basic_len);
 
 	if (elems->tim && !elems->parse_error) {
 		const struct ieee80211_tim_ie *tim_ie = elems->tim;
-- 
2.53.0


