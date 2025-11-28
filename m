Return-Path: <linux-wireless+bounces-29417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88775C924DA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DFA334FADD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8F32AAC0;
	Fri, 28 Nov 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D2NwM7YR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C3331224
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339687; cv=none; b=ueVd7pD5UFypvH/9/TdOpPluQg2eGUwNbCNRy3NDsDa049XhvG2rS0NSU3p7aKGWdkyVSkVCOGFWgT7pvK7XsE0fkgzyGFd4Dx+xtVz+oe7/uiT41juwjKDEB4H39GZ3arVWKCEWrBpGZZa/+APIaJ27LwlvFeu8OIKq1MMkE/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339687; c=relaxed/simple;
	bh=1uKsO1LRJpkDgTTtRg1Bt67Q+bVcTx5otvoYvpd0e3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9ojGREY7enGi65SnnNKUCn2DGu0WWnI2mQLyFwq2GY4TFbJ4Pu/sSsBvGPFMAkvN88yO9MPPC8y585xB0aJDCVyZSPIRhHmRtfdoVz21Lq2VoKViMevOseiqgaUbopsEK+HTPPuLXaZW0DontF/YechggzNpnhc5p2JQ5bcgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D2NwM7YR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aodPAlg1O5cvOY964tz1DIiwAy2Adu4YYRCwwWFExZE=;
	t=1764339685; x=1765549285; b=D2NwM7YR3xDX7F5t7NU2DUW1d23ebKh8lmVjliBLzVaQcQ+
	+eLq0e96HP5HKkNV4fzwmObkguIWhtocIcJL780UbBSvYnQo1KLr7cN5yb43YoUBX6odG+qaGqcd9
	Hrt6fdE7uYRYkAn3MkYfMXT5nro6HchyE/G/SzAISdMw0P1+JRN8nov9s8QfoMNOtg5GdQdwnqJlW
	LHGV0AhmHIll5KezDm8HiiDeHSissJj/+vAh/1l/9l1l7m40hHkD21zPvShDAsG6LmuHi14oAX1VV
	uqpy3NIWj8+VjXIz4Ib51Khhkwuew5OJabCfhwOdUh6eoDKOBGMIN89LIKWFPSxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLe-00000003926-0lpl;
	Fri, 28 Nov 2025 15:21:22 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 17/18] wifi: mac80211: export ieee80211_calculate_rx_timestamp
Date: Fri, 28 Nov 2025 15:15:55 +0100
Message-ID: <20251128151537.eb292302a8d9.Ieabfe66768b1bf64c3076d62e73c50794faeacdc@changeid>
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

The function is quite useful when handling beacon timestamps. Export it
so that it can be used by mac80211_hwsim and others.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/net/mac80211.h     | 18 ++++++++++++++++++
 net/mac80211/ibss.c        |  2 +-
 net/mac80211/ieee80211_i.h |  4 ----
 net/mac80211/mesh_sync.c   |  2 +-
 net/mac80211/rx.c          |  2 +-
 net/mac80211/scan.c        |  2 +-
 net/mac80211/util.c        | 18 +++---------------
 7 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 8874e5eeae7d..66f27b0c04a9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7273,6 +7273,24 @@ void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif);
  */
 int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id);
 
+/**
+ * ieee80211_calculate_rx_timestamp - calculate timestamp in frame
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @status: RX status
+ * @mpdu_len: total MPDU length (including FCS)
+ * @mpdu_offset: offset into MPDU to calculate timestamp at
+ *
+ * This function calculates the RX timestamp at the given MPDU offset, taking
+ * into account what the RX timestamp was. An offset of 0 will just normalize
+ * the timestamp to TSF at beginning of MPDU reception.
+ *
+ * Returns: the calculated timestamp
+ */
+u64 ieee80211_calculate_rx_timestamp(struct ieee80211_hw *hw,
+				     struct ieee80211_rx_status *status,
+				     unsigned int mpdu_len,
+				     unsigned int mpdu_offset);
+
 /**
  * ieee80211_report_wowlan_wakeup - report WoWLAN wakeup
  * @vif: virtual interface
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 168f84a1353b..3ce7412b4fcd 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1133,7 +1133,7 @@ static void ieee80211_rx_bss_info(struct ieee80211_sub_if_data *sdata,
 	if (ieee80211_have_rx_timestamp(rx_status)) {
 		/* time when timestamp field was received */
 		rx_timestamp =
-			ieee80211_calculate_rx_timestamp(local, rx_status,
+			ieee80211_calculate_rx_timestamp(&local->hw, rx_status,
 							 len + FCS_LEN, 24);
 	} else {
 		/*
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9d9313eee59f..12d9c10ef773 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1914,10 +1914,6 @@ ieee80211_vif_get_num_mcast_if(struct ieee80211_sub_if_data *sdata)
 	return -1;
 }
 
-u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
-				     struct ieee80211_rx_status *status,
-				     unsigned int mpdu_len,
-				     unsigned int mpdu_offset);
 int ieee80211_hw_config(struct ieee80211_local *local, int radio_idx,
 			u32 changed);
 int ieee80211_hw_conf_chan(struct ieee80211_local *local);
diff --git a/net/mac80211/mesh_sync.c b/net/mac80211/mesh_sync.c
index 3a66b4cefca7..24a68eef7db8 100644
--- a/net/mac80211/mesh_sync.c
+++ b/net/mac80211/mesh_sync.c
@@ -103,7 +103,7 @@ mesh_sync_offset_rx_bcn_presp(struct ieee80211_sub_if_data *sdata, u16 stype,
 	 * section.
 	 */
 	if (ieee80211_have_rx_timestamp(rx_status))
-		t_r = ieee80211_calculate_rx_timestamp(local, rx_status,
+		t_r = ieee80211_calculate_rx_timestamp(&local->hw, rx_status,
 						       len + FCS_LEN, 24);
 	else
 		t_r = drv_get_tsf(local, sdata);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6a1899512d07..b82657f79a6e 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -404,7 +404,7 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 		while ((pos - (u8 *)rthdr) & 7)
 			*pos++ = 0;
 		put_unaligned_le64(
-			ieee80211_calculate_rx_timestamp(local, status,
+			ieee80211_calculate_rx_timestamp(&local->hw, status,
 							 mpdulen, 0),
 			pos);
 		rthdr->it_present |= cpu_to_le32(BIT(IEEE80211_RADIOTAP_TSFT));
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 5ef315ed3b0f..a536f535e315 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -216,7 +216,7 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 
 		if (link_conf) {
 			bss_meta.parent_tsf =
-				ieee80211_calculate_rx_timestamp(local,
+				ieee80211_calculate_rx_timestamp(&local->hw,
 								 rx_status,
 								 len + FCS_LEN,
 								 24);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ef7ea78da736..b333ebd73d86 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3370,20 +3370,7 @@ u8 ieee80211_mcs_to_chains(const struct ieee80211_mcs_info *mcs)
 	return 1;
 }
 
-/**
- * ieee80211_calculate_rx_timestamp - calculate timestamp in frame
- * @local: mac80211 hw info struct
- * @status: RX status
- * @mpdu_len: total MPDU length (including FCS)
- * @mpdu_offset: offset into MPDU to calculate timestamp at
- *
- * This function calculates the RX timestamp at the given MPDU offset, taking
- * into account what the RX timestamp was. An offset of 0 will just normalize
- * the timestamp to TSF at beginning of MPDU reception.
- *
- * Returns: the calculated timestamp
- */
-u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
+u64 ieee80211_calculate_rx_timestamp(struct ieee80211_hw *hw,
 				     struct ieee80211_rx_status *status,
 				     unsigned int mpdu_len,
 				     unsigned int mpdu_offset)
@@ -3502,7 +3489,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 	case RX_ENC_LEGACY: {
 		struct ieee80211_supported_band *sband;
 
-		sband = local->hw.wiphy->bands[status->band];
+		sband = hw->wiphy->bands[status->band];
 		ri.legacy = sband->bitrates[status->rate_idx].bitrate;
 
 		if (mactime_plcp_start) {
@@ -3534,6 +3521,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 
 	return ts;
 }
+EXPORT_SYMBOL_GPL(ieee80211_calculate_rx_timestamp);
 
 /* Cancel CAC for the interfaces under the specified @local. If @ctx is
  * also provided, only the interfaces using that ctx will be canceled.
-- 
2.51.1


