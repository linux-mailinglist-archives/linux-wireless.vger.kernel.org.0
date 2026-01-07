Return-Path: <linux-wireless+bounces-30477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C18CFE58F
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37FBB300E794
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CA033D6D4;
	Wed,  7 Jan 2026 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iiN1+dCC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A4333D6C6
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795831; cv=none; b=ncNiNtb/gFdJzL4rZMEEtF6cmWULKpbsTnXLVd+BV5+R10WFIDZgG1/s1QrpN/FvnpxqxILym0dGpDJ7srbjCoVjpFVp1CyT0el/92xfCYBN8hLrmVACvGO45YLpsfYhDafDafinQsJUaLbky7mjbh1AicJU0F0bAwXSCoBuR9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795831; c=relaxed/simple;
	bh=LIJbHFuWhBiAcmUET9MhvV3nkaP0hpm7zfw1isvxv1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/fjshh6EWAsvoMMQUVOJBi+OpKMWWabIRmpVxcV+Q/oX55ISwpwrT/dyO0a/n9q/DTThHTY42pNzaw4WxgjqbCeclOWgkyezomiw3pSsuFiRq3UDaWLdni0dwB4AXz98N5BEvwRkpVydttPtDyPTo5VkEAbHhpBsuM6m8FxzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iiN1+dCC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OMQJAiMFlV/b/VQiAHCHQsElvzga/VQR9OXuUFyFmkU=;
	t=1767795830; x=1769005430; b=iiN1+dCCjy3HkamtCJB33n9gLp/BAZxphSiq7msbEqp3sa2
	J4uqxBryep7SJFVObROdeVtRDclkPiXnl5tBvH/VuSAqQIXXhb3gMkyrolNJZ75lIeYAkfBRiDD+w
	H1tkHVkUIFgsLhR8HLeeOmVFcpQDSWR7l2UGXeEXA+aJDwRlZZ1Rof2LLaB9mQf/1D/bO/9FNX1EI
	ugjL56fjOCxLXvHxUmmTcskE79Y8HhNfkiKqV0B0USkWHt2pQrs72BL9F/t8avCg6NcWBjJCqVzR4
	2l93w0JzRVxMfhRC9HWwB6EW76dfpPTG64lO/tQMX0P5d7dVm/MWwsAyFs5SkhPw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURv-00000005agF-14K9;
	Wed, 07 Jan 2026 15:23:47 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 16/46] wifi: mac80211_hwsim: protect tsf_offset using a spinlock
Date: Wed,  7 Jan 2026 15:22:15 +0100
Message-ID: <20260107152325.789b81f89c0b.I0da5477220b896e2177bd521f7d9a8f2595631e6@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

To implement NAN synchronization in hwsim, the TSF needs to be adjusted
regularly from the RX path. Add a spinlock so that this can be done in a
safe manner.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |  1 +
 .../wireless/virtual/mac80211_hwsim_main.c    | 34 ++++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index 0cc87205554e..ee566aff4785 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -101,6 +101,7 @@ struct mac80211_hwsim_data {
 	u32 wmediumd;
 
 	/* difference between this hw's clock and the real clock, in usecs */
+	spinlock_t tsf_offset_lock;
 	s64 tsf_offset;
 
 	/* Stats */
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 5c74b5e5a2b5..09b4c2eec6c3 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1119,13 +1119,17 @@ static inline u64 mac80211_hwsim_get_sim_tsf(void)
 ktime_t mac80211_hwsim_tsf_to_boottime(struct mac80211_hwsim_data *data,
 				       u64 tsf)
 {
-	return us_to_ktime(tsf - data->tsf_offset);
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return us_to_ktime(tsf - data->tsf_offset);
+	}
 }
 
 u64 mac80211_hwsim_boottime_to_tsf(struct mac80211_hwsim_data *data,
 				   ktime_t ts)
 {
-	return ktime_to_us(ts + data->tsf_offset);
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return ktime_to_us(ts) + data->tsf_offset;
+	}
 }
 
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
@@ -1134,14 +1138,18 @@ u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 	struct mac80211_hwsim_data *data = hw->priv;
 	u64 sim_time = mac80211_hwsim_get_sim_tsf();
 
-	return sim_time + data->tsf_offset;
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return sim_time + data->tsf_offset;
+	}
 }
 
 static __le64 __mac80211_hwsim_get_tsf(struct mac80211_hwsim_data *data)
 {
 	u64 sim_time = mac80211_hwsim_get_sim_tsf();
 
-	return cpu_to_le64(sim_time + data->tsf_offset);
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return cpu_to_le64(sim_time + data->tsf_offset);
+	}
 }
 
 static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
@@ -1156,11 +1164,13 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 	if (conf && !conf->enable_beacon)
 		return;
 
-	/* adjust after beaconing with new timestamp at old TBTT */
-	if (tsf > now)
-		data->tsf_offset += delta;
-	else
-		data->tsf_offset -= delta;
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		/* adjust after beaconing with new timestamp at old TBTT */
+		if (tsf > now)
+			data->tsf_offset += delta;
+		else
+			data->tsf_offset -= delta;
+	}
 }
 
 static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
@@ -1440,6 +1450,8 @@ static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
 	/* TODO: get MCS */
 	int bitrate = 100;
 
+	spin_lock_bh(&data->tsf_offset_lock);
+
 	txrate = ieee80211_get_tx_rate(data->hw, info);
 	if (txrate)
 		bitrate = txrate->bitrate;
@@ -1465,6 +1477,8 @@ static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
 							  10 * 8 * 10 /
 							  bitrate);
 	}
+
+	spin_unlock_bh(&data->tsf_offset_lock);
 }
 
 static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
@@ -5324,6 +5338,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	hw->wiphy->mbssid_max_interfaces = 8;
 	hw->wiphy->ema_max_profile_periodicity = 3;
 
+	spin_lock_init(&data->tsf_offset_lock);
+
 	data->rx_rssi = DEFAULT_RX_RSSI;
 
 	INIT_DELAYED_WORK(&data->roc_start, hw_roc_start);
-- 
2.52.0


