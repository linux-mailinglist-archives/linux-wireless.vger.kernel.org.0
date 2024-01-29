Return-Path: <linux-wireless+bounces-2690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6F8412AA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229B41C208AF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F52015A4BF;
	Mon, 29 Jan 2024 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R8yuVuiv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3D158D6A
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553687; cv=none; b=r51Na//F7LqNUeXm6YPoNF2jGgKP24gBn9ebYh8eheg6eNYwcwtFQWNW6VNU1TtNWU7rd80CiAxCjHcmpyUuv013bfIjlBLe8k4a3I7AejpGqTsoxhjXGvj0wqVaQ040mCKrDcFKsIKUkM9MOTzEGlW9filcy1IZ5b9hBaGCeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553687; c=relaxed/simple;
	bh=vF1xHAkaL8sdbmL2/nzDPmaaepLG0nAZaacy/Y3dYLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUJ9zSogPdVWRnKQv9u+4/x7+W/A8kET0oEeJpyVpPLG8ytQfxDnaTQba/6dEDydonW4HYVk8fIcwwwUjoydQ6mj8ht/++olltRmq4bvajyMghjRO46R7cffb/Ig1wt27KqAPik10YQ+PunA9aBwI2x1VFKQAoFYhy6PoSE6tLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R8yuVuiv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7wWAy1oqsd71mYz/uh6Dprml+565Z99Zn8z9fpl/tXs=;
	t=1706553685; x=1707763285; b=R8yuVuiv4L17DI53u/T9VLE0rJGbcDtMYgdGX0VsNkDEdOi
	zXHZ6SAoU90dtjc1CsRCs7FiRJL2xFpu2kmRSlwi/WXw8hVJ/VB8c6l7+vjMVKesWrxMV34kCNwH4
	gq47u0v9G8xQ/XIGjOcsQwQANBI3QOUBvTdFcY0f08YU7eaKjqmG8NyvMOYrcjCTcku3e/xV5QFbD
	oZPVFZkXl+QfemYvyIDc/9YYxkM2NTyZEt2PatDRbVHyoMnDTptl2Lx0nu93sp1PG8fHOmrBNM9iz
	iqHqmZiaJmmJVRA02TXYUKgvYgLzR2GXal4NQsWZcVPwQ3oAOaJCZn6UmN0J/vTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZO-00000004z9N-2WPh;
	Mon, 29 Jan 2024 19:41:22 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: mac80211: use cfg80211_chandef_primary_freq()
Date: Mon, 29 Jan 2024 19:34:48 +0100
Message-ID: <20240129194108.eb59d6433d18.I74b745f0d1a32e779fb25d50c56407be7c35b840@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129184108.49639-17-johannes@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Instead of calculating the new primary 40/80/160 MHz
center frequency here, use the new helper function from
cfg80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 49eef33b5e70..63a88169d53d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4365,8 +4365,9 @@ EXPORT_SYMBOL(ieee80211_radar_detected);
 void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 				 struct ieee80211_conn_settings *conn)
 {
+	/* no-HT indicates nothing to do */
+	enum nl80211_chan_width new_primary_width = NL80211_CHAN_WIDTH_20_NOHT;
 	struct ieee80211_conn_settings _ignored = {};
-	int tmp;
 
 	/* allow passing NULL if caller doesn't care */
 	if (!conn)
@@ -4390,12 +4391,7 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
 		break;
 	case NL80211_CHAN_WIDTH_80:
-		tmp = (30 + c->chan->center_freq - c->center_freq1)/20;
-		/* n_P40 */
-		tmp /= 2;
-		/* freq_P40 */
-		c->center_freq1 = c->center_freq1 - 20 + 40 * tmp;
-		c->width = NL80211_CHAN_WIDTH_40;
+		new_primary_width = NL80211_CHAN_WIDTH_40;
 		if (conn->mode == IEEE80211_CONN_MODE_VHT)
 			conn->mode = IEEE80211_CONN_MODE_HT;
 		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_40;
@@ -4406,21 +4402,11 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_80;
 		break;
 	case NL80211_CHAN_WIDTH_160:
-		/* n_P20 */
-		tmp = (70 + c->chan->center_freq - c->center_freq1)/20;
-		/* n_P80 */
-		tmp /= 4;
-		c->center_freq1 = c->center_freq1 - 40 + 80 * tmp;
-		c->width = NL80211_CHAN_WIDTH_80;
+		new_primary_width = NL80211_CHAN_WIDTH_80;
 		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_80;
 		break;
 	case NL80211_CHAN_WIDTH_320:
-		/* n_P20 */
-		tmp = (150 + c->chan->center_freq - c->center_freq1) / 20;
-		/* n_P160 */
-		tmp /= 8;
-		c->center_freq1 = c->center_freq1 - 80 + 160 * tmp;
-		c->width = NL80211_CHAN_WIDTH_160;
+		new_primary_width = NL80211_CHAN_WIDTH_160;
 		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_160;
 		break;
 	case NL80211_CHAN_WIDTH_1:
@@ -4442,6 +4428,12 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 		break;
 	}
 
+	if (new_primary_width != NL80211_CHAN_WIDTH_20_NOHT) {
+		c->center_freq1 =
+			cfg80211_chandef_primary_freq(c, new_primary_width);
+		c->width = new_primary_width;
+	}
+
 	WARN_ON_ONCE(!cfg80211_chandef_valid(c));
 }
 
-- 
2.43.0


