Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EFC564FCF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 10:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiGDIfh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 04:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiGDIfg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 04:35:36 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA8D3B493
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FJG6V
        4jph5sUNRiak7lEZgEto/bDbMAVj1LGzxQ4h9A=; b=iN5ba/iD0D7W2aUp0RxvL
        6JY/aLphkeo4i3b/rILBYLodVQf4zg73ZUrkcoEioeNPjgBYMMc/Lx+KTaqgI2c2
        zSCf3zwWrP6tc7/PKg8SZ7/tPX700mdkuu61vKQWJBHjN6ROUheCu6xFvVoWgW1N
        qL5lpp6oO3dgPa1mNOabE0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgAHZZkSpsJidprJHA--.17231S2;
        Mon, 04 Jul 2022 16:34:27 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, windhl@126.com
Subject: [PATCH 1/2] mediatek: mt76: mac80211: Fix missing of_node_put() in mt76_led_init()
Date:   Mon,  4 Jul 2022 16:34:20 +0800
Message-Id: <20220704083421.276727-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgAHZZkSpsJidprJHA--.17231S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw17XrWkGw48tw4kXw1fJFb_yoWfKrg_Wr
        n29r17XFyktw1Ykr42yr4a93yFkFWkWrWxJFZaqryfW3y7WFZ8Gr4FvryDJry7uws293y5
        Gw1DGF98AayrZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRJGYdJUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RM0F1pEAVUTQgAAsG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We should use of_node_put() for the reference 'np' returned by
of_get_child_by_name() which will increase the refcount.

Fixes: 17f1de56df05 ("mt76: add common code shared between multiple chipsets")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 18b5de55334c..e1708eff9186 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -210,6 +210,7 @@ static int mt76_led_init(struct mt76_dev *dev)
 		if (!of_property_read_u32(np, "led-sources", &led_pin))
 			dev->led_pin = led_pin;
 		dev->led_al = of_property_read_bool(np, "led-active-low");
+		of_node_put(np);
 	}
 
 	return led_classdev_register(dev->dev, &dev->led_cdev);
-- 
2.25.1

