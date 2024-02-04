Return-Path: <linux-wireless+bounces-3111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D28490FF
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581461F22AE5
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BC53FB14;
	Sun,  4 Feb 2024 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHmyVdnr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF63D99A
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084413; cv=none; b=C+k6uXAWFXfeKwNE7a9yaGlXMUpcXHCJJPr8igBBcrOiYkS7nLHZa6fGSZSWBwMnnjkFeM4xOM8fDB4bFfA+220ES2HQ9kbvXgdfsLbeTYPw9fyHtPDJWsxs6kyEJcYzDpYSKSkMFJntHwIzytI92dyGTRY1LkqB2tsP7nEiTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084413; c=relaxed/simple;
	bh=usskLYDXWqy+eZrpyFwvSTpRd+ap0/zKHhmRG7xJFHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sTfZF0TfbnhNIz6BltH/wbeSvdBy4TTqYCCWleBV75VMRDgNPhOSm+qbygycPFQxvJiGEb/nnj5msYCcqj6hdyCM58iWIXHho+7HWaPAUgg8n1z4PVS1cKflWRoS2kkKIZTuCmrSuTcrgY9AFpkgl2p4wROWx6u+FKKH1K5xCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHmyVdnr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084412; x=1738620412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=usskLYDXWqy+eZrpyFwvSTpRd+ap0/zKHhmRG7xJFHw=;
  b=eHmyVdnrcBLDkKj+ftOmKkc2x75iZEpKn/ADjkluX8N37iD+bZFW35/K
   fRMCou9uy485y6KejALbsKRULHgMyBmfcT6ENaQ31dZa6Wn48NhidAcMw
   uc4Dz294l5bcZwBAwE+jxxdLaQ5Vac80yZVtmVGkDAb0Bl0C9RsKY6z3O
   V0YHzVyIoKUl7KWWGScucnARb5GycAxdKeUtOzGGFxYs8PDFT6ciDbHpM
   Kn518uSHYL+C4NGdm+9GxR3snNS3xRPUUByAfIqtYkRuDOgDmTQBiMak8
   oKOj79AewyKKL5Zod/qPTzIAIgaJPRjzgWX/IuCFXgQM5q7AS7YbP82ZS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869386"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869386"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815893"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: don't support reduced tx power on ack for new devices
Date: Mon,  5 Feb 2024 00:06:12 +0200
Message-Id: <20240204235836.768d56206093.I737872ff19f0dbeefca42a239d673f05b9ac06f0@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is no longer supported by the firmware.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 2c34c55ca5f4..535edb51d1c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -181,6 +181,9 @@ static int iwl_mvm_bt_coex_reduced_txp(struct iwl_mvm *mvm, u8 sta_id,
 	struct iwl_mvm_sta *mvmsta;
 	u32 value;
 
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		return 0;
+
 	mvmsta = iwl_mvm_sta_from_staid_protected(mvm, sta_id);
 	if (!mvmsta)
 		return 0;
-- 
2.34.1


