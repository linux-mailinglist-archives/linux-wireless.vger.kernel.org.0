Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB973FF8D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 17:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjF0PUp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 11:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjF0PUo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 11:20:44 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 08:20:42 PDT
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD81735;
        Tue, 27 Jun 2023 08:20:42 -0700 (PDT)
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by forward205b.mail.yandex.net (Yandex) with ESMTP id 5D6E96751F;
        Tue, 27 Jun 2023 18:14:27 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2929:0:640:5f6e:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id B861460024;
        Tue, 27 Jun 2023 18:14:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KENE8w0DV4Y0-RAocMuF0;
        Tue, 27 Jun 2023 18:14:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687878861;
        bh=6YvjUD6AxvMQ0iz8tQiHRTDEHNd8AITV9R1JP2bRykM=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Tfhs9+qQH5DrHNkLDKTBBZAj5ntTJZ8dcXLAalkffxlN4bAL4VY0jAMF1iuAfOehR
         kx5HiDCKVTtpqfVgyKtOTClIMj1UOK/MloWibK7mVqRhkLkjZ39F1CaVpuGXTUq6fT
         gRHJ8/7uVoY99Y25Y57YwxA4d6dLrSW56zYB5hlA=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>,
        stable@vger.kernel.org
Subject: [PATCH] [v2] wifi: b43: fix cordic arithmetic
Date:   Tue, 27 Jun 2023 18:13:53 +0300
Message-ID: <20230627151411.92749-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ef4750f8-8de5-dbfc-2c0b-3400d30d83e5@lwfinger.net>
References: <ef4750f8-8de5-dbfc-2c0b-3400d30d83e5@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Fixes: 6f98e62a9f1b ("b43: update cordic code to match current specs")

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org
Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: add Cc: stable and Fixes: (Larry Finger)
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

