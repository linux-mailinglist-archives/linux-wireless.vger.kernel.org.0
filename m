Return-Path: <linux-wireless+bounces-30476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46394CFFBF1
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 20:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D41D303D361
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDF833D50E;
	Wed,  7 Jan 2026 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FeB8c2N6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5BA339708
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795829; cv=none; b=k5O0WrjBZs+CGgJ2B5P1nYW4WEuaQhY6z6M/B3AI9WbVgtfCRkMXVYD+ab2Cdm8uSwp4EhbpeACEe/7TdhmKaaN0jOP1tCn1hRq0RaX/uJw2vWEQfXu8ZFi7pLUNMsb6kT/pPUwXcFC1k3BsH9wwzc8MYV7E/eelD+zmrXA7n38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795829; c=relaxed/simple;
	bh=8z3hOpzruyeJ0zDgaOexnMX/TEnS3tZTNbl1qpyGlGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WljskD/h1qgEMZNd942u7Dq2nYyjE/RVjdmByrLICBOPIWN7VOR/KhMrZO082r1iLztiRgu9t8nCCjZJeu3kTUrW3V36bFSjwwR/SOE5myrml4fSto9UQL8D1ELjyx85XEoJ0Lbqdsv/js/DNrMadF0nJiGVmZHoiq5JsrRmJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FeB8c2N6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4bvrrWS8Hx1wEgfaVoa+fCIloxxwdqeI9v7WXwfD25o=;
	t=1767795827; x=1769005427; b=FeB8c2N6LDmhqqxhvnnoU/H9Z47NKEAB6M5njzGhamJMCQW
	+5Lhj+NVRfwlRZcPecRML6GhTLNVJdRL8C4aLYfsmarDfaqRVvhdWMLINJ1Njl8RIA2904H9I/mjZ
	Rz1RjmbBt4A6yBzEcKYETRL069Ycc2IBkzJjBUj+p0FlPcZf9cEUIzZ3iaWhHGL+wHSRDc2oJwpz6
	n0mhbWXTTq2yfSBWPb++JRLHOH8MudSK+XWxnbh4HHwBG7l0oJERUv7QKDc0lwbsbPg6VIUtPxrHL
	XvKPWxn3cBHNRTCdLznlva21PidDag4euk3OXaCIPSq85L9jADtyoLa/wDfsepbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURs-00000005agF-3lmK;
	Wed, 07 Jan 2026 15:23:45 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 14/46] wifi: mac80211_hwsim: select NAN TX channel based on current TSF
Date: Wed,  7 Jan 2026 15:22:13 +0100
Message-ID: <20260107152325.2084f2c9c153.I5ec4076a8a9445233dc414c6ecaa39f32f1e9595@changeid>
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

Move the TX channel selection into the NAN specific file and select the
channel based on the current slot.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_main.c |  6 +-----
 .../net/wireless/virtual/mac80211_hwsim_nan.c  | 18 ++++++++++++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h  |  3 +++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 57e22f18bbd1..cfe72dfd5918 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1918,11 +1918,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	}
 
 	if (vif && vif->type == NL80211_IFTYPE_NAN && !data->tmp_chan) {
-		/* For NAN Device simulation purposes, assume that NAN is always
-		 * on channel 6 or channel 149, unless a ROC is in progress (for
-		 * USD use cases).
-		 */
-		channel = data->nan.channel;
+		channel = mac80211_hwsim_nan_get_tx_channel(hw);
 
 		if (WARN_ON(!channel)) {
 			ieee80211_free_txskb(hw, skb);
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index 029499bf965f..ce8bb73f9dd6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -310,3 +310,21 @@ bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 
 	return true;
 }
+
+struct ieee80211_channel *
+mac80211_hwsim_nan_get_tx_channel(struct ieee80211_hw *hw)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	u64 tsf = mac80211_hwsim_get_tsf(data->hw, data->nan.device_vif);
+	u8 slot = hwsim_nan_slot_from_tsf(tsf);
+
+	if (slot == SLOT_24GHZ_DW)
+		return ieee80211_get_channel(hw->wiphy, 2437);
+
+	if (slot == SLOT_5GHZ_DW &&
+	    data->nan.bands & BIT(NL80211_BAND_5GHZ))
+		return ieee80211_get_channel(hw->wiphy, 5745);
+
+	/* drop frame and warn, NAN_CHAN_SWITCH_TIME_US should avoid races */
+	return NULL;
+}
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
index 6a0780797273..796cc17d194e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
@@ -39,4 +39,7 @@ int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
 bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 					 struct ieee80211_txq *txq);
 
+struct ieee80211_channel *
+mac80211_hwsim_nan_get_tx_channel(struct ieee80211_hw *hw);
+
 #endif /* __MAC80211_HWSIM_NAN_H */
-- 
2.52.0


