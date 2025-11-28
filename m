Return-Path: <linux-wireless+bounces-29416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86848C9251F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89D164E8BE7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4FA330B1B;
	Fri, 28 Nov 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HWnCirTy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEC432AAC0
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339685; cv=none; b=dU81fHaAfooVXJJJlH2r/SnJSRduQJi40QVarTTACyswyrT26B5HH3egz3ehozGgrx1mRIfByX4ZNltPJ41D2GiC1+nST+Xx12BixYmjyPaf7CxZXnUNew9scpYrnh7CV2XjGCwx0EhuOJUhCDQrbw5WBFRp84CA/GIcg54cHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339685; c=relaxed/simple;
	bh=59R/LjXYSjs1Tq40nDBrqD5fA5AzdUnVn49C1Sv5ozU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMeHVAi00BbL7feUmhYm8t6BUnTKfioDv72SAEMTyZN+lS1xgv9MOi3uY9cjCDy64G/wKDw3/5w2b6EpLhXlZY2erU3TZqE/C/rIC5OWwA7Y/F81C1HNlz+KMMuHoJbHSk7y9j0tT6Bp+jViBk+Q8czPyeKXUkr/Ff2SU8QMsQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HWnCirTy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=K5xyu2Gvly+rGa52dFCrbrsFp2Z9Tq2X3Q5H5Bzwi8s=;
	t=1764339683; x=1765549283; b=HWnCirTy4bpeZBekLd1uDU7t4Jl9qDbCYPGmxO086vzQnfG
	b2sKvHWW93Ojioy+5rXUdpXsV1GvHUqblreic9JOw4upXwRCOlsC82U1o7+U057hvl6bl2r9EUrtD
	Cu7lt9m+mhgzg6IKvKayBG8N8IU8FwhN5Vo7Yh/mAUi8YgkWLHC1A101isMpOX5cFJ46eRN6UdIXU
	8oZaeNXXUduf8uwHkNw8AZ5gAxVVVigNAiOEfSrGBoVdBj0BAhZDOjSa+ZmZeGmP/CHJwEm2VGSY7
	XFljh5I/7PiIhSnXGJlS4yTvTRoDEF13sXkIgC68ku/CDE9l8T2zeaF6czy39m+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLb-00000003926-2oWO;
	Fri, 28 Nov 2025 15:21:20 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 15/18] wifi: mac80211_hwsim: protect tsf_offset using a spinlock
Date: Fri, 28 Nov 2025 15:15:53 +0100
Message-ID: <20251128151537.22e352257823.I0da5477220b896e2177bd521f7d9a8f2595631e6@changeid>
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

To implement NAN synchronization in hwsim, the TSF needs to be adjusted
regularly from the RX path. Add a spinlock so that this can be done in a
safe manner.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
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
index 4e836289d58e..78f31921d8d7 100644
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
@@ -5320,6 +5334,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	hw->wiphy->mbssid_max_interfaces = 8;
 	hw->wiphy->ema_max_profile_periodicity = 3;
 
+	spin_lock_init(&data->tsf_offset_lock);
+
 	data->rx_rssi = DEFAULT_RX_RSSI;
 
 	INIT_DELAYED_WORK(&data->roc_start, hw_roc_start);
-- 
2.51.1


