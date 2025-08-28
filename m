Return-Path: <linux-wireless+bounces-26740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28871B396E2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C1C7B4BDF
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF12E0921;
	Thu, 28 Aug 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjLe5n32"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8882DECA1
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369621; cv=none; b=QBJtpFnP9DgphkMIpyD++FjXE3PRxysQLmieD09zdoM8z1I4+GCnrVdn3WP+6+LSRcoQzKDYpGNuQcf3m28vPjO5UPgK1hmZMbi0qfW129aU7cxDobuLEUL9f6NRlU4uPPhjX/8J/xwCBUTrv5Tj62lKpnlMF5FYg8mnkDZy5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369621; c=relaxed/simple;
	bh=DoVuJ3ArAJZbG+7U4aOMOvpEfGNBGedAdocPXhIj9QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAoSM8g+3a2KIXr5Ct2jHNeh7ZN1WCu02yths3cygsKuF+eOuI5Giru04eBgX2+luLuExPwuke6g4zzNXrTNi66TxwK4J02phgJlZcln/3uSTWAOVTwre39IRq1wTA1jHwq7cPANx8mLvKOjhysFADrdSe6spW+MzqI8MkvRWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjLe5n32; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369620; x=1787905620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DoVuJ3ArAJZbG+7U4aOMOvpEfGNBGedAdocPXhIj9QM=;
  b=SjLe5n32UnddtgwonFxFY95FEWgvLGYgOD+cDz4n6u5r65ko4xLQbW12
   aoku9joNCjWPvOEzn53YImUrYuglxa9QGwmXZ5WfNlopA28A1OQr/U3cn
   zgpfw1wjhZB9l+uI456b+XsonwrNY4kRMESmQ5WJzU65YygtyNZIQOJtg
   xmnGXhK85Ebro6qYRJztKhh9coh9JfKfxuZ7hcf2gS1wNh4C/zLqgnhN/
   TJ89xAVnVYLiVeeSdaMr7Su5bOeQ95L6XNc6sCl2jQCyYPGwObMxh4SwI
   DPUBFw+8/zedYkmo5jWd8k6g4NrCxfUiPJRklRayH20LSm+XsmkacyY9G
   A==;
X-CSE-ConnectionGUID: LziCFIrdSW6IFci21LNmxw==
X-CSE-MsgGUID: DQ1bNNZTRnmilfO9NhVIQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003365"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003365"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:46 -0700
X-CSE-ConnectionGUID: r1K34WTXSDyiyGaLKqi7pA==
X-CSE-MsgGUID: chwMEYF3TPieApvfxzga+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224519"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Yedidya Ben Shimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: pcie: remember when interrupts are disabled
Date: Thu, 28 Aug 2025 11:25:57 +0300
Message-Id: <20250828111032.e293d6a8385b.I919375e5ad7bd7e4fee4a95ce6ce6978653d6b16@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

trans_pcie::fh_mask and hw_mask indicates what are the interrupts are
currently enabled (unmasked).
When we disable all interrupts, those should be set to 0, so if, for
some reason, we get an interrupt even though it was disabled, we will
know to ignore.

Reviewed-by: Yedidya Ben Shimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index b5114fb4eaa2..79893e2d2701 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -841,6 +841,8 @@ static inline void _iwl_disable_interrupts(struct iwl_trans *trans)
 			    trans_pcie->fh_init_mask);
 		iwl_write32(trans, CSR_MSIX_HW_INT_MASK_AD,
 			    trans_pcie->hw_init_mask);
+		trans_pcie->fh_mask = 0;
+		trans_pcie->hw_mask = 0;
 	}
 	IWL_DEBUG_ISR(trans, "Disabled interrupts\n");
 }
@@ -1023,6 +1025,7 @@ static inline void iwl_enable_rfkill_int(struct iwl_trans *trans)
 	} else {
 		iwl_write32(trans, CSR_MSIX_FH_INT_MASK_AD,
 			    trans_pcie->fh_init_mask);
+		trans_pcie->fh_mask = 0;
 		iwl_enable_hw_int_msk_msix(trans,
 					   MSIX_HW_INT_CAUSES_REG_RF_KILL);
 	}
-- 
2.34.1


