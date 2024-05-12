Return-Path: <linux-wireless+bounces-7549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37AB8C3681
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D73C2812CF
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7E846B91;
	Sun, 12 May 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQ0F5+yD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A946522
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516737; cv=none; b=NVpTlTVFnNcwcns62lEC+G0oi64vb/BXoI2MCwMaCReVSTtOMdoZ3dTuLYgWhzVvS1LdI+9aiSmTijkuPuqvlSmFDGBYl05xwc7fh1kqkOM00j6KU84M5VEoynfrcF5SpD4LvpmrQtx9Pr65B5nIZsBuQhFmSxXAEh21x0qlHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516737; c=relaxed/simple;
	bh=vhMRuS6eNwKXkPE9Mui0EmIpIF4PlFmpdG1Io7aiLRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHNdRlid/OWSMxCIOrL20+gsJcQuTsN+23SwhxKthoh6OmHekWvPa46vH+zRZQXFETAwhDdCuhoU0CBAY4RHzaqQIRb2fbzx0Rkl7C8vFcRxvlpH2+KaGNVaDqPUdQ8g8032th488CxsuSagzgMCiyknYlyJC4k+vcIW+oR4aNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQ0F5+yD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516736; x=1747052736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vhMRuS6eNwKXkPE9Mui0EmIpIF4PlFmpdG1Io7aiLRM=;
  b=TQ0F5+yDH2QH6EhqUtiuQ/Lnvy/eciqzivuKAJHRlix6N7N54Uejkb9g
   U9SlX7m27dEliuK5rudOLPptE3jGY6lwEo8ZwExCUIhh3wm+nfNEYQ6Ge
   vmvkKln1NxxaNOOnpLgFBVex/aeq1A+V21WNIB+2f/1tTlgVbYwsp7fs9
   XH90S+vtwJynjZ4vGFeh+UhqyzpXUDFEqBXOan8aGGC5KHZdk7ouIkaWc
   4V9UpoTvGgcbQvliMjtW/8LUu6Mn1gbWmCZ9PSFcM5Ffk5N7xuGtXaVNh
   Gyml8rLhJs3elSFjRD+kOw6aYIs4uqHnYfBQwFVyEslCpg6QFDwsh8tH0
   w==;
X-CSE-ConnectionGUID: k5I2C0XJSR2yCyY/BPpPCA==
X-CSE-MsgGUID: AEgctstdQceDVBjYdqYdsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397226"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397226"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:36 -0700
X-CSE-ConnectionGUID: EzxU7sg5Qnu3LM1EF3yEgw==
X-CSE-MsgGUID: OYs05ujEQzm3cQZQpmpd5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761368"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/14] wifi: iwlwifi: mvm: don't read past the mfuart notifcation
Date: Sun, 12 May 2024 15:25:07 +0300
Message-Id: <20240512152312.66d9d0b23348.Ia91dd20f5e1ca1ad380b95e68aebf2794f553d9b@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

In case the firmware sends a notification that claims it has more data
than it has, we will read past that was allocated for the notification.
Remove the print of the buffer, we won't see it by default. If needed,
we can see the content with tracing.

This was reported by KFENCE.

Fixes: bdccdb854f2f ("iwlwifi: mvm: support MFUART dump in case of MFUART assert")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 87cc1471dfdd..b8a785032513 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -94,20 +94,10 @@ void iwl_mvm_mfu_assert_dump_notif(struct iwl_mvm *mvm,
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_mfu_assert_dump_notif *mfu_dump_notif = (void *)pkt->data;
-	__le32 *dump_data = mfu_dump_notif->data;
-	int n_words = le32_to_cpu(mfu_dump_notif->data_size) / sizeof(__le32);
-	int i;
 
 	if (mfu_dump_notif->index_num == 0)
 		IWL_INFO(mvm, "MFUART assert id 0x%x occurred\n",
 			 le32_to_cpu(mfu_dump_notif->assert_id));
-
-	for (i = 0; i < n_words; i++)
-		IWL_DEBUG_INFO(mvm,
-			       "MFUART assert dump, dword %u: 0x%08x\n",
-			       le16_to_cpu(mfu_dump_notif->index_num) *
-			       n_words + i,
-			       le32_to_cpu(dump_data[i]));
 }
 
 static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
-- 
2.34.1


