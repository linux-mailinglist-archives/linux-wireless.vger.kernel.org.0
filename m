Return-Path: <linux-wireless+bounces-2737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D1D8413A0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D1228433D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD21E4E1BA;
	Mon, 29 Jan 2024 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PwTE7zrc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF815705E
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556950; cv=none; b=R0lFLLLNeZtAUGqQTWGobvcuLlhmys5IZsnnveM0LFXsk9XQylVKvsuIoZJZEmsg37GDLSTKWYCp5KJ3Z7LxqwiCHk3S0VoY4EyRareio+hh4f8jjq7urKFlfERDKLugLGviNJlcDKciIt+UT1LvisvXHQxJJXaEAO01PTuYNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556950; c=relaxed/simple;
	bh=3EQjtWsS4OwB0JOIyVXpPaZWm0FREW4GbwAa2a/DEO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pziV6IASyj1WBNltqedMgncICVsc742NMGFDj1XFBfHyMXl+YqVMh8JEH8deoZffHVrKPovwu21jOlyuhZ4+LA8gdmqeETzfsm63RslwNQiEsl+CdYFeJcJN7RRhsCmy752oLoKD5D5unLJzYSg+0v1eRRL7YHSSlpVL56A/E7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PwTE7zrc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=fnsj4qsosH2pk8jEEZi0PPmDUFSR6Svca5HkV8IFDxM=; t=1706556949; x=1707766549; 
	b=PwTE7zrcjzgOx7s2X4Ynh6G7V4KxbiA7GBHKWDlfJ3ALrsZAB8phgDEUUfIgVOwGQVSgcZOB0wF
	Hgd6fUT9DuPZ88FSCTkU0iFdwdCOAV3e0znZ8gDprOoV6meteUiTHGXca3NQBrjBRz77MqIL+ciwR
	4FhNN8pEI0V8g+dQLH5KJZjMXBlDvvvMaZPm0ejlwDt0eM2qagO8lCcwHC+4nxOxV3PVBJRvnqI6r
	/CnntUi5OA+V1dAX9/a/hvjF91P/qFMcVR4gZyxtbvudPQQloXUdT1jjBIqQptEq/GGvFRKFl60nE
	PnXfJQ5BJNb6kXIh0jzIyTcCZWQKfvPeZfrA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXQ2-000000051Ns-2u44;
	Mon, 29 Jan 2024 20:35:46 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: allow CSA to same channel
Date: Mon, 29 Jan 2024 20:35:45 +0100
Message-ID: <20240129203544.ef7258d5790d.Idafe22e41621757458d4960659b9621853f7104d@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This could be used e.g. for temporarily sending quiet
(mode=1 in CSA/ECSA), or updating bandwidth. This is
also useful for testing, since it's something that an
AP may do and the client needs to be prepared. Simply
allow it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8f647e28e354..c92acbf7b002 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3874,10 +3874,6 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->wdev.cac_started)
 		return -EBUSY;
 
-	if (cfg80211_chandef_identical(&chanreq.oper,
-				       &sdata->vif.bss_conf.chanreq.oper))
-		return -EINVAL;
-
 	if (chanreq.oper.punctured && !sdata->vif.bss_conf.eht_support)
 		return -EINVAL;
 
-- 
2.43.0


