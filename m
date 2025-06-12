Return-Path: <linux-wireless+bounces-24060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE8BAD6F6E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C425D1BC4DCF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0FE229B0F;
	Thu, 12 Jun 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUJFxr6w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407723C51E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728965; cv=none; b=Ap4/TbSTRYCh4ROuP4FkVN/G9+OCPmxKMOiv0u0BrUVw1zIRmeTeK/JUCIfafwPQmjDUyhgItadWpXfUup7u0Md7qxxcLKE2qYJ7JJyLsLCYEXQpVXX/rSOFJ2yIToPr5bSm1xQq+mapzQwwNmktDV8It3bgkfKshovOzsJMiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728965; c=relaxed/simple;
	bh=yUJ6CK/r3WTHQshy7N2SWU4HmSYNEcw5QbtCNdGdjqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ugf9bHDihM6VUjiKcqi4XjONuJjNTTOGvH2rMGg8nTKMWQ8G+zZq1wwGeeedefi3RTf26ZzUF+HkNl2NhOykTOi0ToLUr/W54dmFGR39vfXg8LVvTz6Dry5KzmKh7sz6G5bT4eurqqV7kEdkNtcEcgxj7OhNI6DfQYnaDdbKJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUJFxr6w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728964; x=1781264964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUJ6CK/r3WTHQshy7N2SWU4HmSYNEcw5QbtCNdGdjqE=;
  b=hUJFxr6wBZrM/iSUwRuHRQ4eyLGrgxzcuyn/zKUfxs1sd8Tw91YiKx+D
   JGH3h9Gw60y5j8aO/4JXTHFQQeHVZ9f8Jz7v19R8tWkLumACnwHgsnY/h
   H/JcPQhbnJOrMyEuboQpgXfF4+ZBAt6UsWFyHpZeYpthhi7BiGmgTI4P1
   NE06jYRFSETFzDcSNPV83NjuMG/H35v1nlCqEEpeIMMiny1ejTaF2FBr9
   9N/NPHJpKyorTGns/X0eJMuM7tPeXITStTc+p3g+jxoAlN3fCqhsqwKju
   EZSKNGp4UxD5VGdI1lMhQfa8QVwQvV1RsnrysqoPXbq5gr9ikoQcneJyE
   w==;
X-CSE-ConnectionGUID: Brmv1n0RSy2ZFGPr3g7z8g==
X-CSE-MsgGUID: ko3bVNhiTsaBEEpwnmBvMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248332"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248332"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:24 -0700
X-CSE-ConnectionGUID: 7wqr9+VgTFqh4idh2qbZmQ==
X-CSE-MsgGUID: hPqo4YQPTn24QFPIY6ZmNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382124"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/13] wifi: iwlwifi: mld: advertise support for TTLM changes
Date: Thu, 12 Jun 2025 14:48:52 +0300
Message-Id: <20250612144708.3b0a4fd2c12b.I1fab7840f1cc222bd1e8cb58ac1a4177474fcd56@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
References: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The iwlmld driver is able to handle TTLM changes as long as all TIDs
have the same TID to Link Mapping. Add the corresponding code so that
mac80211 will accept and trigger the TTLM change.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 1eb4dfb83778..a8b2e2046d76 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2622,6 +2622,23 @@ static int iwl_mld_start_pmsr(struct ieee80211_hw *hw,
 	return iwl_mld_ftm_start(mld, vif, request);
 }
 
+static enum ieee80211_neg_ttlm_res
+iwl_mld_can_neg_ttlm(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		     struct ieee80211_neg_ttlm *neg_ttlm)
+{
+	u16 map;
+
+	/* Verify all TIDs are mapped to the same links set */
+	map = neg_ttlm->downlink[0];
+	for (int i = 0; i < IEEE80211_TTLM_NUM_TIDS; i++) {
+		if (neg_ttlm->downlink[i] != neg_ttlm->uplink[i] ||
+		    neg_ttlm->uplink[i] != map)
+			return NEG_TTLM_RES_REJECT;
+	}
+
+	return NEG_TTLM_RES_ACCEPT;
+}
+
 const struct ieee80211_ops iwl_mld_hw_ops = {
 	.tx = iwl_mld_mac80211_tx,
 	.start = iwl_mld_mac80211_start,
@@ -2691,4 +2708,5 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.prep_add_interface = iwl_mld_prep_add_interface,
 	.set_hw_timestamp = iwl_mld_set_hw_timestamp,
 	.start_pmsr = iwl_mld_start_pmsr,
+	.can_neg_ttlm = iwl_mld_can_neg_ttlm,
 };
-- 
2.34.1


