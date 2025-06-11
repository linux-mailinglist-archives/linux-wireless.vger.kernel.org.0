Return-Path: <linux-wireless+bounces-24004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D09AD5F08
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635EB189F2D8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD87C2BDC1C;
	Wed, 11 Jun 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1zSn948"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071F2BD5BB
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670017; cv=none; b=El0wBZK6A4neke2Pls7J8EuKRGONXfnXNTr5CedAID7PPctO6ecBTvvGVbWOBUTgjk62esmV0+y6HUFEkyYZRkI4B7PUQ2s05Hl9CFDCoOUDmK6YMWZFCRxIZWJt9iIxBftmXD8wIh3VuGyLNzd2S/wRo1ie1IO85zo30UYFEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670017; c=relaxed/simple;
	bh=vVOEhfS8uBmV2AWGbh9zbfC7yYm/3cLvNe3Sk55Reuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XWBAlxQnWqFsa7VEB1xcpu8vpUthyeSvzfCeiFWtLNtZi1DtYdDzjMeOhsHMneSmrY6ph0A3sK350NgbY2LKj/wgAda0o8WKMDbwRKBreTakt1gQ+szhv/gtQvWyroMf3yDK8lDI32zS5nLkwQZUKuqAC3eoAOi2mtR5wCZ5Z4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1zSn948; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670016; x=1781206016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vVOEhfS8uBmV2AWGbh9zbfC7yYm/3cLvNe3Sk55Reuk=;
  b=T1zSn948BvcbtTngTAJ0hMuTQnyj5/sZJCsJEcyUifV6iXQyojHsPUDA
   rA9GqI/5tWZdM0frfGzon5CEuracV5S8y1X4MlAH0epE8uiX/29TIGa60
   hOFzfNVB9kHUvmJviV7cidAKayWk4Q0+8rUGEpyjpALoJavRYqZQWtDf3
   iighbkg9Wm9bZENn/YRcN0Sb3abshwel1iBA6X7AiiHax81dwnxK4aokq
   XDkOfCl6alQ2u/PPpfpNY4sdzu8VNXukLS+p6NE5Q/KTSJchDMRn/dgVL
   siRhtih0da/ONBb3bx8dSO/aFViW2Fx3I5OQTDavPxK4jOmQ+vj8waSsk
   w==;
X-CSE-ConnectionGUID: yTNnc2V7RpKyeuXqrJXzOQ==
X-CSE-MsgGUID: 1TYm1Fe4QHSOHrWqRliIgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360871"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360871"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:56 -0700
X-CSE-ConnectionGUID: jJCYQMP3TEqVXwUVrpzIWw==
X-CSE-MsgGUID: s4JayflgQIie2Rdvhl0b/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165840"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next v2 04/15] wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg_collect
Date: Wed, 11 Jun 2025 22:26:23 +0300
Message-Id: <20250611222325.8158d15ec866.Ifa3e422c302397111f20a16da7509e6574bc19e3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Ensure descriptor is freed on error to avoid memory leak.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ea739ebe7cb0..95a732efce45 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3008,6 +3008,7 @@ int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_dump_desc *desc;
 	unsigned int delay = 0;
 	bool monitor_only = false;
+	int ret;
 
 	if (trigger) {
 		u16 occurrences = le16_to_cpu(trigger->occurrences) - 1;
@@ -3038,7 +3039,11 @@ int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 	desc->trig_desc.type = cpu_to_le32(trig);
 	memcpy(desc->trig_desc.data, str, len);
 
-	return iwl_fw_dbg_collect_desc(fwrt, desc, monitor_only, delay);
+	ret = iwl_fw_dbg_collect_desc(fwrt, desc, monitor_only, delay);
+	if (ret)
+		kfree(desc);
+
+	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_collect);
 
-- 
2.34.1


