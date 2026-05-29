Return-Path: <linux-wireless+bounces-37110-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ClvMlFOGWrzuQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37110-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788F5FF285
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C3830E8562
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA9348C56;
	Fri, 29 May 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OtX2ODlp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B63ACEFE
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043214; cv=none; b=csmNzIzL8/BXkDVEB3E29GtOGstvS5oTDgOZHdKmZ6OcgmMy+ip1hY37cAabnG6Dvoz4japOLJsXdb7/WH4Sxu8K2HItXPqMtF9VZKqb9rdx/wo6894xz8QC0mwxUTLqeqFDawwSG6Sb3UOe7pe7xgX8XOHdVeYjYgTDtV+nkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043214; c=relaxed/simple;
	bh=+sIoC6eb0W1eLEgklMRzgxa5sHu0RABnQ5yA3iXRTBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujskT4rysIT1EQKud3skZ5HRdLETHJRdr8WhYj2JyMg0hoI9SPsGRsHDmbKK1/vaxuoVEBEG3ms0qJGXlHKkoX1tHfNurhbhYI2UMahYrYVKISaIBVFm6OwfRpiX+bdGIAp9bNTV/GoEbr4OmhRSS8BLUSCxBcmTsLa3UMy30Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OtX2ODlp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4UQs+oduRqTMkiknIFQGq3zaKIanu0vjb5TD9He1P3s=;
	t=1780043212; x=1781252812; b=OtX2ODlptFgDkbFkyEDMzQfTjQqkV3RjrgdGXy1JdG8NqAw
	+9KP7i5ffXXTtrbt8TxCzaZgKS+I+z/xaj9ZE5p0xhim7CAYuTS3OsHJzhR1y4YUXXeLOO4lYxT3N
	xRLMbih7o+fJEnfrHqH4R1779Alh/QFw1YhUDRgxl4EIU+oSIeK2dMV7bSQUuaB5wlZgrRux3s6so
	IicIET0FdQfFPWQaJm1cYOJ8mS7LXxRCgyxaipghuVMUtmaM9pilh5wd0Y450P5Heb0ScnI59yIUG
	OBGGHRrHWXYc0EIPfj92aVZ5NbP6IpMZ2EeODqeUHUCf7SvxkWsYDUYiyuoYEvag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYM-00000009bVp-2UXM;
	Fri, 29 May 2026 10:26:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 04/16] wifi: mac80211: rename "multi_link_inner" variable
Date: Fri, 29 May 2026 10:24:57 +0200
Message-ID: <20260529102644.7ccd55a411cf.I4101e1cfd133a2ce2374340712da8bb1f0292a40@changeid>
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
	TAGGED_FROM(0.00)[bounces-37110-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 2788F5FF285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

This variable name seems a bit misleading now (I added it
myself a year ago or so), it indicates that the parsing is
happening on the inner elements of a multi-link element.
Rename it to "inside_multilink" to clarify.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 22365c507b99..4a7b41995f76 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -59,7 +59,7 @@ struct ieee80211_elems_parse {
 
 	struct ieee80211_elem_defrag ml_reconf, ml_epcs;
 
-	bool multi_link_inner;
+	bool inside_multilink;
 	bool skip_vendor;
 
 	/*
@@ -167,7 +167,7 @@ ieee80211_parse_extension_element(u32 *crc,
 			switch (le16_get_bits(mle->control,
 					      IEEE80211_ML_CONTROL_TYPE)) {
 			case IEEE80211_ML_CONTROL_TYPE_BASIC:
-				if (elems_parse->multi_link_inner) {
+				if (elems_parse->inside_multilink) {
 					elems->parse_error |=
 						IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC;
 					break;
@@ -1046,7 +1046,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	const struct element *non_inherit = NULL;
 	struct ieee802_11_elems *elems;
 	size_t scratch_len = 3 * params->len;
-	bool multi_link_inner = false;
+	bool inside_multilink = false;
 
 	BUILD_BUG_ON(sizeof(empty_non_inheritance) != empty_non_inheritance[1] + 2);
 	BUILD_BUG_ON(offsetof(typeof(*elems_parse), elems) != 0);
@@ -1114,7 +1114,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 		/* must always parse to get elems_parse->ml_basic_elem */
 		non_inherit = ieee80211_prep_mle_link_parse(elems_parse, params,
 							    &sub);
-		multi_link_inner = true;
+		inside_multilink = true;
 	}
 
 	elems_parse->skip_vendor =
@@ -1125,7 +1125,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 
 	/* Override with nontransmitted/per-STA profile if found */
 	if (sub.len) {
-		elems_parse->multi_link_inner = multi_link_inner;
+		elems_parse->inside_multilink = inside_multilink;
 		elems_parse->skip_vendor = false;
 		_ieee802_11_parse_elems_full(&sub, elems_parse, NULL);
 	}
-- 
2.53.0


