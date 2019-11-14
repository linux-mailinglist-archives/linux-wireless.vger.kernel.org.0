Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D4DFBCE5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 01:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfKNAMg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 19:12:36 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43340 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfKNAMg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 19:12:36 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so3320546qtn.10
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 16:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JB/xftZHmG+eByqeZoQConbCpTOrGr5ABu1yhgA+4gI=;
        b=efe4Y4R+QgfzYoq6fg0c+elj9KyL672xysYluQSvja+cbS6Su1+tGxNi8tAx8e9mcz
         TfGln6hyu74YyfdL8//Y8Q4RFSHpEzq7d4ZYj9R0/WwGrwAq9dpD+3f+5qu/jR8Ynl36
         nNhWcoqqQCJUj6FunqKekKMFRna8AcBF573APoAlXcNMqYNyhaMwa21/kc5jO/t6XVd+
         JSL2TZRtL5mrAducAjVEt+6mJGX4l1utRpmXS339XAoa3u9OvywaIGeyenBM3udtqE8h
         GUasVPXnMgVEfpKeOh/SC+H2VH30fRWakNNPQbWJgM1q3WZZqVWSIVv79+z0D/xqkB8d
         X35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JB/xftZHmG+eByqeZoQConbCpTOrGr5ABu1yhgA+4gI=;
        b=LJr8KFzuglTUxXIfoSuB/JZn00DhenuXRCa9h8nTbAKVN2PmUiC0Y19GYLfodFiV19
         44WHvmgnzsfht8rfve1At6O9wI/UzHRgfED3bHozfgI9hHmFWlUmEP7aFdi5SMCbvaAG
         9vZz5AfSp0a8hS7qB2NMgQfxrvUJqw62hoFK8mM8bgqb0Bs68/HgmUFk7TVbdWPjyis+
         uKZ4mgaeA2GZ7/o8N4UPsFKLOSeSHXiUC6BDOKy68d7XCqP7tbkyXtqXRN9MRolT+aSL
         93Ad4oofIkmv4yEr0frDhUUgmhaJK8vaBUUwMZ40C/LrBKw1m0nd4870HzKTGQn7hXqr
         kleQ==
X-Gm-Message-State: APjAAAVMNNGroYjsKhOOq686zXLUSUDJxguwqe+qt6RQtkyVNJfaEuhQ
        +v/6MYfwC4CcaeYlh50J8rY=
X-Google-Smtp-Source: APXvYqxOcOVd12GAy0RsPy5v0BTtb/X/Ki1gvWkAhTxTnSUuTHy5tQOqYd25WotTTpcW9rfaVgNr+g==
X-Received: by 2002:ac8:4a0d:: with SMTP id x13mr5699364qtq.164.1573690355545;
        Wed, 13 Nov 2019 16:12:35 -0800 (PST)
Received: from ubuntu.wgti.net ([64.94.121.131])
        by smtp.gmail.com with ESMTPSA id i10sm1856574qtj.19.2019.11.13.16.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 16:12:34 -0800 (PST)
From:   Ming Chen <ming032217@gmail.com>
X-Google-Original-From: Ming Chen <ming.chen@watchguard.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Ming Chen <ming.chen@watchguard.com>
Subject: [PATCH] mac80211: Drop the packets whose source or destination mac address is empty
Date:   Wed, 13 Nov 2019 16:12:30 -0800
Message-Id: <20191114001230.71469-1-ming.chen@watchguard.com>
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

