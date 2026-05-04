Return-Path: <linux-wireless+bounces-35815-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGvHGwhJ+Gn+sAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35815-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E04B9460
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65317300406B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2D02E1C4E;
	Mon,  4 May 2026 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6tn605M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43D22DF13E
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879285; cv=none; b=QscvyrgMfw6wtKwL1fdfKu3KJPsfYTvwgnxiFmedLyl4ZQPInu4sA2+jPLUxn53Q9DT63dHihqHLhq7Ps+PDqzedaWLb8/ZfGnA5tBgajZTTOwq/UXOjwfMC3hyzg00Uy4x/l8G6/sJ4+/R9nmWzwjFilgxDaJDYOMpG4NTUSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879285; c=relaxed/simple;
	bh=bNWDWdK7JOHaObLfKVo/9SMt2q2cSCBD1e78PXgr258=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkbNTWOKzDB5+sItHEklaK8bGLL7LpGjGrOUAt7CKTIxiPGRKQA5EFnzLzNzS/oQWwYZ55ggg8RkzQ93qPKb5f1wFY4qU0GogdEhiNB+WbFEyyh/bttJhFjmwQ1eFjquyPe1xdYU1zg3qwIJUZj1h6IZGRCXD5BHYAGeBHN0vq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6tn605M; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777879283; x=1809415283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bNWDWdK7JOHaObLfKVo/9SMt2q2cSCBD1e78PXgr258=;
  b=d6tn605MikBTr0izCX2jhgV1CwIW/wad5fPUk7/GwuDfcxG7jhGCZaJt
   +HcTrDpKh9lLFarc97R26rWdVlu9dls+L5ahv5MK09b27iujsxPKoHVET
   qNetV9CCHQcWWTolPoIUubxLCJV3/WuJFns4oXBCIO+NI7D3yNtn2dT0T
   bovRXFT4vngCk131nDqggY8HKc1QrYQq/shQ5bi0b+1PC7hD3mQWfytFb
   UbMDIYfx3BkJNngSgN5Ac4o4BBlBdLG8tOEo2He0teZcjw2GgwCGwzCGe
   UI3/Dwqgr6mfUQIHLQeLZQx6nj5aPpka67tBqsYtAiAMAaDDNVTsz+RvX
   Q==;
X-CSE-ConnectionGUID: pVqcV/jDRQaVoOkxqSzlOQ==
X-CSE-MsgGUID: qvokbxITSZyDirjHq8eKQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101398324"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101398324"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:20 -0700
X-CSE-ConnectionGUID: abL5sMx3Rgqrmhexg6eQgg==
X-CSE-MsgGUID: isMVOdPERfKB9c+uspXBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273555258"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 wireless-next 09/15] wifi: mac80211_hwsim: move NAN related variables into a struct
Date: Mon,  4 May 2026 10:20:49 +0300
Message-Id: <20260504101829.56feb1563479.Ia82f11ae5cbd0ac02b3697d010489d5a93906d40@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
References: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E1E04B9460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35815-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: Benjamin Berg <benjamin.berg@intel.com>

Move it all into a common struct to better segment the code.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 76 ++++++++++---------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 7ab0765cb482..d5b9170f690c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -663,6 +663,15 @@ struct mac80211_hwsim_link_data {
 	struct hrtimer beacon_timer;
 };
 
+struct mac80211_hwsim_nan_data {
+	struct ieee80211_vif *device_vif;
+	u8 bands;
+
+	enum nl80211_band curr_dw_band;
+	struct hrtimer timer;
+	bool notify_dw;
+};
+
 struct mac80211_hwsim_data {
 	struct list_head list;
 	struct rhash_head rht;
@@ -759,12 +768,7 @@ struct mac80211_hwsim_data {
 
 	struct mac80211_hwsim_link_data link_data[IEEE80211_MLD_MAX_NUM_LINKS];
 
-	struct ieee80211_vif *nan_device_vif;
-	u8 nan_bands;
-
-	enum nl80211_band nan_curr_dw_band;
-	struct hrtimer nan_timer;
-	bool notify_dw;
+	struct mac80211_hwsim_nan_data nan;
 };
 
 static const struct rhashtable_params hwsim_rht_params = {
@@ -2108,9 +2112,9 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		 * on channel 6 or channel 149, unless a ROC is in progress (for
 		 * USD use cases).
 		 */
-		if (data->nan_curr_dw_band == NL80211_BAND_2GHZ)
+		if (data->nan.curr_dw_band == NL80211_BAND_2GHZ)
 			channel = ieee80211_get_channel(hw->wiphy, 2437);
-		else if (data->nan_curr_dw_band == NL80211_BAND_5GHZ)
+		else if (data->nan.curr_dw_band == NL80211_BAND_5GHZ)
 			channel = ieee80211_get_channel(hw->wiphy, 5745);
 		else
 			channel = NULL;
@@ -4131,21 +4135,21 @@ mac80211_hwsim_nan_dw_start(struct hrtimer *timer)
 {
 	struct mac80211_hwsim_data *data =
 		container_of(timer, struct mac80211_hwsim_data,
-			     nan_timer);
+			     nan.timer);
 	struct ieee80211_hw *hw = data->hw;
 	u64 orig_tsf = mac80211_hwsim_get_tsf(hw, NULL), tsf = orig_tsf;
 	u32 dw_int = 512 * 1024;
 	u64 until_dw;
 
-	if (!data->nan_device_vif)
+	if (!data->nan.device_vif)
 		return HRTIMER_NORESTART;
 
-	if (data->nan_bands & BIT(NL80211_BAND_5GHZ)) {
-		if (data->nan_curr_dw_band == NL80211_BAND_2GHZ) {
+	if (data->nan.bands & BIT(NL80211_BAND_5GHZ)) {
+		if (data->nan.curr_dw_band == NL80211_BAND_2GHZ) {
 			dw_int = 128 * 1024;
-			data->nan_curr_dw_band = NL80211_BAND_5GHZ;
-		} else if (data->nan_curr_dw_band == NL80211_BAND_5GHZ) {
-			data->nan_curr_dw_band = NL80211_BAND_2GHZ;
+			data->nan.curr_dw_band = NL80211_BAND_5GHZ;
+		} else if (data->nan.curr_dw_band == NL80211_BAND_5GHZ) {
+			data->nan.curr_dw_band = NL80211_BAND_2GHZ;
 		}
 	}
 
@@ -4162,18 +4166,18 @@ mac80211_hwsim_nan_dw_start(struct hrtimer *timer)
 	 */
 	wiphy_debug(hw->wiphy,
 		    "%s: tsf=%llx, curr_dw_band=%u, next_dw=%llu\n",
-		    __func__, orig_tsf, data->nan_curr_dw_band,
+		    __func__, orig_tsf, data->nan.curr_dw_band,
 		    until_dw);
 
-	hrtimer_forward_now(&data->nan_timer,
+	hrtimer_forward_now(&data->nan.timer,
 			    ns_to_ktime(until_dw * NSEC_PER_USEC));
 
-	if (data->notify_dw) {
+	if (data->nan.notify_dw) {
 		struct ieee80211_channel *ch;
 		struct wireless_dev *wdev =
-			ieee80211_vif_to_wdev(data->nan_device_vif);
+			ieee80211_vif_to_wdev(data->nan.device_vif);
 
-		if (data->nan_curr_dw_band == NL80211_BAND_5GHZ)
+		if (data->nan.curr_dw_band == NL80211_BAND_5GHZ)
 			ch = ieee80211_get_channel(hw->wiphy, 5745);
 		else
 			ch = ieee80211_get_channel(hw->wiphy, 2437);
@@ -4197,18 +4201,18 @@ static int mac80211_hwsim_start_nan(struct ieee80211_hw *hw,
 	if (vif->type != NL80211_IFTYPE_NAN)
 		return -EINVAL;
 
-	if (data->nan_device_vif)
+	if (data->nan.device_vif)
 		return -EALREADY;
 
 	/* set this before starting the timer, as preemption might occur */
-	data->nan_device_vif = vif;
-	data->nan_bands = conf->bands;
-	data->nan_curr_dw_band = NL80211_BAND_2GHZ;
+	data->nan.device_vif = vif;
+	data->nan.bands = conf->bands;
+	data->nan.curr_dw_band = NL80211_BAND_2GHZ;
 
 	wiphy_debug(hw->wiphy, "nan_started, next_dw=%llu\n",
 		    until_dw);
 
-	hrtimer_start(&data->nan_timer,
+	hrtimer_start(&data->nan.timer,
 		      ns_to_ktime(until_dw * NSEC_PER_USEC),
 		      HRTIMER_MODE_REL_SOFT);
 
@@ -4224,7 +4228,7 @@ static int mac80211_hwsim_start_nan(struct ieee80211_hw *hw,
 		hwsim_nan_cluster_id[5] = get_random_u8();
 	}
 
-	data->notify_dw = conf->enable_dw_notification;
+	data->nan.notify_dw = conf->enable_dw_notification;
 
 	cfg80211_nan_cluster_joined(wdev, hwsim_nan_cluster_id, true,
 				    GFP_KERNEL);
@@ -4239,16 +4243,16 @@ static int mac80211_hwsim_stop_nan(struct ieee80211_hw *hw,
 	struct mac80211_hwsim_data *data2;
 	bool nan_cluster_running = false;
 
-	if (vif->type != NL80211_IFTYPE_NAN || !data->nan_device_vif ||
-	    data->nan_device_vif != vif)
+	if (vif->type != NL80211_IFTYPE_NAN || !data->nan.device_vif ||
+	    data->nan.device_vif != vif)
 		return -EINVAL;
 
-	hrtimer_cancel(&data->nan_timer);
-	data->nan_device_vif = NULL;
+	hrtimer_cancel(&data->nan.timer);
+	data->nan.device_vif = NULL;
 
 	spin_lock_bh(&hwsim_radio_lock);
 	list_for_each_entry(data2, &hwsim_radios, list) {
-		if (data2->nan_device_vif) {
+		if (data2->nan.device_vif) {
 			nan_cluster_running = true;
 			break;
 		}
@@ -4271,19 +4275,19 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	if (vif->type != NL80211_IFTYPE_NAN)
 		return -EINVAL;
 
-	if (!data->nan_device_vif)
+	if (!data->nan.device_vif)
 		return -EINVAL;
 
 	wiphy_debug(hw->wiphy, "nan_config_changed: changes=0x%x\n", changes);
 
 	/* Handle only the changes we care about for simulation purposes */
 	if (changes & CFG80211_NAN_CONF_CHANGED_BANDS) {
-		data->nan_bands = conf->bands;
-		data->nan_curr_dw_band = NL80211_BAND_2GHZ;
+		data->nan.bands = conf->bands;
+		data->nan.curr_dw_band = NL80211_BAND_2GHZ;
 	}
 
 	if (changes & CFG80211_NAN_CONF_CHANGED_CONFIG)
-		data->notify_dw = conf->enable_dw_notification;
+		data->nan.notify_dw = conf->enable_dw_notification;
 
 	return 0;
 }
@@ -5716,7 +5720,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
 			NAN_DEV_CAPA_NDPE_SUPPORTED;
 
-		hrtimer_setup(&data->nan_timer, mac80211_hwsim_nan_dw_start,
+		hrtimer_setup(&data->nan.timer, mac80211_hwsim_nan_dw_start,
 			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS_SOFT);
 	}
 
-- 
2.34.1


