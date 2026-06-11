Return-Path: <linux-wireless+bounces-37672-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3zUUItaxKmqKvAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37672-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 15:02:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8424B6721E4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 15:02:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hqQ9qXVK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37672-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37672-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3613130759DC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362F23FBEDA;
	Thu, 11 Jun 2026 13:01:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6E3EFD03;
	Thu, 11 Jun 2026 13:01:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182865; cv=none; b=McflNpzsVzU6cRBxt/a2NGOZN8LmG6BtfzdRal+MkhZfe1Wqo5dvYGWrEFM0RoWQYb1FM4rbKrFgd63sWvjiFB5oPL1F7wu0QSBbqPfjjvcO+WCU22n5lmsYBffbEtO+ZdC5GdgRLoUf7FvReMnEMpG6PjuDGShGffw9smmQEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182865; c=relaxed/simple;
	bh=Nj68VoNxv9pWOeXFpIy1Mi0MaCfekFyrax1y0cWTst8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FlWZYrVv7O8aQJGkyPpxhUGI5/LQB3wap3h63HlNgWQB38mP/HWaVZ9WoglIwLQBC5vs1wd78dBqYd5Q1naVDGf3VehgaE6BihYmXVzqmJbXpCmi/5lxoPaqAj5LdlBCIcz9vkfxeJz4ZYExaMjNvc71XqXxOK7r8KzaOArJ0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqQ9qXVK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26831F00893;
	Thu, 11 Jun 2026 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182863;
	bh=b7Xo99CTQi357IJ5sn3pZq61XJKz+u9lb+berFjqWnw=;
	h=From:To:Cc:Subject:Date;
	b=hqQ9qXVK/wX5tnyBaIhamDQHsoPAJxaa+nR0qVQe/zHWm8M77Qg9P/bVm8koKMu3J
	 JsXEvgj1hJ/64zRPpkxR0Tsszk4s6HFfK5FJJxmxcMdbVCXouU9M/sQSwMQRhG/Qv1
	 fIO9jIZG7Val7PCCIwKZk8ihmHrSnzOS9IP8M82+nM4sQkoWjU0nn+WuOOflbRp+Nz
	 QZkMuvlaBGFmNJapO70rArkIvoG9KQNh+kv/N4CEJqlMFYpPCfceruJzMXS0RuTvbb
	 0r7KxoGG6aQaS5pp+/nZvUH87bhylEtWv2PyUqM4qW9PMCaMFdET0EAH9poJCZXMFs
	 qsGrFdqwaj3DA==
From: Arnd Bergmann <arnd@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [wireless-next] wifi: mac80211: allocate backup ieee80211_nan_sched_cfg off stack
Date: Thu, 11 Jun 2026 15:00:54 +0200
Message-Id: <20260611130100.3387714-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37672-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:miriam.rachel.korenblit@intel.com,m:arnd@arndb.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8424B6721E4

From: Arnd Bergmann <arnd@arndb.de>

The ieee80211_nan_sched_cfg structure is too large to keep on the
per thread stack:

net/mac80211/nan.c:251:5: error: stack frame size (1560) exceeds limit (1536) in 'ieee80211_nan_set_local_sched' [-Werror,-Wframe-larger-than]
  251 | int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,

Allocate this dynamically using kmalloc_obj() to reduce the stack
usage of this function to a manageable 344 bytes for the same
configuration.

Fixes: 589c06e8fdee ("wifi: mac80211: add NAN local schedule support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/mac80211/nan.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/nan.c b/net/mac80211/nan.c
index 1800bb96dd29..19e08661be43 100644
--- a/net/mac80211/nan.c
+++ b/net/mac80211/nan.c
@@ -253,9 +253,12 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_nan_channel *sched_idx_to_chan[IEEE80211_NAN_MAX_CHANNELS] = {};
 	struct ieee80211_nan_sched_cfg *sched_cfg = &sdata->vif.cfg.nan_sched;
-	struct ieee80211_nan_sched_cfg backup_sched;
+	struct ieee80211_nan_sched_cfg *backup_sched __free(kfree) = kmalloc_obj(*backup_sched);
 	int ret;
 
+	if (!backup_sched)
+		return -ENOMEM;
+
 	if (sched->n_channels > IEEE80211_NAN_MAX_CHANNELS)
 		return -EOPNOTSUPP;
 
@@ -275,13 +278,13 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 
 	bitmap_zero(sdata->u.nan.removed_channels, IEEE80211_NAN_MAX_CHANNELS);
 
-	memcpy(backup_sched.schedule, sched_cfg->schedule,
-	       sizeof(backup_sched.schedule));
-	memcpy(backup_sched.channels, sched_cfg->channels,
-	       sizeof(backup_sched.channels));
-	memcpy(backup_sched.avail_blob, sched_cfg->avail_blob,
-	       sizeof(backup_sched.avail_blob));
-	backup_sched.avail_blob_len = sched_cfg->avail_blob_len;
+	memcpy(backup_sched->schedule, sched_cfg->schedule,
+	       sizeof(backup_sched->schedule));
+	memcpy(backup_sched->channels, sched_cfg->channels,
+	       sizeof(backup_sched->channels));
+	memcpy(backup_sched->avail_blob, sched_cfg->avail_blob,
+	       sizeof(backup_sched->avail_blob));
+	backup_sched->avail_blob_len = sched_cfg->avail_blob_len;
 
 	memcpy(sched_cfg->avail_blob, sched->nan_avail_blob,
 	       sched->nan_avail_blob_len);
@@ -380,17 +383,17 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 		if (!chan_def->chan)
 			continue;
 
-		if (!cfg80211_chandef_identical(&backup_sched.channels[i].chanreq.oper,
+		if (!cfg80211_chandef_identical(&backup_sched->channels[i].chanreq.oper,
 						chan_def))
 			ieee80211_nan_remove_channel(sdata,
 						     &sched_cfg->channels[i]);
 	}
 
 	/* Re-add all backed up channels */
-	for (int i = 0; i < ARRAY_SIZE(backup_sched.channels); i++) {
+	for (int i = 0; i < ARRAY_SIZE(backup_sched->channels); i++) {
 		struct ieee80211_nan_channel *chan = &sched_cfg->channels[i];
 
-		*chan = backup_sched.channels[i];
+		*chan = backup_sched->channels[i];
 
 		/*
 		 * For deferred update, no channels were removed and the channel
@@ -421,11 +424,11 @@ int ieee80211_nan_set_local_sched(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	memcpy(sched_cfg->schedule, backup_sched.schedule,
-	       sizeof(backup_sched.schedule));
-	memcpy(sched_cfg->avail_blob, backup_sched.avail_blob,
-	       sizeof(backup_sched.avail_blob));
-	sched_cfg->avail_blob_len = backup_sched.avail_blob_len;
+	memcpy(sched_cfg->schedule, backup_sched->schedule,
+	       sizeof(backup_sched->schedule));
+	memcpy(sched_cfg->avail_blob, backup_sched->avail_blob,
+	       sizeof(backup_sched->avail_blob));
+	sched_cfg->avail_blob_len = backup_sched->avail_blob_len;
 	sched_cfg->deferred = false;
 	bitmap_zero(sdata->u.nan.removed_channels, IEEE80211_NAN_MAX_CHANNELS);
 
-- 
2.39.5


