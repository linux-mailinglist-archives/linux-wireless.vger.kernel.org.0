Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F5258312
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 22:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgHaU4Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 16:56:24 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52280 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729579AbgHaU4X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 16:56:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 687F34F8DB8;
        Mon, 31 Aug 2020 20:56:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rZKAZmcShEi4; Mon, 31 Aug 2020 20:56:20 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 7F3D94F8DE3;
        Mon, 31 Aug 2020 20:56:09 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 09/22] mac80211: support S1G STA capabilities
Date:   Mon, 31 Aug 2020 13:55:47 -0700
Message-Id: <20200831205600.21058-10-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200831205600.21058-1-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Include the S1G Capabilities element in an association
request, and support the cfg80211 capability overrides.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/ieee80211_i.h |  4 ++++
 net/mac80211/mlme.c        |  8 +++++++
 net/mac80211/util.c        | 45 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6bf879660a93..9363f43887b4 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -530,6 +530,8 @@ struct ieee80211_if_managed {
 	struct ieee80211_ht_cap ht_capa_mask; /* Valid parts of ht_capa */
 	struct ieee80211_vht_cap vht_capa; /* configured VHT overrides */
 	struct ieee80211_vht_cap vht_capa_mask; /* Valid parts of vht_capa */
+	struct ieee80211_s1g_cap s1g_capa; /* configured S1G overrides */
+	struct ieee80211_s1g_cap s1g_capa_mask; /* valid s1g_capa bits */
 
 	/* TDLS support */
 	u8 tdls_peer[ETH_ALEN] __aligned(2);
@@ -2193,6 +2195,8 @@ int ieee80211_add_ext_srates_ie(struct ieee80211_sub_if_data *sdata,
 				struct sk_buff *skb, bool need_basic,
 				enum nl80211_band band);
 u8 *ieee80211_add_wmm_info_ie(u8 *buf, u8 qosinfo);
+u8 *ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
+			       struct ieee80211_sta_s1g_cap *caps, u8 *buf);
 
 /* channel management */
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ac870309b911..b69889563457 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1018,6 +1018,10 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		pos = ieee80211_add_wmm_info_ie(skb_put(skb, 9), qos_info);
 	}
 
+	if (sband->band == NL80211_BAND_S1GHZ)
+		pos = ieee80211_add_s1g_capab_ie(sdata, &sband->s1g_cap,
+						 skb_put(skb, 17));
+
 	/* add any remaining custom (i.e. vendor specific here) IEs */
 	if (assoc_data->ie_len) {
 		noffset = assoc_data->ie_len;
@@ -5461,6 +5465,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	memcpy(&ifmgd->vht_capa_mask, &req->vht_capa_mask,
 	       sizeof(ifmgd->vht_capa_mask));
 
+	memcpy(&ifmgd->s1g_capa, &req->s1g_capa, sizeof(ifmgd->s1g_capa));
+	memcpy(&ifmgd->s1g_capa_mask, &req->s1g_capa_mask,
+	       sizeof(ifmgd->s1g_capa_mask));
+
 	if (req->ie && req->ie_len) {
 		memcpy(assoc_data->ie, req->ie, req->ie_len);
 		assoc_data->ie_len = req->ie_len;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c8504ffc71a1..27b2f1ceca69 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4276,6 +4276,51 @@ int ieee80211_max_num_channels(struct ieee80211_local *local)
 	return max_num_different_channels;
 }
 
+u8 *ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
+			       struct ieee80211_sta_s1g_cap *own_cap, u8 *buf)
+{
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	struct ieee80211_s1g_cap s1g_capab;
+	u8 *pos = buf;
+	int i;
+
+	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_STATION))
+		return pos;
+
+	if (!own_cap->s1g)
+		return pos;
+
+	memcpy(s1g_capab.capab_info, own_cap->cap, sizeof(own_cap->cap));
+	memcpy(s1g_capab.supp_mcs_nss, own_cap->nss_mcs,
+	       sizeof(own_cap->nss_mcs));
+
+	/* override the capability info */
+	for (i = 0; i < sizeof(ifmgd->s1g_capa.capab_info); i++) {
+		u8 mask = ifmgd->s1g_capa_mask.capab_info[i];
+
+		s1g_capab.capab_info[i] &= ~mask;
+		s1g_capab.capab_info[i] |= (ifmgd->s1g_capa.capab_info[i] &
+					    mask);
+	}
+
+	/* then MCS and NSS set */
+	for (i = 0; i < sizeof(ifmgd->s1g_capa.supp_mcs_nss); i++) {
+		u8 mask = ifmgd->s1g_capa_mask.supp_mcs_nss[i];
+
+		s1g_capab.supp_mcs_nss[i] &= ~mask;
+		s1g_capab.supp_mcs_nss[i] |= (ifmgd->s1g_capa.supp_mcs_nss[i] &
+					      mask);
+	}
+
+	*pos++ = WLAN_EID_S1G_CAPABILITIES;
+	*pos++ = sizeof(s1g_capab);
+
+	memcpy(pos, &s1g_capab, sizeof(s1g_capab));
+	pos += sizeof(s1g_capab);
+
+	return pos;
+}
+
 u8 *ieee80211_add_wmm_info_ie(u8 *buf, u8 qosinfo)
 {
 	*buf++ = WLAN_EID_VENDOR_SPECIFIC;
-- 
2.20.1

