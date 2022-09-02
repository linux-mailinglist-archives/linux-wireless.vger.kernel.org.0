Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD355AB525
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 17:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiIBP2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiIBP2S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 11:28:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA5E56
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=6GdBPBQPLZLxaTkJbQDRP5LffYvQ4j5sgQcRyZQ/23s=; t=1662130929; x=1663340529; 
        b=sVZU5HqPX+CL7uf/Udg/ChRbaV4N0jELxF91zrTBa9zPtJLbmCScuOYcmuxYr7HafBf7f6qjcAs
        Av7eGDKnYuBl7n1YKtK+dledSmaozrrat00Vsti1F4ZBkfuecIY6u+2Hus5TdlmXHREHWX8LL2Xzo
        sU9ok6z9lE2lEkhYQiocN/rTbzzWMtDgO5fskmvfICu2wjWQxhLFN/uCCKF+IHyt6vo1s0FOEFj8B
        nLKy/vxCWmcSozINQrdY1isa6+Hipfh9lPoGXkRkFfbTm2SzsyDf4p6wnBz2AWIXXC27HgZkkfAvz
        4yheCaaMZLfbgk59NQI3GWxXTspjbuIC52EA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU8BK-006DgI-1l;
        Fri, 02 Sep 2022 17:02:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4] wifi: mac80211: fix link warning in RX agg timer expiry
Date:   Fri,  2 Sep 2022 17:02:02 +0200
Message-Id: <20220902170201.9fa6c20e2c64.I3d9a23c49e1df3bd0c91ef0e1c1805dd09937db8@changeid>
X-Mailer: git-send-email 2.37.2
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

The rx data link pointer isn't set from the RX aggregation timer,
resulting in a later warning. Fix that by setting it to the first
valid link for now, with a FIXME to worry about statistics later,
it's not very important since it's just the timeout case.

While at it, also assign the link_sta since we might assume that
exists if the sta exists (as it should.)

Reported-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/498d714c-76be-9d04-26db-a1206878de5e@redhat.com
Fixes: 56057da4569b ("wifi: mac80211: rx: track link in RX data")
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
[add link_sta assignment]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index cc139fe5fb78..04f16eabb78f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4084,6 +4084,7 @@ void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid)
 		.link_id = -1,
 	};
 	struct tid_ampdu_rx *tid_agg_rx;
+	u8 link_id;
 
 	tid_agg_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[tid]);
 	if (!tid_agg_rx)
@@ -4103,6 +4104,10 @@ void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid)
 		};
 		drv_event_callback(rx.local, rx.sdata, &event);
 	}
+	/* FIXME: statistics won't be right with this */
+	link_id = sta->sta.valid_links ? ffs(sta->sta.valid_links) - 1 : 0;
+	rx.link = rcu_dereference(sta->sdata->link[link_id]);
+	rx.link_sta = rcu_dereference(sta->link[link_id]);
 
 	ieee80211_rx_handlers(&rx, &frames);
 }
-- 
2.37.2

