Return-Path: <linux-wireless+bounces-26640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CBDB36F53
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C5A985681
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2ED31A573;
	Tue, 26 Aug 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RaFnyk5Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C64B26E702
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223748; cv=none; b=Dpj9YrMfUai1w2qBqO1P4Efw9NDfhVCmdSfMbE8zKM/ez76rM0DgZoFgkqgqakTbfZgipJNo3XZUYPeXf5hceSwcjJ65jkxepiWiAJyHH5kRMBkhE/5xaiwrLcsi10d73l1vECT7SZ+vU/tvuYpC9o0/NJz7fhgJcw7pHYRAuVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223748; c=relaxed/simple;
	bh=5fago3RaIUtZjalvLbXw1C/Mrc1NukcpQ+t0lemHmSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKviz1wjEMlQuRbqOmA614CYBOQ45THcA3i0UijpV7BO1AvPBoPluMqiGBCYIPo20hODDuy4V/vHWoClqYJZl1J1w5Ty9ZgZu15WOb3XIn7ToI5W8oXDN9riUg/120Bp+lOG2SFdiHXYTlj7ApsqcdT4cS/Pn5hzb0K0gmuL2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RaFnyk5Z; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223746; x=1787759746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fago3RaIUtZjalvLbXw1C/Mrc1NukcpQ+t0lemHmSc=;
  b=RaFnyk5ZwRWnpQSCdG/GNQMIczOWPhUwWGtoKkBCC8uncljz3EMQtOca
   TTZbTflNuSjokUARLIUQ7W8x9Rckj6I8CSi6pYjoA7GDFEOi/7EtvSwHO
   CsSZ9Ewz61VG00bmdezioC4R31Xns+dGeRt+S0JAF0BQimC/PfV/aaUhU
   diI/0GFak8kJVGjLIhZvZW+oSjOsET7jFyoiD1ZNSVSojk+Q/cACISpA8
   xWJrjX2SDq800rl/Tynlr6bGX1lBqHZXDGEQZOPmcPfQ/u9q/kDt6gpKF
   3RqDlspasUwAiaC/8ANYJFlFaOrUDHaRHVh5+Ibx7upjDavS8dWJI0nIs
   w==;
X-CSE-ConnectionGUID: vOJoCTz7TYC6SP/4t9kLkg==
X-CSE-MsgGUID: MjoI7YXOScuDLJN88FoEvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108415"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108415"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:36 -0700
X-CSE-ConnectionGUID: 0tJQBHTbRUWUWUb68f7D+A==
X-CSE-MsgGUID: W40l88jCSK6+uyvCZoBMpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218226"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: simplify iwl_poll_prph_bit return value
Date: Tue, 26 Aug 2025 18:54:53 +0300
Message-Id: <20250826184046.6d5444d553ce.I769146e3ba78e12ccd014b4692492df6aea17ca1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Itamar Shalev <itamar.shalev@intel.com>

Update iwl_poll_prph_bit to return 0 on success or an error code.
Remove timing information from the return value, as it is unused.

Signed-off-by: Itamar Shalev <itamar.shalev@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 0a68378dd505..fb645dafea38 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -160,7 +160,7 @@ int iwl_poll_prph_bit(struct iwl_trans *trans, u32 addr,
 
 	do {
 		if ((iwl_read_prph(trans, addr) & mask) == (bits & mask))
-			return t;
+			return 0;
 		udelay(IWL_POLL_INTERVAL);
 		t += IWL_POLL_INTERVAL;
 	} while (t < timeout);
-- 
2.34.1


