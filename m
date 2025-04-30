Return-Path: <linux-wireless+bounces-22272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663AAA4C6F
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE551B63CBE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF16A25A633;
	Wed, 30 Apr 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3vXnT+j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA82609D8
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017880; cv=none; b=lgYGC9FPG0cNIRWrv8hdcuUpC9tdkDMKpg4OwXrjRNVz2Pf5GD7TUd66u8fyC+MB7sPQGynoojVuDyLeyNRaQU2q5UoHnaegZfXxMrvFrlbVdHvVcV4SPys/nzquKAgKtNcYlh6OBgSC7iP0/r6WqwzgcZIqf6f+MEwr//dWaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017880; c=relaxed/simple;
	bh=c7k4nmLcHKK0tYSRiGhz0ao5U0LuxHDl6LkPeySJtCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAYOxa0xi/75I88eq2XkQoCK0x4QJIhubfAI2k1biZNR0QDCynCTcRalE5riqi3plGQ53Gkcq97O4XlsAjH0MwswylxgHith1nOIOhoZQwP/BQ1UBja7Rs0gD3TY5u9fba+S1lEoqR067Ozu5KZ4GUEECyfs10vU4PYDC28Q5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3vXnT+j; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017879; x=1777553879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c7k4nmLcHKK0tYSRiGhz0ao5U0LuxHDl6LkPeySJtCo=;
  b=E3vXnT+jdSF2W8V5z3Z/GgQSA6b+KGIeSIhiOfrbIxEPIRasdwIZ4C62
   /FmglX0F4LRtT1H+wZvL0Ch719zv8Wg8PJvltI1TuJlw01N6gfehcJbX0
   iSBMxKAfnyHNfnhiKJXebqjpKuzmCN1qhhpMpjkxmxFtJxZLizx3G5LHl
   IKFBNPdaoGcZB8ztNSffT8L40DMmDPOrs7h1V6ALyyWjFm/1vXWDWaoyJ
   bf5GGThuKsn18o6I4B0/Hx4JVJ45sl0cTYcoPyD1XGJx7KtqkdA3z/bZC
   Fcu3RHv5JjrPbk4zE6hWFIdBKVbCBfbW0aptK+TysTRmOr3SATw1eh1GX
   g==;
X-CSE-ConnectionGUID: w4AJwcN/SX+l1TZuKIwSYw==
X-CSE-MsgGUID: fyCw3SH0QyCqtXmpVkrCXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332350"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332350"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:59 -0700
X-CSE-ConnectionGUID: jUYVTpDOTbSD4MbrPhn3Bg==
X-CSE-MsgGUID: r7JvtW4NRHa1E55sxzDZ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632121"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mld: force the responder to use the full bandwidth
Date: Wed, 30 Apr 2025 15:57:25 +0300
Message-Id: <20250430155443.620fe8099fff.Id50675f4d4c524b0a7ee602c48af538a327010e0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

When a soft AP is started, it may not use the full configured
bandwidth (e.g. if no station is connected). As a result, the
responder will not support the configured bandwidth. Since the
responder supports ranging with unassociated stations, there is
no indication to the driver when the full bandwidth should be enabled.
Fix it by configuring the AP to always use the full bandwidth when a
responder is supported.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/phy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.c b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
index 3a80ee5e1cb3..d5a32ee56b92 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
@@ -50,6 +50,9 @@ static void iwl_mld_chanctx_usage_iter(void *_data, u8 *mac,
 		if (rcu_access_pointer(link_conf->chanctx_conf) != data->ctx)
 			continue;
 
+		if (vif->type == NL80211_IFTYPE_AP && link_conf->ftm_responder)
+			data->use_def = true;
+
 		if (iwl_mld_chanctx_fils_enabled(vif, data->ctx))
 			data->use_def = true;
 	}
-- 
2.34.1


