Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0705BBA58
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 22:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIQU2i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 16:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIQU2h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 16:28:37 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6152ED74
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 13:28:36 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZeQU-0003pN-3C;
        Sat, 17 Sep 2022 22:28:35 +0200
Date:   Sat, 17 Sep 2022 21:28:29 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 09/16] rt2x00: don't run Rt5592 IQ calibration on MT7620
Message-ID: <31a1c34ddbd296b82f38c18c9ae7339059215fdc.1663445157.git.daniel@makrotopia.org>
References: <cover.1663445157.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663445157.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function rt2800_iq_calibrate is intended for Rt5592 only.
Don't call it for MT7620 which has it's own calibration functions.

Reported-by: Serge Vasilugin <vasilugin@yandex.ru>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: test for RT5592 instead of !RT6352

 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 2dc197b508ad32..4b912b362562c9 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -4398,7 +4398,8 @@ static void rt2800_config_channel(struct rt2x00_dev *rt2x00dev,
 		reg = (rf->channel <= 14 ? 0x1c : 0x24) + 2*rt2x00dev->lna_gain;
 		rt2800_bbp_write_with_rx_chain(rt2x00dev, 66, reg);
 
-		rt2800_iq_calibrate(rt2x00dev, rf->channel);
+		if (rt2x00_rt(rt2x00dev, RT5592))
+			rt2800_iq_calibrate(rt2x00dev, rf->channel);
 	}
 
 	if (rt2x00_rt(rt2x00dev, RT6352)) {
-- 
2.37.3

