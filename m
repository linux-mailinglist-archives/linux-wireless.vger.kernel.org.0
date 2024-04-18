Return-Path: <linux-wireless+bounces-6517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B2F8A96B9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B01F21191
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 09:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5300015B554;
	Thu, 18 Apr 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Td9wij3o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9015B13E
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433949; cv=none; b=feuqpE3AtkJczLVMe7GKtz4yX6tcVZjXOQ2onav5/QN+w9R05oXqhRJafseG9CgznaJNo4/KKoiyKEoD5b3WAOYTfA6CVdvUYlVHDgV5gQYt8ZnP9t5/VKQarZotmbPxZ/jVmG/pWeY+Y0BsUctGoqkFb6+PgZBPjnHUNDKKSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433949; c=relaxed/simple;
	bh=/1W3PiXHzqbOZG2JKIHP2M+KebXTpikrXK0Ib7Wtsno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cs1N37eJuGAwbRSdhwCFUb6bnKACQYN+3bYUwdUmmpNmujzoS8V5bP1x56Jr+byE58yIMo+QF4mhYcSBK8KgxK9OzO+PBEb4v6qXDsuX9LbR0+5b4uHxDGXPKPuCQXHkvqA2fDmGn+ugT9pc7ZrY1tXbNS+SCobad4iPkblV6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Td9wij3o; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/FijGTmv8297S/TPXCMqkXvfkD7Pmh038la17TVCxpo=;
	t=1713433947; x=1714643547; b=Td9wij3oP1kMuzJdb1RQbuyHMS+d3e08JKWI01qTITZqVek
	TZYwqYF8XMhCTm5EIk9Q2mMxVZE1hBVyWvnsWY7qqcjJ07x7kvO80i2EFhT53SoZtwil5ipYzjr4y
	wFKYGSKt0YTmz1qnZJRtZxfhVG22KJ0jb1LqbV93xok2WvVqlQ1QKbq3NOo1u+MrHGWaY5TRaLMFI
	QWf9onaolEYOPZqI0pyEX9ay6RCiSsK21CqpSJ3fJCQhvl68tuC8yDJybSqvhTmxCiJ7vLN1LROV0
	yPqsOjRGJtUQk6kf0xZBdkdY5f74loTM8iP5ntHwK+n30CKFcnC1ujD4HK4lycig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxORM-0000000CM0y-1Hm8;
	Thu, 18 Apr 2024 11:52:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next 2/3] wifi: mac80211: simplify ieee80211_assign_link_chanctx()
Date: Thu, 18 Apr 2024 11:52:20 +0200
Message-ID: <20240418115219.a94852030d33.I9d647178ab25636372ed79e5312c68a06e0bf60c@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418115219.94ea84c8ee1e.I0b247dbc0cd937ae6367bc0fc7e8d156b5d5f9b1@changeid>
References: <20240418115219.94ea84c8ee1e.I0b247dbc0cd937ae6367bc0fc7e8d156b5d5f9b1@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need for a label/goto here, the only thing is
that drv_assign_vif_chanctx() must succeed to set 'conf'
and add the new context to the list, the remaining code
is (and must be) the same regardless.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 6d0148dea126..2c338014ded5 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -815,7 +815,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *curr_ctx = NULL;
-	int ret = 0;
+	int ret;
 
 	if (WARN_ON(sdata->vif.type == NL80211_IFTYPE_NAN))
 		return -EOPNOTSUPP;
@@ -836,15 +836,16 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 		ieee80211_recalc_chanctx_min_def(local, new_ctx, link);
 
 		ret = drv_assign_vif_chanctx(local, sdata, link->conf, new_ctx);
-		if (ret)
-			goto out;
-
-		conf = &new_ctx->conf;
-		list_add(&link->assigned_chanctx_list,
-			 &new_ctx->assigned_links);
+		if (!ret) {
+			/* succeeded, so commit it to the data structures */
+			conf = &new_ctx->conf;
+			list_add(&link->assigned_chanctx_list,
+				 &new_ctx->assigned_links);
+		}
+	} else {
+		ret = 0;
 	}
 
-out:
 	rcu_assign_pointer(link->conf->chanctx_conf, conf);
 
 	sdata->vif.cfg.idle = !conf;
-- 
2.44.0


