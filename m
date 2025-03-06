Return-Path: <linux-wireless+bounces-19907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8425EA54A02
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD24D18872B8
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379D1A0711;
	Thu,  6 Mar 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlpGOM+E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABF20C00C
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261772; cv=none; b=Fb5jQth79WyijVneQvomKJ9riPpN5ZN7xeB7ZW1ZpZqbRxi3Kz5z0QwJlikcN5rGPNPhbp6X12tAWlZel/1FssvOY/BRTCfNkZ3P/I8UkgPOZ3tJ0IKvsPZmcI7YbURriVfspBfcQ17WdP0Zu9Gtc96AXmY4UHU/brAq3FbXXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261772; c=relaxed/simple;
	bh=+syhqyEU7ZeN3xxAqNsIFIuAmJpnrWfr6M2cgkxY0gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cH9NybJeg0jET6GaDuDbhe6hGxB3o5nBBuZvgU/Lmyu+HpFPi/GQ1V+nQAtfcqKQxp2zEMfYZjOic5R1hp360b2ko27JCoC3iNcWSLj/udVgkVAusxLbVhfK1G3kgCbxg55pSUF3P2KMmFjqJlg6qAUaDYTuc9FX3xqJVDiZNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlpGOM+E; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261771; x=1772797771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+syhqyEU7ZeN3xxAqNsIFIuAmJpnrWfr6M2cgkxY0gQ=;
  b=GlpGOM+EUo+VxH77eeDd4Gs0CzqC9kErT3um73SITEFPROhYaubcANpA
   B1cfviIUdWCGN865YLv9GHII2WFCHIpJyHayBX4/XPfYS14+MiYy2xdg/
   qQ0QPCGT4rFqXgdpYQm/cxFs2OlGFsnhZuCyYtoGsN8FYs8gVcZSUtjn/
   yPIiiLXlPOsDeldLQZfnnMBHG1hpn6JWjTPPCcEW73yPTsIT2MgWV3sHG
   /Cg5hdhaJIR/2s7gVbcIM1WNI7zxdkVhyHVRUexiL1r0IVQRRSUFkSprO
   Yr5RKFsVXQWTi4yrye8VIltICoNZU8b9k5b7jZsR4Kl/e+n2daWaNE+I5
   A==;
X-CSE-ConnectionGUID: 5QLf+yMnT0WWta8X4mjL4w==
X-CSE-MsgGUID: AqreYuUDT4SQ4d+s/arnPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474552"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474552"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:31 -0800
X-CSE-ConnectionGUID: aktLbxJ9SVeF+4mXOGzmYg==
X-CSE-MsgGUID: s8ukZ/BzQpCEVKy316AYOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915578"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 14/19] wifi: iwlwifi: don't warn when if there is a FW error
Date: Thu,  6 Mar 2025 13:48:50 +0200
Message-Id: <20250306134559.9c109c8b31e1.I9332506af1997faefcf0bdb51d98d5e874051722@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_trans_reclaim is warning if it is called when the FW is not alive.
But if it is called when there is a pending restart, i.e. after a FW
error, there is no need to warn, instead - return silently.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 1632ab20a23f..ea67df09fc01 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021, 2023-2024 Intel Corporation
+ * Copyright (C) 2019-2021, 2023-2025 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
@@ -639,6 +639,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_tx);
 void iwl_trans_reclaim(struct iwl_trans *trans, int queue, int ssn,
 		       struct sk_buff_head *skbs, bool is_flush)
 {
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
+		return;
+
 	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
 		      "bad state = %d\n", trans->state))
 		return;
-- 
2.34.1


