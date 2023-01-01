Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35D65A9DC
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjAALxo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjAALxn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:53:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A2226E6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:53:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21248B8091A
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670E2C433EF;
        Sun,  1 Jan 2023 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672574018;
        bh=zGhv7VUBExUx7mSrY0FyCkLxLdsxJEL9M/HJ8SYZn6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJqBwH1ovoak0ZQIkod5288tMTOttg7qE5Mm0z5cJ1+zE/qulNcU6UV4qD7AeagKp
         oIwc8chjv3hTII3OTnI7NLZTlTn/g0TtIvzw83EaHEUXcisEuv6Y2Xy3Pz+PmHiXC3
         D3KOQzgrCbx/war5GukoLFY+uWxlizIAKIFMA5SbhMVwQw4sFveI+B88FyZtzkR7OD
         1qh0wl0ZeRurfSp71LoMIbbMygdHAJsem+6GNYnPM7UEqtAnDPHZgPgXCbTAtptoHz
         5krfAEgSXxnqTDMY2PQ7Eje8G0cJeCSI1GBXpoGRvzgvbu4MOC+tg3Hdbfxad0D9D3
         1fplFj8pjhwog==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 2/6] wifi: mt76: mt7603: avoid mcu_restart function pointer
Date:   Sun,  1 Jan 2023 12:53:19 +0100
Message-Id: <2eba74f7d407cef21bc773fd4192702df468d9cd.1672573894.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1672573894.git.lorenzo@kernel.org>
References: <cover.1672573894.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run mt7603_mcu_restart routine directly and avoid mcu_restart function
pointer whenever it is possible.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 7884b952b720..301668c3cc92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -221,7 +221,6 @@ int mt7603_mcu_init(struct mt7603_dev *dev)
 		.headroom = sizeof(struct mt7603_mcu_txd),
 		.mcu_skb_send_msg = mt7603_mcu_skb_send_msg,
 		.mcu_parse_response = mt7603_mcu_parse_response,
-		.mcu_restart = mt7603_mcu_restart,
 	};
 
 	dev->mt76.mcu_ops = &mt7603_mcu_ops;
@@ -230,7 +229,7 @@ int mt7603_mcu_init(struct mt7603_dev *dev)
 
 void mt7603_mcu_exit(struct mt7603_dev *dev)
 {
-	__mt76_mcu_restart(&dev->mt76);
+	mt7603_mcu_restart(&dev->mt76);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 
-- 
2.38.1

