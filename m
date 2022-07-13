Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4CC573367
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiGMJqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiGMJpl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C400DF8940
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=h8r0EsZmEGEdYHzDuxqXu4xU76V1TNQ4D/QgICDf1BE=;
        t=1657705530; x=1658915130; b=cRSpSeQ3eEr3tI/4xvTyg03uXSYjACRF0svhVJlA1pJGKMG
        jRdyb9hT3/FDqT7qYLmsLiLR7BFQDsOvYFn/wgT0gks28LyuXKge1aPTGnUwoxMQuzG7nLFnr2wop
        ZafNgmAYrPs9nMP44UV8URgIwvT9tW8opbBStOiRfvj9OAoiUE2NDy5s4T4QiOBRQODahO6Aj2v5/
        6Jtpzo2+BBrApGPzVj/9JclPDqtZylWo6SW/Qbkt34aiWy1m4wRAlGESA8oVYvkYuTqDXdSMYPFqW
        uovccCUrKSpP9uTCPTxMzzx6bGkw2H8LN93VxYKmjB2wJHSZQL4sc3sqXBaMtLrg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvw-00EgvB-KG;
        Wed, 13 Jul 2022 11:45:28 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 69/76] wifi: mac80211: Allow EAPOL tx from specific link
Date:   Wed, 13 Jul 2022 11:44:55 +0200
Message-Id: <20220713114426.f8605a6ad828.I8d7bb06ee1b7be8b6ab526de0c66bc66476defef@changeid>
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

Allow link source address on TX.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 3 +++
 net/mac80211/rx.c          | 4 ++--
 net/mac80211/tx.c          | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 58b08315fa26..163e62dab045 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1752,6 +1752,9 @@ void __ieee80211_check_fast_rx_iface(struct ieee80211_sub_if_data *sdata);
 void ieee80211_check_fast_rx_iface(struct ieee80211_sub_if_data *sdata);
 void ieee80211_clear_fast_rx(struct sta_info *sta);
 
+bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
+			   const u8 *addr, int *out_link_id);
+
 /* STA code */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata);
 int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 97046d30c9ca..fcea7c3f5cd5 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2532,8 +2532,8 @@ __ieee80211_data_to_8023(struct ieee80211_rx_data *rx, bool *port_control)
 	return 0;
 }
 
-static bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
-				  const u8 *addr, int *out_link_id)
+bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
+			   const u8 *addr, int *out_link_id)
 {
 	unsigned int link_id;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1ba3bd180bd2..b9cb71dfa6cf 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2781,7 +2781,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		     (sdata->vif.type != NL80211_IFTYPE_OCB) &&
 		     !multicast && !authorized &&
 		     (cpu_to_be16(ethertype) != sdata->control_port_protocol ||
-		      !ether_addr_equal(sdata->vif.addr, skb->data + ETH_ALEN)))) {
+		      !ieee80211_is_our_addr(sdata, skb->data + ETH_ALEN, NULL)))) {
 #ifdef CONFIG_MAC80211_VERBOSE_DEBUG
 		net_info_ratelimited("%s: dropped frame to %pM (unauthorized port)\n",
 				    sdata->name, hdr.addr1);
-- 
2.36.1

