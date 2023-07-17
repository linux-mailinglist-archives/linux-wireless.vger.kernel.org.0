Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71BD75672B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 17:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjGQPHr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 11:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGQPHr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 11:07:47 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F7DE10A
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=7rbCAG5coNINQnK+bW
        N2b1Y9ju2yuPS40hfsCL/t69I=; b=p15itanoK/qlTWiT1QTksOQxKYSb7GWJjj
        uRBK7ogONYFQ2lawjFczu4H77kosWo0ATUzrLmgaMeq3VAKSm/FxJQMdM5mLb1MV
        weg0hcDZJATMmdIBPnLFXRkhYSe2IFKozMhxBC0LB7vCS5qa9rgqiK/jCvmxF/VH
        Ohv/BQZ58=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wAH1SEiVbVkAqIxAg--.34560S4;
        Mon, 17 Jul 2023 22:50:13 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 1/1] net: mt76: fix return value check in mt76x02_mac_process_rx
Date:   Mon, 17 Jul 2023 22:50:08 +0800
Message-Id: <20230717145008.26999-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wAH1SEiVbVkAqIxAg--.34560S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr43XFyrAF1ftFWUtF1UWrg_yoWfAFX_Wr
        n2q3ZrJr18GFn3Kr42yr4xCrWYkay8WFykGF98trWYvrW7AFyUur9xuF9rJrZrC3Z2yry7
        Jr1DuFW8XayFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRurWr5UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbBSQqv5VaEH4VJggAAsK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

in mt76x02_mac_process_rx(), return an error code if an
unexpected result is returned by pskb_trim.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 3e41d809ade3..d5db6ffd6d36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -853,7 +853,8 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 	if (WARN_ON_ONCE(len > skb->len))
 		return -EINVAL;
 
-	pskb_trim(skb, len);
+	if (pskb_trim(skb, len))
+		return -EINVAL;
 
 	status->chains = BIT(0);
 	signal = mt76x02_mac_get_rssi(dev, rxwi->rssi[0], 0);
-- 
2.17.1

