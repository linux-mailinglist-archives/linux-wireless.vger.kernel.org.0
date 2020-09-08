Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4202F261F64
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 22:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbgIHUC0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgIHPek (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 11:34:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CB9C061364
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=s8LSK010ZEQutKKKguvk0l3oIK2Y3Zs3fmojxp/ExwI=; b=Y+y4JmY8PlXYel6C+sezgsqFYf
        N/rxXTlKig1KnyS4SnM6wHdhflQhl00TInbCXURYt0OlHFbc2W++ceWEdhSMcLs5W4JviKlkTrAVs
        g5nf5/VAMm9RThlH6IZqy+MrbTKRf3xfVqFyy5GPxYaKHrBR6jIDG4faJYNgON2eqY+g=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFcrw-00050i-QW; Tue, 08 Sep 2020 14:37:04 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v4 02/14] mac80211: check and refresh aggregation session in encap offload tx
Date:   Tue,  8 Sep 2020 14:36:50 +0200
Message-Id: <20200908123702.88454-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908123702.88454-1-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update the last_tx timestamp to avoid tearing down the aggregation session
early. Fall back to the slow path if the session setup is still running

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bee9b01c5a6b..cd54d197caab 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4198,6 +4198,8 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	bool authorized = false;
 	bool multicast;
 	unsigned char *ra = ehdr->h_dest;
+	struct tid_ampdu_tx *tid_tx;
+	u8 tid;
 
 	if (IS_ERR(sta) || (sta && !sta->uploaded))
 		sta = NULL;
@@ -4235,6 +4237,22 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	memset(info, 0, sizeof(*info));
 
+	if (sta) {
+		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
+		if (tid_tx) {
+			if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
+				/* fall back to non-offload slow path */
+				__ieee80211_subif_start_xmit(skb, dev, 0, 0, NULL);
+				return;
+			}
+
+			info->flags |= IEEE80211_TX_CTL_AMPDU;
+			if (tid_tx->timeout)
+				tid_tx->last_tx = jiffies;
+		}
+	}
+
 	if (unlikely(!multicast && skb->sk &&
 		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
 		info->ack_frame_id = ieee80211_store_ack_skb(local, skb,
-- 
2.28.0

