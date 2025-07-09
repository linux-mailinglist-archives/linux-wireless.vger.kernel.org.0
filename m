Return-Path: <linux-wireless+bounces-25126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01FBAFF2EC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F2417B972
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BC8242D79;
	Wed,  9 Jul 2025 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtY2Z+ZO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594122A4F4
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092700; cv=none; b=j8Bq2jSiXSQIOZG7NpaodIwDTAPr4Kv1AMvchuYmD1PFBoLdOipf/zjRDbQGBE/oLcv8+cfsV21r+oxxhFjA0fSyI4EwUU9B4Vy9CKWCNAPPz2e3e8xY3ggZMBLbmzXwp83QJ3H1zzkqezp2T9GiXdWWyq254+PugyScMDgjduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092700; c=relaxed/simple;
	bh=nbuzzFx4tke59zOj1Ivx+NPdfpI4UvaeNA05hvg4Opk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I75OZdGI7+hCNTHmzR+gvAqtffSjIRabXPUwlvT7XuyOP2NaE60bnq8eyyPMGS0oWBPt193aFUtlNvOmTJHw0XARfHh/c/3o4DIfkLdsjzGIx/81W9yS4RGKJLsbqSibH09KpOqZNlsx2uhMsZ1n2co10GlzR7HeSzCgLPUPf4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtY2Z+ZO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752092699; x=1783628699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbuzzFx4tke59zOj1Ivx+NPdfpI4UvaeNA05hvg4Opk=;
  b=VtY2Z+ZOwjVW7e2e8JpFRi6Ms0/mnL0BjVFNXzq2JmGDZFm26S4qWlfQ
   hzJRkiqfXCr5XcPWgwuRyQY/raIiFe6E4Cdy/2FKkWJrrd0rl1U6rthpI
   B9SXCoqzaAU5+dYA9m5jCt2JwiUXo/DPv8k1lwYxtKeJ8scRaFghVfTvQ
   GaJmpsSRsoALv2M2G5EKWTbBtoH6ba1sCgIGDBskM6pNiujRIgqK5CZ6M
   zosD4h+7tvaf3nK3pgVxKX8T0T6iW4TRelpYSeb3lkODnPqqpLbUlGXTO
   bEp84YXJo4tTsRPR4Y04wcUIdpsBwxq9S3ZK5DY3VMGPet21aqpv4uBBK
   w==;
X-CSE-ConnectionGUID: 5BykEDkrR2SlstwRnEfz9Q==
X-CSE-MsgGUID: OZZSxd1/QruGE17jHIZHfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54509714"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54509714"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:24:58 -0700
X-CSE-ConnectionGUID: Ic5C+n1+T9mtpuZ4Y8ny0w==
X-CSE-MsgGUID: U3nq5IKsQPGLyW3ezNfM7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="159897625"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:24:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/2] wifi: mac80211: add the virtual monitor after reconfig complete
Date: Wed,  9 Jul 2025 23:24:36 +0300
Message-Id: <20250709232419.648d39b041e8.I2e37b68375278987e303d6c00cc5f3d8334d2f96@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709232419.8dcefe578497.I4c90a00ae3256520e063199d7f6f2580d5451acf@changeid>
References: <20250709232419.8dcefe578497.I4c90a00ae3256520e063199d7f6f2580d5451acf@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In reconfig we add the virtual monitor in 2 cases:
1. If we are resuming (it was deleted on suspend)
2. If it was added after an error but before the reconfig
   (due to the last non-monitor interface removal).

In the second case, the removal of the non-monitor interface will succeed
but the addition of the virtual monitor will fail, so we add it in the
reconfig.

The problem is that we mislead the driver to think that this is an existing
interface that is getting re-added - while it is actually a completely new
interface from the drivers' point of view.

Some drivers act differently when a interface is re-added. For example, it
might not initialize things because they were already initialized.
Such drivers will - in this case - be left with a partialy initialized vif.

To fix it, add the virtual monitor after reconfig_complete, so the
driver will know that this is a completely new interface.

Fixes: 3c3e21e7443b ("mac80211: destroy virtual monitor interface across suspend")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/util.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a125995ed252..e66da651678a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2144,11 +2144,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		cfg80211_sched_scan_stopped_locked(local->hw.wiphy, 0);
 
  wake_up:
-
-	if (local->virt_monitors > 0 &&
-	    local->virt_monitors == local->open_count)
-		ieee80211_add_virtual_monitor(local);
-
 	/*
 	 * Clear the WLAN_STA_BLOCK_BA flag so new aggregation
 	 * sessions can be established after a resume.
@@ -2202,6 +2197,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		}
 	}
 
+	if (local->virt_monitors > 0 &&
+	    local->virt_monitors == local->open_count)
+		ieee80211_add_virtual_monitor(local);
+
 	if (!suspended)
 		return 0;
 
-- 
2.34.1


