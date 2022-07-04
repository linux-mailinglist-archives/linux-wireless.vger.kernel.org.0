Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4378B564FCE
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 10:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiGDIfh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 04:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGDIfg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 04:35:36 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA838B484
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=l1t1B
        jKcaNds6H6upcvrVgJe3EiI8pwcuA8sdN9vvyg=; b=Tm+7ACJ1gbLTGc88970MZ
        CQWYVyg0336/jCku5DrIeuf0F8fm6iOc+83i15f2YquFtBTe7gASuTa0giz4kiv7
        NhPuRRmEVxm/9Q9CusiylzdEYCDE1TF70Wigqan0ikCQqFWdrvcLX53Xhg9qX2pa
        kJsKV+0ICC8U+DlfwEp3rM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgAHZZkSpsJidprJHA--.17231S3;
        Mon, 04 Jul 2022 16:34:28 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, windhl@126.com
Subject: [PATCH 2/2] mediatek: mt76: eeprom: fix missing of_node_put() in mt76_find_power_limits_node()
Date:   Mon,  4 Jul 2022 16:34:21 +0800
Message-Id: <20220704083421.276727-2-windhl@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704083421.276727-1-windhl@126.com>
References: <20220704083421.276727-1-windhl@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgAHZZkSpsJidprJHA--.17231S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruw17XrWkGw48tw4kAr15XFb_yoWDJrX_ur
        s7WrnxJF1xKr10gr4jyFW3ZayIkaykJr1xuFWIqrySg3yayrW8WFn0vr9rJr9ruFsavr15
        Jw1qqFy5Aa9a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRLF4iUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhQ0F18RPbX8JQAAsm
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

Fixes: 22b980badc0f ("mt76: add functions for parsing rate power limits from DT")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index a499861918fa..9bc8758573fc 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -162,10 +162,13 @@ mt76_find_power_limits_node(struct mt76_dev *dev)
 		}
 
 		if (mt76_string_prop_find(country, dev->alpha2) ||
-		    mt76_string_prop_find(regd, region_name))
+		    mt76_string_prop_find(regd, region_name)) {
+			of_node_put(np);
 			return cur;
+		}
 	}
 
+	of_node_put(np);
 	return fallback;
 }
 
-- 
2.25.1

