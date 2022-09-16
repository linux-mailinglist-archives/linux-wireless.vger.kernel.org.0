Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB25BB4BD
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 01:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIPXQH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 19:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIPXP5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 19:15:57 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBA6B40D1
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 16:15:55 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZKO4-0006zU-1q;
        Sat, 17 Sep 2022 01:04:44 +0200
Date:   Sat, 17 Sep 2022 00:04:38 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/15] rt2x00: add throughput LED trigger
Message-ID: <YyUBBqmK0gzmM1mP@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: David Bauer <mail@david-bauer.net>

This adds a (currently missing) throughput LED trigger for the rt2x00
driver. Previously, LED triggers had to be assigned to the netdev, which
was limited to a single VAP.

Tested-by: Christoph Krapp <achterin@googlemail.com>
Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index e95c101c271113..3a035afcf7f99c 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1093,6 +1093,19 @@ static void rt2x00lib_remove_hw(struct rt2x00_dev *rt2x00dev)
 	kfree(rt2x00dev->spec.channels_info);
 }
 
+static const struct ieee80211_tpt_blink rt2x00_tpt_blink[] = {
+	{ .throughput = 0 * 1024, .blink_time = 334 },
+	{ .throughput = 1 * 1024, .blink_time = 260 },
+	{ .throughput = 2 * 1024, .blink_time = 220 },
+	{ .throughput = 5 * 1024, .blink_time = 190 },
+	{ .throughput = 10 * 1024, .blink_time = 170 },
+	{ .throughput = 25 * 1024, .blink_time = 150 },
+	{ .throughput = 54 * 1024, .blink_time = 130 },
+	{ .throughput = 120 * 1024, .blink_time = 110 },
+	{ .throughput = 265 * 1024, .blink_time = 80 },
+	{ .throughput = 586 * 1024, .blink_time = 50 },
+};
+
 static int rt2x00lib_probe_hw(struct rt2x00_dev *rt2x00dev)
 {
 	struct hw_mode_spec *spec = &rt2x00dev->spec;
@@ -1174,6 +1187,11 @@ static int rt2x00lib_probe_hw(struct rt2x00_dev *rt2x00dev)
 
 #undef RT2X00_TASKLET_INIT
 
+	ieee80211_create_tpt_led_trigger(rt2x00dev->hw,
+					 IEEE80211_TPT_LEDTRIG_FL_RADIO,
+					 rt2x00_tpt_blink,
+					 ARRAY_SIZE(rt2x00_tpt_blink));
+
 	/*
 	 * Register HW.
 	 */
-- 
2.37.3

