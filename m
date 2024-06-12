Return-Path: <linux-wireless+bounces-8852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD5905052
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8921F23225
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B23316D4E8;
	Wed, 12 Jun 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ncPKYwBj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356933FE;
	Wed, 12 Jun 2024 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187838; cv=none; b=o99gHIp/oZiQtqoty1E/I0VZmZE1AGYvcslzWjdqjDtlbek43hSFlegAhbiFAVe3e0WSLj1BhDJig/cWJ3AulMmIhOb5raYlhxxvkDsPjhPS3V2JB6Vaso+D+rrjFRi7e6Yd6CodNY28UtId7foCMBFJvH9HyNx2XrKS3cLW0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187838; c=relaxed/simple;
	bh=2qHJFYFh73lrvWmxHb3NTQP9Z7uyaBW3xz+u/xTP04M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXO+O9hEdwEnkczQteJkzOtUnx4+mMORFwlrsf386rJMFDMzxctbhXqNreE6vwGvh6l5R/Gtr/9T58DnQNUGss3nSnFsP6+ddPStVh97jGIIYG2ZKTXff7VFZ2dM2bnqppUo8S/r7k5Nn84GydTH6HXNJ1SfAHygraEuF6oQC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ncPKYwBj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WIdO3VKldfixdQMF9J3eD7EHRNfF+VOZV3up1G9FO9I=;
	t=1718187836; x=1719397436; b=ncPKYwBjTTyfrZ9rc1T3juhtCpUB1VLyG7tOrTJx/rpGzSr
	/jbJveMC2i7067Q1iFB3WrT5oaLPyKUs0aiUs7fRGUPNPEdEFNXcJHuTCDgh6YXvvtQHxL917r+i1
	I1YCvkzrzsn2NvAodA/w3P0Tlfe5sRoeVCxvl1D1iPJGqPUMM8TDNQrEAUm+HIDFM2Y5vah6jZkdF
	dzVtZjjTrxYhiHqzEst/xCsdUPz+uA4DUzQSx/kuOAKzXIJyMWfrtfQRJRlcOEtChZcpqpDY6AEeR
	YRrq2hzVGU0qNfAhOtkJdunF15uh5UyUEq+yVVcXwPfZcYYE25r4pTkNcsDwqydQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHL8z-0000000A9sU-2Q1T;
	Wed, 12 Jun 2024 12:23:53 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Savyasaachi Vanga <savyasaachiv@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: fix monitor channel with chanctx emulation
Date: Wed, 12 Jun 2024 12:23:51 +0200
Message-ID: <20240612122351.b12d4a109dde.I1831a44417faaab92bea1071209abbe4efbe3fba@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

After the channel context emulation, there were reports that
changing the monitor channel no longer works. This is because
those drivers don't have WANT_MONITOR_VIF, so the setting the
channel always exits out quickly.

Fix this by always allocating the virtual monitor sdata, and
simply not telling the driver about it unless it wanted to.
This way, we have an interface/sdata to bind the chanctx to,
and the emulation can work correctly.

Cc: stable@vger.kernel.org
Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Reported-by: Savyasaachi Vanga <savyasaachiv@gmail.com>
Closes: https://lore.kernel.org/r/chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/driver-ops.c | 17 +++++++++++++++++
 net/mac80211/iface.c      | 21 +++++++++------------
 net/mac80211/util.c       |  2 +-
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index dce37ba8ebe3..254d745832cb 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -311,6 +311,18 @@ int drv_assign_vif_chanctx(struct ieee80211_local *local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	/*
+	 * We should perhaps push emulate chanctx down and only
+	 * make it call ->config() when the chanctx is actually
+	 * assigned here (and unassigned below), but that's yet
+	 * another change to all drivers to add assign/unassign
+	 * emulation callbacks. Maybe later.
+	 */
+	if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+	    local->emulate_chanctx &&
+	    !ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+		return 0;
+
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
@@ -338,6 +350,11 @@ void drv_unassign_vif_chanctx(struct ieee80211_local *local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+	    local->emulate_chanctx &&
+	    !ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+		return;
+
 	if (!check_sdata_in_driver(sdata))
 		return;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index dc42902e2693..4a49e834a9f5 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1121,9 +1121,6 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	struct ieee80211_sub_if_data *sdata;
 	int ret;
 
-	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
-		return 0;
-
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1145,11 +1142,13 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 
 	ieee80211_set_default_queues(sdata);
 
-	ret = drv_add_interface(local, sdata);
-	if (WARN_ON(ret)) {
-		/* ok .. stupid driver, it asked for this! */
-		kfree(sdata);
-		return ret;
+	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
+		ret = drv_add_interface(local, sdata);
+		if (WARN_ON(ret)) {
+			/* ok .. stupid driver, it asked for this! */
+			kfree(sdata);
+			return ret;
+		}
 	}
 
 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
@@ -1187,9 +1186,6 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
 
-	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
-		return;
-
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1209,7 +1205,8 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 
 	ieee80211_link_release_channel(&sdata->deflink);
 
-	drv_remove_interface(local, sdata);
+	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+		drv_remove_interface(local, sdata);
 
 	kfree(sdata);
 }
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 283bfc99417e..963ed75deb76 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1843,7 +1843,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
 	/* add interfaces */
 	sdata = wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
-	if (sdata) {
+	if (sdata && ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
 		/* in HW restart it exists already */
 		WARN_ON(local->resuming);
 		res = drv_add_interface(local, sdata);
-- 
2.45.2


