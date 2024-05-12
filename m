Return-Path: <linux-wireless+bounces-7542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3339F8C367A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B831F2201A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A9C2E645;
	Sun, 12 May 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huEkjw3M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FB29D0B
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516727; cv=none; b=Mq04lJ7Ds8onPWgxzBD/TLX+bm3hKyvPawFt2kKq9DVSPhG0DF0spr6nz+9YK1vAfEold/YlL0KSuWy9NMDjPiBgAKaVJtNlU0byRcN6YoqsD8b8mGhFBkj6CqSj7VgmBCA/WBAD4SltRnIwnvJxQG5pG5OtQInsxCQHDDUatJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516727; c=relaxed/simple;
	bh=UkI60nuylt5dSf7A9phYfFYEQu0YDb30Pn7JY6QI4vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWql4hB+W2iiL60MjjokDhWzl4QUyy5lXSj5fQYQqYViwqqBmk2FogmA4zDzGLllHY312dpDY1tg2fdVYxEeTLkg28bqToPaoq7mgA7HNTCn5fsBsE1deHN9hAB4askebxTfFbCErZMFtzSpKGULz98rb3ss1aKIk1x1k7SzuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huEkjw3M; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516725; x=1747052725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UkI60nuylt5dSf7A9phYfFYEQu0YDb30Pn7JY6QI4vw=;
  b=huEkjw3MleKU9VGpI4oVmmFB1HDoXVqvk0Zz7nSB394vqhuuK1W3QvzF
   l8JKLb2QBoFxAZ584HJikaufizp/jN639xNxtuJjr05n7YCX+8rVx9Zb/
   Qo5pD1WzzI1xYX5xQT+WlOivG2uitVBSkoZj3I6KBMaEYdMQawFXGhEks
   gilH9WB/z1rQST8lk2E2vPpgu0G9XxnS/RjP+R+WS+JWWeQtybyveV0kr
   RCnUjtiCLKRB03xn9mi9EvrK7nRjnXzc8h1RIMnCzwHnmbQqGI7Et5+zB
   PoJpti4Y7jQODFGUIUQeVvWmeljKQ2OQjBLDkJAarzMnD3cDl16vmXFwu
   w==;
X-CSE-ConnectionGUID: voGnvziIRe+pGv3kQzA1TQ==
X-CSE-MsgGUID: jw3/SBZYTTKa5DZRUh40BA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397205"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397205"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:25 -0700
X-CSE-ConnectionGUID: a0MKSUkaTKyygrhB8tXVDA==
X-CSE-MsgGUID: BbWAIixyRfyMQjG7o2ar8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761325"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/14] wifi: iwlwifi: mvm: don't initialize csa_work twice
Date: Sun, 12 May 2024 15:25:00 +0300
Message-Id: <20240512152312.4f15b41604f0.Iec912158e5a706175531d3736d77d25adf02fba4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The initialization of this worker moved to iwl_mvm_mac_init_mvmvif
but we removed only from the pre-MLD version of the add_interface
callback. Remove it also from the MLD version.

Fixes: 0bcc2155983e ("wifi: iwlwifi: mvm: init vif works only once")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index f69f7df40a6d..00433d1c8564 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -75,8 +75,6 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		goto out_free_bf;
 
 	iwl_mvm_tcm_add_vif(mvm, vif);
-	INIT_DELAYED_WORK(&mvmvif->csa_work,
-			  iwl_mvm_channel_switch_disconnect_wk);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		mvm->monitor_on = true;
-- 
2.34.1


