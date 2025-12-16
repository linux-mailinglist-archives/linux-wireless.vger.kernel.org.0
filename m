Return-Path: <linux-wireless+bounces-29799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419BCC2274
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 12:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DE1630792B6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 11:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941033893E;
	Tue, 16 Dec 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CdLBVsq+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0EB32862F;
	Tue, 16 Dec 2025 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883958; cv=none; b=ZNdoNFEIrAMlYNY93MBFg9wL6GyIKCf+AwTEINQtq4PrlVC4dDaYlCVg32Kf/TaWz/cMqRzO9YfuQBkQEY8f2rZ1wEiCSrre8Ofs/r9/OuGqu9wwqwBL+Kng0hm3AHXE+AMlMH0pH+VyHfcRjUeruLnF7co8RnrHOSeghsrECvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883958; c=relaxed/simple;
	bh=jV4nqNrOmliNsJ3gSGNq3tq5z4vr/GaPek6PTEEgpdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b43oE7z/nqoKWVp0T2bTHfkUSoWWHaCH8ZygRaK680BaN3qqCZTDPM9UZ2AupPVFzQjZPzHEMomNXllaXexk9aCsklrbTWFC2K07UkpCUM0l6idpZq4wle6UdW18wdWH6UxZEXgKQj8PoSrLG9PqBcCAhQR1loS/elYjXFh/EO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CdLBVsq+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wajJfvGHfxjrujb+tDRZGXUj+CeBAKL7X/uzaz61ESc=; t=1765883956; x=1767093556; 
	b=CdLBVsq+z3taYlzn9t1Zn6Z5W7wyfyfK5pBVSSpjjai7Gib5JgBhljBh3d4gXHjfjiLjvMn2gxl
	ujouuhOOUtDQ886ZQkVRGc+Ylv+s979Mik9ss6KGVD2/bbJh3cyQmsc5uvn+nzJbDk7dp3OKR1Pja
	rGJ0yGgZiQlcvDa1765G8i9MmYNxQMCFg1hSpQ8RRQbcg6prrvHPzt+Iu5WF8SrF41fSWn6QoM9Kh
	vPgyMvVfxgHgq+T/UalMySb3hTgJhDzaTTZeSKuYAu4Mb8JlJtjQgnsTAea9owhi1b0xzriLCZOk6
	k+cOn1GBawtFRdbuKDzXMMKe/NOX2Mket1DA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVT5F-0000000ALEY-0Hxf;
	Tue, 16 Dec 2025 12:19:13 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org,
	Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>
Subject: [PATCH v2] wifi: mac80211: restore non-chanctx injection behaviour
Date: Tue, 16 Dec 2025 12:19:09 +0100
Message-ID: <20251216111909.25076-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

During the transition to use channel contexts throughout, the
ability to do injection while in monitor mode concurrent with
another interface was lost, since the (virtual) monitor won't
have a chanctx assigned in this scenario.

We could use the local->hw.conf.chandef in the emulation case,
but that wouldn't fix drivers (such as mt76) that themselves
are now using channel contexts.

So instead, assume that if there's just a single chanctx that
must be the one meant for injection, addressing both cases.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218763
Reported-by: Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>
Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: use the single chanctx if such a thing exists to fix both
    cases of emulation and drivers that changed like mt76
---
 net/mac80211/tx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 9d8b0a25f73c..22d0df442ac0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2395,6 +2395,18 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 				rcu_dereference(tmp_sdata->vif.bss_conf.chanctx_conf);
 	}
 
+	if (!chanctx_conf) {
+		struct ieee80211_chanctx *ctx;
+		bool first = true;
+
+		list_for_each_entry_rcu(ctx, &local->chanctx_list, list) {
+			if (!first)
+				goto fail_rcu;
+			chanctx_conf = &ctx->conf;
+			first = false;
+		}
+	}
+
 	if (chanctx_conf)
 		chandef = &chanctx_conf->def;
 	else
-- 
2.52.0


