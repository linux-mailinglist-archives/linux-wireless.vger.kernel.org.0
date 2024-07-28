Return-Path: <linux-wireless+bounces-10581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8132293E35A
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAA61F21FA8
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBFB1AD40B;
	Sun, 28 Jul 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojVQnoVl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AEA1AD407;
	Sun, 28 Jul 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128204; cv=none; b=jVoviOrGnH/L8uIfd9bO+ogNPWUEgZusaUvFrVsy78h/2LzpyD7mU8G9nQuBe6xPA6U5LBMvTw+HIFs3ZKR2IcI0BVJnc1kn0NsF3K/XGK0rIOFeHau3rUZpan0239kZsiR6p3dshjKre03SQhHrgV91Ki7woaJeM7anZe6iwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128204; c=relaxed/simple;
	bh=qzdVVb2oStn+HphjoGBguQm7zZ4R8M3Kn0CKRXboWHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEXSvi7VltY1vZ+7Mhdm8Sk3Yruu3f+ngdZEDLgFapJCQKvSIivjyvpMFERaG8OkvxtwyZDphwWXjqMfDhLFuJ/Z9nnkt7fePgX5FhHT2oEwNbEJqXDE/MYyMb3pmevPw4fs/MkpY/B/6XHkDbBJyAAmz5JyqEtyzZF8wRoRWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojVQnoVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1B2C4AF07;
	Sun, 28 Jul 2024 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128204;
	bh=qzdVVb2oStn+HphjoGBguQm7zZ4R8M3Kn0CKRXboWHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojVQnoVlqwYbvEHW1gAeknpwcwsMUsz5RruTT6sc9DZQ/0LBqr7xgoteVsjcNee/A
	 8hf6UmN4gy5CyIoDy/w7F39rYu+rkI2EJJYsZ7uGuzFzYTidGKDpYAGJTyRSUETz5N
	 KpbRu78YWw18vZIUTB9VxUXAkKyRWoJvxGf24WMyhZx1UwkEfWgnU8mstf010cg8pm
	 wCfMld2Glob3ySNgVB8R0eMu5iq+16Wbuf2PGYJUym0JU/Ei6ErmKG+hxfeA4vSZ78
	 zgTOdYvSmBEut09P5P5yfSjayVfQBY+aTCxQ+pgoL9ds2frqv9Hw4apCgEQwf9ZXpI
	 dV8Cfqh6RFqvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/4] wifi: nl80211: don't give key data to userspace
Date: Sat, 27 Jul 2024 20:56:37 -0400
Message-ID: <20240728005638.1737527-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005638.1737527-1-sashal@kernel.org>
References: <20240728005638.1737527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit a7e5793035792cc46a1a4b0a783655ffa897dfe9 ]

When a key is requested by userspace, there's really no need
to include the key data, the sequence counter is really what
userspace needs in this case. The fact that it's included is
just a historic quirk.

Remove the key data.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240627104411.b6a4f097e4ea.I7e6cc976cb9e8a80ef25a3351330f313373b4578@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 15f28203445cb..ebd8449f2fcf1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3383,10 +3383,7 @@ static void get_key_callback(void *c, struct key_params *params)
 	struct nlattr *key;
 	struct get_key_cookie *cookie = c;
 
-	if ((params->key &&
-	     nla_put(cookie->msg, NL80211_ATTR_KEY_DATA,
-		     params->key_len, params->key)) ||
-	    (params->seq &&
+	if ((params->seq &&
 	     nla_put(cookie->msg, NL80211_ATTR_KEY_SEQ,
 		     params->seq_len, params->seq)) ||
 	    (params->cipher &&
@@ -3398,10 +3395,7 @@ static void get_key_callback(void *c, struct key_params *params)
 	if (!key)
 		goto nla_put_failure;
 
-	if ((params->key &&
-	     nla_put(cookie->msg, NL80211_KEY_DATA,
-		     params->key_len, params->key)) ||
-	    (params->seq &&
+	if ((params->seq &&
 	     nla_put(cookie->msg, NL80211_KEY_SEQ,
 		     params->seq_len, params->seq)) ||
 	    (params->cipher &&
-- 
2.43.0


