Return-Path: <linux-wireless+bounces-25115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B298AFF2A5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C481C82E4F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53DF262FE5;
	Wed,  9 Jul 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9sUofVc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4FD26158C
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091572; cv=none; b=TrnvFEfoFKwtYyDOBLKrobPGmzkMUS8o5wDOE98DdvbXeRhjhfAJolchR5HGX/6u3rTxPwmh97sez5RQKY5/vPuQ0xbO8BOPYogfToA/TfdtRjSPCQueLq33B32YJaR9M0XQrN/gQV2TEbbIyQJ7VaK71U5zezYoj5oVXBs2j7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091572; c=relaxed/simple;
	bh=Fh9irTQJn5fE2sT3iUro5wr8vZjhN1csDxaz4YZLqoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WmsKc/FxTNPvYeQixw7Yo5HDVa4sfb13iXRg3TOqZ3vcdvLO9PmeV3+82B6BGpljDXZTQOFMrK4+CvnX1l/1LHUYmpKKLED2NsxHx118nMtb33AyL5l4K9JO7qQxzw8bcUlMjGHk9Ch917jRfsghUIRae5BgjqBcL8whKy0QGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9sUofVc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091571; x=1783627571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fh9irTQJn5fE2sT3iUro5wr8vZjhN1csDxaz4YZLqoE=;
  b=C9sUofVc+YQglzkYRAgY00U0c5LGlAMIv7qNHJ1RkJdoexxrsqEOUCHQ
   YEWAn2RQeQqmk1/28DXYiNRTxpafMY/eg6sElleEZsTOeRzTq3+9GheuN
   52FIQiEN0tSSbEZOEXfyKXuR26kSuFfN4W4q7p+CQa1j3i5f4WzVKzNGM
   ZzkgeKagwykz21trDfxBfUDoxUeAfxWxll+3b6ukmqBoTyrFYEMVcTaZr
   9jE1ffnb4vjH3bQnPJDS1EPUaNgkRc8YQtiEu1Qjfp8LHwFhA3bdZq0jm
   iTiFR76SCDgyg/F/Uqec8TdXQyAnvVn4SVQ4cQGhAT9QWzpGSfx7/JoOX
   g==;
X-CSE-ConnectionGUID: YnJ2zSMxTa+OmNL5I4OsxQ==
X-CSE-MsgGUID: Ef+0B8CVRbORGeNYIJXtPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240304"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240304"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:09 -0700
X-CSE-ConnectionGUID: KUGo+EwKThSOQQ9ZTc6LaA==
X-CSE-MsgGUID: dG9xVSLjQHClb89EO9UB1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126030"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: add a reference to iwl_wowlan_info_notif_v3
Date: Wed,  9 Jul 2025 23:05:33 +0300
Message-Id: <20250709230308.19ebfa430c5c.Ie5aca3f0af11cc3137c6b6862a13777bae0cb06b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
References: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Mark this structure as one of the structures that represent
WOWLAN_INFO_NOTIFICATION

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/offload.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index 7d9aa8363f90..2a1c2b0f19e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -19,7 +19,8 @@ enum iwl_prot_offload_subcmd_ids {
 
 	/**
 	 * @WOWLAN_INFO_NOTIFICATION: Notification in
-	 * &struct iwl_wowlan_info_notif_v1, or &struct iwl_wowlan_info_notif
+	 * &struct iwl_wowlan_info_notif_v1, iwl_wowlan_info_notif_v3,
+	 * or &struct iwl_wowlan_info_notif
 	 */
 	WOWLAN_INFO_NOTIFICATION = 0xFD,
 
-- 
2.34.1


