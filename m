Return-Path: <linux-wireless+bounces-2731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07324841347
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C121C21B90
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A032E834;
	Mon, 29 Jan 2024 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVuB+ige"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53A48790
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556166; cv=none; b=b3ZhxdRdN4MSrvF7Tsk0xl6QJXE5B0R++r3vmMw24etUTZm3a8JelCeDHLqCAR8+rg/nP96AoYqnk/ZoVyBrRIg/11dvRBFCJQjC+IIHRfqmBBdHMRUFO1+uYCAwg50d8VxxGqs3mApRu/n59FLS77kKgYqUmhCvEF7+3b5q8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556166; c=relaxed/simple;
	bh=BSGfhYrgoFz1LAEopbG3O+q4l3m3wXsIgUz+py9/55E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBfpzaqvVtjH2GtczVbezFHwng+bi+mJCKyUy9uP39ihBF1gVIKUI/wHr/KHyfX7aT1Tje/VhhHTIBw1sCBFCGOCoW5Wgglj9oorvXRwxpbEl2ejDGiSbpfP/TrdWL/cNzL5QDYTDRVWICKDsgHpzVCOwKdpzpvn8d4sRuA5+Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVuB+ige; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556166; x=1738092166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BSGfhYrgoFz1LAEopbG3O+q4l3m3wXsIgUz+py9/55E=;
  b=GVuB+igeR2nZIbOIK/sLKBQzjamBK7WwV/RDyp1owK0Awi3xFcn4VB3i
   HcuwwLmL1EwDjndpfC0XMdhNSr9xznR5TWesQI1ujxFf+5FS2hy343f9G
   1sIzAQCTyQlEUu6BKQPzhH6CzE9pxHrhfRq54L8UHhmUOhkuYNz2qCyPM
   kMGie4UCvu4Rju+mmD588Wvf/B6l43pVzbMgP7A621uVay7D43OSI5OjK
   Vh3UoCmvSdMbGAXJmAbsWS7xiXQBr94J3cvHKuYjiUzKRcUQ5Ejz6ZH3O
   xEXo1zlyhpjtCArna+3xFy2UlQo5J4Ki6JC5XiYUOHfoTBFSZ5YrJJilb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2943042"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2943042"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459133"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:43 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: use FW rate for non-data only on new devices
Date: Mon, 29 Jan 2024 21:21:58 +0200
Message-Id: <20240129211905.e59056d0a8cc.Iccc4c5c1753921d3d85241ede812a150fb05b898@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With MLO connections we need to let the firmware pick the rate
as we don't know the link the frame might be transmitted on
(in some cases we do know, but we'd rather always use the FW
and find bugs.) We _did_ end up finding bugs and fixing them,
but older devices likely won't get fixed as we don't have a
need for this there, they cannot support MLO.

Thus, go back to picking a rate on the host for the relevant
frames on older (pre-Bz) devices.

Fixes: 499d02790495 ("wifi: iwlwifi: Use FW rate for non-data frames")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 33 ++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index db986bfc4dc3..79eb6394e5a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -520,6 +520,31 @@ static void iwl_mvm_set_tx_cmd_crypto(struct iwl_mvm *mvm,
 	}
 }
 
+static bool iwl_mvm_use_host_rate(struct iwl_mvm *mvm,
+				  struct iwl_mvm_sta *mvmsta,
+				  struct ieee80211_hdr *hdr,
+				  struct ieee80211_tx_info *info)
+{
+	if (unlikely(!mvmsta))
+		return true;
+
+	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT))
+		return true;
+
+	if (likely(ieee80211_is_data(hdr->frame_control) &&
+		   mvmsta->sta_state >= IEEE80211_STA_AUTHORIZED))
+		return false;
+
+	/*
+	 * Not a data frame, use host rate if on an old device that
+	 * can't possibly be doing MLO (firmware may be selecting a
+	 * bad rate), if we might be doing MLO we need to let FW pick
+	 * (since we don't necesarily know the link), but FW rate
+	 * selection was fixed.
+	 */
+	return mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ;
+}
+
 /*
  * Allocates and sets the Tx cmd the driver data pointers in the skb
  */
@@ -556,12 +581,12 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			flags |= IWL_TX_FLAGS_ENCRYPT_DIS;
 
 		/*
-		 * For data and mgmt packets rate info comes from the fw. Only
+		 * For data and mgmt packets rate info comes from the fw (for
+		 * new devices, older FW is somewhat broken for this). Only
 		 * set rate/antenna for injected frames with fixed rate, or
-		 * when no sta is given.
+		 * when no sta is given, or with older firmware.
 		 */
-		if (unlikely(!sta ||
-			     info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT)) {
+		if (unlikely(iwl_mvm_use_host_rate(mvm, mvmsta, hdr, info))) {
 			flags |= IWL_TX_FLAGS_CMD_RATE;
 			rate_n_flags =
 				iwl_mvm_get_tx_rate_n_flags(mvm, info, sta,
-- 
2.34.1


