Return-Path: <linux-wireless+bounces-16833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4A79FD1BC
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD5F16401B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27D47083A;
	Fri, 27 Dec 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfQKzXkr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5614F11E
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286506; cv=none; b=gbDgUvZatEzBDaWlRJBM8MKjcL2345+6Ju9A4hywC7KfbRLXKvOEEoh09b6ccptQGLhsWaCIut9rTHDQX6QE8fcPtqZqquLcFVZ4f0ZLzP9teUkuegle6a0OCxMZTbHMqf1rDlK//5gVbOxU+xT1h756Z2j5x2jI1rRxA6OnR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286506; c=relaxed/simple;
	bh=WeQtkk8fN05/PxXFrx2aocUNCdsOQYnwBEzjPE9tlQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBZIetYruT20lQK5XGWwD5hr2dwt6VPHdvEUZu6/HDOrNBC6BcJgacSvXbjPYZBT2d3lGLUEmzmxBccLKfcxXFMrPZlV/+XCNIR5iVgEboLqhrGiAxHz7VIPQmuZqf30pNvj3Rr2PooAejAopil+OkT6kOdvKPSJvjMHaeqPxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfQKzXkr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286505; x=1766822505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WeQtkk8fN05/PxXFrx2aocUNCdsOQYnwBEzjPE9tlQ8=;
  b=EfQKzXkrkPEXnBMpeDDViP0+HfooGj7dpdI567QUJUu4aAndK/wC/Sni
   hY5AraNO5zLCMgLTFnGBDeKjGyYiQhHpj72BS07ekey7DMMtCNG9n36fT
   2ZwVWAM34LXvkc9ETpUiwP232tZTOSDXf2EwdevSaUhFv1B+oy9f2b+81
   jRl3LZnGWTb/CSlF1/b2Vp1eLixf6jR+rRVs/ZcJDMWUAgXDWm01UDSBq
   3Na30aUHC4yoakhJsCv/7PNsf7pstGG5JS/sdsWeqvF6Q1SAKtqSOxzkz
   bBa8lUnDRQCa/P224t/BtEmkV0lYvvtv8G79gkUpDx2vur1yvHXFSg6kA
   Q==;
X-CSE-ConnectionGUID: Lcj2W6U1TIiNhOa6TB2MXg==
X-CSE-MsgGUID: NDZlWCzYQVqR/pStv+X7KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690972"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690972"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:43 -0800
X-CSE-ConnectionGUID: bUPD5mbuQmi+rSH3P4t1+g==
X-CSE-MsgGUID: 7mq9m8LRQVGRYYK23zxlCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858391"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/17] wifi: iwlwifi: mvm: restrict MAC start retry to timeouts
Date: Fri, 27 Dec 2024 10:01:06 +0200
Message-Id: <20241227095718.98201c79f66d.I5d7e12b219d533c6a77741ec5863984d35711f48@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We had reverted the retry loop removal because of an issue
with PNVM loading, but that issue manifests as timeouts.
Since the retries aren't needed in other cases, only do
them when there were timeouts while starting, not other
errors.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ca6c40954e9d..b3c75484dafd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1311,7 +1311,7 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 
 	for (retry = 0; retry <= max_retry; retry++) {
 		ret = __iwl_mvm_mac_start(mvm);
-		if (!ret)
+		if (ret != -ETIMEDOUT)
 			break;
 
 		IWL_ERR(mvm, "mac start retry %d\n", retry);
-- 
2.34.1


