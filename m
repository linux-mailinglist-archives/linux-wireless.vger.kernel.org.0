Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A402573330
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiGMJp3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiGMJpM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B79BFAEB
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wzNscMqAxoelS5nwrxvoB4bZtZlu79LtgrYZfO300KQ=;
        t=1657705511; x=1658915111; b=ngpBVXtel7xwfd/hNeh5l2fW1D29MI2SAC65WUKmrB94V/w
        lfxKvMtnxgGk4VQOmKWWDu7wTGKTUOFwUg3hrqbBaZucmviETfyQc4srqj+WDhCfcBZoK5Oy6Tye7
        uT7FHDeWMUF2KRkn3tuEL21/GkHZUPbuAYWVqvQxtHure1bptMziUuoU25TAk6izPftUQhMxSMVIo
        UsO6ZFr1OI2e3CZiro3j9Ew0JBzlb+6riBaks2DN3R97c2FgPLwE25pa1MjeF8OeySM5F3ktf+x7G
        fkRC4CaB137miRW4+9hg02nQIwEYM0321rgxBbHFkQ4Gt0EuwY40SXYBIws9q5EQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvd-00EgvB-W6;
        Wed, 13 Jul 2022 11:45:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 18/76] wifi: mac80211_hwsim: Ack link addressed frames
Date:   Wed, 13 Jul 2022 11:44:04 +0200
Message-Id: <20220713114425.609fda332c9e.Icaf0d6c62f89a131c4f0482d6a6d3b296d0cf1aa@changeid>
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

Do address matching with link addresses as well.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 8cc813f66010..835422c3a1b2 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1198,10 +1198,27 @@ struct mac80211_hwsim_addr_match_data {
 static void mac80211_hwsim_addr_iter(void *data, u8 *mac,
 				     struct ieee80211_vif *vif)
 {
+	int i;
 	struct mac80211_hwsim_addr_match_data *md = data;
 
-	if (memcmp(mac, md->addr, ETH_ALEN) == 0)
+	if (memcmp(mac, md->addr, ETH_ALEN) == 0) {
 		md->ret = true;
+		return;
+	}
+
+	/* Match the link address */
+	for (i = 0; i < ARRAY_SIZE(vif->link_conf); i++) {
+		struct ieee80211_bss_conf *conf;
+
+		conf = rcu_dereference(vif->link_conf[i]);
+		if (!conf)
+			continue;
+
+		if (memcmp(conf->addr, md->addr, ETH_ALEN) == 0) {
+			md->ret = true;
+			return;
+		}
+	}
 }
 
 static bool mac80211_hwsim_addr_match(struct mac80211_hwsim_data *data,
-- 
2.36.1

