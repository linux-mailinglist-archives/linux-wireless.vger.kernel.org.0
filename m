Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EB95AB426
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiIBOvc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiIBOvF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796249F0F2
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Qwz7IDFzJHzLEXI55DmhwjOLK18C8Boe99ke3pY++Is=;
        t=1662127990; x=1663337590; b=tvDnisghHyN8RD9eU9MNrIHqdXMM0ZO3aoPHsn7uW1Oplmb
        G5KVcCkdh79LlefvhXZAFzUFcEq4BioXh8qGHrv8Bd6hmBnf6oxtPfIS45wlD5duKcNWr2CvZg5fy
        o32aFwIokcSOYT1dTneNWv5SwD1jvJPR1Zg5RqfAi6sAKc62d77UZBEa0w8G8IA7SeTZKazWL7VRb
        nH93uFIY/CaFpRbRdCB1ZorxYZ0OyeakYGN2/fxwyqUmiEV/USHxaEIzerOhaBqfgrPp5CJRGzwXI
        QkMBB9gh47DYeoqbeUADa+5tyrE28PeK8uCavAa+4Zcro3cDHqyXvMfBPzyR7Atg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pw-006Ch3-2I;
        Fri, 02 Sep 2022 16:13:08 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/27] wifi: mac80211_hwsim: track active STA links
Date:   Fri,  2 Sep 2022 16:12:45 +0200
Message-Id: <20220902161143.91006e4d67ea.Iefbba1427a3aea30d84f60cacd7cbedaf74d2cdd@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Track the powersave bit on frames where we can look up
the STA by link addresses and set the links active or
inactive accordingly, and use this information to TX
only on links that are actually active in the peer.

Note that this doesn't implement powersave fully so
if no link is active things will not work right.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index f17de806a35d..b5bc707d8e4e 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -229,6 +229,7 @@ static inline void hwsim_clear_magic(struct ieee80211_vif *vif)
 struct hwsim_sta_priv {
 	u32 magic;
 	unsigned int last_link;
+	u16 active_links_rx;
 };
 
 #define HWSIM_STA_MAGIC	0x6d537749
@@ -1567,6 +1568,29 @@ static void mac80211_hwsim_rx(struct mac80211_hwsim_data *data,
 			      struct ieee80211_rx_status *rx_status,
 			      struct sk_buff *skb)
 {
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+
+	if (!ieee80211_has_morefrags(hdr->frame_control) &&
+	    !is_multicast_ether_addr(hdr->addr1) &&
+	    (ieee80211_is_mgmt(hdr->frame_control) ||
+	     ieee80211_is_data(hdr->frame_control))) {
+		struct ieee80211_sta *sta;
+		unsigned int link_id;
+
+		rcu_read_lock();
+		sta = ieee80211_find_sta_by_link_addrs(data->hw, hdr->addr2,
+						       hdr->addr1, &link_id);
+		if (sta) {
+			struct hwsim_sta_priv *sp = (void *)sta->drv_priv;
+
+			if (ieee80211_has_pm(hdr->frame_control))
+				sp->active_links_rx &= ~BIT(link_id);
+			else
+				sp->active_links_rx |= BIT(link_id);
+		}
+		rcu_read_unlock();
+	}
+
 	memcpy(IEEE80211_SKB_RXCB(skb), rx_status, sizeof(*rx_status));
 
 	mac80211_hwsim_add_vendor_rtap(skb);
@@ -1738,6 +1762,9 @@ mac80211_hwsim_select_tx_link(struct mac80211_hwsim_data *data,
 		if (!(vif->active_links & BIT(link_id)))
 			continue;
 
+		if (!(sp->active_links_rx & BIT(link_id)))
+			continue;
+
 		*link_sta = rcu_dereference(sta->link[link_id]);
 		if (!*link_sta)
 			continue;
@@ -2412,10 +2439,19 @@ static int mac80211_hwsim_sta_add(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta)
 {
+	struct hwsim_sta_priv *sp = (void *)sta->drv_priv;
+
 	hwsim_check_magic(vif);
 	hwsim_set_sta_magic(sta);
 	mac80211_hwsim_sta_rc_update(hw, vif, sta, 0);
 
+	if (sta->valid_links) {
+		WARN(hweight16(sta->valid_links) > 1,
+		     "expect to add STA with single link, have 0x%x\n",
+		     sta->valid_links);
+		sp->active_links_rx = sta->valid_links;
+	}
+
 	return 0;
 }
 
@@ -3037,8 +3073,13 @@ static int mac80211_hwsim_change_sta_links(struct ieee80211_hw *hw,
 					   struct ieee80211_sta *sta,
 					   u16 old_links, u16 new_links)
 {
+	struct hwsim_sta_priv *sp = (void *)sta->drv_priv;
+
 	hwsim_check_sta_magic(sta);
 
+	if (vif->type == NL80211_IFTYPE_STATION)
+		sp->active_links_rx = new_links;
+
 	return 0;
 }
 
-- 
2.37.2

