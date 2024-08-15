Return-Path: <linux-wireless+bounces-11457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF06595295F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072CE1C21F83
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9D176FA2;
	Thu, 15 Aug 2024 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClnDJTfn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EE18D65A;
	Thu, 15 Aug 2024 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703496; cv=none; b=G74iKJi3KE5tfXkKmasqZapnVB/+4vTsi0iFWccUVVfwND4J6OZSLYJwdrKOZy3kknY2+hc0r34kwCn6j1H5OgI14FGDmoOygNnur1ZcH6J/je/HKlRNKrAjFyRA5palvXG+lh1Wzur6CFtSb4UxjrGg7Yo/n/SV19dz16IOOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703496; c=relaxed/simple;
	bh=LILggnHI5JAH3IQtyXvSWYCaxwOVXP4oIXahHsbk27s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XgbIlKYrVoPchyZckwhZtmCkAEb7LMsn2R4kHkkLXmGt9T/q91rCt5H6osMGc7dndNvxJtXqjbW1SV2bVY3Pak+spot6EwyBVjKz9k3jSJTPmRm82h53L3wK5PXzXi5yXvkRjqxohfesKkRodDI8g+p86bf8StS1IuVF2uyDPNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClnDJTfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124F3C4AF0A;
	Thu, 15 Aug 2024 06:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723703495;
	bh=LILggnHI5JAH3IQtyXvSWYCaxwOVXP4oIXahHsbk27s=;
	h=Date:From:To:Cc:Subject:From;
	b=ClnDJTfnVenw6uXqLv0CpwkgTsuA7XdBv0XGDamcjqDKMbwnm11WSdS0z4CRUL4TX
	 1zyj12LbLW2xU3TFcsibMMaB5cUrHnEpMzUV0UylDBW8J1fLTykrFZCVVGAuRv+UF7
	 RhEwbS/1Uf6zFhis3HBrYiB9tOjGuNcC88LlPu9CbxpDcTRMas6KYPt5596SWYAsRR
	 2Knzeqb62O+TFy4IjRL8aBMu7XMM8akAMdWD+/keWKlpBB6C+M4GATPkpmZszh/YJY
	 p+NXRv6NtO8MOidqfu9mooQnUXgEC0j4ex7OlWl6+TTKhmamQcsQiKtXIo8t65rMnW
	 jJRAkKl8baBHw==
Date: Thu, 15 Aug 2024 00:31:32 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Zr2gxERA3RL3EwRe@elsanto>
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

So, in order to avoid ending up with a flexible-array member in the
middle of multiple other structs, we use the `__struct_group()`
helper to create new tagged structures with the suffix `_hdr`.
These structures group together all the members of the original
flexible structures except the flexible arrays.

As a result, the arrays are effectively separated from the rest of the
members without modifying the memory layout of the flexible structures.
We then change the type of the middle struct members currently causing
trouble from the original flex struct to the newly created structs with
suffix `_hdr`.

We also want to ensure that when new members need to be added to the
flexible structures, they are always included within the newly created
tagged structs. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement the `_hdr` structures as
completely separate structures, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible-array
member, if necessary.

Also, remove a couple of unused zero-length arrays and flexible-array
members.

So, with these changes, fix the following warnings:

drivers/net/wireless/intel/iwlegacy/commands.h:1196:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlegacy/commands.h:1197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlegacy/commands.h:2505:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlegacy/commands.h:2549:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlegacy/commands.h:2654:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlegacy/commands.h:2665:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlegacy/commands.h:2673:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlegacy/commands.h:3349:30: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/3945.c    |   2 +-
 drivers/net/wireless/intel/iwlegacy/3945.h    |   6 +-
 .../net/wireless/intel/iwlegacy/4965-mac.c    |   2 +-
 .../net/wireless/intel/iwlegacy/commands.h    | 303 +++++++++---------
 drivers/net/wireless/intel/iwlegacy/common.h  |   2 +-
 5 files changed, 165 insertions(+), 150 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945.c b/drivers/net/wireless/intel/iwlegacy/3945.c
index 1fab7849f56d..e95800b77f6b 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945.c
@@ -527,7 +527,7 @@ il3945_hdl_rx(struct il_priv *il, struct il_rx_buf *rxb)
 	struct ieee80211_hdr *header;
 	struct ieee80211_rx_status rx_status = {};
 	struct il_rx_pkt *pkt = rxb_addr(rxb);
-	struct il3945_rx_frame_stats *rx_stats = IL_RX_STATS(pkt);
+	struct il3945_rx_frame_stats_hdr *rx_stats = IL_RX_STATS(pkt);
 	struct il3945_rx_frame_hdr *rx_hdr = IL_RX_HDR(pkt);
 	struct il3945_rx_frame_end *rx_end = IL_RX_END(pkt);
 	u16 rx_stats_sig_avg __maybe_unused = le16_to_cpu(rx_stats->sig_avg);
diff --git a/drivers/net/wireless/intel/iwlegacy/3945.h b/drivers/net/wireless/intel/iwlegacy/3945.h
index 82e4a4878bc2..ffbe11902628 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.h
+++ b/drivers/net/wireless/intel/iwlegacy/3945.h
@@ -157,8 +157,10 @@ struct il3945_ibss_seq {
 };
 
 #define IL_RX_HDR(x) ((struct il3945_rx_frame_hdr *)(\
-		       x->u.rx_frame.stats.payload + \
-		       x->u.rx_frame.stats.phy_count))
+		      container_of(&x->u.rx_frame.stats, \
+				   struct il3945_rx_frame_stats, \
+				   hdr)->payload + \
+		      x->u.rx_frame.stats.phy_count))
 #define IL_RX_END(x) ((struct il3945_rx_frame_end *)(\
 		       IL_RX_HDR(x)->payload + \
 		       le16_to_cpu(IL_RX_HDR(x)->len)))
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 1600c344edbb..fcccde7bb659 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -1769,7 +1769,7 @@ il4965_tx_skb(struct il_priv *il,
 	/* Set up first empty entry in queue's array of Tx/cmd buffers */
 	out_cmd = txq->cmd[q->write_ptr];
 	out_meta = &txq->meta[q->write_ptr];
-	tx_cmd = &out_cmd->cmd.tx;
+	tx_cmd = container_of(&out_cmd->cmd.tx, struct il_tx_cmd, __hdr);
 	memset(&out_cmd->hdr, 0, sizeof(out_cmd->hdr));
 	memset(tx_cmd, 0, sizeof(struct il_tx_cmd));
 
diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
index 28cf4e832152..4a9fa8b83f0f 100644
--- a/drivers/net/wireless/intel/iwlegacy/commands.h
+++ b/drivers/net/wireless/intel/iwlegacy/commands.h
@@ -201,9 +201,6 @@ struct il_cmd_header {
 	 *  15          unsolicited RX or uCode-originated notification
 	 */
 	__le16 sequence;
-
-	/* command or response/notification data follows immediately */
-	u8 data[];
 } __packed;
 
 /**
@@ -1160,23 +1157,33 @@ struct il_wep_cmd {
 #define RX_MPDU_RES_STATUS_DEC_DONE_MSK	(0x800)
 
 struct il3945_rx_frame_stats {
-	u8 phy_count;
-	u8 id;
-	u8 rssi;
-	u8 agc;
-	__le16 sig_avg;
-	__le16 noise_diff;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(il3945_rx_frame_stats_hdr, hdr, __packed,
+		u8 phy_count;
+		u8 id;
+		u8 rssi;
+		u8 agc;
+		__le16 sig_avg;
+		__le16 noise_diff;
+	);
 	u8 payload[];
 } __packed;
+static_assert(offsetof(struct il3945_rx_frame_stats, payload) == sizeof(struct il3945_rx_frame_stats_hdr),
+	      "struct member likely outside of __struct_group()");
 
 struct il3945_rx_frame_hdr {
-	__le16 channel;
-	__le16 phy_flags;
-	u8 reserved1;
-	u8 rate;
-	__le16 len;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(il3945_rx_frame_hdr_hdr, hdr, __packed,
+		__le16 channel;
+		__le16 phy_flags;
+		u8 reserved1;
+		u8 rate;
+		__le16 len;
+	);
 	u8 payload[];
 } __packed;
+static_assert(offsetof(struct il3945_rx_frame_hdr, payload) == sizeof(struct il3945_rx_frame_hdr_hdr),
+	      "struct member likely outside of __struct_group()");
 
 struct il3945_rx_frame_end {
 	__le32 status;
@@ -1193,8 +1200,8 @@ struct il3945_rx_frame_end {
  * stats.phy_count
  */
 struct il3945_rx_frame {
-	struct il3945_rx_frame_stats stats;
-	struct il3945_rx_frame_hdr hdr;
+	struct il3945_rx_frame_stats_hdr stats;
+	struct il3945_rx_frame_hdr_hdr hdr;
 	struct il3945_rx_frame_end end;
 } __packed;
 
@@ -1352,67 +1359,69 @@ struct il_rx_mpdu_res_start {
  */
 
 struct il3945_tx_cmd {
-	/*
-	 * MPDU byte count:
-	 * MAC header (24/26/30/32 bytes) + 2 bytes pad if 26/30 header size,
-	 * + 8 byte IV for CCM or TKIP (not used for WEP)
-	 * + Data payload
-	 * + 8-byte MIC (not used for CCM/WEP)
-	 * NOTE:  Does not include Tx command bytes, post-MAC pad bytes,
-	 *        MIC (CCM) 8 bytes, ICV (WEP/TKIP/CKIP) 4 bytes, CRC 4 bytes.i
-	 * Range: 14-2342 bytes.
-	 */
-	__le16 len;
-
-	/*
-	 * MPDU or MSDU byte count for next frame.
-	 * Used for fragmentation and bursting, but not 11n aggregation.
-	 * Same as "len", but for next frame.  Set to 0 if not applicable.
-	 */
-	__le16 next_frame_len;
-
-	__le32 tx_flags;	/* TX_CMD_FLG_* */
-
-	u8 rate;
-
-	/* Index of recipient station in uCode's station table */
-	u8 sta_id;
-	u8 tid_tspec;
-	u8 sec_ctl;
-	u8 key[16];
-	union {
-		u8 byte[8];
-		__le16 word[4];
-		__le32 dw[2];
-	} tkip_mic;
-	__le32 next_frame_info;
-	union {
-		__le32 life_time;
-		__le32 attempt;
-	} stop_time;
-	u8 supp_rates[2];
-	u8 rts_retry_limit;	/*byte 50 */
-	u8 data_retry_limit;	/*byte 51 */
-	union {
-		__le16 pm_frame_timeout;
-		__le16 attempt_duration;
-	} timeout;
-
-	/*
-	 * Duration of EDCA burst Tx Opportunity, in 32-usec units.
-	 * Set this if txop time is not specified by HCCA protocol (e.g. by AP).
-	 */
-	__le16 driver_txop;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(il3945_tx_cmd_hdr, __hdr, __packed,
+		/*
+		 * MPDU byte count:
+		 * MAC header (24/26/30/32 bytes) + 2 bytes pad if 26/30 header size,
+		 * + 8 byte IV for CCM or TKIP (not used for WEP)
+		 * + Data payload
+		 * + 8-byte MIC (not used for CCM/WEP)
+		 * NOTE:  Does not include Tx command bytes, post-MAC pad bytes,
+		 *        MIC (CCM) 8 bytes, ICV (WEP/TKIP/CKIP) 4 bytes, CRC 4 bytes.i
+		 * Range: 14-2342 bytes.
+		 */
+		__le16 len;
+
+		/*
+		 * MPDU or MSDU byte count for next frame.
+		 * Used for fragmentation and bursting, but not 11n aggregation.
+		 * Same as "len", but for next frame.  Set to 0 if not applicable.
+		 */
+		__le16 next_frame_len;
+
+		__le32 tx_flags;	/* TX_CMD_FLG_* */
+
+		u8 rate;
+
+		/* Index of recipient station in uCode's station table */
+		u8 sta_id;
+		u8 tid_tspec;
+		u8 sec_ctl;
+		u8 key[16];
+		union {
+			u8 byte[8];
+			__le16 word[4];
+			__le32 dw[2];
+		} tkip_mic;
+		__le32 next_frame_info;
+		union {
+			__le32 life_time;
+			__le32 attempt;
+		} stop_time;
+		u8 supp_rates[2];
+		u8 rts_retry_limit;	/*byte 50 */
+		u8 data_retry_limit;	/*byte 51 */
+		union {
+			__le16 pm_frame_timeout;
+			__le16 attempt_duration;
+		} timeout;
+
+		/*
+		 * Duration of EDCA burst Tx Opportunity, in 32-usec units.
+		 * Set this if txop time is not specified by HCCA protocol (e.g. by AP).
+		 */
+		__le16 driver_txop;
+	);
 
 	/*
 	 * MAC header goes here, followed by 2 bytes padding if MAC header
 	 * length is 26 or 30 bytes, followed by payload data
 	 */
-	union {
-		DECLARE_FLEX_ARRAY(u8, payload);
-		DECLARE_FLEX_ARRAY(struct ieee80211_hdr, hdr);
-	};
+	struct ieee80211_hdr hdr[];
 } __packed;
+static_assert(offsetof(struct il3945_tx_cmd, hdr) == sizeof(struct il3945_tx_cmd_hdr),
+	      "struct member likely outside of __struct_group()");
 
 /*
  * C_TX = 0x1c (response)
@@ -1438,83 +1447,87 @@ struct il_dram_scratch {
 } __packed;
 
 struct il_tx_cmd {
-	/*
-	 * MPDU byte count:
-	 * MAC header (24/26/30/32 bytes) + 2 bytes pad if 26/30 header size,
-	 * + 8 byte IV for CCM or TKIP (not used for WEP)
-	 * + Data payload
-	 * + 8-byte MIC (not used for CCM/WEP)
-	 * NOTE:  Does not include Tx command bytes, post-MAC pad bytes,
-	 *        MIC (CCM) 8 bytes, ICV (WEP/TKIP/CKIP) 4 bytes, CRC 4 bytes.i
-	 * Range: 14-2342 bytes.
-	 */
-	__le16 len;
-
-	/*
-	 * MPDU or MSDU byte count for next frame.
-	 * Used for fragmentation and bursting, but not 11n aggregation.
-	 * Same as "len", but for next frame.  Set to 0 if not applicable.
-	 */
-	__le16 next_frame_len;
-
-	__le32 tx_flags;	/* TX_CMD_FLG_* */
-
-	/* uCode may modify this field of the Tx command (in host DRAM!).
-	 * Driver must also set dram_lsb_ptr and dram_msb_ptr in this cmd. */
-	struct il_dram_scratch scratch;
-
-	/* Rate for *all* Tx attempts, if TX_CMD_FLG_STA_RATE_MSK is cleared. */
-	__le32 rate_n_flags;	/* RATE_MCS_* */
-
-	/* Index of destination station in uCode's station table */
-	u8 sta_id;
-
-	/* Type of security encryption:  CCM or TKIP */
-	u8 sec_ctl;		/* TX_CMD_SEC_* */
-
-	/*
-	 * Index into rate table (see C_TX_LINK_QUALITY_CMD) for initial
-	 * Tx attempt, if TX_CMD_FLG_STA_RATE_MSK is set.  Normally "0" for
-	 * data frames, this field may be used to selectively reduce initial
-	 * rate (via non-0 value) for special frames (e.g. management), while
-	 * still supporting rate scaling for all frames.
-	 */
-	u8 initial_rate_idx;
-	u8 reserved;
-	u8 key[16];
-	__le16 next_frame_flags;
-	__le16 reserved2;
-	union {
-		__le32 life_time;
-		__le32 attempt;
-	} stop_time;
-
-	/* Host DRAM physical address pointer to "scratch" in this command.
-	 * Must be dword aligned.  "0" in dram_lsb_ptr disables usage. */
-	__le32 dram_lsb_ptr;
-	u8 dram_msb_ptr;
-
-	u8 rts_retry_limit;	/*byte 50 */
-	u8 data_retry_limit;	/*byte 51 */
-	u8 tid_tspec;
-	union {
-		__le16 pm_frame_timeout;
-		__le16 attempt_duration;
-	} timeout;
-
-	/*
-	 * Duration of EDCA burst Tx Opportunity, in 32-usec units.
-	 * Set this if txop time is not specified by HCCA protocol (e.g. by AP).
-	 */
-	__le16 driver_txop;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(il_tx_cmd_hdr, __hdr, __packed,
+		/*
+		 * MPDU byte count:
+		 * MAC header (24/26/30/32 bytes) + 2 bytes pad if 26/30 header size,
+		 * + 8 byte IV for CCM or TKIP (not used for WEP)
+		 * + Data payload
+		 * + 8-byte MIC (not used for CCM/WEP)
+		 * NOTE:  Does not include Tx command bytes, post-MAC pad bytes,
+		 *        MIC (CCM) 8 bytes, ICV (WEP/TKIP/CKIP) 4 bytes, CRC 4 bytes.i
+		 * Range: 14-2342 bytes.
+		 */
+		__le16 len;
+
+		/*
+		 * MPDU or MSDU byte count for next frame.
+		 * Used for fragmentation and bursting, but not 11n aggregation.
+		 * Same as "len", but for next frame.  Set to 0 if not applicable.
+		 */
+		__le16 next_frame_len;
+
+		__le32 tx_flags;	/* TX_CMD_FLG_* */
+
+		/* uCode may modify this field of the Tx command (in host DRAM!).
+		 * Driver must also set dram_lsb_ptr and dram_msb_ptr in this cmd. */
+		struct il_dram_scratch scratch;
+
+		/* Rate for *all* Tx attempts, if TX_CMD_FLG_STA_RATE_MSK is cleared. */
+		__le32 rate_n_flags;	/* RATE_MCS_* */
+
+		/* Index of destination station in uCode's station table */
+		u8 sta_id;
+
+		/* Type of security encryption:  CCM or TKIP */
+		u8 sec_ctl;		/* TX_CMD_SEC_* */
+
+		/*
+		 * Index into rate table (see C_TX_LINK_QUALITY_CMD) for initial
+		 * Tx attempt, if TX_CMD_FLG_STA_RATE_MSK is set.  Normally "0" for
+		 * data frames, this field may be used to selectively reduce initial
+		 * rate (via non-0 value) for special frames (e.g. management), while
+		 * still supporting rate scaling for all frames.
+		 */
+		u8 initial_rate_idx;
+		u8 reserved;
+		u8 key[16];
+		__le16 next_frame_flags;
+		__le16 reserved2;
+		union {
+			__le32 life_time;
+			__le32 attempt;
+		} stop_time;
+
+		/* Host DRAM physical address pointer to "scratch" in this command.
+		 * Must be dword aligned.  "0" in dram_lsb_ptr disables usage. */
+		__le32 dram_lsb_ptr;
+		u8 dram_msb_ptr;
+
+		u8 rts_retry_limit;	/*byte 50 */
+		u8 data_retry_limit;	/*byte 51 */
+		u8 tid_tspec;
+		union {
+			__le16 pm_frame_timeout;
+			__le16 attempt_duration;
+		} timeout;
+
+		/*
+		 * Duration of EDCA burst Tx Opportunity, in 32-usec units.
+		 * Set this if txop time is not specified by HCCA protocol (e.g. by AP).
+		 */
+		__le16 driver_txop;
+	);
 
 	/*
 	 * MAC header goes here, followed by 2 bytes padding if MAC header
 	 * length is 26 or 30 bytes, followed by payload data
 	 */
-	u8 payload[0];
 	struct ieee80211_hdr hdr[];
 } __packed;
+static_assert(offsetof(struct il_tx_cmd, hdr) == sizeof(struct il_tx_cmd_hdr),
+	      "struct member likely outside of __struct_group()");
 
 /* TX command response is sent after *3945* transmission attempts.
  *
@@ -2502,7 +2515,7 @@ struct il3945_scan_cmd {
 
 	/* For active scans (set to all-0s for passive scans).
 	 * Does not include payload.  Must specify Tx rate; no rate scaling. */
-	struct il3945_tx_cmd tx_cmd;
+	struct il3945_tx_cmd_hdr tx_cmd;
 
 	/* For directed active scans (set to all-0s otherwise) */
 	struct il_ssid_ie direct_scan[PROBE_OPTION_MAX_3945];
@@ -2546,7 +2559,7 @@ struct il_scan_cmd {
 
 	/* For active scans (set to all-0s for passive scans).
 	 * Does not include payload.  Must specify Tx rate; no rate scaling. */
-	struct il_tx_cmd tx_cmd;
+	struct il_tx_cmd_hdr tx_cmd;
 
 	/* For directed active scans (set to all-0s otherwise) */
 	struct il_ssid_ie direct_scan[PROBE_OPTION_MAX];
@@ -2662,7 +2675,7 @@ struct il4965_beacon_notif {
  */
 
 struct il3945_tx_beacon_cmd {
-	struct il3945_tx_cmd tx;
+	struct il3945_tx_cmd_hdr tx;
 	__le16 tim_idx;
 	u8 tim_size;
 	u8 reserved1;
@@ -2670,7 +2683,7 @@ struct il3945_tx_beacon_cmd {
 } __packed;
 
 struct il_tx_beacon_cmd {
-	struct il_tx_cmd tx;
+	struct il_tx_cmd_hdr tx;
 	__le16 tim_idx;
 	u8 tim_size;
 	u8 reserved1;
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 69687fcf963f..2147781b5fff 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -553,7 +553,7 @@ struct il_device_cmd {
 		u8 val8;
 		u16 val16;
 		u32 val32;
-		struct il_tx_cmd tx;
+		struct il_tx_cmd_hdr tx;
 		u8 payload[DEF_CMD_PAYLOAD_SIZE];
 	} __packed cmd;
 } __packed;
-- 
2.34.1


