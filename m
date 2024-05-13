Return-Path: <linux-wireless+bounces-7588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A797A8C3EE2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 12:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E931C22984
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1014A4C4;
	Mon, 13 May 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdgnKe6T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58B14A0A6
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596052; cv=none; b=qRCTB0S9c4CJ4Rpmg9Fyt0irToZM8PSa6EVgwFZjxbXa/1RJKTy6K/xVaSiLRllynVtD12hvY4yKqCsL1kexhI14XkwJKa1GMnoGWVKzeQVI4j9i777LwywlScel2EsV0kCb8riQJYglS4fJ67eZBVxHbA6a0o76pvsdVymnAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596052; c=relaxed/simple;
	bh=u6kcOh1bm9cWMobY6O4a/TWDMNd/isGc9OGoEF17NaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwScQPZVTYuaGuiAG5z4tJ0NGW69RzUr2Tr6pbV2YUbAzjvpA2/hJZBW1wVvXV8E92NyCTx8qGszY/iRPFL7C6/vM6IMBJzZVE3BeO1QqUPvabl+7dQ3Fks0xtizSaaurqjv2v3dgpNo1ka0pgeXDB01xk7OfjAsBe5y2L5AqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdgnKe6T; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596052; x=1747132052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6kcOh1bm9cWMobY6O4a/TWDMNd/isGc9OGoEF17NaQ=;
  b=OdgnKe6TuREFXkLbX2v0zb558CkAIBIQ9iyW3smYTKTnbNAKYtmwN5/Z
   4opdk2iOdO+npb3NLwKe1FHwQRfmBoxwzSw5hslCGdBnBHlbq4xVIC5yB
   i+G76qMMu1fnoHQ9VnVoiF/n35fYHgWjDHWhnr3//itgB9MJZkqORFRam
   CIoFPNQHtI8hZStP6EBbgyLzbC5b7+dEGZmXaKnejCTGMIMGuwMxddL4x
   kCfP9vogk2t7CAC1oDoSs1F9rePznojvUtT2rJZVmbhZFD0P3YFwKJqnw
   +Dwl/BCNGQTT8kr5pkBjkVCOKYTfDqgEzMMJ+rXuAKLV/gdiEEcelZnQq
   w==;
X-CSE-ConnectionGUID: ow6ZFIscSY6GiVPGRRThRQ==
X-CSE-MsgGUID: 3BpVt1U5SjC/FEvltg9hug==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22928672"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="22928672"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:31 -0700
X-CSE-ConnectionGUID: I+HkdxuKRbOUKNuP04wGzg==
X-CSE-MsgGUID: wzt1AtFJQv6/SCaXL5IKXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="53516424"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7/7] wifi: iwlwifi: mvm: don't read past the mfuart notifcation
Date: Mon, 13 May 2024 13:27:14 +0300
Message-Id: <20240513132416.ba82a01a559e.Ia91dd20f5e1ca1ad380b95e68aebf2794f553d9b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
References: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
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
index e1c2b7fc92ab..c56212c2c306 100644
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


