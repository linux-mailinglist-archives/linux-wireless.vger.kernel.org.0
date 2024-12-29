Return-Path: <linux-wireless+bounces-16876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 255009FDF4D
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDA116193C
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2992228691;
	Sun, 29 Dec 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RIiOuOTS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863E194A60
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483533; cv=none; b=JtILOmrlgDnw7eNvnYVx8z6mSCVeICdBj3O1Whm6+MZuBXdeOoHXnVVznvPlqKoZ12cMBLGIQxwPTnZDQfXzre6Tgm6cS6ShDBOX1/Uy4bV8lrTFJyCx1zKSRjZ3OAaiM1JBRaFVzgn4H9eT0RmClwjHA5wPfn+U/ASp04iGA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483533; c=relaxed/simple;
	bh=WVPIIrJyx/rnJptzHTWXvKZeRVttxjQbmGLLRr70Tb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MAFWfQwi3sM8FAqFIm+oCNNa4AVH6KBoATYdFQ6zmN4fl5eO5rEFg01PafuruMeZScGs3BsgRARCsVdPZiT6z22DROVHefkym08fwMUEFN1UEcbeHKzI2a/tchFmxEKdNOZisoYLN68xIx5+tnj/uAT+6tBUOVzjNXXPmojPzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RIiOuOTS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483532; x=1767019532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WVPIIrJyx/rnJptzHTWXvKZeRVttxjQbmGLLRr70Tb0=;
  b=RIiOuOTSj0opJm7M9fmav1K4+0EYdxbD6ZO79Rt5qAAiaJEGKyiMYYBm
   cZVdFdI16HZHdk+tf+Zsub12s+u/mK96mFiCHdbzQND3XGLwMSMGHIsni
   Bs58O4RuIr4O9fwW1zTDqEiMT0GhhgxQagL4+BHO6QL9AutOmdjYyW0tm
   C/jyzVTpQKzv+xZWgFXRr8Zgn55iNjvKzUgnLlpmbpIuiE6153Ur8zdCM
   6Ovxud6TU6ZbGDmWudtJHxtZPtXonweuK++YBgzuC1Eij7lAn8XRePYUr
   L1qbjIZqiV6CVAnf0epwOHl6NlAxg4b2qPFjCPVp40pa+Ly4JkKurXh6o
   w==;
X-CSE-ConnectionGUID: IzgLaWawRqWvBUW85C/s/A==
X-CSE-MsgGUID: OP11MJBfSxGHjcu9HLlx1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572471"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572471"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:32 -0800
X-CSE-ConnectionGUID: wXW3qn2pSQa+MAW0ecBZkg==
X-CSE-MsgGUID: LyUHdP8tTHqB54ILy7JzuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656999"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:30 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Jason Wang <wangborong@cdjrlc.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 16/17] wifi: iwlwifi: mvm: Fix comment typo
Date: Sun, 29 Dec 2024 16:44:51 +0200
Message-Id: <20241229164246.76502dda646b.I0a1d012eaa1cd8d39430cde981cae8c4cc058442@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 7cab5373c8ae..5e7e2926be0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -31,7 +31,7 @@ u8 iwl_mvm_get_channel_width(const struct cfg80211_chan_def *chandef)
 
 /*
  * Maps the driver specific control channel position (relative to the center
- * freq) definitions to the the fw values
+ * freq) definitions to the fw values
  */
 u8 iwl_mvm_get_ctrl_pos(const struct cfg80211_chan_def *chandef)
 {
-- 
2.34.1


