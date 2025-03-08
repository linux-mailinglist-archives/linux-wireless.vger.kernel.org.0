Return-Path: <linux-wireless+bounces-20074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C03FA57F3D
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353553AC127
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4D1AAE0D;
	Sat,  8 Mar 2025 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+g23mMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A093213E73
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471319; cv=none; b=bAqMlmuSykNOoQpCEM0aYRPUeeoHBGVKRuBayGwnJGsXRj5FUrEY5Dx5W7xg1m0zzi+DCGtv24/Fb2WhTAKtqREAOt4CiwDsC88X6z7J01rgvZE70mB+6Vv3MwWFz3pm1SlLcCdHO00G3x8/CdxqHLEPKh/L5u4pMC/5ztjZkXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471319; c=relaxed/simple;
	bh=fMFUirmSSi+PZ9aORxxtumMiw1oYzuSI+08YtsP8rNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vCTiGWpiux4waFrXq1H+aF/777RFqiMBbdOt8NGTVUz8JUrzJEosQv8AINDv8PpIuE1GfZYuvcgn5mROCd7qVWfkXatHt6yzK+K67ZZIwiYxIRKcY75GkB2pZJL2sjScsOi7KGsL9yyMHiJH/nHGAm68pw0q3SsSG2LV61STJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+g23mMp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471318; x=1773007318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fMFUirmSSi+PZ9aORxxtumMiw1oYzuSI+08YtsP8rNE=;
  b=L+g23mMpB5zsC38SCPY0aklc/etAd5g4FYXg7CNxqqKADwizbQlzXI5+
   xJgnOXXkrdpeqPCYagyXK+vhBcqehu3XhE3hyz7K61iQM9D3qqi3WPE+3
   e56Ep1AvcJM+Lm7Cx42dikbUyNfyl0lZ60wb4bzKJZJaQMmBO1Ykrat3f
   qIFJWEfwJ3Wfkv6UXtHBYh/oseB+We6T0qAlN9dl27e++6qsyDgTu9wOT
   T5HUQxkuja1W3/CTNe7c5JtN75RAom6YiQl2tPPZn/6ty9pT7EsK1v4Gs
   E01f4Ook2+g+JcYp/6VezZKL9EUmnqobg9jEIg0OLaVjgkd7B8RG+OO1G
   A==;
X-CSE-ConnectionGUID: 5NJLUwLiQ9aj5JRjYZMxXA==
X-CSE-MsgGUID: v4ngOFh5TBmxaJWDHT0HEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540680"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540680"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:58 -0800
X-CSE-ConnectionGUID: 2kBfQ0eBQDOuI/uGGnDF/g==
X-CSE-MsgGUID: xKsf4Z+gTb+euQ3o5oImZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352180"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 14/15] wifi: iwlwifi: mld: fix bad RSSI handling
Date: Sun,  9 Mar 2025 00:01:24 +0200
Message-Id: <20250308235203.a31b95888244.If6dca30d657658fa902b19e07b6fbc86c48d69cb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If the RSSI is dropping to below the threshold, we need to do a MLO
scan to try select a better link.
This is true also if the connection doesn't have EMLSR capability,
and also if we are in EMLSR.
Fix the logic to always check the RSSI (and do a MLO scan if needed).

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/stats.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index a9d3860d8f9c..75cb204c2419 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -378,15 +378,11 @@ static void iwl_mld_update_link_sig(struct ieee80211_vif *vif, int sig,
 
 	/* TODO: task=statistics handle CQM notifications */
 
-	if (!iwl_mld_vif_has_emlsr_cap(vif))
-		return;
+	if (sig < IWL_MLD_LOW_RSSI_MLO_SCAN_THRESH)
+		iwl_mld_int_mlo_scan(mld, vif);
 
-	/* Handle inactive EMLSR, check whether to switch links */
-	if (!iwl_mld_emlsr_active(vif)) {
-		if (sig < IWL_MLD_LOW_RSSI_MLO_SCAN_THRESH)
-			iwl_mld_int_mlo_scan(mld, vif);
+	if (!iwl_mld_emlsr_active(vif))
 		return;
-	}
 
 	/* We are in EMLSR, check if we need to exit */
 	exit_emlsr_thresh =
-- 
2.34.1


