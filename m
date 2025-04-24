Return-Path: <linux-wireless+bounces-21988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95966A9ADAF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EB6463F85
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04027B504;
	Thu, 24 Apr 2025 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYjBTrKx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63027A936
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498343; cv=none; b=ExeQN12cEWaRdFcM7XEGTrCJjSvSPVd6r1Pyruzx4gcymxYjUdrdaGWbcdPDTMTdz45M4bqYYvLLjlzMv5hFMgMkMvFYcpOWQKHcjQAk+HRq3+7lsv/SBHW7bkPivfyW7r8TkdcQRzmJX/Hwlw+T9fvUL16E7OuvwLZpLpkkR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498343; c=relaxed/simple;
	bh=KCGhGY749hNCgVIaYl7iifAn2zfHgXR/iqVmbfUFQag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcT8HMV7aOxyERIdtYO6i33B2JGuS+v3wCdMG80AYOAFLdzlG8PRXRIh+KqXs1xlmJRSDSK+S6C8wJVAVyJ9Mj6z+2CJVqM+qCzZoIRIFzhMQMusVF1L1AxeBWhRsx4yllHAu4+dlBmq5LI41Vn7rSxASeJdGajcsirEnNwK1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYjBTrKx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498342; x=1777034342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KCGhGY749hNCgVIaYl7iifAn2zfHgXR/iqVmbfUFQag=;
  b=YYjBTrKxJwGRNVcb9JXqIjwowGwikzMAvOkfW7KhC7+Tkw1Ef9R2HMap
   TtNgMttaatZh8YPf8iuBpRWIcj6AcT0prLaUb0HwJBiKCwtg0jeqypLuF
   1Z6hu44A97TABUH1lY/dviut4Ro5t2hlSHK/0Pn6k8UQIwd1qKz4AzLNb
   GHYxISM/1KAE/XKTcpnA0EDE1pvj+kWgfD/OHo0iud5SBxI4BfkghHaRc
   EaF8L+Hzn4Ryu1E97OaP6rFiRhyjoisu8OHhzFE+xBcYswsvkz0fDDEaM
   ENoWdopA0GGxsM3mWq8brNmidPScQVyPfSNT+vJTwzfuX+TnXfa8O8Jqi
   w==;
X-CSE-ConnectionGUID: KLGSIYiCT+KriFeW2cE2HQ==
X-CSE-MsgGUID: XX02qyl1QJaxV56Vw0+i2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302431"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302431"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:39:01 -0700
X-CSE-ConnectionGUID: LWqL1BWARUy/dGWYz+TCpQ==
X-CSE-MsgGUID: ECf6NBrXR2WO7DYeK6L/4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137442"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:39:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 09/14] wifi: iwlwifi: mld: rx: simplify channel handling
Date: Thu, 24 Apr 2025 15:38:26 +0300
Message-Id: <20250424153620.409c2f4ecbcc.I1735cd773ed07ad9fae44bdfc46261fa9a8fd0e0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to have the channel in phy_data, this
code only supports one descriptor format so can use
it directly from there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c | 28 ++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index c04097b1c825..ef366b7a20d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -33,7 +33,6 @@ struct iwl_mld_rx_phy_data {
 	u32 gp2_on_air_rise;
 	u16 phy_info;
 	u8 energy_a, energy_b;
-	u8 channel;
 };
 
 static void
@@ -43,7 +42,6 @@ iwl_mld_fill_phy_data(struct iwl_rx_mpdu_desc *desc,
 	phy_data->phy_info = le16_to_cpu(desc->phy_info);
 	phy_data->rate_n_flags = le32_to_cpu(desc->v3.rate_n_flags);
 	phy_data->gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
-	phy_data->channel = desc->v3.channel;
 	phy_data->energy_a = desc->v3.energy_a;
 	phy_data->energy_b = desc->v3.energy_b;
 	phy_data->data0 = desc->v3.phy_data0;
@@ -1735,15 +1733,11 @@ static void iwl_mld_rx_update_ampdu_ref(struct iwl_mld *mld,
 }
 
 static void
-iwl_mld_fill_rx_status_band_freq(struct iwl_mld_rx_phy_data *phy_data,
-				 struct iwl_rx_mpdu_desc *mpdu_desc,
-				 struct ieee80211_rx_status *rx_status)
+iwl_mld_fill_rx_status_band_freq(struct ieee80211_rx_status *rx_status,
+				 u8 band, u8 channel)
 {
-	u8 band = u8_get_bits(mpdu_desc->mac_phy_band,
-			      IWL_RX_MPDU_MAC_PHY_BAND_BAND_MASK);
-
 	rx_status->band = iwl_mld_phy_band_to_nl80211(band);
-	rx_status->freq = ieee80211_channel_to_frequency(phy_data->channel,
+	rx_status->freq = ieee80211_channel_to_frequency(channel,
 							 rx_status->band);
 }
 
@@ -1758,7 +1752,7 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 	struct sk_buff *skb;
 	size_t mpdu_desc_size = sizeof(*mpdu_desc);
 	bool drop = false;
-	u8 crypto_len = 0;
+	u8 crypto_len = 0, band;
 	u32 pkt_len = iwl_rx_packet_payload_len(pkt);
 	u32 mpdu_len;
 	enum iwl_mld_reorder_result reorder_res;
@@ -1802,7 +1796,11 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 	rx_status = IEEE80211_SKB_RXCB(skb);
 
 	/* this is needed early */
-	iwl_mld_fill_rx_status_band_freq(&phy_data, mpdu_desc, rx_status);
+	band = u8_get_bits(mpdu_desc->mac_phy_band,
+			   IWL_RX_MPDU_MAC_PHY_BAND_BAND_MASK);
+	iwl_mld_fill_rx_status_band_freq(rx_status, band,
+					 mpdu_desc->v3.channel);
+
 
 	rcu_read_lock();
 
@@ -1956,6 +1954,7 @@ void iwl_mld_rx_monitor_no_data(struct iwl_mld *mld, struct napi_struct *napi,
 	struct ieee80211_rx_status *rx_status;
 	struct sk_buff *skb;
 	u32 format, rssi;
+	u8 channel;
 
 	if (unlikely(mld->fw_status.in_hw_restart))
 		return;
@@ -1968,9 +1967,10 @@ void iwl_mld_rx_monitor_no_data(struct iwl_mld *mld, struct napi_struct *napi,
 	desc = (void *)pkt->data;
 
 	rssi = le32_to_cpu(desc->rssi);
+	channel = u32_get_bits(rssi, RX_NO_DATA_CHANNEL_MSK);
+
 	phy_data.energy_a = u32_get_bits(rssi, RX_NO_DATA_CHAIN_A_MSK);
 	phy_data.energy_b = u32_get_bits(rssi, RX_NO_DATA_CHAIN_B_MSK);
-	phy_data.channel = u32_get_bits(rssi, RX_NO_DATA_CHANNEL_MSK);
 	phy_data.data0 = desc->phy_info[0];
 	phy_data.data1 = desc->phy_info[1];
 	phy_data.phy_info = IWL_RX_MPDU_PHY_TSF_OVERLOAD;
@@ -2018,10 +2018,10 @@ void iwl_mld_rx_monitor_no_data(struct iwl_mld *mld, struct napi_struct *napi,
 		break;
 	}
 
-	rx_status->band = phy_data.channel > 14 ? NL80211_BAND_5GHZ :
+	rx_status->band = channel > 14 ? NL80211_BAND_5GHZ :
 		NL80211_BAND_2GHZ;
 
-	rx_status->freq = ieee80211_channel_to_frequency(phy_data.channel,
+	rx_status->freq = ieee80211_channel_to_frequency(channel,
 							 rx_status->band);
 
 	iwl_mld_rx_fill_status(mld, skb, &phy_data, NULL, NULL, queue);
-- 
2.34.1


