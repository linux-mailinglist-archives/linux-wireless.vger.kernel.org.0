Return-Path: <linux-wireless+bounces-11228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B102394D4BF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 18:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5FC2826FB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5391B969;
	Fri,  9 Aug 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELvcMjOX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75338394;
	Fri,  9 Aug 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221183; cv=none; b=HzWdASINrr1v4jADEOCZycx6qd+vspn+DokUJd2z44M54insUTEMU4aL+cKEEQ/xZrGXRGgjFTSZ3kCm65skopJHlx3iQQKzjpNA/kJooXiM8oPRtkdnf5KSy5lMLh+lpBOLvfN6dGx3F9NqEXLZKu+CHCG+oY3+bsH2V3522Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221183; c=relaxed/simple;
	bh=1ubKv9iYakEVw8NVhxMtu+IrpAtVCtKDNpr+xRZOhk0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QDUu8TwVcqoNyRIiMxNS0e8YrP2VbNBfF0FehntJVqAtV0Vhz0gcKG/hJW2lkRVaraX4WJtEtiFJkS5NWdLBd6HEFsQUrPPigXMHdB+y9WfOZrNqX1GFXEJamhU7YMo4WcLyA97066iIcuKDEaHYq0ydRxu4uOXarGq8OUoDVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELvcMjOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157E4C32782;
	Fri,  9 Aug 2024 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723221182;
	bh=1ubKv9iYakEVw8NVhxMtu+IrpAtVCtKDNpr+xRZOhk0=;
	h=Date:From:To:Cc:Subject:From;
	b=ELvcMjOXSJvDg/yRqQsKVs5fRAWH5zGBZFk0nlPxRcA77KkbM/SHsxp1nHo535Nt0
	 POTyM8nnCT6j6X4yirmfIJsEJHWPPXMEhIA3J/WMdGRyhoocp3MYiJI12L3sE86sd9
	 A2t2gW1ulbaCjiLGP1DHGHEw93SBw388iY63R11uWdUTTP/G0+tLkUDroqOzMYWQJ0
	 rAX3bR+5z6sDVVDwLa28Q5KbP2+8rco4l5a6LL9WABl+3Czl9Ze6LV+QFemFEnsnnq
	 VyccyiZfPqLnd5exLpJfxDskDJXIv0NXfzWQ8ciYF0/ufiLhub+K6Nt5Qoc+gYlCpQ
	 iNoOGIOWvX1mA==
Date: Fri, 9 Aug 2024 10:32:59 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: ath12k: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZrZEuxJihMzAaTVh@cute>
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

Also, remove an unused structure.

Fix the following warnings:
drivers/net/wireless/ath/ath12k/core.h:290:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/ath/ath12k/dp.h:1499:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.h |  4 +++-
 drivers/net/wireless/ath/ath12k/dp.h   | 12 ------------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index cdfd43a7321a..bd23c7401637 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -287,7 +287,6 @@ struct ath12k_vif {
 	int txpower;
 	bool rsnie_present;
 	bool wpaie_present;
-	struct ieee80211_chanctx_conf chanctx;
 	u32 key_cipher;
 	u8 tx_encap_type;
 	u8 vdev_stats_id;
@@ -295,6 +294,9 @@ struct ath12k_vif {
 	bool ps;
 	struct ath12k_vif_cache *cache;
 	struct ath12k_rekey_data rekey_data;
+
+	/* Must be last - ends in a flexible-array member. */
+	struct ieee80211_chanctx_conf chanctx;
 };
 
 struct ath12k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index b77497c14ac4..2fb18b83b3ee 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1495,18 +1495,6 @@ struct htt_ppdu_stats_user_rate {
 #define HTT_TX_INFO_PEERID(_flags) \
 			u32_get_bits(_flags, HTT_PPDU_STATS_TX_INFO_FLAGS_PEERID_M)
 
-struct htt_tx_ppdu_stats_info {
-	struct htt_tlv tlv_hdr;
-	__le32 tx_success_bytes;
-	__le32 tx_retry_bytes;
-	__le32 tx_failed_bytes;
-	__le32 flags; /* %HTT_PPDU_STATS_TX_INFO_FLAGS_ */
-	__le16 tx_success_msdus;
-	__le16 tx_retry_msdus;
-	__le16 tx_failed_msdus;
-	__le16 tx_duration; /* united in us */
-} __packed;
-
 enum  htt_ppdu_stats_usr_compln_status {
 	HTT_PPDU_STATS_USER_STATUS_OK,
 	HTT_PPDU_STATS_USER_STATUS_FILTERED,
-- 
2.34.1


