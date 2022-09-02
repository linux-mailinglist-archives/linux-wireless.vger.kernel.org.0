Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82EE5AB420
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbiIBOvW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiIBOvD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CD56C766
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7zn+0WJ3FL4EeKKdRxke2/V3u6t76iZ9uzyOiiO3zTY=;
        t=1662127986; x=1663337586; b=Hx3kXjtCvWaGAgVvKCY2IgiLoKipmYgrUqhkYA1CTQNrRNl
        qrGG4k3c3887eL90YnFmO2q+ThQ/2duWrZNAOpAafgrmDugTED/YHe+7m2/49s2XEYrAG/BCCPamj
        U6PdWGNRPLFy8KJMO6oScaS2ufCsLuD92rXiGMCMeaureshYR5rRceXKKkx67phLs+2/ckJ2pXA7c
        HJLXOaoUJ/4ZOJJn5lvElzFB+v5r1Cldr4s7B4tHEY5QWTTvRxD4WujGN0V/z4TR0t0TBXtqKzQ/w
        WOjTyU6790XpfITYHQi3+zKwRDIos3ixZXBbN/tbQwhZ2bobd6cny7DQu/EKtarQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pq-006Ch3-35;
        Fri, 02 Sep 2022 16:13:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/27] wifi: mac80211_hwsim: remove multicast workaround
Date:   Fri,  2 Sep 2022 16:12:33 +0200
Message-Id: <20220902161143.acba32891806.I9169fd552ff0c7320413af5fbd42c045edfb8faa@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
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

Now that we have proper multicast TX in mac80211, there's
no longer a need to fake something here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 4fb8f68e5c3b..87176b205fc1 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1714,12 +1714,7 @@ mac80211_hwsim_select_tx_link(struct mac80211_hwsim_data *data,
 	if (!vif->valid_links)
 		return &vif->bss_conf;
 
-	/* FIXME: handle multicast TX properly */
-	if (is_multicast_ether_addr(hdr->addr1) || WARN_ON_ONCE(!sta)) {
-		unsigned int first_link = ffs(vif->valid_links) - 1;
-
-		return rcu_dereference(vif->link_conf[first_link]);
-	}
+	WARN_ON(is_multicast_ether_addr(hdr->addr1));
 
 	if (WARN_ON_ONCE(!sta->valid_links))
 		return &vif->bss_conf;
-- 
2.37.2

