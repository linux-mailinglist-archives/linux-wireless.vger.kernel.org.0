Return-Path: <linux-wireless+bounces-9650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4898A91A1CE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBFBBB21C94
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB31137923;
	Thu, 27 Jun 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eL+tXDZF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA49136653
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477864; cv=none; b=J9suJPaxf2JqXH6X1kBxU6zX5lncsAGgb16S3Xn6XKQtN9FXP03UNmS1bDHlvOH4ckAxLxRCi3JWC8x66S0miQDlTSU1x2rBTzUn9zlHo5evtrVun7kZDUCC7L6ZxnrIEe8g0bTQkoDtVleqCCzqJvM/BOQ1hdMQ8G8nRcz7JFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477864; c=relaxed/simple;
	bh=PrIoiPZrsJB7aBEjPG0lzg3q7jc1mx6M7DN/5lImNZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhTKQwMh0Hd+FjZhMArGZMZglIiSZ9jPkwoQZbS+iScJS8G3DGZ1dqYKCU7nfbi1CDia4mkHrWf53bL0J92MAJp4mibYxK3MKBPe2ndPVUAUcSDaOrlfLuPeHFsS6WLQ9QqGwNOPg0SnpKmLFi5YABidfYgku1xEe80nVYqnke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eL+tXDZF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ikYr4gQ//JRZHxrNESeTEtMxfRnYw/bFvpk018kJqmk=;
	t=1719477862; x=1720687462; b=eL+tXDZFCmIMTEUhF8q5Vlamk/svWdhb9v5QWGLhasqX7R4
	xtu40rAptK1CI6b3b7dIeMJ/5+X2X5xrGX1sxR/yi1z2nLvRaIPA8q3EklssOKQU9b5vWRw6NBQP4
	qBE7NuU4VKKzqZVyJl7WRznoPQlFseeMc+FBsUmHsKwjRVObkzukynoODdXlK/4wnSLjZrZJb/Pei
	qpRxJxDIMCflOfOKVwbPBQkZAY54F3b0NbOtGQTP9VpnOUlHUs9ZbveeWYUu/li9ZH62jnNg593lC
	Wjz/Uf+PrU2XwSf8trZK8bd4QBAqMv7eVi4EYso0UaYvK/IEduViycw0zpTWRcQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMkjr-00000006aek-2dxO;
	Thu, 27 Jun 2024 10:44:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: remove key data from get_key callback
Date: Thu, 27 Jun 2024 10:44:12 +0200
Message-ID: <20240627104411.f8ac49a8cfe0.Ic01f775903f0acd10b9ba77eb39d4ed50e709173@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627104411.b6a4f097e4ea.I7e6cc976cb9e8a80ef25a3351330f313373b4578@changeid>
References: <20240627104411.b6a4f097e4ea.I7e6cc976cb9e8a80ef25a3351330f313373b4578@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is now unused in nl80211, so there's no need to set
the pointer/length.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 83ad6c9709fe..e77c7e7d5f56 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -742,9 +742,6 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 		break;
 	}
 
-	params.key = key->conf.key;
-	params.key_len = key->conf.keylen;
-
 	callback(cookie, &params);
 	err = 0;
 
-- 
2.45.2


