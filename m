Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824E65AC622
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiIDT3g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiIDT32 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BF7DCC
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=EJmCzvimHGVmyoK2N+rHdXGNgYNdH1jC2BojVX04m4U=;
        t=1662319762; x=1663529362; b=HQ3ipsduqQ+IJmQK3doDUnWe/OEOIMePgLUUU/CvUv6cJ85
        jylsvhlj9qVIW66CPk4mlK70kiorqCdSBjIgLxYdn74EW0bDzssOixSZnmaGaO+ETBeYIItuIK/BA
        cg4FrDZJxiNkdkmR+h24Ggx7pd04ZXvc62uXO61n1gX+LQl822A7Xyt5Ln4HpvE4UTPbEKyNJEyHM
        c09hXo4lOM2sNXbe7T+34e26ro0P9rRMa5Je7uHHvjN3OaFBIRaZr1kU1Dqhkrpk63F0ndsnK/c87
        fkSLgbBQAMf1cQ4tW2aQ6FXJdioCc7TPRJKeR1EdsAASWYwOKWWOWH87tvUyoHtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvJ1-007pTZ-2b;
        Sun, 04 Sep 2022 21:29:19 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH 10/12] wifi: cw1200: remove RCU STA pointer handling in TX
Date:   Sun,  4 Sep 2022 21:29:10 +0200
Message-Id: <20220904212910.e5bc20dd17bf.Ib570ff7fde33c2b6eddef493a3541fa04eb47181@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

We can call this in one of two ways: through mac80211, where
we're already in an RCU read-side critical section, or from
some other code in the driver where this pointer can only be
NULL. In any case, we get a 'free' already protected pointer
to the sta through info->control.sta, so we can use it on
the stack without any further protection.

Remove the rcu_dereference() and critical section.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Cc: Solomon Peachy <pizza@shaftnet.org>
---
 drivers/net/wireless/st/cw1200/txrx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index fde21fca6c5e..ab19e0403dc2 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -762,8 +762,7 @@ void cw1200_tx(struct ieee80211_hw *dev,
 	if (ret)
 		goto drop;
 
-	rcu_read_lock();
-	sta = rcu_dereference(t.sta);
+	sta = t.sta;
 
 	spin_lock_bh(&priv->ps_state_lock);
 	{
@@ -776,8 +775,6 @@ void cw1200_tx(struct ieee80211_hw *dev,
 	if (tid_update && sta)
 		ieee80211_sta_set_buffered(sta, t.txpriv.tid, true);
 
-	rcu_read_unlock();
-
 	cw1200_bh_wakeup(priv);
 
 	return;
-- 
2.37.2

