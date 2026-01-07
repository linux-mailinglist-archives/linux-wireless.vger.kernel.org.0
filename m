Return-Path: <linux-wireless+bounces-30460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A759CFE042
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE0C130215CC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72733ADB7;
	Wed,  7 Jan 2026 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UrkoiWMw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA433ADB5
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793063; cv=none; b=SYGVlfusQYZltkZFtfydo1yZLzhmP60DHkqWhqfZLpnYynfdUJurl/lu4QF4yqWXQgGcda5vIcstd6ipMSlqgr+lcXWNMiQSKgeKsgyoiDtD6YO9+zn4508jBUPoWUr8fkEKuoNfcoeKIzy50HSrUODPwvB50W0RVa73JQGXgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793063; c=relaxed/simple;
	bh=L0IttRNk6j9p4qxuytI0YeQYVnFoWU6PejHmm14gjwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMkubiiTb21cYDpjUElbUMhWtrD5xkkjJcoXhYpS0FB6QTl65olLmp2XXRz0B7Goxun9z5QPvN7IK7fW9SWefXCYofWScgx+v/bee6XkvgE34APukqP+6bpi6HF0EjB8+GxqYhRtblz507S49zUjgzJHP5QVpXybyGNa8Vy1lwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UrkoiWMw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=6CwEsksrRgCnvPXKBJtgAyCujeII+bXopNu3uPEyjWQ=; t=1767793061; x=1769002661; 
	b=UrkoiWMwM/8qyF1NzpPMtBbawZ0ssSguBnSztIQjMI5jjCadeijXZ7jqf/IsEXtEbQdBHQ6TECs
	5rSzgOzxYu25XOz/1dbf7HkO0+dVylNJRlbk1TQLdRmqYvLX9J/jBXp/jgooEo40SplTsEl6UWkNj
	PyhapWUknmybrizcQmUXTOCas0+AAhDo0magWzlz/dAJtmOVbWvrWmFZwL6WgGqMwxvQb4aUBqrB0
	GAbmeIUkkKgpPceOSqHjhqTkHUgIRupPjX8DhLtDjP4B1uzlFR2oSP8r8v0iwf2yMbxs2LouBw8Tz
	hdIbEsOCl9ZI6I0VBHOqxbm6S58R3Bc8ZufQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdTjG-00000005ZT7-1jjl;
	Wed, 07 Jan 2026 14:37:38 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless] wifi: mac80211: don't iterate not running interfaces
Date: Wed,  7 Jan 2026 14:37:36 +0100
Message-ID: <20260107143736.55c084e2a976.I38b7b904a135dadca339321923b501b2c2c5c8c0@changeid>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

for_each_chanctx_user_* was introdcued as a replacement for
for_each_sdata_link, which visits also other chanctx users that are not
link.
for_each_sdata_link skips not running interfaces, do the same for
for_each_chanctx_user_*

Fixes: 1ce954c98b89 ("wifi: mac80211: add and use chanctx usage iteration")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 net/mac80211/chan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index d0bfb1216401..d8c5f11afc15 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -90,6 +90,9 @@ static void ieee80211_chanctx_user_iter_next(struct ieee80211_local *local,
 	/* next (or first) interface */
 	iter->sdata = list_prepare_entry(iter->sdata, &local->interfaces, list);
 	list_for_each_entry_continue(iter->sdata, &local->interfaces, list) {
+		if (!ieee80211_sdata_running(iter->sdata))
+			continue;
+
 		/* AP_VLAN has a chanctx pointer but follows AP */
 		if (iter->sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 			continue;
-- 
2.52.0


