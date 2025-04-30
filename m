Return-Path: <linux-wireless+bounces-22253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8ACAA4B0B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714B09A0520
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C98D25A2CC;
	Wed, 30 Apr 2025 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXW9mUIk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1406A258CC0
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015900; cv=none; b=hMoyjFKW1ps0410AeeLDusRPpzoYxHpZKxcMaHPqtj5xSsbPPRPltn0Wg+e37vGzJhEJCi2B17mEuwKShBKN1a9fGPm7gQPLEQ+A9N8wSOmOaPDPg/BySdHCTx/k5abGxeFeaQvcdNPXu9+pfk1p5zfrWXXFxaDK9KL4YALnGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015900; c=relaxed/simple;
	bh=RNWr15s1yp0pQdXSY+oIUFhcj5NB1Q83TUvb9X8v2MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNrokLM0U7bawo2QM2XAhheClzPNjywIRnF/YfmRlusuWHcw2kwt1qxTrsterZuKITKNvpjjUHIg3Ic7wBF+T+X9b4JhAv1AQSm9ZI8AOzmXFKlI962FlJjkouc6yLiv1gcvrVuLalP8DZyacSoqWhjnJ6pGbZO1sVuqbO3DL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXW9mUIk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015899; x=1777551899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RNWr15s1yp0pQdXSY+oIUFhcj5NB1Q83TUvb9X8v2MU=;
  b=CXW9mUIk7GlJ62keXkjGCU7mZ83xfY0LtWfOVgZJAWzRhDaLGPY1g/YJ
   uHw67q/Yb9ixPZ2RL+vkk9qYegK028uKdxuwc+y+zIef34W3oMPIET+ZL
   BYeKtxuBWD6Z/R/S9MiDR9zkPLbLBvEeLWTGpl1ZO9yNEbH6EwHjiIO9K
   run4efajn6aSjTAl7xD/mEaNQ1Cbv1m5njqqyCkxpE4hWlz1o6vI3Qkn1
   8YG8a/mkWdtHtctJa/mhUvkbjQNLnO3fnoVCZPIAZX8Z/sg3P6+26v73W
   vPu3Bl0Fhf7jhMyDFKGEI0eSDIeg8ib2B6RSEn5z5TtWs4+NLfG7/By6B
   w==;
X-CSE-ConnectionGUID: IjVDK0STQ6y9G+DAeumbXg==
X-CSE-MsgGUID: vne6UGx2SZSuNGS1cjYKYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578285"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578285"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:59 -0700
X-CSE-ConnectionGUID: xFCQ3qrZQ7Sb7jlIP2DxWg==
X-CSE-MsgGUID: wwwHqtwzTC6RdIrLaOGvPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087884"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 10/14] wifi: iwlwifi: mld: check for NULL before referencing a pointer
Date: Wed, 30 Apr 2025 15:23:16 +0300
Message-Id: <20250430151952.408652d45cda.I1bb72836dab17895a2e39910e4493d667db0fa80@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
References: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Errors can happen, and it is better not to risk with a NULL pointer
dereference.
Make sure that the links-to-remove pointers are not NULL before
dereferencing it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 03ef9b33c2d2..284599abf8c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2450,7 +2450,7 @@ iwl_mld_change_vif_links(struct ieee80211_hw *hw,
 		added |= BIT(0);
 
 	for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		if (removed & BIT(i))
+		if (removed & BIT(i) && !WARN_ON(!old[i]))
 			iwl_mld_remove_link(mld, old[i]);
 	}
 
-- 
2.34.1


