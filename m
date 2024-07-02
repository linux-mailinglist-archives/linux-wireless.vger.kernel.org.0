Return-Path: <linux-wireless+bounces-9877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604819248BE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 22:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848681C21EF6
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 20:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35D1D47D9;
	Tue,  2 Jul 2024 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ZvkS0RDA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0201D363F
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950816; cv=none; b=vC0gauRxrgSHKt+8qZ9lieVzOnjqYtnCZSYJuE0EfLVtyBKWX5hWMhwQogTXLwHl9ORhYt2bRsRC66wiAN8QWmlYXamq8bmX/oddPj9ysi0DLLIPcXJaGqgo4Elx28uf1JWvf+E0g3YRaiKqr/EZ2z9TCdUNMLNjxGzGoTbXxsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950816; c=relaxed/simple;
	bh=GAwNMvxd+Qvs0ks18/Qpi6jIvI8JlWCs7Hmz6vwfYXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAINiamkDoDSlgz566wBhVejK2ICOpggNzpwEiN+vNAFedGgdNMKdYSwiQRV7TXFGo+CSPJ3C1Rb2pNeCLfXAqMmApZL5jZ4ZDq0ITwH1Z1aOfAFIqGzbmCVg/sSpeXo3dtPorw6cIBHuOsxgSB27Vy0Lo1D7f0tNfuRd4/gUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ZvkS0RDA; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 58954501D70
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 19:58:25 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A8638940079
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 19:58:17 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id D135313C2B0;
	Tue,  2 Jul 2024 12:58:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D135313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1719950296;
	bh=GAwNMvxd+Qvs0ks18/Qpi6jIvI8JlWCs7Hmz6vwfYXE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZvkS0RDAq5YDBTZ/OjlW7efFHeRNha21XirCuLYG0XefchSQ1NaR0q7aQVUpY3Bsl
	 zTqiYGh377URfDZpMOtJ+lIEQnS7jIO8REWKCGoM/1fE6At5mc33u288XCawEdqfRM
	 hu059Zo1JU0/JGMs8h+4p9gZ46LDCaz9mtJVnEBk=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [RFC] iwlwifi: allow scanning non PSC channels.
Date: Tue,  2 Jul 2024 12:58:09 -0700
Message-ID: <20240702195809.866513-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1719950298-KQ0WV8JPi0zY
X-MDID-O:
 us5;at1;1719950298;KQ0WV8JPi0zY;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

I put a 6ghz only AP, 40Mhz wide, on 6Ghz channel 1 (non-psc).
It is not doing any colocated stuff or beaconning on 2.4/5.

be200 would not scan it.

With this patch, it will scan and associate.  I also patched my
supplicant to disable NL80211_SCAN_FLAG_COLOCATED_6GHZ flag on
every 5th scan.  Only with this flag disabled will be200 now
scan on non-psc channels.

My approach is to relax the only-scan-psc-channels logic in iwlwifi
when NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set.

The reason I think this might be valid approach (the part about when
it is not set...)

 @NL80211_SCAN_FLAG_COLOCATED_6GHZ: scan for collocated APs reported by
 *      2.4/5 GHz APs. When the flag is set, the scan logic will use the
 *      information from the RNR element found in beacons/probe responses
 *      received on the 2.4/5 GHz channels to actively scan only the 6GHz
 *      channels on which APs are expected to be found. Note that when not set,
 *      the scan logic would scan all 6GHz channels, but since transmission of
 *      probe requests on non-PSC channels is limited, it is highly likely that
 *      these channels would passively be scanned. Also note that when the flag
 *      is set, in addition to the colocated APs, PSC channels would also be
 *      scanned if the user space has asked for it.

I know patch is full of debugging and at lease the cfg80211 part needs
to go away.  Maybe iwlwifi part can stay since it will be disabled by
default anyway, and it is useful for debugging scan issues in case
someone wants to enable it.

Suggestions for improvement are welcome.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 57 +++++++++++++++++--
 net/wireless/scan.c                           | 11 ++++
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index e975f5ff17b5..05029f366043 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1666,6 +1666,9 @@ iwl_mvm_umac_scan_cfg_channels_v7(struct iwl_mvm *mvm,
 		else
 			cfg->flags |= cpu_to_le32((iwl_band <<
 						   IWL_CHAN_CFG_FLAGS_BAND_POS));
+		IWL_DEBUG_SCAN(mvm,
+			       "Scan umac-scan-cfg-channels-v7[%i] hw-ch-num: %i  is-psc: %d\n",
+			       i, channels[i]->hw_value, cfg80211_channel_is_psc(channels[i]));
 	}
 }
 
@@ -1769,13 +1772,20 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
 		s8 psd_20 = IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED;
 
+		IWL_DEBUG_SCAN(mvm,
+			       "Scan umac-scan-cfg-channels-v7-6g[%i] hw-ch-num: %i  is-psc: %d  n-6ghz-params: %d  n-ssids:%d  coloc-6ghz: %d\n",
+			       i, params->channels[i]->hw_value, cfg80211_channel_is_psc(params->channels[i]),
+			       params->n_6ghz_params, params->n_ssids,
+			       !!(params->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ));
+
 		/*
 		 * Avoid performing passive scan on non PSC channels unless the
 		 * scan is specifically a passive scan, i.e., no SSIDs
 		 * configured in the scan command.
 		 */
 		if (!cfg80211_channel_is_psc(params->channels[i]) &&
-		    !params->n_6ghz_params && params->n_ssids)
+		    !params->n_6ghz_params && params->n_ssids &&
+		    params->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ)
 			continue;
 
 		cfg->v1.channel_num = params->channels[i]->hw_value;
@@ -1811,6 +1821,10 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 			psc_no_listen |= scan_6ghz_params[j].psc_no_listen;
 		}
 
+		IWL_DEBUG_SCAN(mvm,
+			       "Scan umac-scan-cfg-channels-v7-6g[%i] psc-no-listen: %d  un-sol-probe-on-channel: %d\n",
+			       i, psc_no_listen, unsolicited_probe_on_chan);
+
 		/*
 		 * In the following cases apply passive scan:
 		 * 1. Non fragmented scan:
@@ -1941,6 +1955,10 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		if (version >= 17)
 			cfg->v5.psd_20 = psd_20;
 
+		IWL_DEBUG_SCAN(mvm,
+			       "Scan umac-scan-cfg-channels-v7-6g[%i] psc-no-listen: %d allow-passive: %d  force_passive: %d  un-sol-probe-on-channel: %d flags: 0x%x\n",
+			       i, psc_no_listen,  unsolicited_probe_on_chan, allow_passive, force_passive, flags);
+
 		ch_cnt++;
 	}
 
@@ -2068,8 +2086,13 @@ static void iwl_mvm_scan_6ghz_passive_scan(struct iwl_mvm *mvm,
 	 */
 	if (n_disabled != sband->n_channels) {
 		IWL_DEBUG_SCAN(mvm,
-			       "6GHz passive scan: 6GHz channels enabled\n");
-		return;
+			       "6GHz passive scan: some 6GHz channels enabled, coloc-6ghz: %d\n",
+			       !!(params->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ));
+		/* if user has disabled colocated-6ghz flag, they are asking for all channels
+		 * to be scanned, so allow passive scanning.
+		 */
+		if (params->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ)
+			return;
 	}
 
 	/* all conditions to enable 6ghz passive scan are satisfied */
@@ -2451,6 +2474,10 @@ iwl_mvm_scan_umac_fill_ch_p_v7(struct iwl_mvm *mvm,
 					  channel_cfg_flags,
 					  vif->type, version);
 
+	IWL_DEBUG_SCAN(mvm,
+		       "Scan umac-scan-cfg-ch-p-v7, enable-passive: %d  n-channels: n_channels: %d\n",
+		       params->enable_6ghz_passive, params->n_channels);
+
 	if (params->enable_6ghz_passive) {
 		struct ieee80211_supported_band *sband =
 			&mvm->nvm_data->bands[NL80211_BAND_6GHZ];
@@ -2549,6 +2576,9 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 	if (ret)
 		return ret;
 
+	IWL_DEBUG_SCAN(mvm,
+		       "Scan umac-scan-v14-above, scan-6ghz: %d\n",
+		       params->scan_6ghz);
 	if (!params->scan_6ghz) {
 		iwl_mvm_scan_umac_fill_probe_p_v4(params,
 						  &scan_p->probe_params,
@@ -2572,12 +2602,19 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 							 params->n_channels,
 							 pb, cp, vif->type,
 							 version);
+	IWL_DEBUG_SCAN(mvm,
+		       "Scan umac-scan-v14-above, v7-6g count: %d\n",
+		       cp->count);
 	if (!cp->count)
 		return -EINVAL;
 
 	if (!params->n_ssids ||
-	    (params->n_ssids == 1 && !params->ssids[0].ssid_len))
+	    (params->n_ssids == 1 && !params->ssids[0].ssid_len)) {
+		IWL_DEBUG_SCAN(mvm,
+			       "Scan umac-scan-v14-above, setting 6G_PSC_NO_FILTER\n");
+
 		cp->flags |= IWL_SCAN_CHANNEL_FLAG_6G_PSC_NO_FILTER;
+	}
 
 	return 0;
 }
@@ -3151,6 +3188,11 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		}
 	}
 
+	IWL_DEBUG_SCAN(mvm,
+		       "Scan sched-scan-start, non-psc-included: %d  n-channels: %d scan-colocated-6g: %d\n",
+		       non_psc_included, params.n_channels,
+		       !!((params.flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ)));
+
 	if (non_psc_included) {
 		params.channels = kmemdup(params.channels,
 					  sizeof(params.channels[0]) *
@@ -3161,8 +3203,13 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 
 		for (i = j = 0; i < params.n_channels; i++) {
 			if (params.channels[i]->band == NL80211_BAND_6GHZ &&
-			    !cfg80211_channel_is_psc(params.channels[i]))
+			    (params.flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ) &&
+			    !cfg80211_channel_is_psc(params.channels[i])) {
+				IWL_DEBUG_SCAN(mvm,
+					       "Scan sched-scan-start, skipping non-psc channel[%d]\n",
+					       i);
 				continue;
+			}
 			params.channels[j++] = params.channels[i];
 		}
 		params.n_channels = j;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1280ff7d6349..d19a463c7bd9 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -826,6 +826,9 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
 	n_channels = rdev->wiphy.bands[NL80211_BAND_6GHZ]->n_channels;
 
+	pr_info("cfg802311-scan-6ghz, scan-flag-colocated-6ghz: %d\n",
+		!!(rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ));
+
 	if (rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ) {
 		struct cfg80211_internal_bss *intbss;
 
@@ -1045,6 +1048,9 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 			n_channels++;
 	}
 
+	pr_info("cfg802311-scan, scan-flag-colocated-6ghz: %d\n",
+		!!(rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ));
+
 	if (!n_channels) {
 		int rv = cfg80211_scan_6ghz(rdev);
 		if (rv)
@@ -1095,6 +1101,11 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 	wdev = rdev_req->wdev;
 	request = rdev->int_scan_req ? rdev->int_scan_req : rdev_req;
 
+	pr_info("cfg802311-scan-done, scan-flag-colocated-6ghz: %d wdev-running: %d  split-scan-6ghz: %d req-scan-6ghz: %d aborted: %d\n",
+		!!(rdev_req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ), wdev_running(wdev),
+		!!(rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ), rdev_req->scan_6ghz,
+		request->info.aborted);
+
 	if (wdev_running(wdev) &&
 	    (rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ) &&
 	    !rdev_req->scan_6ghz && !request->info.aborted &&
-- 
2.42.0


