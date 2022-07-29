Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9FF584D9B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiG2IpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jul 2022 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiG2IpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jul 2022 04:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6828F26CD
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 01:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EBAC61D1E
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 08:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D04C433D6;
        Fri, 29 Jul 2022 08:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659084314;
        bh=Ym4Nbc4rPTQPZhh+SRG0WgGbhugdnT04+7RoiXZxl6k=;
        h=From:To:Cc:Subject:Date:From;
        b=hYRBDuL4Oj3UPSgd8lIcd7pEVvyplj2WsPXFAc8pLdmqKihjHrnB79azSJUSfTpwC
         aWxnCs23w/e1agcoXI39Nr7FOaJ39k1S8dc6/d2x4NxmxwhthoKTJVPbmXkTCfM7iT
         Dm9g50xtCEDNQJCtJEU7cnfeuIaj6ag8JeA9kwsc613WOBuzELHD03ce01lOzGO/kA
         6GSOHDxJmWCUsaqmI5l1NkOgZ0kA0agP9nZuRlJuI4u8pzeIXO559BYRmqttonhGJi
         NldgzfrON+fWGinorl236Yk9D0zBrByZaZfI19bBEa8672RJVEe3BuzRUwmxIlwIjU
         7HjhRkunk9I4A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH] mt76: mt76_usb.mt76u_mcu.burst is always false remove related code
Date:   Fri, 29 Jul 2022 10:45:09 +0200
Message-Id: <129572d903df0a4993f096a46bb6ae8d4a1657cd.1659084253.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gergo Koteles <soyer@irl.hu>

Simplify mt76x02u_multiple_mcu_reads routine since burst is always
false.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 -
 .../wireless/mediatek/mt76/mt76x02_usb_mcu.c  | 30 +++++--------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4da77d47b0a6..abfa660cc815 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -527,7 +527,6 @@ struct mt76_usb {
 		struct mt76_reg_pair *rp;
 		int rp_len;
 		u32 base;
-		bool burst;
 	} mcu;
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
index c6c16fe8ee85..02da543dfc5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
@@ -21,29 +21,16 @@ static void
 mt76x02u_multiple_mcu_reads(struct mt76_dev *dev, u8 *data, int len)
 {
 	struct mt76_usb *usb = &dev->usb;
-	u32 reg, val;
 	int i;
 
-	if (usb->mcu.burst) {
-		WARN_ON_ONCE(len / 4 != usb->mcu.rp_len);
-
-		reg = usb->mcu.rp[0].reg - usb->mcu.base;
-		for (i = 0; i < usb->mcu.rp_len; i++) {
-			val = get_unaligned_le32(data + 4 * i);
-			usb->mcu.rp[i].reg = reg++;
-			usb->mcu.rp[i].value = val;
-		}
-	} else {
-		WARN_ON_ONCE(len / 8 != usb->mcu.rp_len);
-
-		for (i = 0; i < usb->mcu.rp_len; i++) {
-			reg = get_unaligned_le32(data + 8 * i) -
-			      usb->mcu.base;
-			val = get_unaligned_le32(data + 8 * i + 4);
-
-			WARN_ON_ONCE(usb->mcu.rp[i].reg != reg);
-			usb->mcu.rp[i].value = val;
-		}
+	WARN_ON_ONCE(len / 8 != usb->mcu.rp_len);
+
+	for (i = 0; i < usb->mcu.rp_len; i++) {
+		u32 reg = get_unaligned_le32(data + 8 * i) - usb->mcu.base;
+		u32 val = get_unaligned_le32(data + 8 * i + 4);
+
+		WARN_ON_ONCE(usb->mcu.rp[i].reg != reg);
+		usb->mcu.rp[i].value = val;
 	}
 }
 
@@ -207,7 +194,6 @@ mt76x02u_mcu_rd_rp(struct mt76_dev *dev, u32 base,
 	usb->mcu.rp = data;
 	usb->mcu.rp_len = n;
 	usb->mcu.base = base;
-	usb->mcu.burst = false;
 
 	ret = __mt76x02u_mcu_send_msg(dev, skb, CMD_RANDOM_READ, true);
 
-- 
2.37.1

