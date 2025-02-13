Return-Path: <linux-wireless+bounces-18945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE0A3509B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 22:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9FF3AE027
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59661487FA;
	Thu, 13 Feb 2025 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="uiSjIrPQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5269266B56
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483071; cv=none; b=TYTjc2zFSvkMcgMTYm7HJGpqIBNHNzVM3NijZu02EvR3aK6clr0h8zPpcFmGeZ3LzPsZuPrcVcECcbsmqUttGxt9rInilrrWE0R0sFB/kyPQtQNj6pJU4BOAs1HV7o56y5w5EbfNxVLw/+IAwkTJuXfV7Yu9sdeg+1miBNU2vD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483071; c=relaxed/simple;
	bh=GpwrtTNM946pqoB8xKOa7giJ95pYqor73SHvRTsz0dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/qSaej5KD4zkEmorsvzqxBd/z38fxjm1togrUrco/m0REhjLUcZGyZeGTMYh7RDskuKh7JpfjUngfT7S93jOxGzwas/D3f7MXMQa2s8aWeQoLoYROuA8sC51GWpp/d92Z/fQTmfQD9O2rNmgRqIQtzqvGPWI9P/Pq1LKDX3Fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=uiSjIrPQ; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739483059;
	bh=GpwrtTNM946pqoB8xKOa7giJ95pYqor73SHvRTsz0dk=;
	h=From:To:Cc:Subject:Date;
	b=uiSjIrPQ8UskRdjRtJwufXHm56mZH6NGYEqFsODuzyybjt05kr8G32MnIjBlwvZ11
	 E9woo5K2bqV+MzNIehnQ7Nj954aZ6yi28lRUtkzZCVwhs8+lX0jyxFGbW8G+YlBKO2
	 +r+040YY4W/xeyAU5mfdF2BPqvN79NBa8YIVBPt8=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] wifi: mac80211: Fix sparse warning for monitor_sdata
Date: Thu, 13 Feb 2025 22:43:30 +0100
Message-ID: <20250213214330.6113-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use rcu_access_pointer() to avoid sparse warning in
drv_remove_interface().

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502130534.bVrZZBK0-lkp@intel.com/
Fixes: 646262c71aca ("wifi: mac80211: remove debugfs dir for virtual monitor")
---
 net/mac80211/driver-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 2fc60e1e77a5..35349a7f16cb 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -121,7 +121,7 @@ void drv_remove_interface(struct ieee80211_local *local,
 	 * The virtual monitor interface doesn't get a debugfs
 	 * entry, so it's exempt here.
 	 */
-	if (sdata != local->monitor_sdata)
+	if (sdata != rcu_access_pointer(local->monitor_sdata))
 		ieee80211_debugfs_recreate_netdev(sdata,
 						  sdata->vif.valid_links);
 
-- 
2.48.1


