Return-Path: <linux-wireless+bounces-35927-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGpQFw0e+mmaJwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35927-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:42:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D254D1831
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD0E1301A0BF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55AC38F23F;
	Tue,  5 May 2026 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jycKftDK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2314921AC
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999358; cv=none; b=Og5AzzYROZK6aDDcZU8cAFpFkN/QIEI5vURHVipWyp6mp/W5uLfArfVbHoPgnRo9t1S47NkD8DwiRgVIaWWIEyFnr44aO6TdFEwMcq3e2cERpuRwB+jPv0GdGKuDCXF32vPu/uQhE6xS7nwhbx9SDkAdGbq80dLzDDJc8zPwkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999358; c=relaxed/simple;
	bh=txPx0yrgvipn56ScFDh2rtEtN8/a9+N7nVQIolfrJNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S5DMeSJdzpYfTbIN4yu8m3+Ff/3z7MoHZC5xAU6tV3qkYJoNdQ9lqEU+9sXaEchgqLi3Md6i0Hp6vssTESvnPx39JR0cIhg76R4yl3NIBAL9KWhAVsV/4kP12Bme7Q/7L8IcFMqMtkzBhJYLOBrtkug1IyEy5SqGsHaTpIyWCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jycKftDK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999357; x=1809535357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txPx0yrgvipn56ScFDh2rtEtN8/a9+N7nVQIolfrJNA=;
  b=jycKftDKazUVNg7HDt2obhed9FcJrfooq66h5Z3bSPtKxrmwPqUXzCw0
   7kFKEnrRLYMdA37wlGYuvZxahtLgj4XFPYo4CpuNETQjMs6NQa5qVv6O6
   iqkyEbmXYvZHB7tpFLEuAD0eppXpi4rqbhYsM4+FWXj65vshEUP9Yqqew
   WNkIVucU2M2OlYhiCpyZfogS/CqGncWKReizml+MXLjps87WJD3VBWJPL
   UuDb5aaKWm3K2PpfD6zVTeD6UicQs49ghQ0klyY9lw8gGf+6DEwy5RXIz
   Q7jsQo1s3zttn+SBP1fGf+oaHKvZM1gk9sSv4Fbpqt0W2jSuBA/UO4Cly
   A==;
X-CSE-ConnectionGUID: h4goWQBGQruasEglS/LIxA==
X-CSE-MsgGUID: ER1VB7EKSdKVghoMiXtSUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898966"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898966"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:36 -0700
X-CSE-ConnectionGUID: tYmRTsBYRLOv9hex3JPQxw==
X-CSE-MsgGUID: uVOtF9ZkTquhqVEMGxVS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206366"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 03/14] wifi: mac80211_hwsim: only RX on NAN when active on a slot
Date: Tue,  5 May 2026 19:42:08 +0300
Message-Id: <20260505194007.8cf4a67d3436.Ife07cf4ae8a2d59766356398163f7ee8d734bd6a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
References: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 64D254D1831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35927-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Benjamin Berg <benjamin.berg@intel.com>

This moves the NAN receive into the main code and changes it so that
frame RX only happens when the device is active on the channel. This
limits RX to the DW slots as there is currently no datapath.

With this the globally stored channel is obsolete, remove it.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 26 ++++++++----
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 41 +++++++++++++++++--
 .../net/wireless/virtual/mac80211_hwsim_nan.h |  7 ++--
 3 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index f0f6cb7fa894..76f1028bc42e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1731,6 +1731,8 @@ static bool hwsim_chans_compat(struct ieee80211_channel *c1,
 
 struct tx_iter_data {
 	struct ieee80211_channel *channel;
+	struct ieee80211_rx_status *rx_status;
+	struct ieee80211_hw *hw;
 	bool receive;
 };
 
@@ -1740,13 +1742,10 @@ static void mac80211_hwsim_tx_iter(void *_data, u8 *addr,
 	struct tx_iter_data *data = _data;
 	int i;
 
-	/* For NAN Device simulation purposes, assume that NAN is always
-	 * on channel 6 or channel 149.
-	 */
 	if (vif->type == NL80211_IFTYPE_NAN) {
-		data->receive = (data->channel &&
-				 (data->channel->center_freq == 2437 ||
-				  data->channel->center_freq == 5745));
+		data->receive = mac80211_hwsim_nan_receive(data->hw,
+							   data->channel,
+							   data->rx_status);
 		return;
 	}
 
@@ -1923,7 +1922,9 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 		struct sk_buff *nskb;
 		struct tx_iter_data tx_iter_data = {
 			.receive = false,
+			.hw = data2->hw,
 			.channel = chan,
+			.rx_status = &rx_status,
 		};
 
 		if (data == data2)
@@ -1939,6 +1940,12 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 		if (data->netgroup != data2->netgroup)
 			continue;
 
+		/*
+		 * Set mactime early since NAN RX filtering relies on it
+		 * for slot calculation
+		 */
+		rx_status.mactime = sim_tsf + data2->tsf_offset;
+
 		if (!hwsim_chans_compat(chan, data2->tmp_chan) &&
 		    !hwsim_chans_compat(chan, data2->channel)) {
 			ieee80211_iterate_active_interfaces_atomic(
@@ -1975,8 +1982,6 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 		if (mac80211_hwsim_addr_match(data2, hdr->addr1))
 			ack = true;
 
-		rx_status.mactime = sim_tsf + data2->tsf_offset;
-
 		mac80211_hwsim_rx(data2, &rx_status, nskb);
 	}
 	spin_unlock(&hwsim_radio_lock);
@@ -6286,7 +6291,10 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	/* A frame is received from user space */
 	memset(&rx_status, 0, sizeof(rx_status));
 	if (info->attrs[HWSIM_ATTR_FREQ]) {
-		struct tx_iter_data iter_data = {};
+		struct tx_iter_data iter_data = {
+			.hw = data2->hw,
+			.rx_status = &rx_status,
+		};
 
 		/* throw away off-channel packets, but allow both the temporary
 		 * ("hw" scan/remain-on-channel), regular channels and links,
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index 10bbac9a4b55..805848172605 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -96,7 +96,6 @@ mac80211_hwsim_nan_slot_timer(struct hrtimer *timer)
 	case SLOT_24GHZ_DW:
 		wiphy_dbg(data->hw->wiphy, "Start of 2.4 GHz DW, is DW0=%d\n",
 			  dwst_of_dw0);
-		data->nan.channel = ieee80211_get_channel(hw->wiphy, 2437);
 		break;
 
 	case SLOT_24GHZ_DW + 1:
@@ -111,8 +110,6 @@ mac80211_hwsim_nan_slot_timer(struct hrtimer *timer)
 	case SLOT_5GHZ_DW:
 		if (data->nan.bands & BIT(NL80211_BAND_5GHZ)) {
 			wiphy_dbg(data->hw->wiphy, "Start of 5 GHz DW\n");
-			data->nan.channel =
-				ieee80211_get_channel(hw->wiphy, 5745);
 		}
 		break;
 
@@ -158,7 +155,6 @@ int mac80211_hwsim_nan_start(struct ieee80211_hw *hw,
 	/* set this before starting the timer, as preemption might occur */
 	data->nan.device_vif = vif;
 	data->nan.bands = conf->bands;
-	data->nan.channel = ieee80211_get_channel(hw->wiphy, 2437);
 
 	/* Just run this "soon" and start in a random schedule position */
 	hrtimer_start(&data->nan.slot_timer,
@@ -328,3 +324,40 @@ mac80211_hwsim_nan_get_tx_channel(struct ieee80211_hw *hw)
 	/* drop frame and warn, NAN_CHAN_SWITCH_TIME_US should avoid races */
 	return NULL;
 }
+
+bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
+				struct ieee80211_channel *channel,
+				struct ieee80211_rx_status *rx_status)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	u8 slot;
+
+	if (WARN_ON_ONCE(!data->nan.device_vif))
+		return false;
+
+	if (rx_status->rx_flags & RX_FLAG_MACTIME) {
+		slot = hwsim_nan_slot_from_tsf(rx_status->mactime);
+	} else {
+		u64 tsf;
+
+		/*
+		 * This is not perfect, but that should be fine.
+		 *
+		 * Assume the frame might be a bit early in relation to our
+		 * own TSF. This is largely because the TSF sync is going to be
+		 * pretty bad when the frame was RXed via NL and the beacon as
+		 * well as RX timestamps are not accurate.
+		 */
+		tsf = mac80211_hwsim_get_tsf(data->hw, data->nan.device_vif);
+		slot = hwsim_nan_slot_from_tsf(tsf + 128);
+	}
+
+	if (slot == SLOT_24GHZ_DW && channel->center_freq == 2437)
+		return true;
+
+	if (slot == SLOT_5GHZ_DW && data->nan.bands & BIT(NL80211_BAND_5GHZ) &&
+	    channel->center_freq == 5745)
+		return true;
+
+	return false;
+}
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
index 796cc17d194e..af8dd7ff00cc 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
@@ -11,9 +11,6 @@ struct mac80211_hwsim_nan_data {
 	struct ieee80211_vif *device_vif;
 	u8 bands;
 
-	/* Current channel of the NAN device */
-	struct ieee80211_channel *channel;
-
 	struct hrtimer slot_timer;
 	struct hrtimer resume_txqs_timer;
 	bool notify_dw;
@@ -42,4 +39,8 @@ bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 struct ieee80211_channel *
 mac80211_hwsim_nan_get_tx_channel(struct ieee80211_hw *hw);
 
+bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
+				struct ieee80211_channel *channel,
+				struct ieee80211_rx_status *rx_status);
+
 #endif /* __MAC80211_HWSIM_NAN_H */
-- 
2.34.1


