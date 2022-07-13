Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C51573328
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiGMJpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiGMJpK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A3AC04F4
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZRKPXVbu75DosdF67c6fgpxhMdiabqN4YKqhyJejv+Y=;
        t=1657705508; x=1658915108; b=ZHtIrU3yMxHPSWkj8uAiwEXsdRAxdFodSgDqu2OHzzATWWp
        VM06dN8t7jZtpTZz/JML3S8eus2KmKxn+uz5iaWCuKf/KdhYIVHoKOaO5bJQujoE1++m+pW3e2Gc1
        7wZ3xm3iShw7nUARnL7PZKfTaG3hDenaGOw9bVJyzVB5MlvC9Cag9YfIHxX4sG9m110jLu8s9SseK
        BGhTjnhGvK8pbWuCqz1VNn5ti6x0lRq7I7iyxImT++0w96F30NuRNEDF70GsJvVI9VsW35oM4oj8N
        reKadUlR2EtwnWRthQO4/2Oa8TMFfwZJBsJzXqb21ST+NN6xI03+xgpBnhNqgBhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvZ-00EgvB-3J;
        Wed, 13 Jul 2022 11:45:05 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 01/76] wifi: mac80211_hwsim: Support link channel matching on rx
Date:   Wed, 13 Jul 2022 11:43:47 +0200
Message-Id: <20220713114425.6c3f78efc6fe.I60f9df15439ef2374761bd5ae042c102a7d85178@changeid>
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

Accept frames from all the links' channels.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 91440b0dc0cc..7be846d4d63e 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1474,15 +1474,25 @@ static void mac80211_hwsim_tx_iter(void *_data, u8 *addr,
 				   struct ieee80211_vif *vif)
 {
 	struct tx_iter_data *data = _data;
+	int i;
 
-	if (!vif->bss_conf.chanctx_conf)
-		return;
+	for (i = 0; i < ARRAY_SIZE(vif->link_conf); i++) {
+		struct ieee80211_bss_conf *conf = vif->link_conf[i];
+		struct ieee80211_chanctx_conf *chanctx;
 
-	if (!hwsim_chans_compat(data->channel,
-				rcu_dereference(vif->bss_conf.chanctx_conf)->def.chan))
-		return;
+		if (!conf)
+			continue;
+
+		chanctx = rcu_dereference(conf->chanctx_conf);
+		if (!chanctx)
+			continue;
+
+		if (!hwsim_chans_compat(data->channel, chanctx->def.chan))
+			continue;
 
-	data->receive = true;
+		data->receive = true;
+		return;
+	}
 }
 
 static void mac80211_hwsim_add_vendor_rtap(struct sk_buff *skb)
-- 
2.36.1

