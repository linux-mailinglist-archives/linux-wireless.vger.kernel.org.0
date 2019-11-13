Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA63FBCB7
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 00:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfKMXzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 18:55:13 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44196 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMXzM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 18:55:12 -0500
Received: by mail-qk1-f194.google.com with SMTP id m16so3434640qki.11
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 15:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JB/xftZHmG+eByqeZoQConbCpTOrGr5ABu1yhgA+4gI=;
        b=YkvuAb7lWDVGDaH1ajYJMNluNqkGsKexHsApLF+Asddi/Xe7cOF3bMMnURTjcynCrI
         /ba6HcY63Be50/SUhc/Y/O8xm+0jD98TQdT0o+4xMVHBRFBSlbAvBBv2aMda9h2dq5mH
         I1yplAeN/Gd1s5CunGoxpdZG2mTwHPS6JpdEnFCvNmjH+3HG7iuwy7yN3gmBaKlQQajT
         BSKM44M696pFXTykJJrCaRB+xQs9DOsEOuy2gBTcht532FhWFZS25Dbv7Ew6fzpFtToJ
         gukIr4yGGS8ZTllgWhU83Wx5mFcjOG7ks+eaUFDEovkf+tvenecDSSNnqECFWYNkgxSy
         W90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JB/xftZHmG+eByqeZoQConbCpTOrGr5ABu1yhgA+4gI=;
        b=baYEsJTdHwCeGcdyevwgCmo/RZWwyYls/6L4DFu/QVKauRtZQVHe9stEqiYqXjXWt1
         UZqzbjL0fzEzwNMswLyULAfUvV4E3fH97WWg4lr/HJXZoEz70wYQf3zK1t0SAhl4Hr+Q
         pBYUvuzzMMxvBaF8W0KpGUmXJn3K6grYNjgEJ2EVUb0WnMLKFJt6oiddBvQLr/16De/j
         6TdBjdhC1AECfwvwU+c5exDVTzodsSOsrhLR2r69HZ+kwy6/+7sfyawBWnzd4utJetAZ
         j1QX/F7e/unD36ic0znJkkD6BVFgb/JHXhbWwCfMNowNHY4g2ZQONT4GLNhmC/jZeVKX
         oBjw==
X-Gm-Message-State: APjAAAXcRY/tOMe9SpK1IPw8XyP5bZUB6euTeC7mnyIX1okPmwkVYRW5
        FSZuz1FE0OOxxSnfs6bxZLmh29iqrik=
X-Google-Smtp-Source: APXvYqxHgqCyDpJ7KK/ZlAcUaj3YaEzeiKB6rzruveXQaHkdMu2ivrNtoy3B8IkghZezo2Y1gnL2Pg==
X-Received: by 2002:a05:620a:3dd:: with SMTP id r29mr5198065qkm.370.1573689311704;
        Wed, 13 Nov 2019 15:55:11 -0800 (PST)
Received: from ubuntu.wgti.net ([64.94.121.131])
        by smtp.gmail.com with ESMTPSA id 134sm1335501qkn.24.2019.11.13.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 15:55:10 -0800 (PST)
From:   Ming Chen <ming032217@gmail.com>
X-Google-Original-From: Ming Chen <ming.chen@watchguard.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Ming Chen <ming.chen@watchguard.com>
Subject: [PATCH] mac80211: Drop the packets whose source or destination mac address is empty
Date:   Wed, 13 Nov 2019 15:55:05 -0800
Message-Id: <20191113235505.70905-1-ming.chen@watchguard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We occasionally found ath9k could receive some packets from Linux IP stack
with empty source and destination mac address,which will result in the
driver cannot find the station node in TX complete. And thus, the driver
will complete this buffer but without updating the block ack window.

To fix this issue, we should drop this kind of error packet before it
goes into the driver.
---
 net/mac80211/tx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index db38be1b75fa..0668123e8e85 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2481,6 +2481,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	bool tdls_peer;
 	bool multicast;
 	u16 info_id = 0;
+	const int empty_mac[ETH_ALEN] = {0};
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_sub_if_data *ap_sdata;
 	enum nl80211_band band;
@@ -2489,6 +2490,13 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	if (IS_ERR(sta))
 		sta = NULL;
 
+	/* drop this skb when source mac or destination mac is empty */
+	if (!memcmp(skb->data, empty_mac, ETH_ALEN) ||
+	    !memcmp(skb->data + ETH_ALEN, empty_mac, ETH_ALEN)) {
+		ret = -ENOTCONN;
+		goto free;
+	}
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 	if (local->force_tx_status)
 		info_flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
@@ -3414,6 +3422,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	u16 ethertype = (skb->data[12] << 8) | skb->data[13];
 	int extra_head = fast_tx->hdr_len - (ETH_HLEN - 2);
+	const int empty_mac[ETH_ALEN] = {0};
 	int hw_headroom = sdata->local->hw.extra_tx_headroom;
 	struct ethhdr eth;
 	struct ieee80211_tx_info *info;
@@ -3435,6 +3444,12 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
 		return false;
 
+	/* drop this skb when source mac or destination mac is empty */
+	if (!memcmp(skb->data, empty_mac, ETH_ALEN) ||
+	    !memcmp(skb->data + ETH_ALEN, empty_mac, ETH_ALEN)) {
+		return false;
+        }
+
 	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
 		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
 		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
-- 
2.17.1

