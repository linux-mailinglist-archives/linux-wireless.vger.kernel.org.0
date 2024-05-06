Return-Path: <linux-wireless+bounces-7246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E4E8BD5CE
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A642814A3
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099F15B986;
	Mon,  6 May 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RxhxGlyV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E715ADA1
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024745; cv=none; b=t4XJlvQhtBjOuwAjpLvxdNHrzcfmqjzcZb//YQrJXIRcrlvX1X9ZBrImbUEzThvU62vXv39G1+USa2CXeJ/iuLEltVH3E/GkGeLjLyRpg+zUAn96Sub/786AHJGN3w1wzBu4uGp5KpKwU1dxD/TpwUOwaCBcHcQXfu+4zmZKqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024745; c=relaxed/simple;
	bh=8Cdfdfdn39pyCUXWEhYn27AwFxGPn7MJdtuFwjhKTaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5wouQOCFcEOvUJB+he9JCwa1TZ84j54sxEX1JVzU4Zh4oxp0uW7C3O2+GcL29VJUb2nnIbYa7WOJSVVC2WDuhOCtgAKomcT2HOIytbO9kkclD4h9Acza1v2gruJ/5/x3/P+XBdN8ruEQFopHNK3G/5OGJW7AYfvJi/9jYBhAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RxhxGlyV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6yLCv9zEcVNdfK81dnbPROqcNWJH7sOxsBfO0trtLdQ=;
	t=1715024744; x=1716234344; b=RxhxGlyV6Lth9ENKAH27qj+wobiWLg311CgPZsSgfa+LPk3
	Fuuz+6hj0BREfl2mS7mlmgjA2wsLd5m8PvmvkZxDTJV5lfEVYBR4yo9kEH/tM4GceobYFZTzeIXXc
	Tz11gfBPdGyCgRBXbiCkZZ9kNYm5PINuXzcegZr1HdExZ7LB2fImYs7cu0iNyywuEtg7AFdPqmAAd
	J+5IXBvUIHfRvlWcI/zoGmpfYLnz2relGHtzcu2tcbaYYyArRweASyDKZxs4KsS02+8xw3A0ADjQM
	3D0tOUJd9FKPdBe82VLD3QeETzp9iGTAhytc0nhYiWvhVTjts0w7y3zksvLekiAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s44HN-00000008C27-0cjo;
	Mon, 06 May 2024 21:45:41 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/5] wifi: ieee80211/ath11k: remove IEEE80211_MAX_NUM_PWR_LEVEL
Date: Mon,  6 May 2024 21:37:54 +0200
Message-ID: <20240506214536.9818e5471055.Icece7e47e963d6b68e0d97ba13c102b37fbaa689@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506194536.102148-7-johannes@sipsolutions.net>
References: <20240506194536.102148-7-johannes@sipsolutions.net>
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
index 205f40ee6b66..df24f0e409af 100644
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
index 4f62e38ba48b..59e5e8085742 100644
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


