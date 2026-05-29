Return-Path: <linux-wireless+bounces-37115-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLKgNnZOGWr2uggAu9opvQ
	(envelope-from <linux-wireless+bounces-37115-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729A5FF2D5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 423BD313D547
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDF23ACA46;
	Fri, 29 May 2026 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DviMMkCB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA43A0E8B
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043218; cv=none; b=WDCtE+zKl1tRjh6x0SWiKcAC1eCmhDMIu6ySCTQGkhKgOKBhd8A32yWBy/9XQba5Q6D4dchxKKMZ2TzZ1aTapJR5rm4bz7hZDRqSRdnBSEqaXxnI+dmmPMy0J/zeyN5rR26u1KVsrLUT1Zrivbcg7+UyJ4u0XNlqeU3SqpyqzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043218; c=relaxed/simple;
	bh=ERY8L9EpTX1URFSKkWJw8F3v8glluf/6gcJ/MuPOLWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+g5wT7g12yQQ6/fVFSu2tQpFmpeLN0zxTpyF8sGebRiy0o5nWHX13viA7m73JTEOt52JgfLwdKIeZmHb6thvFx92QKxrfAXEzrE1D1p4zY5ElzHkze2PSezdUv/C4ZV/aNlyBOy/jmIu9FK+yChOp4fTyc+V6uDFa/pSelD1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DviMMkCB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AuyZkXhg8azem6O0ktFcqIBKKpnmoFCwRgptaHQU61A=;
	t=1780043217; x=1781252817; b=DviMMkCBfWzOJIIV635vZnR8sMR/PkCBk9HJpyEXCVP8wNA
	9hx7A2ukxIb2Y5zBnZOnIL1NxC+pUAMD21mOrB6Fl9GurypNFZheXtDqJiz+k8lFpwj3aQlKXsptO
	LwfzGR8dWclcWGln5GcHPRCPs1kHQc0eqf1RsBc4XNp/qzDOnqpnI/NcEDQePdDJNpAi8iJ4TWN59
	p6Jd/ZlsDV3tp0FivgpM1AKA/soxQAuBvjGN3YZbhGdStVeF3V1MXMZid//fGbD3OOOOJxUNAslMJ
	u5AqclxBOQyUDIj5kQfjUurRYCffyphp0ZX7RixP93ZVFALI6gDwMG71EZrB2XwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYR-00000009bVp-07zw;
	Fri, 29 May 2026 10:26:55 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 09/16] wifi: mac80211: mlme: allow UHR only with MLO
Date: Fri, 29 May 2026 10:25:02 +0200
Message-ID: <20260529102644.43817ce87042.If4562ae9c5ca83339b397d9a344b68631cb17c4a@changeid>
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
	TAGGED_FROM(0.00)[bounces-37115-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 5729A5FF2D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

UHR requires MLO, not just formally but also in order
for the client to understand AP BSS parameter changes,
since the Critical Update Counter is inside the Multi-
Link Element. Require MLO for UHR connections to avoid
otherwise needed complexity such as not enabling any
feature that would require tracking critical updates.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 181fe975fcd9..949ea018079a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -389,7 +389,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	}
 
 check_uhr:
-	if (conn->mode < IEEE80211_CONN_MODE_UHR || !uhr_oper)
+	if (conn->mode < IEEE80211_CONN_MODE_UHR || !uhr_oper || !elems->ml_basic)
 		return IEEE80211_CONN_MODE_EHT;
 
 	if (elems->frame_type != (IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_BEACON)) {
-- 
2.53.0


