Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37425BB994
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 18:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiIQQsl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 12:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIQQsg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 12:48:36 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB964D4
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 09:48:35 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZaza-0002gb-1A;
        Sat, 17 Sep 2022 18:48:34 +0200
Date:   Sat, 17 Sep 2022 17:48:28 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 12/16] rt2x00: fix HT20/HT40 bandwidth switch on MT7620
Message-ID: <c79f22377149de0c633ff832c7bb5892969d661f.1663431288.git.daniel@makrotopia.org>
References: <cover.1663431288.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663431288.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing configuration of the channel bandwidth filter to the
channel setup function for MT7620.

Reported-by: Serge Vasilugin <vasilugin@yandex.ru>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index fce63feb249449..64032d342966d3 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -3855,6 +3855,14 @@ static void rt2800_config_channel_rf7620(struct rt2x00_dev *rt2x00dev,
 		rfcsr |= tx_agc_fc;
 		rt2800_rfcsr_write_bank(rt2x00dev, 7, 59, rfcsr);
 	}
+
+	if (conf_is_ht40(conf)) {
+		rt2800_bbp_glrt_write(rt2x00dev, 141, 0x10);
+		rt2800_bbp_glrt_write(rt2x00dev, 157, 0x2f);
+	} else {
+		rt2800_bbp_glrt_write(rt2x00dev, 141, 0x1a);
+		rt2800_bbp_glrt_write(rt2x00dev, 157, 0x40);
+	}
 }
 
 static void rt2800_config_alc(struct rt2x00_dev *rt2x00dev,
-- 
2.37.3

