Return-Path: <linux-wireless+bounces-3113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229E9849101
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB77E1F22B14
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C9140BE4;
	Sun,  4 Feb 2024 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhY2jJcR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A5405DE
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084418; cv=none; b=IyvkugnDBAgkW5dTPnJpzVXh0/bQYqXPwwdrnKiQc5UL//xC6gSMkiEOWzZW4UNOVq3lzdRg9YUq3IsCHfTbRm8gdyOJueDfNF1/S5QuedcVYr2Zj12FS1rkrxQcKijopwhHMJSO3GxQKMsSyp1/lbyvu0zO4ziv5imM6boJKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084418; c=relaxed/simple;
	bh=UJHOdjgKS0zRo9VDXtrvWArJBGvfAzirM7XVlgi2mG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlmewbwQ5kIuCIOcZBzOdpKQBm+YSr6z+HTDLZUsVYcSf3CIKLPwBTEqwqx9AAVbk00KmdQxjYsLxpr6DNWN3dSM75wzRwPwGjH2NuZ5w4gLxQBA5Ig8D1dwKXVGgNFjqT+7mmcBU6DsjBgPhi1CS8450cOmdiCKVHMtti/32eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhY2jJcR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084417; x=1738620417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJHOdjgKS0zRo9VDXtrvWArJBGvfAzirM7XVlgi2mG0=;
  b=YhY2jJcRvNQR7xVrbNQn2zGG0SiECZ5O/DuhnvAmCoyLQDnlzoVhR2OD
   dltD27KeZEFMVO5t5IlpTZjJHZ82RPtAQi27533lcxQOrz1eMyI7q74EG
   cpWGYZlkUiK4nDKKY+OvUEnGHTTYxgRog44K1lyELUBrtb0brug15dUwf
   AtNl0quu6MVW/cSOf/u6StJDHK5d8/70zbYQs5NvWTVgJYoeOyi6ZmF0a
   N+yUS5HKgQrpEveU27xX7EDvAxPOwavwsKpIkFQ1/Z173N584aZL/8Z+F
   j8thttBEJt3QBGkdo/beXNN0s1kuSqNDsXR9lljjgQ68qigiQzQLcmmQN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869392"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869392"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815905"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>,
	Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 12/15] iwlwifi: mvm: advertise support for protected ranging negotiation
Date: Mon,  5 Feb 2024 00:06:14 +0200
Message-Id: <20240204235836.608a307e4dd0.I578af1c9836e91069ce318b265bd221f42955992@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Advertise support for protected ranging negotiation if the firmware
supports it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index bc8d1760f36c..e62fcfd1a65f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -705,6 +705,13 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		}
 	}
 
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(LOCATION_GROUP,
+						   TOF_RANGE_REQ_CMD),
+				  IWL_FW_CMD_VER_UNKNOWN) >= 11) {
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_PROT_RANGE_NEGO_AND_MEASURE);
+	}
+
 	mvm->rts_threshold = IEEE80211_MAX_RTS_THRESHOLD;
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1


