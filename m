Return-Path: <linux-wireless+bounces-24990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC0AFD79A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE1A16BC79
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1996E2417C8;
	Tue,  8 Jul 2025 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZDH4fio"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC80241669
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004292; cv=none; b=UN4WnuIJxpqJFW+WBKZ3qmDGsW3qmBnhs9D/8BHpWXujF5MC8woq0vtWPY/mxYkEpoZqb2+ZZzjkBeeNisL7nMsKhbjrC+UqLlmiTCUMfsWM32JiuJhx2Ym1i7miUkTelIKcAsNYx2WhratKbvqRdyyQQdooCoVdd3ni6sJF5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004292; c=relaxed/simple;
	bh=t5T8s2a2NVYKJGpN4g6q3Ru0p7n81EmTmSk0JUEStTg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+TziXC8LfYrIl/P+BFbWj90zf3G/xFa3K+42nGoz4LVB3BKolgTX8WzlHBz6FcUzBatk5oQ5Vhg1b3Z4xRj1R96ShZ/md4w4pkEZxDZzwOdhhMmPhpLGXpPNPW27BFLou1L29zkd6LBMJtli2DJbc84EN1x5PNKcKrhJw6UzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZDH4fio; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004290; x=1783540290;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=t5T8s2a2NVYKJGpN4g6q3Ru0p7n81EmTmSk0JUEStTg=;
  b=HZDH4fio9M4o4KPRHYT6BTEKk0aZo3rAFhbimFp0BlA/ofFj7+DliVev
   I9X5P7PxWnNSBwyCTunV6xraMzz8fEoLW0OtARznMGOLByW4ixb6PCj7l
   1QmimZRb0aPrM9fjHVbXfjKF9rkPaewmQkAehseim6gsH7N0qUim5n7UY
   zSREwURR/ratUTKNQOxAVyaH5131MkBGRIdNnpnvj1ffAZNeGJEXjbeO4
   LJ3AtIrJoo/+C4uSCNwbl0vxeLFSC7Bxs5HWyC95t/FiT0x0VehfTcG7C
   BiO/acLuC96/fMolAId2GnDIdBXMKB0cYdk3rYONRxlLUBeLuvRhp4jTd
   A==;
X-CSE-ConnectionGUID: Fm/EN3zqTXam2XfrCwlv4A==
X-CSE-MsgGUID: kjHxuCq1Tr6Y3/4yUXzQ2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54229730"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54229730"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:30 -0700
X-CSE-ConnectionGUID: I6dKfW8zRH+FwK6TlpKrEg==
X-CSE-MsgGUID: 87Lle3HYSNqE8eXqdts8ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155668992"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mvm: remove unneeded argument
Date: Tue,  8 Jul 2025 22:50:51 +0300
Message-Id: <20250708224652.9abf13e6e6ef.Iddf9a2b24546cb3a1506d68ca41ed215f88cff5c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
References: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
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


