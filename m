Return-Path: <linux-wireless+bounces-8122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C78D07F8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6D21C2241E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66815F320;
	Mon, 27 May 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgOgs64v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3615EFC8
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825997; cv=none; b=McnUDv4L3qzJPMjGyEqLcA4rLVZrLBRuB8hEhbUh8QCq36yF0IB939jVxPngqDAdni3Bd7XZ1E0+vNCWVFsorrdEWbDBdKsD1EhLwKlrdY/w0YrWIm+3vLQXpZKqX+HC2QkiMjUSkXW1m3ARHGXIYvAKP5fNIV9BHlMszrjIIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825997; c=relaxed/simple;
	bh=XWbcCMcpCb1QpC42k20A+pt00F6hlMeD7mFV5mQzmDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ko2GtrKMdJ4rw3UOIylJWZARrPoJvetaOu8NHpAVLof7X+SFXhZbobMSptfjfJnQ/I2BjLDecJnPxCBSHZA5GnZiKRMyw9xW0EOmpUPCzMOSCq9V7y+dEHlnI2FexnetfK88c1P9f7aIovLATtu9QExIqu9Kfyg/h/Hpbyu+b2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgOgs64v; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825996; x=1748361996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XWbcCMcpCb1QpC42k20A+pt00F6hlMeD7mFV5mQzmDY=;
  b=JgOgs64vr9PEcnacTkTM2CkswjVs+Vje8RImAv+njZeRIXtaNizRS0A8
   owqppX/K0tTZobbs411gG4sJtOzYa9Zo0wAynw6jVeWKoAuddyfax7cAu
   RnjssJt00qLFVzBz4UTuuRNa6+yxKPkZSWXSg8gNGs9c/DWL0uwG1tBpe
   I3l//jmksQqkxJQCZ9kePvY1Lli8LgL7d6mVmRR3a4HbKtgeUlnnDTMVB
   pM4eooXBqLIJGMQv2f8FaIsaaybNN6mXMvm6zHMNOTAZl5YVybZs7UWY2
   OF6KYtSCyNE89L6DypQsGdh5kgW1BD5KVxP3SIUCWQEU0p/iRZ6abKYI7
   g==;
X-CSE-ConnectionGUID: nEcLkaNgRRWKoztQMaIh4g==
X-CSE-MsgGUID: A2f6XyCHRtyMv7GduW8jWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002086"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002086"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:36 -0700
X-CSE-ConnectionGUID: Ebb7kWAzSl+jkcQO7iKnhw==
X-CSE-MsgGUID: dIGo9Z8URdWS3TObGRdPsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407092"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 08/20] wifi: iwlwifi: mvm: Remove debug related code
Date: Mon, 27 May 2024 19:06:03 +0300
Message-Id: <20240527190228.c3b89828efb2.I7ded6348d2fb0cb7e103c4eee033451924c3461d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This code is intended for internal testing. Remove it.

Fixes: 30ce039094b5 ("wifi: iwlwifi: mvm: Don't allow EMLSR when the RSSI is low")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
index f49e3c98b1ba..6a680b5d03e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
@@ -393,9 +393,6 @@ static void test_valid_link_pair(struct kunit *test)
 	chandef_a.width = params->cw_a ?: NL80211_CHAN_WIDTH_20;
 	chandef_b.width = params->cw_b ?: NL80211_CHAN_WIDTH_20;
 
-#ifdef CONFIG_IWLWIFI_SUPPORT_DEBUG_OVERRIDES
-	trans->dbg_cfg = default_dbg_config;
-#endif
 	mvm.trans = trans;
 
 	mvm.last_bt_notif.wifi_loss_low_rssi = params->bt;
-- 
2.34.1


