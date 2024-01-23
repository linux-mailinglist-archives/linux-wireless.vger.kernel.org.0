Return-Path: <linux-wireless+bounces-2406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C559839750
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8671C259A6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E1681AA3;
	Tue, 23 Jan 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJ0rKvaj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144381AA1
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033356; cv=none; b=H3OpLuz89JnHOFwst9cXwmfSEFcniy7K0YGW39BxJTRj6ChyQBjEeGgJbyXjnu8fWhRPuGNIISheRdkMm6utmBNvz6lLoSSWUM9ZEgfZHlYT0tf+9kdO1s9lvr/e+waPo6LyHlsre+5Aa2bL47ZMVlcvOdUCxclHOc+Ruab1/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033356; c=relaxed/simple;
	bh=N37T55mJBIIoiUUiqzhDSaUHfuTJKmVV3+BI70QjCJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M39EqqJexB1G9uCJhGfOF4sQPHOT4jmhEACsWaM9GmCCkmOrR9vdgi9Lu1HZXqEW/9b1TvRtb3pljcD8m1yNHtta1JWFir0o237OdCBeoZoIFAmXintbMjDVVHzJ3NoNrz4RMadC4wRZANu7gM4rCWRPM/Bfcqs5v9fUf8X9sS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJ0rKvaj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033355; x=1737569355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N37T55mJBIIoiUUiqzhDSaUHfuTJKmVV3+BI70QjCJ8=;
  b=JJ0rKvajk3J1c9dwrTYLz3dxcDsYH9dXNlLEaHRViaXeZaWENdz+6hWZ
   4GweesuZPuMLzLlTn46PndfXTFRaGSTSPj58Zpqwy4EqHzmIpOKV4wEEG
   GyXiIHuSHIYAcg8YsRBbDDPlY9V6/zIHF8QmukAYd4kHjfsrkuPh0eBLp
   9AvDP7u0U3POOOxeix7oParuQ5LS5Ob1WP4GtMOdm/TWs9rsvlUVkyI4Q
   Z3bYXY/EuBjL2gL/YkVqsGy2biVYZaB7eG1OD+bhEgqPLdumKycjZ70dU
   pRo8AKDA0/1j6ig3sT/bGK+SKk9IToFS1+4WyQpuasggNqIsW1Psn+DEV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501940"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501940"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666605"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: skip adding debugfs symlink for reconfig
Date: Tue, 23 Jan 2024 20:08:19 +0200
Message-Id: <20240123200528.314395eacda4.I5823e962c3c3674b942383733debd10b3fe903e2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The function to add an interface may be called without a previous
removal if the HW is being reconfigured. As such, only add the symlink
if the hardware is not being reconfigured due to a HW_RESTART.

Fixes: c36235acb34f ("wifi: iwlwifi: mvm: rework debugfs handling")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 6 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6bbcf4092f52..fbe65284f046 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1592,7 +1592,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	 */
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
-		iwl_mvm_vif_dbgfs_add_link(mvm, vif);
+		if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+			iwl_mvm_vif_dbgfs_add_link(mvm, vif);
 		ret = 0;
 		goto out;
 	}
@@ -1632,7 +1633,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 			iwl_mvm_chandef_get_primary_80(&vif->bss_conf.chandef);
 	}
 
-	iwl_mvm_vif_dbgfs_add_link(mvm, vif);
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		iwl_mvm_vif_dbgfs_add_link(mvm, vif);
 
 	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
 	    vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 61170173f917..1f36e934ef69 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -81,7 +81,8 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		ieee80211_hw_set(mvm->hw, RX_INCLUDES_FCS);
 	}
 
-	iwl_mvm_vif_dbgfs_add_link(mvm, vif);
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		iwl_mvm_vif_dbgfs_add_link(mvm, vif);
 
 	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
 	    vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
-- 
2.34.1


