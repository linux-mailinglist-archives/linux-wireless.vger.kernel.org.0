Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9D5BBF7D
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Sep 2022 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIRTVK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIRTVI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 15:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDED15FE4
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663528866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uOzXnE7V620ExmXecsTAdqAqQObBZ3En/vJphIYBVeQ=;
        b=Y0INYyd2fSVNFknwqP/2ZGIsVJ9YwpLDT/2BeM+uxpEsftNBU+Mf1sHzysXpbgtNEiStv6
        0KNYTGQplcSkUSCHvL2yoPo0ZgIDxBgGXUKWvbHDnlD0er71ke/r+3wRicKdTkeRlLHKou
        YeHv7w2A8wl3YMPERQ2f5FFE8TN9vGM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-mdfkfUN1Mp-oEybs1U6OlQ-1; Sun, 18 Sep 2022 15:21:03 -0400
X-MC-Unique: mdfkfUN1Mp-oEybs1U6OlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD4A738041C6;
        Sun, 18 Sep 2022 19:21:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2C7B2166B26;
        Sun, 18 Sep 2022 19:21:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH] mac80211: Fix regression caused by 'enable QoS support for nl80211 ctrl port'
Date:   Sun, 18 Sep 2022 21:20:52 +0200
Message-Id: <20220918192052.443529-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 10cb8e617560 ("mac80211: enable QoS support for nl80211 ctrl port")
changed ieee80211_tx_control_port() to aways call
__ieee80211_select_queue() without checking local->hw.queues.

__ieee80211_select_queue() returns a queue-id between 0 and 3, which means
that now ieee80211_tx_control_port() may end up setting the queue-mapping
for a skb to a value higher then local->hw.queues if local->hw.queues
is less then 4.

Specifically this is a problem for ralink rt2500-pci cards where
local->hw.queues is 2. There this causes rt2x00queue_get_tx_queue() to
return NULL and the following error to be logged: "ieee80211 phy0:
rt2x00mac_tx: Error - Attempt to send packet over invalid queue 2",
after which association with the AP fails.

Other callers of __ieee80211_select_queue() skip calling it when
local->hw.queues < IEEE80211_NUM_ACS, add the same check to
ieee80211_tx_control_port(). This fixes ralink rt2500-pci and
similar cards when less then 4 tx-queues no longer working.

Fixes: 10cb8e617560 ("mac80211: enable QoS support for nl80211 ctrl port")
Cc: Markus Theil <markus.theil@tu-ilmenau.de>
Suggested-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 net/mac80211/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bf7fe6cd9dfc..13249e97a069 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5878,6 +5878,9 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	skb_reset_network_header(skb);
 	skb_reset_mac_header(skb);
 
+	if (local->hw.queues < IEEE80211_NUM_ACS)
+		goto start_xmit;
+
 	/* update QoS header to prioritize control port frames if possible,
 	 * priorization also happens for control port frames send over
 	 * AF_PACKET
@@ -5905,6 +5908,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	}
 	rcu_read_unlock();
 
+start_xmit:
 	/* mutex lock is only needed for incrementing the cookie counter */
 	mutex_lock(&local->mtx);
 
-- 
2.37.3

