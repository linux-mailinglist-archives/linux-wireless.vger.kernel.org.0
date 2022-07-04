Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2007564FD3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiGDIgz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 04:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGDIgy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 04:36:54 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C9F8A44B
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iPysx
        cqXD4MktxFv2jTlSRSS0lgtVcXHhc6wMprLs+Y=; b=lv3XfKQVqmMuLIrvyUcyW
        Ev/0PD+jk+dcWi1Z8mrnVTSBM1pvGz+CjtJewQ6VMqIAbqqoBa4HxBrnzKxCuaiR
        f3H7fLJbH964a+oUtNLZ8QW/xOev2k+4gQ8l4v3Q9i/bkh0wjDOfJytbUlqSFSwD
        QvBJi8bBdYlKvbMHc1ct5I=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowAAHDyuIpsJidbThFw--.49737S2;
        Mon, 04 Jul 2022 16:36:24 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, windhl@126.com, linmq006@gmail.com
Subject: [PATCH] mediatek: mt7915: fix missing of_node_put() in mt7986_wmac_coninfra_setup
Date:   Mon,  4 Jul 2022 16:35:56 +0800
Message-Id: <20220704083556.276827-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAAHDyuIpsJidbThFw--.49737S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW7Kry8WFyrtr4UGry7trb_yoWfWrb_ur
        Z2gFnxWF1kCr1vkr42kw43Ca4Yya95Za18uFZIqrWFqrWjvFWUGr1YvF17JrZrurn7Zr98
        Gr1DAFyFqa98ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiUDG3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuAg0F2JVkLx0MAAAsM
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
of_parse_phandle() which will increase the refcount.

Fixes: 99ad32a4ca3a ("mt76: mt7915: add support for MT7986")
Co-authored-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index c74afa746251..ee7ddda4288b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -278,6 +278,7 @@ static int mt7986_wmac_coninfra_setup(struct mt7915_dev *dev)
 		return -EINVAL;
 
 	rmem = of_reserved_mem_lookup(np);
+	of_node_put(np);
 	if (!rmem)
 		return -EINVAL;
 
-- 
2.25.1

