Return-Path: <linux-wireless+bounces-15-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C9C7F6905
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B178B281887
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531504D5B5;
	Thu, 23 Nov 2023 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fCJPldP3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B68D67
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q2KCkqGxx8qJdzfHAlSCBvED4kseHGHCcqLQHBjP2Wk=;
	t=1700778481; x=1701988081; b=fCJPldP3No5fdHaKXkCC6WulvTQ/mSYChMOGLy02eRywAKy
	ZHeSyQPvwbeGJqCzZiMIXFEid1L/+3+M8lkycQwcIt/E67KaQILJ4oHFz6QJlG8jn2zCRENCOMDjh
	G4d4e5Z0ZyLkj2hELabNUu8X6tCEEAL+tglw1LZb0wRoSC0SzA/JpnnkQWPlNO/AF9dJwobfP7Or0
	Pz1a5Zk03jJGzkqNv9DKfsmXp5DgSk5n1jJDkx1CnKZYfa39qpzxkhjVIJXcuMmEN/rq2YpdhwUwx
	pz5PYDNeoCfhuqa6tL0keo5GRik5VagWaszvGmBhRSJn8hursX0+a4vfc/cXPezw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAx-00000001Y53-2YCs;
	Thu, 23 Nov 2023 23:27:59 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 10/13] wifi: mac80211: chan: chandef is non-NULL for reserved
Date: Thu, 23 Nov 2023 23:14:47 +0100
Message-ID: <20231123231436.1ffba9763c23.I12287452f42c54baf75821e75491cf6d021af20a@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123221436.143254-14-johannes@sipsolutions.net>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The last caller of this with a NULL argument was related to
the non-chanctx code, so we can now remove this odd logic.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 2974fe9ddb74..fdcc3d777190 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -90,11 +90,11 @@ ieee80211_chanctx_reserved_chandef(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (WARN_ON(!compat))
+		return NULL;
+
 	list_for_each_entry(link, &ctx->reserved_links,
 			    reserved_chanctx_list) {
-		if (!compat)
-			compat = &link->reserved_chandef;
-
 		compat = cfg80211_chandef_compatible(&link->reserved_chandef,
 						     compat);
 		if (!compat)
-- 
2.42.0


