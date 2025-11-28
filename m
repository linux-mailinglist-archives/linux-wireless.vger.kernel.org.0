Return-Path: <linux-wireless+bounces-29413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C3FC92519
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68EBA4E4A0E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7B24DCE5;
	Fri, 28 Nov 2025 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iCo2IL8f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559A330D47
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339682; cv=none; b=s8S+L7gIJxCBhZOf8x8BS9zNsNYESmyN9OIaOWFNe7uAcq0P6aukDy5M8M6qKTBaXM1Xc69IYJLnobl94wwDfEzUATeRgxcrC2WFNh0/t+KEr+vBexkOhGXNILeCCbk0vl/GY3Zhyc17KmY77VkEJuNHu4os/Wg9JZf5FNdnsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339682; c=relaxed/simple;
	bh=ZjrFqy5dlrUaZ/yBqZDkWgdPNoeA8jrgTMNV1NnpTyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+ld3pm4Yz/hJqQ+JwAPi9gkCLrKgbQaAbptjmSRwJJvfHfWnSr+t/JK8LCiWeCVKvDlV3AVZ1EQP6SZBKdyt2J0UNw0/hL0p6FBLHZaoDK7+tUqujBny9k2zDWmGxVm81U5U5TX224UYDUbcgaegpbnN2FI2cEh6jAkOyOsfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iCo2IL8f; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=E4L7d3L+Zdh/7eXcCexcUQgkcPrKHmC4Ve+w7LU2Uio=;
	t=1764339678; x=1765549278; b=iCo2IL8faSNq4oIHMLI8n7QfY/1irxoewmsZjYgfdsEx76E
	Qy2XItWrk7UAZvJEBex/roXVMRQvJa5UoW8IVg5p3C7b/UWR2My5LyU/CJLXXMHIyvyQcqJY4qqJ8
	aB5xaaoPzEFr6psVbdmBxEM06t7c2POSuiGJ5g5T6NYl/iuhyFjA7Jp5CKc8r4zbRBs81WLhB+ZZa
	4b/iBocGTVjxt81GUtrk+57dN6D2Ol57YUs9JNWzLKF7CtV2wQmnhyUNC3LXtkxxhInH1Zc9VJ1kf
	ayPn7TjAo3CvYaE8qFPy2U9bjEb626MAg5zdiQwIERd4/Hj1xihb06aETZjoIZ/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLX-00000003926-19Lc;
	Fri, 28 Nov 2025 15:21:15 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 13/18] wifi: mac80211_hwsim: select NAN TX channel based on current TSF
Date: Fri, 28 Nov 2025 15:15:51 +0100
Message-ID: <20251128151537.79e13967a71c.I5ec4076a8a9445233dc414c6ecaa39f32f1e9595@changeid>
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

Move the TX channel selection into the NAN specific file and select the
channel based on the current slot.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_main.c |  6 +-----
 .../net/wireless/virtual/mac80211_hwsim_nan.c  | 18 ++++++++++++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h  |  3 +++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0f8769ccfd9a..6903f6044a10 100644
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
2.51.1


