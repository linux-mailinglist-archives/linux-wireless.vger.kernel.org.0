Return-Path: <linux-wireless+bounces-9649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F691A1CD
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 10:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11E41C20E91
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 08:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3AD770F9;
	Thu, 27 Jun 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="v8cI+uXx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A6131E41
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477864; cv=none; b=mQxS3HPJKBplVkpSWIWZqXzQg0r0KrUZ3NZmIYGxxXIIAPI7WHQZr0tfagYS0ElSGFTLrVMx507bu9oljK7kEUdObJww7YkoMWv1AY/HqxKf3dpavFRA61gWL4S9H+c3r59xqSPJQSPgGEDZN6RD2U/SEDa3TLO1HW7NNRwlhN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477864; c=relaxed/simple;
	bh=VPQUNJKhYdZNWTylpP+rrsxntMvpJZVHFNXTaH8RGf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duJJOJe1loiWAiHlT9Dwh4xxZtolM++4s+vKBgP2quKJEXvQE9S2hCivLy2WaUVeTCV/55aAljRnwLouzT+qHfaCsyDxU7+wtI+ZPLreliiuE3CxxoAU2Qk7OWW4ZMEgdwed/TveJQ4LwGl6/MwpTJaQ/KdDL2/TyiWDYZzxB+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=v8cI+uXx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=tQWXCX8Y9t0oRias0uDtHTUSLKIMk4mys3zwUc3v+DY=; t=1719477861; x=1720687461; 
	b=v8cI+uXxW+As0/LTIwBeYKPxfLBco8s/eBckqFZd3Hd47eExwV25AaXIYboSdEchhqSRHC1IWAk
	n7Sqh3O1MQzpfH773dgYzs2G4CLnz/xol3rFLkkT2WNseYxR50dqMYaYaZ0EQXKCOxnMXyqPpMSQD
	EfnpOCFnqeXzDphe5So1zp0ifKeH7mU5chHnnO7vR/7d42U7ZZoC//qu4k9IFp+ex4Lpn7BrrfzPr
	lWRtiUuXnuKnxskaPSoeStcZvt0cOR3y0nkmrvH1H9VhlVLHPTypNsZZz6zhr8CFrVTFy5aKCDVwR
	RhPfDtv8XBJuJ84XhkCDWZAWsb1akMj1AEKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMkjq-00000006aek-39Iz;
	Thu, 27 Jun 2024 10:44:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/2] wifi: nl80211: don't give key data to userspace
Date: Thu, 27 Jun 2024 10:44:11 +0200
Message-ID: <20240627104411.b6a4f097e4ea.I7e6cc976cb9e8a80ef25a3351330f313373b4578@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When a key is requested by userspace, there's really no need
to include the key data, the sequence counter is really what
userspace needs in this case. The fact that it's included is
just a historic quirk.

Remove the key data.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 72c7bf558581..63899fb2f316 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4455,10 +4455,7 @@ static void get_key_callback(void *c, struct key_params *params)
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
@@ -4470,10 +4467,7 @@ static void get_key_callback(void *c, struct key_params *params)
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
2.45.2


