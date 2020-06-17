Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D0F1FC88F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgFQI1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 04:27:06 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49905 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFQI1F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 04:27:05 -0400
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 257AF580073;
        Wed, 17 Jun 2020 10:27:03 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v3 1/2] mac80211: skip mpath lookup also for control port tx
Date:   Wed, 17 Jun 2020 10:26:36 +0200
Message-Id: <20200617082637.22670-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617082637.22670-1-markus.theil@tu-ilmenau.de>
References: <20200617082637.22670-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When using 802.1X over mesh networks, at first an ordinary
mesh peering is established, then the 802.1X EAPOL dialog
happens, afterwards an authenticated mesh peering exchange
(AMPE) happens, finally the peering is complete and we can
set the STA authorized flag.

As 802.1X is an intermediate step here and key material is
not yet exchanged for stations we have to skip mesh path lookup
for these EAPOL frames. Otherwise the already configure mesh
group encryption key would be used to send a mesh path request
which no one can decipher, because we didn't already establish
key material on both peers, like with SAE and directly using AMPE.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/mac80211/tx.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e9ce658141f5..bd86f85a5b73 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3933,6 +3933,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 	struct sk_buff *next;
+	u32 ctrl_flags_adapted;
 
 	if (unlikely(skb->len < ETH_HLEN)) {
 		kfree_skb(skb);
@@ -3996,8 +3997,12 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	skb_list_walk_safe(skb, skb, next) {
 		skb_mark_not_on_list(skb);
 
+		ctrl_flags_adapted = ctrl_flags;
+		if (sdata->control_port_protocol == skb->protocol)
+			ctrl_flags_adapted |= IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP;
+
 		skb = ieee80211_build_hdr(sdata, skb, info_flags,
-					  sta, ctrl_flags, cookie);
+					  sta, ctrl_flags_adapted, cookie);
 		if (IS_ERR(skb)) {
 			kfree_skb_list(next);
 			goto out;
@@ -5370,8 +5375,10 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	    proto != cpu_to_be16(ETH_P_PREAUTH))
 		return -EINVAL;
 
-	if (proto == sdata->control_port_protocol)
-		ctrl_flags |= IEEE80211_TX_CTRL_PORT_CTRL_PROTO;
+	if (proto == sdata->control_port_protocol) {
+		ctrl_flags |= IEEE80211_TX_CTRL_PORT_CTRL_PROTO |
+			      IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP;
+	}
 
 	if (unencrypted)
 		flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
-- 
2.27.0

