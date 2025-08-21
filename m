Return-Path: <linux-wireless+bounces-26541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9AB30176
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 19:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9349CA08265
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CF9341AAE;
	Thu, 21 Aug 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oz7lhNUe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B2341AD4
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798490; cv=none; b=udegsmm/yEmAFImVTXT850RCOrCFNNipaLT7QEVF+yGDTpg1x+9LnSvk+MwhNSlhTZL4sRVWoxkSGDBpeImyADZJmIvxyTnNKb0hNCWudIYRdpETot+12R5fpxLGgNbY3/+OB0KwYevzQ0YYwRBzYH1TwPlyUxxrtkhJI6ext+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798490; c=relaxed/simple;
	bh=60MIe90YO2J1AnPxOb3ycDAwOCRAzfrMK6Fh6ffV50Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9wTvCGGZnIUnZDda3In8tgD1JPJq5voRRAcj0WLb8dwvB8B/8UzHIbHRq1994lANtE2PahgmAlhGDxEp6gwXK01Sz99cd2XP0YDmQPxGUaMMlQ7lqK8kTAEXhS8xs4dqrbne9ULvCPxeo38y7/b8uDjaZOimbFsf9WsmXhfAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oz7lhNUe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755798489; x=1787334489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=60MIe90YO2J1AnPxOb3ycDAwOCRAzfrMK6Fh6ffV50Q=;
  b=Oz7lhNUegBzBV5rcR5lE8qEmVbEMKaDdmpRWLISPmfXxVTts8cBW2T0A
   HSdEVkVKXicgZ+iZJNJZWEi6mmxthUnlaZ+MINss+GqXTnrj3qzMWTs3Z
   KkxlKVkJX1XnPQtZeTvYNc+fd8DR6E00Vnmi2ABEZPuz/sTpA6n2LEjLJ
   7c1ti2JfRyqJeWSqYtTtGkdNfn5O1M+BrSctvZ6CZsgflpn7xKxjqiUET
   BU41mKr0hLmZBWPLUq5KpPpUxChvigtSMBsNoSg+PGIkL7PVY9Hu6Xu7e
   XgWu75aloqVoQqB5pZUE5uyqXAGrKv+YwmEYOx268Hvn7B7aPLQVfgj6F
   Q==;
X-CSE-ConnectionGUID: rJK6yHEiQmepVLrVb3e5mg==
X-CSE-MsgGUID: 0UvAC17ZRRK0PTN+Izi8JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68806093"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="68806093"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:09 -0700
X-CSE-ConnectionGUID: 3iBVY2uZSOiI5Bbfj8gZEA==
X-CSE-MsgGUID: kDcmRi9YSha6xJx5+wVOiQ==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 10:48:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 14/15] wifi: iwlwifi: mld: rename iwl_mld_set_key_rx_seq
Date: Thu, 21 Aug 2025 20:47:25 +0300
Message-Id: <20250821204455.ebf93a07905a.I8380b5cf9f6095b3a0b35fe4b7d56c544b921600@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
References: <20250821174726.2425334-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This function should only be used for group keys. For pairwise keys we
have iwl_mld_update_ptk_rx_seq. Make that clear from the name.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index db0c83a425fa..b27b874b3e84 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -679,8 +679,8 @@ iwl_mld_set_key_rx_seq_tids(struct ieee80211_key_conf *key,
 }
 
 static void
-iwl_mld_set_key_rx_seq(struct ieee80211_key_conf *key,
-		       struct iwl_mld_mcast_key_data *key_data)
+iwl_mld_update_mcast_rx_seq(struct ieee80211_key_conf *key,
+			    struct iwl_mld_mcast_key_data *key_data)
 {
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
@@ -768,7 +768,7 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 		}
 
 		status_idx = key->keyidx == wowlan_status->gtk[1].id;
-		iwl_mld_set_key_rx_seq(key, &wowlan_status->gtk[status_idx]);
+		iwl_mld_update_mcast_rx_seq(key, &wowlan_status->gtk[status_idx]);
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
@@ -776,11 +776,13 @@ iwl_mld_resume_keys_iter(struct ieee80211_hw *hw,
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 		if (key->keyidx == 4 || key->keyidx == 5) {
 			if (key->keyidx == wowlan_status->igtk.id)
-				iwl_mld_set_key_rx_seq(key, &wowlan_status->igtk);
+				iwl_mld_update_mcast_rx_seq(key,
+							    &wowlan_status->igtk);
 		}
 		if (key->keyidx == 6 || key->keyidx == 7) {
 			status_idx = key->keyidx == wowlan_status->bigtk[1].id;
-			iwl_mld_set_key_rx_seq(key, &wowlan_status->bigtk[status_idx]);
+			iwl_mld_update_mcast_rx_seq(key,
+						    &wowlan_status->bigtk[status_idx]);
 		}
 		break;
 	default:
@@ -807,7 +809,7 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 	if (IS_ERR(key_config))
 		return;
 
-	iwl_mld_set_key_rx_seq(key_config, key_data);
+	iwl_mld_update_mcast_rx_seq(key_config, key_data);
 
 	/* The FW holds only one igtk so we keep track of the valid one */
 	if (key_config->keyidx == 4 || key_config->keyidx == 5) {
-- 
2.34.1


