Return-Path: <linux-wireless+bounces-18-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 998877F6908
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0163B21527
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388824E629;
	Thu, 23 Nov 2023 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ameE76fE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC1D6F
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mM9pvYCUEHOkK06/2+UtdcKatUXxunj/dkXavmrEeX4=;
	t=1700778479; x=1701988079; b=ameE76fETCmfSrfQHo6oPmKutbGxvpAmEKoBUc9+iG1sC+x
	leNha1Oihx9Ehg8v5sMezNw3a1XWtJXJVga39eB2NxvjndJTlcUxB0uhLXcbTx1bTMWlDTrTRz/XV
	Vrbofeg1b4i44P3W5Zbq/7pHiq3zoIcB7hNmAHt7PmU9qDhSrMgWQOTN8wUthH/zRtEbIShX70FW8
	YQTWPEQhFQ1S3PHIDDSwdOa6RFRp4O99kPyemyevgN6ZhX55ICiu/TOJ85ot3uejqoOM4MC74mKYl
	6YblIPm+/DbiA/42Qxn4bZ68CIFz4RjgG240zdhDISnAA4cYfoqfSRLVn4A85xOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAv-00000001Y53-0mjI;
	Thu, 23 Nov 2023 23:27:57 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 07/13] wifi: mac80211: clean up connection process
Date: Thu, 23 Nov 2023 23:14:44 +0100
Message-ID: <20231123231436.cf8f1b7371b4.I3e61f4cfe9da89008e1854160093c76a1e69dc2a@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123221436.143254-14-johannes@sipsolutions.net>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Rewrite the station-side connection handling. The connection
flags (IEEE80211_DISABLE_*) are rather confusing, and they're
not always maintained well. Additionally, for wider-bandwidth
OFDMA support we need to know the precise bandwidth of the AP,
which is currently somewhat difficult.

Rewrite this to have a 'mode' (S1G/legacy/HT/...) and a limit
on the bandwidth. This is not entirely clean because some of
those modes aren't completely sequenced (as this assumes in
some places), e.g. VHT doesn't exist on 2.4 GHz, but HE does.
However, it still simplifies things and gives us a good idea
what we're operating as, so we can parse elements accordingly
etc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Not sure if the puncturing FIXME is all that interesting right
now, we'll catch up with the puncturing a soon as we see the
first beacon after association. However, I plan to address it
by moving the puncturing into the chandef as previously
discussed on the list.
---
 net/mac80211/chan.c        |    4 +-
 net/mac80211/debug.h       |   22 +-
 net/mac80211/ibss.c        |   15 +-
 net/mac80211/ieee80211_i.h |   59 +-
 net/mac80211/mesh.c        |   17 +-
 net/mac80211/mlme.c        | 1967 +++++++++++++++++++-----------------
 net/mac80211/spectmgmt.c   |   21 +-
 net/mac80211/tdls.c        |    8 +-
 net/mac80211/util.c        |  122 ++-
 9 files changed, 1226 insertions(+), 1009 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 1d928f29ad6f..eee93f2d47cb 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * mac80211 - channel management
- * Copyright 2020 - 2022 Intel Corporation
+ * Copyright 2020 - 2023 Intel Corporation
  */
 
 #include <linux/nl80211.h>
@@ -382,7 +382,7 @@ _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	/* downgrade chandef up to max_bw */
 	min_def = ctx->conf.def;
 	while (min_def.width > max_bw)
-		ieee80211_chandef_downgrade(&min_def);
+		ieee80211_chandef_downgrade(&min_def, NULL);
 
 	if (cfg80211_chandef_identical(&ctx->conf.min_def, &min_def))
 		return 0;
diff --git a/net/mac80211/debug.h b/net/mac80211/debug.h
index d49894df2351..85b5e675b34d 100644
--- a/net/mac80211/debug.h
+++ b/net/mac80211/debug.h
@@ -152,16 +152,17 @@ do {									\
 		else							\
 			_sdata_err((link)->sdata, fmt, ##__VA_ARGS__);	\
 	} while (0)
+#define _link_id_dbg(print, sdata, link_id, fmt, ...)			\
+	do {								\
+		if (ieee80211_vif_is_mld(&(sdata)->vif))          	\
+			_sdata_dbg(print, sdata, "[link %d] " fmt,	\
+				   link_id, ##__VA_ARGS__);		\
+		else							\
+			_sdata_dbg(1, sdata, fmt, ##__VA_ARGS__);	\
+	} while (0)
 #define link_dbg(link, fmt, ...)					\
-	do {								\
-		if (ieee80211_vif_is_mld(&(link)->sdata->vif))          \
-			_sdata_dbg(1, (link)->sdata, "[link %d] " fmt,	\
-				   (link)->link_id,			\
-				   ##__VA_ARGS__);			\
-		else							\
-			_sdata_dbg(1, (link)->sdata, fmt,		\
-				   ##__VA_ARGS__);			\
-	} while (0)
+	_link_id_dbg(1, (link)->sdata, (link)->link_id,			\
+		     fmt, ##__VA_ARGS__)
 
 #define ht_dbg(sdata, fmt, ...)						\
 	_sdata_dbg(MAC80211_HT_DEBUG,					\
@@ -226,6 +227,9 @@ do {									\
 #define mlme_dbg(sdata, fmt, ...)					\
 	_sdata_dbg(MAC80211_MLME_DEBUG,					\
 		   sdata, fmt, ##__VA_ARGS__)
+#define mlme_link_id_dbg(sdata, link_id, fmt, ...)			\
+	_link_id_dbg(MAC80211_MLME_DEBUG, sdata, link_id,		\
+		     fmt, ##__VA_ARGS__)
 
 #define mlme_dbg_ratelimited(sdata, fmt, ...)				\
 	_sdata_dbg(MAC80211_MLME_DEBUG && net_ratelimit(),		\
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 8b1e02f2f9ae..210a1a99ef42 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -757,21 +757,22 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 	enum nl80211_channel_type ch_type;
 	int err;
-	ieee80211_conn_flags_t conn_flags;
+	struct ieee80211_conn_settings conn = {
+		.mode = IEEE80211_CONN_MODE_HT,
+		.bw_limit = IEEE80211_CONN_BW_LIMIT_40,
+	};
 	u32 vht_cap_info = 0;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	conn_flags = IEEE80211_CONN_DISABLE_VHT;
-
 	switch (ifibss->chandef.width) {
 	case NL80211_CHAN_WIDTH_5:
 	case NL80211_CHAN_WIDTH_10:
 	case NL80211_CHAN_WIDTH_20_NOHT:
-		conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		conn.mode = IEEE80211_CONN_MODE_LEGACY;
 		fallthrough;
 	case NL80211_CHAN_WIDTH_20:
-		conn_flags |= IEEE80211_CONN_DISABLE_40MHZ;
+		conn.bw_limit = IEEE80211_CONN_BW_LIMIT_20;
 		break;
 	default:
 		break;
@@ -783,8 +784,8 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	memset(&params, 0, sizeof(params));
 	err = ieee80211_parse_ch_switch_ie(sdata, elems,
 					   ifibss->chandef.chan->band,
-					   vht_cap_info,
-					   conn_flags, ifibss->bssid, &csa_ie);
+					   vht_cap_info, &conn,
+					   ifibss->bssid, &csa_ie);
 	/* can't switch to destination channel, fail */
 	if (err < 0)
 		goto disconnect;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 84df104f272b..e36822ad58ca 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 
 #ifndef IEEE80211_I_H
@@ -367,19 +367,32 @@ enum ieee80211_sta_flags {
 	IEEE80211_STA_ENABLE_RRM	= BIT(15),
 };
 
-typedef u32 __bitwise ieee80211_conn_flags_t;
-
-enum ieee80211_conn_flags {
-	IEEE80211_CONN_DISABLE_HT	= (__force ieee80211_conn_flags_t)BIT(0),
-	IEEE80211_CONN_DISABLE_40MHZ	= (__force ieee80211_conn_flags_t)BIT(1),
-	IEEE80211_CONN_DISABLE_VHT	= (__force ieee80211_conn_flags_t)BIT(2),
-	IEEE80211_CONN_DISABLE_80P80MHZ	= (__force ieee80211_conn_flags_t)BIT(3),
-	IEEE80211_CONN_DISABLE_160MHZ	= (__force ieee80211_conn_flags_t)BIT(4),
-	IEEE80211_CONN_DISABLE_HE	= (__force ieee80211_conn_flags_t)BIT(5),
-	IEEE80211_CONN_DISABLE_EHT	= (__force ieee80211_conn_flags_t)BIT(6),
-	IEEE80211_CONN_DISABLE_320MHZ	= (__force ieee80211_conn_flags_t)BIT(7),
+enum ieee80211_conn_mode {
+	IEEE80211_CONN_MODE_S1G,
+	IEEE80211_CONN_MODE_LEGACY,
+	IEEE80211_CONN_MODE_HT,
+	IEEE80211_CONN_MODE_VHT,
+	IEEE80211_CONN_MODE_HE,
+	IEEE80211_CONN_MODE_EHT,
 };
 
+#define IEEE80211_CONN_MODE_HIGHEST	IEEE80211_CONN_MODE_EHT
+
+enum ieee80211_conn_bw_limit {
+	IEEE80211_CONN_BW_LIMIT_20,
+	IEEE80211_CONN_BW_LIMIT_40,
+	IEEE80211_CONN_BW_LIMIT_80,
+	IEEE80211_CONN_BW_LIMIT_160, /* also 80+80 */
+	IEEE80211_CONN_BW_LIMIT_320,
+};
+
+struct ieee80211_conn_settings {
+	enum ieee80211_conn_mode mode;
+	enum ieee80211_conn_bw_limit bw_limit;
+};
+
+extern const struct ieee80211_conn_settings ieee80211_conn_settings_unlimited;
+
 struct ieee80211_mgd_auth_data {
 	struct cfg80211_bss *bss;
 	unsigned long timeout;
@@ -413,7 +426,7 @@ struct ieee80211_mgd_assoc_data {
 		size_t elems_len;
 		u8 *elems; /* pointing to inside ie[] below */
 
-		ieee80211_conn_flags_t conn_flags;
+		struct ieee80211_conn_settings conn;
 
 		u16 status;
 
@@ -934,7 +947,7 @@ struct ieee80211_link_data_managed {
 	enum ieee80211_smps_mode req_smps, /* requested smps mode */
 				 driver_smps_mode; /* smps mode request */
 
-	ieee80211_conn_flags_t conn_flags;
+	struct ieee80211_conn_settings conn;
 
 	s16 p2p_noa_index;
 
@@ -2163,9 +2176,8 @@ void ieee80211_process_measurement_req(struct ieee80211_sub_if_data *sdata,
  * @elems: parsed 802.11 elements received with the frame
  * @current_band: indicates the current band
  * @vht_cap_info: VHT capabilities of the transmitter
- * @conn_flags: contains information about own capabilities and restrictions
- *	to decide which channel switch announcements can be accepted, using
- *	flags from &enum ieee80211_conn_flags.
+ * @conn: contains information about own capabilities and restrictions
+ *	to decide which channel switch announcements can be accepted
  * @bssid: the currently connected bssid (for reporting)
  * @csa_ie: parsed 802.11 csa elements on count, mode, chandef and mesh ttl.
  *	All of them will be filled with if success only.
@@ -2175,7 +2187,8 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 struct ieee802_11_elems *elems,
 				 enum nl80211_band current_band,
 				 u32 vht_cap_info,
-				 ieee80211_conn_flags_t conn_flags, u8 *bssid,
+				 struct ieee80211_conn_settings *conn,
+				 u8 *bssid,
 				 struct ieee80211_csa_ie *csa_ie);
 
 /* Suspend/resume and hw reconfiguration */
@@ -2240,6 +2253,7 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
 
 /**
  * struct ieee80211_elems_parse_params - element parsing parameters
+ * @mode: connection mode for parsing
  * @start: pointer to the elements
  * @len: length of the elements
  * @action: %true if the elements came from an action frame
@@ -2257,6 +2271,7 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
  *	for EHT capabilities parsing)
  */
 struct ieee80211_elems_parse_params {
+	enum ieee80211_conn_mode mode;
 	const u8 *start;
 	size_t len;
 	bool action;
@@ -2276,6 +2291,7 @@ ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			   struct cfg80211_bss *bss)
 {
 	struct ieee80211_elems_parse_params params = {
+		.mode = IEEE80211_CONN_MODE_HIGHEST,
 		.start = start,
 		.len = len,
 		.action = action,
@@ -2451,9 +2467,9 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 				const struct cfg80211_chan_def *chandef);
 u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype);
-u8 *ieee80211_ie_build_he_cap(ieee80211_conn_flags_t disable_flags, u8 *pos,
+u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
 			      const struct ieee80211_sta_he_cap *he_cap,
-			      u8 *end);
+			      u8 *pos, u8 *end);
 void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
 				    enum ieee80211_smps_mode smps_mode,
 				    struct sk_buff *skb);
@@ -2493,7 +2509,8 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 				    struct cfg80211_chan_def *chandef);
 bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
 				struct cfg80211_chan_def *chandef);
-ieee80211_conn_flags_t ieee80211_chandef_downgrade(struct cfg80211_chan_def *c);
+void ieee80211_chandef_downgrade(struct cfg80211_chan_def *chandef,
+				 struct ieee80211_conn_settings *conn);
 
 int __must_check
 ieee80211_link_use_channel(struct ieee80211_link_data *link,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index fccbcde3359a..bcfd7f0eff56 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -586,7 +586,7 @@ int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
 		return -ENOMEM;
 
 	pos = skb_put(skb, ie_len);
-	ieee80211_ie_build_he_cap(0, pos, he_cap, pos + ie_len);
+	ieee80211_ie_build_he_cap(NULL, he_cap, pos, pos + ie_len);
 
 	return 0;
 }
@@ -1292,7 +1292,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct ieee80211_supported_band *sband;
 	int err;
-	ieee80211_conn_flags_t conn_flags = 0;
+	struct ieee80211_conn_settings conn = ieee80211_conn_settings_unlimited;
 	u32 vht_cap_info = 0;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
@@ -1303,13 +1303,14 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 
 	switch (sdata->vif.bss_conf.chandef.width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
-		conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		fallthrough;
+		conn.mode = IEEE80211_CONN_MODE_LEGACY;
+		conn.bw_limit = IEEE80211_CONN_BW_LIMIT_20;
+		break;
 	case NL80211_CHAN_WIDTH_20:
-		conn_flags |= IEEE80211_CONN_DISABLE_40MHZ;
+		conn.bw_limit = IEEE80211_CONN_BW_LIMIT_40;
 		fallthrough;
 	case NL80211_CHAN_WIDTH_40:
-		conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		conn.mode = IEEE80211_CONN_MODE_HT;
 		break;
 	default:
 		break;
@@ -1321,8 +1322,8 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 
 	memset(&params, 0, sizeof(params));
 	err = ieee80211_parse_ch_switch_ie(sdata, elems, sband->band,
-					   vht_cap_info,
-					   conn_flags, sdata->vif.addr,
+					   vht_cap_info, &conn,
+					   sdata->vif.addr,
 					   &csa_ie);
 	if (err < 0)
 		return false;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0e9ed0e3e70b..fdcdba2b2c9e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -149,8 +149,7 @@ ieee80211_handle_puncturing_bitmap(struct ieee80211_link_data *link,
 		if (cfg80211_valid_disable_subchannel_bitmap(&bitmap,
 							     chandef))
 			break;
-		link->u.mgd.conn_flags |=
-			ieee80211_chandef_downgrade(chandef);
+		ieee80211_chandef_downgrade(chandef, &link->u.mgd.conn);
 		*changed |= BSS_CHANGED_BANDWIDTH;
 	}
 
@@ -217,77 +216,88 @@ static int ecw2cw(int ecw)
 	return (1 << ecw) - 1;
 }
 
-static ieee80211_conn_flags_t
-ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
-			     struct ieee80211_link_data *link,
-			     ieee80211_conn_flags_t conn_flags,
-			     struct ieee80211_supported_band *sband,
-			     struct ieee80211_channel *channel,
-			     u32 vht_cap_info,
-			     const struct ieee80211_ht_operation *ht_oper,
-			     const struct ieee80211_vht_operation *vht_oper,
-			     const struct ieee80211_he_operation *he_oper,
-			     const struct ieee80211_eht_operation *eht_oper,
-			     const struct ieee80211_s1g_oper_ie *s1g_oper,
-			     struct cfg80211_chan_def *chandef, bool tracking)
+static enum ieee80211_conn_mode
+ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
+			    struct ieee80211_channel *channel,
+			    u32 vht_cap_info,
+			    const struct ieee802_11_elems *elems,
+			    bool ignore_ht_channel_mismatch,
+			    const struct ieee80211_conn_settings *conn,
+			    struct cfg80211_chan_def *chandef) /* out */
 {
+	const struct ieee80211_ht_operation *ht_oper = elems->ht_operation;
+	const struct ieee80211_vht_operation *vht_oper = elems->vht_operation;
+	const struct ieee80211_he_operation *he_oper = elems->he_operation;
+	const struct ieee80211_eht_operation *eht_oper = elems->eht_operation;
+	struct ieee80211_supported_band *sband =
+		sdata->local->hw.wiphy->bands[channel->band];
+	bool is_6ghz = sband->band == NL80211_BAND_6GHZ;
 	struct cfg80211_chan_def vht_chandef;
-	struct ieee80211_sta_ht_cap sta_ht_cap;
-	ieee80211_conn_flags_t ret;
+	bool no_vht = false;
 	u32 ht_cfreq;
 
-	memset(chandef, 0, sizeof(struct cfg80211_chan_def));
-	chandef->chan = channel;
-	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
-	chandef->center_freq1 = channel->center_freq;
-	chandef->freq1_offset = channel->freq_offset;
+	*chandef = (struct cfg80211_chan_def) {
+		.chan = channel,
+		.width = NL80211_CHAN_WIDTH_20_NOHT,
+		.center_freq1 = channel->center_freq,
+		.freq1_offset = channel->freq_offset,
+	};
 
-	if (channel->band == NL80211_BAND_6GHZ) {
-		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, eht_oper,
-						    chandef)) {
-			mlme_dbg(sdata,
-				 "bad 6 GHz operation, disabling HT/VHT/HE/EHT\n");
-			ret = IEEE80211_CONN_DISABLE_HT |
-			      IEEE80211_CONN_DISABLE_VHT |
-			      IEEE80211_CONN_DISABLE_HE |
-			      IEEE80211_CONN_DISABLE_EHT;
-		} else {
-			ret = 0;
-		}
-		vht_chandef = *chandef;
-		goto out;
-	} else if (sband->band == NL80211_BAND_S1GHZ) {
-		if (!ieee80211_chandef_s1g_oper(s1g_oper, chandef)) {
+	/* get special S1G case out of the way */
+	if (sband->band == NL80211_BAND_S1GHZ) {
+		if (!ieee80211_chandef_s1g_oper(elems->s1g_oper, chandef)) {
 			sdata_info(sdata,
 				   "Missing S1G Operation Element? Trying operating == primary\n");
 			chandef->width = ieee80211_s1g_channel_width(channel);
 		}
 
-		ret = IEEE80211_CONN_DISABLE_HT | IEEE80211_CONN_DISABLE_40MHZ |
-		      IEEE80211_CONN_DISABLE_VHT |
-		      IEEE80211_CONN_DISABLE_80P80MHZ |
-		      IEEE80211_CONN_DISABLE_160MHZ;
-		goto out;
+		return IEEE80211_CONN_MODE_S1G;
 	}
 
-	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
-	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
+	/* get special 6 GHz case out of the way */
+	if (is_6ghz) {
+		enum ieee80211_conn_mode mode = IEEE80211_CONN_MODE_EHT;
 
-	if (!ht_oper || !sta_ht_cap.ht_supported) {
-		mlme_dbg(sdata, "HT operation missing / HT not supported\n");
-		ret = IEEE80211_CONN_DISABLE_HT |
-		      IEEE80211_CONN_DISABLE_VHT |
-		      IEEE80211_CONN_DISABLE_HE |
-		      IEEE80211_CONN_DISABLE_EHT;
-		goto out;
+		/* this is an error */
+		if (conn->mode < IEEE80211_CONN_MODE_HE)
+			return IEEE80211_CONN_MODE_LEGACY;
+
+		if (!elems->he_6ghz_capa) {
+			sdata_info(sdata,
+				   "HE 6 GHz AP is missing HE 6 GHz band capability\n");
+			return IEEE80211_CONN_MODE_LEGACY;
+		}
+
+		if (!elems->he_cap)
+			return IEEE80211_CONN_MODE_LEGACY;
+
+		if (!eht_oper || !elems->eht_cap) {
+			eht_oper = NULL;
+			mode = IEEE80211_CONN_MODE_HE;
+		}
+
+		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper,
+						    eht_oper, chandef)) {
+			sdata_info(sdata, "bad HE/EHT 6 GHz operation\n");
+			return IEEE80211_CONN_MODE_LEGACY;
+		}
+
+		return mode;
 	}
 
+	/* now we have the progression HT, VHT, ... */
+	if (conn->mode < IEEE80211_CONN_MODE_HT)
+		return IEEE80211_CONN_MODE_LEGACY;
+
+	if (!is_6ghz && (!ht_oper || !elems->ht_cap_elem))
+		return IEEE80211_CONN_MODE_LEGACY;
+
 	chandef->width = NL80211_CHAN_WIDTH_20;
 
 	ht_cfreq = ieee80211_channel_to_frequency(ht_oper->primary_chan,
 						  channel->band);
 	/* check that channel matches the right operating channel */
-	if (!tracking && channel->center_freq != ht_cfreq) {
+	if (!ignore_ht_channel_mismatch && channel->center_freq != ht_cfreq) {
 		/*
 		 * It's possible that some APs are confused here;
 		 * Netgear WNDR3700 sometimes reports 4 higher than
@@ -299,36 +309,22 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			   "Wrong control channel: center-freq: %d ht-cfreq: %d ht->primary_chan: %d band: %d - Disabling HT\n",
 			   channel->center_freq, ht_cfreq,
 			   ht_oper->primary_chan, channel->band);
-		ret = IEEE80211_CONN_DISABLE_HT |
-		      IEEE80211_CONN_DISABLE_VHT |
-		      IEEE80211_CONN_DISABLE_HE |
-		      IEEE80211_CONN_DISABLE_EHT;
-		goto out;
+		return IEEE80211_CONN_MODE_LEGACY;
 	}
 
-	/* check 40 MHz support, if we have it */
-	if (sta_ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
-		ieee80211_chandef_ht_oper(ht_oper, chandef);
-	} else {
-		mlme_dbg(sdata, "40 MHz not supported\n");
-		/* 40 MHz (and 80 MHz) must be supported for VHT */
-		ret = IEEE80211_CONN_DISABLE_VHT;
-		/* also mark 40 MHz disabled */
-		ret |= IEEE80211_CONN_DISABLE_40MHZ;
-		goto out;
-	}
+	ieee80211_chandef_ht_oper(ht_oper, chandef);
 
-	if (!vht_oper || !sband->vht_cap.vht_supported) {
-		mlme_dbg(sdata, "VHT operation missing / VHT not supported\n");
-		ret = IEEE80211_CONN_DISABLE_VHT;
-		goto out;
-	}
+	if (conn->mode < IEEE80211_CONN_MODE_VHT)
+		return IEEE80211_CONN_MODE_HT;
 
 	vht_chandef = *chandef;
-	if (!(conn_flags & IEEE80211_CONN_DISABLE_HE) &&
-	    he_oper &&
-	    (le32_to_cpu(he_oper->he_oper_params) &
-	     IEEE80211_HE_OPERATION_VHT_OPER_INFO)) {
+
+	/*
+	 * having he_cap/he_oper parsed out implies we're at
+	 * least operating as HE STA
+	 */
+	if (elems->he_cap && he_oper &&
+	    he_oper->he_oper_params & cpu_to_le32(IEEE80211_HE_OPERATION_VHT_OPER_INFO)) {
 		struct ieee80211_vht_operation he_oper_vht_cap;
 
 		/*
@@ -341,52 +337,63 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 		if (!ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
 						&he_oper_vht_cap, ht_oper,
 						&vht_chandef)) {
-			if (!(conn_flags & IEEE80211_CONN_DISABLE_HE))
-				sdata_info(sdata,
-					   "HE AP VHT information is invalid, disabling HE\n");
-			ret = IEEE80211_CONN_DISABLE_HE | IEEE80211_CONN_DISABLE_EHT;
-			goto out;
+			sdata_info(sdata,
+				   "HE AP VHT information is invalid, disabling HE\n");
+			/* this will cause us to re-parse as VHT STA */
+			return IEEE80211_CONN_MODE_VHT;
 		}
+	} if (!vht_oper || !elems->vht_cap_elem) {
+		if (sband->band == NL80211_BAND_5GHZ) {
+			sdata_info(sdata,
+				   "VHT information is missing, disabling VHT\n");
+			return IEEE80211_CONN_MODE_HT;
+		}
+		no_vht = true;
+	} else if (sband->band == NL80211_BAND_2GHZ) {
+		no_vht = true;
 	} else if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
 					       vht_cap_info,
 					       vht_oper, ht_oper,
 					       &vht_chandef)) {
-		if (!(conn_flags & IEEE80211_CONN_DISABLE_VHT))
-			sdata_info(sdata,
-				   "AP VHT information is invalid, disabling VHT\n");
-		ret = IEEE80211_CONN_DISABLE_VHT;
-		goto out;
-	}
-
-	if (!cfg80211_chandef_valid(&vht_chandef)) {
-		if (!(conn_flags & IEEE80211_CONN_DISABLE_VHT))
-			sdata_info(sdata,
-				   "AP VHT information is invalid, disabling VHT\n");
-		ret = IEEE80211_CONN_DISABLE_VHT;
-		goto out;
-	}
-
-	if (cfg80211_chandef_identical(chandef, &vht_chandef)) {
-		ret = 0;
-		goto out;
+		sdata_info(sdata,
+			   "AP VHT information is invalid, disabling VHT\n");
+		return IEEE80211_CONN_MODE_HT;
 	}
 
 	if (!cfg80211_chandef_compatible(chandef, &vht_chandef)) {
-		if (!(conn_flags & IEEE80211_CONN_DISABLE_VHT))
-			sdata_info(sdata,
-				   "AP VHT information doesn't match HT, disabling VHT\n");
-		ret = IEEE80211_CONN_DISABLE_VHT;
-		goto out;
+		sdata_info(sdata,
+			   "AP VHT information doesn't match HT, disabling VHT\n");
+		return IEEE80211_CONN_MODE_HT;
 	}
 
 	*chandef = vht_chandef;
 
+	/* stick to current max mode if we don't have HE */
+	if (conn->mode < IEEE80211_CONN_MODE_HE) {
+		if (no_vht)
+			return IEEE80211_CONN_MODE_HT;
+		return IEEE80211_CONN_MODE_VHT;
+	}
+
+	if (!elems->he_operation || !elems->he_cap) {
+		if (no_vht)
+			return IEEE80211_CONN_MODE_HT;
+		return IEEE80211_CONN_MODE_VHT;
+	}
+
+	/* stick to HE if we don't have EHT */
+	if (conn->mode < IEEE80211_CONN_MODE_EHT)
+		return IEEE80211_CONN_MODE_HE;
+
+	if (!eht_oper || !elems->eht_cap)
+		return IEEE80211_CONN_MODE_HE;
+
 	/*
 	 * handle the case that the EHT operation indicates that it holds EHT
 	 * operation information (in case that the channel width differs from
 	 * the channel width reported in HT/VHT/HE).
 	 */
-	if (eht_oper && (eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT)) {
+	if (eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) {
 		struct cfg80211_chan_def eht_chandef = *chandef;
 
 		ieee80211_chandef_eht_oper((const void *)eht_oper->optional,
@@ -395,199 +402,589 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 					   false, &eht_chandef);
 
 		if (!cfg80211_chandef_valid(&eht_chandef)) {
-			if (!(conn_flags & IEEE80211_CONN_DISABLE_EHT))
-				sdata_info(sdata,
-					   "AP EHT information is invalid, disabling EHT\n");
-			ret = IEEE80211_CONN_DISABLE_EHT;
-			goto out;
+			sdata_info(sdata,
+				   "AP EHT information is invalid, disabling EHT\n");
+			return IEEE80211_CONN_MODE_HE;
 		}
 
 		if (!cfg80211_chandef_compatible(chandef, &eht_chandef)) {
-			if (!(conn_flags & IEEE80211_CONN_DISABLE_EHT))
-				sdata_info(sdata,
-					   "AP EHT information is incompatible, disabling EHT\n");
-			ret = IEEE80211_CONN_DISABLE_EHT;
-			goto out;
+			sdata_info(sdata,
+				   "AP EHT information doesn't match HT/VHT/HE, disabling EHT\n");
+			return IEEE80211_CONN_MODE_HE;
 		}
 
 		*chandef = eht_chandef;
 	}
 
-	ret = 0;
+	return IEEE80211_CONN_MODE_EHT;
+}
+
+static bool
+ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
+				     const struct ieee80211_he_cap_elem *he_cap,
+				     const struct ieee80211_he_operation *he_op)
+{
+	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
+	u16 mcs_80_map_tx, mcs_80_map_rx;
+	u16 ap_min_req_set;
+	int nss;
+
+	if (!he_cap)
+		return false;
+
+	/* mcs_nss is right after he_cap info */
+	he_mcs_nss_supp = (void *)(he_cap + 1);
+
+	mcs_80_map_tx = le16_to_cpu(he_mcs_nss_supp->tx_mcs_80);
+	mcs_80_map_rx = le16_to_cpu(he_mcs_nss_supp->rx_mcs_80);
+
+	/* P802.11-REVme/D0.3
+	 * 27.1.1 Introduction to the HE PHY
+	 * ...
+	 * An HE STA shall support the following features:
+	 * ...
+	 * Single spatial stream HE-MCSs 0 to 7 (transmit and receive) in all
+	 * supported channel widths for HE SU PPDUs
+	 */
+	if ((mcs_80_map_tx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+	    (mcs_80_map_rx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED) {
+		sdata_info(sdata,
+			   "Missing mandatory rates for 1 Nss, rx 0x%x, tx 0x%x, disable HE\n",
+			   mcs_80_map_tx, mcs_80_map_rx);
+		return false;
+	}
+
+	if (!he_op)
+		return true;
+
+	ap_min_req_set = le16_to_cpu(he_op->he_mcs_nss_set);
 
-out:
 	/*
-	 * When tracking the current AP, don't do any further checks if the
-	 * new chandef is identical to the one we're currently using for the
-	 * connection. This keeps us from playing ping-pong with regulatory,
-	 * without it the following can happen (for example):
-	 *  - connect to an AP with 80 MHz, world regdom allows 80 MHz
-	 *  - AP advertises regdom US
-	 *  - CRDA loads regdom US with 80 MHz prohibited (old database)
-	 *  - the code below detects an unsupported channel, downgrades, and
-	 *    we disconnect from the AP in the caller
-	 *  - disconnect causes CRDA to reload world regdomain and the game
-	 *    starts anew.
-	 * (see https://bugzilla.kernel.org/show_bug.cgi?id=70881)
+	 * Apparently iPhone 13 (at least iOS version 15.3.1) sets this to all
+	 * zeroes, which is nonsense, and completely inconsistent with itself
+	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
+	 */
+	if (!ap_min_req_set)
+		return true;
+
+	/* make sure the AP is consistent with itself
 	 *
-	 * It seems possible that there are still scenarios with CSA or real
-	 * bandwidth changes where a this could happen, but those cases are
-	 * less common and wouldn't completely prevent using the AP.
+	 * P802.11-REVme/D0.3
+	 * 26.17.1 Basic HE BSS operation
+	 *
+	 * A STA that is operating in an HE BSS shall be able to receive and
+	 * transmit at each of the <HE-MCS, NSS> tuple values indicated by the
+	 * Basic HE-MCS And NSS Set field of the HE Operation parameter of the
+	 * MLME-START.request primitive and shall be able to receive at each of
+	 * the <HE-MCS, NSS> tuple values indicated by the Supported HE-MCS and
+	 * NSS Set field in the HE Capabilities parameter of the MLMESTART.request
+	 * primitive
 	 */
-	if (tracking &&
-	    cfg80211_chandef_identical(chandef, &link->conf->chandef))
-		return ret;
+	for (nss = 8; nss > 0; nss--) {
+		u8 ap_op_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
+		u8 ap_rx_val;
+		u8 ap_tx_val;
+
+		if (ap_op_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
+			continue;
+
+		ap_rx_val = (mcs_80_map_rx >> (2 * (nss - 1))) & 3;
+		ap_tx_val = (mcs_80_map_tx >> (2 * (nss - 1))) & 3;
 
-	/* don't print the message below for VHT mismatch if VHT is disabled */
-	if (ret & IEEE80211_CONN_DISABLE_VHT)
-		vht_chandef = *chandef;
+		if (ap_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    ap_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    ap_rx_val < ap_op_val || ap_tx_val < ap_op_val) {
+			sdata_info(sdata,
+				   "Invalid rates for %d Nss, rx %d, tx %d oper %d, disable HE\n",
+				   nss, ap_rx_val, ap_rx_val, ap_op_val);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static bool
+ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
+				    const struct ieee80211_he_operation *he_op)
+{
+	const struct ieee80211_sta_he_cap *sta_he_cap =
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	u16 ap_min_req_set;
+	int i;
+
+	if (!sta_he_cap || !he_op)
+		return false;
+
+	ap_min_req_set = le16_to_cpu(he_op->he_mcs_nss_set);
 
 	/*
-	 * Ignore the DISABLED flag when we're already connected and only
-	 * tracking the APs beacon for bandwidth changes - otherwise we
-	 * might get disconnected here if we connect to an AP, update our
-	 * regulatory information based on the AP's country IE and the
-	 * information we have is wrong/outdated and disables the channel
-	 * that we're actually using for the connection to the AP.
+	 * Apparently iPhone 13 (at least iOS version 15.3.1) sets this to all
+	 * zeroes, which is nonsense, and completely inconsistent with itself
+	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
+	 */
+	if (!ap_min_req_set)
+		return true;
+
+	/* Need to go over for 80MHz, 160MHz and for 80+80 */
+	for (i = 0; i < 3; i++) {
+		const struct ieee80211_he_mcs_nss_supp *sta_mcs_nss_supp =
+			&sta_he_cap->he_mcs_nss_supp;
+		u16 sta_mcs_map_rx =
+			le16_to_cpu(((__le16 *)sta_mcs_nss_supp)[2 * i]);
+		u16 sta_mcs_map_tx =
+			le16_to_cpu(((__le16 *)sta_mcs_nss_supp)[2 * i + 1]);
+		u8 nss;
+		bool verified = true;
+
+		/*
+		 * For each band there is a maximum of 8 spatial streams
+		 * possible. Each of the sta_mcs_map_* is a 16-bit struct built
+		 * of 2 bits per NSS (1-8), with the values defined in enum
+		 * ieee80211_he_mcs_support. Need to make sure STA TX and RX
+		 * capabilities aren't less than the AP's minimum requirements
+		 * for this HE BSS per SS.
+		 * It is enough to find one such band that meets the reqs.
+		 */
+		for (nss = 8; nss > 0; nss--) {
+			u8 sta_rx_val = (sta_mcs_map_rx >> (2 * (nss - 1))) & 3;
+			u8 sta_tx_val = (sta_mcs_map_tx >> (2 * (nss - 1))) & 3;
+			u8 ap_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
+
+			if (ap_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
+				continue;
+
+			/*
+			 * Make sure the HE AP doesn't require MCSs that aren't
+			 * supported by the client as required by spec
+			 *
+			 * P802.11-REVme/D0.3
+			 * 26.17.1 Basic HE BSS operation
+			 *
+			 * An HE STA shall not attempt to join * (MLME-JOIN.request primitive)
+			 * a BSS, unless it supports (i.e., is able to both transmit and
+			 * receive using) all of the <HE-MCS, NSS> tuples in the basic
+			 * HE-MCS and NSS set.
+			 */
+			if (sta_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+			    sta_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+			    (ap_val > sta_rx_val) || (ap_val > sta_tx_val)) {
+				verified = false;
+				break;
+			}
+		}
+
+		if (verified)
+			return true;
+	}
+
+	/* If here, STA doesn't meet AP's HE min requirements */
+	return false;
+}
+
+static u8
+ieee80211_get_eht_cap_mcs_nss(const struct ieee80211_sta_he_cap *sta_he_cap,
+			      const struct ieee80211_sta_eht_cap *sta_eht_cap,
+			      unsigned int idx, int bw)
+{
+	u8 he_phy_cap0 = sta_he_cap->he_cap_elem.phy_cap_info[0];
+	u8 eht_phy_cap0 = sta_eht_cap->eht_cap_elem.phy_cap_info[0];
+
+	/* handle us being a 20 MHz-only EHT STA - with four values
+	 * for MCS 0-7, 8-9, 10-11, 12-13.
 	 */
+	if (!(he_phy_cap0 & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL))
+		return sta_eht_cap->eht_mcs_nss_supp.only_20mhz.rx_tx_max_nss[idx];
+
+	/* the others have MCS 0-9 together, rather than separately from 0-7 */
+	if (idx > 0)
+		idx--;
+
+	switch (bw) {
+	case 0:
+		return sta_eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_max_nss[idx];
+	case 1:
+		if (!(he_phy_cap0 &
+		      (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+		       IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)))
+			return 0xff; /* pass check */
+		return sta_eht_cap->eht_mcs_nss_supp.bw._160.rx_tx_max_nss[idx];
+	case 2:
+		if (!(eht_phy_cap0 & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ))
+			return 0xff; /* pass check */
+		return sta_eht_cap->eht_mcs_nss_supp.bw._320.rx_tx_max_nss[idx];
+	}
+
+	WARN_ON(1);
+	return 0;
+}
+
+static bool
+ieee80211_verify_sta_eht_mcs_support(struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_supported_band *sband,
+				     const struct ieee80211_eht_operation *eht_op)
+{
+	const struct ieee80211_sta_he_cap *sta_he_cap =
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	const struct ieee80211_sta_eht_cap *sta_eht_cap =
+		ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
+	const struct ieee80211_eht_mcs_nss_supp_20mhz_only *req;
+	unsigned int i;
+
+	if (!sta_he_cap || !sta_eht_cap || !eht_op)
+		return false;
+
+	req = &eht_op->basic_mcs_nss;
+
+	for (i = 0; i < ARRAY_SIZE(req->rx_tx_max_nss); i++) {
+		u8 req_rx_nss, req_tx_nss;
+		unsigned int bw;
+
+		req_rx_nss = u8_get_bits(req->rx_tx_max_nss[i],
+					 IEEE80211_EHT_MCS_NSS_RX);
+		req_tx_nss = u8_get_bits(req->rx_tx_max_nss[i],
+					 IEEE80211_EHT_MCS_NSS_TX);
+
+		for (bw = 0; bw < 3; bw++) {
+			u8 have, have_rx_nss, have_tx_nss;
+
+			have = ieee80211_get_eht_cap_mcs_nss(sta_he_cap,
+							     sta_eht_cap,
+							     i, bw);
+			have_rx_nss = u8_get_bits(have,
+						  IEEE80211_EHT_MCS_NSS_RX);
+			have_tx_nss = u8_get_bits(have,
+						  IEEE80211_EHT_MCS_NSS_TX);
+
+			if (req_rx_nss > have_rx_nss ||
+			    req_tx_nss > have_tx_nss)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static const char *ieee80211_conn_mode_str(enum ieee80211_conn_mode mode)
+{
+	static const char *modes[] = {
+		[IEEE80211_CONN_MODE_S1G] = "S1G",
+		[IEEE80211_CONN_MODE_LEGACY] = "legacy",
+		[IEEE80211_CONN_MODE_HT] = "HT",
+		[IEEE80211_CONN_MODE_VHT] = "VHT",
+		[IEEE80211_CONN_MODE_HE] = "HE",
+		[IEEE80211_CONN_MODE_EHT] = "EHT",
+	};
+
+	if (WARN_ON(mode >= ARRAY_SIZE(modes)))
+		return "<out of range>";
+
+	return modes[mode] ?: "<missing string>";
+}
+
+static struct ieee802_11_elems *
+ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
+			      struct ieee80211_conn_settings *conn,
+			      struct cfg80211_bss *cbss, int link_id,
+			      struct cfg80211_chan_def *chandef)
+{
+	const struct cfg80211_bss_ies *ies = rcu_dereference(cbss->ies);
+	struct ieee80211_bss *bss = (void *)cbss->priv;
+	struct ieee80211_channel *channel = cbss->channel;
+	struct ieee80211_elems_parse_params parse_params = {
+		.link_id = -1,
+		.from_ap = true,
+		.start = ies->data,
+		.len = ies->len,
+		.mode = conn->mode,
+	};
+	struct ieee802_11_elems *elems;
+	struct ieee80211_supported_band *sband;
+	struct cfg80211_chan_def ap_chandef;
+	enum ieee80211_conn_mode ap_mode;
+	int ret;
+
+again:
+	elems = ieee802_11_parse_elems_full(&parse_params);
+	if (!elems)
+		return ERR_PTR(-ENOMEM);
+
+	ap_mode = ieee80211_determine_ap_chan(sdata, channel, bss->vht_cap_info,
+					      elems, false, conn, &ap_chandef);
+
+	mlme_link_id_dbg(sdata, link_id, "determined AP %pM to be %s\n",
+			 cbss->bssid, ieee80211_conn_mode_str(ap_mode));
+
+	/* this should be impossible since parsing depends on our mode */
+	if (WARN_ON(ap_mode > conn->mode)) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	sband = sdata->local->hw.wiphy->bands[channel->band];
+
+	switch (channel->band) {
+	case NL80211_BAND_S1GHZ:
+		if (WARN_ON(ap_mode != IEEE80211_CONN_MODE_S1G)) {
+			ret = -EINVAL;
+			goto free;
+		}
+		return elems;
+	case NL80211_BAND_6GHZ:
+		if (ap_mode < IEEE80211_CONN_MODE_HE ||
+		    conn->mode < IEEE80211_CONN_MODE_HE) {
+			sdata_info(sdata,
+				   "Rejecting non-HE 6/7 GHz connection");
+			ret = -EINVAL;
+			goto free;
+		}
+		break;
+	default:
+		if (WARN_ON(ap_mode == IEEE80211_CONN_MODE_S1G)) {
+			ret = -EINVAL;
+			goto free;
+		}
+	}
+
+	switch (ap_mode) {
+	case IEEE80211_CONN_MODE_S1G:
+		WARN_ON(1);
+		ret = -EINVAL;
+		goto free;
+	case IEEE80211_CONN_MODE_LEGACY:
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
+		break;
+	case IEEE80211_CONN_MODE_HT:
+		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+				       conn->bw_limit,
+				       IEEE80211_CONN_BW_LIMIT_40);
+		break;
+	case IEEE80211_CONN_MODE_VHT:
+	case IEEE80211_CONN_MODE_HE:
+		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+				       conn->bw_limit,
+				       IEEE80211_CONN_BW_LIMIT_160);
+		break;
+	case IEEE80211_CONN_MODE_EHT:
+		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+				       conn->bw_limit,
+				       IEEE80211_CONN_BW_LIMIT_320);
+		break;
+	}
+
+	conn->mode = ap_mode;
+	*chandef = ap_chandef;
+
 	while (!cfg80211_chandef_usable(sdata->local->hw.wiphy, chandef,
-					tracking ? 0 :
-						   IEEE80211_CHAN_DISABLED)) {
+					IEEE80211_CHAN_DISABLED)) {
 		if (WARN_ON(chandef->width == NL80211_CHAN_WIDTH_20_NOHT)) {
-			ret = IEEE80211_CONN_DISABLE_HT |
-			      IEEE80211_CONN_DISABLE_VHT |
-			      IEEE80211_CONN_DISABLE_HE |
-			      IEEE80211_CONN_DISABLE_EHT;
-			break;
+			ret = -EINVAL;
+			goto free;
 		}
 
-		ret |= ieee80211_chandef_downgrade(chandef);
+		ieee80211_chandef_downgrade(chandef, conn);
 	}
 
-	if (!he_oper || !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
-						 IEEE80211_CHAN_NO_HE))
-		ret |= IEEE80211_CONN_DISABLE_HE | IEEE80211_CONN_DISABLE_EHT;
+	if (conn->mode >= IEEE80211_CONN_MODE_HE &&
+	    !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
+				     IEEE80211_CHAN_NO_HE))
+		conn->mode = IEEE80211_CONN_MODE_VHT;
 
-	if (!eht_oper || !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
-						  IEEE80211_CHAN_NO_EHT))
-		ret |= IEEE80211_CONN_DISABLE_EHT;
+	if (conn->mode >= IEEE80211_CONN_MODE_EHT &&
+	    !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
+				     IEEE80211_CHAN_NO_EHT)) {
+		conn->mode = IEEE80211_CONN_MODE_HE;
+		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+				       conn->bw_limit,
+				       IEEE80211_CONN_BW_LIMIT_160);
+	}
 
-	if (chandef->width != vht_chandef.width && !tracking)
+	if (chandef->width != ap_chandef.width || ap_mode != conn->mode)
 		sdata_info(sdata,
-			   "capabilities/regulatory prevented using AP HT/VHT configuration, downgraded\n");
+			   "regulatory prevented using AP config, downgraded\n");
 
-	WARN_ON_ONCE(!cfg80211_chandef_valid(chandef));
-	return ret;
+	if (conn->mode >= IEEE80211_CONN_MODE_HE &&
+	    (!ieee80211_verify_peer_he_mcs_support(sdata, (void *)elems->he_cap,
+						   elems->he_operation) ||
+	     !ieee80211_verify_sta_he_mcs_support(sdata, sband,
+						  elems->he_operation))) {
+		conn->mode = IEEE80211_CONN_MODE_VHT;
+		sdata_info(sdata, "required MCSes not supported, disabling HE\n");
+	}
+
+	if (conn->mode >= IEEE80211_CONN_MODE_EHT &&
+	    !ieee80211_verify_sta_eht_mcs_support(sdata, sband,
+						  elems->eht_operation)) {
+		conn->mode = IEEE80211_CONN_MODE_HE;
+		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+				       conn->bw_limit,
+				       IEEE80211_CONN_BW_LIMIT_160);
+		sdata_info(sdata, "required MCSes not supported, disabling EHT\n");
+	}
+
+	if (conn->mode >= IEEE80211_CONN_MODE_EHT) {
+		const struct ieee80211_eht_operation *eht_oper;
+
+		eht_oper = elems->eht_operation;
+
+		if (WARN_ON_ONCE(!eht_oper)) {
+			ret = -EINVAL;
+			goto free;
+		}
+
+		if (eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT &&
+		    eht_oper->params & IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT) {
+			const struct ieee80211_eht_operation_info *info =
+				(void *)eht_oper->optional;
+			const u8 *disable_subchannel_bitmap = info->optional;
+			u16 bitmap;
+
+			bitmap = get_unaligned_le16(disable_subchannel_bitmap);
+			if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
+								      &ap_chandef)) {
+				conn->mode = IEEE80211_CONN_MODE_HE;
+				conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+						       conn->bw_limit,
+						       IEEE80211_CONN_BW_LIMIT_160);
+				sdata_info(sdata,
+					   "AP has invalid puncturing, disabling EHT\n");
+			}
+			/* FIXME: store puncturing bitmap */
+		}
+	}
+
+	/* the mode can only decrease, so this must terminate */
+	if (ap_mode != conn->mode)
+		goto again;
+
+	mlme_link_id_dbg(sdata, link_id,
+			 "connecting with %s mode, max bandwidth %d MHz\n",
+			 ieee80211_conn_mode_str(conn->mode),
+			 20 * (1 << conn->bw_limit));
+
+	if (WARN_ON_ONCE(!cfg80211_chandef_valid(chandef))) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	return elems;
+free:
+	kfree(elems);
+	return ERR_PTR(ret);
+}
+
+static enum ieee80211_conn_bw_limit
+ieee80211_min_bw_limit_from_chandef(struct cfg80211_chan_def *chandef)
+{
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		return IEEE80211_CONN_BW_LIMIT_20;
+	case NL80211_CHAN_WIDTH_40:
+		return IEEE80211_CONN_BW_LIMIT_40;
+	case NL80211_CHAN_WIDTH_80:
+		return IEEE80211_CONN_BW_LIMIT_80;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+		return IEEE80211_CONN_BW_LIMIT_160;
+	case NL80211_CHAN_WIDTH_320:
+		return IEEE80211_CONN_BW_LIMIT_320;
+	default:
+		WARN(1, "unhandled chandef width %d\n", chandef->width);
+		return IEEE80211_CONN_BW_LIMIT_20;
+	}
 }
 
 static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			       struct ieee802_11_elems *elems,
-			       const u8 *bssid, u64 *changed)
+			       u64 *changed)
 {
-	const struct ieee80211_vht_cap *vht_cap = elems->vht_cap_elem;
-	const struct ieee80211_ht_operation *ht_oper = elems->ht_operation;
-	const struct ieee80211_vht_operation *vht_oper = elems->vht_operation;
-	const struct ieee80211_he_operation *he_oper = elems->he_operation;
-	const struct ieee80211_eht_operation *eht_oper = elems->eht_operation;
-	const struct ieee80211_s1g_oper_ie *s1g_oper = elems->s1g_oper;
+	struct ieee80211_channel *channel = link->conf->chandef.chan;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	struct ieee80211_channel *chan = link->conf->chandef.chan;
-	struct ieee80211_supported_band *sband =
-		local->hw.wiphy->bands[chan->band];
-	struct cfg80211_chan_def chandef;
-	u16 ht_opmode;
-	ieee80211_conn_flags_t flags;
+	struct cfg80211_chan_def ap_chandef;
+	enum ieee80211_conn_mode ap_mode;
 	u32 vht_cap_info = 0;
+	u16 ht_opmode;
 	int ret;
 
-	/* if HT was/is disabled, don't track any bandwidth changes */
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT || !ht_oper)
+	/* don't track any bandwidth changes in legacy mode */
+	if (link->u.mgd.conn.mode == IEEE80211_CONN_MODE_LEGACY)
 		return 0;
 
-	/* don't check VHT if we associated as non-VHT station */
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
-		vht_oper = NULL;
+	if (elems->vht_cap_elem)
+		vht_cap_info = le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
 
-	/* don't check HE if we associated as non-HE station */
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE ||
-	    !ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif)) {
-		he_oper = NULL;
-		eht_oper = NULL;
+	ap_mode = ieee80211_determine_ap_chan(sdata, channel, vht_cap_info,
+					      elems, true, &link->u.mgd.conn,
+					      &ap_chandef);
+
+	if (ap_mode != link->u.mgd.conn.mode) {
+		link_info(link,
+			  "AP appears to change mode (expected %s, found %s), disconnect\n",
+			  ieee80211_conn_mode_str(link->u.mgd.conn.mode),
+			  ieee80211_conn_mode_str(ap_mode));
+		return -EINVAL;
 	}
 
-	/* don't check EHT if we associated as non-EHT station */
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT ||
-	    !ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif))
-		eht_oper = NULL;
-
 	/*
-	 * if bss configuration changed store the new one -
+	 * if HT operation mode changed store the new one -
 	 * this may be applicable even if channel is identical
 	 */
-	ht_opmode = le16_to_cpu(ht_oper->operation_mode);
-	if (link->conf->ht_operation_mode != ht_opmode) {
-		*changed |= BSS_CHANGED_HT;
-		link->conf->ht_operation_mode = ht_opmode;
+	if (elems->ht_operation) {
+		ht_opmode = le16_to_cpu(elems->ht_operation->operation_mode);
+		if (link->conf->ht_operation_mode != ht_opmode) {
+			*changed |= BSS_CHANGED_HT;
+			link->conf->ht_operation_mode = ht_opmode;
+		}
 	}
 
-	if (vht_cap)
-		vht_cap_info = le32_to_cpu(vht_cap->vht_cap_info);
-
-	/* calculate new channel (type) based on HT/VHT/HE operation IEs */
-	flags = ieee80211_determine_chantype(sdata, link,
-					     link->u.mgd.conn_flags,
-					     sband, chan, vht_cap_info,
-					     ht_oper, vht_oper,
-					     he_oper, eht_oper,
-					     s1g_oper, &chandef, true);
-
 	/*
 	 * Downgrade the new channel if we associated with restricted
-	 * capabilities. For example, if we associated as a 20 MHz STA
-	 * to a 40 MHz AP (due to regulatory, capabilities or config
-	 * reasons) then switching to a 40 MHz channel now won't do us
-	 * any good -- we couldn't use it with the AP.
+	 * bandwidth capabilities. For example, if we associated as a
+	 * 20 MHz STA to a 40 MHz AP (due to regulatory, capabilities
+	 * or config reasons) then switching to a 40 MHz channel now
+	 * won't do us any good -- we couldn't use it with the AP.
 	 */
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ &&
-	    chandef.width == NL80211_CHAN_WIDTH_80P80)
-		flags |= ieee80211_chandef_downgrade(&chandef);
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_160MHZ &&
-	    chandef.width == NL80211_CHAN_WIDTH_160)
-		flags |= ieee80211_chandef_downgrade(&chandef);
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ &&
-	    chandef.width > NL80211_CHAN_WIDTH_20)
-		flags |= ieee80211_chandef_downgrade(&chandef);
+	while (link->u.mgd.conn.bw_limit <
+			ieee80211_min_bw_limit_from_chandef(&ap_chandef))
+		ieee80211_chandef_downgrade(&ap_chandef, NULL);
 
-	if (cfg80211_chandef_identical(&chandef, &link->conf->chandef))
+	if (cfg80211_chandef_identical(&ap_chandef, &link->conf->chandef))
 		return 0;
 
 	link_info(link,
 		  "AP %pM changed bandwidth, new config is %d.%03d MHz, width %d (%d.%03d/%d MHz)\n",
-		  link->u.mgd.bssid, chandef.chan->center_freq,
-		  chandef.chan->freq_offset, chandef.width,
-		  chandef.center_freq1, chandef.freq1_offset,
-		  chandef.center_freq2);
+		  link->u.mgd.bssid, ap_chandef.chan->center_freq,
+		  ap_chandef.chan->freq_offset, ap_chandef.width,
+		  ap_chandef.center_freq1, ap_chandef.freq1_offset,
+		  ap_chandef.center_freq2);
 
-	if (flags != (link->u.mgd.conn_flags &
-				(IEEE80211_CONN_DISABLE_HT |
-				 IEEE80211_CONN_DISABLE_VHT |
-				 IEEE80211_CONN_DISABLE_HE |
-				 IEEE80211_CONN_DISABLE_EHT |
-				 IEEE80211_CONN_DISABLE_40MHZ |
-				 IEEE80211_CONN_DISABLE_80P80MHZ |
-				 IEEE80211_CONN_DISABLE_160MHZ |
-				 IEEE80211_CONN_DISABLE_320MHZ)) ||
-	    !cfg80211_chandef_valid(&chandef)) {
+	if (!cfg80211_chandef_valid(&ap_chandef)) {
 		sdata_info(sdata,
-			   "AP %pM changed caps/bw in a way we can't support (0x%x/0x%x) - disconnect\n",
-			   link->u.mgd.bssid, flags, ifmgd->flags);
+			   "AP %pM changed caps/bw in a way we can't support - disconnect\n",
+			   link->u.mgd.bssid);
 		return -EINVAL;
 	}
 
-	ret = ieee80211_link_change_bandwidth(link, &chandef, changed);
+	/*
+	 * We're tracking the current AP here, so don't do any further checks
+	 * here. This keeps us from playing ping-pong with regulatory, without
+	 * it the following can happen (for example):
+	 *  - connect to an AP with 80 MHz, world regdom allows 80 MHz
+	 *  - AP advertises regdom US
+	 *  - CRDA loads regdom US with 80 MHz prohibited (old database)
+	 *  - we detect an unsupported channel and disconnect
+	 *  - disconnect causes CRDA to reload world regdomain and the game
+	 *    starts anew.
+	 * (see https://bugzilla.kernel.org/show_bug.cgi?id=70881)
+	 *
+	 * It seems possible that there are still scenarios with CSA or real
+	 * bandwidth changes where a this could happen, but those cases are
+	 * less common and wouldn't completely prevent using the AP.
+	 */
 
+	ret = ieee80211_link_change_bandwidth(link, &ap_chandef, changed);
 	if (ret) {
 		sdata_info(sdata,
 			   "AP %pM changed bandwidth to incompatible one - disconnect\n",
@@ -605,7 +1002,7 @@ static void ieee80211_add_ht_ie(struct ieee80211_sub_if_data *sdata,
 				struct ieee80211_supported_band *sband,
 				struct ieee80211_channel *channel,
 				enum ieee80211_smps_mode smps,
-				ieee80211_conn_flags_t conn_flags)
+				const struct ieee80211_conn_settings *conn)
 {
 	u8 *pos;
 	u32 flags = channel->flags;
@@ -640,7 +1037,7 @@ static void ieee80211_add_ht_ie(struct ieee80211_sub_if_data *sdata,
 	 * capable of 40 MHz -- some broken APs will never fall
 	 * back to trying to transmit in 20 MHz.
 	 */
-	if (conn_flags & IEEE80211_CONN_DISABLE_40MHZ) {
+	if (conn->bw_limit <= IEEE80211_CONN_BW_LIMIT_20) {
 		cap &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 		cap &= ~IEEE80211_HT_CAP_SGI_40;
 	}
@@ -679,7 +1076,7 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb,
 				 struct ieee80211_supported_band *sband,
 				 struct ieee80211_vht_cap *ap_vht_cap,
-				 ieee80211_conn_flags_t conn_flags)
+				 const struct ieee80211_conn_settings *conn)
 {
 	struct ieee80211_local *local = sdata->local;
 	u8 *pos;
@@ -696,16 +1093,7 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 	/* determine capability flags */
 	cap = vht_cap.cap;
 
-	if (conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ) {
-		u32 bw = cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-
-		cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-		if (bw == IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ ||
-		    bw == IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
-			cap |= IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ;
-	}
-
-	if (conn_flags & IEEE80211_CONN_DISABLE_160MHZ) {
+	if (conn->bw_limit <= IEEE80211_CONN_BW_LIMIT_80) {
 		cap &= ~IEEE80211_VHT_CAP_SHORT_GI_160;
 		cap &= ~IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
 	}
@@ -769,7 +1157,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb,
 				struct ieee80211_supported_band *sband,
 				enum ieee80211_smps_mode smps_mode,
-				ieee80211_conn_flags_t conn_flags)
+				const struct ieee80211_conn_settings *conn)
 {
 	u8 *pos, *pre_he_pos;
 	const struct ieee80211_sta_he_cap *he_cap;
@@ -787,8 +1175,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 				      he_cap->he_cap_elem.phy_cap_info);
 	pos = skb_put(skb, he_cap_size);
 	pre_he_pos = pos;
-	pos = ieee80211_ie_build_he_cap(conn_flags,
-					pos, he_cap, pos + he_cap_size);
+	pos = ieee80211_ie_build_he_cap(conn, he_cap, pos, pos + he_cap_size);
 	/* trim excess if any */
 	skb_trim(skb, skb->len - (pre_he_pos + he_cap_size - pos));
 
@@ -1126,11 +1513,11 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 					       offset);
 
 	if (sband->band != NL80211_BAND_6GHZ &&
-	    !(assoc_data->link[link_id].conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+	    assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_HT) {
 		ieee80211_add_ht_ie(sdata, skb,
 				    assoc_data->link[link_id].ap_ht_param,
 				    sband, chan, smps_mode,
-				    assoc_data->link[link_id].conn_flags);
+				    &assoc_data->link[link_id].conn);
 		ADD_PRESENT_ELEM(WLAN_EID_HT_CAPABILITY);
 	}
 
@@ -1140,36 +1527,25 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 						offset);
 
 	if (sband->band != NL80211_BAND_6GHZ &&
-	    !(assoc_data->link[link_id].conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
+	    assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_VHT) {
 		bool mu_mimo_owner =
 			ieee80211_add_vht_ie(sdata, skb, sband,
 					     &assoc_data->link[link_id].ap_vht_cap,
-					     assoc_data->link[link_id].conn_flags);
+					     &assoc_data->link[link_id].conn);
 
 		if (link)
 			link->conf->mu_mimo_owner = mu_mimo_owner;
 		ADD_PRESENT_ELEM(WLAN_EID_VHT_CAPABILITY);
 	}
 
-	/*
-	 * If AP doesn't support HT, mark HE and EHT as disabled.
-	 * If on the 5GHz band, make sure it supports VHT.
-	 */
-	if (assoc_data->link[link_id].conn_flags & IEEE80211_CONN_DISABLE_HT ||
-	    (sband->band == NL80211_BAND_5GHZ &&
-	     assoc_data->link[link_id].conn_flags & IEEE80211_CONN_DISABLE_VHT))
-		assoc_data->link[link_id].conn_flags |=
-			IEEE80211_CONN_DISABLE_HE |
-			IEEE80211_CONN_DISABLE_EHT;
-
 	/* if present, add any custom IEs that go before HE */
 	offset = ieee80211_add_before_he_elems(skb, extra_elems,
 					       extra_elems_len,
 					       offset);
 
-	if (!(assoc_data->link[link_id].conn_flags & IEEE80211_CONN_DISABLE_HE)) {
+	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_HE) {
 		ieee80211_add_he_ie(sdata, skb, sband, smps_mode,
-				    assoc_data->link[link_id].conn_flags);
+				    &assoc_data->link[link_id].conn);
 		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_HE_CAPABILITY);
 	}
 
@@ -1178,7 +1554,7 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 	 * calling ieee80211_assoc_add_ml_elem(), so add this one if
 	 * we're going to put it after the ML element
 	 */
-	if (!(assoc_data->link[link_id].conn_flags & IEEE80211_CONN_DISABLE_EHT))
+	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_EHT)
 		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_EHT_CAPABILITY);
 
 	if (link_id == assoc_data->assoc_link_id)
@@ -1188,7 +1564,7 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 	/* crash if somebody gets it wrong */
 	present_elems = NULL;
 
-	if (!(assoc_data->link[link_id].conn_flags & IEEE80211_CONN_DISABLE_EHT))
+	if (assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_EHT)
 		ieee80211_add_eht_ie(sdata, skb, sband);
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
@@ -1199,9 +1575,6 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 	if (iftd && iftd->vendor_elems.data && iftd->vendor_elems.len)
 		skb_put_data(skb, iftd->vendor_elems.data, iftd->vendor_elems.len);
 
-	if (link)
-		link->u.mgd.conn_flags = assoc_data->link[link_id].conn_flags;
-
 	return offset;
 }
 
@@ -1492,7 +1865,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	/* Set MBSSID support for HE AP if needed */
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_ONLY_HE_MULTI_BSSID) &&
-	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HE &&
 	    ext_capa && ext_capa->datalen >= 3)
 		ext_capa->data[2] |= WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
 
@@ -1858,7 +2231,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	bss = (void *)cbss->priv;
 	res = ieee80211_parse_ch_switch_ie(sdata, elems, current_band,
 					   bss->vht_cap_info,
-					   link->u.mgd.conn_flags,
+					   &link->u.mgd.conn,
 					   link->u.mgd.bssid, &csa_ie);
 
 	if (!res) {
@@ -3038,8 +3411,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.u.mgd.tracking_signal_avg = false;
 	sdata->deflink.u.mgd.disable_wmm_tracking = false;
 
+	sdata->vif.bss_conf.eht_puncturing = 0;
+
 	ifmgd->flags = 0;
-	sdata->deflink.u.mgd.conn_flags = 0;
 
 	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
 		struct ieee80211_link_data *link;
@@ -3502,7 +3876,6 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 		sta_info_destroy_addr(sdata, auth_data->ap_addr);
 
 		/* other links are destroyed */
-		sdata->deflink.u.mgd.conn_flags = 0;
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_BSSID);
@@ -3540,7 +3913,6 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		del_timer_sync(&sdata->u.mgd.timer);
 		sta_info_destroy_addr(sdata, assoc_data->ap_addr);
 
-		sdata->deflink.u.mgd.conn_flags = 0;
 		eth_zero_addr(sdata->deflink.u.mgd.bssid);
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  BSS_CHANGED_BSSID);
@@ -3990,11 +4362,13 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	unsigned int link_id = link->link_id;
 	struct ieee80211_elems_parse_params parse_params = {
+		.mode = IEEE80211_CONN_MODE_HIGHEST, // FIXME
 		.start = elem_start,
 		.len = elem_len,
 		.link_id = link_id == assoc_data->assoc_link_id ? -1 : link_id,
 		.from_ap = true,
 	};
+	bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
 	const struct cfg80211_bss_ies *bss_ies = NULL;
@@ -4070,9 +4444,9 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	 */
 	if (!is_6ghz &&
 	    ((assoc_data->wmm && !elems->wmm_param) ||
-	     (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
+	     (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT &&
 	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
-	     (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
+	     (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
 		struct ieee802_11_elems *bss_elems;
@@ -4109,25 +4483,25 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		 * have to include the IEs in the (re)association response.
 		 */
 		if (!elems->ht_cap_elem && bss_elems->ht_cap_elem &&
-		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+		    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT) {
 			elems->ht_cap_elem = bss_elems->ht_cap_elem;
 			sdata_info(sdata,
 				   "AP bug: HT capability missing from AssocResp\n");
 		}
 		if (!elems->ht_operation && bss_elems->ht_operation &&
-		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+		    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT) {
 			elems->ht_operation = bss_elems->ht_operation;
 			sdata_info(sdata,
 				   "AP bug: HT operation missing from AssocResp\n");
 		}
 		if (!elems->vht_cap_elem && bss_elems->vht_cap_elem &&
-		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
+		    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
 			elems->vht_cap_elem = bss_elems->vht_cap_elem;
 			sdata_info(sdata,
 				   "AP bug: VHT capa missing from AssocResp\n");
 		}
 		if (!elems->vht_operation && bss_elems->vht_operation &&
-		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
+		    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
 			elems->vht_operation = bss_elems->vht_operation;
 			sdata_info(sdata,
 				   "AP bug: VHT operation missing from AssocResp\n");
@@ -4140,7 +4514,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	 * We previously checked these in the beacon/probe response, so
 	 * they should be present here. This is just a safety net.
 	 */
-	if (!is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
+	if (!is_6ghz && link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT &&
 	    (!elems->wmm_param || !elems->ht_cap_elem || !elems->ht_operation)) {
 		sdata_info(sdata,
 			   "HT AP is missing WMM params or HT capability/operation\n");
@@ -4148,7 +4522,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		goto out;
 	}
 
-	if (!is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
+	if (is_5ghz && link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT &&
 	    (!elems->vht_cap_elem || !elems->vht_operation)) {
 		sdata_info(sdata,
 			   "VHT AP is missing VHT capability/operation\n");
@@ -4156,36 +4530,20 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		goto out;
 	}
 
-	if (is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
-	    !elems->he_6ghz_capa) {
-		sdata_info(sdata,
-			   "HE 6 GHz AP is missing HE 6 GHz band capability\n");
-		ret = false;
-		goto out;
-	}
-
 	if (WARN_ON(!link->conf->chandef.chan)) {
 		ret = false;
 		goto out;
 	}
 	sband = local->hw.wiphy->bands[link->conf->chandef.chan->band];
 
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
-	    (!elems->he_cap || !elems->he_operation)) {
-		sdata_info(sdata,
-			   "HE AP is missing HE capability/operation\n");
-		ret = false;
-		goto out;
-	}
-
 	/* Set up internal HT/VHT capabilities */
-	if (elems->ht_cap_elem && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
+	if (elems->ht_cap_elem && link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT)
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
 						  elems->ht_cap_elem,
 						  link_sta);
 
 	if (elems->vht_cap_elem &&
-	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
+	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
 		const struct ieee80211_vht_cap *bss_vht_cap = NULL;
 		const struct cfg80211_bss_ies *ies;
 
@@ -4212,7 +4570,8 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		rcu_read_unlock();
 	}
 
-	if (elems->he_operation && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	if (elems->he_operation &&
+	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HE &&
 	    elems->he_cap) {
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
 						  elems->he_cap,
@@ -4233,7 +4592,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 						     link_sta, elems);
 
 		if (elems->eht_operation && elems->eht_cap &&
-		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)) {
+		    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_EHT) {
 			ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
 							    elems->he_cap,
 							    elems->he_cap_len,
@@ -4440,7 +4799,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 	bool support_160;
 	u8 chains = 1;
 
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)
+	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_HT)
 		return chains;
 
 	ht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_HT_CAPABILITY);
@@ -4453,7 +4812,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 		 */
 	}
 
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
+	if (link->u.mgd.conn.mode <= IEEE80211_CONN_MODE_VHT)
 		return chains;
 
 	vht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_VHT_CAPABILITY);
@@ -4472,7 +4831,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 		chains = max(chains, nss);
 	}
 
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)
+	if (link->u.mgd.conn.mode & IEEE80211_CONN_MODE_HE)
 		return chains;
 
 	ies = rcu_dereference(cbss->ies);
@@ -4523,465 +4882,278 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 	return chains;
 }
 
-static bool
-ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
-				     const struct ieee80211_he_cap_elem *he_cap,
-				     const struct ieee80211_he_operation *he_op)
+static void
+ieee80211_determine_our_sta_mode(struct ieee80211_sub_if_data *sdata,
+				 struct ieee80211_supported_band *sband,
+				 struct cfg80211_assoc_request *req,
+				 bool wmm_used, int link_id,
+				 struct ieee80211_conn_settings *conn)
 {
-	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
-	u16 mcs_80_map_tx, mcs_80_map_rx;
-	u16 ap_min_req_set;
-	int nss;
-
-	if (!he_cap)
-		return false;
-
-	/* mcs_nss is right after he_cap info */
-	he_mcs_nss_supp = (void *)(he_cap + 1);
-
-	mcs_80_map_tx = le16_to_cpu(he_mcs_nss_supp->tx_mcs_80);
-	mcs_80_map_rx = le16_to_cpu(he_mcs_nss_supp->rx_mcs_80);
-
-	/* P802.11-REVme/D0.3
-	 * 27.1.1 Introduction to the HE PHY
-	 * ...
-	 * An HE STA shall support the following features:
-	 * ...
-	 * Single spatial stream HE-MCSs 0 to 7 (transmit and receive) in all
-	 * supported channel widths for HE SU PPDUs
-	 */
-	if ((mcs_80_map_tx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-	    (mcs_80_map_rx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED) {
-		sdata_info(sdata,
-			   "Missing mandatory rates for 1 Nss, rx 0x%x, tx 0x%x, disable HE\n",
-			   mcs_80_map_tx, mcs_80_map_rx);
-		return false;
+	struct ieee80211_sta_ht_cap sta_ht_cap = sband->ht_cap;
+	bool is_5ghz = sband->band == NL80211_BAND_5GHZ;
+	bool is_6ghz = sband->band == NL80211_BAND_6GHZ;
+	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	struct ieee80211_sta_vht_cap vht_cap;
+
+	if (sband->band == NL80211_BAND_S1GHZ) {
+		conn->mode = IEEE80211_CONN_MODE_S1G;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
+		mlme_dbg(sdata, "operating as S1G STA\n");
+		return;
 	}
 
-	if (!he_op)
-		return true;
-
-	ap_min_req_set = le16_to_cpu(he_op->he_mcs_nss_set);
-
-	/*
-	 * Apparently iPhone 13 (at least iOS version 15.3.1) sets this to all
-	 * zeroes, which is nonsense, and completely inconsistent with itself
-	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
-	 */
-	if (!ap_min_req_set)
-		return true;
-
-	/* make sure the AP is consistent with itself
-	 *
-	 * P802.11-REVme/D0.3
-	 * 26.17.1 Basic HE BSS operation
-	 *
-	 * A STA that is operating in an HE BSS shall be able to receive and
-	 * transmit at each of the <HE-MCS, NSS> tuple values indicated by the
-	 * Basic HE-MCS And NSS Set field of the HE Operation parameter of the
-	 * MLME-START.request primitive and shall be able to receive at each of
-	 * the <HE-MCS, NSS> tuple values indicated by the Supported HE-MCS and
-	 * NSS Set field in the HE Capabilities parameter of the MLMESTART.request
-	 * primitive
-	 */
-	for (nss = 8; nss > 0; nss--) {
-		u8 ap_op_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
-		u8 ap_rx_val;
-		u8 ap_tx_val;
-
-		if (ap_op_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
-			continue;
+	conn->mode = IEEE80211_CONN_MODE_LEGACY;
+	conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
 
-		ap_rx_val = (mcs_80_map_rx >> (2 * (nss - 1))) & 3;
-		ap_tx_val = (mcs_80_map_tx >> (2 * (nss - 1))) & 3;
+	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
 
-		if (ap_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-		    ap_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-		    ap_rx_val < ap_op_val || ap_tx_val < ap_op_val) {
-			sdata_info(sdata,
-				   "Invalid rates for %d Nss, rx %d, tx %d oper %d, disable HE\n",
-				   nss, ap_rx_val, ap_rx_val, ap_op_val);
-			return false;
-		}
+        if (req && req->flags & ASSOC_REQ_DISABLE_HT) {
+		mlme_link_id_dbg(sdata, link_id,
+				 "HT disabled by flag, limiting to legacy\n");
+		goto out;
 	}
 
-	return true;
-}
-
-static bool
-ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
-				    struct ieee80211_supported_band *sband,
-				    const struct ieee80211_he_operation *he_op)
-{
-	const struct ieee80211_sta_he_cap *sta_he_cap =
-		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
-	u16 ap_min_req_set;
-	int i;
-
-	if (!sta_he_cap || !he_op)
-		return false;
-
-	ap_min_req_set = le16_to_cpu(he_op->he_mcs_nss_set);
-
-	/*
-	 * Apparently iPhone 13 (at least iOS version 15.3.1) sets this to all
-	 * zeroes, which is nonsense, and completely inconsistent with itself
-	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
-	 */
-	if (!ap_min_req_set)
-		return true;
-
-	/* Need to go over for 80MHz, 160MHz and for 80+80 */
-	for (i = 0; i < 3; i++) {
-		const struct ieee80211_he_mcs_nss_supp *sta_mcs_nss_supp =
-			&sta_he_cap->he_mcs_nss_supp;
-		u16 sta_mcs_map_rx =
-			le16_to_cpu(((__le16 *)sta_mcs_nss_supp)[2 * i]);
-		u16 sta_mcs_map_tx =
-			le16_to_cpu(((__le16 *)sta_mcs_nss_supp)[2 * i + 1]);
-		u8 nss;
-		bool verified = true;
-
-		/*
-		 * For each band there is a maximum of 8 spatial streams
-		 * possible. Each of the sta_mcs_map_* is a 16-bit struct built
-		 * of 2 bits per NSS (1-8), with the values defined in enum
-		 * ieee80211_he_mcs_support. Need to make sure STA TX and RX
-		 * capabilities aren't less than the AP's minimum requirements
-		 * for this HE BSS per SS.
-		 * It is enough to find one such band that meets the reqs.
-		 */
-		for (nss = 8; nss > 0; nss--) {
-			u8 sta_rx_val = (sta_mcs_map_rx >> (2 * (nss - 1))) & 3;
-			u8 sta_tx_val = (sta_mcs_map_tx >> (2 * (nss - 1))) & 3;
-			u8 ap_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
+	if (!wmm_used) {
+		mlme_dbg(sdata, "WMM/QoS not supported, limiting to legacy\n");
+		goto out;
+	}
 
-			if (ap_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
-				continue;
+	if (req) {
+		unsigned int i;
 
-			/*
-			 * Make sure the HE AP doesn't require MCSs that aren't
-			 * supported by the client as required by spec
-			 *
-			 * P802.11-REVme/D0.3
-			 * 26.17.1 Basic HE BSS operation
-			 *
-			 * An HE STA shall not attempt to join * (MLME-JOIN.request primitive)
-			 * a BSS, unless it supports (i.e., is able to both transmit and
-			 * receive using) all of the <HE-MCS, NSS> tuples in the basic
-			 * HE-MCS and NSS set.
-			 */
-			if (sta_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-			    sta_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-			    (ap_val > sta_rx_val) || (ap_val > sta_tx_val)) {
-				verified = false;
-				break;
+		for (i = 0; i < req->crypto.n_ciphers_pairwise; i++) {
+			if (req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_WEP40 ||
+			    req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_TKIP ||
+			    req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_WEP104) {
+				netdev_info(sdata->dev,
+					    "WEP/TKIP use, limiting to legacy\n");
+				goto out;
 			}
 		}
+	}
 
-		if (verified)
-			return true;
+	if (!sta_ht_cap.ht_supported && !is_6ghz) {
+		mlme_dbg(sdata,
+			 "HT not supported (and not on 6 GHz), limiting to legacy\n");
+		goto out;
 	}
 
-	/* If here, STA doesn't meet AP's HE min requirements */
-	return false;
-}
-
-static u8
-ieee80211_get_eht_cap_mcs_nss(const struct ieee80211_sta_he_cap *sta_he_cap,
-			      const struct ieee80211_sta_eht_cap *sta_eht_cap,
-			      unsigned int idx, int bw)
-{
-	u8 he_phy_cap0 = sta_he_cap->he_cap_elem.phy_cap_info[0];
-	u8 eht_phy_cap0 = sta_eht_cap->eht_cap_elem.phy_cap_info[0];
-
-	/* handle us being a 20 MHz-only EHT STA - with four values
-	 * for MCS 0-7, 8-9, 10-11, 12-13.
-	 */
-	if (!(he_phy_cap0 & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL))
-		return sta_eht_cap->eht_mcs_nss_supp.only_20mhz.rx_tx_max_nss[idx];
-
-	/* the others have MCS 0-9 together, rather than separately from 0-7 */
-	if (idx > 0)
-		idx--;
-
-	switch (bw) {
-	case 0:
-		return sta_eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_max_nss[idx];
-	case 1:
-		if (!(he_phy_cap0 &
-		      (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
-		       IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)))
-			return 0xff; /* pass check */
-		return sta_eht_cap->eht_mcs_nss_supp.bw._160.rx_tx_max_nss[idx];
-	case 2:
-		if (!(eht_phy_cap0 & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ))
-			return 0xff; /* pass check */
-		return sta_eht_cap->eht_mcs_nss_supp.bw._320.rx_tx_max_nss[idx];
+	/* HT is fine */
+	conn->mode = IEEE80211_CONN_MODE_HT;
+	conn->bw_limit = sta_ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
+		IEEE80211_CONN_BW_LIMIT_40 :
+		IEEE80211_CONN_BW_LIMIT_20;
+
+	memcpy(&vht_cap, &sband->vht_cap, sizeof(vht_cap));
+	ieee80211_apply_vhtcap_overrides(sdata, &vht_cap);
+
+	if (vht_cap.vht_supported && is_5ghz) {
+		bool have_80mhz = false;
+		unsigned int i;
+
+		if (conn->bw_limit == IEEE80211_CONN_BW_LIMIT_20) {
+			mlme_link_id_dbg(sdata, link_id,
+					 "no 40 MHz support on 5 GHz, limiting to HT\n");
+			goto out;
+		}
+
+		/* Allow VHT if at least one channel on the sband supports 80 MHz */
+		for (i = 0; i < sband->n_channels; i++) {
+			if (sband->channels[i].flags & (IEEE80211_CHAN_DISABLED |
+							IEEE80211_CHAN_NO_80MHZ))
+				continue;
+
+			have_80mhz = true;
+			break;
+		}
+
+		if (!have_80mhz) {
+			mlme_link_id_dbg(sdata, link_id,
+					 "no 80 MHz channel support on 5 GHz, limiting to HT\n");
+			goto out;
+		}
+	} else if (is_5ghz) { /* !vht_supported but on 5 GHz */
+		mlme_link_id_dbg(sdata, link_id,
+				 "no VHT support on 5 GHz, limiting to HT\n");
+		goto out;
 	}
 
-	WARN_ON(1);
-	return 0;
-}
-
-static bool
-ieee80211_verify_sta_eht_mcs_support(struct ieee80211_sub_if_data *sdata,
-				     struct ieee80211_supported_band *sband,
-				     const struct ieee80211_eht_operation *eht_op)
-{
-	const struct ieee80211_sta_he_cap *sta_he_cap =
-		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
-	const struct ieee80211_sta_eht_cap *sta_eht_cap =
-		ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
-	const struct ieee80211_eht_mcs_nss_supp_20mhz_only *req;
-	unsigned int i;
-
-	if (!sta_he_cap || !sta_eht_cap || !eht_op)
-		return false;
-
-	req = &eht_op->basic_mcs_nss;
-
-	for (i = 0; i < ARRAY_SIZE(req->rx_tx_max_nss); i++) {
-		u8 req_rx_nss, req_tx_nss;
-		unsigned int bw;
-
-		req_rx_nss = u8_get_bits(req->rx_tx_max_nss[i],
-					 IEEE80211_EHT_MCS_NSS_RX);
-		req_tx_nss = u8_get_bits(req->rx_tx_max_nss[i],
-					 IEEE80211_EHT_MCS_NSS_TX);
-
-		for (bw = 0; bw < 3; bw++) {
-			u8 have, have_rx_nss, have_tx_nss;
-
-			have = ieee80211_get_eht_cap_mcs_nss(sta_he_cap,
-							     sta_eht_cap,
-							     i, bw);
-			have_rx_nss = u8_get_bits(have,
-						  IEEE80211_EHT_MCS_NSS_RX);
-			have_tx_nss = u8_get_bits(have,
-						  IEEE80211_EHT_MCS_NSS_TX);
-
-			if (req_rx_nss > have_rx_nss ||
-			    req_tx_nss > have_tx_nss)
-				return false;
+        if (req && req->flags & ASSOC_REQ_DISABLE_VHT) {
+		mlme_link_id_dbg(sdata, link_id,
+				 "VHT disabled by flag, limiting to HT\n");
+		goto out;
+	}
+
+	/* VHT - if we have - is fine, including 80 MHz, check 160 below again */
+	conn->mode = IEEE80211_CONN_MODE_VHT;
+	if (sband->band != NL80211_BAND_2GHZ)
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_160;
+
+	if (is_5ghz &&
+	    !(vht_cap.cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
+			     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ))) {
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_80;
+		mlme_link_id_dbg(sdata, link_id,
+				 "no VHT 160 MHz capability on 5 GHz, limiting to 80 MHz");
+	}
+
+        if (req && req->flags & ASSOC_REQ_DISABLE_HE) {
+		mlme_dbg(sdata, "HE disabled by flag, limiting to VHT\n");
+		goto out;
+	}
+
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	if (!he_cap) {
+		WARN_ON(is_6ghz);
+		mlme_link_id_dbg(sdata, link_id,
+				 "no HE support, limiting to VHT\n");
+		goto out;
+	}
+
+	/* so we have HE */
+	conn->mode = IEEE80211_CONN_MODE_HE;
+
+	/* check bandwidth */
+	switch (sband->band) {
+	default:
+	case NL80211_BAND_2GHZ:
+		if (he_cap->he_cap_elem.phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
+			break;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
+		mlme_link_id_dbg(sdata, link_id,
+				 "no 40 MHz HE cap in 2.4 GHz, limiting to 20 MHz\n");
+		break;
+	case NL80211_BAND_5GHZ:
+		if (!(he_cap->he_cap_elem.phy_cap_info[0] &
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)) {
+			conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
+			mlme_link_id_dbg(sdata, link_id,
+					 "no 40/80 MHz HE cap in 5 GHz, limiting to 20 MHz\n");
+			break;
+		}
+		if (!(he_cap->he_cap_elem.phy_cap_info[0] &
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)) {
+			conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+					       conn->bw_limit,
+					       IEEE80211_CONN_BW_LIMIT_80);
+			mlme_link_id_dbg(sdata, link_id,
+					 "no 160 MHz HE cap in 5 GHz, limiting to 80 MHz\n");
 		}
+		break;
+	case NL80211_BAND_6GHZ:
+		if (he_cap->he_cap_elem.phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
+			break;
+		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+				       conn->bw_limit,
+				       IEEE80211_CONN_BW_LIMIT_80);
+		mlme_link_id_dbg(sdata, link_id,
+				 "no 160 MHz HE cap in 6 GHz, limiting to 80 MHz\n");
+		break;
+	}
+
+	if (req && req->flags & ASSOC_REQ_DISABLE_EHT) {
+		mlme_dbg(sdata, "EHT disabled by flag, limiting to HE\n");
+		goto out;
+	}
+
+	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
+	if (!eht_cap) {
+		mlme_link_id_dbg(sdata, link_id,
+				 "no EHT support, limiting to HE\n");
+		goto out;
+	}
+
+	/* we have EHT */
+        if (req && req->flags & ASSOC_REQ_DISABLE_EHT) {
+		mlme_dbg(sdata, "EHT disabled by flag, limiting to HE\n");
+		goto out;
 	}
 
-	return true;
+	conn->mode = IEEE80211_CONN_MODE_EHT;
+
+	/* check bandwidth */
+	if (is_6ghz &&
+	    eht_cap->eht_cap_elem.phy_cap_info[0] & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_320;
+	else if (is_6ghz)
+		mlme_link_id_dbg(sdata, link_id,
+				 "no EHT 320 MHz cap in 6 GHz, limiting to 160 MHz\n");
+
+out:
+	mlme_link_id_dbg(sdata, link_id,
+			 "determined local STA to be %s, BW limited to %d MHz\n",
+			 ieee80211_conn_mode_str(conn->mode),
+			 20 * (1 << conn->bw_limit));
 }
 
 static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_link_data *link,
-				  struct cfg80211_bss *cbss,
-				  bool mlo,
-				  ieee80211_conn_flags_t *conn_flags)
+				  int link_id,
+				  struct cfg80211_bss *cbss, bool mlo,
+				  struct ieee80211_conn_settings *conn)
 {
 	struct ieee80211_local *local = sdata->local;
-	const struct ieee80211_ht_cap *ht_cap = NULL;
-	const struct ieee80211_ht_operation *ht_oper = NULL;
-	const struct ieee80211_vht_operation *vht_oper = NULL;
-	const struct ieee80211_he_operation *he_oper = NULL;
-	const struct ieee80211_eht_operation *eht_oper = NULL;
-	const struct ieee80211_s1g_oper_ie *s1g_oper = NULL;
-	struct ieee80211_supported_band *sband;
 	struct cfg80211_chan_def chandef;
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
-	bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
-	bool supports_mlo = false;
-	struct ieee80211_bss *bss = (void *)cbss->priv;
-	struct ieee80211_elems_parse_params parse_params = {
-		.link_id = -1,
-		.from_ap = true,
-	};
 	struct ieee802_11_elems *elems;
-	const struct cfg80211_bss_ies *ies;
 	int ret;
 	u32 i;
-	bool have_80mhz;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	rcu_read_lock();
+	elems = ieee80211_determine_chan_mode(sdata, conn, cbss, link_id,
+					      &chandef);
 
-	ies = rcu_dereference(cbss->ies);
-	parse_params.start = ies->data;
-	parse_params.len = ies->len;
-	elems = ieee802_11_parse_elems_full(&parse_params);
-	if (!elems) {
+	if (IS_ERR(elems)) {
 		rcu_read_unlock();
-		return -ENOMEM;
+		return PTR_ERR(elems);
 	}
 
-	sband = local->hw.wiphy->bands[cbss->channel->band];
-
-	*conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
-			 IEEE80211_CONN_DISABLE_80P80MHZ |
-			 IEEE80211_CONN_DISABLE_160MHZ);
-
-	/* disable HT/VHT/HE if we don't support them */
-	if (!sband->ht_cap.ht_supported && !is_6ghz) {
-		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE/EHT\n");
-		*conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		*conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (!sband->vht_cap.vht_supported && is_5ghz) {
-		mlme_dbg(sdata, "VHT not supported, disabling VHT/HE/EHT\n");
-		*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		*conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (!ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif)) {
-		mlme_dbg(sdata, "HE not supported, disabling HE and EHT\n");
-		*conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (!ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif)) {
-		mlme_dbg(sdata, "EHT not supported, disabling EHT\n");
-		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (!(*conn_flags & IEEE80211_CONN_DISABLE_HT) && !is_6ghz) {
-		ht_oper = elems->ht_operation;
-		ht_cap = elems->ht_cap_elem;
-
-		if (!ht_cap) {
-			*conn_flags |= IEEE80211_CONN_DISABLE_HT;
-			ht_oper = NULL;
-		}
-	}
-
-	if (!(*conn_flags & IEEE80211_CONN_DISABLE_VHT) && !is_6ghz) {
-		vht_oper = elems->vht_operation;
-		if (vht_oper && !ht_oper) {
-			vht_oper = NULL;
-			sdata_info(sdata,
-				   "AP advertised VHT without HT, disabling HT/VHT/HE\n");
-			*conn_flags |= IEEE80211_CONN_DISABLE_HT;
-			*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-			*conn_flags |= IEEE80211_CONN_DISABLE_HE;
-			*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-		}
-
-		if (!elems->vht_cap_elem) {
-			*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-			vht_oper = NULL;
-		}
+	if (mlo && !elems->ml_basic) {
+		sdata_info(sdata, "Rejecting MLO as it is not supported by AP\n");
+		rcu_read_unlock();
+		return -EINVAL;
 	}
 
-	if (!(*conn_flags & IEEE80211_CONN_DISABLE_HE)) {
-		he_oper = elems->he_operation;
-
-		if (link && is_6ghz) {
-			struct ieee80211_bss_conf *bss_conf;
-			u8 j = 0;
+	if (link && is_6ghz && conn->mode >= IEEE80211_CONN_MODE_HE) {
+		struct ieee80211_bss_conf *bss_conf;
+		u8 j = 0;
 
-			bss_conf = link->conf;
+		bss_conf = link->conf;
 
-			if (elems->pwr_constr_elem)
-				bss_conf->pwr_reduction = *elems->pwr_constr_elem;
+		if (elems->pwr_constr_elem)
+			bss_conf->pwr_reduction = *elems->pwr_constr_elem;
 
-			BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
-				     ARRAY_SIZE(elems->tx_pwr_env));
+		BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
+			     ARRAY_SIZE(elems->tx_pwr_env));
 
-			for (i = 0; i < elems->tx_pwr_env_num; i++) {
-				if (elems->tx_pwr_env_len[i] >
-				    sizeof(bss_conf->tx_pwr_env[j]))
-					continue;
+		for (i = 0; i < elems->tx_pwr_env_num; i++) {
+			if (elems->tx_pwr_env_len[i] > sizeof(bss_conf->tx_pwr_env[j]))
+				continue;
 
-				bss_conf->tx_pwr_env_num++;
-				memcpy(&bss_conf->tx_pwr_env[j], elems->tx_pwr_env[i],
-				       elems->tx_pwr_env_len[i]);
-				j++;
-			}
+			bss_conf->tx_pwr_env_num++;
+			memcpy(&bss_conf->tx_pwr_env[j], elems->tx_pwr_env[i],
+			       elems->tx_pwr_env_len[i]);
+			j++;
 		}
-
-		if (!ieee80211_verify_peer_he_mcs_support(sdata,
-							  (void *)elems->he_cap,
-							  he_oper) ||
-		    !ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
-			*conn_flags |= IEEE80211_CONN_DISABLE_HE |
-				       IEEE80211_CONN_DISABLE_EHT;
 	}
-
-	/*
-	 * EHT requires HE to be supported as well. Specifically for 6 GHz
-	 * channels, the operation channel information can only be deduced from
-	 * both the 6 GHz operation information (from the HE operation IE) and
-	 * EHT operation.
-	 */
-	if (!(*conn_flags &
-			(IEEE80211_CONN_DISABLE_HE |
-			 IEEE80211_CONN_DISABLE_EHT)) &&
-	    he_oper) {
-		eht_oper = elems->eht_operation;
-
-		if (!ieee80211_verify_sta_eht_mcs_support(sdata, sband, eht_oper))
-			*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-
-		supports_mlo = elems->ml_basic;
-	}
-
-	/* Allow VHT if at least one channel on the sband supports 80 MHz */
-	have_80mhz = false;
-	for (i = 0; i < sband->n_channels; i++) {
-		if (sband->channels[i].flags & (IEEE80211_CHAN_DISABLED |
-						IEEE80211_CHAN_NO_80MHZ))
-			continue;
-
-		have_80mhz = true;
-		break;
-	}
-
-	if (!have_80mhz) {
-		sdata_info(sdata, "80 MHz not supported, disabling VHT\n");
-		*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-	}
-
-	if (sband->band == NL80211_BAND_S1GHZ) {
-		s1g_oper = elems->s1g_oper;
-		if (!s1g_oper)
-			sdata_info(sdata,
-				   "AP missing S1G operation element?\n");
-	}
-
-	*conn_flags |=
-		ieee80211_determine_chantype(sdata, link, *conn_flags,
-					     sband,
-					     cbss->channel,
-					     bss->vht_cap_info,
-					     ht_oper, vht_oper,
-					     he_oper, eht_oper,
-					     s1g_oper,
-					     &chandef, false);
-
-	if (link)
-		link->needed_rx_chains =
-			min(ieee80211_max_rx_chains(link, cbss),
-			    local->rx_chains);
-
 	rcu_read_unlock();
 	/* the element data was RCU protected so no longer valid anyway */
 	kfree(elems);
 	elems = NULL;
 
-	if (*conn_flags & IEEE80211_CONN_DISABLE_HE && is_6ghz) {
-		sdata_info(sdata, "Rejecting non-HE 6/7 GHz connection");
-		return -EINVAL;
-	}
-
-	if (mlo && !supports_mlo) {
-		sdata_info(sdata, "Rejecting MLO as it is not supported by AP\n");
-		return -EINVAL;
-	}
-
 	if (!link)
 		return 0;
 
+	rcu_read_lock();
+	link->needed_rx_chains = min(ieee80211_max_rx_chains(link, cbss),
+				     local->rx_chains);
+	rcu_read_unlock();
+
 	/* will change later if needed */
 	link->smps_mode = IEEE80211_SMPS_OFF;
 
@@ -4996,15 +5168,14 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	/* don't downgrade for 5 and 10 MHz channels, though. */
 	if (chandef.width == NL80211_CHAN_WIDTH_5 ||
 	    chandef.width == NL80211_CHAN_WIDTH_10)
-		goto out;
+		return ret;
 
 	while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
-		*conn_flags |=
-			ieee80211_chandef_downgrade(&chandef);
+		ieee80211_chandef_downgrade(&chandef, conn);
 		ret = ieee80211_link_use_channel(link, &chandef,
 						 IEEE80211_CHANCTX_SHARED);
 	}
- out:
+
 	return ret;
 }
 
@@ -5128,8 +5299,10 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		link->conf->dtim_period = link->u.mgd.dtim_period ?: 1;
 
 		if (link_id != assoc_data->assoc_link_id) {
-			err = ieee80211_prep_channel(sdata, link, cbss, true,
-						     &link->u.mgd.conn_flags);
+			link->u.mgd.conn = assoc_data->link[link_id].conn;
+
+			err = ieee80211_prep_channel(sdata, link, link_id, cbss,
+						     true, &link->u.mgd.conn);
 			if (err) {
 				link_info(link, "prep_channel failed\n");
 				goto out_err;
@@ -5222,6 +5395,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
 	u16 capab_info, status_code, aid;
 	struct ieee80211_elems_parse_params parse_params = {
+		.mode = IEEE80211_CONN_MODE_HIGHEST, // FIXME
 		.bss = NULL,
 		.link_id = -1,
 		.from_ap = true,
@@ -6046,6 +6220,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	u8 *bssid, *variable = mgmt->u.beacon.variable;
 	u8 deauth_buf[IEEE80211_DEAUTH_FRAME_LEN];
 	struct ieee80211_elems_parse_params parse_params = {
+		.mode = IEEE80211_CONN_MODE_HIGHEST, // FIXME
 		.link_id = -1,
 		.from_ap = true,
 	};
@@ -6300,10 +6475,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
-	if (ieee80211_config_bw(link, elems, bssid, &changed)) {
-		sdata_info(sdata,
-			   "failed to follow AP %pM bandwidth change, disconnect\n",
-			   bssid);
+	if (ieee80211_config_bw(link, elems, &changed)) {
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_DEAUTH_LEAVING,
 				       true, deauth_buf);
@@ -6326,7 +6498,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 					       elems->cisco_dtpc_elem);
 
 	if (elems->eht_operation &&
-	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)) {
+	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_EHT) {
 		if (!ieee80211_config_puncturing(link, elems->eht_operation,
 						 &changed)) {
 			ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
@@ -6996,7 +7168,6 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	unsigned int link_id = link->link_id;
 
 	link->u.mgd.p2p_noa_index = -1;
-	link->u.mgd.conn_flags = 0;
 	link->conf->bssid = link->u.mgd.bssid;
 
 	wiphy_work_init(&link->u.mgd.request_smps_work,
@@ -7035,6 +7206,7 @@ void ieee80211_mlme_notify_scan_completed(struct ieee80211_local *local)
 static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 				     struct cfg80211_bss *cbss, s8 link_id,
 				     const u8 *ap_mld_addr, bool assoc,
+				     struct ieee80211_conn_settings *conn,
 				     bool override)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -7166,13 +7338,22 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (new_sta || override) {
-		err = ieee80211_prep_channel(sdata, link, cbss, mlo,
-					     &link->u.mgd.conn_flags);
+		/*
+		 * Only set this if we're also going to calculate the AP
+		 * settings etc., otherwise this was set before in a
+		 * previous call. Note override is set to %true in assoc
+		 * if the settings were changed.
+		 */
+		link->u.mgd.conn = *conn;
+		err = ieee80211_prep_channel(sdata, link, link->link_id, cbss,
+					     mlo, &link->u.mgd.conn);
 		if (err) {
 			if (new_sta)
 				sta_info_free(local, new_sta);
 			goto out_err;
 		}
+		/* pass out for use in assoc */
+		*conn = link->u.mgd.conn;
 	}
 
 	if (new_sta) {
@@ -7218,11 +7399,14 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_auth_data *auth_data;
+	struct ieee80211_conn_settings conn;
 	struct ieee80211_link_data *link;
 	const struct element *csa_elem, *ecsa_elem;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_bss *bss;
 	u16 auth_alg;
 	int err;
-	bool cont_auth;
+	bool cont_auth, wmm_used;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -7364,8 +7548,18 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	/* needed for transmitting the auth frame(s) properly */
 	memcpy(sdata->vif.cfg.ap_addr, auth_data->ap_addr, ETH_ALEN);
 
+	bss = (void *)req->bss->priv;
+	wmm_used = bss->wmm_used && (local->hw.queues >= IEEE80211_NUM_ACS);
+
+	sband = local->hw.wiphy->bands[req->bss->channel->band];
+
+	ieee80211_determine_our_sta_mode(sdata, sband, NULL, wmm_used,
+					 req->link_id > 0 ? req->link_id : 0,
+					 &conn);
+
 	err = ieee80211_prep_connection(sdata, req->bss, req->link_id,
-					req->ap_mld_addr, cont_auth, false);
+					req->ap_mld_addr, cont_auth,
+					&conn, false);
 	if (err)
 		goto err_clear;
 
@@ -7404,38 +7598,33 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	return err;
 }
 
-static ieee80211_conn_flags_t
+static void
 ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 			   struct ieee80211_mgd_assoc_data *assoc_data,
 			   struct cfg80211_assoc_request *req,
-			   ieee80211_conn_flags_t conn_flags,
+			   struct ieee80211_conn_settings *conn,
 			   unsigned int link_id)
 {
 	struct ieee80211_local *local = sdata->local;
 	const struct cfg80211_bss_ies *bss_ies;
 	struct ieee80211_supported_band *sband;
-	const struct element *ht_elem, *vht_elem;
 	struct ieee80211_link_data *link;
 	struct cfg80211_bss *cbss;
 	struct ieee80211_bss *bss;
-	bool is_5ghz, is_6ghz;
 
 	cbss = assoc_data->link[link_id].bss;
 	if (WARN_ON(!cbss))
-		return 0;
+		return;
 
 	bss = (void *)cbss->priv;
 
 	sband = local->hw.wiphy->bands[cbss->channel->band];
 	if (WARN_ON(!sband))
-		return 0;
+		return;
 
 	link = sdata_dereference(sdata->link[link_id], sdata);
 	if (WARN_ON(!link))
-		return 0;
-
-	is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
-	is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
+		return;
 
 	/* for MLO connections assume advertising all rates is OK */
 	if (!req->ap_mld_addr) {
@@ -7452,40 +7641,18 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 		assoc_data->ie_pos += req->links[link_id].elems_len;
 	}
 
-	rcu_read_lock();
-	ht_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_HT_OPERATION);
-	if (ht_elem && ht_elem->datalen >= sizeof(struct ieee80211_ht_operation))
-		assoc_data->link[link_id].ap_ht_param =
-			((struct ieee80211_ht_operation *)(ht_elem->data))->ht_param;
-	else if (!is_6ghz)
-		conn_flags |= IEEE80211_CONN_DISABLE_HT;
-	vht_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_VHT_CAPABILITY);
-	if (vht_elem && vht_elem->datalen >= sizeof(struct ieee80211_vht_cap)) {
-		memcpy(&assoc_data->link[link_id].ap_vht_cap, vht_elem->data,
-		       sizeof(struct ieee80211_vht_cap));
-	} else if (is_5ghz) {
-		link_info(link,
-			  "VHT capa missing/short, disabling VHT/HE/EHT\n");
-		conn_flags |= IEEE80211_CONN_DISABLE_VHT |
-			      IEEE80211_CONN_DISABLE_HE |
-			      IEEE80211_CONN_DISABLE_EHT;
-	}
-	rcu_read_unlock();
-
 	link->u.mgd.beacon_crc_valid = false;
 	link->u.mgd.dtim_period = 0;
 	link->u.mgd.have_beacon = false;
 
-	/* override HT/VHT configuration only if the AP and we support it */
-	if (!(conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+	/* override HT configuration only if the AP and we support it */
+	if (conn->mode >= IEEE80211_CONN_MODE_HT) {
 		struct ieee80211_sta_ht_cap sta_ht_cap;
 
 		memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
 		ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
 	}
 
-	link->conf->eht_puncturing = 0;
-
 	rcu_read_lock();
 	bss_ies = rcu_dereference(cbss->beacon_ies);
 	if (bss_ies) {
@@ -7506,7 +7673,6 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (bss_ies) {
-		const struct ieee80211_eht_operation *eht_oper;
 		const struct element *elem;
 
 		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION,
@@ -7523,31 +7689,6 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 			link->conf->ema_ap = true;
 		else
 			link->conf->ema_ap = false;
-
-		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION,
-					      bss_ies->data, bss_ies->len);
-		eht_oper = (const void *)(elem->data + 1);
-
-		if (elem &&
-		    ieee80211_eht_oper_size_ok((const void *)(elem->data + 1),
-					       elem->datalen - 1) &&
-		    (eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) &&
-		    (eht_oper->params & IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT)) {
-			const struct ieee80211_eht_operation_info *info =
-				(void *)eht_oper->optional;
-			const u8 *disable_subchannel_bitmap = info->optional;
-			u16 bitmap;
-
-			bitmap = get_unaligned_le16(disable_subchannel_bitmap);
-			if (cfg80211_valid_disable_subchannel_bitmap(&bitmap,
-								     &link->conf->chandef))
-				ieee80211_handle_puncturing_bitmap(link,
-								   eht_oper,
-								   bitmap,
-								   NULL);
-			else
-				conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-		}
 	}
 	rcu_read_unlock();
 
@@ -7574,8 +7715,6 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 	} else {
 		link->smps_mode = link->u.mgd.req_smps;
 	}
-
-	return conn_flags;
 }
 
 int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
@@ -7587,11 +7726,9 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgd_assoc_data *assoc_data;
 	const struct element *ssid_elem, *csa_elem, *ecsa_elem;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
-	ieee80211_conn_flags_t conn_flags = 0;
 	struct ieee80211_link_data *link;
 	struct cfg80211_bss *cbss;
-	struct ieee80211_bss *bss;
-	bool override;
+	bool override, uapsd_supported;
 	int i, err;
 	size_t size = sizeof(*assoc_data) + req->ie_len;
 
@@ -7612,8 +7749,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	ssid_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_SSID);
 	if (!ssid_elem || ssid_elem->datalen > sizeof(assoc_data->ssid)) {
 		rcu_read_unlock();
-		kfree(assoc_data);
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_free;
 	}
 
 	csa_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_CHANNEL_SWITCH);
@@ -7626,51 +7763,122 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	     ((struct ieee80211_ext_chansw_ie *)ecsa_elem->data)->count != 0)) {
 		sdata_info(sdata, "AP is in CSA process, reject assoc\n");
 		rcu_read_unlock();
-		kfree(assoc_data);
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_free;
 	}
 
 	memcpy(assoc_data->ssid, ssid_elem->data, ssid_elem->datalen);
 	assoc_data->ssid_len = ssid_elem->datalen;
-	memcpy(vif_cfg->ssid, assoc_data->ssid, assoc_data->ssid_len);
-	vif_cfg->ssid_len = assoc_data->ssid_len;
 	rcu_read_unlock();
 
+	if (ifmgd->associated) {
+		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+
+		sdata_info(sdata,
+			   "disconnect from AP %pM for new assoc to %pM\n",
+			   sdata->vif.cfg.ap_addr, assoc_data->ap_addr);
+		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
+				       WLAN_REASON_UNSPECIFIED,
+				       false, frame_buf);
+
+		ieee80211_report_disconnect(sdata, frame_buf,
+					    sizeof(frame_buf), true,
+					    WLAN_REASON_UNSPECIFIED,
+					    false);
+	}
+
+	memcpy(&ifmgd->ht_capa, &req->ht_capa, sizeof(ifmgd->ht_capa));
+	memcpy(&ifmgd->ht_capa_mask, &req->ht_capa_mask,
+	       sizeof(ifmgd->ht_capa_mask));
+
+	memcpy(&ifmgd->vht_capa, &req->vht_capa, sizeof(ifmgd->vht_capa));
+	memcpy(&ifmgd->vht_capa_mask, &req->vht_capa_mask,
+	       sizeof(ifmgd->vht_capa_mask));
+
+	memcpy(&ifmgd->s1g_capa, &req->s1g_capa, sizeof(ifmgd->s1g_capa));
+	memcpy(&ifmgd->s1g_capa_mask, &req->s1g_capa_mask,
+	       sizeof(ifmgd->s1g_capa_mask));
+
 	if (req->ap_mld_addr) {
+		uapsd_supported = true;
+
 		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-			if (!req->links[i].bss)
+			struct ieee80211_supported_band *sband;
+			struct cfg80211_bss *cbss = req->links[i].bss;
+			struct ieee80211_bss *bss;
+
+			if (!cbss)
 				continue;
+
+			bss = (void *)cbss->priv;
+
+			if (!bss->wmm_used) {
+				err = -EINVAL;
+				goto err_free;
+			}
+
+			if (req->flags & (ASSOC_REQ_DISABLE_HT |
+					  ASSOC_REQ_DISABLE_VHT |
+					  ASSOC_REQ_DISABLE_HE |
+					  ASSOC_REQ_DISABLE_EHT)) {
+				err = -EINVAL;
+				goto err_free;
+			}
+
+			if (cbss->channel->band == NL80211_BAND_S1GHZ) {
+				err = -EINVAL;
+				goto err_free;
+			}
+
 			link = sdata_dereference(sdata->link[i], sdata);
 			if (link)
 				ether_addr_copy(assoc_data->link[i].addr,
 						link->conf->addr);
 			else
 				eth_random_addr(assoc_data->link[i].addr);
+			sband = local->hw.wiphy->bands[cbss->channel->band];
+
+			ieee80211_determine_our_sta_mode(sdata, sband, req, true, i,
+							 &assoc_data->link[i].conn);
+			assoc_data->link[i].bss = cbss;
+			assoc_data->link[i].disabled = req->links[i].disabled;
+
+			if (!bss->uapsd_supported)
+				uapsd_supported = false;
 		}
+
+		memcpy(assoc_data->ap_addr, req->ap_mld_addr, ETH_ALEN);
+		assoc_data->wmm = true;
 	} else {
+		struct ieee80211_supported_band *sband;
+		struct cfg80211_bss *cbss = req->bss;
+		struct ieee80211_bss *bss = (void *)cbss->priv;
+
 		memcpy(assoc_data->link[0].addr, sdata->vif.addr, ETH_ALEN);
-	}
+		assoc_data->s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
 
-	assoc_data->s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
+		memcpy(assoc_data->ap_addr, cbss->bssid, ETH_ALEN);
 
-	memcpy(assoc_data->ap_addr,
-	       req->ap_mld_addr ?: req->bss->bssid,
-	       ETH_ALEN);
+		assoc_data->wmm = bss->wmm_used &&
+				  (local->hw.queues >= IEEE80211_NUM_ACS);
 
-	if (ifmgd->associated) {
-		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+		if (cbss->channel->band == NL80211_BAND_6GHZ &&
+		    req->flags & (ASSOC_REQ_DISABLE_HT |
+				  ASSOC_REQ_DISABLE_VHT |
+				  ASSOC_REQ_DISABLE_HE)) {
+			err = -EINVAL;
+			goto err_free;
+		}
 
-		sdata_info(sdata,
-			   "disconnect from AP %pM for new assoc to %pM\n",
-			   sdata->vif.cfg.ap_addr, assoc_data->ap_addr);
-		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
-				       WLAN_REASON_UNSPECIFIED,
-				       false, frame_buf);
+		sband = local->hw.wiphy->bands[cbss->channel->band];
 
-		ieee80211_report_disconnect(sdata, frame_buf,
-					    sizeof(frame_buf), true,
-					    WLAN_REASON_UNSPECIFIED,
-					    false);
+		assoc_data->link[0].bss = cbss;
+
+		ieee80211_determine_our_sta_mode(sdata, sband, req,
+						 assoc_data->wmm, 0,
+						 &assoc_data->link[0].conn);
+
+		uapsd_supported = bss->uapsd_supported;
 	}
 
 	if (ifmgd->auth_data && !ifmgd->auth_data->done) {
@@ -7696,76 +7904,6 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			ieee80211_destroy_auth_data(sdata, false);
 	}
 
-	/* prepare assoc data */
-
-	bss = (void *)cbss->priv;
-	assoc_data->wmm = bss->wmm_used &&
-			  (local->hw.queues >= IEEE80211_NUM_ACS);
-
-	/*
-	 * IEEE802.11n does not allow TKIP/WEP as pairwise ciphers in HT mode.
-	 * We still associate in non-HT mode (11a/b/g) if any one of these
-	 * ciphers is configured as pairwise.
-	 * We can set this to true for non-11n hardware, that'll be checked
-	 * separately along with the peer capabilities.
-	 */
-	for (i = 0; i < req->crypto.n_ciphers_pairwise; i++) {
-		if (req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_WEP40 ||
-		    req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_TKIP ||
-		    req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_WEP104) {
-			conn_flags |= IEEE80211_CONN_DISABLE_HT;
-			conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-			conn_flags |= IEEE80211_CONN_DISABLE_HE;
-			conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-			netdev_info(sdata->dev,
-				    "disabling HT/VHT/HE due to WEP/TKIP use\n");
-		}
-	}
-
-	/* also disable HT/VHT/HE/EHT if the AP doesn't use WMM */
-	if (!bss->wmm_used) {
-		conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-		netdev_info(sdata->dev,
-			    "disabling HT/VHT/HE as WMM/QoS is not supported by the AP\n");
-	}
-
-	if (req->flags & ASSOC_REQ_DISABLE_HT) {
-		mlme_dbg(sdata, "HT disabled by flag, disabling HT/VHT/HE\n");
-		conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (req->flags & ASSOC_REQ_DISABLE_VHT) {
-		mlme_dbg(sdata, "VHT disabled by flag, disabling VHT\n");
-		conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-	}
-
-	if (req->flags & ASSOC_REQ_DISABLE_HE) {
-		mlme_dbg(sdata, "HE disabled by flag, disabling HE/EHT\n");
-		conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (req->flags & ASSOC_REQ_DISABLE_EHT)
-		conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-
-	memcpy(&ifmgd->ht_capa, &req->ht_capa, sizeof(ifmgd->ht_capa));
-	memcpy(&ifmgd->ht_capa_mask, &req->ht_capa_mask,
-	       sizeof(ifmgd->ht_capa_mask));
-
-	memcpy(&ifmgd->vht_capa, &req->vht_capa, sizeof(ifmgd->vht_capa));
-	memcpy(&ifmgd->vht_capa_mask, &req->vht_capa_mask,
-	       sizeof(ifmgd->vht_capa_mask));
-
-	memcpy(&ifmgd->s1g_capa, &req->s1g_capa, sizeof(ifmgd->s1g_capa));
-	memcpy(&ifmgd->s1g_capa_mask, &req->s1g_capa_mask,
-	       sizeof(ifmgd->s1g_capa_mask));
-
 	if (req->ie && req->ie_len) {
 		memcpy(assoc_data->ie, req->ie, req->ie_len);
 		assoc_data->ie_len = req->ie_len;
@@ -7796,19 +7934,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	assoc_data->assoc_link_id = assoc_link_id;
 
 	if (req->ap_mld_addr) {
-		for (i = 0; i < ARRAY_SIZE(assoc_data->link); i++) {
-			assoc_data->link[i].conn_flags = conn_flags;
-			assoc_data->link[i].bss = req->links[i].bss;
-			assoc_data->link[i].disabled = req->links[i].disabled;
-		}
-
 		/* if there was no authentication, set up the link */
 		err = ieee80211_vif_set_links(sdata, BIT(assoc_link_id), 0);
 		if (err)
 			goto err_clear;
-	} else {
-		assoc_data->link[0].conn_flags = conn_flags;
-		assoc_data->link[0].bss = cbss;
 	}
 
 	link = sdata_dereference(sdata->link[assoc_link_id], sdata);
@@ -7817,19 +7946,21 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		goto err_clear;
 	}
 
-	/* keep old conn_flags from ieee80211_prep_channel() from auth */
-	conn_flags |= link->u.mgd.conn_flags;
-	conn_flags |= ieee80211_setup_assoc_link(sdata, assoc_data, req,
-						 conn_flags, assoc_link_id);
-	override = link->u.mgd.conn_flags != conn_flags;
-	link->u.mgd.conn_flags |= conn_flags;
+	override = link->u.mgd.conn.mode !=
+			assoc_data->link[assoc_link_id].conn.mode ||
+		   link->u.mgd.conn.bw_limit !=
+			assoc_data->link[assoc_link_id].conn.bw_limit;
+	link->u.mgd.conn = assoc_data->link[assoc_link_id].conn;
+
+	ieee80211_setup_assoc_link(sdata, assoc_data, req, &link->u.mgd.conn,
+				   assoc_link_id);
 
 	if (WARN((sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_UAPSD) &&
 		 ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK),
 	     "U-APSD not supported with HW_PS_NULLFUNC_STACK\n"))
 		sdata->vif.driver_flags &= ~IEEE80211_VIF_SUPPORTS_UAPSD;
 
-	if (bss->wmm_used && bss->uapsd_supported &&
+	if (assoc_data->wmm && uapsd_supported &&
 	    (sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_UAPSD)) {
 		assoc_data->uapsd = true;
 		ifmgd->flags |= IEEE80211_STA_UAPSD_ENABLED;
@@ -7873,27 +8004,29 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			continue;
 		if (i == assoc_data->assoc_link_id)
 			continue;
-		/* only calculate the flags, hence link == NULL */
-		err = ieee80211_prep_channel(sdata, NULL,
+		/* only calculate the mode, hence link == NULL */
+		err = ieee80211_prep_channel(sdata, NULL, i,
 					     assoc_data->link[i].bss, true,
-					     &assoc_data->link[i].conn_flags);
+					     &assoc_data->link[i].conn);
 		if (err) {
 			req->links[i].error = err;
 			goto err_clear;
 		}
 	}
 
+	memcpy(vif_cfg->ssid, assoc_data->ssid, assoc_data->ssid_len);
+	vif_cfg->ssid_len = assoc_data->ssid_len;
+
 	/* needed for transmitting the assoc frames properly */
 	memcpy(sdata->vif.cfg.ap_addr, assoc_data->ap_addr, ETH_ALEN);
 
 	err = ieee80211_prep_connection(sdata, cbss, req->link_id,
-					req->ap_mld_addr, true, override);
+					req->ap_mld_addr, true,
+					&assoc_data->link[assoc_link_id].conn,
+					override);
 	if (err)
 		goto err_clear;
 
-	assoc_data->link[assoc_data->assoc_link_id].conn_flags =
-		link->u.mgd.conn_flags;
-
 	if (ieee80211_hw_check(&sdata->local->hw, NEED_DTIM_BEFORE_ASSOC)) {
 		const struct cfg80211_bss_ies *beacon_ies;
 
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index 55959b0b24c5..d8c7b3e16eb7 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -23,7 +23,8 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 struct ieee802_11_elems *elems,
 				 enum nl80211_band current_band,
 				 u32 vht_cap_info,
-				 ieee80211_conn_flags_t conn_flags, u8 *bssid,
+				 struct ieee80211_conn_settings *conn,
+				 u8 *bssid,
 				 struct ieee80211_csa_ie *csa_ie)
 {
 	enum nl80211_band new_band = current_band;
@@ -42,13 +43,13 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	wide_bw_chansw_ie = elems->wide_bw_chansw_ie;
 	bwi = elems->bandwidth_indication;
 
-	if (conn_flags & (IEEE80211_CONN_DISABLE_HT |
-			  IEEE80211_CONN_DISABLE_40MHZ)) {
+	if (conn->mode < IEEE80211_CONN_MODE_HT ||
+	    conn->bw_limit < IEEE80211_CONN_BW_LIMIT_40) {
 		sec_chan_offs = NULL;
 		wide_bw_chansw_ie = NULL;
 	}
 
-	if (conn_flags & IEEE80211_CONN_DISABLE_VHT)
+	if (conn->mode < IEEE80211_CONN_MODE_VHT)
 		wide_bw_chansw_ie = NULL;
 
 	if (elems->ext_chansw_ie) {
@@ -95,7 +96,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 
 	if (sec_chan_offs) {
 		secondary_channel_offset = sec_chan_offs->sec_chan_offs;
-	} else if (!(conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+	} else if (conn->mode >= IEEE80211_CONN_MODE_HT) {
 		/* If the secondary channel offset IE is not present,
 		 * we can't know what's the post-CSA offset, so the
 		 * best we can do is use 20MHz.
@@ -169,12 +170,10 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 						&new_vht_chandef))
 			new_vht_chandef.chan = NULL;
 
-		if (conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ &&
-		    new_vht_chandef.width == NL80211_CHAN_WIDTH_80P80)
-			ieee80211_chandef_downgrade(&new_vht_chandef);
-		if (conn_flags & IEEE80211_CONN_DISABLE_160MHZ &&
-		    new_vht_chandef.width == NL80211_CHAN_WIDTH_160)
-			ieee80211_chandef_downgrade(&new_vht_chandef);
+		if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_160 &&
+		    (new_vht_chandef.width == NL80211_CHAN_WIDTH_80P80 ||
+		     new_vht_chandef.width == NL80211_CHAN_WIDTH_160))
+			ieee80211_chandef_downgrade(&new_vht_chandef, NULL);
 	}
 
 	/* if VHT data is there validate & use it */
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 05a7dff69fe9..f0372dcb93ce 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -347,7 +347,7 @@ ieee80211_tdls_chandef_vht_upgrade(struct ieee80211_sub_if_data *sdata,
 	       (uc.width > sta->tdls_chandef.width &&
 		!cfg80211_reg_can_beacon_relax(sdata->local->hw.wiphy, &uc,
 					       sdata->wdev.iftype)))
-		ieee80211_chandef_downgrade(&uc);
+		ieee80211_chandef_downgrade(&uc, NULL);
 
 	if (!cfg80211_chandef_identical(&uc, &sta->tdls_chandef)) {
 		tdls_dbg(sdata, "TDLS ch width upgraded %d -> %d\n",
@@ -561,7 +561,7 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 			ieee80211_he_ppe_size(he_cap->ppe_thres[0],
 					      he_cap->he_cap_elem.phy_cap_info);
 		pos = skb_put(skb, cap_size);
-		pos = ieee80211_ie_build_he_cap(0, pos, he_cap, pos + cap_size);
+		pos = ieee80211_ie_build_he_cap(NULL, he_cap, pos, pos + cap_size);
 
 		/* Build HE 6Ghz capa IE from sband */
 		if (sband->band == NL80211_BAND_6GHZ) {
@@ -1413,8 +1413,8 @@ iee80211_tdls_recalc_ht_protection(struct ieee80211_sub_if_data *sdata,
 			 IEEE80211_HT_OP_MODE_NON_HT_STA_PRSNT;
 	u16 opmode;
 
-	/* Nothing to do if the BSS connection uses HT */
-	if (!(sdata->deflink.u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
+	/* Nothing to do if the BSS connection uses (at least) HT */
+	if (sdata->deflink.u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT)
 		return;
 
 	tdls_ht = (sta && sta->sta.deflink.ht_cap.ht_supported) ||
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ed680120d5a7..f9dab1f5b8af 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -46,6 +46,11 @@ struct ieee80211_hw *wiphy_to_ieee80211_hw(struct wiphy *wiphy)
 }
 EXPORT_SYMBOL(wiphy_to_ieee80211_hw);
 
+const struct ieee80211_conn_settings ieee80211_conn_settings_unlimited = {
+	.mode = IEEE80211_CONN_MODE_EHT,
+	.bw_limit = IEEE80211_CONN_BW_LIMIT_320,
+};
+
 u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
 			enum nl80211_iftype type)
 {
@@ -929,23 +934,31 @@ ieee80211_parse_extension_element(u32 *crc,
 
 	switch (elem->data[0]) {
 	case WLAN_EID_EXT_HE_MU_EDCA:
+		if (params->mode < IEEE80211_CONN_MODE_HE)
+			break;
 		calc_crc = true;
 		if (len >= sizeof(*elems->mu_edca_param_set))
 			elems->mu_edca_param_set = data;
 		break;
 	case WLAN_EID_EXT_HE_CAPABILITY:
+		if (params->mode < IEEE80211_CONN_MODE_HE)
+			break;
 		if (ieee80211_he_capa_size_ok(data, len)) {
 			elems->he_cap = data;
 			elems->he_cap_len = len;
 		}
 		break;
 	case WLAN_EID_EXT_HE_OPERATION:
+		if (params->mode < IEEE80211_CONN_MODE_HE)
+			break;
 		calc_crc = true;
 		if (len >= sizeof(*elems->he_operation) &&
 		    len >= ieee80211_he_oper_size(data) - 1)
 			elems->he_operation = data;
 		break;
 	case WLAN_EID_EXT_UORA:
+		if (params->mode < IEEE80211_CONN_MODE_HE)
+			break;
 		if (len >= 1)
 			elems->uora_element = data;
 		break;
@@ -958,15 +971,21 @@ ieee80211_parse_extension_element(u32 *crc,
 			elems->mbssid_config_ie = data;
 		break;
 	case WLAN_EID_EXT_HE_SPR:
+		if (params->mode < IEEE80211_CONN_MODE_HE)
+			break;
 		if (len >= sizeof(*elems->he_spr) &&
 		    len >= ieee80211_he_spr_size(data))
 			elems->he_spr = data;
 		break;
 	case WLAN_EID_EXT_HE_6GHZ_CAPA:
+		if (params->mode < IEEE80211_CONN_MODE_HE)
+			break;
 		if (len >= sizeof(*elems->he_6ghz_capa))
 			elems->he_6ghz_capa = data;
 		break;
 	case WLAN_EID_EXT_EHT_CAPABILITY:
+		if (params->mode < IEEE80211_CONN_MODE_EHT)
+			break;
 		if (ieee80211_eht_capa_size_ok(elems->he_cap,
 					       data, len,
 					       params->from_ap)) {
@@ -975,11 +994,15 @@ ieee80211_parse_extension_element(u32 *crc,
 		}
 		break;
 	case WLAN_EID_EXT_EHT_OPERATION:
+		if (params->mode < IEEE80211_CONN_MODE_EHT)
+			break;
 		if (ieee80211_eht_oper_size_ok(data, len))
 			elems->eht_operation = data;
 		calc_crc = true;
 		break;
 	case WLAN_EID_EXT_EHT_MULTI_LINK:
+		if (params->mode < IEEE80211_CONN_MODE_EHT)
+			break;
 		calc_crc = true;
 
 		if (ieee80211_mle_size_ok(data, len)) {
@@ -1004,11 +1027,15 @@ ieee80211_parse_extension_element(u32 *crc,
 		}
 		break;
 	case WLAN_EID_EXT_BANDWIDTH_INDICATION:
+		if (params->mode < IEEE80211_CONN_MODE_EHT)
+			break;
 		if (ieee80211_bandwidth_indication_size_ok(data, len))
 			elems->bandwidth_indication = data;
 		calc_crc = true;
 		break;
 	case WLAN_EID_EXT_TID_TO_LINK_MAPPING:
+		if (params->mode < IEEE80211_CONN_MODE_EHT)
+			break;
 		calc_crc = true;
 		if (ieee80211_tid_to_link_map_size_ok(data, len) &&
 		    elems->ttlm_num < ARRAY_SIZE(elems->ttlm)) {
@@ -1178,24 +1205,32 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			elems->ext_supp_rates_len = elen;
 			break;
 		case WLAN_EID_HT_CAPABILITY:
+			if (params->mode < IEEE80211_CONN_MODE_HT)
+				break;
 			if (elen >= sizeof(struct ieee80211_ht_cap))
 				elems->ht_cap_elem = (void *)pos;
 			else
 				elem_parse_failed = true;
 			break;
 		case WLAN_EID_HT_OPERATION:
+			if (params->mode < IEEE80211_CONN_MODE_HT)
+				break;
 			if (elen >= sizeof(struct ieee80211_ht_operation))
 				elems->ht_operation = (void *)pos;
 			else
 				elem_parse_failed = true;
 			break;
 		case WLAN_EID_VHT_CAPABILITY:
+			if (params->mode < IEEE80211_CONN_MODE_VHT)
+				break;
 			if (elen >= sizeof(struct ieee80211_vht_cap))
 				elems->vht_cap_elem = (void *)pos;
 			else
 				elem_parse_failed = true;
 			break;
 		case WLAN_EID_VHT_OPERATION:
+			if (params->mode < IEEE80211_CONN_MODE_VHT)
+				break;
 			if (elen >= sizeof(struct ieee80211_vht_operation)) {
 				elems->vht_operation = (void *)pos;
 				if (calc_crc)
@@ -1205,6 +1240,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			elem_parse_failed = true;
 			break;
 		case WLAN_EID_OPMODE_NOTIF:
+			if (params->mode < IEEE80211_CONN_MODE_VHT)
+				break;
 			if (elen > 0) {
 				elems->opmode_notif = pos;
 				if (calc_crc)
@@ -1264,6 +1301,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			elems->ext_chansw_ie = (void *)pos;
 			break;
 		case WLAN_EID_SECONDARY_CHANNEL_OFFSET:
+			if (params->mode < IEEE80211_CONN_MODE_HT)
+				break;
 			if (elen != sizeof(struct ieee80211_sec_chan_offs_ie)) {
 				elem_parse_failed = true;
 				break;
@@ -1279,6 +1318,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			elems->mesh_chansw_params_ie = (void *)pos;
 			break;
 		case WLAN_EID_WIDE_BW_CHANNEL_SWITCH:
+			if (params->mode < IEEE80211_CONN_MODE_VHT) // ??
+				break;
 			if (!params->action ||
 			    elen < sizeof(*elems->wide_bw_chansw_ie)) {
 				elem_parse_failed = true;
@@ -1287,6 +1328,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			elems->wide_bw_chansw_ie = (void *)pos;
 			break;
 		case WLAN_EID_CHANNEL_SWITCH_WRAPPER:
+			if (params->mode < IEEE80211_CONN_MODE_VHT) // ??
+				break;
 			if (params->action) {
 				elem_parse_failed = true;
 				break;
@@ -1305,6 +1348,9 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 					elem_parse_failed = true;
 			}
 
+			if (params->mode < IEEE80211_CONN_MODE_EHT)
+				break;
+
 			subelem = cfg80211_find_ext_elem(WLAN_EID_EXT_BANDWIDTH_INDICATION,
 							 pos, elen);
 			if (subelem) {
@@ -1376,6 +1422,8 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			elems->rsnx_len = elen;
 			break;
 		case WLAN_EID_TX_POWER_ENVELOPE:
+			if (params->mode < IEEE80211_CONN_MODE_VHT) // ??
+				break;
 			if (elen < 1 ||
 			    elen > sizeof(struct ieee80211_tx_pwr_env))
 				break;
@@ -1393,24 +1441,32 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 							  elem, elems, params);
 			break;
 		case WLAN_EID_S1G_CAPABILITIES:
+			if (params->mode != IEEE80211_CONN_MODE_S1G)
+				break;
 			if (elen >= sizeof(*elems->s1g_capab))
 				elems->s1g_capab = (void *)pos;
 			else
 				elem_parse_failed = true;
 			break;
 		case WLAN_EID_S1G_OPERATION:
+			if (params->mode != IEEE80211_CONN_MODE_S1G)
+				break;
 			if (elen == sizeof(*elems->s1g_oper))
 				elems->s1g_oper = (void *)pos;
 			else
 				elem_parse_failed = true;
 			break;
 		case WLAN_EID_S1G_BCN_COMPAT:
+			if (params->mode != IEEE80211_CONN_MODE_S1G)
+				break;
 			if (elen == sizeof(*elems->s1g_bcn_compat))
 				elems->s1g_bcn_compat = (void *)pos;
 			else
 				elem_parse_failed = true;
 			break;
 		case WLAN_EID_AID_RESPONSE:
+			if (params->mode != IEEE80211_CONN_MODE_S1G)
+				break;
 			if (elen == sizeof(struct ieee80211_aid_response_ie))
 				elems->aid_resp = (void *)pos;
 			else
@@ -1562,6 +1618,7 @@ static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
 {
 	struct ieee80211_mle_per_sta_profile *prof;
 	struct ieee80211_elems_parse_params sub = {
+		.mode = params->mode,
 		.action = params->action,
 		.from_ap = params->from_ap,
 		.link_id = -1,
@@ -1649,6 +1706,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	/* Override with nontransmitted profile, if found */
 	if (nontransmitted_profile_len) {
 		struct ieee80211_elems_parse_params sub = {
+			.mode = params->mode,
 			.start = nontransmitted_profile,
 			.len = nontransmitted_profile_len,
 			.action = params->action,
@@ -2142,7 +2200,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	if (he_cap &&
 	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
 					 IEEE80211_CHAN_NO_HE)) {
-		pos = ieee80211_ie_build_he_cap(0, pos, he_cap, end);
+		pos = ieee80211_ie_build_he_cap(NULL, he_cap, pos, end);
 		if (!pos)
 			goto out_err;
 	}
@@ -3201,15 +3259,18 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
 				     he_cap->he_cap_elem.phy_cap_info);
 }
 
-u8 *ieee80211_ie_build_he_cap(ieee80211_conn_flags_t disable_flags, u8 *pos,
+u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
 			      const struct ieee80211_sta_he_cap *he_cap,
-			      u8 *end)
+			      u8 *pos, u8 *end)
 {
 	struct ieee80211_he_cap_elem elem;
 	u8 n;
 	u8 ie_len;
 	u8 *orig_pos = pos;
 
+	if (!conn)
+		conn = &ieee80211_conn_settings_unlimited;
+
 	/* Make sure we have place for the IE */
 	/*
 	 * TODO: the 1 added is because this temporarily is under the EXTENSION
@@ -3221,18 +3282,15 @@ u8 *ieee80211_ie_build_he_cap(ieee80211_conn_flags_t disable_flags, u8 *pos,
 	/* modify on stack first to calculate 'n' and 'ie_len' correctly */
 	elem = he_cap->he_cap_elem;
 
-	if (disable_flags & IEEE80211_CONN_DISABLE_40MHZ)
+	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_40)
 		elem.phy_cap_info[0] &=
 			~(IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G);
 
-	if (disable_flags & IEEE80211_CONN_DISABLE_160MHZ)
+	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_160)
 		elem.phy_cap_info[0] &=
-			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
-
-	if (disable_flags & IEEE80211_CONN_DISABLE_80P80MHZ)
-		elem.phy_cap_info[0] &=
-			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+			~(IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G);
 
 	n = ieee80211_he_mcs_nss_size(&elem);
 	ie_len = 2 + 1 +
@@ -4382,21 +4440,32 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL(ieee80211_radar_detected);
 
-ieee80211_conn_flags_t ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
+void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
+				 struct ieee80211_conn_settings *conn)
 {
-	ieee80211_conn_flags_t ret;
+	struct ieee80211_conn_settings _ignored = {};
 	int tmp;
 
+	/* allow passing NULL if caller doesn't care */
+	if (!conn)
+		conn = &_ignored;
+
 	switch (c->width) {
+	default:
+	case NL80211_CHAN_WIDTH_20_NOHT:
+		WARN_ON_ONCE(1);
+		fallthrough;
 	case NL80211_CHAN_WIDTH_20:
 		c->width = NL80211_CHAN_WIDTH_20_NOHT;
-		ret = IEEE80211_CONN_DISABLE_HT | IEEE80211_CONN_DISABLE_VHT;
+		conn->mode = IEEE80211_CONN_MODE_LEGACY;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
 		break;
 	case NL80211_CHAN_WIDTH_40:
 		c->width = NL80211_CHAN_WIDTH_20;
 		c->center_freq1 = c->chan->center_freq;
-		ret = IEEE80211_CONN_DISABLE_40MHZ |
-		      IEEE80211_CONN_DISABLE_VHT;
+		if (conn->mode == IEEE80211_CONN_MODE_VHT)
+			conn->mode = IEEE80211_CONN_MODE_HT;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
 		break;
 	case NL80211_CHAN_WIDTH_80:
 		tmp = (30 + c->chan->center_freq - c->center_freq1)/20;
@@ -4405,13 +4474,14 @@ ieee80211_conn_flags_t ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 		/* freq_P40 */
 		c->center_freq1 = c->center_freq1 - 20 + 40 * tmp;
 		c->width = NL80211_CHAN_WIDTH_40;
-		ret = IEEE80211_CONN_DISABLE_VHT;
+		if (conn->mode == IEEE80211_CONN_MODE_VHT)
+			conn->mode = IEEE80211_CONN_MODE_HT;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_80;
 		break;
 	case NL80211_CHAN_WIDTH_80P80:
 		c->center_freq2 = 0;
 		c->width = NL80211_CHAN_WIDTH_80;
-		ret = IEEE80211_CONN_DISABLE_80P80MHZ |
-		      IEEE80211_CONN_DISABLE_160MHZ;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_80;
 		break;
 	case NL80211_CHAN_WIDTH_160:
 		/* n_P20 */
@@ -4420,8 +4490,7 @@ ieee80211_conn_flags_t ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 		tmp /= 4;
 		c->center_freq1 = c->center_freq1 - 40 + 80 * tmp;
 		c->width = NL80211_CHAN_WIDTH_80;
-		ret = IEEE80211_CONN_DISABLE_80P80MHZ |
-		      IEEE80211_CONN_DISABLE_160MHZ;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_80;
 		break;
 	case NL80211_CHAN_WIDTH_320:
 		/* n_P20 */
@@ -4430,13 +4499,7 @@ ieee80211_conn_flags_t ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 		tmp /= 8;
 		c->center_freq1 = c->center_freq1 - 80 + 160 * tmp;
 		c->width = NL80211_CHAN_WIDTH_160;
-		ret = IEEE80211_CONN_DISABLE_320MHZ;
-		break;
-	default:
-	case NL80211_CHAN_WIDTH_20_NOHT:
-		WARN_ON_ONCE(1);
-		c->width = NL80211_CHAN_WIDTH_20_NOHT;
-		ret = IEEE80211_CONN_DISABLE_HT | IEEE80211_CONN_DISABLE_VHT;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_160;
 		break;
 	case NL80211_CHAN_WIDTH_1:
 	case NL80211_CHAN_WIDTH_2:
@@ -4447,13 +4510,12 @@ ieee80211_conn_flags_t ieee80211_chandef_downgrade(struct cfg80211_chan_def *c)
 	case NL80211_CHAN_WIDTH_10:
 		WARN_ON_ONCE(1);
 		/* keep c->width */
-		ret = IEEE80211_CONN_DISABLE_HT | IEEE80211_CONN_DISABLE_VHT;
+		conn->mode = IEEE80211_CONN_MODE_LEGACY;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
 		break;
 	}
 
 	WARN_ON_ONCE(!cfg80211_chandef_valid(c));
-
-	return ret;
 }
 
 /*
-- 
2.42.0


