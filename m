Return-Path: <linux-wireless+bounces-30505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A46ACFF4B0
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 19:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C09A3559B62
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BBF345CA2;
	Wed,  7 Jan 2026 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dgWr9zgj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E0345752
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795858; cv=none; b=QH6c2Kthysx4oU8K8lWfe2UN6vfXhBh9/vUMy/5esfWHwfvoWGk9m0mB9mxx8Gv6FvEUczBVq3RpjkbNrpBPqBM7OWTCXxfuRxp0j2OLPl3DkOjl+F9I41QR9f5rDgf8aLepWkMOx47qKHc6LZZTNGq9GjKQAjHerjmFfkaEnZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795858; c=relaxed/simple;
	bh=W3AjSx3EyieLiWk/Giv15LDXMWmJULOmioL19f70fc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjLO5qzuZnwg3hDJN6kX8xFkTe+yUL00lGD1NgFW9woCxJ5tox/AUJnWe3qdpyMaZHaXx0FeuhI5hHf6bowog3BHdKN+iVR09hbzWUrEonuDb/RIikFy9yfvfTdRBiChhrgDwgtdmZDm5/Uy8uNfJexAFoBp4d05d5KZjkKt76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dgWr9zgj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lJEY30h9q1eng3uvadOLyAIXYt+w11gzdc/HYgMzrI0=;
	t=1767795856; x=1769005456; b=dgWr9zgjUdwhfrfGt0LwHrzSJ8VLW6jTnjN3zwJRLmDr7ZY
	4kHshpHD6m2Ob2BC9bv2bhTKA1E2zFjgldHQQJlHbOXktIW9NB74h2v2ObnDgVkRCEzZHgvMgRL2I
	v/omchRY8E2OD6FSA6XtpdmeDMcHqFs3CEkRfbAqHpbUecoTvkHmMEk2b3G5+UmjShUyrzEkXWldn
	r8UBhd/rP83Qw0fjFO96PJMeUhbXE0Z/9AzVisjlZ1i5IuDyfqQY16efAC5YvRco4iYwQl7ADp1Y1
	a+movdbVD4no8pCEgNS4uvQB2Sh3Lw/F3EfjZ3hVq2k9yTpJGofJViIzlQ8xtyvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSK-00000005agF-1WEJ;
	Wed, 07 Jan 2026 15:24:12 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 43/46] wifi: mac80211_hwsim: set HAS_RATE_CONTROL when using NAN
Date: Wed,  7 Jan 2026 15:22:42 +0100
Message-ID: <20260107152325.9b82fef42996.If9ef94a12cec8dfc55416afaf745d6e5025a5ec9@changeid>
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

From: Daniel Gabay <daniel.gabay@intel.com>

- NAN switches between bands/channels per its schedule, so mac80211
  rate control can't work, set HAS_RATE_CONTROL instead.
- Skip rate control checks for NAN interfaces in
  mac80211_hwsim_sta_rc_update() as it's not relevant.
- Move set_rts_threshold stub to HWSIM_COMMON_OPS and return 0 instead
  of -EOPNOTSUPP to prevent failures in non-MLO tests that set RTS
  threshold (hwsim ignores the use_rts instruction from mac80211
  anyway).

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_main.c    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index f7f3edf505d0..9db4eac5959d 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2572,6 +2572,10 @@ mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
 	u32 bw = U32_MAX;
 	int link_id;
 
+	if (vif->type == NL80211_IFTYPE_NAN ||
+	    vif->type == NL80211_IFTYPE_NAN_DATA)
+		return;
+
 	rcu_read_lock();
 	for (link_id = 0;
 	     link_id < ARRAY_SIZE(vif->link_conf);
@@ -3301,7 +3305,8 @@ static int mac80211_hwsim_tx_last_beacon(struct ieee80211_hw *hw)
 static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw,
 					    int radio_idx, u32 value)
 {
-	return -EOPNOTSUPP;
+	/* hwsim ignores the use_rts instruction from mac80211 anyway */
+	return 0;
 }
 
 static int mac80211_hwsim_change_vif_links(struct ieee80211_hw *hw,
@@ -3941,6 +3946,7 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 	.get_et_strings = mac80211_hwsim_get_et_strings,		 \
 	.start_pmsr = mac80211_hwsim_start_pmsr,			 \
 	.abort_pmsr = mac80211_hwsim_abort_pmsr,			 \
+	.set_rts_threshold = mac80211_hwsim_set_rts_threshold,		 \
 	.start_nan = mac80211_hwsim_nan_start,				 \
 	.stop_nan = mac80211_hwsim_nan_stop,				 \
 	.nan_change_conf = mac80211_hwsim_nan_change_config,		 \
@@ -3986,7 +3992,6 @@ static const struct ieee80211_ops mac80211_hwsim_mchan_ops = {
 static const struct ieee80211_ops mac80211_hwsim_mlo_ops = {
 	HWSIM_COMMON_OPS
 	HWSIM_CHANCTX_OPS
-	.set_rts_threshold = mac80211_hwsim_set_rts_threshold,
 	.change_vif_links = mac80211_hwsim_change_vif_links,
 	.change_sta_links = mac80211_hwsim_change_sta_links,
 	.sta_state = mac80211_hwsim_sta_state,
@@ -5386,6 +5391,12 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		hw->wiphy->nan_capa.phy.ht = hwsim_nan_ht_cap;
 		hw->wiphy->nan_capa.phy.vht = hwsim_nan_vht_cap;
 		hw->wiphy->nan_capa.phy.he = hwsim_nan_he_cap;
+
+		/*
+		 * NAN switches between bands/channels per its schedule,
+		 * so mac80211 rate control can't work here.
+		 */
+		ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	}
 
 	data->if_combination.radar_detect_widths =
-- 
2.52.0


