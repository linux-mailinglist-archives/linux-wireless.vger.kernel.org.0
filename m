Return-Path: <linux-wireless+bounces-10578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0993693E328
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D6C1C21140
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC41A2554;
	Sun, 28 Jul 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw3VnC8M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB01A254F;
	Sun, 28 Jul 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128161; cv=none; b=q0STCjEo3U8zKwka7EP6PhWo6cBVr9NE7LtI8gb9W5KIzRw6jrI4qljomCSEEmRV0ZvZRBdRJZpxyH+FGGxQltPndkslyK34ZFnmJk/BZKBx660BHwcoMMiI1PwO+6cpuW7CDXFZB5XxqVEEoSHDEb0w455DZXpEysDZiGYWgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128161; c=relaxed/simple;
	bh=McGun3hKDWWG76yQinsdnDyfqiYmyzSUv0CHoagLixw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnh1edrPQvydOYAUby8UuewPYmJ8mhOJ2JigdPIrWejgoukQ9jBRqc0kSfNyAlJ6Jxck0HmQvlmjGX49ENa1WPuS+f8xor0BUFoMqe0ThpIIT5Ji+sBOikK1c2hwGk6ukNbGi3ik9Or3VaFsXLoAWpKZsHILViqqKCPTjVBWZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw3VnC8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA36C4AF09;
	Sun, 28 Jul 2024 00:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128161;
	bh=McGun3hKDWWG76yQinsdnDyfqiYmyzSUv0CHoagLixw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pw3VnC8MpCW2tIuoDWN3ngYZQrjbPnTWMVBz0aU9V4FxjCKvmhVG5h6HzAeQv9gff
	 2wBcNlOp/u95sQYfvHYClCQOitFhoQtGlhdtEgD1ipbHWXTO25yxk/Cd77U3MCkUMA
	 h1+FW8Wp6ObCiyxynvipbJNSIaxRbZUmlbFI75nApM1itHHkMvUnKuDCZlFDHcaKfJ
	 eQy2NHpHwPW5aDjh489QedvKis6sB84I2uDDHaNIGQDs2BfPi50GscY72eUneg6lBT
	 8KTwvRrE59WcdPizIkBZwSjjKm9E4LlgP7+lH26gcCAYZ+SwdWyXGYYVfQ5REN6T9K
	 F/s+3PNXDQ9/A==
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
Subject: [PATCH AUTOSEL 5.15 5/6] wifi: nl80211: don't give key data to userspace
Date: Sat, 27 Jul 2024 20:55:46 -0400
Message-ID: <20240728005549.1734443-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005549.1734443-1-sashal@kernel.org>
References: <20240728005549.1734443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index d758ec5655892..9ff4c8f1a1829 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4137,10 +4137,7 @@ static void get_key_callback(void *c, struct key_params *params)
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
@@ -4152,10 +4149,7 @@ static void get_key_callback(void *c, struct key_params *params)
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


