Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD024CC92
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 06:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgHUEUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 00:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgHUEUH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 00:20:07 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322AC061385
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 21:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OfH6NMfLVLcdKdvTqmI1pBUX/QDrSXkQLZz48xXmMSA=; b=iAFpKzlVZMfYQL75d93X7Ah0+I
        22wAUrxKEK1xUMSdThDc8l7GiwAn8OFZZHdVi2Jm/qZjXbibcx1AB8Liz7vausFdNzLq58kQhXkTE
        3QAS0TJlsk9W2JTTnS+KWvbvkBe+5pxuz9OpImIcS7ND2ZBo7jC4Yi5DSFKrA9Z3Pe90=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k8yX7-0005s7-9k; Fri, 21 Aug 2020 06:20:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 08/13] mac80211: check and refresh aggregation session in encap offload tx
Date:   Fri, 21 Aug 2020 06:19:56 +0200
Message-Id: <20200821042001.23388-9-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821042001.23388-1-nbd@nbd.name>
References: <20200821042001.23388-1-nbd@nbd.name>
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
index 04d8e528357b..64590ad930fe 100644
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

