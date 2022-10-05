Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3EB5F54E1
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJENBT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJENA5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084711EECF
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9tv3I5iPzNPH5DgrY9SUK8azWbNXtWI9nPFvJjn4vUw=;
        t=1664974856; x=1666184456; b=JzNLYOi/ZKFsRCUBanQywBsssX7345HAU0JKv6SJGxHdXQp
        RYmBrja/nRm8A+7rjDWWH2opA5MiImBjBd4B8+yln/aEOV8OeHwYNGr35TH6HUb6Y4zpHzkUJCKDD
        3+ZKIe6oYQWn5fgzGfx1b/SD7xMSYgnfL+TLle9pxHEAnp/kRRRWAnnPDHhmWQH2ZxWzM/Orenqge
        EyuzHK485bjF45L+rQDW7P5TgpOneKM4whATq8viDdyZergMzzBuQFGowkre1EcRawPeorj3+wWZT
        dotbMnS3Mm7JiYfoP2iIkkAL3hN63pBBZffogFq8FOoOi72kv6+x64fn+AhYQORQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og418-00G2RL-10;
        Wed, 05 Oct 2022 15:00:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Haim Dreyfuss <haim.dreyfuss@intel.com>
Subject: [PATCH 15/28] wifi: mac80211: advertise TWT requester only with HW support
Date:   Wed,  5 Oct 2022 15:00:35 +0200
Message-Id: <20221005145226.4c01851c1557.I671c4b73e3a85580a977e9166a5721add10c37e1@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
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

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

Currently, we rely only on the AP capability. If the AP supports
TWT responder we will advertise TWT requester even if the driver
or HW doesn't support it. This this by checking the HW capability.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2e4bb75c68c0..b6f378e7edea 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3870,9 +3870,15 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 	}
 }
 
-static bool ieee80211_twt_req_supported(const struct link_sta_info *link_sta,
+static bool ieee80211_twt_req_supported(struct ieee80211_sub_if_data *sdata,
+					struct ieee80211_supported_band *sband,
+					const struct link_sta_info *link_sta,
 					const struct ieee802_11_elems *elems)
 {
+	const struct ieee80211_sta_he_cap *own_he_cap =
+		ieee80211_get_he_iftype_cap(sband,
+					    ieee80211_vif_type_p2p(&sdata->vif));
+
 	if (elems->ext_capab_len < 10)
 		return false;
 
@@ -3880,14 +3886,19 @@ static bool ieee80211_twt_req_supported(const struct link_sta_info *link_sta,
 		return false;
 
 	return link_sta->pub->he_cap.he_cap_elem.mac_cap_info[0] &
-		IEEE80211_HE_MAC_CAP0_TWT_RES;
+		IEEE80211_HE_MAC_CAP0_TWT_RES &&
+		own_he_cap &&
+		(own_he_cap->he_cap_elem.mac_cap_info[0] &
+			IEEE80211_HE_MAC_CAP0_TWT_REQ);
 }
 
-static int ieee80211_recalc_twt_req(struct ieee80211_link_data *link,
+static int ieee80211_recalc_twt_req(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
+				    struct ieee80211_link_data *link,
 				    struct link_sta_info *link_sta,
 				    struct ieee802_11_elems *elems)
 {
-	bool twt = ieee80211_twt_req_supported(link_sta, elems);
+	bool twt = ieee80211_twt_req_supported(sdata, sband, link_sta, elems);
 
 	if (link->conf->twt_requester != twt) {
 		link->conf->twt_requester = twt;
@@ -4129,7 +4140,8 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		else
 			bss_conf->twt_protected = false;
 
-		*changed |= ieee80211_recalc_twt_req(link, link_sta, elems);
+		*changed |= ieee80211_recalc_twt_req(sdata, sband, link,
+						     link_sta, elems);
 
 		if (elems->eht_operation && elems->eht_cap &&
 		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)) {
@@ -5472,6 +5484,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	struct ieee802_11_elems *elems;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *chanctx_conf;
+	struct ieee80211_supported_band *sband;
 	struct ieee80211_channel *chan;
 	struct link_sta_info *link_sta;
 	struct sta_info *sta;
@@ -5734,7 +5747,12 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		goto free;
 	}
 
-	changed |= ieee80211_recalc_twt_req(link, link_sta, elems);
+	if (WARN_ON(!link->conf->chandef.chan))
+		goto free;
+
+	sband = local->hw.wiphy->bands[link->conf->chandef.chan->band];
+
+	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
 	if (ieee80211_config_bw(link, elems->ht_cap_elem,
 				elems->vht_cap_elem, elems->ht_operation,
-- 
2.37.3

