Return-Path: <linux-wireless+bounces-11139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CAC94C59F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D2B1C221B5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236D15990C;
	Thu,  8 Aug 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nk+1lJiy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541E158DA0
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148591; cv=none; b=tgnGo3yE+brQG2YrqoxbRDKHX3NWukEtPHxi0ThlQXRzCGL7n0wiOcpU01oYLeSVEc0hlVd6gRxuFM/tuvTpdQF2AGKp8cZ80gF5R8b3lszcj9RPc9qTWaF8u7hek/1kHrQDvzNN7UhGGnj/Mz9IYMNigcOAxEm9pBGzP1LEQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148591; c=relaxed/simple;
	bh=D4BVSHmX4ElwQKiNcP/6xCd4Ibhq5EomBkNDwX/RX8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cm0V4oPFIsFux8qPA+nZLfLewITZvIQwzLVHqeayFZ9ICi+Z86JTFepn3WgCr8z4/05Jh0bM7wU2siyTGGtunHZ8mVYZG7lj1B/Lq7BnN0d2SHVx2Akt4vGPlJX1oMxbvQRjDghDFLiCMg7/bo/1L8wIat8mfm6c6T3z8VirDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nk+1lJiy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148590; x=1754684590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D4BVSHmX4ElwQKiNcP/6xCd4Ibhq5EomBkNDwX/RX8M=;
  b=Nk+1lJiyWB5YuCIvIftYmLGVCqLDrBKtwTxkiSwq1pipcanWtCnSqyFq
   YnPKoeI2lis4dVYI4zm8N4izlLKiDNG7UOy07vDI5SNin9QQ/dGnJmc9s
   a0HAJP+AQH72mQkn84NLzoP2D6/LE8o0CP5LknidAbR+CM7BeONtkRMUR
   nMgWFe34rxPL6ToRmC06vc8/kBJ9qieUXlYcn47pHFMvYtIZDxEFZhK8A
   dMgyFgvbNIwMclQxor2My89hXuYYSOBF4FpQCwVKWzOEjmwfGERsZqps+
   z85PePUaSgyznR1+qTonTKSql+Iaggk68AUS6OuYzMzyRYoefDDgFCdQ1
   Q==;
X-CSE-ConnectionGUID: +Dh4uBlDSDC+UjrojSxiDA==
X-CSE-MsgGUID: H/ultLH8T2q61y7/GdRxqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808842"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808842"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:09 -0700
X-CSE-ConnectionGUID: C7BftDaqRqudEdjrXSyoxg==
X-CSE-MsgGUID: v84wyiOKTiC0pHvSHV1B9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305296"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 05/13] wifi: iwlwifi: mvm: exit EMLSR if both links are missing beacons
Date: Thu,  8 Aug 2024 23:22:41 +0300
Message-Id: <20240808232017.b7785943a4fe.I70a459c5e7db85f398d5795ba83bb15f65d6bf9d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

If both links are missing 5 beacons, we need to exit EMLSR, if only one
link misses beacons, we need to wait until 11 beacons are missed.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/constants.h    |  3 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 25 ++++++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 8f63cbe9e50d..ddf484027d4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -16,6 +16,8 @@
 #define IWL_MVM_BT_COEX_WIFI_LOSS_THRESH	0
 #define IWL_MVM_TRIGGER_LINK_SEL_TIME_SEC	30
 #define IWL_MVM_TPT_COUNT_WINDOW_SEC		5
+#define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS	5
+#define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH	11
 
 #define IWL_MVM_DEFAULT_PS_TX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
 #define IWL_MVM_DEFAULT_PS_RX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
@@ -125,7 +127,6 @@
 #define IWL_MVM_6GHZ_PASSIVE_SCAN_ASSOC_TIMEOUT 60   /* in seconds */
 #define IWL_MVM_MIN_BEACON_INTERVAL_TU		16
 #define IWL_MVM_AUTO_EML_ENABLE                 true
-#define IWL_MVM_MISSED_BEACONS_EXIT_ESR_THRESH	7
 
 #define IWL_MVM_HIGH_RSSI_THRESH_20MHZ		-67
 #define IWL_MVM_LOW_RSSI_THRESH_20MHZ		-71
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 4a8f50f8bb79..bb864ec2e22a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1664,10 +1664,27 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 				 "missed_beacons:%d, missed_beacons_since_rx:%d\n",
 				 rx_missed_bcon, rx_missed_bcon_since_rx);
 		}
-	} else if (rx_missed_bcon >= IWL_MVM_MISSED_BEACONS_EXIT_ESR_THRESH &&
-		   link_id >= 0 && hweight16(vif->active_links) > 1) {
-		iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_MISSED_BEACON,
-				 iwl_mvm_get_other_link(vif, link_id));
+	} else if (link_id >= 0 && hweight16(vif->active_links) > 1) {
+		u32 scnd_lnk_bcn_lost = 0;
+
+		if (notif_ver >= 5 &&
+		    !IWL_FW_CHECK(mvm,
+				  le32_to_cpu(mb->other_link_id) == IWL_MVM_FW_LINK_ID_INVALID,
+				  "No data for other link id but we are in EMLSR active_links: 0x%x\n",
+				  vif->active_links))
+			scnd_lnk_bcn_lost =
+				le32_to_cpu(mb->consec_missed_beacons_other_link);
+
+		/* Exit EMLSR if we lost more than
+		 * IWL_MVM_MISSED_BEACONS_EXIT_ESR_THRESH beacons on boths links
+		 * OR more than IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH on any link.
+		 */
+		if ((rx_missed_bcon >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS &&
+		     scnd_lnk_bcn_lost >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS) ||
+		    rx_missed_bcon >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH)
+			iwl_mvm_exit_esr(mvm, vif,
+					 IWL_MVM_ESR_EXIT_MISSED_BEACON,
+					 iwl_mvm_get_primary_link(vif));
 	} else if (rx_missed_bcon_since_rx > IWL_MVM_MISSED_BEACONS_THRESHOLD) {
 		if (!iwl_mvm_has_new_tx_api(mvm))
 			ieee80211_beacon_loss(vif);
-- 
2.34.1


