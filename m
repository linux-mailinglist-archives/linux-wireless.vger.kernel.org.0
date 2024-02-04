Return-Path: <linux-wireless+bounces-3112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7375A849100
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A674C1C21F3A
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CE43FE54;
	Sun,  4 Feb 2024 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjQ8XWc4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D13FE4E
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084416; cv=none; b=TgcX2K4dcbGPOZ8z6z9BhEasTVW3h4SHdVY0D8dug3Fw8k9JqG5hYmfV76y+i7RYsbC5OfTrvjMdgho/0BnG3URRnKMZhFk/HnZyaaGYvvWkhtqcwq/xDzSSDDw2b5IakPmEehZ0QrHG5/SlOmAvk98QkdmLzDn8djWzyCr+G20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084416; c=relaxed/simple;
	bh=QPSFHWToY5hd9xLIUY78GuoM1IOIQ+iyVx7Qosmg1A0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1BNSIhu8/58SUbglYEYGdPoS9lNrteAEpXyI8OS3aT38TUVKFU9/ToIsffEx3UhV4kK+M6L3Xg8K06Z3tBBstKPE3S0gQUv2SlqV6oBTqlF50NlDGucEu1xhujtJr74NlDcNs76dR7vQROlPzEJb8Rev3AKwqA8t26MYpy2ZJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjQ8XWc4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084415; x=1738620415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QPSFHWToY5hd9xLIUY78GuoM1IOIQ+iyVx7Qosmg1A0=;
  b=OjQ8XWc4G0jrZ+l9RdR38irblr8qLRvmsveVCjw+9n3+yb2VBrJRHyji
   eSmZwLZQQPyFNa3F3wezhHBByTUDZIKVOFxz7DGi0CZyDyNrOVI6RMvAE
   BUhSAhzU1ux8+KKEgcM1fzr9IneSTf0BMaPVyD5sMJSE1vVa90YxM8B5o
   Jt5T8zGvpZFdHQTtfXUZjO6Sg7LfOQAMlzV8Cxt0GZazWDA1OQ7vKw1gx
   4IjT12mUBvTWOG4ouIRx8PH1z90sTzYqs1TXsAuY1kP0OtKfpJyxNKV7S
   O7jOA2ntFOn9DNXw+SMcvhCXYL4dXXwKoO4tYj9gKT/3C0swcDib2uvi+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869388"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869388"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815900"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: support EHT for WH
Date: Mon,  5 Feb 2024 00:06:13 +0200
Message-Id: <20240204235836.a6d4097cbaca.I8b00fa7b6226b4116cd91f70fb0b15e79b4dee5a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

sku_cap_11be_enable should be set to true also for WH.

Fixes: e1374ed25324 ("wifi: iwlwifi: Add support for new CNVi (SC)")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index c30187d77b3c..d2f133255ee6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -2125,7 +2125,7 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_BAND_5_2_ENABLED);
 	nvm->sku_cap_mimo_disabled =
 		!!(mac_flags & NVM_MAC_SKU_FLAGS_MIMO_DISABLED);
-	if (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM)
+	if (CSR_HW_RFID_TYPE(trans->hw_rf_id) >= IWL_CFG_RF_TYPE_FM)
 		nvm->sku_cap_11be_enable = true;
 
 	/* Initialize PHY sku data */
-- 
2.34.1


