Return-Path: <linux-wireless+bounces-10575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5993E2DB
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37199281EA2
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC6113C8F0;
	Sun, 28 Jul 2024 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTznLrXC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D0198823;
	Sun, 28 Jul 2024 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128103; cv=none; b=pxvhIPcZyUxxCr6PmA5Go66hsYwKyemaPqhosREPaprdvlNYtNLzrr3QbnwWEvOxRHIDh9plNzeJUtfCpU2qxeJy9Pj38/uOn5Fs8CPdefy8zFbh4J708IEhTibeXap6Kzywy9ulpra6rHgFCfj39D0rMFH8WMcjA5lDYnxvX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128103; c=relaxed/simple;
	bh=MA3XM1jeguBBrdp4swl4qkAPtLoHxSwGVkYozfJv89o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jdieaw+5kodGDxLc5NeOWuZe7au22XZTY5TiB1ubYaekViRb6bOEVh3NV2nFXIEbODs+2enox030IrejE4AsEmkJZeO5OHU9emizooiyY2AJmy8Oh7n53sROhPqpgJv0gbtMlg+qT86nKPkNSKPBhdE7w+fELKk+WC9EKG0UX3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTznLrXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9E9C4AF07;
	Sun, 28 Jul 2024 00:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128103;
	bh=MA3XM1jeguBBrdp4swl4qkAPtLoHxSwGVkYozfJv89o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTznLrXCDc5+UBdAHflJ4Nk7tgGW5sbgnpLuqnSefurgbPuqGKzRRo2LNL1EDQzqX
	 1Ob7pgTkV6b3ATryRbJUTEEzoIptYoxrxDS9ZA3ZxBHWcAt5iiqAil9kHP96u21vE1
	 LAHxDnq+cem94VR8829qZd0TsUiN4LtkQKVSzp/WIeGpQ8P2o0vw6+45nboik/kPMB
	 pJo2Ob8n/wkBrxMf2ifb1Q+OK88rR0LaF+ZfW08eUZWoMX05Dm5ZRRuT20FqO3Jrwg
	 y9zi18vZITdroBiSu3hD0mPNBCz1IplPN323h4N2sIKd/pRXaZ729v4TPEX8FB1IO/
	 Wpq0EnS2afzMg==
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
Subject: [PATCH AUTOSEL 6.6 09/15] wifi: nl80211: don't give key data to userspace
Date: Sat, 27 Jul 2024 20:54:30 -0400
Message-ID: <20240728005442.1729384-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005442.1729384-1-sashal@kernel.org>
References: <20240728005442.1729384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 053258b4e28d2..be5c42d6ffbea 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4473,10 +4473,7 @@ static void get_key_callback(void *c, struct key_params *params)
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
@@ -4488,10 +4485,7 @@ static void get_key_callback(void *c, struct key_params *params)
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


