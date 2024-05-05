Return-Path: <linux-wireless+bounces-7186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C473F8BBF74
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80118281D40
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E6B65D;
	Sun,  5 May 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHUXS5zX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E343D8E
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890029; cv=none; b=vE+pWwHOTpfztHJN18u30RNRYVV8XR0bFw41ryzbzH6sFr73t970rqYiJJz+064Mjrdc+x16SyDLjVCp/RVMg/ULc0u8DZ2F8Bblt6fBtJ5/4exDzrC3lKghIUVTcWWwjmAzhcG/hm1rAtsRPME138mzYL2FUz+tBw3TWBHXv9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890029; c=relaxed/simple;
	bh=IpzZkqjNl3mS+lPxyhm6GOD8ZurtwivI7bPhR9dVVus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JT8/ZMbdkqw5mVkC79dN6X1aMRMs0wEmpMt1lYmSwTqy2tXILEpGLbrQgPXz9OgbTRIfPcHiqHCHqI9TJRHgZkft5xFfZ0so8x8pHZVuggfUUbP2aHpe19Km/1A9npxf2efKHXPDBQgTWAyMQzdIZE2AWm0LAgBym6s4RGflilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHUXS5zX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890028; x=1746426028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IpzZkqjNl3mS+lPxyhm6GOD8ZurtwivI7bPhR9dVVus=;
  b=IHUXS5zXHCpp8CGpOJujfUiRZnagKmc56oeLsSwXezx1TeiUFnUDxrdP
   vTMAvvKf1u1jFfj82KFW9qxXx/CcAWlB35KCIQoJTsRPJjPh27nkiSddn
   scQjElbdZrkZackC9TJWXB36GVM9BTgI+e5GroRYMFNDOPKIG5WNZq+Ii
   J2MPnH3EoVjCXoepdD1r4gshhEuDiTUq913vQjPWT7STLnV+e28fC0NTV
   PjipFeF38NHZoPyDP5zos2cgab4h7FlTAsN2eObxjgB3r6sCTxa2mufm9
   ywZ5RTZR5nHadyrBcO08SyWJLMNhX2qnx27zx3jJYZUFmHyI5OP/EdCwp
   A==;
X-CSE-ConnectionGUID: NmIQNgZYTv2qieWVxnpC6A==
X-CSE-MsgGUID: J7NETpWrQIuJFMNZ5w98NA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461821"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461821"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:27 -0700
X-CSE-ConnectionGUID: enVE9kuJRPyzrZlSyFEFug==
X-CSE-MsgGUID: 6MwLzZldQwaV/icVXonjwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903614"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: trigger link selection upon TTLM start/end
Date: Sun,  5 May 2024 09:19:52 +0300
Message-Id: <20240505091420.ed2b386566a8.I0168e61da86b2027633743aaf5d97e483991f0dc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When non default TTLM is applied, mac80211 may force us to use a specific
link (For example, if the only active link becomes a dormant link,
mac80211 will pick the first usable link and set it as active).
When default TTLM is applied, we have new usable links that we might want
to select. Therefore, trigger MLO scan and link selection upon change in
TTLM.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 305f194ae7b2..31669996ecce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -879,6 +879,11 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 		if (ret)
 			IWL_ERR(mvm, "failed to update power mode\n");
 	}
+
+	if (changes & (BSS_CHANGED_MLD_VALID_LINKS | BSS_CHANGED_MLD_TTLM) &&
+	    ieee80211_vif_is_mld(vif) && mvmvif->authorized)
+		wiphy_delayed_work_queue(mvm->hw->wiphy,
+					 &mvmvif->mlo_int_scan_wk, 0);
 }
 
 static void
-- 
2.34.1


