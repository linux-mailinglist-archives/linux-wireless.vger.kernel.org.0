Return-Path: <linux-wireless+bounces-19866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6EEA547BA
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4193AE303
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC38202971;
	Thu,  6 Mar 2025 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZuocFMR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78E1FFC70
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256764; cv=none; b=B01OzZnRG9DByo/oOUMZ7JJGO3IJB3Sl5hT6O7JQxq53wEFXVAYqbQoju82w3ovI8omZ2FIw5q3RhP9hM/EQ8wy413WyTsOCp1DsBTYGhtZ6igs6xVUx5w+e8EZHirQyOz500nkkmV70shQCipwkB2awM/r3p7UzeYMo79M+nY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256764; c=relaxed/simple;
	bh=/IwYSDKfeJxFYICY3XqZiXWO+qjXMx97iRqVScmQJ0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POwYvxjR5GU7TmIsvV4oQPzyJR/OqnSLVrMrFphJCkaA34O3fUdK9S8L4F0ZDGYM+ruWCQegjovYj7rlGie33h1q5usjXVL7r+kM/OA8QSST23Roxkqwb32dVFvcWpWb+bU+mZM77AUaJBCSrPJblawr6qUQFMf/UAf/LwsaI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZuocFMR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256763; x=1772792763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/IwYSDKfeJxFYICY3XqZiXWO+qjXMx97iRqVScmQJ0c=;
  b=JZuocFMRRznPk7vgyspk8ezosuYUn3RPfDZzuO7S5BMWDQfDZTpHBrCH
   bLZby5ZQdQG8GgP4d61qsiKU9tzy8YD3olrJBO/aRcFH4ctQKZc79zfCI
   ZLK0FUR2isO6t+HaGknxUCQY73iF/w/Zp6GTT6G83zqeDJDb/Ojr4R7vH
   OnA564/XCBXKI/q0nxQ6h+rVxVQS192SRAxP9nSY9Z3omomYwjykYP7ZJ
   Y8nRH+qbelmGCzhOu8Oz96yxwON16jbwZH1O44z4ctnOm+Z7r/ArLtj6f
   d5BwyfWbN56F5fYYTyyxQWnWlsVrWoMX3PbpslLJZw/TWE08vAvYEnr0e
   w==;
X-CSE-ConnectionGUID: 5rqKuc45SUe2gzrthC8Bpw==
X-CSE-MsgGUID: 2ioi1wUaQGGRxH7l9CEqXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41433442"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41433442"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:26:03 -0800
X-CSE-ConnectionGUID: YJniljhoQ8SItKmo1V4mDQ==
X-CSE-MsgGUID: UImLFEnBQM2H8p/nTOY5UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="142209567"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:26:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 2/3] wifi: iwlwifi: mvm: fix PNVM timeout for non-MSI-X platforms
Date: Thu,  6 Mar 2025 12:25:47 +0200
Message-Id: <20250306122425.0f2cf207aae1.I025d8f724b44f52eadf6c19069352eb9275613a8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306102548.4056118-1-miriam.rachel.korenblit@intel.com>
References: <20250306102548.4056118-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When MSI-X is not enabled, we mask all the interrupts in the interrupt
handler and re-enable them when the interrupt thread runs. If
STATUS_INT_ENABLED is not set, we won't re-enable in the thread.
In order to get the ALIVE interrupt, we allow the ALIVE interrupt
itself, and RX as well in order to receive the ALIVE notification (which
is received as an RX from the firmware.

The problem is that STATUS_INT_ENABLED is clear until the op_mode calls
trans_fw_alive which means that until trans_fw_alive is called, any
notification from the firmware will not be received.

This became a problem when we inserted the pnvm_load exactly between the
ALIVE and trans_fw_alive.

Fix that by calling trans_fw_alive before loading the PNVM. This will
allow to get the notification from the firmware about PNVM load being
complete and continue the flow normally.

This didn't happen on MSI-X because we don't disable the interrupts in
the ISR when MSI-X is available.

The error in the log looks like this:

iwlwifi 0000:00:03.0: Timeout waiting for PNVM load!
iwlwifi 0000:00:03.0: Failed to start RT ucode: -110
iwlwifi 0000:00:03.0: WRT: Collecting data: ini trigger 13 fired (delay=0ms).

Fixes: 70d3ca86b025 ("iwlwifi: mvm: ring the doorbell and wait for PNVM load completion")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index df49dd2e2026..d10877856049 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -422,6 +422,8 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	/* if reached this point, Alive notification was received */
 	iwl_mei_alive_notif(true);
 
+	iwl_trans_fw_alive(mvm->trans, alive_data.scd_base_addr);
+
 	ret = iwl_pnvm_load(mvm->trans, &mvm->notif_wait,
 			    &mvm->fw->ucode_capa);
 	if (ret) {
@@ -430,8 +432,6 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 		return ret;
 	}
 
-	iwl_trans_fw_alive(mvm->trans, alive_data.scd_base_addr);
-
 	/*
 	 * Note: all the queues are enabled as part of the interface
 	 * initialization, but in firmware restart scenarios they
-- 
2.34.1


