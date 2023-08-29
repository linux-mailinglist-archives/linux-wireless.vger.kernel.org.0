Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC878C22E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 12:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjH2KSP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 06:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjH2KSJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 06:18:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA29ECF1
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BGri6jaygC1ILH5orTu1JZp6MdXwusl2RDVFe9Mpu08=;
        t=1693304268; x=1694513868; b=lloJHqUKZ1UBxdTQOlmoNwjyTkZlIXQAS6BlS2qfKXQwHdY
        VYmTNPpgNU6hpk8BiaV5c/DAHWHqkDPvPknpm73Lyv4rFV8MWCWtS7NPesoj470rn0dlOVBAhMQOK
        triFjidX/xydNvAn4xTK3erq8zCnajsT0sym0KFRb1JMC88wDKrFHItBzfQyRdJobKlzLbqynE70D
        Oz2IghmsBshLwjQ6emWxeLfSe+CllaKKimPWv+rqZ9WSYurPc14JWRAFq1lvqE6J9vYdZILvo+7Po
        aDtbR7njDNDYMXEWNU6D7P6QDtz8x+sp9sQ87dCcMElFlCshcb2vgZHiHqE+ekPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qavn8-000zlu-1y;
        Tue, 29 Aug 2023 12:17:46 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: remove shifted rate support
Date:   Tue, 29 Aug 2023 12:17:44 +0200
Message-ID: <20230829121742.619d3ad12057.I633603421b24c59f31dc7cec7d105ba5d155f657@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829121742.634a0631eaf3.I38b5dcce8b130f93743a2d43ab9d89269b937b5d@changeid>
References: <20230829121742.634a0631eaf3.I38b5dcce8b130f93743a2d43ab9d89269b937b5d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We really cannot even get into this as we can't have
a BSS with a 5/10 MHz (scan) width, and therefore all
the code handling shifted rates cannot happen. Remove
it all, since it's broken anyway, at least with MLO.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/airtime.c             |  8 ++-
 net/mac80211/cfg.c                 |  8 +--
 net/mac80211/ibss.c                | 13 ++---
 net/mac80211/ieee80211_i.h         | 39 +--------------
 net/mac80211/mlme.c                | 18 +++----
 net/mac80211/rc80211_minstrel_ht.c |  7 ++-
 net/mac80211/status.c              | 12 ++---
 net/mac80211/tx.c                  | 20 +++-----
 net/mac80211/util.c                | 79 +++++++++---------------------
 9 files changed, 53 insertions(+), 151 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index e8ebd343e2bf..14be7b526f1d 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -632,7 +632,7 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 {
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_chanctx_conf *conf;
-	int rateidx, shift = 0;
+	int rateidx;
 	bool cck, short_pream;
 	u32 basic_rates;
 	u8 band = 0;
@@ -641,10 +641,8 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 	len += 38; /* Ethernet header length */
 
 	conf = rcu_dereference(vif->bss_conf.chanctx_conf);
-	if (conf) {
+	if (conf)
 		band = conf->def.chan->band;
-		shift = ieee80211_chandef_get_shift(&conf->def);
-	}
 
 	if (pubsta) {
 		struct sta_info *sta = container_of(pubsta, struct sta_info,
@@ -704,7 +702,7 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 	short_pream = vif->bss_conf.use_short_preamble;
 
 	rateidx = basic_rates ? ffs(basic_rates) - 1 : 0;
-	rate = sband->bitrates[rateidx].bitrate << shift;
+	rate = sband->bitrates[rateidx].bitrate;
 	cck = sband->bitrates[rateidx].flags & IEEE80211_RATE_MANDATORY_B;
 
 	return ieee80211_calc_legacy_rate_duration(rate, short_pream, cck, len);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 851d6ed68367..0dd4a95982e3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -810,15 +810,11 @@ void sta_set_rate_info_tx(struct sta_info *sta,
 		rinfo->nss = ieee80211_rate_get_vht_nss(rate);
 	} else {
 		struct ieee80211_supported_band *sband;
-		int shift = ieee80211_vif_get_shift(&sta->sdata->vif);
-		u16 brate;
 
 		sband = ieee80211_get_sband(sta->sdata);
 		WARN_ON_ONCE(sband && !sband->bitrates);
-		if (sband && sband->bitrates) {
-			brate = sband->bitrates[rate->idx].bitrate;
-			rinfo->legacy = DIV_ROUND_UP(brate, 1 << shift);
-		}
+		if (sband && sband->bitrates)
+			rinfo->legacy = sband->bitrates[rate->idx].bitrate;
 	}
 	if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
 		rinfo->bw = RATE_INFO_BW_40;
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 55ec34602b53..a7736acadf3c 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -51,7 +51,6 @@ ieee80211_ibss_build_presp(struct ieee80211_sub_if_data *sdata,
 	u32 rate_flags, rates = 0, rates_added = 0;
 	struct beacon_data *presp;
 	int frame_len;
-	int shift;
 
 	/* Build IBSS probe response */
 	frame_len = sizeof(struct ieee80211_hdr_3addr) +
@@ -92,7 +91,6 @@ ieee80211_ibss_build_presp(struct ieee80211_sub_if_data *sdata,
 
 	sband = local->hw.wiphy->bands[chandef->chan->band];
 	rate_flags = ieee80211_chandef_rate_flags(chandef);
-	shift = ieee80211_chandef_get_shift(chandef);
 	rates_n = 0;
 	if (have_higher_than_11mbit)
 		*have_higher_than_11mbit = false;
@@ -111,8 +109,7 @@ ieee80211_ibss_build_presp(struct ieee80211_sub_if_data *sdata,
 	*pos++ = WLAN_EID_SUPP_RATES;
 	*pos++ = min_t(int, 8, rates_n);
 	for (ri = 0; ri < sband->n_bitrates; ri++) {
-		int rate = DIV_ROUND_UP(sband->bitrates[ri].bitrate,
-					5 * (1 << shift));
+		int rate = DIV_ROUND_UP(sband->bitrates[ri].bitrate, 5);
 		u8 basic = 0;
 		if (!(rates & BIT(ri)))
 			continue;
@@ -155,8 +152,7 @@ ieee80211_ibss_build_presp(struct ieee80211_sub_if_data *sdata,
 		*pos++ = WLAN_EID_EXT_SUPP_RATES;
 		*pos++ = rates_n - 8;
 		for (; ri < sband->n_bitrates; ri++) {
-			int rate = DIV_ROUND_UP(sband->bitrates[ri].bitrate,
-						5 * (1 << shift));
+			int rate = DIV_ROUND_UP(sband->bitrates[ri].bitrate, 5);
 			u8 basic = 0;
 			if (!(rates & BIT(ri)))
 				continue;
@@ -399,7 +395,6 @@ static void ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_channel_type chan_type;
 	u64 tsf;
 	u32 rate_flags;
-	int shift;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -434,7 +429,6 @@ static void ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 
 	sband = sdata->local->hw.wiphy->bands[cbss->channel->band];
 	rate_flags = ieee80211_chandef_rate_flags(&sdata->u.ibss.chandef);
-	shift = ieee80211_vif_get_shift(&sdata->vif);
 
 	basic_rates = 0;
 
@@ -448,8 +442,7 @@ static void ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 			    != rate_flags)
 				continue;
 
-			brate = DIV_ROUND_UP(sband->bitrates[j].bitrate,
-					     5 * (1 << shift));
+			brate = DIV_ROUND_UP(sband->bitrates[j].bitrate, 5);
 			if (brate == rate) {
 				if (is_basic)
 					basic_rates |= BIT(j);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0e20627ba60e..e963050412da 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1138,40 +1138,6 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 #define sdata_dereference(p, sdata) \
 	wiphy_dereference(sdata->local->hw.wiphy, p)
 
-static inline int
-ieee80211_chanwidth_get_shift(enum nl80211_chan_width width)
-{
-	switch (width) {
-	case NL80211_CHAN_WIDTH_5:
-		return 2;
-	case NL80211_CHAN_WIDTH_10:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
-static inline int
-ieee80211_chandef_get_shift(struct cfg80211_chan_def *chandef)
-{
-	return ieee80211_chanwidth_get_shift(chandef->width);
-}
-
-static inline int
-ieee80211_vif_get_shift(struct ieee80211_vif *vif)
-{
-	struct ieee80211_chanctx_conf *chanctx_conf;
-	int shift = 0;
-
-	rcu_read_lock();
-	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
-	if (chanctx_conf)
-		shift = ieee80211_chandef_get_shift(&chanctx_conf->def);
-	rcu_read_unlock();
-
-	return shift;
-}
-
 static inline int
 ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems,
 				struct cfg80211_rnr_elems *rnr_elems,
@@ -2038,7 +2004,7 @@ struct sk_buff *
 ieee80211_build_data_template(struct ieee80211_sub_if_data *sdata,
 			      struct sk_buff *skb, u32 info_flags);
 void ieee80211_tx_monitor(struct ieee80211_local *local, struct sk_buff *skb,
-			  int retry_count, int shift, bool send_to_cooked,
+			  int retry_count, bool send_to_cooked,
 			  struct ieee80211_tx_status *status);
 
 void ieee80211_check_fast_xmit(struct sta_info *sta);
@@ -2211,8 +2177,7 @@ static inline int __ieee80211_resume(struct ieee80211_hw *hw)
 /* utility functions/constants */
 extern const void *const mac80211_wiphy_privid; /* for wiphy privid */
 int ieee80211_frame_duration(enum nl80211_band band, size_t len,
-			     int rate, int erp, int short_preamble,
-			     int shift);
+			     int rate, int erp, int short_preamble);
 void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
 					   struct ieee80211_tx_queue_params *qparam,
 					   int ac);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6d0a29749e8c..154a09e4cba5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -829,7 +829,6 @@ static void ieee80211_assoc_add_rates(struct sk_buff *skb,
 				      struct ieee80211_supported_band *sband,
 				      struct ieee80211_mgd_assoc_data *assoc_data)
 {
-	unsigned int shift = ieee80211_chanwidth_get_shift(width);
 	unsigned int rates_len, supp_rates_len;
 	u32 rates = 0;
 	int i, count;
@@ -868,8 +867,7 @@ static void ieee80211_assoc_add_rates(struct sk_buff *skb,
 	count = 0;
 	for (i = 0; i < sband->n_bitrates; i++) {
 		if (BIT(i) & rates) {
-			int rate = DIV_ROUND_UP(sband->bitrates[i].bitrate,
-						5 * (1 << shift));
+			int rate = DIV_ROUND_UP(sband->bitrates[i].bitrate, 5);
 			*pos++ = (u8)rate;
 			if (++count == 8)
 				break;
@@ -885,8 +883,7 @@ static void ieee80211_assoc_add_rates(struct sk_buff *skb,
 			if (BIT(i) & rates) {
 				int rate;
 
-				rate = DIV_ROUND_UP(sband->bitrates[i].bitrate,
-						    5 * (1 << shift));
+				rate = DIV_ROUND_UP(sband->bitrates[i].bitrate, 5);
 				*pos++ = (u8)rate;
 			}
 		}
@@ -3847,8 +3844,7 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 				u8 *supp_rates, unsigned int supp_rates_len,
 				u32 *rates, u32 *basic_rates,
 				bool *have_higher_than_11mbit,
-				int *min_rate, int *min_rate_index,
-				int shift)
+				int *min_rate, int *min_rate_index)
 {
 	int i, j;
 
@@ -3856,7 +3852,7 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 		int rate = supp_rates[i] & 0x7f;
 		bool is_basic = !!(supp_rates[i] & 0x80);
 
-		if ((rate * 5 * (1 << shift)) > 110)
+		if ((rate * 5) > 110)
 			*have_higher_than_11mbit = true;
 
 		/*
@@ -3880,7 +3876,7 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 
 			br = &sband->bitrates[j];
 
-			brate = DIV_ROUND_UP(br->bitrate, (1 << shift) * 5);
+			brate = DIV_ROUND_UP(br->bitrate, 5);
 			if (brate == rate) {
 				*rates |= BIT(j);
 				if (is_basic)
@@ -4324,8 +4320,6 @@ static int ieee80211_mgd_setup_link_sta(struct ieee80211_link_data *link,
 	u32 rates = 0, basic_rates = 0;
 	bool have_higher_than_11mbit = false;
 	int min_rate = INT_MAX, min_rate_index = -1;
-	/* this is clearly wrong for MLO but we'll just remove it later */
-	int shift = ieee80211_vif_get_shift(&sdata->vif);
 	struct ieee80211_supported_band *sband;
 
 	memcpy(link_sta->addr, cbss->bssid, ETH_ALEN);
@@ -4341,7 +4335,7 @@ static int ieee80211_mgd_setup_link_sta(struct ieee80211_link_data *link,
 
 	ieee80211_get_rates(sband, bss->supp_rates, bss->supp_rates_len,
 			    &rates, &basic_rates, &have_higher_than_11mbit,
-			    &min_rate, &min_rate_index, shift);
+			    &min_rate, &min_rate_index);
 
 	/*
 	 * This used to be a workaround for basic rates missing
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index b34c80522047..6bf3b4444a43 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1725,16 +1725,15 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 	mi->band = sband->band;
 	mi->last_stats_update = jiffies;
 
-	ack_dur = ieee80211_frame_duration(sband->band, 10, 60, 1, 1, 0);
-	mi->overhead = ieee80211_frame_duration(sband->band, 0, 60, 1, 1, 0);
+	ack_dur = ieee80211_frame_duration(sband->band, 10, 60, 1, 1);
+	mi->overhead = ieee80211_frame_duration(sband->band, 0, 60, 1, 1);
 	mi->overhead += ack_dur;
 	mi->overhead_rtscts = mi->overhead + 2 * ack_dur;
 
 	ctl_rate = &sband->bitrates[rate_lowest_index(sband, sta)];
 	erp = ctl_rate->flags & IEEE80211_RATE_ERP_G;
 	ack_dur = ieee80211_frame_duration(sband->band, 10,
-					   ctl_rate->bitrate, erp, 1,
-					   ieee80211_chandef_get_shift(chandef));
+					   ctl_rate->bitrate, erp, 1);
 	mi->overhead_legacy = ack_dur;
 	mi->overhead_legacy_rtscts = mi->overhead_legacy + 2 * ack_dur;
 
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 3355e66d96d8..f67eafada741 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -256,7 +256,7 @@ static int ieee80211_tx_radiotap_len(struct ieee80211_tx_info *info,
 static void
 ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 				 struct sk_buff *skb, int retry_count,
-				 int rtap_len, int shift,
+				 int rtap_len,
 				 struct ieee80211_tx_status *status)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -307,7 +307,7 @@ ieee80211_add_tx_radiotap_header(struct ieee80211_local *local,
 
 	if (legacy_rate) {
 		rthdr->it_present |= cpu_to_le32(BIT(IEEE80211_RADIOTAP_RATE));
-		*pos = DIV_ROUND_UP(legacy_rate, 5 * (1 << shift));
+		*pos = DIV_ROUND_UP(legacy_rate, 5);
 		/* padding for tx flags */
 		pos += 2;
 	}
@@ -878,7 +878,7 @@ static int ieee80211_tx_get_rates(struct ieee80211_hw *hw,
 }
 
 void ieee80211_tx_monitor(struct ieee80211_local *local, struct sk_buff *skb,
-			  int retry_count, int shift, bool send_to_cooked,
+			  int retry_count, bool send_to_cooked,
 			  struct ieee80211_tx_status *status)
 {
 	struct sk_buff *skb2;
@@ -895,7 +895,7 @@ void ieee80211_tx_monitor(struct ieee80211_local *local, struct sk_buff *skb,
 		return;
 	}
 	ieee80211_add_tx_radiotap_header(local, skb, retry_count,
-					 rtap_len, shift, status);
+					 rtap_len, status);
 
 	/* XXX: is this sufficient for BPF? */
 	skb_reset_mac_header(skb);
@@ -948,14 +948,12 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	bool acked;
 	bool noack_success;
 	struct ieee80211_bar *bar;
-	int shift = 0;
 	int tid = IEEE80211_NUM_TIDS;
 
 	fc = hdr->frame_control;
 
 	if (status->sta) {
 		sta = container_of(status->sta, struct sta_info, sta);
-		shift = ieee80211_vif_get_shift(&sta->sdata->vif);
 
 		if (info->flags & IEEE80211_TX_STATUS_EOSP)
 			clear_sta_flag(sta, WLAN_STA_SP);
@@ -1093,7 +1091,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	}
 
 	/* send to monitor interfaces */
-	ieee80211_tx_monitor(local, skb, retry_count, shift,
+	ieee80211_tx_monitor(local, skb, retry_count,
 			     send_to_cooked, status);
 }
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d30b9f204d1b..9b845fbf923c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -43,7 +43,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 				 struct sk_buff *skb, int group_addr,
 				 int next_frag_len)
 {
-	int rate, mrate, erp, dur, i, shift = 0;
+	int rate, mrate, erp, dur, i;
 	struct ieee80211_rate *txrate;
 	struct ieee80211_local *local = tx->local;
 	struct ieee80211_supported_band *sband;
@@ -58,10 +58,8 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 
 	rcu_read_lock();
 	chanctx_conf = rcu_dereference(tx->sdata->vif.bss_conf.chanctx_conf);
-	if (chanctx_conf) {
-		shift = ieee80211_chandef_get_shift(&chanctx_conf->def);
+	if (chanctx_conf)
 		rate_flags = ieee80211_chandef_rate_flags(&chanctx_conf->def);
-	}
 	rcu_read_unlock();
 
 	/* uh huh? */
@@ -143,7 +141,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 			continue;
 
 		if (tx->sdata->vif.bss_conf.basic_rates & BIT(i))
-			rate = DIV_ROUND_UP(r->bitrate, 1 << shift);
+			rate = r->bitrate;
 
 		switch (sband->band) {
 		case NL80211_BAND_2GHZ:
@@ -173,7 +171,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 	if (rate == -1) {
 		/* No matching basic rate found; use highest suitable mandatory
 		 * PHY rate */
-		rate = DIV_ROUND_UP(mrate, 1 << shift);
+		rate = mrate;
 	}
 
 	/* Don't calculate ACKs for QoS Frames with NoAck Policy set */
@@ -185,8 +183,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 		 * (10 bytes + 4-byte FCS = 112 bits) plus SIFS; rounded up
 		 * to closest integer */
 		dur = ieee80211_frame_duration(sband->band, 10, rate, erp,
-				tx->sdata->vif.bss_conf.use_short_preamble,
-				shift);
+				tx->sdata->vif.bss_conf.use_short_preamble);
 
 	if (next_frag_len) {
 		/* Frame is fragmented: duration increases with time needed to
@@ -195,8 +192,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 		/* next fragment */
 		dur += ieee80211_frame_duration(sband->band, next_frag_len,
 				txrate->bitrate, erp,
-				tx->sdata->vif.bss_conf.use_short_preamble,
-				shift);
+				tx->sdata->vif.bss_conf.use_short_preamble);
 	}
 
 	return cpu_to_le16(dur);
@@ -5556,7 +5552,6 @@ struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
 						     IEEE80211_INCLUDE_ALL_MBSSID_ELEMS,
 						     NULL);
 	struct sk_buff *copy;
-	int shift;
 
 	if (!bcn)
 		return bcn;
@@ -5576,8 +5571,7 @@ struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
 	if (!copy)
 		return bcn;
 
-	shift = ieee80211_vif_get_shift(vif);
-	ieee80211_tx_monitor(hw_to_local(hw), copy, 1, shift, false, NULL);
+	ieee80211_tx_monitor(hw_to_local(hw), copy, 1, false, NULL);
 
 	return bcn;
 }
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 4aefb9483aa9..57e4d2561abc 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -109,8 +109,7 @@ void ieee80211_tx_set_protected(struct ieee80211_tx_data *tx)
 }
 
 int ieee80211_frame_duration(enum nl80211_band band, size_t len,
-			     int rate, int erp, int short_preamble,
-			     int shift)
+			     int rate, int erp, int short_preamble)
 {
 	int dur;
 
@@ -121,9 +120,6 @@ int ieee80211_frame_duration(enum nl80211_band band, size_t len,
 	 *
 	 * rate is in 100 kbps, so divident is multiplied by 10 in the
 	 * DIV_ROUND_UP() operations.
-	 *
-	 * shift may be 2 for 5 MHz channels or 1 for 10 MHz channels, and
-	 * is assumed to be 0 otherwise.
 	 */
 
 	if (band == NL80211_BAND_5GHZ || erp) {
@@ -144,12 +140,6 @@ int ieee80211_frame_duration(enum nl80211_band band, size_t len,
 		dur += 16; /* IEEE 802.11-2012 18.3.2.4: T_PREAMBLE = 16 usec */
 		dur += 4; /* IEEE 802.11-2012 18.3.2.4: T_SIGNAL = 4 usec */
 
-		/* IEEE 802.11-2012 18.3.2.4: all values above are:
-		 *  * times 4 for 5 MHz
-		 *  * times 2 for 10 MHz
-		 */
-		dur *= 1 << shift;
-
 		/* rates should already consider the channel bandwidth,
 		 * don't apply divisor again.
 		 */
@@ -184,7 +174,7 @@ __le16 ieee80211_generic_frame_duration(struct ieee80211_hw *hw,
 {
 	struct ieee80211_sub_if_data *sdata;
 	u16 dur;
-	int erp, shift = 0;
+	int erp;
 	bool short_preamble = false;
 
 	erp = 0;
@@ -193,11 +183,10 @@ __le16 ieee80211_generic_frame_duration(struct ieee80211_hw *hw,
 		short_preamble = sdata->vif.bss_conf.use_short_preamble;
 		if (sdata->deflink.operating_11g_mode)
 			erp = rate->flags & IEEE80211_RATE_ERP_G;
-		shift = ieee80211_vif_get_shift(vif);
 	}
 
 	dur = ieee80211_frame_duration(band, frame_len, rate->bitrate, erp,
-				       short_preamble, shift);
+				       short_preamble);
 
 	return cpu_to_le16(dur);
 }
@@ -211,7 +200,7 @@ __le16 ieee80211_rts_duration(struct ieee80211_hw *hw,
 	struct ieee80211_rate *rate;
 	struct ieee80211_sub_if_data *sdata;
 	bool short_preamble;
-	int erp, shift = 0, bitrate;
+	int erp, bitrate;
 	u16 dur;
 	struct ieee80211_supported_band *sband;
 
@@ -227,20 +216,19 @@ __le16 ieee80211_rts_duration(struct ieee80211_hw *hw,
 		short_preamble = sdata->vif.bss_conf.use_short_preamble;
 		if (sdata->deflink.operating_11g_mode)
 			erp = rate->flags & IEEE80211_RATE_ERP_G;
-		shift = ieee80211_vif_get_shift(vif);
 	}
 
-	bitrate = DIV_ROUND_UP(rate->bitrate, 1 << shift);
+	bitrate = rate->bitrate;
 
 	/* CTS duration */
 	dur = ieee80211_frame_duration(sband->band, 10, bitrate,
-				       erp, short_preamble, shift);
+				       erp, short_preamble);
 	/* Data frame duration */
 	dur += ieee80211_frame_duration(sband->band, frame_len, bitrate,
-					erp, short_preamble, shift);
+					erp, short_preamble);
 	/* ACK duration */
 	dur += ieee80211_frame_duration(sband->band, 10, bitrate,
-					erp, short_preamble, shift);
+					erp, short_preamble);
 
 	return cpu_to_le16(dur);
 }
@@ -255,7 +243,7 @@ __le16 ieee80211_ctstoself_duration(struct ieee80211_hw *hw,
 	struct ieee80211_rate *rate;
 	struct ieee80211_sub_if_data *sdata;
 	bool short_preamble;
-	int erp, shift = 0, bitrate;
+	int erp, bitrate;
 	u16 dur;
 	struct ieee80211_supported_band *sband;
 
@@ -270,18 +258,17 @@ __le16 ieee80211_ctstoself_duration(struct ieee80211_hw *hw,
 		short_preamble = sdata->vif.bss_conf.use_short_preamble;
 		if (sdata->deflink.operating_11g_mode)
 			erp = rate->flags & IEEE80211_RATE_ERP_G;
-		shift = ieee80211_vif_get_shift(vif);
 	}
 
-	bitrate = DIV_ROUND_UP(rate->bitrate, 1 << shift);
+	bitrate = rate->bitrate;
 
 	/* Data frame duration */
 	dur = ieee80211_frame_duration(sband->band, frame_len, bitrate,
-				       erp, short_preamble, shift);
+				       erp, short_preamble);
 	if (!(frame_txctl->flags & IEEE80211_TX_CTL_NO_ACK)) {
 		/* ACK duration */
 		dur += ieee80211_frame_duration(sband->band, 10, bitrate,
-						erp, short_preamble, shift);
+						erp, short_preamble);
 	}
 
 	return cpu_to_le16(dur);
@@ -1942,7 +1929,6 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	u8 rates[32];
 	int num_rates;
 	int ext_rates_len;
-	int shift;
 	u32 rate_flags;
 	bool have_80mhz = false;
 
@@ -1953,7 +1939,6 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 		return 0;
 
 	rate_flags = ieee80211_chandef_rate_flags(chandef);
-	shift = ieee80211_chandef_get_shift(chandef);
 
 	/* For direct scan add S1G IE and consider its override bits */
 	if (band == NL80211_BAND_S1GHZ) {
@@ -1971,8 +1956,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 			continue;
 
 		rates[num_rates++] =
-			(u8) DIV_ROUND_UP(sband->bitrates[i].bitrate,
-					  (1 << shift) * 5);
+			(u8) DIV_ROUND_UP(sband->bitrates[i].bitrate, 5);
 	}
 
 	supp_rates_len = min_t(int, num_rates, 8);
@@ -2265,14 +2249,13 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_supported_band *sband;
 	size_t num_rates;
 	u32 supp_rates, rate_flags;
-	int i, j, shift;
+	int i, j;
 
 	sband = sdata->local->hw.wiphy->bands[band];
 	if (WARN_ON(!sband))
 		return 1;
 
 	rate_flags = ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chandef);
-	shift = ieee80211_vif_get_shift(&sdata->vif);
 
 	num_rates = sband->n_bitrates;
 	supp_rates = 0;
@@ -2298,8 +2281,7 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if_data *sdata,
 			    != rate_flags)
 				continue;
 
-			brate = DIV_ROUND_UP(sband->bitrates[j].bitrate,
-					     1 << shift);
+			brate = sband->bitrates[j].bitrate;
 
 			if (brate == own_rate) {
 				supp_rates |= BIT(j);
@@ -3996,7 +3978,6 @@ int ieee80211_parse_bitrates(enum nl80211_chan_width width,
 			     const u8 *srates, int srates_len, u32 *rates)
 {
 	u32 rate_flags = ieee80211_chanwidth_rate_flags(width);
-	int shift = ieee80211_chanwidth_get_shift(width);
 	struct ieee80211_rate *br;
 	int brate, rate, i, j, count = 0;
 
@@ -4010,7 +3991,7 @@ int ieee80211_parse_bitrates(enum nl80211_chan_width width,
 			if ((rate_flags & br->flags) != rate_flags)
 				continue;
 
-			brate = DIV_ROUND_UP(br->bitrate, (1 << shift) * 5);
+			brate = DIV_ROUND_UP(br->bitrate, 5);
 			if (brate == rate) {
 				*rates |= BIT(j);
 				count++;
@@ -4027,12 +4008,11 @@ int ieee80211_add_srates_ie(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
-	int rate, shift;
+	int rate;
 	u8 i, rates, *pos;
 	u32 basic_rates = sdata->vif.bss_conf.basic_rates;
 	u32 rate_flags;
 
-	shift = ieee80211_vif_get_shift(&sdata->vif);
 	rate_flags = ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chandef);
 	sband = local->hw.wiphy->bands[band];
 	rates = 0;
@@ -4057,8 +4037,7 @@ int ieee80211_add_srates_ie(struct ieee80211_sub_if_data *sdata,
 
 		if (need_basic && basic_rates & BIT(i))
 			basic = 0x80;
-		rate = DIV_ROUND_UP(sband->bitrates[i].bitrate,
-				    5 * (1 << shift));
+		rate = DIV_ROUND_UP(sband->bitrates[i].bitrate, 5);
 		*pos++ = basic | (u8) rate;
 	}
 
@@ -4071,13 +4050,12 @@ int ieee80211_add_ext_srates_ie(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
-	int rate, shift;
+	int rate;
 	u8 i, exrates, *pos;
 	u32 basic_rates = sdata->vif.bss_conf.basic_rates;
 	u32 rate_flags;
 
 	rate_flags = ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chandef);
-	shift = ieee80211_vif_get_shift(&sdata->vif);
 
 	sband = local->hw.wiphy->bands[band];
 	exrates = 0;
@@ -4106,8 +4084,7 @@ int ieee80211_add_ext_srates_ie(struct ieee80211_sub_if_data *sdata,
 				continue;
 			if (need_basic && basic_rates & BIT(i))
 				basic = 0x80;
-			rate = DIV_ROUND_UP(sband->bitrates[i].bitrate,
-					    5 * (1 << shift));
+			rate = DIV_ROUND_UP(sband->bitrates[i].bitrate, 5);
 			*pos++ = basic | (u8) rate;
 		}
 	}
@@ -4266,25 +4243,13 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 		fallthrough;
 	case RX_ENC_LEGACY: {
 		struct ieee80211_supported_band *sband;
-		int shift = 0;
-		int bitrate;
-
-		switch (status->bw) {
-		case RATE_INFO_BW_10:
-			shift = 1;
-			break;
-		case RATE_INFO_BW_5:
-			shift = 2;
-			break;
-		}
 
 		sband = local->hw.wiphy->bands[status->band];
-		bitrate = sband->bitrates[status->rate_idx].bitrate;
-		ri.legacy = DIV_ROUND_UP(bitrate, (1 << shift));
+		ri.legacy = sband->bitrates[status->rate_idx].bitrate;
 
 		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
 			if (status->band == NL80211_BAND_5GHZ) {
-				ts += 20 << shift;
+				ts += 20;
 				mpdu_offset += 2;
 			} else if (status->enc_flags & RX_ENC_FLAG_SHORTPRE) {
 				ts += 96;
-- 
2.41.0

