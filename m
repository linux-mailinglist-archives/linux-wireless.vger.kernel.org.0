Return-Path: <linux-wireless+bounces-2673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB8184090E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 15:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5291A1F21441
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14EF152E11;
	Mon, 29 Jan 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qq2F45qQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538945B5C1
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540037; cv=none; b=ala4usXmPPZEmS0pZJhgxOPeCFgOatznavQsjUYkJqpwiwamF5N/sASbe1ZSkOSL3TX3u6U7kNeFxJtdT+1h/WKEJ4x+syLejuvRuannonc+e3gDGaCHTxPxm0aD6FznhV59E0r0W2wI4pdEUqP5PV/QttSXB7dyYiTysJJ13Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540037; c=relaxed/simple;
	bh=k22XOvcDReIa0xvF18gIGGIHGY7/s9wqDxWvobbUZeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZ3V0G1EP6S3ySIA0LfYAzN1zVVTYmDcAKKKd299USaRYuxFNNmt/8OQPyKmk7xnwhL9aAy71qMLbV4LVigHZz6Y90JhzE+cyeOYM5QjrdvRj2qH4v/K0PP5rYB4Vju45Hk6++8k+f2NGELALsOLm6Usjp1RQLj7BWPafQsQSF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qq2F45qQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=1xc7kEElmq2lH6BilhyWFZy2Gf07+UlqKuqFPd/00Ss=; t=1706540034; x=1707749634; 
	b=qq2F45qQ3cukoHvjZit26RqaYex9Y3UBJIWIItYC4t7SaH20QdVdZ68CXnihQpMGsZTiT0fxwwn
	Ls1Z3tW3s0p1X5lGEyCEdgSKMLuyUdGFbCP4RUnKO22U37HRUS0Zb/w/seT7Blfvw8KyerdTOVqmt
	NxbVkaC45DVOgNtgr5ViHw1DHR+VQu75VGhy7r+7MsdAo4CeX3ZAvEqRNfCDs9ZMBx15/POdwk+aV
	yy8qWP1Fo2EzwtlJVqAx35GjbKCn88gdeg7183kHesA/23bT5KLC+C7HcqL/nx3RKE38o5jkfLTVZ
	F3E67OB872o0kq4LViQ6sWKbLYTMDlspbfHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUT1C-00000004tLt-3Ar4;
	Mon, 29 Jan 2024 15:53:50 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: fix RCU use in TDLS fast-xmit
Date: Mon, 29 Jan 2024 15:53:48 +0100
Message-ID: <20240129155348.8a9c0b1e1d89.I553f96ce953bb41b0b877d592056164dec20d01c@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This looks up the link under RCU protection, but isn't
guaranteed to actually have protection. Fix that.

Fixes: 8cc07265b691 ("wifi: mac80211: handle TDLS data frames with MLO")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 68a48abc7287..e448ab338448 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3100,10 +3100,11 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 			/* DA SA BSSID */
 			build.da_offs = offsetof(struct ieee80211_hdr, addr1);
 			build.sa_offs = offsetof(struct ieee80211_hdr, addr2);
+			rcu_read_lock();
 			link = rcu_dereference(sdata->link[tdls_link_id]);
-			if (WARN_ON_ONCE(!link))
-				break;
-			memcpy(hdr->addr3, link->u.mgd.bssid, ETH_ALEN);
+			if (!WARN_ON_ONCE(!link))
+				memcpy(hdr->addr3, link->u.mgd.bssid, ETH_ALEN);
+			rcu_read_unlock();
 			build.hdr_len = 24;
 			break;
 		}
-- 
2.43.0


