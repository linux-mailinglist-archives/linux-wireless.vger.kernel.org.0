Return-Path: <linux-wireless+bounces-29418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2551C924DD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050903AB3D5
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0222773E3;
	Fri, 28 Nov 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Qsls/60s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B0331235
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339689; cv=none; b=AJCh3QmjUbOCEfRfnwCZihAYDZaSUMYlc9egx+eVubLHPLK2yJKUmOAgqkhcXPid6cyM8qEMQQco6m3w/7om4ABcuTcJxgrux4S4fowv4z0+FuOlxXoGf15n0FOhA+LWscRwKvT9CmPw1Iv737o3UVTjKCY1b9ovBixgMbHgtOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339689; c=relaxed/simple;
	bh=QvSrjn6EgGCsoUXY1csP2YFYcfjBkfVdUmfCsiC0jB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALI+n0DumXAaOC5j3vDck4LDF+fawj6iOwYZ4ko5NWeDim556XFhhzQK1KJ2Se2zrLXMXqqNdxvtA142iWKJRKZ9TItFmIXU3oLGLGvbvjN/WelBFw3QJvCJR24jZjkRTLMEkntQLYfWUGZOc1vhtrNx9hNPG1JVb1sAYmrKQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Qsls/60s; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YqkvuTpxnujs7Hf0p2lEW25IQ0/bzl5W7dib1ZQ2+rE=;
	t=1764339686; x=1765549286; b=Qsls/60sefXmiHfzTGzVf4O0jh5LAX2gTdDIHlr/WTYfOub
	MLk6Hp/2tT3waiTcP4tDMeZeyVnAGTJwn581BtTKOu7a1w3pvO8h/KMHylbhBWwGxBaYIR0lY2eSH
	QQ0F5bHzRvveX1EV/yve3uZc93tCRQFrVj0EE13qlaHQI86o5qjt64licESE4tdrEFDegcs5q5O7P
	biqcvJJ5niDNxeUhhpH8n0OrWrhNAUSXqVyKKo1c86bD+rp1bbGrlvDk7MeDa5mJuPKpbU82HDZkV
	eOuuaIiRUokNEiu1wm+jCAlxWq6wXIswA6J2afV70tMSYs9YHod333oWM/+IrOng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLf-00000003926-3NSe;
	Fri, 28 Nov 2025 15:21:24 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 18/18] wifi: mac80211_hwsim: implement NAN synchronization
Date: Fri, 28 Nov 2025 15:15:56 +0100
Message-ID: <20251128151537.5d2961bce1fe.I98b6c15eadefd6d123658294ef1a0cd3c2ce3054@changeid>
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

Add all the handling to do NAN synchronization on 2.4 GHz including
sending out beacons. With this, the mac80211_hwsim NAN device also works
when used in conjunction with an external medium simulation.

Note that the TSF sync is not ideal in case of an external medium
simulation. This is because the mactime for received frames needs to be
estimated and the simulation may not update the timestamp of beacons
to the actual time that the frame was transmitted.

The implementation has an initial short phase where it scans for
clusters. This facilitates cluster joining and avoids creating a new
cluster immediately, which would result in two cluster join
notifications. It does not scan otherwise and will only see another
cluster appearing if a discovery beacon happens to be sent during the
2.4 GHz discovery window (DW).

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |   4 +
 .../wireless/virtual/mac80211_hwsim_main.c    |  18 +-
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 721 +++++++++++++++++-
 .../net/wireless/virtual/mac80211_hwsim_nan.h |  43 ++
 4 files changed, 743 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index ee566aff4785..a42f94dd6d6a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -136,6 +136,10 @@ u64 mac80211_hwsim_boottime_to_tsf(struct mac80211_hwsim_data *data,
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif);
 
+void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
+			     struct sk_buff *skb,
+			     struct ieee80211_channel *chan);
+
 void ieee80211_hwsim_wake_tx_queue(struct ieee80211_hw *hw,
 				   struct ieee80211_txq *txq);
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 78f31921d8d7..78d658bc6478 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -914,10 +914,6 @@ static int hwsim_get_chanwidth(enum nl80211_chan_width bw)
 	return INT_MAX;
 }
 
-static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
-				    struct sk_buff *skb,
-				    struct ieee80211_channel *chan);
-
 /* sysfs attributes */
 static void hwsim_send_ps_poll(void *dat, u8 *mac, struct ieee80211_vif *vif)
 {
@@ -1728,6 +1724,9 @@ static void mac80211_hwsim_rx(struct mac80211_hwsim_data *data,
 
 	mac80211_hwsim_add_vendor_rtap(skb);
 
+	if (data->nan.device_vif)
+		mac80211_hwsim_nan_rx(data->hw, skb);
+
 	data->rx_pkts++;
 	data->rx_bytes += skb->len;
 	ieee80211_rx_irqsafe(data->hw, skb);
@@ -2182,9 +2181,9 @@ static void mac80211_hwsim_remove_interface(
 		mac80211_hwsim_config_mac_nl(hw, vif->addr, false);
 }
 
-static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
-				    struct sk_buff *skb,
-				    struct ieee80211_channel *chan)
+void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
+			     struct sk_buff *skb,
+			     struct ieee80211_channel *chan)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	u32 _portid = READ_ONCE(data->wmediumd);
@@ -5281,6 +5280,11 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		hrtimer_setup(&data->nan.resume_txqs_timer,
 			      mac80211_hwsim_nan_resume_txqs_timer,
 			      CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
+		hrtimer_setup(&data->nan.discovery_beacon_timer,
+			      mac80211_hwsim_nan_discovery_beacon_timer,
+			      CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
+
+		spin_lock_init(&data->nan.state_lock);
 	}
 
 	data->if_combination.radar_detect_widths =
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index acc1cd6e24ac..ded629f0d4af 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2025 Intel Corporation
  */
 
+#include <net/cfg80211.h>
 #include "mac80211_hwsim_i.h"
 
 /* Defined as the lower 23 bits being zero */
@@ -26,11 +27,15 @@
 static_assert(16 * DWST_TU * 1024 == 8192 * 1024);
 static_assert(DW0_TSF_MASK + 1 == 8192 * 1024);
 
+/* warmup phase should be 120 seconds, which is approximately 225 DWSTs */
+#define NAN_WARMUP_DWST		225
+
+#define NAN_RSSI_CLOSE (-60)
+#define NAN_RSSI_MIDDLE (-75)
+
 /* Quiet time at the end of each slot where TX is suppressed */
 #define NAN_CHAN_SWITCH_TIME_US		256
 
-static u8 hwsim_nan_cluster_id[ETH_ALEN];
-
 static void mac80211_hwsim_nan_resume_txqs(struct mac80211_hwsim_data *data);
 
 static u64 hwsim_nan_get_timer_tsf(struct mac80211_hwsim_data *data)
@@ -45,10 +50,43 @@ static u8 hwsim_nan_slot_from_tsf(u64 tsf)
 	return (tsf & DWST_TSF_MASK) / ieee80211_tu_to_usec(SLOT_TU);
 }
 
+static u64 hwsim_nan_encode_master_rank(u8 master_pref, u8 random_factor,
+					const u8 *addr)
+{
+	return ((u64)master_pref << 56) +
+		((u64)random_factor << 48) +
+		((u64)addr[5] << 40) +
+		((u64)addr[4] << 32) +
+		((u64)addr[3] << 24) +
+		((u64)addr[2] << 16) +
+		((u64)addr[1] << 8) +
+		((u64)addr[0] << 0);
+}
+
+static u64 hwsim_nan_get_master_rank(struct mac80211_hwsim_data *data)
+{
+	u8 master_pref = 0;
+	u8 random_factor = 0;
+
+	if (data->nan.phase == MAC80211_HWSIM_NAN_PHASE_UP) {
+		master_pref = data->nan.master_pref;
+		random_factor = data->nan.random_factor;
+	}
+
+	return hwsim_nan_encode_master_rank(master_pref, random_factor,
+					    data->nan.device_vif->addr);
+}
+
 static void
-mac80211_hwsim_nan_schedule_slot(struct mac80211_hwsim_data *data, u8 slot)
+mac80211_hwsim_nan_schedule_slot(struct mac80211_hwsim_data *data, u8 slot,
+				 bool discontinuity)
 {
-	u64 tsf = hwsim_nan_get_timer_tsf(data);
+	u64 tsf;
+
+	if (!discontinuity)
+		tsf = hwsim_nan_get_timer_tsf(data);
+	else
+		tsf = mac80211_hwsim_get_tsf(data->hw, data->nan.device_vif);
 
 	/* Only called by mac80211_hwsim_nan_dw_timer from softirq context */
 	lockdep_assert_in_softirq();
@@ -60,16 +98,564 @@ mac80211_hwsim_nan_schedule_slot(struct mac80211_hwsim_data *data, u8 slot)
 			    mac80211_hwsim_tsf_to_boottime(data, tsf));
 }
 
+void mac80211_hwsim_nan_rx(struct ieee80211_hw *hw,
+			   struct sk_buff *skb)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	const struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	struct element *nan_elem = (void *)mgmt->u.beacon.variable;
+	struct ieee80211_nan_anchor_master_info *ami = NULL;
+	const struct ieee80211_nan_attr *nan_attr;
+	struct ieee80211_rx_status rx_status;
+	bool joined_cluster = false;
+	bool adopt_tsf = false;
+	bool is_sync_beacon;
+	bool is_same_cluster;
+	u64 master_rank = 0;
+	ssize_t data_len;
+	u8 slot;
+
+	/* Need a NAN vendor element at the start */
+	if (skb->len < (offsetofend(struct ieee80211_mgmt, u.beacon) + 6) ||
+	    !ieee80211_is_beacon(mgmt->frame_control))
+		return;
+
+	data_len = skb->len - offsetofend(struct ieee80211_mgmt, u.beacon);
+
+	/* Copy the RX status to add a MAC timestamp if needed */
+	memcpy(&rx_status, IEEE80211_SKB_RXCB(skb),
+	       sizeof(struct ieee80211_rx_status));
+
+	/* And deal with the lack of mac time stamp */
+	if ((rx_status.flag & RX_FLAG_MACTIME) != RX_FLAG_MACTIME_START) {
+		u64 tsf = mac80211_hwsim_get_tsf(hw, data->nan.device_vif);;
+
+		/* In that case there should be no timestamp */
+		WARN_ON_ONCE(rx_status.flag & RX_FLAG_MACTIME);
+
+		/* No mac timestamp, set current TSF for the frame end */
+		rx_status.flag |= RX_FLAG_MACTIME_END;
+		rx_status.mactime = tsf;
+
+		/* And translate to the start for the rest of the code */
+		rx_status.mactime =
+			ieee80211_calculate_rx_timestamp(hw, &rx_status,
+							 skb->len, 0);
+		rx_status.flag &= ~RX_FLAG_MACTIME;
+		rx_status.flag |= RX_FLAG_MACTIME_START;
+
+		/* Match mac80211_hwsim_nan_receive, see comment there */
+		slot = hwsim_nan_slot_from_tsf(tsf + 128);
+	} else {
+		slot = hwsim_nan_slot_from_tsf(rx_status.mactime);
+	}
+
+	/*
+	 * (overly) simplify things, only track 2.4 GHz here. Also, ignore
+	 * frames outside of the 2.4 GHz DW slot, unless in the initial SCAN
+	 * phase.
+	 */
+	if ((slot != SLOT_24GHZ_DW &&
+	     data->nan.phase != MAC80211_HWSIM_NAN_PHASE_SCAN) ||
+	    rx_status.freq != 2437)
+		return;
+
+	/* Just ignore low RSSI beacons that we cannot sync to */
+	if (rx_status.signal < NAN_RSSI_MIDDLE)
+		return;
+
+	/* Needs to be a valid NAN cluster ID in A3 */
+	if (get_unaligned_be32(mgmt->bssid) != ((WLAN_OUI_WFA << 8) | 0x01))
+		return;
+
+	/* We are only interested in NAN beacons */
+	if (nan_elem->id != WLAN_EID_VENDOR_SPECIFIC ||
+	    nan_elem->datalen < 4 ||
+	    get_unaligned_be32(nan_elem->data) !=
+	    (WLAN_OUI_WFA << 8 | WLAN_OUI_TYPE_WFA_NAN))
+		return;
+
+	u8 *nan_defragmented __free(kfree) = kzalloc(data_len, GFP_ATOMIC);
+	data_len = cfg80211_defragment_element(nan_elem,
+					       mgmt->u.beacon.variable,
+					       data_len,
+					       nan_defragmented, data_len,
+					       WLAN_EID_FRAGMENT);
+
+	if (data_len < 0)
+		return;
+
+	/* Assume it is a synchronization beacon if beacon_int is 512 TUs */
+	is_sync_beacon = le16_to_cpu(mgmt->u.beacon.beacon_int) == DWST_TU;
+	is_same_cluster = ether_addr_equal(mgmt->bssid, data->nan.cluster_id);
+
+	for_each_nan_attr(nan_attr, nan_defragmented + 4, data_len - 4) {
+		if (nan_attr->attr == NAN_ATTR_MASTER_INDICATION &&
+		    le16_to_cpu(nan_attr->length) >=
+		    sizeof(struct ieee80211_nan_master_indication)) {
+			struct ieee80211_nan_master_indication *mi =
+				(void *)nan_attr->data;
+
+			master_rank =
+				hwsim_nan_encode_master_rank(mi->master_pref,
+							     mi->random_factor,
+							     mgmt->sa);
+		}
+
+		if (nan_attr->attr == NAN_ATTR_CLUSTER_INFO &&
+		    le16_to_cpu(nan_attr->length) >=
+		    sizeof(struct ieee80211_nan_anchor_master_info)) {
+			ami = (void *)nan_attr->data;
+
+			/*
+			 * The AMBTT should be set to the beacon timestamp when
+			 * the sender is the anchor master. We can simply
+			 * modify the structure because we created a copy when
+			 * defragmenting the NAN element.
+			 */
+			if (ami->hop_count == 0)
+				ami->ambtt = cpu_to_le32(
+					le64_to_cpu(mgmt->u.beacon.timestamp));
+		}
+	}
+
+	/* Do the rest of the processing under lock */
+	spin_lock_bh(&data->nan.state_lock);
+
+	/*
+	 * sync beacon should be discarded if the master rank is the same
+	 * and the AMBTT is older than 16 * 512 TUs compared to our own TSF.
+	 *
+	 * Subtract the AMBTT from the lowered TSF. If the AMBTT is older
+	 * (smaller) then the calculation will not underflow.
+	 */
+	if (is_sync_beacon && ami &&
+	    ami->master_rank == data->nan.current_ami.master_rank &&
+	    (((u32)rx_status.mactime -
+	      ieee80211_tu_to_usec(16 * 512)) -
+	     le32_to_cpu(ami->ambtt)) < 0x8000000) {
+		wiphy_dbg(hw->wiphy,
+			  "NAN: ignoring sync beacon with old AMBTT\n");
+		is_sync_beacon = false;
+	}
+
+	if (is_same_cluster && is_sync_beacon &&
+	    master_rank > hwsim_nan_get_master_rank(data)) {
+		if (rx_status.signal > NAN_RSSI_CLOSE)
+			data->nan.master_transition_score += 3;
+		else
+			data->nan.master_transition_score += 1;
+	}
+
+	if (is_same_cluster && is_sync_beacon && ami &&
+	    ((ami->master_rank == data->nan.current_ami.master_rank &&
+	      ami->hop_count < data->nan.current_ami.hop_count) ||
+	     (master_rank > hwsim_nan_get_master_rank(data) &&
+	      ami->hop_count == data->nan.current_ami.hop_count))) {
+		if (rx_status.signal > NAN_RSSI_CLOSE)
+			data->nan.sync_transition_score += 3;
+		else
+			data->nan.sync_transition_score += 1;
+	}
+
+	/*
+	 * Decide on TSF adjustments before updating any other state
+	 */
+	if (is_same_cluster && is_sync_beacon && ami &&
+	    data->nan.current_ami.hop_count != 0) {
+		if (le64_to_cpu(ami->master_rank) >
+		    le64_to_cpu(data->nan.current_ami.master_rank) &&
+		    ami->master_rank != data->nan.last_ami.master_rank)
+			adopt_tsf = true;
+
+		if (le64_to_cpu(ami->master_rank) >
+		    le64_to_cpu(data->nan.current_ami.master_rank) &&
+		    ami->master_rank == data->nan.last_ami.master_rank &&
+		    le32_to_cpu(ami->ambtt) >
+		    le32_to_cpu(data->nan.last_ami.ambtt))
+			adopt_tsf = true;
+
+		if (le64_to_cpu(ami->master_rank) <
+		    le64_to_cpu(data->nan.current_ami.master_rank) &&
+		    le64_to_cpu(ami->master_rank) >
+		    hwsim_nan_get_master_rank(data) &&
+		    ether_addr_equal(ami->master_addr,
+				     data->nan.current_ami.master_addr))
+			adopt_tsf = true;
+
+		if (ami->master_rank == data->nan.current_ami.master_rank &&
+		    le32_to_cpu(ami->ambtt) >
+		    le32_to_cpu(data->nan.current_ami.ambtt))
+			adopt_tsf = true;
+
+		/* Anchor Master case is handled below */
+	}
+
+	/*
+	 * NAN Cluster merging
+	 */
+	if (!is_same_cluster && ami) {
+		u64 curr_amr;
+		u64 own_cg;
+		u64 frame_amr;
+		u64 cg;
+
+		/* Shifted down by 19 bits compared to spec */
+		frame_amr = le64_to_cpu(ami->master_rank);
+		cg = (u64)ami->master_pref << (64 - 19);
+		cg += le64_to_cpu(mgmt->u.beacon.timestamp) >> 19;
+
+		curr_amr = le64_to_cpu(data->nan.current_ami.master_rank);
+		own_cg = (u64)data->nan.current_ami.master_pref << (64 - 19);
+		own_cg += rx_status.mactime >> 19;
+
+		/*
+		 * Check if the cluster shall be joined
+		 *
+		 * When in the "scan" phase, just join immediately.
+		 */
+		if (cg > own_cg ||
+		    (cg == own_cg && frame_amr > curr_amr) ||
+		    data->nan.phase == MAC80211_HWSIM_NAN_PHASE_SCAN) {
+			/* Avoid a state transition */
+			data->nan.master_transition_score = 0;
+			data->nan.sync_transition_score = 0;
+
+			/*
+			 * NOTE: The spec says we should TX sync beacons on the
+			 * old schedule after joining. We do not implement this.
+			 */
+
+			wiphy_dbg(hw->wiphy, "NAN: joining cluster %pM\n",
+				  mgmt->bssid);
+
+			joined_cluster = true;
+			adopt_tsf = true;
+
+			memcpy(&data->nan.last_ami, &data->nan.current_ami,
+			       sizeof(data->nan.last_ami));
+			memcpy(&data->nan.current_ami, ami,
+			       sizeof(data->nan.last_ami));
+			data->nan.current_ami.hop_count += 1;
+
+			memcpy(data->nan.cluster_id, mgmt->bssid, ETH_ALEN);
+
+			/*
+			 * Assume we are UP if we joined a cluster.
+			 *
+			 * If the other anchor master is still in the warmup
+			 * phase, then we may temporarily become the anchor
+			 * master until it sets its own master preference to
+			 * be non-zero.
+			 */
+			data->nan.phase = MAC80211_HWSIM_NAN_PHASE_UP;
+			data->nan.random_factor_valid_dwst = 0;
+		}
+	}
+
+	/*
+	 * Anchor master selection
+	 */
+	/* We are not anchor master */
+	if (is_same_cluster && is_sync_beacon && ami &&
+	    data->nan.current_ami.hop_count != 0) {
+		if (le64_to_cpu(data->nan.current_ami.master_rank) <
+		    le64_to_cpu(ami->master_rank)) {
+			if (ami->master_rank == data->nan.last_ami.master_rank &&
+			    le32_to_cpu(ami->ambtt) <=
+			    le32_to_cpu(data->nan.last_ami.ambtt)) {
+				/* disregard frame */
+			} else {
+				memcpy(&data->nan.last_ami,
+				       &data->nan.current_ami,
+				       sizeof(data->nan.last_ami));
+				memcpy(&data->nan.current_ami, ami,
+				       sizeof(data->nan.last_ami));
+				data->nan.current_ami.hop_count += 1;
+			}
+		}
+
+		if (le64_to_cpu(data->nan.current_ami.master_rank) >
+		    le64_to_cpu(ami->master_rank)) {
+			if (!ether_addr_equal(data->nan.current_ami.master_addr,
+					      ami->master_addr)) {
+				/* disregard frame */
+			} else {
+				u64 amr = hwsim_nan_get_master_rank(data);
+
+				if (amr > le64_to_cpu(ami->master_rank)) {
+					/* assume ourselves as anchor master */
+					wiphy_dbg(hw->wiphy,
+						  "NAN: assume anchor master role\n");
+					data->nan.current_ami.master_rank =
+						cpu_to_le64(amr);
+					data->nan.current_ami.hop_count = 0;
+					memset(&data->nan.last_ami, 0,
+					       sizeof(data->nan.last_ami));
+					data->nan.last_ami.ambtt =
+						data->nan.current_ami.ambtt;
+					data->nan.current_ami.ambtt = 0;
+				} else {
+					memcpy(&data->nan.last_ami,
+					       &data->nan.current_ami,
+					       sizeof(data->nan.last_ami));
+					memcpy(&data->nan.current_ami, ami,
+					       sizeof(data->nan.last_ami));
+					data->nan.current_ami.hop_count += 1;
+				}
+			}
+		}
+
+		if (data->nan.current_ami.master_rank == ami->master_rank) {
+			if (le32_to_cpu(data->nan.current_ami.ambtt) <
+			    le32_to_cpu(ami->ambtt)) {
+				data->nan.current_ami.ambtt = ami->ambtt;
+			}
+
+			if (data->nan.current_ami.hop_count >
+			    ami->hop_count + 1) {
+				data->nan.current_ami.hop_count =
+					ami->hop_count + 1;
+			}
+		}
+	}
+
+	/* We are anchor master */
+	if (is_same_cluster && is_sync_beacon &&
+	    data->nan.current_ami.hop_count == 0) {
+		WARN_ON_ONCE(!ether_addr_equal(data->nan.current_ami.master_addr,
+					       data->nan.device_vif->addr));
+
+		if (le64_to_cpu(ami->master_rank) <
+		    le64_to_cpu(data->nan.current_ami.master_rank) ||
+		    ether_addr_equal(ami->master_addr,
+				     data->nan.current_ami.master_addr)) {
+			/* disregard */
+		} else {
+			wiphy_dbg(hw->wiphy, "NAN: lost anchor master role\n");
+			adopt_tsf = true;
+			memcpy(&data->nan.last_ami, &data->nan.current_ami,
+			       sizeof(data->nan.last_ami));
+			memcpy(&data->nan.current_ami, ami,
+			       sizeof(data->nan.last_ami));
+			data->nan.current_ami.hop_count += 1;
+		}
+	}
+
+	if (adopt_tsf && !data->nan.tsf_adjusted) {
+		int threshold = 5;
+		s64 adjustment;
+
+		/* Timestamp is likely inaccurate (and late) in this case */
+		if (!(IEEE80211_SKB_RXCB(skb)->flag & RX_FLAG_MACTIME))
+			threshold = 128;
+
+		adjustment =
+			le64_to_cpu(mgmt->u.beacon.timestamp) -
+			ieee80211_calculate_rx_timestamp(hw, &rx_status,
+							 skb->len, 24);
+
+		scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+			if (adjustment < -threshold || adjustment > threshold) {
+				if (adjustment < -(s64)ieee80211_tu_to_usec(4) ||
+				    adjustment > (s64)ieee80211_tu_to_usec(4))
+					data->nan.tsf_discontinuity = true;
+
+				wiphy_debug(hw->wiphy,
+					    "NAN: Adjusting TSF by +/- %d us or more: %lld us (discontinuity: %d, from: %pM, old offset: %lld)\n",
+					    threshold, adjustment,
+					    data->nan.tsf_discontinuity, mgmt->sa,
+					    data->tsf_offset);
+			} else {
+				/* smooth things out a little bit */
+				adjustment /= 2;
+			}
+
+			/*
+			 * Do the TSF adjustment
+			 * The flag prevents further adjustments until the next
+			 * 2.4 GHz DW starts to avoid race conditions for
+			 * in-flight packets.
+			 */
+			data->nan.tsf_adjusted = true;
+			data->tsf_offset += adjustment;
+		}
+	}
+
+	spin_unlock_bh(&data->nan.state_lock);
+
+	if (joined_cluster) {
+		struct wireless_dev *wdev =
+			ieee80211_vif_to_wdev(data->nan.device_vif);
+
+		cfg80211_nan_cluster_joined(wdev, data->nan.cluster_id, false,
+					    GFP_ATOMIC);
+	}
+}
+
 static void
 mac80211_hwsim_nan_exec_state_transitions(struct mac80211_hwsim_data *data)
 {
+	bool notify_join = false;
+
 	/*
 	 * Handle NAN role and state transitions at the end of the DW period
 	 * in accordance to Wi-Fi Aware version 4.0 section 3.3.7 point 2, i.e.
 	 * end of 5 GHz DW if enabled else at the end of the 2.4 GHz DW.
-	 *
-	 * TODO: Implement
 	 */
+
+	spin_lock(&data->nan.state_lock);
+
+	/* Handle role transitions, Wi-Fi Aware version 4.0 section 3.3.6  */
+	if (data->nan.master_transition_score < 3)
+		data->nan.role = MAC80211_HWSIM_NAN_ROLE_MASTER;
+	else if (data->nan.role == MAC80211_HWSIM_NAN_ROLE_MASTER &&
+		 data->nan.master_transition_score >= 3)
+		data->nan.role = MAC80211_HWSIM_NAN_ROLE_SYNC;
+	else if (data->nan.role == MAC80211_HWSIM_NAN_ROLE_SYNC &&
+		 data->nan.sync_transition_score >= 3)
+		data->nan.role = MAC80211_HWSIM_NAN_ROLE_NON_SYNC;
+	else if (data->nan.role == MAC80211_HWSIM_NAN_ROLE_NON_SYNC &&
+		 data->nan.sync_transition_score < 3)
+		data->nan.role = MAC80211_HWSIM_NAN_ROLE_SYNC;
+
+	/*
+	 * The discovery beacon timer will stop automatically. Make sure it is
+	 * running if we are master. Do not bother with a proper alignment it
+	 * will sync itself to the TSF after the first TX.
+	 */
+	if (data->nan.role == MAC80211_HWSIM_NAN_ROLE_MASTER &&
+	    !hrtimer_active(&data->nan.discovery_beacon_timer))
+		hrtimer_start(&data->nan.discovery_beacon_timer,
+			      ns_to_ktime(10 * NSEC_PER_USEC),
+			      HRTIMER_MODE_REL_SOFT);
+
+	data->nan.master_transition_score = 0;
+	data->nan.sync_transition_score = 0;
+
+	if (data->nan.random_factor_valid_dwst == 0) {
+		u64 amr;
+
+		if (data->nan.phase == MAC80211_HWSIM_NAN_PHASE_SCAN) {
+			data->nan.phase = MAC80211_HWSIM_NAN_PHASE_WARMUP;
+			data->nan.random_factor_valid_dwst = NAN_WARMUP_DWST;
+
+			notify_join = true;
+		} else {
+			data->nan.phase = MAC80211_HWSIM_NAN_PHASE_UP;
+			data->nan.random_factor_valid_dwst =
+				get_random_u32_inclusive(120, 240);
+			data->nan.random_factor = get_random_u8();
+		}
+
+		amr = hwsim_nan_get_master_rank(data);
+
+		if (data->nan.current_ami.hop_count == 0) {
+			/* Update if we are already anchor master */
+			data->nan.current_ami.master_rank = cpu_to_le64(amr);
+		} else if (le64_to_cpu(data->nan.current_ami.master_rank) < amr) {
+			/* assume role if we have a higher rank */
+			wiphy_dbg(data->hw->wiphy,
+				  "NAN: assume anchor master role\n");
+			data->nan.current_ami.master_rank = cpu_to_le64(amr);
+			data->nan.current_ami.hop_count = 0;
+			memset(&data->nan.last_ami, 0,
+			       sizeof(data->nan.last_ami));
+			data->nan.last_ami.ambtt = data->nan.current_ami.ambtt;
+			data->nan.current_ami.ambtt = 0;
+		}
+	} else {
+		data->nan.random_factor_valid_dwst--;
+	}
+
+	spin_unlock(&data->nan.state_lock);
+
+	if (notify_join) {
+		struct wireless_dev *wdev =
+			ieee80211_vif_to_wdev(data->nan.device_vif);
+
+		cfg80211_nan_cluster_joined(wdev, data->nan.cluster_id, true,
+					    GFP_ATOMIC);
+	}
+}
+
+static void
+mac80211_hwsim_nan_tx_beacon(struct mac80211_hwsim_data *data,
+			     bool is_discovery,
+			     struct ieee80211_channel *channel)
+{
+	struct ieee80211_vendor_ie nan_ie = {
+		.element_id = WLAN_EID_VENDOR_SPECIFIC,
+		.len = 27 - 2,
+		.oui = { u32_get_bits(WLAN_OUI_WFA, 0xff0000),
+			 u32_get_bits(WLAN_OUI_WFA, 0xff00),
+			 u32_get_bits(WLAN_OUI_WFA, 0xff) },
+		.oui_type = WLAN_OUI_TYPE_WFA_NAN,
+	};
+	size_t alloc_size =
+		IEEE80211_TX_STATUS_HEADROOM +
+		offsetofend(struct ieee80211_mgmt, u.beacon) +
+		27 /* size of NAN vendor element */;
+	struct ieee80211_nan_master_indication master_indication;
+	struct ieee80211_nan_attr nan_attr;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+
+	/*
+	 * TODO: Should the configured vendor elements or NAN attributes be
+	 * included in some of these beacons?
+	 */
+
+	skb = alloc_skb(alloc_size, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	spin_lock(&data->nan.state_lock);
+
+	skb_reserve(skb, IEEE80211_TX_STATUS_HEADROOM);
+	mgmt = skb_put(skb, offsetofend(struct ieee80211_mgmt, u.beacon));
+
+	memset(mgmt, 0, offsetofend(struct ieee80211_mgmt, u.beacon));
+	memcpy(mgmt->sa, data->nan.device_vif->addr, ETH_ALEN);
+	memset(mgmt->da, 0xff, ETH_ALEN);
+	memcpy(mgmt->bssid, data->nan.cluster_id, ETH_ALEN);
+
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_BEACON);
+	mgmt->u.beacon.beacon_int = cpu_to_le16(is_discovery ? 100 : DWST_TU);
+	mgmt->u.beacon.capab_info =
+		cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME |
+			    WLAN_CAPABILITY_SHORT_PREAMBLE);
+
+	/* FIXME: set these to saner values? */
+	mgmt->duration = 0;
+	mgmt->seq_ctrl = 0;
+
+	/* Put the NAN element */
+	skb_put_data(skb, &nan_ie, sizeof(nan_ie));
+
+	nan_attr.attr = NAN_ATTR_MASTER_INDICATION;
+	nan_attr.length = cpu_to_le16(sizeof(master_indication));
+	if (data->nan.phase == MAC80211_HWSIM_NAN_PHASE_UP) {
+		master_indication.master_pref = data->nan.master_pref;
+		master_indication.random_factor = data->nan.random_factor;
+	} else {
+		master_indication.master_pref = 0;
+		master_indication.random_factor = 0;
+	}
+
+	skb_put_data(skb, &nan_attr, sizeof(nan_attr));
+	skb_put_data(skb, &master_indication, sizeof(master_indication));
+
+	nan_attr.attr = NAN_ATTR_CLUSTER_INFO;
+	nan_attr.length = cpu_to_le16(sizeof(data->nan.current_ami));
+	skb_put_data(skb, &nan_attr, sizeof(nan_attr));
+	skb_put_data(skb, &data->nan.current_ami,
+		     sizeof(data->nan.current_ami));
+
+	spin_unlock(&data->nan.state_lock);
+
+	mac80211_hwsim_tx_frame(data->hw, skb, channel);
 }
 
 enum hrtimer_restart
@@ -80,6 +666,7 @@ mac80211_hwsim_nan_slot_timer(struct hrtimer *timer)
 			     nan.slot_timer);
 	struct ieee80211_hw *hw = data->hw;
 	struct ieee80211_channel *notify_dw_chan = NULL;
+	struct ieee80211_channel *beacon_sync_chan = NULL;
 	u64 tsf = hwsim_nan_get_timer_tsf(data);
 	u8 slot = hwsim_nan_slot_from_tsf(tsf);
 	bool dwst_of_dw0 = false;
@@ -92,10 +679,24 @@ mac80211_hwsim_nan_slot_timer(struct hrtimer *timer)
 		dwst_of_dw0 = true;
 
 
+	scoped_guard(spinlock, &data->nan.state_lock) {
+		if (data->nan.tsf_discontinuity) {
+			data->nan.tsf_discontinuity = false;
+
+			mac80211_hwsim_nan_schedule_slot(data, 32, true);
+
+			return HRTIMER_RESTART;
+		}
+
+		if (slot == SLOT_24GHZ_DW)
+			data->nan.tsf_adjusted = false;
+	}
+
 	switch (slot) {
 	case SLOT_24GHZ_DW:
 		wiphy_dbg(data->hw->wiphy, "Start of 2.4 GHz DW, is DW0=%d\n",
 			  dwst_of_dw0);
+		beacon_sync_chan = ieee80211_get_channel(hw->wiphy, 2437);
 		break;
 
 	case SLOT_24GHZ_DW + 1:
@@ -110,6 +711,8 @@ mac80211_hwsim_nan_slot_timer(struct hrtimer *timer)
 	case SLOT_5GHZ_DW:
 		if (data->nan.bands & BIT(NL80211_BAND_5GHZ)) {
 			wiphy_dbg(data->hw->wiphy, "Start of 5 GHz DW\n");
+			beacon_sync_chan =
+				ieee80211_get_channel(hw->wiphy, 5745);
 		}
 		break;
 
@@ -122,6 +725,12 @@ mac80211_hwsim_nan_slot_timer(struct hrtimer *timer)
 		break;
 	}
 
+	/* TODO: This does not implement DW contention mitigation */
+	if (beacon_sync_chan &&
+	    data->nan.phase != MAC80211_HWSIM_NAN_PHASE_SCAN &&
+	    data->nan.role != MAC80211_HWSIM_NAN_ROLE_NON_SYNC)
+		mac80211_hwsim_nan_tx_beacon(data, false, beacon_sync_chan);
+
 	if (dw_end)
 		mac80211_hwsim_nan_exec_state_transitions(data);
 
@@ -134,7 +743,48 @@ mac80211_hwsim_nan_slot_timer(struct hrtimer *timer)
 
 	mac80211_hwsim_nan_resume_txqs(data);
 
-	mac80211_hwsim_nan_schedule_slot(data, slot + 1);
+	mac80211_hwsim_nan_schedule_slot(data, slot + 1, false);
+
+	return HRTIMER_RESTART;
+}
+
+enum hrtimer_restart
+mac80211_hwsim_nan_discovery_beacon_timer(struct hrtimer *timer)
+{
+	struct mac80211_hwsim_data *data =
+		container_of(timer, struct mac80211_hwsim_data,
+			     nan.discovery_beacon_timer);
+	u64 tsf_now;
+	u64 tbtt;
+
+	if (!data->nan.device_vif)
+		return HRTIMER_NORESTART;
+
+	scoped_guard(spinlock, &data->nan.state_lock) {
+		if (data->nan.phase == MAC80211_HWSIM_NAN_PHASE_SCAN ||
+		    data->nan.role != MAC80211_HWSIM_NAN_ROLE_MASTER)
+			return HRTIMER_NORESTART;
+	}
+
+	mac80211_hwsim_nan_tx_beacon(
+		data, true, ieee80211_get_channel(data->hw->wiphy, 2437));
+
+	if (data->nan.bands & BIT(NL80211_BAND_5GHZ))
+		mac80211_hwsim_nan_tx_beacon(
+			data, true,
+			ieee80211_get_channel(data->hw->wiphy, 5745));
+
+	/* Read the TSF from the current time in case of adjustments */
+	tsf_now = mac80211_hwsim_get_tsf(data->hw, data->nan.device_vif);
+
+	/* Wrap value to be after the next TBTT */
+	tbtt = tsf_now + ieee80211_tu_to_usec(100);
+
+	/* Round TBTT down to the correct time */
+	tbtt = tbtt - tbtt % ieee80211_tu_to_usec(100);
+
+	hrtimer_set_expires(&data->nan.discovery_beacon_timer,
+			    mac80211_hwsim_tsf_to_boottime(data, tbtt));
 
 	return HRTIMER_RESTART;
 }
@@ -144,7 +794,6 @@ int mac80211_hwsim_nan_start(struct ieee80211_hw *hw,
 			     struct cfg80211_nan_conf *conf)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
-	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
 
 	if (vif->type != NL80211_IFTYPE_NAN)
 		return -EINVAL;
@@ -156,28 +805,33 @@ int mac80211_hwsim_nan_start(struct ieee80211_hw *hw,
 	data->nan.device_vif = vif;
 	data->nan.bands = conf->bands;
 
+	/* Start in the "scan" phase and stay there for a little bit */
+	data->nan.phase = MAC80211_HWSIM_NAN_PHASE_SCAN;
+	data->nan.random_factor_valid_dwst = 1;
+	data->nan.random_factor = 0;
+	data->nan.master_pref = conf->master_pref;
+	data->nan.role = MAC80211_HWSIM_NAN_ROLE_MASTER;
+	memset(&data->nan.current_ami, 0, sizeof(data->nan.current_ami));
+	memset(&data->nan.last_ami, 0, sizeof(data->nan.last_ami));
+	data->nan.current_ami.master_rank =
+		cpu_to_le64(hwsim_nan_get_master_rank(data));
+
 	/* Just run this "soon" and start in a random schedule position */
 	hrtimer_start(&data->nan.slot_timer,
 		      ns_to_ktime(10 * NSEC_PER_USEC),
 		      HRTIMER_MODE_REL_SOFT);
 
-	if (conf->cluster_id && !is_zero_ether_addr(conf->cluster_id) &&
-	    is_zero_ether_addr(hwsim_nan_cluster_id)) {
-		memcpy(hwsim_nan_cluster_id, conf->cluster_id, ETH_ALEN);
-	} else if (is_zero_ether_addr(hwsim_nan_cluster_id)) {
-		hwsim_nan_cluster_id[0] = 0x50;
-		hwsim_nan_cluster_id[1] = 0x6f;
-		hwsim_nan_cluster_id[2] = 0x9a;
-		hwsim_nan_cluster_id[3] = 0x01;
-		hwsim_nan_cluster_id[4] = get_random_u8();
-		hwsim_nan_cluster_id[5] = get_random_u8();
+	if (conf->cluster_id && !is_zero_ether_addr(conf->cluster_id)) {
+		memcpy(data->nan.cluster_id, conf->cluster_id, ETH_ALEN);
+	} else {
+		put_unaligned_be32((WLAN_OUI_WFA << 8) | 0x01,
+				   data->nan.cluster_id);
+		data->nan.cluster_id[4] = get_random_u8();
+		data->nan.cluster_id[5] = get_random_u8();
 	}
 
 	data->nan.notify_dw = conf->enable_dw_notification;
 
-	cfg80211_nan_cluster_joined(wdev, hwsim_nan_cluster_id, true,
-				    GFP_KERNEL);
-
 	return 0;
 }
 
@@ -185,8 +839,6 @@ int mac80211_hwsim_nan_stop(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
-	struct mac80211_hwsim_data *data2;
-	bool nan_cluster_running = false;
 
 	if (vif->type != NL80211_IFTYPE_NAN || !data->nan.device_vif ||
 	    data->nan.device_vif != vif)
@@ -194,20 +846,9 @@ int mac80211_hwsim_nan_stop(struct ieee80211_hw *hw,
 
 	hrtimer_cancel(&data->nan.slot_timer);
 	hrtimer_cancel(&data->nan.resume_txqs_timer);
+	hrtimer_cancel(&data->nan.discovery_beacon_timer);
 	data->nan.device_vif = NULL;
 
-	spin_lock_bh(&hwsim_radio_lock);
-	list_for_each_entry(data2, &hwsim_radios, list) {
-		if (data2->nan.device_vif) {
-			nan_cluster_running = true;
-			break;
-		}
-	}
-	spin_unlock_bh(&hwsim_radio_lock);
-
-	if (!nan_cluster_running)
-		memset(hwsim_nan_cluster_id, 0, ETH_ALEN);
-
 	return 0;
 }
 
@@ -233,6 +874,11 @@ int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
 	if (changes & CFG80211_NAN_CONF_CHANGED_CONFIG)
 		data->nan.notify_dw = conf->enable_dw_notification;
 
+	if (changes & CFG80211_NAN_CONF_CHANGED_PREF) {
+		scoped_guard(spinlock_bh, &data->nan.state_lock)
+			data->nan.master_pref = conf->master_pref;
+	}
+
 	return 0;
 }
 
@@ -335,7 +981,10 @@ bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
 	if (WARN_ON_ONCE(!data->nan.device_vif))
 		return false;
 
-	if (rx_status->rx_flags & RX_FLAG_MACTIME) {
+	if (data->nan.phase == MAC80211_HWSIM_NAN_PHASE_SCAN)
+		return channel->center_freq == 2437;
+
+	if (rx_status->flag & RX_FLAG_MACTIME) {
 		slot = hwsim_nan_slot_from_tsf(rx_status->mactime);
 	} else {
 		u64 tsf;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
index af8dd7ff00cc..3199e5c5376b 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
@@ -7,6 +7,18 @@
 #ifndef __MAC80211_HWSIM_NAN_H
 #define __MAC80211_HWSIM_NAN_H
 
+enum mac80211_hwsim_nan_phase {
+	MAC80211_HWSIM_NAN_PHASE_SCAN,
+	MAC80211_HWSIM_NAN_PHASE_WARMUP,
+	MAC80211_HWSIM_NAN_PHASE_UP,
+};
+
+enum mac80211_hwsim_nan_role {
+	MAC80211_HWSIM_NAN_ROLE_MASTER,
+	MAC80211_HWSIM_NAN_ROLE_SYNC,
+	MAC80211_HWSIM_NAN_ROLE_NON_SYNC,
+};
+
 struct mac80211_hwsim_nan_data {
 	struct ieee80211_vif *device_vif;
 	u8 bands;
@@ -14,12 +26,40 @@ struct mac80211_hwsim_nan_data {
 	struct hrtimer slot_timer;
 	struct hrtimer resume_txqs_timer;
 	bool notify_dw;
+
+	struct hrtimer discovery_beacon_timer;
+
+	/* Later members are protected by this lock */
+	spinlock_t state_lock;
+
+	u8 master_pref;
+	u8 random_factor;
+
+	u8 random_factor_valid_dwst;
+
+	enum mac80211_hwsim_nan_phase phase;
+	enum mac80211_hwsim_nan_role role;
+
+	u8 cluster_id[ETH_ALEN];
+
+	struct ieee80211_nan_anchor_master_info current_ami;
+	struct ieee80211_nan_anchor_master_info last_ami;
+
+	/* Wi-Fi Aware version 4.0, section 3.3.6.1 and 3.3.6.2 */
+	int master_transition_score;
+	/* Wi-Fi Aware version 4.0, section 3.3.6.3 and 3.3.6.4 */
+	int sync_transition_score;
+
+	bool tsf_adjusted;
+	bool tsf_discontinuity;
 };
 
 enum hrtimer_restart
 mac80211_hwsim_nan_slot_timer(struct hrtimer *timer);
 enum hrtimer_restart
 mac80211_hwsim_nan_resume_txqs_timer(struct hrtimer *timer);
+enum hrtimer_restart
+mac80211_hwsim_nan_discovery_beacon_timer(struct hrtimer *timer);
 
 int mac80211_hwsim_nan_start(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
@@ -43,4 +83,7 @@ bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
 				struct ieee80211_channel *channel,
 				struct ieee80211_rx_status *rx_status);
 
+void mac80211_hwsim_nan_rx(struct ieee80211_hw *hw,
+			   struct sk_buff *skb);
+
 #endif /* __MAC80211_HWSIM_NAN_H */
-- 
2.51.1


