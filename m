Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D284E5AB51D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiIBP2a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbiIBP2O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 11:28:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9D71143
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=1d0hdHYNneScrAKPpLjnN4n5PaVpRN/CxDeQ3j9FoPc=; t=1662130911; x=1663340511; 
        b=n3ovonaFEa72F17sPKJzbHCkM9NW3zyWKKSboPXkECgD5RG7jwu3mrAGhD6MMHJr3invnf+LJsP
        SRnOciGLQfCsrBm7+u/vfje0SCEGqPsVNBKQTRDRuDCKDU2NCLSnImzfrkXrZfLv/OrClxdOKOuJU
        BvnoobZgd4V/Fq7EQ+/f+1vO3Y7LpJjaNDV2OsCATphpwNBk8I9GPvutGftztwZy3S8gNQQelHzDm
        VapR0rdHyrKcC5PC96eKTjAxpgBh9h3otV+7qh9N05NpZpCKK1ws0YKhhjK/qXbBQO4k/rUEOlqpD
        I8mvKNXIRWsOBPzOAw78Pvavbf6B6jOZa4Gw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU8B2-006Dff-1l;
        Fri, 02 Sep 2022 17:01:48 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3] wifi: mac80211: fix link warning in RX agg timer expiry
Date:   Fri,  2 Sep 2022 17:01:46 +0200
Message-Id: <20220902170143.71fc830073b8.I3d9a23c49e1df3bd0c91ef0e1c1805dd09937db8@changeid>
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
 net/mac80211/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index cc139fe5fb78..511c809e2c6b 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4084,6 +4084,7 @@ void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid)
 		.link_id = -1,
 	};
 	struct tid_ampdu_rx *tid_agg_rx;
+	u8 link_id;
 
 	tid_agg_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[tid]);
 	if (!tid_agg_rx)
@@ -4103,6 +4104,9 @@ void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid)
 		};
 		drv_event_callback(rx.local, rx.sdata, &event);
 	}
+	/* FIXME: statistics won't be right with this */
+	link_id = sta->sta.valid_links ? ffs(sta->sta.valid_links) - 1 : 0;
+	rx.link = rcu_dereference(sta->sdata->link[link_id]);
 
 	ieee80211_rx_handlers(&rx, &frames);
 }
-- 
2.37.2

