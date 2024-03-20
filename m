Return-Path: <linux-wireless+bounces-5048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBA988190D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9E0B22BD7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA748595A;
	Wed, 20 Mar 2024 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daJ3RC11"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6985C46
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970021; cv=none; b=eUIIj11/XQchn+c3zvj2WguqiIQeh++zH1BMScXiO3WN3UsDSc/zbATdFHFKmF5+KYouy95/Fl0SQPFz7r9DgxI91n9f6zNb52/XT9Nn1oNvJPnQIJ6XGlKIhQD7RIucDd57346obLzAXfP80uv++SFPx1vmLMwAm2ytY0RGtbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970021; c=relaxed/simple;
	bh=4FCbGYFitIKkLyOeNfJiWXvDliIC1hijxy0WtQlr6Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZ7+xGlOs25AOXbyTCUI0ug190HOFnMvNRh1x0u1VLA/o+R3sqkvtjw8N0EXRg1Tv0nxWq0vIgZ47yBsugyZ+ujhdWAU7rtf9u6xdXFGwx/0S3tUSdSx+td44hou09QPc5zfSgZgYTLtXpEq78V/7eeGumHY/EsknNNhsNLX1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daJ3RC11; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970020; x=1742506020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4FCbGYFitIKkLyOeNfJiWXvDliIC1hijxy0WtQlr6Ys=;
  b=daJ3RC11Rj6HIp6bXqgL484re/tlk8x1gPUgeQP014wilpg/EkoReyNr
   zdpMQw2i+V6if9pLYgdNjJYVlEaLHD+MsvafyXxsYi1H6cdaqk80RYUG7
   i10cANxSLl+SPE/UsYyOREiPr+GIVpe2VOzTBYk7PlJjQdFM+x5CzfLxf
   6hzi+M+ZM5EAekmVuIzM9Na87mH+80bvwHMDuxaSleLgb74Uhiujfwxu4
   ZHlzPiMza9Yiuhn/7JGThUUA6yIsVJ8omSFUlYE8M8XwzqUs9sxYRjS7/
   573hPsg1bVybu+JcMWhH/NC/+qAIRHoxh+8SRi0OX04fBhtLrXH6mK05H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698062"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698062"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184128"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/17] wifi: iwlwifi: mvm: mark EMLSR disabled in cleanup iterator
Date: Wed, 20 Mar 2024 23:26:26 +0200
Message-Id: <20240320232419.71eb622d6ce3.Ic4d50695b9bb332190dc712473096083aa96074b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

During HW restart only one link will be active initially and other links
are only activated again later on. With only a single link EMLSR cannot
be enabled and having it marked enabled confuses the internal state.

Mark EMLSR as disabled in the cleanup iterator, it can be reenabled
later one once this is possible.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 964871f31c73..448b43d73625 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1108,6 +1108,9 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	mvmvif->ba_enabled = false;
 	mvmvif->ap_sta = NULL;
 
+	mvmvif->esr_active = false;
+	vif->driver_flags &= ~IEEE80211_VIF_EML_ACTIVE;
+
 	for_each_mvm_vif_valid_link(mvmvif, link_id) {
 		mvmvif->link[link_id]->ap_sta_id = IWL_MVM_INVALID_STA;
 		mvmvif->link[link_id]->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
-- 
2.34.1


