Return-Path: <linux-wireless+bounces-29232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B8C78921
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 11:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 82C7733B8B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1453446B5;
	Fri, 21 Nov 2025 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LegJx3MV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3A3446CE
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763721468; cv=none; b=KqajZ2L1su5NJFVOe/bjViR08rJowKPEs8qDG8JfxwaKpbfjC9/bvNz5iCX+O5pJokktogX2txIf1nQZlFTnns5xPhHpEk07WhSfG90Q+NUNEEGpoaLBzy9iGpWgXSpewzHOWGq/yF7CJOWZF1qhkE9Z1LMH04qeu5x1NEQccKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763721468; c=relaxed/simple;
	bh=CPinw/K80wrKRtZCxWDJsw/ufFHpEv2bUtXAV1sg41U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOtfMT0E1IuxyH44zXFNOxGZWgWDLeQIT36IIWTNmnVv2CeP13GJV6xAVvu1dMwrk0XRtt25kwAtshrYLmM5lX77Par4DaBOKRIHA5Q8nglgkGx4cylNmuGLNlzlAjbT4qcWQm04vXWCUG60wmqLvGxl3cfJt9vqhK4j61QqVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LegJx3MV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ryxZxhJ94MvQR9zcJfKn9XBPgjxv829eudbXebgDvbk=; t=1763721466; x=1764931066; 
	b=LegJx3MVV3YEWfwAhmfVsBNEC2cBl0dkqhL62QkrG/n9one+/tJ/mSeNPCp8uDVwfliN/jfnzTH
	IJp6d3HYEcfwQlaLqo3nIHFfn6z1+f3pKJGijkg2z7Vlj4w+e3thdsxC4xFZrVMG1a9U51GHm7E4f
	bq+2B0ZQUbh7wUtUNLmrfCS7TpT9DtyZeh86VKnLufZcWb43K/DrKeSW+KTPNLSj92UOUMniFabUA
	zw3LVKcX8t5uLdwvPHb9NVUT2vJzZwJ0CYA8cKvwRwyZ7Q48QT+/N1cKHIHq0IYJMr910iHd0jYUQ
	48q4bhcPRVmvOjNeplByAHeEb5wuC+C1DdtQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vMOWG-0000000BRtO-1sYv;
	Fri, 21 Nov 2025 11:37:36 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: fix channel switching code
Date: Fri, 21 Nov 2025 11:37:34 +0100
Message-ID: <20251121113733.7710a58d45eb.Ie9ec010b52b1baed93dbe44f968c2119b6b5d98d@changeid>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

My prior commit here introduced a bug due to copy/paste,
it was iterating the links assigned to 'ctx->replace_ctx'
and I replaced it by iterating links assigned to 'ctx' by
accident, then modified it for the iteration later.

Fix it to iterate the users of the correct chanctx, i.e.
'ctx->replace_ctx'.

Ultimately, this issue led to a crash in a hwsim test
(multi_ap_wps_shared_apdev_csa) because it would actually
do the switch (rather than refuse here) and then later
have a double-free of the original chanctx, because it
was still in use by another interface yet freed as part
of the switching.

Fixes: a1dc648aa76d ("wifi: mac80211: remove chanctx to link back-references")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 6aa305839f53..c8aba4183c9a 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1715,7 +1715,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		n_reserved = 0;
 		n_ready = 0;
 
-		for_each_chanctx_user_assigned(local, ctx, &iter) {
+		for_each_chanctx_user_assigned(local, ctx->replace_ctx, &iter) {
 			n_assigned++;
 			if (iter.link->reserved_chanctx) {
 				n_reserved++;
-- 
2.51.1


