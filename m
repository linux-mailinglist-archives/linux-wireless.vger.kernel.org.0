Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3017A573136
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiGMIez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiGMIet (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 04:34:49 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E56CA58DF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U5nOCw1FF1E1jHoqtqtfndc6T1DM0LVamn49kxUCuAI=; b=lOWmebSTvrZmWCQoWVew7j7uJg
        0r++lTPdp1W3yfp7TyThRh82jP6tlGkQiKCjAj1+VB6p9sxsEvoxus/J3yDCGw/+sIIAeVOBguS7G
        LmIQR2fZnCpxrbX0PWwVjKzGUTQbrPBqMVV7Gou3kl4NwNW7bIH9MgIm/yClQttZ92A4=;
Received: from p200300daa70a0200316cabb8b2c8ca0c.dip0.t-ipconnect.de ([2003:da:a70a:200:316c:abb8:b2c8:ca0c] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1oBXpV-000205-UF; Wed, 13 Jul 2022 10:34:46 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: exclude multicast packets from AQL pending airtime
Date:   Wed, 13 Jul 2022 10:34:44 +0200
Message-Id: <20220713083444.86129-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In AP mode, multicast traffic is handled very differently from normal traffic,
especially if at least one client is in powersave mode.
This means that multicast packets can be buffered a lot longer than normal
unicast packets, and can eat up the AQL budget very quickly because of the low
data rate.
Along with the recent change to maintain a global PHY AQL limit, this can lead
to significant latency spikes for unicast traffic.

Since queueing multicast to hardware is currently not constrained by AQL limits
anyway, let's just exclude it from the AQL pending airtime calculation entirely.

Fixes: 8e4bac067105 ("wifi: mac80211: add a per-PHY AQL limit to improve fairness")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8e7340b5fd8b..cc187bc898aa 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3775,7 +3775,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 encap_out:
 	IEEE80211_SKB_CB(skb)->control.vif = vif;
 
-	if (vif &&
+	if (tx.sta &&
 	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
 		bool ampdu = txq->ac != IEEE80211_AC_VO;
 		u32 airtime;
-- 
2.36.1

