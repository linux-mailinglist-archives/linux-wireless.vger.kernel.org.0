Return-Path: <linux-wireless+bounces-37113-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K9EpAGtOGWr2uggAu9opvQ
	(envelope-from <linux-wireless+bounces-37113-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9145FF2C0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34644311F60C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23143A8723;
	Fri, 29 May 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iScRG8os"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2D371CEA
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043216; cv=none; b=cdn1JnCSKOdTkf2KMfFj29YhmBbSTfWdW9tUialK/JZTH4eY0q0PKDCX1VWEUa5cVlrN0PGaoxkt+6x55SK4ATe35jgfpkkwWq3+LpWxsMFp0HWkLNb6bOYxxxvIi0OZSst63IhOiVxSxOTPgMLif2wX34PzIKoVFO/Wn7mcefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043216; c=relaxed/simple;
	bh=Rle18RQR1vDok5GhWJkhF1MX6zdxKPVoec4XRNM9CPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcrPopdEw0fOYsb99/yOPgitrDoaCEXcaMIRR99p3vdyJTDbVSoD1GtyEnHUV34xNMEMBU2DWXE+hn8TzgSi7leegD+4mwiEexqN0O7PlJhF5dv1nun45wr20nbzDL8t9lq0pOuV88Lnm9GbGibJxOWRUcIeoedWEoc69Wd80po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iScRG8os; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C902LNmNH5zFEMF5Xv0qpC23UTzWAz4I+VzNzWzE5yk=;
	t=1780043215; x=1781252815; b=iScRG8osfHBvdKJVulBFn4znSAd818mwgaUcnSH44MWwrAD
	UDjYOQZ74ksnhwf50jmzzv9mmNXY6+rNCBdawcTVS2AoqEoud8srtReE4M+kNEXvpGnGlQbp8ZefV
	AwDjioCA7o/i8/dhyB6QXDt+NkFfM9vBBfUCM0wQd5Ewea6h8+HLp3F/ykzvntAlApBac8BtfoxWe
	+aBgZrQBxW21FoiD373waO1iROg86CTeGhqCoc0eBJi+3QyVW/xdOi52Cf9ic9pXG9J0HFwIHTjZd
	ILGJuEcAix43aQKxurFluEB1xykDWXfoQVeaqhsqgVJxQwqSt3nNKwjzQ1oeclRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYO-00000009bVp-3aPM;
	Fri, 29 May 2026 10:26:53 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 07/16] wifi: cfg80211: harden cfg80211_defragment_element()
Date: Fri, 29 May 2026 10:25:00 +0200
Message-ID: <20260529102644.198945754054.I5ae8fdebf9008abc6e15d0b0f10c3a7b73d02eab@changeid>
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-37113-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:email,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 7D9145FF2C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

A previous commit changed mac80211 to no longer make wrong
calls to cfg80211_defragment_element() with the element
pointing outside of the buffer. Additionally, harden this
function itself against that and always return -EINVAL in
case the element isn't inside the source buffer.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 358cbc9e43d8..17f0032844ab 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -5,7 +5,7 @@
  * Copyright 2008 Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2016	Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -2603,7 +2603,9 @@ ssize_t cfg80211_defragment_element(const struct element *elem, const u8 *ies,
 	ssize_t copied;
 	u8 elem_datalen;
 
-	if (!elem)
+	if (!elem || (const u8 *)elem < ies ||
+	    (const u8 *)elem + sizeof(*elem) > ies + ieslen ||
+	    (const u8 *)elem + sizeof(*elem) + elem->datalen > ies + ieslen)
 		return -EINVAL;
 
 	/* elem might be invalid after the memmove */
-- 
2.53.0


