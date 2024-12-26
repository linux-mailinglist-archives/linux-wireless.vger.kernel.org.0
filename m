Return-Path: <linux-wireless+bounces-16800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4DB9FC745
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 02:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B06161869
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 01:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4AFC8C5;
	Thu, 26 Dec 2024 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iSbr5OpN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11DF4C9F;
	Thu, 26 Dec 2024 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735175646; cv=none; b=a0yUuv2LZMoHzNkB6VeDrtc48IqKiym/pUXm2r3Stn4Y76UwW/QwokoCepXNDFFiI1On2E1c76KjJPQCH4kSWR1mMavdeq42CRKBEN013gsk+tP/0ZFj59xPI6jkHfjEEg9OgAIKrgqhKpf64+QL/7N12p4PMG/vtbuyAXy+Vks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735175646; c=relaxed/simple;
	bh=hXXOOf4rBAXcb3Lv/zkRuTagj/a0IE/Vdn/1mnq9Qc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWo39GrgGUPtIEFxvNXtb61dS/4LSB4iyYv2acjmCte8Z2UlL3az1qqxdPIZyXFY5nyuAk92PJDX6t7oAxxMHVuW4Kn6nOKtn19rbRX6dklfRzoith8SGaR08nH2gbF3/p6HOLsdYLCsBuQ5nzAztnOBjuw76hmnXRxVjlduY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iSbr5OpN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VkZs2K4avoBS3ppyZFrilgDpmw5oj5bV2e7wqyXsg3E=; b=iSbr5OpNJyohcRHf
	5cy+X1qYZt+6EZgxBIGHACTofxiSBwokUCUMDDVQOI4zT/VDsDR50Xygg0hsMMg9NjBuP2sI2hsJn
	HxZ/ENYTabRb7TONFLrjOY2hAxY7MALeutrzrUOWR1ALoVnqNByLcXMQhTJjioFM+qEp/hs7MfImS
	zKQVfMiLPHCcytGw9qpSdh2eiWFM6uux58raJSqgRHZ2swuov5g6489b+iejQJAOPVUiL6FsJmE8x
	baA4EtjFBj2+7umxNf0YrEdtvrxF+wqtd4X74BIzTGv6JlMGztwnpR0pqudq9Jw6uoV/jOVQRR+tt
	5qIdubdtz44hXu74kQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQcRp-007EdY-0g;
	Thu, 26 Dec 2024 01:13:57 +0000
From: linux@treblig.org
To: stf_xl@wp.pl,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/2] wifi: iwlegacy: Remove unused il_get_single_channel_number
Date: Thu, 26 Dec 2024 01:13:55 +0000
Message-ID: <20241226011355.135417-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241226011355.135417-1-linux@treblig.org>
References: <20241226011355.135417-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

THe last use of il_get_single_channel_number() was removed in 2011 by
commit dd6d2a8aef69 ("iwlegacy: remove reset rf infrastructure")
when it was still called iwl_legacy_get_single_channel_number.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 31 --------------------
 drivers/net/wireless/intel/iwlegacy/common.h |  1 -
 2 files changed, 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 958dd4f9bc69..af4f42534ea0 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -3915,37 +3915,6 @@ il_set_rxon_ht(struct il_priv *il, struct il_ht_config *ht_conf)
 }
 EXPORT_SYMBOL(il_set_rxon_ht);
 
-/* Return valid, unused, channel for a passive scan to reset the RF */
-u8
-il_get_single_channel_number(struct il_priv *il, enum nl80211_band band)
-{
-	const struct il_channel_info *ch_info;
-	int i;
-	u8 channel = 0;
-	u8 min, max;
-
-	if (band == NL80211_BAND_5GHZ) {
-		min = 14;
-		max = il->channel_count;
-	} else {
-		min = 0;
-		max = 14;
-	}
-
-	for (i = min; i < max; i++) {
-		channel = il->channel_info[i].channel;
-		if (channel == le16_to_cpu(il->staging.channel))
-			continue;
-
-		ch_info = il_get_channel_info(il, band, channel);
-		if (il_is_channel_valid(ch_info))
-			break;
-	}
-
-	return channel;
-}
-EXPORT_SYMBOL(il_get_single_channel_number);
-
 /*
  * il_set_rxon_channel - Set the band and channel values in staging RXON
  * @ch: requested channel as a pointer to struct ieee80211_channel
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 725c2a88ddb7..92285412ab10 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -1705,7 +1705,6 @@ int il_full_rxon_required(struct il_priv *il);
 int il_set_rxon_channel(struct il_priv *il, struct ieee80211_channel *ch);
 void il_set_flags_for_band(struct il_priv *il, enum nl80211_band band,
 			   struct ieee80211_vif *vif);
-u8 il_get_single_channel_number(struct il_priv *il, enum nl80211_band band);
 void il_set_rxon_ht(struct il_priv *il, struct il_ht_config *ht_conf);
 bool il_is_ht40_tx_allowed(struct il_priv *il,
 			   struct ieee80211_sta_ht_cap *ht_cap);
-- 
2.47.1


