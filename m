Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9AE73FC54
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjF0NBn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 09:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjF0NBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 09:01:39 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B80AE1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 06:01:36 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:18a7:0:640:a497:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 85932600C5;
        Tue, 27 Jun 2023 16:01:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id W1LC600WneA0-2l6yKD55;
        Tue, 27 Jun 2023 16:01:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687870893;
        bh=z/kJMvgnEYW7QCC6gU8hR3PAnmTeFs6lg3z8P7s2tTI=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=LEw2iY1qi3nFTVGSj2atiPwzwnr7Axjd0xQ/xpyV5OyZGOizlXzTGcaBHnzRRPvRN
         e4a1+2JyC8Fy3i5+pfe+jDd0ly3ld35ZvZpGE0oMMvUPLbsDJk+gd64aeT4HcOw8JT
         htnLwoISwYXTOT6qsemCpof2ADgkWWPIoh8YIjsU=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: b43: fix cordic arithmetic
Date:   Tue, 27 Jun 2023 16:00:27 +0300
Message-ID: <20230627130102.63665-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'lpphy_start_tx_tone()', 'CORDIC_FLOAT((sample.i * max) & 0xFF)'
is invalid because it is (<32-bit> & 0xff) shifted right by 15 bits
and so always evaluates to zero. Looking through brcmsmac's
'wlc_lcnphy_start_tx_tone()', the result should be masked instead,
i. e. 'CORDIC_FLOAT(sample[i].max) & 0xFF'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/broadcom/b43/phy_lp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/phy_lp.c b/drivers/net/wireless/broadcom/b43/phy_lp.c
index 0e5c076e7544..e8ef04e509aa 100644
--- a/drivers/net/wireless/broadcom/b43/phy_lp.c
+++ b/drivers/net/wireless/broadcom/b43/phy_lp.c
@@ -1788,8 +1788,8 @@ static void lpphy_start_tx_tone(struct b43_wldev *dev, s32 freq, u16 max)
 	for (i = 0; i < samples; i++) {
 		sample = cordic_calc_iq(CORDIC_FIXED(theta));
 		theta += rotation;
-		buf[i] = CORDIC_FLOAT((sample.i * max) & 0xFF) << 8;
-		buf[i] |= CORDIC_FLOAT((sample.q * max) & 0xFF);
+		buf[i] = (u16)((CORDIC_FLOAT(sample.i * max) & 0xFF) << 8);
+		buf[i] |= (u16)(CORDIC_FLOAT(sample.q * max) & 0xFF);
 	}
 
 	b43_lptab_write_bulk(dev, B43_LPTAB16(5, 0), samples, buf);
-- 
2.41.0

