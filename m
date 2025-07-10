Return-Path: <linux-wireless+bounces-25205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F281B00B5B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8802E5A33C3
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C627F198;
	Thu, 10 Jul 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfZbISNS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7D2F4317
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172137; cv=none; b=RDVWfkgLY0T/plovtUt8ycubZ+RwjhkK21Ln/0kTCydUN4M2dUHH/m/NQwOZPuxyR4Eayqjnq81f1TOOvHWYCbtRIwv9X5PEaazhRK/pJ5+8iJmsgs9/eVuPN0Xqk1E+5iAX1PYZQn+os731lNA8nrZylapYi39kq3km8SfBwOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172137; c=relaxed/simple;
	bh=6y2zzFGdzpz2vwqtH0uISVpei0e6a9cecyoRhSlNKsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xl0m1jG2iLBHq4oYppnHJXP1K+SA7OFdKTxCDHSxhXyvR+H4DcLlGNcWQ6mrbO7uotuYWWdKfJ4Z02ZsfgHVqoiB8VNF9zUa7y3qe8TIqQHOMKLoA9H0whS34SCtpIj8Yqnvf651IXka042AJrLhn7/spdKyo8mBniduFZk5JOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfZbISNS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172136; x=1783708136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6y2zzFGdzpz2vwqtH0uISVpei0e6a9cecyoRhSlNKsU=;
  b=XfZbISNSSLboQkrxVWnUf4xmLjnOQlT7ee/w9i5k+yu6PJ+AH7TMJsSH
   nwJd2CZLBeGm+3wBoRI6IeeMtZ9R7y9s8+Ax4ZxLj0H5O6RTRP4MKSEmh
   qFxGtEgIdzQl7Ks7YLzGzAFHwS/2PygWEoJLR18MtgY0/MMz7L4S0AvaZ
   8cjRyO8DG4JT+fd7tPm2OKlqEr6ck/UeCVrH2Tw1rsTMni1TKgQReBKsp
   moANUycYzb3KeTQZTUakjEaNSu9BbAk3mscy7DT/d5KAcRUefQgr05i7E
   WMPF3PDu1YuLsTzhrGelh9RhBkM7Lgzdv5Xps63tVbsvS/xYMvmYb3Lg/
   g==;
X-CSE-ConnectionGUID: 9nUaBDwaQ6q33uu2eCrcoQ==
X-CSE-MsgGUID: JxcD+Ye0TdqLP/cNz3uSwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077789"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077789"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:55 -0700
X-CSE-ConnectionGUID: 6vYrF22eTN++CaUnV0hcyQ==
X-CSE-MsgGUID: +66NR9hNSKySg/waxlevVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718669"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: fix scan request validation
Date: Thu, 10 Jul 2025 21:28:18 +0300
Message-Id: <20250710212632.ec7d665f56a4.I416816b491fafa5d3efdf0a4be78356eedf2bd95@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
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
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 63d5d39bb083..479a76a94aa8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -359,7 +359,7 @@ iwl_mld_scan_fits(struct iwl_mld *mld, int n_ssids,
 		  struct ieee80211_scan_ies *ies, int n_channels)
 {
 	return ((n_ssids <= PROBE_OPTION_MAX) &&
-		(n_channels <= mld->fw->ucode_capa.n_scan_channels) &
+		(n_channels <= mld->fw->ucode_capa.n_scan_channels) &&
 		(ies->common_ie_len + ies->len[NL80211_BAND_2GHZ] +
 		 ies->len[NL80211_BAND_5GHZ] + ies->len[NL80211_BAND_6GHZ] <=
 		 iwl_mld_scan_max_template_size()));
-- 
2.34.1


