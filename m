Return-Path: <linux-wireless+bounces-29414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAEDC924D4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9798034F902
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62561274643;
	Fri, 28 Nov 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xMGlOVj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA039331211
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339684; cv=none; b=nF1tT5dEbkUfzfrhzFanJ9MaFAUSPE+bfOcgGc+XH3Xm8yV1Mwh7NClzPUQQVL1UzIZKXMzfk57N1DMbVBENC0/UwO1i+RKZIm8fAnMn2MQiPxJK5H2r6G7o0n6LGvFVgWzM5eAG5vZuLlNv9simDZWTNCbadfKBTW5dM0dbbQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339684; c=relaxed/simple;
	bh=jfIv9k40kniZNRR4cLJv7BD8liSK7kdqQd7PpnZHia8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/WBEw4+mItBTqPCw3mKHBf90wV4nZsXfs0MRl/xGs/d1ej1t2kneRB3ZfcyxP4+p3+9YbpQ7kO3RNB+sJobTAO4neObMFRzDiT3fXfONmtO1MQMv8Had2BA6jbtkMMh5grV1+0uee57awZNqUoenHcRRbbz55sNHSqrM8G6m30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xMGlOVj9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IMD3bODic6/GbeLAKKis6MQYJ7AMuYK/uWYaE92gs58=;
	t=1764339681; x=1765549281; b=xMGlOVj9vQ3VPK0q4ESTL+KeTgbDND1CIfyq5MiZaHDXSb8
	NLiVa3i8qaXPzWavVI3lRhhQ9OdAN5FZNVaHlACdI4F+lPV6IZhnMz0AWrWRbgzbldSZowghmBcpa
	J371wbRbaMWSWt8CmfUQAtMWWk+K8WeKe8axpHCtgH25PBoeTIdte04tDTN1jHmUrori7SJDw6u0c
	aHsoXsAuUHpj+q1PgGxT0PsotLc6syWYVvZaavaM778SrKVh37teXhbFHpv9m9WOEQjMHCctBbAFU
	90VWvQeoxUUQ4myU2wt6tOIBxD4VyfOxI158Sl6sBaQyL4xSzmZ9iVS/TcGanc4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLZ-00000003926-3Npn;
	Fri, 28 Nov 2025 15:21:18 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 14/18] wifi: mac80211_hwsim: only RX on NAN when active on a slot
Date: Fri, 28 Nov 2025 15:15:52 +0100
Message-ID: <20251128151537.42e9d3f17e41.Ife07cf4ae8a2d59766356398163f7ee8d734bd6a@changeid>
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

This moves the NAN receive into the main code and changes it so that
frame RX only happens when the device is active on the channel. This
limits RX to the DW slots as there is currently no datapath.

With this the globally stored channel is obsolete, remove it.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 18 ++++----
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 41 +++++++++++++++++--
 .../net/wireless/virtual/mac80211_hwsim_nan.h |  7 ++--
 3 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 6903f6044a10..4e836289d58e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1594,6 +1594,8 @@ static bool hwsim_chans_compat(struct ieee80211_channel *c1,
 
 struct tx_iter_data {
 	struct ieee80211_channel *channel;
+	struct ieee80211_rx_status *rx_status;
+	struct ieee80211_hw *hw;
 	bool receive;
 };
 
@@ -1603,13 +1605,10 @@ static void mac80211_hwsim_tx_iter(void *_data, u8 *addr,
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
 
@@ -1786,7 +1785,9 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 		struct sk_buff *nskb;
 		struct tx_iter_data tx_iter_data = {
 			.receive = false,
+			.hw = data2->hw,
 			.channel = chan,
+			.rx_status = &rx_status,
 		};
 
 		if (data == data2)
@@ -5924,7 +5925,10 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
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
index ce8bb73f9dd6..acc1cd6e24ac 100644
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
2.51.1


