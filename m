Return-Path: <linux-wireless+bounces-25033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0CEAFDE8A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10CA189521C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99324226CE0;
	Wed,  9 Jul 2025 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKbdnT/V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B0223DD4
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032655; cv=none; b=NSQVO76gFWjMaxuSq8xvD/cwtU5l7DPUIOrpUYvJGzsKQFAclUzkCjp89rgeYTOrnV3do4xHzS6BE/NhMS804t/sm3CUr89cosGQ11DvhZgpWPDMxAIsT4dnMmlOGQeQkdzDYKqwFUehkgMQ/R24SgCP+2N9+FDGN07vdtSxZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032655; c=relaxed/simple;
	bh=t5T8s2a2NVYKJGpN4g6q3Ru0p7n81EmTmSk0JUEStTg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IT6J0ubbeTypg348VERnHsyOgWs3kFtTGxyhyEYVuUBnIBERoHSlSqaC/e2Z9Hb2wH5VSkMfKpPl6y/zfdIWp2wIEWYlAE0Yb9P21EQDNtFUlwXXJXsaAM0E6us2hshLRVO3g6wQGGyFEj7zWyGiwNGaqvzLAnLSlyQBwelzD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKbdnT/V; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032654; x=1783568654;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=t5T8s2a2NVYKJGpN4g6q3Ru0p7n81EmTmSk0JUEStTg=;
  b=VKbdnT/VkMd64b/k5uFRUoyHeN8yQzeXXiiinm0E2Brzf4xxEEHXPg91
   9gYzfVtX6Uhm9hAMl3NTCpE+I8Dyt/yehsHsSwFENlx3cFxjT5MG/57XZ
   zXG2Y58oARMPnRUZw/rpIWWmM3zvllODSD/vUL9fy/uAmiI/6zy1G3fcK
   xp4QGu29Fx7Jp3QYNJAI+y2U9pmnkG3NOX9fdZ/W4WIAY9H82H2dgy//r
   O25hm+kuqIG7opH0BoBw1uteA0AQwaVvbv+ToQg8OqxMXipNY2LyV9fbQ
   U/vBljvr45Wgb7r8RQtyuDEoJkDRmr1457QsIG+XqZQDX7cz8sTV5fThI
   w==;
X-CSE-ConnectionGUID: YP+mcJWHRkekcCd2Vts+Pw==
X-CSE-MsgGUID: iBnF3n2STr2NfQb6UW1NEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720664"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720664"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:13 -0700
X-CSE-ConnectionGUID: 6uAK39JMTXGOtij1xGX8+w==
X-CSE-MsgGUID: hLeYN/TAQcSjXhGnx3AOUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390573"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next v2 13/15] wifi: iwlwifi: mvm: remove unneeded argument
Date: Wed,  9 Jul 2025 06:43:37 +0300
Message-Id: <20250709063858.d48f073381f3.Iddf9a2b24546cb3a1506d68ca41ed215f88cff5c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
References: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
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


