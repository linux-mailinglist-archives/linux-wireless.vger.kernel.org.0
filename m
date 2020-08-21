Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AEC24CCB1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 06:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgHUEZN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 00:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgHUEZL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 00:25:11 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECFC061385
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 21:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3Ph7ZH4jmXu/uxMcDwQcp83/aBFYb/qx5NJX2udfT6s=; b=DIqdEo7qUzgF+BgeW0OAe+GbCk
        Ybqu0XVyeALdWpHzjwtrtmpN8wrvVhlY+F26BAxPmLOkJ14QDqjEMS0Hmm6Jn17Cra/5eDT2nsWlW
        dxrtxGxsoQs1qlrqoMnCSYQMx4+wZc2UaiJAp9Ssq3TzUrYHZJcavBupnKxJamm01QRs=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k8yX8-0005s7-Li; Fri, 21 Aug 2020 06:20:06 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 13/13] mac80211: set info->control.hw_key for encap offload packets
Date:   Fri, 21 Aug 2020 06:20:01 +0200
Message-Id: <20200821042001.23388-14-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821042001.23388-1-nbd@nbd.name>
References: <20200821042001.23388-1-nbd@nbd.name>
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
index 4cf4840f2886..e3d061308113 100644
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
 	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
 
+	key = rcu_dereference(sta->ptk[sta->ptk_idx]);
+	if (key)
+		info->control.hw_key = &key->conf;
+
 	ieee80211_tx_8023(sdata, skb, skb->len, sta, false);
 
 	return;
-- 
2.28.0

