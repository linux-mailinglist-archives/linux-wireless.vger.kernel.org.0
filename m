Return-Path: <linux-wireless+bounces-30480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CECCFF9C4
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 20:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2772833FD2A4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCED33DEFA;
	Wed,  7 Jan 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uMNoY/Y4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D2233D6E3
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795833; cv=none; b=XLF/e/MamYweEGHV1wc+VgqlLvyek7oSZg4WlrG1sSSGK2GJP/v0t9dQtqEBSF4rUVH5BJP56yt/SyXgUiN7/uApkTPpq/qRaZzcYBha5jKj3lBJbprjq+N20fUf6SL2R3V6WPFyxXoJuRaEn3TTMMBYajU+vHXZTF4XzSpmRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795833; c=relaxed/simple;
	bh=9K4ZEqEjCZtRdkEdDz+21wO9/E5D/ayYePIHJUqU75A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8adnts0+QeuOQ1VOp+Wa77Qhzs2gVo2z//h00wDQHNGuXS7XfsLjdlAxPl+QkFY3UQVlaPgo+1qnwbqTf/3LwcqmeX1EW0t/tr78mevL3BKVFmJUVq1gXgAcO9zPjqNwR4OaWicI3cAl13yarn+TO+lMViCuiIIv5V/PdkxB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uMNoY/Y4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AAauqeTTG2vIUAbuf5wdJSpa8N4L778rLQKLLzzb5r8=;
	t=1767795832; x=1769005432; b=uMNoY/Y48eOLboWvqFJehlOHVQZDh/G3T48X6I5OZ6621jL
	GNNnAD7ps4OCpeG+cfIQZvBRk3k5brQP5yRUEvs4ytJzBF554Pa5dvuAxCYQeRpuiapoyt9ZJnlx6
	4WFxNmzaTB532RVEyYJzyltTa80r09aT/ZbLZxmNZ62JYI+aNOKIFxMolkBEFoiREC3zRULu0qYwJ
	hHMWbn6QEVLLIpA4TS1Cslr+utFZ7kjsltrg9LABaAX7amjOZ3Cu8Vw46PRTJvlQ517mSav6LthCT
	RxEfd+nVSDoW/Evk1EN33N5KBzdFflA71//lLJIeuAMbjp/4ELWUz+7+yvK41g3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURx-00000005agF-1kAS;
	Wed, 07 Jan 2026 15:23:49 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 18/46] wifi: mac80211: export ieee80211_calculate_rx_timestamp
Date: Wed,  7 Jan 2026 15:22:17 +0100
Message-ID: <20260107152325.62b6e9a85c43.Ieabfe66768b1bf64c3076d62e73c50794faeacdc@changeid>
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

The function is quite useful when handling beacon timestamps. Export it
so that it can be used by mac80211_hwsim and others.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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
index 649ea9d2ae9b..7083718e52d5 100644
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
index 84888927496b..b38f860936c2 100644
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
index 278af3b76268..c93ffccb27e8 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3366,20 +3366,7 @@ u8 ieee80211_mcs_to_chains(const struct ieee80211_mcs_info *mcs)
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
@@ -3498,7 +3485,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 	case RX_ENC_LEGACY: {
 		struct ieee80211_supported_band *sband;
 
-		sband = local->hw.wiphy->bands[status->band];
+		sband = hw->wiphy->bands[status->band];
 		ri.legacy = sband->bitrates[status->rate_idx].bitrate;
 
 		if (mactime_plcp_start) {
@@ -3530,6 +3517,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 
 	return ts;
 }
+EXPORT_SYMBOL_GPL(ieee80211_calculate_rx_timestamp);
 
 /* Cancel CAC for the interfaces under the specified @local. If @ctx is
  * also provided, only the interfaces using that ctx will be canceled.
-- 
2.52.0


