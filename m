Return-Path: <linux-wireless+bounces-2722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C46AD84133E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578AB1F21264
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3554CB5B;
	Mon, 29 Jan 2024 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgFbrId2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466D3C46E
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556139; cv=none; b=YV50/TxBjCIKl7MW72kV8vVQyEYoFeCBGYcm6dcOID1YzmpvgBREhDU/cxZV6QNLEqRiAKV/y5uCMKMVH4yBncaFm+530elCfx+qYyH3zbx6qGZyYn8K8NA1oFpXpWASRyDXhIBLmDyoIIpFe2TeO5l4hL1OFRs0InMDtq1VqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556139; c=relaxed/simple;
	bh=2P18XZ1idB2abb9HeIkzStILMnV64Xj3wi//DtBxvlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwp5CNN8xcl46ZMLfsSUrC/+Yvyb8R/j9zna9h/A9EjrVYAb64DpCykWyAHFiGGMyy7u2ay364IKyx4ucztupXuKp47mOCYpQawFatCvw2ztG1UOJDY/1p2ADmx6tJo87j2HunKQBQwaQeI8R7SrwlNEmo5PhzG8WNhk50OJzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgFbrId2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556138; x=1738092138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2P18XZ1idB2abb9HeIkzStILMnV64Xj3wi//DtBxvlc=;
  b=YgFbrId2UynjuNYz8Wh/0f4NH8YE2e5V7NmdbwaU4OiZkG5X2NkYICq7
   fcwYH0MDaVlFOOeFMkGk0FfbuTPlMn0XuoTUXnCWWVjgTRuuPLWQA5ZQz
   j7eT7Yui2/BeDvVcyfJQzvkhCmoKyELMh9QLTrcgQo6hOS5Yol6INjPGk
   TCToc25/Lp3Nqt45SKmQ8KpiAXjgKsAg66vrDeteOnaJJ5LZuGBSj9wzK
   VuDv92g/xR9ZtA/hDkb6TAkD/Dd9sjdr4+saIYIXf4ExJzaMMLq7vgHAR
   BvCkwj/tFlrJ81UE7aJCj9sDJxLtIt5wSmzNz+s+KOOBkSDS8+nx01I29
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2942941"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2942941"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459040"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: fix EWRD table validity check
Date: Mon, 29 Jan 2024 21:21:49 +0200
Message-Id: <20240129211905.448ea2f40814.Iffd2aadf8e8693e6cb599bee0406a800a0c1e081@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

EWRD ACPI table contains up to 3 additional sar profiles.
According to the BIOS spec, the table contains a n_profile
variable indicating how many additional profiles exist in the
table.
Currently we check that n_profiles is not <= 0.
But according to the BIOS spec, 0 is a valid value,
and it can't be < 0 anyway because we receive that from ACPI as
an unsigned integer.

Fixes: 39c1a9728f93 ("iwlwifi: refactor the SAR tables from mvm to acpi")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index dd68d382d7de..9be91e6a9882 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -767,7 +767,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	 * from index 1, so the maximum value allowed here is
 	 * ACPI_SAR_PROFILES_NUM - 1.
 	 */
-	if (n_profiles <= 0 || n_profiles >= ACPI_SAR_PROFILE_NUM) {
+	if (n_profiles >= ACPI_SAR_PROFILE_NUM) {
 		ret = -EINVAL;
 		goto out_free;
 	}
-- 
2.34.1


