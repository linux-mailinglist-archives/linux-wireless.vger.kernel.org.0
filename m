Return-Path: <linux-wireless+bounces-21754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30E5A946DB
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24EA17528A
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0D2AE86;
	Sun, 20 Apr 2025 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvHlG6ZT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5A18C33B
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132420; cv=none; b=K95Av987MV61wYHXSHB5/nxRSkmaEhRg0W6us2nWekX4+uxWPoB6Au5tWYUdRwEyJFsGpAhjMbsdK6Ojb5VnzHThUOZs809XqMx4BVRjdUDrFpUmtU7CYJaRrbUpGWNFg8oaE7/SzfI98lSJP/7vHG0+BItWRu2Xo4/eB0i86ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132420; c=relaxed/simple;
	bh=2k64ZHWbjAhOztt2bqxfQTCPdQh3i1EBn85Ep2GnmTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nn8roRmdwdRc2Wst9YhC8kgXBuDEwmstyweRy9OseJ84n29Eha4r/Ani8NG0Kka0lsFYEQk6lnKXzBkLhjenoW2VqTbG4hn077Qfs8YmaE5TuqcNXjBNY5JhCllKMPGGHJpSWYD/yr5/ScOrIQ3Jz3zle3yEFtyQjZ22xlwyEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvHlG6ZT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745132418; x=1776668418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2k64ZHWbjAhOztt2bqxfQTCPdQh3i1EBn85Ep2GnmTI=;
  b=CvHlG6ZTLE4xSoEWln8gcQT+hROMjeKv88Tv7DAtWUYxD7Zfl03J2FgV
   u+7ekMjX95HOYMxS1/693NNZ5q4zykceUWBhSJIOefINlesO+dtfhZLMs
   8E3tRGuGc40Ct4B2L70sbRCKBe8yHqdG6Rc9ulWE0ZeqdZ8yYefY3M/oI
   0yJUmPg1l40bPNqAqmjnQ/KdK+VdAetSu9D7zCq74dkGHKG2OsNdvRIsy
   CwJiRwK/9iRGTRmAhpJB58rdpLUUmnHwJQyGkXSpFAq7mwnui6BOw2+Qg
   4KKq2FFo/kkjOHyUWIfdCg683Cw18wHCxUWuWip6lPgetuTNksANxaako
   A==;
X-CSE-ConnectionGUID: aSWHUSvRQ0ia1qnrYXtU/w==
X-CSE-MsgGUID: 483QrzvLTX2cSL9fS1n3Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46827883"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46827883"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:17 -0700
X-CSE-ConnectionGUID: 7acwdA/uTEaqtGsAv72LJA==
X-CSE-MsgGUID: 3X/aPmhMSwiM//vtHSK3HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="154615709"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless 2/7] wifi: iwlwifi: mld: inform trans on init failure
Date: Sun, 20 Apr 2025 09:59:56 +0300
Message-Id: <20250420095642.3331d1686556.Ifaf15bdd8ef8c59e04effbd2e7aa0034b30eeacb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
References: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If starting the op mode failed, the opmode memory is being freed,
so trans->op_mode needs to be NULLified. Otherwise, trans will access
already freed memory.
Call iwl_trans_op_mode_leave in that case.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index cfdf52b43c68..4a0842a46a8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -414,7 +414,7 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		wiphy_unlock(mld->wiphy);
 		rtnl_unlock();
 		iwl_fw_flush_dumps(&mld->fwrt);
-		goto free_hw;
+		goto err;
 	}
 
 	/* We are about to stop the FW. Notifications may require an
@@ -460,7 +460,8 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_mld_leds_exit(mld);
 free_nvm:
 	kfree(mld->nvm_data);
-free_hw:
+err:
+	iwl_trans_op_mode_leave(mld->trans);
 	ieee80211_free_hw(mld->hw);
 	return ERR_PTR(ret);
 }
-- 
2.34.1


