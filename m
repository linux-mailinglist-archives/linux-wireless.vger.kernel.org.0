Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76F82618DD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbgIHR6r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 13:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgIHQMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:46 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46E4C06136B
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=A9XAojkNO6R9JhxTA5mn7U4XymOAPDn6xmLAcEl7tqU=; b=bAiVX73C8WL+Oi2tBjhJDEfB17
        mX0E9UXswyROTqCDuPr/i4KrTnPk3Nz5ZN5uzD9epVxhtSQBMqRw95LE4OjGwr5oKKd6jkj5blnzP
        B21J/9UQmAhMDJm0uOg60vXUdCApOeUnkFKLemF3v+cb9HqXNYMPBPatRjri0/unIy0E=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFcrx-00050i-6u; Tue, 08 Sep 2020 14:37:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v4 04/14] mac80211: set info->control.hw_key for encap offload packets
Date:   Tue,  8 Sep 2020 14:36:52 +0200
Message-Id: <20200908123702.88454-5-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908123702.88454-1-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is needed for drivers that don't do the key lookup themselves

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ea750081f6c6..65dfc24916e8 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4194,6 +4194,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_key *key;
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
 
@@ -4242,6 +4243,10 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	info->control.flags |= IEEE80211_TX_CTRL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
 
+	key = rcu_dereference(sta->ptk[sta->ptk_idx]);
+	if (key)
+		info->control.hw_key = &key->conf;
+
 	ieee80211_tx_8023(sdata, skb, skb->len, sta, false);
 
 	return;
-- 
2.28.0

