Return-Path: <linux-wireless+bounces-20057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDEBA57E84
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140A016E10D
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA211E25F7;
	Sat,  8 Mar 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnT0a7mc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333AC1F5848
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468796; cv=none; b=e14YWY+Gv3x2pLjIDNvttIWs6Yt5M0gb7ufHTcQiyV6V11azW9GdledkT4FRfrGwgQWD82lr+/vyb+70ldZWr1csRlY+l9StYoUL6y+rVZLjAFQXXN5C1zQfHkRPCYtKU3K0F+Lb+MhkCUgsMUOsY2KMXO1N5xzsodG0tqvUHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468796; c=relaxed/simple;
	bh=+syhqyEU7ZeN3xxAqNsIFIuAmJpnrWfr6M2cgkxY0gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5WT881rAOs3gCOnukOAiXth9o+lv8cGmuaOXiMaHmpgokfrYVuMyLmYW/PzvBC+VeQoumPdpz6CXFtRL1qrs4HIHB62OxRWC5+1b4EeKgA2Bg7hA9Z0m057fDx981zdcQzZbFxjHMqIaJsOoY3f9exJ58Q9s22M1pD0W4TNlnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnT0a7mc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468795; x=1773004795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+syhqyEU7ZeN3xxAqNsIFIuAmJpnrWfr6M2cgkxY0gQ=;
  b=gnT0a7mcisidRcFLcfcqlmzCY4C3vZ7h7xGsMCgWmUmKFGML9CTQAyXg
   Zbjt4Wsu9RO4T9IrikGP515Y7JRzdwvfK5wjph+cBHqmFT/wiXooy6AFK
   9OSFMr1ZoleYODkWFqvP3rSMgpWNR0IG7Aue3tIPmSSPzToD2bibeqQ1j
   +FEQ2Vv8+3Nf5VSD/6Ex9WbSUf4Xl/jgr/OS5bZaZjBEvQTiujGO2slQl
   Mqe/XAod80LPwztvLDYAD8lBP/lUhp5NgCr3SmN/KDTwCZDvTKc10Y+pY
   tfHvB+HKK5LhY2lDMkGHPi7pEKVTO4Wj0BB+f/mH44j/fi9aD8T2VbtoA
   w==;
X-CSE-ConnectionGUID: JGNw4DtOQRCHQpaAzsqB2A==
X-CSE-MsgGUID: Cxnste1gR52dSpCUgRh7nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052387"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052387"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:55 -0800
X-CSE-ConnectionGUID: vOKy0+ErT+GUQ05Xn6TiYw==
X-CSE-MsgGUID: 1Ga1HCcoRYCgOuZ9S3bufA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859957"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:54 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v3 wireless-next 12/14] wifi: iwlwifi: don't warn when if there is a FW error
Date: Sat,  8 Mar 2025 23:19:23 +0200
Message-Id: <20250308231427.ba3d90b22c25.I9332506af1997faefcf0bdb51d98d5e874051722@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
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


