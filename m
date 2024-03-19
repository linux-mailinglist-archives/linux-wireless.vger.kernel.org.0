Return-Path: <linux-wireless+bounces-4887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F92187F916
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EA21F2418E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED19D7CF17;
	Tue, 19 Mar 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8Gh1rA/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2385D7CF0B
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835858; cv=none; b=NI8Zmqr/uXjxo5YcRSfW8FdRbK5IOo1He92s2CvbAs7YD3qRlWR4bhwk6ixsBWV93aw7iMc7ngKNbupsH6o5aUeEs6HpU8uKnjfCGAqZU0YRmeN7XbzED+bXgQjaCiJOctbuS5oaPJSogjPDgjttKa+C3vOunkpdZzekAZ17ww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835858; c=relaxed/simple;
	bh=VCzT/TWTiSe65nej3deynYY3ltYB3iA6F3oZEwI+Qd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eUn8SL3wK7ARLebT2qRwJNzIvNHv0+t67YawWR6Oxb7jvqHrFd2wu/39ayB/e2DYo9SUyZ7t3j3dtd0rT2f/t7RAKMmxaoL9n2N3zJxfnBw96UOoANhv0CaQGGhiv1r8Vg9EPvpx7aKk1mzdYf7TQe9J+NyeSHbrdvMXemWhjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8Gh1rA/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835857; x=1742371857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VCzT/TWTiSe65nej3deynYY3ltYB3iA6F3oZEwI+Qd8=;
  b=L8Gh1rA/a6CSfR5zUkSlxN6Y6fzD710NKaBUFJxXKaf5XuFRLevp7CuE
   +P4zvt4ulfQvfXU+LD1KQVW3ux36qUdld7QNKTa7t0/RUejS3CsoMGsNH
   KGPUhYZrahQEQU0vrZ4IrsZw8tvb+yxIb6d0zGJRiAvSYVeQzg3IAA8b1
   NkKAnN0v2QtajEeIBKmnqg9I3EIGYN63b6YKnDUuVJ7a98iBGjgydc52v
   AFQ06y/VGTv4f5QTCCPJNgbXmRwkhOxXSaafO+DSd49tAxlLYUXWSVhfs
   LhMKDIHITRegHXm6Kb/XRsHV/3TSNhR4FxNSoPe/GRXkcXJw6Ecg09gCA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810554"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810554"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447619"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: always apply 6 GHz probe limitations
Date: Tue, 19 Mar 2024 10:10:19 +0200
Message-Id: <20240319100755.e0b114b68d1d.Ib86afccdb955f0d221ef5d7b8afdc1d67c3542ef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When scanning on 6 GHz we allocate a set of short-SSIDs and BSSIDs to
probe. However, when we need to do an active scan because of a hidden
SSID, then we could add too many entries for probing causing an
assertion in the firmware input validation.

Reshuffle the code a bit to first calculate the maximum number of
short-SSIDs and BSSIDs that are permitted for the channel. Then ensure
that we do not set more than the permitted number of bits in the
bitmasks and turn on force_passive when we have surpassed the limit.

While at it, also change the logic so that allow_passive is always
disabled in case a hidden SSID is included. Previously, we might not
have done so if we added the short-SSID based on the number of BSSIDs
already in the request.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 155 ++++++++++--------
 1 file changed, 89 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index ea05957fbcec..459adba41ca6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1750,8 +1750,9 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 			&cp->channel_config[ch_cnt];
 
 		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
-		u8 j, k, s_max = 0, b_max = 0, n_used_bssid_entries;
-		bool force_passive, found = false, allow_passive = true,
+		u8 j, k, n_s_ssids = 0, n_bssids = 0;
+		u8 max_s_ssids, max_bssids;
+		bool force_passive = false, found = false, allow_passive = true,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
 		s8 psd_20 = IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED;
 
@@ -1774,20 +1775,15 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		cfg->v5.iter_count = 1;
 		cfg->v5.iter_interval = 0;
 
-		/*
-		 * The optimize the scan time, i.e., reduce the scan dwell time
-		 * on each channel, the below logic tries to set 3 direct BSSID
-		 * probe requests for each broadcast probe request with a short
-		 * SSID.
-		 * TODO: improve this logic
-		 */
-		n_used_bssid_entries = 3;
 		for (j = 0; j < params->n_6ghz_params; j++) {
 			s8 tmp_psd_20;
 
 			if (!(scan_6ghz_params[j].channel_idx == i))
 				continue;
 
+			unsolicited_probe_on_chan |=
+				scan_6ghz_params[j].unsolicited_probe;
+
 			/* Use the highest PSD value allowed as advertised by
 			 * APs for this channel
 			 */
@@ -1799,12 +1795,69 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 			     psd_20 < tmp_psd_20))
 				psd_20 = tmp_psd_20;
 
-			found = false;
-			unsolicited_probe_on_chan |=
-				scan_6ghz_params[j].unsolicited_probe;
 			psc_no_listen |= scan_6ghz_params[j].psc_no_listen;
+		}
+
+		/*
+		 * In the following cases apply passive scan:
+		 * 1. Non fragmented scan:
+		 *	- PSC channel with NO_LISTEN_FLAG on should be treated
+		 *	  like non PSC channel
+		 *	- Non PSC channel with more than 3 short SSIDs or more
+		 *	  than 9 BSSIDs.
+		 *	- Non PSC Channel with unsolicited probe response and
+		 *	  more than 2 short SSIDs or more than 6 BSSIDs.
+		 *	- PSC channel with more than 2 short SSIDs or more than
+		 *	  6 BSSIDs.
+		 * 3. Fragmented scan:
+		 *	- PSC channel with more than 1 SSID or 3 BSSIDs.
+		 *	- Non PSC channel with more than 2 SSIDs or 6 BSSIDs.
+		 *	- Non PSC channel with unsolicited probe response and
+		 *	  more than 1 SSID or more than 3 BSSIDs.
+		 */
+		if (!iwl_mvm_is_scan_fragmented(params->type)) {
+			if (!cfg80211_channel_is_psc(params->channels[i]) ||
+			    flags & IWL_UHB_CHAN_CFG_FLAG_PSC_CHAN_NO_LISTEN) {
+				if (unsolicited_probe_on_chan) {
+					max_s_ssids = 2;
+					max_bssids = 6;
+				} else {
+					max_s_ssids = 3;
+					max_bssids = 9;
+				}
+			} else {
+				max_s_ssids = 2;
+				max_bssids = 6;
+			}
+		} else if (cfg80211_channel_is_psc(params->channels[i])) {
+			max_s_ssids = 1;
+			max_bssids = 3;
+		} else {
+			if (unsolicited_probe_on_chan) {
+				max_s_ssids = 1;
+				max_bssids = 3;
+			} else {
+				max_s_ssids = 2;
+				max_bssids = 6;
+			}
+		}
+
+		/*
+		 * The optimize the scan time, i.e., reduce the scan dwell time
+		 * on each channel, the below logic tries to set 3 direct BSSID
+		 * probe requests for each broadcast probe request with a short
+		 * SSID.
+		 * TODO: improve this logic
+		 */
+		for (j = 0; j < params->n_6ghz_params; j++) {
+			if (!(scan_6ghz_params[j].channel_idx == i))
+				continue;
+
+			found = false;
 
-			for (k = 0; k < pp->short_ssid_num; k++) {
+			for (k = 0;
+			     k < pp->short_ssid_num && n_s_ssids < max_s_ssids;
+			     k++) {
 				if (!scan_6ghz_params[j].unsolicited_probe &&
 				    le32_to_cpu(pp->short_ssid[k]) ==
 				    scan_6ghz_params[j].short_ssid) {
@@ -1815,25 +1868,25 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 					}
 
 					/*
-					 * Use short SSID only to create a new
-					 * iteration during channel dwell or in
-					 * case that the short SSID has a
-					 * matching SSID, i.e., scan for hidden
-					 * APs.
+					 * Prefer creating BSSID entries unless
+					 * the short SSID probe can be done in
+					 * the same channel dwell iteration.
+					 *
+					 * We also need to create a short SSID
+					 * entry for any hidden AP.
 					 */
-					if (n_used_bssid_entries >= 3) {
-						s_ssid_bitmap |= BIT(k);
-						s_max++;
-						n_used_bssid_entries -= 3;
-						found = true;
+					if (3 * n_s_ssids > n_bssids &&
+					    !pp->direct_scan[k].len)
 						break;
-					} else if (pp->direct_scan[k].len) {
-						s_ssid_bitmap |= BIT(k);
-						s_max++;
-						found = true;
+
+					/* Hidden AP, cannot do passive scan */
+					if (pp->direct_scan[k].len)
 						allow_passive = false;
-						break;
-					}
+
+					s_ssid_bitmap |= BIT(k);
+					n_s_ssids++;
+					found = true;
+					break;
 				}
 			}
 
@@ -1845,9 +1898,12 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 					    scan_6ghz_params[j].bssid,
 					    ETH_ALEN)) {
 					if (!(bssid_bitmap & BIT(k))) {
-						bssid_bitmap |= BIT(k);
-						b_max++;
-						n_used_bssid_entries++;
+						if (n_bssids < max_bssids) {
+							bssid_bitmap |= BIT(k);
+							n_bssids++;
+						} else {
+							force_passive = TRUE;
+						}
 					}
 					break;
 				}
@@ -1861,39 +1917,6 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		if (unsolicited_probe_on_chan)
 			flags |= IWL_UHB_CHAN_CFG_FLAG_UNSOLICITED_PROBE_RES;
 
-		/*
-		 * In the following cases apply passive scan:
-		 * 1. Non fragmented scan:
-		 *	- PSC channel with NO_LISTEN_FLAG on should be treated
-		 *	  like non PSC channel
-		 *	- Non PSC channel with more than 3 short SSIDs or more
-		 *	  than 9 BSSIDs.
-		 *	- Non PSC Channel with unsolicited probe response and
-		 *	  more than 2 short SSIDs or more than 6 BSSIDs.
-		 *	- PSC channel with more than 2 short SSIDs or more than
-		 *	  6 BSSIDs.
-		 * 3. Fragmented scan:
-		 *	- PSC channel with more than 1 SSID or 3 BSSIDs.
-		 *	- Non PSC channel with more than 2 SSIDs or 6 BSSIDs.
-		 *	- Non PSC channel with unsolicited probe response and
-		 *	  more than 1 SSID or more than 3 BSSIDs.
-		 */
-		if (!iwl_mvm_is_scan_fragmented(params->type)) {
-			if (!cfg80211_channel_is_psc(params->channels[i]) ||
-			    flags & IWL_UHB_CHAN_CFG_FLAG_PSC_CHAN_NO_LISTEN) {
-				force_passive = (s_max > 3 || b_max > 9);
-				force_passive |= (unsolicited_probe_on_chan &&
-						  (s_max > 2 || b_max > 6));
-			} else {
-				force_passive = (s_max > 2 || b_max > 6);
-			}
-		} else if (cfg80211_channel_is_psc(params->channels[i])) {
-			force_passive = (s_max > 1 || b_max > 3);
-		} else {
-			force_passive = (s_max > 2 || b_max > 6);
-			force_passive |= (unsolicited_probe_on_chan &&
-					  (s_max > 1 || b_max > 3));
-		}
 		if ((allow_passive && force_passive) ||
 		    (!(bssid_bitmap | s_ssid_bitmap) &&
 		     !cfg80211_channel_is_psc(params->channels[i])))
-- 
2.34.1


