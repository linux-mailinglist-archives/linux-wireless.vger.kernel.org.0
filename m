Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7957278B15A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjH1NJl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjH1NJd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 09:09:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D37CC
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 06:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yKvczykbCBbs1mw669eJ5ML0FkWfqshW9Tm/sR+WZF8=;
        t=1693228171; x=1694437771; b=UHRreAsZ/qJ8qMyXtCW2EZqWgW85t6yUKJVom6MMTZJeB68
        yExoNjfHqosvdgCz+4ijNVep6yWSe3jEoKz1/Jbjt/bEjpjMIVsSVGCX3CItuuEaUBfnoowbxmsoQ
        GOTTJROvgiJiqmcowHxSSU+tPeXGHmMspomYbfEG8/0UJTAKOi8ssl5qArW3kqjkWZ72gJu9DQ0QO
        h74odw4AgcN36QW8K6+pSR5iIDnwNWOmjwAm9782jbGuhykFm2s1veMG1lkaiaBkI8aN7/ud9IpBL
        TnAJF0K4aXNbwiX4RYK3CzmRTVIF+kct9LKM7VqySf7fcpdocFea7yD9LlAxC1WA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qabzk-00Go8O-1w;
        Mon, 28 Aug 2023 15:09:28 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 3/4] wifi: mac80211: Fix SMPS handling in the context of MLO
Date:   Mon, 28 Aug 2023 15:09:25 +0200
Message-ID: <20230828150922.2cce9b20924e.Iaed8aaac30f599e030b9e9de5e868faaa2c1a0ab@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828150922.c5182ba79e0f.I5efd1399be8e6dedc1e48982b7f20c531ff37616@changeid>
References: <20230828150922.c5182ba79e0f.I5efd1399be8e6dedc1e48982b7f20c531ff37616@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

When the connection is a MLO connection, a SMPS request should be
sent on a specific link, as SMPS is BSS specific, and the DA and BSSID
used for the action frame transmission should be the AP MLD address, as
the underlying driver is expected to perform the address translation
(based on the link ID).

Fix the SMPS request handling to use the AP MLD address and provide the
link ID for the request processing during Tx.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: fix the non-MLD case
---
 net/mac80211/cfg.c         | 10 ++++++++--
 net/mac80211/ht.c          |  4 ++--
 net/mac80211/ieee80211_i.h |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 29a6da5ee77f..fa20a260f9c8 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3178,6 +3178,10 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
 		return -EINVAL;
 
+	if (ieee80211_vif_is_mld(&sdata->vif) &&
+	    !(sdata->vif.active_links & BIT(link->link_id)))
+		return 0;
+
 	old_req = link->u.mgd.req_smps;
 	link->u.mgd.req_smps = smps_mode;
 
@@ -3194,7 +3198,7 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	    link->conf->chandef.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
-	ap = link->u.mgd.bssid;
+	ap = sdata->vif.cfg.ap_addr;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
@@ -3216,7 +3220,9 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 
 	/* send SM PS frame to AP */
 	err = ieee80211_send_smps_action(sdata, smps_mode,
-					 ap, ap);
+					 ap, ap,
+					 ieee80211_vif_is_mld(&sdata->vif) ?
+					 link->link_id : -1);
 	if (err)
 		link->u.mgd.req_smps = old_req;
 	else if (smps_mode != IEEE80211_SMPS_OFF && tdls_peer_found)
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 33729870ad8a..802b0e738696 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -538,7 +538,7 @@ ieee80211_smps_mode_to_smps_mode(enum ieee80211_smps_mode smps)
 
 int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 			       enum ieee80211_smps_mode smps, const u8 *da,
-			       const u8 *bssid)
+			       const u8 *bssid, int link_id)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
@@ -579,7 +579,7 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 
 	/* we'll do more on status of this frame */
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-	ieee80211_tx_skb(sdata, skb);
+	ieee80211_tx_skb_tid(sdata, skb, 7, link_id);
 
 	return 0;
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7b74cf96ee0a..1df2101d8eeb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2098,7 +2098,7 @@ void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 			  u16 initiator, u16 reason_code);
 int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 			       enum ieee80211_smps_mode smps, const u8 *da,
-			       const u8 *bssid);
+			       const u8 *bssid, int link_id);
 bool ieee80211_smps_is_restrictive(enum ieee80211_smps_mode smps_mode_old,
 				   enum ieee80211_smps_mode smps_mode_new);
 
-- 
2.41.0

