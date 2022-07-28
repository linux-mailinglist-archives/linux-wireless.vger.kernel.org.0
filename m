Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ADD58439E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiG1PyV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiG1PyU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 11:54:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114286BC0C
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 08:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABC9761C16
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 15:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38B5C433C1;
        Thu, 28 Jul 2022 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659023659;
        bh=VCKPmLhjzR+UjDQKtOqAQ5TBM7+FyIVn2N3f2IjYM7M=;
        h=From:To:Cc:Subject:Date:From;
        b=eiqvbY0MoTxpegAESk1a7IY88X109oScop9pbEtCRxIJ9xphibt4ke7zpWGrLWIZp
         RC7k0jArZn2y7ZM6072Bb//VY/MzyRzEYZN54P9E2H95uIhf2bDgsivvCXENpeId4L
         KMnN6yB7J/HoBeqzbOUdk89j6l8j3qUgG8VnatRN59IleFgBJN6nAaKsb5LebOKXrc
         Hq/xSIRfLJB/VkMU91TX9elHXutwdb6Wl4B8BzEYqxCt3DZ2AzE35JbRr0+n1E7gOd
         YYe+IGzgL+JttbvIajAnVbcXL9cZD4rM+iFOuIDbdUbrIjjWcgtBMqMKYJDzTnLHR1
         rDfPei1RqOPig==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7663s: add rx_check callback
Date:   Thu, 28 Jul 2022 17:54:13 +0200
Message-Id: <ff4018102f1b0f3be242a0d7dd1bed4d340cac48.1659023615.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce rx_check callback support for mt7663s driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index 49ab3a1f3b9b..8fd4abc829cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -83,6 +83,7 @@ static int mt7663s_probe(struct sdio_func *func,
 		.tx_complete_skb = mt7663_usb_sdio_tx_complete_skb,
 		.tx_status_data = mt7663_usb_sdio_tx_status_data,
 		.rx_skb = mt7615_queue_rx_skb,
+		.rx_check = mt7615_rx_check,
 		.sta_ps = mt7615_sta_ps,
 		.sta_add = mt7615_mac_sta_add,
 		.sta_remove = mt7615_mac_sta_remove,
-- 
2.37.1

