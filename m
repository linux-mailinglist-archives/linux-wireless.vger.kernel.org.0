Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A13B3DCD38
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Aug 2021 21:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhHATSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Aug 2021 15:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhHATSf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Aug 2021 15:18:35 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB15C06175F;
        Sun,  1 Aug 2021 12:18:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r5so14586776ilc.13;
        Sun, 01 Aug 2021 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHMIxaVy3aDx7oa8/QYCorPHQ/IPcMdISHsVYAkYd60=;
        b=SBhmf7zMiw7Unay+ENpPai89k2vRlhr6jZzQVhqlT0D1Q/ys7c+WAIauBMAjHUZsoF
         wpZMITHG5ZTAFjIiaJz7vKANEskUfAj39xnwpZO/7UruJdnYpBXCyATnESB16qLmn07T
         Q5n40gz52suq5Ey00f6w31lT6bJ2ZyfQMIAPG5rjucTpLTBIh4zKP+o54xW4kozZGu6P
         a45Z39tr29HaTojIdOjl3f8fEcDVT7R6fGE8xlh/8b1ngePihjpiTJGHFD2VGX0OhLe/
         3QM6a3S2edbDofMlTkeYt4kAa7904CNHhTlOz+9DFEgci2H5tp/nZzI1kVIPs0Q0aDEw
         YApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHMIxaVy3aDx7oa8/QYCorPHQ/IPcMdISHsVYAkYd60=;
        b=eDRN0/MzTen3SMsqYyJO4sQ6rXzu5JwpRNegiIhvcaRtS3OyYOv9lFokvyu7rhXECU
         jTPvIZF/OFna3VxWQMPv8QZ8PKkjGRijJZEsFs6nO5F8gk7Zh+uYzIdNPe54Q6izOPzX
         ny5a49tM9RV8qie1IU2l72te4tH2UtrKHIxRf/Iq/wd6IprsOD9gaOUH2HmRvMXYuCnO
         8CacmxfvgjfetDHCPQw4Fwi8klpHm/GMdOJGPgDApnxJ/rOiZ8Iz3sjHbFkdGAuXJnYA
         Rwo7h+N//7a3pa0G4hL/50SyRI2febbQo0WrLcQh8C5Jm0hR6x7sOciT3Cd6886nC3KH
         kZJw==
X-Gm-Message-State: AOAM531ptevTuCOEm0AFMpqHW27EC/sxNrn1x1zJYmkN7n3DqwZhQvR6
        2WPY/scD+60mQUfnZhWXqxY=
X-Google-Smtp-Source: ABdhPJx5GNnv7WMyDoXHKSLsgUTRqoBn/b/u6qv60/3wEJyO1FqOmBB2Z3pJjS9lcEJKeIRm2urlKw==
X-Received: by 2002:a92:4b0a:: with SMTP id m10mr3604127ilg.163.1627845506186;
        Sun, 01 Aug 2021 12:18:26 -0700 (PDT)
Received: from localhost.localdomain ([2600:1702:1260:6e50:2a99:68d3:e3cd:a9ec])
        by smtp.gmail.com with ESMTPSA id l18sm5263285ioc.13.2021.08.01.12.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:18:25 -0700 (PDT)
From:   William Batista <batistaw082@gmail.com>
X-Google-Original-From: William Batista <bootlegbilly@protonmail.ch>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        trivial@kernel.org, William Batista <bootlegbilly@protonmail.ch>
Subject: [PATCH] iwlwifi: renamed all occurrences of IWL_RATE_COUNT to IWL_RATE_INDEX_COUNT
Date:   Sun,  1 Aug 2021 15:18:22 -0400
Message-Id: <20210801191822.152193-1-bootlegbilly@protonmail.ch>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A FIXME requested to eventaully rename IWL_RATE_COUNT to
IWL_RATE_INDEX_COUNT, as it's a more appropriate name.

Signed-off-by: William Batista <bootlegbilly@protonmail.ch>
---
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   | 48 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/dvm/rs.h   | 16 +++----
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  6 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 36 +++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   | 10 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  4 +-
 10 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
index 3b937a7dd..87c64b701 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/lib.c
@@ -89,7 +89,7 @@ int iwlagn_hwrate_to_mac80211_idx(u32 rate_n_flags, enum nl80211_band band)
 	} else {
 		if (band == NL80211_BAND_5GHZ)
 			band_offset = IWL_FIRST_OFDM_RATE;
-		for (idx = band_offset; idx < IWL_RATE_COUNT_LEGACY; idx++)
+		for (idx = band_offset; idx < IWL_RATE_INDEX_COUNT_LEGACY; idx++)
 			if (iwl_rates[idx].plcp == (rate_n_flags & 0xFF))
 				return idx - band_offset;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index 548540dd0..27892c652 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -80,7 +80,7 @@ static const u8 ant_toggle_lookup[] = {
  * maps to IWL_RATE_INVALID
  *
  */
-const struct iwl_rate_info iwl_rates[IWL_RATE_COUNT] = {
+const struct iwl_rate_info iwl_rates[IWL_RATE_INDEX_COUNT] = {
 	IWL_DECLARE_RATE_INFO(1, INV, INV, 2, INV, 2, INV, 2),    /*  1mbps */
 	IWL_DECLARE_RATE_INFO(2, INV, 1, 5, 1, 5, 1, 5),          /*  2mbps */
 	IWL_DECLARE_RATE_INFO(5, INV, 2, 6, 2, 11, 2, 11),        /*5.5mbps */
@@ -162,46 +162,46 @@ static void rs_dbgfs_set_mcs(struct iwl_lq_sta *lq_sta,
  * (2.4 GHz) band.
  */
 
-static const u16 expected_tpt_legacy[IWL_RATE_COUNT] = {
+static const u16 expected_tpt_legacy[IWL_RATE_INDEX_COUNT] = {
 	7, 13, 35, 58, 40, 57, 72, 98, 121, 154, 177, 186, 0
 };
 
-static const u16 expected_tpt_siso20MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_siso20MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0, 42, 0,  76, 102, 124, 159, 183, 193, 202}, /* Norm */
 	{0, 0, 0, 0, 46, 0,  82, 110, 132, 168, 192, 202, 210}, /* SGI */
 	{0, 0, 0, 0, 47, 0,  91, 133, 171, 242, 305, 334, 362}, /* AGG */
 	{0, 0, 0, 0, 52, 0, 101, 145, 187, 264, 330, 361, 390}, /* AGG+SGI */
 };
 
-static const u16 expected_tpt_siso40MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_siso40MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0,  77, 0, 127, 160, 184, 220, 242, 250, 257}, /* Norm */
 	{0, 0, 0, 0,  83, 0, 135, 169, 193, 229, 250, 257, 264}, /* SGI */
 	{0, 0, 0, 0,  94, 0, 177, 249, 313, 423, 512, 550, 586}, /* AGG */
 	{0, 0, 0, 0, 104, 0, 193, 270, 338, 454, 545, 584, 620}, /* AGG+SGI */
 };
 
-static const u16 expected_tpt_mimo2_20MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_mimo2_20MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0,  74, 0, 123, 155, 179, 214, 236, 244, 251}, /* Norm */
 	{0, 0, 0, 0,  81, 0, 131, 164, 188, 223, 243, 251, 257}, /* SGI */
 	{0, 0, 0, 0,  89, 0, 167, 235, 296, 402, 488, 526, 560}, /* AGG */
 	{0, 0, 0, 0,  97, 0, 182, 255, 320, 431, 520, 558, 593}, /* AGG+SGI*/
 };
 
-static const u16 expected_tpt_mimo2_40MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_mimo2_40MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0, 123, 0, 182, 214, 235, 264, 279, 285, 289}, /* Norm */
 	{0, 0, 0, 0, 131, 0, 191, 222, 242, 270, 284, 289, 293}, /* SGI */
 	{0, 0, 0, 0, 171, 0, 305, 410, 496, 634, 731, 771, 805}, /* AGG */
 	{0, 0, 0, 0, 186, 0, 329, 439, 527, 667, 764, 803, 838}, /* AGG+SGI */
 };
 
-static const u16 expected_tpt_mimo3_20MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_mimo3_20MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0,  99, 0, 153, 186, 208, 239, 256, 263, 268}, /* Norm */
 	{0, 0, 0, 0, 106, 0, 162, 194, 215, 246, 262, 268, 273}, /* SGI */
 	{0, 0, 0, 0, 134, 0, 249, 346, 431, 574, 685, 732, 775}, /* AGG */
 	{0, 0, 0, 0, 148, 0, 272, 376, 465, 614, 727, 775, 818}, /* AGG+SGI */
 };
 
-static const u16 expected_tpt_mimo3_40MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_mimo3_40MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0, 152, 0, 211, 239, 255, 279,  290,  294,  297}, /* Norm */
 	{0, 0, 0, 0, 160, 0, 219, 245, 261, 284,  294,  297,  300}, /* SGI */
 	{0, 0, 0, 0, 254, 0, 443, 584, 695, 868,  984, 1030, 1070}, /* AGG */
@@ -209,7 +209,7 @@ static const u16 expected_tpt_mimo3_40MHz[4][IWL_RATE_COUNT] = {
 };
 
 /* mbps, mcs */
-static const struct iwl_rate_mcs_info iwl_rate_mcs[IWL_RATE_COUNT] = {
+static const struct iwl_rate_mcs_info iwl_rate_mcs[IWL_RATE_INDEX_COUNT] = {
 	{  "1", "BPSK DSSS"},
 	{  "2", "QPSK DSSS"},
 	{"5.5", "BPSK CCK"},
@@ -454,7 +454,7 @@ static int rs_collect_tx_data(struct iwl_scale_tbl_info *tbl,
 	static const u64 mask = (((u64)1) << (IWL_RATE_MAX_WINDOW - 1));
 	s32 fail_count, tpt;
 
-	if (scale_index < 0 || scale_index >= IWL_RATE_COUNT)
+	if (scale_index < 0 || scale_index >= IWL_RATE_INDEX_COUNT)
 		return -EINVAL;
 
 	/* Select window for current tx bit rate */
@@ -738,7 +738,7 @@ static u16 rs_get_adjacent_rate(struct iwl_priv *priv, u8 index, u16 rate_mask,
 
 		/* Find the next rate that is in the rate mask */
 		i = index + 1;
-		for (mask = (1 << i); i < IWL_RATE_COUNT; i++, mask <<= 1) {
+		for (mask = (1 << i); i < IWL_RATE_INDEX_COUNT; i++, mask <<= 1) {
 			if (rate_mask & mask) {
 				high = i;
 				break;
@@ -1087,7 +1087,7 @@ static void rs_set_expected_tpt_table(struct iwl_lq_sta *lq_sta,
 				      struct iwl_scale_tbl_info *tbl)
 {
 	/* Used to choose among HT tables */
-	const u16 (*ht_tbl_pointer)[IWL_RATE_COUNT];
+	const u16 (*ht_tbl_pointer)[IWL_RATE_INDEX_COUNT];
 
 	/* Check for invalid LQ type */
 	if (WARN_ON_ONCE(!is_legacy(tbl->lq_type) && !is_Ht(tbl->lq_type))) {
@@ -1403,7 +1403,7 @@ static void rs_move_legacy_other(struct iwl_priv *priv,
 				&(lq_sta->lq_info[(1 - lq_sta->active_tbl)]);
 	struct iwl_rate_scale_data *window = &(tbl->win[index]);
 	u32 sz = (sizeof(struct iwl_scale_tbl_info) -
-		  (sizeof(struct iwl_rate_scale_data) * IWL_RATE_COUNT));
+		  (sizeof(struct iwl_rate_scale_data) * IWL_RATE_INDEX_COUNT));
 	u8 start_action;
 	u8 valid_tx_ant = priv->nvm_data->valid_tx_ant;
 	u8 tx_chains_num = priv->hw_params.tx_chains_num;
@@ -1577,7 +1577,7 @@ static void rs_move_siso_to_other(struct iwl_priv *priv,
 	struct iwl_rate_scale_data *window = &(tbl->win[index]);
 	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 	u32 sz = (sizeof(struct iwl_scale_tbl_info) -
-		  (sizeof(struct iwl_rate_scale_data) * IWL_RATE_COUNT));
+		  (sizeof(struct iwl_rate_scale_data) * IWL_RATE_INDEX_COUNT));
 	u8 start_action;
 	u8 valid_tx_ant = priv->nvm_data->valid_tx_ant;
 	u8 tx_chains_num = priv->hw_params.tx_chains_num;
@@ -1747,7 +1747,7 @@ static void rs_move_mimo2_to_other(struct iwl_priv *priv,
 	struct iwl_rate_scale_data *window = &(tbl->win[index]);
 	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 	u32 sz = (sizeof(struct iwl_scale_tbl_info) -
-		  (sizeof(struct iwl_rate_scale_data) * IWL_RATE_COUNT));
+		  (sizeof(struct iwl_rate_scale_data) * IWL_RATE_INDEX_COUNT));
 	u8 start_action;
 	u8 valid_tx_ant = priv->nvm_data->valid_tx_ant;
 	u8 tx_chains_num = priv->hw_params.tx_chains_num;
@@ -1915,7 +1915,7 @@ static void rs_move_mimo3_to_other(struct iwl_priv *priv,
 	struct iwl_rate_scale_data *window = &(tbl->win[index]);
 	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 	u32 sz = (sizeof(struct iwl_scale_tbl_info) -
-		  (sizeof(struct iwl_rate_scale_data) * IWL_RATE_COUNT));
+		  (sizeof(struct iwl_rate_scale_data) * IWL_RATE_INDEX_COUNT));
 	u8 start_action;
 	u8 valid_tx_ant = priv->nvm_data->valid_tx_ant;
 	u8 tx_chains_num = priv->hw_params.tx_chains_num;
@@ -2140,7 +2140,7 @@ static void rs_stay_in_table(struct iwl_lq_sta *lq_sta, bool force_search)
 				lq_sta->table_count = 0;
 
 				IWL_DEBUG_RATE(priv, "LQ: stay in table clear win\n");
-				for (i = 0; i < IWL_RATE_COUNT; i++)
+				for (i = 0; i < IWL_RATE_INDEX_COUNT; i++)
 					rs_rate_scale_clear_window(
 						&(tbl->win[i]));
 			}
@@ -2150,7 +2150,7 @@ static void rs_stay_in_table(struct iwl_lq_sta *lq_sta, bool force_search)
 		 * bitmaps and stats in active table (this will become the new
 		 * "search" table). */
 		if (!lq_sta->stay_in_tbl) {
-			for (i = 0; i < IWL_RATE_COUNT; i++)
+			for (i = 0; i < IWL_RATE_INDEX_COUNT; i++)
 				rs_rate_scale_clear_window(&(tbl->win[i]));
 		}
 	}
@@ -2557,7 +2557,7 @@ static void rs_rate_scale_perform(struct iwl_priv *priv,
 		if (lq_sta->search_better_tbl) {
 			/* Access the "search" table, clear its history. */
 			tbl = &(lq_sta->lq_info[(1 - lq_sta->active_tbl)]);
-			for (i = 0; i < IWL_RATE_COUNT; i++)
+			for (i = 0; i < IWL_RATE_INDEX_COUNT; i++)
 				rs_rate_scale_clear_window(&(tbl->win[i]));
 
 			/* Use new "search" start rate */
@@ -2657,7 +2657,7 @@ static void rs_initialize_lq(struct iwl_priv *priv,
 
 	tbl = &(lq_sta->lq_info[active_tbl]);
 
-	if ((i < 0) || (i >= IWL_RATE_COUNT))
+	if ((i < 0) || (i >= IWL_RATE_INDEX_COUNT))
 		i = 0;
 
 	rate = iwl_rates[i].plcp;
@@ -2701,7 +2701,7 @@ static void rs_get_rate(void *priv_r, struct ieee80211_sta *sta, void *priv_sta,
 		    (lq_sta->max_rate_idx != -1))
 			lq_sta->max_rate_idx += IWL_FIRST_OFDM_RATE;
 		if ((lq_sta->max_rate_idx < 0) ||
-		    (lq_sta->max_rate_idx >= IWL_RATE_COUNT))
+		    (lq_sta->max_rate_idx >= IWL_RATE_INDEX_COUNT))
 			lq_sta->max_rate_idx = -1;
 	}
 
@@ -2734,7 +2734,7 @@ static void rs_get_rate(void *priv_r, struct ieee80211_sta *sta, void *priv_sta,
 			info->control.rates[0].flags |= IEEE80211_TX_RC_GREEN_FIELD;
 	} else {
 		/* Check for invalid rates */
-		if ((rate_idx < 0) || (rate_idx >= IWL_RATE_COUNT_LEGACY) ||
+		if ((rate_idx < 0) || (rate_idx >= IWL_RATE_INDEX_COUNT_LEGACY) ||
 				((sband->band == NL80211_BAND_5GHZ) &&
 				 (rate_idx < IWL_FIRST_OFDM_RATE)))
 			rate_idx = rate_lowest_index(sband, sta);
@@ -2782,7 +2782,7 @@ void iwl_rs_rate_init(struct iwl_priv *priv, struct ieee80211_sta *sta, u8 sta_i
 	lq_sta->lq.sta_id = sta_id;
 
 	for (j = 0; j < LQ_SIZE; j++)
-		for (i = 0; i < IWL_RATE_COUNT; i++)
+		for (i = 0; i < IWL_RATE_INDEX_COUNT; i++)
 			rs_rate_scale_clear_window(&lq_sta->lq_info[j].win[i]);
 
 	lq_sta->flush_timer = 0;
@@ -3198,7 +3198,7 @@ static ssize_t rs_sta_dbgfs_stats_table_read(struct file *file,
 				lq_sta->lq_info[i].is_dup,
 				lq_sta->is_green,
 				lq_sta->lq_info[i].current_rate);
-		for (j = 0; j < IWL_RATE_COUNT; j++) {
+		for (j = 0; j < IWL_RATE_INDEX_COUNT; j++) {
 			desc += sprintf(buff+desc,
 				"counter=%d success=%d %%=%d\n",
 				lq_sta->lq_info[i].win[j].counter,
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.h b/drivers/net/wireless/intel/iwlwifi/dvm/rs.h
index 68a840d73..70c7f6a72 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.h
@@ -34,7 +34,7 @@ struct iwl_rate_info {
 
 /*
  * These serve as indexes into
- * struct iwl_rate_info iwl_rates[IWL_RATE_COUNT];
+ * struct iwl_rate_info iwl_rates[IWL_RATE_INDEX_COUNT];
  */
 enum {
 	IWL_RATE_1M_INDEX = 0,
@@ -50,10 +50,10 @@ enum {
 	IWL_RATE_48M_INDEX,
 	IWL_RATE_54M_INDEX,
 	IWL_RATE_60M_INDEX,
-	IWL_RATE_COUNT, /*FIXME:RS:change to IWL_RATE_INDEX_COUNT,*/
-	IWL_RATE_COUNT_LEGACY = IWL_RATE_COUNT - 1,	/* Excluding 60M */
-	IWL_RATE_INVM_INDEX = IWL_RATE_COUNT,
-	IWL_RATE_INVALID = IWL_RATE_COUNT,
+	IWL_RATE_INDEX_COUNT,
+	IWL_RATE_INDEX_COUNT_LEGACY = IWL_RATE_INDEX_COUNT - 1,	/* Excluding 60M */
+	IWL_RATE_INVM_INDEX = IWL_RATE_INDEX_COUNT,
+	IWL_RATE_INVALID = IWL_RATE_INDEX_COUNT,
 };
 
 enum {
@@ -161,7 +161,7 @@ enum {
 	IWL_RATE_11M_IEEE = 22,
 };
 
-#define IWL_RATES_MASK ((1 << IWL_RATE_COUNT) - 1)
+#define IWL_RATES_MASK ((1 << IWL_RATE_INDEX_COUNT) - 1)
 
 #define IWL_INVALID_VALUE    -1
 
@@ -246,7 +246,7 @@ enum {
 #define TID_MAX_TIME_DIFF ((TID_QUEUE_MAX_SIZE - 1) * TID_QUEUE_CELL_SPACING)
 #define TIME_WRAP_AROUND(x, y) (((y) > (x)) ? (y) - (x) : (0-(x)) + (y))
 
-extern const struct iwl_rate_info iwl_rates[IWL_RATE_COUNT];
+extern const struct iwl_rate_info iwl_rates[IWL_RATE_INDEX_COUNT];
 
 enum iwl_table_type {
 	LQ_NONE,
@@ -302,7 +302,7 @@ struct iwl_scale_tbl_info {
 	u8 max_search;	/* maximun number of tables we can search */
 	const u16 *expected_tpt;	/* throughput metrics; expected_tpt_G, etc. */
 	u32 current_rate;  /* rate_n_flags, uCode API format */
-	struct iwl_rate_scale_data win[IWL_RATE_COUNT]; /* rate histories */
+	struct iwl_rate_scale_data win[IWL_RATE_INDEX_COUNT]; /* rate histories */
 };
 
 struct iwl_traffic_load {
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 847b8e07f..4f7fdcae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -156,7 +156,7 @@ static void iwlagn_tx_cmd_build_rate(struct iwl_priv *priv,
 	 */
 	rate_idx = info->control.rates[0].idx;
 	if (info->control.rates[0].flags & IEEE80211_TX_RC_MCS ||
-			(rate_idx < 0) || (rate_idx > IWL_RATE_COUNT_LEGACY))
+			(rate_idx < 0) || (rate_idx > IWL_RATE_INDEX_COUNT_LEGACY))
 		rate_idx = rate_lowest_index(
 				&priv->nvm_data->bands[info->band], sta);
 	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index fc2fa49e9..bab35a6d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -186,7 +186,7 @@ struct iwl_tlc_update_notif {
 
 /*
  * These serve as indexes into
- * struct iwl_rate_info fw_rate_idx_to_plcp[IWL_RATE_COUNT];
+ * struct iwl_rate_info fw_rate_idx_to_plcp[IWL_RATE_INDEX_COUNT];
  * TODO: avoid overlap between legacy and HT rates
  */
 enum {
@@ -224,8 +224,8 @@ enum {
 	IWL_RATE_MCS_10_INDEX,
 	IWL_RATE_MCS_11_INDEX,
 	IWL_LAST_HE_RATE = IWL_RATE_MCS_11_INDEX,
-	IWL_RATE_COUNT_LEGACY = IWL_LAST_NON_HT_RATE + 1,
-	IWL_RATE_COUNT = IWL_LAST_HE_RATE + 1,
+	IWL_RATE_INDEX_COUNT_LEGACY = IWL_LAST_NON_HT_RATE + 1,
+	IWL_RATE_INDEX_COUNT = IWL_LAST_HE_RATE + 1,
 };
 
 #define IWL_RATE_BIT_MSK(r) BIT(IWL_RATE_##r##M_INDEX)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index b97708cb8..6c7578cbc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -80,7 +80,7 @@ static const u8 ant_toggle_lookup[] = {
  * maps to IWL_RATE_INVALID
  *
  */
-static const struct iwl_rs_rate_info iwl_rates[IWL_RATE_COUNT] = {
+static const struct iwl_rs_rate_info iwl_rates[IWL_RATE_INDEX_COUNT] = {
 	IWL_DECLARE_RATE_INFO(1, INV, INV, 2),   /*  1mbps */
 	IWL_DECLARE_RATE_INFO(2, INV, 1, 5),     /*  2mbps */
 	IWL_DECLARE_RATE_INFO(5, INV, 2, 11),    /*5.5mbps */
@@ -396,63 +396,63 @@ static void rs_stay_in_table(struct iwl_lq_sta *lq_sta, bool force_search);
  * CCK rates are only valid in legacy table and will only be used in G
  * (2.4 GHz) band.
  */
-static const u16 expected_tpt_legacy[IWL_RATE_COUNT] = {
+static const u16 expected_tpt_legacy[IWL_RATE_INDEX_COUNT] = {
 	7, 13, 35, 58, 40, 57, 72, 98, 121, 154, 177, 186, 0, 0, 0
 };
 
 /* Expected TpT tables. 4 indexes:
  * 0 - NGI, 1 - SGI, 2 - AGG+NGI, 3 - AGG+SGI
  */
-static const u16 expected_tpt_siso_20MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_siso_20MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0, 42, 0,  76, 102, 124, 159, 183, 193, 202, 216, 0},
 	{0, 0, 0, 0, 46, 0,  82, 110, 132, 168, 192, 202, 210, 225, 0},
 	{0, 0, 0, 0, 49, 0,  97, 145, 192, 285, 375, 420, 464, 551, 0},
 	{0, 0, 0, 0, 54, 0, 108, 160, 213, 315, 415, 465, 513, 608, 0},
 };
 
-static const u16 expected_tpt_siso_40MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_siso_40MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0,  77, 0, 127, 160, 184, 220, 242, 250,  257,  269,  275},
 	{0, 0, 0, 0,  83, 0, 135, 169, 193, 229, 250, 257,  264,  275,  280},
 	{0, 0, 0, 0, 101, 0, 199, 295, 389, 570, 744, 828,  911, 1070, 1173},
 	{0, 0, 0, 0, 112, 0, 220, 326, 429, 629, 819, 912, 1000, 1173, 1284},
 };
 
-static const u16 expected_tpt_siso_80MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_siso_80MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0, 130, 0, 191, 223, 244,  273,  288,  294,  298,  305,  308},
 	{0, 0, 0, 0, 138, 0, 200, 231, 251,  279,  293,  298,  302,  308,  312},
 	{0, 0, 0, 0, 217, 0, 429, 634, 834, 1220, 1585, 1760, 1931, 2258, 2466},
 	{0, 0, 0, 0, 241, 0, 475, 701, 921, 1343, 1741, 1931, 2117, 2468, 2691},
 };
 
-static const u16 expected_tpt_siso_160MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_siso_160MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0, 191, 0, 244, 288,  298,  308,  313,  318,  323,  328,  330},
 	{0, 0, 0, 0, 200, 0, 251, 293,  302,  312,  317,  322,  327,  332,  334},
 	{0, 0, 0, 0, 439, 0, 875, 1307, 1736, 2584, 3419, 3831, 4240, 5049, 5581},
 	{0, 0, 0, 0, 488, 0, 972, 1451, 1925, 2864, 3785, 4240, 4691, 5581, 6165},
 };
 
-static const u16 expected_tpt_mimo2_20MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_mimo2_20MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0,  74, 0, 123, 155, 179, 213, 235, 243, 250,  261, 0},
 	{0, 0, 0, 0,  81, 0, 131, 164, 187, 221, 242, 250, 256,  267, 0},
 	{0, 0, 0, 0,  98, 0, 193, 286, 375, 550, 718, 799, 878, 1032, 0},
 	{0, 0, 0, 0, 109, 0, 214, 316, 414, 607, 790, 879, 965, 1132, 0},
 };
 
-static const u16 expected_tpt_mimo2_40MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_mimo2_40MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0, 123, 0, 182, 214, 235,  264,  279,  285,  289,  296,  300},
 	{0, 0, 0, 0, 131, 0, 191, 222, 242,  270,  284,  289,  293,  300,  303},
 	{0, 0, 0, 0, 200, 0, 390, 571, 741, 1067, 1365, 1505, 1640, 1894, 2053},
 	{0, 0, 0, 0, 221, 0, 430, 630, 816, 1169, 1490, 1641, 1784, 2053, 2221},
 };
 
-static const u16 expected_tpt_mimo2_80MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_mimo2_80MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0, 182, 0, 240,  264,  278,  299,  308,  311,  313,  317,  319},
 	{0, 0, 0, 0, 190, 0, 247,  269,  282,  302,  310,  313,  315,  319,  320},
 	{0, 0, 0, 0, 428, 0, 833, 1215, 1577, 2254, 2863, 3147, 3418, 3913, 4219},
 	{0, 0, 0, 0, 474, 0, 920, 1338, 1732, 2464, 3116, 3418, 3705, 4225, 4545},
 };
 
-static const u16 expected_tpt_mimo2_160MHz[4][IWL_RATE_COUNT] = {
+static const u16 expected_tpt_mimo2_160MHz[4][IWL_RATE_INDEX_COUNT] = {
 	{0, 0, 0, 0, 240, 0, 278,  308,  313,  319,  322,  324,  328,  330,   334},
 	{0, 0, 0, 0, 247, 0, 282,  310,  315,  320,  323,  325,  329,  332,   338},
 	{0, 0, 0, 0, 875, 0, 1735, 2582, 3414, 5043, 6619, 7389, 8147, 9629,  10592},
@@ -460,7 +460,7 @@ static const u16 expected_tpt_mimo2_160MHz[4][IWL_RATE_COUNT] = {
 };
 
 /* mbps, mcs */
-static const struct iwl_rate_mcs_info iwl_rate_mcs[IWL_RATE_COUNT] = {
+static const struct iwl_rate_mcs_info iwl_rate_mcs[IWL_RATE_INDEX_COUNT] = {
 	{  "1", "BPSK DSSS"},
 	{  "2", "QPSK DSSS"},
 	{"5.5", "BPSK CCK"},
@@ -586,7 +586,7 @@ static void rs_rate_scale_clear_tbl_windows(struct iwl_mvm *mvm,
 	int i;
 
 	IWL_DEBUG_RATE(mvm, "Clearing up window stats\n");
-	for (i = 0; i < IWL_RATE_COUNT; i++)
+	for (i = 0; i < IWL_RATE_INDEX_COUNT; i++)
 		rs_rate_scale_clear_window(&tbl->win[i]);
 
 	for (i = 0; i < ARRAY_SIZE(tbl->tpc_win); i++)
@@ -794,7 +794,7 @@ static int rs_collect_tlc_data(struct iwl_mvm *mvm,
 {
 	struct iwl_rate_scale_data *window = NULL;
 
-	if (scale_index < 0 || scale_index >= IWL_RATE_COUNT)
+	if (scale_index < 0 || scale_index >= IWL_RATE_INDEX_COUNT)
 		return -EINVAL;
 
 	if (tbl->column != RS_COLUMN_INVALID) {
@@ -1040,7 +1040,7 @@ static u16 rs_get_adjacent_rate(struct iwl_mvm *mvm, u8 index, u16 rate_mask,
 
 		/* Find the next rate that is in the rate mask */
 		i = index + 1;
-		for (mask = (1 << i); i < IWL_RATE_COUNT; i++, mask <<= 1) {
+		for (mask = (1 << i); i < IWL_RATE_INDEX_COUNT; i++, mask <<= 1) {
 			if (rate_mask & mask) {
 				high = i;
 				break;
@@ -1284,7 +1284,7 @@ static const u16 *rs_get_expected_tpt_table(struct iwl_lq_sta *lq_sta,
 					    u32 bw)
 {
 	/* Used to choose among HT tables */
-	const u16 (*ht_tbl_pointer)[IWL_RATE_COUNT];
+	const u16 (*ht_tbl_pointer)[IWL_RATE_INDEX_COUNT];
 
 	if (WARN_ON_ONCE(column->mode != RS_LEGACY &&
 			 column->mode != RS_SISO &&
@@ -3936,7 +3936,7 @@ static ssize_t rs_sta_dbgfs_stats_table_read(struct file *file,
 				is_ht80(rate) ? "80MHz" :
 				is_ht160(rate) ? "160MHz" : "ERR",
 				rate->index);
-		for (j = 0; j < IWL_RATE_COUNT; j++) {
+		for (j = 0; j < IWL_RATE_INDEX_COUNT; j++) {
 			desc += sprintf(buff+desc,
 				"counter=%d success=%d %%=%d\n",
 				tbl->win[j].counter,
@@ -4005,7 +4005,7 @@ static ssize_t rs_sta_dbgfs_drv_tx_stats_read(struct file *file,
 	endpos = pos + bufsz;
 
 	pos += scnprintf(pos, endpos - pos, "COLUMN,");
-	for (rate = 0; rate < IWL_RATE_COUNT; rate++)
+	for (rate = 0; rate < IWL_RATE_INDEX_COUNT; rate++)
 		pos += scnprintf(pos, endpos - pos, "%s,", rate_name[rate]);
 	pos += scnprintf(pos, endpos - pos, "\n");
 
@@ -4013,7 +4013,7 @@ static ssize_t rs_sta_dbgfs_drv_tx_stats_read(struct file *file,
 		pos += scnprintf(pos, endpos - pos,
 				 "%s,", column_name[col]);
 
-		for (rate = 0; rate < IWL_RATE_COUNT; rate++) {
+		for (rate = 0; rate < IWL_RATE_INDEX_COUNT; rate++) {
 			stats = &(lq_sta->pers.tx_stats[col][rate]);
 			pos += scnprintf(pos, endpos - pos,
 					 "%llu/%llu,",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 32104c9f8..88698d322 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -37,8 +37,8 @@ struct iwl_rs_rate_info {
 #define IWL_RATE_60M_PLCP 3
 
 enum {
-	IWL_RATE_INVM_INDEX = IWL_RATE_COUNT,
-	IWL_RATE_INVALID = IWL_RATE_COUNT,
+	IWL_RATE_INVM_INDEX = IWL_RATE_INDEX_COUNT,
+	IWL_RATE_INVALID = IWL_RATE_INDEX_COUNT,
 };
 
 #define LINK_QUAL_MAX_RETRY_NUM 16
@@ -123,7 +123,7 @@ enum {
 	IWL_RATE_HT_MIMO2_MCS_9_PLCP = IWL_RATE_HT_SISO_MCS_INV_PLCP,
 };
 
-#define IWL_RATES_MASK ((1 << IWL_RATE_COUNT) - 1)
+#define IWL_RATES_MASK ((1 << IWL_RATE_INDEX_COUNT) - 1)
 
 #define IWL_INVALID_VALUE    -1
 
@@ -302,7 +302,7 @@ struct iwl_scale_tbl_info {
 	struct rs_rate rate;
 	enum rs_column column;
 	const u16 *expected_tpt;	/* throughput metrics; expected_tpt_G, etc. */
-	struct iwl_rate_scale_data win[IWL_RATE_COUNT]; /* rate histories */
+	struct iwl_rate_scale_data win[IWL_RATE_INDEX_COUNT]; /* rate histories */
 	/* per txpower-reduction history */
 	struct iwl_rate_scale_data tpc_win[TPC_MAX_REDUCTION + 1];
 };
@@ -388,7 +388,7 @@ struct iwl_lq_sta {
 		u8 chains;
 		s8 chain_signal[IEEE80211_MAX_CHAINS];
 		s8 last_rssi;
-		struct rs_rate_stats tx_stats[RS_COLUMN_COUNT][IWL_RATE_COUNT];
+		struct rs_rate_stats tx_stats[RS_COLUMN_COUNT][IWL_RATE_INDEX_COUNT];
 		struct iwl_mvm *drv;
 		spinlock_t lock; /* for races in reinit/update table */
 	} pers;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 0368b7101..3272ca8a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1009,7 +1009,7 @@ static int iwl_mvm_scan_lmac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 static int rate_to_scan_rate_flag(unsigned int rate)
 {
-	static const int rate_to_scan_rate[IWL_RATE_COUNT] = {
+	static const int rate_to_scan_rate[IWL_RATE_INDEX_COUNT] = {
 		[IWL_RATE_1M_INDEX]	= SCAN_CONFIG_RATE_1M,
 		[IWL_RATE_2M_INDEX]	= SCAN_CONFIG_RATE_2M,
 		[IWL_RATE_5M_INDEX]	= SCAN_CONFIG_RATE_5M,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 0a13c2bda..437b469b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -284,7 +284,7 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 	}
 
 	/* if the rate isn't a well known legacy rate, take the lowest one */
-	if (rate_idx < 0 || rate_idx >= IWL_RATE_COUNT_LEGACY)
+	if (rate_idx < 0 || rate_idx >= IWL_RATE_INDEX_COUNT_LEGACY)
 		rate_idx = rate_lowest_index(
 				&mvm->nvm_data->bands[info->band], sta);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 4a3d2971a..d276cf12b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -141,7 +141,7 @@ int iwl_mvm_send_cmd_pdu_status(struct iwl_mvm *mvm, u32 id, u16 len,
 /*
  * Translate from fw_rate_index (IWL_RATE_XXM_INDEX) to PLCP
  */
-static const u8 fw_rate_idx_to_plcp[IWL_RATE_COUNT] = {
+static const u8 fw_rate_idx_to_plcp[IWL_RATE_INDEX_COUNT] = {
 	IWL_DECLARE_RATE_INFO(1),
 	IWL_DECLARE_RATE_INFO(2),
 	IWL_DECLARE_RATE_INFO(5),
@@ -166,7 +166,7 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 	/* Legacy rate format, search for match in table */
 	if (band != NL80211_BAND_2GHZ)
 		band_offset = IWL_FIRST_OFDM_RATE;
-	for (idx = band_offset; idx < IWL_RATE_COUNT_LEGACY; idx++)
+	for (idx = band_offset; idx < IWL_RATE_INDEX_COUNT_LEGACY; idx++)
 		if (fw_rate_idx_to_plcp[idx] == rate)
 			return idx - band_offset;
 
-- 
2.32.0

