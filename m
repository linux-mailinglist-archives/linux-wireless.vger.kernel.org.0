Return-Path: <linux-wireless+bounces-10579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B27D93E33B
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD6F1F21EB4
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40511A3BC4;
	Sun, 28 Jul 2024 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXMfMPwV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734521A3BBA;
	Sun, 28 Jul 2024 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128177; cv=none; b=QmNRcc1UwQd2m5vDwmDgKkNdo44Cn6iv4RyCmfn16lwbGmopgTMibwzy7AT93sI020Nke3B9hacGuGAIHG2Btnz4+Ous5L3togy5E+gYqHxgyrjPGMwzOfmEOI96slV0DUI62OiaUkT0QR2vsOJYy/eHqL/Tsy4wb6W4Q6H+lJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128177; c=relaxed/simple;
	bh=dvkkAPDaacE7kiejBF1QSAFOsPJrr78sPM+1SlPO+I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFhprKcYoLIJtUMdEOKweQI+BhIcy2sHFmL2cDEYk5Mn9mZg9QBm7Og+3YhqrNQtybZDHGBz8J11CcsYpv9sIkcrZPy5BsDY/RbERq1ozlj1yAtPUbtdktzJWtTQFc6ROsaM8zyYEX6qrKjj1vlBtSGUQYHVVpdNT7X7jQToWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXMfMPwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60C1C4AF09;
	Sun, 28 Jul 2024 00:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128177;
	bh=dvkkAPDaacE7kiejBF1QSAFOsPJrr78sPM+1SlPO+I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXMfMPwVEcVS0v6f/KHuokIBEBky91Jgo7ask8AqHoXRVt4kMu3SdXvlx8vFdquZo
	 CtCMBlM0u05rC7/7CcQR5bqcOFW5b57hf/bTGuj6vAknXCHppMaUANMuLU01VXUGvX
	 mI9/1FzEhYZYby+uMW325arU5lK+iRW1omwjaxzKb0wPS9uuh3CDrnLXwFcV8KmmeJ
	 ASi+pgSf4KR+gvuPbVdINi+8SXx6zd/HbC/Z4MZEe0E4aNs/AoCG+ttwkDz7WCYO+w
	 og2+Hh9UdBB/BRrr1s7Z2nyZ5jbXE298R3e43x9kTZ+00wjguv07+J/x2qOK0wxYeV
	 /AzMV63qi+xag==
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
Subject: [PATCH AUTOSEL 5.10 5/6] wifi: nl80211: don't give key data to userspace
Date: Sat, 27 Jul 2024 20:56:02 -0400
Message-ID: <20240728005606.1735387-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005606.1735387-1-sashal@kernel.org>
References: <20240728005606.1735387-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 846e40dc00bb6..f9ad7de710cb4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3968,10 +3968,7 @@ static void get_key_callback(void *c, struct key_params *params)
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
@@ -3983,10 +3980,7 @@ static void get_key_callback(void *c, struct key_params *params)
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


