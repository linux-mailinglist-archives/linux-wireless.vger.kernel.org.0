Return-Path: <linux-wireless+bounces-10577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8793E30C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1870E1F210E9
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589D1A00F1;
	Sun, 28 Jul 2024 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ+sEcGK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B11A00EB;
	Sun, 28 Jul 2024 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128140; cv=none; b=EVhkAQnRU8nZWdnZQjdLg96jyinCnj73HkZx04n7K0kN7lqreYK0CTZMERTYT8jhfbqwHPL4+rYM4hIk5a1kih6A1NIaj7a6X3C5GzhP7WKGBDh4MvpuC4d/lWmprhkRk/Ck9lKy2yyQQSwckFi/FIkFf0Q2ZcY/WcFcmOr1dGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128140; c=relaxed/simple;
	bh=VpQvO4RAU5y+q4bkbshCLv8cjz3nvDeGcsm23WZUl7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3cgln9ixJ4JlxZLzAfI4R0ji+WqWKFXJKRjbgCuj+F9moFkR3Elq96ch/vLpC5LNw+zPvzR15nGNAOaryRptPDAqEV0S4xcfSBGa2JvfnP6b1tTKxpz4lyZtxevfDIhNZt6XqX0rwEMPwwLsHcia2o1lSRG3uBEb0xBOS89R/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ+sEcGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5693C32781;
	Sun, 28 Jul 2024 00:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128140;
	bh=VpQvO4RAU5y+q4bkbshCLv8cjz3nvDeGcsm23WZUl7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQ+sEcGKUbBuEwbsVGz20OPIrcbqT53bdLxqFzyHUg+ieMp0F+5ZYferUci9ByIny
	 rAW0WMpm/RU4RGxXbZsrTCjmhX1eSKPfDcWTpLPnANxrFucWDzKafKktyvD7YBa9sI
	 QU8WTkOo5RjOrx/ePl2Bq/tKnwo0wBtcP042ajL0gHNCe4BwFAN7rALlll2+FegM2p
	 gBc9i61VYqrC4ck9TsUi/drVcGaaez8e7fDl/9CrqdLvsv+Iivu6f234uMg6bgqYGZ
	 lWLISApNAS0mn6qOcXcXwduS+rH35xRdhltbjC+LDwDFcE025U+HGvMCRP5MBwlrmQ
	 wJ6jstnBUIh8A==
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
Subject: [PATCH AUTOSEL 6.1 08/11] wifi: nl80211: don't give key data to userspace
Date: Sat, 27 Jul 2024 20:55:13 -0400
Message-ID: <20240728005522.1731999-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005522.1731999-1-sashal@kernel.org>
References: <20240728005522.1731999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 603fcd921bd22..214eee6105c7f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4421,10 +4421,7 @@ static void get_key_callback(void *c, struct key_params *params)
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
@@ -4436,10 +4433,7 @@ static void get_key_callback(void *c, struct key_params *params)
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


