Return-Path: <linux-wireless+bounces-9885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6FD924FE2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 05:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA65F282E80
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 03:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B2318B09;
	Wed,  3 Jul 2024 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQx77Cev"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEFB18042
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978213; cv=none; b=ZI+swxr0OBG+2xta9AqIqrIN7p9Fn2sGzgqZkNcruwcT1w7XpjNvoNCxf6FscvEYWkS3NSCN/vVAr4A2NHRAhKYw8SGA9OXjoUFvn4ZFOcR8b5wytt7G36zJ8I2eKrgNsq9hV4kdyp4wO7PAuLe8W4enn7jfW9Ukkkelrk0Mm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978213; c=relaxed/simple;
	bh=rqP6/9BKyf61Qf4lRR4jvm0ThC7nbK3Dt5peDRM/3+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESj4Ehdn/RIpDyfIHjcVGMD51mJZtrQgtyb26LZdH2su2QGh4yxpRiPPgQLnzsrkZ2zcZ/gi6Icvs6K5BhOO1T0V+9NmRVM5N84W3knyjHuYeZdcDGU88m6glNOjHMbliMXQAV7XgpXvN9kLkzYnwOkw0dYXm9xM2+J60Ao3exU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQx77Cev; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719978212; x=1751514212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rqP6/9BKyf61Qf4lRR4jvm0ThC7nbK3Dt5peDRM/3+w=;
  b=mQx77CevcMjsKyRHnuX7gC6fZLQkjZBb4qMjNjh3GUwktFnoSQxHgPkH
   OfoUjwJaTkeRqg/a5BM32nnTPSGP3sgNBXkNnEb+YXiVP9ln4CuWNo5tE
   dSOjmIEau9y9XkXBQccZ3CGc+9hJ5xMimRiQ67B2m9sMyE+WQL+T/7ydt
   ONODEKn4vTfPX5h+511oUwCm/re4cxU9FmCjcRgs/4rh7uyhiXmKRoGBw
   dxwJ7AINkBV/BWq223/X+R8woIIT+J8FD6bZwd2dQ4CtTe3dpjFrbwMWH
   PldmFgeR5Rzob1UVDIybbhmfpK7wWuvOCtADcqOfvRI4P+9abiooip+2t
   Q==;
X-CSE-ConnectionGUID: aLxEnzemRxOAv7/BzDGIzA==
X-CSE-MsgGUID: xbX/74fFS5qrJ3cvGGSK7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17304043"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17304043"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:32 -0700
X-CSE-ConnectionGUID: gUVQenbqS/qoy+EcC/lgwg==
X-CSE-MsgGUID: 4gjIErzPSWOwZuq8koHgQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="51291066"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/5] wifi: iwlwifi: mvm: avoid NULL dereference
Date: Wed,  3 Jul 2024 06:43:15 +0300
Message-Id: <20240703064027.a661f8c65aac.I45cf09b01af8ee3d55828863958ead741ea43b7f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
References: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_mvm_get_bss_vif might return a NULL or ERR_PTR. Some of the callers
check only the NULL case, and some doesn't check at all.

Some of the callers even have a pointer to the mvmvif of the bss vif,
so we don't even need to call this function, and can simply get the vif
from mvmvif. Do it for those cases, and for the others - properly check
if IS_ERR_OR_NULL

Fixes: ec0d43d26f2c ("wifi: iwlwifi: mvm: Activate EMLSR based on traffic volume")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c       | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b1e6d4eee68d..678744a6fc6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1656,7 +1656,8 @@ static void iwl_mvm_prevent_esr_done_wk(struct wiphy *wiphy,
 	struct iwl_mvm_vif *mvmvif =
 		container_of(wk, struct iwl_mvm_vif, prevent_esr_done_wk.work);
 	struct iwl_mvm *mvm = mvmvif->mvm;
-	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
+	struct ieee80211_vif *vif =
+		container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
 
 	mutex_lock(&mvm->mutex);
 	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_PREVENTION);
@@ -1682,7 +1683,8 @@ static void iwl_mvm_unblock_esr_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
 	struct iwl_mvm_vif *mvmvif =
 		container_of(wk, struct iwl_mvm_vif, unblock_esr_tpt_wk);
 	struct iwl_mvm *mvm = mvmvif->mvm;
-	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
+	struct ieee80211_vif *vif =
+		container_of((void *)mvmvif, struct ieee80211_vif, drv_priv);
 
 	mutex_lock(&mvm->mutex);
 	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_TPT);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 53283d052e18..48671540f37a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -153,7 +153,7 @@ static void iwl_mvm_rx_esr_mode_notif(struct iwl_mvm *mvm,
 	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
 
 	/* FW recommendations is only for entering EMLSR */
-	if (!vif || iwl_mvm_vif_from_mac80211(vif)->esr_active)
+	if (IS_ERR_OR_NULL(vif) || iwl_mvm_vif_from_mac80211(vif)->esr_active)
 		return;
 
 	if (le32_to_cpu(notif->action) == ESR_RECOMMEND_ENTER)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 773cc2bdcb0b..6e933907f985 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -966,7 +966,7 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (!bss_vif)
+	if (IS_ERR_OR_NULL(bss_vif))
 		return;
 
 	mvmvif = iwl_mvm_vif_from_mac80211(bss_vif);
-- 
2.34.1


