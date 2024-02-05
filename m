Return-Path: <linux-wireless+bounces-3175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1867884A6DD
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB111C2687A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6504759B5C;
	Mon,  5 Feb 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5wpaOeI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9459B67
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160928; cv=none; b=ShZCB0mFm5AIGaNOcS4yUXAbMM4BnEAOlrXJ6A030rbWu52BIMa64CjXEWc+ITo0yBAVCX0J9eGsq1Ow9I+oUaNEGf4kUeIk5PZuRJiE9nMUxb7yZeOuQCGH2UHiDLDc4/uPkcZ8IfA0aMICEIkb+HpLwbZBNv7iYmhO/kRAteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160928; c=relaxed/simple;
	bh=iwA7SCrHkJ7/NzFPcE1mPBoCSZAZSRJKOT0EqQRURIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjZP8ycVAbTwmWayzAvhJ/J7bmH3vg7rpvi8GeDbmEYFbaN0e7CtA8We1p/9TFELF3ITvXQo5X+TUPqFQvipWbkQPVSOn+UhbQVQznuNSwpcjJ8W8o7/ID9GqD2Pen679FlxmqPBDs4abt0TANRpp3uf5B2K5oszs3Hmh3YfiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5wpaOeI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160926; x=1738696926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwA7SCrHkJ7/NzFPcE1mPBoCSZAZSRJKOT0EqQRURIE=;
  b=l5wpaOeINpC6P34gEcnPN4xeiPlEE0uM6n5EtTPKnlhezbw2Rdmx2KIQ
   G5S2ilXl+9UTEw3ZueQ1BaoVBmsQ2dZwf6SerKCEL/SBraF5wU3QooQ0y
   vDI0m7yxi0tU7xf82toEpbG1fMA4G9mVfdLqbh/4PTJFUicIOoHgwbade
   Ca33SmV9ZVNmeMD7RayP77Zs5cOy+QFkrrODvHx20CqsfQHiQvJbYQt6H
   iQ5W+fOuZLT0kaBOOEwsP48eCt9waFBmzjvLLcTTOGpuk7x6AJOCRly6e
   T+MpzqSeddcszINhQl4a7H22IXmDQJwTjaljYkKmLv42PdPgsCxK/2edk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381654"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381654"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403185"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: always update keys in D3 exit
Date: Mon,  5 Feb 2024 21:21:12 +0200
Message-Id: <20240205211151.68cf3974b5d7.Iac9b71a1906ab973aba9baadc9e923b63c0b4945@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

If during D3 there was both a GTK rekey and a
disconnection, when waking up, we must first
update the new keys and then disconnect.

The reason is that when disconnecting we first need
to remove the keys.
Trying to remove invalid keys results in firmware
assert.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index af449cb9f967..89030647e639 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2100,7 +2100,6 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 		.status = status,
 	};
 	int i;
-
 	u32 disconnection_reasons =
 		IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_MISSED_BEACON |
 		IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_DEAUTH;
@@ -2108,9 +2107,6 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 	if (!status || !vif->bss_conf.bssid)
 		return false;
 
-	if (status->wakeup_reasons & disconnection_reasons)
-		return false;
-
 	if (iwl_mvm_lookup_wowlan_status_ver(mvm) > 6 ||
 	    iwl_fw_lookup_notif_ver(mvm->fw, PROT_OFFLOAD_GROUP,
 				    WOWLAN_INFO_NOTIFICATION,
@@ -2171,6 +2167,9 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 		mvmvif->seqno = status->non_qos_seq_ctr + 0x10;
 	}
 
+	if (status->wakeup_reasons & disconnection_reasons)
+		return false;
+
 	return true;
 }
 
-- 
2.34.1


