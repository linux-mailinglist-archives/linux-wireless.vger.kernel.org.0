Return-Path: <linux-wireless+bounces-16870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540A19FDF47
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49013A18D4
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACF3195FEF;
	Sun, 29 Dec 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Obv9x58s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB333062
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483522; cv=none; b=OckAGc6WKI8ty0+WveV/rFp8TC1MoNFNr/U5NlU5LM2rahPY4gb6zr5GffUk9YWbtuRdDf8BjyvHGY8nIu72okqt+AZJdTuDPHHDldXwXrDZF4LIx+LcFNILsqQ48AUovKdoJ5NMIJXnKpLUKabQvIUcsvHVHpFuCsVXg6yUseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483522; c=relaxed/simple;
	bh=uKqlbpHUiUxla3RYXQ+fDOG9wrormS+g6kpW8WK1g8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOJmUEl/FfoGKmz47t1I7SRtC+0F31NYs0JjcoXtMmjM8GHGm1pdcMxH9XOcby1WlkPObfWjvkiLiqfTINoCYKCwzst7w/JaDLmcRHzn6Z9wLxKfZDDcIJ77QpRfBDeAKmoBIl70utZ+7ZfALhciMXbI/kITmjNClw8yDzeAol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Obv9x58s; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483521; x=1767019521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uKqlbpHUiUxla3RYXQ+fDOG9wrormS+g6kpW8WK1g8U=;
  b=Obv9x58sJ3rQn9OzwnQfv4Vzh++RXcw1u73f3D3+wko8AQaGSirAcc35
   A+BChKSY3/cglEhUdm+dzFwVj+VdIGZVqHL/JuTDY5jApKYsq7GFmojcd
   sWfdCaLQtVSthtr7KlCnZWj2uPbeZOGDQkXgx/ZLnhr70J9L/0Hfh7iQp
   4f398GWwvP+4AxVx8ZOVD2zMRkQqN5NdQx8t7ptG/JUqpahIpe35/WWER
   SfW+20BI7KilbI2gxe9jqU0YxVhkKyFuCvow6Q9cDp8TzaXqR3Imj1Dq8
   sE1AhQA78LCbhA0IUjeiddf+aWsNBZVtNPXusA2urMqYCuQVNY9afwO81
   g==;
X-CSE-ConnectionGUID: zwGl4xceRnGXi91RLQ7FtA==
X-CSE-MsgGUID: NvH7ZLUPQLGRj3lWCSgf0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572449"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572449"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:21 -0800
X-CSE-ConnectionGUID: 6PKHQ93PT9aUTrCQPVSKvg==
X-CSE-MsgGUID: NyIbmbVpRGujf0zvOl2Gyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656954"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 09/17] iwlwifi: mvm: Improve code style in pointer declarations
Date: Sun, 29 Dec 2024 16:44:44 +0200
Message-Id: <20241229164246.f09a200be4f8.Ia564ae1c59136bd3c2864ccfb3a244b3257dcd5f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Juan José Arboleda <soyjuanarbol@gmail.com>

The changes ensure that there is a space between the `u8` type and the
`*` character as preferred by the guidelines.

This change is purely stylistic and do not affect the functionality
of the code.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
Link: https://msgid.link/10b6d4945675cada713e819f7bd6782a66a1c0d2.1724103043.git.soyjuanarbol@gmail.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index bc363e8427e4..a386b315e52f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -567,7 +567,7 @@ struct iwl_power_vifs {
 	bool monitor_active;
 };
 
-static void iwl_mvm_power_disable_pm_iterator(void *_data, u8* mac,
+static void iwl_mvm_power_disable_pm_iterator(void *_data, u8 *mac,
 					      struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -575,7 +575,7 @@ static void iwl_mvm_power_disable_pm_iterator(void *_data, u8* mac,
 	mvmvif->pm_enabled = false;
 }
 
-static void iwl_mvm_power_ps_disabled_iterator(void *_data, u8* mac,
+static void iwl_mvm_power_ps_disabled_iterator(void *_data, u8 *mac,
 					       struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-- 
2.34.1


