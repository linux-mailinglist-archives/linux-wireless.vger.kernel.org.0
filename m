Return-Path: <linux-wireless+bounces-25124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30979AFF2B1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809EA5C1A6D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685420458A;
	Wed,  9 Jul 2025 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cl/MVeYl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673A268C40
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091582; cv=none; b=J4l/IzN+QQO/p08wQgB8UkQHtEZbENEv4V+nlRuXfjUORAEjIGqAS++KSk8Nn5Iopq5CSYdVd2apU+7PEk19ghLHBJyF94LgFmt6XH0ZgxjC0zMq/uPrl2/S4Jq5SFCsJ+6mfADNaigWMbAeVSBtLUcyU1tqozC7PLGKKEGRom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091582; c=relaxed/simple;
	bh=da3/ol6P6+vji+GzSf9A+k1lBcxATEP3wM4qWtXRMIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bI9L2sDC1p3xFHjmCNjAPAYJ8gRj/GRrhLuoqnSg3sdLd7ynh2LzIj4bpP8OGEs7TnQ73fRAYGCXzkUbrPL+vCiHShQtPtV9VR0Em5tWZbUjkb9mRQbAxuJQD6Utt6x73Is0c08al/8Ow6J+tmSXT7q40r9fV8jBvT/hzx/RVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cl/MVeYl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091581; x=1783627581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=da3/ol6P6+vji+GzSf9A+k1lBcxATEP3wM4qWtXRMIE=;
  b=Cl/MVeYlHs9JDU9Os+N3ujkgFjV0U/wEZzFZkF4wp38+g3cWPigNhPFH
   6z9A0dV0tDHdpNP5mf5/VWXaTWSLL0+7j75tZXZYalD55i/84zyHgh9Xj
   hBrnHxL/Lb/B5EhT99eLEw+aLC2WBaB3g5Ik4UjKYPNOSmtPu0IRVzGis
   MQJ1AVTHevq/NqSDImr6hjfN/9Q8uYmknRqClGuiVhXPGehc1GVzUeBb2
   g6fXvpF+T4d5ZYMPejP2cjhq3cp1MqzqmF34Bw25AGn5RP2no/OkO8yKd
   M9lhGi5Y5/f8aqlMcHJlZCSilMFJX93AFF+1DYnp7LbGYNf9xwktxjBYo
   A==;
X-CSE-ConnectionGUID: F2cMKJe6ToyAdFdw6d6nug==
X-CSE-MsgGUID: s37Pp5UYRASfCGaNIktyow==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240333"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240333"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:21 -0700
X-CSE-ConnectionGUID: PEqQVofPSpaaicvZbyZjmw==
X-CSE-MsgGUID: /wBEsYDTSEOZ5ui7ttnk1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126100"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mvm: fix scan request validation
Date: Wed,  9 Jul 2025 23:05:43 +0300
Message-Id: <20250709230308.3fbc1f27871b.I7a8ee91f463c1a2d9d8561c8232e196885d02c43@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
References: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
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


