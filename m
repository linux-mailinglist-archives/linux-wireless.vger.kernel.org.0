Return-Path: <linux-wireless+bounces-20059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236EDA57E86
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05AF189267D
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81E120E318;
	Sat,  8 Mar 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bj7/Qf9u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B41D1F5848
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468799; cv=none; b=uyy5bdmPGuaOoM1WWyOigqGeZdgT2pAEI7lrBELV5Ag9Tmj3EqfRIPEr+oM7m/KS1KDz1E4wFIZ6eUU5djFv3FBs5rGYlXwYK6uIioyfUXtKYyoeX7F7bxHZfwT+HBGnjvO4DN0N5m1J7uZJAiNTKHMnQDK28n/vQ+UxX793qAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468799; c=relaxed/simple;
	bh=Fs0s/aimuoS/iHurGf8VxnMtc9mb6hXdFm4hTzV0Yuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTpGpFp42G/Nc5S39GxoE7s/QM94av3r0lizGZwuZgFlVc6UWcrHCPxScmjaL06HmLkxoXg8Fdjj6X15aR8yoiCvVLmsj0Rx3I2BA1t5aLlgLP8U3kdRqRF/8GYZyJM3Vt/w32vTWfLejFKnSNnR0BqzwKK1l/1oF3uzboK9JRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bj7/Qf9u; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468798; x=1773004798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fs0s/aimuoS/iHurGf8VxnMtc9mb6hXdFm4hTzV0Yuw=;
  b=Bj7/Qf9uTMMFNemee4LDIZxlaBnFAAuJ8TISyJfIvSPFAUbL2Hhv8amF
   NBMEurBWJjjbn2FfNI5N3W6VS93cY16xrcqmE2V9K+AcyiajD+OUSe1Jk
   D4k6xcKWtNI0jcCty7qZjoQF4HLIn+DB8L6ohqz3d71KYJDTQFX9cuNKX
   2IUJFeOroHypxof4ac+vaU7fUEDREJsabaaJN/yCjrFXII69x+DXos9kc
   PChKzsBLJtT/Mq/KGTkECngo9SSgi8t3vXb95hWZxWuZ/4TClfbmdfn2D
   Sjek6AUsKqRwDfYtqZSjWFpJLnetodJBuu1qV24fGleInZKa8O9vWOx/4
   Q==;
X-CSE-ConnectionGUID: cg03DT/RTJ6oJgKcyRYogw==
X-CSE-MsgGUID: uTHlpCU5SUKZGgKRO3tV2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052391"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052391"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:58 -0800
X-CSE-ConnectionGUID: PVrITE/2Tm+trrH6xYR5nA==
X-CSE-MsgGUID: 7J5fg2RuTMumCIZeZelAWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859981"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH v3 wireless-next 14/14] wifi: iwlwifi: mvm: fix setting the TK when associated
Date: Sat,  8 Mar 2025 23:19:25 +0200
Message-Id: <20250308231427.603dc31579d9.Icd19d797e56483c08dd22c55b96fee481c4d2f3d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

When running secured ranging and the initiator is associated with
the responder, the TK was not set in the range request command.
Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index dfb25b964f0e..a493ef6bedc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -672,7 +672,11 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 			target.bssid = bssid;
 			target.cipher = cipher;
+			target.tk = NULL;
 			ieee80211_iter_keys(mvm->hw, vif, iter, &target);
+
+			if (!WARN_ON(!target.tk))
+				memcpy(tk, target.tk, TK_11AZ_LEN);
 		} else {
 			memcpy(tk, entry->tk, sizeof(entry->tk));
 		}
-- 
2.34.1


