Return-Path: <linux-wireless+bounces-9922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4175925896
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B62289AEF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570C16DEAC;
	Wed,  3 Jul 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5c8xBO8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99116C6A8
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002467; cv=none; b=YvlWMv3JRGW6fLqv0UXLCgbJnElqcOGZ2ay0EUVvSrDf9GkkitQoo+9psAifUDtAoPLivkIaCwq5uYD+OwS2ze8cmfYI70uSLpBpnCWztsERd+/ZeJEATWbPLi1oWhH/Le3Z5kK18wqjHj851RCgSvl/ocWmdQQ/RU7C530Qhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002467; c=relaxed/simple;
	bh=NOVtHVj5fblsmwmDUay2dwFQi6hbxpcINT4lLNNQppU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YL6pRyg6kLXaKB+GJo7FlXvvMW6zZYOU3s1vX8fDwrm0/jev1NY6mondl3mwsGmZUfLeIM/yRDYD0EXAW0wCgOj/+qSyJrXnqpFucQNTzLDVaJN+6vkH+5tlI4q9cH/zHlTpaW51wxXE/LGbvkTU1t3sbnGYa0n44IZU5V1AVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5c8xBO8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720002465; x=1751538465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NOVtHVj5fblsmwmDUay2dwFQi6hbxpcINT4lLNNQppU=;
  b=Z5c8xBO8r+83M91u6DTG7JUap+MC+xmlLnIbuKDQSwgqPi2YdtwR6adx
   UvSDLkgN1n01KcV+K/NB7/g+OJ1JzoUCbqBmrjj4WlaeoQIr+gFAfKe7M
   yRZaLccgTvrOYfFQSzvrewgfAqJciKKRYijqY4kyZL6/i4uvzoSE1JxFP
   Aq/+/1AV6YLVCGSuL6I15daVqEwDfS/Vj7LCbaGNSzCTLeYrfnVty+rU9
   KRSQlAoRqls6/Sq8Nx5PV0mqxggyi/rWgZk00Yt9MMYxv/UwIJrp4Ncbr
   l1KmYLXtgw1FWu30adVz0L+yFL5APeFyOUY23UrK9EHahcPPmJGX2sFns
   A==;
X-CSE-ConnectionGUID: GQxUzVyVRUO/Wcgus/+IVA==
X-CSE-MsgGUID: 636sLSY6Th+ODCmva1/P7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16879146"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="16879146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:27:45 -0700
X-CSE-ConnectionGUID: o2wDPKxcQHmZ6RB8orNFgQ==
X-CSE-MsgGUID: fOUUU3yeRCeXtSms5qjrBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="76944278"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:27:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: mvm: re-enable MLO
Date: Wed,  3 Jul 2024 13:27:37 +0300
Message-Id: <20240703132713.8f77a71c3902.Ib302054cbd8fba82db97eb5298b2aaf8bbe106df@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

MLO was temporarily disabled by
commit 5f404005055 ("wifi: iwlwifi: mvm: disable MLO for the time being"),
until it will stabilize.
Now, that all the bugs were fixed and the minimum FW version was bumped
to a stable one, we can re-enable MLO back.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 60bfe42d5386..0e738521c60d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -372,7 +372,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	if (mvm->mld_api_is_used && mvm->nvm_data->sku_cap_11be_enable &&
 	    !iwlwifi_mod_params.disable_11ax &&
 	    !iwlwifi_mod_params.disable_11be) {
-		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
+		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
 		/* we handle this already earlier, but need it for MLO */
 		ieee80211_hw_set(hw, HANDLES_QUIET_CSA);
 	}
-- 
2.34.1


