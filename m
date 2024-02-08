Return-Path: <linux-wireless+bounces-3359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739D984E5CE
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 18:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136F01F283CC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B881204;
	Thu,  8 Feb 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8NldmCQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADBC82D8A
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411566; cv=none; b=LU7dqUnM4YmubP32uf9giINcFCSe6TZylKqMOwKE//P9VTsc++UkIYroex2ZCOdTtjJJoKM2KAKXtTaLZfmfGex2HLEM7MsCjtBpZswtA1JP77MUHBNK9yuqGr/U/6vu2QB644SITFgftV8AZ65vtXdRczqZFnEQI2u0mAVrVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411566; c=relaxed/simple;
	bh=ZKPVy1Acu4r2NEpTKqh2kZLP66M9LqixfVwCvki2TX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLnRtW9zqU4bZa89pDP77EEEW2NMxeCdFHxukRAiDe1ArTJ5e0FIQKEtlD9iwhhbdId6brqRI1fwTtfuvqLhW6vxlDbk6e20x+1WYcVFZmEqtx1VQZ9jPNY1NJYts+2W2pQThVoG6VmBLMX8SjanRqT6fYzkmZC/3LtFNaeO8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8NldmCQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411565; x=1738947565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZKPVy1Acu4r2NEpTKqh2kZLP66M9LqixfVwCvki2TX8=;
  b=L8NldmCQQTDbhslsQa/IENJdG1p6bjf40updspaPsJNuPiPw8mlfMD8d
   uEcGpOW803ANH5ul9k9T3mZwiNgJqKKf7tLifGKaRFdnXmSRiEUG3A22Y
   sRx1jsp3j1naff9cAl2Ef7/WE0bMl/XXcQ59s/RaQWb5HLvXUE7deW3a9
   stdvE9uS2tPC7EKIwekC6jlEZDrzx1OwnWDl6GePvBctaBolUoSgcImcJ
   BV1BsnbPxZcL6jMODjzYlXFHEGyrrfIgDnNNfBKCMb1SXUh71YXDvwuHg
   w/0x7AJH2tuvmjtA0AXKBo5AgiUQKroF42znFW+zQ6cpMQ8MCF8TPbAq0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1404036"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1404036"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318879"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/13] wifi: iwlwifi: mvm: check own capabilities for EMLSR
Date: Thu,  8 Feb 2024 18:58:47 +0200
Message-Id: <20240208185302.036443611696.If33caabd7cf372834287863b40b2d6d1ef1ca3f7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
References: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There may be different hardware or configurations supported,
so check for our own EMLSR capability before allowing it to
be used, in addition to checking the AP's.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index f818cf46b09c..63d6b68f6415 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1275,6 +1275,7 @@ static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int primary_link = iwl_mvm_mld_get_primary_link(mvm, vif,
 							desired_links);
+	const struct wiphy_iftype_ext_capab *ext_capa;
 	bool ret = true;
 	int link_id;
 
@@ -1284,6 +1285,12 @@ static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
 	if (!(vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP))
 		return false;
 
+	ext_capa = cfg80211_get_iftype_ext_capa(mvm->hw->wiphy,
+						ieee80211_vif_type_p2p(vif));
+	if (!ext_capa ||
+	    !(ext_capa->eml_capabilities & IEEE80211_EML_CAP_EMLSR_SUPP))
+		return false;
+
 	for_each_set_bit(link_id, &desired_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf =
 			link_conf_dereference_protected(vif, link_id);
-- 
2.34.1


