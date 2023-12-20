Return-Path: <linux-wireless+bounces-970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466E581838C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D703F2861E2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8A11C9D;
	Tue, 19 Dec 2023 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwAQbiur"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889111C9E
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975077; x=1734511077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=COKq1bR1TZUNtdJb6hqhjGUfHMD/7h9pcbx5wmH1PFo=;
  b=dwAQbiurqX66hxoVblGmppkiMrtLYhXaxp5Cq2cT+GBxBrPZCbtrnbXm
   qqyPXVvsPU9LRfulYXE4hRn1LYJgZf2R9ae3/LAE2d48niYzjAB+zhljW
   f6lK+va00phHmNcktgz0DJHGzR6hd4QISWnyLcpKTRRNJ/tIF8ctg6UJh
   9uMC6YTfnTmZHuHTSNNJmGEOJEvxgwnQynuv5juzaSVhMvla5KNt6sQXf
   0DjpBDGHJvAkjtz+Mv4BW4Y6gsIsMBUUMhe3ZVy7ErFMum/81OzUg+iju
   8r18azxGS2BkpGThLl5QnpUgLpccFYyEm+J99q/iSKBygqPMjFTKCin5g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969215"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969215"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266356"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266356"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>, Berg@web.codeaurora.org,
	Benjamin <benjamin.berg@intel.com>
Subject: [PATCH 06/15] wifi: mac80211: rework RX timestamp flags
Date: Wed, 20 Dec 2023 04:37:54 +0200
Message-Id: <20231220043149.caaf422c940d.I20c8900106f9bf81316bed778b1e3ce145785274@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
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

NOTE: For upstream, ath10k needs to be changed like this:
 -status->flag &= ~RX_FLAG_MACTIME_END
 +status->flag &= ~RX_FLAG_MACTIME

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Reviewed-by: Berg, Benjamin <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h     | 13 +++++++++----
 net/mac80211/ieee80211_i.h |  5 +----
 net/mac80211/util.c        | 16 ++++++++++------
 3 files changed, 20 insertions(+), 14 deletions(-)

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


