Return-Path: <linux-wireless+bounces-12840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FED977BA8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C0E1C246AC
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B231714CD;
	Fri, 13 Sep 2024 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="oxNgHfH9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5841AD256
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217773; cv=none; b=lKfpetr3yjoPFQFQ50XhSkGjtmRLl/wFq1y6bPhzH5fDpAzbOlKq3NMpt+hKcaJ46sHesk9/5NOC5laqessb26myk02cnjoAlQt4hq9In8n8Ko9EILKyFTWHwWn/vFNbaqkiP0q4t2Doh8PRKSKq9XQ0T0dgjuFAjqqPeZKfML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217773; c=relaxed/simple;
	bh=465zN9RxtMzGUMxr6/bGR9tHwxtKZRLIVQiou/J98Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+6mCsmOO6kWFl+BousnUbbIfQojV35HZABJf26S4rIR7JZAJINT3kP1pRrudZo6wTpFrHlsr6exy5ty6OLHsB0xJTEZmu/Ei5pmuD4R3CvPU6uJuBobpRl1mDB2WAtBfGxmpRn6BrfND9bxQdwdiCrtch/ccTkrXh5A3bEBBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=oxNgHfH9; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id 2545165AB3
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 11:50:08 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:3b2:0:640:ff71:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 30D6A60B46;
	Fri, 13 Sep 2024 11:50:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wngYhHEOcCg0-5Ln9wqoP;
	Fri, 13 Sep 2024 11:49:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1726217399; bh=ui4U3v5zw5FNb6uHCsSmagK4rhRACcOmwVpu24Xtxik=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=oxNgHfH9BEbAeuri5VeI/TbWwRVVApWjwg2oaVOz04a8OpTSwvoINBBAnH1xC9A5c
	 Dc2WIiqQ1GppQPx7cyQZeBxrLuHlzSGpp50B3rSrbWmJEBDVVYU/lECej5E8BFx9sF
	 atmjsbJdptWjzxpEYMQkRpxB3dn9z/gq3QxgMtxI=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2] wifi: mac80211, cfg80211: miscellaneous spelling fixes
Date: Fri, 13 Sep 2024 11:49:19 +0300
Message-ID: <20240913084919.118862-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <a5f94700f09cc9eab7f01d63f699586de65a935d.camel@sipsolutions.net>
References: <a5f94700f09cc9eab7f01d63f699586de65a935d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling here and there as suggested by codespell.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: s/complaints/compliance by Johannes
---
 net/mac80211/agg-tx.c              | 2 +-
 net/mac80211/chan.c                | 4 ++--
 net/mac80211/ieee80211_i.h         | 2 +-
 net/mac80211/mesh.c                | 2 +-
 net/mac80211/mesh_plink.c          | 2 +-
 net/mac80211/mesh_sync.c           | 2 +-
 net/mac80211/rc80211_minstrel_ht.c | 2 +-
 net/mac80211/sta_info.h            | 2 +-
 net/mac80211/tkip.c                | 2 +-
 net/mac80211/tx.c                  | 2 +-
 net/mac80211/util.c                | 2 +-
 net/mac80211/vht.c                 | 4 ++--
 net/wireless/chan.c                | 2 +-
 net/wireless/nl80211.c             | 4 ++--
 net/wireless/radiotap.c            | 2 +-
 net/wireless/reg.c                 | 2 +-
 net/wireless/util.c                | 2 +-
 net/wireless/wext-compat.c         | 2 +-
 net/wireless/wext-core.c           | 2 +-
 19 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 1c18b862ef8c..04cb45cfb310 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -797,7 +797,7 @@ void ieee80211_start_tx_ba_cb(struct sta_info *sta, int tid,
 
 	if (!test_bit(HT_AGG_STATE_SENT_ADDBA, &tid_tx->state)) {
 		ieee80211_send_addba_with_timeout(sta, tid_tx);
-		/* RESPONSE_RECEIVED state whould trigger the flow again */
+		/* RESPONSE_RECEIVED state would trigger the flow again */
 		return;
 	}
 
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index cca6d14084d2..a155e418d26b 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -462,7 +462,7 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 				continue;
 
 			/* vif changed to narrow BW and narrow BW for station wasn't
-			 * requested or vise versa */
+			 * requested or vice versa */
 			if ((new_sta_bw < link_sta->pub->bandwidth) == !narrowed)
 				continue;
 
@@ -1118,7 +1118,7 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 		 *
 		 * Consider ctx1..3, link1..6, each ctx has 2 links. link1 and
 		 * link2 from ctx1 request new different chandefs starting 2
-		 * in-place reserations with ctx4 and ctx5 replacing ctx1 and
+		 * in-place reservations with ctx4 and ctx5 replacing ctx1 and
 		 * ctx2 respectively. Next link5 and link6 from ctx3 reserve
 		 * ctx4. If link3 and link4 remain on ctx2 as they are then this
 		 * fails unless `replace_ctx` from ctx5 is replaced with ctx3.
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4f0390918b60..269f51dd543e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2452,7 +2452,7 @@ static inline bool ieee80211_can_run_worker(struct ieee80211_local *local)
 	/*
 	 * If quiescing is set, we are racing with __ieee80211_suspend.
 	 * __ieee80211_suspend flushes the workers after setting quiescing,
-	 * and we check quiescing / suspended before enqueing new workers.
+	 * and we check quiescing / suspended before enqueuing new workers.
 	 * We should abort the worker to avoid the races below.
 	 */
 	if (local->quiescing)
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index f94e4be0be12..0460102c8796 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1482,7 +1482,7 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 	if (!elems)
 		return;
 
-	/* ignore non-mesh or secure / unsecure mismatch */
+	/* ignore non-mesh or secure / insecure mismatch */
 	if ((!elems->mesh_id || !elems->mesh_config) ||
 	    (elems->rsn && sdata->u.mesh.security == IEEE80211_MESH_SEC_NONE) ||
 	    (!elems->rsn && sdata->u.mesh.security != IEEE80211_MESH_SEC_NONE))
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 8f2b492a9fe9..42286aa3623c 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -667,7 +667,7 @@ void mesh_plink_timer(struct timer_list *t)
 	/*
 	 * This STA is valid because sta_info_destroy() will
 	 * del_timer_sync() this timer after having made sure
-	 * it cannot be readded (by deleting the plink.)
+	 * it cannot be re-added (by deleting the plink.)
 	 */
 	sta = mesh->plink_sta;
 
diff --git a/net/mac80211/mesh_sync.c b/net/mac80211/mesh_sync.c
index 8cf3f395f52f..3a66b4cefca7 100644
--- a/net/mac80211/mesh_sync.c
+++ b/net/mac80211/mesh_sync.c
@@ -175,7 +175,7 @@ static void mesh_sync_offset_adjust_tsf(struct ieee80211_sub_if_data *sdata,
 	spin_lock_bh(&ifmsh->sync_offset_lock);
 
 	if (ifmsh->sync_offset_clockdrift_max > TOFFSET_MINIMUM_ADJUSTMENT) {
-		/* Since ajusting the tsf here would
+		/* Since adjusting the tsf here would
 		 * require a possibly blocking call
 		 * to the driver tsf setter, we punt
 		 * the tsf adjustment to the mesh tasklet
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 6bf3b4444a43..706cbc99f718 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1053,7 +1053,7 @@ minstrel_ht_refill_sample_rates(struct minstrel_ht_sta *mi)
  *  - max_prob_rate must use only one stream, as a tradeoff between delivery
  *    probability and throughput during strong fluctuations
  *  - as long as the max prob rate has a probability of more than 75%, pick
- *    higher throughput rates, even if the probablity is a bit lower
+ *    higher throughput rates, even if the probability is a bit lower
  */
 static void
 minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9195d5a2de0a..9f89fb5bee37 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -169,7 +169,7 @@ struct sta_info;
  * @buf_size: reorder buffer size at receiver
  * @failed_bar_ssn: ssn of the last failed BAR tx attempt
  * @bar_pending: BAR needs to be re-sent
- * @amsdu: support A-MSDU withing A-MDPU
+ * @amsdu: support A-MSDU within A-MDPU
  * @ssn: starting sequence number of the session
  *
  * This structure's lifetime is managed by RCU, assignments to
diff --git a/net/mac80211/tkip.c b/net/mac80211/tkip.c
index e7f57bb18f6e..7aac84cec044 100644
--- a/net/mac80211/tkip.c
+++ b/net/mac80211/tkip.c
@@ -313,7 +313,7 @@ int ieee80211_tkip_decrypt_data(struct arc4_ctx *ctx,
 		 * Record previously received IV, will be copied into the
 		 * key information after MIC verification. It is possible
 		 * that we don't catch replays of fragments but that's ok
-		 * because the Michael MIC verication will then fail.
+		 * because the Michael MIC verification will then fail.
 		 */
 		*out_iv32 = iv32;
 		*out_iv16 = iv16;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a9ee86982259..eedb2c5123ab 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -6214,7 +6214,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 		goto start_xmit;
 
 	/* update QoS header to prioritize control port frames if possible,
-	 * priorization also happens for control port frames send over
+	 * prioritization also happens for control port frames send over
 	 * AF_PACKET
 	 */
 	rcu_read_lock();
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f94faa86ba8a..bc5e61a1d41d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1010,7 +1010,7 @@ void ieee80211_set_wmm_default(struct ieee80211_link_data *link,
 	else
 		aCWmin = 15;
 
-	/* Confiure old 802.11b/g medium access rules. */
+	/* Configure old 802.11b/g medium access rules. */
 	qparam.cw_max = aCWmax;
 	qparam.cw_min = aCWmin;
 	qparam.txop = 0;
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index bf6ef45af757..eafe47bf201a 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -280,10 +280,10 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	/*
 	 * This is a workaround for VHT-enabled STAs which break the spec
 	 * and have the VHT-MCS Rx map filled in with value 3 for all eight
-	 * spacial streams, an example is AR9462.
+	 * spatial streams, an example is AR9462.
 	 *
 	 * As per spec, in section 22.1.1 Introduction to the VHT PHY
-	 * A VHT STA shall support at least single spactial stream VHT-MCSs
+	 * A VHT STA shall support at least single spatial stream VHT-MCSs
 	 * 0 to 7 (transmit and receive) in all supported channel widths.
 	 */
 	if (vht_cap->vht_mcs.rx_mcs_map == cpu_to_le16(0xFFFF)) {
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index e579d7e1425f..afd86f7c66ce 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -289,7 +289,7 @@ static bool cfg80211_valid_center_freq(u32 center,
 
 	/*
 	 * Valid channels are packed from lowest frequency towards higher ones.
-	 * So test that the lower frequency alignes with one of these steps.
+	 * So test that the lower frequency aligns with one of these steps.
 	 */
 	return (center - bw / 2 - 5945) % step == 0;
 }
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9ab777e0bd4d..d51bcb4e9108 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12446,7 +12446,7 @@ static int nl80211_del_pmksa(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_MAC]) {
 		pmksa.bssid = nla_data(info->attrs[NL80211_ATTR_MAC]);
 	} else if (info->attrs[NL80211_ATTR_SSID]) {
-		/* SSID based pmksa flush suppported only for FILS,
+		/* SSID based pmksa flush supported only for FILS,
 		 * OWE/SAE OFFLOAD cases
 		 */
 		if (info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
@@ -15498,7 +15498,7 @@ static int nl80211_add_tx_ts(struct sk_buff *skb, struct genl_info *info)
 	if (tsid >= IEEE80211_FIRST_TSPEC_TSID) {
 		/* TODO: handle 802.11 TSPEC/admission control
 		 * need more attributes for that (e.g. BA session requirement);
-		 * change the WMM adminssion test above to allow both then
+		 * change the WMM admission test above to allow both then
 		 */
 		return -EINVAL;
 	}
diff --git a/net/wireless/radiotap.c b/net/wireless/radiotap.c
index ae2e1a896461..619187e229b4 100644
--- a/net/wireless/radiotap.c
+++ b/net/wireless/radiotap.c
@@ -200,7 +200,7 @@ static void find_ns(struct ieee80211_radiotap_iterator *iterator,
  * present fields.  @this_arg can be changed by the caller (eg,
  * incremented to move inside a compound argument like
  * IEEE80211_RADIOTAP_CHANNEL).  The args pointed to are in
- * little-endian format whatever the endianess of your CPU.
+ * little-endian format whatever the endianness of your CPU.
  *
  * Alignment Gotcha:
  * You must take care when dereferencing iterator.this_arg
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 6489ba943a63..1df65a5a44f7 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1147,7 +1147,7 @@ static const struct ieee80211_regdomain *reg_get_regdomain(struct wiphy *wiphy)
 
 	/*
 	 * Follow the driver's regulatory domain, if present, unless a country
-	 * IE has been processed or a user wants to help complaince further
+	 * IE has been processed or a user wants to help compliance further
 	 */
 	if (lr->initiator != NL80211_REGDOM_SET_BY_COUNTRY_IE &&
 	    lr->initiator != NL80211_REGDOM_SET_BY_USER &&
diff --git a/net/wireless/util.c b/net/wireless/util.c
index f49b55724f83..93a9c32418a6 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -743,7 +743,7 @@ __ieee80211_amsdu_copy(struct sk_buff *skb, unsigned int hlen,
 		return NULL;
 
 	/*
-	 * When reusing framents, copy some data to the head to simplify
+	 * When reusing fragments, copy some data to the head to simplify
 	 * ethernet header handling and speed up protocol header processing
 	 * in the stack later.
 	 */
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 2371069f3c43..cd9f8f6e298b 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -1204,7 +1204,7 @@ static int cfg80211_wext_siwpower(struct net_device *dev,
 		switch (wrq->flags & IW_POWER_MODE) {
 		case IW_POWER_ON:       /* If not specified */
 		case IW_POWER_MODE:     /* If set all mask */
-		case IW_POWER_ALL_R:    /* If explicitely state all */
+		case IW_POWER_ALL_R:    /* If explicitly state all */
 			ps = true;
 			break;
 		default:                /* Otherwise we ignore */
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 838ad6541a17..3bb04b05c5ce 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -1159,7 +1159,7 @@ char *iwe_stream_add_event(struct iw_request_info *info, char *stream,
 	/* Check if it's possible */
 	if (likely((stream + event_len) < ends)) {
 		iwe->len = event_len;
-		/* Beware of alignement issues on 64 bits */
+		/* Beware of alignment issues on 64 bits */
 		memcpy(stream, (char *) iwe, IW_EV_LCP_PK_LEN);
 		memcpy(stream + lcp_len, &iwe->u,
 		       event_len - lcp_len);
-- 
2.46.0


