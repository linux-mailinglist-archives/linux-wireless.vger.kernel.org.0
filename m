Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11185BBA50
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Sep 2022 22:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIQU0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Sep 2022 16:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQU0e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Sep 2022 16:26:34 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033A92EF04
        for <linux-wireless@vger.kernel.org>; Sat, 17 Sep 2022 13:26:33 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1oZeOW-0003mg-1E;
        Sat, 17 Sep 2022 22:26:32 +0200
Date:   Sat, 17 Sep 2022 21:26:27 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 01/16] rt2x00: define RF5592 in init_eeprom routine
Message-ID: <d7eccb2c7b8ec4cd360fa2007796abffc35abb0d.1663445157.git.daniel@makrotopia.org>
References: <cover.1663445157.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1663445157.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tomislav Požega <pozega.tomislav@gmail.com>

Fix incorrect RF value encoded in EEPROM on devices with Ralink Rt5592
PCIe radio (a single chip 2T2R 802.11abgn solution).

Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 18102fbe36d6cc..cc9c5554fdc9ca 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -9435,6 +9435,8 @@ static int rt2800_init_eeprom(struct rt2x00_dev *rt2x00dev)
 		rf = RF3853;
 	else if (rt2x00_rt(rt2x00dev, RT5350))
 		rf = RF5350;
+	else if (rt2x00_rt(rt2x00dev, RT5592))
+		rf = RF5592;
 	else
 		rf = rt2x00_get_field16(eeprom, EEPROM_NIC_CONF0_RF_TYPE);
 
-- 
2.37.3

