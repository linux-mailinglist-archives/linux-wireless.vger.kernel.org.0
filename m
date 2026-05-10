Return-Path: <linux-wireless+bounces-36175-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLb+KmvvAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36175-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA34506595
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55C5B300844A
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FDE336881;
	Sun, 10 May 2026 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NANyVIas"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84033D50F
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446152; cv=none; b=FdSIrTkQXs0LhSKTk40Ie3EuEKnCOMjFZ8UdxP0Xod9E9HNkwPhDCVWkBXw7Fy6v/5S+oiaT1hQfvMYW6FmX5WUCuXNyI0Bio6+kuGpY/oH9utFzQshxHoRBuMDfLoxjZe0OIcHBI1/E0U2YAvlv728D7q5HZbxdjqLWEzIrJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446152; c=relaxed/simple;
	bh=SzHQjcky3/OzCEOXo7r/x56WAEiGOSE/jGXChktiAmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCtZRWOoLngLs7Oz1RY5SVfjczbYoFySdrSJlibZwn+YR7jei3V5SFrY0h5j/GE5ODsFmzahGaD8zllOgsCj119ZAN2Z1LvCqlSWpCoK0S4ur8n0k6cZMpw4sPcOaUqhjYSMO5+uf9HUGQVRzJEN4EVjpczCUAsdyTnfOBjYql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NANyVIas; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446151; x=1809982151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SzHQjcky3/OzCEOXo7r/x56WAEiGOSE/jGXChktiAmI=;
  b=NANyVIas+8kUgTUSP9UlWA7EaQNVJzxTnKhlcX0qU6OGqIgDJXDjEddU
   rGD6i16LYwpqNtxjO5lxz1iWLsbHV6c3zrKpbBvNx+uQ2ehBO0GrfHnfi
   K2qQWw7Xq9kSqIuk5ZM06ACy0tsOpPQNtFDOXlvw6YKsJFAUfKvr3IZO4
   huatumvWp6nFoDpiRqDEWDyQ1KimGcPQu9V5uzWkJI2Z/pOPQB8UD+XGk
   4B0Sxea0ObxGbmWXc7I4cultl8a4zb1fDb37TI3KMfQiEPUw8d6IHar9S
   aJLIcWrjv7iH1KlNNCNFH+aVRWuUrKxmErra6ZS6m2zz86OmAPyptISlT
   g==;
X-CSE-ConnectionGUID: x+hcfqC7Rw6Mt5g7qNeq7A==
X-CSE-MsgGUID: rhEXPpefRNueBh+lJlz/Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904761"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904761"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:10 -0700
X-CSE-ConnectionGUID: 5ywlufhkRMGxjB9kARaiZg==
X-CSE-MsgGUID: gZYtTTDsQCaCkrZfBangyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095076"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 iwlwifi-next 13/15] wifi: iwlwifi: mld: Do not declare NAN support for Extended Key ID
Date: Sun, 10 May 2026 23:48:38 +0300
Message-Id: <20260510234534.42f0e92d0ee1.Ic3e47a926539a1d8f20103c40ebe5cfeaf671a96@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
References: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEA34506595
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36175-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Ilan Peer <ilan.peer@intel.com>

Do not declare support for Extended Key ID for NAN, as defined in section
7.4 in the WiFi Aware specification v4.0 (in order to support security
association upgrade).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index d5deb4a7fab4..cad10f011072 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -299,8 +299,6 @@ static void iwl_mld_hw_set_nan(struct iwl_mld *mld)
 
 	/* Maximal channel switch time is 4 msec */
 	hw->wiphy->nan_capa.max_channel_switch_time = 4;
-	hw->wiphy->nan_capa.dev_capabilities =
-		NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED;
 
 	hw->wiphy->nan_capa.phy.ht = mld->nvm_data->nan_phy_capa.ht;
 	hw->wiphy->nan_capa.phy.vht = mld->nvm_data->nan_phy_capa.vht;
-- 
2.34.1


