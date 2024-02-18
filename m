Return-Path: <linux-wireless+bounces-3747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E124859854
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73A5281BA1
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C293E6F072;
	Sun, 18 Feb 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVH15q80"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4C6F092
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278736; cv=none; b=o4O1IdgShwzFAwV5IxlJ2tf8Y9KkNaCZCfMXJTz4LKTq6t+OtFU6Ss3h/rMCvfnT8Lh9TCf7df8hDP1FjwqKj9/ANgYsK09tQ3GBYGljOmuOBXdJc1TwDOqqytEkgqjHbQSLRXG9r/WFeCy+MsKAZaRyxQ4oMt+RvHj/yANNspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278736; c=relaxed/simple;
	bh=H64tbjNP2RlzcIhisbXjWc9o+rwoiErepWsnq16+38A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUE9phQJ3RrqomiV+NggGi6dCkNQm70k6L1KuMHSfzYz8yHDMp8C54sv032YABDIZzERuQ/IVimJWd6pwKgsiZC+dzoKQ0i0NL1QdBpEk+MrpqIDznhW3Iqr9EJDXVAVwQPRpBxO/i8n8jXnLLtZaC9hGfSqc2eJnyutXqN78LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVH15q80; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278735; x=1739814735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H64tbjNP2RlzcIhisbXjWc9o+rwoiErepWsnq16+38A=;
  b=gVH15q80kMyBwQaJSVlI47Fs8jBHcnBJXBgxjmIrjQF3haPsA/bkRyqq
   CTi4tUVNdUrZ9DzjWZH1aRF1sSYYckYtsXzLl+60F1Ope8pTSO796X3jo
   VxXxaV/lRQYWZCofv69AMbUE+YrT6IvNH4N/N5geMBzGlhDg6bkoTf/jF
   +mJUw4XSmqeH3eUpsVNImnt17N1zTW4fu89EAqcEOdbv9Bmzo/AdVlvvT
   IIrtqi7dSN5IOwXwqceeX83xE98E2ltKeYodhMXEi0HXVgkCr47EhLiar
   7CgwDjGcvO5JyhWFQos2kwx3/oiLYiiiCcYvz210vJXGCmGhiGskB+kCZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464979"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464979"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459439"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 05/11] wifi: iwlwifi: mvm: unlock mvm if there is no primary link
Date: Sun, 18 Feb 2024 19:51:46 +0200
Message-Id: <20240218194912.21de6e68d9e5.I3c0ebe577dec6b26ab6b4eac48035d6f35a8b0f8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

At that point in the code mvm->mutex has already been taken, so jump to
out_noreset in order to unlock before returning the error.

Fixes: 8c9bef26e98b ("wifi: iwlwifi: mvm: d3: implement suspend with MLO")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 9830a3c3600b..6d5ed79b9fff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1290,8 +1290,10 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	mvm_link = mvmvif->link[primary_link];
-	if (WARN_ON_ONCE(!mvm_link))
-		return -EINVAL;
+	if (WARN_ON_ONCE(!mvm_link)) {
+		ret = -EINVAL;
+		goto out_noreset;
+	}
 
 	if (mvm_link->ap_sta_id == IWL_MVM_INVALID_STA) {
 		/* if we're not associated, this must be netdetect */
-- 
2.34.1


