Return-Path: <linux-wireless+bounces-1007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96855818E66
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD92842C2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ACF37D03;
	Tue, 19 Dec 2023 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vx54rUVT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5700D37D0B
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703007687; x=1734543687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+CW9q4FSSviunFXUF1WJZFnh5cnbk9XOSoeNIAJoCEk=;
  b=Vx54rUVTY8F73dF1L2SdeREGyX31IBbykmlPdLChpNsvaqxSlsBlsUhc
   qMIAtO2EYbTzPor/0VITP3RNebn7o9Pv2g43oUeIMEGCnsd5WJSKXKXA4
   6Jyfc/Ns3D9YjUewgi+6lbgAge0yz1J5QZFax4vn+1kBN6bGBE0s/Pyd1
   RcewNCHR0WhTwphK31dccTrzyUrOc32FJHLCfXle0TlU0Aa6j7qGPXT8V
   7sqSEfPxy1/3B7GTJyk5VLFIjgTp4dFJmY5+zH+Pwxkw51E/3Wyvaz6ka
   KhTXQJW8jwKTzMrOIXPXnf45f6YbB9wyEGobFFaJ84uEYLxuLz6E9I4Tl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2790452"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2790452"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894370151"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="894370151"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:23 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 06/13] wifi: mac80211: rework RX timestamp flags
Date: Wed, 20 Dec 2023 13:41:39 +0200
Message-Id: <20231220133549.d0e664832d14.I20c8900106f9bf81316bed778b1e3ce145785274@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We only have a single flag free, and before using that for
another mactime flag, instead refactor the mactime flags
to use a 2-bit field.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: Fix wrong email addresses and fix ath code
---
 drivers/net/wireless/ath/ath10k/htt_rx.c |  2 +-
 include/net/mac80211.h                   | 13 +++++++++----
 net/mac80211/ieee80211_i.h               |  5 +----
 net/mac80211/util.c                      | 16 ++++++++++------
 4 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index fa0f598ed6bf..7d28ae5453cf 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1295,7 +1295,7 @@ static void ath10k_htt_rx_h_ppdu(struct ath10k *ar,
 		status->encoding = RX_ENC_LEGACY;
 		status->bw = RATE_INFO_BW_20;
 
-		status->flag &= ~RX_FLAG_MACTIME_END;
+		status->flag &= ~RX_FLAG_MACTIME;
 		status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
 		status->flag &= ~(RX_FLAG_AMPDU_IS_LAST);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 77a71b1396b1..00274d1cdeeb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1362,6 +1362,9 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
  *	the frame.
  * @RX_FLAG_FAILED_PLCP_CRC: Set this flag if the PCLP check failed on
  *	the frame.
+ * @RX_FLAG_MACTIME: The timestamp passed in the RX status (@mactime
+ *	field) is valid if this field is non-zero, and the position
+ *	where the timestamp was sampled depends on the value.
  * @RX_FLAG_MACTIME_START: The timestamp passed in the RX status (@mactime
  *	field) is valid and contains the time the first symbol of the MPDU
  *	was received. This is useful in monitor mode and for proper IBSS
@@ -1441,12 +1444,12 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
 enum mac80211_rx_flags {
 	RX_FLAG_MMIC_ERROR		= BIT(0),
 	RX_FLAG_DECRYPTED		= BIT(1),
-	RX_FLAG_MACTIME_PLCP_START	= BIT(2),
+	RX_FLAG_ONLY_MONITOR		= BIT(2),
 	RX_FLAG_MMIC_STRIPPED		= BIT(3),
 	RX_FLAG_IV_STRIPPED		= BIT(4),
 	RX_FLAG_FAILED_FCS_CRC		= BIT(5),
 	RX_FLAG_FAILED_PLCP_CRC 	= BIT(6),
-	RX_FLAG_MACTIME_START		= BIT(7),
+	/* one free bit at 7 */
 	RX_FLAG_NO_SIGNAL_VAL		= BIT(8),
 	RX_FLAG_AMPDU_DETAILS		= BIT(9),
 	RX_FLAG_PN_VALIDATED		= BIT(10),
@@ -1455,8 +1458,10 @@ enum mac80211_rx_flags {
 	RX_FLAG_AMPDU_IS_LAST		= BIT(13),
 	RX_FLAG_AMPDU_DELIM_CRC_ERROR	= BIT(14),
 	RX_FLAG_AMPDU_DELIM_CRC_KNOWN	= BIT(15),
-	RX_FLAG_MACTIME_END		= BIT(16),
-	RX_FLAG_ONLY_MONITOR		= BIT(17),
+	RX_FLAG_MACTIME			= BIT(16) | BIT(17),
+	RX_FLAG_MACTIME_PLCP_START	= 1 << 16,
+	RX_FLAG_MACTIME_START		= 2 << 16,
+	RX_FLAG_MACTIME_END		= 3 << 16,
 	RX_FLAG_SKIP_MONITOR		= BIT(18),
 	RX_FLAG_AMSDU_MORE		= BIT(19),
 	RX_FLAG_RADIOTAP_TLV_AT_END	= BIT(20),
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 29312f6638a1..938f4d255668 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1775,10 +1775,7 @@ static inline bool txq_has_queue(struct ieee80211_txq *txq)
 static inline bool
 ieee80211_have_rx_timestamp(struct ieee80211_rx_status *status)
 {
-	WARN_ON_ONCE(status->flag & RX_FLAG_MACTIME_START &&
-		     status->flag & RX_FLAG_MACTIME_END);
-	return !!(status->flag & (RX_FLAG_MACTIME_START | RX_FLAG_MACTIME_END |
-				  RX_FLAG_MACTIME_PLCP_START));
+	return status->flag & RX_FLAG_MACTIME;
 }
 
 void ieee80211_vif_inc_num_mcast(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ed680120d5a7..643c54855be6 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4176,6 +4176,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 				     unsigned int mpdu_offset)
 {
 	u64 ts = status->mactime;
+	bool mactime_plcp_start;
 	struct rate_info ri;
 	u16 rate;
 	u8 n_ltf;
@@ -4183,6 +4184,9 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 	if (WARN_ON(!ieee80211_have_rx_timestamp(status)))
 		return 0;
 
+	mactime_plcp_start = (status->flag & RX_FLAG_MACTIME) ==
+				RX_FLAG_MACTIME_PLCP_START;
+
 	memset(&ri, 0, sizeof(ri));
 
 	ri.bw = status->bw;
@@ -4197,7 +4201,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 		if (status->enc_flags & RX_ENC_FLAG_SHORT_GI)
 			ri.flags |= RATE_INFO_FLAGS_SHORT_GI;
 		/* TODO/FIXME: is this right? handle other PPDUs */
-		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
+		if (mactime_plcp_start) {
 			mpdu_offset += 2;
 			ts += 36;
 		}
@@ -4214,7 +4218,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 		 * See P802.11ax_D6.0, section 27.3.4 for
 		 * VHT PPDU format.
 		 */
-		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
+		if (mactime_plcp_start) {
 			mpdu_offset += 2;
 			ts += 36;
 
@@ -4238,7 +4242,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 		 * See P802.11REVmd_D3.0, section 19.3.2 for
 		 * HT PPDU format.
 		 */
-		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
+		if (mactime_plcp_start) {
 			mpdu_offset += 2;
 			if (status->enc_flags & RX_ENC_FLAG_HT_GF)
 				ts += 24;
@@ -4266,7 +4270,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 		 * See P802.11REVmd_D3.0, section 21.3.2 for
 		 * VHT PPDU format.
 		 */
-		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
+		if (mactime_plcp_start) {
 			mpdu_offset += 2;
 			ts += 36;
 
@@ -4288,7 +4292,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 		sband = local->hw.wiphy->bands[status->band];
 		ri.legacy = sband->bitrates[status->rate_idx].bitrate;
 
-		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
+		if (mactime_plcp_start) {
 			if (status->band == NL80211_BAND_5GHZ) {
 				ts += 20;
 				mpdu_offset += 2;
@@ -4310,7 +4314,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 		return 0;
 
 	/* rewind from end of MPDU */
-	if (status->flag & RX_FLAG_MACTIME_END)
+	if ((status->flag & RX_FLAG_MACTIME) == RX_FLAG_MACTIME_END)
 		ts -= mpdu_len * 8 * 10 / rate;
 
 	ts += mpdu_offset * 8 * 10 / rate;
-- 
2.34.1


