Return-Path: <linux-wireless+bounces-21877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17ABA97E5A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB71418978A0
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C445266EEC;
	Wed, 23 Apr 2025 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9/64JJZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1C26462C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387475; cv=none; b=MmmIYWTitJtgsmgLtoL3Y5rE2GfkNtbDO94+nZpL9raG/uAe6/TqEmtq0sm7jEOt1cJZx2YWbXTJQw0L3K78/fm2zsSw8WA2Ce9EePIetGNoVGGP12vvlJjzpySzUJAe1Hv5Fv7YR00vLUfNscKoKpjS71NXlc0TzIGhy1Rz/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387475; c=relaxed/simple;
	bh=c/V2aRHqPEAfrppj7F21Qr3t8qAwhyhUigfJ3ebJt+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9Z25Na65iKXYZEjT3qat9Ik0CoZeSD5fBODkKJl1i0SM0+DA7x/1lE/8SDp8RfUqFOT5L0NM7ub0i5NPf5toVtS7i36zEX0pJgtELOqkmMc8zzHwBe+oHDfXl1KTmIJmynWLBDijxh1wDn6EHaPhbyIEfA16ZXbTSpHFbTEi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9/64JJZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387474; x=1776923474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c/V2aRHqPEAfrppj7F21Qr3t8qAwhyhUigfJ3ebJt+s=;
  b=e9/64JJZxFz+9igpGrsMq1dCZEMwQHfQuBugc9FOHWeSEndJ29/uhjzD
   zKDjpraQS0HVhzMdVz8tpJCZgp398siHVeiWq2le8sMJ+6ILVfS5Vhtxv
   /upmTS1qEnMkY0B0WnmnZQ1Nzg/TTZ8yooGgUpcpfTSCPNmGXkqnIujmt
   +MxRZ1trAxRKW/JyYIG2XUSKu/zoLHeOVfVeSrD1R/K1woF4N9nML1RlK
   loh5eFurEPLtnZ8FfYcMIzgXrnnowVCDgfcEMTH9sEepNkAX7sEORqMtR
   zl68OU4R23XlRi85K92xs8hZw7iJasxv7Mx36noG26nYz7ZrFmUZozwo5
   Q==;
X-CSE-ConnectionGUID: Q6JeArW5QmmZSTB//fb6MA==
X-CSE-MsgGUID: j/p3pNxpTUq+wxT2hitbsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844658"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844658"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:14 -0700
X-CSE-ConnectionGUID: /xQv33IWQjikoOXL3u0caQ==
X-CSE-MsgGUID: YB46q4RETE2sfm8UtiPHFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164383"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:51:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless 17/17] wifi: iwlwifi: mld: clarify variable type
Date: Wed, 23 Apr 2025 08:50:36 +0300
Message-Id: <20250423084826.9edbdbc0a86e.Ie2e8de150f67369c4e034452c5f1a15f85d2931c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In iwl_mld_emlsr_disallowed_with_link() the code uses an
enum for a bitmap of values from it, which doesn't really
make sense.Use u32 for the variable just like the return
value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index a870e169e265..bf158af5f6f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -643,7 +643,7 @@ iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
 {
 	struct wiphy *wiphy = mld->wiphy;
 	struct ieee80211_bss_conf *conf;
-	enum iwl_mld_emlsr_exit ret = 0;
+	u32 ret = 0;
 
 	conf = wiphy_dereference(wiphy, vif->link_conf[link->link_id]);
 	if (WARN_ON_ONCE(!conf))
-- 
2.34.1


