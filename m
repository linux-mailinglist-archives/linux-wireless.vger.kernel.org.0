Return-Path: <linux-wireless+bounces-22815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1BCAB2505
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A0A01605
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787CE283127;
	Sat, 10 May 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIUg6mBR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F662686AA
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902926; cv=none; b=XizqTMZP1rbcPWtb1mRm/+k0JJS4LYSYf0+5EHix/Mu4aVn1okmNdIA63UV0ARA03ttQxd8yGPzN6X++qowG61sdzp9g2XlEBbHw6rJVZiS6wO7xTlRks0Mw0LH8YlGedJ25uWrHmQ6ITTP8iPy4tYN4wWhWfhhfmu+uAVidSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902926; c=relaxed/simple;
	bh=NICU5whAi1R0JAwwHUbK9obse/hA+vbrRIbff2OgoNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHLfeNB2AOgiNQ0rar0XQMKTOGPAmnEacwdvV6+2SEKCEFytLiVpHZ7/ybq3wY1bTHI8VBhwATNMs3coyB/ZJp6U31giWT8iqgIWxYQ13KkydfT+zG+vbr9ZCL7xWLB0ucCxPm7+TJNFZNcI6/kU4YgjTas73RMt0vQ1egNeh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIUg6mBR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902925; x=1778438925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NICU5whAi1R0JAwwHUbK9obse/hA+vbrRIbff2OgoNQ=;
  b=aIUg6mBRUHM/zje4QealgfsDxmVWoozxCXLrQnwb3Od7L5EQ60w8xYDi
   homgWwNTVX9bb+lTISYiPq8gVwRxdAGxm/zRHlE3iubxFyspSPi3TBXxJ
   Z4ugHKgLDU18eXP5D6dhE7J74llZ6/EL0MZYg8KWodHtJ3q60wNZEhu3W
   xG4dp55bAUR4kBA4akJsnnqnyqleq9hGPFI7S5DQdO/ZqxdhqGsRUatUc
   yuCyy+VPJSunPP3w884j4TbxDk4TmV83Pi4AkqnZAyMu1qTN7pQaBDyv4
   yan6txp+KegxsbX7W5jFWtysPLeH53+WbNKzNP7SozMF74aKdjKrayHVv
   A==;
X-CSE-ConnectionGUID: LH/pld8nRViveZ09rB+V3g==
X-CSE-MsgGUID: o4H83SptR2Of242ar62ChQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880875"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880875"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:45 -0700
X-CSE-ConnectionGUID: dRo1rj8GQ9qzA2YU+9stlw==
X-CSE-MsgGUID: 0zgaOajMRJugWgT9Seg1Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033414"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mld: add debug log instead of warning
Date: Sat, 10 May 2025 21:48:14 +0300
Message-Id: <20250510214621.2593268ca988.I9786126cd1078caec8587b166a7f8735300c951d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
References: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

During link selection if the links does not meet the valid grade
criteria then add debug log instead of warning.

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 93d0547798c6..71edfb1cf68e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -974,8 +974,11 @@ static void _iwl_mld_select_links(struct iwl_mld *mld,
 	n_data = iwl_mld_set_link_sel_data(mld, vif, data, usable_links,
 					   &best_idx);
 
-	if (WARN(!n_data, "Couldn't find a valid grade for any link!\n"))
+	if (!n_data) {
+		IWL_DEBUG_EHT(mld,
+			      "Couldn't find a valid grade for any link!\n");
 		return;
+	}
 
 	/* Default to selecting the single best link */
 	best_link = &data[best_idx];
-- 
2.34.1


