Return-Path: <linux-wireless+bounces-10572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529EB93E299
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BDDB21D8C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00019149B;
	Sun, 28 Jul 2024 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcFvuPno"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA2191496;
	Sun, 28 Jul 2024 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128054; cv=none; b=SyluVyQQnImFod55ux/xBxQwwY2B/1h2KTbdn1xDINIT4Y+w97x+eTET6AQYBRzFRnsDpcvOV/2WwUo5PYZlPOZw/XhoVgOLWUVky/N0p2O7h0RSUsUnEfmLsnrjhlKpNM+O06ZKtvDBw51dNYNtWBan5AGYu/dxfWHejX1gTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128054; c=relaxed/simple;
	bh=dNcT6zvBsQVLj1Ly5S7urfD5j1AbpzE+00HRb5e+HVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNeBFLk+LOuo/adsChG1nvdeqLlzRzE7hFc7YMJdv6u6ZJjbjc5PZl8Q9/oyBi72OfwjI5ptNRsKYObBjWfquLOJ062skpcN3EYkq/lxEb1Mxb+eZdY9KEew1KdYjiBwZhIys0Ec/JqK4hxSHjPj6PhVAyceBYMEkrrosiTqFTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcFvuPno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE66C32781;
	Sun, 28 Jul 2024 00:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128054;
	bh=dNcT6zvBsQVLj1Ly5S7urfD5j1AbpzE+00HRb5e+HVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcFvuPnoOa7ovg1MUznIJPnowH1GSeMf2Ab9XzKo8hMiOTtEDCW0Zmzmn8Bij97iC
	 TRp/Tdp2JixMjML8BMg7XS0+QnVA0xlpLDsYNu7kbVAYD9g1ntpEE9pzCNX9LONTDS
	 aGMA1LxOWaOKXlGFIXn2dd8MyWmyo44OHt8sQEDDZ7+MeSmQETwk33JuxE7njj1VTx
	 CKCJtw6KQb8HEP/MP9u3Nd6voJBsJQDKykbbMe38HRPhra0pXmEbu4adX0F3TJUl5M
	 3q1sk1QiRiCX7ciqBpLdhF43lVKmsCmdyGF+G83Lg1WwXYEQBeoZMA3T26rjGp+0YI
	 qI3w0rWuxmJ/w==
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
Subject: [PATCH AUTOSEL 6.10 16/27] wifi: nl80211: don't give key data to userspace
Date: Sat, 27 Jul 2024 20:52:59 -0400
Message-ID: <20240728005329.1723272-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 81d5bf186180f..715ecbb3689e7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4482,10 +4482,7 @@ static void get_key_callback(void *c, struct key_params *params)
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
@@ -4497,10 +4494,7 @@ static void get_key_callback(void *c, struct key_params *params)
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


