Return-Path: <linux-wireless+bounces-25067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23498AFDF27
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2AE4E69A4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB18A26AAB2;
	Wed,  9 Jul 2025 05:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awnt1j/G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF426B756
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038234; cv=none; b=kwr+KcP0G0X430Z3WZL5oyVmWiLCCWhAqBwOVPoo2oli3tMjZHUKBCMUOi4Z/KY3qiB8x11M+ygScU4lTNKluKP5SX1Mx4B593A2y2txGXfR9uWnNCuhpCkdV2Rc1w+2T7yFCry5YtUfJl7oKgjt5ot2qO4qVY8YP5emLfDzzjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038234; c=relaxed/simple;
	bh=t5T8s2a2NVYKJGpN4g6q3Ru0p7n81EmTmSk0JUEStTg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqPUsviZ+wlzkabMGe7reF7CLyXloHlL88VgRMTqHMp3EtlbqHGLIosTO+QI61dJYhS/EJ4f90IBcmPrMPDGRRLxYcgitHjuksiXkxe+Jy1uP1ApJjeGIV97ra6dC88BCLdnZ94ys4WNBt+rYZtsJwxtT+/MPtoruw53ruEHAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awnt1j/G; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038234; x=1783574234;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=t5T8s2a2NVYKJGpN4g6q3Ru0p7n81EmTmSk0JUEStTg=;
  b=awnt1j/Gc9Ft6oDh2xVtixDphDjjzRKWgHX1Vgbf1sIS/yB1YXNo9A8U
   6UyX+pOqoQbBht8QYAZt40U6Lw4Nw1qIl1v61fQACrJE5bafAOughXBmE
   BusNOTluhWhFCtKp9NPiUO+VzHpQFpBQgJ6dfebCVTJ18VyaLjgqZZckf
   v1jV1Wg/1JMT4ztvas99Okg+1u1cVmsw60lc2mwwqFRXEn/TdmF0o95N1
   yFReF0faTKim0fZXQ0+vIsrpOyhXotpvv1zrxhXg5Cw1KfqLCUcakFyDC
   zCK7iqQi5hCarh7hNuCCsAEDvaTzrVheeHKMx7KEX2UQytT7l9Kp5QJRR
   Q==;
X-CSE-ConnectionGUID: PP9IFjftQqq9xbRqT90qWA==
X-CSE-MsgGUID: g6KTVeADRPmwYNG4p5l+9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091180"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091180"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:13 -0700
X-CSE-ConnectionGUID: PuyDAi+kRrql3DuteGE9Yg==
X-CSE-MsgGUID: KRe7DwkUT/S+6d4ndOkBnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327893"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next v3 13/15] wifi: iwlwifi: mvm: remove unneeded argument
Date: Wed,  9 Jul 2025 08:16:32 +0300
Message-Id: <20250709081300.2586112afd70.Iddf9a2b24546cb3a1506d68ca41ed215f88cff5c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
References: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_mvm_set_key_rx_seq is called only once when the installed argument
is false. Remove this argument.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 1af9e54a882d..7f0b2089ab8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1787,8 +1787,7 @@ static void iwl_mvm_set_key_rx_seq_idx(struct ieee80211_key_conf *key,
 }
 
 static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
-				   struct iwl_wowlan_status_data *status,
-				   bool installed)
+				   struct iwl_wowlan_status_data *status)
 {
 	int i;
 
@@ -1812,7 +1811,7 @@ static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
 
 		/* handle the case where we didn't, last key only */
 		if (status->gtk_seq[i].key_id == -1 &&
-		    (!status->num_of_gtk_rekeys || installed))
+		    (!status->num_of_gtk_rekeys))
 			iwl_mvm_set_key_rx_seq_idx(key, status, i);
 	}
 }
@@ -1963,7 +1962,7 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 		     (status->gtk[1].len && keyidx == status->gtk[1].id))) {
 			ieee80211_remove_key(key);
 		} else {
-			iwl_mvm_set_key_rx_seq(key, data->status, false);
+			iwl_mvm_set_key_rx_seq(key, data->status);
 		}
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-- 
2.34.1


