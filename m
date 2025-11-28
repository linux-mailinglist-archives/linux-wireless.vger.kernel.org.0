Return-Path: <linux-wireless+bounces-29404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A7C924C5
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D593AC3F8
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4F330B15;
	Fri, 28 Nov 2025 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C+aNeD/f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B95330329
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339670; cv=none; b=dT0FdQ1D5WbZXB6CoiIkDnI7mHsTyxxGyMA2jEhr7dUBE8Mg5v4eI7vH/5qhPNjt9WlgiQE1VnjQAx/z0ysnhZBSWsS6HY8lCRO92N0VS3VQNybOa1PAKXGAvAvVi2Cs5CEq8vLtdnRN/LNrniA74uBG+Ol76pjRkyQqjEUV7d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339670; c=relaxed/simple;
	bh=3t7t5h/ut14evtmsxZZ1jW9cpluwKIZQFA6kpJTuk2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0wz4gM64ZhL+UvD5SlfnuxzrWGgEahOFOxKhXDC9Kk/DNoijNiksPhHJvkvGi6BQ+z8ltuRVZIXXHIO59P3MvVKtXBSBaEFPJAgQC8QpknBtqzKtXun+YPsb/vRXTV6RTgF3L3O6wRH2MUyVbI7hGIeHVTxeBmYrNkR3Q72YGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C+aNeD/f; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hpGVVPIIJee+1MFVUB7JeJUY5G2UB2KE/r9luD3eMj8=;
	t=1764339666; x=1765549266; b=C+aNeD/fsc9gKDBTA07eC6yHj4F6bqk+Xv1MJpVdQUEESUw
	dToodn/V9fcbGRwDR3JmtiS6Z9LJTqelkYyujkR0uk+Cn0coP/7ZryGCGD5V88PwFMLc6EPcasXJw
	jKU5HubE9FJUEBrSENx5Yww7bA0DAvXjx6pIPB8vD0ryB1KQJ7Mb89zEeXKjPtK8OPOXZW/vygBUw
	GDQ2cz2lg276PgS2rHaLFu3ErmNL3rmIw6yROrvKZOnE4o69Wg0QrUAcM+h6vp4HKTyZZwZpYkkhm
	IFwymdNHzcJAZG8mZVflP7WmWHbF9BJEI3sde6EWiebyKpmCJBWTu2U8PYUtXfCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLK-00000003926-0xZ8;
	Fri, 28 Nov 2025 15:21:02 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 04/18] wifi: mac80211_hwsim: move NAN related variables into a struct
Date: Fri, 28 Nov 2025 15:15:42 +0100
Message-ID: <20251128151537.83e21d5e3b5c.Ia82f11ae5cbd0ac02b3697d010489d5a93906d40@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128141537.287627-20-benjamin@sipsolutions.net>
References: <20251128141537.287627-20-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Move it all into a common struct to better segment the code.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 76 ++++++++++---------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index dc0ef30f96b1..05e27c2fbdc9 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -659,6 +659,15 @@ struct mac80211_hwsim_link_data {
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
@@ -754,12 +763,7 @@ struct mac80211_hwsim_data {
 
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
@@ -1979,9 +1983,9 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
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
@@ -3996,21 +4000,21 @@ mac80211_hwsim_nan_dw_start(struct hrtimer *timer)
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
 
@@ -4027,18 +4031,18 @@ mac80211_hwsim_nan_dw_start(struct hrtimer *timer)
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
@@ -4062,18 +4066,18 @@ static int mac80211_hwsim_start_nan(struct ieee80211_hw *hw,
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
 
@@ -4089,7 +4093,7 @@ static int mac80211_hwsim_start_nan(struct ieee80211_hw *hw,
 		hwsim_nan_cluster_id[5] = get_random_u8();
 	}
 
-	data->notify_dw = conf->enable_dw_notification;
+	data->nan.notify_dw = conf->enable_dw_notification;
 
 	cfg80211_nan_cluster_joined(wdev, hwsim_nan_cluster_id, true,
 				    GFP_KERNEL);
@@ -4104,16 +4108,16 @@ static int mac80211_hwsim_stop_nan(struct ieee80211_hw *hw,
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
@@ -4136,19 +4140,19 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
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
@@ -5519,7 +5523,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
 			NAN_DEV_CAPA_NDPE_SUPPORTED;
 
-		hrtimer_setup(&data->nan_timer, mac80211_hwsim_nan_dw_start,
+		hrtimer_setup(&data->nan.timer, mac80211_hwsim_nan_dw_start,
 			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS_SOFT);
 	}
 
-- 
2.51.1


