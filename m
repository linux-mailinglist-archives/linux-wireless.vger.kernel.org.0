Return-Path: <linux-wireless+bounces-4891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1863587F91A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE37EB224FE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43177D090;
	Tue, 19 Mar 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayj275J6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E737D081
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835866; cv=none; b=sQz6LnVZdc4CBAvNQZ18ejeLu1bEHBtIjLnfdZZ0jtgq2B0hmsvMjIoQx+hNmGYmLhqqo+XFfMC/a8U1QhAtViiAF0BehCoFTkUIlZnk/rPetQ/qe9+krnOnQ7F+oZvSyCZAdu4nnThvuR7wlGVs80dSTbdfi+yMH4WIkkaE6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835866; c=relaxed/simple;
	bh=fonq+4R7t6PzYWcZweyMLnjiLXPkjAWWOEbloKVVlC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRH51jsjgaLVW8yhUJVaAsWclv2xJRDZA6/umP2TsIh2u7km6KRdHgp7EIxPDcgyb+pKqKRHqiaY92eJXi84f/FUTEkyhPfXOkTSRhiPesO3KuaIXyufFUzGAOuSU/6yX0alVJeqdcIUfg9JExtvwI2dSBFRKjCvz7O5r4LQzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayj275J6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835865; x=1742371865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fonq+4R7t6PzYWcZweyMLnjiLXPkjAWWOEbloKVVlC8=;
  b=ayj275J6tQ2ApaYgswj1h19oXDCIPSsOvIEPiwY/UoK9Anp5uR03CE7q
   BFhAQ7g5RTNrtXYmCMYNf9pETHFTy3arrMR/QK+7FKK0ZjmoMS1P0GN7j
   b9oiw6QRAWFMN1+7cBQOwk8jZ3eq2ehiEvGCsGw2M6xXQzojexER3+2wk
   0pV/XDtu8bHiKUs9eOWOoqczeWa2s131iKU0EM8p+KnJkLYhyYLU9KcIk
   kATNPkesJNU7rlZrDPOUeibqoWEzci4+7HTtPqo68UwGabcTmfionGnuf
   SthMhghNjWR6pizF+QbO4iBojzG/onqYs5+yi2IEsCI6OfZXLZL24ufP6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810577"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810577"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447649"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: don't support puncturing in 5 GHz
Date: Tue, 19 Mar 2024 10:10:23 +0200
Message-Id: <20240319100755.f61448c4a43a.Ib740b341af0ca6c3e06cc9a0b04447a6635df7a8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is simply not supported, so set the flag for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 01843a1c9c24..964871f31c73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -723,6 +723,8 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 	mvm->rts_threshold = IEEE80211_MAX_RTS_THRESHOLD;
 
+	ieee80211_hw_set(hw, DISALLOW_PUNCTURING_5GHZ);
+
 #ifdef CONFIG_PM_SLEEP
 	if ((unified || mvm->fw->img[IWL_UCODE_WOWLAN].num_sec) &&
 	    mvm->trans->ops->d3_suspend &&
-- 
2.34.1


