Return-Path: <linux-wireless+bounces-2953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CBB8459F6
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D2B287446
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB475D47C;
	Thu,  1 Feb 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYfx6qO8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6515D498
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797194; cv=none; b=KokjssRg6XwE0D2OQ8natHP4PMFO2xvkmX98ByGrIFZBQ6EUzuhRM4wrrge7B6HWv8vwQswzPXQyjP4HISKZ6omiV5RXnPi4r36vcu4Fo/rKgN7EpYOh3KAZYJSlmtEWJtPdy3rkQQmTsVvySvALa5yFp6/rYFXYTJUkogTT6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797194; c=relaxed/simple;
	bh=Cw/YGNBY0Z5L8ZZ/3Qj42qcOsyeieZXrdZUGsanRFfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G73+vRKs3tFBOctB6SuXENUfHHb77tAX/KEp7AR5Hwv1+TN5VbJAXEqyaotxh6nmhvlxBIke+05LGB3ZsxbYth6wne0qPHCVsKgIGD/rJVdeR3CuIZe7ygzTeKGxPyqNKiMgwOVpk9Ja2NcX2O8qNWgB8b1HFjx23EyYj9DKH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYfx6qO8; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797192; x=1738333192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cw/YGNBY0Z5L8ZZ/3Qj42qcOsyeieZXrdZUGsanRFfQ=;
  b=YYfx6qO8BruZ8+f9KYixpbGR3iPeAdd5oLAi9HVCOE2FG+6A01Hw1VS/
   jvLbNYRAjDRcjy6pzO9HsBi8zUF71PDO4gKcCY1FDlcMSfIM2opbZEPwp
   2FQlcJI9TAdO2TCmipGzI4/K4PTIrrhtfMpJ5JuaiiJyWxj8r21d2ro7o
   KKtG0Ju6FQNbL8iEuccFqUoAQZJ9Sji98U5z1Y0X0OWKI2dOUOVd8s/fe
   n6/fIiiMNsgWKOu2mst45e41TWh3MqS0RwqA3SQkoXDK5YLvcDHkOzXGb
   aHXZshRRxRyrd83aUlXDtFVzR4KvKFEwmXYdglOHN2ZrhzAkJq5bpP418
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062886"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062886"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94132"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/17] wifi: iwlwifi: do not announce EPCS support
Date: Thu,  1 Feb 2024 16:17:30 +0200
Message-Id: <20240201155157.59d71656addc.Idde91b3018239c49fc6ed231b411d05354fb9fb1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
References: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

mac80211 does not have proper support for EPCS currently as that would
require changing the ECDA parameters if EPCS (Emergency Preparedness
Communications Service) is in use. As such, do not announce support for
it in the capabilities.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 0b2b0c320cb0..c30187d77b3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -668,7 +668,6 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			.has_eht = true,
 			.eht_cap_elem = {
 				.mac_cap_info[0] =
-					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
 					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2 |
@@ -796,7 +795,6 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			.has_eht = true,
 			.eht_cap_elem = {
 				.mac_cap_info[0] =
-					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
 					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2,
@@ -1028,8 +1026,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	if (CSR_HW_REV_TYPE(trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
 	    iftype_data->eht_cap.has_eht) {
 		iftype_data->eht_cap.eht_cap_elem.mac_cap_info[0] &=
-			~(IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
-			  IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
+			~(IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
 			  IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2);
 		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[3] &=
 			~(IEEE80211_EHT_PHY_CAP0_PARTIAL_BW_UL_MU_MIMO |
-- 
2.34.1


