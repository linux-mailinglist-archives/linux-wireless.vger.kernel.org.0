Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E646E2B709
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2019 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfE0Nx4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 May 2019 09:53:56 -0400
Received: from narfation.org ([79.140.41.39]:57082 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfE0Nx4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 May 2019 09:53:56 -0400
Received: from sven-desktop.home.narfation.org (p200300C5970B91EA00000000000002FB.dip0.t-ipconnect.de [IPv6:2003:c5:970b:91ea::2fb])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id EAE1A1100DC;
        Mon, 27 May 2019 15:53:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558965233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+RkFk2fD/MD3doLVuCoZWkHnZEHbUcXxgt3b7zypiw=;
        b=Lc0xnmIjaQ93/GEceuBLB09q2I7hF8m/rBykBAOfMIyoIlMJzyqoS74U5jvohw0Qu/CZbF
        Y7MzOVIBRiLbKCsqhBV/hk1fEz8dhKPWapsd/zzqAo0Xm4y7/XibxX5nzw6/XuY5F5S/qS
        5F0Zw0ZdyCyDDut5aMofGtkljOk6ibw=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     Sven Eckelmann <seckelmann@datto.com>
Subject: [RFC PATCH 2/2] mac80211: implement HE support for mesh
Date:   Mon, 27 May 2019 15:53:40 +0200
Message-Id: <20190527135340.15600-2-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527135340.15600-1-sven@narfation.org>
References: <20190527135340.15600-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1558965233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+RkFk2fD/MD3doLVuCoZWkHnZEHbUcXxgt3b7zypiw=;
        b=N9TEOcEf1kd+dBi2r1TjWGR2eJgFjdinII/TT1s2UGagYBabAiciFe4lFREA7BEeouAbcI
        cvDcG83thPqwD7yj+H4NQUO2IRJjnanP/F5wYum0qKixSQEE2LjQ+Zxu5sPsQY1OGqBDo2
        WF61+I3mudvJLgaRs1dbbRW0O5JpTnM=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1558965233; a=rsa-sha256;
        cv=none;
        b=RTM/xZMYtPEEsJDIu2F9g2/3HzDii/QDPXfQQ+krgTosTn91rozFgr0VPyjSwJWHh7hA9m
        VO4M7h0RRcrmzDzCJxDOVVHxiaT0QK+1Mc2OPCaB5P7T/QRcRWXnD6b7KJhoC4sOPV0hqi
        Pb2N6AZCADaJgm9xZIztqckfJBuD2/k=
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
 include/net/cfg80211.h     | 19 ++++++++++++
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mesh.c        | 61 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/mesh.h        |  4 +++
 net/mac80211/mesh_plink.c  | 11 ++++++-
 net/mac80211/util.c        | 52 ++++++++++++++++++++++++++++++++
 6 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 13bfeb712d36..9caa0ca5020d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -399,6 +399,25 @@ ieee80211_get_he_sta_cap(const struct ieee80211_supported_band *sband)
 	return NULL;
 }
 
+/**
+ * ieee80211_get_he_mesh_cap - return HE capabilities for an sband's mesh STA
+ * @sband: the sband to search for the mesh STA on
+ *
+ * Return: pointer to the struct ieee80211_sta_he_cap, or NULL is none found
+ */
+static inline const struct ieee80211_sta_he_cap *
+ieee80211_get_he_mesh_cap(const struct ieee80211_supported_band *sband)
+{
+	const struct ieee80211_sband_iftype_data *data =
+		ieee80211_get_sband_iftype_data(sband,
+						NL80211_IFTYPE_MESH_POINT);
+
+	if (data && data->he_cap.has_he)
+		return &data->he_cap;
+
+	return NULL;
+}
+
 /**
  * wiphy_read_of_freq_limits - read frequency limits from device tree
  *
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e170f986d226..dea736cdf60b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2126,9 +2126,11 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 			       u32 cap);
 u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 				const struct cfg80211_chan_def *chandef);
+u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata);
 u8 *ieee80211_ie_build_he_cap(u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end);
+u8 *ieee80211_ie_build_he_oper(u8 *pos);
 int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 766e5e5bab8a..47ef885c4060 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -535,6 +535,61 @@ int mesh_add_vht_oper_ie(struct ieee80211_sub_if_data *sdata,
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
+	he_cap = ieee80211_get_he_mesh_cap(sband);
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
+	he_cap = ieee80211_get_he_mesh_cap(sband);
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
@@ -680,6 +735,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct mesh_csa_settings *csa;
 	enum nl80211_band band;
+	u8 ie_len_he_cap;
 	u8 *pos;
 	struct ieee80211_sub_if_data *sdata;
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.beacon);
@@ -690,6 +746,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	band = chanctx_conf->def.chan->band;
 	rcu_read_unlock();
 
+	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata);
 	head_len = hdr_len +
 		   2 + /* NULL SSID */
 		   /* Channel Switch Announcement */
@@ -709,6 +766,8 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 		   2 + sizeof(__le16) + /* awake window */
 		   2 + sizeof(struct ieee80211_vht_cap) +
 		   2 + sizeof(struct ieee80211_vht_operation) +
+		   ie_len_he_cap +
+		   2 + 1 + sizeof(struct ieee80211_he_operation) +
 		   ifmsh->ie_len;
 
 	bcn = kzalloc(sizeof(*bcn) + head_len + tail_len, GFP_KERNEL);
@@ -826,6 +885,8 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	    mesh_add_awake_window_ie(sdata, skb) ||
 	    mesh_add_vht_cap_ie(sdata, skb) ||
 	    mesh_add_vht_oper_ie(sdata, skb) ||
+	    mesh_add_he_cap_ie(sdata, skb, ie_len_he_cap) ||
+	    mesh_add_he_oper_ie(sdata, skb) ||
 	    mesh_add_vendor_ies(sdata, skb))
 		goto out_free;
 
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 574c3891c4b2..af1d9154b255 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -221,6 +221,10 @@ int mesh_add_vht_cap_ie(struct ieee80211_sub_if_data *sdata,
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
index 8afd0ece94c9..e18e433fde29 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -221,9 +221,11 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 	bool include_plid = false;
 	u16 peering_proto = 0;
 	u8 *pos, ie_len = 4;
+	u8 ie_len_he_cap;
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.self_prot);
 	int err = -ENOMEM;
 
+	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata);
 	skb = dev_alloc_skb(local->tx_headroom +
 			    hdr_len +
 			    2 + /* capability info */
@@ -236,6 +238,8 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 			    2 + sizeof(struct ieee80211_ht_operation) +
 			    2 + sizeof(struct ieee80211_vht_cap) +
 			    2 + sizeof(struct ieee80211_vht_operation) +
+			    ie_len_he_cap +
+			    2 + 1 + sizeof(struct ieee80211_he_operation) +
 			    2 + 8 + /* peering IE */
 			    sdata->u.mesh.ie_len);
 	if (!skb)
@@ -324,7 +328,9 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 		if (mesh_add_ht_cap_ie(sdata, skb) ||
 		    mesh_add_ht_oper_ie(sdata, skb) ||
 		    mesh_add_vht_cap_ie(sdata, skb) ||
-		    mesh_add_vht_oper_ie(sdata, skb))
+		    mesh_add_vht_oper_ie(sdata, skb) ||
+		    mesh_add_he_cap_ie(sdata, skb, ie_len_he_cap) ||
+		    mesh_add_he_oper_ie(sdata, skb))
 			goto free;
 	}
 
@@ -436,6 +442,9 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 	ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 					    elems->vht_cap_elem, sta);
 
+	ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband, elems->he_cap,
+					  elems->he_cap_len, sta);
+
 	if (bw != sta->sta.bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 4c1655972565..d86925438b5f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2663,6 +2663,30 @@ u8 *ieee80211_ie_build_vht_cap(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 	return pos;
 }
 
+u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata)
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_supported_band *sband;
+	u8 ie_len;
+	u8 n;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return 0;
+
+	he_cap = ieee80211_get_he_mesh_cap(sband);
+	if (!he_cap)
+		return 0;
+
+	n = ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem);
+	ie_len = 2 + 1 +
+		 sizeof(he_cap->he_cap_elem) + n +
+		 ieee80211_he_ppe_size(he_cap->ppe_thres[0],
+				       he_cap->he_cap_elem.phy_cap_info);
+
+	return ie_len;
+}
+
 u8 *ieee80211_ie_build_he_cap(u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end)
@@ -2852,6 +2876,34 @@ u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
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

