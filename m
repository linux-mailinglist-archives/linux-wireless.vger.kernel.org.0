Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB1F77FB42
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353367AbjHQPx0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353351AbjHQPxI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 11:53:08 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E16730D6
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Hivvnfk5CmpeuLkc39eBdb7z8a3eSNDNL5QJG8QOI3w=; b=TSOPWIljQdZz7JMgwenx92/PZJ
        ozcR8bXcQ93yH68Hj7jZM1W18kGyYoaJFmI04GuMwun+12ZKDnY8ll3zjqUfie6zaidxowoEzduAL
        NLzDU6QA/CRS7t8s32AyyRolAQ9zvcy79JhVQi2DOarEgAv9/tg+Jxx+0CVfgP1sSFHg=;
Received: from 134.101.185.184.dynamic-pppoe.dt.ipv4.wtnet.de ([134.101.185.184] helo=Maecks.fritz.box)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qWfJ2-00AmKH-DG
        for linux-wireless@vger.kernel.org; Thu, 17 Aug 2023 17:53:04 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/5] wifi: mt76: mt7603: add missing register initialization for MT7628
Date:   Thu, 17 Aug 2023 17:52:57 +0200
Message-ID: <20230817155258.62636-4-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817155258.62636-1-nbd@nbd.name>
References: <20230817155258.62636-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ported from the vendor driver code

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 0762de3ce5ac..dd3c96f96999 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -184,6 +184,13 @@ mt7603_mac_init(struct mt7603_dev *dev)
 
 	mt76_set(dev, MT_TMAC_TCR, MT_TMAC_TCR_RX_RIFS_MODE);
 
+	if (is_mt7628(dev)) {
+		mt76_set(dev, MT_TMAC_TCR,
+			 MT_TMAC_TCR_TXOP_BURST_STOP | BIT(1) | BIT(0));
+		mt76_set(dev, MT_TXREQ, BIT(27));
+		mt76_set(dev, MT_AGG_TMP, GENMASK(4, 2));
+	}
+
 	mt7603_set_tmac_template(dev);
 
 	/* Enable RX group to HIF */
-- 
2.41.0

