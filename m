Return-Path: <linux-wireless+bounces-30468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E08BCFE769
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 16:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 343113097B4E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DF833C1B7;
	Wed,  7 Jan 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YaH0w/C9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27733C19C
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795823; cv=none; b=YEE06OrabdAZQ/vm6uUYT8CWQ4RoOc5gLSWY9aPCIBx5ohP1zjaZJRAHoSK0ikyF18et1L4ms72FrP2+89x0aLgQUw09pTQosPCcpi93i9TAJFKJy6U9Mw2buK/vuI6bBUWQrdnA/Bs2OuHz6AHL96fxoWjqzlIiYDrEe9tsaAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795823; c=relaxed/simple;
	bh=+NrsJg7cvI9DoXiIDMVzvFpAfpsId7PTEeoHJ/M9dCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGivZ3zwfs4milaFqIsIN98iG+AYgALC3wJiLFPSWI17n/bCg3kEIQUekee9gnoTpz9w8maxMkjpHM8fGpKPslktbko+vt26Ki1SB0mZc9oTyLKtLkGSvEmxYPgwBm1sbmchYtFXQJc+/KO7s7NhEqjLYouIAglf7Yiii8rWCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YaH0w/C9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=m6kpLRZVTGBmDO7jNTedaL8ukyJUnbphZLKVMvieio8=;
	t=1767795821; x=1769005421; b=YaH0w/C9rYQff4ptHZbfEmnfFhA/NMKDEWPnQ7Xu5jaMwlb
	l9ESxbgh39JUBsBOkMYLnaGMwLgPBghgnanGqPO+nUerCOKYNkAyvsg99qwH8og508C0xafyAcetn
	IMMF5zk0wMA76d1yRR8m/tuSWhDVt4AZ7loDF6QF0Eh4JPzDiJItXkMv+SU04nmdLOecpluba9TYd
	u2oCgc2f+CKA/zA2q2bF0gh1vPK0jMJcfDfwEE89zDwnrfJwj32C5REYksAEXedpDscgAZ0cETKgm
	ZDWjs2rxt+bvR8ET6OT/Y9zAI/xVRip9mnJA3elFnx0EiY0tArAoa1cjMJbUOTpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURn-00000005agF-0Ubj;
	Wed, 07 Jan 2026 15:23:39 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 07/46] wifi: mac80211_hwsim: rename and switch simulation time to boottime
Date: Wed,  7 Jan 2026 15:22:06 +0100
Message-ID: <20260107152324.f2174011165c.I2ef047f3cdd6dc52af4bb7bf747368fb78014f18@changeid>
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

The mac80211_hwsim base time for the simulation of the TSF was based on
the real time of the system. This clock is subject to unexpected
changes. Switch it to use boottime which is always monotonic and also
continues to run through times where the system is suspended.

Also change the function name from tsf_raw to sim_tsf to better
differentiate between the TSF of the mac and the TSF base of the
simulation.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 33 ++++++++++---------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index d933e91d7700..fc02a008f612 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1111,22 +1111,25 @@ static netdev_tx_t hwsim_mon_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static inline u64 mac80211_hwsim_get_tsf_raw(void)
+static inline u64 mac80211_hwsim_get_sim_tsf(void)
 {
-	return ktime_to_us(ktime_get_real());
-}
-
-static __le64 __mac80211_hwsim_get_tsf(struct mac80211_hwsim_data *data)
-{
-	u64 now = mac80211_hwsim_get_tsf_raw();
-	return cpu_to_le64(now + data->tsf_offset);
+	return ktime_to_us(ktime_get_boottime());
 }
 
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
-	return le64_to_cpu(__mac80211_hwsim_get_tsf(data));
+	u64 sim_time = mac80211_hwsim_get_sim_tsf();
+
+	return sim_time + data->tsf_offset;
+}
+
+static __le64 __mac80211_hwsim_get_tsf(struct mac80211_hwsim_data *data)
+{
+	u64 sim_time = mac80211_hwsim_get_sim_tsf();
+
+	return cpu_to_le64(sim_time + data->tsf_offset);
 }
 
 static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
@@ -1678,7 +1681,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_rx_status rx_status;
-	u64 now;
+	u64 sim_tsf;
 
 	memset(&rx_status, 0, sizeof(rx_status));
 	rx_status.flag |= RX_FLAG_MACTIME_START;
@@ -1731,9 +1734,9 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	if (ieee80211_is_beacon(hdr->frame_control) ||
 	    ieee80211_is_probe_resp(hdr->frame_control)) {
 		rx_status.boottime_ns = ktime_get_boottime_ns();
-		now = data->abs_bcn_ts;
+		sim_tsf = data->abs_bcn_ts;
 	} else {
-		now = mac80211_hwsim_get_tsf_raw();
+		sim_tsf = mac80211_hwsim_get_sim_tsf();
 	}
 
 	/* Copy skb to all enabled radios that are on the current frequency */
@@ -1794,7 +1797,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 		if (mac80211_hwsim_addr_match(data2, hdr->addr1))
 			ack = true;
 
-		rx_status.mactime = now + data2->tsf_offset;
+		rx_status.mactime = sim_tsf + data2->tsf_offset;
 
 		mac80211_hwsim_rx(data2, &rx_status, nskb);
 	}
@@ -2011,7 +2014,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		txrate = ieee80211_get_tx_rate(hw, txi);
 		if (txrate)
 			bitrate = txrate->bitrate;
-		ts = mac80211_hwsim_get_tsf_raw();
+		ts = mac80211_hwsim_get_sim_tsf();
 		mgmt->u.probe_resp.timestamp =
 			cpu_to_le64(ts + data->tsf_offset +
 				    24 * 8 * 10 / bitrate);
@@ -2194,7 +2197,7 @@ static void __mac80211_hwsim_beacon_tx(struct ieee80211_bss_conf *link_conf,
 
 	mgmt = (struct ieee80211_mgmt *) skb->data;
 	/* fake header transmission time */
-	data->abs_bcn_ts = mac80211_hwsim_get_tsf_raw();
+	data->abs_bcn_ts = mac80211_hwsim_get_sim_tsf();
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
 		struct ieee80211_ext *ext = (void *) mgmt;
 
-- 
2.52.0


