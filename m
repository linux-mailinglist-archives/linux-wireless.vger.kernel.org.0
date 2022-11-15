Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FFD62953A
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 11:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiKOKD5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Nov 2022 05:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238238AbiKOKDv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Nov 2022 05:03:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A9DE0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 02:03:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82B2AB8188D
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 10:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE03C433D7;
        Tue, 15 Nov 2022 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668506627;
        bh=1bovjdeoMKWFw+tJMQ+43q/PF7rjxniCpwusoyjT9kI=;
        h=From:To:Cc:Subject:Date:From;
        b=iIjnWaghEmS/MdsghOITNAUq0skKKeFQicxUt+8XaN67cca2SxQoy8GJIeMbD98Y9
         JcYTkuUQOGOSZe25vwfSEC7WgvZmYVaNkZ7P+CiN+JCtYvgCw6+CjHKyp21hrG9SBP
         nyGafllaFxMTTd1mJnlF4Kd14vxVlgSwchSeobjpcYlBB/4F40u6VYCj9EMWbOjZhL
         FncVfFGIXuyqL1BMWA/NWlnA+H7vr+iAYrXZ9kTSVOuL18jZQdSFZ4z9GiiMVHlpje
         F0xF2ezJ1rmJPIVapM0ZNb49XTuP9/4MKy4QxSFKs4ygE7IkCM6i5Q6zcmiAFUAW31
         p1V0wOicleYgQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7921: remove unused variable in mt7921u_probe
Date:   Tue, 15 Nov 2022 11:03:35 +0100
Message-Id: <a2011b4bd0f4e80c1cee1d46dc0f1cd327037080.1668506558.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Remove warning in mt7921u_probe().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index d0caf4a1b21c..5321d20dcdcb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -205,7 +205,6 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	struct ieee80211_hw *hw;
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
-	const void *ops_src;
 	u8 features;
 	int ret;
 
-- 
2.38.1

