Return-Path: <linux-wireless+bounces-16743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA159FB84B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 02:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3B91884A68
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985646447;
	Tue, 24 Dec 2024 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="os25GmIg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0E3FE4;
	Tue, 24 Dec 2024 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735003984; cv=none; b=TCSusf25haXjwKethPtKWR/HXmYojY66PFYq8G+cRIpJ/8DJBJlxe+gOL5hTMlG0i2UMymYOwZ/W7arDJtSm6ZeIAcLTBMw9c6eE7UcoXcEqXwrxWvqomRF0Y4aCEH3jrawDtf0D6xN9hhPbKVYsQLyX1ym9nrDJz613OUA6ELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735003984; c=relaxed/simple;
	bh=bkOlsJMCEhswxSQkLahHchzZI3J0JbslmKmDz4pDc78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTehk3hvi6dWdspGfvXpWsWrxYyuhnKPd+qW0dhuoKl6AjqJznoex4j0mDQrifEF1zEouNxRINjDb7243LD3Wg6pVZ1JZ2q6a9JRxSs38WNSBbfwepT+G+OraOpzNBVduj+Ji8bOAuRQ2COFSNSofXUjKzJN9KXUrzMpVTNPS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=os25GmIg; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=hBSa9Rn0CkNbYuUWFc1n920EK0yIZQ8wal1JvWTl5/s=; b=os25GmIgt9Z0JJcu
	9HR7MgT8G4KXCSaiduuCGlCxp882OPNfgvkIZfyG8JSy+KWktbBf9cMndMTdH29Q7iPcS83VewUpZ
	q5s3/4aEGY4WBBCNAk8mLFGRWfhxgUAsHsYv6C8BWlCM95k3xQl5hNFfUp8zsd8MUHlrXBAI8x23Z
	pFQAf01F+twvJK23urwfwEy69oUAvl72Ehkb5zFwtkRO5YQcKXORbriPLQKS1fj/9hqHw3IxMFHLM
	+wkPKtrpGjs2GOSkiKdJWd2Hh0W7LE82w0uPFWaWF6Z/77s7j6VQsEjUOnK+AhsYnKUyZBChXMTAi
	wXcZrjrdlmwyIUi4JQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tPtnA-006wDg-2S;
	Tue, 24 Dec 2024 01:33:00 +0000
From: linux@treblig.org
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/2] wifi: mac80211: Remove unused ieee80211_nan_func_match
Date: Tue, 24 Dec 2024 01:32:57 +0000
Message-ID: <20241224013257.185742-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224013257.185742-1-linux@treblig.org>
References: <20241224013257.185742-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

ieee80211_nan_func_match() was explicitly added in 2016 by
commit 92bc43bce284 ("mac80211: Add API to report NAN function match")

but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/mac80211.h | 15 ---------------
 net/mac80211/cfg.c     | 25 -------------------------
 2 files changed, 40 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ab8dce1f2c27..47d67b1f7d02 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7550,21 +7550,6 @@ void ieee80211_nan_func_terminated(struct ieee80211_vif *vif,
 				   enum nl80211_nan_func_term_reason reason,
 				   gfp_t gfp);
 
-/**
- * ieee80211_nan_func_match - notify about NAN function match event.
- *
- * This function is used to notify mac80211 about NAN function match. The
- * cookie inside the match struct will be assigned by mac80211.
- * Note that this function can't be called from hard irq.
- *
- * @vif: &struct ieee80211_vif pointer from the add_interface callback.
- * @match: match event information
- * @gfp: allocation flags
- */
-void ieee80211_nan_func_match(struct ieee80211_vif *vif,
-			      struct cfg80211_nan_match_params *match,
-			      gfp_t gfp);
-
 /**
  * ieee80211_calc_rx_airtime - calculate estimated transmission airtime for RX.
  *
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d3fc158ccaf6..50b4ec777349 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4525,31 +4525,6 @@ void ieee80211_nan_func_terminated(struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL(ieee80211_nan_func_terminated);
 
-void ieee80211_nan_func_match(struct ieee80211_vif *vif,
-			      struct cfg80211_nan_match_params *match,
-			      gfp_t gfp)
-{
-	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	struct cfg80211_nan_func *func;
-
-	if (WARN_ON(vif->type != NL80211_IFTYPE_NAN))
-		return;
-
-	spin_lock_bh(&sdata->u.nan.func_lock);
-
-	func = idr_find(&sdata->u.nan.function_inst_ids,  match->inst_id);
-	if (WARN_ON(!func)) {
-		spin_unlock_bh(&sdata->u.nan.func_lock);
-		return;
-	}
-	match->cookie = func->cookie;
-
-	spin_unlock_bh(&sdata->u.nan.func_lock);
-
-	cfg80211_nan_match(ieee80211_vif_to_wdev(vif), match, gfp);
-}
-EXPORT_SYMBOL(ieee80211_nan_func_match);
-
 static int ieee80211_set_multicast_to_unicast(struct wiphy *wiphy,
 					      struct net_device *dev,
 					      const bool enabled)
-- 
2.47.1


