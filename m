Return-Path: <linux-wireless+bounces-20277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2872A5E749
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224AB3B463C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6002E1EF0AD;
	Wed, 12 Mar 2025 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdURpCnj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D701F0E5C
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818190; cv=none; b=OzMVoHcMd296ARxRvux7xJ/KQz0lWpBXrxsXQFW48h6Qxik8lNoRGtN/u1trSek0DIO0E7Vj9EiJF/p5sSKU5yY+Z15J7Nkye1sCmeBhQa6xpTmrCKd4XX8Uik28swx4Q6vTBEChSTKKz6BSbQjrkrPfQEcxMXpNQwYWSDERnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818190; c=relaxed/simple;
	bh=T+SN5v1bTJW6yNVjHYotiT84weZpKqcq1iyVKIgCeC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+hR5w9S8FsYROj779lLIk/uQgb0v3FxIlymjPNKw4hpfovzTICl5vpLguuFowVtT0p2thaWjLFbhyP0c27dMMnnGvJa7XtA2GEE+ELhUnxyahES2XADuJXC67wrReLeFi36Blgj0vaaCnqH3fcbWIG9JMBwwWUXo9QShBxM+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdURpCnj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818189; x=1773354189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T+SN5v1bTJW6yNVjHYotiT84weZpKqcq1iyVKIgCeC0=;
  b=LdURpCnjBq7a4rxPtbTS9f3ETCudtnOQhVdJWsrVMdGdkHoMg1r/sc7W
   DgrTuY+apxO21kjJdQCKzfd7Wau//OTvoYw9Jv0/6C2EOCIyHTSm7mBhY
   PhAJbzQFRmJ8DW9JN6ySOigC+FJFw1vYYbzYBrVYrcApxipbZjc0PwJNs
   hP9mbS5cDN4pFSi6N6SKkAhGWbH8vpn+/IDvhX5P67QRe2JKduAVhbZKB
   Ib6E8Qyvqupszp4JPYKEpyCdx430xbLLqfMTUIsqFiopMocjXNUWDJaKm
   gkcoV698lTh9xulZXIeGJs6DYt5BXqQHr0i1uFemYqInWd7j+ehNyu1QK
   Q==;
X-CSE-ConnectionGUID: mnaCbo8yTqOc01PSeh/Zxw==
X-CSE-MsgGUID: vkx6jW+YTD2Ck2PCvOxIlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826760"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:09 -0700
X-CSE-ConnectionGUID: SE3YwXIASiOVyaAHjJ7G9w==
X-CSE-MsgGUID: ISnGkQ3LQo2n3st7ko3bNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267401"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 12/15] wifi: iwlwifi: mld: fix copy/paste error
Date: Thu, 13 Mar 2025 00:22:35 +0200
Message-Id: <20250313002008.aabb2232f9dd.I7cb24458a747e8363df2bf1ff848db6a9d472f60@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_mld_emlsr_tmp_non_bss_done_wk used the wrong work name
(prevent_done_wk) to extract the mld_vif pointer,
so the pointer was a wrong one, leading to a page fault.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index dac72644ec78..0f24c2e862c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -99,7 +99,7 @@ void iwl_mld_emlsr_tmp_non_bss_done_wk(struct wiphy *wiphy,
 				       struct wiphy_work *wk)
 {
 	struct iwl_mld_vif *mld_vif = container_of(wk, struct iwl_mld_vif,
-						   emlsr.prevent_done_wk.work);
+						   emlsr.tmp_non_bss_done_wk.work);
 	struct ieee80211_vif *vif =
 		container_of((void *)mld_vif, struct ieee80211_vif, drv_priv);
 
-- 
2.34.1


