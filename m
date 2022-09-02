Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A425AB425
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiIBOv2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiIBOvF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E84397D55
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=095hDYsDlcTV8evU1aEFxpjTrvn2h/uZJCNm8+1IhlU=;
        t=1662127990; x=1663337590; b=fxbzBWk1TYYX8IpZnXB/4sFblBLtE7TxcWl+UagvePqXjfa
        4Hn8MWoXPcbTWXNMnkUkswYX7N/B8u0WiPKDlcBpRNvC6yRYLQzdjvephwFKeKCuJY0qDpHUDZ1EN
        v4O0G6B3mv08v4/ps03TmXyNi1ott1rSMNO3xVVbFSzKOxTUXajebBrtB7owpFW/MAIgAmKPtUFX5
        ZhZrcDUxZVeH4HwgzPwT9tmygwMA66y3c4Vv5tDLact/YdnW26H8D0dKn3OiczOoMPrm3G1JIUZCm
        bBuMUcV9LXaZq9dixgnO4wdkgN2SHM32PDx99T5aBKFokyuYdFlhZIIO+5voSx/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pw-006Ch3-1Y;
        Fri, 02 Sep 2022 16:13:08 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/27] wifi: mac80211_hwsim: skip inactive links on TX
Date:   Fri,  2 Sep 2022 16:12:44 +0200
Message-Id: <20220902161143.3489c3850898.I8f77618ccb1a9eaedf3495464a6f8594ccf5112c@changeid>
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

With the link activation handling in mac80211, skip
any inactive links on TX.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index a75420d92816..f17de806a35d 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1735,6 +1735,9 @@ mac80211_hwsim_select_tx_link(struct mac80211_hwsim_data *data,
 		/* round-robin the available link IDs */
 		link_id = (sp->last_link + i + 1) % ARRAY_SIZE(vif->link_conf);
 
+		if (!(vif->active_links & BIT(link_id)))
+			continue;
+
 		*link_sta = rcu_dereference(sta->link[link_id]);
 		if (!*link_sta)
 			continue;
@@ -1743,6 +1746,10 @@ mac80211_hwsim_select_tx_link(struct mac80211_hwsim_data *data,
 		if (WARN_ON_ONCE(!bss_conf))
 			continue;
 
+		/* can happen while switching links */
+		if (!rcu_access_pointer(bss_conf->chanctx_conf))
+			continue;
+
 		sp->last_link = link_id;
 		return bss_conf;
 	}
-- 
2.37.2

