Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024F87631A7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjGZJUu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjGZJUe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 05:20:34 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B5A171D
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aBO/2X8Kh9zAFI0kKRAKUBHaIL0WFnX+gQ4MtU5TMAo=; b=N5mekpYZXEwkG+j7DAkxgsUCwF
        e/Az5E7jL7FLmTuzvZhKQTUXb4fELoZytVegEG1Vt/3bRbioFGA/ad03EJhj47mps82Uz2cZN3XGZ
        qSreVbXCtcFY7OAkWUMxb+4DMtwcgiB52oWZH3OJZ0IBnqCERUpp7LrgDuHHUwad9Ws8=;
Received: from p4ff134dd.dip0.t-ipconnect.de ([79.241.52.221] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qOadt-001nWM-HE
        for linux-wireless@vger.kernel.org; Wed, 26 Jul 2023 11:17:13 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] wifi: mt76: mt7603: fix beacon interval after disabling a single vif
Date:   Wed, 26 Jul 2023 11:17:03 +0200
Message-ID: <20230726091704.25795-2-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726091704.25795-1-nbd@nbd.name>
References: <20230726091704.25795-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When disabling beacons on a vif, intval is 0. Ensure that dev->mt76.beacon_int
is not overwritten in this case, so that beacons continue to work for other
interfaces.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index b65b0a88c1de..888678732f29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -161,7 +161,8 @@ void mt7603_beacon_set_timer(struct mt7603_dev *dev, int idx, int intval)
 		return;
 	}
 
-	dev->mt76.beacon_int = intval;
+	if (intval)
+		dev->mt76.beacon_int = intval;
 	mt76_wr(dev, MT_TBTT,
 		FIELD_PREP(MT_TBTT_PERIOD, intval) | MT_TBTT_CAL_ENABLE);
 
-- 
2.41.0

