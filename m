Return-Path: <linux-wireless+bounces-2687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE28412A5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BB51F22F76
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC815A481;
	Mon, 29 Jan 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SXoj7Oou"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA641586ED
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553685; cv=none; b=O8MJQHqPbNHH4lgAdFfF1ouXp28f4j2jlTDzUrcm+RPGRxN3L3BeQaJdL8SweI80RVezEVtVzjOBcN4KlQvzuls2V6k49FqloLTILsSow6sDJtY+6dC+XsFZ3j9kxseZFdF3XVWwpOcmHX/XtnwFmjxRfAcN4RsthN1pXhd8AF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553685; c=relaxed/simple;
	bh=X/yh6soMSPaInGxF9F4HyqYUQLHevEDIaWi+W3hb0Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avoGohRO3geSV+APowi33M8OCIl/ioBTgOYPRuDIdolRgYGPL0dc7pGq40W99jkCEOBWBsZ78DjVeDxLLP6wwro+n7tdr96JjymLZkight1Pac1C/g9zw1/0Lsc64aOyNy3uvbpwnuBfG0Qzw/usvbxtkTIUKPsfvI0Vkqk25aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SXoj7Oou; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J5/AzamHVOI7vGRQ/zYZ2hZYuQVx6FtSOM3k7/DLSmI=;
	t=1706553678; x=1707763278; b=SXoj7OouE9hx6tdnkdahldbQpfc06bLSmK3R7JiDPfxTrxk
	N3Umkgdc3ILlyUf8DFdUe+d5f43VxxaURIx7BiKIvtyjMS/zpJvN4yRLkLFCfMP27OMWUEsxhXxI9
	82Pd3++TpJ7X7MtV2pSlyQGIb1SZ5qHz7rHoVZjEhEp2vUz2eV2IGl0pMWYBqJZvY5Lwdk2iC+DuP
	9GEMRwndDnLV/BZebJpSOWX0RuZVA4iU4M0kWWD0ThnxkUyVmnefWxTefvswm1y9oak4kIRz7IWDN
	2FDLyEfVVMQEM9Kb9/F8kIebuoqwYYYbVyY0Ip8qlTDejeVGRXpxouRtwdqoTvig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZI-00000004z9N-02M7;
	Mon, 29 Jan 2024 19:41:16 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/15] wifi: mac80211: introduce 'channel request'
Date: Mon, 29 Jan 2024 19:34:40 +0100
Message-ID: <20240129194108.2e88e48bd2e9.I4256183debe975c5ed71621611206fdbb69ba330@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129184108.49639-17-johannes@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For channel contexts, mac80211 currently uses the cfg80211
chandef struct (control channel, center freq(s), width) to
define towards drivers and internally how these behave. In
fact, there are _two_ such structs used, where the min_def
can reduce bandwidth according to the stations connected.

Unfortunately,  with EHT this is longer be sufficient,  at
least not for all hardware.  EHT requires that non-AP STAs
that are connected to an AP with a lower bandwidth than it
(the AP) advertises (e.g. 160 MHz STA connected to 320 MHz
AP) still be able to receive downlink OFDMA and respond to
trigger frames for uplink OFDMA  that specify the position
and bandwidth  for the non-AP STA  relative to the channel
the AP is using.  Therefore, they need to be aware of this,
and at least for some hardware (e.g. Intel) this awareness
is in the hardware. As a result, use of the "same" channel
may need to be split over  two channel contexts where they
differ by the AP being used.

As a first step,  introduce a concept of a channel request
('chanreq') for each interface,  to control the context it
requests.   This step does nothing but reorganise the code,
so that later the AP's chandef can be added to the request
in order to handle the EHT case described above.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  12 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   4 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   4 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   |   4 +-
 drivers/net/wireless/silabs/wfx/sta.c         |   4 +-
 drivers/net/wireless/ti/wlcore/main.c         |   6 +-
 drivers/staging/vt6655/device_main.c          |   2 +-
 drivers/staging/vt6656/main_usb.c             |   2 +-
 include/net/mac80211.h                        |  12 +-
 net/mac80211/agg-tx.c                         |   2 +-
 net/mac80211/cfg.c                            |  66 ++---
 net/mac80211/chan.c                           | 233 ++++++++++--------
 net/mac80211/ht.c                             |   2 +-
 net/mac80211/ibss.c                           |  36 +--
 net/mac80211/ieee80211_i.h                    |  21 +-
 net/mac80211/iface.c                          |   6 +-
 net/mac80211/link.c                           |   3 +-
 net/mac80211/main.c                           |   2 +-
 net/mac80211/mesh.c                           |  81 +++---
 net/mac80211/mesh_plink.c                     |   4 +-
 net/mac80211/mlme.c                           |  87 ++++---
 net/mac80211/ocb.c                            |   3 +-
 net/mac80211/rate.c                           |  12 +-
 net/mac80211/spectmgmt.c                      |  22 +-
 net/mac80211/tdls.c                           |   8 +-
 net/mac80211/trace.h                          |   6 +-
 net/mac80211/util.c                           |  18 +-
 net/mac80211/vht.c                            |   6 +-
 34 files changed, 375 insertions(+), 325 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index c4f96125cf33..37e401892b9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -455,7 +455,7 @@ void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
 		break;
 	case IEEE80211_HT_OP_MODE_PROTECTION_20MHZ:
 		/* Protect when channel wider than 20MHz */
-		if (link_conf->chandef.width > NL80211_CHAN_WIDTH_20)
+		if (link_conf->chanreq.oper.width > NL80211_CHAN_WIDTH_20)
 			*protection_flags |= cpu_to_le32(ht_flag);
 		break;
 	default:
@@ -494,7 +494,7 @@ void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (link_conf->qos)
 		*qos_flags |= cpu_to_le32(MAC_QOS_FLG_UPDATE_EDCA);
 
-	if (link_conf->chandef.width != NL80211_CHAN_WIDTH_20_NOHT)
+	if (link_conf->chanreq.oper.width != NL80211_CHAN_WIDTH_20_NOHT)
 		*qos_flags |= cpu_to_le32(MAC_QOS_FLG_TGN);
 }
 
@@ -910,8 +910,8 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 		link_conf = rcu_dereference(vif->link_conf[link_id]);
 		if (link_conf) {
 			basic = link_conf->basic_rates;
-			if (link_conf->chandef.chan)
-				band = link_conf->chandef.chan->band;
+			if (link_conf->chanreq.oper.chan)
+				band = link_conf->chanreq.oper.chan->band;
 		}
 		rcu_read_unlock();
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 406956574f52..7e7895dffb65 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1630,7 +1630,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		mvm->monitor_on = true;
 		mvm->monitor_p80 =
-			iwl_mvm_chandef_get_primary_80(&vif->bss_conf.chandef);
+			iwl_mvm_chandef_get_primary_80(&vif->bss_conf.chanreq.oper);
 	}
 
 	iwl_mvm_vif_dbgfs_add_link(mvm, vif);
@@ -3409,16 +3409,16 @@ iwl_mvm_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
 		.tolerated = true,
 	};
 
-	if (WARN_ON_ONCE(!link_conf->chandef.chan ||
+	if (WARN_ON_ONCE(!link_conf->chanreq.oper.chan ||
 			 !mvmvif->link[link_id]))
 		return;
 
-	if (!(link_conf->chandef.chan->flags & IEEE80211_CHAN_RADAR)) {
+	if (!(link_conf->chanreq.oper.chan->flags & IEEE80211_CHAN_RADAR)) {
 		mvmvif->link[link_id]->he_ru_2mhz_block = false;
 		return;
 	}
 
-	cfg80211_bss_iter(hw->wiphy, &link_conf->chandef,
+	cfg80211_bss_iter(hw->wiphy, &link_conf->chanreq.oper,
 			  iwl_mvm_check_he_obss_narrow_bw_ru_iter,
 			  &iter_data);
 
@@ -3478,10 +3478,10 @@ static void iwl_mvm_mei_host_associated(struct iwl_mvm *mvm,
 		return;
 
 	/* FIXME: MEI needs to be updated for MLO */
-	if (!vif->bss_conf.chandef.chan)
+	if (!vif->bss_conf.chanreq.oper.chan)
 		return;
 
-	conn_info.channel = vif->bss_conf.chandef.chan->hw_value;
+	conn_info.channel = vif->bss_conf.chanreq.oper.chan->hw_value;
 
 	switch (mvm_sta->pairwise_cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 449229ced3bb..c7cbbee3e464 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -654,7 +654,7 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			continue;
 
 		data[n_data].link_id = link_id;
-		data[n_data].band = link_conf->chandef.chan->band;
+		data[n_data].band = link_conf->chanreq.oper.chan->band;
 		data[n_data].active = vif->active_links & BIT(link_id);
 		n_data++;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 38a84a54ff78..18275d34a3b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -161,9 +161,9 @@ static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 	if (!vif || vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	if (!vif->bss_conf.chandef.chan ||
-	    vif->bss_conf.chandef.chan->band != NL80211_BAND_2GHZ ||
-	    vif->bss_conf.chandef.width < NL80211_CHAN_WIDTH_40)
+	if (!vif->bss_conf.chanreq.oper.chan ||
+	    vif->bss_conf.chanreq.oper.chan->band != NL80211_BAND_2GHZ ||
+	    vif->bss_conf.chanreq.oper.width < NL80211_CHAN_WIDTH_40)
 		return;
 
 	if (!vif->cfg.assoc)
@@ -219,7 +219,7 @@ void iwl_mvm_update_link_smps(struct ieee80211_vif *vif,
 		return;
 
 	if (mvm->fw_static_smps_request &&
-	    link_conf->chandef.width == NL80211_CHAN_WIDTH_160 &&
+	    link_conf->chanreq.oper.width == NL80211_CHAN_WIDTH_160 &&
 	    link_conf->he_support)
 		mode = IEEE80211_SMPS_STATIC;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 6cba8a353b53..71d92635d6d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -525,10 +525,10 @@ u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta,
 	const struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
 	const struct ieee80211_sta_eht_cap *eht_cap = &link_sta->eht_cap;
 
-	if (WARN_ON_ONCE(!link_conf->chandef.chan))
+	if (WARN_ON_ONCE(!link_conf->chanreq.oper.chan))
 		return IEEE80211_MAX_MPDU_LEN_VHT_3895;
 
-	if (link_conf->chandef.chan->band == NL80211_BAND_6GHZ) {
+	if (link_conf->chanreq.oper.chan->band == NL80211_BAND_6GHZ) {
 		switch (le16_get_bits(link_sta->he_6ghz_capa.capa,
 				      IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN)) {
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
@@ -538,7 +538,7 @@ u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta,
 		default:
 			return IEEE80211_MAX_MPDU_LEN_VHT_3895;
 		}
-	} else if (link_conf->chandef.chan->band == NL80211_BAND_2GHZ &&
+	} else if (link_conf->chanreq.oper.chan->band == NL80211_BAND_2GHZ &&
 		   eht_cap->has_eht) {
 		switch (u8_get_bits(eht_cap->eht_cap_elem.mac_cap_info[0],
 				    IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 2a3ca9785974..97b9f366039a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -71,7 +71,7 @@ u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_link_sta *link_sta,
 		mpdu_dens = link_sta->ht_cap.ampdu_density;
 	}
 
-	if (link_conf->chandef.chan->band == NL80211_BAND_6GHZ) {
+	if (link_conf->chanreq.oper.chan->band == NL80211_BAND_6GHZ) {
 		/* overwrite HT values on 6 GHz */
 		mpdu_dens = le16_get_bits(link_sta->he_6ghz_capa.capa,
 					  IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
@@ -208,7 +208,7 @@ int iwl_mvm_sta_send_to_fw(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	}
 
 	if (sta->deflink.ht_cap.ht_supported ||
-	    mvm_sta->vif->bss_conf.chandef.chan->band == NL80211_BAND_6GHZ)
+	    mvm_sta->vif->bss_conf.chanreq.oper.chan->band == NL80211_BAND_6GHZ)
 		add_sta_cmd.station_flags_msk |=
 			cpu_to_le32(STA_FLG_MAX_AGG_SIZE_MSK |
 				    STA_FLG_AGG_MPDU_DENS_MSK);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index db986bfc4dc3..ed21e6aa51a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -869,10 +869,10 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 			if (WARN_ON(!link_conf))
 				band = NL80211_BAND_2GHZ;
 			else
-				band = link_conf->chandef.chan->band;
+				band = link_conf->chanreq.oper.chan->band;
 			rcu_read_unlock();
 		} else {
-			band = mvmsta->vif->bss_conf.chandef.chan->band;
+			band = mvmsta->vif->bss_conf.chanreq.oper.chan->band;
 		}
 
 		lmac = iwl_mvm_get_lmac_id(mvm, band);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index c67c4f6ca2aa..df1ad6d4e12d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -463,10 +463,10 @@ static bool mt7915_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
 		.tolerated = true,
 	};
 
-	if (!(vif->bss_conf.chandef.chan->flags & IEEE80211_CHAN_RADAR))
+	if (!(vif->bss_conf.chanreq.oper.chan->flags & IEEE80211_CHAN_RADAR))
 		return false;
 
-	cfg80211_bss_iter(hw->wiphy, &vif->bss_conf.chandef,
+	cfg80211_bss_iter(hw->wiphy, &vif->bss_conf.chanreq.oper,
 			  mt7915_check_he_obss_narrow_bw_ru_iter,
 			  &iter_data);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index eb94e832e154..487f6fcc5473 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4615,10 +4615,10 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 	if (!vif->bss_conf.he_support || vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	if (!(vif->bss_conf.chandef.chan->flags & IEEE80211_CHAN_RADAR))
+	if (!(vif->bss_conf.chanreq.oper.chan->flags & IEEE80211_CHAN_RADAR))
 		return;
 
-	cfg80211_bss_iter(hw->wiphy, &vif->bss_conf.chandef,
+	cfg80211_bss_iter(hw->wiphy, &vif->bss_conf.chanreq.oper,
 			  rtw89_mac_check_he_obss_narrow_bw_ru_iter,
 			  &tolerated);
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index e8aeb4d76c13..211fa25b9a78 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -740,7 +740,7 @@ u16 rsi_get_connected_channel(struct ieee80211_vif *vif)
 		return 0;
 
 	bss = &vif->bss_conf;
-	channel = bss->chandef.chan;
+	channel = bss->chanreq.oper.chan;
 
 	if (!channel)
 		return 0;
@@ -759,7 +759,7 @@ static void rsi_switch_channel(struct rsi_hw *adapter,
 	if (!vif)
 		return;
 
-	channel = vif->bss_conf.chandef.chan;
+	channel = vif->bss_conf.chanreq.oper.chan;
 
 	if (!channel)
 		return;
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 537caf9d914a..0abfa2902225 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -144,13 +144,13 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 		struct wfx_vif *wvif_ch0 = wdev_to_wvif(wvif->wdev, 0);
 		struct ieee80211_vif *vif_ch0 = wvif_to_vif(wvif_ch0);
 
-		chan0 = vif_ch0->bss_conf.chandef.chan;
+		chan0 = vif_ch0->bss_conf.chanreq.oper.chan;
 	}
 	if (wdev_to_wvif(wvif->wdev, 1)) {
 		struct wfx_vif *wvif_ch1 = wdev_to_wvif(wvif->wdev, 1);
 		struct ieee80211_vif *vif_ch1 = wvif_to_vif(wvif_ch1);
 
-		chan1 = vif_ch1->bss_conf.chandef.chan;
+		chan1 = vif_ch1->bss_conf.chanreq.oper.chan;
 	}
 	if (chan0 && chan1 && vif->type != NL80211_IFTYPE_AP) {
 		if (chan0->hw_value == chan1->hw_value) {
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index fb9ed97774c7..a34bd0a8725d 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2910,7 +2910,7 @@ static int wlcore_set_assoc(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 	int ret;
 
 	wlvif->aid = vif->cfg.aid;
-	wlvif->channel_type = cfg80211_get_chandef_type(&bss_conf->chandef);
+	wlvif->channel_type = cfg80211_get_chandef_type(&bss_conf->chanreq.oper);
 	wlvif->beacon_int = bss_conf->beacon_int;
 	wlvif->wmm_enabled = bss_conf->qos;
 
@@ -4242,7 +4242,7 @@ static void wl1271_bss_info_changed_ap(struct wl1271 *wl,
 
 	/* Handle HT information change */
 	if ((changed & BSS_CHANGED_HT) &&
-	    (bss_conf->chandef.width != NL80211_CHAN_WIDTH_20_NOHT)) {
+	    (bss_conf->chanreq.oper.width != NL80211_CHAN_WIDTH_20_NOHT)) {
 		ret = wl1271_acx_set_ht_information(wl, wlvif,
 					bss_conf->ht_operation_mode);
 		if (ret < 0) {
@@ -4515,7 +4515,7 @@ static void wl1271_bss_info_changed_sta(struct wl1271 *wl,
 	/* Handle new association with HT. Do this after join. */
 	if (sta_exists) {
 		bool enabled =
-			bss_conf->chandef.width != NL80211_CHAN_WIDTH_20_NOHT;
+			bss_conf->chanreq.oper.width != NL80211_CHAN_WIDTH_20_NOHT;
 
 		ret = wlcore_hw_set_peer_cap(wl,
 					     &sta_ht_cap,
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index e23a5da2b67e..283804b49e91 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1515,7 +1515,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_TXPOWER)
 		RFbSetPower(priv, priv->wCurrentRate,
-			    conf->chandef.chan->hw_value);
+			    conf->chanreq.oper.chan->hw_value);
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
 		dev_dbg(&priv->pcid->dev,
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 6c70493d1b01..7bbed462f062 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -794,7 +794,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 		vnt_set_bss_mode(priv);
 
 	if (changed & (BSS_CHANGED_TXPOWER | BSS_CHANGED_BANDWIDTH))
-		vnt_rf_setpower(priv, conf->chandef.chan);
+		vnt_rf_setpower(priv, conf->chanreq.oper.chan);
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
 		dev_dbg(&priv->usb->dev,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 62c4b4d10bb4..dd8a66e9afd9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -223,6 +223,14 @@ enum ieee80211_chanctx_change {
 	IEEE80211_CHANCTX_CHANGE_MIN_WIDTH	= BIT(4),
 };
 
+/**
+ * struct ieee80211_chan_req - A channel "request"
+ * @oper: channel definition to use for operation
+ */
+struct ieee80211_chan_req {
+	struct cfg80211_chan_def oper;
+};
+
 /**
  * struct ieee80211_chanctx_conf - channel context that vifs may be tuned to
  *
@@ -583,7 +591,7 @@ struct ieee80211_fils_discovery {
  * @mcast_rate: per-band multicast rate index + 1 (0: disabled)
  * @bssid: The BSSID for this BSS
  * @enable_beacon: whether beaconing should be enabled or not
- * @chandef: Channel definition for this BSS -- the hardware might be
+ * @chanreq: Channel request for this BSS -- the hardware might be
  *	configured a higher bandwidth than this BSS uses, for example.
  * @mu_group: VHT MU-MIMO group membership data
  * @ht_operation_mode: HT operation mode like in &struct ieee80211_ht_operation.
@@ -716,7 +724,7 @@ struct ieee80211_bss_conf {
 	u32 cqm_rssi_hyst;
 	s32 cqm_rssi_low;
 	s32 cqm_rssi_high;
-	struct cfg80211_chan_def chandef;
+	struct ieee80211_chan_req chanreq;
 	struct ieee80211_mu_group_data mu_group;
 	bool qos;
 	bool hidden_ssid;
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index b8a278355e18..21d55dc539f6 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -616,7 +616,7 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		return -EINVAL;
 
 	if (!pubsta->deflink.ht_cap.ht_supported &&
-	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ)
+	    sta->sdata->vif.bss_conf.chanreq.oper.chan->band != NL80211_BAND_6GHZ)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(!local->ops->ampdu_action))
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8b4e3671b8f3..400abed929f4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -886,11 +886,13 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_chan_req chanreq = { .oper = *chandef };
 	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (cfg80211_chandef_identical(&local->monitor_chandef, chandef))
+	if (cfg80211_chandef_identical(&local->monitor_chanreq.oper,
+				       &chanreq.oper))
 		return 0;
 
 	sdata = wiphy_dereference(local->hw.wiphy,
@@ -898,17 +900,17 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 	if (!sdata)
 		goto done;
 
-	if (cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef, chandef))
+	if (cfg80211_chandef_identical(&sdata->vif.bss_conf.chanreq.oper,
+				       &chanreq.oper))
 		return 0;
 
 	ieee80211_link_release_channel(&sdata->deflink);
-	ret = ieee80211_link_use_channel(&sdata->deflink,
-					 chandef,
+	ret = ieee80211_link_use_channel(&sdata->deflink, &chanreq,
 					 IEEE80211_CHANCTX_EXCLUSIVE);
 	if (ret)
 		return ret;
 done:
-	local->monitor_chandef = *chandef;
+	local->monitor_chanreq = chanreq;
 	return 0;
 }
 
@@ -1253,6 +1255,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	unsigned int link_id = params->beacon.link_id;
 	struct ieee80211_link_data *link;
 	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_chan_req chanreq = { .oper = params->chandef };
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1365,7 +1368,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			return err;
 	}
 
-	err = ieee80211_link_use_channel(link, &params->chandef,
+	err = ieee80211_link_use_channel(link, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 	if (!err)
 		ieee80211_link_copy_chanctx_to_vlans(link, false);
@@ -1626,7 +1629,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 					  BSS_CHANGED_BEACON_ENABLED);
 
 	if (sdata->wdev.cac_started) {
-		chandef = link_conf->chandef;
+		chandef = link_conf->chanreq.oper;
 		wiphy_delayed_work_cancel(wiphy, &link->dfs_cac_timer_work);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
@@ -1826,7 +1829,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 
 	if (params->supported_rates &&
 	    params->supported_rates_len) {
-		ieee80211_parse_bitrates(link->conf->chandef.width,
+		ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
 					 sband, params->supported_rates,
 					 params->supported_rates_len,
 					 &link_sta->pub->supp_rates[sband->band]);
@@ -2600,6 +2603,7 @@ static int ieee80211_join_mesh(struct wiphy *wiphy, struct net_device *dev,
 			       const struct mesh_setup *setup)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_chan_req chanreq = { .oper = setup->chandef };
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	int err;
 
@@ -2616,7 +2620,7 @@ static int ieee80211_join_mesh(struct wiphy *wiphy, struct net_device *dev,
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
-	err = ieee80211_link_use_channel(&sdata->deflink, &setup->chandef,
+	err = ieee80211_link_use_channel(&sdata->deflink, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 	if (err)
 		return err;
@@ -2659,7 +2663,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		return -EINVAL;
 
 	if (params->basic_rates) {
-		if (!ieee80211_parse_bitrates(link->conf->chandef.width,
+		if (!ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
 					      wiphy->bands[sband->band],
 					      params->basic_rates,
 					      params->basic_rates_len,
@@ -3174,7 +3178,7 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	 * the new value until we associate.
 	 */
 	if (!sdata->u.mgd.associated ||
-	    link->conf->chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
+	    link->conf->chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
 	ap = sdata->vif.cfg.ap_addr;
@@ -3329,9 +3333,11 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 	 * so at a basic rate so that all clients can receive it.
 	 */
 	if (rcu_access_pointer(sdata->vif.bss_conf.chanctx_conf) &&
-	    sdata->vif.bss_conf.chandef.chan) {
+	    sdata->vif.bss_conf.chanreq.oper.chan) {
 		u32 basic_rates = sdata->vif.bss_conf.basic_rates;
-		enum nl80211_band band = sdata->vif.bss_conf.chandef.chan->band;
+		enum nl80211_band band;
+
+		band = sdata->vif.bss_conf.chanreq.oper.chan->band;
 
 		if (!(mask->control[band].legacy & basic_rates))
 			return -EINVAL;
@@ -3383,6 +3389,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 					   u32 cac_time_ms)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_chan_req chanreq = { .oper = *chandef };
 	struct ieee80211_local *local = sdata->local;
 	int err;
 
@@ -3397,7 +3404,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	sdata->deflink.needed_rx_chains = local->rx_chains;
 
-	err = ieee80211_link_use_channel(&sdata->deflink, chandef,
+	err = ieee80211_link_use_channel(&sdata->deflink, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 	if (err)
 		goto out_unlock;
@@ -3649,8 +3656,8 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 		return ieee80211_link_use_reserved_context(&sdata->deflink);
 	}
 
-	if (!cfg80211_chandef_identical(&link_data->conf->chandef,
-					&link_data->csa_chandef))
+	if (!cfg80211_chandef_identical(&link_data->conf->chanreq.oper,
+					&link_data->csa_chanreq.oper))
 		return -EINVAL;
 
 	sdata->vif.bss_conf.csa_active = false;
@@ -3677,7 +3684,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 	if (err)
 		return err;
 
-	cfg80211_ch_switch_notify(sdata->dev, &link_data->csa_chandef,
+	cfg80211_ch_switch_notify(sdata->dev, &link_data->csa_chanreq.oper,
 				  link_data->link_id,
 				  link_data->conf->eht_puncturing);
 
@@ -3812,7 +3819,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 
 		/* changes into another band are not supported */
-		if (sdata->vif.bss_conf.chandef.chan->band !=
+		if (sdata->vif.bss_conf.chanreq.oper.chan->band !=
 		    params->chandef.chan->band)
 			return -EINVAL;
 
@@ -3860,6 +3867,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 			   struct cfg80211_csa_settings *params)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_chan_req chanreq = { .oper = params->chandef };
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_channel_switch ch_switch;
 	struct ieee80211_chanctx_conf *conf;
@@ -3875,8 +3883,8 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->wdev.cac_started)
 		return -EBUSY;
 
-	if (cfg80211_chandef_identical(&params->chandef,
-				       &sdata->vif.bss_conf.chandef))
+	if (cfg80211_chandef_identical(&chanreq.oper,
+				       &sdata->vif.bss_conf.chanreq.oper))
 		return -EINVAL;
 
 	/* don't allow another channel switch if one is already active. */
@@ -3901,14 +3909,14 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	ch_switch.timestamp = 0;
 	ch_switch.device_timestamp = 0;
 	ch_switch.block_tx = params->block_tx;
-	ch_switch.chandef = params->chandef;
+	ch_switch.chandef = chanreq.oper;
 	ch_switch.count = params->count;
 
 	err = drv_pre_channel_switch(sdata, &ch_switch);
 	if (err)
 		goto out;
 
-	err = ieee80211_link_reserve_chanctx(&sdata->deflink, &params->chandef,
+	err = ieee80211_link_reserve_chanctx(&sdata->deflink, &chanreq,
 					     chanctx->mode,
 					     params->radar_required);
 	if (err)
@@ -3934,7 +3942,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (params->punct_bitmap && !sdata->vif.bss_conf.eht_support)
 		goto out;
 
-	sdata->deflink.csa_chandef = params->chandef;
+	sdata->deflink.csa_chanreq = chanreq; 
 	sdata->deflink.csa_block_tx = params->block_tx;
 	sdata->vif.bss_conf.csa_active = true;
 	sdata->vif.bss_conf.csa_punct_bitmap = params->punct_bitmap;
@@ -3944,14 +3952,15 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
-					  &sdata->deflink.csa_chandef, 0,
+					  &sdata->deflink.csa_chanreq.oper, 0,
 					  params->count, params->block_tx,
 					  sdata->vif.bss_conf.csa_punct_bitmap);
 
 	if (changed) {
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  changed);
-		drv_channel_switch_beacon(sdata, &params->chandef);
+		drv_channel_switch_beacon(sdata,
+					  &sdata->deflink.csa_chanreq.oper);
 	} else {
 		/* if the beacon didn't change, we can finalize immediately */
 		ieee80211_csa_finalize(&sdata->deflink);
@@ -4204,12 +4213,12 @@ static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
 
 	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
 	if (chanctx_conf) {
-		*chandef = link->conf->chandef;
+		*chandef = link->conf->chanreq.oper;
 		ret = 0;
 	} else if (local->open_count > 0 &&
 		   local->open_count == local->monitors &&
 		   sdata->vif.type == NL80211_IFTYPE_MONITOR) {
-		*chandef = local->monitor_chandef;
+		*chandef = local->monitor_chanreq.oper;
 		ret = 0;
 	}
 out:
@@ -4257,12 +4266,13 @@ static int ieee80211_set_ap_chanwidth(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_link_data *link;
+	struct ieee80211_chan_req chanreq = { .oper = *chandef };
 	int ret;
 	u64 changed = 0;
 
 	link = sdata_dereference(sdata->link[link_id], sdata);
 
-	ret = ieee80211_link_change_bandwidth(link, chandef, &changed);
+	ret = ieee80211_link_change_chanreq(link, &chanreq, &changed);
 	if (ret == 0)
 		ieee80211_link_info_change_notify(sdata, link, changed);
 
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 6b82c79cf7a6..f1cef332e4db 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -81,87 +81,97 @@ ieee80211_link_get_chanctx(struct ieee80211_link_data *link)
 	return container_of(conf, struct ieee80211_chanctx, conf);
 }
 
-static const struct cfg80211_chan_def *
-ieee80211_chanctx_reserved_chandef(struct ieee80211_local *local,
+static const struct ieee80211_chan_req *
+ieee80211_chanreq_compatible(const struct ieee80211_chan_req *a,
+			     const struct ieee80211_chan_req *b)
+{
+	const struct cfg80211_chan_def *compat;
+
+	compat = cfg80211_chandef_compatible(&a->oper, &b->oper);
+
+	if (compat == &a->oper)
+		return a;
+
+	if (compat == &b->oper)
+		return b;
+
+	WARN_ON(compat);
+	return NULL;
+}
+
+static const struct ieee80211_chan_req *
+ieee80211_chanctx_compatible(struct ieee80211_chanctx *ctx,
+			     const struct ieee80211_chan_req *req,
+			     struct ieee80211_chan_req *tmp)
+{
+	*tmp = (struct ieee80211_chan_req){
+		.oper = ctx->conf.def,
+	};
+
+	return ieee80211_chanreq_compatible(tmp, req);
+}
+
+static const struct ieee80211_chan_req *
+ieee80211_chanctx_reserved_chanreq(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *ctx,
-				   const struct cfg80211_chan_def *compat)
+				   const struct ieee80211_chan_req *req)
 {
 	struct ieee80211_link_data *link;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (WARN_ON(!compat))
+	if (WARN_ON(!req))
 		return NULL;
 
-	list_for_each_entry(link, &ctx->reserved_links,
-			    reserved_chanctx_list) {
-		compat = cfg80211_chandef_compatible(&link->reserved_chandef,
-						     compat);
-		if (!compat)
+	list_for_each_entry(link, &ctx->reserved_links, reserved_chanctx_list) {
+		req = ieee80211_chanreq_compatible(&link->reserved, req);
+		if (!req)
 			break;
 	}
 
-	return compat;
+	return req;
 }
 
-static const struct cfg80211_chan_def *
+static const struct ieee80211_chan_req *
 ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 				       struct ieee80211_chanctx *ctx,
-				       const struct cfg80211_chan_def *compat)
+				       const struct ieee80211_chan_req *compat)
 {
 	struct ieee80211_link_data *link;
+	const struct ieee80211_chan_req *comp_def = compat;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry(link, &ctx->assigned_links,
-			    assigned_chanctx_list) {
+	list_for_each_entry(link, &ctx->assigned_links, assigned_chanctx_list) {
 		struct ieee80211_bss_conf *link_conf = link->conf;
 
 		if (link->reserved_chanctx)
 			continue;
 
-		if (!compat)
-			compat = &link_conf->chandef;
-
-		compat = cfg80211_chandef_compatible(
-				&link_conf->chandef, compat);
-		if (!compat)
+		comp_def = ieee80211_chanreq_compatible(&link_conf->chanreq,
+							comp_def);
+		if (!comp_def)
 			break;
 	}
 
-	return compat;
-}
-
-static const struct cfg80211_chan_def *
-ieee80211_chanctx_combined_chandef(struct ieee80211_local *local,
-				   struct ieee80211_chanctx *ctx,
-				   const struct cfg80211_chan_def *compat)
-{
-	lockdep_assert_wiphy(local->hw.wiphy);
-
-	compat = ieee80211_chanctx_reserved_chandef(local, ctx, compat);
-	if (!compat)
-		return NULL;
-
-	compat = ieee80211_chanctx_non_reserved_chandef(local, ctx, compat);
-	if (!compat)
-		return NULL;
-
-	return compat;
+	return comp_def;
 }
 
 static bool
-ieee80211_chanctx_can_reserve_chandef(struct ieee80211_local *local,
-				      struct ieee80211_chanctx *ctx,
-				      const struct cfg80211_chan_def *def)
+ieee80211_chanctx_can_reserve(struct ieee80211_local *local,
+			      struct ieee80211_chanctx *ctx,
+			      const struct ieee80211_chan_req *req)
 {
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (ieee80211_chanctx_combined_chandef(local, ctx, def))
-		return true;
+	if (!ieee80211_chanctx_reserved_chanreq(local, ctx, req))
+		return false;
+
+	if (!ieee80211_chanctx_non_reserved_chandef(local, ctx, req))
+		return false;
 
 	if (!list_empty(&ctx->reserved_links) &&
-	    ieee80211_chanctx_reserved_chandef(local, ctx, def))
+	    ieee80211_chanctx_reserved_chanreq(local, ctx, req))
 		return true;
 
 	return false;
@@ -169,7 +179,7 @@ ieee80211_chanctx_can_reserve_chandef(struct ieee80211_local *local,
 
 static struct ieee80211_chanctx *
 ieee80211_find_reservation_chanctx(struct ieee80211_local *local,
-				   const struct cfg80211_chan_def *chandef,
+				   const struct ieee80211_chan_req *chanreq,
 				   enum ieee80211_chanctx_mode mode)
 {
 	struct ieee80211_chanctx *ctx;
@@ -186,8 +196,7 @@ ieee80211_find_reservation_chanctx(struct ieee80211_local *local,
 		if (ctx->mode == IEEE80211_CHANCTX_EXCLUSIVE)
 			continue;
 
-		if (!ieee80211_chanctx_can_reserve_chandef(local, ctx,
-							   chandef))
+		if (!ieee80211_chanctx_can_reserve(local, ctx, chanreq))
 			continue;
 
 		return ctx;
@@ -290,7 +299,7 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 			 * point, so take the width from the chandef, but
 			 * account also for TDLS peers
 			 */
-			width = max(link->conf->chandef.width,
+			width = max(link->conf->chanreq.oper.width,
 				    ieee80211_get_max_required_bw(sdata, link_id));
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
@@ -299,7 +308,7 @@ ieee80211_get_chanctx_vif_max_required_bw(struct ieee80211_sub_if_data *sdata,
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
-			width = link->conf->chandef.width;
+			width = link->conf->chanreq.oper.width;
 			break;
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_UNSPECIFIED:
@@ -395,7 +404,7 @@ _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 }
 
 /* calling this function is assuming that station vif is updated to
- * lates changes by calling ieee80211_link_update_chandef
+ * lates changes by calling ieee80211_link_update_chanreq
  */
 static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 				     struct ieee80211_chanctx *ctx,
@@ -475,9 +484,10 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
 				      struct ieee80211_chanctx *old_ctx,
-				      const struct cfg80211_chan_def *chandef,
+				      const struct ieee80211_chan_req *chanreq,
 				      struct ieee80211_link_data *rsvd_for)
 {
+	const struct cfg80211_chan_def *chandef = &chanreq->oper;
 	u32 changed;
 
 	/* expected to handle only 20/40/80/160/320 channel widths */
@@ -526,16 +536,17 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 static void ieee80211_change_chanctx(struct ieee80211_local *local,
 				     struct ieee80211_chanctx *ctx,
 				     struct ieee80211_chanctx *old_ctx,
-				     const struct cfg80211_chan_def *chandef)
+				     const struct ieee80211_chan_req *chanreq)
 {
-	_ieee80211_change_chanctx(local, ctx, old_ctx, chandef, NULL);
+	_ieee80211_change_chanctx(local, ctx, old_ctx, chanreq, NULL);
 }
 
 static struct ieee80211_chanctx *
 ieee80211_find_chanctx(struct ieee80211_local *local,
-		       const struct cfg80211_chan_def *chandef,
+		       const struct ieee80211_chan_req *chanreq,
 		       enum ieee80211_chanctx_mode mode)
 {
+	struct ieee80211_chan_req tmp;
 	struct ieee80211_chanctx *ctx;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -544,7 +555,7 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 		return NULL;
 
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		const struct cfg80211_chan_def *compat;
+		const struct ieee80211_chan_req *compat;
 
 		if (ctx->replace_state != IEEE80211_CHANCTX_REPLACE_NONE)
 			continue;
@@ -552,11 +563,11 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 		if (ctx->mode == IEEE80211_CHANCTX_EXCLUSIVE)
 			continue;
 
-		compat = cfg80211_chandef_compatible(&ctx->conf.def, chandef);
+		compat = ieee80211_chanctx_compatible(ctx, chanreq, &tmp);
 		if (!compat)
 			continue;
 
-		compat = ieee80211_chanctx_reserved_chandef(local, ctx,
+		compat = ieee80211_chanctx_reserved_chanreq(local, ctx,
 							    compat);
 		if (!compat)
 			continue;
@@ -636,7 +647,7 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 
 static struct ieee80211_chanctx *
 ieee80211_alloc_chanctx(struct ieee80211_local *local,
-			const struct cfg80211_chan_def *chandef,
+			const struct ieee80211_chan_req *chanreq,
 			enum ieee80211_chanctx_mode mode)
 {
 	struct ieee80211_chanctx *ctx;
@@ -649,7 +660,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 
 	INIT_LIST_HEAD(&ctx->assigned_links);
 	INIT_LIST_HEAD(&ctx->reserved_links);
-	ctx->conf.def = *chandef;
+	ctx->conf.def = chanreq->oper;
 	ctx->conf.rx_chains_static = 1;
 	ctx->conf.rx_chains_dynamic = 1;
 	ctx->mode = mode;
@@ -685,7 +696,7 @@ static int ieee80211_add_chanctx(struct ieee80211_local *local,
 
 static struct ieee80211_chanctx *
 ieee80211_new_chanctx(struct ieee80211_local *local,
-		      const struct cfg80211_chan_def *chandef,
+		      const struct ieee80211_chan_req *chanreq,
 		      enum ieee80211_chanctx_mode mode)
 {
 	struct ieee80211_chanctx *ctx;
@@ -693,7 +704,7 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	ctx = ieee80211_alloc_chanctx(local, chandef, mode);
+	ctx = ieee80211_alloc_chanctx(local, chanreq, mode);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
@@ -737,6 +748,7 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 	struct ieee80211_chanctx_conf *conf = &ctx->conf;
 	struct ieee80211_sub_if_data *sdata;
 	const struct cfg80211_chan_def *compat = NULL;
+	struct ieee80211_chan_req chanreq = {};
 	struct sta_info *sta;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -762,9 +774,9 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 				continue;
 
 			if (!compat)
-				compat = &link_conf->chandef;
+				compat = &link_conf->chanreq.oper;
 
-			compat = cfg80211_chandef_compatible(&link_conf->chandef,
+			compat = cfg80211_chandef_compatible(&link_conf->chanreq.oper,
 							     compat);
 			if (WARN_ON_ONCE(!compat))
 				break;
@@ -794,7 +806,9 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 	if (!compat)
 		return;
 
-	ieee80211_change_chanctx(local, ctx, ctx, compat);
+	chanreq.oper = *compat;
+
+	ieee80211_change_chanctx(local, ctx, ctx, &chanreq);
 }
 
 static void ieee80211_recalc_radar_chanctx(struct ieee80211_local *local,
@@ -1050,7 +1064,7 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 }
 
 int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
-				   const struct cfg80211_chan_def *chandef,
+				   const struct ieee80211_chan_req *chanreq,
 				   enum ieee80211_chanctx_mode mode,
 				   bool radar_required)
 {
@@ -1064,10 +1078,10 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 	if (curr_ctx && !local->ops->switch_vif_chanctx)
 		return -EOPNOTSUPP;
 
-	new_ctx = ieee80211_find_reservation_chanctx(local, chandef, mode);
+	new_ctx = ieee80211_find_reservation_chanctx(local, chanreq, mode);
 	if (!new_ctx) {
 		if (ieee80211_can_create_new_chanctx(local)) {
-			new_ctx = ieee80211_new_chanctx(local, chandef, mode);
+			new_ctx = ieee80211_new_chanctx(local, chanreq, mode);
 			if (IS_ERR(new_ctx))
 				return PTR_ERR(new_ctx);
 		} else {
@@ -1121,7 +1135,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 			    !list_empty(&curr_ctx->reserved_links))
 				return -EBUSY;
 
-			new_ctx = ieee80211_alloc_chanctx(local, chandef, mode);
+			new_ctx = ieee80211_alloc_chanctx(local, chanreq, mode);
 			if (!new_ctx)
 				return -ENOMEM;
 
@@ -1139,7 +1153,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 
 	list_add(&link->reserved_chanctx_list, &new_ctx->reserved_links);
 	link->reserved_chanctx = new_ctx;
-	link->reserved_chandef = *chandef;
+	link->reserved = *chanreq;
 	link->reserved_radar_required = radar_required;
 	link->reserved_ready = false;
 
@@ -1178,14 +1192,14 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 }
 
 static void
-ieee80211_link_update_chandef(struct ieee80211_link_data *link,
-			      const struct cfg80211_chan_def *chandef)
+ieee80211_link_update_chanreq(struct ieee80211_link_data *link,
+			      const struct ieee80211_chan_req *chanreq)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	unsigned int link_id = link->link_id;
 	struct ieee80211_sub_if_data *vlan;
 
-	link->conf->chandef = *chandef;
+	link->conf->chanreq = *chanreq;
 
 	if (sdata->vif.type != NL80211_IFTYPE_AP)
 		return;
@@ -1198,7 +1212,7 @@ ieee80211_link_update_chandef(struct ieee80211_link_data *link,
 		if (WARN_ON(!vlan_conf))
 			continue;
 
-		vlan_conf->chandef = *chandef;
+		vlan_conf->chanreq = *chanreq;
 	}
 	rcu_read_unlock();
 }
@@ -1211,7 +1225,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_vif_chanctx_switch vif_chsw[1] = {};
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
-	const struct cfg80211_chan_def *chandef;
+	const struct ieee80211_chan_req *chanreq;
 	u64 changed = 0;
 	int err;
 
@@ -1233,17 +1247,17 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 		    IEEE80211_CHANCTX_REPLACES_OTHER))
 		return -EINVAL;
 
-	chandef = ieee80211_chanctx_non_reserved_chandef(local, new_ctx,
-				&link->reserved_chandef);
-	if (WARN_ON(!chandef))
+	chanreq = ieee80211_chanctx_non_reserved_chandef(local, new_ctx,
+							 &link->reserved);
+	if (WARN_ON(!chanreq))
 		return -EINVAL;
 
-	if (link_conf->chandef.width != link->reserved_chandef.width)
+	if (link_conf->chanreq.oper.width != link->reserved.oper.width)
 		changed = BSS_CHANGED_BANDWIDTH;
 
-	ieee80211_link_update_chandef(link, &link->reserved_chandef);
+	ieee80211_link_update_chanreq(link, &link->reserved);
 
-	_ieee80211_change_chanctx(local, new_ctx, old_ctx, chandef, link);
+	_ieee80211_change_chanctx(local, new_ctx, old_ctx, chanreq, link);
 
 	vif_chsw[0].vif = &sdata->vif;
 	vif_chsw[0].old_ctx = &old_ctx->conf;
@@ -1291,7 +1305,7 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
-	const struct cfg80211_chan_def *chandef;
+	const struct ieee80211_chan_req *chanreq;
 	int err;
 
 	old_ctx = ieee80211_link_get_chanctx(link);
@@ -1310,12 +1324,12 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 		    IEEE80211_CHANCTX_REPLACES_OTHER))
 		return -EINVAL;
 
-	chandef = ieee80211_chanctx_non_reserved_chandef(local, new_ctx,
-				&link->reserved_chandef);
-	if (WARN_ON(!chandef))
+	chanreq = ieee80211_chanctx_non_reserved_chandef(local, new_ctx,
+							 &link->reserved);
+	if (WARN_ON(!chanreq))
 		return -EINVAL;
 
-	ieee80211_change_chanctx(local, new_ctx, new_ctx, chandef);
+	ieee80211_change_chanctx(local, new_ctx, new_ctx, chanreq);
 
 	list_del(&link->reserved_chanctx_list);
 	link->reserved_chanctx = NULL;
@@ -1589,10 +1603,10 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 
 			link->radar_required = link->reserved_radar_required;
 
-			if (link_conf->chandef.width != link->reserved_chandef.width)
+			if (link_conf->chanreq.oper.width != link->reserved.oper.width)
 				changed = BSS_CHANGED_BANDWIDTH;
 
-			ieee80211_link_update_chandef(link, &link->reserved_chandef);
+			ieee80211_link_update_chanreq(link, &link->reserved);
 			if (changed)
 				ieee80211_link_info_change_notify(sdata,
 								  link,
@@ -1727,7 +1741,7 @@ static void __ieee80211_link_release_channel(struct ieee80211_link_data *link)
 }
 
 int ieee80211_link_use_channel(struct ieee80211_link_data *link,
-			       const struct cfg80211_chan_def *chandef,
+			       const struct ieee80211_chan_req *chanreq,
 			       enum ieee80211_chanctx_mode mode)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
@@ -1740,36 +1754,36 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	if (sdata->vif.active_links &&
 	    !(sdata->vif.active_links & BIT(link->link_id))) {
-		ieee80211_link_update_chandef(link, chandef);
+		ieee80211_link_update_chanreq(link, chanreq);
 		return 0;
 	}
 
 	ret = cfg80211_chandef_dfs_required(local->hw.wiphy,
-					    chandef,
+					    &chanreq->oper,
 					    sdata->wdev.iftype);
 	if (ret < 0)
 		goto out;
 	if (ret > 0)
-		radar_detect_width = BIT(chandef->width);
+		radar_detect_width = BIT(chanreq->oper.width);
 
 	link->radar_required = ret;
 
-	ret = ieee80211_check_combinations(sdata, chandef, mode,
+	ret = ieee80211_check_combinations(sdata, &chanreq->oper, mode,
 					   radar_detect_width);
 	if (ret < 0)
 		goto out;
 
 	__ieee80211_link_release_channel(link);
 
-	ctx = ieee80211_find_chanctx(local, chandef, mode);
+	ctx = ieee80211_find_chanctx(local, chanreq, mode);
 	if (!ctx)
-		ctx = ieee80211_new_chanctx(local, chandef, mode);
+		ctx = ieee80211_new_chanctx(local, chanreq, mode);
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
 		goto out;
 	}
 
-	ieee80211_link_update_chandef(link, chandef);
+	ieee80211_link_update_chanreq(link, chanreq);
 
 	ret = ieee80211_assign_link_chanctx(link, ctx);
 	if (ret) {
@@ -1849,28 +1863,33 @@ int ieee80211_link_use_reserved_context(struct ieee80211_link_data *link)
 	return 0;
 }
 
-int ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
-				    const struct cfg80211_chan_def *chandef,
-				    u64 *changed)
+int ieee80211_link_change_chanreq(struct ieee80211_link_data *link,
+				  const struct ieee80211_chan_req *chanreq,
+				  u64 *changed)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_bss_conf *link_conf = link->conf;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *ctx;
-	const struct cfg80211_chan_def *compat;
+	const struct ieee80211_chan_req *compat;
+	struct ieee80211_chan_req tmp;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (!cfg80211_chandef_usable(sdata->local->hw.wiphy, chandef,
+	if (!cfg80211_chandef_usable(sdata->local->hw.wiphy,
+				     &chanreq->oper,
 				     IEEE80211_CHAN_DISABLED))
 		return -EINVAL;
 
-	if (cfg80211_chandef_identical(chandef, &link_conf->chandef))
+	/* for non-HT 20 MHz the rest doesn't matter */
+	if (chanreq->oper.width == NL80211_CHAN_WIDTH_20_NOHT &&
+	    cfg80211_chandef_identical(&chanreq->oper, &link_conf->chanreq.oper))
 		return 0;
 
-	if (chandef->width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    link_conf->chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
+	/* but you cannot switch to/from it */
+	if (chanreq->oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    link_conf->chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return -EINVAL;
 
 	conf = rcu_dereference_protected(link_conf->chanctx_conf,
@@ -1880,13 +1899,13 @@ int ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
 
 	ctx = container_of(conf, struct ieee80211_chanctx, conf);
 
-	compat = cfg80211_chandef_compatible(&conf->def, chandef);
+	compat = ieee80211_chanctx_compatible(ctx, chanreq, &tmp);
 	if (!compat)
 		return -EINVAL;
 
 	switch (ctx->replace_state) {
 	case IEEE80211_CHANCTX_REPLACE_NONE:
-		if (!ieee80211_chanctx_reserved_chandef(local, ctx, compat))
+		if (!ieee80211_chanctx_reserved_chanreq(local, ctx, compat))
 			return -EBUSY;
 		break;
 	case IEEE80211_CHANCTX_WILL_BE_REPLACED:
@@ -1901,7 +1920,7 @@ int ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
 		break;
 	}
 
-	ieee80211_link_update_chandef(link, chandef);
+	ieee80211_link_update_chanreq(link, chanreq);
 
 	ieee80211_recalc_chanctx_chantype(local, ctx);
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 749f4ecab990..cfe2653ed47f 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -257,7 +257,7 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON(!link_conf))
 		width = NL80211_CHAN_WIDTH_20_NOHT;
 	else
-		width = link_conf->chandef.width;
+		width = link_conf->chanreq.oper.width;
 
 	switch (width) {
 	default:
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index c23f46218af7..27cc9ddd0432 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -223,7 +223,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgmt *mgmt;
 	struct cfg80211_bss *bss;
 	u64 bss_change;
-	struct cfg80211_chan_def chandef;
+	struct ieee80211_chan_req chanreq = {};
 	struct ieee80211_channel *chan;
 	struct beacon_data *presp;
 	struct cfg80211_inform_bss bss_meta = {};
@@ -257,22 +257,22 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 		kfree_rcu(presp, rcu_head);
 
 	/* make a copy of the chandef, it could be modified below. */
-	chandef = *req_chandef;
-	chan = chandef.chan;
-	if (!cfg80211_reg_can_beacon(local->hw.wiphy, &chandef,
+	chanreq.oper = *req_chandef;
+	chan = chanreq.oper.chan;
+	if (!cfg80211_reg_can_beacon(local->hw.wiphy, &chanreq.oper,
 				     NL80211_IFTYPE_ADHOC)) {
-		if (chandef.width == NL80211_CHAN_WIDTH_5 ||
-		    chandef.width == NL80211_CHAN_WIDTH_10 ||
-		    chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
-		    chandef.width == NL80211_CHAN_WIDTH_20) {
+		if (chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+		    chanreq.oper.width == NL80211_CHAN_WIDTH_10 ||
+		    chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+		    chanreq.oper.width == NL80211_CHAN_WIDTH_20) {
 			sdata_info(sdata,
 				   "Failed to join IBSS, beacons forbidden\n");
 			return;
 		}
-		chandef.width = NL80211_CHAN_WIDTH_20;
-		chandef.center_freq1 = chan->center_freq;
+		chanreq.oper.width = NL80211_CHAN_WIDTH_20;
+		chanreq.oper.center_freq1 = chan->center_freq;
 		/* check again for downgraded chandef */
-		if (!cfg80211_reg_can_beacon(local->hw.wiphy, &chandef,
+		if (!cfg80211_reg_can_beacon(local->hw.wiphy, &chanreq.oper,
 					     NL80211_IFTYPE_ADHOC)) {
 			sdata_info(sdata,
 				   "Failed to join IBSS, beacons forbidden\n");
@@ -281,7 +281,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	}
 
 	err = cfg80211_chandef_dfs_required(sdata->local->hw.wiphy,
-					    &chandef, NL80211_IFTYPE_ADHOC);
+					    &chanreq.oper, NL80211_IFTYPE_ADHOC);
 	if (err < 0) {
 		sdata_info(sdata,
 			   "Failed to join IBSS, invalid chandef\n");
@@ -295,7 +295,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 
 	radar_required = err;
 
-	if (ieee80211_link_use_channel(&sdata->deflink, &chandef,
+	if (ieee80211_link_use_channel(&sdata->deflink, &chanreq,
 				       ifibss->fixed_channel ?
 					IEEE80211_CHANCTX_SHARED :
 					IEEE80211_CHANCTX_EXCLUSIVE)) {
@@ -307,7 +307,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	memcpy(ifibss->bssid, bssid, ETH_ALEN);
 
 	presp = ieee80211_ibss_build_presp(sdata, beacon_int, basic_rates,
-					   capability, tsf, &chandef,
+					   capability, tsf, &chanreq.oper,
 					   &have_higher_than_11mbit, NULL);
 	if (!presp)
 		return;
@@ -533,12 +533,12 @@ int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata, u64 *changed)
 					IEEE80211_PRIVACY(ifibss->privacy));
 		/* XXX: should not really modify cfg80211 data */
 		if (cbss) {
-			cbss->channel = sdata->deflink.csa_chandef.chan;
+			cbss->channel = sdata->deflink.csa_chanreq.oper.chan;
 			cfg80211_put_bss(sdata->local->hw.wiphy, cbss);
 		}
 	}
 
-	ifibss->chandef = sdata->deflink.csa_chandef;
+	ifibss->chandef = sdata->deflink.csa_chanreq.oper;
 
 	/* generate the beacon */
 	return ieee80211_ibss_csa_beacon(sdata, NULL, changed);
@@ -799,7 +799,7 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 		goto disconnect;
 
 	params.count = csa_ie.count;
-	params.chandef = csa_ie.chandef;
+	params.chandef = csa_ie.chanreq.oper;
 
 	switch (ifibss->chandef.width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
@@ -858,7 +858,7 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	params.radar_required = err;
 
 	if (cfg80211_chandef_identical(&params.chandef,
-				       &sdata->vif.bss_conf.chandef)) {
+				       &sdata->vif.bss_conf.chanreq.oper)) {
 		ibss_dbg(sdata,
 			 "received csa with an identical chandef, ignoring\n");
 		return true;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cb4684a9451e..70c48cad180a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -884,6 +884,9 @@ struct ieee80211_chanctx {
 	enum ieee80211_chanctx_mode mode;
 	bool driver_present;
 
+	/* temporary data for search algorithm etc. */
+	struct ieee80211_chan_req req;
+
 	struct ieee80211_chanctx_conf conf;
 };
 
@@ -1035,7 +1038,7 @@ struct ieee80211_link_data {
 
 	bool operating_11g_mode;
 
-	struct cfg80211_chan_def csa_chandef;
+	struct ieee80211_chan_req csa_chanreq;
 
 	struct wiphy_work color_change_finalize_work;
 	struct delayed_work color_collision_detect_work;
@@ -1043,7 +1046,7 @@ struct ieee80211_link_data {
 
 	/* context reservation -- protected with wiphy mutex */
 	struct ieee80211_chanctx *reserved_chanctx;
-	struct cfg80211_chan_def reserved_chandef;
+	struct ieee80211_chan_req reserved;
 	bool reserved_radar_required;
 	bool reserved_ready;
 
@@ -1574,7 +1577,7 @@ struct ieee80211_local {
 
 	/* virtual monitor interface */
 	struct ieee80211_sub_if_data __rcu *monitor_sdata;
-	struct cfg80211_chan_def monitor_chandef;
+	struct ieee80211_chan_req monitor_chanreq;
 
 	/* extended capabilities provided by mac80211 */
 	u8 ext_capa[8];
@@ -1639,7 +1642,7 @@ ieee80211_get_link_sband(struct ieee80211_link_data *link)
 
 /* this struct holds the value parsing from channel switch IE  */
 struct ieee80211_csa_ie {
-	struct cfg80211_chan_def chandef;
+	struct ieee80211_chan_req chanreq;
 	u8 mode;
 	u8 count;
 	u8 ttl;
@@ -2523,11 +2526,11 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *chandef,
 
 int __must_check
 ieee80211_link_use_channel(struct ieee80211_link_data *link,
-			   const struct cfg80211_chan_def *chandef,
+			   const struct ieee80211_chan_req *req,
 			   enum ieee80211_chanctx_mode mode);
 int __must_check
 ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
-			       const struct cfg80211_chan_def *chandef,
+			       const struct ieee80211_chan_req *req,
 			       enum ieee80211_chanctx_mode mode,
 			       bool radar_required);
 int __must_check
@@ -2535,9 +2538,9 @@ ieee80211_link_use_reserved_context(struct ieee80211_link_data *link);
 int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link);
 
 int __must_check
-ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
-				const struct cfg80211_chan_def *chandef,
-				u64 *changed);
+ieee80211_link_change_chanreq(struct ieee80211_link_data *link,
+			      const struct ieee80211_chan_req *req,
+			      u64 *changed);
 void ieee80211_link_release_channel(struct ieee80211_link_data *link);
 void ieee80211_link_vlan_copy_chanctx(struct ieee80211_link_data *link);
 void ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index a7504fc5fa20..92e69074a3a9 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -557,7 +557,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 				  &sdata->deflink.dfs_cac_timer_work);
 
 	if (sdata->wdev.cac_started) {
-		chandef = sdata->vif.bss_conf.chandef;
+		chandef = sdata->vif.bss_conf.chanreq.oper;
 		WARN_ON(local->suspended);
 		ieee80211_link_release_channel(&sdata->deflink);
 		cfg80211_cac_event(sdata->dev, &chandef,
@@ -1164,7 +1164,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	rcu_assign_pointer(local->monitor_sdata, sdata);
 	mutex_unlock(&local->iflist_mtx);
 
-	ret = ieee80211_link_use_channel(&sdata->deflink, &local->monitor_chandef,
+	ret = ieee80211_link_use_channel(&sdata->deflink, &local->monitor_chanreq,
 					 IEEE80211_CHANCTX_EXCLUSIVE);
 	if (ret) {
 		mutex_lock(&local->iflist_mtx);
@@ -1252,7 +1252,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		sdata->vif.cab_queue = master->vif.cab_queue;
 		memcpy(sdata->vif.hw_queue, master->vif.hw_queue,
 		       sizeof(sdata->vif.hw_queue));
-		sdata->vif.bss_conf.chandef = master->vif.bss_conf.chandef;
+		sdata->vif.bss_conf.chanreq = master->vif.bss_conf.chanreq;
 
 		sdata->crypto_tx_tailroom_needed_cnt +=
 			master->crypto_tx_tailroom_needed_cnt;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index d4f86955afa6..070f536acd76 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -402,7 +402,8 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 
 		link = sdata_dereference(sdata->link[link_id], sdata);
 
-		ret = ieee80211_link_use_channel(link, &link->conf->chandef,
+		ret = ieee80211_link_use_channel(link,
+						 &link->conf->chanreq,
 						 IEEE80211_CHANCTX_SHARED);
 		WARN_ON_ONCE(ret);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index ce0cba8d7afc..879abe216a3e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1229,7 +1229,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 						&sband->channels[i],
 						NL80211_CHAN_NO_HT);
 			/* init channel we're on */
-			local->monitor_chandef = dflt_chandef;
+			local->monitor_chanreq.oper = dflt_chandef;
 			if (local->emulate_chanctx) {
 				local->dflt_chandef = dflt_chandef;
 				local->hw.conf.chandef = dflt_chandef;
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 60dc453acb5a..e06d9ed2d31b 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -97,7 +97,7 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 	if (sdata->vif.bss_conf.basic_rates != basic_rates)
 		return false;
 
-	cfg80211_chandef_create(&sta_chan_def, sdata->vif.bss_conf.chandef.chan,
+	cfg80211_chandef_create(&sta_chan_def, sdata->vif.bss_conf.chanreq.oper.chan,
 				NL80211_CHAN_NO_HT);
 	ieee80211_chandef_ht_oper(ie->ht_operation, &sta_chan_def);
 
@@ -111,7 +111,7 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 				       ie->eht_operation,
 				       &sta_chan_def);
 
-	if (!cfg80211_chandef_compatible(&sdata->vif.bss_conf.chandef,
+	if (!cfg80211_chandef_compatible(&sdata->vif.bss_conf.chanreq.oper,
 					 &sta_chan_def))
 		return false;
 
@@ -436,9 +436,9 @@ int mesh_add_ht_cap_ie(struct ieee80211_sub_if_data *sdata,
 		return 0;
 
 	if (!sband->ht_cap.ht_supported ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
 	if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_ht_cap))
@@ -477,16 +477,16 @@ int mesh_add_ht_oper_ie(struct ieee80211_sub_if_data *sdata,
 		return 0;
 
 	if (!ht_cap->ht_supported ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
 	if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_ht_operation))
 		return -ENOMEM;
 
 	pos = skb_put(skb, 2 + sizeof(struct ieee80211_ht_operation));
-	ieee80211_ie_build_ht_oper(pos, ht_cap, &sdata->vif.bss_conf.chandef,
+	ieee80211_ie_build_ht_oper(pos, ht_cap, &sdata->vif.bss_conf.chanreq.oper,
 				   sdata->vif.bss_conf.ht_operation_mode,
 				   false);
 
@@ -508,9 +508,9 @@ int mesh_add_vht_cap_ie(struct ieee80211_sub_if_data *sdata,
 		return 0;
 
 	if (!sband->vht_cap.vht_supported ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
 	if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_vht_cap))
@@ -549,9 +549,9 @@ int mesh_add_vht_oper_ie(struct ieee80211_sub_if_data *sdata,
 		return 0;
 
 	if (!vht_cap->vht_supported ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
 	if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_vht_operation))
@@ -559,7 +559,7 @@ int mesh_add_vht_oper_ie(struct ieee80211_sub_if_data *sdata,
 
 	pos = skb_put(skb, 2 + sizeof(struct ieee80211_vht_operation));
 	ieee80211_ie_build_vht_oper(pos, vht_cap,
-				    &sdata->vif.bss_conf.chandef);
+				    &sdata->vif.bss_conf.chanreq.oper);
 
 	return 0;
 }
@@ -578,9 +578,9 @@ int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
 	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
 
 	if (!he_cap ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
 	if (skb_tailroom(skb) < ie_len)
@@ -606,20 +606,20 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 
 	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
 	if (!he_cap ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
 	len = 2 + 1 + sizeof(struct ieee80211_he_operation);
-	if (sdata->vif.bss_conf.chandef.chan->band == NL80211_BAND_6GHZ)
+	if (sdata->vif.bss_conf.chanreq.oper.chan->band == NL80211_BAND_6GHZ)
 		len += sizeof(struct ieee80211_he_6ghz_oper);
 
 	if (skb_tailroom(skb) < len)
 		return -ENOMEM;
 
 	pos = skb_put(skb, len);
-	ieee80211_ie_build_he_oper(pos, &sdata->vif.bss_conf.chandef);
+	ieee80211_ie_build_he_oper(pos, &sdata->vif.bss_conf.chanreq.oper);
 
 	return 0;
 }
@@ -659,9 +659,9 @@ int mesh_add_eht_cap_ie(struct ieee80211_sub_if_data *sdata,
 	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
 	eht_cap = ieee80211_get_eht_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
 	if (!he_cap || !eht_cap ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
 	if (skb_tailroom(skb) < ie_len)
@@ -686,9 +686,9 @@ int mesh_add_eht_oper_ie(struct ieee80211_sub_if_data *sdata, struct sk_buff *sk
 
 	eht_cap = ieee80211_get_eht_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
 	if (!eht_cap ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
 	len = 2 + 1 + offsetof(struct ieee80211_eht_operation, optional) +
@@ -698,7 +698,7 @@ int mesh_add_eht_oper_ie(struct ieee80211_sub_if_data *sdata, struct sk_buff *sk
 		return -ENOMEM;
 
 	pos = skb_put(skb, len);
-	ieee80211_ie_build_eht_oper(pos, &sdata->vif.bss_conf.chandef, eht_cap);
+	ieee80211_ie_build_eht_oper(pos, &sdata->vif.bss_conf.chanreq.oper, eht_cap);
 
 	return 0;
 }
@@ -746,9 +746,9 @@ ieee80211_mesh_update_bss_params(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	if (!ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT) ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return;
 
 	sdata->vif.bss_conf.he_support = true;
@@ -1277,11 +1277,12 @@ static void ieee80211_mesh_csa_mark_radar(struct ieee80211_sub_if_data *sdata)
 	 * unavailable.
 	 */
 	err = cfg80211_chandef_dfs_required(sdata->local->hw.wiphy,
-					    &sdata->vif.bss_conf.chandef,
+					    &sdata->vif.bss_conf.chanreq.oper,
 					    NL80211_IFTYPE_MESH_POINT);
 	if (err > 0)
 		cfg80211_radar_event(sdata->local->hw.wiphy,
-				     &sdata->vif.bss_conf.chandef, GFP_ATOMIC);
+				     &sdata->vif.bss_conf.chanreq.oper,
+				     GFP_ATOMIC);
 }
 
 static bool
@@ -1302,7 +1303,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	if (!sband)
 		return false;
 
-	switch (sdata->vif.bss_conf.chandef.width) {
+	switch (sdata->vif.bss_conf.chanreq.oper.width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
 		conn.mode = IEEE80211_CONN_MODE_LEGACY;
 		conn.bw_limit = IEEE80211_CONN_BW_LIMIT_20;
@@ -1339,7 +1340,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	if (csa_ie.reason_code == WLAN_REASON_MESH_CHAN_REGULATORY)
 		ieee80211_mesh_csa_mark_radar(sdata);
 
-	params.chandef = csa_ie.chandef;
+	params.chandef = csa_ie.chanreq.oper;
 	params.count = csa_ie.count;
 
 	if (!cfg80211_chandef_usable(sdata->local->hw.wiphy, &params.chandef,
@@ -1375,7 +1376,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	params.radar_required = err;
 
 	if (cfg80211_chandef_identical(&params.chandef,
-				       &sdata->vif.bss_conf.chandef)) {
+				       &sdata->vif.bss_conf.chanreq.oper)) {
 		mcsa_dbg(sdata,
 			 "received csa with an identical chandef, ignoring\n");
 		return true;
@@ -1555,7 +1556,7 @@ int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata, u64 *changed)
 	*changed |= BSS_CHANGED_BEACON;
 
 	mcsa_dbg(sdata, "complete switching to center freq %d MHz",
-		 sdata->vif.bss_conf.chandef.chan->center_freq);
+		 sdata->vif.bss_conf.chanreq.oper.chan->center_freq);
 	return 0;
 }
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 28bf794f67f8..e3aad60f68ab 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -163,7 +163,7 @@ static u64 mesh_set_ht_prot_mode(struct ieee80211_sub_if_data *sdata)
 	u16 ht_opmode;
 	bool non_ht_sta = false, ht20_sta = false;
 
-	switch (sdata->vif.bss_conf.chandef.width) {
+	switch (sdata->vif.bss_conf.chanreq.oper.width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_5:
 	case NL80211_CHAN_WIDTH_10:
@@ -196,7 +196,7 @@ static u64 mesh_set_ht_prot_mode(struct ieee80211_sub_if_data *sdata)
 	if (non_ht_sta)
 		ht_opmode = IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED;
 	else if (ht20_sta &&
-		 sdata->vif.bss_conf.chandef.width > NL80211_CHAN_WIDTH_20)
+		 sdata->vif.bss_conf.chanreq.oper.width > NL80211_CHAN_WIDTH_20)
 		ht_opmode = IEEE80211_HT_OP_MODE_PROTECTION_20MHZ;
 	else
 		ht_opmode = IEEE80211_HT_OP_MODE_PROTECTION_NONE;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e68195c7eaed..def6f1caa58c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -139,7 +139,7 @@ ieee80211_handle_puncturing_bitmap(struct ieee80211_link_data *link,
 				   const struct ieee80211_eht_operation *eht_oper,
 				   u16 bitmap, u64 *changed)
 {
-	struct cfg80211_chan_def *chandef = &link->conf->chandef;
+	struct cfg80211_chan_def *chandef = &link->conf->chanreq.oper;
 	struct ieee80211_local *local = link->sdata->local;
 	u16 extracted;
 	u64 _changed = 0;
@@ -862,8 +862,9 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			       struct ieee802_11_elems *elems,
 			       u64 *changed)
 {
-	struct ieee80211_channel *channel = link->conf->chandef.chan;
+	struct ieee80211_channel *channel = link->conf->chanreq.oper.chan;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_chan_req chanreq = {};
 	struct cfg80211_chan_def ap_chandef;
 	enum ieee80211_conn_mode ap_mode;
 	u32 vht_cap_info = 0;
@@ -913,7 +914,7 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			ieee80211_min_bw_limit_from_chandef(&ap_chandef))
 		ieee80211_chandef_downgrade(&ap_chandef, NULL);
 
-	if (cfg80211_chandef_identical(&ap_chandef, &link->conf->chandef))
+	if (cfg80211_chandef_identical(&ap_chandef, &link->conf->chanreq.oper))
 		return 0;
 
 	link_info(link,
@@ -946,8 +947,9 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	 * bandwidth changes where a this could happen, but those cases are
 	 * less common and wouldn't completely prevent using the AP.
 	 */
+	chanreq.oper = ap_chandef;
 
-	ret = ieee80211_link_change_bandwidth(link, &ap_chandef, changed);
+	ret = ieee80211_link_change_chanreq(link, &chanreq, changed);
 	if (ret) {
 		sdata_info(sdata,
 			   "AP %pM changed bandwidth to incompatible one - disconnect\n",
@@ -2069,8 +2071,8 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 		return;
 	}
 
-	if (!cfg80211_chandef_identical(&link->conf->chandef,
-					&link->csa_chandef)) {
+	if (!cfg80211_chandef_identical(&link->conf->chanreq.oper,
+					&link->csa_chanreq.oper)) {
 		sdata_info(sdata,
 			   "failed to finalize channel switch, disconnecting\n");
 		wiphy_work_queue(sdata->local->hw.wiphy,
@@ -2118,7 +2120,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 		return;
 	}
 
-	cfg80211_ch_switch_notify(sdata->dev, &link->reserved_chandef,
+	cfg80211_ch_switch_notify(sdata->dev, &link->reserved.oper,
 				  link->link_id, 0);
 }
 
@@ -2211,7 +2213,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		ch_switch.timestamp = timestamp;
 		ch_switch.device_timestamp = device_timestamp;
 		ch_switch.block_tx = csa_ie.mode;
-		ch_switch.chandef = csa_ie.chandef;
+		ch_switch.chandef = csa_ie.chanreq.oper;
 		ch_switch.count = csa_ie.count;
 		ch_switch.delay = csa_ie.max_switch_time;
 	}
@@ -2231,34 +2233,36 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		return;
 	}
 
-	if (link->conf->chandef.chan->band !=
-	    csa_ie.chandef.chan->band) {
+	if (link->conf->chanreq.oper.chan->band !=
+	    csa_ie.chanreq.oper.chan->band) {
 		sdata_info(sdata,
 			   "AP %pM switches to different band (%d MHz, width:%d, CF1/2: %d/%d MHz), disconnecting\n",
 			   link->u.mgd.bssid,
-			   csa_ie.chandef.chan->center_freq,
-			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
-			   csa_ie.chandef.center_freq2);
+			   csa_ie.chanreq.oper.chan->center_freq,
+			   csa_ie.chanreq.oper.width,
+			   csa_ie.chanreq.oper.center_freq1,
+			   csa_ie.chanreq.oper.center_freq2);
 		goto drop_connection;
 	}
 
-	if (!cfg80211_chandef_usable(local->hw.wiphy, &csa_ie.chandef,
+	if (!cfg80211_chandef_usable(local->hw.wiphy, &csa_ie.chanreq.oper,
 				     IEEE80211_CHAN_DISABLED)) {
 		sdata_info(sdata,
 			   "AP %pM switches to unsupported channel "
 			   "(%d.%03d MHz, width:%d, CF1/2: %d.%03d/%d MHz), "
 			   "disconnecting\n",
 			   link->u.mgd.bssid,
-			   csa_ie.chandef.chan->center_freq,
-			   csa_ie.chandef.chan->freq_offset,
-			   csa_ie.chandef.width, csa_ie.chandef.center_freq1,
-			   csa_ie.chandef.freq1_offset,
-			   csa_ie.chandef.center_freq2);
+			   csa_ie.chanreq.oper.chan->center_freq,
+			   csa_ie.chanreq.oper.chan->freq_offset,
+			   csa_ie.chanreq.oper.width,
+			   csa_ie.chanreq.oper.center_freq1,
+			   csa_ie.chanreq.oper.freq1_offset,
+			   csa_ie.chanreq.oper.center_freq2);
 		goto drop_connection;
 	}
 
-	if (cfg80211_chandef_identical(&csa_ie.chandef,
-				       &link->conf->chandef) &&
+	if (cfg80211_chandef_identical(&csa_ie.chanreq.oper,
+				       &link->conf->chanreq.oper) &&
 	    (!csa_ie.mode || !beacon)) {
 		if (link->u.mgd.csa_ignored_same_chan)
 			return;
@@ -2299,7 +2303,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		goto drop_connection;
 	}
 
-	res = ieee80211_link_reserve_chanctx(link, &csa_ie.chandef,
+	res = ieee80211_link_reserve_chanctx(link, &csa_ie.chanreq,
 					     chanctx->mode, false);
 	if (res) {
 		sdata_info(sdata,
@@ -2309,7 +2313,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	}
 
 	link->conf->csa_active = true;
-	link->csa_chandef = csa_ie.chandef;
+	link->csa_chanreq = csa_ie.chanreq;
 	link->csa_block_tx = csa_ie.mode;
 	link->u.mgd.csa_ignored_same_chan = false;
 	link->u.mgd.beacon_crc_valid = false;
@@ -2318,7 +2322,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
-	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chandef,
+	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chanreq.oper,
 					  link->link_id, csa_ie.count,
 					  csa_ie.mode, 0);
 
@@ -2741,7 +2745,7 @@ void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct ieee80211_link_data *link =
 		container_of(work, struct ieee80211_link_data,
 			     dfs_cac_timer_work.work);
-	struct cfg80211_chan_def chandef = link->conf->chandef;
+	struct cfg80211_chan_def chandef = link->conf->chanreq.oper;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
@@ -4507,11 +4511,11 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		goto out;
 	}
 
-	if (WARN_ON(!link->conf->chandef.chan)) {
+	if (WARN_ON(!link->conf->chanreq.oper.chan)) {
 		ret = false;
 		goto out;
 	}
-	sband = local->hw.wiphy->bands[link->conf->chandef.chan->band];
+	sband = local->hw.wiphy->bands[link->conf->chanreq.oper.chan->band];
 
 	/* Set up internal HT/VHT capabilities */
 	if (elems->ht_cap_elem && link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT)
@@ -4579,7 +4583,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		} else if (is_6ghz) {
 			link_info(link,
 				  "HE 6 GHz operation missing (on %d MHz), expect issues\n",
-				  bss_conf->chandef.chan->center_freq);
+				  bss_conf->chanreq.oper.chan->center_freq);
 		}
 
 		bss_conf->he_support = link_sta->pub->he_cap.has_he;
@@ -5131,8 +5135,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_conn_settings *conn)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct cfg80211_chan_def chandef;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
+	struct ieee80211_chan_req chanreq = {};
 	struct ieee802_11_elems *elems;
 	int ret;
 	u32 i;
@@ -5141,7 +5145,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	rcu_read_lock();
 	elems = ieee80211_determine_chan_mode(sdata, conn, cbss, link_id,
-					      &chandef);
+					      &chanreq.oper);
 
 	if (IS_ERR(elems)) {
 		rcu_read_unlock();
@@ -5198,17 +5202,18 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	 * on incompatible channels, e.g. 80+80 and 160 sharing the
 	 * same control channel) try to use a smaller bandwidth.
 	 */
-	ret = ieee80211_link_use_channel(link, &chandef,
+	ret = ieee80211_link_use_channel(link, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 
 	/* don't downgrade for 5 and 10 MHz channels, though. */
-	if (chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    chandef.width == NL80211_CHAN_WIDTH_10)
+	if (chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
+	    chanreq.oper.width == NL80211_CHAN_WIDTH_10)
 		return ret;
 
-	while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
-		ieee80211_chandef_downgrade(&chandef, conn);
-		ret = ieee80211_link_use_channel(link, &chandef,
+	while (ret && chanreq.oper.width != NL80211_CHAN_WIDTH_20_NOHT) {
+		ieee80211_chandef_downgrade(&chanreq.oper, conn);
+
+		ret = ieee80211_link_use_channel(link, &chanreq,
 						 IEEE80211_CHANCTX_SHARED);
 	}
 
@@ -5864,7 +5869,7 @@ static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
 	}
 
 	extracted = ieee80211_extract_dis_subch_bmap(eht_oper,
-						     &link->conf->chandef,
+						     &link->conf->chanreq.oper,
 						     bitmap);
 
 	/* accept if there are no changes */
@@ -5873,12 +5878,12 @@ static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
 		return true;
 
 	if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
-						      &link->conf->chandef)) {
+						      &link->conf->chanreq.oper)) {
 		link_info(link,
 			  "Got an invalid disable subchannel bitmap from AP %pM: bitmap = 0x%x, bw = 0x%x. disconnect\n",
 			  link->u.mgd.bssid,
 			  bitmap,
-			  link->conf->chandef.width);
+			  link->conf->chanreq.oper.width);
 		return false;
 	}
 
@@ -6575,10 +6580,10 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		goto free;
 	}
 
-	if (WARN_ON(!link->conf->chandef.chan))
+	if (WARN_ON(!link->conf->chanreq.oper.chan))
 		goto free;
 
-	sband = local->hw.wiphy->bands[link->conf->chandef.chan->band];
+	sband = local->hw.wiphy->bands[link->conf->chanreq.oper.chan->band];
 
 	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 449af4e1cca4..2dd4a2196af4 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -168,6 +168,7 @@ void ieee80211_ocb_setup_sdata(struct ieee80211_sub_if_data *sdata)
 int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 		       struct ocb_setup *setup)
 {
+	struct ieee80211_chan_req chanreq = { .oper = setup->chandef };
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_ocb *ifocb = &sdata->u.ocb;
 	u64 changed = BSS_CHANGED_OCB | BSS_CHANGED_BSSID;
@@ -182,7 +183,7 @@ int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 	sdata->deflink.needed_rx_chains = sdata->local->rx_chains;
 
-	err = ieee80211_link_use_channel(&sdata->deflink, &setup->chandef,
+	err = ieee80211_link_use_channel(&sdata->deflink, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 	if (err)
 		return err;
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index d5ea5f5bcf3a..34e03b9522c8 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -4,7 +4,7 @@
  * Copyright 2005-2006, Devicescape Software, Inc.
  * Copyright (c) 2006 Jiri Benc <jbenc@suse.cz>
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2019, 2022-2024 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -278,10 +278,10 @@ void ieee80211_check_rate_mask(struct ieee80211_link_data *link)
 	u32 user_mask, basic_rates = link->conf->basic_rates;
 	enum nl80211_band band;
 
-	if (WARN_ON(!link->conf->chandef.chan))
+	if (WARN_ON(!link->conf->chanreq.oper.chan))
 		return;
 
-	band = link->conf->chandef.chan->band;
+	band = link->conf->chanreq.oper.chan->band;
 	if (band == NL80211_BAND_S1GHZ) {
 		/* TODO */
 		return;
@@ -761,7 +761,7 @@ static bool rate_control_cap_mask(struct ieee80211_sub_if_data *sdata,
 	u32 i, flags;
 
 	*mask = sdata->rc_rateidx_mask[sband->band];
-	flags = ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chandef);
+	flags = ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
 	for (i = 0; i < sband->n_bitrates; i++) {
 		if ((flags & sband->bitrates[i].flags) != flags)
 			*mask &= ~BIT(i);
@@ -817,7 +817,7 @@ rate_control_apply_mask_ratetbl(struct sta_info *sta,
 				   mcs_mask, vht_mask))
 		return;
 
-	chan_width = sta->sdata->vif.bss_conf.chandef.width;
+	chan_width = sta->sdata->vif.bss_conf.chanreq.oper.width;
 	for (i = 0; i < IEEE80211_TX_RATE_TABLE_SIZE; i++) {
 		if (rates->rate[i].idx < 0)
 			break;
@@ -854,7 +854,7 @@ static void rate_control_apply_mask(struct ieee80211_sub_if_data *sdata,
 	 * included in the configured mask and change the rate indexes
 	 * if needed.
 	 */
-	chan_width = sdata->vif.bss_conf.chandef.width;
+	chan_width = sdata->vif.bss_conf.chanreq.oper.width;
 	for (i = 0; i < max_rates; i++) {
 		/* Skip invalid rates */
 		if (rates[i].idx < 0)
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index 51efc9bc8168..2b0bf2a1a877 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -108,26 +108,26 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	default:
 		/* secondary_channel_offset was present but is invalid */
 	case IEEE80211_HT_PARAM_CHA_SEC_NONE:
-		cfg80211_chandef_create(&csa_ie->chandef, new_chan,
+		cfg80211_chandef_create(&csa_ie->chanreq.oper, new_chan,
 					NL80211_CHAN_HT20);
 		break;
 	case IEEE80211_HT_PARAM_CHA_SEC_ABOVE:
-		cfg80211_chandef_create(&csa_ie->chandef, new_chan,
+		cfg80211_chandef_create(&csa_ie->chanreq.oper, new_chan,
 					NL80211_CHAN_HT40PLUS);
 		break;
 	case IEEE80211_HT_PARAM_CHA_SEC_BELOW:
-		cfg80211_chandef_create(&csa_ie->chandef, new_chan,
+		cfg80211_chandef_create(&csa_ie->chanreq.oper, new_chan,
 					NL80211_CHAN_HT40MINUS);
 		break;
 	case -1:
-		cfg80211_chandef_create(&csa_ie->chandef, new_chan,
+		cfg80211_chandef_create(&csa_ie->chanreq.oper, new_chan,
 					NL80211_CHAN_NO_HT);
 		/* keep width for 5/10 MHz channels */
-		switch (sdata->vif.bss_conf.chandef.width) {
+		switch (sdata->vif.bss_conf.chanreq.oper.width) {
 		case NL80211_CHAN_WIDTH_5:
 		case NL80211_CHAN_WIDTH_10:
-			csa_ie->chandef.width =
-				sdata->vif.bss_conf.chandef.width;
+			csa_ie->chanreq.oper.width =
+				sdata->vif.bss_conf.chanreq.oper.width;
 			break;
 		default:
 			break;
@@ -137,7 +137,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 
 	if (bwi) {
 		/* start with the CSA one */
-		new_vht_chandef = csa_ie->chandef;
+		new_vht_chandef = csa_ie->chanreq.oper;
 		/* and update the width accordingly */
 		ieee80211_chandef_eht_oper(&bwi->info, &new_vht_chandef);
 	} else if (wide_bw_chansw_ie) {
@@ -159,7 +159,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 		/* default, for the case of IEEE80211_VHT_CHANWIDTH_USE_HT,
 		 * to the previously parsed chandef
 		 */
-		new_vht_chandef = csa_ie->chandef;
+		new_vht_chandef = csa_ie->chanreq.oper;
 
 		/* ignore if parsing fails */
 		if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
@@ -177,13 +177,13 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	/* if VHT data is there validate & use it */
 	if (new_vht_chandef.chan) {
 		if (!cfg80211_chandef_compatible(&new_vht_chandef,
-						 &csa_ie->chandef)) {
+						 &csa_ie->chanreq.oper)) {
 			sdata_info(sdata,
 				   "BSS %pM: CSA has inconsistent channel data, disconnecting\n",
 				   bssid);
 			return -EINVAL;
 		}
-		csa_ie->chandef = new_vht_chandef;
+		csa_ie->chanreq.oper = new_vht_chandef;
 	}
 
 	if (elems->max_channel_switch_time)
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 396fd54d8bf7..0f4aa42e070f 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -159,7 +159,7 @@ static void ieee80211_tdls_add_oper_classes(struct ieee80211_link_data *link,
 	u8 *pos;
 	u8 op_class;
 
-	if (!ieee80211_chandef_to_operating_class(&link->conf->chandef,
+	if (!ieee80211_chandef_to_operating_class(&link->conf->chanreq.oper,
 						  &op_class))
 		return;
 
@@ -438,7 +438,7 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 		if (WARN_ON_ONCE(!sta))
 			return;
 
-		sta->tdls_chandef = link->conf->chandef;
+		sta->tdls_chandef = link->conf->chanreq.oper;
 	}
 
 	ieee80211_tdls_add_oper_classes(link, skb);
@@ -638,7 +638,7 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_link_data *link,
 	if (WARN_ON_ONCE(!sta || !ap_sta))
 		return;
 
-	sta->tdls_chandef = link->conf->chandef;
+	sta->tdls_chandef = link->conf->chanreq.oper;
 
 	/* add any custom IEs that go before the QoS IE */
 	if (extra_ies_len) {
@@ -684,7 +684,7 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_link_data *link,
 
 		pos = skb_put(skb, 2 + sizeof(struct ieee80211_ht_operation));
 		ieee80211_ie_build_ht_oper(pos, &sta->sta.deflink.ht_cap,
-					   &link->conf->chandef, prot,
+					   &link->conf->chanreq.oper, prot,
 					   true);
 	}
 
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 1c0c46b11c6d..ddf0aebd52a7 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -503,9 +503,9 @@ TRACE_EVENT(drv_link_info_changed,
 		__entry->ht_operation_mode = link_conf->ht_operation_mode;
 		__entry->cqm_rssi_thold = link_conf->cqm_rssi_thold;
 		__entry->cqm_rssi_hyst = link_conf->cqm_rssi_hyst;
-		__entry->channel_width = link_conf->chandef.width;
-		__entry->channel_cfreq1 = link_conf->chandef.center_freq1;
-		__entry->channel_cfreq1_offset = link_conf->chandef.freq1_offset;
+		__entry->channel_width = link_conf->chanreq.oper.width;
+		__entry->channel_cfreq1 = link_conf->chanreq.oper.center_freq1;
+		__entry->channel_cfreq1_offset = link_conf->chanreq.oper.freq1_offset;
 		__entry->qos = link_conf->qos;
 		__entry->hidden_ssid = link_conf->hidden_ssid;
 		__entry->txpower = link_conf->txpower;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 51c1a99f57b8..49eef33b5e70 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2309,7 +2309,7 @@ struct sk_buff *ieee80211_build_probe_req(struct ieee80211_sub_if_data *sdata,
 	 * in order to maximize the chance that we get a response.  Some
 	 * badly-behaved APs don't respond when this parameter is included.
 	 */
-	chandef.width = sdata->vif.bss_conf.chandef.width;
+	chandef.width = sdata->vif.bss_conf.chanreq.oper.width;
 	if (flags & IEEE80211_PROBE_FLAG_DIRECTED)
 		chandef.chan = NULL;
 	else
@@ -2351,7 +2351,8 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON(!sband))
 		return 1;
 
-	rate_flags = ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chandef);
+	rate_flags =
+		ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
 
 	num_rates = sband->n_bitrates;
 	supp_rates = 0;
@@ -4026,7 +4027,8 @@ int ieee80211_add_srates_ie(struct ieee80211_sub_if_data *sdata,
 	u32 basic_rates = sdata->vif.bss_conf.basic_rates;
 	u32 rate_flags;
 
-	rate_flags = ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chandef);
+	rate_flags =
+		ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
 	sband = local->hw.wiphy->bands[band];
 	rates = 0;
 	for (i = 0; i < sband->n_bitrates; i++) {
@@ -4068,8 +4070,8 @@ int ieee80211_add_ext_srates_ie(struct ieee80211_sub_if_data *sdata,
 	u32 basic_rates = sdata->vif.bss_conf.basic_rates;
 	u32 rate_flags;
 
-	rate_flags = ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chandef);
-
+	rate_flags =
+		ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chanreq.oper);
 	sband = local->hw.wiphy->bands[band];
 	exrates = 0;
 	for (i = 0; i < sband->n_bitrates; i++) {
@@ -4312,7 +4314,7 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 					  &sdata->deflink.dfs_cac_timer_work);
 
 		if (sdata->wdev.cac_started) {
-			chandef = sdata->vif.bss_conf.chandef;
+			chandef = sdata->vif.bss_conf.chanreq.oper;
 			ieee80211_link_release_channel(&sdata->deflink);
 			cfg80211_cac_event(sdata->dev,
 					   &chandef,
@@ -4756,7 +4758,7 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 
 	list_for_each_entry(link, &ctx->reserved_links, reserved_chanctx_list)
 		if (link->reserved_radar_required)
-			radar_detect |= BIT(link->reserved_chandef.width);
+			radar_detect |= BIT(link->reserved.oper.width);
 
 	/*
 	 * An in-place reservation context should not have any assigned vifs
@@ -4770,7 +4772,7 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 			continue;
 
 		radar_detect |=
-			BIT(link->conf->chandef.width);
+			BIT(link->conf->chanreq.oper.width);
 	}
 
 	return radar_detect;
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index b3a5c3e96a72..2c475c439ba9 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -369,7 +369,7 @@ ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta)
 		link_conf = rcu_dereference(sdata->vif.link_conf[link_id]);
 
 		if (eht_cap->has_eht &&
-		    link_conf->chandef.chan->band == NL80211_BAND_6GHZ) {
+		    link_conf->chanreq.oper.chan->band == NL80211_BAND_6GHZ) {
 			info = eht_cap->eht_cap_elem.phy_cap_info[0];
 
 			if (info & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ) {
@@ -380,7 +380,7 @@ ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta)
 
 		info = he_cap->he_cap_elem.phy_cap_info[0];
 
-		if (link_conf->chandef.chan->band == NL80211_BAND_2GHZ) {
+		if (link_conf->chanreq.oper.chan->band == NL80211_BAND_2GHZ) {
 			if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
 				ret = IEEE80211_STA_RX_BW_40;
 			else
@@ -515,7 +515,7 @@ ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
 	if (WARN_ON(!link_conf))
 		bss_width = NL80211_CHAN_WIDTH_20_NOHT;
 	else
-		bss_width = link_conf->chandef.width;
+		bss_width = link_conf->chanreq.oper.width;
 	rcu_read_unlock();
 
 	bw = ieee80211_sta_cap_rx_bw(link_sta);
-- 
2.43.0


