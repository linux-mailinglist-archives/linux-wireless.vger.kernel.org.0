Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65C57335F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiGMJqv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiGMJpk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36444F78B2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=QLYmK6grybLHabjDFerAJWZQ9IhuIiX/u6kR6PwK6Ls=;
        t=1657705530; x=1658915130; b=mnS70LiLhmXjEsdKlm2JuiAvljHYNJ/tpkwkax5ZnnBOumJ
        roNNu43BimHYFYGiwJtW+y8MTi4Kj7RBZObeL2Hd5r99BLGy9FO6XzIiNTAnfLBCYirIcUdyEsCQm
        c79XHAk6PBoLs+TGB+zQpRqIJ/L6SoeLRjFNk4mmkR8tsjxsauFU6MPyCYF9yIC9pf/4GYyfjToc/
        c/3ly2EN49IMVhPadRlYRp62eiH6EhkuieVWMrz7ztDHqucvUFtlJhzo/ynmbKgbBlD1kTrRAlRZ6
        uj5/72t5zoxrJ7+yvAmoV8mZPqoUAUSJ5lTw3ksyiKg2jb5KrXgHh7hOLirxbiqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvw-00EgvB-82;
        Wed, 13 Jul 2022 11:45:28 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 68/76] wifi: mac80211: Allow EAPOL frames from link addresses
Date:   Wed, 13 Jul 2022 11:44:54 +0200
Message-Id: <20220713114426.44b23683d856.Icb74df4bf6e952ef304d7dab777e836ca9245786@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Allow transmitting EAPOL frames not only from the interface
address (which is the MLD address) but also any link addresses,
in order to support non-MLO stations on AP interfaces.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 60 +++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 9f7ce1377604..97046d30c9ca 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2532,6 +2532,35 @@ __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
 	return 0;
 }
 
+static bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
+				  const u8 *addr, int *out_link_id)
+{
+	unsigned int link_id;
+
+	/* non-MLO, or MLD address replaced by hardware */
+	if (ether_addr_equal(sdata->vif.addr, addr))
+		return true;
+
+	if (!sdata->vif.valid_links)
+		return false;
+
+	for (link_id = 0; link_id < ARRAY_SIZE(sdata->vif.link_conf); link_id++) {
+		struct ieee80211_bss_conf *conf;
+
+		conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+
+		if (!conf)
+			continue;
+		if (ether_addr_equal(conf->addr, addr)) {
+			if (out_link_id)
+				*out_link_id = link_id;
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /*
  * requires that rx->skb is a frame with ethernet header
  */
@@ -2547,7 +2576,7 @@ static bool ieee80211_frame_allowed(struct ieee80211_rx_data *rx, __le16 fc)
 	 * all other destination addresses for them.
 	 */
 	if (unlikely(ehdr->h_proto == rx->sdata->control_port_protocol))
-		return ether_addr_equal(ehdr->h_dest, rx->sdata->vif.addr) ||
+		return ieee80211_is_our_addr(rx->sdata, ehdr->h_dest, NULL) ||
 		       ether_addr_equal(ehdr->h_dest, pae_group_addr);
 
 	if (ieee80211_802_1x_port_control(rx) ||
@@ -4142,35 +4171,6 @@ static inline int ieee80211_bssid_match(const u8 *raddr, const u8 *addr)
 	       is_broadcast_ether_addr(raddr);
 }
 
-static bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
-				  const u8 *addr, int *out_link_id)
-{
-	unsigned int link_id;
-
-	/* non-MLO, or MLD address replaced by hardware */
-	if (ether_addr_equal(sdata->vif.addr, addr))
-		return true;
-
-	if (!sdata->vif.valid_links)
-		return false;
-
-	for (link_id = 0; link_id < ARRAY_SIZE(sdata->vif.link_conf); link_id++) {
-		struct ieee80211_bss_conf *conf;
-
-		conf = rcu_dereference(sdata->vif.link_conf[link_id]);
-
-		if (!conf)
-			continue;
-		if (ether_addr_equal(conf->addr, addr)) {
-			if (out_link_id)
-				*out_link_id = link_id;
-			return true;
-		}
-	}
-
-	return false;
-}
-
 static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 {
 	struct ieee80211_sub_if_data *sdata = rx->sdata;
-- 
2.36.1

