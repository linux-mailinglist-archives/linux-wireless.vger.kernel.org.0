Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D851AD992
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 11:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgDQJPb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 05:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgDQJPb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 05:15:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF4C061A0C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2020 02:15:31 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jPN5s-006tP6-Do; Fri, 17 Apr 2020 11:15:28 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: mlme: remove duplicate AID bookkeeping
Date:   Fri, 17 Apr 2020 11:15:19 +0200
Message-Id: <20200417111518.d3c9edb463d0.I2e7a2ceceea8c6880219f9e9ee4d4ac985fd295a@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Maintain the connection AID only in sdata->vif.bss_conf.aid, not
also in sdata->u.mgd.aid.

Keep setting that where we set ifmgd->aid before, which has the
side effect of exposing the AID to the driver before the station
entry (AP) is marked associated, in case it needs it then.

Requested-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 2 --
 net/mac80211/mlme.c        | 7 +++----
 net/mac80211/tdls.c        | 3 +--
 net/mac80211/tx.c          | 2 +-
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f8ed4f621f7f..934a91bef575 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -450,8 +450,6 @@ struct ieee80211_if_managed {
 
 	u8 bssid[ETH_ALEN] __aligned(2);
 
-	u16 aid;
-
 	bool powersave; /* powersave requested for this iface */
 	bool broken_ap; /* AP is broken -- turn off powersave */
 	bool have_beacon;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 16d75da0996a..7139335f29c0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3249,7 +3249,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		return false;
 	}
 
-	ifmgd->aid = aid;
+	sdata->vif.bss_conf.aid = aid;
 	ifmgd->tdls_chan_switch_prohibited =
 		elems->ext_capab && elems->ext_capab_len >= 5 &&
 		(elems->ext_capab[4] & WLAN_EXT_CAPA5_TDLS_CH_SW_PROHIBITED);
@@ -3521,9 +3521,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		bss_conf->protected_keep_alive = false;
 	}
 
-	/* set AID and assoc capability,
+	/* set assoc capability (AID was already set earlier),
 	 * ieee80211_set_associated() will tell the driver */
-	bss_conf->aid = aid;
 	bss_conf->assoc_capability = capab_info;
 	ieee80211_set_associated(sdata, cbss, changed);
 
@@ -3948,7 +3947,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 					  mgmt->bssid, bssid);
 
 	if (ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK) &&
-	    ieee80211_check_tim(elems.tim, elems.tim_len, ifmgd->aid)) {
+	    ieee80211_check_tim(elems.tim, elems.tim_len, bss_conf->aid)) {
 		if (local->hw.conf.dynamic_ps_timeout > 0) {
 			if (local->hw.conf.flags & IEEE80211_CONF_PS) {
 				local->hw.conf.flags &= ~IEEE80211_CONF_PS;
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index fca1f5477396..7ff22f9d6e80 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -226,12 +226,11 @@ static void ieee80211_tdls_add_link_ie(struct ieee80211_sub_if_data *sdata,
 static void
 ieee80211_tdls_add_aid(struct ieee80211_sub_if_data *sdata, struct sk_buff *skb)
 {
-	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 *pos = skb_put(skb, 4);
 
 	*pos++ = WLAN_EID_AID;
 	*pos++ = 2; /* len */
-	put_unaligned_le16(ifmgd->aid, pos);
+	put_unaligned_le16(sdata->vif.bss_conf.aid, pos);
 }
 
 /* translate numbering in the WMM parameter IE to the mac80211 notation */
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 82846aca86d9..3dc1990e15c5 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5006,7 +5006,7 @@ struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
 	pspoll = skb_put_zero(skb, sizeof(*pspoll));
 	pspoll->frame_control = cpu_to_le16(IEEE80211_FTYPE_CTL |
 					    IEEE80211_STYPE_PSPOLL);
-	pspoll->aid = cpu_to_le16(ifmgd->aid);
+	pspoll->aid = cpu_to_le16(sdata->vif.bss_conf.aid);
 
 	/* aid in PS-Poll has its two MSBs each set to 1 */
 	pspoll->aid |= cpu_to_le16(1 << 15 | 1 << 14);
-- 
2.25.1

