Return-Path: <linux-wireless+bounces-976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5FD818395
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18152285F0D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74B11729;
	Tue, 19 Dec 2023 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnZtPhuv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2711739
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975114; x=1734511114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D+S31kVwq1hwyOmygoG307hvwXTG0BeNBJy6rpDtnBE=;
  b=DnZtPhuvUSQpCr1BdUqDrsBEqDMW8SXK96LHbApTKW124WdBVDg2UugY
   CgLYZ1AlZDUOwsdMMzaXo/kmBvFYqQONV4jTSAl9aDZB6ZISZXIVMY2pW
   7S5odfAaZqeW5EShqa2ggSILjo90tCiakI916aOSeV5FiYj4wMA4zwWe6
   +sU9yup3v4FkcUX9CwQQfuLIuCQeqc5g0SPmFzVkMC7DooM0pit43ncvX
   Kk5WHskS/rQW0IhFUr8kRHlm8p1TsnlDHGO2c6m6Tn/xn+ZqfhNK3Ww3D
   5OQq9ELMBMKp0lR+2Mg7nmXw5Dvs5dnuY63ryQ8xjUbrTP5AC5u7NQwJP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969288"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969288"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266527"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266527"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:30 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>, Berg@web.codeaurora.org,
	Johannes <johannes.berg@intel.com>
Subject: [PATCH 12/15] wifi: mac80211: do not re-add debugfs entries during resume
Date: Wed, 20 Dec 2023 04:38:00 +0200
Message-Id: <20231220043149.ddd48c66ec6b.Ia81080d92129ceecf462eceb4966bab80df12060@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The driver debugfs entries still exist when the interface is re-added
during reconfiguration. This can be either because of a HW restart
(in_reconfig) or because we are resuming.

Fixes: a1f5dcb1c0c1 ("wifi: mac80211: add a driver callback to add vif debugfs")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/driver-ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index d3820333cd59..5e0435db2f9c 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -77,7 +77,7 @@ int drv_add_interface(struct ieee80211_local *local,
 
 	sdata->flags |= IEEE80211_SDATA_IN_DRIVER;
 
-	if (!local->in_reconfig) {
+	if (!local->in_reconfig && !local->resuming) {
 		drv_vif_add_debugfs(local, sdata);
 		/* initially vif is not MLD */
 		ieee80211_link_debugfs_drv_add(&sdata->deflink);
@@ -534,7 +534,7 @@ int drv_change_vif_links(struct ieee80211_local *local,
 	if (ret)
 		return ret;
 
-	if (!local->in_reconfig) {
+	if (!local->in_reconfig && !local->resuming) {
 		for_each_set_bit(link_id, &links_to_add,
 				 IEEE80211_MLD_MAX_NUM_LINKS) {
 			link = rcu_access_pointer(sdata->link[link_id]);
@@ -590,7 +590,7 @@ int drv_change_sta_links(struct ieee80211_local *local,
 		return ret;
 
 	/* during reconfig don't add it to debugfs again */
-	if (local->in_reconfig)
+	if (local->in_reconfig || local->resuming)
 		return 0;
 
 	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
-- 
2.34.1


