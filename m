Return-Path: <linux-wireless+bounces-30470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AB7CFF676
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B88B13008C45
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAFC32FA30;
	Wed,  7 Jan 2026 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mAKPDKur"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EF433C1B0
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795824; cv=none; b=m7z6OFCH+unVkgHjJWJ6I1AnueVJ1NgL77umI4dvl1glAjBdg/Q9OJ5UlfVIqPofV9QgeKwFH5u53nzvUdjoSmgqx92sOjEbTiCpJ+Rr1lu3ueIqq3Fv17YRT5zDk8FNQBb/g96f4MjFroK7TcNU6D4AXai9JpBCY79g94gb06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795824; c=relaxed/simple;
	bh=u/y+IoSyJDd10RfaX650Vu13eURI3bUbqKoNYeyVAnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQxjUVfUw7weNejE/MBs5u4Lp1ws5nxc1OEssy6TnX+0ASHQityKsIxnmZCiASD+DmKJHSSToeF0oQGdVsB9TdwAdy2YxdWsQbCq/qN78kN3FHJrE+oQ4wc3GdDgtuGPZGKqcW3pXHtpJXSBeZ3EjvK6Iv6uVTpu2PuQ8Pn0vz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mAKPDKur; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=arfijmCxRLCHEf1JNjVDTYtkdPpvqixApmBl3LfdGFA=;
	t=1767795823; x=1769005423; b=mAKPDKurbbEoQYep4oWDngKKrJvFifm6rakEsgFdSnkv8Je
	pMo+Z9BEuvRCNKCNNZbl2zhNuSYVn9wGU/diyG07SvKQHOaO1+66mUlVc7JfzbYMm6lx5E+bWcA0q
	uitaECSni5qF0s2/VwH9dTvYMui7iIfwcJQEucH7AuwZ53KHoGnYJSZGuhqkk/zK9Yy6Jioe+LzxA
	aIu+3+6e57bv7eGMYzNl51knWe4jwWzCb7kSiPQy8UyzBoPePRzfcAc+8hi2/8zgm+iI9yXhkJ/M7
	8szupy/+Jec44mQK6DK8v5XlOdhLaz6mndqjiY7myiiXzrtXlXrNVMShDOAGtnOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURo-00000005agF-0vqG;
	Wed, 07 Jan 2026 15:23:40 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 08/46] wifi: mac80211_hwsim: move timestamp writing later in the datapath
Date: Wed,  7 Jan 2026 15:22:07 +0100
Message-ID: <20260107152324.31a9752df348.I86810bbbf9b171acc6dbf07f9904ce1686b5167a@changeid>
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

By delegating writing the timestamp into beacons and probe responses, we
can remove the abs_bcn_ts from the global data and still avoid any time
offset issues. This also seems conceptually closer to "real" hardware
where the timestamp will be written late in the TX path.

Move sending the SKB to the monitor interface to happen later, so that
the frame timestamp has the value filled in by mac80211_hwsim.

type=maint
ticket=none

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |   2 -
 .../wireless/virtual/mac80211_hwsim_main.c    | 110 ++++++++----------
 2 files changed, 49 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index e1a36eb7a3d5..5aae80cee8ec 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -103,8 +103,6 @@ struct mac80211_hwsim_data {
 	/* difference between this hw's clock and the real clock, in usecs */
 	s64 tsf_offset;
 	s64 bcn_delta;
-	/* absolute beacon transmission time. Used to cover up "tx" delay. */
-	u64 abs_bcn_ts;
 
 	/* Stats */
 	u64 tx_pkts;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index fc02a008f612..59cf2433b4b6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1423,6 +1423,43 @@ static inline u16 trans_tx_rate_flags_ieee2hwsim(struct ieee80211_tx_rate *rate)
 	return result;
 }
 
+static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
+				     struct sk_buff *skb, u64 sim_time)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_rate *txrate;
+	/* TODO: get MCS */
+	int bitrate = 100;
+
+	txrate = ieee80211_get_tx_rate(data->hw, info);
+	if (txrate)
+		bitrate = txrate->bitrate;
+
+	if (skb->len >= offsetofend(typeof(*mgmt), u.probe_resp.timestamp) &&
+	    ieee80211_is_probe_resp(hdr->frame_control)) {
+		mgmt->u.probe_resp.timestamp =
+			cpu_to_le64(sim_time + data->tsf_offset +
+				    24 * 8 * 10 / bitrate);
+	} else if (skb->len >= offsetofend(typeof(*mgmt), u.beacon.timestamp) &&
+		   ieee80211_is_beacon(mgmt->frame_control)) {
+		mgmt->u.beacon.timestamp = cpu_to_le64(sim_time +
+						       data->tsf_offset +
+						       24 * 8 * 10 /
+						       bitrate);
+	} else if (skb->len >= offsetofend(struct ieee80211_ext,
+					   u.s1g_beacon.timestamp) &&
+		   ieee80211_is_s1g_beacon(mgmt->frame_control)) {
+		struct ieee80211_ext *ext = (void *)mgmt;
+
+		ext->u.s1g_beacon.timestamp = cpu_to_le32(sim_time +
+							  data->tsf_offset +
+							  10 * 8 * 10 /
+							  bitrate);
+	}
+}
+
 static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 				       struct sk_buff *my_skb,
 				       int dst_portid,
@@ -1438,6 +1475,7 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 	struct hwsim_tx_rate tx_attempts[IEEE80211_TX_MAX_RATES];
 	struct hwsim_tx_rate_flag tx_attempts_flags[IEEE80211_TX_MAX_RATES];
 	uintptr_t cookie;
+	u64 sim_tsf;
 
 	if (data->ps != PS_DISABLED)
 		hdr->frame_control |= cpu_to_le16(IEEE80211_FCTL_PM);
@@ -1450,6 +1488,9 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 		}
 	}
 
+	sim_tsf = mac80211_hwsim_get_sim_tsf();
+	mac80211_hwsim_write_tsf(data, my_skb, sim_tsf);
+
 	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 	if (skb == NULL)
 		goto nla_put_failure;
@@ -1681,7 +1722,11 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_rx_status rx_status;
-	u64 sim_tsf;
+	u64 sim_tsf = mac80211_hwsim_get_sim_tsf();
+
+	mac80211_hwsim_write_tsf(data, skb, sim_tsf);
+
+	mac80211_hwsim_monitor_rx(hw, skb, chan);
 
 	memset(&rx_status, 0, sizeof(rx_status));
 	rx_status.flag |= RX_FLAG_MACTIME_START;
@@ -1724,20 +1769,9 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	skb_ext_reset(skb);
 	nf_reset_ct(skb);
 
-	/*
-	 * Get absolute mactime here so all HWs RX at the "same time", and
-	 * absolute TX time for beacon mactime so the timestamp matches.
-	 * Giving beacons a different mactime than non-beacons looks messy, but
-	 * it helps the Toffset be exact and a ~10us mactime discrepancy
-	 * probably doesn't really matter.
-	 */
 	if (ieee80211_is_beacon(hdr->frame_control) ||
-	    ieee80211_is_probe_resp(hdr->frame_control)) {
+	    ieee80211_is_probe_resp(hdr->frame_control))
 		rx_status.boottime_ns = ktime_get_boottime_ns();
-		sim_tsf = data->abs_bcn_ts;
-	} else {
-		sim_tsf = mac80211_hwsim_get_sim_tsf();
-	}
 
 	/* Copy skb to all enabled radios that are on the current frequency */
 	spin_lock(&hwsim_radio_lock);
@@ -2001,27 +2035,6 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 			return;
 	}
 
-	if (skb->len >= 24 + 8 &&
-	    ieee80211_is_probe_resp(hdr->frame_control)) {
-		/* fake header transmission time */
-		struct ieee80211_mgmt *mgmt;
-		struct ieee80211_rate *txrate;
-		/* TODO: get MCS */
-		int bitrate = 100;
-		u64 ts;
-
-		mgmt = (struct ieee80211_mgmt *)skb->data;
-		txrate = ieee80211_get_tx_rate(hw, txi);
-		if (txrate)
-			bitrate = txrate->bitrate;
-		ts = mac80211_hwsim_get_sim_tsf();
-		mgmt->u.probe_resp.timestamp =
-			cpu_to_le64(ts + data->tsf_offset +
-				    24 * 8 * 10 / bitrate);
-	}
-
-	mac80211_hwsim_monitor_rx(hw, skb, channel);
-
 	/* wmediumd mode check */
 	_portid = READ_ONCE(data->wmediumd);
 
@@ -2155,8 +2168,6 @@ static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 				       ARRAY_SIZE(txi->control.rates));
 	}
 
-	mac80211_hwsim_monitor_rx(hw, skb, chan);
-
 	if (_portid || hwsim_virtio_enabled)
 		return mac80211_hwsim_tx_frame_nl(hw, skb, _portid, chan);
 
@@ -2174,10 +2185,6 @@ static void __mac80211_hwsim_beacon_tx(struct ieee80211_bss_conf *link_conf,
 {
 	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
 	struct ieee80211_tx_info *info;
-	struct ieee80211_rate *txrate;
-	struct ieee80211_mgmt *mgmt;
-	/* TODO: get MCS */
-	int bitrate = 100;
 
 	if (vp->skip_beacons[link_conf->link_id]) {
 		vp->skip_beacons[link_conf->link_id]--;
@@ -2191,27 +2198,6 @@ static void __mac80211_hwsim_beacon_tx(struct ieee80211_bss_conf *link_conf,
 				       info->control.rates,
 				       ARRAY_SIZE(info->control.rates));
 
-	txrate = ieee80211_get_tx_rate(hw, info);
-	if (txrate)
-		bitrate = txrate->bitrate;
-
-	mgmt = (struct ieee80211_mgmt *) skb->data;
-	/* fake header transmission time */
-	data->abs_bcn_ts = mac80211_hwsim_get_sim_tsf();
-	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
-		struct ieee80211_ext *ext = (void *) mgmt;
-
-		ext->u.s1g_beacon.timestamp = cpu_to_le32(data->abs_bcn_ts +
-							  data->tsf_offset +
-							  10 * 8 * 10 /
-							  bitrate);
-	} else {
-		mgmt->u.beacon.timestamp = cpu_to_le64(data->abs_bcn_ts +
-						       data->tsf_offset +
-						       24 * 8 * 10 /
-						       bitrate);
-	}
-
 	mac80211_hwsim_tx_frame(hw, skb,
 			rcu_dereference(link_conf->chanctx_conf)->def.chan);
 }
@@ -5814,6 +5800,8 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 	if (!found)
 		goto out;
 
+	mac80211_hwsim_monitor_rx(data2->hw, skb, data2->channel);
+
 	/* Tx info received because the frame was broadcasted on user space,
 	 so we get all the necessary info: tx attempts and skb control buff */
 
-- 
2.52.0


