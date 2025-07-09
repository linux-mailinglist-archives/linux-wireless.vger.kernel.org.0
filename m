Return-Path: <linux-wireless+bounces-25053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C1AFDF01
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2BF4E4EBD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EC926A1AF;
	Wed,  9 Jul 2025 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+V3NwNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF626B747
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037364; cv=none; b=tmKSG6RiYK5A8nZ805eagpFkqBGKTcpUfd8fi9j8tJl4JEnmRuVcSUFgd9edB5+PniNTquY+XmRTFaTrDx39wOhat2xG2228vYdoevP0Rhib16iLxyFlWqKzxRkmF7RplM82B5DlW1trLdVjL0eD9h5YzTgy05w0E9kGgBymsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037364; c=relaxed/simple;
	bh=da3/ol6P6+vji+GzSf9A+k1lBcxATEP3wM4qWtXRMIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hUcqeFZiNnTY8Ffr+AWccI30fNwkq9vg71MeBEwUPnxVzj3vy+2JHxEls3Cint+wK0DWaS4CZZ7Wut9lOSLZmE4Ec47gvk7mJcUDC3SrWr9dNFpn4zyqwZ5+HDrvd7X2wCsfSt3fE7k8mVzGZgeX4lo2q4U5fZsRf4run3XtzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+V3NwNl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037362; x=1783573362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=da3/ol6P6+vji+GzSf9A+k1lBcxATEP3wM4qWtXRMIE=;
  b=O+V3NwNlnVabPbsfsjoOysfzVAjdZhDxNUuHVOhZvaqQKucluffkV4mf
   B6ACqTJ9CbtXKHhG9bzTD3JdRsfNUa72J84bTO3z+vhLRIN7NWdPscPNF
   Bbk/DRiP9DPQeTYqVYT9/kp4R4mTjpTZvvtmFMPtY8S/hZ65Nc0zKOlPq
   kOYOCZlbA9W5v7TFvm5KhhPHWNmxf/2+l0et3CePUBKNBNu0oRUNJfGYu
   tBu79DxXj/X5sxaw+eCV1uyjGUAFbxgg0iKIJCVvDB+6+ZO4diO+j3fW0
   08dJdx3XMhoi8Me8Uch0FY9j3SKjfbIuC1uBBinPW6gGbF4DvImccKTWt
   w==;
X-CSE-ConnectionGUID: Mup71IsASRu04XWg6C3ltA==
X-CSE-MsgGUID: ZyuOSeWaROicpKivOzhLxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501537"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501537"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:42 -0700
X-CSE-ConnectionGUID: HjwYSeksSHOTBRDNtTZ44g==
X-CSE-MsgGUID: UAKgGsO6TH2K60V9mq+mtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859280"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mvm: fix scan request validation
Date: Wed,  9 Jul 2025 08:01:59 +0300
Message-Id: <20250709075928.0aa4f690ee52.I7a8ee91f463c1a2d9d8561c8232e196885d02c43@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
References: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

The scan request validation function uses bitwise and instead
of logical and. Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 5f30109ca18f..79660138ae97 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -836,7 +836,7 @@ static inline bool iwl_mvm_scan_fits(struct iwl_mvm *mvm, int n_ssids,
 				     int n_channels)
 {
 	return ((n_ssids <= PROBE_OPTION_MAX) &&
-		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &
+		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &&
 		(ies->common_ie_len +
 		 ies->len[NL80211_BAND_2GHZ] + ies->len[NL80211_BAND_5GHZ] +
 		 ies->len[NL80211_BAND_6GHZ] <=
-- 
2.34.1


