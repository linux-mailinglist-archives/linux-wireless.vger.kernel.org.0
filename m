Return-Path: <linux-wireless+bounces-26672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1A0B37895
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 05:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCED6686761
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 03:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA87017597;
	Wed, 27 Aug 2025 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PsFdQa5y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCB1E86E
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265672; cv=none; b=WVS868VH4MJKt3JYZS/sjI0+2DoQSze9smSp3M1FT5lOLpN9K9mr4desuhrjGYLLJ+n1ygaUZKR/meKxQa1H7PBNftxDwqY4UhZCEpjrGS/wkvPBaeQGhnp9cjbYUUPMYdHbM0YA9py0R+tcKRalAdZNhcpqQfCuB1/iCn0/TzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265672; c=relaxed/simple;
	bh=TLfUZJWi41kVFyFTjIL1mPK8ICAg7Nb0GScTEEI4rp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qpR44qsCnZXvelzotS2PFh26tTVSTIuYO1F4wKZBVpgsWySGsR/kSuaJ0kpa6jwFSDSCzlw/wUgoKxuEPA/Gf9kiMgCGNVYk42pcgS84ACR+5VHuN+G7XU1sYGTA6aJjv6dIwOb+qgWDhIoaMnCTFdf97VPcb3SDM1exrxZ7j7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PsFdQa5y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756265670; x=1787801670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TLfUZJWi41kVFyFTjIL1mPK8ICAg7Nb0GScTEEI4rp4=;
  b=PsFdQa5yaMGKckqORiNoEX2nhpvde/EmukG6ACcyxHFVutjWhNdkpL2W
   wjBnzCkr1KcVzMSMXpFn9SiH4E9eZZ2AaaCBAd6h3ZKb5b+iNuU1SEOAX
   M1C1F/x3n9+IuTx/BSh3ROqQlHKDCFnrA5p23gcohhVJFK0E4IPMEPPVB
   y2OpdHLq6T62CFkXPCUhCdO7O+7SpfkKBAN/6cBMQeUzPfq2hOsZB2+vY
   dZNZ4olNJqYvMMfdtFrFeAyIVHUYVyGvMc2Op5zA/X/HwKySFU+OlWgIp
   yoPGZktHGVwTinUC709FaLb8kQXzUkOJtI08I0ha+JijOAQ07ymhmmV7O
   w==;
X-CSE-ConnectionGUID: PoJPW73/T7G9hrPfHwksGg==
X-CSE-MsgGUID: rw1h4LcdSK6NHheTXT6R9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69229550"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69229550"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:34:30 -0700
X-CSE-ConnectionGUID: ukqr/Z6fQwyCLILDxUXPmQ==
X-CSE-MsgGUID: sfEiOn4YSkuTYA+yqL02DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200631393"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:34:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 3/4] wifi: iwlwifi: uefi: check DSM item validity
Date: Wed, 27 Aug 2025 06:34:00 +0300
Message-Id: <20250827063332.59ec52ff865e.I9e11f497a029eb38f481b2c90c43c0935285216d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
References: <20250827063332.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The first array index is a bitmap indicating which of the
other values are valid. Check that bitmap before returning
a value.

Fixes: fc7214c3c986 ("wifi: iwlwifi: read DSM functions from UEFI")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220085
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 48126ec6b94b..99a17b9323e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -747,6 +747,12 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		goto out;
 	}
 
+	if (!(data->functions[DSM_FUNC_QUERY] & BIT(func))) {
+		IWL_DEBUG_RADIO(fwrt, "DSM func %d not in 0x%x\n",
+				func, data->functions[DSM_FUNC_QUERY]);
+		goto out;
+	}
+
 	*value = data->functions[func];
 
 	IWL_DEBUG_RADIO(fwrt,
-- 
2.34.1


