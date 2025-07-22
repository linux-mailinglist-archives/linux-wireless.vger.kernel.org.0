Return-Path: <linux-wireless+bounces-25872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B64FB0E074
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E01C839A4
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC23626529B;
	Tue, 22 Jul 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pJ8ynarc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E42638B2
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197924; cv=none; b=c4Pdn8ZcMF+HRVPjFexvoBPd4B0hBT38JZmR0SraY7t3ajQfhwJ2jU9j3lhd+K4mZEbbwecp82i28xSktGUSLz4mdWPw8RrRSNqkPV8BdCfPtiPDniFVFYU6WrV/k+BpZ4XzrS6GUoFxDxRjqcNrNtcblDKYvyTOfxEA2sXGeTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197924; c=relaxed/simple;
	bh=rfUoYh4o9HEeRm68vvlrrIdS/pqOrOJCg2YQTAbNcLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2G+5/LbgCuUFlxipp42ndiAdz1ACmKQHlIRYshrykMtgT313Ny/lFOzcIQjEK/SjwUjxCVrZLQukNoPioDNKqP7MXl4lKYR9LmZGC46DHMxoJb5DRHoQpwUobClwXCPprecoAL+Scr1Fb223KDmUUZGPwldsF/Ksi0MJsfW5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pJ8ynarc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=S0zLxzX3FmZmyLw2YeoS8oVQ12owvtOWerdFshfp2is=; t=1753197923; x=1754407523; 
	b=pJ8ynarc7U7V8e5Q+5PU50E8beQJrGG0ZU77u4QuUH1Xt6RtPIQwxiccJHXLleLUgwbBJ+m5y6q
	LRsZn0uLBA34MPp3wMD+H8WDHMBr62SLLJTLUOHKjGEBLkdhVGhpMwOCItovBgktDBmPVpTJ3WS/v
	1+v6CWt8xE58CeXJmKMD92qEhSYJ6a6Wprp9iKw/TB0znFwk6clXz07aK52TfXtjDUtUCU7aO9/hX
	YZc9dFkiso3ERAekrw7oVhelkH474K4u9VxcJhQXaHWEknoLwQqn9gedF2bK8V8cAg+BVSRd3yfNg
	C/gVa+CNovTVQgTTb5sl8y84Fx2CUoEHmwmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueEro-00000002HiI-05DZ;
	Tue, 22 Jul 2025 17:25:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: [PATCH wireless-next] wifi: mac80211: fix WARN_ON for monitor mode on some devices
Date: Tue, 22 Jul 2025 17:25:17 +0200
Message-ID: <20250722152517.30340-2-johannes@sipsolutions.net>
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
 net/mac80211/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6b6de43d9420..63393eabc501 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -407,9 +407,20 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 
 	WARN_ON_ONCE(changed & BSS_CHANGED_VIF_CFG_FLAGS);
 
-	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+	if (!changed)
 		return;
 
+	switch (sdata->vif.type)
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


