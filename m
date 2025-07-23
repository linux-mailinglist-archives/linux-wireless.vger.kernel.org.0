Return-Path: <linux-wireless+bounces-25910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DF9B0EB8B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381DE7AB762
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 07:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6882586EB;
	Wed, 23 Jul 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BPIClsNV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7F158535
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254900; cv=none; b=k8HNBBinuli42KiLRbs/HzmaMte0xf2iiL4zAVekk0lyDy6e//T2VEhHkmCV56hQVDzT/vqPBGAl48L3We3jp7QxEwoJt6DjEW+9CdjeXnUhGR3UvGHj1tktfCoArxkE6s1xk8pn7hDa2/8bACm5E7MbRpbBmETZtR/CBNuQs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254900; c=relaxed/simple;
	bh=POjaZi5X8ErjnPG/6Deq28HxXdyMRTte4NschZ283KE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srGQF1ndXUQsYRIEykCrd0nLUbaivrjwb++hM1RKI0VeQ6eqf+SzUyq1e5frqjXkUlS8fi2lqzqxa6wpNIQk5OARHqoMzNrF9b0uJLOg0ZMDzPIwIHRPoHBUfIE9v+0vZjy7v4BAJpUr99s9V7/BjOFKZGGgGZjrRMFYNXuLlJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BPIClsNV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wCz9AyMZOHMyZlEg1UJBiV2i2qTOtiNZPytgIxQrAFU=; t=1753254898; x=1754464498; 
	b=BPIClsNVWp5BdwflXbp4tLuUyplSR6MO8E5NSEh8/BARl0ecBd7hFTVo4QHaCTNN+yDEzIgkTe2
	wzIZvyzkPEPOmXXY3ZAtrzfgGYtk9nhOlQJaqRf5FNrWRffwFN0uwy+Ik/YqhNIeyXaVrzKOUwEsL
	dKwu12B0M7TTXtGEv1o/1d9UJJjntU7mOyrsQLs/gwPwZzvanL8fCEU2YxS2sTB+/ENd2ruwsSaID
	jf9I48jvJ5xvi8Rugq8g0c5mVfoSprGkoqAsy67yeztvZD5xH4Pkl3AGXFw8lHYn+Jl4l5esumAk/
	ixRC4UJtyksLtr0SMIxt65Pv34snS5p38SUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueTgF-00000003XDA-3TU5;
	Wed, 23 Jul 2025 09:14:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: [PATCH wireless-next v2] wifi: mac80211: fix WARN_ON for monitor mode on some devices
Date: Wed, 23 Jul 2025 09:14:19 +0200
Message-ID: <20250723071419.7081-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

On devices without WANT_MONITOR_VIF (and probably without
channel context support) we get a WARN_ON for changing the
per-link setting of a monitor interface.

Since we already skip AP_VLAN interfaces and MONITOR with
WANT_MONITOR_VIF and/or NO_VIRTUAL_MONITOR should update
the settings, catch this in the link change code instead
of the warning.

Reported-by: Martin Kaistra <martin.kaistra@linutronix.de>
Link: https://lore.kernel.org/r/a9de62a0-28f1-4981-84df-253489da74ed@linutronix.de/
Fixes: c4382d5ca1af ("wifi: mac80211: update the right link for tx power")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: add missing { to fix build
---
 net/mac80211/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 351564360c26..9c8f18b258a6 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -408,9 +408,20 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 
 	WARN_ON_ONCE(changed & BSS_CHANGED_VIF_CFG_FLAGS);
 
-	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+	if (!changed)
 		return;
 
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP_VLAN:
+		return;
+	case NL80211_IFTYPE_MONITOR:
+		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+			return;
+		break;
+	default:
+		break;
+	}
+
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-- 
2.50.1


