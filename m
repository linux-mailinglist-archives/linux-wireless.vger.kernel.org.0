Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8F5A2F68
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbiHZS4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345521AbiHZSzu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 14:55:50 -0400
X-Greylist: delayed 1682 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 11:51:38 PDT
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA604505E
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 11:51:35 -0700 (PDT)
Received: from p200300daa713fa00d95ad2224e59825a.dip0.t-ipconnect.de ([2003:da:a713:fa00:d95a:d222:4e59:825a] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oRdzP-0003Hc-FH; Fri, 26 Aug 2022 20:23:31 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org
Subject: [PATCH 6.0] wifi: mt76: fix reading current per-tid starting sequence number for aggregation
Date:   Fri, 26 Aug 2022 20:23:29 +0200
Message-Id: <20220826182329.18155-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The code was accidentally shifting register values down by tid % 32 instead of
(tid * field_size) % 32.

Cc: stable@vger.kernel.org
Fixes: a28bef561a5c ("mt76: mt7615: re-enable offloading of sequence number assignment")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ad6c7d632eed..d6aae60c440d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1088,7 +1088,7 @@ u32 mt7615_mac_get_sta_tid_sn(struct mt7615_dev *dev, int wcid, u8 tid)
 	offset %= 32;
 
 	val = mt76_rr(dev, addr);
-	val >>= (tid % 32);
+	val >>= offset;
 
 	if (offset > 20) {
 		addr += 4;
-- 
2.36.1

