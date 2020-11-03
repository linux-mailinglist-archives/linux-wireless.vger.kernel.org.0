Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0292A2A3FCA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 10:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgKCJRx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 04:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKCJRw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 04:17:52 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11DC061A47
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 01:17:52 -0800 (PST)
Received: from [149.224.151.57] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kZsRp-0006BN-CH; Tue, 03 Nov 2020 10:17:49 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V5 4/4] mac80211: don't allow CSA on non-transmitting interfaces
Date:   Tue,  3 Nov 2020 10:17:43 +0100
Message-Id: <20201103091743.1924854-5-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103091743.1924854-1-john@phrozen.org>
References: <20201103091743.1924854-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As a non-transmitting interface does not broadcast a beacon, we do not want
to allow channel switch announcements. They need to be triggered on the
transmitting interface.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 net/mac80211/cfg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index cfe38480a3fc..457a956bb637 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3508,6 +3508,9 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->vif.csa_active)
 		return -EBUSY;
 
+	if (sdata->vif.multiple_bssid.flags & IEEE80211_VIF_MBSS_NON_TRANSMITTING)
+		return -EINVAL;
+
 	mutex_lock(&local->chanctx_mtx);
 	conf = rcu_dereference_protected(sdata->vif.chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
-- 
2.25.1

