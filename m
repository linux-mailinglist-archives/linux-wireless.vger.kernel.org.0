Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0345E1C4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfGCKTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 06:19:00 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:36498 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGCKTA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 06:19:00 -0400
Received: from sven-desktop.home.narfation.org (p4FCB2E24.dip0.t-ipconnect.de [79.203.46.36])
        by dvalin.narfation.org (Postfix) with ESMTPSA id DB48E20955;
        Wed,  3 Jul 2019 10:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562149137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxSqv/s0rK9MzmA2NrC5jqNYf2mnkMEEXsn1g41gLBw=;
        b=x7p4CTCGVG4t+OsuzrV4pt27SYvpKwp45XnmSh8oEgw01A80FG0XREIPvuZ1EsCnenqDHB
        NsQUKMd9yRO5gw/sb1F6ys3FquAI3mCNg/T3vfqV2Zr7LwCWdlNUSaPeiipYD+ODO4w/Ov
        l6rMnuEOv7IQC8D0WQ5c3pXZo8tsQ7s=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <seckelmann@datto.com>
Subject: [PATCH v4 1/3] mac80211: implement HE support for mesh
Date:   Wed,  3 Jul 2019 12:18:37 +0200
Message-Id: <20190703101839.18827-2-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703101839.18827-1-sven@narfation.org>
References: <20190703101839.18827-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562149137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxSqv/s0rK9MzmA2NrC5jqNYf2mnkMEEXsn1g41gLBw=;
        b=R37SO2xXRykZcDpdONMsQ31s8A4kst7IhW/06oExnRtVIoaCqI1GKYCyd2rvJuGTLrs/Lm
        Kmxvd1Z9cfYjnp9cE1VjV4N80wRGa5t8h5jnUImIJZUHUfbRicTDuy9pgWA/VqvJnuNWlJ
        IwAZ8t4QLcRNii9Vgf7l0W/ibhrMMcs=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1562149137; a=rsa-sha256;
        cv=none;
        b=RxJtDwYopAuNn61dOLcUaRlAbSzmI9p9tKrR338AWHxRJkd79fwcS8lVysVqvsrn0rwHGZ
        QSP4kphRHu5+6LmM7DpKXp5EH6vJmUNycCmW3faxQkpQH/+/BEuV2ZIHM8++Vx0DQv7Mi0
        KUDaO2nh/vzHcHPiYF+W//04g0Pinnk=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sven Eckelmann <seckelmann@datto.com>

Implement the basics required for supporting high efficiency with mesh:
include HE information elements in beacons, probe responses, and peering
action frames, and check for compatible HE configurations when peering.

Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mesh.c        | 62 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/mesh.h        |  4 +++
 net/mac80211/mesh_plink.c  | 12 +++++++-
 net/mac80211/util.c        | 49 ++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 004e2e3adb88..6e924ba9eeb1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2133,9 +2133,11 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 			       u32 cap);
 u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 				const struct cfg80211_chan_def *chandef);
+u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype);
 u8 *ieee80211_ie_build_he_cap(u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end);
+u8 *ieee80211_ie_build_he_oper(u8 *pos);
 int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 2e7fa743c892..d09b3c789314 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -532,6 +532,61 @@ int mesh_add_vht_oper_ie(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
+		       struct sk_buff *skb, u8 ie_len)
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_supported_band *sband;
+	u8 *pos;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
+
+	if (!he_cap ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+		return 0;
+
+	if (skb_tailroom(skb) < ie_len)
+		return -ENOMEM;
+
+	pos = skb_put(skb, ie_len);
+	ieee80211_ie_build_he_cap(pos, he_cap, pos + ie_len);
+
+	return 0;
+}
+
+int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
+			struct sk_buff *skb)
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_supported_band *sband;
+	u8 *pos;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
+	if (!he_cap ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+		return 0;
+
+	if (skb_tailroom(skb) < 2 + 1 + sizeof(struct ieee80211_he_operation))
+		return -ENOMEM;
+
+	pos = skb_put(skb, 2 + 1 + sizeof(struct ieee80211_he_operation));
+	ieee80211_ie_build_he_oper(pos);
+
+	return 0;
+}
+
 static void ieee80211_mesh_path_timer(struct timer_list *t)
 {
 	struct ieee80211_sub_if_data *sdata =
@@ -677,6 +732,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct mesh_csa_settings *csa;
 	enum nl80211_band band;
+	u8 ie_len_he_cap;
 	u8 *pos;
 	struct ieee80211_sub_if_data *sdata;
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.beacon);
@@ -687,6 +743,8 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	band = chanctx_conf->def.chan->band;
 	rcu_read_unlock();
 
+	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata,
+						NL80211_IFTYPE_MESH_POINT);
 	head_len = hdr_len +
 		   2 + /* NULL SSID */
 		   /* Channel Switch Announcement */
@@ -706,6 +764,8 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 		   2 + sizeof(__le16) + /* awake window */
 		   2 + sizeof(struct ieee80211_vht_cap) +
 		   2 + sizeof(struct ieee80211_vht_operation) +
+		   ie_len_he_cap +
+		   2 + 1 + sizeof(struct ieee80211_he_operation) +
 		   ifmsh->ie_len;
 
 	bcn = kzalloc(sizeof(*bcn) + head_len + tail_len, GFP_KERNEL);
@@ -823,6 +883,8 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	    mesh_add_awake_window_ie(sdata, skb) ||
 	    mesh_add_vht_cap_ie(sdata, skb) ||
 	    mesh_add_vht_oper_ie(sdata, skb) ||
+	    mesh_add_he_cap_ie(sdata, skb, ie_len_he_cap) ||
+	    mesh_add_he_oper_ie(sdata, skb) ||
 	    mesh_add_vendor_ies(sdata, skb))
 		goto out_free;
 
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 94d57cce70da..953f720754e8 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -218,6 +218,10 @@ int mesh_add_vht_cap_ie(struct ieee80211_sub_if_data *sdata,
 			struct sk_buff *skb);
 int mesh_add_vht_oper_ie(struct ieee80211_sub_if_data *sdata,
 			 struct sk_buff *skb);
+int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
+		       struct sk_buff *skb, u8 ie_len);
+int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
+			struct sk_buff *skb);
 void mesh_rmc_free(struct ieee80211_sub_if_data *sdata);
 int mesh_rmc_init(struct ieee80211_sub_if_data *sdata);
 void ieee80211s_init(void);
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index dd3aefd052a9..737c5f4dbf52 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -218,9 +218,12 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 	bool include_plid = false;
 	u16 peering_proto = 0;
 	u8 *pos, ie_len = 4;
+	u8 ie_len_he_cap;
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.self_prot);
 	int err = -ENOMEM;
 
+	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata,
+						NL80211_IFTYPE_MESH_POINT);
 	skb = dev_alloc_skb(local->tx_headroom +
 			    hdr_len +
 			    2 + /* capability info */
@@ -233,6 +236,8 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 			    2 + sizeof(struct ieee80211_ht_operation) +
 			    2 + sizeof(struct ieee80211_vht_cap) +
 			    2 + sizeof(struct ieee80211_vht_operation) +
+			    ie_len_he_cap +
+			    2 + 1 + sizeof(struct ieee80211_he_operation) +
 			    2 + 8 + /* peering IE */
 			    sdata->u.mesh.ie_len);
 	if (!skb)
@@ -321,7 +326,9 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 		if (mesh_add_ht_cap_ie(sdata, skb) ||
 		    mesh_add_ht_oper_ie(sdata, skb) ||
 		    mesh_add_vht_cap_ie(sdata, skb) ||
-		    mesh_add_vht_oper_ie(sdata, skb))
+		    mesh_add_vht_oper_ie(sdata, skb) ||
+		    mesh_add_he_cap_ie(sdata, skb, ie_len_he_cap) ||
+		    mesh_add_he_oper_ie(sdata, skb))
 			goto free;
 	}
 
@@ -433,6 +440,9 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 	ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 					    elems->vht_cap_elem, sta);
 
+	ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband, elems->he_cap,
+					  elems->he_cap_len, sta);
+
 	if (bw != sta->sta.bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1b224fa27367..52f5082bb165 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2702,6 +2702,27 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 	return pos;
 }
 
+u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_supported_band *sband;
+	u8 n;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return 0;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, iftype);
+	if (!he_cap)
+		return 0;
+
+	n = ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem);
+	return 2 + 1 +
+	       sizeof(he_cap->he_cap_elem) + n +
+	       ieee80211_he_ppe_size(he_cap->ppe_thres[0],
+				     he_cap->he_cap_elem.phy_cap_info);
+}
+
 u8 *ieee80211_ie_build_he_cap(u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end)
@@ -2891,6 +2912,34 @@ u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 	return pos + sizeof(struct ieee80211_vht_operation);
 }
 
+u8 *ieee80211_ie_build_he_oper(u8 *pos)
+{
+	struct ieee80211_he_operation *he_oper;
+	u32 he_oper_params;
+
+	*pos++ = WLAN_EID_EXTENSION;
+	*pos++ = 1 + sizeof(struct ieee80211_he_operation);
+	*pos++ = WLAN_EID_EXT_HE_OPERATION;
+
+	he_oper_params = 0;
+	he_oper_params |= u32_encode_bits(1023, /* disabled */
+				IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
+	he_oper_params |= u32_encode_bits(1,
+				IEEE80211_HE_OPERATION_ER_SU_DISABLE);
+	he_oper_params |= u32_encode_bits(1,
+				IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
+
+	he_oper = (struct ieee80211_he_operation *)pos;
+	he_oper->he_oper_params = cpu_to_le32(he_oper_params);
+
+	/* don't require special HE peer rates */
+	he_oper->he_mcs_nss_set = cpu_to_le16(0xffff);
+
+	/* TODO add VHT operational and 6GHz operational subelement? */
+
+	return pos + sizeof(struct ieee80211_vht_operation);
+}
+
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
 			       struct cfg80211_chan_def *chandef)
 {
-- 
2.20.1

