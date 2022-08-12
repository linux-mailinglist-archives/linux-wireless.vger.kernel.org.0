Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7461659139C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiHLQLN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbiHLQK6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0542A5719
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E6276158A
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FC7C433C1;
        Fri, 12 Aug 2022 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320649;
        bh=QKa8RYa36A8wmj6F+CjEmfOj91FQm0VR5sYv4dES3Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ef2YjPBaFD09h0VgSwqcDbELNrdP6vH9p4bpLL1pGwejW6eKQJWSKoyTU5MevEIyd
         1vJTX0Sjsr/9/4fSg3l/YsjiaKwl+MMN65EfXpAmeOZVuDNng47qNVKeIvtV4tQBRd
         j0nUW9quSPWiwqRpjBv68gqJziqbWYNqN1f9pyJL0QYqcDLva/Yd9w1PQEzL+XVArS
         m/dYAFTHo2T7YPWhxMEk7xGqILjYqsMr0NuTkwWRLkTZiYpWhh8pFKeqLDLiQvTkPS
         qwY0umK6sPHwszSkFOabk6S1TXLO53GEi3lkn9TqdNcmbT1sP4Z0LJYD4efj5Fs2hf
         4LK6a84Les+Iw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 41/50] wifi: ath12k: add reg.c
Date:   Fri, 12 Aug 2022 19:09:54 +0300
Message-Id: <20220812161003.27279-42-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812161003.27279-1-kvalo@kernel.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 732 ++++++++++++++++++++++++++++++++++
 1 file changed, 732 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
new file mode 100644
index 000000000000..6ede91ebc8e1
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -0,0 +1,732 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/rtnetlink.h>
+#include "core.h"
+#include "debug.h"
+
+/* World regdom to be used in case default regd from fw is unavailable */
+#define ATH12K_2GHZ_CH01_11      REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0)
+#define ATH12K_5GHZ_5150_5350    REG_RULE(5150 - 10, 5350 + 10, 80, 0, 30,\
+					  NL80211_RRF_NO_IR)
+#define ATH12K_5GHZ_5725_5850    REG_RULE(5725 - 10, 5850 + 10, 80, 0, 30,\
+					  NL80211_RRF_NO_IR)
+
+#define ETSI_WEATHER_RADAR_BAND_LOW		5590
+#define ETSI_WEATHER_RADAR_BAND_HIGH		5650
+#define ETSI_WEATHER_RADAR_BAND_CAC_TIMEOUT	600000
+
+static const struct ieee80211_regdomain ath12k_world_regd = {
+	.n_reg_rules = 3,
+	.alpha2 = "00",
+	.reg_rules = {
+		ATH12K_2GHZ_CH01_11,
+		ATH12K_5GHZ_5150_5350,
+		ATH12K_5GHZ_5725_5850,
+	}
+};
+
+static bool ath12k_regdom_changes(struct ath12k *ar, char *alpha2)
+{
+	const struct ieee80211_regdomain *regd;
+
+	regd = rcu_dereference_rtnl(ar->hw->wiphy->regd);
+	/* This can happen during wiphy registration where the previous
+	 * user request is received before we update the regd received
+	 * from firmware.
+	 */
+	if (!regd)
+		return true;
+
+	return memcmp(regd->alpha2, alpha2, 2) != 0;
+}
+
+static void
+ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct ath12k_wmi_init_country_arg arg;
+	struct ath12k *ar = hw->priv;
+	int ret;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+		   "Regulatory Notification received for %s\n", wiphy_name(wiphy));
+
+	/* Currently supporting only General User Hints. Cell base user
+	 * hints to be handled later.
+	 * Hints from other sources like Core, Beacons are not expected for
+	 * self managed wiphy's
+	 */
+	if (!(request->initiator == NL80211_REGDOM_SET_BY_USER &&
+	      request->user_reg_hint_type == NL80211_USER_REG_HINT_USER)) {
+		ath12k_warn(ar->ab, "Unexpected Regulatory event for this wiphy\n");
+		return;
+	}
+
+	if (!IS_ENABLED(CONFIG_ATH_REG_DYNAMIC_USER_REG_HINTS)) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+			   "Country Setting is not allowed\n");
+		return;
+	}
+
+	if (!ath12k_regdom_changes(ar, request->alpha2)) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_REG, "Country is already set\n");
+		return;
+	}
+
+	/* Set the country code to the firmware and wait for
+	 * the WMI_REG_CHAN_LIST_CC EVENT for updating the
+	 * reg info
+	 */
+	arg.flags = ALPHA_IS_SET;
+	memcpy(&arg.cc_info.alpha2, request->alpha2, 2);
+	arg.cc_info.alpha2[2] = 0;
+
+	ret = ath12k_wmi_send_init_country_cmd(ar, &arg);
+	if (ret)
+		ath12k_warn(ar->ab,
+			    "INIT Country code set to fw failed : %d\n", ret);
+}
+
+int ath12k_reg_update_chan_list(struct ath12k *ar)
+{
+	struct ieee80211_supported_band **bands;
+	struct ath12k_wmi_scan_chan_list_arg *arg;
+	struct ieee80211_channel *channel;
+	struct ieee80211_hw *hw = ar->hw;
+	struct ath12k_wmi_channel_arg *ch;
+	enum nl80211_band band;
+	int num_channels = 0;
+	int i, ret;
+
+	bands = hw->wiphy->bands;
+	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		if (!bands[band])
+			continue;
+
+		for (i = 0; i < bands[band]->n_channels; i++) {
+			if (bands[band]->channels[i].flags &
+			    IEEE80211_CHAN_DISABLED)
+				continue;
+
+			num_channels++;
+		}
+	}
+
+	if (WARN_ON(!num_channels))
+		return -EINVAL;
+
+	arg = kzalloc(struct_size(arg, channel, num_channels), GFP_KERNEL);
+
+	if (!arg)
+		return -ENOMEM;
+
+	arg->pdev_id = ar->pdev->pdev_id;
+	arg->nallchans = num_channels;
+
+	ch = arg->channel;
+
+	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		if (!bands[band])
+			continue;
+
+		for (i = 0; i < bands[band]->n_channels; i++) {
+			channel = &bands[band]->channels[i];
+
+			if (channel->flags & IEEE80211_CHAN_DISABLED)
+				continue;
+
+			/* TODO: Set to true/false based on some condition? */
+			ch->allow_ht = true;
+			ch->allow_vht = true;
+			ch->allow_he = true;
+
+			ch->dfs_set =
+				!!(channel->flags & IEEE80211_CHAN_RADAR);
+			ch->is_chan_passive = !!(channel->flags &
+						IEEE80211_CHAN_NO_IR);
+			ch->is_chan_passive |= ch->dfs_set;
+			ch->mhz = channel->center_freq;
+			ch->cfreq1 = channel->center_freq;
+			ch->minpower = 0;
+			ch->maxpower = channel->max_power * 2;
+			ch->maxregpower = channel->max_reg_power * 2;
+			ch->antennamax = channel->max_antenna_gain * 2;
+
+			/* TODO: Use appropriate phymodes */
+			if (channel->band == NL80211_BAND_2GHZ)
+				ch->phy_mode = MODE_11G;
+			else
+				ch->phy_mode = MODE_11A;
+
+			if (channel->band == NL80211_BAND_6GHZ &&
+			    cfg80211_channel_is_psc(channel))
+				ch->psc_channel = true;
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+				   "mac channel [%d/%d] freq %d maxpower %d regpower %d antenna %d mode %d\n",
+				   i, arg->nallchans,
+				   ch->mhz, ch->maxpower, ch->maxregpower,
+				   ch->antennamax, ch->phy_mode);
+
+			ch++;
+			/* TODO: use quarrter/half rate, cfreq12, dfs_cfreq2
+			 * set_agile, reg_class_idx
+			 */
+		}
+	}
+
+	ret = ath12k_wmi_send_scan_chan_list_cmd(ar, arg);
+	kfree(arg);
+
+	return ret;
+}
+
+static void ath12k_copy_regd(struct ieee80211_regdomain *regd_orig,
+			     struct ieee80211_regdomain *regd_copy)
+{
+	u8 i;
+
+	/* The caller should have checked error conditions */
+	memcpy(regd_copy, regd_orig, sizeof(*regd_orig));
+
+	for (i = 0; i < regd_orig->n_reg_rules; i++)
+		memcpy(&regd_copy->reg_rules[i], &regd_orig->reg_rules[i],
+		       sizeof(struct ieee80211_reg_rule));
+}
+
+int ath12k_regd_update(struct ath12k *ar, bool init)
+{
+	struct ieee80211_regdomain *regd, *regd_copy = NULL;
+	int ret, regd_len, pdev_id;
+	struct ath12k_base *ab;
+
+	ab = ar->ab;
+	pdev_id = ar->pdev_idx;
+
+	spin_lock_bh(&ab->base_lock);
+
+	if (init) {
+		/* Apply the regd received during init through
+		 * WMI_REG_CHAN_LIST_CC event. In case of failure to
+		 * receive the regd, initialize with a default world
+		 * regulatory.
+		 */
+		if (ab->default_regd[pdev_id]) {
+			regd = ab->default_regd[pdev_id];
+		} else {
+			ath12k_warn(ab,
+				    "failed to receive default regd during init\n");
+			regd = (struct ieee80211_regdomain *)&ath12k_world_regd;
+		}
+	} else {
+		regd = ab->new_regd[pdev_id];
+	}
+
+	if (!regd) {
+		ret = -EINVAL;
+		spin_unlock_bh(&ab->base_lock);
+		goto err;
+	}
+
+	regd_len = sizeof(*regd) + (regd->n_reg_rules *
+		sizeof(struct ieee80211_reg_rule));
+
+	regd_copy = kzalloc(regd_len, GFP_ATOMIC);
+	if (regd_copy)
+		ath12k_copy_regd(regd, regd_copy);
+
+	spin_unlock_bh(&ab->base_lock);
+
+	if (!regd_copy) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	rtnl_lock();
+	wiphy_lock(ar->hw->wiphy);
+	ret = regulatory_set_wiphy_regd_sync(ar->hw->wiphy, regd_copy);
+	wiphy_unlock(ar->hw->wiphy);
+	rtnl_unlock();
+
+	kfree(regd_copy);
+
+	if (ret)
+		goto err;
+
+	if (ar->state == ATH12K_STATE_ON) {
+		ret = ath12k_reg_update_chan_list(ar);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+err:
+	ath12k_warn(ab, "failed to perform regd update : %d\n", ret);
+	return ret;
+}
+
+static enum nl80211_dfs_regions
+ath12k_map_fw_dfs_region(enum ath12k_dfs_region dfs_region)
+{
+	switch (dfs_region) {
+	case ATH12K_DFS_REG_FCC:
+	case ATH12K_DFS_REG_CN:
+		return NL80211_DFS_FCC;
+	case ATH12K_DFS_REG_ETSI:
+	case ATH12K_DFS_REG_KR:
+		return NL80211_DFS_ETSI;
+	case ATH12K_DFS_REG_MKK:
+	case ATH12K_DFS_REG_MKK_N:
+		return NL80211_DFS_JP;
+	default:
+		return NL80211_DFS_UNSET;
+	}
+}
+
+static u32 ath12k_map_fw_reg_flags(u16 reg_flags)
+{
+	u32 flags = 0;
+
+	if (reg_flags & REGULATORY_CHAN_NO_IR)
+		flags = NL80211_RRF_NO_IR;
+
+	if (reg_flags & REGULATORY_CHAN_RADAR)
+		flags |= NL80211_RRF_DFS;
+
+	if (reg_flags & REGULATORY_CHAN_NO_OFDM)
+		flags |= NL80211_RRF_NO_OFDM;
+
+	if (reg_flags & REGULATORY_CHAN_INDOOR_ONLY)
+		flags |= NL80211_RRF_NO_OUTDOOR;
+
+	if (reg_flags & REGULATORY_CHAN_NO_HT40)
+		flags |= NL80211_RRF_NO_HT40;
+
+	if (reg_flags & REGULATORY_CHAN_NO_80MHZ)
+		flags |= NL80211_RRF_NO_80MHZ;
+
+	if (reg_flags & REGULATORY_CHAN_NO_160MHZ)
+		flags |= NL80211_RRF_NO_160MHZ;
+
+	return flags;
+}
+
+static bool
+ath12k_reg_can_intersect(struct ieee80211_reg_rule *rule1,
+			 struct ieee80211_reg_rule *rule2)
+{
+	u32 start_freq1, end_freq1;
+	u32 start_freq2, end_freq2;
+
+	start_freq1 = rule1->freq_range.start_freq_khz;
+	start_freq2 = rule2->freq_range.start_freq_khz;
+
+	end_freq1 = rule1->freq_range.end_freq_khz;
+	end_freq2 = rule2->freq_range.end_freq_khz;
+
+	if ((start_freq1 >= start_freq2 &&
+	     start_freq1 < end_freq2) ||
+	    (start_freq2 > start_freq1 &&
+	     start_freq2 < end_freq1))
+		return true;
+
+	/* TODO: Should we restrict intersection feasibility
+	 *  based on min bandwidth of the intersected region also,
+	 *  say the intersected rule should have a  min bandwidth
+	 * of 20MHz?
+	 */
+
+	return false;
+}
+
+static void ath12k_reg_intersect_rules(struct ieee80211_reg_rule *rule1,
+				       struct ieee80211_reg_rule *rule2,
+				       struct ieee80211_reg_rule *new_rule)
+{
+	u32 start_freq1, end_freq1;
+	u32 start_freq2, end_freq2;
+	u32 freq_diff, max_bw;
+
+	start_freq1 = rule1->freq_range.start_freq_khz;
+	start_freq2 = rule2->freq_range.start_freq_khz;
+
+	end_freq1 = rule1->freq_range.end_freq_khz;
+	end_freq2 = rule2->freq_range.end_freq_khz;
+
+	new_rule->freq_range.start_freq_khz = max_t(u32, start_freq1,
+						    start_freq2);
+	new_rule->freq_range.end_freq_khz = min_t(u32, end_freq1, end_freq2);
+
+	freq_diff = new_rule->freq_range.end_freq_khz -
+			new_rule->freq_range.start_freq_khz;
+	max_bw = min_t(u32, rule1->freq_range.max_bandwidth_khz,
+		       rule2->freq_range.max_bandwidth_khz);
+	new_rule->freq_range.max_bandwidth_khz = min_t(u32, max_bw, freq_diff);
+
+	new_rule->power_rule.max_antenna_gain =
+		min_t(u32, rule1->power_rule.max_antenna_gain,
+		      rule2->power_rule.max_antenna_gain);
+
+	new_rule->power_rule.max_eirp = min_t(u32, rule1->power_rule.max_eirp,
+					      rule2->power_rule.max_eirp);
+
+	/* Use the flags of both the rules */
+	new_rule->flags = rule1->flags | rule2->flags;
+
+	/* To be safe, lts use the max cac timeout of both rules */
+	new_rule->dfs_cac_ms = max_t(u32, rule1->dfs_cac_ms,
+				     rule2->dfs_cac_ms);
+}
+
+static struct ieee80211_regdomain *
+ath12k_regd_intersect(struct ieee80211_regdomain *default_regd,
+		      struct ieee80211_regdomain *curr_regd)
+{
+	u8 num_old_regd_rules, num_curr_regd_rules, num_new_regd_rules;
+	struct ieee80211_reg_rule *old_rule, *curr_rule, *new_rule;
+	struct ieee80211_regdomain *new_regd = NULL;
+	u8 i, j, k;
+
+	num_old_regd_rules = default_regd->n_reg_rules;
+	num_curr_regd_rules = curr_regd->n_reg_rules;
+	num_new_regd_rules = 0;
+
+	/* Find the number of intersecting rules to allocate new regd memory */
+	for (i = 0; i < num_old_regd_rules; i++) {
+		old_rule = default_regd->reg_rules + i;
+		for (j = 0; j < num_curr_regd_rules; j++) {
+			curr_rule = curr_regd->reg_rules + j;
+
+			if (ath12k_reg_can_intersect(old_rule, curr_rule))
+				num_new_regd_rules++;
+		}
+	}
+
+	if (!num_new_regd_rules)
+		return NULL;
+
+	new_regd = kzalloc(sizeof(*new_regd) + (num_new_regd_rules *
+			sizeof(struct ieee80211_reg_rule)),
+			GFP_ATOMIC);
+
+	if (!new_regd)
+		return NULL;
+
+	/* We set the new country and dfs region directly and only trim
+	 * the freq, power, antenna gain by intersecting with the
+	 * default regdomain. Also MAX of the dfs cac timeout is selected.
+	 */
+	new_regd->n_reg_rules = num_new_regd_rules;
+	memcpy(new_regd->alpha2, curr_regd->alpha2, sizeof(new_regd->alpha2));
+	new_regd->dfs_region = curr_regd->dfs_region;
+	new_rule = new_regd->reg_rules;
+
+	for (i = 0, k = 0; i < num_old_regd_rules; i++) {
+		old_rule = default_regd->reg_rules + i;
+		for (j = 0; j < num_curr_regd_rules; j++) {
+			curr_rule = curr_regd->reg_rules + j;
+
+			if (ath12k_reg_can_intersect(old_rule, curr_rule))
+				ath12k_reg_intersect_rules(old_rule, curr_rule,
+							   (new_rule + k++));
+		}
+	}
+	return new_regd;
+}
+
+static const char *
+ath12k_reg_get_regdom_str(enum nl80211_dfs_regions dfs_region)
+{
+	switch (dfs_region) {
+	case NL80211_DFS_FCC:
+		return "FCC";
+	case NL80211_DFS_ETSI:
+		return "ETSI";
+	case NL80211_DFS_JP:
+		return "JP";
+	default:
+		return "UNSET";
+	}
+}
+
+static u16
+ath12k_reg_adjust_bw(u16 start_freq, u16 end_freq, u16 max_bw)
+{
+	u16 bw;
+
+	bw = end_freq - start_freq;
+	bw = min_t(u16, bw, max_bw);
+
+	if (bw >= 80 && bw < 160)
+		bw = 80;
+	else if (bw >= 40 && bw < 80)
+		bw = 40;
+	else if (bw < 40)
+		bw = 20;
+
+	return bw;
+}
+
+static void
+ath12k_reg_update_rule(struct ieee80211_reg_rule *reg_rule, u32 start_freq,
+		       u32 end_freq, u32 bw, u32 ant_gain, u32 reg_pwr,
+		       u32 reg_flags)
+{
+	reg_rule->freq_range.start_freq_khz = MHZ_TO_KHZ(start_freq);
+	reg_rule->freq_range.end_freq_khz = MHZ_TO_KHZ(end_freq);
+	reg_rule->freq_range.max_bandwidth_khz = MHZ_TO_KHZ(bw);
+	reg_rule->power_rule.max_antenna_gain = DBI_TO_MBI(ant_gain);
+	reg_rule->power_rule.max_eirp = DBM_TO_MBM(reg_pwr);
+	reg_rule->flags = reg_flags;
+}
+
+static void
+ath12k_reg_update_weather_radar_band(struct ath12k_base *ab,
+				     struct ieee80211_regdomain *regd,
+				     struct ath12k_reg_rule *reg_rule,
+				     u8 *rule_idx, u32 flags, u16 max_bw)
+{
+	u32 end_freq;
+	u16 bw;
+	u8 i;
+
+	i = *rule_idx;
+
+	bw = ath12k_reg_adjust_bw(reg_rule->start_freq,
+				  ETSI_WEATHER_RADAR_BAND_LOW, max_bw);
+
+	ath12k_reg_update_rule(regd->reg_rules + i, reg_rule->start_freq,
+			       ETSI_WEATHER_RADAR_BAND_LOW, bw,
+			       reg_rule->ant_gain, reg_rule->reg_power,
+			       flags);
+
+	ath12k_dbg(ab, ATH12K_DBG_REG,
+		   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
+		   i + 1, reg_rule->start_freq, ETSI_WEATHER_RADAR_BAND_LOW,
+		   bw, reg_rule->ant_gain, reg_rule->reg_power,
+		   regd->reg_rules[i].dfs_cac_ms,
+		   flags);
+
+	if (reg_rule->end_freq > ETSI_WEATHER_RADAR_BAND_HIGH)
+		end_freq = ETSI_WEATHER_RADAR_BAND_HIGH;
+	else
+		end_freq = reg_rule->end_freq;
+
+	bw = ath12k_reg_adjust_bw(ETSI_WEATHER_RADAR_BAND_LOW, end_freq,
+				  max_bw);
+
+	i++;
+
+	ath12k_reg_update_rule(regd->reg_rules + i,
+			       ETSI_WEATHER_RADAR_BAND_LOW, end_freq, bw,
+			       reg_rule->ant_gain, reg_rule->reg_power,
+			       flags);
+
+	regd->reg_rules[i].dfs_cac_ms = ETSI_WEATHER_RADAR_BAND_CAC_TIMEOUT;
+
+	ath12k_dbg(ab, ATH12K_DBG_REG,
+		   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
+		   i + 1, ETSI_WEATHER_RADAR_BAND_LOW, end_freq,
+		   bw, reg_rule->ant_gain, reg_rule->reg_power,
+		   regd->reg_rules[i].dfs_cac_ms,
+		   flags);
+
+	if (end_freq == reg_rule->end_freq) {
+		regd->n_reg_rules--;
+		*rule_idx = i;
+		return;
+	}
+
+	bw = ath12k_reg_adjust_bw(ETSI_WEATHER_RADAR_BAND_HIGH,
+				  reg_rule->end_freq, max_bw);
+
+	i++;
+
+	ath12k_reg_update_rule(regd->reg_rules + i, ETSI_WEATHER_RADAR_BAND_HIGH,
+			       reg_rule->end_freq, bw,
+			       reg_rule->ant_gain, reg_rule->reg_power,
+			       flags);
+
+	ath12k_dbg(ab, ATH12K_DBG_REG,
+		   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
+		   i + 1, ETSI_WEATHER_RADAR_BAND_HIGH, reg_rule->end_freq,
+		   bw, reg_rule->ant_gain, reg_rule->reg_power,
+		   regd->reg_rules[i].dfs_cac_ms,
+		   flags);
+
+	*rule_idx = i;
+}
+
+struct ieee80211_regdomain *
+ath12k_reg_build_regd(struct ath12k_base *ab,
+		      struct ath12k_reg_info *reg_info, bool intersect)
+{
+	struct ieee80211_regdomain *tmp_regd, *default_regd, *new_regd = NULL;
+	struct ath12k_reg_rule *reg_rule;
+	u8 i = 0, j = 0, k = 0;
+	u8 num_rules;
+	u16 max_bw;
+	u32 flags;
+	char alpha2[3];
+
+	num_rules = reg_info->num_5g_reg_rules + reg_info->num_2g_reg_rules;
+
+	/* FIXME: Currently taking reg rules for 6G only from Indoor AP mode list.
+	 * This can be updated to choose the combination dynamically based on AP
+	 * type and client type, after complete 6G regulatory support is added.
+	 */
+	if (reg_info->is_ext_reg_event)
+		num_rules += reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP];
+
+	if (!num_rules)
+		goto ret;
+
+	/* Add max additional rules to accommodate weather radar band */
+	if (reg_info->dfs_region == ATH12K_DFS_REG_ETSI)
+		num_rules += 2;
+
+	tmp_regd = kzalloc(sizeof(*tmp_regd) +
+			   (num_rules * sizeof(struct ieee80211_reg_rule)),
+			   GFP_ATOMIC);
+	if (!tmp_regd)
+		goto ret;
+
+	memcpy(tmp_regd->alpha2, reg_info->alpha2, REG_ALPHA2_LEN + 1);
+	memcpy(alpha2, reg_info->alpha2, REG_ALPHA2_LEN + 1);
+	alpha2[2] = '\0';
+	tmp_regd->dfs_region = ath12k_map_fw_dfs_region(reg_info->dfs_region);
+
+	ath12k_dbg(ab, ATH12K_DBG_REG,
+		   "\r\nCountry %s, CFG Regdomain %s FW Regdomain %d, num_reg_rules %d\n",
+		   alpha2, ath12k_reg_get_regdom_str(tmp_regd->dfs_region),
+		   reg_info->dfs_region, num_rules);
+	/* Update reg_rules[] below. Firmware is expected to
+	 * send these rules in order(2G rules first and then 5G)
+	 */
+	for (; i < num_rules; i++) {
+		if (reg_info->num_2g_reg_rules &&
+		    (i < reg_info->num_2g_reg_rules)) {
+			reg_rule = reg_info->reg_rules_2g_ptr + i;
+			max_bw = min_t(u16, reg_rule->max_bw,
+				       reg_info->max_bw_2g);
+			flags = 0;
+		} else if (reg_info->num_5g_reg_rules &&
+			   (j < reg_info->num_5g_reg_rules)) {
+			reg_rule = reg_info->reg_rules_5g_ptr + j++;
+			max_bw = min_t(u16, reg_rule->max_bw,
+				       reg_info->max_bw_5g);
+
+			/* FW doesn't pass NL80211_RRF_AUTO_BW flag for
+			 * BW Auto correction, we can enable this by default
+			 * for all 5G rules here. The regulatory core performs
+			 * BW correction if required and applies flags as
+			 * per other BW rule flags we pass from here
+			 */
+			flags = NL80211_RRF_AUTO_BW;
+		} else if (reg_info->is_ext_reg_event &&
+			   reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP] &&
+			(k < reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP])) {
+			reg_rule = reg_info->reg_rules_6g_ap_ptr[WMI_REG_INDOOR_AP] + k++;
+			max_bw = min_t(u16, reg_rule->max_bw,
+				       reg_info->max_bw_6g_ap[WMI_REG_INDOOR_AP]);
+			flags = NL80211_RRF_AUTO_BW;
+		} else {
+			break;
+		}
+
+		flags |= ath12k_map_fw_reg_flags(reg_rule->flags);
+
+		ath12k_reg_update_rule(tmp_regd->reg_rules + i,
+				       reg_rule->start_freq,
+				       reg_rule->end_freq, max_bw,
+				       reg_rule->ant_gain, reg_rule->reg_power,
+				       flags);
+
+		/* Update dfs cac timeout if the dfs domain is ETSI and the
+		 * new rule covers weather radar band.
+		 * Default value of '0' corresponds to 60s timeout, so no
+		 * need to update that for other rules.
+		 */
+		if (flags & NL80211_RRF_DFS &&
+		    reg_info->dfs_region == ATH12K_DFS_REG_ETSI &&
+		    (reg_rule->end_freq > ETSI_WEATHER_RADAR_BAND_LOW &&
+		    reg_rule->start_freq < ETSI_WEATHER_RADAR_BAND_HIGH)){
+			ath12k_reg_update_weather_radar_band(ab, tmp_regd,
+							     reg_rule, &i,
+							     flags, max_bw);
+			continue;
+		}
+
+		if (reg_info->is_ext_reg_event) {
+			ath12k_dbg(ab, ATH12K_DBG_REG, "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d) (%d, %d)\n",
+				   i + 1, reg_rule->start_freq, reg_rule->end_freq,
+				   max_bw, reg_rule->ant_gain, reg_rule->reg_power,
+				   tmp_regd->reg_rules[i].dfs_cac_ms,
+				   flags, reg_rule->psd_flag, reg_rule->psd_eirp);
+		} else {
+			ath12k_dbg(ab, ATH12K_DBG_REG,
+				   "\t%d. (%d - %d @ %d) (%d, %d) (%d ms) (FLAGS %d)\n",
+				   i + 1, reg_rule->start_freq, reg_rule->end_freq,
+				   max_bw, reg_rule->ant_gain, reg_rule->reg_power,
+				   tmp_regd->reg_rules[i].dfs_cac_ms,
+				   flags);
+		}
+	}
+
+	tmp_regd->n_reg_rules = i;
+
+	if (intersect) {
+		default_regd = ab->default_regd[reg_info->phy_id];
+
+		/* Get a new regd by intersecting the received regd with
+		 * our default regd.
+		 */
+		new_regd = ath12k_regd_intersect(default_regd, tmp_regd);
+		kfree(tmp_regd);
+		if (!new_regd) {
+			ath12k_warn(ab, "Unable to create intersected regdomain\n");
+			goto ret;
+		}
+	} else {
+		new_regd = tmp_regd;
+	}
+
+ret:
+	return new_regd;
+}
+
+void ath12k_regd_update_work(struct work_struct *work)
+{
+	struct ath12k *ar = container_of(work, struct ath12k,
+					 regd_update_work);
+	int ret;
+
+	ret = ath12k_regd_update(ar, false);
+	if (ret) {
+		/* Firmware has already moved to the new regd. We need
+		 * to maintain channel consistency across FW, Host driver
+		 * and userspace. Hence as a fallback mechanism we can set
+		 * the prev or default country code to the firmware.
+		 */
+		/* TODO: Implement Fallback Mechanism */
+	}
+}
+
+void ath12k_reg_init(struct ath12k *ar)
+{
+	ar->hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
+	ar->hw->wiphy->reg_notifier = ath12k_reg_notifier;
+}
+
+void ath12k_reg_free(struct ath12k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < ab->hw_params->max_radios; i++) {
+		kfree(ab->default_regd[i]);
+		kfree(ab->new_regd[i]);
+	}
+}

