Return-Path: <linux-wireless+bounces-20276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095BEA5E748
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D61189E324
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226691F03C5;
	Wed, 12 Mar 2025 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHyTbaI5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D911EF0AD
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818189; cv=none; b=gJqPzs2zGzLk4wbrqEoAwmRBPqju5jV0sMl3rRsnj3NFwyFPIbzaACAta0HFM+aHgmI3735B38KjKZ85CFsUuD/h/HDm5R+nhwnd7i9Tafl4w3xx1OyDzKFq4iXKwCTJMq4hyiHrXNP5M6w8ho+f99NkSnnTLSELzDq1iFKty9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818189; c=relaxed/simple;
	bh=LBfD5eupcVnF7YZmljnO0NrbKj6vEoZ66ONi9XXQYc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBo7pL+eL6fJZBTiOkm7Sxna+A1sYmbYodDwB2LGuHng6FiU3eS9adD6IAEo5IuvK6Ho5CvPWPx3/KCO7hk1ix541hTc/T5Yx0Nfts7/L+w1vaIxiFffqDoGsdzI/3+37clysrxBqocxxAczxbwOMfL3JTd7gd3wxIUMechAaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHyTbaI5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818188; x=1773354188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBfD5eupcVnF7YZmljnO0NrbKj6vEoZ66ONi9XXQYc0=;
  b=jHyTbaI5ogs8lKQr3gW8g25yBrXyA7yLosl/UkOgbmoYuYnqZA7vNvZ7
   AsdX+Wc7Ped7f3nmHLzBFuaAbgYzavsS9tjOQ79XHNYwiyupzdU0fOEaf
   p4UOcyNFjiuGBgmiMzH0cL9YU0WcBqilOJ2vRIpB6Eq+hdMi/gIrsEPE9
   rkBTQ7c/q5YkPOS6QYBHH3BVrurg5s8MQq6fPBQzCugCQf2DTr9HemZsZ
   BNg7wQxFZo/dgmSQFyC2D1OKitBNbccxZhJLbbpaTj1ifaXOrzEi9W7ym
   6yK2Mj5sasMRrC2Y+0LMZmHsiOOtSE4bB8k8U06I+S/ISYeTYkmIF7JoW
   w==;
X-CSE-ConnectionGUID: OpcgiX0dTbaAa6m69wFzFA==
X-CSE-MsgGUID: Q0oMkcNyQ6e5u2AiJhrpzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826758"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826758"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:08 -0700
X-CSE-ConnectionGUID: VBCwk5H8RfGWtzZC1cc74g==
X-CSE-MsgGUID: PX5shoMcQ2WHhgzK9EI0Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267396"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 11/15] wifi: iwlwifi: mld: make iwl_mld_run_fw_init_sequence static
Date: Thu, 13 Mar 2025 00:22:34 +0200
Message-Id: <20250313002008.2d30c0b66734.I98cd21aeaf6e787af3ee3ed60d0ad8656ed8ec52@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

It is not used outside of fw.c.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c  | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
index 9c1dce0d5979..62da137e1024 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -257,7 +257,7 @@ static int iwl_mld_load_fw_wait_alive(struct iwl_mld *mld)
 	return ret;
 }
 
-int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
+static int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
 {
 	struct iwl_notification_wait init_wait;
 	struct iwl_init_extended_cfg_cmd init_cfg = {};
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 38f1d1bc5a24..5eceaaf7696d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -336,7 +336,6 @@ iwl_mld_add_debugfs_files(struct iwl_mld *mld, struct dentry *debugfs_dir)
 {}
 #endif
 
-int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld);
 int iwl_mld_load_fw(struct iwl_mld *mld);
 void iwl_mld_stop_fw(struct iwl_mld *mld);
 int iwl_mld_start_fw(struct iwl_mld *mld);
-- 
2.34.1


