Return-Path: <linux-wireless+bounces-31925-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJZ0C59MlGkNCQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31925-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:10:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6BF14B2DB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F9943008099
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3026330644;
	Tue, 17 Feb 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="n98ZST9y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i693.smtp2go.com (e3i693.smtp2go.com [158.120.86.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9EF330329
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326605; cv=none; b=es14t6BSAa1ZBziI4FzXBjOtg4lyaIag6BeQEoXhQ4a5BT2NAHsL3JIc5XhR2iRHm396HvPf/wVoYV9gtIWg3mLsvdBDxSjbz9ri0O/BSOuFTWy+VlaoF43HT2zo4M/0QQqOvsvKCbmeEAPKuiHy8hBONbK2sXFpqAgx4WIkl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326605; c=relaxed/simple;
	bh=Rwa5SbZbwFw5zHzjmWHA0GCYttQW3qra5cJmckSp1rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKEyeUZLZkwrLN6+GTSgOGjD3OPxdfWRGFtsnWcaTAQC5Pzj8Uxchw478tce9ohrulIltuEl77wKeJEDAtqRlijTZzEpx8Wm2/SNB1r5UOCQyLPZeUhserS3+SWLEqNruSXWpL97rU8uF3hio9Wx3GZiHms4N2nyfh5ce6G4jyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=n98ZST9y; arc=none smtp.client-ip=158.120.86.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1771325695; h=from : subject
 : to : message-id : date;
 bh=JnYH1ptdFFHGtpfwVkqyYHfrXgSqYG4pcNvlPo4D2KE=;
 b=n98ZST9yujDTR5w+wmfGDSrgPLgSojSrfiUzCH2BF2javfqTLw9dtCjms1ApzYUEOg/u1
 dL/6PElLVj6CHyTRYKUcrbCY6bx83uQ+yjHjxLOBW71qBpM9jIb1IjxEMP1rFYkNVjx0Bw8
 8HRYE6YdNKFUec/gswN+3K/J2ciR6IsEWYHeIVVfyliAL2Lsp0I1ez37U3962UP0UQanOGg
 746K9XFIq+h70BH941oCEZaoK1mrHrAHfykF9HdE2JHsDzLHans4tVOBcwtUlKFhyHbKnFF
 4gU04VV52g+6k8RwJnPvQX7uZfcu+e2pzxRnpXSwnh6Er8z+LsP4pGtmp6vg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vsIj6-FnQW0hQ1cSj-la2V;
	Tue, 17 Feb 2026 10:54:44 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless] wifi: mac80211: Fix ADDBA update when HW supports reordering
Date: Tue, 17 Feb 2026 11:36:07 +0100
Message-ID: <5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616snk9QLnpdH
X-smtpcorp-track: 1460UQuBlizn.CIweTXkbUFHk.dn8hhQLfRie
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31925-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,triplefau.lt:mid,triplefau.lt:dkim,triplefau.lt:email]
X-Rspamd-Queue-Id: 5C6BF14B2DB
X-Rspamd-Action: no action

Commit f89e07d4cf26 ("mac80211: agg-rx: refuse ADDBA Request with timeout
update") added a check to fail when ADDBA update would change the
timeout param.

This param is kept in tid_ampdu_rx context which is only allocated on HW
that do not set SUPPORTS_REORDERING_BUFFER. Because the timeout check
was done regardless of this param, ADDBA update always failed on those
HW.

Fix this by only checking tid_ampdu_rx->timeout only when
SUPPORTS_REORDERING_BUFFER is not set.

Fixes: f89e07d4cf26 ("mac80211: agg-rx: refuse ADDBA Request with timeout update")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/agg-rx.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 7da909d78c68..099a291723e6 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -353,7 +353,16 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 	       buf_size, sta->sta.addr);
 
 	if (test_bit(tid, sta->ampdu_mlme.agg_session_valid)) {
-		if (sta->ampdu_mlme.tid_rx_token[tid] == dialog_token) {
+		if (sta->ampdu_mlme.tid_rx_token[tid] != dialog_token) {
+			ht_dbg_ratelimited(sta->sdata,
+					   "unexpected AddBA Req from %pM on tid %u\n",
+					   sta->sta.addr, tid);
+
+			/* delete existing Rx BA session on the same tid */
+			__ieee80211_stop_rx_ba_session(sta, tid, WLAN_BACK_RECIPIENT,
+						       WLAN_STATUS_UNSPECIFIED_QOS,
+						       false);
+		} else if (!ieee80211_hw_check(&local->hw, SUPPORTS_REORDERING_BUFFER)) {
 			struct tid_ampdu_rx *tid_rx;
 
 			ht_dbg_ratelimited(sta->sdata,
@@ -374,14 +383,6 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 			goto end;
 		}
 
-		ht_dbg_ratelimited(sta->sdata,
-				   "unexpected AddBA Req from %pM on tid %u\n",
-				   sta->sta.addr, tid);
-
-		/* delete existing Rx BA session on the same tid */
-		__ieee80211_stop_rx_ba_session(sta, tid, WLAN_BACK_RECIPIENT,
-					       WLAN_STATUS_UNSPECIFIED_QOS,
-					       false);
 	}
 
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_REORDERING_BUFFER)) {
-- 
2.52.0


