Return-Path: <linux-wireless+bounces-6740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0158AF7B6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 22:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F14DB2427D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003F914262B;
	Tue, 23 Apr 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bkkW0n6K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A31422BB
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902428; cv=none; b=AHwT5Y+zG291vRHiViykDH7VUuBpAHLqrbe7BtbM51ktU5EbtFpQDD0oD3QjaSjuAzjnKvWsJTzSPsfQqAsKvvaCUvW/5AJeT5BN4GpoKvSl6XCSXcxUrQ8eLQQGbpExgBj95x80GdR6YGEP3TLSxYayp6L9XcFOsxjPCkuw2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902428; c=relaxed/simple;
	bh=lmch4M2vtnBuoWHcE3iavH/cS5o13A3AfAgNRlZPq9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjvZ9YTXCZGBRxhr1PHSILk2mY8khPbDGgJ2rUp/qfMAu181CFfGYgJnhWortq46zdi5f5+r+2f/WklJDfZnAG5ss6Dkpqu3r/3QDtM9CrNBBxXlSFMEkCMJ+6ecbmDNZbPjiPmp8F/f1AK03yZ//ymCidxMPDx4hiDH9l6tvlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bkkW0n6K; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BC5oyaIdn497QjOroxvmZgJF14Cw3vvhCxwCiepkjqk=;
	t=1713902427; x=1715112027; b=bkkW0n6K+aSAe9h3mSy7WY2Z6Hmslu1kVIpheDbN4BVW2a6
	9iYXd1SV+NqRXTw2Q7eAa9nxi4achZCO5VKbTj1tzOcmgoQyASkMlbJjtwmjyzoqEU7OUnu2+nZ76
	Ezr8pfKkzDLglhTstjkZUP/B4KPJjMTjcM2/3GIzewIOoOjdjBm4v4n+XRjx4Owr/7OhFahvBoQZ0
	oUNCmmvBmAXmUke7JKwzs04jFcpmv79We1PwJjWqA+EtFhFv3kQ8tu3KNGjXwh2GrYzJwvsyL9bVV
	CiXp4NaWpm1LdJ8eXs94Vs+dQTbmibxxY3BWVtB3UqnM2TrciS7fJ6Kl3Uls5gaA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzMJT-00000002OTL-2Nlh;
	Tue, 23 Apr 2024 22:00:23 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 1/4] wifi: ieee80211/ath11k: remove IEEE80211_MAX_NUM_PWR_LEVEL
Date: Tue, 23 Apr 2024 21:56:12 +0200
Message-ID: <20240423220019.b0806261c6ab.Icece7e47e963d6b68e0d97ba13c102b37fbaa689@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423200019.192941-6-johannes@sipsolutions.net>
References: <20240423200019.192941-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

From: Johannes Berg <johannes.berg@intel.com>

The define IEEE80211_MAX_NUM_PWR_LEVEL doesn't make much
sense. Yes, that table has a maximum value of 8, and the
table will actually remain that way, but EHT introduced
a way to encode more levels for 320 MHz channels.

Remove IEEE80211_MAX_NUM_PWR_LEVEL and, for ath11k being
the only user, add ATH11K_NUM_PWR_LEVELS, where it makes
sense since it cannot support 320 MHz channels.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath11k/core.h | 9 ++++++---
 drivers/net/wireless/ath/ath11k/mac.c  | 2 +-
 include/linux/ieee80211.h              | 5 -----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b3fb74a226fb..8bee358a075e 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -330,6 +330,9 @@ struct ath11k_chan_power_info {
 	s8 tx_power;
 };
 
+/* ath11k only deals with 160 MHz, so 8 subchannels */
+#define ATH11K_NUM_PWR_LEVELS	8
+
 /**
  * struct ath11k_reg_tpc_power_info - regulatory TPC power info
  * @is_psd_power: is PSD power or not
@@ -346,10 +349,10 @@ struct ath11k_reg_tpc_power_info {
 	u8 eirp_power;
 	enum wmi_reg_6ghz_ap_type ap_power_type;
 	u8 num_pwr_levels;
-	u8 reg_max[IEEE80211_MAX_NUM_PWR_LEVEL];
+	u8 reg_max[ATH11K_NUM_PWR_LEVELS];
 	u8 ap_constraint_power;
-	s8 tpe[IEEE80211_MAX_NUM_PWR_LEVEL];
-	struct ath11k_chan_power_info chan_power_info[IEEE80211_MAX_NUM_PWR_LEVEL];
+	s8 tpe[ATH11K_NUM_PWR_LEVELS];
+	struct ath11k_chan_power_info chan_power_info[ATH11K_NUM_PWR_LEVELS];
 };
 
 struct ath11k_vif {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c32be587000d..03b0a6ac6d6a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7688,7 +7688,7 @@ void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
 	struct ieee80211_channel *chan, *temp_chan;
 	u8 pwr_lvl_idx, num_pwr_levels, pwr_reduction;
 	bool is_psd_power = false, is_tpe_present = false;
-	s8 max_tx_power[IEEE80211_MAX_NUM_PWR_LEVEL],
+	s8 max_tx_power[ATH11K_NUM_PWR_LEVELS],
 		psd_power, tx_power;
 	s8 eirp_power = 0;
 	u16 start_freq, center_freq;
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index de2dce743ee2..68d861c9d873 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2797,11 +2797,6 @@ struct ieee80211_he_6ghz_oper {
  * So it it totally max 8 Transmit Power Envelope element.
  */
 #define IEEE80211_TPE_MAX_IE_COUNT	8
-/*
- * In "Table 9-277—Meaning of Maximum Transmit Power Count subfield"
- * of "IEEE Std 802.11ax™‐2021", the max power level is 8.
- */
-#define IEEE80211_MAX_NUM_PWR_LEVEL	8
 
 #define IEEE80211_TPE_MAX_POWER_COUNT	8
 
-- 
2.44.0


