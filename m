Return-Path: <linux-wireless+bounces-11227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5390694D486
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5601F22C55
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5EC1991C9;
	Fri,  9 Aug 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTx0pkY3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF3195F3A;
	Fri,  9 Aug 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220449; cv=none; b=ZWq1wn2cXQ3Kv5i2hVEYt08I32/w632E1Cz3KsxqCFvwoFZfHBz8OWWWSFujfMTCm1dDQW6yYJ6NFhiT79NnMZx4N40jtT/f/rSn15tAW5a0oAh1e57jZSnNT9imjWKm8aMvhD+hk0Mr053CHdB8CPMAjQmBH30UAeUsSl5Ih4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220449; c=relaxed/simple;
	bh=JvFuafIlA5XYuTkzcsIaPQIzRgFXGYfK86QgMIRemXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lWd+yUvlw+Jzi2v1S+7JCD7uVm6VPUA5A87PwQysMBVe0oAzldezTAE7wjOroGuWu4g0Jm+XiBqRgDBRuDYeL4eoc49sX2AhjGEJl5QG6b3kMyN9gzOfN7r2SUDPBRMslK9TpFMWQdNd4witqhlLhCIETAWalT8QXAuQTFukuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTx0pkY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1335BC32782;
	Fri,  9 Aug 2024 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723220448;
	bh=JvFuafIlA5XYuTkzcsIaPQIzRgFXGYfK86QgMIRemXM=;
	h=Date:From:To:Cc:Subject:From;
	b=JTx0pkY32DTKdHuZ8o93I2RKkOrJMLad6J9pBwJVg4g/I4Kjq88Xx5NvRbLu7q+rn
	 g71WncVeC5YSlCMMuF+dTJ5vOg7NkN1eBqh5PKWnAZrBuMUHqaGKj5TgZuJ3pa8c+g
	 qQnq2FJ/xDMCZsluWC4pLkMRAGvig4a8Cd96pwUZtKS3YZZe/DOKqisVttItQmjf2B
	 LHfwR8wch9DmpbeEdWklneFb8ENsA1y3Bkbm1W9oYraV7ehsOSbDt5KKzinSKlKyAv
	 MPHtUqWLNOa7yJDux76y8dqQdkvtFtb2pLtfo4f/UkHz3FzZZQxdUmi7F14PZZuL3k
	 WXuNAozIuging==
Date: Fri, 9 Aug 2024 10:20:45 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: ath11k: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZrZB3Rjswe0ZXtug@cute>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct ieee80211_chanctx_conf` is a flexible structure --a
structure that contains a flexible-array member.

Also, remove a couple of unused structures.

Fix the following warnings:
drivers/net/wireless/ath/ath11k/core.h:409:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/ath/ath11k/dp.h:1309:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/ath/ath11k/dp.h:1368:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  4 +++-
 drivers/net/wireless/ath/ath11k/dp.h   | 23 -----------------------
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index df24f0e409af..e283415dccf3 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -406,11 +406,13 @@ struct ath11k_vif {
 	bool wpaie_present;
 	bool bcca_zero_sent;
 	bool do_not_send_tmpl;
-	struct ieee80211_chanctx_conf chanctx;
 	struct ath11k_arp_ns_offload arp_ns_offload;
 	struct ath11k_rekey_data rekey_data;
 
 	struct ath11k_reg_tpc_power_info reg_tpc_info;
+
+	/* Must be last - ends in a flexible-array member. */
+	struct ieee80211_chanctx_conf chanctx;
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 2f6dd69d3be2..65d2bc0687c8 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1305,18 +1305,6 @@ struct htt_ppdu_stats_user_rate {
 #define HTT_TX_INFO_PEERID(_flags) \
 			FIELD_GET(HTT_PPDU_STATS_TX_INFO_FLAGS_PEERID_M, _flags)
 
-struct htt_tx_ppdu_stats_info {
-	struct htt_tlv tlv_hdr;
-	u32 tx_success_bytes;
-	u32 tx_retry_bytes;
-	u32 tx_failed_bytes;
-	u32 flags; /* %HTT_PPDU_STATS_TX_INFO_FLAGS_ */
-	u16 tx_success_msdus;
-	u16 tx_retry_msdus;
-	u16 tx_failed_msdus;
-	u16 tx_duration; /* united in us */
-} __packed;
-
 enum  htt_ppdu_stats_usr_compln_status {
 	HTT_PPDU_STATS_USER_STATUS_OK,
 	HTT_PPDU_STATS_USER_STATUS_FILTERED,
@@ -1364,17 +1352,6 @@ struct htt_ppdu_stats_usr_cmpltn_ack_ba_status {
 	u32 success_bytes;
 } __packed;
 
-struct htt_ppdu_stats_usr_cmn_array {
-	struct htt_tlv tlv_hdr;
-	u32 num_ppdu_stats;
-	/* tx_ppdu_stats_info is filled by multiple struct htt_tx_ppdu_stats_info
-	 * elements.
-	 * tx_ppdu_stats_info is variable length, with length =
-	 *     number_of_ppdu_stats * sizeof (struct htt_tx_ppdu_stats_info)
-	 */
-	struct htt_tx_ppdu_stats_info tx_ppdu_info[];
-} __packed;
-
 struct htt_ppdu_user_stats {
 	u16 peer_id;
 	u32 tlv_flags;
-- 
2.34.1


