Return-Path: <linux-wireless+bounces-11500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4678A953A78
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 21:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7375285F7B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5C343AD5;
	Thu, 15 Aug 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGrtYnZW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71A54205D;
	Thu, 15 Aug 2024 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748427; cv=none; b=AEb80TyYH0HAvvnvU9smBKQDmJzhij8byKu6mg3zrgryfqmb80UBZRidIbQSbIECfJOM3sIJq7cOb2GfqNjgeFQZ2Yorbq+MJFumV5AM4aaK056uYz43a2SozuHvUgxkk3EcJR683XHhy55fh99jofWTtmLTeJ+qsenAXdo+BqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748427; c=relaxed/simple;
	bh=QxUDLnoLCSswiWCQdSYaa1Uy9+RjfDFXGtuCXk56fes=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HCvVS8mvZEgK7uIN04D/oT+CaqzrH9cmbYvAXZ0KEDRrj4PH/PK7OS4IBkYbebhC63U4JzpYlbRBxwc0xahF4abV8PjRQCe0T48y6fc5FAXD7M178OwlHx/9R0JMEiB87IoZe5gXKZApw6v5cXqsyHYD63TUkMn5TMbUf2GFjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGrtYnZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81EDC4AF0F;
	Thu, 15 Aug 2024 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723748426;
	bh=QxUDLnoLCSswiWCQdSYaa1Uy9+RjfDFXGtuCXk56fes=;
	h=Date:From:To:Cc:Subject:From;
	b=cGrtYnZW49jp7cuB7v3HYgWnOXjXrQtEshm/gZyzmSYb1+nR1+rzFNEvaHuudjoh0
	 Xi+k+94Y8SD72ueGkhSJGOJUnvlLMC2nmfrtZpragvI5lMev7soAmYg1BjOOMmJriQ
	 qt+x8yOAIJouTPhHLCZa969stXv8kzjEluqoq/mhqTJQ7Atho8Yd01UVffGAxSQ82B
	 ADnwnqQcis9eZpkXJEf7mcqYigpZnznGFNPdaTX9Ju0hHynBCfES6xRl+RfxNVJYIx
	 fH+ebxOtY1nkYgh8VF70fkqxHV/YEOYwNGApA6tsyK8h6P+hBgIOXTuxtwRPs0ZAuJ
	 bPpyG8bhxlS3Q==
Date: Thu, 15 Aug 2024 13:00:23 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: dvm: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Zr5QR03+wyw571zd@elsanto>
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
helper to create a new tagged `struct iwl_tx_cmd_hdr`. This structure
groups together all the members of the flexible `struct iwl_tx_cmd`
except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct members currently causing
trouble from `struct iwl_tx_cmd` to `struct iwl_tx_cmd_hdr`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct iwl_tx_cmd_hdr`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

So, with these changes, fix the following warnings:

drivers/net/wireless/intel/iwlwifi/dvm/commands.h:2315:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/dvm/commands.h:2426:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../net/wireless/intel/iwlwifi/dvm/commands.h | 154 +++++++++---------
 1 file changed, 78 insertions(+), 76 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
index 3f49c0bccb28..96ea6c8dfc89 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
@@ -1180,85 +1180,87 @@ struct iwl_dram_scratch {
 } __packed;
 
 struct iwl_tx_cmd {
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
-	struct iwl_dram_scratch scratch;
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
-	 * Index into rate table (see REPLY_TX_LINK_QUALITY_CMD) for initial
-	 * Tx attempt, if TX_CMD_FLG_STA_RATE_MSK is set.  Normally "0" for
-	 * data frames, this field may be used to selectively reduce initial
-	 * rate (via non-0 value) for special frames (e.g. management), while
-	 * still supporting rate scaling for all frames.
-	 */
-	u8 initial_rate_index;
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
-
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(iwl_tx_cmd_hdr, __hdr, __packed,
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
+		struct iwl_dram_scratch scratch;
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
+		 * Index into rate table (see REPLY_TX_LINK_QUALITY_CMD) for initial
+		 * Tx attempt, if TX_CMD_FLG_STA_RATE_MSK is set.  Normally "0" for
+		 * data frames, this field may be used to selectively reduce initial
+		 * rate (via non-0 value) for special frames (e.g. management), while
+		 * still supporting rate scaling for all frames.
+		 */
+		u8 initial_rate_index;
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
+
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
+static_assert(offsetof(struct iwl_tx_cmd, hdr) == sizeof(struct iwl_tx_cmd_hdr),
+	      "struct member likely outside of __struct_group()");
 
 /*
  * TX command response is sent after *agn* transmission attempts.
@@ -2312,7 +2314,7 @@ struct iwl_scan_cmd {
 
 	/* For active scans (set to all-0s for passive scans).
 	 * Does not include payload.  Must specify Tx rate; no rate scaling. */
-	struct iwl_tx_cmd tx_cmd;
+	struct iwl_tx_cmd_hdr tx_cmd;
 
 	/* For directed active scans (set to all-0s otherwise) */
 	struct iwl_ssid_ie direct_scan[PROBE_OPTION_MAX];
@@ -2423,7 +2425,7 @@ struct iwlagn_beacon_notif {
  */
 
 struct iwl_tx_beacon_cmd {
-	struct iwl_tx_cmd tx;
+	struct iwl_tx_cmd_hdr tx;
 	__le16 tim_idx;
 	u8 tim_size;
 	u8 reserved1;
-- 
2.34.1


