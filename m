Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1AD2886B0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 12:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbgJIKPe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 06:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbgJIKPd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 06:15:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDFCC0613D4
        for <linux-wireless@vger.kernel.org>; Fri,  9 Oct 2020 03:15:33 -0700 (PDT)
Received: from [134.101.218.207] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kQpQw-0004jy-Vo; Fri, 09 Oct 2020 12:15:31 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V4 4/4] mac80211: don't allow CSA on non-transmitting interfaces
Date:   Fri,  9 Oct 2020 12:15:28 +0200
Message-Id: <20201009101528.4780-5-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009101528.4780-1-john@phrozen.org>
References: <20201009101528.4780-1-john@phrozen.org>
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
index 11cecb2ed640..7693894c4f84 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3504,6 +3504,9 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
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

